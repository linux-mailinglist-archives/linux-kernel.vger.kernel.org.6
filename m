Return-Path: <linux-kernel+bounces-321541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0267971BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BE61F232F5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4115E1BE845;
	Mon,  9 Sep 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8wfYX8t"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76E81BDAB4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889926; cv=none; b=LYXKFTUU5kGtUlQWv/Ums8MgHsIymwV25MC2a+6S8W2Tu/vumG1su9DqGDt2IY3nj2G6BI854N4vhaBHU088hQRdGS/MdoEeVGwK3gRwvA0Rs3OSUXSzrBhryWU+/+oFdHugQd6hjdCzet6mBQNNgHYZ00KsrPgNMf+VtUtbKC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889926; c=relaxed/simple;
	bh=pT3vklV3r+mZAGNAtUkG8vU9TQS654l0/1TCGybfK8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9J3sEAYDH+Y+y+qU5ogqvGaclWGbpz6D/CNvl+NI7l8D8KqiDD1YLBCsieY6U7zGllx3esJSIYsSe/VDfEUbVf98YZKfmTJqQ+/YimzoRQCnpVP6lUl6vWQURUxnLuGx/jNrUViTFPTPHGd6pyFZ/CxQcWJYHqWdT3dd7bBbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I8wfYX8t; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d2bd7dcd4so8404666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889923; x=1726494723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4QKaI+3WBHRSwPufs3rtV0LI1aQyhehd6Wi2dpHTGg=;
        b=I8wfYX8tfs3bIUlo+wVdT9N2bWdXNilZsA16A0aBYWQvU41B9k4wGQKA7PSt/SuTnE
         i9h68NKghMh/rW7+nwbDgntYi1OEtloe+Btx+m24cPiF0IlMcJJv0sMe7VDlBHUKEerh
         56RnAjrf0KXE0Cl6M5YnZUZm5sDfpHF1J8fQDpLH2mhvg2srThDWZ0tA157GRz94L50Y
         2znr2H3wn18tyU2Lt57f6MRaTJFS23Yx7BqdfnbAhgjfsLELZO8ddkX5IvMGRkJFP067
         +XCKDco8sKxlpDKsY4MQnXkGVo7c3oiaCAHLTf0sNpq6PafIT9QxsMpF6hSngEZy2sKP
         hyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889923; x=1726494723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4QKaI+3WBHRSwPufs3rtV0LI1aQyhehd6Wi2dpHTGg=;
        b=ORXLVJPUvxNfHkAr8z0RiTlLNMisiw6v/2BngtZBbo5pAA4kttT1aOIuRBvK4DszEq
         /sF6Ye3gv4JkaRxfB6W6+6lNWp9N8lkd8wayI+AcncMxPYI3hbJgpKjzBHvEJya3kLZU
         RyMD6lXtt4+iLr3lpHbzlKAP0lUuwOhqoC9Tk0LGLlvUtwnvUXK0MTglcApdnbkwUzba
         h08iCjoioTwzrau995Ymx5levt0P8I73aZuWp96VjBt77IkBoaYuDWwWbBFcKMPDDgri
         u6avdLVNs8U3tAxJ7zqsUDKQtpkNipF1045B5+yimqSiMn/QTIHpJnCd8xhnVP1nCk4B
         l56g==
X-Gm-Message-State: AOJu0YwNb8Tys5WONtJcPJylx+n5CEd5FAxWDHMP5ZqejGIOhd1ypZqw
	MzV19ysJW++8Q8+w4UrF9uayapC5H3MDhC4+VJcOtwMXykfwtGb1PDFDn/YRrtY=
X-Google-Smtp-Source: AGHT+IFkB5FwZ6RP2VpeDYDu58V07W5VhL+BMyppWhQzRBjqI5M81sTuW26HDIwx4LByUJ7TdWVeBw==
X-Received: by 2002:a17:907:608a:b0:a8a:7189:2106 with SMTP id a640c23a62f3a-a8a88803359mr291596666b.6.1725889922892;
        Mon, 09 Sep 2024 06:52:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf3ad6sm345344566b.148.2024.09.09.06.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:52:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Sep 2024 15:51:28 +0200
