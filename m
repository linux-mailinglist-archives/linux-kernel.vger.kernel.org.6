Return-Path: <linux-kernel+bounces-569725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB53CA6A6A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 628D38A1866
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17B321D3CC;
	Thu, 20 Mar 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwHEeqmy"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FE2744D;
	Thu, 20 Mar 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475691; cv=none; b=ZRePZzQFP2L5qDPEa9SZ/azCXFrIQBVLBvyBmWce/IYOCuN7JnLi2tscDnRyFqjdNXthg14Y3FpYwdVcrxkkJa/GuruOMtvSXUoy5+6E3RcmNjZ3kkPU7k+PNL8MxC0xqvbWqfdqWqI+06tOYYg7RlSKeqEBTSza+LgXYbzB6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475691; c=relaxed/simple;
	bh=87vTHOZT+JRQXqKD/ajA8nRYhzwvixU2jXQJBrEV1XY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owYbcQnzdDZFHMk9Z8rOPY/N0lek5nLHMj7cZif1vWf4aqdyMNNuN+G9d6lK4LFtzxcNschK2ENjK+Ave9Gxfc9GrMkzH0loLQmjgifIbcbL/T/Fbo8g0Z8jjrkcruAaX+XMIeCgrjcPPVloBIKa8PXVeaQoZyg6CkkFWUt8nAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwHEeqmy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so4528735e9.3;
        Thu, 20 Mar 2025 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475688; x=1743080488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXGZSQaYq8bc/tr8X+R6iDGpv0XCfiL/MLUXqqcdlyQ=;
        b=SwHEeqmyPM7qSTDcHd5fEB0ZxGjqrrS/3V1kFfgm1Ns3ebOvhMadC6RICeM4YcetSO
         Ig6o/tLviZCNejDGQ0prqEpQHBnMI44vv1X+BU+4DuGYgEk2xFvBe6RjcbIDeaHUcdOu
         e3ldXJnMT+vauVJPF3WZCr9tdtUA0lYpkd/K9FZOA5DD2hNduOpdCakIotJlc0b+yrFF
         MK+S1O+bnKPqZags27+EQiHQJUvvzaYkfLLwVmz2duL2O33tfwrj4wxl33hHBW5f6ezM
         AuZTZ+U/leOdToxbH4yUWNFAhU84t1PSqYFVMtzRj9SEm3gu59vmMHgilov7GJuGGCAu
         5V5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475688; x=1743080488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXGZSQaYq8bc/tr8X+R6iDGpv0XCfiL/MLUXqqcdlyQ=;
        b=cX04Gaiqgt3TCUq0+qH4eH62krykCYd5uwJv2usi3xlBUqMTMCHLcT53KidlxHR7+P
         xbaFQZ7ot7Y5QHtPcDKqgcRwhUsB0yuSwlvVKteOjMiOilMuVfLAB2hyuBRD4Hj1pOcL
         NBtDMVHhGxJfyIi4gYEFM4Jux3ULwjYbgijI1lCrxoiCadtj7DSLTRW0Or58e9Tm9QyA
         hdj5Ge/uyzb1wbDzzVUdESvHNxdL8OWgkQw5FbfNuwlV6iFMDs9KyJct5bXFhaf/ovSj
         SOKOor4ZPKCeNSJI+F6oGh2Hf76r6lSNVXuOXF1zaQUkoEScthRNTXC8IuYk7az04tMF
         UMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU70BgcVEbh7Gd4qNqfHh4iWWsKo6t9W341Ex8p4HxLr2vkEMvB5ziLDaOB3QIs76oHN8gedFP5OMyY@vger.kernel.org, AJvYcCUj5jfe8XNJF2GZbbqDcnTo1eAXaK5DBFyXPIJS6pxFmDxbW40+6j2ZnNbZpQvUhYEMIX2z+xiHlCxF9Gad@vger.kernel.org, AJvYcCVLxTBdzNMQC0Q6o0hlSaVt12GFGKlvdLh29lfMaKFj1i/HgveK3jSGA5P60hSyOWr52GJVjIG1fL2B@vger.kernel.org, AJvYcCXER3xz4pdDeupIgDTs5LB/k9VOk4Tb1080yyiIA8kWHvt4x6px1jpKDB7GE6+ek+Pl8QMjQy8Utb4f@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqfc5bssa/k4P0SYXTLsnun4IOWJXMhUIYwytLKqNQaDyfS96/
	gECktP82bSi8NEl7iYRtMIa/OUMLxceyjlIIt3uh7iYdknJ6NF8M
