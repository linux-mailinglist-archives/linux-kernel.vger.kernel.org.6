Return-Path: <linux-kernel+bounces-309013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D352796652D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 876CC284642
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87191B5316;
	Fri, 30 Aug 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3g7p7+t"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE45D1A4B6C;
	Fri, 30 Aug 2024 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031206; cv=none; b=BoiKay3eEq/mW+3emXuZFXxw2N2rD2L3D/MPU4Nnbf/PWm4sNBUCWtBRu0Qp147CnVUnETIQgMOqFd7dhBEFmxIpsFD2E5NHn4+W6y9XuAfjpwOEM0AMDIyKGyR7i34ixB2EUcBZlkKUvFoyOfr+CMCdDrmsGTBnrLeUDgGRFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031206; c=relaxed/simple;
	bh=0UXZVK+01YIALbpXvQLWD0w7jNJSs5w4fefocSWUt9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=shuXxRkTDMPkopEOASRZJcNylTgajMLyRLbNNPoCax4YNEPrhgCGBsYf9bsUSd/fALZsyFqpFIQUXpHCGGCZK2SRcEK2322X7q7aB/AMXrfLqwwFik4t8HRWztjOrPJ9T2aUeO3lDdUa+XlXnaxGJph2KuIa9RnmbDYGZhftl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3g7p7+t; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bb885f97eso8828365e9.0;
        Fri, 30 Aug 2024 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725031203; x=1725636003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwCJQYBFWQH0dOGXuS489tUDvuQt4sjtMeEawT8BUM0=;
        b=g3g7p7+tpUqBIzT3u5zWDC4VOQr5u1ugf4wF/rJCD1t0vBTw8fxTbeHVssZbJlq5tF
         RpNxpJAyuLmO5Nz4Wv5YhW1N9hvuCBbyT266kyAMWtncOg6wMhzO4FUaXIJZd9CyxVkN
         1AOoKOs0webIgse1FNoljgsIUcwq7HYKKeiKRmB63TC+T2b+uf/Eu5v2IHh2hIr0tzkU
         33PBS64w7XrDlyd5In2rLVnl79vox8lUu6RC/8tiy7uzUMjhGUd/epCOlKjlCRBj3fio
         wAFO/C0rCmQQnnfvqSYA5EinBubMNi75+yjEXeCDwI/akGlZ2tFP7tiUttJAC7WwtxMR
         qK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031203; x=1725636003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwCJQYBFWQH0dOGXuS489tUDvuQt4sjtMeEawT8BUM0=;
        b=AZ34sLI+gYJ2s3Ed+Tb0gYV/cCH9Qc7T3udYx+yyMd4X9J2H6vja364rNrEjWRwilv
         FXmu4av6orV3cMIyQhhZqk25dtZC9ISb4Yjn9pZWTfJUyHOkdG+AgwDvZfQAMpACf+k+
         S7KWJxKd0XIRQZ9WOOdyH8n6dOv3XvUFu7Lg5fVLDAHl84FOI0rc9C8T6sz/SlEfYEst
         8eFsDM409DqmGiMg0CZNq58Zj8I6vNwAk6iCo5FiASEuup9wftpR0XuHUukMDsPnHZUy
         TFNPIsXujEU3dDA3oGzC6U1VEg6BdhNPyVyTLX/8OrPP7hSRXpit2aziI9Yrc+w4L8hi
         L2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVF/H8fLDV7Gjm8O43LU7J/VMb1H+r3kzhSn2RDafuivChHqQYA46BQWlPW3489H7qKi7WJ01tNQFTIKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxlYIidyncwjjJeyXkdTtwyck0f+wCgXEZsteHpwoLuIuWgSed
	zXu22eH0WeCSnstTHDN/1CH3c07NdsEahdAJUPz1oIZrUao3yiZO
X-Google-Smtp-Source: AGHT+IF+udyzry1IDmtCy91l9bClMLrPxmjJcx1kb7Pek9BxSYiO48yR1YlWp4gF9ewCeje+gqKWOA==
X-Received: by 2002:a5d:6748:0:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-374a916ee7bmr1940789f8f.3.1725031202347;
        Fri, 30 Aug 2024 08:20:02 -0700 (PDT)
