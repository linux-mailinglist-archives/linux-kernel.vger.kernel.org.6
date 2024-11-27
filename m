Return-Path: <linux-kernel+bounces-423359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247789DA64C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E08B16566B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5D31E1A08;
	Wed, 27 Nov 2024 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJ0L2mqQ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFDB1E0DED
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705098; cv=none; b=dzY+VXt7KPsazMCy2Z3hbLCM/PryMnR5i2GDhM84H0w2ovrbKP37QS9qNRC19bNss6nB3ip2utbjpDsPOOEcKSprCaf1T1IRWqUadCAtrgXYgC2Sk51Zq1h/tKgAB8mUW6yHR46Nha9Ppf8FFA3eQ/+XJvw3XQvMKwjnSBH+h0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705098; c=relaxed/simple;
	bh=56S6FPhiczc/qLI1wqqGxrJUgzjsmjSd5EAzkBeA1wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnN18oeUoEbxCxiLD6k8V2lLlWwCgS6c/ALgNv+EFyBT6sSPPBBt4L5VMMs0ESSyfpDiEc+4WWmr2Fn9tqBPIYYbkU2BjG6TpbHtb5So5PJH/xZT12zZtQzUvaaJ7orpcdUqyUCP782bbGZQiJ5rE9jSLQ7F7BCakAOopg2Xapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bJ0L2mqQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cfddc94c83so8216076a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705094; x=1733309894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xK1rXO8tid7sxZflvw8Sl0BR2j7teaHPSp5KtJr+3E=;
        b=bJ0L2mqQQbMtT1P/XBzdguApdhpViNXjwt/8e9Arfw678Al5oIULF6vMKm/TOK27pa
         owCIAriwrGj6kXkvKr7eeLPZt7Qiy3hKiO7dJc/s7D29bBqnJOu3hBpwNHXDC5y9nP+y
         Cbvyr/dMf/t42s2qJp8j1xOAzjWMd0lzImcgpvqBykis4jb3UpGrleMoBKGFQAPqcdjr
         OskiNa6J+o+PJIz+t0ESs9j2s32xvFjrObnbb65kypoyW0Ik5J2R+W1e3K3GF481x/9i
         FfeAs1cozf71pbQQVN4M+YjYvRHEDOJ/Bscrx4h0phklxg0Uiq2b6hqrz9RgjAlYr4/6
         0VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705094; x=1733309894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xK1rXO8tid7sxZflvw8Sl0BR2j7teaHPSp5KtJr+3E=;
        b=EOPX9oo3dRTVGCXbGTx5BH3r/OctdRqFs8ZSfAucN0U4n2lIulXWWHKSX5K4UoLE4K
         wh2j38yrR/5ZQi8KJhvLdRG6vD702aVLQiYfyb1OEcSAdt9W/Fp08wSBqcQEvH/jXcHo
         4OcBKkfVxW+9eM3/v+HHM5X+XwU69vj60/OtPpHgT88RuoG9EsfXYtnvKxQg5SW6jtRB
         4C9aDeF5cGjJxIBOvgmve3o41f2LSCGzt2pZM1ecK64A2U2TR87i14zJ6qG7UKoQO+Vq
         MlT9gqCtEbkZP9CCjN+MZ/uyco13xcqhYUOStE9g2jPpfie5Es4kktRU4o2rB7+X95JD
         xlFA==
X-Forwarded-Encrypted: i=1; AJvYcCXZMVjw/QS5cXQkr4vaTaZxfrWusQu32i4Cv+bT2rXelo9CFH9sh+biwnGMNk5dxeuKJAnzTIOdIL7kr6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMOITGLEvP0kR5Gvx8Vipct3kKKKrwKc9EimiEYmNgh2VmUxE
	I5Dx9PYgx23EKlbkFi/eCKkrAOVmh7+6/6kQwo8PXvrIm8SsdKeNcfnMavLuzeQ=
X-Gm-Gg: ASbGncu82FZVsyMpIjwcabsVtI1pvB2iaz3CCGj5+G7Uu56UswoisSog5aq/9+cmnBg
	iUX20DS+gOl22/TanP4dgzMeQlEDF86GVsUjJtagmhHz0+W/C9YLgEbLU8hZ15L7wTWVi+hO3gx
	aAqhpWWKjsso9p7LHDvQJayosxVbRN7+kUof1ZPCsAGlkuWrZsk9bLWXugZN5ihPRTkCwUkw7V9
	VR4OQqD2XEl92yfDTVVkZtUCATHcVzRzJsFC/hiciY/lh9ab6Qy3z/vxi53kCgmkAdmQfO0QYXu
	A5bDNacPH+IkCD0UGlN1WplPU//Lz96UJQ==
X-Google-Smtp-Source: AGHT+IFg+ahvle9uWHq2KZqsvbKtQxnkarL+5juw3kuxAh2lY4VSQel9JXoaUYp7iW98tOctHLx83w==
X-Received: by 2002:a17:906:31c1:b0:aa5:31f5:922a with SMTP id a640c23a62f3a-aa580f1e0d4mr204197766b.19.1732705094209;
        Wed, 27 Nov 2024 02:58:14 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54a6db906sm412183566b.41.2024.11.27.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:58:13 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 10:58:14 +0000
Subject: [PATCH 4/9] phy: exynos5-usbdrd: convert to dev_err_probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-phy-v1-4-1b7fce24960b@linaro.org>
References: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

dev_err_probe() exists to simplify code.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
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


