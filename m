Return-Path: <linux-kernel+bounces-516107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D528DA36D03
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE8189478F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD2E1A23A4;
	Sat, 15 Feb 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lClWM+//"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577341A4B69;
	Sat, 15 Feb 2025 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612396; cv=none; b=EOx6/9khhDE4nTHOlbqpqBpZObaD4Cp7pRlrI6FJpKzxbSWd7ZW8Pgac7gd8mBqpE/BLUUeE4GliTapLg4+vKeynh8GGK+nI+bkgy85nMKavSmHwBPwJMxkBcP0c4Z97uoOLsGj8pmuWFq7sHXH62BHTae2NxIkOvm/N+9GDazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612396; c=relaxed/simple;
	bh=t1GHjMmU0ognTEYJZcAOAhbfDin+9ghT43s1MEvfcck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pxWpvRT36fDgwKebChi6jmRmNcw9faZZGTigXVLGDDsSqWS5x5eg0XtgoAPGULRIRdYJUcRIihztOsAObK8TZnTyI25lgf+yM6yfF+5/o6zO0kATDLPH7XIuQNG0SPZYNJJGPsOorqdY+6mTszBrp8nJ74pXMvI6HtYhGMd40W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lClWM+//; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aba868c6e88so183147366b.2;
        Sat, 15 Feb 2025 01:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739612392; x=1740217192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lmr3YaTLm2TMny3Haqb4MzDdaWsOi7W4RHKlgDAQeoc=;
        b=lClWM+//cma/mnOYNUCyUgZbSMZpfwZayeS8rBTDZ1gbcrzqxZVD0FgRG9mrzeF5NU
         /4vRA+yRLvak67aq8Ae9knqikd5t4t5EfhmAIyzBQQ2EhSIGUoBK+lHhEK5QTS6tveG3
         q7nDler1NPm4sxarN5Mf+v4WAqEUoFQLs/qZmbQann+/5UJ/hopQtdRksuZq3037fDht
         O1NGdZ6oPz+LlKwi1Rtte6ob1nKMh1b6V1LADpzvIU9ao9HlzaiJ2l9sPGIe6udeBDBy
         sxPBxIf2cBIgi01T245KTbW6yamarNx3LXMibu0vlq9jLhAHyHGNEZSC2uyPwfmH/Y5d
         LNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739612392; x=1740217192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmr3YaTLm2TMny3Haqb4MzDdaWsOi7W4RHKlgDAQeoc=;
        b=QQiTMhVtnd89AzOk9lyKXFVDxU2cQkhlV9Its0cKMVkh89SQUb7VyPOUuPoywxMLM7
         IZye+W/BkUmcaN2z7lDR0JTkvtK+nzqsdJiOF6Pjtwc575jzwYr/yTntNcNEOGRmAdnu
         9V55tHznbX4e908bawAdQamdTGtXaLBu6tacVFeAs0wznzTnVenlhujNGfh9xFkcyu3u
         QssO8Jy+DbCKW5FfaWM7OrrT6Ml3EhQBF5FStsRO9iyFSwgx/y+P81yk3Rb/fWufm7EO
         FcgxHZ1F3CRjUUy3+hTaYLAxEZlF4IEl04DA4B6zqyd84lZs00UZ5uaeJsv1OSvhGvxx
         R2yg==
X-Forwarded-Encrypted: i=1; AJvYcCWwJb5IaoqLO3NvgmsmCh62TvKHrSmrJHFnngGJBcgoITRJKko1A2/9kquZ3G/DWpAh+ye8FwQA3P+Cn+jl@vger.kernel.org, AJvYcCXCH7RX/PMSw7Ii/CPA0Rhm9o0P9eyL816+i0cUBI/X5nVVSFoTPILJiO38Mo1NmwahnxwsabePvbbE@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKe1aFI/EVmqbzDiuask2huc/G91XmTI7rsz2AtoVE2mfrGFj
	FBsgJjiiv4gd9++jMgsSwGFT0Uc5hfXuaGfW3+nCEIl9xUfiZNFL
X-Gm-Gg: ASbGncuI+43BWU4oU5inp4PFBhFCeR/NkZma3Ov1rH1McPUrySRYubNtFy8Da5WzWcT
	NILVqSVjtm11tTdIPDD+tUKixbKBVVvpBLlj3o/a3wpDAWVqRq/diSmqRM8mj3xu1yly0WdREqW
	13KCY/hS9DgetLmHIXHcBF/wKBgIH/lT9LHG7vrBTCCc4B9XMW95WSORBpVhdYBZhI5lqs4fQ8m
	4zQphfh050JF0PpF+rJJfYfNIaSgKrwg5YtqASsOe0L17arX4HTNdwFYkAtrJ50WowDDqFg/Iha
	xhmDol/VGo0oHKRqtE3SdRfxq1838YQ7Ngkob0vGcf1H2gxLveX0Ln3FBTMZ0g==
