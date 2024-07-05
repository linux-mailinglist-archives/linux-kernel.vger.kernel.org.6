Return-Path: <linux-kernel+bounces-242921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD409928ED8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBE71C22534
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054801779BA;
	Fri,  5 Jul 2024 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op4ygW2h"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9D176AD9;
	Fri,  5 Jul 2024 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215364; cv=none; b=ao3Ro7aJvhslz+YUOsmq4JdaCILh7O83r+jdUI98+MIoUU7ok7wb0mkIgwwXFxYNuXH+O9yaXPyEfxeLJJmvbgDraOB2HFSIplwAVjHNdwq/7N51MwjOoxCRmKuz5HVA73Vha59dcu3apa6X5cidxtWigsELT3H3EQEqusXrM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215364; c=relaxed/simple;
	bh=1KLcDBL4My9mLYKiWQ97bQ2zVWix9tqgGjwsYqVxdvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QKJygd3KjmeQcZQbrhi2/y5tUDvdT1BkwW0pOgpn6+aLsbrPupaDe78QXi5Sn9TXS43xzPg11M5CfXoA34Pxj/Y1vfJHKQ/d6vCglZV4d+h0Tj/Bwp3szpityrBaXaCVbZmoqM3ryRuFJR+0ZKvi2rMv1Jv1/cIDI31wU/nN4S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op4ygW2h; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c8517aab46so1514798a91.1;
        Fri, 05 Jul 2024 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215361; x=1720820161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTntlDfiFV94NqQlcSgdB2IjeLIJXrnhsauLNz2UQLE=;
        b=Op4ygW2hZSyFUtNepoFJxh8jy6P3MopITMyKI5DyK3b85P5FR6/kc4AEQDapbm35wq
         M5o9REpsShFvwgWQglUUhCj3gzbxQq3Z3oEGzhhTTdexoYM8KbJYZGYO+W+27QGvYOPl
         zI/OLVq+Scs3uL5Z+Nq9+e1TQRSTibRZAcwRME2ohuQYoJWW0zJRv9hQaSc552vO+2fT
         BZg8q6BxIcW120kRcWdA6R9L7rMq5qgRAPSMqq8Z4pECS5ACDZ013i4KxOhI8T+R2DRy
         +SK5zlw9Xj+3wSlYDVk0u+rHFMCyNLxBVpFIxDluLQvkzmHK+91q89TYcq6YXO+bB7PK
         BqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215361; x=1720820161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uTntlDfiFV94NqQlcSgdB2IjeLIJXrnhsauLNz2UQLE=;
        b=NqybddWZCuBFkqcpFrCfohRlAMfFLhswEQa3qTBjm1cS44QSftDKLb9jbcMJmb8Igz
         90TAeL16fVdDJj7CbUtephvlFBvQJm8ll+Q3ecLueeN+2gPqjmYvYGyRYVE3lxrT0cxW
         k3HZT2LHIjo384n7pu/Zl4D2xTyl9q9kdzTTczVJyNZd0HuWDMvJiVLHiq6J6sytOvKS
         I8bncqlwcEMkI6YGZdUZcjBuhPXz16rRyTmHSxwg9FtdWw4/TM9/uP95vzh45POl4POn
         5L8KQ1TSrLvqCZ8deMsojDBR/OE1dKHR1Cp7S/wGS4HaejP0luUR7Uegs056PNDvuFm4
         d9Cw==
X-Gm-Message-State: AOJu0YxhF+lleiOLmOrOV2pZzL1ZPWsXDr86n1USapRY5Ke3JjFje2gK
	BW+/X4P24siAhRS/aM+5D+XYXI4yKvqsEFV7ATyHa75qkEhagYoOSizJ4A==
X-Google-Smtp-Source: AGHT+IFs64wIrdJamsGyUi17pnM6ydCUViOvjjTNmdvkar81CfARPVMsrfJjQH0TXBDKW+xHa+3dlg==
X-Received: by 2002:a17:90b:300a:b0:2c9:4c3:3128 with SMTP id 98e67ed59e1d1-2c99c32b203mr4883108a91.0.1720215361407;
        Fri, 05 Jul 2024 14:36:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a3c5sm3879255a91.5.2024.07.05.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:36:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 06/11] hwmon: (amc6821) Use tabs for column alignment in defines
Date: Fri,  5 Jul 2024 14:35:42 -0700
Message-Id: <20240705213547.1155690-7-linux@roeck-us.net>
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

