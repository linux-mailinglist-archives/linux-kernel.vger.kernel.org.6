Return-Path: <linux-kernel+bounces-569726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0B3A6A6AB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2349C7B0474
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EED221725;
	Thu, 20 Mar 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGBaId+l"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942BA21CA04;
	Thu, 20 Mar 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475694; cv=none; b=VljkvPkOsBy3XPZy68KsbIvdX4aUuwNTef5QW8kWIjmQ/WXe1hQRJlJhR37xHKGf7CzJPENjaCYhSoUCGGbSQrpmTXb+36eWsQ/qyfJmU5N3wub5/ZzUIrNnacp9wmCahLx9EjN/z8IFTcmPLNyiBJplSn2ZaokI+XGQwUitEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475694; c=relaxed/simple;
	bh=Vf4IvpSQePggWg4vxSZCOAh0dp5rJpQ5R2PqA5vbKGM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpxW67nsKd+kIoVQfg4B5ZJDbmWvzDRvihH8jpFpFtnk5aWvFRk0r5RAty9z2hZaAkCEr0nERE7IM9I/I/rbiBCILw5+EFpDrtpKC3ObIdBMLvUlh/tCBgDH76XQ9bKc5jgEcY9KGYULbsdqWqEHxG2Mj+zx8rEfp2ztZovyJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGBaId+l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso7365885e9.2;
        Thu, 20 Mar 2025 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475690; x=1743080490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYnsaKwLQcaTkvM+4ffTJRr6nfs/V7lVq/qqbRtol90=;
        b=UGBaId+lgAzRwV9yVT9kXm2jHy3tmDDDOZPvhahTWpwFQQsdiR38t9Jsnn9u1GTNlL
         m5VQfistmrDPK0+54W71/pLaflQnhCZFU/51K79LHkgnkHM2LLunKLqHydZZy5gSHSzd
         u87pH7Oa9gkiR2K5n3NbLeWnS3ekl54eGEf4pGiQ7FYXpBiJbGvlD0kSut0udA1zdaOj
         oPlqfaCl8oGqr5UcMt+jVJKFfhdeZLVTddUT5Ao7PV4KZXS+SQoqt3Xljmlp63gPlnWO
         cjtFvRGUm6EITqsXT07jeGtV5FLGR3wj7r8BGMrkeBkfelqbQ7SSP+fQC0Ast/PVoLjZ
         ahUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475690; x=1743080490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYnsaKwLQcaTkvM+4ffTJRr6nfs/V7lVq/qqbRtol90=;
        b=X5w07KTXnicQhH+ahfR6eUEFSYn23dowgaU4ycuHtaKa7RBzwbMPiZm7qRfmoc5Tgp
         T0kaaeOsMgRogNVpyXs680OmGoMR7Ejzx/3pVrOKFS3cTfxkFiGIknQ1kWli5h0NMibB
         QMTCeyfLxMlaGoR1P6DWduIJnz3YR8/B2R6kACc4QDR18TLxD9DRR41tqtf9PhWDA4l+
         chXKVTmcqFUn7Srmof5xyC1Wqs54n59PN0W3s5zsg8y+YHjxthCKQnR5UoExJGSsMibt
         B6lynK4GUdG1+7s3iuLxajEtwSbMUI+IY0yf6CdTmddS9CTCF4G0R9e2Bjaj48q25rQc
         A7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVHd0fh3LneRNrVzLToVtmOEmtPp+uBlCRbKSInDDX4nENHFqwc2qI3tg9R6mpGbTS+szzQALwchabo3Ryy@vger.kernel.org, AJvYcCVv6Ps4whYnB+4ee3Zacr171BsLB8gzE1MS34lWFVrf825tKGlJTbi2ohr0XhGsJjb8NTrzM3xw0M75@vger.kernel.org, AJvYcCW/RJM1ukCABZy9+aQOgrGfuEI1a8QM87vex9SJdxMXnUpIvdh2FcZIOhFVIsD0dL1YJcjJEpzOtc0y@vger.kernel.org, AJvYcCWryhNasqfjE+6l+hw5XmZj09k1opiDw2F+xbwsTa4yDru6JUgcUD127lbRsazKS1n7Smj3BkxwqSzZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+NgC+6QmH9aeOmd17nJ5yxap//0gMk4q53phzzI/ImpXCf9pp
	WUiGuCL0COLqJuqwNbOyPlDG2FiH/IhpsJQR//VEiL6VbQt2sPk7
