Return-Path: <linux-kernel+bounces-543052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E13A4D0F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4421899DA9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C1C1552E0;
	Tue,  4 Mar 2025 01:31:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08231F4720;
	Tue,  4 Mar 2025 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051865; cv=none; b=gq82FJQWAuPTZ3DtmKU6IQVp19GxNnU8JQNY/OAZaEAiy9e35HHHaZX2RkZdIQn2KmSSMdQTS7+UayUHWs0A1+QRsuwVaxwrJ8hYO9l6QZIJANgWTBcyJbpcr54KXAWL9qjD2IPWugKrvbHR22XAzZQc61Ozh4Alb95q5cISsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051865; c=relaxed/simple;
	bh=JU9dcV6U51gzrsCqd2hp3HXL7DS+uvkGIHdqLqYOgvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dL61dtHll1PAMpwOpy2rDOS3TAk/YEVJ4VivERZXwe++r2htx62bvSboMCA/5TNvy8nGztWLYkXPE46uBbKHCLGvZ75UYAO3gWkdIHebSiyw69aOEN/9kvDSCwloKp2H8vlJfYWuLMsvh/jcLesbNra4VwyPEjwKu8N3sLdrvtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04E31FEC;
	Mon,  3 Mar 2025 17:31:17 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 455873F673;
	Mon,  3 Mar 2025 17:31:01 -0800 (PST)
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
Subject: [PATCH v3 14/15] clk: sunxi-ng: a523: add reset lines
Date: Tue,  4 Mar 2025 01:28:04 +0000
Message-ID: <20250304012805.28594-15-andre.przywara@arm.com>
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

Allwinner SoCs do not contain a separate reset controller, instead the
reset lines for the various devices are integrated into the "BGR" (Bus
Gate / Reset) registers, for each device group: one for all UARTs, one
for all SPI interfaces, and so on.
The Allwinner CCU driver also doubles as a reset provider, and since the
reset lines are indeed just single bits in those BGR register, we can
represent them easily in an array of structs, just containing the
register offset and the bit number.

Add the location of the reset bits for all devices in the A523/T527
SoCs, using the existing sunxi CCU infrastructure.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 84 ++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 7d46a5ccbb051..7b2ac2705773f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -1526,11 +1526,95 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 	},
 };
 
