Return-Path: <linux-kernel+bounces-176244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF52D8C2BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0A31C20F49
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF7613C8EB;
	Fri, 10 May 2024 21:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4PEeaAt"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B9D13C3FA;
	Fri, 10 May 2024 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377152; cv=none; b=UK8cmlVqymmw1PrnyrWhPAIYdUfOiBfTFMswUMCdFc3/wC73RtIwQOfQE8ClfikqEbUZKqvmCa3Q8ob6u0HbbktdXSDajBlLcc5hJBhr4YDzN6rTApatGA/VEKAGCd5czXUQU2DgDgPnsDde72JxrQUqhv/iIdBsVldqWnVUemQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377152; c=relaxed/simple;
	bh=Wce+sUTCuiJ5FXm4hO89NOZnuFF6R5OigeT5dgSbQQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mQkbcDUYCxC/NWcaXgu6Dp1NfMnKd8iBSguba+AxcSdu8nt1ir8TPjOEzDuV2p7CCQuRYw8Vg7WjJn24IfqwgTgKW2zI2uczyhdzbeEs0Cdvxcq7cMOFXcCrNDlfnAj8GOeDsmmMd+Iyn5xRJb9hXBIB2R/HRevRw549Q5bV6UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4PEeaAt; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23d23a6123eso908264fac.1;
        Fri, 10 May 2024 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715377148; x=1715981948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XE9AFM6ubwTHsLKt1e2+92rJLoMNOBgv6z9yq4LSgQc=;
        b=e4PEeaAtJuAKXYkV5ivw19YpkCrmkp7TepKW4Q4ORUDzpX4A6/AxWhG3kQDipbgXvm
         OR//ApZyu+TC9a7nmu9lju9ool5W1CuVPLyDn1w6dqB4snM9kl8g/Gdxq77nz5JRKW7W
         W5UXMNFPgrSwI7AgDc3gSbNbFRg8kgQpLR8jUhp9psVvmBzjaXZn79kVCau04fDPCRok
         o9WwlO1LE1MULhnj43hk/s+GVYNGlFNX4ur5xnWafCDGONwQWqLVgljdJeRE3FLcWYli
         nKUSsrDcp3eX0MPCipBRW+9En8VpB6DwJgWz1Zz8pCHYh94eoZYuIE2fDlPEhBHlE1aE
         SP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377148; x=1715981948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XE9AFM6ubwTHsLKt1e2+92rJLoMNOBgv6z9yq4LSgQc=;
        b=J462dFVcktvq+56xhMao+lWo7GQWGu61cxFVdlNNHO7cAlApvSKbRmL1a0dxuqPfy+
         qdgyOTqL3APbm77plTp8dZQW4v6i6FwmNgfJR99Mh6T61q1jxJZrJD9DNqn9jvB16C4A
         wDjqIwbPWi1uR+/AAS55ICv9XbWR/v/l6f9sK7f+MtkLR/7+btl1rryY/wWym7EX4rZt
         EVrHW/rp3Q9dAyUzDMEVmXHGPUPTHPgBlPAqHjhoHJLBxVrkIpd6tQbl4bq0P4lmYtqU
         3NAS1c0e/1Ntj80EGCfUakD/0lHCbCxH/zjJqitAD+DWxVVbthJ0idmbCG8FXQkBnayY
         yq5g==
X-Forwarded-Encrypted: i=1; AJvYcCXQvqrfterbOlBzQZGuDg+fuCC6p8ZM2Oh1+hYNOuLzs8z6nZe24T4Zmzc98NT32WC8CoQ9jpNRSFQse1mLK4ubcbYXE1kHlU1Yx/NCeY+VuYuBzHmudm1dyRc5ZD9yzUwNjxWRL81Enkg=
X-Gm-Message-State: AOJu0Yw2HqvpRa8Ld0HV0QlwIDjO9+6g1/Rv16cImnvHclkh6RStPvop
	UEho0ex6QtTNrPl8RZqTVebZZriG+ouRWBzXpqMeqWKLJ4XHORiA
X-Google-Smtp-Source: AGHT+IGbQ9VPnvrjm+eL8Yqig1Ks4QLL0WQMgyXaXhIrNm1wCBPHhxqMYi/HTHzo/KQFSnkzb8GX0A==
X-Received: by 2002:a05:6870:9d13:b0:23e:7432:6f1c with SMTP id 586e51a60fabf-24172a4e5a0mr4050838fac.18.1715377148450;
        Fri, 10 May 2024 14:39:08 -0700 (PDT)