Received: from localhost.localdomain ([78.209.142.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef7f334sm4299778f8f.80.2024.08.30.08.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:20:01 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4] hwmon: (sht4x): add heater support
Date: Fri, 30 Aug 2024 17:17:53 +0200
Message-Id: <20240830151752.577899-1-apokusinski01@gmail.com>
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
Changes since v3:
* struct sht4x_data: add heating_complete timestamp
* struct sht4x_data: add data_pending flag
* heater_enable_store: return -EINVAL if input != 1
* heater_enable_store: check for data->heating_complete and update it
* heater_enable_store: set data_pending flag after heating request
* sht4x_read_values: msleep if heating in progress
* sht4x_read_values: dont send measurement request if data_pending
* heater_enable attr: make it RW
* Documentation: update info about heater_enable attr

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
 Documentation/hwmon/sht4x.rst |  14 +++
 drivers/hwmon/sht4x.c         | 184 ++++++++++++++++++++++++++++++++--
 2 files changed, 189 insertions(+), 9 deletions(-)

diff --git a/Documentation/hwmon/sht4x.rst b/Documentation/hwmon/sht4x.rst
index daf21e763425..ba094ad0e281 100644
--- a/Documentation/hwmon/sht4x.rst
+++ b/Documentation/hwmon/sht4x.rst
@@ -42,4 +42,18 @@ humidity1_input Measured humidity in %H
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
+		condensed water from the sensor surface. The
+		heater cannot be manually turned off once
+		enabled (it will automatically turn off
+		after completing its operation).
+
+			- 0: turned off (read-only value)
+			- 1: turn on
 =============== ============================================
diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index b8916d2735b5..6c9b776237c2 100644
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
@@ -49,6 +56,10 @@ DECLARE_CRC8_TABLE(sht4x_crc8_table);
  * struct sht4x_data - All the data required to operate an SHT4X chip
  * @client: the i2c client associated with the SHT4X
  * @lock: a mutex that is used to prevent parallel access to the i2c client
+ * @heating_complete: the time that the last heating finished
+ * @data_pending: true if and only if there are measurements to retrieve after heating
+ * @heater_power: the power at which the heater will be started
+ * @heater_time: the time for which the heater will remain turned on
  * @valid: validity of fields below
  * @update_interval: the minimum poll interval
  * @last_updated: the previous time that the SHT4X was polled
@@ -58,6 +69,10 @@ DECLARE_CRC8_TABLE(sht4x_crc8_table);
 struct sht4x_data {
 	struct i2c_client	*client;
 	struct mutex		lock;	/* atomic read data updates */
+	unsigned long		heating_complete;	/* in jiffies */
+	bool			data_pending;
+	u32			heater_power;	/* in milli-watts */
+	u32			heater_time;	/* in milli-seconds */
 	bool			valid;	/* validity of fields below */
 	long			update_interval;	/* in milli-seconds */
 	long			last_updated;	/* in jiffies */
@@ -79,19 +94,30 @@ static int sht4x_read_values(struct sht4x_data *data)
 	u8 crc;
 	u8 cmd[SHT4X_CMD_LEN] = {SHT4X_CMD_MEASURE_HPM};
 	u8 raw_data[SHT4X_RESPONSE_LENGTH];
+	unsigned long curr_jiffies;
 
 	mutex_lock(&data->lock);
-	next_update = data->last_updated +
-		      msecs_to_jiffies(data->update_interval);
 
-	if (data->valid && time_before_eq(jiffies, next_update))
-		goto unlock;
+	curr_jiffies = jiffies;
+	if (time_before(curr_jiffies, data->heating_complete))
+		msleep(jiffies_to_msecs(data->heating_complete - curr_jiffies));
 
-	ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
-	if (ret < 0)
-		goto unlock;
+	if (data->data_pending &&
+	    time_before(jiffies, data->heating_complete + data->update_interval)) {
+		data->data_pending = false;
+	} else {
+		next_update = data->last_updated +
+			msecs_to_jiffies(data->update_interval);
 
-	usleep_range(SHT4X_MEAS_DELAY_HPM, SHT4X_MEAS_DELAY_HPM + SHT4X_DELAY_EXTRA);
+		if (data->valid && time_before_eq(jiffies, next_update))
+			goto unlock;
+
+		ret = i2c_master_send(client, cmd, SHT4X_CMD_LEN);
+		if (ret < 0)
+			goto unlock;
+
+		usleep_range(SHT4X_MEAS_DELAY_HPM, SHT4X_MEAS_DELAY_HPM + SHT4X_DELAY_EXTRA);
+	}
 
 	ret = i2c_master_recv(client, raw_data, SHT4X_RESPONSE_LENGTH);
 	if (ret != SHT4X_RESPONSE_LENGTH) {
@@ -215,6 +241,143 @@ static int sht4x_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
+static ssize_t heater_enable_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct sht4x_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%u\n", time_before(jiffies, data->heating_complete));
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
+	u8 cmd;
+	u32 heating_time_bound;
+
+	ret = kstrtobool(buf, &status);
+	if (ret)
+		return ret;
+	if (!status)
+		return -EINVAL;
+
+	if (data->heater_time == 100) {
+		if (data->heater_power == 20)
+			cmd = SHT4X_CMD_HEATER_20_01;
+		else if (data->heater_power == 110)
+			cmd = SHT4X_CMD_HEATER_110_01;
+		else /* data->heater_power == 200 */
+			cmd = SHT4X_CMD_HEATER_200_01;
+
+		heating_time_bound = 110;
+	} else { /* data->heater_time == 1000 */
+		if (data->heater_power == 20)
+			cmd = SHT4X_CMD_HEATER_20_1;
+		else if (data->heater_power == 110)
+			cmd = SHT4X_CMD_HEATER_110_1;
+		else /* data->heater_power == 200 */
+			cmd = SHT4X_CMD_HEATER_200_1;
+
+		heating_time_bound = 1100;
+	}
+
+	mutex_lock(&data->lock);
+
+	if (time_before(jiffies, data->heating_complete)) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
+	ret = i2c_master_send(data->client, &cmd, SHT4X_CMD_LEN);
+	if (ret < 0)
+		goto unlock;
+
+	data->heating_complete = jiffies + msecs_to_jiffies(heating_time_bound);
+	data->data_pending = true;
+unlock:
+	mutex_unlock(&data->lock);
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
+static DEVICE_ATTR_RW(heater_enable);
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
@@ -255,6 +418,9 @@ static int sht4x_probe(struct i2c_client *client)
 
 	data->update_interval = SHT4X_MIN_POLL_INTERVAL;
 	data->client = client;
+	data->heater_power = 200;
+	data->heater_time = 1000;
+	data->heating_complete = jiffies;
 
 	mutex_init(&data->lock);
 
@@ -270,7 +436,7 @@ static int sht4x_probe(struct i2c_client *client)
 							 client->name,
 							 data,
 							 &sht4x_chip_info,
-							 NULL);
+							 sht4x_groups);
 
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
-- 
2.25.1


