Return-Path: <linux-kernel+bounces-200637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 570478FB2CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D641F24AAF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7931494DE;
	Tue,  4 Jun 2024 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dV0j5nLg"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEE01465A8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505279; cv=none; b=sn/XH3SiswLp40GpDmGmDeqRmaLPnUOJH/8ZhOufONyZoxy+0v8rQHdJNxhmOXdHWni1Iy5SanCrLASD6WEwGtundyLfnrevONl0ONTDDonYuLK69MRom+eSrto4fNsTBvfzmx3Oo2S8HXjG9PJKSK8pFJCeMn8OedNCNVki8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505279; c=relaxed/simple;
	bh=eGgQ6rqvgGBEXY2yWzzaKPZzdMb8oI+vz1jVseKQiDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSZMJlCeykRf/iFXdBmFLjKBFYs5JJAWtQPCQSUORrEVc+wgW6Wfijo3iHoWNrWZn8ZAjhygftyM9afyMpXlITo0XTLF83nD/Y5mVG0Yk+22it6VBbS22EnyTf88rzWJt1FgPavTIqfDCeoP8SFP4vCBeSx8p+EwuesLnkTjFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=dV0j5nLg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-356c4e926a3so4520201f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1717505275; x=1718110075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPJ9LkXjFjDVG4PWaLJ89nsw4bBLS/hPn/b1hBhxzwY=;
        b=dV0j5nLg0uNeVKJsLmfwB3AzvvC05fqxMVJ0mc7EVi5tA2S4nQmq7mTUr1uFmO/1Ct
         nmRHNrEXK9cgBGPEkoYjgYzwbgNRGCMIZoSIwGqrVmixPJYa/vAUD8xbJApfowoQ58X2
         Yd/ROc0s6KEP4qHLCzVncNxiURNScbJ7MRo1ci4PFtUa+p4f9K7+78nDAe8EuTQoibtn
         8R+nUNaCTCEK63f3lVVv13nojCtJoYGOZf++1HTyw/nyzfakjr6JskHfu5aWsKj7P0r0
         R5ZT1qsv4jOjwQYYioV/9357JNV/Nbk0oAr3/2NyEgVNWg45985W0kz2ASoSxS0t4mO4
         BC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505275; x=1718110075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPJ9LkXjFjDVG4PWaLJ89nsw4bBLS/hPn/b1hBhxzwY=;
        b=aVVLmOaYJHfwmUbOekz/OmwxbVUG30Wvwetd2s6VR83JMGLxmqy14dsfLZbroFZj6Z
         E260DGrrT5mrjP3xmGfZcjovevGbfxaa39Onf9GoYv/HZ2y2M0ug11JwYVW3nEMvkhCO
         wDkL3vO9gB0A0B2wIq/MnpqO01kIuhEES4LEvfgwiZoMzIAIgmTA3V8j6LPFV4v7WGdo
         wIfdfJfRIIp44y/lwHh4ULi8Kihef2J8wPKfXbnG02Y5HRJKWg4p1uqmuNMnDHEzEe0Q
         uSaHznU1z0++Hc79C9vBtuj61Vq8I9/EoM5Xx1pKmNdeFxVD6lJsxUoBU/IqV+eG0/pL
         46BQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/gqRnCRV6jYrzSQHLjef8aKILlGUsI1krs+3P/1ZF0T+B8CB1/YtR/s/k1s3xTQyBhaEQaV+IvmusUhmmyYYDK47QZOZlpKVwImCt
X-Gm-Message-State: AOJu0YwrWGZBVs0/4Czex0Pmc2mhRnYldc45ITbjyP402GZgj971Gn9Z
	b1z6WEa6ogeKR/bKjOWn34cwsI3y2BPWv7oawb3giTUsa6VMj6UL1pBF+jaO614=
