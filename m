Return-Path: <linux-kernel+bounces-217952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7222590B6D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2D7284EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523911662F5;
	Mon, 17 Jun 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zlRWvGzF"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA614286
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642715; cv=none; b=tsiKOeIdxOk7e4UhoIiInSiaxocZCOCaq0yPuYjpoSjHOP4bd5Ugs32yCrAHaNsBnUKwEvbEPZ5wY7WZYc7Qv0DL1yjW3Q9u0bckb25EL6EEGv5E4xTLncBOzdkN+cUw+/3yhJiOSxswzYsAYu8Wyo1MVh6hfPGmXQ6a8AWTKXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642715; c=relaxed/simple;
	bh=N6XZFI/sQDTPBOoCeIod5mutBdsHCWns1i2fnE8Jrwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKAj6ZMm/WpCjH7IA/o7fZFB64pUCYyTpTqKeCE/bL4ZGznpbfuOhOCMfpBfdn4D46H/pdgJY53feiC7Z7KMiTPtnUH8rF86Grcxmu1TPEwxc7FvgB1ZbUji5LXXzB0NAj3cR4IzfWVTjpKnXLJNO1me4j/qUPzE3+TLjZ+2hiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zlRWvGzF; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6f936d2ba1so28556066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718642712; x=1719247512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThsTojdQQ8zSHFhNOOxiXRSOPUFKMTWzQLxLd3s8TBU=;
        b=zlRWvGzFChzB2CneiQEZxpCvEfWbVgFblBgdayzp7c/0T03EcQGAAdbOrxZtiSVB1z
         DUnjaQ/O+omeC/ayVj9wrdVjDloriawoeK68GNnQHPU1smNzf4iQD0c65w7+EUNqEo53
         NeRuH+W0S3L8cN2gnfsFMRx+jhZb+M6A+/tDBNSQXRX3U20fKUTK8MBQcM4TYFlGLMsT
         HpbmtxSaWjUgmlrxynUztzglDmciewNtu4YvTtVvy5acapYeJZlBF3+9cKnMo4C3sCVl
         JLH5DUfz3RwcbSawP6lho9jUeeL9E0pCqeLgaOWQFdixFA5C6vbBII4uaZEe/9be8ERu
         2MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718642712; x=1719247512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThsTojdQQ8zSHFhNOOxiXRSOPUFKMTWzQLxLd3s8TBU=;
        b=A4vTcYiuyY6G6ZQGUi5cr2KbYxfMGOogVcQ7sPjTq1f8w2LvVIBz14Hbo/C2D69HZX
         gGHDnl2Ys/9eRSElff9RC3X/LJHolJoOHA0QFb6DDZxIs5s3D+jXbnFQ7dTYAWSVIFZY
         ravWN0IBBjdl4/d7cptruEE1r7qJZxeq1opMLRWEL6L869gFmCO7bwmxAxPSnIl9Qspo
         7rEPkL6bHddPZhA3JQE/wneNI1pUol9PGGZpMMhMJDI+z6oRa6gFSmTUkoaC0zyS1xXF
         AekXxmKHAIpczlpSeLkFELNHmZVCqpsjsSqtj/olqh9D8NzzI1QzvTtdkc2xRKMd5ElW
         PgJA==
X-Forwarded-Encrypted: i=1; AJvYcCWHA9J3TG1sEHyRe9q3GA+CtOkS6n06UtKbg4e4+VFUX30zH492z+ZRZ0aXl6+5Qkw1kOJYt6t6AM4DWdOhHd4aTZz4N9dR+7fT3gyX
X-Gm-Message-State: AOJu0Yx9sqU/NjpyupYtNSzK7CSs8TTAAiByqdVpO6AoevQEM+433KeT
	GP072iCqcD3RmSh6jjxSeSJ49CuC8+Vdwvq/hb1/ZzkaiM/SEJavhxQbvQHptXQ=
X-Google-Smtp-Source: AGHT+IFcJWeLyEHV3yWQ18wnmpR54ia9kKxwzabyy2RmlFFm5mvL5H8jtPPWb261kiLvundn45hNyg==
X-Received: by 2002:a17:907:c249:b0:a6f:603a:d9e9 with SMTP id a640c23a62f3a-a6f94e29a83mr13525366b.10.1718642711493;
        Mon, 17 Jun 2024 09:45:11 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f4170bsm527139966b.157.2024.06.17.09.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:45:11 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 17 Jun 2024 17:44:43 +0100
Subject: [PATCH v3 2/6] phy: exynos5-usbdrd: support isolating HS and SS
 ports independently
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-usb-phy-gs101-v3-2-b66de9ae7424@linaro.org>
References: <20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org>
In-Reply-To: <20240617-usb-phy-gs101-v3-0-b66de9ae7424@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Some versions of this IP have been integrated using separate PMU power
control registers for the HS and SS parts. One example is the Google
Tensor gs101 SoC.

Such SoCs can now set pmu_offset_usbdrd0_phy_ss in their
exynos5_usbdrd_phy_drvdata for the SS phy to the appropriate value.

The existing 'usbdrdphy' alias can not be used in this case because
that is meant for determining the correct PMU offset if multiple
distinct PHYs exist in the system (as opposed to one PHY with multiple
isolators).

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v3: use drv_data instead of phy_drd->drv_data for shorter lines
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 15be966b50ae..b7e2526f4c06 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -186,6 +186,7 @@ struct exynos5_usbdrd_phy_drvdata {
 	const struct exynos5_usbdrd_phy_config *phy_cfg;
 	const struct phy_ops *phy_ops;
 	u32 pmu_offset_usbdrd0_phy;
+	u32 pmu_offset_usbdrd0_phy_ss;
 	u32 pmu_offset_usbdrd1_phy;
 	bool has_common_clk_gate;
 };
@@ -1065,16 +1066,6 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 	if (channel < 0)
 		dev_dbg(dev, "Not a multi-controller usbdrd phy\n");
 
-	switch (channel) {
-	case 1:
-		pmu_offset = phy_drd->drv_data->pmu_offset_usbdrd1_phy;
-		break;
-	case 0:
-	default:
-		pmu_offset = phy_drd->drv_data->pmu_offset_usbdrd0_phy;
-		break;
-	}
-
 	/* Get Vbus regulators */
 	phy_drd->vbus = devm_regulator_get(dev, "vbus");
 	if (IS_ERR(phy_drd->vbus)) {
@@ -1109,6 +1100,18 @@ static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 		phy_drd->phys[i].phy = phy;
 		phy_drd->phys[i].index = i;
 		phy_drd->phys[i].reg_pmu = reg_pmu;
+		switch (channel) {
+		case 1:
+			pmu_offset = drv_data->pmu_offset_usbdrd1_phy;
+			break;
+		case 0:
+		default:
+			pmu_offset = drv_data->pmu_offset_usbdrd0_phy;
+			if (i == EXYNOS5_DRDPHY_PIPE3 && drv_data
+						->pmu_offset_usbdrd0_phy_ss)
+				pmu_offset = drv_data->pmu_offset_usbdrd0_phy_ss;
+			break;
+		}
 		phy_drd->phys[i].pmu_offset = pmu_offset;
 		phy_drd->phys[i].phy_cfg = &drv_data->phy_cfg[i];
 		phy_set_drvdata(phy, &phy_drd->phys[i]);

-- 
2.45.2.627.g7a2c4fd464-goog


