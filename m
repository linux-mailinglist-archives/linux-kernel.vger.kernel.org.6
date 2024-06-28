Return-Path: <linux-kernel+bounces-234108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08091C24C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818B41C21975
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25981CCCD4;
	Fri, 28 Jun 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECnG0EI5"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC01CCCA2;
	Fri, 28 Jun 2024 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587653; cv=none; b=LKwdkftVwebeEnJOqgicVF4ZVIE+PUeNne8YensH0oPuVYgwDScjkt6sOyH9b0yboTTf5DNLTpKd466mDimzokRs3T/fEOsiZpF1pdxvHaDe6W2kLtasUirV2jr3cxO0PKm3pWzl7Xj8aY9M/6DPn3144e9ai2DMW+yVPODJ9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587653; c=relaxed/simple;
	bh=67+pPDB9hrjsu57CEbG1fh7bqOdYqEOcVAFhIvSxE9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bqb9gSGUuJbj4L0Mt3Zo3TGaaFs8mof4vBtPojYN68RNFWOI+WmHW24k6yeRx23tw4ejbsAEYdGYt5quJEps5r3HlXhWyLkth8vbRgbZL7WrY+HtyIwhHS9O5lMcZnNlernhbn5VzPI3oX5A5KcrlIFV+GkmCjVCskjevojNbK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECnG0EI5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7163489149eso532392a12.1;
        Fri, 28 Jun 2024 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587650; x=1720192450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lW6Pd9Wzwjx1lXXTnOZIchp2EV9ymFzV8ODIWR95e3Y=;
        b=ECnG0EI5sHm3BsNSZwi6ENSBZCdiGMsnRgiytNSaNGmvVp1WsHdpbs8oO+IDTDHr5N
         nhQVVZ1m3iKe2OxZ0TrLDNSZ18zZ/pFJYlvVqMH5+lmN9u7dDyIvQsJe55lDQ6BOVieV
         vUvGfXsLp1ODY6Le9jWHDocHt1k7CgnfHcM3bItu3vShen5/I3WsY61rKHkZqkIx+6eh
         fJ7cQV+ijll8t27Fwk00fGcLi3LheE+9SaGJNOvR2jNVMPAizJAKveHNJVNB63BTYp4O
         G3QIcDEDIAlgUSslRG1p/IShOqoxJBhHxUo3BSEK2ICrnShfdiX4G8yo7G6xR28ACuvR
         rThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587650; x=1720192450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lW6Pd9Wzwjx1lXXTnOZIchp2EV9ymFzV8ODIWR95e3Y=;
        b=peAwGL/wWey24IQli9aUrHb+KDjdE0Wj6HVC7YgDh4ZqJqAk0hG9LR1C2pPUS5tWK4
         ktelJGcSgrN1iXQxu49EomHiUf0Wis27lI9I3UOjbJ+D4Js/jTlZEarXDpVk7jS7Lpcm
         i/kYlhRPBALD7Hx1NSCNkFSCyv4zgVhuPKsksxy5pltYHUURCUKUuy22wQlK7jYidfII
         DQTlmMmqp9I70vgsQLzwcPNNPaLB/QhzQbNvOKk674Et3XLAyY89woroiWD645/7T5uM
         RhL2iIbJeyky4mqFdvWr92pQpQ+J8XKcFut+oKZfXugh7Uez7e0Dj/IcnYmezy6CST+Y
         VEKg==
X-Gm-Message-State: AOJu0Yya+n8VkhdAIvQaNKcCcURUc4isfsdV5+9Xn2Ec5p+EsaGm2eBG
	8mvzE+HU2hdTNWjGudQUdp/lLMwDv0Gg7LSQ9eW4KUF1MTgJ4LKf5EoffQ==
