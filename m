Return-Path: <linux-kernel+bounces-514969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12BDA35E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792EF3B13DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF6C264A74;
	Fri, 14 Feb 2025 12:56:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3E9266F0F;
	Fri, 14 Feb 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537787; cv=none; b=PH27/spa67VBLEkO1i4OXb1VFRCVDAYb8Rfj1bunc+rGCRxBbXZhkvQcFgKHho2SN5d6cfKvCaUuhsQhsVNNNH0/ugcC6wH5HNp/nYATDlwp1/tAILf/408emQq9Lf/vDOuaPAZUO6iGBoQX1nV9K8lolES61fx5bF/KjzBdwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537787; c=relaxed/simple;
	bh=OH3ngy1G65nZdexdeC5SkYWXRjqaxBiJfCaGEmjK3xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpjlKaQ/91OjjNKv2y9xkyc267+zv8ICpMxvR9H04UMqnMs075AR37gTIjrA0P8qQND+aBxKCH13bUH51M3dspicXRjKS3lzsAqOekpUo12E4ZRH/2Bj5j4bwG8E34U/k9veRpVvxbAwktZdgOtHHCOb+CW9BbAJ1rdvbueMNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11F1B1596;
	Fri, 14 Feb 2025 04:56:45 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA7A13F58B;
	Fri, 14 Feb 2025 04:56:22 -0800 (PST)
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
Subject: [PATCH v2 10/15] clk: sunxi-ng: a523: add USB mod clocks
Date: Fri, 14 Feb 2025 12:53:54 +0000
Message-ID: <20250214125359.5204-11-andre.przywara@arm.com>
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

Add the clocks driving the USB subsystem: this just covers the two
clocks creating the 12 MHz rate for the OHCI (USB 1.x) device. The rest
of the USB clocks are either gate clocks (added later) or created
internal to the USB IP.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 57 ++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 14d13fb16dfbb..59cc31f89ae77 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -667,6 +667,59 @@ static SUNXI_CCU_M_WITH_GATE(gpadc1_clk, "gpadc1", "hosc", 0x9e4,
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
@@ -838,6 +891,8 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 	&ir_tx_clk.common,
 	&gpadc0_clk.common,
 	&gpadc1_clk.common,
+	&usb_ohci0_clk.common,
+	&usb_ohci1_clk.common,
 	&pcie_aux_clk.common,
 	&hdmi_24M_clk.common,
 	&hdmi_cec_32k_clk.common,
@@ -927,6 +982,8 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
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


