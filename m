Return-Path: <linux-kernel+bounces-543044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE27BA4D0E0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0331754D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F513D24D;
	Tue,  4 Mar 2025 01:30:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5371613C3F2;
	Tue,  4 Mar 2025 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051848; cv=none; b=R8Yx+Md2niQjeyfpvEPhQxKK4T+H73n1QlG0vcDV48xF66oa674I9rDgZoaIcvMEDrp/6JIOqFGEkmGDBdF59/yyoYn5G32IvlgZAKOL7N/FK3nfSpOyGrnDTvTPu6+N7tPzQfKTwxIt4ki/tlAjYRKAxnh39RtOYIGX/flCZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051848; c=relaxed/simple;
	bh=dFRr4/941s7irGOsRSYbiCH4dYt3lBy6A9asJDt8H1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jw9v48tvZ+CpCOFHBEn0IJTOf5YhCLbSPFSBMCeNpAB3ChEtgBOHjq+PUhO9FHNBQRUl8M2+tTlPepKXkTpq6wuyIa+QpoB6pYy+/Wa2CxhZdACBd66u3AYoA/bihSiOdpe5qFLyfmpSNhCQcUa6Lp6q7c32oq9rC2J2MM4zwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09B4A1063;
	Mon,  3 Mar 2025 17:31:00 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48CBD3F673;
	Mon,  3 Mar 2025 17:30:44 -0800 (PST)
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
Subject: [PATCH v3 06/15] clk: sunxi-ng: Add support for the A523/T527 CCU PLLs
Date: Tue,  4 Mar 2025 01:27:56 +0000
Message-ID: <20250304012805.28594-7-andre.przywara@arm.com>
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

Add the PLL clocks of the main CCU of the Allwinner A523 and T527 SoCs.
The clocks were modelled after the A523 and T527 manual, and double
checked by writing all 1's into the respective register, to spot all
implemented bits.

The PLL and mod clocks for the two CPU clusters and the DSU are part of
a separate CCU, also most audio clocks are collected in a DSP CCU, so
both of these clock groups are missing from this driver.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/Kconfig           |   5 +
 drivers/clk/sunxi-ng/Makefile          |   2 +
 drivers/clk/sunxi-ng/ccu-sun55i-a523.c | 481 +++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun55i-a523.h |  14 +
 4 files changed, 502 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index b547198a2c654..04efbda847cf9 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -52,6 +52,11 @@ config SUN50I_H6_R_CCU
 	default y
 	depends on ARM64 || COMPILE_TEST
 
+config SUN55I_A523_CCU
+	tristate "Support for the Allwinner A523/T527 CCU"
+	default y
+	depends on ARM64 || COMPILE_TEST
+
 config SUN4I_A10_CCU
 	tristate "Support for the Allwinner A10/A20 CCU"
 	default y
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 6b3ae2b620db6..01a887f7824bb 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_SUN50I_A100_R_CCU)	+= sun50i-a100-r-ccu.o
 obj-$(CONFIG_SUN50I_H6_CCU)	+= sun50i-h6-ccu.o
 obj-$(CONFIG_SUN50I_H6_R_CCU)	+= sun50i-h6-r-ccu.o
 obj-$(CONFIG_SUN50I_H616_CCU)	+= sun50i-h616-ccu.o
+obj-$(CONFIG_SUN55I_A523_CCU)	+= sun55i-a523-ccu.o
 obj-$(CONFIG_SUN4I_A10_CCU)	+= sun4i-a10-ccu.o
 obj-$(CONFIG_SUN5I_CCU)		+= sun5i-ccu.o
 obj-$(CONFIG_SUN6I_A31_CCU)	+= sun6i-a31-ccu.o
@@ -58,6 +59,7 @@ sun50i-a100-r-ccu-y		+= ccu-sun50i-a100-r.o
 sun50i-h6-ccu-y			+= ccu-sun50i-h6.o
 sun50i-h6-r-ccu-y		+= ccu-sun50i-h6-r.o
 sun50i-h616-ccu-y		+= ccu-sun50i-h616.o
