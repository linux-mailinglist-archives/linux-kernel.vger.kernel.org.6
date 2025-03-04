Return-Path: <linux-kernel+bounces-543049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A3FA4D0F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBD03AF73D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4801F3FED;
	Tue,  4 Mar 2025 01:30:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7E01F4174;
	Tue,  4 Mar 2025 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051858; cv=none; b=NJt9JmBfPGWbA0ZdosmP+70IVZ82Y6J3UXJWoyEl8dg7uOV3rlcrpDewNgo+GIb2NrxJ0qpdsBCfEbz/7GaiG2bn+GoHpf6HTmjUBjqeLdDFAX5IZuE4sJVQaYETk2ITZ2HtMRHR0w2303mQ/xNPiUEhzDU2PZ59LUCkqq6m5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051858; c=relaxed/simple;
	bh=Ddc0gypRS35D9ISvodKyAMUc2+6+6ub2YWfWwxSlW1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddMQ7FXMXwOFhkILopS2pr1lugHkNxb/ibs1UoCH/6Jsjen5dr56UOOawSJJ12+PRb/EygQuPINGohkvjnyz3OCTka2RKtfgfMJEszokgAJX1J2BGyNOkDfvW9oIXGxoxjox8DiUhlRAvSCFSS/QXw1GbecGfdo0euk2l8b/nEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 922861BF7;
	Mon,  3 Mar 2025 17:31:10 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1B7E3F673;
	Mon,  3 Mar 2025 17:30:54 -0800 (PST)
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
Subject: [PATCH v3 11/15] clk: sunxi-ng: a523: add USB mod clocks
Date: Tue,  4 Mar 2025 01:28:01 +0000
Message-ID: <20250304012805.28594-12-andre.przywara@arm.com>
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

Add the clocks driving the USB subsystem: this just covers the two
clocks creating the 12 MHz rate for the OHCI (USB 1.x) device. The rest
of the USB clocks are either gate clocks (added later) or created
internal to the USB IP.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 57 ++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 7aa38bb2e6ba6..573c9885110a1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -684,6 +684,59 @@ static SUNXI_CCU_M_WITH_GATE(gpadc1_clk, "gpadc1", "hosc", 0x9e4,
 				 BIT(31),	/* gate */
 				 0);
 
+/*
+ * The first parent is a 48 MHz input clock divided by 4. That 48 MHz clock is
+ * a 2x multiplier from osc24M synchronized by pll-periph0, and is also used by
+ * the OHCI module.
+ */
+static const struct clk_parent_data usb_ohci_parents[] = {
+	{ .hw = &pll_periph0_4x_clk.common.hw },
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+};
+static const struct ccu_mux_fixed_prediv usb_ohci_predivs[] = {
+	{ .index = 0, .div = 50 },
+	{ .index = 1, .div = 2 },
+};
+
+static struct ccu_mux usb_ohci0_clk = {
+	.enable		= BIT(31),
+	.mux		= {
+		.shift		= 24,
+		.width		= 2,
+		.fixed_predivs	= usb_ohci_predivs,
+		.n_predivs	= ARRAY_SIZE(usb_ohci_predivs),
+	},
+	.common		= {
+		.reg		= 0xa70,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("usb-ohci0",
+							   usb_ohci_parents,
+							   &ccu_mux_ops,
+							   0),
+	},
+};
+
+static struct ccu_mux usb_ohci1_clk = {
+	.enable		= BIT(31),
+	.mux		= {
+		.shift		= 24,
+		.width		= 2,
+		.fixed_predivs	= usb_ohci_predivs,
+		.n_predivs	= ARRAY_SIZE(usb_ohci_predivs),
+	},
+	.common		= {
+		.reg		= 0xa74,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("usb-ohci1",
+							   usb_ohci_parents,
+							   &ccu_mux_ops,
+							   0),
+	},
+};
+
+
 static const struct clk_parent_data losc_hosc_parents[] = {
 	{ .fw_name = "hosc" },
 	{ .fw_name = "losc" },
@@ -869,6 +922,8 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 	&ir_tx_clk.common,
 	&gpadc0_clk.common,
 	&gpadc1_clk.common,
+	&usb_ohci0_clk.common,
+	&usb_ohci1_clk.common,
 	&pcie_aux_clk.common,
 	&hdmi_24M_clk.common,
 	&hdmi_cec_32k_clk.common,
@@ -960,6 +1015,8 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_IR_TX]		= &ir_tx_clk.common.hw,
 		[CLK_GPADC0]		= &gpadc0_clk.common.hw,
 		[CLK_GPADC1]		= &gpadc1_clk.common.hw,
+		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
+		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
 		[CLK_PCIE_AUX]		= &pcie_aux_clk.common.hw,
 		[CLK_HDMI_24M]		= &hdmi_24M_clk.common.hw,
 		[CLK_HDMI_CEC_32K]	= &hdmi_cec_32k_clk.common.hw,
-- 
2.46.3