X-Gm-Gg: ASbGncuU8KICshQFCKcbrtj8JxvAd34bjS3PzLrAgHxFUMRhqiteqdAhbtXLz21eipE
	DIGaYzIRJDrdnx+sZCs/L9XhwpZlXWQcD9pZbjgSK6oQZIsnDyY0tSY24B4edlVg6O8qd8twJFJ
	U1VqegRY6CKEAyvFfbGZDkYSAwAq5GRDrcpqGqPnwbvrK+y0XMyWO0T5XegiKL9zweUuKtLg1ea
	5Sjv20e+V/4XugZo/BaPJrcV5+/FL/hJHtIkdFF9yjEaQiRQ6ePBskTXAk9IlsbRUvkO0LRk0ly
	xxn7w65VdEnvSUA1FxKunk2phOBBVGGeEKW8T91XITy2XNk1nvq4ShHxPbthmME7S3hl7ULIT4s
	vJvWjJBUsEtzoHwyqbjcECuN+
X-Google-Smtp-Source: AGHT+IEuObpmg3yOapMwPpVVWSs/wQpdUsdFeU9kVqS7nHNyOr/jMa+9GDR775od73FEkiQXApr31g==
X-Received: by 2002:a05:600c:a00e:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-43d4381618dmr55265165e9.25.1742475687246;
        Thu, 20 Mar 2025 06:01:27 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm18492328f8f.97.2025.03.20.06.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:01:26 -0700 (PDT)
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
Subject: [PATCH v2 01/11] clk: en7523: convert driver to regmap API
Date: Thu, 20 Mar 2025 14:00:24 +0100
Message-ID: <20250320130054.4804-2-ansuelsmth@gmail.com>
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

Convert driver to regmap API, in preparation for support of Airoha
AN7583 as the SCU will be an MFD and the regmap will be provided in the
parent node. Also Airoha EN7581 benefits from this in preparation of USB
support that required checking and configuring SCU SSR bits.

While at it also cleanup some register mask and use bitfield macro.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/clk-en7523.c | 137 ++++++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 61 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index 15bbdeb60b8e..314e7450313f 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/bitfield.h>
 #include <linux/delay.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
@@ -34,6 +35,7 @@
 #define   REG_RESET_CONTROL_PCIE2	BIT(26)
 /* EN7581 */
 #define REG_NP_SCU_PCIC			0x88
+#define REG_PCIE_CTRL			GENMASK(7, 0)
 #define REG_NP_SCU_SSTR			0x9c
 #define REG_PCIE_XSI0_SEL_MASK		GENMASK(14, 13)
 #define REG_PCIE_XSI1_SEL_MASK		GENMASK(12, 11)
@@ -63,14 +65,14 @@ struct en_clk_desc {
 };
 
 struct en_clk_gate {
-	void __iomem *base;
+	struct regmap *map;
 	struct clk_hw hw;
 };
 
 struct en_rst_data {
 	const u16 *bank_ofs;
 	const u16 *idx_map;
-	void __iomem *base;
+	struct regmap *map;
 	struct reset_controller_dev rcdev;
 };
 
