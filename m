Return-Path: <linux-kernel+bounces-526581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B2DA4008E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D0642593F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B250253F3A;
	Fri, 21 Feb 2025 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z998P0uE"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B9253F15;
	Fri, 21 Feb 2025 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169003; cv=none; b=WDiyfPuDsauoCxpJ8SMR5Tn+y7KnG4JsoRTWZ/1pBw7Qt2iwlDzy8Gr2BXU6gjRJkbPjU8knj3Xd2FSTuq0nQikPdIDbXYIWqnT80dro5STRCfGbKF347CkGt3qwxwMvVnOwQ3tThT9/H93WzI3LMRzACsH6BQrckp+3rh+GfHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169003; c=relaxed/simple;
	bh=t1GHjMmU0ognTEYJZcAOAhbfDin+9ghT43s1MEvfcck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCBMNNmGRae66nBYqk1PYfVoPOG4HMwlkKC7Kn8C7IBLTt5eC9BWcDoLY45M8voSKtSFJ9GAqpF1lEi3/3Knmu6KYv/3bmQeFdTPyTzSWrv5BAqlFAt3ltbvZvurqdiezAzi4vhLAxm4OddUieTcX8Eaf6C54HSmm/cZiGpXCz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z998P0uE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e0516e7a77so3833937a12.1;
        Fri, 21 Feb 2025 12:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740169000; x=1740773800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lmr3YaTLm2TMny3Haqb4MzDdaWsOi7W4RHKlgDAQeoc=;
        b=Z998P0uE2J6n3hXDRCeY9MqG4B09eb4U9MFdcUOmWma8qAyLRCojt684WSPqs176LW
         lqsCmj4YSCG2iQI1FjsNogi/DCjYJq/xToo/6IHgE12pDa0pd0m1S7vZswmVNKZ6W2VB
         PbjmlrxBFEe+hV0P/MfNlW92zZW5YAD4HSsDBLbtcUmjMDLsnrGzn3XPg09orKRoI9z6
         iHmKNIt6kdb264z4PHsXerxUeNrHw9/fdyLpBpE3u9Z0mbd3jwz6fGLVQJUYVBn5nhre
         oWVQCSvzgQzSn/38tzmG4ttMc5WWXD0WngZloJY0DbKeqoM8MmqN6e5yteiC+7jno/Jb
         aAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740169000; x=1740773800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lmr3YaTLm2TMny3Haqb4MzDdaWsOi7W4RHKlgDAQeoc=;
        b=pEUksaQ4vRT7haCOrFAmZz4naN/xwzc2+9sa2JW9cr3v463ovxzokyP/5x2aWyPjyD
         8EytlrCQAK1FdBuah0yrz0liI41bYS/XRS73gAt/RRoz771Lc12ZPRK1ICpXlXfYNUoX
         xgRGgDKtduUz0y+WfsHLFHLbGO2hxw1qM0NVWbltl6lZcw8C0u9ajtJXCtA8kLFlbcke
         hFPeJm+9w+sGjbd8rWJTui+l2PD0YTuyIbgO4WiuC5qzJGC/1vYdA7RYqxBrdWvrI022
         j68wvMaGt12BqJPjN32Alr7UumfgNGOJqASM7UfN3zibXQYYaW65pXKRez+lGa1DNWUo
         uWsg==
X-Forwarded-Encrypted: i=1; AJvYcCU8BS84TJKe3LHVJYr4Cy/I+DmtUAcDhA96TedN49H62ZrFhTq8nssysHD5jTHZKJ0IaySmrvRbQe1w@vger.kernel.org, AJvYcCVBzfjgElzPraL7imBZqW03Mv8YBgswB56kDaRa+dKxpaAIMpiyBrAJ/a+OzeXPI05Fp7/gRsjC/WBMGRws@vger.kernel.org
X-Gm-Message-State: AOJu0YxWk7gU8OnuTP/Pb0Hhw/AkuRFhHvsfGtVVdscVqN/tp7xNkLP/
	ieNTn+9M42FKuGd1N4gHHQgC/T6cCZVD2GjW6BYJUJIJu3q653bpjgcHLiB9
X-Gm-Gg: ASbGnct+6MBt1EbLMgr6+FXufc+iet/Q8k+cZfJupajRzdgBQ5Wg0QxLz2LyWcPap7/
	4xZiqBjyiqQxN4UVkiab4+E49RKjgtl4STVDK00ZCT45RfEJwyTq1tehafZ3snfE4vnj3lGxq7A
	+ES1TNgf7032H1+Ejmc4V/UdJbMNwmgluXST545pHS8IMRJUWVXpME4y82L37cdTwvx6hFnXqFa
	2ga06rUsC2xoy5MW80KXGyiApUCPGzn5KDujgAVaxzMB3NkhNPMF+qooNXky+quiqH68/QiYunG
	mCZlfL/WhJ9JwAKUUuZug0zuVZMIhjM/WgOSeqyyyDBD9lkoKE5Sm+M28k3AWxPTj7HZ08pX
X-Google-Smtp-Source: AGHT+IEeKOS8OKCsI/ty3zePkmJDpCNDVO0risKPCTuABCL5ejXvmTQrB5HccUNC0YkgxKNgnt/D6w==
X-Received: by 2002:a05:6402:430f:b0:5e0:4710:5f47 with SMTP id 4fb4d7f45d1cf-5e0b7243e16mr4226037a12.23.1740168999708;
        Fri, 21 Feb 2025 12:16:39 -0800 (PST)
Received: from hex.my.domain (83.8.202.192.ipv4.supernova.orange.pl. [83.8.202.192])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4f70sm14127594a12.12.2025.02.21.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 12:16:39 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Fri, 21 Feb 2025 21:16:26 +0100
Subject: [PATCH v5 4/9] mfd: bcm590xx: Add support for multiple device
 types + BCM59054 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-bcm59054-v5-4-065f516a9042@gmail.com>
References: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
In-Reply-To: <20250221-bcm59054-v5-0-065f516a9042@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740168989; l=2626;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=t1GHjMmU0ognTEYJZcAOAhbfDin+9ghT43s1MEvfcck=;
 b=Y3l+sREpXyFYOU8qs/T6Jp2nukNDFnsJJtx5eMGBfeDRnFSBW6I2OHkxh2gNxpgPPV/82Dz/7
 +VR6B90B4UmBQdIdzfpNQgbeI3CeK/WyKJveT4bxIUtYf5vJKq8fNRy
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