+static struct ccu_reset_map sun55i_a523_ccu_resets[] = {
+	[RST_MBUS]		= { 0x540, BIT(30) },
+	[RST_BUS_NSI]		= { 0x54c, BIT(16) },
+	[RST_BUS_DE]		= { 0x60c, BIT(16) },
+	[RST_BUS_DI]		= { 0x62c, BIT(16) },
+	[RST_BUS_G2D]		= { 0x63c, BIT(16) },
+	[RST_BUS_SYS]		= { 0x64c, BIT(16) },
+	[RST_BUS_GPU]		= { 0x67c, BIT(16) },
+	[RST_BUS_CE]		= { 0x68c, BIT(16) },
+	[RST_BUS_SYS_CE]	= { 0x68c, BIT(17) },
+	[RST_BUS_VE]		= { 0x69c, BIT(16) },
+	[RST_BUS_DMA]		= { 0x70c, BIT(16) },
+	[RST_BUS_MSGBOX]	= { 0x71c, BIT(16) },
+	[RST_BUS_SPINLOCK]	= { 0x72c, BIT(16) },
+	[RST_BUS_CPUXTIMER]	= { 0x74c, BIT(16) },
+	[RST_BUS_DBG]		= { 0x78c, BIT(16) },
+	[RST_BUS_PWM0]		= { 0x7ac, BIT(16) },
+	[RST_BUS_PWM1]		= { 0x7ac, BIT(17) },
+	[RST_BUS_DRAM]		= { 0x80c, BIT(16) },
+	[RST_BUS_NAND]		= { 0x82c, BIT(16) },
+	[RST_BUS_MMC0]		= { 0x84c, BIT(16) },
+	[RST_BUS_MMC1]		= { 0x84c, BIT(17) },
+	[RST_BUS_MMC2]		= { 0x84c, BIT(18) },
+	[RST_BUS_SYSDAP]	= { 0x88c, BIT(16) },
+	[RST_BUS_UART0]		= { 0x90c, BIT(16) },
+	[RST_BUS_UART1]		= { 0x90c, BIT(17) },
+	[RST_BUS_UART2]		= { 0x90c, BIT(18) },
+	[RST_BUS_UART3]		= { 0x90c, BIT(19) },
+	[RST_BUS_UART4]		= { 0x90c, BIT(20) },
+	[RST_BUS_UART5]		= { 0x90c, BIT(21) },
+	[RST_BUS_UART6]		= { 0x90c, BIT(22) },
+	[RST_BUS_UART7]		= { 0x90c, BIT(23) },
+	[RST_BUS_I2C0]		= { 0x91c, BIT(16) },
+	[RST_BUS_I2C1]		= { 0x91c, BIT(17) },
+	[RST_BUS_I2C2]		= { 0x91c, BIT(18) },
+	[RST_BUS_I2C3]		= { 0x91c, BIT(19) },
+	[RST_BUS_I2C4]		= { 0x91c, BIT(20) },
+	[RST_BUS_I2C5]		= { 0x91c, BIT(21) },
+	[RST_BUS_CAN]		= { 0x92c, BIT(16) },
+	[RST_BUS_SPI0]		= { 0x96c, BIT(16) },
+	[RST_BUS_SPI1]		= { 0x96c, BIT(17) },
+	[RST_BUS_SPI2]		= { 0x96c, BIT(18) },
+	[RST_BUS_SPIFC]		= { 0x96c, BIT(19) },
+	[RST_BUS_EMAC0]		= { 0x97c, BIT(16) },
+	[RST_BUS_EMAC1]		= { 0x98c, BIT(16) | BIT(17) },	/* GMAC1-AXI */
+	[RST_BUS_IR_RX]		= { 0x99c, BIT(16) },
+	[RST_BUS_IR_TX]		= { 0x9cc, BIT(16) },
+	[RST_BUS_GPADC0]	= { 0x9ec, BIT(16) },
+	[RST_BUS_GPADC1]	= { 0x9ec, BIT(17) },
+	[RST_BUS_THS]		= { 0x9fc, BIT(16) },
+	[RST_USB_PHY0]		= { 0xa70, BIT(30) },
+	[RST_USB_PHY1]		= { 0xa74, BIT(30) },
+	[RST_BUS_OHCI0]		= { 0xa8c, BIT(16) },
+	[RST_BUS_OHCI1]		= { 0xa8c, BIT(17) },
+	[RST_BUS_EHCI0]		= { 0xa8c, BIT(20) },
+	[RST_BUS_EHCI1]		= { 0xa8c, BIT(21) },
+	[RST_BUS_OTG]		= { 0xa8c, BIT(24) },
+	[RST_BUS_3]		= { 0xa8c, BIT(25) },	/* BSP + register */
+	[RST_BUS_LRADC]		= { 0xa9c, BIT(16) },
+	[RST_BUS_PCIE_USB3]	= { 0xaac, BIT(16) },
+	[RST_BUS_DISPLAY0_TOP]	= { 0xabc, BIT(16) },
+	[RST_BUS_DISPLAY1_TOP]	= { 0xacc, BIT(16) },
+	[RST_BUS_HDMI_MAIN]	= { 0xb1c, BIT(16) },
+	[RST_BUS_HDMI_SUB]	= { 0xb1c, BIT(17) },
+	[RST_BUS_MIPI_DSI0]	= { 0xb4c, BIT(16) },
+	[RST_BUS_MIPI_DSI1]	= { 0xb4c, BIT(17) },
+	[RST_BUS_TCON_LCD0]	= { 0xb7c, BIT(16) },
+	[RST_BUS_TCON_LCD1]	= { 0xb7c, BIT(17) },
+	[RST_BUS_TCON_LCD2]	= { 0xb7c, BIT(18) },
+	[RST_BUS_TCON_TV0]	= { 0xb9c, BIT(16) },
+	[RST_BUS_TCON_TV1]	= { 0xb9c, BIT(17) },
+	[RST_BUS_LVDS0]		= { 0xbac, BIT(16) },
+	[RST_BUS_LVDS1]		= { 0xbac, BIT(17) },
+	[RST_BUS_EDP]		= { 0xbbc, BIT(16) },
+	[RST_BUS_VIDEO_OUT0]	= { 0xbcc, BIT(16) },
+	[RST_BUS_VIDEO_OUT1]	= { 0xbcc, BIT(17) },
+	[RST_BUS_LEDC]		= { 0xbfc, BIT(16) },
+	[RST_BUS_CSI]		= { 0xc1c, BIT(16) },
+	[RST_BUS_ISP]		= { 0xc2c, BIT(16) },	/* BSP + register */
+};
+
 static const struct sunxi_ccu_desc sun55i_a523_ccu_desc = {
 	.ccu_clks	= sun55i_a523_ccu_clks,
 	.num_ccu_clks	= ARRAY_SIZE(sun55i_a523_ccu_clks),
 
 	.hw_clks	= &sun55i_a523_hw_clks,
+
+	.resets		= sun55i_a523_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun55i_a523_ccu_resets),
 };
 
 static const u32 pll_regs[] = {
-- 
2.46.3


