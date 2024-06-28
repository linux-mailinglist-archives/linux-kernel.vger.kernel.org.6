Return-Path: <linux-kernel+bounces-234104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 302B891C243
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4A81C2011F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55A31CB309;
	Fri, 28 Jun 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2I1c4Yn"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860721C9EC3;
	Fri, 28 Jun 2024 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587646; cv=none; b=H1zy3D1f25n1qoQ5minUevuWLGBMf9rsRlCuKHn4Sii2dNYa69SHjQXVnfwL4ghQMoU43xSLrBCvdVKlL6ELNnVY94Jiuz+IYdZyxMqOFti6N4/ViFJL9orgoz+5LjtcluvpVj/4yE1juYF7D0SXnil3lhiZ2Dy7g4a2AtbKUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587646; c=relaxed/simple;
	bh=gjZNisN3UNBQNSjn05RmJck5ECw4A8z2ZF6EBVwQ13Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gx2puhsSx4mbOYPTgAGMZ8Uudwp/E++WTtAVQG5XyBKCm8SnCLxUrulRhe92xa063oiyODgSyH9G6E1S8ugsarVA4SHbS55NdZ08OO4kXzzia2t96eXo4x/KeX4wwUfRAI2L1/bSbndpDEyEgti0ND1DgnZKLMUorZ/7PtVddO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2I1c4Yn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6fabe9da3so4784985ad.0;
        Fri, 28 Jun 2024 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587644; x=1720192444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gztMhVxUqECP9wITlVEZK0vKrOtrBdNLPHM8t3kssk=;
        b=c2I1c4Yne+ptwHQiE+qafuPUnM1qWVUhk/LnlqkNcLgwm9QEUB36II/kF9W2vzHDoR
         HhuelD1llrvI5zqMDdK/ZrhfscOXf+FHt6u6+mClodgm1m+x+xrk1G3W5jL7tRb+Gfdl
         cetuEOSXIvVQxQnyhszIqSeC7xt8LusMt1vq9OTIaqvmfYVYd+LUzNUKTnQp3lAl4JsF
         YKzrD/FIrRtAmyQ5BuVcnpEMPWmaUAv593jyBuDl+543QSa04iHq4PMrssi/84Nh4fCr
         nbzHV5HRb5ygjQk5/aCbYDCgnfMJZxBZdGaIXIH8dCs2KW+kOsWutcwAmZGbGRHLUxdU
         JB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587644; x=1720192444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gztMhVxUqECP9wITlVEZK0vKrOtrBdNLPHM8t3kssk=;
        b=hFr3BX7W0FR1FjIfklnRHsodBZiJF2e0SaQ0r213gDgyCT2NwtfVj6BOqbl89UxzbH
         70yENP5uOeb7uCjlOpKit0WyAZx2HeAVyHnbErnw5KbTaNTBF4efNGw7lwIs4mnu2Voe
         lxpzss2nI514XqLi9cqjAVKXSymUa8qQuKJYMOeCh6z5KD6pZPZFUgG0EMMKPMnlJFly
         qJdJnVPc9piYXtbTlu5geHXHDCPtIPgu7p93eTMK9pXBqHqVsN/U9EtT7MU+D/msCQWo
         r8fL+BA0VR5or223dUXnoC5M2Nb1Gcyq1QJ6Uyo9JB1Zsvfqwb1BRTAsup4e5W91hYae
         veDQ==
X-Gm-Message-State: AOJu0Yy1ZJ1uiReusIymM5nDFCGH888Kp1nm2V6ry1n8JbBuu5ZzTIRc
	BGuQ/YJS0tXe2CznEZKp8LEVYFUEBRtKJd6+3XsLoZCoC041ynJKEgvhaA==
X-Google-Smtp-Source: AGHT+IEJ6dYlObITfhu84TW1xf8ZScAxYDFJJLlPVS01oYygX+MPVCfdn1WlSePUxtGX+HQ0qwFHeQ==
X-Received: by 2002:a17:902:da8b:b0:1fa:81bc:f4cc with SMTP id d9443c01a7336-1fa81bcf71amr82852455ad.68.1719587644321;
        Fri, 28 Jun 2024 08:14:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1599d28sm16344915ad.287.2024.06.28.08.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:14:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 07/10] hwmon: (amc2821) Use BIT() and GENMASK()
Date: Fri, 28 Jun 2024 08:13:43 -0700
Message-Id: <20240628151346.1152838-8-linux@roeck-us.net>
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

