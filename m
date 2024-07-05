Return-Path: <linux-kernel+bounces-242918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E8F928ED2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C921C21AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04C513C9A2;
	Fri,  5 Jul 2024 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwLtBgrk"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BD116A934;
	Fri,  5 Jul 2024 21:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215359; cv=none; b=hG9cllgEfn2v3ErXCl6MARyM1MUxWFqUAZI6OWv7SZhQ2HjFomBuz6BX8f+hX6TyhEN5rApYCPCLfAfosJBWzz9FhtQqxjzA3kaGKE3D5F+U1jg8Ipjol8GfQjRkWHoZF+WtSsFwld+p3U550kTWvDKc3FjZk9ORMnHiifzR4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215359; c=relaxed/simple;
	bh=DNIKHWcQCZGQz+jiYNyyjUeuzr9URx7hl/xqvWQnzvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXunIhOedOnePtKV77G3V/J5zVEwZsR8n4xzKbRshIAH9Jolo4dUw+OjQhmS/q1CDZKK2/tqQVeBPg6s4uClcjTdFSzino2stubNDfBo1Zi74ARCD/6xiD1YHzcu/GuzCSLAkom64HitdN8VvcpFWiZ91SZEKW0BmQm0cDjfjI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwLtBgrk; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1231384a12.2;
        Fri, 05 Jul 2024 14:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215356; x=1720820156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quPhHnTfwd9Eqj/ojIrYnZWBNLBixE3EyDPxmdiayU4=;
        b=jwLtBgrkuqMOXB/r8KS/8wa01d9GyzdvEUB7idqT6FhCRSrFT0ziqkxOhknIoTIs8L
         yAS1AW6dcEeCQs6pXILhn6fgZIYNfXkGxbqs4PmJWf70Aq8WJkyQfEMBwinQxwoicoxO
         HlTgoWGxJ5XVlbVwvEo2Nd2mKOx3UX8JgOUWfLYLxBa+w8cxUehklAkVwFWXyZY1fypH
         0Qx/qBiqemol7ANz4XKs32ZRiZs5UTKIKBKewLBsdsuEqvPvl1R2FphE6FynY2x6vR8/
         aAeQb+c8mmprjkof0tuDir2prSkS4WAOH/GMoMh5cjxk8tP5hAhRLMsP5viXHozQBI2l
         yRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215356; x=1720820156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=quPhHnTfwd9Eqj/ojIrYnZWBNLBixE3EyDPxmdiayU4=;
        b=gDXGTgIHsBWb6XX50gx0sqDaTte8CIiA8+tLEkiOwVO2zOTAClCyjA+IpA4Du8gl5V
         Qtz7YQ2s5k3mQ+axC36skhj9YAstyGB1U1V4TG4mApkn+4MukrduNtgr7bGwmjwcoC61
         0cXlKS2+N2EicVSmBcWSkipqWEbRxdd4VTgzZ1wpXh+l7bhKIJ7BpA7yQGtewF4PUDAl
         +ahdGGjyn6+2bQuguBGXJJR43qyniTxMWtHNj+g6xMQOcL3w2bksT98QjooRNJjKBbkA
         eKZ9Yc+UVAAeyfVQQmNBdoP1FR4IVjKHx7znySiGf0RGggdwGw5Uqw5oIIkWYyyNNdBm
         wBhw==
X-Gm-Message-State: AOJu0Yyba1/iqkM5QXieZdArDceZvU3v1zZ7jdhX6gdp8UpR7FL/9Cd1
	aO3Y5FkRN9lGyjMwQkVEqZSIwTZUX3NYvINIDCnYQ4abKr7CNEuAnFw9iw==
X-Google-Smtp-Source: AGHT+IFMWHeX9OnPlL96Emc/im+u0ZIzCDz+oeUrqCvE13YIbFZrWTtwNtgNVdq+294kK7nLAGc8zQ==
X-Received: by 2002:a05:6a20:2449:b0:1bd:28b9:6f88 with SMTP id adf61e73a8af0-1c0cc7422d3mr6688626637.24.1720215356343;
        Fri, 05 Jul 2024 14:35:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb5e2f37desm4350525ad.166.2024.07.05.14.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:35:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 03/11] hwmon: (amc6821) Rename fan1_div to fan1_pulses
Date: Fri,  5 Jul 2024 14:35:39 -0700
Message-Id: <20240705213547.1155690-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705213547.1155690-1-linux@roeck-us.net>
References: <20240705213547.1155690-1-linux@roeck-us.net>
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
v4: No change

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