X-Google-Smtp-Source: AGHT+IFOOHIIE6IhJwFfi61etJg455fdFC+ZzPmzIahXvJXfmJ6a7kmV+J+LLKW4E67ljlgHPDUwBg==
X-Received: by 2002:a05:6000:12c7:b0:34c:5448:b81a with SMTP id ffacd0b85a97d-35e0f30e821mr8430188f8f.48.1717505275004;
        Tue, 04 Jun 2024 05:47:55 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0e8fsm11488832f8f.2.2024.06.04.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:47:54 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] hwmon: (max6639) : Update hwmon init using info structure
Date: Tue,  4 Jun 2024 18:17:39 +0530
Message-ID: <20240604124742.4093334-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update hwmon init with info instead of group. The hwmon info structure
in more flexible to describe sensor attribute & easy to maintian.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
Changes in v4:
- Change res type from unsigned to signed

Changes in V3:
- return 0 when 'res' variable is known zero.
- Handle errors first before assigning results
- Use BIT to make it easier to read.
- Remove error message print on user input
- Return err value instead of printing error message & returing zero.
- Remove variable declaration in switch case statement
- Use find_closest instead of for loop
- Remove pointless assignment & check
- Seperate patch for adding additional attributes
---
 drivers/hwmon/max6639.c | 469 +++++++++++++++++++++++++---------------
 1 file changed, 299 insertions(+), 170 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index cbb595fe47aa..e2a5210f9f95 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_data/max6639.h>
 #include <linux/regmap.h>
+#include <linux/util_macros.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
@@ -55,13 +56,17 @@ static const unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 #define MAX6639_GCONFIG_PWM_FREQ_HI		0x08
 
 #define MAX6639_FAN_CONFIG1_PWM			0x80
-
+#define MAX6639_FAN_CONFIG3_FREQ_MASK		0x03
 #define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
 
 #define MAX6639_NUM_CHANNELS			2
 
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
+/* Supported PWM frequency */
+static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
+					   25000 };
+
 #define FAN_FROM_REG(val, rpm_range)	((val) == 0 || (val) == 255 ? \
 				0 : (rpm_ranges[rpm_range] * 30) / (val))
 #define TEMP_LIMIT_TO_REG(val)	clamp_val((val) / 1000, 0, 255)
@@ -73,19 +78,16 @@ struct max6639_data {
 	struct regmap *regmap;
 
 	/* Register values initialized only once */
-	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
-	u8 rpm_range;		/* Index in above rpm_ranges table */
+	u8 ppr[MAX6639_NUM_CHANNELS];	/* Pulses per rotation 0..3 for 1..4 ppr */
+	u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
 
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
 };
 
-static ssize_t temp_input_show(struct device *dev,
-			       struct device_attribute *dev_attr, char *buf)
+static int max6639_temp_read_input(struct device *dev, int channel, long *temp)
 {
-	long temp;
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	unsigned int val;
 	int res;
 
@@ -93,251 +95,378 @@ static ssize_t temp_input_show(struct device *dev,
 	 * Lock isn't needed as MAX6639_REG_TEMP wpnt change for at least 250ms after reading
 	 * MAX6639_REG_TEMP_EXT
 	 */
-	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(channel), &val);
 	if (res < 0)
 		return res;
 
-	temp = val >> 5;
-	res = regmap_read(data->regmap, MAX6639_REG_TEMP(attr->index), &val);
+	*temp = val >> 5;
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP(channel), &val);
 	if (res < 0)
 		return res;
 
-	temp |= val << 3;
-	temp *= 125;
+	*temp |= val << 3;
+	*temp *= 125;
 
-	return sprintf(buf, "%ld\n", temp);
+	return 0;
 }
 
-static ssize_t temp_fault_show(struct device *dev,
-			       struct device_attribute *dev_attr, char *buf)
+static int max6639_temp_read_fault(struct device *dev, int channel, long *fault)
 {
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	unsigned int val;
 	int res;
 
-	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(attr->index), &val);
+	res = regmap_read(data->regmap, MAX6639_REG_TEMP_EXT(channel), &val);
 	if (res < 0)
 		return res;
 