+sun55i-a523-ccu-y		+= ccu-sun55i-a523.o
 sun4i-a10-ccu-y			+= ccu-sun4i-a10.o
 sun5i-ccu-y			+= ccu-sun5i.o
 sun6i-a31-ccu-y			+= ccu-sun6i-a31.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.c b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
new file mode 100644
index 0000000000000..455bca0c344bc
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-2024 Arm Ltd.
+ * Based on the D1 CCU driver:
+ *   Copyright (c) 2020 huangzhenwei@allwinnertech.com
+ *   Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "../clk.h"
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mp.h"
+#include "ccu_mult.h"
+#include "ccu_nk.h"
+#include "ccu_nkm.h"
+#include "ccu_nkmp.h"
+#include "ccu_nm.h"
+
+#include "ccu-sun55i-a523.h"
+
+/*
+ * The 24 MHz oscillator, the root of most of the clock tree.
+ * .fw_name is the string used in the DT "clock-names" property, used to
+ * identify the corresponding clock in the "clocks" property.
+ */
+static const struct clk_parent_data osc24M[] = {
+	{ .fw_name = "hosc" }
+};
+
+/**************************************************************************
+ *                              PLLs                                      *
+ **************************************************************************/
+
+/* Some PLLs are input * N / div1 / P. Model them as NKMP with no K */
+#define SUN55I_A523_PLL_DDR0_REG		0x010
+static struct ccu_nkmp pll_ddr_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
+	.common		= {
+		.reg		= 0x010,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-ddr0", osc24M,
+							   &ccu_nkmp_ops,
+							   CLK_SET_RATE_GATE |
+							   CLK_IS_CRITICAL),
+	},
+};
+
+/*
+ * There is no actual clock output with that frequency (2.4 GHz), instead it
+ * has multiple outputs with adjustable dividers from that base frequency.
+ * Model them separately as divider clocks based on that parent here.
+ */
+#define SUN55I_A523_PLL_PERIPH0_REG	0x020
+static struct ccu_nm pll_periph0_4x_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= 0x020,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-periph0-4x",
+							   osc24M, &ccu_nm_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+/*
+ * Most clock-defining macros expect an *array* of parent clocks, even if
+ * they do not contain a muxer to select between different parents.
+ * The macros ending in just _HW take a simple clock pointer, but then create
+ * a single-entry array out of that. The macros using _HWS take such an
+ * array (even when it is a single entry one), this avoids having those
+ * helper arrays created inside *every* clock definition.
+ * This means for every clock that is referenced more than once it is
+ * useful to create such a dummy array and use _HWS.
+ */
+static const struct clk_hw *pll_periph0_4x_hws[] = {
+	&pll_periph0_4x_clk.common.hw
+};
+
+static SUNXI_CCU_M_HWS(pll_periph0_2x_clk, "pll-periph0-2x",
+		       pll_periph0_4x_hws, 0x020, 16, 3, 0);
+static const struct clk_hw *pll_periph0_2x_hws[] = {
+	&pll_periph0_2x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_periph0_800M_clk, "pll-periph0-800M",
+		       pll_periph0_4x_hws, 0x020, 20, 3, 0);
+static SUNXI_CCU_M_HWS(pll_periph0_480M_clk, "pll-periph0-480M",
+		       pll_periph0_4x_hws, 0x020, 2, 3, 0);
+static const struct clk_hw *pll_periph0_480M_hws[] = {
+	&pll_periph0_480M_clk.common.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph0_600M_clk, "pll-periph0-600M",
+			    pll_periph0_2x_hws, 2, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_400M_clk, "pll-periph0-400M",
+			    pll_periph0_2x_hws, 3, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_300M_clk, "pll-periph0-300M",
+			    pll_periph0_2x_hws, 4, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_200M_clk, "pll-periph0-200M",
+			    pll_periph0_2x_hws, 6, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_150M_clk, "pll-periph0-150M",
+			    pll_periph0_2x_hws, 8, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_160M_clk, "pll-periph0-160M",
+			    pll_periph0_480M_hws, 3, 1, 0);
+
+#define SUN55I_A523_PLL_PERIPH1_REG	0x028
+static struct ccu_nm pll_periph1_4x_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= 0x028,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-periph1-4x",
+							   osc24M, &ccu_nm_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_periph1_4x_hws[] = {
+	&pll_periph1_4x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_periph1_2x_clk, "pll-periph1-2x",
+		       pll_periph1_4x_hws, 0x028, 16, 3, 0);
+static SUNXI_CCU_M_HWS(pll_periph1_800M_clk, "pll-periph1-800M",
+		       pll_periph1_4x_hws, 0x028, 20, 3, 0);
+static SUNXI_CCU_M_HWS(pll_periph1_480M_clk, "pll-periph1-480M",
+		       pll_periph1_4x_hws, 0x028, 2, 3, 0);
+
+static const struct clk_hw *pll_periph1_2x_hws[] = {
+	&pll_periph1_2x_clk.common.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph1_600M_clk, "pll-periph1-600M",
+			    pll_periph1_2x_hws, 2, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_400M_clk, "pll-periph1-400M",
+			    pll_periph1_2x_hws, 3, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_300M_clk, "pll-periph1-300M",
+			    pll_periph1_2x_hws, 4, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_200M_clk, "pll-periph1-200M",
+			    pll_periph1_2x_hws, 6, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_150M_clk, "pll-periph1-150M",
+			    pll_periph1_2x_hws, 8, 1, 0);
+static const struct clk_hw *pll_periph1_480M_hws[] = {
+	&pll_periph1_480M_clk.common.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph1_160M_clk, "pll-periph1-160M",
+			    pll_periph1_480M_hws, 3, 1, 0);
+
+#define SUN55I_A523_PLL_GPU_REG		0x030
+static struct ccu_nkmp pll_gpu_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
+	.common		= {
+		.reg		= 0x030,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-gpu", osc24M,
+							   &ccu_nkmp_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+
+#define SUN55I_A523_PLL_VIDEO0_REG	0x040
+static struct ccu_nm pll_video0_8x_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= 0x040,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-video0-8x",
+							   osc24M, &ccu_nm_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_video0_8x_hws[] = {
+	&pll_video0_8x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_video0_4x_clk, "pll-video0-4x",
+		       pll_video0_8x_hws, 0x040, 0, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_video0_3x_clk, "pll-video0-3x",
+			    pll_video0_8x_hws, 3, 1, CLK_SET_RATE_PARENT);
+
+#define SUN55I_A523_PLL_VIDEO1_REG	0x048
+static struct ccu_nm pll_video1_8x_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= 0x048,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-video1-8x",
+							   osc24M, &ccu_nm_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_video1_8x_hws[] = {
+	&pll_video1_8x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_video1_4x_clk, "pll-video1-4x",
+		       pll_video1_8x_hws, 0x048, 0, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_video1_3x_clk, "pll-video1-3x",
+			    pll_video1_8x_hws, 3, 1, CLK_SET_RATE_PARENT);
+
+#define SUN55I_A523_PLL_VIDEO2_REG	0x050
+static struct ccu_nm pll_video2_8x_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= 0x050,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-video2-8x",
+							   osc24M, &ccu_nm_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_video2_8x_hws[] = {
+	&pll_video2_8x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_video2_4x_clk, "pll-video2-4x",
+		       pll_video2_8x_hws, 0x050, 0, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_video2_3x_clk, "pll-video2-3x",
+			    pll_video2_8x_hws, 3, 1, CLK_SET_RATE_PARENT);
+
+#define SUN55I_A523_PLL_VE_REG		0x058
+static struct ccu_nkmp pll_ve_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
+	.common		= {
+		.reg		= 0x058,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-ve", osc24M,
+							   &ccu_nkmp_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+
+#define SUN55I_A523_PLL_VIDEO3_REG	0x068
+static struct ccu_nm pll_video3_8x_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= 0x068,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-video3-8x",
+							   osc24M, &ccu_nm_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_video3_8x_hws[] = {
+	&pll_video3_8x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS(pll_video3_4x_clk, "pll-video3-4x",
+		       pll_video3_8x_hws, 0x068, 0, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_video3_3x_clk, "pll-video3-3x",
+			    pll_video3_8x_hws, 3, 1, CLK_SET_RATE_PARENT);
+
+/*
+ * PLL_AUDIO0 has m0, m1 dividers in addition to the usual N, M factors.
+ * Since we only need some fixed frequency from this PLL (22.5792MHz x 4 and
+ * 24.576MHz x 4), ignore those dividers and force both of them to 1 (encoded
+ * as 0), in the probe function below.
+ * The M factor must be an even number to produce a 50% duty cycle output.
+ */
+#define SUN55I_A523_PLL_AUDIO0_REG		0x078
+static struct ccu_sdm_setting pll_audio0_sdm_table[] = {
+	{ .rate = 90316800, .pattern = 0xc000872b, .m = 20, .n = 75 },
+	{ .rate = 98304000, .pattern = 0xc0004dd3, .m = 12, .n = 49 },
+
+};
+
+static struct ccu_nm pll_audio0_4x_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(16, 6),
+	.sdm		= _SUNXI_CCU_SDM(pll_audio0_sdm_table, BIT(24),
+					 0x178, BIT(31)),
+	.min_rate	= 180000000U,
+	.max_rate	= 3000000000U,
+	.common		= {
+		.reg		= 0x078,
+		.features	= CCU_FEATURE_SIGMA_DELTA_MOD,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-audio0-4x",
+							   osc24M, &ccu_nm_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+
+static CLK_FIXED_FACTOR_HW(pll_audio0_2x_clk, "pll-audio0-2x",
+			   &pll_audio0_4x_clk.common.hw, 2, 1, 0);
+static CLK_FIXED_FACTOR_HW(pll_audio0_clk, "pll-audio0",
+			   &pll_audio0_4x_clk.common.hw, 4, 1, 0);
+
+#define SUN55I_A523_PLL_NPU_REG			0x080
+static struct ccu_nm pll_npu_4x_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1),	/* input divider */
+	.common		= {
+		.reg		= 0x0080,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-npu-4x",
+							   osc24M, &ccu_nm_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+static CLK_FIXED_FACTOR_HW(pll_npu_2x_clk, "pll-npu-2x",
+			   &pll_npu_4x_clk.common.hw, 2, 1, CLK_SET_RATE_PARENT);
+
+static CLK_FIXED_FACTOR_HW(pll_npu_1x_clk, "pll-npu-1x",
+			   &pll_npu_4x_clk.common.hw, 4, 1, 0);
+
+/*
+ * Contains all clocks that are controlled by a hardware register. They
+ * have a (sunxi) .common member, which needs to be initialised by the common
+ * sunxi CCU code, to be filled with the MMIO base address and the shared lock.
+ */
+static struct ccu_common *sun55i_a523_ccu_clks[] = {
+	&pll_ddr_clk.common,
+	&pll_periph0_4x_clk.common,
+	&pll_periph0_2x_clk.common,
+	&pll_periph0_800M_clk.common,
+	&pll_periph0_480M_clk.common,
+	&pll_periph1_4x_clk.common,
+	&pll_periph1_2x_clk.common,
+	&pll_periph1_800M_clk.common,
+	&pll_periph1_480M_clk.common,
+	&pll_gpu_clk.common,
+	&pll_video0_8x_clk.common,
+	&pll_video0_4x_clk.common,
+	&pll_video1_8x_clk.common,
+	&pll_video1_4x_clk.common,
+	&pll_video2_8x_clk.common,
+	&pll_video2_4x_clk.common,
+	&pll_video3_8x_clk.common,
+	&pll_video3_4x_clk.common,
+	&pll_ve_clk.common,
+	&pll_audio0_4x_clk.common,
+	&pll_npu_4x_clk.common,
+};
+
+static struct clk_hw_onecell_data sun55i_a523_hw_clks = {
+	.num	= CLK_NUMBER,
+	.hws	= {
+		[CLK_PLL_DDR0]		= &pll_ddr_clk.common.hw,
+		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
+		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.common.hw,
+		[CLK_PLL_PERIPH0_800M]	= &pll_periph0_800M_clk.common.hw,
+		[CLK_PLL_PERIPH0_480M]	= &pll_periph0_480M_clk.common.hw,
+		[CLK_PLL_PERIPH0_600M]	= &pll_periph0_600M_clk.hw,
+		[CLK_PLL_PERIPH0_400M]	= &pll_periph0_400M_clk.hw,
+		[CLK_PLL_PERIPH0_300M]	= &pll_periph0_300M_clk.hw,
+		[CLK_PLL_PERIPH0_200M]	= &pll_periph0_200M_clk.hw,
+		[CLK_PLL_PERIPH0_160M]	= &pll_periph0_160M_clk.hw,
+		[CLK_PLL_PERIPH0_150M]	= &pll_periph0_150M_clk.hw,
+		[CLK_PLL_PERIPH1_4X]	= &pll_periph1_4x_clk.common.hw,
+		[CLK_PLL_PERIPH1_2X]	= &pll_periph1_2x_clk.common.hw,
+		[CLK_PLL_PERIPH1_800M]	= &pll_periph1_800M_clk.common.hw,
+		[CLK_PLL_PERIPH1_480M]	= &pll_periph1_480M_clk.common.hw,
+		[CLK_PLL_PERIPH1_600M]	= &pll_periph1_600M_clk.hw,
+		[CLK_PLL_PERIPH1_400M]	= &pll_periph1_400M_clk.hw,
+		[CLK_PLL_PERIPH1_300M]	= &pll_periph1_300M_clk.hw,
+		[CLK_PLL_PERIPH1_200M]	= &pll_periph1_200M_clk.hw,
+		[CLK_PLL_PERIPH1_160M]	= &pll_periph1_160M_clk.hw,
+		[CLK_PLL_PERIPH1_150M]	= &pll_periph1_150M_clk.hw,
+		[CLK_PLL_VIDEO0_8X]	= &pll_video0_8x_clk.common.hw,
+		[CLK_PLL_VIDEO0_4X]	= &pll_video0_4x_clk.common.hw,
+		[CLK_PLL_VIDEO0_3X]	= &pll_video0_3x_clk.hw,
+		[CLK_PLL_VIDEO1_8X]	= &pll_video1_8x_clk.common.hw,
+		[CLK_PLL_VIDEO1_4X]	= &pll_video1_4x_clk.common.hw,
+		[CLK_PLL_VIDEO1_3X]	= &pll_video1_3x_clk.hw,
+		[CLK_PLL_VIDEO2_8X]	= &pll_video2_8x_clk.common.hw,
+		[CLK_PLL_VIDEO2_4X]	= &pll_video2_4x_clk.common.hw,
+		[CLK_PLL_VIDEO2_3X]	= &pll_video2_3x_clk.hw,
+		[CLK_PLL_VIDEO3_8X]	= &pll_video3_8x_clk.common.hw,
+		[CLK_PLL_VIDEO3_4X]	= &pll_video3_4x_clk.common.hw,
+		[CLK_PLL_VIDEO3_3X]	= &pll_video3_3x_clk.hw,
+		[CLK_PLL_VE]		= &pll_ve_clk.common.hw,
+		[CLK_PLL_AUDIO0_4X]	= &pll_audio0_4x_clk.common.hw,
+		[CLK_PLL_AUDIO0_2X]	= &pll_audio0_2x_clk.hw,
+		[CLK_PLL_AUDIO0]	= &pll_audio0_clk.hw,
+		[CLK_PLL_NPU_4X]	= &pll_npu_4x_clk.common.hw,
+		[CLK_PLL_NPU_2X]	= &pll_npu_2x_clk.hw,
+		[CLK_PLL_NPU]		= &pll_npu_1x_clk.hw,
+	},
+};
+
+static const struct sunxi_ccu_desc sun55i_a523_ccu_desc = {
+	.ccu_clks	= sun55i_a523_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun55i_a523_ccu_clks),
+
+	.hw_clks	= &sun55i_a523_hw_clks,
+};
+
+static const u32 pll_regs[] = {
+	SUN55I_A523_PLL_DDR0_REG,
+	SUN55I_A523_PLL_PERIPH0_REG,
+	SUN55I_A523_PLL_PERIPH1_REG,
+	SUN55I_A523_PLL_GPU_REG,
+	SUN55I_A523_PLL_VIDEO0_REG,
+	SUN55I_A523_PLL_VIDEO1_REG,
+	SUN55I_A523_PLL_VIDEO2_REG,
+	SUN55I_A523_PLL_VE_REG,
+	SUN55I_A523_PLL_VIDEO3_REG,
+	SUN55I_A523_PLL_AUDIO0_REG,
+	SUN55I_A523_PLL_NPU_REG,
+};
+
+static int sun55i_a523_ccu_probe(struct platform_device *pdev)
+{
+	void __iomem *reg;
+	u32 val;
+	int i, ret;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	/*
+	 * The PLL clock code does not model all bits, for instance it does
+	 * not support a separate enable and gate bit. We present the
+	 * gate bit(27) as the enable bit, but then have to set the
+	 * PLL Enable, LDO Enable, and Lock Enable bits on all PLLs here.
+	 */
+	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
+		val = readl(reg + pll_regs[i]);
+		val |= BIT(31) | BIT(30) | BIT(29);
+		writel(val, reg + pll_regs[i]);
+	}
+
+	/* Enforce m1 = 0, m0 = 0 for PLL_AUDIO0 */
+	val = readl(reg + SUN55I_A523_PLL_AUDIO0_REG);
+	val &= ~(BIT(1) | BIT(0));
+	writel(val, reg + SUN55I_A523_PLL_AUDIO0_REG);
+
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun55i_a523_ccu_desc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id sun55i_a523_ccu_ids[] = {
+	{ .compatible = "allwinner,sun55i-a523-ccu" },
+	{ }
+};
+
+static struct platform_driver sun55i_a523_ccu_driver = {
+	.probe	= sun55i_a523_ccu_probe,
+	.driver	= {
+		.name			= "sun55i-a523-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun55i_a523_ccu_ids,
+	},
+};
+module_platform_driver(sun55i_a523_ccu_driver);
+
+MODULE_IMPORT_NS("SUNXI_CCU");
+MODULE_DESCRIPTION("Support for the Allwinner A523 CCU");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523.h b/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
new file mode 100644
index 0000000000000..fc8dd42f1b47b
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2024 Arm Ltd.
+ */
+
+#ifndef _CCU_SUN55I_A523_H
+#define _CCU_SUN55I_A523_H
+
+#include <dt-bindings/clock/sun55i-a523-ccu.h>
+#include <dt-bindings/reset/sun55i-a523-ccu.h>
+
+#define CLK_NUMBER	(CLK_FANOUT2 + 1)
+
+#endif /* _CCU_SUN55I_A523_H */
-- 
2.46.3