Use BIT() and GENMASK() for bit and mask definitions
to help distinguish bit and mask definitions from other
defines and to make the code easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/amc6821.c | 71 +++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 03ce2e3ffd86..042e2044de7b 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -8,6 +8,7 @@
  * Copyright (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
  */
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
@@ -68,46 +69,46 @@ enum chips { amc6821 };
 #define AMC6821_REG_TACH_SETTINGL	0x1e
 #define AMC6821_REG_TACH_SETTINGH	0x1f
 
-#define AMC6821_CONF1_START		0x01
-#define AMC6821_CONF1_FAN_INT_EN	0x02
-#define AMC6821_CONF1_FANIE		0x04
-#define AMC6821_CONF1_PWMINV		0x08
-#define AMC6821_CONF1_FAN_FAULT_EN	0x10
-#define AMC6821_CONF1_FDRC0		0x20
-#define AMC6821_CONF1_FDRC1		0x40
-#define AMC6821_CONF1_THERMOVIE		0x80
+#define AMC6821_CONF1_START		BIT(0)
+#define AMC6821_CONF1_FAN_INT_EN	BIT(1)
+#define AMC6821_CONF1_FANIE		BIT(2)
+#define AMC6821_CONF1_PWMINV		BIT(3)
+#define AMC6821_CONF1_FAN_FAULT_EN	BIT(4)
+#define AMC6821_CONF1_FDRC0		BIT(5)
+#define AMC6821_CONF1_FDRC1		BIT(7)
+#define AMC6821_CONF1_THERMOVIE		BIT(7)
 
-#define AMC6821_CONF2_PWM_EN		0x01
-#define AMC6821_CONF2_TACH_MODE		0x02
-#define AMC6821_CONF2_TACH_EN		0x04
-#define AMC6821_CONF2_RTFIE		0x08
-#define AMC6821_CONF2_LTOIE		0x10
-#define AMC6821_CONF2_RTOIE		0x20
-#define AMC6821_CONF2_PSVIE		0x40
-#define AMC6821_CONF2_RST		0x80
+#define AMC6821_CONF2_PWM_EN		BIT(0)
+#define AMC6821_CONF2_TACH_MODE		BIT(1)
+#define AMC6821_CONF2_TACH_EN		BIT(2)
+#define AMC6821_CONF2_RTFIE		BIT(3)
+#define AMC6821_CONF2_LTOIE		BIT(4)
+#define AMC6821_CONF2_RTOIE		BIT(5)
+#define AMC6821_CONF2_PSVIE		BIT(6)
+#define AMC6821_CONF2_RST		BIT(7)
 
-#define AMC6821_CONF3_THERM_FAN_EN	0x80
-#define AMC6821_CONF3_REV_MASK		0x0F
+#define AMC6821_CONF3_THERM_FAN_EN	BIT(7)
+#define AMC6821_CONF3_REV_MASK		GENMASK(3, 0)
 
-#define AMC6821_CONF4_OVREN		0x10
-#define AMC6821_CONF4_TACH_FAST		0x20
-#define AMC6821_CONF4_PSPR		0x40
-#define AMC6821_CONF4_MODE		0x80
+#define AMC6821_CONF4_OVREN		BIT(4)
+#define AMC6821_CONF4_TACH_FAST		BIT(5)
+#define AMC6821_CONF4_PSPR		BIT(6)
+#define AMC6821_CONF4_MODE		BIT(7)
 
-#define AMC6821_STAT1_RPM_ALARM		0x01
-#define AMC6821_STAT1_FANS		0x02
-#define AMC6821_STAT1_RTH		0x04
-#define AMC6821_STAT1_RTL		0x08
-#define AMC6821_STAT1_R_THERM		0x10
-#define AMC6821_STAT1_RTF		0x20
-#define AMC6821_STAT1_LTH		0x40
-#define AMC6821_STAT1_LTL		0x80
+#define AMC6821_STAT1_RPM_ALARM		BIT(0)
+#define AMC6821_STAT1_FANS		BIT(1)
+#define AMC6821_STAT1_RTH		BIT(2)
+#define AMC6821_STAT1_RTL		BIT(3)
+#define AMC6821_STAT1_R_THERM		BIT(4)
+#define AMC6821_STAT1_RTF		BIT(5)
+#define AMC6821_STAT1_LTH		BIT(6)
+#define AMC6821_STAT1_LTL		BIT(7)
 
-#define AMC6821_STAT2_RTC		0x08
-#define AMC6821_STAT2_LTC		0x10
-#define AMC6821_STAT2_LPSV		0x20
-#define AMC6821_STAT2_L_THERM		0x40
-#define AMC6821_STAT2_THERM_IN		0x80
+#define AMC6821_STAT2_RTC		BIT(3)
+#define AMC6821_STAT2_LTC		BIT(4)
+#define AMC6821_STAT2_LPSV		BIT(5)
+#define AMC6821_STAT2_L_THERM		BIT(6)
+#define AMC6821_STAT2_THERM_IN		BIT(7)
 
 enum {IDX_TEMP1_INPUT = 0, IDX_TEMP1_MIN, IDX_TEMP1_MAX,
 	IDX_TEMP1_CRIT, IDX_TEMP2_INPUT, IDX_TEMP2_MIN,
-- 
2.39.2


