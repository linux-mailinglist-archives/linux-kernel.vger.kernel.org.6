Return-Path: <linux-kernel+bounces-217955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB2590B6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FC41C23663
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AE31684BB;
	Mon, 17 Jun 2024 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmE2mdwy"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD840166302
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642718; cv=none; b=uz2RYJTB0cxAaQyXgz6PvVeKKWTdwhmfQXrga9Ya4W53WPajUdL9psQVxVnfWjQWNfk9CmewNdPET0uXCXmUkdHC6X2ssM1fqj2FI9P6X9UzLBbTG2t9vW/gL9Uwr7hK2Oa17BgzcdFemRI74ky3xzO9BmIN5/xrKyRCVFnZ5LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642718; c=relaxed/simple;
	bh=ccz0hCcXkhmHSbVigTvyDMlitcNo6eYRerPiHfBjKIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tB/kJOT5OYPKikfwszE59tlOEXoUjga2RNGFhiXxzatLt1bqdqfFHuskXm95YUlOhQvcEOtWD+f97pxchKOQiqjVdD/s5jnGziol603BIyMVrvEBXFfd4i2yXdZUIM14Nel2gpK8zJQqedKD0YAUOGqRZF0yrAvi63oc88ZkRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jmE2mdwy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so111197566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718642713; x=1719247513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=775Rc3YSZJA9GkF9P0glZgOGiZ3l+SlVgXxf6vD2zUg=;
        b=jmE2mdwy5T/uWDp8s5cFegj8l+JAIMvSyac28D2wXQO4ZLSuAQvAMfyHsDNnlgSbYG
         h4EpvrSKVGrHS89eyK6W38+odwPkipZvT9A7ghcf8AeLPmu7eNWv2ZKSJnWLpLFjRsBt
         IJ5W/YXRB0jFKZ1RIgFYr+6pLpe5jH+Y/h0Ekyyn7Gsa5MwMirBCNEwbWSdofUJdYYch
         uno0KOywQMM+QByUER4T2d2goOhCGnZQhuJwM0aqVeziyr8boTSuPHJfAiEjNaQOuDZ6
         UNVFpX3VReVAuvgbawb8pxRKjsd0iExLaB8gpbWRbv2Ai7B+f3ENaRYWncLaB89ibIOW
         wUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718642713; x=1719247513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=775Rc3YSZJA9GkF9P0glZgOGiZ3l+SlVgXxf6vD2zUg=;
        b=scoXWMjTZAWg4W7ribs+7Wi41vuwRt1uNdqyp3fY2RUx8iPBgwlDkn4g5NIDVfGSdm
         CWWEhkM8VwvW2RwjznOHBH7fPlqnsDm5IM7K/ytx4p8yabUCAxBonoXjmJWMJeflJhse
         5MfYGYfikGpI16/KR/OMowEmimAB2eUES4+k8UjbQnGBObukJLV836JMsCTzlxbYsltN
         1GMMp7f1xQJA/oGGwxW9hKlPwBf8MGR4z5akbjgvXWmcGLTkkMWe4mhtQAE2I9X7Xm9R
         Exy8PmKv/Gk6nMS7MIMmux3KZJtH6U+FNovQDL6OHajth9LC2plKXIQgOx1qj39od2NL
         xlrg==
X-Forwarded-Encrypted: i=1; AJvYcCUvb4vNh33hCWZY6VPBSgPYaSogF5AZSwbK1eLSr2pK8SPkgDeXdNo07Ko7hThJYNSOQ4LT0XK40XKVbCC4Tlk2q1mcqYFmMOdNAbYm
X-Gm-Message-State: AOJu0YxVuoN6dVEHaAXTpp7PQutJJgSePKVwRYm3QxRhW+CKTuxjX5ht
	IZfX8aW2junqvUm+MKRai+ghKKUIuoo8LylRr/1zHsDmwUsFFvYOGtlUpgtabB4=
X-Google-Smtp-Source: AGHT+IGxghexs1XqxhT5potawbeFSAX16ipohQs+SrpdF0FJ0NKfLsTElkU4lhVhPvf7HZsnVf1r1Q==
X-Received: by 2002:a17:906:ba89:b0:a6f:6960:5e15 with SMTP id a640c23a62f3a-a6f94c13e0emr12835266b.7.1718642713131;
        Mon, 17 Jun 2024 09:45:13 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f4170bsm527139966b.157.2024.06.17.09.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 09:45:12 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 17 Jun 2024 17:44:45 +0100
Subject: [PATCH v3 4/6] phy: exynos5-usbdrd: convert (phy) register access
 clock to clk_bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240617-usb-phy-gs101-v3-4-b66de9ae7424@linaro.org>
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

