Return-Path: <linux-kernel+bounces-298857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9AF95CC44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3F91C21108
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F43185923;
	Fri, 23 Aug 2024 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIAfTeYq"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628CF9457;
	Fri, 23 Aug 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724415726; cv=none; b=Jl/lK+jwr+sUqmFkye+AH/qHT2+4yDJrqsYzZf0betC8VuaroDCh5uaynFn7lzwFfMl4jiBocZUCg3LZpizyz2Fs7wnMCXiK90DUDavFXczOSYv/3afSMzmBZrW70dThntJF2YC3SBdtXbU/KaBIYM/hapE7xisFTZu5j/daAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724415726; c=relaxed/simple;
	bh=Lc8l5JND44/zG76jTdnfFqKHRz/NrHFNKpUikJFT+4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IMy8cXRXIBzLLOOn+Vf/WTarwxb0JNc5FIFiKfRK79APrpkQwlhj07V2HbX4+AQNJ1o7WIdFr57JtK2hrcTJakvhMlGR68ZA2lp944Q3c2MBun/Eb9CLTck6HuKgKeXk4ePlnYHYdBQN9uBl0ASbAWnavwbJ/oE2dRpKTD5LxGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIAfTeYq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a83597ce5beso294358166b.1;
        Fri, 23 Aug 2024 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724415723; x=1725020523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5eEdCgC0SPKqs3u0LuaMWosRv+buqe75w5wcTyW8ZQo=;
        b=BIAfTeYqwXbOv/b8WJzzZ7HLF0OwE2dNjUznKOm8DaQJFppJ5bWH/jKRLTSi1jEcfo
         AvpWMWa7XbVUXd0jYM4HJLEfpG8nr5bnKzVYO0yuGDnrfktnWqVCMBe7USb0ERq+4ac5
         d12gx7+I25LwiSaNOxAN6sEP0ZbU2f/rky3xNZAgqIQ4+ywhGRHoK1IGFbu2QislTJV8
         xwzu5As3E0kPYnSrDWsIwRnq9XBF7bW3DH/sXQMxz5ImS1Gm2SFNxTn0z2NyzoFDbQ5Y
         11Pm2ZE/jbBPc4BNMCJoBKEnn6BrCNL57rPbXn+wsCxAXIfsphr3kK2enPUAph7r4tvr
         x71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724415723; x=1725020523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eEdCgC0SPKqs3u0LuaMWosRv+buqe75w5wcTyW8ZQo=;
        b=ZIb2gn2wnvglNGpnTypKrmz9uDUuskjE8WARZ3NK7apoe/j31TCckSu73Nr+pEOAIy
         +ida5XXKO1JLieHLn4f3iTJDUMOCKeSgt3Ik23PmhcN6fyNR1s7exfbA8tZf1TZhHbWQ
         uGEYtYEC6gEPGiOg7RGIVuqJF2RW6WKcq2RsKgHZcKR4RodaM8FNOyb8LOct1F67XVUT
         WpOuO1O/7GwlnjOYoq9rIZRIPKHiGPL4LhWqezjfzwxeG2nm9bCmrKSmeJba6EjSxvQ2
         n6F7F+LYCJ/EBE5JtyOVEvndy4MzbZRTx6fmu2Yy5tcv/36QpWv+iuzxgcBH8WDgTM2i
         5yqw==
X-Forwarded-Encrypted: i=1; AJvYcCVcaptx+q9fqzbfxmt6R4qVK3g1LGdJzzk6UbKyAU/EYubIpLWHDdf7Cn8w9ITL3GS3hnbszWbUGDTwNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbEnLvelVWcs+TNvcIknzGs6gz86F+tYbFJDDjVot+XZlvNwV
	YFdvgMp5uC9eOkE+DEDzlj15LYt6Sjo2M8a/lMIf9L9NupLjkZhp
X-Google-Smtp-Source: AGHT+IEtzhFNF1/qaDPbXhNNEEMpqA9Zaf6XEK3JQKxLluenNtG8sXlgTDCejcz+iDBXAzJC7A8yLw==
X-Received: by 2002:a17:907:9811:b0:a86:84c3:a87 with SMTP id a640c23a62f3a-a868a84e735mr570613466b.24.1724415722116;
        Fri, 23 Aug 2024 05:22:02 -0700 (PDT)
