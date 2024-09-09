Return-Path: <linux-kernel+bounces-321539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95163971BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB45EB22239
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF3D1BA286;
	Mon,  9 Sep 2024 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTMniVFR"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693C1BA27F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889924; cv=none; b=fUk9P83oTS17pCgW81B1uMysvya5FxoaguhmcxBKuiZjUwc1HatSZFgjKXGLUzlOXp+GXEHPjjgtDUH4H6LApwSayHYCyzcwyKA7Xcm3b8VgQ4E7xajrVxW8TvtziBMro5OhHzrySmwPdHuahetKp/DgB6M9yrJOPoioWsx5UpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889924; c=relaxed/simple;
	bh=QfpMH8xpX7M5v1cNMdTuKAFwaOO0ijMMMrIuqJNJ7Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JQoUCd9Ik9vmnJdIY/EWFBPzjsB+aYHQLfnG1i8xZmWCJ02+MBEJTG67QILdKGX3PRdeFRzwIKLAPIkN5d8VypOnSi1OqODxZc0cv073IIimKINdqYIHRkO+s9+XNcAiQUnq4BxxQWLI2KkgmWzRAQNOezKOvvUm5ZGo00w4kzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TTMniVFR; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a92e8c840so38153466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725889921; x=1726494721; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HEAviafQzNR7Z9t5hpM5VZEKV85C26CtMxeL00PENiQ=;
        b=TTMniVFRkH7FAW64HG0nVKhi7SVcFNDUXg/BNNoI1aifgw0L6hVZrZSjOeCqXl61+b
         ES93oSt+YKovm1dUCxenX1Ed4egEPg7QwncUpVRDh27M1HDGQBp9MeNp/ihpUahajpQV
         5wiyiswV8+/mzom0u6rJe1rgK9l9Ps9X6qAtZ3CHvUPZqccX3ejAuvga+yzic24Z0mf4
         EneCVg9LXZNS2wGiw3Tx6UZ5QBUwnWInbd0O7kSTHMHMmkrC3oDXM6PgwhIhjC0nQwSN
         QTwXu6a6+vFof0P2Yr4fn5GRDD7bMqfyeGdfJGwj4amB06T4cjRzvs2EjTT9Sa4CIX9W
         SJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889921; x=1726494721;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HEAviafQzNR7Z9t5hpM5VZEKV85C26CtMxeL00PENiQ=;
        b=npiFZZWhD68KDE+/0xyM1kYuU7FxfvPmfcCu0t2+iVPU21vtVy2r+kStlrBr0Pfrgj
         RK8nDPu5HFq+4g8GeF1s1GtWXEYI0tP1FeVMGbwI9TaviSpVvMDXvyQoZi/UHhJq9WNN
         hVP5ceaqa9Xno5DJB0AgWnVn+Jl15QqenRwYr/3JJiyfECdmnToHhwmseXqW+MS9/Wmd
         9PolsUf2NelYDioRS7N09lKMhgszKXMnyZHvJ5geAK8d2e+Uh6LmXgzwdY8inCtx1+3J
         dnmjlOqhWewubzYSYstGNScIDoKZfdvWcBOEEK3pAqjKk0F7tGmQLZDAMzDzsB57U3HH
         fkaQ==
X-Gm-Message-State: AOJu0YyKAAufVuv8cTEIveR1/X8stFLhcT8wytMolAVffnIPIEF4Rlky
	UXJWDx4pVNjQpqyZXvO3bYnX8zs9EfVNSytZxX/owM1WhEtZiqidOxxGPXvUXsk=
X-Google-Smtp-Source: AGHT+IGUrqfpjeRf1rMAe7mjAkRWErGkoP/w4iRCRemp+gCnfBdE5Yx7pYFApwpFKe1jn6l3HlkbcA==
X-Received: by 2002:a17:907:3d8b:b0:a80:a193:a509 with SMTP id a640c23a62f3a-a8a885bdde7mr356155466b.2.1725889921408;
        Mon, 09 Sep 2024 06:52:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cf3ad6sm345344566b.148.2024.09.09.06.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:52:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Sep 2024 15:51:27 +0200