Using tabs for column alignment makes the code easier to read.

No functional change intended.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: No change

v3: No change

v2: Add Quentin's Reviewed-by: tag

 drivers/hwmon/amc6821.c | 128 ++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 8869dbe5a733..bb20ccde5fea 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -37,77 +37,77 @@ module_param(init, int, 0444);
 
 enum chips { amc6821 };
 
-#define AMC6821_REG_DEV_ID 0x3D
-#define AMC6821_REG_COMP_ID 0x3E
-#define AMC6821_REG_CONF1 0x00
-#define AMC6821_REG_CONF2 0x01
-#define AMC6821_REG_CONF3 0x3F
-#define AMC6821_REG_CONF4 0x04
-#define AMC6821_REG_STAT1 0x02
-#define AMC6821_REG_STAT2 0x03
-#define AMC6821_REG_TDATA_LOW 0x08
-#define AMC6821_REG_TDATA_HI 0x09
-#define AMC6821_REG_LTEMP_HI 0x0A
-#define AMC6821_REG_RTEMP_HI 0x0B
-#define AMC6821_REG_LTEMP_LIMIT_MIN 0x15
-#define AMC6821_REG_LTEMP_LIMIT_MAX 0x14
-#define AMC6821_REG_RTEMP_LIMIT_MIN 0x19
-#define AMC6821_REG_RTEMP_LIMIT_MAX 0x18
-#define AMC6821_REG_LTEMP_CRIT 0x1B
-#define AMC6821_REG_RTEMP_CRIT 0x1D
-#define AMC6821_REG_PSV_TEMP 0x1C
-#define AMC6821_REG_DCY 0x22
-#define AMC6821_REG_LTEMP_FAN_CTRL 0x24
-#define AMC6821_REG_RTEMP_FAN_CTRL 0x25
-#define AMC6821_REG_DCY_LOW_TEMP 0x21
+#define AMC6821_REG_DEV_ID		0x3D
+#define AMC6821_REG_COMP_ID		0x3E
+#define AMC6821_REG_CONF1		0x00
+#define AMC6821_REG_CONF2		0x01
+#define AMC6821_REG_CONF3		0x3F
+#define AMC6821_REG_CONF4		0x04
+#define AMC6821_REG_STAT1		0x02
+#define AMC6821_REG_STAT2		0x03
+#define AMC6821_REG_TDATA_LOW		0x08
+#define AMC6821_REG_TDATA_HI		0x09
+#define AMC6821_REG_LTEMP_HI		0x0A
+#define AMC6821_REG_RTEMP_HI		0x0B
+#define AMC6821_REG_LTEMP_LIMIT_MIN	0x15
+#define AMC6821_REG_LTEMP_LIMIT_MAX	0x14
+#define AMC6821_REG_RTEMP_LIMIT_MIN	0x19
+#define AMC6821_REG_RTEMP_LIMIT_MAX	0x18
+#define AMC6821_REG_LTEMP_CRIT		0x1B
+#define AMC6821_REG_RTEMP_CRIT		0x1D
+#define AMC6821_REG_PSV_TEMP		0x1C
+#define AMC6821_REG_DCY			0x22
+#define AMC6821_REG_LTEMP_FAN_CTRL	0x24
+#define AMC6821_REG_RTEMP_FAN_CTRL	0x25
+#define AMC6821_REG_DCY_LOW_TEMP	0x21
 
-#define AMC6821_REG_TACH_LLIMITL 0x10
-#define AMC6821_REG_TACH_LLIMITH 0x11
-#define AMC6821_REG_TACH_HLIMITL 0x12
-#define AMC6821_REG_TACH_HLIMITH 0x13
-#define AMC6821_REG_TACH_SETTINGL 0x1e
-#define AMC6821_REG_TACH_SETTINGH 0x1f
+#define AMC6821_REG_TACH_LLIMITL	0x10
+#define AMC6821_REG_TACH_LLIMITH	0x11
+#define AMC6821_REG_TACH_HLIMITL	0x12
+#define AMC6821_REG_TACH_HLIMITH	0x13
+#define AMC6821_REG_TACH_SETTINGL	0x1e
+#define AMC6821_REG_TACH_SETTINGH	0x1f
 
