Return-Path: <linux-kernel+bounces-241565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ACC927C98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BE828544F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0D113D51B;
	Thu,  4 Jul 2024 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpNJl/Ch"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B9D13C9A1;
	Thu,  4 Jul 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115544; cv=none; b=XphukCMJM6LWczAE4BD461mrj7C1TJc5+bjjPqOXr2iZqcBNz+r90VY1ZbjD+PlDSjjqDsnVrRvQdNwehP5dY99pEWDBmnfcQvgN4TIIX3/p2B/dtnISofDlBxuyYihfMHpALKJiiH3bUTbAlpdPZnx8woPtPBc1CmnV9xLX0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115544; c=relaxed/simple;
	bh=XE+2jH3QR7W1l5V9fQXxOmBkasQ10ztEG86UmUwUbaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5uw3hMmKmHvbp/tn0oeHXJmr5Qc8Vp3z/VkckdUApk/BD5VkaqXQgZ8X2/1HHmbKN94tuj90xe8F4uZkCo8PERk4UjLipDvx/Q4vn4k4yuAnRMZrgtTmGAylFCze63V7+El9fXa3brCusIDnnyJbxYFmfWoz4IChaot3xYWlsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpNJl/Ch; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-761e0f371f5so392552a12.1;
        Thu, 04 Jul 2024 10:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115541; x=1720720341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCGcuc7gyewbCHDREDLke+yRA7c8VYP1n4+FukttKsw=;
        b=FpNJl/ChIiEsWj2X8wIzaTGsp9x6H8vcklBl/2towirgskwcUcrGVZ86v5cwLTCW8J
         SSG57uLy6k84PWhZ/9Kijsyq1ydqw7rooD/+x+hzZ0XerKckZ7W/TE9zU1m/jt2byMD8
         XiB8lsn0+DsHauoK+gC/gYCTfMt1+Tsx61m7Vr/S6LTzghYH+H89SnI01WunIgUsvyA1
         Y0GHLMjugeeNn4diOr6Drt/V6YoE7HY5XEwqtD1f89FmrJurX5h0dWeFyJjGqVe0Yrz6
         Ht2Z7SjHTyX4bkvDN6fBhS/OZa/kucr9dVs51U0WktWWkNsavBO55b5FEz6bdVDs5JON
         GEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115541; x=1720720341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCGcuc7gyewbCHDREDLke+yRA7c8VYP1n4+FukttKsw=;
        b=NDRWjPI6LJOiWxIvqlblhCDD3iZlmhHb87NbYkNO0NHBcze81f0db/OEocEFqo022z
         vvU95Uh9VRfTZkc4+ylHyIPWPO2zHgUlETOmc5ouREfQedrmTrhE+FbPsKxZVNl9FWn0
         mSVBQTyE7tqi63fEgyPR+fLLNvKwoWUvIRFgCaZuwfPUE8hYPJmeZAgD7J769EENOI5r
         iAAWQg2KOFSQrh+J2kMN7zeEFtrSc7xn4jXOOLvThFecxacJ6/uW3pNhQXg/vxNRAybt
         c9HWQVZNINSeB23JNtRqXgpGx91Lz/XZmUElDutAiuSMLmLmzFPKU78YQYPYztvlTWJS
         gnDA==
X-Gm-Message-State: AOJu0YxUDM+jaEslMabmR1xMjSJX9KPQQcUcAgcs7l4TUXuUUVtAn6Dk
	AiZaRDYLal3Q1EJ2cDe6kqWizF0Q0zSWTQOrJpbZv3ytog85DUAm//Qk3Q==
X-Google-Smtp-Source: AGHT+IH/621CvNwC/v7lKbl+eWpFBmNzhbw83S4SC7n4HhXpwNJxHcvlVWEJn8t1oRcz34btIGRv7w==
X-Received: by 2002:a17:90b:f82:b0:2c9:63d3:1f20 with SMTP id 98e67ed59e1d1-2c99f37f81amr2937666a91.18.1720115541322;
        Thu, 04 Jul 2024 10:52:21 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a81e503sm1826311a91.0.2024.07.04.10.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 06/11] hwmon: (amc6821) Use tabs for column alignment in defines
Date: Thu,  4 Jul 2024 10:52:02 -0700
Message-Id: <20240704175207.2684012-7-linux@roeck-us.net>
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

Using tabs for column alignment makes the code easier to read.

No functional change intended.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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