X-Gm-Gg: ASbGncvon9ZJexp2sjXz0B/f7PphEFcnroyEZ0WaFzXU0ymtFtiaC3/vT5RM2WEFLs2
	YOjxb+nL4UCl14C7/H9fZiXUIGHmaegAW8od3ak7SyLC8uME2tCYnYNc/ElQLRLU1cnuAteD1R2
	UaYq6Im0BKVriPBFEFusQ2PPPtRIP6mAOCICDdVlUiuSeuIElfjQyXIUWZzVFRBzhim4qFF9M2x
	+rfd2QRWQKWnsiUwYxLEuiPJLCPtD6pbCLIg/g8clfSws00TXr/uQT8BXcQfS1x9hsuTbrbalhD
	u3FjMXQ2i5EFMm/BqYH1PVGcVzywMkLuEXydjDsJu3nQBHxd5XE2fFrqRgSqwRFKs8p3wusrlCf
	kuzge+VULb7w8gw==
X-Google-Smtp-Source: AGHT+IHitBKtOOy1SucPgUEGQLzzWHiEWJEFOJ0pyvyjc03NX9aNdjwUqdZDmvLHpRN43tzfEYYlSg==
X-Received: by 2002:a05:6000:21c7:b0:390:e1e0:1300 with SMTP id ffacd0b85a97d-399739d437amr4854037f8f.33.1742475689504;
        Thu, 20 Mar 2025 06:01:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm18492328f8f.97.2025.03.20.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:01:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 02/11] clk: en7523: generalize register clocks function
Date: Thu, 20 Mar 2025 14:00:25 +0100
Message-ID: <20250320130054.4804-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320130054.4804-1-ansuelsmth@gmail.com>
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Generalize register clocks function for Airoha EN7523 and EN7581 clocks
driver. The same logic is applied for both clock hence code can be
reduced and simplified by putting the base_clocks struct in the soc_data
and passing that to a generic register clocks function.

There is always the pattern where the last clock is always the PCIe one.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 130 ++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 77 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 314e7450313f..2a74bc8fed24 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -78,8 +78,10 @@ struct en_rst_data {
 
 struct en_clk_soc_data {
 	u32 num_clocks;
+	const struct en_clk_desc *base_clks;
 	const struct clk_ops pcie_ops;
 	int (*hw_init)(struct platform_device *pdev,
+		       const struct en_clk_soc_data *soc_data,
 		       struct clk_hw_onecell_data *clk_data);
 };
 
@@ -467,6 +469,50 @@ static struct clk_hw *en7523_register_pcie_clk(struct device *dev,
 	return &cg->hw;
 }
 
+static void en75xx_register_clocks(struct device *dev,
+				   const struct en_clk_soc_data *soc_data,
+				   struct clk_hw_onecell_data *clk_data,
+				   struct regmap *map, struct regmap *clk_map)
+{
+	struct clk_hw *hw;
+	u32 rate;
+	int i;
+
+	for (i = 0; i < soc_data->num_clocks - 1; i++) {
+		const struct en_clk_desc *desc = &soc_data->base_clks[i];
+		u32 val, reg = desc->div_reg ? desc->div_reg : desc->base_reg;
+		int err;
+
+		err = regmap_read(map, desc->base_reg, &val);
+		if (err) {
+			pr_err("Failed reading fixed clk rate %s: %d\n",
+			       desc->name, err);
+			continue;
+		}
+		rate = en7523_get_base_rate(desc, val);
+
+		err = regmap_read(map, reg, &val);
+		if (err) {
+			pr_err("Failed reading fixed clk div %s: %d\n",
+			       desc->name, err);
+			continue;
+		}
+		rate /= en7523_get_div(desc, val);
+
+		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %ld\n",
+			       desc->name, PTR_ERR(hw));
+			continue;
+		}
+
+		clk_data->hws[desc->id] = hw;
+	}
+
+	hw = en7523_register_pcie_clk(dev, clk_map);
+	clk_data->hws[soc_data->num_clocks] = hw;
+}
+
 static int en7581_pci_is_enabled(struct clk_hw *hw)
 {
 	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
@@ -504,38 +550,6 @@ static void en7581_pci_disable(struct clk_hw *hw)
 	usleep_range(1000, 2000);
 }
 
-static void en7523_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
-				   struct regmap *map, struct regmap *clk_map)
-{
-	struct clk_hw *hw;
-	u32 rate;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(en7523_base_clks); i++) {
-		const struct en_clk_desc *desc = &en7523_base_clks[i];
-		u32 reg = desc->div_reg ? desc->div_reg : desc->base_reg;
-		u32 val;
-
-		regmap_read(map, desc->base_reg, &val);
-
-		rate = en7523_get_base_rate(desc, val);
-		regmap_read(map, reg, &val);
-		rate /= en7523_get_div(desc, val);
-
-		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
-		if (IS_ERR(hw)) {
-			pr_err("Failed to register clk %s: %ld\n",
-			       desc->name, PTR_ERR(hw));
-			continue;
-		}
-
-		clk_data->hws[desc->id] = hw;
-	}
-
-	hw = en7523_register_pcie_clk(dev, clk_map);
-	clk_data->hws[EN7523_CLK_PCIE] = hw;
-}
-
 static const struct regmap_config en7523_clk_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
