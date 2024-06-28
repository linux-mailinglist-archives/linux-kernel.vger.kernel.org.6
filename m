Return-Path: <linux-kernel+bounces-234106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF25691C24B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F306C1C21F25
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BFA1C6894;
	Fri, 28 Jun 2024 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naFxpBW+"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E64E1CB329;
	Fri, 28 Jun 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587651; cv=none; b=cFlDE2++SOncmPMqq6luFq2iAJVQzHah6bbe9aDfn7rW0uv/A0HeI2iFA5yNvTGBV94DewkeoRWYTal2gbL8LzW/9nAKbGdN91IPv+nTKnHlIBbOrPFbBc29lWBrA+HlR7HHjFoMDDnRtg41g9GWarnkk3UAMKRzLYY/8Ni+FJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587651; c=relaxed/simple;
	bh=ZbJhOAqQZCMBdnhjK04gJEOKQrEHkT863t4ky8wGXAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=douls3XmsRj81CRQwSn1xLEmMi0Xe/UOwZHilBK3sm1Z8KB26CcorSugYwi9+8c6JLk2yVRWH1qyjuFHeYNh3d3qCwyY4QbiLAZO4dfAyEUSrcFDawCvAWaAlCfHkiN2fajS9ESYl48ozRYdFMMUgiyGNDD5e07h1Y+SaH6lKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naFxpBW+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f480624d0dso5227065ad.1;
        Fri, 28 Jun 2024 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587648; x=1720192448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W3zJ6VEnkMTA8IHP/+PzEqouaOw2+HRHWJqW4vFypw=;
        b=naFxpBW+2B3N1dPpwNEzfvNJBjj3+OwaTwbncPUul8QDzSlrOjTfSLx2sZ49AwgBZP
         J1COTYLfHYpRCnIac2HxRcxSQGmKUx3bETdt63vWhrY3/b2+r44I79z5aZug5bYvUPn4
         jfid5+SVK7hwzzegpTkUuXcnMin6ZqCJxT9SwOMnj7aW4H8XM0F7bAyq/hvY3WVVCAMX
         SVz28Yi9NLE4v5hNFXCveK7AeI2nrgHtKL5Qag/jazRki7fmpZB/ZtPwYz1J1KJZkv+0
         I2UB8hp78A+XdXZJuKlvCeDn+c3l+Uw3PuSgTAcol6NXZBD8vzZt6AwAHOuBUvQyXMk1
         rLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587648; x=1720192448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/W3zJ6VEnkMTA8IHP/+PzEqouaOw2+HRHWJqW4vFypw=;
        b=U2R7Z8jXzJOv+dc/w7P4V5usL7vPsxMrlP5bJtKvGPHuUN8C2f03rzlAyw3oOhQIBx
         dbMpd51PwR7GPIH6UKSh0DHBkEWRrl3eoNDBg/n6kz57Dwm8zlW3Mvyt8SFFJET2Zunl
         1w5VbCcFm5VpSXlCN2slxq5tvzx3xEl9nM+pZdB9OiTR8/NljIXS2PKTz+3W+ZfiWudH
         AEhGU1eJMPAdmik1cdADvUsxJov9QbK4cj/tgw0tHqCll4Ec1ETuE6F8DBRz1tpEu06B
         +ASEiIbwg/EEjQW1olhDl2BaYG8lyrG4Ga9eRAXHlH64TfUDbYT8nf3+9LjI4c0sXl7p
         0M5g==
X-Gm-Message-State: AOJu0Yx7z2gYbOeBZ0BNL9gQaDbnTInW+QgC7GN7ig8KIreFEtvwzgWy
	pkHYvGt0CyYbZeyByRos2hUFY1/7Ent2jgOuorI8Lc/ZBaVFp/8zyQL2jQ==
X-Google-Smtp-Source: AGHT+IHwuQpSxs4S6PGMFUkWkqHz/qWgBSOqeXyvNC1stChjx194NhW4maQ6JGTeMQ48abDTktdcrQ==
X-Received: by 2002:a17:903:2302:b0:1f7:1b59:6f5c with SMTP id d9443c01a7336-1fa23f156e6mr202771765ad.44.1719587647791;
        Fri, 28 Jun 2024 08:14:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fad2083614sm6520385ad.87.2024.06.28.08.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:14:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 09/10] hwmon: (amc6821) Convert to use regmap
Date: Fri, 28 Jun 2024 08:13:45 -0700
Message-Id: <20240628151346.1152838-10-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628151346.1152838-1-linux@roeck-us.net>
References: <20240628151346.1152838-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use regmap for register accesses and for most caching.

While at it, use sysfs_emit() instead of sprintf() to write sysfs
attribute data.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/amc6821.c | 711 +++++++++++++++++++---------------------
 1 file changed, 330 insertions(+), 381 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index ebffc9393c3d..6ffab4288134 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -14,9 +14,9 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
