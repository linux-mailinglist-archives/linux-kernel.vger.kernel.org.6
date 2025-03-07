Return-Path: <linux-kernel+bounces-550153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F386A55BEB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBCB188BC52
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E81310A1F;
	Fri,  7 Mar 2025 00:26:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBECE183CA6;
	Fri,  7 Mar 2025 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307215; cv=none; b=UZE7WMio8pREpF4x1CyJLeOYxaKxLjy0ZjECwlBKoKik4iaRbkyABjiuiVCXbXeBNTeNImTCp9YFve0RPy3/HEfZ+4A61UEJn3FDYRXv3qnQTvuEJ70YfFK4cQ8AZRFBbrmUngVMgF+dPc0GWR5cgm+lT0lA4WgN8sFnAlIff9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307215; c=relaxed/simple;
	bh=Ibk91gtQt/XrzkDKKDOyXQrAhb8QjmODf1tdE+oH1lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s0ucqNn9BepaOxF/W0+PUTxdJIYBdrKSPt5B8LoSBchcJBDpv0v8AfXiBsMCjKGMJ8BRw57gKz7jf42/N8lqall6pxSlk6owXBCH51DSmeldLSO2/SsxLdrNbSOWKXbclo6KJtMzsdfMwygUdTK4XYLSpxvg4reN7MEYpDYunRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09B3A169E;
	Thu,  6 Mar 2025 16:27:05 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AAC63F673;
	Thu,  6 Mar 2025 16:26:50 -0800 (PST)
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
Subject: [PATCH v4 08/14] clk: sunxi-ng: a523: add system mod clocks
Date: Fri,  7 Mar 2025 00:26:22 +0000
Message-ID: <20250307002628.10684-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250307002628.10684-1-andre.przywara@arm.com>
References: <20250307002628.10684-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the clocks driving some core system related subsystems of the SoC:
the "CE" crypto engine, the high speed timers, the DRAM and the associated
MBUS clock, and the PCIe clock.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 135 +++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 17a4ffc0b7f52..c59f3f789d052 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -364,6 +364,21 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", apb1_parents, 0x524,
 				 24, 3,		/* mux */
 				 0);
 
