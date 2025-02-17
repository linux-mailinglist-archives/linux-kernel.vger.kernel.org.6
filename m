Return-Path: <linux-kernel+bounces-516997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00958A37AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E867A2A72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3E18C932;
	Mon, 17 Feb 2025 05:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBpdEf4h"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C20185B67;
	Mon, 17 Feb 2025 05:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739769088; cv=none; b=OPE8nPoCCT63o6gcJN1T9fqkPt46IhTqfTnIbu13xuW0Yev4JOQMdoLkfkHaHLLndjg6J26XydQVN74mApmFqdZuor98Dzlf7/Azd6RjdCjgC+x36tXomZXIa1qV1SsOTbujxiywjoYdqxNrff3pTUARzhk8HTmMemzro75gFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739769088; c=relaxed/simple;
	bh=DWZDyA7Vh1sZo70VcP5FEczLVQG7VuzdzMwKgz8+UfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPkX4Ua2PmgEk5AmUZ3uDDVeR9mzRH4FtSq+Ffad+GIC7dR8yHLNVKyYq0GiNEh+IJGwDudyg6dVlIzXOmOi4qwtb+zQFOKUH+jZer+vEwkbaOV/awf/0kxjKg3AA0ebLk7igPk56DDLn79I5nuB92JCnWgSXbE8ZAietYAaTmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBpdEf4h; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4395f66a639so22882645e9.0;
        Sun, 16 Feb 2025 21:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739769084; x=1740373884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaTsMNAsN5DKWCWC5o+nLJL+4cZULpJH+Ep2kGiFF/o=;
        b=lBpdEf4hWWJWtmwIYNovB+Ua1KgmRJkxHcEJTlOYwIQ3CPM9WbB9Vkkp5EbZmXkSgV
         h1y1upSvPS1IjyFrqOOfU0rYXineSLpRemcQ+HxcAYJjHQQ28JISbBp58+79UWYKEYfk
         PKM3opm3Hlv0QqqrJyO8Jn+IRc1E72YULZo4POHoHA37qe8l0mSnGu6p7iqFWM9dnyux
         iqXumKgKxRgzsFnkrOTL+ccCJwrbWJjeuqqFZiFQG0lPme0dXYJeSPtViPGNikj9cEVl
         6HPDtGew5kzs6mKTc2I91EiSqLlkjuyW4MxBewLc9LwUEjvm10sOn2dIflPnnp/nMU9e
         mAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739769084; x=1740373884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaTsMNAsN5DKWCWC5o+nLJL+4cZULpJH+Ep2kGiFF/o=;
        b=MKb8DyOJ9OJLGosI+AL+NR97CqHo7+HSKedK9UjAZL/gP8VeMeEnE3BektjK0M9AB3
         5HOL5Veks43pN2HJrMWi6w40jTYEyUvy82X8Bc0HTE7BdbdmmBTJeGVvjkV7wSqC802p
         g2Mwf8lQhKFvTPUO0di0THCWOzlwntucXNMTFJ3tjN6PLByxdDE+LO+Z81UPYgPqKNI3
         vX0CwBI7eXqpnN+qX9A8iSHJ3bnFarvnvvJIA1JZqFpx0sIrzzQ5l+viopoHXB0ghL1c
         Vw4wYy7bu8NQluhOCaCpR4DavgtZImyPZiUU6NXPcnLYD8ZYmMkgiSaXugK8Rs1fyQPE
         nUhw==
X-Forwarded-Encrypted: i=1; AJvYcCU6o4QvWbD75CWHmCm09jo+IXuCvQL8pnew9M3CN2Xsh01pJlDrvBLM0GZlbmuCesAPmA+WS8LWqSqW@vger.kernel.org, AJvYcCUnEPbecT338i591nw8TSMNmg056WHMG4HGudaBZjVYUx14k8K0Z4y1siRiq2vepcIGtOLOsHV2SMX8WBwI@vger.kernel.org
X-Gm-Message-State: AOJu0YxNw/YahfL99QzSfhNTdZjPh6yM3gX9NQxMdAFhS1LePQZ1DMbI
	A16QSA9ABFwrAkY3geDRjS9dHXpRdp4rktjS8zKtyLcgjXaF2jkr