@@ -388,44 +390,44 @@ static u32 en7523_get_div(const struct en_clk_desc *desc, u32 val)
 static int en7523_pci_is_enabled(struct clk_hw *hw)
 {
 	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
+	u32 val;
 
-	return !!(readl(cg->base + REG_PCI_CONTROL) & REG_PCI_CONTROL_REFCLK_EN1);
+	regmap_read(cg->map, REG_PCI_CONTROL, &val);
+	return !!(val & REG_PCI_CONTROL_REFCLK_EN1);
 }
 
 static int en7523_pci_prepare(struct clk_hw *hw)
 {
 	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
-	void __iomem *np_base = cg->base;
-	u32 val, mask;
+	struct regmap *map = cg->map;
+	u32 mask;
 
 	/* Need to pull device low before reset */
-	val = readl(np_base + REG_PCI_CONTROL);
-	val &= ~(REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT);
-	writel(val, np_base + REG_PCI_CONTROL);
+	regmap_clear_bits(map, REG_PCI_CONTROL,
+			  REG_PCI_CONTROL_PERSTOUT1 |
+			  REG_PCI_CONTROL_PERSTOUT);
 	usleep_range(1000, 2000);
 
 	/* Enable PCIe port 1 */
-	val |= REG_PCI_CONTROL_REFCLK_EN1;
-	writel(val, np_base + REG_PCI_CONTROL);
+	regmap_set_bits(map, REG_PCI_CONTROL,
+			REG_PCI_CONTROL_REFCLK_EN1);
 	usleep_range(1000, 2000);
 
 	/* Reset to default */
-	val = readl(np_base + REG_RESET_CONTROL1);
 	mask = REG_RESET_CONTROL_PCIE1 | REG_RESET_CONTROL_PCIE2 |
 	       REG_RESET_CONTROL_PCIEHB;
-	writel(val & ~mask, np_base + REG_RESET_CONTROL1);
+	regmap_clear_bits(map, REG_RESET_CONTROL1, mask);
 	usleep_range(1000, 2000);
-	writel(val | mask, np_base + REG_RESET_CONTROL1);
+	regmap_set_bits(map, REG_RESET_CONTROL1, mask);
 	msleep(100);
-	writel(val & ~mask, np_base + REG_RESET_CONTROL1);
+	regmap_clear_bits(map, REG_RESET_CONTROL1, mask);
 	usleep_range(5000, 10000);
 
 	/* Release device */
 	mask = REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT;
-	val = readl(np_base + REG_PCI_CONTROL);
-	writel(val & ~mask, np_base + REG_PCI_CONTROL);
+	regmap_clear_bits(map, REG_PCI_CONTROL, mask);
 	usleep_range(1000, 2000);
-	writel(val | mask, np_base + REG_PCI_CONTROL);
+	regmap_set_bits(map, REG_PCI_CONTROL, mask);
 	msleep(250);
 
 	return 0;
@@ -434,16 +436,13 @@ static int en7523_pci_prepare(struct clk_hw *hw)
 static void en7523_pci_unprepare(struct clk_hw *hw)
 {
 	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
-	void __iomem *np_base = cg->base;
-	u32 val;
+	struct regmap *map = cg->map;
 
-	val = readl(np_base + REG_PCI_CONTROL);
-	val &= ~REG_PCI_CONTROL_REFCLK_EN1;
-	writel(val, np_base + REG_PCI_CONTROL);
+	regmap_clear_bits(map, REG_PCI_CONTROL, REG_PCI_CONTROL_REFCLK_EN1);
 }
 
 static struct clk_hw *en7523_register_pcie_clk(struct device *dev,
-					       void __iomem *np_base)
+					       struct regmap *clk_map)
 {
 	const struct en_clk_soc_data *soc_data = device_get_match_data(dev);
 	struct clk_init_data init = {
@@ -456,7 +455,7 @@ static struct clk_hw *en7523_register_pcie_clk(struct device *dev,
 	if (!cg)
 		return NULL;
 
-	cg->base = np_base;
+	cg->map = clk_map;
 	cg->hw.init = &init;
 
 	if (init.ops->unprepare)
@@ -474,21 +473,20 @@ static int en7581_pci_is_enabled(struct clk_hw *hw)
 	u32 val, mask;
 
 	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1;
-	val = readl(cg->base + REG_PCI_CONTROL);
+	regmap_read(cg->map, REG_PCI_CONTROL, &val);
 	return (val & mask) == mask;
 }
 
 static int en7581_pci_enable(struct clk_hw *hw)
 {
 	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
-	void __iomem *np_base = cg->base;
-	u32 val, mask;
+	struct regmap *map = cg->map;
+	u32 mask;
 
 	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1 |
 	       REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT2 |
 	       REG_PCI_CONTROL_PERSTOUT;
-	val = readl(np_base + REG_PCI_CONTROL);
-	writel(val | mask, np_base + REG_PCI_CONTROL);
+	regmap_set_bits(map, REG_PCI_CONTROL, mask);
 
 	return 0;
 }
@@ -496,19 +494,18 @@ static int en7581_pci_enable(struct clk_hw *hw)
 static void en7581_pci_disable(struct clk_hw *hw)
 {
 	struct en_clk_gate *cg = container_of(hw, struct en_clk_gate, hw);
-	void __iomem *np_base = cg->base;
-	u32 val, mask;
+	struct regmap *map = cg->map;
+	u32 mask;
 
 	mask = REG_PCI_CONTROL_REFCLK_EN0 | REG_PCI_CONTROL_REFCLK_EN1 |
 	       REG_PCI_CONTROL_PERSTOUT1 | REG_PCI_CONTROL_PERSTOUT2 |
 	       REG_PCI_CONTROL_PERSTOUT;
-	val = readl(np_base + REG_PCI_CONTROL);
-	writel(val & ~mask, np_base + REG_PCI_CONTROL);
+	regmap_clear_bits(map, REG_PCI_CONTROL, mask);
 	usleep_range(1000, 2000);
 }
 
 static void en7523_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
-				   void __iomem *base, void __iomem *np_base)
+				   struct regmap *map, struct regmap *clk_map)
 {
 	struct clk_hw *hw;
 	u32 rate;
@@ -517,10 +514,12 @@ static void en7523_register_clocks(struct device *dev, struct clk_hw_onecell_dat
 	for (i = 0; i < ARRAY_SIZE(en7523_base_clks); i++) {
 		const struct en_clk_desc *desc = &en7523_base_clks[i];
 		u32 reg = desc->div_reg ? desc->div_reg : desc->base_reg;
-		u32 val = readl(base + desc->base_reg);
+		u32 val;
+
+		regmap_read(map, desc->base_reg, &val);
 
 		rate = en7523_get_base_rate(desc, val);
-		val = readl(base + reg);
+		regmap_read(map, reg, &val);
 		rate /= en7523_get_div(desc, val);
 
 		hw = clk_hw_register_fixed_rate(dev, desc->name, NULL, 0, rate);
@@ -533,30 +532,47 @@ static void en7523_register_clocks(struct device *dev, struct clk_hw_onecell_dat
 		clk_data->hws[desc->id] = hw;
 	}
 
-	hw = en7523_register_pcie_clk(dev, np_base);
+	hw = en7523_register_pcie_clk(dev, clk_map);
 	clk_data->hws[EN7523_CLK_PCIE] = hw;
 }
 
+static const struct regmap_config en7523_clk_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
 static int en7523_clk_hw_init(struct platform_device *pdev,
 			      struct clk_hw_onecell_data *clk_data)
 {
 	void __iomem *base, *np_base;
+	struct regmap *map, *clk_map;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	map = devm_regmap_init_mmio(&pdev->dev, base,
+				    &en7523_clk_regmap_config);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
 	np_base = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(np_base))
 		return PTR_ERR(np_base);
 
-	en7523_register_clocks(&pdev->dev, clk_data, base, np_base);
+	clk_map = devm_regmap_init_mmio(&pdev->dev, np_base,
+					&en7523_clk_regmap_config);
+	if (IS_ERR(clk_map))
+		return PTR_ERR(clk_map);
+
+	en7523_register_clocks(&pdev->dev, clk_data, map, clk_map);
 
 	return 0;
 }
 
 static void en7581_register_clocks(struct device *dev, struct clk_hw_onecell_data *clk_data,
-				   struct regmap *map, void __iomem *base)
+				   struct regmap *map, struct regmap *clk_map)
 {
 	struct clk_hw *hw;
 	u32 rate;
@@ -593,7 +609,7 @@ static void en7581_register_clocks(struct device *dev, struct clk_hw_onecell_dat
 		clk_data->hws[desc->id] = hw;
 	}
 
-	hw = en7523_register_pcie_clk(dev, base);
+	hw = en7523_register_pcie_clk(dev, clk_map);
 	clk_data->hws[EN7523_CLK_PCIE] = hw;
 }
 
