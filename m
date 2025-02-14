Return-Path: <linux-kernel+bounces-514968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABBFA35E11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460127A3ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2178F266F08;
	Fri, 14 Feb 2025 12:56:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0770266EE7;
	Fri, 14 Feb 2025 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537784; cv=none; b=h/s0TV+oNW8Q/fOAxGfMvhcYz26Rftxx8kYo86h3RvBxP8hHmukZp4JvlkqFWLZSjJaa4nH3uQDegOObYJIqJWubXS6gH1QS1mLxNajQ62pkKPcHK475kSZD0qw1/5xa/HltMzF5/S9IxiU+3N/6eUKfXVCnlptNjAWVPQHctAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537784; c=relaxed/simple;
	bh=OtZcIbj6y6RLCS3m9Lo2JBZQzU4hireMXAzAHy/hDf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIe6KcpMe66TF3j8Zp4XSesaOP/h+b8q1aZ/kOIeIO1SKd36fcWG6ExYFpXleDyhOoXQM8TFjtCecnb1M2cVuwBdxJV8ArtpMcWHI5ZdIt5yDg6mbIs/I2Rs5jT1oDdLODniOQO+rVA/yaLNT/1HqxWJMMoHTYPhT/NoxzDL6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED516113E;
	Fri, 14 Feb 2025 04:56:42 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C18073F58B;
	Fri, 14 Feb 2025 04:56:20 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/15] clk: sunxi-ng: a523: add interface mod clocks
Date: Fri, 14 Feb 2025 12:53:53 +0000
Message-ID: <20250214125359.5204-10-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250214125359.5204-1-andre.przywara@arm.com>
References: <20250214125359.5204-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the clocks driving what the user manual summarises under "interface"
devices: raw NAND flash, MMC, SPI, EMAC, "IR" infrared, and the "GPADC"
general purpose analogue/digital converter.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 160 +++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index b68c44bce825f..14d13fb16dfbb 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -113,6 +113,9 @@ static CLK_FIXED_FACTOR_HWS(pll_periph0_150M_clk, "pll-periph0-150M",
 			    pll_periph0_2x_hws, 8, 1, 0);
 static CLK_FIXED_FACTOR_HWS(pll_periph0_160M_clk, "pll-periph0-160M",
 			    pll_periph0_480M_hws, 3, 1, 0);
