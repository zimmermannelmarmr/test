# docker build -t realtime .
# docker run -it -d -e DB_HOST="172.16.4.28:1521/ora12uni"  -v c:\temp\logs:/home/rt/groundstar/realtime/server/log  --name optimizer realtime /home/rt/groundstar/realtime/server/bin/gsrtsrv -log /home/rt/groundstar/realtime/server/etc/InformGsRtHandlerMobResOpt.xml

#docker run --rm -d -v c:\temp\logs:/home/rt/server/log rt
# docker exec -i -t container_name /bin/bash

FROM centos:centos7

#WORKDIR /tmp
#RUN yum -y install gcc
#ADD http://www.cpan.org/src/5.0/perl-5.22.1.tar.gz /tmp
#RUN tar -xzf perl-*.tar.gz
#WORKDIR /tmp/perl-5.22.1
#RUN ./Configure -des -Dprefix=/opt/perl-5.22.1/localperl
#RUN make
#RUN make test
#RUN make install

COPY /preriq/oracle/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
COPY /preriq/oracle/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm /tmp/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
COPY /preriq/oracle/libaio-0.3.109-13.el7.x86_64.rpm /tmp/libaio-0.3.109-13.el7.x86_64.rpm
COPY /preriq/oracle/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

RUN rpm -i /tmp/libaio-0.3.109-13.el7.x86_64.rpm
RUN rpm -i /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
RUN rpm -i /tmp/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
RUN rpm -i /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm



COPY /groundstar/realtime/server/bin /home/rt/groundstar/realtime/server/bin
COPY /groundstar/realtime/server/etc /home/rt/groundstar/realtime/server/etc
#COPY /groundstar/realtime/server/cfg /home/rt/groundstar/realtime/server/cfg
COPY /groundstar/realtime/server/schema /home/rt/groundstar/realtime/server/schema
COPY /vendor /home/rt/vendor

WORKDIR /home/rt/vendor

RUN mkdir /home/rt/groundstar/realtime/server/cache

ENV PATH /home/rt/groundstar/realtime/server/bin:/usr/lib/oracle/12.1/client64/bin:$PATH
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.1/client64/lib:/home/rt/groundstar/realtime/server/bin:/usr/lib:/usr/lib64:$LD_LIBRARY_PATH
ENV container docker
CMD ["/usr/sbin/init"]

# docker run -it -e DB_HOST="172.16.4.28:1521/ora12uni"  -v c:\temp\logs:/home/rt/groundstar/realtime/server/log  --name optimizer realtime /home/rt/groundstar/realtime/server/bin/gsrtsrv -log /home/rt/groundstar/realtime/server/etc/InformGsRtHandlerMobResOpt.xml