Subject: [PATCH 16/17] regulator: hi6421v530: Use container_of and constify
 static data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-regulator-const-v1-16-8934704a5787@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=QfpMH8xpX7M5v1cNMdTuKAFwaOO0ijMMMrIuqJNJ7Fc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm3v1mbrrIu6Do6kppOFM21iGEOSQnx+wr6TRGX
 MTTtX77+QKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZt79ZgAKCRDBN2bmhouD
 17PsD/49SlTRgOuT9opobBE999Eo0XMLtC18q26ggdv3vW/9xY53TZacc1sfclw2LWcHUPAzpMk
 v2yz16QkZK0z0MiqCpwIM3z7/b4Idk/YJQxNscRM645bKHaNxlYeBVQgXRpX/rgPYKwne7RRCzS
 2G8wCmaSA7KTQ4OK0I/VX1B1w1PVLAdlTp1DajYRjpFMQyCbeGMx1dw2pHFCVEZnGklOtB+JXZw
 F24rxvpdFzaZTvbSrR8OA3Qr0AbdGSNsvBjJxWxMKNmeXehb9q4X7PeP6NMEWyZuZahJhIwjPuK
 4GjDbix7naxDG3LRLFvXQVBTd3tTtlrmarGiqUrWr48TKoOIiXQ9+3DhtiZbU0jen/scVfhLIXN
 JLmEHol/WBUI0ziNAnJcMtWHmUDZeQZgehGHviTxSEQvRoCRJi8cR8jVrPFXBOeWXUp5+cELP7+
 e9OPitc1nA9XIsdv9Is1SNjUSSH8fQGeNLDqzfSNPLkGqGDi8HE/QlkfwsNJ27ITARLbditccpc
 3OaBBhaAb6Ejc/HnYwA1EcFNkR+iwRN8RBLJqsGC7GVr9tfTtG1CZDKj8B9TfcLpEpCBvVTcmUd
 wa85RJKRg3BgCuNk3/bEnS44Ywg8avfJ5Q66Hu84715P6hvPDUVsjB8PJSrlaN477J5Bxa2URNo
 S2rXdeUiFplSo8w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Switch from rdev_get_drvdata() to container_of(), so the static
'struct hi6421v530_regulator_info' holding 'struct regulator_desc' can
be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

[RFT]: Not tested, only built.
---
 drivers/regulator/hi6421v530-regulator.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/hi6421v530-regulator.c b/drivers/regulator/hi6421v530-regulator.c
index a9c6c077f50d..b3ebd1624814 100644
--- a/drivers/regulator/hi6421v530-regulator.c
+++ b/drivers/regulator/hi6421v530-regulator.c
@@ -91,7 +91,7 @@ static const struct regulator_ops hi6421v530_ldo_ops;
 
 /* HI6421V530 regulator information */
 
-static struct hi6421v530_regulator_info hi6421v530_regulator_info[] = {
+static const struct hi6421v530_regulator_info hi6421v530_regulator_info[] = {
 	HI6421V530_LDO(LDO3, ldo_3_voltages, 0x061, 0xf, 0x060, 0x2,
 		   20000, 0x6),
 	HI6421V530_LDO(LDO9, ldo_9_11_voltages, 0x06b, 0x7, 0x06a, 0x2,
@@ -107,10 +107,10 @@ static struct hi6421v530_regulator_info hi6421v530_regulator_info[] = {
 static unsigned int hi6421v530_regulator_ldo_get_mode(
 					struct regulator_dev *rdev)
 {
-	struct hi6421v530_regulator_info *info;
+	const struct hi6421v530_regulator_info *info;
 	unsigned int reg_val;
 
-	info = rdev_get_drvdata(rdev);
+	info = container_of(rdev->desc, struct hi6421v530_regulator_info, rdesc);
 	regmap_read(rdev->regmap, rdev->desc->enable_reg, &reg_val);
 
 	if (reg_val & (info->mode_mask))
@@ -122,10 +122,10 @@ static unsigned int hi6421v530_regulator_ldo_get_mode(
 static int hi6421v530_regulator_ldo_set_mode(struct regulator_dev *rdev,
 						unsigned int mode)
 {
-	struct hi6421v530_regulator_info *info;
+	const struct hi6421v530_regulator_info *info;
 	unsigned int new_mode;
 
-	info = rdev_get_drvdata(rdev);
+	info = container_of(rdev->desc, struct hi6421v530_regulator_info, rdesc);
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
 		new_mode = 0;
@@ -172,7 +172,6 @@ static int hi6421v530_regulator_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(hi6421v530_regulator_info); i++) {
 		config.dev = pdev->dev.parent;
 		config.regmap = pmic->regmap;
-		config.driver_data = &hi6421v530_regulator_info[i];
 
 		rdev = devm_regulator_register(&pdev->dev,
 				&hi6421v530_regulator_info[i].rdesc,

-- 
2.43.0


