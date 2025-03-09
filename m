Return-Path: <linux-kernel+bounces-553134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E5AA58455
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E57E7A5CB2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A021DE3AB;
	Sun,  9 Mar 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp5jxaS6"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3AC9460;
	Sun,  9 Mar 2025 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527043; cv=none; b=RvUq9poo2M50N71OQCRinnQuhNCaMAPuAXJDaLdANZMyEbCMYDz2zbeQZeXU+07DFfGPHAakOMAgGmrhH57WUvesueEXqbNZg3j+Go0zTvuZl0J2SH/EjEAy7n7Tgd5b+M+6G1Q0ocPuQ9pmOi6aWyIBcazgj1c6hm3/19ZzmRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527043; c=relaxed/simple;
	bh=87vTHOZT+JRQXqKD/ajA8nRYhzwvixU2jXQJBrEV1XY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXzHoAzy1Cuk8JGHhhNObS37zXiFtl+8885sWsGVD5PU56trfMAKxGgmoHFy5EA3zp4pJae399t5amFnIPateChCYJqatwssQ2sDtcDwvWMcnLkbsFgLJokxi3j41pn3lImRKCwdCmElo8hGu185QL+xufnGnYv8yGl5Vfl35X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp5jxaS6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so1549081f8f.2;
        Sun, 09 Mar 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527040; x=1742131840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXGZSQaYq8bc/tr8X+R6iDGpv0XCfiL/MLUXqqcdlyQ=;
        b=Sp5jxaS6hJE72PIP1dfY5BR+muTbklLzMl9PjL9++HNSr2VAkRafnOoZVCaB44jqCV
         PLwhV1mnEx7zON2PgAiCcOat/U2WIMUHHEcroV0btsTYU2rmChZoX9iBTKXKSB2V5oVU
         XQ1DJ2BOfRa8GplpSQuPF5cn220xKHw1crw1JKXgM47DGSM70+gtFWitPb74qYaeIyKV
         0rL1MfBqfzvqJTtdB/feevCqe+IZk1wLABL8m7837C25YHtj4T5G2nCtiHdG3kz9pyVC
         2EMx8CdEUgbdxs25Von4TETo/HafdeGXXEc8du6n06Oyp7Zp4HekVjLDFqDck2xEfYih
         1d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527040; x=1742131840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXGZSQaYq8bc/tr8X+R6iDGpv0XCfiL/MLUXqqcdlyQ=;
        b=aGRMc/NmaNJy67hyE8hV0b1UlSuaiuEF7FBdqoNG9+4KW5olgo1eBsJYi6MG5K+Bt1
         niSjaGck4f9KmrlA1bICC4RnYfBkzJCd3i+DY2F/p55BJybMgt/R3UsyPXjZM0pMEnjj
         8FdJ+lZzAZi/+Buw6dHQ3Nxlap0ncoESx1ZEzsHSMz70hwtFje/nEjkgLq+RUqNQkaBv
         gDAI4Fo7l8gFvqRI0ycQ7Da6ymLBnhTzk9PZnBb05MNzsx3BjqG1KQZ71eTbAX7lesB+
         KNor+HgGXTjb/TnObFH9+YquB6TCW8WDy1M+/iPYMe1PavQgQCpDFurr34KP7rtjqJMo
         rZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCUOU5gs9skvQdEr42AGROUhaBewaTbjw9+I29sh9uoX6XmfhYiuHY+IhpT2I4xLS7isHx0VrB9wlDKi3h0f@vger.kernel.org, AJvYcCV4tZ1UuGwiJoEmUsETGlsKT2KVKaVgfIMfPxh0+AGUPwS1zJ3Z1pV02GIn6iH8WI7+7YGftYOJE9YH@vger.kernel.org, AJvYcCWjf9SfDrV0/K45nNcjrq0XNmEPzrOd/yr4cM0kaRpa6AQ/Bj6kH52Rt4zhWmOMhoQkfmeYVrKX48XX@vger.kernel.org, AJvYcCXEeQlA17Y71QZUpiFibDnLk3uo+u79Z8dzVU62oLFphKNrPuiDhn/wiPOLtJh4KF7uK0bZZh5EOuZk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00ONpQ+HxJd9SfOY2KaSvo2ceukckfhffqCd/dg2tgr9V4x0s
	180YE0G0CXjqpG1Ia1vqWQ/bDUReAp+oKgNcX1k73AN7s9iHgzby
X-Gm-Gg: ASbGncsuKHBo7lTPr5zd5r1Pycdwy6TQAswIMHCx/M4OEiVLgkrXTroW0YFF/Mus6b4
	g2TQqnFsym0GgeigOqWjLKFI4uQHYQKA+6tpSqc/3N+PE/vXcoNtBHBuge7qRCJJvVJSpjf5EaF
	GMrTqK5efnzoCOPxs5fnynwDI4Y6YzDLsOEXlG0flN3eytjGcny8JLdGdPUgl+76HoZcjNEnAu5
	iYEpJVxqvdNmj/eiH/xRHWvZLwdjabhmOk9urA0Qfvp1DjKC5uNE36eqfWcPJCmHPG8ScOgy1jo
	8sHEKJnqEYGxRK0+YF3gaA6vC/78WWQwdB3Jlunvl98LH7kdk1zWSpEWE82B24i9IW9YnvnoSW8
	18sF12sZaJawCvA==
X-Google-Smtp-Source: AGHT+IExUCuOZLoF7gqcGan1qMq7cFGyQ2TzVW2KLuRBjuD+qOt/apk1yulFVHLpZzet4enxc1wYZQ==
X-Received: by 2002:a05:6000:2ac:b0:391:3094:d696 with SMTP id ffacd0b85a97d-39132de2bdfmr5586276f8f.54.1741527039657;
        Sun, 09 Mar 2025 06:30:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
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
Subject: [PATCH 01/13] clk: en7523: convert driver to regmap API
Date: Sun,  9 Mar 2025 14:29:32 +0100
Message-ID: <20250309132959.19045-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
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