-#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 /*
@@ -44,6 +44,7 @@ module_param(init, int, 0444);
 #define AMC6821_REG_CONF4		0x04
 #define AMC6821_REG_STAT1		0x02
 #define AMC6821_REG_STAT2		0x03
+#define AMC6821_REG_TEMP_LO		0x06
 #define AMC6821_REG_TDATA_LOW		0x08
 #define AMC6821_REG_TDATA_HI		0x09
 #define AMC6821_REG_LTEMP_HI		0x0A
@@ -61,11 +62,8 @@ module_param(init, int, 0444);
 #define AMC6821_REG_DCY_LOW_TEMP	0x21
 
 #define AMC6821_REG_TACH_LLIMITL	0x10
-#define AMC6821_REG_TACH_LLIMITH	0x11
 #define AMC6821_REG_TACH_HLIMITL	0x12
-#define AMC6821_REG_TACH_HLIMITH	0x13
 #define AMC6821_REG_TACH_SETTINGL	0x1e
-#define AMC6821_REG_TACH_SETTINGH	0x1f
 
 #define AMC6821_CONF1_START		BIT(0)
 #define AMC6821_CONF1_FAN_INT_EN	BIT(1)
@@ -73,7 +71,7 @@ module_param(init, int, 0444);
 #define AMC6821_CONF1_PWMINV		BIT(3)
 #define AMC6821_CONF1_FAN_FAULT_EN	BIT(4)
 #define AMC6821_CONF1_FDRC0		BIT(5)
-#define AMC6821_CONF1_FDRC1		BIT(7)
+#define AMC6821_CONF1_FDRC1		BIT(6)
 #define AMC6821_CONF1_THERMOVIE		BIT(7)
 
 #define AMC6821_CONF2_PWM_EN		BIT(0)
@@ -130,224 +128,170 @@ static const u8 fan_reg_low[] = {AMC6821_REG_TDATA_LOW,
 			AMC6821_REG_TACH_HLIMITL,
 			AMC6821_REG_TACH_SETTINGL, };
 
-static const u8 fan_reg_hi[] = {AMC6821_REG_TDATA_HI,
-			AMC6821_REG_TACH_LLIMITH,
-			AMC6821_REG_TACH_HLIMITH,
-			AMC6821_REG_TACH_SETTINGH, };
-
 /*
  * Client data (each client gets its own)
  */
 
 struct amc6821_data {
-	struct i2c_client *client;
+	struct regmap *regmap;
 	struct mutex update_lock;
-	bool valid; /* false until following fields are valid */
-	unsigned long last_updated; /* in jiffies */
 
-	/* register values */
-	int temp[TEMP_IDX_LEN];
-
-	u16 fan[FAN1_IDX_LEN];
-	u8 fan1_pulses;
-
-	u8 pwm1;
 	u8 temp1_auto_point_temp[3];
 	u8 temp2_auto_point_temp[3];
-	u8 pwm1_auto_point_pwm[3];
-	u8 pwm1_enable;
-	u8 pwm1_auto_channels_temp;
-
-	u8 stat1;
-	u8 stat2;
 };
 
-static struct amc6821_data *amc6821_update_device(struct device *dev)
+static int amc6821_init_auto_point_data(struct amc6821_data *data)
 {
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-	int timeout = HZ;
-	u8 reg;
-	int i;
+	struct regmap *regmap = data->regmap;
+	u32 pwm, regval;
+	int err;
 
-	mutex_lock(&data->update_lock);
+	err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);
+	if (err)
+		return err;
 
-	if (time_after(jiffies, data->last_updated + timeout) ||
-			!data->valid) {
+	err = regmap_read(regmap, AMC6821_REG_PSV_TEMP, &regval);
+	if (err)
+		return err;
+	data->temp1_auto_point_temp[0] = regval;
+	data->temp2_auto_point_temp[0] = data->temp1_auto_point_temp[0];
 
-		for (i = 0; i < TEMP_IDX_LEN; i++)
-			data->temp[i] = (int8_t)i2c_smbus_read_byte_data(
-				client, temp_reg[i]);
+	err = regmap_read(regmap, AMC6821_REG_LTEMP_FAN_CTRL, &regval);
+	if (err)
+		return err;
+	data->temp1_auto_point_temp[1] = (regval & 0xF8) >> 1;
 
-		data->stat1 = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_STAT1);
-		data->stat2 = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_STAT2);
+	regval &= 0x07;
+	regval = 0x20 >> regval;
+	if (regval)
+		data->temp1_auto_point_temp[2] =
+			data->temp1_auto_point_temp[1] +
+			(255 - pwm) / regval;
+	else
+		data->temp1_auto_point_temp[2] = 255;
 
