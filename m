Return-Path: <linux-kernel+bounces-234100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2BF91C23B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B85284189
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AFC1C232E;
	Fri, 28 Jun 2024 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAYyVwcY"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31471C68B0;
	Fri, 28 Jun 2024 15:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587640; cv=none; b=szoN00DgCS6Mqy0bdm6v92l/bb1PujlmOCmeXD3E8PDe6gGOvdJTLl5QzotxFhjy8vdyTsLCZxmLyyHQNzSpWgvKTrgqFcJVrGPVVkT2K1QCVXxryi5UCmsYZ/jWQRhmvrKK/iQh7cXUVq1HY5Y46yVPAHzzpX+/ZvioYGZnrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587640; c=relaxed/simple;
	bh=HkjQXDqoq4CW9BM40Ocb/uoZr3Zx/2lsLABP+q5jUAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i66YIQz/3Ho3nmA1817XJ0nnFzfwBnByt6rLAZDYx+vaf+8gHXab54pJ38Djx/A38pvGVTUoS2To/J6/RfyfRlmyEp4zV923DGZ0oYgtu+1XSr+G/KRFjuOYmvQVly9Xy7my0MYXmBg4WxnjJmUxf+kF5H5cbxRxByuKXJeNbv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAYyVwcY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7163489149eso532206a12.1;
        Fri, 28 Jun 2024 08:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587638; x=1720192438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejEx78WKXom23aFc7lD9B6dUuYkDYrO71Mml1PP5MG8=;
        b=GAYyVwcYs+r3rFKaM7N+NQuc8uyIqQiHObGGWtvm+c8uW4ftXQtrXkDC7ZEC57yT2r
         61RR0PP9GxCbYZskxKD9WVwrwUKFxOsTqHMsehlcwC88TOU59Wyjed544rc6qZAchCd8
         +LbBrKKDiiAjMeMflajwN2GHQaVLNCpu6CIEo72iHtFJ/OUYaoKTmLXWj+8Og1rkGXu3
         WSwnd5KQhaS6vmta3OkAhtN6t6GVB5EOOOEHbV0yeqV2dTgmPEtAZENxiPbPcFdBFxqc
         GuTA3GunC0abDop72AWZWp5WR/NSh6Y7jr1qYGHomi3hlN7aOLtTpQGk3CJBFgg8/99s
         q+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587638; x=1720192438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ejEx78WKXom23aFc7lD9B6dUuYkDYrO71Mml1PP5MG8=;
        b=UmKriVUvMpGR76IcToSVmfDTwqicjyA+5jvJ8fXHnoqCnPSbV+H2Pv7xUOszYb1HKH
         PsAebz68suTsDvLlu8NaP+LKxrA7B1Ma45h3+xE015uzwHtkFu8VIDqoh8/F5dos/qbG
         QbtB7ZI7l4yrQ8MRhli/nS10k8kLHJjj/PyXn+elotbqcWwyDLzmSX622erql6zBj/aF
         1Cea2e77Z/0rK8/Hf+Ukb4/5OuMhaq3Hdd0qnOUh++buLYpHNALOoqleMW6lq8oOzIkK
         mN86Kj0bnz/R/xpHsfZvwpLqmFI5xKwYe6n6g7LCH7YhBqFPwybKeK/bpbvii1mWd8Tm
         8dFA==
X-Gm-Message-State: AOJu0Yw1kWs6Ff/ZMlqZRcfwmID7voPQoPkq2WQdvXTrD87/IqAGApIo
	S5P4PUSE0fyCegRAsHzPOPayopktRsDONF6GvswaNT/2M60neT5PagQd3w==
X-Google-Smtp-Source: AGHT+IHp1Jij6wrmYCVNwQm3eVA7ft0BIW+QlXbEXxyUfgEx8/Nxa8iHnjYYaw6wICjCikkPtRk/Zw==
X-Received: by 2002:a05:6a21:394c:b0:1be:d0c8:d562 with SMTP id adf61e73a8af0-1bed0c8d7a1mr6940727637.37.1719587637550;
        Fri, 28 Jun 2024 08:13:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1537373sm16359605ad.135.2024.06.28.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:13:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/10] hwmon: (amc6821) Rename fan1_div to fan1_pulses
Date: Fri, 28 Jun 2024 08:13:39 -0700
Message-Id: <20240628151346.1152838-4-linux@roeck-us.net>
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

The chip does not have a fan divisor. What it does have is a configuration
to set either 2 or 4 pulses per fan rotation. Rename the attribute to
reflect its use. Update documentation accordingly.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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
index e37257ae1a6b..6eb7edd9aca9 100644
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
@@ -645,16 +645,16 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
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
@@ -674,11 +674,11 @@ static ssize_t fan1_div_store(struct device *dev,
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
@@ -713,7 +713,7 @@ static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, IDX_FAN1_INPUT);
 static SENSOR_DEVICE_ATTR_RW(fan1_min, fan, IDX_FAN1_MIN);
 static SENSOR_DEVICE_ATTR_RW(fan1_max, fan, IDX_FAN1_MAX);
 static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan1_fault, 0);
-static SENSOR_DEVICE_ATTR_RW(fan1_div, fan1_div, 0);
+static SENSOR_DEVICE_ATTR_RW(fan1_pulses, fan1_pulses, 0);
 
 static SENSOR_DEVICE_ATTR_RW(pwm1, pwm1, 0);
 static SENSOR_DEVICE_ATTR_RW(pwm1_enable, pwm1_enable, 0);
@@ -756,7 +756,7 @@ static struct attribute *amc6821_attrs[] = {
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


