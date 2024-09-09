Return-Path: <linux-kernel+bounces-321530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2752E971BBE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8CF51F242D3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE641BBBDE;
	Mon,  9 Sep 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R1X4o1Cn"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4CE1BB685
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889912; cv=none; b=WWX6kvblzhreJ4DiX2Lq2p+vT17Bdr0sJuvBHUdi4dUCNMZELDMk51M3/p3yEDDCWnnwn22ruUvoBX+VAL9rn7xJmy2kIL3b/z7sYDzQ/F/T3bAnYuLrPIwlbFbhMltPExfoQmHuZpb5zhu1n9yorRGfl3nwKgI+MH1RrNcujgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889912; c=relaxed/simple;
	bh=aQxdvJysaJsMuCiXGmuPsUG5zXaAXydDbTeDR80ECyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FsOeVdoaVpxME1GlpwHjGH6DYGlaRJPn6vr45+l/K2Ta96i2pFmmZCOMrP95VTrcAh7GQGYTzM093vA26yutPAXS3jtN6+QB4ETIihgo491G3mCANPjPdwBnVWvlydHHr3aHkYxfUn+CE9AQ0u6aYV48GQP+AifQkFDzawbkUk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R1X4o1Cn; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c243ef5322so847083a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889908; x=1726494708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FndzdmkQ1TyGddm5J1kGgfQG5PZMqaxnpW3JAkHAkvA=;
        b=R1X4o1CnjAw2OlweZP3yXAliuF3exIxoRbfC5XI1syBb+fn53fApg24x++PA43Vw96
         APIsHyVhs3P/xw7zyoj5pQKtQazbZW6cht+7HGxpV1Fy3eEInXvJFRk27eblOR0ivU9+
         RiRHq/DRSOpK6khb619guYu4azimqdCM6WZLP0OriWbBqJktEa7ArGs8v/8oNOLsxY4N
         HkXHKm2BL3p0gGG3qRjWpR5bgywwgUC+hB+mPJBJQP6oGVqks4Dw1rH1Cva3MyHscitR
         kkTqhcsynaGd+QyHixYY7VBbd7cfWcg5ZbaJXflJrzdqDt5Yhh3Bi8j86B7o8eUyhNFt
         D5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889908; x=1726494708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FndzdmkQ1TyGddm5J1kGgfQG5PZMqaxnpW3JAkHAkvA=;
        b=U8C2CJm/a+xQ8+Uqf3CE/PjkQHRAtV3EgmNYsLzseaw0C1Z00zhCGmGSM/aiRqU0H7
         BnLxwY16x8MUhaNAYHJfgqRFncs3LIjGSs3UhPSfgZE69HoUZwPdvEdJY9diqM8uaEyB
         vQQ9D+32viWpLNPTSGRCnD5QMTK7nAMEq9o/qldhcjPyBYZQGqQ0ET4m8j7sLk1QuDAr
         jBvhJB3GqJTmGAET4DdFsDGSjarn2bzZQIW3RZM8tpgqTi7cCPSN25QNLR0uw377j0U0
         fpPvBNrLhsG3g4pm2JzQwu5aw/2FK0EdaWQoosucBaYoOSeMEkYAzCNGpRh4eNl3RHzp
         rrVw==
X-Gm-Message-State: AOJu0YyFapZAaYvqFpWm0L1g5Xa1wTTZC97V0/ONEFMet/9TkHwWRi7p
	3JztxuO/CDjTM8AAgePtZdBQb5Uxi78YB9kFtn9iCN5iweXPV4OEvXvWnX74VVQ=
X-Google-Smtp-Source: AGHT+IFey0kfUyFLxagH6WYQeneAlVLduFYs1cyOv+swLVtBUWQ2bTPbM+NQhOdNSq4TWZKivO7V+g==
X-Received: by 2002:a17:907:3f87:b0:a8d:2624:1a85 with SMTP id a640c23a62f3a-a8d26242590mr191552266b.12.1725889908199;
        Mon, 09 Sep 2024 06:51:48 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf3ad6sm345344566b.148.2024.09.09.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:51:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Sep 2024 15:51:18 +0200
