Return-Path: <linux-kernel+bounces-211883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC1C9058AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD04EB21883
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E580C181D03;
	Wed, 12 Jun 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kcLjxOf1"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0617FAD4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208952; cv=none; b=dAento5Zs+30wXwRCgNNJrQ6gcjsKlv9uz6oUbUSy1GPPxuPb51dY93s8ylUczaAbOLGCC4ldplXL4iv/Ypi80pWICh6/rDjMVVpN+hAXHQ4ffU/umx0DXgQo3mC6TYWI/ES4p6BdkeH+PCSq7iWTKurSdf+8TpVlqLMGkN1UEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208952; c=relaxed/simple;
	bh=+6N7gMq4jHzelVlw8umcPCRfVgXICvRLvIVfctyIHUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEEaDf1WqWvC9t8lymQxWpdmz5Hs6f+SfuPwfdbTfzmVtpiWY6amNQ3O7AYCdKqwQj6SvGPMqZZo1rDiZStylbkER4BdUZwRxIFx6oVmhSbIuXeRRgkuXLqw+X9fKv2vSPiFXFcbxS9AMvxpTvqnuaS9fJnPxNmqfpSVSt3XF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kcLjxOf1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a63359aaacaso10248466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208947; x=1718813747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbUB+HoAqq7FbsjH4xIB6iwTWnEv+liGNHJk9xgO0cg=;
        b=kcLjxOf1LBj6xbwspKlmAWOvrQY1qIzgdjDcj78mKV/7P3QEF4k3D5+jkAa87nH3lt
         GPG7BpNbrakTtxspIRz9iB5xDxWb3MtyF0Wh8efu9x4H5W2MoXq032uDG8iJIy6JU35P
         yBSeOtxp7JEbBUh1OVFr89y8otuE4pSmxs7R8Zp33xXzivbvXjAhwXzvhPiRSm9WajYg
         7FCbC57GDlNdJffVBAUrDibTMXP+vfYJWeiWoV/yZRy/BfjdYrBUpqBtVozk0XUEheaC
         AkBSY/yJ1+xJUZsu1Cj9CSucmWKIwHT+XaHgdjayH59CCXH3ofD5MiWvVFqzR81X9XMB
         A/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208947; x=1718813747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbUB+HoAqq7FbsjH4xIB6iwTWnEv+liGNHJk9xgO0cg=;
        b=HP4mFneJfiF40pja602JbndPCTnZta9bbNy8AlQBtgwaQI08W8YKi/FGWvkYqejxCI
         C+UFsrfeKPlVCO0o+0XIPITaa6CeLQHpxByFev3QMlPKw/lyZUkIeFlYy4VX68sYnURI
         mVwYRxHBkg29M7+Y+ZZEVlAIe1QdwDSeI7tqm0vwML1ItLDwnwE3AOjTBrJb+8KEHKki
         u0hA9SHx6NhMpivsjY8vr4F6nV8itTgZi6/1QD0uAHapJ1E+Z2Qx7fJa1KTDRz3dJXpw
         q5CHg6IgQQMGhkcwLNGOUEoez0Hw6B4hhdv93FX1sV+8TdrOlFUdKvWLpiqpWkoWxaFi
         7JHA==
X-Forwarded-Encrypted: i=1; AJvYcCXK2AzpFlC+qPRD8Gkc3PcfVgZiSkYi7DNYNL3TFnsXgrwJI0sYiaauuddgwuH3Wt0UMqoqhITp0Eho8TBxBgslQ6gUysvCYwIlxsLy
X-Gm-Message-State: AOJu0YxfYvYCkvV6syz3QmeU026kk4ByNwORT+fRT2aJ6eIoyt9meQBz
	AyGN76y3szfDpKp5a9RyXD8mXlNmElq0kdYmJEpBVuKFu4VhGTWs0wlSDk4CmJ4=
X-Google-Smtp-Source: AGHT+IG0yCZZBR115YOLcbqPgpzpGDnmFUZQ7t8V3T3cBvW0NmL6cdA4+NAFWt7VmyHk43Bf5ICYxA==
X-Received: by 2002:a17:907:38c:b0:a6f:15f5:261e with SMTP id a640c23a62f3a-a6f47c9b5fbmr151234666b.7.1718208947613;
        Wed, 12 Jun 2024 09:15:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:15:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:17 +0200