In preparation for support for additional platforms, convert the phy
register access clock to using the clk_bulk interfaces.

Newer SoCs like Google Tensor gs101 require additional clocks for
access to additional (different) register areas (PHY, PMA, PCS), and
converting to clk_bulk simplifies addition of those extra clocks.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v3:
* make the register access clock name(s) platform specific and avoid
  use of devm_clk_bulk_get_optional() as we want to be sure to have
  retrieved all required clocks
* fix a whitespace issue
* slightly rephrase commit message
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 54 +++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index 35b307dad2ee..80a3891fd605 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -185,6 +185,8 @@ struct exynos5_usbdrd_phy_config {
 struct exynos5_usbdrd_phy_drvdata {
 	const struct exynos5_usbdrd_phy_config *phy_cfg;
 	const struct phy_ops *phy_ops;
+	const char * const *clk_names;
+	int n_clks;
 	const char * const *core_clk_names;
 	int n_core_clks;
 	u32 pmu_offset_usbdrd0_phy;
@@ -196,7 +198,7 @@ struct exynos5_usbdrd_phy_drvdata {
  * struct exynos5_usbdrd_phy - driver data for USB 3.0 PHY
  * @dev: pointer to device instance of this platform device
  * @reg_phy: usb phy controller register memory base
- * @clk: phy clock for register access
+ * @clks: clocks for register access
  * @core_clks: core clocks for phy (ref, pipe3, utmi+, ITP, etc. as required)
  * @drv_data: pointer to SoC level driver data structure
  * @phys: array for 'EXYNOS5_DRDPHYS_NUM' number of PHY
@@ -209,7 +211,7 @@ struct exynos5_usbdrd_phy_drvdata {
 struct exynos5_usbdrd_phy {
 	struct device *dev;
 	void __iomem *reg_phy;
-	struct clk *clk;
+	struct clk_bulk_data *clks;
 	struct clk_bulk_data *core_clks;
 	const struct exynos5_usbdrd_phy_drvdata *drv_data;
 	struct phy_usb_instance {
@@ -402,7 +404,7 @@ static int exynos5_usbdrd_phy_init(struct phy *phy)
 	struct phy_usb_instance *inst = phy_get_drvdata(phy);
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 
-	ret = clk_prepare_enable(phy_drd->clk);
+	ret = clk_bulk_prepare_enable(phy_drd->drv_data->n_clks, phy_drd->clks);
 	if (ret)
 		return ret;
 
@@ -452,7 +454,7 @@ static int exynos5_usbdrd_phy_init(struct phy *phy)
 	reg &= ~PHYCLKRST_PORTRESET;
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYCLKRST);
 
-	clk_disable_unprepare(phy_drd->clk);
+	clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->clks);
 
 	return 0;
 }
@@ -464,7 +466,7 @@ static int exynos5_usbdrd_phy_exit(struct phy *phy)
 	struct phy_usb_instance *inst = phy_get_drvdata(phy);
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 
-	ret = clk_prepare_enable(phy_drd->clk);
+	ret = clk_bulk_prepare_enable(phy_drd->drv_data->n_clks, phy_drd->clks);
 	if (ret)
 		return ret;
 
@@ -486,7 +488,7 @@ static int exynos5_usbdrd_phy_exit(struct phy *phy)
 		PHYTEST_POWERDOWN_HSP;
 	writel(reg, phy_drd->reg_phy + EXYNOS5_DRD_PHYTEST);
 
-	clk_disable_unprepare(phy_drd->clk);
+	clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->clks);
 
 	return 0;
 }
@@ -811,14 +813,14 @@ static int exynos850_usbdrd_phy_init(struct phy *phy)
 	struct exynos5_usbdrd_phy *phy_drd = to_usbdrd_phy(inst);
 	int ret;
 
-	ret = clk_prepare_enable(phy_drd->clk);
+	ret = clk_bulk_prepare_enable(phy_drd->drv_data->n_clks, phy_drd->clks);
 	if (ret)
 		return ret;
 
 	/* UTMI or PIPE3 specific init */
 	inst->phy_cfg->phy_init(phy_drd);
 
-	clk_disable_unprepare(phy_drd->clk);
+	clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->clks);
 
 	return 0;
 }
@@ -831,7 +833,7 @@ static int exynos850_usbdrd_phy_exit(struct phy *phy)
 	u32 reg;
 	int ret;
 
-	ret = clk_prepare_enable(phy_drd->clk);
+	ret = clk_bulk_prepare_enable(phy_drd->drv_data->n_clks, phy_drd->clks);
 	if (ret)
 		return ret;
 
@@ -854,7 +856,7 @@ static int exynos850_usbdrd_phy_exit(struct phy *phy)
 	reg &= ~CLKRST_LINK_SW_RST;
 	writel(reg, regs_base + EXYNOS850_DRD_CLKRST);
 