-	return sprintf(buf, "%d\n", val & 1);
+	*fault = val & 1;
+
+	return 0;
 }
 
-static ssize_t temp_max_show(struct device *dev,
-			     struct device_attribute *dev_attr, char *buf)
+static int max6639_temp_read_max(struct device *dev, int channel, long *max)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
 	unsigned int val;
 	int res;
 
-	res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index), &val);
+	res = regmap_read(data->regmap, MAX6639_REG_THERM_LIMIT(channel), &val);
 	if (res < 0)
 		return res;
 
-	return sprintf(buf, "%d\n", (val * 1000));
+	*max = val * 1000;
+
+	return 0;
 }
 
-static ssize_t temp_max_store(struct device *dev,
-			      struct device_attribute *dev_attr,
-			      const char *buf, size_t count)
+static int max6639_temp_read_crit(struct device *dev, int channel, long *crit)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	unsigned long val;
+	unsigned int val;
 	int res;
 
-	res = kstrtoul(buf, 10, &val);
-	if (res)
+	res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(channel), &val);
+	if (res < 0)
 		return res;
 
-	regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(attr->index),
-		     TEMP_LIMIT_TO_REG(val));
-	return count;
+	*crit = val * 1000;
+
+	return 0;
 }
 
-static ssize_t temp_crit_show(struct device *dev,
-			      struct device_attribute *dev_attr, char *buf)
+static int max6639_temp_read_emergency(struct device *dev, int channel, long *emerg)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
 	unsigned int val;
 	int res;
 
-	res = regmap_read(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index), &val);
+	res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(channel), &val);
 	if (res < 0)
 		return res;
 
-	return sprintf(buf, "%d\n", (val * 1000));
+	*emerg = val * 1000;
+
+	return 0;
 }
 
-static ssize_t temp_crit_store(struct device *dev,
-			       struct device_attribute *dev_attr,
-			       const char *buf, size_t count)
+static int max6639_get_status(struct device *dev, unsigned int *status)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	unsigned long val;
+	unsigned int val;
 	int res;
 
-	res = kstrtoul(buf, 10, &val);
-	if (res)
+	res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
+	if (res < 0)
 		return res;
 
-	regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(attr->index),
-		     TEMP_LIMIT_TO_REG(val));
-	return count;
+	*status = val;
+
+	return 0;
 }
 
-static ssize_t temp_emergency_show(struct device *dev,
-				   struct device_attribute *dev_attr,
-				   char *buf)
+static int max6639_temp_set_max(struct max6639_data *data, int channel, unsigned long val)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
-	struct max6639_data *data = dev_get_drvdata(dev);
-	unsigned int val;
 	int res;
 
-	res = regmap_read(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), &val);
-	if (res < 0)
-		return res;
-
-	return sprintf(buf, "%d\n", (val * 1000));
+	res = regmap_write(data->regmap, MAX6639_REG_THERM_LIMIT(channel),
+			   TEMP_LIMIT_TO_REG(val));
+	return res;
 }
 
-static ssize_t temp_emergency_store(struct device *dev,
-				    struct device_attribute *dev_attr,
-				    const char *buf, size_t count)
+static int max6639_temp_set_crit(struct max6639_data *data, int channel, unsigned long val)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
-	struct max6639_data *data = dev_get_drvdata(dev);
-	unsigned long val;
 	int res;
 
-	res = kstrtoul(buf, 10, &val);
-	if (res)
-		return res;
-
-	regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(attr->index), TEMP_LIMIT_TO_REG(val));
+	res = regmap_write(data->regmap, MAX6639_REG_ALERT_LIMIT(channel), TEMP_LIMIT_TO_REG(val));
 
-	return count;
+	return res;
 }
 
-static ssize_t pwm_show(struct device *dev, struct device_attribute *dev_attr,
-			char *buf)
+static int max6639_temp_set_emergency(struct max6639_data *data, int channel, unsigned long val)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
-	struct max6639_data *data = dev_get_drvdata(dev);
-	unsigned int val;
 	int res;
 
