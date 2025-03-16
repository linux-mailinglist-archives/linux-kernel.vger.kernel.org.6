Return-Path: <linux-kernel+bounces-563096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A47A636F2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46077188F4CD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 18:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6881F8BAC;
	Sun, 16 Mar 2025 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLE02i59"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0BA1F4725;
	Sun, 16 Mar 2025 18:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742149167; cv=none; b=RRyoJ23v9KUlsHsexY/r8AqdKih0UCZUrTVI7+yVYXGsNRFvotlJHmNJNDLROll/yyIFffkoVp7tM9eHV91Y2a5lGq2C40CCXcy2MmyiDSuKNRyR7M426X8SGfXTKn3aqDaLluSFnVruhYlzdrX3rPNd8UoIqk0bIs6tWLuBI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742149167; c=relaxed/simple;
	bh=Vau+qtkiLKbsSAyta7HK/1aydJ9QZlhuWFoLqVhFrJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0ZjBweGervUEQiGo0sDhI9VENZgGhjFy95u2oAAM8O1tos3DWXp7wwZgaPlX6a9kVgcuQauSd43JfC1M1JXMaBiLjKHERwCdtU+DMqVd9AkpMRa7Tqw3jaS1o5Pb9Ci5qpUC8WkGWB5Ge7nrQPte/EFQAOtea2kaovhLcc/fHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLE02i59; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac297cbe017so875886666b.0;
        Sun, 16 Mar 2025 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742149164; x=1742753964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+2M+lUouAH0+Jr+nyjeHl+wxA0K/oLUPdCGmVRRMGE=;
        b=WLE02i59rYg12OVKBwiDxNoTW9/bq5Aieo49e8aTGl8wVVeo5NVuKkL92ent+Z0FWu
         pph/5bCFL2WsuSblMk1UeW2bkDbH5yyRkYElGuBGoqu/AtYFKlJ5V19yD5rRr8sIRyss
         pySYF1LCmlEtYH0Qsdzvhugg4fckWmREWV4R+NBmZESJWfkpoSNXs1q79GqzxGC7S/ft
         KZNO2tQRBT1tIabusqwZom9pjInDfDwe6eprrdwZMX/nL2MpewqH3hKXuvKk4klAnELr
         xFUL0mwGht8LQ/B1SVkng61Z4PnERCmS3y1fs45qSpBSaR1GhBT4WJMFIm/aFKOM75GU
         badw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742149164; x=1742753964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+2M+lUouAH0+Jr+nyjeHl+wxA0K/oLUPdCGmVRRMGE=;
        b=wMx/EUPBpOsuOiSo0Y5Y8M3Ajyi80cZgt45S9hAD0Cp+v9WHFzNp9XXcXQZAf9dzSs
         AHRwlQXpO7UlDimbu5voQVkE6cHzQZ1stSHy3bT4u5TY8woztlqhbVSg33MJ3J97qvmE
         MEfGJKlyDZy1xMT7A0h4rE02MQzOMXnPbOqiRfF4ARQp0HSuGKGZi2sGQdYTvcPDV7ct
         lTF75kJ/zk5cdhpXhAMbN/Lfb2YYpIYX1UnSPDLXOl05l93wPGmr+jTozyrRMEWbNShx
         sEFUT7boFyqsfsB2Zua60GzuGTESPPPISTOT8rfbMIViibF484UKOOV9PLGrU15IBMJv
         gqvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW44DqaLiBkHHi4EnfOLpA/1nakdpXpIYq0NAlBcECat4dp0hnbONrhVbd4iSgwApHM7RlrI5+0lOUhBhJ@vger.kernel.org, AJvYcCWlLJ57CtnkOmOXJSQCCCyC30TY9239XFI3OXcSVPX0x42PjqbsdZEHAdEd1s9uc4VzInS3zBkSbmn0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9VQzErOAWaqoqjjDOXXH3r5YvrcJ/pYfezsmSSISA11zTRp6i
	xVHyyiQQ2cnfGbtrfj7UsD+5uEQrdnuF9Km+eAjQecou3h4WUrku1Bebqw==
X-Gm-Gg: ASbGncu1JWHRpguu1zJwKoW9sPx4CGU3NacjqhDBeRbjX/1xyVh11vi36KRAfGB6BY5
	mkoztB+ZLtVjQzwtTfUkVfhwFSL1crEN1EfTf+Onpw8udLta2SMylJDM1eMK8YmxqLhL/voj4O1
	m5qNXQcMcL8BDpSiBfG+V6pOFMmDhuZAGDiIgNM6dRlraSO/UZxDqG+ODCD0XTGA7n7pVoTUxqb
	aYJrXMAAhRmzPnOhg6be0IdbxN3zFu/sJYCMP50e6oMCAk2xzjiudXVtMYK5KegwLFfKaFHgYld
	Pga8mBUFjZITxvUzqdjq+m1UbusCh8XX8hT3w+BeVkNaXCVeWyUHt0RC72X6CAIlMJhGH6+xZSd
	JbzWFoOgNkABOJQyFUQ==