-	clk_disable_unprepare(phy_drd->clk);
+	clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->clks);
 
 	return 0;
 }
@@ -873,11 +875,19 @@ static int exynos5_usbdrd_phy_clk_handle(struct exynos5_usbdrd_phy *phy_drd)
 	struct clk *ref_clk;
 	unsigned long ref_rate;
 
-	phy_drd->clk = devm_clk_get(phy_drd->dev, "phy");
-	if (IS_ERR(phy_drd->clk)) {
-		dev_err(phy_drd->dev, "Failed to get phy clock\n");
-		return PTR_ERR(phy_drd->clk);
-	}
+	phy_drd->clks = devm_kcalloc(phy_drd->dev, phy_drd->drv_data->n_clks,
+				     sizeof(*phy_drd->clks), GFP_KERNEL);
+	if (!phy_drd->clks)
+		return -ENOMEM;
+
+	for (int i = 0; i < phy_drd->drv_data->n_clks; ++i)
+		phy_drd->clks[i].id = phy_drd->drv_data->clk_names[i];
+
+	ret = devm_clk_bulk_get(phy_drd->dev, phy_drd->drv_data->n_clks,
+				phy_drd->clks);
+	if (ret)
+		return dev_err_probe(phy_drd->dev, ret,
+				     "failed to get phy clock(s)\n");
 
 	phy_drd->core_clks = devm_kcalloc(phy_drd->dev,
 					  phy_drd->drv_data->n_core_clks,
@@ -939,6 +949,10 @@ static const struct exynos5_usbdrd_phy_config phy_cfg_exynos850[] = {
 	},
 };
 
+static const char * const exynos5_clk_names[] = {
+	"phy",
+};
+
 static const char * const exynos5_core_clk_names[] = {
 	"ref",
 };
@@ -952,6 +966,8 @@ static const struct exynos5_usbdrd_phy_drvdata exynos5420_usbdrd_phy = {
 	.phy_ops		= &exynos5_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
 	.pmu_offset_usbdrd1_phy	= EXYNOS5420_USBDRD1_PHY_CONTROL,
+	.clk_names		= exynos5_clk_names,
+	.n_clks			= ARRAY_SIZE(exynos5_clk_names),
 	.core_clk_names		= exynos5_core_clk_names,
 	.n_core_clks		= ARRAY_SIZE(exynos5_core_clk_names),
 };
@@ -960,6 +976,8 @@ static const struct exynos5_usbdrd_phy_drvdata exynos5250_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos5,
 	.phy_ops		= &exynos5_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
+	.clk_names		= exynos5_clk_names,
+	.n_clks			= ARRAY_SIZE(exynos5_clk_names),
 	.core_clk_names		= exynos5_core_clk_names,
 	.n_core_clks		= ARRAY_SIZE(exynos5_core_clk_names),
 };
@@ -969,6 +987,8 @@ static const struct exynos5_usbdrd_phy_drvdata exynos5433_usbdrd_phy = {
 	.phy_ops		= &exynos5_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
 	.pmu_offset_usbdrd1_phy	= EXYNOS5433_USBHOST30_PHY_CONTROL,
+	.clk_names		= exynos5_clk_names,
+	.n_clks			= ARRAY_SIZE(exynos5_clk_names),
 	.core_clk_names		= exynos5433_core_clk_names,
 	.n_core_clks		= ARRAY_SIZE(exynos5433_core_clk_names),
 };
@@ -977,6 +997,8 @@ static const struct exynos5_usbdrd_phy_drvdata exynos7_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos5,
 	.phy_ops		= &exynos5_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
+	.clk_names		= exynos5_clk_names,
+	.n_clks			= ARRAY_SIZE(exynos5_clk_names),
 	.core_clk_names		= exynos5433_core_clk_names,
 	.n_core_clks		= ARRAY_SIZE(exynos5433_core_clk_names),
 };
@@ -985,6 +1007,8 @@ static const struct exynos5_usbdrd_phy_drvdata exynos850_usbdrd_phy = {
 	.phy_cfg		= phy_cfg_exynos850,
 	.phy_ops		= &exynos850_usbdrd_phy_ops,
 	.pmu_offset_usbdrd0_phy	= EXYNOS5_USBDRD_PHY_CONTROL,
+	.clk_names		= exynos5_clk_names,
+	.n_clks			= ARRAY_SIZE(exynos5_clk_names),
 	.core_clk_names		= exynos5_core_clk_names,
 	.n_core_clks		= ARRAY_SIZE(exynos5_core_clk_names),
 };

-- 
2.45.2.627.g7a2c4fd464-goog