-	res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), &val);
-	if (res < 0)
-		return res;
+	res = regmap_write(data->regmap, MAX6639_REG_OT_LIMIT(channel), TEMP_LIMIT_TO_REG(val));
 
-	return sprintf(buf, "%d\n", val * 255 / 120);
+	return res;
 }
 
-static ssize_t pwm_store(struct device *dev,
-			 struct device_attribute *dev_attr, const char *buf,
-			 size_t count)
+static int max6639_read_fan(struct device *dev, u32 attr, int channel,
+			    long *fan_val)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	struct max6639_data *data = dev_get_drvdata(dev);
-	unsigned long val;
+	unsigned int val;
 	int res;
 
-	res = kstrtoul(buf, 10, &val);
-	if (res)
-		return res;
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (attr) {
+	case hwmon_fan_input:
+		res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(channel), &val);
+		if (res < 0)
+			return res;
+		*fan_val = FAN_FROM_REG(val, data->rpm_range[channel]);
+		return 0;
+	case hwmon_fan_fault:
+		res = max6639_get_status(dev, &val);
+		if (res < 0)
+			return res;
+		*fan_val = !!(val & BIT(1 - channel));
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
+{
+	/* Decrement the PPR value and shift left by 6 to match the register format */
+	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
+}
 
-	val = clamp_val(val, 0, 255);
+static umode_t max6639_fan_is_visible(const void *_data, u32 attr, int channel)
+{
+	struct max6639_data *data = (struct max6639_data *)_data;
 
-	regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(attr->index), val * 120 / 255);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
-	return count;
+	switch (attr) {
+	case hwmon_fan_input:
+	case hwmon_fan_fault:
+		return 0444;
+	case hwmon_fan_pulses:
+		return 0644;
+	default:
+		return 0;
+	}
 }
 
