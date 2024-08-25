Return-Path: <linux-kernel+bounces-300372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB7595E2EC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 12:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9E82821E3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7313B7BE;
	Sun, 25 Aug 2024 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmGAWClh"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD7B667;
	Sun, 25 Aug 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724580644; cv=none; b=MobFB1xUYwOdehuqnVRCBl3H+LAuAY+wPMMbb2VrPKQQvUf5ow5jg8xQW7CAQArCDC9tQFA+0EdZmakabapxkeIOKco1rmtDYLAl8onj+1TDTup0Cfwb/kNSCRBGWuxL7vd257fQAGHGy/l0r2plvLPot7DhCjxt3HF1hp/jwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724580644; c=relaxed/simple;
	bh=+EYeURRbIpCowLoY9u8LniOecq78WZcm6/b4pt20mCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WF5XlbHVBMmLMPr98h8ecTBBWIhp7uPyq8cQpejMJSJkHh55uIbDAEKCvdCvgMgf9KSq7dqkH8B2JnHHoMiN1IXZwFhM/4ql5LmYW62EZUlvntahD1frvNWgRGLse0i2cC4FlnB0reH/EnUO2pLXyIJOrILBCQDkRsZzxog9gdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmGAWClh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371ba7e46easo1946848f8f.0;
        Sun, 25 Aug 2024 03:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724580641; x=1725185441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJsxVoOmf0EQuRevpB0M1k1iD8kvCJdvgoRepS+ws2U=;
        b=dmGAWClhjn+zNoG9CivJdhFEacODNTWx4Aciauuf8JETYf7f54EJzUnIziPoRIcGI7
         9pwTKdbM6sY7dhlmHhFfcMBJOBHWCJzbNPtSaGTKLkH4gCarljAZmAgarYJuGamOJp29
         Udrh/5U7Yn8YsoAZ9xKsQsDahzQZUm04zfOlCg3hYr3DxVv5H+mI7jLwdSrvtilwP6FJ
         b2OrgQfU+nsUSAEbI86Er9NdLqkYv6lJLqUzPueGKh4E7h3Rcrt6mgI1Lt5BsFLilHQm
         bCMG8gjd+rnBB8kKtShkOUBSGYJo6j7ZfVUxMHFtWJr+ui3sXuPgmccLjCStrYaK8QVA
         MN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724580641; x=1725185441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJsxVoOmf0EQuRevpB0M1k1iD8kvCJdvgoRepS+ws2U=;
        b=HyeZEiCYpBAy6hVbN3ie+wTcpJeZ6d4y6Y8jGnjpdw1vE41mUYezk6yQyjx2nH1XRT
         2zo4vA3cSETuqrNunRz4jdXIhwKUbwfnAkFZkNquahQw+BR0pTCBWDhn7viGzY7MemSL
         mBAiJ+qz0bF56WSRxMfru+ZkWpgsnX+atG8iPDRkpDacz04WeW9l00SjpEeOF1lzTq2+
         ixr9c4Oc6/kK+GtOSyvUp+LBINHhEjwNWbGYDINRI66TR+ow+4d7IRzG4R+zaqtw2Iyr
         bfvVcJu6AVxd4WLiNDkmXSVQcBIdFWPXHsAFjODhc7yHveUDbrycOoX1szNEwyzloZL7
         jzQg==
X-Forwarded-Encrypted: i=1; AJvYcCUxmDLmYh2m5J+OGCor5EKbtqWQogI+P2Pc7QcU7MdIBqXC+iw3l5XRkUBercrCyfsfg3hkps6ALj3YlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJil3qhEOndY5B+VPOfSoDvWx/CMZ0HQtxB8GQXZScHrU+v/q
	2mRihYDazr6p8VZ5tnmNuvSYgDBmQiXNx5p1C5vt4H7M7oECG2gY
X-Google-Smtp-Source: AGHT+IFkZ9kPKWuyfzfwr7DewT89Ke+PLf1IsZuUU5WlZV2D5wIb2FAEEWRO1WXfokqIo0AQAoqZ9A==
X-Received: by 2002:adf:b19a:0:b0:36b:c66a:b9fd with SMTP id ffacd0b85a97d-37311841a8dmr3951158f8f.6.1724580640107;
        Sun, 25 Aug 2024 03:10:40 -0700 (PDT)
