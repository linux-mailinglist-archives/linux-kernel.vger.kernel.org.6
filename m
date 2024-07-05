Return-Path: <linux-kernel+bounces-242919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD544928ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EAB2B21DB4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C39145B3B;
	Fri,  5 Jul 2024 21:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVfMpB/X"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0799116F851;
	Fri,  5 Jul 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215360; cv=none; b=V9HMrWVs/jjicm6TvN5mGmVNGJ0Egcim3BFP4MO4uMPLhZnxq6w68bRxWCBARGYywKeVxSf+s9V7+DoqtfVL/UWUyTvRQGN935LJEJicEs3cQBYGB83eM+QOGRYCPZz13jdyUz1S6b4FnhWS9e8ASRDGGBhCEIQ/APdqKMmQpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215360; c=relaxed/simple;
	bh=hKR4EqvgPF/ta+GBfbq6/daAaoOQeqZWSB7qC393jkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EnwRb6/tosHh/lx1gD5i190o7Y05UBlVH5vXSjNwhEWB12ZGUkC1aAXsehtLHP+YXnbdVuZFftpZcBgZkJAvvvJmG7lRgMlNxUFX2Wt4gecsd46ggzOCoLEJPSPPG27r93ZT7/dBri49bz7InuQPTOjYT4t6PeVCXVvAkDWqv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVfMpB/X; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70b12572bd8so642975b3a.2;
        Fri, 05 Jul 2024 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215358; x=1720820158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc093wpBM6LNFe2Wuit1fA24HJdVtIXzQkJANhf3X90=;
        b=WVfMpB/Xc8lWlA5apku1DSPCc06FUwX/BtvlRPVjinAWZSjZhUs3xQbDVvu3dJekhw
         33tMMZztaQsoB7w45cZX8kmAaplIEIrqbx8STB/iVZeODT9rjkrfZ2kn5QRTRTkcmbu8
         8KJ9xmo19GVM7Kk6FfL9fZvVdZJxzrQ2VglTnLAntoXsPRjU7xERoPgxxkx+K/j8y5q4
         QKv+zX6ZWcU4YLvaHDtkYvgEmxSbFUAJHFd+V9O77w70MdDfKwq8VtiEYS9cOOp8HEii
         dBycZ0s3voF//zpz2l3OKxFjRWXQUIRYPbIzjkFHQID8opMr229MIVmh2z03WJ+2nPOs
         59tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215358; x=1720820158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mc093wpBM6LNFe2Wuit1fA24HJdVtIXzQkJANhf3X90=;
        b=Gsq4kQZW1bSBcP1HM1Qi/KVzRxu+0b84PMLQR+fMQjwdMt3b9IWpkwfrAmUr7Orley
         KS8HQb5jmEX5t3rDQyLXTfIn0HtqVU4Ci8AIgGyGT4FIthwqG7QDS3ALaJPo7Zz9HieZ
         ui772wDgRxv1nsMAq3ePrRfUZlsOrLFmhdqMSjj/VK5vmllA35bTpmfyA0bBex9p/K+d
         B/FFF7omE/gOvyiq0BVxByIDzFWs/XRTciq/wIuKaLNuTo4U+AaqasumjiPvOKhVQUkT
         1/mlQRTzaLpbq2yL3kIneXV41SxctOOy0aKohjIOPm332if87O7eQdDfLBmylv4f4Nwb
         lAig==
X-Gm-Message-State: AOJu0YyX5btpvBcXZz8m6K0I9DskJe9TjVVYqY8tsfIHy/HhHnchcp8H
	F2yn6vRcq+qnVzvZn849241sWTqhTVHj8ChRH/S660QI/rjYomdISZ3pPQ==
X-Google-Smtp-Source: AGHT+IHstafwGjnCDo3pigTXJhi6+vk7FNa2ic5pDL0oD9V2rwP3nzcPyPAkPrdTmkotWA66MsFrtA==
X-Received: by 2002:a05:6a00:2ea2:b0:70b:171b:304a with SMTP id d2e1a72fcca58-70b171b3441mr1310917b3a.30.1720215357886;
        Fri, 05 Jul 2024 14:35:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70aff86d6c2sm3629092b3a.118.2024.07.05.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:35:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 04/11] hwmon: (amc6821) Add support for fan1_target and pwm1_enable mode 4
Date: Fri,  5 Jul 2024 14:35:40 -0700
Message-Id: <20240705213547.1155690-5-linux@roeck-us.net>
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

After setting fan1_target and setting pwm1_enable to 4,
the fan controller tries to achieve the requested fan speed.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: No change

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