@@ -543,6 +557,7 @@ static const struct regmap_config en7523_clk_regmap_config = {
 };
 
 static int en7523_clk_hw_init(struct platform_device *pdev,
+			      const struct en_clk_soc_data *soc_data,
 			      struct clk_hw_onecell_data *clk_data)
 {
 	void __iomem *base, *np_base;
@@ -566,53 +581,11 @@ static int en7523_clk_hw_init(struct platform_device *pdev,
 	if (IS_ERR(clk_map))
 		return PTR_ERR(clk_map);
 
-	en7523_register_clocks(&pdev->dev, clk_data, map, clk_map);
+	en75xx_register_clocks(&pdev->dev, soc_data, clk_data, map, clk_map);
 
 	return 0;
 }
 
-static void en7581_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
-				   struct regmap *map, struct regmap *clk_map)
-{
-	struct clk_hw *hw;
-	u32 rate;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(en7581_base_clks); i++) {
-		const struct en_clk_desc *desc = &en7581_base_clks[i];
-		u32 val, reg = desc->div_reg ? desc->div_reg : desc->base_reg;
-		int err;
-
-		err = regmap_read(map, desc->base_reg, &val);
-		if (err) {
-			pr_err("Failed reading fixed clk rate %s: %d\n",
-			       desc->name, err);
-			continue;
-		}
-		rate = en7523_get_base_rate(desc, val);
-
-		err = regmap_read(map, reg, &val);
-		if (err) {
-			pr_err("Failed reading fixed clk div %s: %d\n",
-			       desc->name, err);
-			continue;
-		}
-		rate /= en7523_get_div(desc, val);
-
-		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
-		if (IS_ERR(hw)) {
-			pr_err("Failed to register clk %s: %ld\n",
-			       desc->name, PTR_ERR(hw));
-			continue;
-		}
-
-		clk_data->hws[desc->id] = hw;
-	}
-
-	hw = en7523_register_pcie_clk(dev, clk_map);
-	clk_data->hws[EN7523_CLK_PCIE] = hw;
-}
-
 static int en7523_reset_update(struct reset_controller_dev *rcdev,
 			       unsigned long id, bool assert)
 {
@@ -689,6 +662,7 @@ static int en7581_reset_register(struct device *dev, struct regmap *map)
 }
 
 static int en7581_clk_hw_init(struct platform_device *pdev,
+			      const struct en_clk_soc_data *soc_data,
 			      struct clk_hw_onecell_data *clk_data)
 {
 	struct regmap *map, *clk_map;
@@ -706,7 +680,7 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 	if (IS_ERR(clk_map))
 		return PTR_ERR(clk_map);
 
-	en7581_register_clocks(&pdev->dev, clk_data, map, clk_map);
+	en75xx_register_clocks(&pdev->dev, soc_data, clk_data, map, clk_map);
 
 	regmap_clear_bits(clk_map, REG_NP_SCU_SSTR,
 			  REG_PCIE_XSI0_SEL_MASK | REG_PCIE_XSI1_SEL_MASK);
@@ -732,7 +706,7 @@ static int en7523_clk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	clk_data->num = soc_data->num_clocks;
-	r = soc_data->hw_init(pdev, clk_data);
+	r = soc_data->hw_init(pdev, soc_data, clk_data);
 	if (r)
 		return r;
 
@@ -740,6 +714,7 @@ static int en7523_clk_probe(struct platform_device *pdev)
 }
 
 static const struct en_clk_soc_data en7523_data = {
+	.base_clks = en7523_base_clks,
 	.num_clocks = ARRAY_SIZE(en7523_base_clks) + 1,
 	.pcie_ops = {
 		.is_enabled = en7523_pci_is_enabled,
@@ -750,6 +725,7 @@ static const struct en_clk_soc_data en7523_data = {
 };
 
 static const struct en_clk_soc_data en7581_data = {
+	.base_clks = en7581_base_clks,
 	/* We increment num_clocks by 1 to account for additional PCIe clock */
 	.num_clocks = ARRAY_SIZE(en7581_base_clks) + 1,
 	.pcie_ops = {
-- 
2.48.1