Subject: [PATCH 17/17] regulator: max77650: Use container_of and constify
 static data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-regulator-const-v1-17-8934704a5787@linaro.org>
References: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
In-Reply-To: <20240909-regulator-const-v1-0-8934704a5787@linaro.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5091;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=pT3vklV3r+mZAGNAtUkG8vU9TQS654l0/1TCGybfK8Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3v1nXIJdWNbRtDH6jLRbfKirVbrDR9hrPibYD
 A0gRNKrWKKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt79ZwAKCRDBN2bmhouD
 14qVEACRgLsVdWDXrS20GsTp4A3Ag89uPdX4Lm1yhjam8q9PHA1EcqEd03qyD9++DH9J+ze5ujx
 c9LiuV8Y4yAXbrIxGmNWOpx5u/7JoGvGjwsAKmG4P+E5hnO96bKsupFq0ZONfubtSA7efMP65qw
 xfW4XKiQcPq3KaXujdFdgnhdkG8ultcDksYS2ZU/MB3hiiFytZi6dddp7Mfzx7BEHgs7yF4s9m8
 yoigsGsbquv2hbcCDnb1ytwDxR+un6SE33cXwUfo5pNBXAW92nmpQbtbWykifj6vIMjV6CmbraR
 52C5s+4gdyII3bdtf4HvUTcz66Asm+/9ihcxYClBn5HiA6lUefRTJjN5zqznTDK0L3zPULYVR2h
 WbLPZiHzj8UDkLW4aGaclTo/gCX5gAgyzDPphNHbsFx185jVuudPHcW7xU1b+9qMguFXzZIwSlp
 5tmlv7aRCC/dGhe1JG9DX3G6ICnQW968kLzlnqDcw6EEHsON1+e8XB/FzHZM2TpHLPTUcRdr5D/
 1o0NHLpdQEnvyS5eZKbx08DylInn6xnZ9QbOZ4sYmBITYGcD8Ou4rdHa/lZHhBW1+E0C4QUP16t
 fLQaiHp2fnlt+GpZXPFrbgCuNfgB6MoliRVSldN2+bWRS5k1sbw8oTaQWBmbqNuZRtcbE5JSIsL
 1RjfoAwiIZmG/ZA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Switch from rdev_get_drvdata() to container_of(), so the static
'struct max77650_regulator_desc' holding 'struct regulator_desc' can
be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

[RFT]: Not tested, only built.
---
 drivers/regulator/max77650-regulator.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index 94abfbb2bc1e..7368f54f046d 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -43,8 +43,6 @@ struct max77650_regulator_desc {
 	unsigned int regB;
 };
 
-static struct max77650_regulator_desc max77651_SBB1_desc;
-
 static const unsigned int max77651_sbb1_volt_range_sel[] = {
 	0x0, 0x1, 0x2, 0x3
 };
