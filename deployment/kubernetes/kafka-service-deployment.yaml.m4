apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: kafka-service
  name: kafka-service
spec:
  selector:
    matchLabels:
      app: kafka-service
  replicas: 1
  template:
    metadata:
      labels:
        app: kafka-service
    spec:
      containers:
      - env:
        - name: KAFKA_ADVERTISED_HOST_NAME
          value: kafka-service
        - name: KAFKA_ADVERTISED_LISTENERS
          value: PLAINTEXT://kafka-service:9092
        - name: KAFKA_ADVERTISED_PORT
          value: "9092"
        - name: KAFKA_AUTO_CREATE_TOPICS_ENABLE
          value: "true"
        - name: KAFKA_BROKER_ID
          value: "1"
        - name: KAFKA_CREATE_TOPICS
          value: content_provider_sched:16:1
        - name: KAFKA_DEFAULT_REPLICATION_FACTOR
          value: "1"
        - name: KAFKA_HEAP_OPTS
          value: -Xmx1024m -Xms1024m
        - name: KAFKA_INTER_BROKER_LISTENER_NAME
          value: PLAINTEXT
        - name: KAFKA_LISTENER_SECURITY_PROTOCOL_MAP
          value: PLAINTEXT:PLAINTEXT
        - name: KAFKA_LOG4J_LOGGERS
          value: kafka=ERROR,kafka.controller=ERROR,state.change.logger=ERROR,org.apache.kafka=ERROR
        - name: KAFKA_LOG4J_ROOT_LOGLEVEL
          value: ERROR
        - name: KAFKA_LOG_RETENTION_HOURS
          value: "8"
        - name: KAFKA_NUM_PARTITIONS
          value: "16"
        - name: KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR
          value: "1"
        - name: KAFKA_ZOOKEEPER_CONNECT
          value: zookeeper-service:2181
        image: wurstmeister/kafka:latest
        name: kafka-service
        ports:
        - containerPort: 9092
        resources:
          limits:
            cpu: "2"
            memory: 1048576e3
          requests:
            cpu: "1"
            memory: 524288e3
      nodeSelector:
        kubernetes.io/hostname: master.machine
      restartPolicy: Always
