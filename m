Return-Path: <linux-kernel+bounces-241566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE205927C9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A43E0285F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F11419A0;
	Thu,  4 Jul 2024 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9MKoUlG"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914813D624;
	Thu,  4 Jul 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115546; cv=none; b=LJwhQyYPLfSdajqOVDvihJHYrKAHTSdtnhpsfsqSdOFD4lSymf4VLQSqZwzxf082Y18svTcJ/DDXnLtVXX9thkM2V10AMk/M+U6Tt2S1F2+2jBhGenYkm/Z99jZfouyFcRUdGqIPiGylVqTywjGZ40TEO9OrWYNWbI30q/AV5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115546; c=relaxed/simple;
	bh=BMAmOr+ZasUuFPzjvGle+6gstpB00pPf8C6tvuwkcyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=paWOCMtHn9g3e+KfBY/JQXVattIfYpwbErtklVokeodAOnjEMmLJ4Efr5rLn58RUDF1vj3XWvJ5rFXCG+DEque8Rj0pZnXeGqa09/kB5VR2p98clBG/y8n6CxB9SSNOdC5eINk9DsAK40JwiOXSkUTVyTouFLam2gaf94TzUHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9MKoUlG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70af8062039so632698b3a.0;
        Thu, 04 Jul 2024 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115543; x=1720720343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM9lEivXvJGaXPFzCNmbgyOKukTO2PVFMDT2smvMIIw=;
        b=J9MKoUlGQlDnFlqUGyCY2MwDTFPRZ4MVxBxN/cJYor4rJs/qmlilZew6wm2o8dUGNG
         8gUMCDp02WuMkOlU11m1dZHzVoRX4P7bUlUE2HSNZKMD21oBHdbP1G+ArRc/O7iswSh/
         lXhtnPBZH+THJvW/H3uSlU0wAupUEUfkeLTnoczX74hap7TSzSKGGZt7burB2/6VO+Ab
         VDGWD9RCf753nNB64+x6KPCUMvbbDoKEwspwts0Kd49QHTml0PKa7/9bo5wUvZlb5aP8
         /3/oV7+qi+3fuUbYWN4f7ndigsaGj/iA/F4YLAGHJI5wmI2YN9kNV9hzqIgvLk77sLGW
         /tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115543; x=1720720343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vM9lEivXvJGaXPFzCNmbgyOKukTO2PVFMDT2smvMIIw=;
        b=mQRlhDTpNTpaOn5LukVH7m6hn5+8Vq+UccadniJmpRyOa3jK09HLfqg5Mupd7DGW8S
         q+7DxOzf1xeDTq+pNjoXuCEub5pqQVCl/578XhCkwqcFOf7jNtrJE2NXg0Eg6mWgT2Rt
         2unNLInN6VqoJnjrLBpulXutWR8qYxrvU5ZphRGKAojRfpm0z4u8+wmY7vtQfnknJyiq
         /yeUg4NYqPPEBvP4mlqS65hBtH2j6twRUxh4h90ri7vGdGp5q8rii0cO0aZ1/roBEhJC
         +QMnzeUiqqCWkXYDMSu/NLUOLTpjV6X8h4p/BbIqum8hFXamd8Vtgm+KY+ECXmiZQ0we
         V+gA==
X-Gm-Message-State: AOJu0Yx9BTff1XV9XRnf+j96PtYAhhSiVPsX4MH9xPu5hoivlksqYaBI
	V7UaPgYyjUGV/eZONjNgWKGgA8/ByKj5s4N1NqEWi7pnxh17j8nJgkp6Tw==
X-Google-Smtp-Source: AGHT+IFYWo8aeTJpU+fJ8XLsjnwHEcIY1I8giYL58vZ/tQEbfUefKn2OFG/eoqtb+G4GuyiDN15LJg==
X-Received: by 2002:a05:6a00:2999:b0:706:6272:417 with SMTP id d2e1a72fcca58-70b00942856mr2166865b3a.10.1720115543071;
        Thu, 04 Jul 2024 10:52:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b0c18237bsm86919b3a.12.2024.07.04.10.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 07/11] hwmon: (amc2821) Use BIT() and GENMASK()
Date: Thu,  4 Jul 2024 10:52:03 -0700
Message-Id: <20240704175207.2684012-8-linux@roeck-us.net>
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

Use BIT() and GENMASK() for bit and mask definitions
to help distinguish bit and mask definitions from other
defines and to make the code easier to read.

No functional change intended.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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