@@ -66,11 +64,11 @@ static const unsigned int max77650_current_limit_table[] = {
 
 static int max77650_regulator_is_enabled(struct regulator_dev *rdev)
 {
-	struct max77650_regulator_desc *rdesc;
+	const struct max77650_regulator_desc *rdesc;
 	struct regmap *map;
 	int val, rv, en;
 
-	rdesc = rdev_get_drvdata(rdev);
+	rdesc = container_of(rdev->desc, struct max77650_regulator_desc, desc);
 	map = rdev_get_regmap(rdev);
 
 	rv = regmap_read(map, rdesc->regB, &val);
@@ -84,10 +82,10 @@ static int max77650_regulator_is_enabled(struct regulator_dev *rdev)
 
 static int max77650_regulator_enable(struct regulator_dev *rdev)
 {
-	struct max77650_regulator_desc *rdesc;
+	const struct max77650_regulator_desc *rdesc;
 	struct regmap *map;
 
-	rdesc = rdev_get_drvdata(rdev);
+	rdesc = container_of(rdev->desc, struct max77650_regulator_desc, desc);
 	map = rdev_get_regmap(rdev);
 
 	return regmap_update_bits(map, rdesc->regB,
@@ -97,10 +95,10 @@ static int max77650_regulator_enable(struct regulator_dev *rdev)
 
 static int max77650_regulator_disable(struct regulator_dev *rdev)
 {
-	struct max77650_regulator_desc *rdesc;
+	const struct max77650_regulator_desc *rdesc;
 	struct regmap *map;
 
-	rdesc = rdev_get_drvdata(rdev);
+	rdesc = container_of(rdev->desc, struct max77650_regulator_desc, desc);
 	map = rdev_get_regmap(rdev);
 
 	return regmap_update_bits(map, rdesc->regB,
@@ -145,7 +143,7 @@ static const struct regulator_ops max77651_SBB1_regulator_ops = {
 	.set_active_discharge	= regulator_set_active_discharge_regmap,
 };
 
-static struct max77650_regulator_desc max77650_LDO_desc = {
+static const struct max77650_regulator_desc max77650_LDO_desc = {
 	.desc = {
 		.name			= "ldo",
 		.of_match		= of_match_ptr("ldo"),
@@ -171,7 +169,7 @@ static struct max77650_regulator_desc max77650_LDO_desc = {
 	.regB		= MAX77650_REG_CNFG_LDO_B,
 };
 
-static struct max77650_regulator_desc max77650_SBB0_desc = {
+static const struct max77650_regulator_desc max77650_SBB0_desc = {
 	.desc = {
 		.name			= "sbb0",
 		.of_match		= of_match_ptr("sbb0"),
@@ -201,7 +199,7 @@ static struct max77650_regulator_desc max77650_SBB0_desc = {
 	.regB		= MAX77650_REG_CNFG_SBB0_B,
 };
 
-static struct max77650_regulator_desc max77650_SBB1_desc = {
+static const struct max77650_regulator_desc max77650_SBB1_desc = {
 	.desc = {
 		.name			= "sbb1",
 		.of_match		= of_match_ptr("sbb1"),
@@ -231,7 +229,7 @@ static struct max77650_regulator_desc max77650_SBB1_desc = {
 	.regB		= MAX77650_REG_CNFG_SBB1_B,
 };
 
-static struct max77650_regulator_desc max77651_SBB1_desc = {
+static const struct max77650_regulator_desc max77651_SBB1_desc = {
 	.desc = {
 		.name			= "sbb1",
 		.of_match		= of_match_ptr("sbb1"),
@@ -264,7 +262,7 @@ static struct max77650_regulator_desc max77651_SBB1_desc = {
 	.regB		= MAX77650_REG_CNFG_SBB1_B,
 };
 
-static struct max77650_regulator_desc max77650_SBB2_desc = {
+static const struct max77650_regulator_desc max77650_SBB2_desc = {
 	.desc = {
 		.name			= "sbb2",
 		.of_match		= of_match_ptr("sbb2"),
@@ -294,7 +292,7 @@ static struct max77650_regulator_desc max77650_SBB2_desc = {
 	.regB		= MAX77650_REG_CNFG_SBB2_B,
 };
 
-static struct max77650_regulator_desc max77651_SBB2_desc = {
+static const struct max77650_regulator_desc max77651_SBB2_desc = {
 	.desc = {
 		.name			= "sbb2",
 		.of_match		= of_match_ptr("sbb2"),
@@ -326,8 +324,8 @@ static struct max77650_regulator_desc max77651_SBB2_desc = {
 
 static int max77650_regulator_probe(struct platform_device *pdev)
 {
-	struct max77650_regulator_desc **rdescs;
-	struct max77650_regulator_desc *rdesc;
+	const struct max77650_regulator_desc **rdescs;
+	const struct max77650_regulator_desc *rdesc;
 	struct regulator_config config = { };
 	struct device *dev, *parent;
 	struct regulator_dev *rdev;
@@ -376,7 +374,6 @@ static int max77650_regulator_probe(struct platform_device *pdev)
 
 	for (i = 0; i < MAX77650_REGULATOR_NUM_REGULATORS; i++) {
 		rdesc = rdescs[i];
-		config.driver_data = rdesc;
 
 		rdev = devm_regulator_register(dev, &rdesc->desc, &config);
 		if (IS_ERR(rdev))

-- 
2.43.0


