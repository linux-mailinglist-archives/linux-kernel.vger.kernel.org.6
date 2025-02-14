Return-Path: <linux-kernel+bounces-514971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32197A35E23
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1CC3B1AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB39264A7A;
	Fri, 14 Feb 2025 12:56:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452E226738C;
	Fri, 14 Feb 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537791; cv=none; b=EKcdbevbeC1Z0m7bIVwAuItf6ShMcTHOynJQaDJeZDArBqcze9MKC59bBJLb1xyJS8/AiRhc/UIr2/iElX+vf0YrTqmsDStd5vTMms2U8sjQ+nSuOZ5vSoysRlmzEty/mr86pQPXrVOYoN7EYVKvwGzxHcoG5HroLLtAm+MpWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537791; c=relaxed/simple;
	bh=0TGt3NG+ZCCb9UPl8Z2Rwxp/4HkuXGOcWiY0OPSjgaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ojqE23SAGFvqchFLZU9mgwlnTRjYqGXVxhrlB28oosuD8Eapjd2EEAfcDFMaj9NIEEM8g/CPXJVkV5pjIE8fV0exh6bt4fvw0pWcVBijBm/mCogVjCw8n4gbQ+7lqRIPa7qqI+Jp5F+qaR6OmqQh4AeYeODTo5l9gXX2DZMBLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4387B113E;
	Fri, 14 Feb 2025 04:56:49 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1875C3F58B;
	Fri, 14 Feb 2025 04:56:26 -0800 (PST)
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
Subject: [PATCH v2 12/15] clk: sunxi-ng: a523: add bus clock gates
Date: Fri, 14 Feb 2025 12:53:56 +0000
Message-ID: <20250214125359.5204-13-andre.przywara@arm.com>
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

Add the various bus clock gates that control access to the devices'
register interface.
These clocks are each just one bit, typically the lower bits in some "BGR"
(Bus Gate / Reset) registers, for each device group: one for all UARTs,
one for all SPI interfaces, and so on.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 295 ++++++++++++++++++++++++-
 1 file changed, 294 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 6a4340f1fd041..fbed9b2b3b2f9 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -350,6 +350,8 @@ static SUNXI_CCU_M_DATA_WITH_MUX(ahb_clk, "ahb", ahb_apb0_parents, 0x510,
 				 0, 5,		/* M */
 				 24, 2,		/* mux */
 				 0);
+static const struct clk_hw *ahb_hws[] = { &ahb_clk.common.hw };
+
 static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ahb_apb0_parents, 0x520,
 				 0, 5,		/* M */
 				 24, 2,	/* mux */
@@ -367,10 +369,11 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", apb1_parents, 0x524,
 				 0, 5,		/* M */
 				 24, 3,		/* mux */
 				 0);