-		data->pwm1 = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_DCY);
-		for (i = 0; i < FAN1_IDX_LEN; i++) {
-			data->fan[i] = i2c_smbus_read_byte_data(
-					client,
-					fan_reg_low[i]);
-			data->fan[i] += i2c_smbus_read_byte_data(
-					client,
-					fan_reg_hi[i]) << 8;
-		}
-		data->fan1_pulses = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_CONF4);
-		data->fan1_pulses = data->fan1_pulses & AMC6821_CONF4_PSPR ? 4 : 2;
+	err = regmap_read(regmap, AMC6821_REG_RTEMP_FAN_CTRL, &regval);
+	if (err)
+		return err;
 
-		data->pwm1_auto_point_pwm[0] = 0;
-		data->pwm1_auto_point_pwm[2] = 255;
-		data->pwm1_auto_point_pwm[1] = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_DCY_LOW_TEMP);
+	data->temp2_auto_point_temp[1] = (regval & 0xF8) >> 1;
+	regval &= 0x07;
+	regval = 0x20 >> regval;
 
-		data->temp1_auto_point_temp[0] =
-			i2c_smbus_read_byte_data(client,
-					AMC6821_REG_PSV_TEMP);
-		data->temp2_auto_point_temp[0] =
-				data->temp1_auto_point_temp[0];
-		reg = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_LTEMP_FAN_CTRL);
-		data->temp1_auto_point_temp[1] = (reg & 0xF8) >> 1;
-		reg &= 0x07;
-		reg = 0x20 >> reg;
-		if (reg > 0)
-			data->temp1_auto_point_temp[2] =
-				data->temp1_auto_point_temp[1] +
-				(data->pwm1_auto_point_pwm[2] -
-				data->pwm1_auto_point_pwm[1]) / reg;
-		else
-			data->temp1_auto_point_temp[2] = 255;
+	if (regval)
+		data->temp2_auto_point_temp[2] =
+			data->temp2_auto_point_temp[1] +
+			(255 - pwm) / regval;
+	else
+		data->temp2_auto_point_temp[2] = 255;
 
-		reg = i2c_smbus_read_byte_data(client,
-			AMC6821_REG_RTEMP_FAN_CTRL);
-		data->temp2_auto_point_temp[1] = (reg & 0xF8) >> 1;
-		reg &= 0x07;
-		reg = 0x20 >> reg;
-		if (reg > 0)
-			data->temp2_auto_point_temp[2] =
-				data->temp2_auto_point_temp[1] +
-				(data->pwm1_auto_point_pwm[2] -
-				data->pwm1_auto_point_pwm[1]) / reg;
-		else
-			data->temp2_auto_point_temp[2] = 255;
-
-		reg = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
-		reg = (reg >> 5) & 0x3;
-		switch (reg) {
-		case 0: /*open loop: software sets pwm1*/
-			data->pwm1_auto_channels_temp = 0;
-			data->pwm1_enable = 1;
-			break;
-		case 2: /*closed loop: remote T (temp2)*/
-			data->pwm1_auto_channels_temp = 2;
-			data->pwm1_enable = 2;
-			break;
-		case 3: /*closed loop: local and remote T (temp2)*/
-			data->pwm1_auto_channels_temp = 3;
-			data->pwm1_enable = 3;
-			break;
-		case 1: /*
-			 * semi-open loop: software sets rpm, chip controls
-			 * pwm1
-			 */
-			data->pwm1_auto_channels_temp = 0;
-			data->pwm1_enable = 4;
-			break;
-		}
-
-		data->last_updated = jiffies;
-		data->valid = true;
-	}
-	mutex_unlock(&data->update_lock);
-	return data;
+	return 0;
 }
 
 static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
-	struct amc6821_data *data = amc6821_update_device(dev);
+	struct amc6821_data *data = dev_get_drvdata(dev);
 	int ix = to_sensor_dev_attr(devattr)->index;
+	u32 regval;
+	int err;
 
-	return sprintf(buf, "%d\n", data->temp[ix] * 1000);
+	err = regmap_read(data->regmap, temp_reg[ix], &regval);
+	if (err)
+		return err;
+
+	return sysfs_emit(buf, "%d\n", (int8_t)regval * 1000);
 }
 
 static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
 			  const char *buf, size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	int ix = to_sensor_dev_attr(attr)->index;
 	long val;
+	int err;
 
 	int ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 	val = clamp_val(val / 1000, -128, 127);
 
