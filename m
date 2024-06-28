Return-Path: <linux-kernel+bounces-234101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF90D91C23D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B032841DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77411C8FD8;
	Fri, 28 Jun 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch7kLxbJ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBAA1C232B;
	Fri, 28 Jun 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587642; cv=none; b=flGihgrsKvhHi0fQSogK8gm8dhtBJyaiC9MadupFCjDKQPXE17sMHpzz8vPmuGN0ok/V8PS063yHvpTuxBi2jce63mI8wZQ6MmSGC5DVMfjB0wSOqGJ9HOVfPsG+va/aekIqSxq29Dm+L8sOK2QJhxnyveRLem8D1mGT0NcJbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587642; c=relaxed/simple;
	bh=YSYpn1pimr6FemNkAAjzhVb5FiuVB1chZr+kY8qXBF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQq9Y+tJkgL842NadJvGd14mib4PHVuQ2PvXrCqw6GzAwxDyKAy64MEveou3stjewy9DbAswA3rio/i2FJJ0/ry7rQUqM+DDVxQc9cheAAuRxB41uDd3Or1awptn8K5Ax9OaUNSckdFGRkGrRLDY8xFLNqt2H4OBDO/6YG7IHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch7kLxbJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fa2ea1c443so5408275ad.0;
        Fri, 28 Jun 2024 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587639; x=1720192439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3FT09DFUGTWcjqSb93NRz9BnJQ9+ZX/Fyen/MdZdis=;
        b=ch7kLxbJznlKrRCj6ZhXZkbVMrgqdsOnGvOSpDKfToAmAQkLur3OIVoRnkyF9HJ38H
         Wjmjnn8EmRA/F1aTm9tsX+rkPteAYQwoZPLqtk+vzl698+1uMytgC4iptc4z0zHpY2NU
         8dVwM5xHjPFXpbL3yP0SWRbxOVV1GX3ihoykTZm+JZrUNbX8jNMjyQ75+XcUB2ScHjU9
         oiFzSzegNUSeNzffpbo72LqFCAgQzGF++oSp3331WcCLPHbYgqkYjyifOAqGUtF0jjHk
         YOn+kQ9v35m9YFxNmUcEHR0H+TXJRaUTtuUSh2MpPb1lZI7rO2n2vTi2xGhh3+NBui2x
         ma4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587639; x=1720192439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3FT09DFUGTWcjqSb93NRz9BnJQ9+ZX/Fyen/MdZdis=;
        b=M3sniGSK+8QECYChcBUYvCRdLXEAC7ra5oVRVjoij+gAtHZMjs8gBkFAL7TxiANXfN
         o1Dp9gsZeqf+BX5HOJ+Uy+IT7jB0YkPV2uccgWr/bxRNWf5r0wvHb3KeVCZP5eDURtVb
         boIo8VLRWkYbzdwDd7MGfi1PK3TtTCcfBctROXE+yMk35++Dl71Dd+Frrx36lbLG72BC
         ehykUVB3E15QzZmSC2OE97jU+bkg0Td52W/uTD/n0yLvDVWABvmdXkhi9TitTHnFLCwl
         5QtOnDGbOt1kc43MqVmM21UaYgI4oFckEwQ9oJEmFLcnuo1KNqoRHx/eUMjBI6c1BLvZ
         Pn7A==
X-Gm-Message-State: AOJu0Yz0gS96nnL4BSJWbosfIcpcG2IiFvhaB7CFratePk1CmCLpHUOa
	hVBLhECW8QSqqWxvXgnL6KeDI53kWK66lUpKCOCJ3bpAW9NfEt5/VAEYjg==
X-Google-Smtp-Source: AGHT+IGrhesP1pAkasRLq/rXvtHuQLIPLrn6RsX0Yqx776c6Mbs8EyVNu4tZz5xDn3wbwOG39oIpeA==
X-Received: by 2002:a17:902:650e:b0:1f7:174e:354d with SMTP id d9443c01a7336-1fa23ef7ef4mr127803105ad.48.1719587639269;
        Fri, 28 Jun 2024 08:13:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac159be6fsm16299065ad.283.2024.06.28.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:13:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 04/10] hwmon: (amc6821) Add support for fan1_target and pwm1_enable mode 4
Date: Fri, 28 Jun 2024 08:13:40 -0700
Message-Id: <20240628151346.1152838-5-linux@roeck-us.net>
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

After setting fan1_target and setting pwm1_enable to 4,
the fan controller tries to achieve the requested fan speed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/amc6821.rst |  4 ++++
 drivers/hwmon/amc6821.c         | 21 +++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

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
index 6eb7edd9aca9..8801208430df 100644
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
 
@@ -410,6 +413,10 @@ static ssize_t pwm1_enable_store(struct device *dev,
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
@@ -712,6 +719,7 @@ static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, temp_alarm, IDX_TEMP2_CRIT);
 static SENSOR_DEVICE_ATTR_RO(fan1_input, fan, IDX_FAN1_INPUT);
 static SENSOR_DEVICE_ATTR_RW(fan1_min, fan, IDX_FAN1_MIN);
 static SENSOR_DEVICE_ATTR_RW(fan1_max, fan, IDX_FAN1_MAX);
+static SENSOR_DEVICE_ATTR_RW(fan1_target, fan, IDX_FAN1_TARGET);
 static SENSOR_DEVICE_ATTR_RO(fan1_fault, fan1_fault, 0);
 static SENSOR_DEVICE_ATTR_RW(fan1_pulses, fan1_pulses, 0);
 
@@ -755,6 +763,7 @@ static struct attribute *amc6821_attrs[] = {
 	&sensor_dev_attr_fan1_input.dev_attr.attr,
 	&sensor_dev_attr_fan1_min.dev_attr.attr,
 	&sensor_dev_attr_fan1_max.dev_attr.attr,
+	&sensor_dev_attr_fan1_target.dev_attr.attr,
 	&sensor_dev_attr_fan1_fault.dev_attr.attr,
 	&sensor_dev_attr_fan1_pulses.dev_attr.attr,
 	&sensor_dev_attr_pwm1.dev_attr.attr,
-- 
2.39.2