X-Google-Smtp-Source: AGHT+IFbFmi/iAMTicJOL2GrOzNLzoQyBgRiskZ/2xLxTlRNgYuIo4NFdDiMjqS4re3zd2jdM6HvsQ==
X-Received: by 2002:a05:6a21:3289:b0:1be:cea5:c781 with SMTP id adf61e73a8af0-1becea5cfb2mr6759745637.16.1719587649527;
        Fri, 28 Jun 2024 08:14:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708043b76a5sm1768887b3a.149.2024.06.28.08.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:14:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 10/10] hwmon: (amc6821) Convert to with_info API
Date: Fri, 28 Jun 2024 08:13:46 -0700
Message-Id: <20240628151346.1152838-11-linux@roeck-us.net>
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

Convert to use with_info API to simplify the code and make it easier
to maintain. This also reduces code size by approximately 20%.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/amc6821.c | 743 +++++++++++++++++++++-------------------
 1 file changed, 386 insertions(+), 357 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 6ffab4288134..14d59aa4254b 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -6,6 +6,9 @@
  *
  * Based on max6650.c:
  * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
+ *
+ * Conversion to regmap and with_info API:
+ * Copyright (C) 2024 Guenter Roeck <linux@roeck-us.net>
  */
 
 #include <linux/bits.h>
@@ -106,28 +109,6 @@ module_param(init, int, 0444);
 #define AMC6821_STAT2_L_THERM		BIT(6)
 #define AMC6821_STAT2_THERM_IN		BIT(7)
 
-enum {IDX_TEMP1_INPUT = 0, IDX_TEMP1_MIN, IDX_TEMP1_MAX,
-	IDX_TEMP1_CRIT, IDX_TEMP2_INPUT, IDX_TEMP2_MIN,
-	IDX_TEMP2_MAX, IDX_TEMP2_CRIT,
-	TEMP_IDX_LEN, };
-
-static const u8 temp_reg[] = {AMC6821_REG_LTEMP_HI,
-			AMC6821_REG_LTEMP_LIMIT_MIN,
-			AMC6821_REG_LTEMP_LIMIT_MAX,
-			AMC6821_REG_LTEMP_CRIT,
-			AMC6821_REG_RTEMP_HI,
-			AMC6821_REG_RTEMP_LIMIT_MIN,
-			AMC6821_REG_RTEMP_LIMIT_MAX,
-			AMC6821_REG_RTEMP_CRIT, };
-
-enum {IDX_FAN1_INPUT = 0, IDX_FAN1_MIN, IDX_FAN1_MAX, IDX_FAN1_TARGET,
-	FAN1_IDX_LEN, };
-
-static const u8 fan_reg_low[] = {AMC6821_REG_TDATA_LOW,
-			AMC6821_REG_TACH_LLIMITL,
-			AMC6821_REG_TACH_HLIMITL,
-			AMC6821_REG_TACH_SETTINGL, };
-
 /*
  * Client data (each client gets its own)
  */
@@ -188,232 +169,323 @@ static int amc6821_init_auto_point_data(struct amc6821_data *data)
 	return 0;
 }
 
