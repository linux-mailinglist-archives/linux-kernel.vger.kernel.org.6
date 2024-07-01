Return-Path: <linux-kernel+bounces-237040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A9F91EA33
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D681C2122A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CBC172BAD;
	Mon,  1 Jul 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgWzcWoy"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB342171E58;
	Mon,  1 Jul 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869038; cv=none; b=rcqWoiLspX3qWhu7hdsy9ZWRoo3PuM3bu/Fu9m3yQvxocx54FMbHeW3j2YOfsl4wsCqdBGI9t8zDjzbRm1sF94pKule0X+SD+Id4IF/I0iRILF+k1lysqKd45YWe6Y7sgfWTjqK6hTlnqpd+aHvQ8pXUTxGRDdP15CVRfZwuFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869038; c=relaxed/simple;
	bh=CqB+VNcXP1Nl0fPDDpfijIsB2LJx7LhGZyddAwfay/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bITBXgqXQzZctTCHvIy1/6bFLqynqilR3NYcl5O+Fk/PgD2uyDNlUFk2sK2VMZfVD7K2+G7tbQXUpFGEcPiTND1Q3ymQhCkvqX6R+OBiPTdfMWFXWZewqwODhMsNvKr25BHf2Ri73NoeBe4NzCIhA0UvADr+vrIT564A2QLijhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgWzcWoy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-70b2421471aso2087608a12.0;
        Mon, 01 Jul 2024 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869036; x=1720473836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcBcMrVYxfSOpGlKyqBSRUtROv7w28yE9/aoEhvsmPM=;
        b=YgWzcWoyYCIVO6NDZHDI1bzIV4r3TClfJ1HWxDAA32zFHDnRKS4IK7pXObF9k2+3US
         atmM3JeseV0z+H4tEok4BuAgw01RJn6xcZKXLxNICSDOncw1dsHUcbUR9HtwzgtIKpik
         Y1Wzml7YJhCXUVPi5e/Ttx8wCkJsEY05Dg0wLRbHcyV+RrGLemLk9coCrElNrO4j3BN6
         auIL+N/nB267olESIUbY1ya1Eo2Zu6Md3lxoU1yLoL0MUDuRhXwWLyj2CQSQyOMjjn+1
         K2+ZHue+G5NKHY7+bd8geGvAb+paMtJIMSDDoJw+rbNmO3ohB4Ie24SeyhuU79e5XY52
         BaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869036; x=1720473836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lcBcMrVYxfSOpGlKyqBSRUtROv7w28yE9/aoEhvsmPM=;
        b=ig9bAQc1DVFX48DAAVuMaW4DsypBM0nx5lZHlPVu0QI1mBCbsWvv2F5uC3PbjN2WLW
         hDtdWK812PZByRyjkrho/8J5lWT20YIMmKZHfrFf8D9UZj/LQYuiXyTUrBT800sVNTcm
         AU8bzOGajZzcOkd2u1qQ1geGjVHX/nisag5+0dd5sZ3KwH8Z4DqApsoXG1jLO46Op17N
         dDCiV/8IIoQ5VaGBNBBaegHRi2W6teSyN3YmAIWxYQlOqqi6BpudP6BQS2QUrRmJsBQW
         pEHSm3uJtRzAORteZPnuIuvSYB9CoCD2/zF1hWHLz1WLs+nYQYtAyqWxPmI6yQblcDkN
         z2lQ==
X-Gm-Message-State: AOJu0YymG7VyrI+p6OKcVmcGMHuWkUmDmEIjlutU/0yHydbczcn+jI3c
	9wJOeceg7V6mRKEyelMQ/GVVB5Z6VdgD1XKcTv3TienVkBy3mv6n9qpkJQ==
X-Google-Smtp-Source: AGHT+IFfEzCXtaZQKrs9KO3NuSgl29NW7Xj55k2pUxT02U/Ud5h33ovlgRKzzurYwvKyKJQ2j2E+mQ==
X-Received: by 2002:a05:6a20:3ca5:b0:1be:e1d1:7ea8 with SMTP id adf61e73a8af0-1bef60f2070mr6169211637.1.1719869035664;
        Mon, 01 Jul 2024 14:23:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080295b982sm7215765b3a.94.2024.07.01.14.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:23:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 03/11] hwmon: (amc6821) Rename fan1_div to fan1_pulses
