Return-Path: <linux-kernel+bounces-514965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F7A35E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14DD3B04E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71F82641E1;
	Fri, 14 Feb 2025 12:56:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011202661AE;
	Fri, 14 Feb 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537778; cv=none; b=rcX5p4jn5W4b5mcoHVTYYjjUFPDAhdiaat6/d1GNuKwUxNxmcSVnDvITKQN0DeEu+xVOBhSzbmnIvbmvtFlj37gMP+4gwNFM22PN/3ew/n73V1IXW3gvnl4qFY15f7PBtZppHjK7+2P9AA2YXbACLEMTH99JJOGxQzJiPNUjq6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537778; c=relaxed/simple;
	bh=+Uk8UruD2di7bxgJdl/GASO2N+xO6A5A79ojvdgEQzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndwOfX6GB6ooUBfqxzyUErrbsTDz6uo+xzD9JDlN6Zq/Wxx5JMezX17g3eMX2ykbvuaXvv6+1oImF9C84/JcXOrbPkspWI297Q2M7nr3SlG8jOPlDm1e4lZG5WZkM6K8ATeLRkkykCo0vTKvKoPCKNmTDK2n31Ff4zofJZdm/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A15D41596;
	Fri, 14 Feb 2025 04:56:36 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 755973F58B;
	Fri, 14 Feb 2025 04:56:14 -0800 (PST)
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
Subject: [PATCH v2 06/15] clk: sunxi-ng: a523: Add support for bus clocks
Date: Fri, 14 Feb 2025 12:53:50 +0000
Message-ID: <20250214125359.5204-7-andre.przywara@arm.com>
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

Add the basic bus clocks for the Allwinner A523 and T527 SoCs.
This covers the AHB, APB0 and APB1 clocks. Linux is not supposed to
change those clocks, but they are needed as parents for many other mod
clocks.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
index 8374e841e9d82..59f45e7c0904b 100644
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