@@ -601,15 +617,10 @@ static int en7523_reset_update(struct reset_controller_dev *rcdev,
 			       unsigned long id, bool assert)
 {
 	struct en_rst_data *rst_data = container_of(rcdev, struct en_rst_data, rcdev);
-	void __iomem *addr = rst_data->base + rst_data->bank_ofs[id / RST_NR_PER_BANK];
-	u32 val;
+	u32 addr = rst_data->bank_ofs[id / RST_NR_PER_BANK];
 
-	val = readl(addr);
-	if (assert)
-		val |= BIT(id % RST_NR_PER_BANK);
-	else
-		val &= ~BIT(id % RST_NR_PER_BANK);
-	writel(val, addr);
+	regmap_update_bits(rst_data->map, addr, BIT(id % RST_NR_PER_BANK),
+			   assert ? BIT(id % RST_NR_PER_BANK) : 0);
 
 	return 0;
 }
@@ -630,9 +641,11 @@ static int en7523_reset_status(struct reset_controller_dev *rcdev,
 			       unsigned long id)
 {
 	struct en_rst_data *rst_data = container_of(rcdev, struct en_rst_data, rcdev);
-	void __iomem *addr = rst_data->base + rst_data->bank_ofs[id / RST_NR_PER_BANK];
+	u32 addr = rst_data->bank_ofs[id / RST_NR_PER_BANK];
+	u32 val;
 
-	return !!(readl(addr) & BIT(id % RST_NR_PER_BANK));
+	regmap_read(rst_data->map, addr, &val);
+	return !!(val & BIT(id % RST_NR_PER_BANK));
 }
 
 static int en7523_reset_xlate(struct reset_controller_dev *rcdev,
@@ -652,7 +665,7 @@ static const struct reset_control_ops en7581_reset_ops = {
 	.status = en7523_reset_status,
 };
 
-static int en7581_reset_register(struct device *dev, void __iomem *base)
+static int en7581_reset_register(struct device *dev, struct regmap *map)
 {
 	struct en_rst_data *rst_data;
 
@@ -662,7 +675,7 @@ static int en7581_reset_register(struct device *dev, void __iomem *base)
 
 	rst_data->bank_ofs = en7581_rst_ofs;
 	rst_data->idx_map = en7581_rst_map;
-	rst_data->base = base;
+	rst_data->map = map;
 
 	rst_data->rcdev.nr_resets = ARRAY_SIZE(en7581_rst_map);
 	rst_data->rcdev.of_xlate = en7523_reset_xlate;
@@ -678,9 +691,8 @@ static int en7581_reset_register(struct device *dev, void __iomem *base)
 static int en7581_clk_hw_init(struct platform_device *pdev,
 			      struct clk_hw_onecell_data *clk_data)
 {
-	struct regmap *map;
+	struct regmap *map, *clk_map;
 	void __iomem *base;
-	u32 val;
 
 	map = syscon_regmap_lookup_by_compatible("airoha,en7581-chip-scu");
 	if (IS_ERR(map))
@@ -690,15 +702,18 @@ static int en7581_clk_hw_init(struct platform_device *pdev,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	en7581_register_clocks(&pdev->dev, clk_data, map, base);
+	clk_map = devm_regmap_init_mmio(&pdev->dev, base, &en7523_clk_regmap_config);
+	if (IS_ERR(clk_map))
+		return PTR_ERR(clk_map);
+
+	en7581_register_clocks(&pdev->dev, clk_data, map, clk_map);
 
-	val = readl(base + REG_NP_SCU_SSTR);
-	val &= ~(REG_PCIE_XSI0_SEL_MASK | REG_PCIE_XSI1_SEL_MASK);
-	writel(val, base + REG_NP_SCU_SSTR);
-	val = readl(base + REG_NP_SCU_PCIC);
-	writel(val | 3, base + REG_NP_SCU_PCIC);
+	regmap_clear_bits(clk_map, REG_NP_SCU_SSTR,
+			  REG_PCIE_XSI0_SEL_MASK | REG_PCIE_XSI1_SEL_MASK);
+	regmap_update_bits(clk_map, REG_NP_SCU_PCIC, REG_PCIE_CTRL,
+			   FIELD_PREP(REG_PCIE_CTRL, 3));
 
-	return en7581_reset_register(&pdev->dev, base);
+	return en7581_reset_register(&pdev->dev, clk_map);
 }
 
 static int en7523_clk_probe(struct platform_device *pdev)
-- 
2.48.1


