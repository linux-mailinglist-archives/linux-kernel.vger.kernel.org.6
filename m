Return-Path: <linux-kernel+bounces-241563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902FE927C94
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FD61C22F13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0248813C83A;
	Thu,  4 Jul 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIfDrotV"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6113AA3F;
	Thu,  4 Jul 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115541; cv=none; b=OXxUkrZSMw6+zZojeoovVy1xHeEcsz2BtlYMXJX4k3aiBPUyA55s8WFv41EPhfWrFcV73QzuyeJH6eM4v4MKfj2i+46imnvfrXQa+uTr7YNxY3xVpSpdzkaiWePBbr/Ok4cbBpEnOgiE9uQcSsXZMK49oP9xI/MdlueoyfEWc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115541; c=relaxed/simple;
	bh=flURxScC6rVK1ybyxxQfoO/FO5A0DRe3BhOPbG5BG3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YYo5H+p58Nez0TvXR9ZAmQ0Tjlf420DYDnKJQ5tXHXWnCBa0i6iOvaljCjv3OsTigayatwBDadOeA8cVN+uVQxmkJ+Wwa0Ug2GYgKKA2mLfJBJn58wctGtoigZh/XGur7d7rkS3x3S60Ta4O+lskzt4E5FYBvvqjsAKHJhcjVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIfDrotV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c980b55741so626355a91.2;
        Thu, 04 Jul 2024 10:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115538; x=1720720338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZfv18F/jmPB8t8JHBVdXaAm+p7ucusfmUrNXw6JNmE=;
        b=JIfDrotVXmE3349OhgHXI4ioKgMqvOBZVkffHIS04w/Tju+0un8Cy19EjZv8kDDfdq
         7GLxKd/UUMbp088xeXy2gUOObvM2J0e8fnv8pc3c09aSzM5tgja2wlfQJhu8EoYKx7CI
         LHaOKbMppa5jg+bIEOdKTZgt0Zm8tG4hrPUKvEANJznYBDAzJ/uWA2TkKD02G2YMoKa6
         ZHVjdcEdDItvIQ+jhD+97syRyewrR9V925uMDq111fOuBRFM4AmSDW6jKrXaWS4Hx0Dy
         tH3IZAHFklunybcvCP25Qhaqehtmmz2hfS6PqEBYTMsGmJXgxjepS5Iz5soyUorwZgMQ
         AvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115538; x=1720720338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZfv18F/jmPB8t8JHBVdXaAm+p7ucusfmUrNXw6JNmE=;
        b=gPcGIRXmB9RFcMjxUcizzRtIaFJtxb7CokbURhNWHH9YLn4/2IDlMNLus1pqQ2o7TI
         T/Zw+JrXzSyzLR4fID/nwly+xikw1iYVgN89Mf1cefvu8PN/KruudkoYZ7197UXuyv2t
         fjjx6Vs7AR0eUpBcy4iIPZ2rqaViYLGfxjpFVt+iX3dUET5WLFRVEWr4FaXhBA5LgtZN
         neSaOxBidPzyfSUz8QutsCwucr+YXg711tzSFLUbBxf7ao43U9rI1LMoeZ6fpDSKKXJ3
         6LFDSy62ehZZ11rGdcgcFs/OFFBDA1g+bcV5sQEAXZ5PKDJ5sEulXCf29wiGpbt2L2Tq
         adpg==
X-Gm-Message-State: AOJu0Yys5h2SXETlppB1F6jRx9dJ3P5uat44heaPoVsSwM5RXuU2Durf
	M16paz+X31EambcZgJwBqduw/tR/UQiiYuUlKwJ0gmm3OXSwEviWPfMPbQ==
X-Google-Smtp-Source: AGHT+IF/fPvrZIYWG8IkZZTD4wpJr8HxQzS1mPtmKrDoiAks2QU7XC124aGCHbP6NyjvTmdY1aDBcQ==
X-Received: by 2002:a17:90b:46d3:b0:2c9:635b:7271 with SMTP id 98e67ed59e1d1-2c99c6bf5a3mr1790354a91.21.1720115538211;
        Thu, 04 Jul 2024 10:52:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa895ecsm1795911a91.47.2024.07.04.10.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 04/11] hwmon: (amc6821) Add support for fan1_target and pwm1_enable mode 4
Date: Thu,  4 Jul 2024 10:52:00 -0700
Message-Id: <20240704175207.2684012-5-linux@roeck-us.net>
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

After setting fan1_target and setting pwm1_enable to 4,
the fan controller tries to achieve the requested fan speed.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Add Quentin's Reviewed-by: tag

v2: Do not permit writing negative or unlimited target fan speed

 Documentation/hwmon/amc6821.rst |  4 ++++
 drivers/hwmon/amc6821.c         | 25 +++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/amc6821.rst b/Documentation/hwmon/amc6821.rst
