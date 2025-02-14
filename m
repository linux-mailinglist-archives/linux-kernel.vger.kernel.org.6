Return-Path: <linux-kernel+bounces-514966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F755A35E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BB0172332
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C9626659A;
	Fri, 14 Feb 2025 12:56:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24D226656C;
	Fri, 14 Feb 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537780; cv=none; b=dZR6twJLkXll5tXq5ApZzENayU4UZPAYiiOkfuj3kKaMQxqNv7Q0r5mQ0k1Zt0rZCiQynNiUo8UrUV42/TIPq/vYI1XqzQ5HMlOAjv49BoeyEKLM5EdXbFBNqLBfyY+UqsgpJRkeB84OpyCtrOYsm2ozOo2LfElzk6dct/WFcnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537780; c=relaxed/simple;
	bh=5yt2rjaZZAx2isvJ0kL3FadII8RRCwYoU3aZ/KPoUYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbEiG35w987KUPGmlEnZcKBotEOyCLVAfD3dY+haBLGPYlqLR8ninj6GlfuQOcdERpd3+aERvvsOQSzWf9uWmu/d4q5QRodVFo7wK4KK3UXjuBwr+GiCIEYQF8TZk6o0vHVDVoQJZGvz3+nCSUuSgyyj/xSiAXn7IL4j/FaMeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5529113E;
	Fri, 14 Feb 2025 04:56:38 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E93C3F58B;
	Fri, 14 Feb 2025 04:56:16 -0800 (PST)
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
Subject: [PATCH v2 07/15] clk: sunxi-ng: a523: add video mod clocks
Date: Fri, 14 Feb 2025 12:53:51 +0000
Message-ID: <20250214125359.5204-8-andre.przywara@arm.com>
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

Add the clocks driving the various video subsystems of the SoC: the "DE"
display engine, the "DI" deinterlacer, the "G2D" 2D graphics system, the
Mali "GPU", the "VE" video engine, its associated IOMMU, as well as the
clocks for the various video output drivers (HDMI, DP, LCDs).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 219 +++++++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 59f45e7c0904b..0ef1fd71a1ca5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -364,6 +364,192 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", apb1_parents, 0x524,
 				 24, 3,		/* mux */
 				 0);
 
