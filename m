Return-Path: <linux-kernel+bounces-242922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F34AE928EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E390B23F3C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42123178371;
	Fri,  5 Jul 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYZfVg6D"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD46176FD8;
	Fri,  5 Jul 2024 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215365; cv=none; b=LsZSzuMpMDZQTChpuxtG1sbcVBjRgYcvU/XbLzZDr4qmJ7f1OxP0/nbs9XW2Q1JPv2zhGNgjymnwjrNJLE77kcnE1gGNiswJ+l8JROIZjsVglWUBZlmlVQhOyf5t4EBo+d3MGbwOIFHqygsGeNpuoJnH7XC1UXtONvBcKBwGOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215365; c=relaxed/simple;
	bh=SAmhcQbjtwIOu+cs6iIWljo4YO7jI8+2WPDEdvsVq3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vn3qL5N6RaO8sVSlTPWHx1YbcYXhP9eBO3LVV1m2LnPnmqkVXdBxTIDFmGIkx0fcY2FPB7o1kqj9BcaIJ1oZ6Z4w2TSlFjgF7UyasJVZ64bN+cAC9cMPmm+/gtPMLAWIbn7c11rWycH/0ysWf9y7LU1zOjUzsshpr5WLy5z2x94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYZfVg6D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb0d88fd25so14047275ad.0;
        Fri, 05 Jul 2024 14:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215363; x=1720820163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0eDqHI/aYbcZ6krpcb9PXF52JNVTzTMcQbUahzMySU=;
        b=UYZfVg6DpIVLZ2+OdqmstAzNtAeI4TqQtsIpNg+7M5Cgv56UYzCJiPoLsaP+EecPB4
         nvsNKfqpQuifKz3DjAad7mROaeMJ4hhzUXcgBgWoQ5h9jHXzNsSle6v2f8TqJHJ4zqu8
         HwMV155N3bW4EcYhUzrcTXMjmjmYw79FzkMseg1UvQCG/OhAvbI4zyjqmGNP9X9cyw2A
         z3nmX1YmeyRNIeaDR8DrPRtP3ZFhfZ7vH4/MciD39HDiuzg4LKoaz29pcX6h20vYtV/t
         7NTNyLa4OKweZzn3y7HxJu4Gbm9fTnSqnOajARf4RLXRW/AK4g7CJEBmJ8aqzIu/tBvt
         6zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215363; x=1720820163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V0eDqHI/aYbcZ6krpcb9PXF52JNVTzTMcQbUahzMySU=;
        b=mvqtfNTU1kCJctXgxv5ewjXcQNoYmi9pAqYWWTV2sy85mlv13fVLRTlDRKCjPoTVMd
         zWFGqBm+xOyQ2fLw5tzII8X/nPv0EwSbFKIft/M5bzFmmubz+aF7F2K68Bcju9QRes04
         kmIZEE1swzHd1AiXL5bhnHzW/XjnwxGjJ8SsvYaa37tJsm4bjdQB+FTqIMDrVpIPpgbT
         jhsjyOl9n6ufm72yTY/Q0sSXt1EcgGyGmDqpRax36BDFFBpGyeR5R3Px/UUpnM8QbwPN
         StQZ3dvcDXm04PwiS2Lk73uftQ/Pe4sMJSBO8z021MCISibNQD5Lq42qZvMHMhiwH3Mb
         H7Tw==
X-Gm-Message-State: AOJu0YzMULwRIZfjrSMTUOItNGizN7d1AWnVRSUg+GIxWIY0TzGHM6FP
	CnLakh/p4PalrY4YD0Monn4ZmVLfcx24zjDes78zSaRYNp/sK7Wo7p609w==
X-Google-Smtp-Source: AGHT+IFXT4zhugoqs/V5KqMbb3VwTxlsTf9s9dRltFo/dDO6kgrP2ngtTA09S9Ci+x4tbfr5EdL9Ng==
X-Received: by 2002:a17:902:e745:b0:1f6:3580:65c9 with SMTP id d9443c01a7336-1fb370a0fc4mr75415925ad.26.1720215362945;
        Fri, 05 Jul 2024 14:36:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15992a0sm145199495ad.263.2024.07.05.14.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:36:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 07/11] hwmon: (amc6821) Use BIT() and GENMASK()
Date: Fri,  5 Jul 2024 14:35:43 -0700
Message-Id: <20240705213547.1155690-8-linux@roeck-us.net>
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

Use BIT() and GENMASK() for bit and mask definitions
to help distinguish bit and mask definitions from other
defines and to make the code easier to read.

No functional change intended.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Fix subject (amc6821, not amc2821)

v3: Add Quentin's Reviewed-by: tag

v2: Fix definition of AMC6821_CONF1_FDRC1 in this patch

 drivers/hwmon/amc6821.c | 71 +++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index bb20ccde5fea..546e79ce93b9 100644
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
+#define AMC6821_CONF1_FDRC1		BIT(6)
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