-#define AMC6821_CONF1_START 0x01
-#define AMC6821_CONF1_FAN_INT_EN 0x02
-#define AMC6821_CONF1_FANIE 0x04
-#define AMC6821_CONF1_PWMINV 0x08
-#define AMC6821_CONF1_FAN_FAULT_EN 0x10
-#define AMC6821_CONF1_FDRC0 0x20
-#define AMC6821_CONF1_FDRC1 0x40
-#define AMC6821_CONF1_THERMOVIE 0x80
+#define AMC6821_CONF1_START		0x01
+#define AMC6821_CONF1_FAN_INT_EN	0x02
+#define AMC6821_CONF1_FANIE		0x04
+#define AMC6821_CONF1_PWMINV		0x08
+#define AMC6821_CONF1_FAN_FAULT_EN	0x10
+#define AMC6821_CONF1_FDRC0		0x20
+#define AMC6821_CONF1_FDRC1		0x40
+#define AMC6821_CONF1_THERMOVIE		0x80
 
-#define AMC6821_CONF2_PWM_EN 0x01
-#define AMC6821_CONF2_TACH_MODE 0x02
-#define AMC6821_CONF2_TACH_EN 0x04
-#define AMC6821_CONF2_RTFIE 0x08
-#define AMC6821_CONF2_LTOIE 0x10
-#define AMC6821_CONF2_RTOIE 0x20
-#define AMC6821_CONF2_PSVIE 0x40
-#define AMC6821_CONF2_RST 0x80
+#define AMC6821_CONF2_PWM_EN		0x01
+#define AMC6821_CONF2_TACH_MODE		0x02
+#define AMC6821_CONF2_TACH_EN		0x04
+#define AMC6821_CONF2_RTFIE		0x08
+#define AMC6821_CONF2_LTOIE		0x10
+#define AMC6821_CONF2_RTOIE		0x20
+#define AMC6821_CONF2_PSVIE		0x40
+#define AMC6821_CONF2_RST		0x80
 
-#define AMC6821_CONF3_THERM_FAN_EN 0x80
-#define AMC6821_CONF3_REV_MASK 0x0F
+#define AMC6821_CONF3_THERM_FAN_EN	0x80
+#define AMC6821_CONF3_REV_MASK		0x0F
 
-#define AMC6821_CONF4_OVREN 0x10
-#define AMC6821_CONF4_TACH_FAST 0x20
-#define AMC6821_CONF4_PSPR 0x40
-#define AMC6821_CONF4_MODE 0x80
+#define AMC6821_CONF4_OVREN		0x10
+#define AMC6821_CONF4_TACH_FAST		0x20
+#define AMC6821_CONF4_PSPR		0x40
+#define AMC6821_CONF4_MODE		0x80
 
-#define AMC6821_STAT1_RPM_ALARM 0x01
-#define AMC6821_STAT1_FANS 0x02
-#define AMC6821_STAT1_RTH 0x04
-#define AMC6821_STAT1_RTL 0x08
-#define AMC6821_STAT1_R_THERM 0x10
-#define AMC6821_STAT1_RTF 0x20
-#define AMC6821_STAT1_LTH 0x40
-#define AMC6821_STAT1_LTL 0x80
+#define AMC6821_STAT1_RPM_ALARM		0x01
+#define AMC6821_STAT1_FANS		0x02
+#define AMC6821_STAT1_RTH		0x04
+#define AMC6821_STAT1_RTL		0x08
+#define AMC6821_STAT1_R_THERM		0x10
+#define AMC6821_STAT1_RTF		0x20
+#define AMC6821_STAT1_LTH		0x40
+#define AMC6821_STAT1_LTL		0x80
 
-#define AMC6821_STAT2_RTC 0x08
-#define AMC6821_STAT2_LTC 0x10
-#define AMC6821_STAT2_LPSV 0x20
-#define AMC6821_STAT2_L_THERM 0x40
-#define AMC6821_STAT2_THERM_IN 0x80
+#define AMC6821_STAT2_RTC		0x08
+#define AMC6821_STAT2_LTC		0x10
+#define AMC6821_STAT2_LPSV		0x20
+#define AMC6821_STAT2_L_THERM		0x40
+#define AMC6821_STAT2_THERM_IN		0x80
 
 enum {IDX_TEMP1_INPUT = 0, IDX_TEMP1_MIN, IDX_TEMP1_MAX,
 	IDX_TEMP1_CRIT, IDX_TEMP2_INPUT, IDX_TEMP2_MIN,
-- 
2.39.2