Received: from localhost.localdomain ([78.210.124.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730815b7e3sm8304029f8f.53.2024.08.25.03.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 03:10:39 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2] hwmon: (sht4x): add heater support
Date: Sun, 25 Aug 2024 12:09:31 +0200
Message-Id: <20240825100930.205670-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for manipulating the internal heater of sht4x devices.
The heater may be used to remove condensed water on the sensor surface
which disturbs the relative humidity measurements.

The heater can operate at three heating levels (20, 110 or 200
milliwatts). Also, two heating durations may be selected (0.1 or 1s).
Once the heating time elapses the heater is automatically switched off.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
Changes since v1:
* explain the use case of the new attributes set
* heater_enable attr: make it write-only
* heater_enable_store: define cmd as u8 instead of u8*
* heater_enable_store: remove unreachable data path
* heater_enable_store: remove unnecessary lock
* heater_enable_store: call i2c_master_send only if status==true
* define attributes as DEVICE_ATTR_* instead of SENSOR_DEVICE_ATTR_*
---
 Documentation/hwmon/sht4x.rst |  11 +++
 drivers/hwmon/sht4x.c         | 126 +++++++++++++++++++++++++++++++++-
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/sht4x.rst b/Documentation/hwmon/sht4x.rst
index daf21e763425..3ff6c08d8267 100644
--- a/Documentation/hwmon/sht4x.rst
+++ b/Documentation/hwmon/sht4x.rst
@@ -42,4 +42,15 @@ humidity1_input Measured humidity in %H
 update_interval The minimum interval for polling the sensor,
                 in milliseconds. Writable. Must be at least
                 2000.
+heater_power	The requested heater power, in milliwatts.
+		Available values: 20, 110, 200 (default: 200).
+heater_time	The requested operating time of the heater,
+		in milliseconds.
+		Available values: 100, 1000 (default 1000).
+heater_enable	Enable the heater with the selected power
+		and for the selected time in order to remove
+		condensed water from the sensor surface. Write-only.
+
+			- 0: turn off
+			- 1: turn on
 =============== ============================================
diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index b8916d2735b5..75e092f9b80e 100644
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
@@ -215,6 +226,117 @@ static int sht4x_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
+static ssize_t heater_enable_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t count)
+{
+	struct sht4x_data *data = dev_get_drvdata(dev);
+	bool status;
+	ssize_t ret;
+	u8 cmd;
+
+	ret = kstrtobool(buf, &status);
+	if (ret)
+		return ret;
+
+	if (status) {
+		if (data->heater_power == 20) {
+			if (data->heater_time == 100)
+				cmd = SHT4X_CMD_HEATER_20_01;
+			else /* data->heater_time == 1000 */
+				cmd = SHT4X_CMD_HEATER_20_1;
+		} else if (data->heater_power == 110) {
+			if (data->heater_time == 100)
+				cmd = SHT4X_CMD_HEATER_110_01;
+			else /* data->heater_time == 1000 */
+				cmd = SHT4X_CMD_HEATER_110_1;
+		} else if (data->heater_power == 200) {
+			if (data->heater_time == 100)
+				cmd = SHT4X_CMD_HEATER_200_01;
+			else /* data->heater_time == 1000 */
+				cmd = SHT4X_CMD_HEATER_200_1;
+		}
+
+		ret = i2c_master_send(data->client, &cmd, SHT4X_CMD_LEN);
+	}
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
+static DEVICE_ATTR_WO(heater_enable);
+static DEVICE_ATTR_RW(heater_power);
+static DEVICE_ATTR_RW(heater_time);
+
+static struct attribute *sht4x_attrs[] = {
+	&dev_attr_heater_enable.attr,
+	&dev_attr_heater_power.attr,
+	&dev_attr_heater_time.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(sht4x);
+
 static const struct hwmon_channel_info * const sht4x_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
 	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
@@ -255,6 +377,8 @@ static int sht4x_probe(struct i2c_client *client)
 
 	data->update_interval = SHT4X_MIN_POLL_INTERVAL;
 	data->client = client;
+	data->heater_power = 200;
+	data->heater_time = 1000;
 
 	mutex_init(&data->lock);
 
@@ -270,7 +394,7 @@ static int sht4x_probe(struct i2c_client *client)
 							 client->name,
 							 data,
 							 &sht4x_chip_info,
-							 NULL);
+							 sht4x_groups);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
-- 
2.25.1


