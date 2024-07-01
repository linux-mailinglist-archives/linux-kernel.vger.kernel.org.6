Return-Path: <linux-kernel+bounces-237041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EC991EA36
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05C8282B05
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29C172BA8;
	Mon,  1 Jul 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhmY328I"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE834172BA7;
	Mon,  1 Jul 2024 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869040; cv=none; b=RS06sIp+64cZyfMxhkwYW5ZXhxOdwZfw9/BED1yFev8OJrEbMJgtj9W6Euz8YIDG0YJszsbpPqZucBKEXlDNKrtRxGKmkn6xL3cgQy1xzhlqDgE9ykR+3xH89Vc0Kh/VCsRkA9+Z6f+Mw/A6RBFfvhoVYxWfKXm6m8TAOXEwBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869040; c=relaxed/simple;
	bh=yr7KgnBlnn4MHLO3e94iSzXYHjx2To5fTXFFFgUWlPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYONkxuRT2I+3bVkNWTlml/dSaQul9RiaTdCCnRXctmi7UrQ6bDIiCWYXUA5IytLXQATL3H3lN0NDZmVttTSVXDf4SvJ8fqmC5baI7zEcdAP8grJRlbCcOVBY/lr1aCXrGdimnArzp1W5Vb/HsCLrwYt7klaT9put6YoT4wgBv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhmY328I; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-706524adf91so2814852b3a.2;
        Mon, 01 Jul 2024 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869037; x=1720473837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOynw5tALStq7JlQfZMm5YT3RcSHQA1ieLjO326B2mo=;
        b=OhmY328IkK+swmAGcDgLN8NC9zDXy3tZ4AdbqVlUJNbdeJzmafPddZKnvwnE+Qf6nz
         rTQs8fr641H75s2+nGlu646NV2TYGOZxkaGusKV3klRispeyVERHzXgnMPgZYpmiMZUL
         m97uV03wEt/F3rmxW115iCj4i+9QXFR3/rSs6UhpRn0JGYYz3p5gIzG99UekwsgDC6SN
         m+xaNm6gKjPOBK/95mw+W5dwplAqwoPQjAMTuHcV8D8urhl+klCcEhYHw3IFleOY/YwZ
         0NjTrl/ncF43VjrXz8O8BGWD7p1fA2EdNXDsSAZaEWxurFfAf6TVSEH7iEG/Awctkeus
         fzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869037; x=1720473837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZOynw5tALStq7JlQfZMm5YT3RcSHQA1ieLjO326B2mo=;
        b=mvonPKaqCt38atKHVZTMS2DyDOedego9Uj+39tHDSXk12dCPGLzvgkwq2Vxc9XGTgc
         lOpt6WN9KPP8IWTsd+wGYUvCdp3HfG6xMDL/JBLLPJEiIXLlzyXvAUDnJcXoQQkfm2hh
         SjINt4JlArdo6WzR/Lq4G/GKo7NoVVqilIdy1xn7CDMhzGTWx3OP1K3MwZYIobq77hLC
         MjWWwEkJjWHL3KVVaM5qEu5luZP0P3Xy43ieB7KEfXEagFHgNQjMIViWnBOay+Kh21O7
         etcswOiaZyTO27TvyFj/AWjRBcJw09igC8nw+XgnGpNUCqALNE7V21pKpYt4on00SX4E
         bpBw==
X-Gm-Message-State: AOJu0YxXQu+0ihk1tGVTRc488pPLtHclkMkMMPqCjujgiKzmr9LmECRR
	DHskBxzJ2dKOy2XD/A/6+AmMtjqIOI1togmliF8vKI0np0v0Ho36dVkb9w==
X-Google-Smtp-Source: AGHT+IFgirt6QyPd9S9HzJitZM83cHBdnkh6CDr8EOD64Yghy2EQZx0wjbB6imfIBwmKkcRNFXoGvQ==
X-Received: by 2002:a05:6a00:3c8e:b0:705:c0a1:61d8 with SMTP id d2e1a72fcca58-70aaad2af71mr8982010b3a.4.1719869037229;
        Mon, 01 Jul 2024 14:23:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a8ed66sm7000232b3a.194.2024.07.01.14.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:23:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 04/11] hwmon: (amc6821) Add support for fan1_target and pwm1_enable mode 4
Date: Mon,  1 Jul 2024 14:23:41 -0700
Message-Id: <20240701212348.1670617-5-linux@roeck-us.net>
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

After setting fan1_target and setting pwm1_enable to 4,
the fan controller tries to achieve the requested fan speed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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
index ed98d470a308..caf720ff674c 100644
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
@@ -623,8 +630,8 @@ static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	/* The minimum fan speed must not be unlimited (0) */
-	if (ix == IDX_FAN1_MIN && !val)
+	/* Minimum and target fan speed must not be unlimited (0) */
+	if ((ix == IDX_FAN1_MIN || ix == IDX_FAN1_TARGET) && !val)
 		return -EINVAL;
 
 	val = val > 0 ? 6000000 / clamp_val(val, 1, 6000000) : 0;
@@ -714,6 +721,7 @@ static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, temp_alarm, IDX_TEMP2_CRIT);
 static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, IDX_FAN1_INPUT);
 static SENSOR_DEVICE_ATTR_RW(fan1_min, fan, IDX_FAN1_MIN);
 static SENSOR_DEVICE_ATTR_RW(fan1_max, fan, IDX_FAN1_MAX);
+static SENSOR_DEVICE_ATTR_RW(fan1_target, fan, IDX_FAN1_TARGET);
 static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan1_fault, 0);
 static SENSOR_DEVICE_ATTR_RW(fan1_pulses, fan1_pulses, 0);
 
@@ -757,6 +765,7 @@ static struct attribute *amc6821_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_max.dev_attr.attr,
+	&sensor_dev_attr_fan1_target.dev_attr.attr,
 	&sensor_dev_attr_fan1_fault.dev_attr.attr,
 	&sensor_dev_attr_fan1_pulses.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
-- 
2.39.2