-static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
-			 char *buf)
+static int amc6821_temp_read_values(struct regmap *regmap, u32 attr, int channel, long *val)
 {
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	int ix = to_sensor_dev_attr(devattr)->index;
+	int reg, err;
 	u32 regval;
-	int err;
 
-	err = regmap_read(data->regmap, temp_reg[ix], &regval);
-	if (err)
-		return err;
-
-	return sysfs_emit(buf, "%d\n", (int8_t)regval * 1000);
-}
-
-static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t count)
-{
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	int ix = to_sensor_dev_attr(attr)->index;
-	long val;
-	int err;
-
-	int ret = kstrtol(buf, 10, &val);
-	if (ret)
-		return ret;
-	val = clamp_val(val / 1000, -128, 127);
-
-	err = regmap_write(data->regmap, temp_reg[ix], val);
-	if (err)
-		return err;
-
-	return count;
-}
-
-static ssize_t temp_alarm_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
-{
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	int ix = to_sensor_dev_attr(devattr)->index;
-	u32 regval, mask, reg;
-	int err;
-
-	switch (ix) {
-	case IDX_TEMP1_MIN:
-		reg = AMC6821_REG_STAT1;
-		mask = AMC6821_STAT1_LTL;
+	switch (attr) {
+	case hwmon_temp_input:
+		reg = channel ? AMC6821_REG_RTEMP_HI : AMC6821_REG_LTEMP_HI;
 		break;
-	case IDX_TEMP1_MAX:
-		reg = AMC6821_REG_STAT1;
-		mask = AMC6821_STAT1_LTH;
+	case hwmon_temp_min:
+		reg = channel ? AMC6821_REG_RTEMP_LIMIT_MIN : AMC6821_REG_LTEMP_LIMIT_MIN;
 		break;
-	case IDX_TEMP1_CRIT:
-		reg = AMC6821_REG_STAT2;
-		mask = AMC6821_STAT2_LTC;
+	case hwmon_temp_max:
+		reg = channel ? AMC6821_REG_RTEMP_LIMIT_MAX : AMC6821_REG_LTEMP_LIMIT_MAX;
 		break;
-	case IDX_TEMP2_MIN:
-		reg = AMC6821_REG_STAT1;
-		mask = AMC6821_STAT1_RTL;
-		break;
-	case IDX_TEMP2_MAX:
-		reg = AMC6821_REG_STAT1;
-		mask = AMC6821_STAT1_RTH;
-		break;
-	case IDX_TEMP2_CRIT:
-		reg = AMC6821_REG_STAT2;
-		mask = AMC6821_STAT2_RTC;
+	case hwmon_temp_crit:
+		reg = channel ? AMC6821_REG_RTEMP_CRIT : AMC6821_REG_LTEMP_CRIT;
 		break;
 	default:
-		dev_dbg(dev, "Unknown attr->index (%d).\n", ix);
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
-	err = regmap_read(data->regmap, reg, &regval);
+	err = regmap_read(regmap, reg, &regval);
 	if (err)
 		return err;
-	return sysfs_emit(buf, "%d\n", !!(regval & mask));
+	*val = (int8_t)regval * 1000;
+	return 0;
 }
 
-static ssize_t temp2_fault_show(struct device *dev,
-				struct device_attribute *devattr, char *buf)
+static int amc6821_read_alarms(struct regmap *regmap, enum hwmon_sensor_types type,
+			       u32 attr, int channel, long *val)
 {
-	struct amc6821_data *data = dev_get_drvdata(dev);
+	int reg, mask, err;
 	u32 regval;
-	int err;
 
-	err = regmap_read(data->regmap, AMC6821_REG_STAT1, &regval);
-	if (err)
-		return err;
-
-	return sysfs_emit(buf, "%d\n", !!(regval & AMC6821_STAT1_RTF));
-}
-
-static ssize_t pwm1_show(struct device *dev, struct device_attribute *devattr,
-			 char *buf)
-{
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	u32 regval;
-	int err;
-
-	err = regmap_read(data->regmap, AMC6821_REG_DCY, &regval);
-	if (err)
-		return err;
-
-	return sysfs_emit(buf, "%d\n", regval);
-}
-
-static ssize_t pwm1_store(struct device *dev,
-			  struct device_attribute *devattr, const char *buf,
-			  size_t count)
-{
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	long val;
-	int ret = kstrtol(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	if (val < 0 || val > 255)
-		return -EINVAL;
-
-	ret = regmap_write(data->regmap, AMC6821_REG_DCY, val);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static ssize_t pwm1_enable_show(struct device *dev,
-				struct device_attribute *devattr, char *buf)
-{
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	int err;
-	u32 val;
-
-	err = regmap_read(data->regmap, AMC6821_REG_CONF1, &val);
-	if (err)
-		return err;
-	switch (val & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
-	case 0:
-		val = 1;	/* manual */
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_min_alarm:
+			reg = AMC6821_REG_STAT1;
+			mask = channel ? AMC6821_STAT1_RTL : AMC6821_STAT1_LTL;
+			break;
+		case hwmon_temp_max_alarm:
+			reg = AMC6821_REG_STAT1;
+			mask = channel ? AMC6821_STAT1_RTH : AMC6821_STAT1_LTH;
+			break;
+		case hwmon_temp_crit_alarm:
+			reg = AMC6821_REG_STAT2;
+			mask = channel ? AMC6821_STAT2_RTC : AMC6821_STAT2_LTC;
+			break;
+		case hwmon_temp_fault:
+			reg = AMC6821_REG_STAT1;
+			mask = AMC6821_STAT1_RTF;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		break;
-	case AMC6821_CONF1_FDRC0:
-		val = 4;	/* target rpm (fan1_target) controlled */
-		break;
-	case AMC6821_CONF1_FDRC1:
-		val = 2;	/* remote temp controlled */
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_fault:
+			reg = AMC6821_REG_STAT1;
+			mask = AMC6821_STAT1_FANS;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
 		break;
 	default:
-		val = 3;	/* max(local, remote) temp controlled */
-		break;
+		return -EOPNOTSUPP;
 	}
-	return sysfs_emit(buf, "%d\n", val);
+	err = regmap_read(regmap, reg, &regval);
+	if (err)
+		return err;
+	*val = !!(regval & mask);
+	return 0;
 }
 
-static ssize_t pwm1_enable_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t count)
+static int amc6821_temp_read(struct device *dev, u32 attr, int channel, long *val)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
-	long val;
+
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_min:
+	case hwmon_temp_max:
+	case hwmon_temp_crit:
+		return amc6821_temp_read_values(data->regmap, attr, channel, val);
+	case hwmon_temp_min_alarm:
+	case hwmon_temp_max_alarm:
+	case hwmon_temp_crit_alarm:
+	case hwmon_temp_fault:
+		return amc6821_read_alarms(data->regmap, hwmon_temp, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int amc6821_temp_write(struct device *dev, u32 attr, int channel, long val)
+{
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	int reg;
+
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -128000, 127000), 1000);
+
+	switch (attr) {
+	case hwmon_temp_min:
+		reg = channel ? AMC6821_REG_RTEMP_LIMIT_MIN : AMC6821_REG_LTEMP_LIMIT_MIN;
+		break;
+	case hwmon_temp_max:
+		reg = channel ? AMC6821_REG_RTEMP_LIMIT_MAX : AMC6821_REG_LTEMP_LIMIT_MAX;
+		break;
+	case hwmon_temp_crit:
+		reg = channel ? AMC6821_REG_RTEMP_CRIT : AMC6821_REG_LTEMP_CRIT;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return regmap_write(data->regmap, reg, val);
+}
+
+static int amc6821_pwm_read(struct device *dev, u32 attr, long *val)
+{
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	u32 regval;
+	int err;
+
+	switch (attr) {
+	case hwmon_pwm_enable:
+		err = regmap_read(regmap, AMC6821_REG_CONF1, &regval);
+		if (err)
+			return err;
+		switch (regval & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
+		case 0:
+			*val = 1;	/* manual */
+			break;
+		case AMC6821_CONF1_FDRC0:
+			*val = 4;	/* target rpm (fan1_target) controlled */
+			break;
+		case AMC6821_CONF1_FDRC1:
+			*val = 2;	/* remote temp controlled */
+			break;
+		default:
+			*val = 3;	/* max(local, remote) temp controlled */
+			break;
+		}
+		return 0;
+	case hwmon_pwm_auto_channels_temp:
+		err = regmap_read(regmap, AMC6821_REG_CONF1, &regval);
+		if (err)
+			return err;
+		switch (regval & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
+		case 0:
+		case AMC6821_CONF1_FDRC0:
+			*val = 0;	/* manual or target rpm controlled */
+			break;
+		case AMC6821_CONF1_FDRC1:
+			*val = 2;	/* remote temp controlled */
+			break;
+		default:
+			*val = 3;	/* max(local, remote) temp controlled */
+			break;
+		}
+		return 0;
+	case hwmon_pwm_input:
+		err = regmap_read(regmap, AMC6821_REG_DCY, &regval);
+		if (err)
+			return err;
+		*val = regval;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int amc6821_pwm_write(struct device *dev, u32 attr, long val)
+{
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
 	u32 mask;
-	int err;
 
-	err = kstrtol(buf, 10, &val);
-	if (err)
-		return err;
-
-	switch (val) {
-	case 1:
-		mask = 0;
-		break;
-	case 2:
-		mask = AMC6821_CONF1_FDRC1;
-		break;
-	case 3:
-		mask = AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1;
-		break;
-	case 4:
-		mask = AMC6821_CONF1_FDRC0;
-		break;
+	switch (attr) {
+	case hwmon_pwm_enable:
+		switch (val) {
+		case 1:
+			mask = 0;
+			break;
+		case 2:
+			mask = AMC6821_CONF1_FDRC1;
+			break;
+		case 3:
+			mask = AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1;
+			break;
+		case 4:
+			mask = AMC6821_CONF1_FDRC0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return regmap_update_bits(regmap, AMC6821_REG_CONF1,
+					  AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
+					  mask);
+	case hwmon_pwm_input:
+		if (val < 0 || val > 255)
+			return -EINVAL;
+		return regmap_write(regmap, AMC6821_REG_DCY, val);
 	default:
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
-
-	err = regmap_update_bits(data->regmap, AMC6821_REG_CONF1,
-				 AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
-				 mask);
-	if (err < 0)
-		return err;
-
-	return count;
 }
 
-static ssize_t pwm1_auto_channels_temp_show(struct device *dev,
-					    struct device_attribute *devattr,
-					    char *buf)
+static int amc6821_fan_read_rpm(struct regmap *regmap, u32 attr, long *val)
 {
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	u32 val;
-	int err;
+	int reg, err;
+	u8 regs[2];
+	u32 regval;
 
-	err = regmap_read(data->regmap, AMC6821_REG_CONF1, &val);
-	if (err)
-		return err;
-	switch (val & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
-	case 0:
-	case AMC6821_CONF1_FDRC0:
-		val = 0;	/* manual or target rpm controlled */
+	switch (attr) {
+	case hwmon_fan_input:
+		reg = AMC6821_REG_TDATA_LOW;
 		break;
-	case AMC6821_CONF1_FDRC1:
-		val = 2;	/* remote temp controlled */
+	case hwmon_fan_min:
+		reg = AMC6821_REG_TACH_LLIMITL;
+		break;
+	case hwmon_fan_max:
+		reg = AMC6821_REG_TACH_HLIMITL;
+		break;
+	case hwmon_fan_target:
+		reg = AMC6821_REG_TACH_SETTINGL;
 		break;
 	default:
-		val = 3;	/* max(local, remote) temp controlled */
-		break;
+		return -EOPNOTSUPP;
 	}
 
-	return sprintf(buf, "%d\n", val);
+	err = regmap_bulk_read(regmap, reg, regs, 2);
+	if (err)
+		return err;
+
+	regval = (regs[1] << 8) | regs[0];
+	*val = 6000000 / (regval ? : 1);
+
+	return 0;
+}
+
+static int amc6821_fan_read(struct device *dev, u32 attr, long *val)
+{
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	u32 regval;
+	int err;
+
+	switch (attr) {
+	case hwmon_fan_input:
+	case hwmon_fan_min:
+	case hwmon_fan_max:
+	case hwmon_fan_target:
+		return amc6821_fan_read_rpm(regmap, attr, val);
+	case hwmon_fan_fault:
+		return amc6821_read_alarms(regmap, hwmon_fan, attr, 0, val);
+	case hwmon_fan_pulses:
+		err = regmap_read(regmap, AMC6821_REG_CONF4, &regval);
+		if (err)
+			return err;
+		*val = (regval & AMC6821_CONF4_PSPR) ? 4 : 2;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int amc6821_fan_write(struct device *dev, u32 attr, long val)
+{
+	struct amc6821_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
+	u8 regs[2];
+	int reg;
+
+	if (attr == hwmon_fan_pulses) {
+		if (val != 2 && val != 4)
+			return -EINVAL;
+		return regmap_update_bits(regmap, AMC6821_REG_CONF4,
+					 AMC6821_CONF4_PSPR,
+					 val == 4 ? AMC6821_CONF4_PSPR : 0);
+	}
+
+	if (val < 0)
+		return -EINVAL;
+
+	val = clamp_val(6000000 / (val ? : 1), 0, 0xffff);
+
+	switch (attr) {
+	case hwmon_fan_min:
+		reg = AMC6821_REG_TACH_LLIMITL;
+		break;
+	case hwmon_fan_max:
+		reg = AMC6821_REG_TACH_HLIMITL;
+		break;
+	case hwmon_fan_target:
+		reg = AMC6821_REG_TACH_SETTINGL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	regs[0] = val & 0xff;
+	regs[1] = val >> 8;
+
+	return regmap_bulk_write(data->regmap, reg, regs, 2);
 }
 
 static ssize_t temp_auto_point_temp_show(struct device *dev,
 					 struct device_attribute *devattr,
 					 char *buf)
 {
+	struct amc6821_data *data = dev_get_drvdata(dev);
 	int ix = to_sensor_dev_attr_2(devattr)->index;
 	int nr = to_sensor_dev_attr_2(devattr)->nr;
-	struct amc6821_data *data = dev_get_drvdata(dev);
 
 	switch (nr) {
 	case 1:
@@ -423,7 +495,6 @@ static ssize_t temp_auto_point_temp_show(struct device *dev,
 		return sprintf(buf, "%d\n",
 			data->temp2_auto_point_temp[ix] * 1000);
 	default:
-		dev_dbg(dev, "Unknown attr->nr (%d).\n", nr);
 		return -EINVAL;
 	}
 }
@@ -579,130 +650,9 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
 	return count;
 }
 
-static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
-			char *buf)
-{
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	int ix = to_sensor_dev_attr(devattr)->index;
-	u32 regval;
-	u8 regs[2];
-	int err;
-
-	err = regmap_bulk_read(data->regmap, fan_reg_low[ix], regs, 2);
-	if (err)
-		return err;
-	regval = (regs[1] << 8) | regs[0];
-
-	return sysfs_emit(buf, "%d\n", 6000000 / (regval ? : 1));
-}
-
-static ssize_t fan1_fault_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
-{
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	u32 regval;
-	int err;
-
-	err = regmap_read(data->regmap, AMC6821_REG_STAT1, &regval);
-	if (err)
-		return err;
-
-	return sysfs_emit(buf, "%d\n", !!(regval & AMC6821_STAT1_FANS));
-}
-
-static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t count)
-{
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	int ix = to_sensor_dev_attr(attr)->index;
-	u8 regs[2];
-	long val;
-	int err;
-
-	err = kstrtol(buf, 10, &val);
-	if (err)
-		return err;
-
-	val = val < 1 ? 0xFFFF : 6000000 / val;
-	val = clamp_val(val, 0, 0xFFFF);
-
-	regs[0] = val & 0xff;
-	regs[1] = val >> 8;
-
-	err = regmap_bulk_write(data->regmap, fan_reg_low[ix], regs, 2);
-	if (err)
-		return err;
-
-	return count;
-}
-
-static ssize_t fan1_pulses_show(struct device *dev,
-				struct device_attribute *devattr, char *buf)
-{
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	u32 regval;
-	int err;
-
-	err = regmap_read(data->regmap, AMC6821_REG_CONF4, &regval);
-	if (err)
-		return err;
-
-	return sysfs_emit(buf, "%d\n", (regval & AMC6821_CONF4_PSPR) ? 4 : 2);
-}
-
-static ssize_t fan1_pulses_store(struct device *dev,
-				 struct device_attribute *attr, const char *buf,
-				 size_t count)
-{
-	struct amc6821_data *data = dev_get_drvdata(dev);
-	long val;
-	int err;
-
-	err = kstrtol(buf, 10, &val);
-	if (err)
-		return err;
-
-	if (val != 2 && val != 4)
-		return -EINVAL;
-
-	err = regmap_update_bits(data->regmap, AMC6821_REG_CONF4,
-				 AMC6821_CONF4_PSPR,
-				 val == 4 ? AMC6821_CONF4_PSPR : 0);
-	if (err)
-		return err;
-
-	return count;
-}
-
-static SENSOR_DEVICE_ATTR_RO(temp1_input, temp, IDX_TEMP1_INPUT);
-static SENSOR_DEVICE_ATTR_RW(temp1_min, temp, IDX_TEMP1_MIN);
-static SENSOR_DEVICE_ATTR_RW(temp1_max, temp, IDX_TEMP1_MAX);
-static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp, IDX_TEMP1_CRIT);
-static SENSOR_DEVICE_ATTR_RO(temp1_min_alarm, temp_alarm, IDX_TEMP1_MIN);
-static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, temp_alarm, IDX_TEMP1_MAX);
-static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, temp_alarm, IDX_TEMP1_CRIT);
-static SENSOR_DEVICE_ATTR_RO(temp2_input, temp, IDX_TEMP2_INPUT);
-static SENSOR_DEVICE_ATTR_RW(temp2_min, temp, IDX_TEMP2_MIN);
-static SENSOR_DEVICE_ATTR_RW(temp2_max, temp, IDX_TEMP2_MAX);
-static SENSOR_DEVICE_ATTR_RW(temp2_crit, temp, IDX_TEMP2_CRIT);
-static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp2_fault, 0);
-static SENSOR_DEVICE_ATTR_RO(temp2_min_alarm, temp_alarm, IDX_TEMP2_MIN);
-static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, temp_alarm, IDX_TEMP2_MAX);
-static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, temp_alarm, IDX_TEMP2_CRIT);
-static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, IDX_FAN1_INPUT);
-static SENSOR_DEVICE_ATTR_RW(fan1_min, fan, IDX_FAN1_MIN);
-static SENSOR_DEVICE_ATTR_RW(fan1_max, fan, IDX_FAN1_MAX);
-static SENSOR_DEVICE_ATTR_RW(fan1_target, fan, IDX_FAN1_TARGET);
-static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan1_fault, 0);
-static SENSOR_DEVICE_ATTR_RW(fan1_pulses, fan1_pulses, 0);
-
-static SENSOR_DEVICE_ATTR_RW(pwm1, pwm1, 0);
-static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm1_enable, 0);
 static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_pwm, pwm1_auto_point_pwm, 0);
 static SENSOR_DEVICE_ATTR_RW(pwm1_auto_point2_pwm, pwm1_auto_point_pwm, 1);
 static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point3_pwm, pwm1_auto_point_pwm, 2);
