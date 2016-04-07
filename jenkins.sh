#!/bin/bash
#step1: echo =====Jenkins install=====
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install -y jenkins
###自此以上三步 jenkins安装完毕

#step2：echo =====change port and start =====
sed -i 's/JENKINS_PORT="8080"/JENKINS_PORT="$changport"/g'   /etc/sysconfig/jenkins
/etc/init.d/jenkins restart

#step3：echo =====访问验证=====
ip=`ifconfig |grep "inet addr" |head -n 1 |awk -F':' '{print $2}'|awk -F ' ' '{print $1}'`
res=`curl -s -I  http://$ip:9090 |head -n 1|awk -F ' ' '{print $2}'`
if ("$res" -eq 200);then
  echo "bingo！ 此时你拥有jenkins，可以去做有意义的事情咯."
else if
  echo "sorry,访问出错了，http错误码为"  $res
fi
echo "OK,The End!!"
