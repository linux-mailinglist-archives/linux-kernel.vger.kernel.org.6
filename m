Return-Path: <linux-kernel+bounces-245838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0AE92BA47
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1E01C22FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F24161936;
	Tue,  9 Jul 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZkzMVutB"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16157166305
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530006; cv=none; b=ShxrAAtq6a8BfCAIk6DP+CkphxP8Ht/8lXo4P3tySnjAjVpuRL1qRnMWV+4CXf5WlQTeG25oli/5yyb8DJuqG5xkt6Iv/IpNbAMnTPHSj0L2c2iptJT8LlONaNQqNc9DiK2l197vHqDwRPZO/WxoX1aNXyZdKapYWieWcRAlJdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530006; c=relaxed/simple;
	bh=uAMTrcC0mVom85qx7RgLzbVpmGNoowEa4jhQ0iR1o5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LEmdDAkmPxuPaOfkhvTxnjF0xBuktIBfM2udM5mZZ09JbVPGmWes+wKZ/QGW4V0Dj41I65fTNsFuC3nRxI3ZEyaLEchzftMcC7B8UF76gD7176RiDqrxzOlWtp23G4WmxyYESSxfk6bAd2/u95lznI+92kujHAzYFtaSidcwaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZkzMVutB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77c4309fc8so552494266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720530003; x=1721134803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybUy1HdKJy0SC3jBHxTxEhNlXRYkfN8Lxd1LqP4XqS8=;
        b=ZkzMVutBjjYqq5Fe1r6tIXaVmNDF/1uirhsYHQNYPdl4C0zeBl2brP7qVphXOKz2UZ
         MK36gOmsusZ3qyyyfm7nvPSZZa7GBFXMjY+kuxssOc0BY3D1zdrEY3Xj9jUYGa5rSSWO
         hgHNYKA2Slx9rDmhUN4LShWghMy20+J7UTKGVVb9d+EPXN5Lv1M/wLIV/mhlq2IniYQK
         aYbHJRsW7ZlCwirBjhbwxcX4KYNL3az0GVSXgl4u1n2VcsgO3hCosZ6P662F/P/RKo9g
         dktiqbB9tY+inbO/THRndSJdjIxjJgN6juKMZMSvjpHykScfbH1ynDtnMeNPtwsk/RUR
         7rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720530003; x=1721134803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybUy1HdKJy0SC3jBHxTxEhNlXRYkfN8Lxd1LqP4XqS8=;
        b=m9ptx1QmwQAgJtz3NOh5PMHcngFoKOkAbJyRrXbGF135oBjJasbPQzFRulskQCvNpR
         gQ9xSyfi3xFzzp8fafJl1EixYvvTwPcBrZVK+VgPoILs8ltD67O3N08wXlM6Bgb+z+tb
         Utqyiz2h7FMNvEiNpw3Egdq7T3TULCpadM0sCHt6oQxXP5kZSrNpyypBS3A7qPM0I3DN
         KGkPvdna1GljLOiBzvMPbkG9eT48scu7vaK8TTaVduwCC+ej4uV3URjVoH78uR8vKfIk
         fSHPaO/GdbtqkD3xdZ9PmpBC+zqH+XHVc1AEwk49ujK9BManu/dWpBpuUkzchC26gipP
         LKuw==
X-Forwarded-Encrypted: i=1; AJvYcCVXYpm3FVd0TOQnXJ+IiWW0D4Y3cXqgvc2drk680R9UrWjCjKKst30VlwpvcQ1dX+QnR5NWhJLGmxuEG+YxeRNfPlwRSuHecU9knT20
X-Gm-Message-State: AOJu0Yy8zp9P0QbqgR+OkOjDdc98h/b/FYezWWwBan7TMxLXBgULKrUc
	BrCqm2K3eS9c7tZqzkPCO/kttb5jmxGOk6ZDQnCpadSblFOQ9MyQhmYDEgiM8cU=
X-Google-Smtp-Source: AGHT+IEyRyFqkTwfhXvnWJMCl1GxNNv1QnYMVp0FnPJnRyxHf5vBWrGeQmH6Alt/59F10w37lZmLdg==
X-Received: by 2002:a17:906:e246:b0:a6e:fb9b:6769 with SMTP id a640c23a62f3a-a780b89ed2dmr142387766b.75.1720530003303;
        Tue, 09 Jul 2024 06:00:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e157bsm76643166b.80.2024.07.09.06.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:00:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 09 Jul 2024 14:59:35 +0200
