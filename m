Return-Path: <linux-kernel+bounces-514970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9725A35E27
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11E51887422
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0F22673A6;
	Fri, 14 Feb 2025 12:56:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F99267388;
	Fri, 14 Feb 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537789; cv=none; b=PI9bv2h19P4m/VJAqoUU2pfmHPyrR/mb7Z6bGyjqq6cGvleADs6BKuRMHzxI2G4P9PQf54SdLo9zF+C6DedHxq9Whca3NKuny0XukW/iW32MX74ppf++Odhuz0J3JbFA13dEmNzUtnJqdeROXZxaUjZCzvUQOm8ijmcfhufmyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537789; c=relaxed/simple;
	bh=e9mtbUari8qdvIIR1EZNAqPnIREw44h1HFg/WiCrmXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxHmIYfDLLcwDl2hAwKzn7cvoS+JcaC7G4d1HPuM9H1YcSoM6tMGk6q3P7mZqq8M7nB1Df027GKmxHGUA1RKj42/3OT2B+pZR8R7ApD6ZnyAF582RPPXOZQD1bJY4FWafjZA/NfGbxj2x9w3vV1eDhxjdPWkT6Rbionrb05zZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33B5927D3;
	Fri, 14 Feb 2025 04:56:47 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F37433F58B;
	Fri, 14 Feb 2025 04:56:24 -0800 (PST)
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
Subject: [PATCH v2 11/15] clk: sunxi-ng: a523: remaining mod clocks
Date: Fri, 14 Feb 2025 12:53:55 +0000
Message-ID: <20250214125359.5204-12-andre.przywara@arm.com>
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

Add the remaining mod clocks, driving various parts of the SoC: the "LEDC"
LED controller, the "CSI" camera interface, the "ISP" image processor,
the DSP clock, and the "fanout" clocks, which allow to put clock signals
on external pins.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 190 +++++++++++++++++++++++++
 1 file changed, 190 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 59cc31f89ae77..6a4340f1fd041 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -354,6 +354,7 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ahb_apb0_parents, 0x520,
 				 0, 5,		/* M */
 				 24, 2,	/* mux */
 				 0);