+static const struct clk_hw *pll_periph0_150M_hws[] = {
+	&pll_periph0_150M_clk.hw
+};
 
 #define SUN55I_A523_PLL_PERIPH1_REG	0x028
 static struct ccu_nm pll_periph1_4x_clk = {
@@ -537,6 +540,133 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(dram_clk, "dram", dram_parents, 0x800,
 static CLK_FIXED_FACTOR_HW(mbus_clk, "mbus",
 			   &dram_clk.common.hw, 4, 1, 0);
 
+static const struct clk_parent_data nand_mmc_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .hw = &pll_periph0_400M_clk.hw },
+	{ .hw = &pll_periph0_300M_clk.hw },
+	{ .hw = &pll_periph1_400M_clk.hw },
+	{ .hw = &pll_periph1_300M_clk.hw },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand0_clk, "nand0", nand_mmc_parents,
+				    0x810,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand1_clk, "nand1", nand_mmc_parents,
+				    0x814,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc0_clk, "mmc0", nand_mmc_parents,
+					   0x830,
+					   0, 5,	/* M */
+					   8, 5,	/* P */
+					   24, 3,	/* mux */
+					   BIT(31),	/* gate */
+					   2,		/* post div */
+					   0, CCU_FEATURE_DUAL_DIV);
+
+static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc1_clk, "mmc1", nand_mmc_parents,
+					   0x834,
+					   0, 5,	/* M */
+					   8, 5,	/* P */
+					   24, 3,	/* mux */
+					   BIT(31),	/* gate */
+					   2,		/* post div */
+					   0, CCU_FEATURE_DUAL_DIV);
+
+static const struct clk_parent_data mmc2_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .hw = &pll_periph0_800M_clk.common.hw },
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .hw = &pll_periph1_800M_clk.common.hw },
+	{ .hw = &pll_periph1_600M_clk.hw },
+};
+
+static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc2_clk, "mmc2", mmc2_parents,
+					   0x838,
+					   0, 5,	/* M */
+					   8, 5,	/* P */
+					   24, 3,	/* mux */
+					   BIT(31),	/* gate */
+					   2,		/* post div */
+					   0, CCU_FEATURE_DUAL_DIV);
+
+static const struct clk_parent_data spi_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .hw = &pll_periph0_300M_clk.hw },
+	{ .hw = &pll_periph0_200M_clk.hw },
+	{ .hw = &pll_periph1_300M_clk.hw },
+	{ .hw = &pll_periph1_200M_clk.hw },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi0_clk, "spi0", spi_parents, 0x940,
+				       0, 5,	/* M */
+				       8, 5,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi1_clk, "spi1", spi_parents, 0x944,
+				       0, 5,	/* M */
+				       8, 5,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spi2_clk, "spi2", spi_parents, 0x948,
+				       0, 5,	/* M */
+				       8, 5,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spifc_clk, "spifc", nand_mmc_parents,
+				       0x950,
+				       0, 5,	/* M */
+				       8, 5,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac0_25M_clk, "emac0-25M",
+				      pll_periph0_150M_hws,
+				      0x970, BIT(31) | BIT(30), 6, 0);
+static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac1_25M_clk, "emac1-25M",
+				      pll_periph0_150M_hws,
+				      0x974, BIT(31) | BIT(30), 6, 0);
+
+static const struct clk_parent_data ir_rx_parents[] = {
+	{ .fw_name = "losc" },
+	{ .fw_name = "hosc" },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ir_rx_clk, "ir-rx", ir_rx_parents, 0x990,
+				      0, 5,	/* M */
+				      24, 1,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+static const struct clk_parent_data ir_tx_ledc_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .hw = &pll_periph1_600M_clk.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ir_tx_clk, "ir-tx", ir_tx_ledc_parents,
+				      0x9c0,
+				      0, 5,	/* M */
+				      24, 1,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static SUNXI_CCU_M_WITH_GATE(gpadc0_clk, "gpadc0", "hosc", 0x9e0,
+				 0, 5,		/* M */
+				 BIT(31),	/* gate */
+				 0);
+static SUNXI_CCU_M_WITH_GATE(gpadc1_clk, "gpadc1", "hosc", 0x9e4,
+				 0, 5,		/* M */
+				 BIT(31),	/* gate */
+				 0);
+
 static const struct clk_parent_data losc_hosc_parents[] = {
 	{ .fw_name = "hosc" },
 	{ .fw_name = "losc" },
@@ -693,6 +823,21 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 	&hstimer5_clk.common,
 	&iommu_clk.common,
 	&dram_clk.common,
+	&nand0_clk.common,
+	&nand1_clk.common,
+	&mmc0_clk.common,
+	&mmc1_clk.common,
+	&mmc2_clk.common,
+	&spi0_clk.common,
+	&spi1_clk.common,
+	&spi2_clk.common,
+	&spifc_clk.common,
+	&emac0_25M_clk.common,
+	&emac1_25M_clk.common,
+	&ir_rx_clk.common,
+	&ir_tx_clk.common,
+	&gpadc0_clk.common,
+	&gpadc1_clk.common,
 	&pcie_aux_clk.common,
 	&hdmi_24M_clk.common,
 	&hdmi_cec_32k_clk.common,
@@ -767,6 +912,21 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_HSTIMER5]		= &hstimer5_clk.common.hw,
 		[CLK_IOMMU]		= &iommu_clk.common.hw,
 		[CLK_DRAM]		= &dram_clk.common.hw,
+		[CLK_NAND0]		= &nand0_clk.common.hw,
+		[CLK_NAND1]		= &nand1_clk.common.hw,
+		[CLK_MMC0]		= &mmc0_clk.common.hw,
+		[CLK_MMC1]		= &mmc1_clk.common.hw,
+		[CLK_MMC2]		= &mmc2_clk.common.hw,
+		[CLK_SPI0]		= &spi0_clk.common.hw,
+		[CLK_SPI1]		= &spi1_clk.common.hw,
+		[CLK_SPI2]		= &spi2_clk.common.hw,
+		[CLK_SPIFC]		= &spifc_clk.common.hw,
+		[CLK_EMAC0_25M]		= &emac0_25M_clk.common.hw,
+		[CLK_EMAC1_25M]		= &emac1_25M_clk.common.hw,
+		[CLK_IR_RX]		= &ir_rx_clk.common.hw,
+		[CLK_IR_TX]		= &ir_tx_clk.common.hw,
+		[CLK_GPADC0]		= &gpadc0_clk.common.hw,
+		[CLK_GPADC1]		= &gpadc1_clk.common.hw,
 		[CLK_PCIE_AUX]		= &pcie_aux_clk.common.hw,
 		[CLK_HDMI_24M]		= &hdmi_24M_clk.common.hw,
 		[CLK_HDMI_CEC_32K]	= &hdmi_cec_32k_clk.common.hw,
-- 
2.46.3


