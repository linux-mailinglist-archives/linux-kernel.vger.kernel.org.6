Return-Path: <linux-kernel+bounces-543050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76207A4D0EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D4F176BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFE514F121;
	Tue,  4 Mar 2025 01:31:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F801F37C3;
	Tue,  4 Mar 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051861; cv=none; b=LIN0boUlE0EfVOaP4ecgidQOYLIF1tusIkAW+XltZRvgTN5yQ+TAjGbB4X7hs2UPvWmGMnhcHRzRO3aAc4JwRFRwelzMgHcpfohirXbAAq6VcdbGS7pohm5QKcLqZiNtK4RaZhvDB8jfSEzdzzfUXqgb920ROQZ4d517KeQCYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051861; c=relaxed/simple;
	bh=AlP7WpdAB6AJvcZIQ2zvJ0bMKW8XOabbeR8BoF73JWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kk27dioJ+gTSf/S/Uw7Zj+p4pHy0GE+0IKm07mczS+64ROZwP1looLL1jMZhKAUibK7zplsLo/fldo3inbLvXavgTpqIryWi1jPkL2JsVTeHraVRZF4PzBeJGkl/6+TuTkqPx9uYuYsoWl6zo0kN26+pKDNDos4WhOshzM6++Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC434FEC;
	Mon,  3 Mar 2025 17:31:12 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAA733F673;
	Mon,  3 Mar 2025 17:30:56 -0800 (PST)
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
Subject: [PATCH v3 12/15] clk: sunxi-ng: a523: remaining mod clocks
Date: Tue,  4 Mar 2025 01:28:02 +0000
Message-ID: <20250304012805.28594-13-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250304012805.28594-1-andre.przywara@arm.com>
References: <20250304012805.28594-1-andre.przywara@arm.com>
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
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 185 +++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 573c9885110a1..12cdd623a3851 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -862,6 +862,157 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_clk, "edp", edp_parents, 0xbb0,
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
 
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
+static SUNXI_CCU_DUALDIV_MUX_GATE(csi_mclk0_clk, "csi-mclk0", csi_mclk_parents,
+				  0xc08,
+				  0, 5,		/* M */
+				  8, 5,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_DUALDIV_MUX_GATE(csi_mclk1_clk, "csi-mclk1", csi_mclk_parents,
+				  0xc0c,
+				  0, 5,		/* M */
+				  8, 5,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_DUALDIV_MUX_GATE(csi_mclk2_clk, "csi-mclk2", csi_mclk_parents,
+				  0xc10,
+				  0, 5,		/* M */
+				  8, 5,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static SUNXI_CCU_DUALDIV_MUX_GATE(csi_mclk3_clk, "csi-mclk3", csi_mclk_parents,
+				  0xc14,
+				  0, 5,		/* M */
+				  8, 5,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
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
+	{ .hw = &pll_periph0_480M_clk.common.hw, },
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
+static const struct clk_parent_data fanout_27M_parents[] = {
+	{ .hw = &pll_video0_4x_clk.common.hw },
+	{ .hw = &pll_video1_4x_clk.common.hw },
+	{ .hw = &pll_video2_4x_clk.common.hw },
+	{ .hw = &pll_video3_4x_clk.common.hw },
+};
+static SUNXI_CCU_DUALDIV_MUX_GATE(fanout_27M_clk, "fanout-27M",
+				  fanout_27M_parents, 0xf34,
+				  0, 5,		/* div0 */
+				  8, 5,		/* div1 */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const struct clk_parent_data fanout_pclk_parents[] = {
+	{ .hw = &apb0_clk.common.hw }
+};
+static SUNXI_CCU_DUALDIV_MUX_GATE(fanout_pclk_clk, "fanout-pclk",
+				  fanout_pclk_parents,
+				  0xf38,
+				  0, 5,		/* div0 */
+				  5, 5,		/* div1 */
+				  0, 0,		/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const struct clk_parent_data fanout_parents[] = {
+	{ .fw_name = "losc-fanout" },
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
@@ -936,6 +1087,23 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
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
@@ -1031,6 +1199,23 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
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
 
-- 
2.46.3