X-Google-Smtp-Source: AGHT+IFsTvbuptCDYunQGEX3V0GFkwHGo4NapBLiRy6Vd2DahCTU9/K1cdfNQ0FqD/7wqDp8TOiXNw==
X-Received: by 2002:a17:907:c5c3:b0:abf:6f95:22fc with SMTP id a640c23a62f3a-ac31250d4edmr1435495666b.28.1742149163867;
        Sun, 16 Mar 2025 11:19:23 -0700 (PDT)
Received: from hex.my.domain (83.11.178.210.ipv4.supernova.orange.pl. [83.11.178.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a48b51sm537951266b.149.2025.03.16.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 11:19:23 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Mar 2025 19:18:53 +0100
Subject: [PATCH v7 05/10] mfd: bcm590xx: Add support for multiple device
 types + BCM59054 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-bcm59054-v7-5-4281126be1b8@gmail.com>
References: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
In-Reply-To: <20250316-bcm59054-v7-0-4281126be1b8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742149152; l=3092;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=Vau+qtkiLKbsSAyta7HK/1aydJ9QZlhuWFoLqVhFrJQ=;
 b=Puz/3rKPW+vwQzNF9UX3IyuvqUyjRTbdWltpxzMJVrt/04G9WW1WaR+0YI8snfqoouVhlGiHZ
 k8OUNSztcexBGxV73E4xGFmXY1qw2F3+nF0cL/yVTd+++L2hKHw87Ft
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

The BCM59054 is another chip from the BCM590xx line of PMUs, commonly
used on devices with the BCM21664/BCM23550 chipsets.

Prepare the BCM590xx driver for supporting other devices by adding the
PMUID register values for supported chip types and store them in the
MFD data struct as "pmu_id". (These will be checked against the actual
PMUID register values in a later commit.)

Then, add a DT compatible for the BCM59054, and provide the PMU ID as
OF match data.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Move PMUID value to MFD header
- Use PMUID value as OF data/device type value
- Add bcm59054 to I2C ID table

Changes in v4:
- Rewrite commit message description
- Rename "device_type" member to "dev_type"
- Drop awkward line break to fit function call
- Add PMU ID/revision parsing function

Changes in v3:
- Fix compilation warning about device_type pointer cast type
- Name the device types enum and use it as the type in the MFD struct
---
 drivers/mfd/bcm590xx.c       | 12 +++++++++++-
 include/linux/mfd/bcm590xx.h |  7 +++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 8b56786d85d0182acf91da203b5f943556c08422..4620eed0066fbf1dd691a2e392e967747b4d125b 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -50,6 +50,8 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 	bcm590xx->dev = &i2c_pri->dev;
 	bcm590xx->i2c_pri = i2c_pri;
 
+	bcm590xx->pmu_id = (uintptr_t) of_device_get_match_data(bcm590xx->dev);
+
 	bcm590xx->regmap_pri = devm_regmap_init_i2c(i2c_pri,
 						 &bcm590xx_regmap_config_pri);
 	if (IS_ERR(bcm590xx->regmap_pri)) {
@@ -91,12 +93,20 @@ static int bcm590xx_i2c_probe(struct i2c_client *i2c_pri)
 }
 
 static const struct of_device_id bcm590xx_of_match[] = {
-	{ .compatible = "brcm,bcm59056" },
+	{
+		.compatible = "brcm,bcm59054",
+		.data = (void *)BCM590XX_PMUID_BCM59054,
+	},
+	{
+		.compatible = "brcm,bcm59056",
+		.data = (void *)BCM590XX_PMUID_BCM59056,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bcm590xx_of_match);
 
 static const struct i2c_device_id bcm590xx_i2c_id[] = {
+	{ "bcm59054" },
 	{ "bcm59056" },
 	{ }
 };
diff --git a/include/linux/mfd/bcm590xx.h b/include/linux/mfd/bcm590xx.h
index c614d1b1d8a217ac2f212908a4c19ae71fa56f63..8d146e3b102a7dbce6f4dbab9f8ae5a9c4e68c0e 100644
--- a/include/linux/mfd/bcm590xx.h
+++ b/include/linux/mfd/bcm590xx.h
@@ -13,6 +13,10 @@
 #include <linux/i2c.h>
 #include <linux/regmap.h>
 
+/* PMU ID register values; also used as device type */
+#define BCM590XX_PMUID_BCM59054		0x54
+#define BCM590XX_PMUID_BCM59056		0x56
+
 /* max register address */
 #define BCM590XX_MAX_REGISTER_PRI	0xe7
 #define BCM590XX_MAX_REGISTER_SEC	0xf0
@@ -23,6 +27,9 @@ struct bcm590xx {
 	struct i2c_client *i2c_sec;
 	struct regmap *regmap_pri;
 	struct regmap *regmap_sec;
+
+	/* PMU ID value; also used as device type */
+	u8 pmu_id;
 };
 
 #endif /*  __LINUX_MFD_BCM590XX_H */

-- 
2.48.1