Subject: [PATCH 05/12] thermal/drivers/exynos: simplify with
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-thermal-probe-v1-5-241644e2b6e0@linaro.org>
References: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
In-Reply-To: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2154;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=uAMTrcC0mVom85qx7RgLzbVpmGNoowEa4jhQ0iR1o5U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmjTRAedXAsDTOKwPCKtVeeBDQKl2GzAwF+mcHe
 Zf9U59jtBCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZo00QAAKCRDBN2bmhouD
 18itD/9VymA98RLj+xi7Rq9XMA4oXDVEu1ExLXuCaztzc4IZ5DS+lAXwA60GwTRyHSg12gpxodX
 wGTxdIsXm4HQC6MocbLKhr2jRUFWF5mhHytUE4GUUvT3J4F8fc73MSKOfMa/Le2ZZtj2uvOWBK0
 nKj10iZWWvmTqZTX/bn9itKX3HfshX45Y9TLwc2XuczRzqCelbhxTpqZ9N4vI2XdNOQ13wHXq7A
 LGO2+oDYGzzp4+2ilbIJWIQI598b0kyEqWyYaPtMWlOUVBZRBhOvAG0XnSaJjR0MWXBoNsO+JjJ
 q4EeU+DKyl/CQnkVw3p8pZrunC3T3EaDD8IknOUF2ZiJyuD37ahtQQvv7clKHWzWiQcAgCGazqp
 3X7JYISIOiq8eYnguL6kSLvstAD8KPb14mlScjX/J/vq74Cxp61tA8oPJl0ZwiUzpfGxuQvBTAs
 2vQV6Zv/GDJLqwG+vPPrFjVzCId3rhmIfdJCCkHZKopeHQmi/220/XRfXg4UYRvtpado0ozAEaa
 RBywtVfSWiQMs9txTHYbqQXEz73r3/K/wVi1+mHB6IE4ImufypcbAQLpgM7aqn3HZtprwamb2vZ
 RMBUeMTZ63ZOlIdRXRwjTG0SULdlI2iKGH2LOTd6JbxVw1wcsy3SS+FrtgP6uKkfxBb1NR0EnIf
 qywB8pGu0hH/zaQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Error handling in probe() can be a bit simpler with dev_err_probe().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 1152871cc982..96cffb2c44ba 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1037,17 +1037,14 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		return ret;
 
 	data->clk = devm_clk_get(dev, "tmu_apbif");
-	if (IS_ERR(data->clk)) {
-		dev_err(dev, "Failed to get clock\n");
-		return PTR_ERR(data->clk);
-	}
+	if (IS_ERR(data->clk))
+		return dev_err_probe(dev, PTR_ERR(data->clk), "Failed to get clock\n");
 
 	data->clk_sec = devm_clk_get(dev, "tmu_triminfo_apbif");
 	if (IS_ERR(data->clk_sec)) {
-		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
-			dev_err(dev, "Failed to get triminfo clock\n");
-			return PTR_ERR(data->clk_sec);
-		}
+		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO)
+			return dev_err_probe(dev, PTR_ERR(data->clk_sec),
+					     "Failed to get triminfo clock\n");
 	} else {
 		ret = clk_prepare(data->clk_sec);
 		if (ret) {
@@ -1067,8 +1064,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	case SOC_ARCH_EXYNOS7:
 		data->sclk = devm_clk_get(dev, "tmu_sclk");
 		if (IS_ERR(data->sclk)) {
-			dev_err(dev, "Failed to get sclk\n");
-			ret = PTR_ERR(data->sclk);
+			ret = dev_err_probe(dev, PTR_ERR(data->sclk), "Failed to get sclk\n");
 			goto err_clk;
 		} else {
 			ret = clk_prepare_enable(data->sclk);
@@ -1091,9 +1087,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	data->tzd = devm_thermal_of_zone_register(dev, 0, data,
 						  &exynos_sensor_ops);
 	if (IS_ERR(data->tzd)) {
-		ret = PTR_ERR(data->tzd);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Failed to register sensor: %d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(data->tzd), "Failed to register sensor\n");
 		goto err_sclk;
 	}
 

-- 
2.43.0