Received: from localhost.localdomain ([78.210.47.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2206a1sm253317166b.6.2024.08.23.05.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:22:01 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH] hwmon: (sht4x): add heater support
Date: Fri, 23 Aug 2024 14:21:39 +0200
Message-Id: <20240823122139.12698-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for manipulating the internal heater of sht4x devices.

The heater can operate at three heating levels (20, 110 or 200
milliwatts). Also, two heating durations may be selected (0.1 or 1s).
Once the heating time elapses the heater is automatically switched off.
---
 Documentation/hwmon/sht4x.rst |  10 +++
 drivers/hwmon/sht4x.c         | 137 +++++++++++++++++++++++++++++++++-
 2 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/sht4x.rst b/Documentation/hwmon/sht4x.rst
index daf21e763425..e7414a623a52 100644
--- a/Documentation/hwmon/sht4x.rst
+++ b/Documentation/hwmon/sht4x.rst
@@ -42,4 +42,14 @@ humidity1_input Measured humidity in %H
 update_interval The minimum interval for polling the sensor,
                 in milliseconds. Writable. Must be at least
                 2000.
+heater_power	The requested heater power, in milliwatts.
+		Available values: 20, 110, 200 (default: 200).
+heater_time	The requested operating time of the heater,
+		in milliseconds.
+		Available values: 100, 1000 (default 1000).
+heater_enable	Enable the heater with the selected power
+		and for the selected time. Write-only.
+
+			- 0: turn off
+			- 1: turn on
 =============== ============================================
diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index b8916d2735b5..34214fe08a9e 100644
--- a/drivers/hwmon/sht4x.c
+++ b/drivers/hwmon/sht4x.c
@@ -11,6 +11,7 @@
 #include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
 #include <linux/i2c.h>
 #include <linux/jiffies.h>
 #include <linux/module.h>
@@ -31,6 +32,12 @@
  */
 #define SHT4X_CMD_MEASURE_HPM	0b11111101
 #define SHT4X_CMD_RESET		0b10010100
+#define SHT4X_CMD_HEATER_20_1	0b00011110
+#define SHT4X_CMD_HEATER_20_01	0b00010101
+#define SHT4X_CMD_HEATER_110_1	0b00101111
+#define SHT4X_CMD_HEATER_110_01	0b00100100
+#define SHT4X_CMD_HEATER_200_1	0b00111001
+#define SHT4X_CMD_HEATER_200_01 0b00110010
 
 #define SHT4X_CMD_LEN		1
 #define SHT4X_CRC8_LEN		1
@@ -54,6 +61,8 @@ DECLARE_CRC8_TABLE(sht4x_crc8_table);
  * @last_updated: the previous time that the SHT4X was polled
  * @temperature: the latest temperature value received from the SHT4X
  * @humidity: the latest humidity value received from the SHT4X
+ * @heater_power: the power at which the heater will be started
+ * @heater_time: the time for which the heater will remain turned on
  */
 struct sht4x_data {
 	struct i2c_client	*client;
@@ -63,6 +72,8 @@ struct sht4x_data {
 	long			last_updated;	/* in jiffies */
 	s32			temperature;
 	s32			humidity;
+	u32			heater_power;	/* in milli-watts */
+	u32			heater_time;	/* in milli-seconds */
 };
 
 /**
@@ -215,6 +226,128 @@ static int sht4x_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
+static ssize_t heater_enable_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	return -EOPNOTSUPP;
+}
+
+static ssize_t heater_enable_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t count)
+{
+	struct sht4x_data *data = dev_get_drvdata(dev);
+	bool status;
+	ssize_t ret;
+	u8 cmd[SHT4X_CMD_LEN];
+
+	ret = kstrtobool(buf, &status);
+	if (ret)
+		return ret;
+
+	if (status) {
+		if (data->heater_power == 20) {
+			if (data->heater_time == 100)
+				*cmd = SHT4X_CMD_HEATER_20_01;
+			else /* data->heater_time == 1000 */
+				*cmd = SHT4X_CMD_HEATER_20_1;
+		} else if (data->heater_power == 110) {
+			if (data->heater_time == 100)
+				*cmd = SHT4X_CMD_HEATER_110_01;
+			else /* data->heater_time == 1000 */
+				*cmd = SHT4X_CMD_HEATER_110_1;
+		} else if (data->heater_power == 200) {
+			if (data->heater_time == 100)
+				*cmd = SHT4X_CMD_HEATER_200_01;
+			else /* data->heater_time == 1000 */
+				*cmd = SHT4X_CMD_HEATER_200_1;
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	mutex_lock(&data->lock);
+	ret = i2c_master_send(data->client, cmd, SHT4X_CMD_LEN);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static ssize_t heater_power_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct sht4x_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", data->heater_power);
+}
+
+static ssize_t heater_power_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t count)
+{
+	struct sht4x_data *data = dev_get_drvdata(dev);
+	u32 power;
+	ssize_t ret;
+
+	ret = kstrtou32(buf, 10, &power);
+	if (ret)
+		return ret;
+
+	if (power != 20 && power != 110 && power != 200)
+		return -EINVAL;
+
+	data->heater_power = power;
+
+	return count;
+}
+
+static ssize_t heater_time_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct sht4x_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", data->heater_time);
+}
+
+static ssize_t heater_time_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf,
+				 size_t count)
+{
+	struct sht4x_data *data = dev_get_drvdata(dev);
+	u32 time;
+	ssize_t ret;
+
+	ret = kstrtou32(buf, 10, &time);
+	if (ret)
+		return ret;
+
+	if (time != 100 && time != 1000)
+		return -EINVAL;
+
+	data->heater_time = time;
+
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(heater_power, heater_power, 0);
+static SENSOR_DEVICE_ATTR_RW(heater_time, heater_time, 0);
+
+static struct attribute *sht4x_attrs[] = {
+	&sensor_dev_attr_heater_enable.dev_attr.attr,
+	&sensor_dev_attr_heater_power.dev_attr.attr,
+	&sensor_dev_attr_heater_time.dev_attr.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(sht4x);
+
 static const struct hwmon_channel_info * const sht4x_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
@@ -255,6 +388,8 @@ static int sht4x_probe(struct i2c_client *client)
 
 	data->update_interval = SHT4X_MIN_POLL_INTERVAL;
 	data->client = client;
+	data->heater_power = 200;
+	data->heater_time = 1000;
 
 	mutex_init(&data->lock);
 
@@ -270,7 +405,7 @@ static int sht4x_probe(struct i2c_client *client)
 							 client->name,
 							 data,
 							 &sht4x_chip_info,
-							 NULL);
+							 sht4x_groups);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
-- 
2.25.1