+
+/**************************************************************************
+ *                          mod clocks                                    *
+ **************************************************************************/
+
+static const struct clk_hw *de_parents[] = {
+	&pll_periph0_300M_clk.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_video3_4x_clk.common.hw,
+	&pll_video3_3x_clk.hw,
+};
+
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(de_clk, "de", de_parents, 0x600,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *di_parents[] = {
+	&pll_periph0_300M_clk.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_video0_4x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+};
+
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(di_clk, "di", di_parents, 0x620,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *g2d_parents[] = {
+	&pll_periph0_400M_clk.hw,
+	&pll_periph0_300M_clk.hw,
+	&pll_video0_4x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+};
+
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(g2d_clk, "g2d", g2d_parents, 0x630,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *gpu_parents[] = {
+	&pll_gpu_clk.common.hw,
+	&pll_periph0_800M_clk.common.hw,
+	&pll_periph0_600M_clk.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_periph0_300M_clk.hw,
+	&pll_periph0_200M_clk.hw,
+};
+
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
+				    0, 4,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *ve_parents[] = {
+	&pll_ve_clk.common.hw,
+	&pll_periph0_480M_clk.common.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_periph0_300M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_parent_data iommu_parents[] = {
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .hw = &pll_ddr0_clk.common.hw },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+	{ .hw = &pll_periph0_400M_clk.hw },
+	{ .hw = &pll_periph0_150M_clk.hw },
+	{ .fw_name = "hosc" },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(iommu_clk, "iommu", iommu_parents, 0x7b0,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_GATE_DATA(hdmi_24M_clk, "hdmi-24M", osc24M, 0xb04, BIT(31), 0);
+
+/* TODO: add mux between 32kOSC and PERIPH0/18750 */
+static SUNXI_CCU_GATE_HWS_WITH_PREDIV(hdmi_cec_32k_clk, "hdmi-cec-32k",
+				      pll_periph0_2x_hws,
+				      0xb10, BIT(30), 36621, 0);
+
+static const struct clk_parent_data hdmi_cec_parents[] = {
+	{ .fw_name = "losc" },
+	{ .hw = &hdmi_cec_32k_clk.common.hw },
+};
+static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_cec_clk, "hdmi-cec", hdmi_cec_parents,
+				    0xb10,
+				    24, 1,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_parent_data mipi_dsi_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .hw = &pll_periph0_200M_clk.hw },
+	{ .hw = &pll_periph0_150M_clk.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(mipi_dsi0_clk, "mipi-dsi0",
+				      mipi_dsi_parents, 0xb24,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(mipi_dsi1_clk, "mipi-dsi1",
+				      mipi_dsi_parents, 0xb28,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *tcon_parents[] = {
+	&pll_video0_4x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+	&pll_video2_4x_clk.common.hw,
+	&pll_video3_4x_clk.common.hw,
+	&pll_periph0_2x_clk.common.hw,
+	&pll_video0_3x_clk.hw,
+	&pll_video1_3x_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd0_clk, "tcon-lcd0", tcon_parents,
+				    0xb60,
+				    0,  5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd1_clk, "tcon-lcd1", tcon_parents,
+				    0xb64,
+				    0,  5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(combophy_dsi0_clk, "combophy-dsi0",
+				    tcon_parents, 0xb6c,
+				    0,  5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(combophy_dsi1_clk, "combophy-dsi1",
+				    tcon_parents, 0xb70,
+				    0,  5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_tv0_clk, "tcon-tv0", tcon_parents,
+				    0xb80,
+				    0, 4,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_tv1_clk, "tcon-tv1", tcon_parents,
+				    0xb84,
+				    0, 4,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *edp_parents[] = {
+	&pll_video0_4x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+	&pll_video2_4x_clk.common.hw,
+	&pll_video3_4x_clk.common.hw,
+	&pll_periph0_2x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_clk, "edp", edp_parents, 0xbb0,
+				    0, 4,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
 /*
  * Contains all clocks that are controlled by a hardware register. They
  * have a (sunxi) .common member, which needs to be initialised by the common
@@ -394,6 +580,22 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 	&ahb_clk.common,
 	&apb0_clk.common,
 	&apb1_clk.common,
+	&de_clk.common,
+	&di_clk.common,
+	&g2d_clk.common,
+	&gpu_clk.common,
+	&ve_clk.common,
+	&iommu_clk.common,
+	&hdmi_24M_clk.common,
+	&hdmi_cec_32k_clk.common,
+	&hdmi_cec_clk.common,
+	&mipi_dsi0_clk.common,
+	&mipi_dsi1_clk.common,
+	&tcon_lcd0_clk.common,
+	&tcon_lcd1_clk.common,
+	&tcon_tv0_clk.common,
+	&tcon_tv1_clk.common,
+	&edp_clk.common,
 };
 
 static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
@@ -442,6 +644,23 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_AHB]		= &ahb_clk.common.hw,
 		[CLK_APB0]		= &apb0_clk.common.hw,
 		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_DE]		= &de_clk.common.hw,
+		[CLK_DI]		= &di_clk.common.hw,
+		[CLK_G2D]		= &g2d_clk.common.hw,
+		[CLK_GPU]		= &gpu_clk.common.hw,
+		[CLK_VE]		= &ve_clk.common.hw,
+		[CLK_HDMI_24M]		= &hdmi_24M_clk.common.hw,
+		[CLK_HDMI_CEC_32K]	= &hdmi_cec_32k_clk.common.hw,
+		[CLK_HDMI_CEC]		= &hdmi_cec_clk.common.hw,
+		[CLK_MIPI_DSI0]		= &mipi_dsi0_clk.common.hw,
+		[CLK_MIPI_DSI1]		= &mipi_dsi1_clk.common.hw,
+		[CLK_TCON_LCD0]		= &tcon_lcd0_clk.common.hw,
+		[CLK_TCON_LCD1]		= &tcon_lcd1_clk.common.hw,
+		[CLK_COMBOPHY_DSI0]	= &combophy_dsi0_clk.common.hw,
+		[CLK_COMBOPHY_DSI1]	= &combophy_dsi1_clk.common.hw,
+		[CLK_TCON_TV0]		= &tcon_tv0_clk.common.hw,
+		[CLK_TCON_TV1]		= &tcon_tv1_clk.common.hw,
+		[CLK_EDP]		= &edp_clk.common.hw,
 	},
 };
 
-- 
2.46.3