-	mutex_lock(&data->update_lock);
-	data->temp[ix] = val;
-	if (i2c_smbus_write_byte_data(client, temp_reg[ix], data->temp[ix])) {
-		dev_err(&client->dev, "Register write error, aborting.\n");
-		count = -EIO;
-	}
-	mutex_unlock(&data->update_lock);
+	err = regmap_write(data->regmap, temp_reg[ix], val);
+	if (err)
+		return err;
+
 	return count;
 }
 
 static ssize_t temp_alarm_show(struct device *dev,
 			       struct device_attribute *devattr, char *buf)
 {
-	struct amc6821_data *data = amc6821_update_device(dev);
+	struct amc6821_data *data = dev_get_drvdata(dev);
 	int ix = to_sensor_dev_attr(devattr)->index;
-	u8 flag;
+	u32 regval, mask, reg;
+	int err;
 
 	switch (ix) {
 	case IDX_TEMP1_MIN:
-		flag = data->stat1 & AMC6821_STAT1_LTL;
+		reg = AMC6821_REG_STAT1;
+		mask = AMC6821_STAT1_LTL;
 		break;
 	case IDX_TEMP1_MAX:
-		flag = data->stat1 & AMC6821_STAT1_LTH;
+		reg = AMC6821_REG_STAT1;
+		mask = AMC6821_STAT1_LTH;
 		break;
 	case IDX_TEMP1_CRIT:
-		flag = data->stat2 & AMC6821_STAT2_LTC;
+		reg = AMC6821_REG_STAT2;
+		mask = AMC6821_STAT2_LTC;
 		break;
 	case IDX_TEMP2_MIN:
-		flag = data->stat1 & AMC6821_STAT1_RTL;
+		reg = AMC6821_REG_STAT1;
+		mask = AMC6821_STAT1_RTL;
 		break;
 	case IDX_TEMP2_MAX:
-		flag = data->stat1 & AMC6821_STAT1_RTH;
+		reg = AMC6821_REG_STAT1;
+		mask = AMC6821_STAT1_RTH;
 		break;
 	case IDX_TEMP2_CRIT:
-		flag = data->stat2 & AMC6821_STAT2_RTC;
+		reg = AMC6821_REG_STAT2;
+		mask = AMC6821_STAT2_RTC;
 		break;
 	default:
 		dev_dbg(dev, "Unknown attr->index (%d).\n", ix);
 		return -EINVAL;
 	}
-	if (flag)
-		return sprintf(buf, "1");
-	else
-		return sprintf(buf, "0");
+	err = regmap_read(data->regmap, reg, &regval);
+	if (err)
+		return err;
+	return sysfs_emit(buf, "%d\n", !!(regval & mask));
 }
 
 static ssize_t temp2_fault_show(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
-	struct amc6821_data *data = amc6821_update_device(dev);
-	if (data->stat1 & AMC6821_STAT1_RTF)
-		return sprintf(buf, "1");
-	else
-		return sprintf(buf, "0");
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	u32 regval;
+	int err;
+
+	err = regmap_read(data->regmap, AMC6821_REG_STAT1, &regval);
+	if (err)
+		return err;
+
+	return sysfs_emit(buf, "%d\n", !!(regval & AMC6821_STAT1_RTF));
 }
 
 static ssize_t pwm1_show(struct device *dev, struct device_attribute *devattr,
 			 char *buf)
 {
-	struct amc6821_data *data = amc6821_update_device(dev);
-	return sprintf(buf, "%d\n", data->pwm1);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	u32 regval;
+	int err;
+
+	err = regmap_read(data->regmap, AMC6821_REG_DCY, &regval);
+	if (err)
+		return err;
+
+	return sysfs_emit(buf, "%d\n", regval);
 }
 
 static ssize_t pwm1_store(struct device *dev,
@@ -355,7 +299,6 @@ static ssize_t pwm1_store(struct device *dev,
 			  size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long val;
 	int ret = kstrtol(buf, 10, &val);
 	if (ret)
@@ -364,18 +307,38 @@ static ssize_t pwm1_store(struct device *dev,
 	if (val < 0 || val > 255)
 		return -EINVAL;
 
-	mutex_lock(&data->update_lock);
-	data->pwm1 = val;
-	i2c_smbus_write_byte_data(client, AMC6821_REG_DCY, data->pwm1);
-	mutex_unlock(&data->update_lock);
+	ret = regmap_write(data->regmap, AMC6821_REG_DCY, val);
+	if (ret)
+		return ret;
+
 	return count;
 }
 
 static ssize_t pwm1_enable_show(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
-	struct amc6821_data *data = amc6821_update_device(dev);
-	return sprintf(buf, "%d\n", data->pwm1_enable);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	int err;
+	u32 val;
+
+	err = regmap_read(data->regmap, AMC6821_REG_CONF1, &val);
+	if (err)
+		return err;
+	switch (val & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
+	case 0:
+		val = 1;	/* manual */
+		break;
+	case AMC6821_CONF1_FDRC0:
+		val = 4;	/* target rpm (fan1_target) controlled */
+		break;
+	case AMC6821_CONF1_FDRC1:
+		val = 2;	/* remote temp controlled */
+		break;
+	default:
+		val = 3;	/* max(local, remote) temp controlled */
+		break;
+	}
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t pwm1_enable_store(struct device *dev,
@@ -383,49 +346,37 @@ static ssize_t pwm1_enable_store(struct device *dev,
 				 const char *buf, size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long val;
-	int config = kstrtol(buf, 10, &val);
-	if (config)
-		return config;
+	u32 mask;
+	int err;
 
-	mutex_lock(&data->update_lock);
-	config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
-	if (config < 0) {
-			dev_err(&client->dev,
-			"Error reading configuration register, aborting.\n");
-			count = config;
-			goto unlock;
-	}
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
 
 	switch (val) {
 	case 1:
-		config &= ~AMC6821_CONF1_FDRC0;
-		config &= ~AMC6821_CONF1_FDRC1;
+		mask = 0;
 		break;
 	case 2:
-		config &= ~AMC6821_CONF1_FDRC0;
-		config |= AMC6821_CONF1_FDRC1;
+		mask = AMC6821_CONF1_FDRC1;
 		break;
 	case 3:
-		config |= AMC6821_CONF1_FDRC0;
-		config |= AMC6821_CONF1_FDRC1;
+		mask = AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1;
 		break;
 	case 4:
-		config |= AMC6821_CONF1_FDRC0;
-		config &= ~AMC6821_CONF1_FDRC1;
+		mask = AMC6821_CONF1_FDRC0;
 		break;
 	default:
-		count = -EINVAL;
-		goto unlock;
+		return -EINVAL;
 	}
-	if (i2c_smbus_write_byte_data(client, AMC6821_REG_CONF1, config)) {
-			dev_err(&client->dev,
-			"Configuration register write error, aborting.\n");
-			count = -EIO;
-	}
-unlock:
-	mutex_unlock(&data->update_lock);
+
+	err = regmap_update_bits(data->regmap, AMC6821_REG_CONF1,
+				 AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
+				 mask);
+	if (err < 0)
+		return err;
+
 	return count;
 }
 
@@ -433,8 +384,27 @@ static ssize_t pwm1_auto_channels_temp_show(struct device *dev,
 					    struct device_attribute *devattr,
 					    char *buf)
 {
-	struct amc6821_data *data = amc6821_update_device(dev);
-	return sprintf(buf, "%d\n", data->pwm1_auto_channels_temp);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	u32 val;
+	int err;
+
+	err = regmap_read(data->regmap, AMC6821_REG_CONF1, &val);
+	if (err)
+		return err;
+	switch (val & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
+	case 0:
+	case AMC6821_CONF1_FDRC0:
+		val = 0;	/* manual or target rpm controlled */
+		break;
+	case AMC6821_CONF1_FDRC1:
+		val = 2;	/* remote temp controlled */
+		break;
+	default:
+		val = 3;	/* max(local, remote) temp controlled */
+		break;
+	}
+
+	return sprintf(buf, "%d\n", val);
 }
 
 static ssize_t temp_auto_point_temp_show(struct device *dev,
@@ -443,7 +413,8 @@ static ssize_t temp_auto_point_temp_show(struct device *dev,
 {
 	int ix = to_sensor_dev_attr_2(devattr)->index;
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
-	struct amc6821_data *data = amc6821_update_device(dev);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+
 	switch (nr) {
 	case 1:
 		return sprintf(buf, "%d\n",
@@ -461,44 +432,59 @@ static ssize_t pwm1_auto_point_pwm_show(struct device *dev,
 					struct device_attribute *devattr,
 					char *buf)
 {
+	struct amc6821_data *data = dev_get_drvdata(dev);
 	int ix = to_sensor_dev_attr(devattr)->index;
-	struct amc6821_data *data = amc6821_update_device(dev);
-	return sprintf(buf, "%d\n", data->pwm1_auto_point_pwm[ix]);
+	u32 val;
+	int err;
+
+	switch (ix) {
+	case 0:
+		val = 0;
+		break;
+	case 1:
+		err = regmap_read(data->regmap, AMC6821_REG_DCY_LOW_TEMP, &val);
+		if (err)
+			return err;
+		break;
+	default:
+		val = 255;
+		break;
+	}
+	return sysfs_emit(buf, "%d\n", val);
 }
 
-static inline ssize_t set_slope_register(struct i2c_client *client,
-		u8 reg,
-		u8 dpwm,
-		u8 *ptemp)
+static inline int set_slope_register(struct regmap *regmap,
+				     u8 reg, u8 *ptemp)
 {
-	int dt;
-	u8 tmp;
+	u8 tmp, dpwm;
+	int err, dt;
+	u32 pwm;
 
-	dt = ptemp[2]-ptemp[1];
+	err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);
+	if (err)
+		return err;
+
+	dpwm = 255 - pwm;
+
+	dt = ptemp[2] - ptemp[1];
 	for (tmp = 4; tmp > 0; tmp--) {
 		if (dt * (0x20 >> tmp) >= dpwm)
 			break;
 	}
 	tmp |= (ptemp[1] & 0x7C) << 1;
-	if (i2c_smbus_write_byte_data(client,
-			reg, tmp)) {
-		dev_err(&client->dev, "Register write error, aborting.\n");
-		return -EIO;
-	}
-	return 0;
+	return regmap_write(regmap, reg, tmp);
 }
 
 static ssize_t temp_auto_point_temp_store(struct device *dev,
 					  struct device_attribute *attr,
 					  const char *buf, size_t count)
 {
-	struct amc6821_data *data = amc6821_update_device(dev);
-	struct i2c_client *client = data->client;
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
 	int ix = to_sensor_dev_attr_2(attr)->index;
 	int nr = to_sensor_dev_attr_2(attr)->nr;
 	u8 *ptemp;
 	u8 reg;
-	int dpwm;
 	long val;
 	int ret = kstrtol(buf, 10, &val);
 	if (ret)
@@ -519,7 +505,6 @@ static ssize_t temp_auto_point_temp_store(struct device *dev,
 	}
 
 	mutex_lock(&data->update_lock);
-	data->valid = false;
 
 	switch (ix) {
 	case 0:
@@ -528,13 +513,9 @@ static ssize_t temp_auto_point_temp_store(struct device *dev,
 		ptemp[0] = clamp_val(ptemp[0], 0,
 				     data->temp2_auto_point_temp[1]);
 		ptemp[0] = clamp_val(ptemp[0], 0, 63);
-		if (i2c_smbus_write_byte_data(
-					client,
-					AMC6821_REG_PSV_TEMP,
-					ptemp[0])) {
-				dev_err(&client->dev,
-					"Register write error, aborting.\n");
-				count = -EIO;
+		if (regmap_write(regmap, AMC6821_REG_PSV_TEMP, ptemp[0])) {
+			dev_err(dev, "Register write error, aborting.\n");
+			count = -EIO;
 		}
 		goto EXIT;
 	case 1:
@@ -550,8 +531,7 @@ static ssize_t temp_auto_point_temp_store(struct device *dev,
 		count = -EINVAL;
 		goto EXIT;
 	}
-	dpwm = data->pwm1_auto_point_pwm[2] - data->pwm1_auto_point_pwm[1];
-	if (set_slope_register(client, reg, dpwm, ptemp))
+	if (set_slope_register(regmap, reg, ptemp))
 		count = -EIO;
 
 EXIT:
@@ -564,38 +544,37 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
 					 const char *buf, size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-	int dpwm;
-	unsigned long val;
-	int ret = kstrtoul(buf, 10, &val);
+	struct regmap *regmap = data->regmap;
+	long val;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return ret;
 
-	if (val > 255)
+	if (val > 254)
 		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
-	data->pwm1_auto_point_pwm[1] = val;
-	if (i2c_smbus_write_byte_data(client, AMC6821_REG_DCY_LOW_TEMP,
-			data->pwm1_auto_point_pwm[1])) {
-		dev_err(&client->dev, "Register write error, aborting.\n");
-		count = -EIO;
-		goto EXIT;
+
+	ret = regmap_write(regmap, AMC6821_REG_DCY_LOW_TEMP, val);
+	if (ret)
+		goto unlock;
+
+	ret = set_slope_register(regmap, AMC6821_REG_LTEMP_FAN_CTRL,
+				 data->temp1_auto_point_temp);
+	if (ret) {
+		count = ret;
+		goto unlock;
 	}
-	dpwm = data->pwm1_auto_point_pwm[2] - data->pwm1_auto_point_pwm[1];
-	if (set_slope_register(client, AMC6821_REG_LTEMP_FAN_CTRL, dpwm,
-			data->temp1_auto_point_temp)) {
-		count = -EIO;
-		goto EXIT;
-	}
-	if (set_slope_register(client, AMC6821_REG_RTEMP_FAN_CTRL, dpwm,
-			data->temp2_auto_point_temp)) {
-		count = -EIO;
-		goto EXIT;
+	ret = set_slope_register(regmap, AMC6821_REG_RTEMP_FAN_CTRL,
+				 data->temp2_auto_point_temp);
+	if (ret) {
+		count = ret;
+		goto unlock;
 	}
 
-EXIT:
-	data->valid = false;
+unlock:
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -603,58 +582,72 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
 static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
 			char *buf)
 {
-	struct amc6821_data *data = amc6821_update_device(dev);
+	struct amc6821_data *data = dev_get_drvdata(dev);
 	int ix = to_sensor_dev_attr(devattr)->index;
-	if (0 == data->fan[ix])
-		return sprintf(buf, "6000000");
-	return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
+	u32 regval;
+	u8 regs[2];
+	int err;
+
+	err = regmap_bulk_read(data->regmap, fan_reg_low[ix], regs, 2);
+	if (err)
+		return err;
+	regval = (regs[1] << 8) | regs[0];
+
+	return sysfs_emit(buf, "%d\n", 6000000 / (regval ? : 1));
 }
 
 static ssize_t fan1_fault_show(struct device *dev,
 			       struct device_attribute *devattr, char *buf)
 {
-	struct amc6821_data *data = amc6821_update_device(dev);
-	if (data->stat1 & AMC6821_STAT1_FANS)
-		return sprintf(buf, "1");
-	else
-		return sprintf(buf, "0");
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	u32 regval;
+	int err;
+
+	err = regmap_read(data->regmap, AMC6821_REG_STAT1, &regval);
+	if (err)
+		return err;
+
+	return sysfs_emit(buf, "%d\n", !!(regval & AMC6821_STAT1_FANS));
 }
 
 static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
 			 const char *buf, size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
-	long val;
 	int ix = to_sensor_dev_attr(attr)->index;
-	int ret = kstrtol(buf, 10, &val);
-	if (ret)
-		return ret;
-	val = val < 1 ? 0xFFFF : 6000000 / val;
+	u8 regs[2];
+	long val;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
+	val = val < 1 ? 0xFFFF : 6000000 / val;
+	val = clamp_val(val, 0, 0xFFFF);
+
+	regs[0] = val & 0xff;
+	regs[1] = val >> 8;
+
+	err = regmap_bulk_write(data->regmap, fan_reg_low[ix], regs, 2);
+	if (err)
+		return err;
 
-	mutex_lock(&data->update_lock);
-	data->fan[ix] = (u16)clamp_val(val, 0, 0xFFFF);
-	if (i2c_smbus_write_byte_data(client, fan_reg_low[ix],
-			data->fan[ix] & 0xFF)) {
-		dev_err(&client->dev, "Register write error, aborting.\n");
-		count = -EIO;
-		goto EXIT;
-	}
-	if (i2c_smbus_write_byte_data(client,
-			fan_reg_hi[ix], data->fan[ix] >> 8)) {
-		dev_err(&client->dev, "Register write error, aborting.\n");
-		count = -EIO;
-	}
-EXIT:
-	mutex_unlock(&data->update_lock);
 	return count;
 }
 
 static ssize_t fan1_pulses_show(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
-	struct amc6821_data *data = amc6821_update_device(dev);
-	return sprintf(buf, "%d\n", data->fan1_pulses);
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	u32 regval;
+	int err;
+
+	err = regmap_read(data->regmap, AMC6821_REG_CONF4, &regval);
+	if (err)
+		return err;
+
+	return sysfs_emit(buf, "%d\n", (regval & AMC6821_CONF4_PSPR) ? 4 : 2);
 }
 
 static ssize_t fan1_pulses_store(struct device *dev,
@@ -662,40 +655,22 @@ static ssize_t fan1_pulses_store(struct device *dev,
 				 size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
-	struct i2c_client *client = data->client;
 	long val;
-	int config = kstrtol(buf, 10, &val);
-	if (config)
-		return config;
+	int err;
+
+	err = kstrtol(buf, 10, &val);
+	if (err)
+		return err;
+
+	if (val != 2 && val != 4)
+		return -EINVAL;
+
+	err = regmap_update_bits(data->regmap, AMC6821_REG_CONF4,
+				 AMC6821_CONF4_PSPR,
+				 val == 4 ? AMC6821_CONF4_PSPR : 0);
+	if (err)
+		return err;
 
-	mutex_lock(&data->update_lock);
-	config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF4);
-	if (config < 0) {
-		dev_err(&client->dev,
-			"Error reading configuration register, aborting.\n");
-		count = config;
-		goto EXIT;
-	}
-	switch (val) {
-	case 2:
-		config &= ~AMC6821_CONF4_PSPR;
-		data->fan1_pulses = 2;
-		break;
-	case 4:
-		config |= AMC6821_CONF4_PSPR;
-		data->fan1_pulses = 4;
-		break;
-	default:
-		count = -EINVAL;
-		goto EXIT;
-	}
-	if (i2c_smbus_write_byte_data(client, AMC6821_REG_CONF4, config)) {
-		dev_err(&client->dev,
-			"Configuration register write error, aborting.\n");
-		count = -EIO;
-	}
-EXIT:
-	mutex_unlock(&data->update_lock);
 	return count;
 }
 
@@ -827,110 +802,84 @@ static int amc6821_detect(
 	return 0;
 }
 
-static int amc6821_init_client(struct i2c_client *client)
+static int amc6821_init_client(struct amc6821_data *data)
 {
-	int config;
-	int err = -EIO;
+	struct regmap *regmap = data->regmap;
+	int err;
+
+	err = amc6821_init_auto_point_data(data);
+	if (err)
+		return err;
 
 	if (init) {
-		config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF4);
-
-		if (config < 0) {
-				dev_err(&client->dev,
-			"Error reading configuration register, aborting.\n");
-				return err;
-		}
-
-		config |= AMC6821_CONF4_MODE;
-
-		if (i2c_smbus_write_byte_data(client, AMC6821_REG_CONF4,
-				config)) {
-			dev_err(&client->dev,
-			"Configuration register write error, aborting.\n");
+		err = regmap_set_bits(regmap, AMC6821_REG_CONF4, AMC6821_CONF4_MODE);
+		if (err)
 			return err;
-		}
-
-		config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF3);
-
-		if (config < 0) {
-			dev_err(&client->dev,
-			"Error reading configuration register, aborting.\n");
+		err = regmap_clear_bits(regmap, AMC6821_REG_CONF3, AMC6821_CONF3_THERM_FAN_EN);
+		if (err)
 			return err;
-		}
-
-		dev_info(&client->dev, "Revision %d\n", config & 0x0f);
-
-		config &= ~AMC6821_CONF3_THERM_FAN_EN;
-
-		if (i2c_smbus_write_byte_data(client, AMC6821_REG_CONF3,
-				config)) {
-			dev_err(&client->dev,
-			"Configuration register write error, aborting.\n");
+		err = regmap_clear_bits(regmap, AMC6821_REG_CONF2,
+					AMC6821_CONF2_RTFIE |
+					AMC6821_CONF2_LTOIE |
+					AMC6821_CONF2_RTOIE);
+		if (err)
 			return err;
-		}
 
-		config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF2);
-
-		if (config < 0) {
-			dev_err(&client->dev,
-			"Error reading configuration register, aborting.\n");
+		err = regmap_update_bits(regmap, AMC6821_REG_CONF1,
+					 AMC6821_CONF1_THERMOVIE | AMC6821_CONF1_FANIE |
+					 AMC6821_CONF1_START | AMC6821_CONF1_PWMINV,
+					 AMC6821_CONF1_START |
+					 (pwminv ? AMC6821_CONF1_PWMINV : 0));
+		if (err)
 			return err;
-		}
-
-		config &= ~AMC6821_CONF2_RTFIE;
-		config &= ~AMC6821_CONF2_LTOIE;
-		config &= ~AMC6821_CONF2_RTOIE;
-		if (i2c_smbus_write_byte_data(client,
-				AMC6821_REG_CONF2, config)) {
-			dev_err(&client->dev,
-			"Configuration register write error, aborting.\n");
-			return err;
-		}
-
-		config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
-
-		if (config < 0) {
-			dev_err(&client->dev,
-			"Error reading configuration register, aborting.\n");
-			return err;
-		}
-
-		config &= ~AMC6821_CONF1_THERMOVIE;
-		config &= ~AMC6821_CONF1_FANIE;
-		config |= AMC6821_CONF1_START;
-		if (pwminv)
-			config |= AMC6821_CONF1_PWMINV;
-		else
-			config &= ~AMC6821_CONF1_PWMINV;
-
-		if (i2c_smbus_write_byte_data(
-				client, AMC6821_REG_CONF1, config)) {
-			dev_err(&client->dev,
-			"Configuration register write error, aborting.\n");
-			return err;
-		}
 	}
 	return 0;
 }
 
+static bool amc6821_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case AMC6821_REG_STAT1:
+	case AMC6821_REG_STAT2:
+	case AMC6821_REG_TEMP_LO:
+	case AMC6821_REG_TDATA_LOW:
+	case AMC6821_REG_LTEMP_HI:
+	case AMC6821_REG_RTEMP_HI:
+	case AMC6821_REG_TDATA_HI:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config amc6821_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AMC6821_REG_CONF3,
+	.volatile_reg = amc6821_volatile_reg,
+	.cache_type = REGCACHE_MAPLE,
+};
+
 static int amc6821_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct amc6821_data *data;
 	struct device *hwmon_dev;
+	struct regmap *regmap;
 	int err;
 
 	data = devm_kzalloc(dev, sizeof(struct amc6821_data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-	data->client = client;
-	mutex_init(&data->update_lock);
 
-	/*
-	 * Initialize the amc6821 chip
-	 */
-	err = amc6821_init_client(client);
+	regmap = devm_regmap_init_i2c(client, &amc6821_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to initialize regmap\n");
+	data->regmap = regmap;
+
+	err = amc6821_init_client(data);
 	if (err)
 		return err;
 
-- 
2.39.2


