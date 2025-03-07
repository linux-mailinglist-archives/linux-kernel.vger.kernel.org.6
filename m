Return-Path: <linux-kernel+bounces-550151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D00A55BE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E85C77AB686
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C071624E9;
	Fri,  7 Mar 2025 00:26:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1146F1552FD;
	Fri,  7 Mar 2025 00:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307210; cv=none; b=Afalr+sTeeozTtkXr5Y5nA6uiPkMiNKV/rHIeU5XGfpD4nivzEhXYR5S25tRsMy/TTRB+QowR7q48+5JU0/Cw1vOSNb4wxXln0fDfhC8BW5Nn45emkmL5pII+TQhyyAIS+vlTxvA3KkwShJz93T2o9Nf2uRdtQ9lKHpz5VF6AK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307210; c=relaxed/simple;
	bh=LDGzPYIsaKKojsVlTcd33q1rNEQOK8VRe43j9jWl8oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzZOlFdQc0NstNoM9Pru5xkX10KGQGG/LV0r9i5fkUU4vf0SRYWJJkPr9K1dUR2DEZmESbrmmoUmteVpmHKbJYK4M5NzD34YBqwfK2dbm2ldw0K5mahVqbl9TCQ+An9XxkVgDL24ZwissllW/7xDYDIQoFNaq6lBJa7fWC5CF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0ABF169E;
	Thu,  6 Mar 2025 16:27:00 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FF293F673;
	Thu,  6 Mar 2025 16:26:46 -0800 (PST)
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
Subject: [PATCH v4 06/14] clk: sunxi-ng: a523: Add support for bus clocks
Date: Fri,  7 Mar 2025 00:26:20 +0000
Message-ID: <20250307002628.10684-7-andre.przywara@arm.com>
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

Add the basic bus clocks for the Allwinner A523 and T527 SoCs.
This covers the AHB, APB0 and APB1 clocks. Linux is not supposed to
change those clocks, but they are needed as parents for many other mod
clocks.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 455bca0c344bc..c8a96b642bb1e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -331,6 +331,39 @@ static CLK_FIXED_FACTOR_HW(pll_npu_2x_clk, "pll-npu-2x",
 static CLK_FIXED_FACTOR_HW(pll_npu_1x_clk, "pll-npu-1x",
 			   &pll_npu_4x_clk.common.hw, 4, 1, 0);
 
+
+/**************************************************************************
+ *                           bus clocks                                   *
+ **************************************************************************/
+
+static const struct clk_parent_data ahb_apb0_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_600M_clk.hw },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX(ahb_clk, "ahb", ahb_apb0_parents, 0x510,
+				 0, 5,		/* M */
+				 24, 2,		/* mux */
+				 0);
+static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ahb_apb0_parents, 0x520,
+				 0, 5,		/* M */
+				 24, 2,	/* mux */
+				 0);
+
+static const struct clk_parent_data apb1_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", apb1_parents, 0x524,
+				 0, 5,		/* M */
+				 24, 3,		/* mux */
+				 0);
+
 /*
  * Contains all clocks that are controlled by a hardware register. They
  * have a (sunxi) .common member, which needs to be initialised by the common
@@ -358,6 +391,9 @@ static struct ccu_common *sun55i_a523_ccu_clks[] = {
 	&pll_ve_clk.common,
 	&pll_audio0_4x_clk.common,
 	&pll_npu_4x_clk.common,
+	&ahb_clk.common,
+	&apb0_clk.common,
+	&apb1_clk.common,
 };
 
 static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
@@ -403,6 +439,9 @@ static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
 		[CLK_PLL_NPU_4X]	= &pll_npu_4x_clk.common.hw,
 		[CLK_PLL_NPU_2X]	= &pll_npu_2x_clk.hw,
 		[CLK_PLL_NPU]		= &pll_npu_1x_clk.hw,
+		[CLK_AHB]		= &ahb_clk.common.hw,
+		[CLK_APB0]		= &apb0_clk.common.hw,
+		[CLK_APB1]		= &apb1_clk.common.hw,
 	},
 };
 
-- 
2.46.3