+static const struct clk_hw *apb0_hws[] = { &apb0_clk.common.hw };
 
 static const struct clk_parent_data apb1_parents[] = {
 	{ .fw_name = "hosc" },
@@ -832,6 +833,153 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_clk, "edp", edp_parents, 0xbb0,
 				    BIT(31),	/* gate */
 				    0);
 
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ir_tx_ledc_parents,
+				      0xbf0,
+				      0, 4,	/* M */
+				      24, 1,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_hw *csi_top_parents[] = {
+	&pll_periph0_300M_clk.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_periph0_480M_clk.common.hw,
+	&pll_video3_4x_clk.common.hw,
+	&pll_video3_3x_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(csi_top_clk, "csi-top", csi_top_parents,
+				    0xc04,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_parent_data csi_mclk_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .hw = &pll_video3_4x_clk.common.hw },
+	{ .hw = &pll_video0_4x_clk.common.hw },
+	{ .hw = &pll_video1_4x_clk.common.hw },
+	{ .hw = &pll_video2_4x_clk.common.hw },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk0_clk, "csi-mclk0",
+				       csi_mclk_parents, 0xc08,
+				       0, 5,	/* M */
+				       8, 5,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk1_clk, "csi-mclk1",
+				       csi_mclk_parents, 0xc0c,
+				       0, 5,	/* M */
+				       8, 5,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk2_clk, "csi-mclk2",
+				       csi_mclk_parents, 0xc10,
+				       0, 5,	/* M */
+				       8, 5,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk3_clk, "csi-mclk3",
+				       csi_mclk_parents, 0xc14,
+				       0, 5,	/* M */
+				       8, 5,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static const struct clk_hw *isp_parents[] = {
+	&pll_periph0_300M_clk.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_video2_4x_clk.common.hw,
+	&pll_video3_4x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(isp_clk, "isp", isp_parents, 0xc20,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_parent_data dsp_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_2x_clk.common.hw },
+	{ .hw = &pll_periph0_400M_clk.hw, },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(dsp_clk, "dsp", dsp_parents, 0xc70,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static SUNXI_CCU_GATE_DATA(fanout_24M_clk, "fanout-24M", osc24M,
+			   0xf30, BIT(0), 0);
+static SUNXI_CCU_GATE_DATA_WITH_PREDIV(fanout_12M_clk, "fanout-12M", osc24M,
+				       0xf30, BIT(1), 2, 0);
+static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_16M_clk, "fanout-16M",
+				      pll_periph0_480M_hws,
+				      0xf30, BIT(2), 30, 0);
+static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_25M_clk, "fanout-25M",
+				      pll_periph0_2x_hws,
+				      0xf30, BIT(3), 48, 0);
+static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_50M_clk, "fanout-50M",
+				      pll_periph0_2x_hws,
+				      0xf30, BIT(4), 24, 0);
+
+/* These clocks have a second divider that is not modelled and forced to 0. */
+#define SUN55I_A523_FANOUT_27M_REG	0xf34
+static const struct clk_hw *fanout_27M_parents[] = {
+	&pll_video0_4x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+	&pll_video2_4x_clk.common.hw,
+	&pll_video3_4x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(fanout_27M_clk, "fanout-27M",
+				    fanout_27M_parents, 0xf34,
+				    0, 5,	/* M */
+				    24, 2,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+#define SUN55I_A523_FANOUT_PCLK_REG	0xf38
+static SUNXI_CCU_M_HWS_WITH_GATE(fanout_pclk_clk, "fanout-pclk", apb0_hws,
+				 0xf38,
+				 0, 5,		/* M */
+				 BIT(31),	/* gate */
+				 0);
+
+static const struct clk_parent_data fanout_parents[] = {
+	{ .fw_name = "osc32k-out" },
+	{ .hw = &fanout_12M_clk.common.hw, },
+	{ .hw = &fanout_16M_clk.common.hw, },
+	{ .hw = &fanout_24M_clk.common.hw, },
+	{ .hw = &fanout_25M_clk.common.hw, },
+	{ .hw = &fanout_27M_clk.common.hw, },
+	{ .hw = &fanout_pclk_clk.common.hw, },
+	{ .hw = &fanout_50M_clk.common.hw, },
+};
+static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout0_clk, "fanout0", fanout_parents,
+				    0xf3c,
+				    0, 3,	/* mux */
+				    BIT(21),	/* gate */
+				    0);
+static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout1_clk, "fanout1", fanout_parents,
+				    0xf3c,
+				    3, 3,	/* mux */
+				    BIT(22),	/* gate */
+				    0);
+static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout2_clk, "fanout2", fanout_parents,
+				    0xf3c,
+				    6, 3,	/* mux */
+				    BIT(23),	/* gate */
+				    0);
+
 /*
  * Contains all clocks that are controlled by a hardware register. They
  * have a (sunxi) .common member, which needs to be initialised by the common
@@ -904,6 +1052,23 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 	&tcon_tv0_clk.common,
 	&tcon_tv1_clk.common,
 	&edp_clk.common,
+	&ledc_clk.common,
+	&csi_top_clk.common,
+	&csi_mclk0_clk.common,
+	&csi_mclk1_clk.common,
+	&csi_mclk2_clk.common,
+	&csi_mclk3_clk.common,
+	&isp_clk.common,
+	&dsp_clk.common,
+	&fanout_24M_clk.common,
+	&fanout_12M_clk.common,
+	&fanout_16M_clk.common,
+	&fanout_25M_clk.common,
+	&fanout_27M_clk.common,
+	&fanout_pclk_clk.common,
+	&fanout0_clk.common,
+	&fanout1_clk.common,
+	&fanout2_clk.common,
 };
 
 static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
@@ -997,6 +1162,23 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_TCON_TV0]		= &tcon_tv0_clk.common.hw,
 		[CLK_TCON_TV1]		= &tcon_tv1_clk.common.hw,
 		[CLK_EDP]		= &edp_clk.common.hw,
+		[CLK_LEDC]		= &ledc_clk.common.hw,
+		[CLK_CSI_TOP]		= &csi_top_clk.common.hw,
+		[CLK_CSI_MCLK0]		= &csi_mclk0_clk.common.hw,
+		[CLK_CSI_MCLK1]		= &csi_mclk1_clk.common.hw,
+		[CLK_CSI_MCLK2]		= &csi_mclk2_clk.common.hw,
+		[CLK_CSI_MCLK3]		= &csi_mclk3_clk.common.hw,
+		[CLK_ISP]		= &isp_clk.common.hw,
+		[CLK_DSP]		= &dsp_clk.common.hw,
+		[CLK_FANOUT_24M]	= &fanout_24M_clk.common.hw,
+		[CLK_FANOUT_12M]	= &fanout_12M_clk.common.hw,
+		[CLK_FANOUT_16M]	= &fanout_16M_clk.common.hw,
+		[CLK_FANOUT_25M]	= &fanout_25M_clk.common.hw,
+		[CLK_FANOUT_27M]	= &fanout_27M_clk.common.hw,
+		[CLK_FANOUT_PCLK]	= &fanout_pclk_clk.common.hw,
+		[CLK_FANOUT0]		= &fanout0_clk.common.hw,
+		[CLK_FANOUT1]		= &fanout1_clk.common.hw,
+		[CLK_FANOUT2]		= &fanout2_clk.common.hw,
 	},
 };
 
@@ -1048,6 +1230,14 @@ static int sun55i_a523_ccu_probe(struct platform_device *pdev)
 	val &= ~(BIT(1) | BIT(0));
 	writel(val, reg + SUN55I_A523_PLL_AUDIO0_REG);
 
+	/* Force fanout factors N to 0. */
+	val = readl(reg + SUN55I_A523_FANOUT_27M_REG);
+	val &= ~GENMASK(12, 8);
+	writel(val, reg + SUN55I_A523_FANOUT_27M_REG);
+	val = readl(reg + SUN55I_A523_FANOUT_PCLK_REG);
+	val &= ~GENMASK(9, 5);
+	writel(val, reg + SUN55I_A523_FANOUT_PCLK_REG);
+
 	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun55i_a523_ccu_desc);
 	if (ret)
 		return ret;
-- 
2.46.3