X-Google-Smtp-Source: AGHT+IHtTXRio0IX06KOJvwoIMmlRaNtlLQCehWw0G/jGNUuBFc/oOUVGLxub/bXrDSDqkRPvqMN7Q==
X-Received: by 2002:a17:906:6a0c:b0:ab6:621a:f87e with SMTP id a640c23a62f3a-abb70de28e8mr203210866b.41.1739612392466;
        Sat, 15 Feb 2025 01:39:52 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb7aecd3d5sm69698966b.148.2025.02.15.01.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 01:39:52 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 15 Feb 2025 10:39:39 +0100
Subject: [PATCH v4 4/9] mfd: bcm590xx: Add support for multiple device
 types + BCM59054 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250215-bcm59054-v4-4-dbfb2d76a855@gmail.com>
References: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
In-Reply-To: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739612381; l=2626;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=t1GHjMmU0ognTEYJZcAOAhbfDin+9ghT43s1MEvfcck=;
 b=RI7LbX6FOYxKwKO5J3j4rVS2/w7E9TrebFBzOHQhttEmNKSR0kMMUamL2Z3ORnLJfWXP+Yzyn
 HzjcYFHR+11BeG0xkJbBEnDlocdF6zjqJYkOshq74kGlY0L9C6aZ4ll
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM59054 is another chip from the BCM590xx line of PMUs,
commonly used on devices with the BCM21664/BCM23550 chipsets.

Prepare the BCM590xx driver for supporting other devices by
adding a "bcm590xx_dev_type" enum with supported chip types
and store it in the MFD data struct as "dev_type". Then, add
a DT compatible for the BCM59054, and provide the device type
as OF match data.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v4:
- Rewrite commit message description
- Rename "device_type" member to "dev_type"
- Drop awkward line break to fit function call
- Add PMU ID/revision parsing function

Changes in v3:
- Fix compilation warning about device_type pointer cast type
- Name the device types enum and use it as the type in the MFD struct
---
 drivers/mfd/bcm590xx.c       | 5 ++++-
 include/linux/mfd/bcm590xx.h | 8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 8b56786d85d0182acf91da203b5f943556c08422..632eb57d0d9e9f20f801fac22eae21b3c46cefd5 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -50,6 +50,8 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 	bcm590xx->dev = &i2c_pri->dev;
 	bcm590xx->i2c_pri = i2c_pri;
 
+	bcm590xx->dev_type = (uintptr_t) of_device_get_match_data(bcm590xx->dev);
+
 	bcm590xx->regmap_pri = devm_regmap_init_i2c(i2c_pri,
 						 &bcm590xx_regmap_config_pri);
 	if (IS_ERR(bcm590xx->regmap_pri)) {
@@ -91,7 +93,8 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 }
 
 static const struct of_device_id bcm590xx_of_match[] = {
-	{ .compatible = "brcm,bcm59056" },
+	{ .compatible = "brcm,bcm59054", .data = (void *)BCM59054_TYPE },
+	{ .compatible = "brcm,bcm59056", .data = (void *)BCM59056_TYPE },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bcm590xx_of_match);
diff --git a/include/linux/mfd/bcm590xx.h b/include/linux/mfd/bcm590xx.h
index 6b8791da6119b22514447bf1572238b71c8b0e97..83e62b5a6c45805bc2acc88ccc7119d86f9ac424 100644
--- a/include/linux/mfd/bcm590xx.h
+++ b/include/linux/mfd/bcm590xx.h
@@ -13,12 +13,20 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 
+/* device types */
+enum bcm590xx_dev_type {
+	BCM59054_TYPE,
+	BCM59056_TYPE,
+	BCM590XX_TYPE_MAX,
+};
+
 /* max register address */
 #define BCM590XX_MAX_REGISTER_PRI	0xe7
 #define BCM590XX_MAX_REGISTER_SEC	0xf0
 
 struct bcm590xx {
 	struct device *dev;
+	enum bcm590xx_dev_type dev_type;
 	struct i2c_client *i2c_pri;
 	struct i2c_client *i2c_sec;
 	struct regmap *regmap_pri;

-- 
2.48.1


