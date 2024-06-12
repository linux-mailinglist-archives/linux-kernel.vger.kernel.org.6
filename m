Return-Path: <linux-kernel+bounces-211889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EC90585F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C589C1F21CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73031836C1;
	Wed, 12 Jun 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ye6tf3i0"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C718309B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208958; cv=none; b=BKkf41wQPQ/+HpgrLv4qNB9567AhQWFdzMf8NDV5qc4GV/2G/2PXRhyt5cNqoW/5PlABfsXH0QEM1Z90H1TNoaPbYP1yDuyT5P05wnFV5pm2wxN6PoEA74M6Axq3crkalgepe9nBAsAl63bLNX/Tq6G021g+gdwaLCxiGEMQezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208958; c=relaxed/simple;
	bh=Qvm23q2GYZ89u4m4lnW1gC9ZSpuZfm4HZTc7sb1PqHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nGB3XY4VmcSzFkg2WoSH60J1ZNb4S9dM/aBXBnEyeO6DtMMCPEzwFcdrTmKKWXb/+IRdKXlB1iBj9PiZ/9G5LVGrY0O0vUayEJy0MBRScCb2CfpTNMwOIKAnUldEwkycdcEOwh9OHqjw7em3ZYvnDrY8zU6QAPW95xY8iVsqCQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ye6tf3i0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so6689930a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208955; x=1718813755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=61skfWvt9BRl/9QYc63/KGerHmR4wxlY7IwK9GFNUXg=;
        b=ye6tf3i0Lo8Y65NBpGxpfGdpl+/n0N6LUlI74jXew6TAGqTJHhlMttL8mGWvKe2NJv
         XUhwCYLMZFz/gO+6nnu6a4DyPmjUS0JLVxMpx+g0bwqJ/3DwEAPjUmHvMDLCibiQ6xiW
         cgouMi0IfXkGf5iexc9c5h7RZ9cJ9zYhHI2awX1i0ieIFCz/pBe492/LRatU2HxlM9mB
         RJPMn6e7MzU/Ym9+T7yJFulGOs7G3sVbAU9otakXs/KPIoI8JQyY2lxi1EErth6MQ9sh
         sVVKutI06Lk+CN87LruveUC35lL3ZwvbXCSVTzMIhquPKtnkOil/EAboKdGtkZDZO772
         im3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208955; x=1718813755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=61skfWvt9BRl/9QYc63/KGerHmR4wxlY7IwK9GFNUXg=;
        b=E3bA4FJyjxMo/VIw7Y5Dloo0Pdh5ksYvM/Oa9VmfiujpXrtuSlaGXQQNzLybudMv5g
         RletEsUik1mAuaPPlY/BI8AiEPXpyaHy8+l8uadJzUqqkJA8qpzn9O5IzAZcEFNTSksO
         Nu3/fnqizeJ1nOmL9nJ/w80jM8ykwvGs3GBHDTqtPZtUEc/L/yoe9rsWcm6KxQ2g9Ok9
         adI5o6PR3n7UdhIP4PjndqGzEuDJ3zYcTRegPG76iGaWAXcCIA2LdzjblczFCPwuPgxH
         +32sTA+fZ71sZ+AlZYa7n8t9JOh4hNR+eOgMZ2rO7IsGCiMS64r5VzgibJposday4Cbu
         92jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC88HH4yyWuMj6KSVb5Uvv19kHlxXePLhEQqW9CPpUsBuFWz7SensBi7hqgPueqi0WDsKlSpsbOxwD92dFnDgMenziNRA4KX35zo0J
X-Gm-Message-State: AOJu0Yypxd8EhTuhxY1Rl1NusschaJcRSBeLmdgx2EfIOnzfuBKxt0nm
	rugtSFHqNl0YbAE8hEn0FcwIWlEmU2MikJ8TP9Pw3qUIBhH46JVuI9Jc6K7CpPG+xD3nfL0pSRq
	E
X-Google-Smtp-Source: AGHT+IFrFEyR1KwAKRzvE5BUx0XlzQZ7BeNBxLJzklNFCPiFqELpkjXvSl/mHaW5rpddnl1lvh2tFw==
X-Received: by 2002:a17:906:2c45:b0:a6f:1893:f549 with SMTP id a640c23a62f3a-a6f47f7ff70mr125342966b.28.1718208955435;
        Wed, 12 Jun 2024 09:15:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:15:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:23 +0200