Subject: [PATCH 07/17] regulator: hi6421v600: Constify static data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-regulator-const-v1-7-8934704a5787@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2313;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=aQxdvJysaJsMuCiXGmuPsUG5zXaAXydDbTeDR80ECyI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3v1eEV9BEYMcFSBw7lfXCzYrANegqqdP0KgLr
 wLORiBbAs+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt79XgAKCRDBN2bmhouD
 1/NGEACM/+upk2qItNXTCceOePEuc0yrqvApHPovnARhqgTaI4wjCEJjM3WbPMEs2it8jbbZY3R
 GWgKaMlU0NZCMQLdzbK6xCPCY0HAUlP5hXV7Z67Ga6wVt96WZRE3i3UvH5aLubbrFfPdsAdZWxc
 9A4DfZDmLK+ex/r4s9ef8DAk2U49qbgi17CR/BLEP0SVqJqNLTiyiLRGcPq24oKifYOQFnpxhAS
 KtLzPTPMLJFV5UQhgfwbPRBI28xbaJAlPyzqxW98B5cTUSz6Aln73tTlcSF620UGIUyFoKwRury
 BOep0BgcFjCQdaJJwn+Dq8kp4Eazcf9knQFU9TPu2T7Kwz9aRVGTXA2myWRdgBlJzhjcQWK+mOp
 j+9qAJ5Kbl+Y1Oy8grzj5aSPTbuo5b1Z79AqfRmD3QFOucMRzqU/OcOtIfVHUUQghwLE+j/asq9
 Few4VKtyywvJ0AcvBTNWRK3PrJvu4yNZqkIzoqNSeMV6WYl5ZPKLEu9A+O+R1cILiAE10eaE/Jc
 inkY3yW1Ccyj1xQxAf+DLVEKSbkpTOSmdlaos8Eh6zLj+JZjsB8Z7LNUgzCvaDqtwC8hRw3H7z5
 QLC2PSX21usUhZ+r+2B9ey/R10vItMc/Uwhxzhhkrb0vhzGWcObfrkEyjxtbYij4VEE+YX6NFud
 nxDwTMTP+ayKivA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Driver does not modify static data with regulator description (struct
hi6421_spmi_reg_info), so make it const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/regulator/hi6421v600-regulator.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index 4e10daa1e689..e5f6fbfc9016 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -118,7 +118,7 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 
 static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 {
-	struct hi6421_spmi_reg_info *sreg;
+	const struct hi6421_spmi_reg_info *sreg;
 	unsigned int reg_val;
 
 	sreg = container_of(rdev->desc, struct hi6421_spmi_reg_info, desc);
@@ -133,7 +133,7 @@ static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 					  unsigned int mode)
 {
-	struct hi6421_spmi_reg_info *sreg;
+	const struct hi6421_spmi_reg_info *sreg;
 	unsigned int val;
 
 	sreg = container_of(rdev->desc, struct hi6421_spmi_reg_info, desc);
@@ -160,7 +160,7 @@ hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
 				       int input_uV, int output_uV,
 				       int load_uA)
 {
-	struct hi6421_spmi_reg_info *sreg;
+	const struct hi6421_spmi_reg_info *sreg;
 
 	sreg = container_of(rdev->desc, struct hi6421_spmi_reg_info, desc);
 
@@ -195,7 +195,7 @@ enum hi6421_spmi_regulator_id {
 	hi6421v600_ldo34,
 };
 
-static struct hi6421_spmi_reg_info regulator_info[] = {
+static const struct hi6421_spmi_reg_info regulator_info[] = {
 	HI6421V600_LDO(ldo3, range_1v5_to_2v0,
 		       0x16, 0x01, 0x51,
 		       20000, 120,
@@ -235,7 +235,7 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 	struct device *pmic_dev = pdev->dev.parent;
 	struct regulator_config config = { };
 	struct hi6421_spmi_reg_priv *priv;
-	struct hi6421_spmi_reg_info *info;
+	const struct hi6421_spmi_reg_info *info;
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
 	struct regulator_dev *rdev;

-- 
2.43.0


