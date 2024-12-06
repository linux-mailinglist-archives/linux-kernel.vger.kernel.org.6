Return-Path: <linux-kernel+bounces-435313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441B9E7600
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD261883AB9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4338E1F4E47;
	Fri,  6 Dec 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="US3SiTNt"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E31F37BD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733502667; cv=none; b=Byx0JhG0byKIvi4GM38X6Ort+dqm9V/NHXbcZKkdQkZmV6ACZVmsmvbuM+yXdR/gf/QsCuYQ2ngB+AdJj5TS+aCC7QvltFg3XqCkX1a/3jDfTlBYS8J38B/M77S71bsMLbdb4um/1ruWhg1roSaaguzZRypGBNqHaysFEK2xya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733502667; c=relaxed/simple;
	bh=fD1l+jNkgnfWuXI1bHIvbywED4CP+GtggJNFPuFqDcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qblO0FySQ7kWadXMEn087+ThN/zNdO6Bnju5Vu4W2EFKsWd4GL9sRbh+4WYFhKUXBIA/9QqHRAK7Xk34eeoLOvwnBrwfn5XbtcBDFyfIDn15kGT6bazR5gpMMA93U/VI1+JUijuNqoSwmJOChsa1tZXx2gdc3v/ldaqBVNOv41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=US3SiTNt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e274f149fso2617284e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733502663; x=1734107463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H11rnIjZ/6A+y0BhElAhFFU5gZO2NZydl8Xc9FZjLpY=;
        b=US3SiTNtbX3OZZXbKxTpAR6pVq2vY3Y3f/v2VOzNiuH21jEJ8ZvzyfJfjZr5WpWpr2
         wvzur5rqAqHoF/DXrbjVnI+xIAxWgahYRLsc3XiOkqlZcapSlq5jxsm0uJN/9RIT4w3I
         mCq6FqtJ49BbNjMt6gZA3rSRgc+dky0WwS62FX1hIVifGSUd0pXUnmvtEWDH+cY4Sbjl
         Exxih7Sx9k1FBKEwU8W/5/ikVZ3tcSlTeXA7mhJhurnffbF5Er9ssiNzVEhAzDOY02KQ
         9PMpuRpH7r3veh0YKZpYN+ZQtfkbIETaDYe9LSapc54yyjtV6wRx84DktfT/nzfzV4++
         z6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733502663; x=1734107463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H11rnIjZ/6A+y0BhElAhFFU5gZO2NZydl8Xc9FZjLpY=;
        b=ssYOl1wC8TBN0Qw5uH15tNAcioYnmgYGeBcHFnXHEjVqR3qg4UNl/LG0zxlMABQplp
         9b2RQofFxlTQw/We6/MspzdQLdSX9Q+aNjqftDT3vKuaPaI1T/DvF96Phm2lzyZzBCEz
         7n2E7/zjXACVNry3xF3mu+CLwwP7QkJqnbjjXU4tMT+VTRp0mRbk0Rl5RJWXYNucYwWz
         GIMKHXIjl3FndAwOJmAqX6ZT0mA2W++JsZqobKlDQPc/VmSCshB3Mns0DWI7tmIzjcs9
         huHPK+ZOyeLzCtBDHlrspFfYwS8nhXbw36LogIf7Q9FnAYVgzQCoofcl9bDgIySbNDA9
         vJYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA4vSa+fw+Vf2iq0jaA2Deo4rrUpOAdGamWOVYJQNOzITVZTgt9X560fhXx8+6JKH77VpA4O5cG7AjjAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK8wLvO/ZJcnHEuHozuGNCUc3oV6qEnu8BAZXypRHNI1sXZtN7
	lYJF64h5X/zGdnymHZMaFipSBgA2gy4OG2ooUT1LWfO7rGODvlQCUpCPUCEpb3Y=
X-Gm-Gg: ASbGnctu/dnb10q01gAYjNHnRkukRO6d6R/s5N11rp8lrZqx/0mFJHd2/FSGo4nNqSv
	BN2X2FC5LL/J1bZ63mt4mJo2AEFfcVZGRCdIY5V4UqYrQX8kP6NTR100VrrmkAfmAfYrbs4Bgl+
	6stZi1iEziI+8QYTVHyREFJbNUJRy/ypfk1CRoY2lsqwlzRdPCyUK9rIMOnNW90Tfen9VB+RKFA
	hrFIA6D9HVrA3ZbtVcxjFKbCPbp0cIrY4YVwgLbT3cNuMS0yDy8JT/96yYxsrsN+H+OrTy5Bhob
	b9zRCBG+MhJptLAdnMbUSvNBy6hkJTTa1g==
X-Google-Smtp-Source: AGHT+IExkzoUN1HflnT9opUQAW9MqmmpGeThLHiF2BwdjV6cAu9grD1ih7bZFlXxIc4t4D7GinRxbw==
X-Received: by 2002:a05:6512:ad1:b0:539:da76:c77e with SMTP id 2adb3069b0e04-53e2c2ac7fcmr2130253e87.5.1733502663241;
        Fri, 06 Dec 2024 08:31:03 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e8af8sm257710266b.191.2024.12.06.08.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:31:02 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 06 Dec 2024 16:31:03 +0000
Subject: [PATCH v4 3/7] phy: exynos5-usbdrd: convert to dev_err_probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241206-gs101-phy-lanes-orientation-phy-v4-3-f5961268b149@linaro.org>
References: <20241206-gs101-phy-lanes-orientation-phy-v4-0-f5961268b149@linaro.org>
In-Reply-To: <20241206-gs101-phy-lanes-orientation-phy-v4-0-f5961268b149@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

dev_err_probe() exists to simplify code.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* collect tags
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index c421b495eb0f..ceae4b47cece 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1725,10 +1725,9 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 
 	reg_pmu = syscon_regmap_lookup_by_phandle(dev->of_node,
 						   "samsung,pmu-syscon");
-	if (IS_ERR(reg_pmu)) {
-		dev_err(dev, "Failed to lookup PMU regmap\n");
-		return PTR_ERR(reg_pmu);
-	}
+	if (IS_ERR(reg_pmu))
+		return dev_err_probe(dev, PTR_ERR(reg_pmu),
+				     "Failed to lookup PMU regmap\n");
 
 	/*
 	 * Exynos5420 SoC has multiple channels for USB 3.0 PHY, with
@@ -1759,10 +1758,9 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 	for (i = 0; i < EXYNOS5_DRDPHYS_NUM; i++) {
 		struct phy *phy = devm_phy_create(dev, NULL, drv_data->phy_ops);
 
-		if (IS_ERR(phy)) {
-			dev_err(dev, "Failed to create usbdrd_phy phy\n");
-			return PTR_ERR(phy);
-		}
+		if (IS_ERR(phy))
+			return dev_err_probe(dev, PTR_ERR(phy),
+					     "Failed to create usbdrd_phy phy\n");
 
 		phy_drd->phys[i].phy = phy;
 		phy_drd->phys[i].index = i;
@@ -1786,10 +1784,9 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 
 	phy_provider = devm_of_phy_provider_register(dev,
 						     exynos5_usbdrd_phy_xlate);
-	if (IS_ERR(phy_provider)) {
-		dev_err(phy_drd->dev, "Failed to register phy provider\n");
-		return PTR_ERR(phy_provider);
-	}
+	if (IS_ERR(phy_provider))
+		return dev_err_probe(phy_drd->dev, PTR_ERR(phy_provider),
+				     "Failed to register phy provider\n");
 
 	return 0;
 }

-- 
2.47.0.338.g60cca15819-goog