Received: from localhost.localdomain ([75.40.203.101])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412ac8d002sm1015320fac.45.2024.05.10.14.39.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 14:39:07 -0700 (PDT)
From: Andrei Aldea <andrei1998@gmail.com>
To: linux@roeck-us.net
Cc: jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Aldea <andrei1998@gmail.com>
Subject: Re: [PATCH v2] hwmon: (lm80) Add support for Texas Instruments AMC80
Date: Fri, 10 May 2024 16:38:58 -0500
Message-Id: <20240510213858.20327-1-andrei1998@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for AMC80 which is register compatible with LM96080

PS -let me know if you'd like me to update other broken links in docs.

Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
---
 Documentation/hwmon/lm80.rst | 20 +++++++++++++++-----
 drivers/hwmon/Kconfig        |  4 ++--
 drivers/hwmon/lm80.c         |  6 ++++++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/lm80.rst b/Documentation/hwmon/lm80.rst
index c53186abd82e..bb223b408e15 100644
--- a/Documentation/hwmon/lm80.rst
+++ b/Documentation/hwmon/lm80.rst
@@ -9,9 +9,9 @@ Supported chips:
 
     Addresses scanned: I2C 0x28 - 0x2f
 
-    Datasheet: Publicly available at the National Semiconductor website
+    Datasheet: Publicly available at the Texas Instruments website
 
-	       http://www.national.com/
+	       http://www.ti.com/product/LM80
 
   * National Semiconductor LM96080
 
@@ -19,10 +19,19 @@ Supported chips:
 
     Addresses scanned: I2C 0x28 - 0x2f
 
-    Datasheet: Publicly available at the National Semiconductor website
+    Datasheet: Publicly available at the Texas Instruments website
 
-	       http://www.national.com/
+	       http://www.ti.com/product/LM96080
 
+  * Texas Instruments AMC80
+
+    Prefix: "amc80"
+
+    Addresses scanned: I2C 0x28 - 0x2f
+
+    Datasheet: Publicly available at the Texas Instruments website
+
+        http://www.ti.com/product/AMC80
 
 Authors:
        - Frodo Looijaard <frodol@dds.nl>,
@@ -35,7 +44,8 @@ This driver implements support for the National Semiconductor LM80.
 It is described as a 'Serial Interface ACPI-Compatible Microprocessor
 System Hardware Monitor'. The LM96080 is a more recent incarnation,
 it is pin and register compatible, with a few additional features not
-yet supported by the driver.
+yet supported by the driver. The AMC80 is pin and register compatible
+with the LM96080 and only changes the manufacturer ID.
 
 The LM80 implements one temperature sensor, two fan rotation speed sensors,
 seven voltage sensors, alarms, and some miscellaneous stuff.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 83945397b6eb..7a2a7e854c8c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1446,11 +1446,11 @@ config SENSORS_LM78
 	  will be called lm78.
 
 config SENSORS_LM80
-	tristate "National Semiconductor LM80 and LM96080"
+	tristate "National Semiconductor LM80 and compatibles"
 	depends on I2C
 	help
 	  If you say yes here you get support for National Semiconductor
-	  LM80 and LM96080 sensor chips.
+	  LM80, LM96080 and Texas Instruments AMC80 sensor chips.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called lm80.
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 63c7831bd3e1..0355b9d849be 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -573,6 +573,11 @@ static int lm80_detect(struct i2c_client *client, struct i2c_board_info *info)
 			return -ENODEV;
 
 		name = "lm96080";
+
+	/* Check for  AMC80 version which is register compatible with lm96080 */
+	} else if (man_id == 0x80 && dev_id == 0x08) {
+		name = "amc80";
+
 	} else {
 		/* Check 6-bit addressing */
 		for (i = 0x2a; i <= 0x3d; i++) {
@@ -624,6 +629,7 @@ static int lm80_probe(struct i2c_client *client)
 static const struct i2c_device_id lm80_id[] = {
 	{ "lm80", 0 },
 	{ "lm96080", 1 },
+	{ "amc80", 2},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm80_id);
-- 
2.39.3 (Apple Git-146)


