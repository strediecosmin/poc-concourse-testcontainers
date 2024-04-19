FROM ubuntu:bionic

ENV DOCKER_CHANNEL=stable \
    DOCKER_VERSION=20.10.18 \
    DOCKER_COMPOSE_VERSION=1.24.1 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install \
        bash \
        curl \
        python-pip \
        python-dev \
        iptables \
        util-linux \
        ca-certificates \
        gcc \
        libc-dev \
        libffi-dev \
        libssl-dev \
        make \
        git \
        wget \
        net-tools \
        iproute2 \
        && \
    curl -fL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" | tar zx && \
    mv /docker/* /bin/ && chmod +x /bin/docker* && \
    pip install docker-compose==${DOCKER_COMPOSE_VERSION} && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache

WORKDIR /shared
COPY docker-entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/shared/entrypoint.sh"]


