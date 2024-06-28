Return-Path: <linux-kernel+bounces-234103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFB491C241
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E8B4B24429
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3847B1C9ED6;
	Fri, 28 Jun 2024 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9xroZbZ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6381C9EAA;
	Fri, 28 Jun 2024 15:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587645; cv=none; b=htJnYlrJnV66JVd5O9NBMO0euUe+fkToRfL2fKKZj7YEKnPKihJKzMd4+ZosnEHn0tz/fNlOwLqNzv+YnE0tDiP/ycX8zZsbpFW67atFkAwyO7sB5CAIXYHduCESVV0/T5VRN5Pyts520SHyesLYBblJtrkgFWFRpk7L/537o6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587645; c=relaxed/simple;
	bh=FPcAS1h017rsrdrXADJIQuYuXZQ7Be8062QstMNA5Cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6k7MdJHSa8vKohq8hRT4KW4hf2o0r/EGY5ngd3VRb+FVsTTdsUUZcjy2R0KrgEGyx6xdXYaAnSoPwQxfFyYfcohOd1EtPvHiZ7c0eVH51/VDbCOcFlrtmUnJdadoKEuWhDe5YIg4oSYMfj1/N80sGJyXs68qVdzDfjxl3EIRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9xroZbZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70698bcd19eso563572b3a.0;
        Fri, 28 Jun 2024 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719587643; x=1720192443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAJlamRBY7B+Tl0+O7T2GO8BElHTOfeCvUNUKkSsRao=;
        b=A9xroZbZqSfmCqZHzdljqvPXAu/Yz84OfuOWDw/hePPLkzqiE4+30l29RTzBrXpr8E
         SzV830fi+G0SndQe6qxPtGrwxUeSG/ZV/RkRtmyBW4jwv91PCUeeaXsRxlLVHufgtqZr
         idJa1ByWwn0GPK8F1hnfmkBNSHJt05na3YwABnjXvtmozvvL+0aQykFS4BSfT27EdFBw
         1xku/UF0p2+BAElOnfZ80hB+pkqwHWB0EQmwqMgJG60M920qdKt8fKAQXx5LyRH4rrFy
         fCIXtn58QR8cHc1Wxta3K3KJs6Qz4Kxh0pVVSEJBJzuoZs3llWLaNEIej2TAdQHpSu2u
         vhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587643; x=1720192443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YAJlamRBY7B+Tl0+O7T2GO8BElHTOfeCvUNUKkSsRao=;
        b=LYykGYQoOOT+8+/cpW+8oJ1M7Tt0vo5f0OrzfaavOhLXhhs1e4r4BALBUYmrcxlcUl
         SE3BRorSGjvZublzrl7sfJC+y8w2+N+dqp5RapowdrAnFeNFmQDNFdxAt9w87N5lni/T
         lcWC1aazPFw+OieWfNm0Hnuwb9BF2uOVH0KqqPK7yMkodVGAMe9uTNzH7hUyZfJX7tnE
         jrYf5euqSowUTMpfSLtr0yUdxBe6G2Emmlq4YowTehavC8R9nZVIWqbi3jbZM4Z3VWka
         jwqPETHBjNHl7X4m8YCjbyEGr4cTUhCX9yuRdaj/i3IvTQcEOHswoPqaRmO2Dr5RxbWy
         j3WQ==
X-Gm-Message-State: AOJu0YyUtzvH2fvZN/rb5+7XegCxAhV0u0BKogHtWnrVYKrkbySdBdmM
	JsW6xVJV7nAAPCn1NYRI2EyTWnME72D8c23vqiYymLjzZNyDdQ+2b56YgQ==
X-Google-Smtp-Source: AGHT+IGaAMDPQscgSyXb1Y5MEPrlkV/Ec8UWpq77gpLbKIA0RegkGbfvpTV35paXwsq02tFEW+l/Cw==
X-Received: by 2002:aa7:870e:0:b0:706:6f82:7e0c with SMTP id d2e1a72fcca58-706746b5896mr15093147b3a.32.1719587642690;
        Fri, 28 Jun 2024 08:14:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a97ae3sm1713860b3a.206.2024.06.28.08.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 08:14:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 06/10] hwmon: (amc6821) Use tabs for column alignment in defines
Date: Fri, 28 Jun 2024 08:13:42 -0700
Message-Id: <20240628151346.1152838-7-linux@roeck-us.net>
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

Using tabs for column alignment makes the code easier to read.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/amc6821.c | 128 ++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 0ac073f83c19..03ce2e3ffd86 100644
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