-static ssize_t fan_input_show(struct device *dev,
-			      struct device_attribute *dev_attr, char *buf)
+static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
+			    long *pwm_val)
 {
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
 	unsigned int val;
 	int res;
 
-	res = regmap_read(data->regmap, MAX6639_REG_FAN_CNT(attr->index), &val);
-	if (res < 0)
-		return res;
+	if (IS_ERR(data))
+		return PTR_ERR(data);
 
-	return sprintf(buf, "%d\n", FAN_FROM_REG(val, data->rpm_range));
+	switch (attr) {
+	case hwmon_pwm_input:
+		res = regmap_read(data->regmap, MAX6639_REG_TARGTDUTY(channel), &val);
+		if (res < 0)
+			return res;
+		*pwm_val = val * 255 / 120;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
 }
 
-static ssize_t alarm_show(struct device *dev,
-			  struct device_attribute *dev_attr, char *buf)
+static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
+			     long val)
 {
 	struct max6639_data *data = dev_get_drvdata(dev);
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(dev_attr);
-	unsigned int val;
+	int err;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		val = clamp_val(val, 0, 255);
+		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(channel),
+				   val * 120 / 255);
+		return err;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t max6639_pwm_is_visible(const void *_data, u32 attr, int channel)
+{
+	switch (attr) {
+	case hwmon_pwm_input:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static int max6639_read_temp(struct device *dev, u32 attr, int channel,
+			     long *val)
+{
+	unsigned int status;
 	int res;
 
-	res = regmap_read(data->regmap, MAX6639_REG_STATUS, &val);
-	if (res < 0)
+	switch (attr) {
+	case hwmon_temp_input:
+		res = max6639_temp_read_input(dev, channel, val);
+		return res;
+	case hwmon_temp_fault:
+		res = max6639_temp_read_fault(dev, channel, val);
+		return res;
+	case hwmon_temp_max:
+		res = max6639_temp_read_max(dev, channel, val);
+		return res;
+	case hwmon_temp_crit:
+		res = max6639_temp_read_crit(dev, channel, val);
+		return res;
+	case hwmon_temp_emergency:
+		res = max6639_temp_read_emergency(dev, channel, val);
 		return res;
+	case hwmon_temp_max_alarm:
+		res = max6639_get_status(dev, &status);
+		if (res < 0)
+			return res;
+		*val = !!(status & BIT(3 - channel));
+		return 0;
+	case hwmon_temp_crit_alarm:
+		res = max6639_get_status(dev, &status);
+		if (res < 0)
+			return res;
+		*val = !!(status & BIT(7 - channel));
+		return 0;
+	case hwmon_temp_emergency_alarm:
+		res = max6639_get_status(dev, &status);
+		if (res < 0)
+			return res;
+		*val = !!(status & BIT(5 - channel));
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int max6639_write_temp(struct device *dev, u32 attr, int channel,
+			      long val)
+{
+	struct max6639_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_max:
+		return max6639_temp_set_max(data, channel, val);
+	case hwmon_temp_crit:
+		return max6639_temp_set_crit(data, channel, val);
+	case hwmon_temp_emergency:
+		return max6639_temp_set_emergency(data, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t max6639_temp_is_visible(const void *_data, u32 attr, int channel)
+{
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_fault:
+	case hwmon_temp_max_alarm:
+	case hwmon_temp_crit_alarm:
+	case hwmon_temp_emergency_alarm:
+		return 0444;
+	case hwmon_temp_max:
+	case hwmon_temp_crit:
+	case hwmon_temp_emergency:
+		return 0644;
+	default:
+		return 0;
+	}
+}
+
+static int max6639_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_fan:
+		return max6639_read_fan(dev, attr, channel, val);
+	case hwmon_pwm:
+		return max6639_read_pwm(dev, attr, channel, val);
+	case hwmon_temp:
+		return max6639_read_temp(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
 
-	return sprintf(buf, "%d\n", !!(val & (1 << attr->index)));
+static int max6639_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_pwm:
+		return max6639_write_pwm(dev, attr, channel, val);
+	case hwmon_temp:
+		return max6639_write_temp(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t max6639_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		return max6639_fan_is_visible(data, attr, channel);
+	case hwmon_pwm:
+		return max6639_pwm_is_visible(data, attr, channel);
+	case hwmon_temp:
+		return max6639_temp_is_visible(data, attr, channel);
+	default:
+		return 0;
+	}
 }
 
-static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_input, 0);
-static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_input, 1);
-static SENSOR_DEVICE_ATTR_RO(temp1_fault, temp_fault, 0);
-static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp_fault, 1);
-static SENSOR_DEVICE_ATTR_RW(temp1_max, temp_max, 0);
-static SENSOR_DEVICE_ATTR_RW(temp2_max, temp_max, 1);
-static SENSOR_DEVICE_ATTR_RW(temp1_crit, temp_crit, 0);
-static SENSOR_DEVICE_ATTR_RW(temp2_crit, temp_crit, 1);
-static SENSOR_DEVICE_ATTR_RW(temp1_emergency, temp_emergency, 0);
-static SENSOR_DEVICE_ATTR_RW(temp2_emergency, temp_emergency, 1);
-static SENSOR_DEVICE_ATTR_RW(pwm1, pwm, 0);
-static SENSOR_DEVICE_ATTR_RW(pwm2, pwm, 1);
-static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0);
-static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1);
-static SENSOR_DEVICE_ATTR_RO(fan1_fault, alarm, 1);
-static SENSOR_DEVICE_ATTR_RO(fan2_fault, alarm, 0);
-static SENSOR_DEVICE_ATTR_RO(temp1_max_alarm, alarm, 3);
-static SENSOR_DEVICE_ATTR_RO(temp2_max_alarm, alarm, 2);
-static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 7);
-static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 6);
-static SENSOR_DEVICE_ATTR_RO(temp1_emergency_alarm, alarm, 5);
-static SENSOR_DEVICE_ATTR_RO(temp2_emergency_alarm, alarm, 4);
-
-
-static struct attribute *max6639_attrs[] = {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp2_input.dev_attr.attr,
-	&sensor_dev_attr_temp1_fault.dev_attr.attr,
-	&sensor_dev_attr_temp2_fault.dev_attr.attr,
-	&sensor_dev_attr_temp1_max.dev_attr.attr,
-	&sensor_dev_attr_temp2_max.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit.dev_attr.attr,
-	&sensor_dev_attr_temp2_crit.dev_attr.attr,
-	&sensor_dev_attr_temp1_emergency.dev_attr.attr,
-	&sensor_dev_attr_temp2_emergency.dev_attr.attr,
-	&sensor_dev_attr_pwm1.dev_attr.attr,
-	&sensor_dev_attr_pwm2.dev_attr.attr,
-	&sensor_dev_attr_fan1_input.dev_attr.attr,
-	&sensor_dev_attr_fan2_input.dev_attr.attr,
-	&sensor_dev_attr_fan1_fault.dev_attr.attr,
-	&sensor_dev_attr_fan2_fault.dev_attr.attr,
-	&sensor_dev_attr_temp1_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_max_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_crit_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_crit_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp1_emergency_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_emergency_alarm.dev_attr.attr,
+static const struct hwmon_channel_info * const max6639_info[] = {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_FAULT),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_ALARM,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
+			   HWMON_T_EMERGENCY_ALARM),
 	NULL
 };
