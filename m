Return-Path: <linux-kernel+bounces-241562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61DB927C92
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154E41C231AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A2113B5A2;
	Thu,  4 Jul 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM/pdprJ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868C136E28;
	Thu,  4 Jul 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115539; cv=none; b=asme/SD7YqjX4g22J++gy7qgn/uoTkz5xqaivWB3obKFNkgELfcshOa1Oqi7z5SNI2GURNbcd+q2vRfNlUMXU3mDq++xthoPjnwZu73OAzKQNbt3t1VNakIJ43ozf9Ynr7+7X0w0dDBWU/5aiiUtiEZV8MjDOQCJxJGOXYX4wWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115539; c=relaxed/simple;
	bh=mwILBdHcZfebWSqaaYSkS2Y3rUPXgv34/I/iXl3Y8aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bv8KLx14vs8BVPrY7hTZo5788Gn5Zz2Q4S+i+EQvV8Odk3AkRj5R01MLr7AuZaAqqcVeJf8v0A7F47d4U5rlxish78MEEGigNfxR5Nq3GkswRRwm4Q726KHENbR0WB85y4qT1l93VZVj8+8ZzYSDXW4iC6oLfAJHTywZS/X8yaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM/pdprJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb3cf78fcaso3863805ad.1;
        Thu, 04 Jul 2024 10:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115537; x=1720720337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlNsjlv4wofRlX5IY9fP/8A6hzQNriYNSbXKhp6SETA=;
        b=BM/pdprJO70fXz7zs6aQcoS00juKGyBUdrueKM51gAsrWtq/4z2Zy5SD+VHLtKtnnI
         s+snRVWVYgaCQB9i4PbcfO1KeTGkAykSxh2pwAxMj0He3YsQ1O15UAkZjXMF8/1e624d
         f03G+CYtOuMULoxbj2QVlT4ypPvCDUSe9XpYCmw59i5bSjoN7DaLGvTeXw55aNhdCikd
         w0Bezd5cGiUcKo8oGhsFQlg2LesLBrWAAuLP/evXlCOunlpy2tJVeSkNIicdLaPHUbty
         5CJXn4hYWER0a0NrekycyV42OMMal9+e8+eV2pPgt7U9VknPjBIDud0g2/R+aOIwkh+8
         RfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115537; x=1720720337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NlNsjlv4wofRlX5IY9fP/8A6hzQNriYNSbXKhp6SETA=;
        b=T+E1olEakEKbQUIFrY5+kAYSpGBCVJOR21RJaJMkln3LjqZbQsWK1TaU5VIvziPAAc
         gGNU3V+zpn0udTz8z7DMWwuINmzY34ONhBXNDul/3XMAehfxVBH2dXxSaR3oOfshGJmF
         173+yNssTfuJ4LunOYB5eYh4s6/LfGKK5x9qSBHHA2A6VmmTFVPqOsAqcNQ2W/DiVJMz
         v9RETyrwWtOtL/Xtpm/PpXHjpRp//Mqwkhy4H8CiQWtmFWrhOElmY5NTM6nZBhdY0mI8
         E4Or6W2D2uRRJoXqTFs8oBmw20jsDtMF5X920ctipE/JVGfvqiDKlzhwCwXO/1kvwbGf
         Hg3g==
X-Gm-Message-State: AOJu0Yxn3d/mHGQYeR7xde4AMSrcNAZV2c1wNpvZBALEANjpPWqGsZud
	bHVH0mc7kkbQFG1H+YP/yIVJDn3w/Y5qEaJ+c6NRBA+0MJE9nUOx1/8AUw==
X-Google-Smtp-Source: AGHT+IF5LB0+VOe+GAJsZFzIWnqvP+X3DDyY2xVjkqDGdj8cbFUAxmow95yhGCuNw+PVp4dFevkVqQ==
X-Received: by 2002:a17:902:c945:b0:1fb:4194:5b7a with SMTP id d9443c01a7336-1fb419460c3mr6507235ad.8.1720115536638;
        Thu, 04 Jul 2024 10:52:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e22a1sm125688225ad.69.2024.07.04.10.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 03/11] hwmon: (amc6821) Rename fan1_div to fan1_pulses
Date: Thu,  4 Jul 2024 10:51:59 -0700
Message-Id: <20240704175207.2684012-4-linux@roeck-us.net>
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

The chip does not have a fan divisor. What it does have is a configuration
to set either 2 or 4 pulses per fan rotation. Rename the attribute to
reflect its use. Update documentation accordingly.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: No change

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
index 8e3cc33d8073..39bf52a5c432 100644
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
@@ -646,16 +646,16 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
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
@@ -675,11 +675,11 @@ static ssize_t fan1_div_store(struct device *dev,
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
@@ -714,7 +714,7 @@ static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, IDX_FAN1_INPUT);
 static SENSOR_DEVICE_ATTR_RW(fan1_min, fan, IDX_FAN1_MIN);
 static SENSOR_DEVICE_ATTR_RW(fan1_max, fan, IDX_FAN1_MAX);
 static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan1_fault, 0);
-static SENSOR_DEVICE_ATTR_RW(fan1_div, fan1_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan1_pulses, fan1_pulses, 0);
 
 static SENSOR_DEVICE_ATTR_RW(pwm1, pwm1, 0);
 static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm1_enable, 0);
@@ -757,7 +757,7 @@ static struct attribute *amc6821_attrs[] = {
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


