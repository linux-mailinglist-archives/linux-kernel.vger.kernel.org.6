Return-Path: <linux-kernel+bounces-241569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D82927CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D45C2858F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1FA143887;
	Thu,  4 Jul 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNRLXW9p"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FB143724;
	Thu,  4 Jul 2024 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115552; cv=none; b=fZ4XVZsGbffOmkP1Zyp6xRVl7Uc6zUrxr99vQlsnuI3f8vOGYB8xDs7puLPZHck7mo64/ZiSsdhZKXKLSbxN/leWEv5tCAi58YyhUs77I/dhmbPe9/XuAjiMc88c/UteI4TCB18xHs4YzQS74+e8Bokobak+1p/k9wo8g2APcu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115552; c=relaxed/simple;
	bh=MbHZm6kUBRqmcak5kTswGKRVg1MEHyfbP0zjAozyyWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/CshgHxRpzPVEXucLRdhmED3AseutxENs9rEHn2lVklMMovok6zeLJ1+VBd1R2WmK1aT/0wSNcexU0uOJa3F1ZZ0/TATn/vKWln0UJSkYK4LkuVdKqg+9AT3xKnQP2TOonRwfj1/M+Bzlrf2Um4eMsYYatvmXroEgHyBxXaUvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNRLXW9p; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb3cf78fcaso3864535ad.1;
        Thu, 04 Jul 2024 10:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115548; x=1720720348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncuAdg/r/bXPRfZ3zvG3UBBspWmRKkX1bBRV0DtBu50=;
        b=SNRLXW9pTo5HgAXM2wbzJ4h58ZOAl9rAs2lE8g/pkDPft8BLQ/LcQZQ/NVI5gMPQX/
         NePwzWQdWIjR14lXDhympD8ajr3AAbqtyXt7mXjHi3nbHTV0+OqriXeYhbJID9FLQwmd
         klqFjNiF96kBYvfjYq1ULPQ7P8S95HjkeeSeuv/Sp8daTctPUiIcXiZfUNdyVcAL/PTb
         GTV90P9c8QlLkoJk8wmh5Qkqla1QrNyQej0UE5EdVR99fTkx+uBkVx7NlJ+cLVQvuY3B
         LWvXjv1LEWv81WIq/0DgkfsUKh7b75FQDUbC+WQhfYrwcPcms+M/tv6sn4o+HGlo4knc
         ezrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115548; x=1720720348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncuAdg/r/bXPRfZ3zvG3UBBspWmRKkX1bBRV0DtBu50=;
        b=C1JchjKRvJ+s8X8upFEE9ASfBk+Y0S70xcmZdZ0Ww/8inbn5arrcR8DcKJph8UhD9x
         9kqVbmNGBIh+c80wsryF1vJdFwKTp2gQVF4NKe12L0NEgynb6xPQaA6De2u4blVeGuGU
         IqhvEsxVJrAbeRjtskGNTU2ESxUtmOmO9k9TMlEEOzkqjyImwBVj6suA5vECIt0t5ygd
         rXB5Zi5XryzWFSSPHLfgTSaEBv1/gdp/gvIoayBfrRTMDr3CR/p/Cr1d6sWkHx4finc+
         GbyD7D44hwZ6koQhLxa4YWMWK8HTqkPIbrdrI99RvS/oRRFBsJF1ygvyqAPP9EQWuvk1
         pSpw==
X-Gm-Message-State: AOJu0Ywmmvp+S2RduNyw/gj3Y8W65RpaRAfPKZk4G9Z0sKCHhBIRPYI9
	2zvXhnnOSmLXP0EYlSN3Bk33s+u71yZKGJCu5V1e+N7U2soMQSptZfltpg==
X-Google-Smtp-Source: AGHT+IEvVWZTF8m62cD9BGa5G2TvKBciUbvyno93Tr9TUwkgz2NDrWEnLOSFLKPwXQw+7K6E+VF9Mg==
X-Received: by 2002:a17:903:1107:b0:1f7:19b7:98bd with SMTP id d9443c01a7336-1fb33e05130mr23122135ad.6.1720115548431;
        Thu, 04 Jul 2024 10:52:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1f3esm125815885ad.19.2024.07.04.10.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 10/11] hwmon: (amc6821) Convert to with_info API
Date: Thu,  4 Jul 2024 10:52:06 -0700
Message-Id: <20240704175207.2684012-11-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704175207.2684012-1-linux@roeck-us.net>
References: <20240704175207.2684012-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use with_info API to simplify the code and make it easier
to maintain. This also reduces code size by approximately 20%.