X-Gm-Gg: ASbGncunLUVBy/lUx2LV4LQzgxpJP+n5YvHzwAxyVRbXStZhLob0c3n3AqwaLE/1WWs
	pLT3sUQ0AX/gqjWN8UAQsugX4sJRuY/bSEtVYr88SIGgwTrRW4U2PMZDzBpkQJjNMuhuLqleuLr
	T3XW4Up3DFSonCDqOVmLVwiaj7Zq6/YxyBAy3Mgkn2PPyEMDKmKf0o2ETdkB13iEfW0RMkrk5QP
	Co59p7pZ9jzd7vhYf1XdIVt08aeQuwvn1uTiJ74dKbYu7facstBVjKtPYYlLb9VGHWwVa/pYAK/
	PDl+0ePGZsagfgo1DyzTMvrKvd8Q4sM5hw6Ng8NOXsoRfuvtIOFzYwtwuzTkKISlcW3SYZA9ur5
	C9W10p4U348toyIXKgx2yCVosg5DjY4gF7f+MHGDpXvkW
X-Google-Smtp-Source: AGHT+IGp5tNexznpSSo5c7JG5FqjuD0qVb5ohdWD6yGwcS6MyHjx7G71Up0D41j0rjTx6YWuOu0JAA==
X-Received: by 2002:a05:600c:458e:b0:439:65fa:5872 with SMTP id 5b1f17b1804b1-4396e7335fbmr61052535e9.24.1739769083992;
        Sun, 16 Feb 2025 21:11:23 -0800 (PST)
