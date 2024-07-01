Return-Path: <linux-kernel+bounces-237043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426BB91EA3A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7C7282C25
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB65C1741D1;
	Mon,  1 Jul 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kumCN9O1"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8883E173320;
	Mon,  1 Jul 2024 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869043; cv=none; b=iApsSh0gABlRJ1hweeNlqae6Qmkb4MItDCWgqIMc2hkueLXufEhji2RqRjV38disRt8sxO0TXnZ8T7E4UzEH8e8ocHNBv3xTH3p2tLWfIBbpLNyB4JrZg84mDTLq5MYXHBK4j+tZDHSxJfYhrrh8Pz4sHGETe9tAZlWdBtQtBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869043; c=relaxed/simple;
	bh=iMHG/Iy5JSd+zMx6HbmL1U/PD3sdQzLYPScMt54Et/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kt7mF+k/Z7nfzNPsx3B5zWxT0lskMk5uMZrE4NZhWlW8chkUbAj0o0DClr/B5UpuMB2YWtcHuRoMCR6WGWGD1Y957uAbjYhzd6pAcd945dbXm63DnfTDQuJrMBSqyl8SsJYDuzumlfJLuMn7Zcz/6HhHU5RrhMB7Oy8B2TKFOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kumCN9O1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fa07e4f44eso23014215ad.2;
        Mon, 01 Jul 2024 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869040; x=1720473840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdZRAJCKkdsgV4TiQnVnwZ/lQYo9HpZX2FKBPS+q5ps=;
        b=kumCN9O1PJlu51VjPhvm1UsMNYSqPnqg46vxs9kCW6A6oVe/c9jJcFmXpB7Gqx2wDe
         kjrexCUII0+CwN6WtJ7Z1hAhKtOjzwNwPDj2CgOYh9hDFtodVdeZ7SeRiCQ7g9L0t4wh
         ne2CGdpexzlULwhfhz7wzav8q1cxdu8Y8CkRV9IO96CO3rZWiPWC70rzdmfYTuhVBi7i
         0252IJYshCv3QJK2kW+LDTu1GCtVzAkLhOC88yrrf5qsX0ly3SzoTqq35mKrVnf8Wmb+
         l+4BRBdIsbh6iHR7QA112kyKAXW0NIc7U6kkTg95iH6CIvRC8Egi1PD0ucr4dqoWxyoP
         42NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869040; x=1720473840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PdZRAJCKkdsgV4TiQnVnwZ/lQYo9HpZX2FKBPS+q5ps=;
        b=QX5vkiEzn1t4nX4CO8ZfDNdJi7I/wgL6UlLSezuUZfC931XdC7+nZivUv1Y2LV1d3r
         /Xbs1UlkI1ytlRnhRh8f/77CvZ4o3u1l1/az0qufLlbThQ7GOXamKCSxyqdSZBRB3E/x
         GuVQ1p61FkxjQE14mFpCktvh5vxXgWhv9onklUznGOgyBZYtCaxYYxIrOiYs1MO2bwy5
         N15z2JL5EAD7imPO+nFlE3FTmPtrJbieauIjzRyEvf07jIgWZtd7qG+cAP/sLlVvQe9f
         H2WCkLevZtUaz/JhKtHVoIaQf74ykw4hiLc0lJkPg0So7xgrcLXB/6q91WjqnTDaMHqZ
         Qp0w==
X-Gm-Message-State: AOJu0YxW02mJb/I5EduzbKKr+W0iEtO4vyMjiunCQFaV5x4MJobcvcj7
	c3RIScQ2G4pJGauj0zkJMPHmbzxT4ACX5jPnja+sTtOC4ly8lku2qEngHQ==
X-Google-Smtp-Source: AGHT+IH5C4N3MVTn0yTQGkwrV6cttoG9nF7ef8UuTK/xwoDVdQEr3Y7vkv1+9x7sBoA1t+vtV2anEw==
X-Received: by 2002:a17:903:183:b0:1fa:a94:4fe with SMTP id d9443c01a7336-1fadbc73db6mr63615875ad.17.1719869040381;
        Mon, 01 Jul 2024 14:24:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c7067sm69701875ad.51.2024.07.01.14.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:23:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 06/11] hwmon: (amc6821) Use tabs for column alignment in defines
Date: Mon,  1 Jul 2024 14:23:43 -0700
Message-Id: <20240701212348.1670617-7-linux@roeck-us.net>
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

Using tabs for column alignment makes the code easier to read.

No functional change intended.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Add Quentin's Reviewed-by: tag

 drivers/hwmon/amc6821.c | 128 ++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index e9d345c8064e..23111c6cb142 100644
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