No functional change intended.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Add Quentin's Reviewed-by: tag

v2: Adjust to changes made in preceding patches

 drivers/hwmon/amc6821.c | 744 +++++++++++++++++++++-------------------
 1 file changed, 390 insertions(+), 354 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index a5abd36a1430..be3e590aba3d 100644
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
 
 #include <linux/bitfield.h>
@@ -112,28 +115,6 @@ module_param(init, int, 0444);
 #define AMC6821_TEMP_SLOPE_MASK		GENMASK(2, 0)
 #define AMC6821_TEMP_LIMIT_MASK		GENMASK(7, 3)
 
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
@@ -180,219 +161,319 @@ static int amc6821_get_auto_point_temps(struct regmap *regmap, int channel, u8 *
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
-	return sysfs_emit(buf, "%d\n", sign_extend32(regval, 7) * 1000);
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
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
-	err = regmap_read(data->regmap, reg, &regval);
+	err = regmap_read(regmap, reg, &regval);
 	if (err)
 		return err;
-	return sysfs_emit(buf, "%d\n", !!(regval & mask));
+	*val = sign_extend32(regval, 7) * 1000;
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
-	u8 val;
-	int ret = kstrtou8(buf, 10, &val);
-	if (ret)
-		return ret;
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
 	u32 mode;
-	int err;
 
-	err = kstrtol(buf, 10, &val);
-	if (err)
-		return err;
-
-	switch (val) {
-	case 1:
-		mode = 0;
-		break;
-	case 2:
-		mode = AMC6821_CONF1_FDRC1;
-		break;
-	case 3:
-		mode = AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1;
-		break;
-	case 4:
-		mode = AMC6821_CONF1_FDRC0;
-		break;
+	switch (attr) {
+	case hwmon_pwm_enable:
+		switch (val) {
+		case 1:
+			mode = 0;
+			break;
+		case 2:
+			mode = AMC6821_CONF1_FDRC1;
+			break;
+		case 3:
+			mode = AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1;
+			break;
+		case 4:
+			mode = AMC6821_CONF1_FDRC0;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return regmap_update_bits(regmap, AMC6821_REG_CONF1,
+					  AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
+					  mode);
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
-				 mode);
-	if (err)
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
 
-	return sysfs_emit(buf, "%d\n", val);
+	err = regmap_bulk_read(regmap, reg, regs, 2);
+	if (err)
+		return err;
+
+	regval = (regs[1] << 8) | regs[0];
+	*val = regval ? 6000000 / regval : 0;
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
+	switch (attr) {
+	case hwmon_fan_min:
+		if (!val)	/* no unlimited minimum speed */
+			return -EINVAL;
+		reg = AMC6821_REG_TACH_LLIMITL;
+		break;
+	case hwmon_fan_max:
+		reg = AMC6821_REG_TACH_HLIMITL;
+		break;
+	case hwmon_fan_target:
+		if (!val)	/* no unlimited target speed */
+			return -EINVAL;
+		reg = AMC6821_REG_TACH_SETTINGL;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	val = val ? 6000000 / clamp_val(val, 1, 6000000) : 0;
+	val = clamp_val(val, 0, 0xffff);
+
+	regs[0] = val & 0xff;
+	regs[1] = val >> 8;
+
+	return regmap_bulk_write(data->regmap, reg, regs, 2);
 }
 
 static ssize_t temp_auto_point_temp_show(struct device *dev,
@@ -564,134 +645,9 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
 	return ret ? : count;
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
-	unsigned long val;
-	u8 regs[2];
-	int err;
-
-	err = kstrtoul(buf, 10, &val);
-	if (err)
-		return err;
-
-	/* Minimum and target fan speed must not be unlimited (0) */
-	if ((ix == IDX_FAN1_MIN || ix == IDX_FAN1_TARGET) && !val)
-		return -EINVAL;
-
-	val = val > 0 ? 6000000 / clamp_val(val, 1, 6000000) : 0;
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
 			       0, 0);
 static SENSOR_DEVICE_ATTR_2_RW(temp1_auto_point2_temp, temp_auto_point_temp,
@@ -707,30 +663,6 @@ static SENSOR_DEVICE_ATTR_2_RW(temp2_auto_point3_temp, temp_auto_point_temp,
 			       1, 2);
 
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
@@ -742,13 +674,117 @@ static struct attribute *amc6821_attrs[] = {
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
@@ -867,9 +903,9 @@ static int amc6821_probe(struct i2c_client *client)
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