+static const struct clk_hw *apb1_hws[] = { &apb1_clk.common.hw };
 
 
 /**************************************************************************
- *                          mod clocks                                    *
+ *                          mod clocks with gates                         *
  **************************************************************************/
 
 static const struct clk_hw *de_parents[] = {
@@ -386,6 +389,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(de_clk, "de", de_parents, 0x600,
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE_HWS(bus_de_clk, "bus-de", ahb_hws, 0x60c, BIT(0), 0);
+
 static const struct clk_hw *di_parents[] = {
 	&pll_periph0_300M_clk.hw,
 	&pll_periph0_400M_clk.hw,
@@ -399,6 +404,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(di_clk, "di", di_parents, 0x620,
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE_HWS(bus_di_clk, "bus-di", ahb_hws, 0x62c, BIT(0), 0);
+
 static const struct clk_hw *g2d_parents[] = {
 	&pll_periph0_400M_clk.hw,
 	&pll_periph0_300M_clk.hw,
@@ -412,6 +419,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(g2d_clk, "g2d", g2d_parents, 0x630,
 				    BIT(31),	/* gate */
 				    0);
 
+static SUNXI_CCU_GATE_HWS(bus_g2d_clk, "bus-g2d", ahb_hws, 0x63c, BIT(0), 0);
+
 static const struct clk_hw *gpu_parents[] = {
 	&pll_gpu_clk.common.hw,
 	&pll_periph0_800M_clk.common.hw,
@@ -427,6 +436,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
 				    BIT(31),	/* gate */
 				    0);
 
+static SUNXI_CCU_GATE_HWS(bus_gpu_clk, "bus-gpu", ahb_hws, 0x67c, BIT(0), 0);
+
 static const struct clk_parent_data ce_parents[] = {
 	{ .fw_name = "hosc" },
 	{ .hw = &pll_periph0_480M_clk.common.hw },
@@ -439,6 +450,10 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0x680,
 				       BIT(31),	/* gate */
 				       0);
 
+static SUNXI_CCU_GATE_HWS(bus_ce_clk, "bus-ce", ahb_hws, 0x68c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_ce_sys_clk, "bus-ce-sys", ahb_hws, 0x68c,
+			  BIT(1), 0);
+
 static const struct clk_hw *ve_parents[] = {
 	&pll_ve_clk.common.hw,
 	&pll_periph0_480M_clk.common.hw,
@@ -451,6 +466,16 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_clk, "ve", ve_parents, 0x690,
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE_HWS(bus_ve_clk, "bus-ve", ahb_hws, 0x69c, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_dma_clk, "bus-dma", ahb_hws, 0x70c, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_msgbox_clk, "bus-msgbox", ahb_hws, 0x71c,
+			  BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_spinlock_clk, "bus-spinlock", ahb_hws, 0x72c,
+			  BIT(0), 0);
+
 static const struct clk_parent_data hstimer_parents[] = {
 	{ .fw_name = "hosc" },
 	{ .fw_name = "iosc" },
@@ -510,6 +535,15 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(hstimer5_clk, "hstimer5",
 				       BIT(31),	/* gate */
 				       CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE_HWS(bus_hstimer_clk, "bus-hstimer", ahb_hws, 0x74c,
+			  BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_dbg_clk, "bus-dbg", ahb_hws, 0x78c,
+			  BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_pwm0_clk, "bus-pwm0", apb1_hws, 0x7ac, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_pwm1_clk, "bus-pwm1", apb1_hws, 0x7ac, BIT(1), 0);
+
 static const struct clk_parent_data iommu_parents[] = {
 	{ .hw = &pll_periph0_600M_clk.hw },
 	{ .hw = &pll_ddr0_clk.common.hw },
@@ -525,6 +559,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(iommu_clk, "iommu", iommu_parents, 0x7b0,
 				      BIT(31),	/* gate */
 				      CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE_HWS(bus_iommu_clk, "bus-iommu", apb0_hws, 0x7bc,
+			  BIT(0), 0);
+
 static const struct clk_hw *dram_parents[] = {
 	&pll_ddr0_clk.common.hw,
 	&pll_periph0_600M_clk.hw,
@@ -541,6 +578,22 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(dram_clk, "dram", dram_parents, 0x800,
 static CLK_FIXED_FACTOR_HW(mbus_clk, "mbus",
 			   &dram_clk.common.hw, 4, 1, 0);
 
+static SUNXI_CCU_GATE_HW(mbus_dma_clk, "mbus-dma", &mbus_clk.hw,
+			 0x804, BIT(0), 0);
+static SUNXI_CCU_GATE_HW(mbus_ve_clk, "mbus-ve", &mbus_clk.hw,
+			 0x804, BIT(1), 0);
+static SUNXI_CCU_GATE_HW(mbus_ce_clk, "mbus-ce", &mbus_clk.hw,
+			 0x804, BIT(2), 0);
+static SUNXI_CCU_GATE_HW(mbus_nand_clk, "mbus-nand", &mbus_clk.hw,
+			 0x804, BIT(5), 0);
+static SUNXI_CCU_GATE_HW(mbus_usb3_clk, "mbus-usb3", &mbus_clk.hw,
+			 0x804, BIT(6), 0);
+static SUNXI_CCU_GATE_HW(mbus_csi_clk, "mbus-csi", &mbus_clk.hw,
+			 0x804, BIT(8), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_dram_clk, "bus-dram", ahb_hws, 0x80c,
+			  BIT(0), CLK_IS_CRITICAL);
+
 static const struct clk_parent_data nand_mmc_parents[] = {
 	{ .fw_name = "hosc" },
 	{ .hw = &pll_periph0_400M_clk.hw },
@@ -563,6 +616,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand1_clk, "nand1", nand_mmc_parents,
 				    BIT(31),	/* gate */
 				    0);
 
+static SUNXI_CCU_GATE_HWS(bus_nand_clk, "bus-nand", ahb_hws, 0x82c,
+			  BIT(0), 0);
+
 static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc0_clk, "mmc0", nand_mmc_parents,
 					   0x830,
 					   0, 5,	/* M */
@@ -598,6 +654,39 @@ static SUNXI_CCU_MP_MUX_GATE_POSTDIV_FEAT(mmc2_clk, "mmc2", mmc2_parents,
 					   2,		/* post div */
 					   0, CCU_FEATURE_DUAL_DIV);
 
+static SUNXI_CCU_GATE_HWS(bus_mmc0_clk, "bus-mmc0", ahb_hws, 0x84c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_mmc1_clk, "bus-mmc1", ahb_hws, 0x84c, BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(bus_mmc2_clk, "bus-mmc2", ahb_hws, 0x84c, BIT(2), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_sysdap_clk, "bus-sysdap", apb1_hws, 0x88c,
+			  BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_uart0_clk, "bus-uart0", apb1_hws, 0x90c,
+			  BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart1_clk, "bus-uart1", apb1_hws, 0x90c,
+			  BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart2_clk, "bus-uart2", apb1_hws, 0x90c,
+			  BIT(2), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart3_clk, "bus-uart3", apb1_hws, 0x90c,
+			  BIT(3), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart4_clk, "bus-uart4", apb1_hws, 0x90c,
+			  BIT(4), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart5_clk, "bus-uart5", apb1_hws, 0x90c,
+			  BIT(5), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart6_clk, "bus-uart6", apb1_hws, 0x90c,
+			  BIT(6), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart7_clk, "bus-uart7", apb1_hws, 0x90c,
+			  BIT(7), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_i2c0_clk, "bus-i2c0", apb1_hws, 0x91c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c1_clk, "bus-i2c1", apb1_hws, 0x91c, BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c2_clk, "bus-i2c2", apb1_hws, 0x91c, BIT(2), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c3_clk, "bus-i2c3", apb1_hws, 0x91c, BIT(3), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c4_clk, "bus-i2c4", apb1_hws, 0x91c, BIT(4), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c5_clk, "bus-i2c5", apb1_hws, 0x91c, BIT(5), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_can_clk, "bus-can", apb1_hws, 0x92c, BIT(0), 0);
+
 static const struct clk_parent_data spi_parents[] = {
 	{ .fw_name = "hosc" },
 	{ .hw = &pll_periph0_300M_clk.hw },
@@ -630,6 +719,11 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(spifc_clk, "spifc", nand_mmc_parents,
 				       24, 3,	/* mux */
 				       BIT(31),	/* gate */
 				       0);
+static SUNXI_CCU_GATE_HWS(bus_spi0_clk, "bus-spi0", ahb_hws, 0x96c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_spi1_clk, "bus-spi1", ahb_hws, 0x96c, BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(bus_spi2_clk, "bus-spi2", ahb_hws, 0x96c, BIT(2), 0);
+static SUNXI_CCU_GATE_HWS(bus_spifc_clk, "bus-spifc", ahb_hws, 0x96c,
+			  BIT(3), 0);
 
 static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac0_25M_clk, "emac0-25M",
 				      pll_periph0_150M_hws,
@@ -637,6 +731,10 @@ static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac0_25M_clk, "emac0-25M",
 static SUNXI_CCU_GATE_HWS_WITH_PREDIV(emac1_25M_clk, "emac1-25M",
 				      pll_periph0_150M_hws,
 				      0x974, BIT(31) | BIT(30), 6, 0);
+static SUNXI_CCU_GATE_HWS(bus_emac0_clk, "bus-emac0", ahb_hws, 0x97c,
+			  BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_emac1_clk, "bus-emac1", ahb_hws, 0x98c,
+			  BIT(0), 0);
 
 static const struct clk_parent_data ir_rx_parents[] = {
 	{ .fw_name = "losc" },
@@ -648,6 +746,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ir_rx_clk, "ir-rx", ir_rx_parents, 0x990,
 				      24, 1,	/* mux */
 				      BIT(31),	/* gate */
 				      0);
+static SUNXI_CCU_GATE_HWS(bus_ir_rx_clk, "bus-ir-rx", apb0_hws, 0x99c,
+			  BIT(0), 0);
+
 static const struct clk_parent_data ir_tx_ledc_parents[] = {
 	{ .fw_name = "hosc" },
 	{ .hw = &pll_periph1_600M_clk.hw },
@@ -658,6 +759,8 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ir_tx_clk, "ir-tx", ir_tx_ledc_parents,
 				      24, 1,	/* mux */
 				      BIT(31),	/* gate */
 				      0);
+static SUNXI_CCU_GATE_HWS(bus_ir_tx_clk, "bus-ir-tx", apb0_hws, 0x9cc,
+			  BIT(0), 0);
 
 static SUNXI_CCU_M_WITH_GATE(gpadc0_clk, "gpadc0", "hosc", 0x9e0,
 				 0, 5,		/* M */
@@ -667,6 +770,12 @@ static SUNXI_CCU_M_WITH_GATE(gpadc1_clk, "gpadc1", "hosc", 0x9e4,
 				 0, 5,		/* M */
 				 BIT(31),	/* gate */
 				 0);
+static SUNXI_CCU_GATE_HWS(bus_gpadc0_clk, "bus-gpadc0", ahb_hws, 0x9ec,
+			  BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_gpadc1_clk, "bus-gpadc1", ahb_hws, 0x9ec,
+			  BIT(1), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_ths_clk, "bus-ths", apb0_hws, 0x9fc, BIT(0), 0);
 
 /*
  * The first parent is a 48 MHz input clock divided by 4. That 48 MHz clock is
@@ -720,6 +829,18 @@ static struct ccu_mux usb_ohci1_clk = {
 	},
 };
 
+static SUNXI_CCU_GATE_HWS(bus_ohci0_clk, "bus-ohci0", ahb_hws, 0xa8c,
+			  BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_ohci1_clk, "bus-ohci1", ahb_hws, 0xa8c,
+			  BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(bus_ehci0_clk, "bus-ehci0", ahb_hws, 0xa8c,
+			  BIT(4), 0);
+static SUNXI_CCU_GATE_HWS(bus_ehci1_clk, "bus-ehci1", ahb_hws, 0xa8c,
+			  BIT(5), 0);
+static SUNXI_CCU_GATE_HWS(bus_otg_clk, "bus-otg", ahb_hws, 0xa8c, BIT(8), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_lradc_clk, "bus-lradc", apb0_hws, 0xa9c,
+			  BIT(0), 0);
 
 static const struct clk_parent_data losc_hosc_parents[] = {
 	{ .fw_name = "hosc" },
@@ -733,6 +854,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(pcie_aux_clk, "pcie-aux",
 				      BIT(31),	/* gate */
 				      0);
 
+static SUNXI_CCU_GATE_HWS(bus_dpss_top_clk, "bus-dpss-top", ahb_hws, 0xabc,
+			  BIT(0), 0);
+
 static SUNXI_CCU_GATE_DATA(hdmi_24M_clk, "hdmi-24M", osc24M, 0xb04, BIT(31), 0);
 
 /* TODO: add mux between 32kOSC and PERIPH0/18750 */
@@ -750,6 +874,8 @@ static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_cec_clk, "hdmi-cec", hdmi_cec_parents,
 				    BIT(31),	/* gate */
 				    0);
 
+static SUNXI_CCU_GATE_HWS(bus_hdmi_clk, "bus-hdmi", ahb_hws, 0xb1c, BIT(0), 0);
+
 static const struct clk_parent_data mipi_dsi_parents[] = {
 	{ .fw_name = "hosc" },
 	{ .hw = &pll_periph0_200M_clk.hw },
@@ -769,6 +895,12 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(mipi_dsi1_clk, "mipi-dsi1",
 				      BIT(31),	/* gate */
 				      CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE_HWS(bus_mipi_dsi0_clk, "bus-mipi-dsi0", ahb_hws, 0xb4c,
+			  BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_mipi_dsi1_clk, "bus-mipi-dsi1", ahb_hws, 0xb4c,
+			  BIT(1), 0);
+
 static const struct clk_hw *tcon_parents[] = {
 	&pll_video0_4x_clk.common.hw,
 	&pll_video1_4x_clk.common.hw,
@@ -806,6 +938,11 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(combophy_dsi1_clk, "combophy-dsi1",
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE_HWS(bus_tcon_lcd0_clk, "bus-tcon-lcd0", ahb_hws, 0xb7c,
+			  BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_tcon_lcd1_clk, "bus-tcon-lcd1", ahb_hws, 0xb7c,
+			  BIT(1), 0);
+
 static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_tv0_clk, "tcon-tv0", tcon_parents,
 				    0xb80,
 				    0, 4,	/* M */
@@ -820,6 +957,11 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_tv1_clk, "tcon-tv1", tcon_parents,
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE_HWS(bus_tcon_tv0_clk, "bus-tcon-tv0", ahb_hws, 0xb9c,
+			  BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_tcon_tv1_clk, "bus-tcon-tv1", ahb_hws, 0xb9c,
+			  BIT(1), 0);
+
 static const struct clk_hw *edp_parents[] = {
 	&pll_video0_4x_clk.common.hw,
 	&pll_video1_4x_clk.common.hw,
@@ -833,6 +975,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_clk, "edp", edp_parents, 0xbb0,
 				    BIT(31),	/* gate */
 				    0);
 
+static SUNXI_CCU_GATE_HWS(bus_edp_clk, "bus-edp", ahb_hws, 0xbbc, BIT(0), 0);
+
 static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ir_tx_ledc_parents,
 				      0xbf0,
 				      0, 4,	/* M */
@@ -840,6 +984,8 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ir_tx_ledc_parents,
 				      BIT(31),	/* gate */
 				      0);
 
+static SUNXI_CCU_GATE_HWS(bus_ledc_clk, "bus-ledc", apb0_hws, 0xbfc, BIT(0), 0);
+
 static const struct clk_hw *csi_top_parents[] = {
 	&pll_periph0_300M_clk.hw,
 	&pll_periph0_400M_clk.hw,
@@ -893,6 +1039,8 @@ static SUNXI_CCU_MP_DATA_WITH_MUX_GATE(csi_mclk3_clk, "csi-mclk3",
 				       BIT(31),	/* gate */
 				       0);
 
+static SUNXI_CCU_GATE_HWS(bus_csi_clk, "bus-csi", ahb_hws, 0xc1c, BIT(0), 0);
+
 static const struct clk_hw *isp_parents[] = {
 	&pll_periph0_300M_clk.hw,
 	&pll_periph0_400M_clk.hw,
@@ -918,6 +1066,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(dsp_clk, "dsp", dsp_parents, 0xc70,
 				      BIT(31),	/* gate */
 				      0);
 
+static SUNXI_CCU_GATE_HWS(bus_dsp_cfg_clk, "bus-dsp-cfg", ahb_hws, 0xc7c,
+			  BIT(1), 0);
+
 static SUNXI_CCU_GATE_DATA(fanout_24M_clk, "fanout-24M", osc24M,
 			   0xf30, BIT(0), 0);
 static SUNXI_CCU_GATE_DATA_WITH_PREDIV(fanout_12M_clk, "fanout-12M", osc24M,
@@ -1011,55 +1162,128 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 	&apb0_clk.common,
 	&apb1_clk.common,
 	&de_clk.common,
+	&bus_de_clk.common,
 	&di_clk.common,
+	&bus_di_clk.common,
 	&g2d_clk.common,
+	&bus_g2d_clk.common,
 	&gpu_clk.common,
+	&bus_gpu_clk.common,
 	&ce_clk.common,
+	&bus_ce_clk.common,
+	&bus_ce_sys_clk.common,
 	&ve_clk.common,
+	&bus_ve_clk.common,
+	&bus_dma_clk.common,
+	&bus_msgbox_clk.common,
+	&bus_spinlock_clk.common,
 	&hstimer0_clk.common,
 	&hstimer1_clk.common,
 	&hstimer2_clk.common,
 	&hstimer3_clk.common,
 	&hstimer4_clk.common,
 	&hstimer5_clk.common,
+	&bus_hstimer_clk.common,
+	&bus_dbg_clk.common,
+	&bus_pwm0_clk.common,
+	&bus_pwm1_clk.common,
 	&iommu_clk.common,
+	&bus_iommu_clk.common,
 	&dram_clk.common,
+	&mbus_dma_clk.common,
+	&mbus_ve_clk.common,
+	&mbus_ce_clk.common,
+	&mbus_nand_clk.common,
+	&mbus_usb3_clk.common,
+	&mbus_csi_clk.common,
+	&bus_dram_clk.common,
 	&nand0_clk.common,
 	&nand1_clk.common,
+	&bus_nand_clk.common,
 	&mmc0_clk.common,
 	&mmc1_clk.common,
 	&mmc2_clk.common,
+	&bus_sysdap_clk.common,
+	&bus_mmc0_clk.common,
+	&bus_mmc1_clk.common,
+	&bus_mmc2_clk.common,
+	&bus_uart0_clk.common,
+	&bus_uart1_clk.common,
+	&bus_uart2_clk.common,
+	&bus_uart3_clk.common,
+	&bus_uart4_clk.common,
+	&bus_uart5_clk.common,
+	&bus_uart6_clk.common,
+	&bus_uart7_clk.common,
+	&bus_i2c0_clk.common,
+	&bus_i2c1_clk.common,
+	&bus_i2c2_clk.common,
+	&bus_i2c3_clk.common,
+	&bus_i2c4_clk.common,
+	&bus_i2c5_clk.common,
+	&bus_can_clk.common,
 	&spi0_clk.common,
 	&spi1_clk.common,
 	&spi2_clk.common,
 	&spifc_clk.common,
+	&bus_spi0_clk.common,
+	&bus_spi1_clk.common,
+	&bus_spi2_clk.common,
+	&bus_spifc_clk.common,
 	&emac0_25M_clk.common,
 	&emac1_25M_clk.common,
+	&bus_emac0_clk.common,
+	&bus_emac1_clk.common,
 	&ir_rx_clk.common,
+	&bus_ir_rx_clk.common,
 	&ir_tx_clk.common,
+	&bus_ir_tx_clk.common,
 	&gpadc0_clk.common,
 	&gpadc1_clk.common,
+	&bus_gpadc0_clk.common,
+	&bus_gpadc1_clk.common,
+	&bus_ths_clk.common,
 	&usb_ohci0_clk.common,
 	&usb_ohci1_clk.common,
+	&bus_ohci0_clk.common,
+	&bus_ohci1_clk.common,
+	&bus_ehci0_clk.common,
+	&bus_ehci1_clk.common,
+	&bus_otg_clk.common,
+	&bus_lradc_clk.common,
 	&pcie_aux_clk.common,
+	&bus_dpss_top_clk.common,
 	&hdmi_24M_clk.common,
 	&hdmi_cec_32k_clk.common,
 	&hdmi_cec_clk.common,
+	&bus_hdmi_clk.common,
 	&mipi_dsi0_clk.common,
 	&mipi_dsi1_clk.common,
+	&bus_mipi_dsi0_clk.common,
+	&bus_mipi_dsi1_clk.common,
 	&tcon_lcd0_clk.common,
 	&tcon_lcd1_clk.common,
+	&combophy_dsi0_clk.common,
+	&combophy_dsi1_clk.common,
+	&bus_tcon_lcd0_clk.common,
+	&bus_tcon_lcd1_clk.common,
 	&tcon_tv0_clk.common,
 	&tcon_tv1_clk.common,
+	&bus_tcon_tv0_clk.common,
+	&bus_tcon_tv1_clk.common,
 	&edp_clk.common,
+	&bus_edp_clk.common,
 	&ledc_clk.common,
+	&bus_ledc_clk.common,
 	&csi_top_clk.common,
 	&csi_mclk0_clk.common,
 	&csi_mclk1_clk.common,
 	&csi_mclk2_clk.common,
 	&csi_mclk3_clk.common,
+	&bus_csi_clk.common,
 	&isp_clk.common,
 	&dsp_clk.common,
+	&bus_dsp_cfg_clk.common,
 	&fanout_24M_clk.common,
 	&fanout_12M_clk.common,
 	&fanout_16M_clk.common,
@@ -1119,57 +1343,126 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_APB1]		= &apb1_clk.common.hw,
 		[CLK_MBUS]		= &mbus_clk.hw,
 		[CLK_DE]		= &de_clk.common.hw,
+		[CLK_BUS_DE]		= &bus_de_clk.common.hw,
 		[CLK_DI]		= &di_clk.common.hw,
+		[CLK_BUS_DI]		= &bus_di_clk.common.hw,
 		[CLK_G2D]		= &g2d_clk.common.hw,
+		[CLK_BUS_G2D]		= &bus_g2d_clk.common.hw,
 		[CLK_GPU]		= &gpu_clk.common.hw,
+		[CLK_BUS_GPU]		= &bus_gpu_clk.common.hw,
 		[CLK_CE]		= &ce_clk.common.hw,
+		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
+		[CLK_BUS_CE_SYS]	= &bus_ce_sys_clk.common.hw,
 		[CLK_VE]		= &ve_clk.common.hw,
+		[CLK_BUS_VE]		= &bus_ve_clk.common.hw,
+		[CLK_BUS_DMA]		= &bus_dma_clk.common.hw,
+		[CLK_BUS_MSGBOX]	= &bus_msgbox_clk.common.hw,
+		[CLK_BUS_SPINLOCK]	= &bus_spinlock_clk.common.hw,
 		[CLK_HSTIMER0]		= &hstimer0_clk.common.hw,
 		[CLK_HSTIMER1]		= &hstimer1_clk.common.hw,
 		[CLK_HSTIMER2]		= &hstimer2_clk.common.hw,
 		[CLK_HSTIMER3]		= &hstimer3_clk.common.hw,
 		[CLK_HSTIMER4]		= &hstimer4_clk.common.hw,
 		[CLK_HSTIMER5]		= &hstimer5_clk.common.hw,
+		[CLK_BUS_HSTIMER]	= &bus_hstimer_clk.common.hw,
+		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
+		[CLK_BUS_PWM0]		= &bus_pwm0_clk.common.hw,
+		[CLK_BUS_PWM1]		= &bus_pwm1_clk.common.hw,
 		[CLK_IOMMU]		= &iommu_clk.common.hw,
+		[CLK_BUS_IOMMU]		= &bus_iommu_clk.common.hw,
 		[CLK_DRAM]		= &dram_clk.common.hw,
+		[CLK_MBUS_DMA]		= &mbus_dma_clk.common.hw,
+		[CLK_MBUS_VE]		= &mbus_ve_clk.common.hw,
+		[CLK_MBUS_CE]		= &mbus_ce_clk.common.hw,
+		[CLK_MBUS_CSI]		= &mbus_csi_clk.common.hw,
+		[CLK_BUS_DRAM]		= &bus_dram_clk.common.hw,
 		[CLK_NAND0]		= &nand0_clk.common.hw,
 		[CLK_NAND1]		= &nand1_clk.common.hw,
+		[CLK_BUS_NAND]		= &bus_nand_clk.common.hw,
 		[CLK_MMC0]		= &mmc0_clk.common.hw,
 		[CLK_MMC1]		= &mmc1_clk.common.hw,
 		[CLK_MMC2]		= &mmc2_clk.common.hw,
+		[CLK_BUS_SYSDAP]	= &bus_sysdap_clk.common.hw,
+		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
+		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
+		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
+		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
+		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
+		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
+		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
+		[CLK_BUS_UART4]		= &bus_uart4_clk.common.hw,
+		[CLK_BUS_UART5]		= &bus_uart5_clk.common.hw,
+		[CLK_BUS_UART6]		= &bus_uart6_clk.common.hw,
+		[CLK_BUS_UART7]		= &bus_uart7_clk.common.hw,
+		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
+		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
+		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
+		[CLK_BUS_I2C3]		= &bus_i2c3_clk.common.hw,
+		[CLK_BUS_I2C4]		= &bus_i2c4_clk.common.hw,
+		[CLK_BUS_I2C5]		= &bus_i2c5_clk.common.hw,
+		[CLK_BUS_CAN]		= &bus_can_clk.common.hw,
 		[CLK_SPI0]		= &spi0_clk.common.hw,
 		[CLK_SPI1]		= &spi1_clk.common.hw,
 		[CLK_SPI2]		= &spi2_clk.common.hw,
 		[CLK_SPIFC]		= &spifc_clk.common.hw,
+		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
+		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
+		[CLK_BUS_SPI2]		= &bus_spi2_clk.common.hw,
+		[CLK_BUS_SPIFC]		= &bus_spifc_clk.common.hw,
 		[CLK_EMAC0_25M]		= &emac0_25M_clk.common.hw,
 		[CLK_EMAC1_25M]		= &emac1_25M_clk.common.hw,
+		[CLK_BUS_EMAC0]		= &bus_emac0_clk.common.hw,
+		[CLK_BUS_EMAC1]		= &bus_emac1_clk.common.hw,
 		[CLK_IR_RX]		= &ir_rx_clk.common.hw,
+		[CLK_BUS_IR_RX]		= &bus_ir_rx_clk.common.hw,
 		[CLK_IR_TX]		= &ir_tx_clk.common.hw,
+		[CLK_BUS_IR_TX]		= &bus_ir_tx_clk.common.hw,
 		[CLK_GPADC0]		= &gpadc0_clk.common.hw,
 		[CLK_GPADC1]		= &gpadc1_clk.common.hw,
+		[CLK_BUS_GPADC0]	= &bus_gpadc0_clk.common.hw,
+		[CLK_BUS_GPADC1]	= &bus_gpadc1_clk.common.hw,
+		[CLK_BUS_THS]		= &bus_ths_clk.common.hw,
 		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
 		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
+		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
+		[CLK_BUS_OHCI1]		= &bus_ohci1_clk.common.hw,
+		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
+		[CLK_BUS_EHCI1]		= &bus_ehci1_clk.common.hw,
+		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
+		[CLK_BUS_LRADC]		= &bus_lradc_clk.common.hw,
 		[CLK_PCIE_AUX]		= &pcie_aux_clk.common.hw,
+		[CLK_BUS_DPSS_TOP]	= &bus_dpss_top_clk.common.hw,
 		[CLK_HDMI_24M]		= &hdmi_24M_clk.common.hw,
 		[CLK_HDMI_CEC_32K]	= &hdmi_cec_32k_clk.common.hw,
 		[CLK_HDMI_CEC]		= &hdmi_cec_clk.common.hw,
+		[CLK_BUS_HDMI]		= &bus_hdmi_clk.common.hw,
 		[CLK_MIPI_DSI0]		= &mipi_dsi0_clk.common.hw,
 		[CLK_MIPI_DSI1]		= &mipi_dsi1_clk.common.hw,
+		[CLK_BUS_MIPI_DSI0]	= &bus_mipi_dsi0_clk.common.hw,
+		[CLK_BUS_MIPI_DSI1]	= &bus_mipi_dsi1_clk.common.hw,
 		[CLK_TCON_LCD0]		= &tcon_lcd0_clk.common.hw,
 		[CLK_TCON_LCD1]		= &tcon_lcd1_clk.common.hw,
 		[CLK_COMBOPHY_DSI0]	= &combophy_dsi0_clk.common.hw,
 		[CLK_COMBOPHY_DSI1]	= &combophy_dsi1_clk.common.hw,
+		[CLK_BUS_TCON_LCD0]	= &bus_tcon_lcd0_clk.common.hw,
+		[CLK_BUS_TCON_LCD1]	= &bus_tcon_lcd1_clk.common.hw,
 		[CLK_TCON_TV0]		= &tcon_tv0_clk.common.hw,
 		[CLK_TCON_TV1]		= &tcon_tv1_clk.common.hw,
+		[CLK_BUS_TCON_TV0]	= &bus_tcon_tv0_clk.common.hw,
+		[CLK_BUS_TCON_TV1]	= &bus_tcon_tv1_clk.common.hw,
 		[CLK_EDP]		= &edp_clk.common.hw,
+		[CLK_BUS_EDP]		= &bus_edp_clk.common.hw,
 		[CLK_LEDC]		= &ledc_clk.common.hw,
+		[CLK_BUS_LEDC]		= &bus_ledc_clk.common.hw,
 		[CLK_CSI_TOP]		= &csi_top_clk.common.hw,
 		[CLK_CSI_MCLK0]		= &csi_mclk0_clk.common.hw,
 		[CLK_CSI_MCLK1]		= &csi_mclk1_clk.common.hw,
 		[CLK_CSI_MCLK2]		= &csi_mclk2_clk.common.hw,
 		[CLK_CSI_MCLK3]		= &csi_mclk3_clk.common.hw,
+		[CLK_BUS_CSI]		= &bus_csi_clk.common.hw,
 		[CLK_ISP]		= &isp_clk.common.hw,
 		[CLK_DSP]		= &dsp_clk.common.hw,
+		[CLK_BUS_DSP_CFG]	= &bus_dsp_cfg_clk.common.hw,
 		[CLK_FANOUT_24M]	= &fanout_24M_clk.common.hw,
 		[CLK_FANOUT_12M]	= &fanout_12M_clk.common.hw,
 		[CLK_FANOUT_16M]	= &fanout_16M_clk.common.hw,
-- 
2.46.3