-ATTRIBUTE_GROUPS(max6639);
+
+static const struct hwmon_ops max6639_hwmon_ops = {
+	.is_visible = max6639_is_visible,
+	.read = max6639_read,
+	.write = max6639_write,
+};
+
+static const struct hwmon_chip_info max6639_chip_info = {
+	.ops = &max6639_hwmon_ops,
+	.info = max6639_info,
+};
 
 /*
  *  returns respective index in rpm_ranges table
@@ -355,11 +484,6 @@ static int rpm_range_to_reg(int range)
 	return 1; /* default: 4000 RPM */
 }
 
-static int max6639_set_ppr(struct max6639_data *data, u8 channel, u8 ppr)
-{
-	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr << 6);
-}
-
 static int max6639_init_client(struct i2c_client *client,
 			       struct max6639_data *data)
 {
@@ -380,30 +504,34 @@ static int max6639_init_client(struct i2c_client *client,
 		ppr = max6639_info->ppr;
 	else
 		ppr = 2;
-	ppr -= 1;
+
+	data->ppr[0] = ppr;
+	data->ppr[1] = ppr;
 
 	if (max6639_info)
 		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
-	data->rpm_range = rpm_range;
+	data->rpm_range[0] = rpm_range;
+	data->rpm_range[1] = rpm_range;
 
 	for (i = 0; i < MAX6639_NUM_CHANNELS; i++) {
-
 		/* Set Fan pulse per revolution */
-		err = max6639_set_ppr(data, i, ppr);
+		err = max6639_set_ppr(data, i, data->ppr[i]);
 		if (err)
 			return err;
 
 		/* Fans config PWM, RPM */
 		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG1(i),
-				   MAX6639_FAN_CONFIG1_PWM | rpm_range);
+				   MAX6639_FAN_CONFIG1_PWM | data->rpm_range[i]);
 		if (err)
 			return err;
 
 		/* Fans PWM polarity high by default */
-		if (max6639_info && max6639_info->pwm_polarity == 0)
-			err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
-		else
-			err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
+		if (max6639_info) {
+			if (max6639_info->pwm_polarity == 0)
+				err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
+			else
+				err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
+		}
 		if (err)
 			return err;
 
@@ -534,9 +662,10 @@ static int max6639_probe(struct i2c_client *client)
 	if (err < 0)
 		return err;
 
-	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
-							   data,
-							   max6639_groups);
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+							 data, &max6639_chip_info,
+							 NULL);
+
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 

base-commit: 5124d9acf3af50bcc6d0958db4fecb3c2f13f8ed
-- 
2.42.0