Received: from thinkpad-p52.telekom.ip (2a02-8388-e103-2700-a24c-4303-c631-1166.cable.dynamic.v6.surfer.at. [2a02:8388:e103:2700:a24c:4303:c631:1166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398a64febasm3988935e9.1.2025.02.16.21.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 21:11:23 -0800 (PST)
From: Andrei Lalaev <andrey.lalaev@gmail.com>
To: linux@roeck-us.net,
	krzk@kernel.org,
	robh@kernel.org,
	christophe.jaillet@wanadoo.fr,
	jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	andrey.lalaev@gmail.com
Subject: [PATCH RESEND v3 1/2] hwmon: add driver for HTU31
Date: Mon, 17 Feb 2025 06:10:55 +0100
Message-ID: <20250217051110.46827-2-andrey.lalaev@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217051110.46827-1-andrey.lalaev@gmail.com>
References: <20250217051110.46827-1-andrey.lalaev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add base support for HTU31 temperature and humidity sensor.

Besides temperature and humidity values, the driver also exports a 24-bit
heater control to sysfs and serial number to debugfs.

Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>
---
 Documentation/hwmon/htu31.rst |  37 ++++
 Documentation/hwmon/index.rst |   1 +
 MAINTAINERS                   |   6 +
 drivers/hwmon/Kconfig         |  11 ++
 drivers/hwmon/Makefile        |   1 +
 drivers/hwmon/htu31.c         | 351 ++++++++++++++++++++++++++++++++++
 6 files changed, 407 insertions(+)
 create mode 100644 Documentation/hwmon/htu31.rst
 create mode 100644 drivers/hwmon/htu31.c

diff --git a/Documentation/hwmon/htu31.rst b/Documentation/hwmon/htu31.rst
new file mode 100644
index 000000000000..ccde84264643
--- /dev/null
+++ b/Documentation/hwmon/htu31.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver HTU31
+====================
+
+Supported chips:
+
+  * Measurement Specialties HTU31
+
+    Prefix: 'htu31'
+
+    Addresses scanned: -
+
+    Datasheet: Publicly available from https://www.te.com/en/product-CAT-HSC0007.html
+
+Author:
+
+  - Andrei Lalaev <andrey.lalaev@gmail.com>
+
+Description
+-----------
+
+HTU31 is a humidity and temperature sensor.
+
+Supported temperature range is from -40 to 125 degrees Celsius.
+
+Communication with the device is performed via I2C protocol. Sensor's default address
+is 0x40.
+
+sysfs-Interface
+---------------
+
+=================== =================
+temp1_input:        temperature input
+humidity1_input:    humidity input
+heater_enable:      heater control
+=================== =================
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 874f8fd26325..86f6f5e46b59 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -85,6 +85,7 @@ Hardware Monitoring Kernel Drivers
    hih6130
    hp-wmi-sensors
    hs3001
+   htu31
    ibmaem
    ibm-cffps
    ibmpowernv
diff --git a/MAINTAINERS b/MAINTAINERS
index d49306cc17e3..13dbb7fa4e73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10667,6 +10667,12 @@ W:	http://www.st.com/
 F:	Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
 F:	drivers/iio/humidity/hts221*
 
+HTU31 Hardware Temperature and Humidity Sensor
+M:	Andrei Lalaev <andrey.lalaev@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/htu31.c
+
 HUAWEI ETHERNET DRIVER
 M:	Cai Huoqing <cai.huoqing@linux.dev>
 L:	netdev@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 4cbaba15d86e..e123e06ba352 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -789,6 +789,17 @@ config SENSORS_HS3001
 	  This driver can also be built as a module. If so, the module
 	  will be called hs3001.
 
+config SENSORS_HTU31
+	tristate "Measurement Specialties HTU31 humidity and temperature sensor"
+	depends on I2C
+	select CRC8
+	help
+	  If you say yes here you get support for the HTU31 humidity
+	  and temperature sensors.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called htu31.
+
 config SENSORS_IBMAEM
 	tristate "IBM Active Energy Manager temperature/power sensors and control"
 	select IPMI_SI
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b7ef0f0562d3..55504e33c72d 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
 obj-$(CONFIG_SENSORS_GXP_FAN_CTRL) += gxp-fan-ctrl.o
 obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
 obj-$(CONFIG_SENSORS_HS3001)	+= hs3001.o
+obj-$(CONFIG_SENSORS_HTU31)	+= htu31.o
 obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
 obj-$(CONFIG_SENSORS_I5500)	+= i5500_temp.o
 obj-$(CONFIG_SENSORS_I5K_AMB)	+= i5k_amb.o
diff --git a/drivers/hwmon/htu31.c b/drivers/hwmon/htu31.c
new file mode 100644
index 000000000000..3860b7eba419
--- /dev/null
+++ b/drivers/hwmon/htu31.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The driver for Measurement Specialties HTU31 Temperature and Humidity sensor.
+ *
+ * Copyright (C) 2025
+ * Author: Andrei Lalaev <andrey.lalaev@gmail.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/cleanup.h>
+#include <linux/crc8.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#define HTU31_READ_TEMP_HUM_CMD	0x00
+#define HTU31_READ_SERIAL_CMD		0x0a
+#define HTU31_CONVERSION_CMD		0x5e
+#define HTU31_HEATER_OFF_CMD		0x02
+#define HTU31_HEATER_ON_CMD		0x04
+
+#define HTU31_TEMP_HUM_LEN		6
+
+/* Conversion time for the highest resolution */
+#define HTU31_HUMIDITY_CONV_TIME	10000 /* us */
+#define HTU31_TEMPERATURE_CONV_TIME	15000 /* us */
+
+#define HTU31_SERIAL_NUMBER_LEN	3
+#define HTU31_SERIAL_NUMBER_CRC_LEN	1
+#define HTU31_SERIAL_NUMBER_CRC_OFFSET	3
+
+#define HTU31_CRC8_INIT_VAL		0
+#define HTU31_CRC8_POLYNOMIAL		0x31
+DECLARE_CRC8_TABLE(htu31_crc8_table);
+
+/**
+ * struct htu31_data - all the data required to operate a HTU31 chip
+ * @client: the i2c client associated with the HTU31
+ * @lock: a mutex to prevent parallel access to the data
+ * @wait_time: the time needed by sensor to convert values
+ * @temperature: the latest temperature value in millidegrees
+ * @humidity: the latest relative humidity value in millipercent
+ * @serial_number: the serial number of the sensor
+ * @heater_enable: the internal state of the heater
+ */
+struct htu31_data {
+	struct i2c_client *client;
+	struct mutex lock; /* Used to protect against parallel data updates */
+	long wait_time;
+	long temperature;
+	long humidity;
+	u8 serial_number[HTU31_SERIAL_NUMBER_LEN];
+	bool heater_enable;
+};
+
+static long htu31_temp_to_millicelsius(u16 val)
+{
+	return -40000 + DIV_ROUND_CLOSEST_ULL(165000ULL * val, 65535);
+}
+
+static long htu31_relative_humidity(u16 val)
+{
+	return DIV_ROUND_CLOSEST_ULL(100000ULL * val, 65535);
+}
+
+static int htu31_data_fetch_command(struct htu31_data *data)
+{
+	struct i2c_client *client = data->client;
+	u8 conversion_on = HTU31_CONVERSION_CMD;
+	u8 read_data_cmd = HTU31_READ_TEMP_HUM_CMD;
+	u8 t_h_buf[HTU31_TEMP_HUM_LEN] = {};
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &read_data_cmd,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(t_h_buf),
+			.buf = t_h_buf,
+		},
+	};
+	int ret;
+	u8 crc;
+
+	guard(mutex)(&data->lock);
+
+	ret = i2c_master_send(client, &conversion_on, 1);
+	if (ret != 1) {
+		ret = ret < 0 ? ret : -EIO;
+		dev_err(&client->dev,
+			"Conversion command is failed. Error code: %d\n", ret);
+		return ret;
+	}
+
+	fsleep(data->wait_time);
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret != ARRAY_SIZE(msgs)) {
+		ret = ret < 0 ? ret : -EIO;
+		dev_err(&client->dev,
+			"T&H command is failed. Error code: %d\n", ret);
+		return ret;
+	}
+
+	crc = crc8(htu31_crc8_table, &t_h_buf[0], 2, HTU31_CRC8_INIT_VAL);
+	if (crc != t_h_buf[2]) {
+		dev_err(&client->dev, "Temperature CRC mismatch\n");
+		return -EIO;
+	}
+
+	crc = crc8(htu31_crc8_table, &t_h_buf[3], 2, HTU31_CRC8_INIT_VAL);
+	if (crc != t_h_buf[5]) {
+		dev_err(&client->dev, "Humidity CRC mismatch\n");
+		return -EIO;
+	}
+
+	data->temperature = htu31_temp_to_millicelsius(be16_to_cpup((__be16 *)&t_h_buf[0]));
+	data->humidity = htu31_relative_humidity(be16_to_cpup((__be16 *)&t_h_buf[3]));
+
+	return 0;
+}
+
+static umode_t htu31_is_visible(const void *data, enum hwmon_sensor_types type,
+				u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+	case hwmon_humidity:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static int htu31_read(struct device *dev, enum hwmon_sensor_types type,
+		      u32 attr, int channel, long *val)
+{
+	struct htu31_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	ret = htu31_data_fetch_command(data);
+	if (ret < 0)
+		return ret;
+
+	switch (type) {
+	case hwmon_temp:
+		if (attr != hwmon_temp_input)
+			return -EINVAL;
+
+		*val = data->temperature;
+		break;
+	case hwmon_humidity:
+		if (attr != hwmon_humidity_input)
+			return -EINVAL;
+
+		*val = data->humidity;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int htu31_read_serial_number(struct htu31_data *data)
+{
+	struct i2c_client *client = data->client;
+	u8 read_sn_cmd = HTU31_READ_SERIAL_CMD;
+	u8 sn_buf[HTU31_SERIAL_NUMBER_LEN + HTU31_SERIAL_NUMBER_CRC_LEN];
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = 1,
+			.buf = &read_sn_cmd,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = sizeof(sn_buf),
+			.buf = sn_buf,
+		},
+	};
+	int ret;
+	u8 crc;
+
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		return ret;
+
+	crc = crc8(htu31_crc8_table, sn_buf, HTU31_SERIAL_NUMBER_LEN, HTU31_CRC8_INIT_VAL);
+	if (crc != sn_buf[HTU31_SERIAL_NUMBER_CRC_OFFSET]) {
+		dev_err(&client->dev, "Serial number CRC mismatch\n");
+		return -EIO;
+	}
+
+	memcpy(data->serial_number, sn_buf, HTU31_SERIAL_NUMBER_LEN);
+
+	return 0;
+}
+
+static ssize_t heater_enable_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct htu31_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", data->heater_enable);
+}
+
+static ssize_t heater_enable_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t count)
+{
+	struct htu31_data *data = dev_get_drvdata(dev);
+	u8 heater_cmd;
+	bool status;
+	int ret;
+
+	ret = kstrtobool(buf, &status);
+	if (ret)
+		return ret;
+
+	heater_cmd = status ? HTU31_HEATER_ON_CMD : HTU31_HEATER_OFF_CMD;
+
+	guard(mutex)(&data->lock);
+
+	ret = i2c_master_send(data->client, &heater_cmd, 1);
+	if (ret < 0)
+		return ret;
+
+	data->heater_enable = status;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(heater_enable);
+
+static int serial_number_show(struct seq_file *seq_file,
+			      void *unused)
+{
+	struct htu31_data *data = seq_file->private;
+
+	seq_printf(seq_file, "%X%X%X\n", data->serial_number[0],
+					 data->serial_number[1],
+					 data->serial_number[2]);
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(serial_number);
+
+static struct attribute *htu31_attrs[] = {
+	&dev_attr_heater_enable.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(htu31);
+
+static const struct hwmon_channel_info * const htu31_info[] = {
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops htu31_hwmon_ops = {
+	.is_visible = htu31_is_visible,
+	.read = htu31_read,
+};
+
+static const struct hwmon_chip_info htu31_chip_info = {
+	.info = htu31_info,
+	.ops = &htu31_hwmon_ops,
+};
+
+static int htu31_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device *hwmon_dev;
+	struct htu31_data *data;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->client = client;
+	data->wait_time = HTU31_TEMPERATURE_CONV_TIME + HTU31_HUMIDITY_CONV_TIME;
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	crc8_populate_msb(htu31_crc8_table, HTU31_CRC8_POLYNOMIAL);
+
+	ret = htu31_read_serial_number(data);
+	if (ret) {
+		dev_err(dev, "Failed to read serial number\n");
+		return ret;
+	}
+
+	debugfs_create_file("serial_number",
+			    0444,
+			    client->debugfs,
+			    data,
+			    &serial_number_fops);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev,
+							 client->name,
+							 data,
+							 &htu31_chip_info,
+							 htu31_groups);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct i2c_device_id htu31_id[] = {
+	{ "htu31" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, htu31_id);
+
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id htu31_of_match[] = {
+	{ .compatible = "meas,htu31" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, htu31_of_match);
+#endif
+
+static struct i2c_driver htu31_driver = {
+	.driver = {
+		.name = "htu31",
+		.of_match_table = of_match_ptr(htu31_of_match),
+	},
+	.probe = htu31_probe,
+	.id_table = htu31_id,
+};
+module_i2c_driver(htu31_driver);
+
+MODULE_AUTHOR("Andrei Lalaev <andrey.lalaev@gmail.com>");
+MODULE_DESCRIPTION("HTU31 Temperature and Humidity sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