index 4ce67c268e52..96e604c5ea8e 100644
--- a/Documentation/hwmon/amc6821.rst
+++ b/Documentation/hwmon/amc6821.rst
@@ -48,12 +48,16 @@ fan1_min		rw	"
 fan1_max		rw	"
 fan1_fault		ro	"
 fan1_pulses		rw	Pulses per revolution can be either 2 or 4.
+fan1_target		rw	Target fan speed, to be used with pwm1_enable
+				mode 4.
 
 pwm1			rw	pwm1
 pwm1_enable		rw	regulator mode, 1=open loop, 2=fan controlled
 				by remote temperature, 3=fan controlled by
 				combination of the on-chip temperature and
 				remote-sensor temperature,
+				4=fan controlled by target rpm set with
+				fan1_target attribute.
 pwm1_auto_channels_temp ro	1 if pwm_enable==2, 3 if pwm_enable==3
 pwm1_auto_point1_pwm	ro	Hardwired to 0, shared for both
 				temperature channels.
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 39bf52a5c432..9e9a70afbfd4 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -66,6 +66,8 @@ enum chips { amc6821 };
 #define AMC6821_REG_TACH_LLIMITH 0x11
 #define AMC6821_REG_TACH_HLIMITL 0x12
 #define AMC6821_REG_TACH_HLIMITH 0x13
+#define AMC6821_REG_TACH_SETTINGL 0x1e
+#define AMC6821_REG_TACH_SETTINGH 0x1f
 
 #define AMC6821_CONF1_START 0x01
 #define AMC6821_CONF1_FAN_INT_EN 0x02
@@ -122,17 +124,18 @@ static const u8 temp_reg[] = {AMC6821_REG_LTEMP_HI,
 			AMC6821_REG_RTEMP_LIMIT_MAX,
 			AMC6821_REG_RTEMP_CRIT, };
 
-enum {IDX_FAN1_INPUT = 0, IDX_FAN1_MIN, IDX_FAN1_MAX,
+enum {IDX_FAN1_INPUT = 0, IDX_FAN1_MIN, IDX_FAN1_MAX, IDX_FAN1_TARGET,
 	FAN1_IDX_LEN, };
 
 static const u8 fan_reg_low[] = {AMC6821_REG_TDATA_LOW,
 			AMC6821_REG_TACH_LLIMITL,
-			AMC6821_REG_TACH_HLIMITL, };
-
+			AMC6821_REG_TACH_HLIMITL,
+			AMC6821_REG_TACH_SETTINGL, };
 
 static const u8 fan_reg_hi[] = {AMC6821_REG_TDATA_HI,
 			AMC6821_REG_TACH_LLIMITH,
-			AMC6821_REG_TACH_HLIMITH, };
+			AMC6821_REG_TACH_HLIMITH,
+			AMC6821_REG_TACH_SETTINGH, };
 
 /*
  * Client data (each client gets its own)
@@ -250,10 +253,10 @@ static struct amc6821_data *amc6821_update_device(struct device *dev)
 			break;
 		case 1: /*
 			 * semi-open loop: software sets rpm, chip controls
-			 * pwm1, currently not implemented
+			 * pwm1
 			 */
 			data->pwm1_auto_channels_temp = 0;
-			data->pwm1_enable = 0;
+			data->pwm1_enable = 4;
 			break;
 		}
 
@@ -407,6 +410,10 @@ static ssize_t pwm1_enable_store(struct device *dev,
 		config |= AMC6821_CONF1_FDRC0;
 		config |= AMC6821_CONF1_FDRC1;
 		break;
+	case 4:
+		config |= AMC6821_CONF1_FDRC0;
+		config &= ~AMC6821_CONF1_FDRC1;
+		break;
 	default:
 		count = -EINVAL;
 		goto unlock;
@@ -622,8 +629,8 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	/* The minimum fan speed must not be unlimited (0) */
-	if (ix == IDX_FAN1_MIN && !val)
+	/* Minimum and target fan speed must not be unlimited (0) */
+	if ((ix == IDX_FAN1_MIN || ix == IDX_FAN1_TARGET) && !val)
 		return -EINVAL;
 
 	val = val > 0 ? 6000000 / clamp_val(val, 1, 6000000) : 0;
@@ -713,6 +720,7 @@ static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, temp_alarm, IDX_TEMP2_CRIT);
 static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, IDX_FAN1_INPUT);
 static SENSOR_DEVICE_ATTR_RW(fan1_min, fan, IDX_FAN1_MIN);
 static SENSOR_DEVICE_ATTR_RW(fan1_max, fan, IDX_FAN1_MAX);
+static SENSOR_DEVICE_ATTR_RW(fan1_target, fan, IDX_FAN1_TARGET);
 static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan1_fault, 0);
 static SENSOR_DEVICE_ATTR_RW(fan1_pulses, fan1_pulses, 0);
 
@@ -756,6 +764,7 @@ static struct attribute *amc6821_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_max.dev_attr.attr,
+	&sensor_dev_attr_fan1_target.dev_attr.attr,
 	&sensor_dev_attr_fan1_fault.dev_attr.attr,
 	&sensor_dev_attr_fan1_pulses.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
-- 
2.39.2