Date: Mon,  1 Jul 2024 14:23:40 -0700
Message-Id: <20240701212348.1670617-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701212348.1670617-1-linux@roeck-us.net>
References: <20240701212348.1670617-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chip does not have a fan divisor. What it does have is a configuration
to set either 2 or 4 pulses per fan rotation. Rename the attribute to
reflect its use. Update documentation accordingly.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add Quentin's Reviewed-by: tag

 Documentation/hwmon/amc6821.rst |  2 +-
 drivers/hwmon/amc6821.c         | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/amc6821.rst b/Documentation/hwmon/amc6821.rst
index 5ddb2849da90..4ce67c268e52 100644
--- a/Documentation/hwmon/amc6821.rst
+++ b/Documentation/hwmon/amc6821.rst
@@ -47,7 +47,7 @@ fan1_input		ro	tachometer speed
 fan1_min		rw	"
 fan1_max		rw	"
 fan1_fault		ro	"
-fan1_div		rw	Fan divisor can be either 2 or 4.
+fan1_pulses		rw	Pulses per revolution can be either 2 or 4.
 
 pwm1			rw	pwm1
 pwm1_enable		rw	regulator mode, 1=open loop, 2=fan controlled
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 9c19d4d278ec..ed98d470a308 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -148,7 +148,7 @@ struct amc6821_data {
 	int temp[TEMP_IDX_LEN];
 
 	u16 fan[FAN1_IDX_LEN];
-	u8 fan1_div;
+	u8 fan1_pulses;
 
 	u8 pwm1;
 	u8 temp1_auto_point_temp[3];
@@ -193,9 +193,9 @@ static struct amc6821_data *amc6821_update_device(struct device *dev)
 					client,
 					fan_reg_hi[i]) << 8;
 		}
-		data->fan1_div = i2c_smbus_read_byte_data(client,
+		data->fan1_pulses = i2c_smbus_read_byte_data(client,
 			AMC6821_REG_CONF4);
-		data->fan1_div = data->fan1_div & AMC6821_CONF4_PSPR ? 4 : 2;
+		data->fan1_pulses = data->fan1_pulses & AMC6821_CONF4_PSPR ? 4 : 2;
 
 		data->pwm1_auto_point_pwm[0] = 0;
 		data->pwm1_auto_point_pwm[2] = 255;
@@ -647,16 +647,16 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t fan1_div_show(struct device *dev,
-			     struct device_attribute *devattr, char *buf)
+static ssize_t fan1_pulses_show(struct device *dev,
+				struct device_attribute *devattr, char *buf)
 {
 	struct amc6821_data *data = amc6821_update_device(dev);
-	return sprintf(buf, "%d\n", data->fan1_div);
+	return sprintf(buf, "%d\n", data->fan1_pulses);
 }
 
-static ssize_t fan1_div_store(struct device *dev,
-			      struct device_attribute *attr, const char *buf,
-			      size_t count)
+static ssize_t fan1_pulses_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
 {
 	struct amc6821_data *data = dev_get_drvdata(dev);
 	struct i2c_client *client = data->client;
@@ -676,11 +676,11 @@ static ssize_t fan1_div_store(struct device *dev,
 	switch (val) {
 	case 2:
 		config &= ~AMC6821_CONF4_PSPR;
-		data->fan1_div = 2;
+		data->fan1_pulses = 2;
 		break;
 	case 4:
 		config |= AMC6821_CONF4_PSPR;
-		data->fan1_div = 4;
+		data->fan1_pulses = 4;
 		break;
 	default:
 		count = -EINVAL;
@@ -715,7 +715,7 @@ static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, IDX_FAN1_INPUT);
 static SENSOR_DEVICE_ATTR_RW(fan1_min, fan, IDX_FAN1_MIN);
 static SENSOR_DEVICE_ATTR_RW(fan1_max, fan, IDX_FAN1_MAX);
 static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan1_fault, 0);
-static SENSOR_DEVICE_ATTR_RW(fan1_div, fan1_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan1_pulses, fan1_pulses, 0);
 
 static SENSOR_DEVICE_ATTR_RW(pwm1, pwm1, 0);
 static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm1_enable, 0);
@@ -758,7 +758,7 @@ static struct attribute *amc6821_attrs[] = {
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_max.dev_attr.attr,
 	&sensor_dev_attr_fan1_fault.dev_attr.attr,
-	&sensor_dev_attr_fan1_div.dev_attr.attr,
+	&sensor_dev_attr_fan1_pulses.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
 	&sensor_dev_attr_pwm1_enable.dev_attr.attr,
 	&sensor_dev_attr_pwm1_auto_channels_temp.dev_attr.attr,
-- 
2.39.2


