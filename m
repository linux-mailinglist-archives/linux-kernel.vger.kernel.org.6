Return-Path: <linux-kernel+bounces-301552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9F295F26F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DEC283110
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DDF17BECA;
	Mon, 26 Aug 2024 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bokT8KLb"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4317ADF0;
	Mon, 26 Aug 2024 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677790; cv=none; b=eg4qT2tfldX/fV7LsVQH4H2uJ8+m5lKFrf8I20Nyt/l2bDZchjHfgIORx0H6c5q9Om0miX8UlgAiZx5uW+gM+610Uw4ESKPdLoHtCpsDFwDTASb1dvNFprezJ/eGubTAwo/QjoQHijKWeCjuyhime7MyZbEsNZec/qNEXAFkTE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677790; c=relaxed/simple;
	bh=hon4k0qRCNgNpW/5k2wfoT8d4aalOd69JWVXOrrkaQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AwjYzIfOcQ6j/oKJA5aisGR97HsY+vk404cyeoDjsYglED6ZhNUvVD18emaGZTCNPngRNt5LRyI2eFNURTBIJO1Q2z1UEDT57Jcfz25mjDHU874qnZkcVTFf4T0C3opQS/vG7p2d0Oto91BSywrMxmRg4YuYo4kmuC8xca9mj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bokT8KLb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f5064816edso17428941fa.3;
        Mon, 26 Aug 2024 06:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724677787; x=1725282587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=owDq8MB2nz+XwFSl+6oyLa3ym/RbNfaXkAQE12NXndI=;
        b=bokT8KLbzPyO/b+Biwt4hoxy4NNp+vUszEz3XzRiNYqjumPobIbkKW1qrfY73r/KoP
         1XhjM+Eh0Q9u5KD9aRZZPnD9S6lrh6V81FVL/L1F0y3+QEA+2DnjGbPDQ8wIrSKnJ3h/
         fxINp98LM2AWTqT9iKS0kQlR9SinXg3dyuM8iUSbjhqrlSH+NYjp6phngHuKS6JWPwTc
         eRJyGCZeOYjqn8ekjBPAz5GLIjJsfFuViIjyUJiSS8DEVmrQHN/brZtoeUWBeXTyxKdS
         OZwgKbGhH3Hy7GvQSEfkuet78Lw3w8Zs/kfJBzq2KfPEZy47kKqlES0U7leEkn3tBHm7
         q9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724677787; x=1725282587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owDq8MB2nz+XwFSl+6oyLa3ym/RbNfaXkAQE12NXndI=;
        b=RC9pDnVznjk7xsBFjWqh3tlMGn9ydm/8/9fXRTxRJZVIVx1aIcTKrjbRFQbVXHHpxC
         zjRhmRPeg10vJXLY1dMVCP4/PBLW44Pu4v8Lkbggs/mdf8XwgOwdNdhuzjlD5MMBvc90
         C3vjGDhAqiHSdGuZniGrGnkGEiat8ONzEPDJQS63LMsxtebyeaV7OEfZ8zr41qohQKqQ
         2B81UfpD4OH3ISvzIdYTw53wJUJHtKUqr2pWfR80UsVlmNhE3UMM3SoFZE8ggx+L5F77
         zoOtT945oRwoFemkHY8DUi+xDD9HHED21g9j2XB6sGhBqm6i7+xicvPgkEVFcoHLXsTv
         Tm0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtU+gCDU27hrqO+yxrkD8xrnfeW9UpHU4eA03S/vG02irO4whegC+UBd0y8nZxnhEXQk46Qp11qz/Ceg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaLEbd7wBnKtRgyMuyLYfzhh0ddrtHKMnE0TU8X4gE1++dYrcR
	io3Scm3Vr3QTQtVr0eskdwvfqQyfzU4NPUc+O4BQE0ydUlJXZU8A
X-Google-Smtp-Source: AGHT+IFNSG5bxSxW7043GICHKiL3rwTBGw5NIKaRxVbDBR2p9dX7CmA7oo5v9+Z/n9zIHVKqbQNw9A==
X-Received: by 2002:a2e:be9e:0:b0:2ef:20ae:d111 with SMTP id 38308e7fff4ca-2f4f48ef674mr78907401fa.6.1724677785793;
        Mon, 26 Aug 2024 06:09:45 -0700 (PDT)
Received: from localhost.localdomain ([37.160.62.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a9582sm5560202a12.95.2024.08.26.06.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:09:45 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3] hwmon: (sht4x): add heater support
Date: Mon, 26 Aug 2024 14:58:04 +0200
Message-Id: <20240826125803.71970-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for manipulating the internal heater of sht4x devices.
Enabling the heater removes condensed water from the sensor surface
which disturbs the relative humidity measurements.

The heater can operate at three heating levels (20, 110 or 200
milliwatts). Also, two heating durations may be selected (0.1 or 1s).
Once the heating time elapses the heater is automatically switched off.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
Hello Guenter,

Thanks for the review. 
I'm not sure if this short patch description above is now ok or shall I
be even more detailed.
The problem that I was facing was that when I was using the sensor for
relative humidity measurements the results were always ~100% even though
the correct value should be ~60%. Enabling the heater in periodic pulses
to remove the condensation fixed the issue and the measurements were
correct after that.
Thus, I'm not sure if I should include that detailed arguments in the
patch description or leave it as it is right now.

Regards,
Antoni Pokusinski

--
Changes since v2:
* heater_enable_store: remove unnecessary if
* Documentation: remove incorrect info about turning off the heater
* be more specific in the patch description

Changes since v1:
* explain the use case of the new attributes set
* heater_enable attr: make it write-only
* heater_enable_store: define cmd as u8 instead of u8*
* heater_enable_store: remove unreachable data path
* heater_enable_store: remove unnecessary lock
* heater_enable_store: call i2c_master_send only if status==true
* define attributes as DEVICE_ATTR_* instead of SENSOR_DEVICE_ATTR_*
---
 Documentation/hwmon/sht4x.rst |  10 +++
 drivers/hwmon/sht4x.c         | 126 +++++++++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/sht4x.rst b/Documentation/hwmon/sht4x.rst
index daf21e763425..0b17f89fa1ab 100644
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
+		and for the selected time in order to remove
+		condensed water from the sensor surface. Write-only.
+
+			- 1: turn on
 =============== ============================================
diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index b8916d2735b5..20b50f7feac0 100644
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
+		} else { /* data->heater_power == 200 */
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