+static const struct clk_parent_data mbus_parents[] = {
+	{ .hw = &pll_ddr_clk.common.hw },
+	{ .hw = &pll_periph1_600M_clk.hw },
+	{ .hw = &pll_periph1_480M_clk.common.hw },
+	{ .hw = &pll_periph1_400M_clk.hw },
+	{ .hw = &pll_periph1_150M_clk.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(mbus_clk, "mbus", mbus_parents,
+					    0x540,
+					    0, 5,		/* M */
+					    0, 0,		/* no P */
+					    24, 3,	/* mux */
+					    BIT(31),	/* gate */
+					    0, CCU_FEATURE_UPDATE_BIT);
 
 /**************************************************************************
  *                          mod clocks                                    *
@@ -423,6 +438,18 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
 
+static const struct clk_parent_data ce_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+	{ .hw = &pll_periph0_400M_clk.hw },
+	{ .hw = &pll_periph0_300M_clk.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x680,
+				       0, 5,	/* M */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
 static const struct clk_hw *ve_parents[] = {
 	&pll_ve_clk.common.hw,
 	&pll_periph0_480M_clk.common.hw,
@@ -435,6 +462,65 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
 
+static const struct clk_parent_data hstimer_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "iosc" },
+	{ .fw_name = "losc" },
+	{ .hw = &pll_periph0_200M_clk.hw },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer0_clk, "hstimer0",
+				       hstimer_parents, 0x730,
+				       0, 0,	/* M */
+				       0, 3,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer1_clk, "hstimer1",
+				       hstimer_parents,
+				       0x734,
+				       0, 0,	/* M */
+				       0, 3,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer2_clk, "hstimer2",
+				       hstimer_parents,
+				       0x738,
+				       0, 0,	/* M */
+				       0, 3,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer3_clk, "hstimer3",
+				       hstimer_parents,
+				       0x73c,
+				       0, 0,	/* M */
+				       0, 3,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer4_clk, "hstimer4",
+				       hstimer_parents,
+				       0x740,
+				       0, 0,	/* M */
+				       0, 3,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer5_clk, "hstimer5",
+				       hstimer_parents,
+				       0x744,
+				       0, 0,	/* M */
+				       0, 3,	/* P */
+				       24, 3,	/* mux */
+				       BIT(31),	/* gate */
+				       0);
+
 static const struct clk_parent_data iommu_parents[] = {
 	{ .hw = &pll_periph0_600M_clk.hw },
 	{ .hw = &pll_ddr_clk.common.hw },
@@ -453,6 +539,34 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(iommu_clk, "iommu", iommu_parents,
 					    CLK_SET_RATE_PARENT,
 					    CCU_FEATURE_UPDATE_BIT);
 
+static const struct clk_parent_data dram_parents[] = {
+	{ .hw = &pll_ddr_clk.common.hw },
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+	{ .hw = &pll_periph0_400M_clk.hw },
+	{ .hw = &pll_periph0_150M_clk.hw },
+};
+static SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(dram_clk, "dram", dram_parents,
+					    0x800,
+					    0, 5,	/* M */
+					    0, 0,	/* no P */
+					    24, 3,	/* mux */
+					    BIT(31),	/* gate */
+					    CLK_IS_CRITICAL,
+					    CCU_FEATURE_UPDATE_BIT);
+
+static const struct clk_parent_data losc_hosc_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(pcie_aux_clk, "pcie-aux",
+				      losc_hosc_parents, 0xaa0,
+				      0, 5,	/* M */
+				      24, 1,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
 static SUNXI_CCU_GATE_DATA(hdmi_24M_clk, "hdmi-24M", osc24M, 0xb04, BIT(31), 0);
 
 static SUNXI_CCU_GATE_HWS_WITH_PREDIV(hdmi_cec_32k_clk, "hdmi-cec-32k",
@@ -596,12 +710,22 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 	&ahb_clk.common,
 	&apb0_clk.common,
 	&apb1_clk.common,
+	&mbus_clk.common,
 	&de_clk.common,
 	&di_clk.common,
 	&g2d_clk.common,
 	&gpu_clk.common,
+	&ce_clk.common,
 	&ve_clk.common,
+	&hstimer0_clk.common,
+	&hstimer1_clk.common,
+	&hstimer2_clk.common,
+	&hstimer3_clk.common,
+	&hstimer4_clk.common,
+	&hstimer5_clk.common,
 	&iommu_clk.common,
+	&dram_clk.common,
+	&pcie_aux_clk.common,
 	&hdmi_24M_clk.common,
 	&hdmi_cec_32k_clk.common,
 	&hdmi_cec_clk.common,
@@ -662,11 +786,22 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_AHB]		= &ahb_clk.common.hw,
 		[CLK_APB0]		= &apb0_clk.common.hw,
 		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_MBUS]		= &mbus_clk.common.hw,
 		[CLK_DE]		= &de_clk.common.hw,
 		[CLK_DI]		= &di_clk.common.hw,
 		[CLK_G2D]		= &g2d_clk.common.hw,
 		[CLK_GPU]		= &gpu_clk.common.hw,
+		[CLK_CE]		= &ce_clk.common.hw,
 		[CLK_VE]		= &ve_clk.common.hw,
+		[CLK_HSTIMER0]		= &hstimer0_clk.common.hw,
+		[CLK_HSTIMER1]		= &hstimer1_clk.common.hw,
+		[CLK_HSTIMER2]		= &hstimer2_clk.common.hw,
+		[CLK_HSTIMER3]		= &hstimer3_clk.common.hw,
+		[CLK_HSTIMER4]		= &hstimer4_clk.common.hw,
+		[CLK_HSTIMER5]		= &hstimer5_clk.common.hw,
+		[CLK_IOMMU]		= &iommu_clk.common.hw,
+		[CLK_DRAM]		= &dram_clk.common.hw,
+		[CLK_PCIE_AUX]		= &pcie_aux_clk.common.hw,
 		[CLK_HDMI_24M]		= &hdmi_24M_clk.common.hw,
 		[CLK_HDMI_CEC_32K]	= &hdmi_cec_32k_clk.common.hw,
 		[CLK_HDMI_CEC]		= &hdmi_cec_clk.common.hw,
-- 
2.46.3