-static SENSOR_DEVICE_ATTR_RO(pwm1_auto_channels_temp, pwm1_auto_channels_temp,
-			     0);
 static SENSOR_DEVICE_ATTR_2_RO(temp1_auto_point1_temp, temp_auto_point_temp,
 			       1, 0);
 static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_point2_temp, temp_auto_point_temp,
@@ -718,30 +668,6 @@ static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_point3_temp, temp_auto_point_temp,
 			       2, 2);
 
 static struct attribute *amc6821_attrs[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_min.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit.dev_attr.attr,
-	&sensor_dev_attr_temp1_min_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_input.dev_attr.attr,
-	&sensor_dev_attr_temp2_min.dev_attr.attr,
-	&sensor_dev_attr_temp2_max.dev_attr.attr,
-	&sensor_dev_attr_temp2_crit.dev_attr.attr,
-	&sensor_dev_attr_temp2_min_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_fault.dev_attr.attr,
-	&sensor_dev_attr_fan1_input.dev_attr.attr,
-	&sensor_dev_attr_fan1_min.dev_attr.attr,
-	&sensor_dev_attr_fan1_max.dev_attr.attr,
-	&sensor_dev_attr_fan1_target.dev_attr.attr,
-	&sensor_dev_attr_fan1_fault.dev_attr.attr,
-	&sensor_dev_attr_fan1_pulses.dev_attr.attr,
-	&sensor_dev_attr_pwm1.dev_attr.attr,
-	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
-	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point1_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point2_pwm.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_point3_pwm.dev_attr.attr,
@@ -753,13 +679,117 @@ static struct attribute *amc6821_attrs[] = {
 	&sensor_dev_attr_temp2_auto_point3_temp.dev_attr.attr,
 	NULL
 };
-
 ATTRIBUTE_GROUPS(amc6821);
 
+static int amc6821_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_temp:
+		return amc6821_temp_read(dev, attr, channel, val);
+	case hwmon_fan:
+		return amc6821_fan_read(dev, attr, val);
+	case hwmon_pwm:
+		return amc6821_pwm_read(dev, attr, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int amc6821_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_temp:
+		return amc6821_temp_write(dev, attr, channel, val);
+	case hwmon_fan:
+		return amc6821_fan_write(dev, attr, val);
+	case hwmon_pwm:
+		return amc6821_pwm_write(dev, attr, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t amc6821_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_min_alarm:
+		case hwmon_temp_max_alarm:
+		case hwmon_temp_crit_alarm:
+		case hwmon_temp_fault:
+			return 0444;
+		case hwmon_temp_min:
+		case hwmon_temp_max:
+		case hwmon_temp_crit:
+			return 0644;
+		default:
+			return 0;
+		}
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+		case hwmon_fan_fault:
+			return 0444;
+		case hwmon_fan_pulses:
+		case hwmon_fan_min:
+		case hwmon_fan_max:
+		case hwmon_fan_target:
+			return 0644;
+		default:
+			return 0;
+		}
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_enable:
+		case hwmon_pwm_input:
+			return 0644;
+		case hwmon_pwm_auto_channels_temp:
+			return 0444;
+		default:
+			return 0;
+		}
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_channel_info * const amc6821_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+			   HWMON_T_CRIT | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM |
+			   HWMON_T_FAULT),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
+			   HWMON_F_TARGET | HWMON_F_PULSES | HWMON_F_FAULT),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE |
+			   HWMON_PWM_AUTO_CHANNELS_TEMP),
+	NULL
+};
+
+static const struct hwmon_ops amc6821_hwmon_ops = {
+	.is_visible = amc6821_is_visible,
+	.read = amc6821_read,
+	.write = amc6821_write,
+};
+
+static const struct hwmon_chip_info amc6821_chip_info = {
+	.ops = &amc6821_hwmon_ops,
+	.info = amc6821_info,
+};
+
 /* Return 0 if detection is successful, -ENODEV otherwise */
-static int amc6821_detect(
-		struct i2c_client *client,
-		struct i2c_board_info *info)
+static int amc6821_detect(struct i2c_client *client, struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
 	int address = client->addr;
@@ -872,7 +902,6 @@ static int amc6821_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-
 	regmap = devm_regmap_init_i2c(client, &amc6821_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
@@ -883,9 +912,9 @@ static int amc6821_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
-	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
-							   data,
-							   amc6821_groups);
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+							 data, &amc6821_chip_info,
+							 amc6821_groups);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
-- 
2.39.2