Subject: [PATCH 04/23] ASoC: codecs: wcd9335: Handle nicer probe deferral
 and simplify with dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-4-0d15885b2a06@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+6N7gMq4jHzelVlw8umcPCRfVgXICvRLvIVfctyIHUQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacma7eeNDLLN0oFnHMu4KHxXU88PgA6aoK/iC
 kzfL/NTn/qJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJmgAKCRDBN2bmhouD
 12oDEACbOfb0Sh+eYacsC3jNLnc/sjhcEJmmabc7LSV2WeyBsOpmWU2H+R1hzWoehPhT/C56MFZ
 E6eECee+tk5B07aSBZ3m7AmmjXcpplP7fmG25JGiRKnSZAAscVYTDv9Nn6r3b6WBkmu1y3fK446
 FZEcVG/vIThP6TFX4KnxO/zq4iM7AtzCEqWqPYqIWOfVvTKOG2oQRGV83sqAgsg7PT7Rlq06R/q
 H5UztTT74rl09nhTYlgdXvPrcLpyUeqog56haAg6sRXSffwo9YvkusGOS1tn8gHvQLD9limLpk9
 5VR/iN9CwtSDf5jItZUPYSAEmaD1qiUZNPXehwHZMoLRLbSB8wJCXU2AZJ71TkU/SgyeGGREIKY
 f/cfNQWiPJWRjIs1gIjCi+BgoX5PUn7vsvnxrf5rmN0PdvVWimILgdX2Q2/BO9CsC0wHU7LZkI4
 uvP/eIv1wytwf0EczGdvUXWoPUZb4fkH+GYLtJlb67p4VNeAP0APnLDAvaL1pMH34nLr9dXppOU
 DSnh/hZDOVU8J5pblyOyJeuOP6dMS0ypPhLWjh52wLLr1JBKPD5p+B4tQsAArE6vvUCdFwAlrdv
 FFo+J0hi8cwmycN0F5sp8ATkRQVH84qpupHF8PxAJbm8tzuUVN20GFd/ibngZBqQ42zxLyZj1Ag
 p83UAfr91YoTpyw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

wcd9335_parse_dt() function is called only from probe(), so printing
errors on resource acquisition is discouraged, because it can pollute
dmesg.  Use dev_err_probe() to fix this and also make the code a bit
simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd9335.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index c5ac2d46e556..334c5241617f 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -5031,22 +5031,16 @@ static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
 	int ret;
 
 	wcd->reset_gpio = of_get_named_gpio(np,	"reset-gpios", 0);
-	if (wcd->reset_gpio < 0) {
-		dev_err(dev, "Reset GPIO missing from DT\n");
-		return wcd->reset_gpio;
-	}
+	if (wcd->reset_gpio < 0)
+		return dev_err_probe(dev, wcd->reset_gpio, "Reset GPIO missing from DT\n");
 
 	wcd->mclk = devm_clk_get(dev, "mclk");
-	if (IS_ERR(wcd->mclk)) {
-		dev_err(dev, "mclk not found\n");
-		return PTR_ERR(wcd->mclk);
-	}
+	if (IS_ERR(wcd->mclk))
+		return dev_err_probe(dev, PTR_ERR(wcd->mclk), "mclk not found\n");
 
 	wcd->native_clk = devm_clk_get(dev, "slimbus");
-	if (IS_ERR(wcd->native_clk)) {
-		dev_err(dev, "slimbus clock not found\n");
-		return PTR_ERR(wcd->native_clk);
-	}
+	if (IS_ERR(wcd->native_clk))
+		return dev_err_probe(dev, PTR_ERR(wcd->native_clk), "slimbus clock not found\n");
 
 	wcd->supplies[0].supply = "vdd-buck";
 	wcd->supplies[1].supply = "vdd-buck-sido";
@@ -5055,10 +5049,8 @@ static int wcd9335_parse_dt(struct wcd9335_codec *wcd)
 	wcd->supplies[4].supply = "vdd-io";
 
 	ret = regulator_bulk_get(dev, WCD9335_MAX_SUPPLY, wcd->supplies);
-	if (ret) {
-		dev_err(dev, "Failed to get supplies: err = %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get supplies\n");
 
 	return 0;
 }
@@ -5157,10 +5149,8 @@ static int wcd9335_slim_probe(struct slim_device *slim)
 
 	wcd->dev = dev;
 	ret = wcd9335_parse_dt(wcd);
-	if (ret) {
-		dev_err(dev, "Error parsing DT: %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	ret = wcd9335_power_on_reset(wcd);
 	if (ret)

-- 
2.43.0