Subject: [PATCH 10/23] ASoC: codecs: wcd934x: Handle nicer probe deferral
 and simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-10-0d15885b2a06@linaro.org>
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Qvm23q2GYZ89u4m4lnW1gC9ZSpuZfm4HZTc7sb1PqHc=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGZpyZ+iUkory59nFZNw3S4z4Zfqy+Cwzs2u33Jv5ftaDeLtk
 4kCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJmacmfAAoJEME3ZuaGi4PXJoQP/RIF
 O+QjkDONoNlP35hSnfUWOqDNPKOOqqeXELTnnNWBOo9hK+x2Q9kxQYTbKIfVwhVnyACJWoMBGGr
 0oGDECFTwTqAqxWtO/zctF3fzRFR9etq/+JadVGW7SLgtcX0aAX96Clr16BnOibMFeUfrNbBh/3
 /ySkxMl+TewZCjxNlGqCiYRisNwaP/HRmu1cMaQcE37iditJkrfP69L/KlJEhG9oq+dhCk4x86E
 kf5Lhd+LG6ZLo+p3qiZetcvlCDP8zSddbBpAINJDroxSA1t5br7yySir/Z0ZQ8SR/VooNpYahGv
 /M+J3mCkpHSi28/3OCC9/hrkWKM0j+F+rQ+DPfYqgbCy9iuMQrHhbZQ4pFQ6OzcjezIRGlU7DbX
 p9/XllFtOaBce/vwjnMyWC4lOeG020XioQTa29S/VWNEIlBj/eVn2lL9IrbwW4HpNMHL6zI8rQS
 Le+WMuhWh5oK0xR1vBhv1Y3okzrbFtJ4dBvWFq8xXIleHIiLlYWT62Qp8oUZL5DjG4yWFUr78j8
 vvFIgpo0ydjM0Q/aFlr95Bxw7OHlLyzmB5KO5OPcuP3C/32dirueNHMHp7LSJmWsGGrbZSnDRGw
 IYni5KrQfaP4MDtAOYT+8OksVXrF/CuuvNmNC7i6yH3chQLVd34cB9fkSxO9USJ8fViC0CnEHDo
 gYf56
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

wcd934x_codec_parse_data() function is called only from probe(), so
printing errors on resource acquisition is discouraged, because it can
pollute dmesg in case of probe deferral.  The actual deferral is here
unlikely, but still the code is a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 2a5fb4370ba3..d1bbc963856b 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5856,17 +5856,13 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 	struct device_node *ifc_dev_np;
 
 	ifc_dev_np = of_parse_phandle(dev->of_node, "slim-ifc-dev", 0);
-	if (!ifc_dev_np) {
-		dev_err(dev, "No Interface device found\n");
-		return -EINVAL;
-	}
+	if (!ifc_dev_np)
+		return dev_err_probe(dev, -EINVAL, "No Interface device found\n");
 
 	wcd->sidev = of_slim_get_device(wcd->sdev->ctrl, ifc_dev_np);
 	of_node_put(ifc_dev_np);
-	if (!wcd->sidev) {
-		dev_err(dev, "Unable to get SLIM Interface device\n");
-		return -EINVAL;
-	}
+	if (!wcd->sidev)
+		return dev_err_probe(dev, -EINVAL, "Unable to get SLIM Interface device\n");
 
 	slim_get_logical_addr(wcd->sidev);
 	wcd->if_regmap = regmap_init_slimbus(wcd->sidev,
@@ -5912,10 +5908,8 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 	mutex_init(&wcd->micb_lock);
 
 	ret = wcd934x_codec_parse_data(wcd);
-	if (ret) {
-		dev_err(wcd->dev, "Failed to get SLIM IRQ\n");
+	if (ret)
 		return ret;
-	}
 
 	/* set default rate 9P6MHz */
 	regmap_update_bits(wcd->regmap, WCD934X_CODEC_RPM_CLK_MCLK_CFG,

-- 
2.43.0


