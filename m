Return-Path: <linux-kernel+bounces-537028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E38CA48731
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036653AED9C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600F11E521C;
	Thu, 27 Feb 2025 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="u0MA5Uif"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6D1B0439
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679397; cv=none; b=fyo11cVKLmZyjjQutaYTFe+8tZRf4TOCiMqizCy8JUUcnMgyIRxR0SGkU2bHUWwsOv2IhPSdeGQ9+zO7VIX3XNH3Qprjsoyo2IbXaZfUnCCG0dasswHjRtkbX7isIpfy3h59M1NhGWG26MKGdeRpQR7q6/w736GVi+8/H9s5uCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679397; c=relaxed/simple;
	bh=nE9V1kcWLPLmcsvMU/nzsN1MDfe3sN8zHcXjFiGLgBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjKbfYagKeAlV13COV/K0fpXpEWnyTqQRjysGOKGJgpxJ4qIc8P4VKklTVndCYghMwNiTKuwL8F2OCc5GRqCUPcPTDFqoy9QQ7hAr1QfBrlDN8CdO4oktWUFL1hqWpVcmDHYhXYsmCIFPD+48QJcpLhYwUunU+xxpokHEULz1zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=u0MA5Uif; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1740679391;
 bh=9ty4e/zSrNHaCJk0SFQt9vg6rC5/YneZMYB2JJ3Fd6c=;
 b=u0MA5UifjoM+NGoB7jQbQ2edekZoOCUquec/QwRjz81eed8n37DttMcKpENkgMu6Pfm1H6fiA
 Tms/ouPVgCUpVTGV4C2Z2BOn/LeDIqkbsdcofdkHQL8WpQ36NiNQWBWHnsW3vONe0NMt6iC4VHV
 BAJF1Qd0Q6eMez8ObpxsTZZnmhPSOZoRL4nC+T2fV8hNe9OEjcJW/Gxcls/9XruQNQvxPJoogaT
 B5nPiK29OaOvd9JRSaSE8mg4Y+LJyiMRTlB8Gkp2/nCH/cOAcAGJKvQTO3L+3KIMcH6/oC2NTmK
 obwAy3pXcUORANr04A7xO85ZHO9wrwhAU1RLGSTwEAIg==
X-Forward-Email-ID: 67c0a6845ef5224158d0c2d5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] clk: rockchip: Add reset lookup table for RK3528
Date: Thu, 27 Feb 2025 17:52:57 +0000
Message-ID: <20250227175302.2950788-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the commit 5d0eb375e685 ("clk: rockchip: Add clock controller driver
for RK3528 SoC") only the dt-binding header was added for the reset
controller for the RK3528 SoC.

Add a reset lookup table generated from the SRST symbols used by vendor
linux-6.1-stan-rkr5 kernel to complete support for the reset controller.

Fixes: 5d0eb375e685 ("clk: rockchip: Add clock controller driver for RK3528 SoC")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/clk/rockchip/Makefile     |   2 +-
 drivers/clk/rockchip/clk-rk3528.c |   2 +
 drivers/clk/rockchip/clk.h        |   1 +
 drivers/clk/rockchip/rst-rk3528.c | 306 ++++++++++++++++++++++++++++++
 4 files changed, 310 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/rockchip/rst-rk3528.c

diff --git a/drivers/clk/rockchip/Makefile b/drivers/clk/rockchip/Makefile
index 0b07fd4a226f..3329b64f7616 100644
--- a/drivers/clk/rockchip/Makefile
+++ b/drivers/clk/rockchip/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_CLK_RK3308)        += clk-rk3308.o
 obj-$(CONFIG_CLK_RK3328)        += clk-rk3328.o
 obj-$(CONFIG_CLK_RK3368)        += clk-rk3368.o
 obj-$(CONFIG_CLK_RK3399)        += clk-rk3399.o
-obj-$(CONFIG_CLK_RK3528)	+= clk-rk3528.o
+obj-$(CONFIG_CLK_RK3528)	+= clk-rk3528.o rst-rk3528.o
 obj-$(CONFIG_CLK_RK3568)	+= clk-rk3568.o
 obj-$(CONFIG_CLK_RK3576)	+= clk-rk3576.o rst-rk3576.o
 obj-$(CONFIG_CLK_RK3588)	+= clk-rk3588.o rst-rk3588.o
diff --git a/drivers/clk/rockchip/clk-rk3528.c b/drivers/clk/rockchip/clk-rk3528.c
index 00caf277d844..b8b577b902a0 100644
--- a/drivers/clk/rockchip/clk-rk3528.c
+++ b/drivers/clk/rockchip/clk-rk3528.c
@@ -1092,6 +1092,8 @@ static int __init clk_rk3528_probe(struct platform_device *pdev)
 				     ARRAY_SIZE(rk3528_cpuclk_rates));
 	rockchip_clk_register_branches(ctx, rk3528_clk_branches, nr_branches);
 
+	rk3528_rst_init(np, reg_base);
+
 	rockchip_register_restart_notifier(ctx, RK3528_GLB_SRST_FST, NULL);
 
 	rockchip_clk_of_add_provider(np, ctx);
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index b2973b76aa2c..b322d42dc879 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -1140,6 +1140,7 @@ static inline void rockchip_register_softrst(struct device_node *np,
 	return rockchip_register_softrst_lut(np, NULL, num_regs, base, flags);
 }
 
+void rk3528_rst_init(struct device_node *np, void __iomem *reg_base);
 void rk3576_rst_init(struct device_node *np, void __iomem *reg_base);
 void rk3588_rst_init(struct device_node *np, void __iomem *reg_base);
 
diff --git a/drivers/clk/rockchip/rst-rk3528.c b/drivers/clk/rockchip/rst-rk3528.c
new file mode 100644
index 000000000000..b24f2c367929
--- /dev/null
+++ b/drivers/clk/rockchip/rst-rk3528.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ * Based on Sebastian Reichel's implementation for RK3588
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <dt-bindings/reset/rockchip,rk3528-cru.h>
+#include "clk.h"
+
+/* 0xFF4A0000 + 0x0A00 */
+#define RK3528_CRU_RESET_OFFSET(id, reg, bit) [id] = (0 + reg * 16 + bit)
+
+/* mapping table for reset ID to register offset */
+static const int rk3528_register_offset[] = {
+	/* CRU_SOFTRST_CON03 */
+	RK3528_CRU_RESET_OFFSET(SRST_CORE0_PO, 3, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE1_PO, 3, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE2_PO, 3, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE3_PO, 3, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE0, 3, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE1, 3, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE2, 3, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE3, 3, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_NL2, 3, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE_BIU, 3, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE_CRYPTO, 3, 10),
+
+	/* CRU_SOFTRST_CON05 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_DBG, 5, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_POT_DBG, 5, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_NT_DBG, 5, 15),
+
+	/* CRU_SOFTRST_CON06 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_CORE_GRF, 6, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DAPLITE_BIU, 6, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CPU_BIU, 6, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_REF_PVTPLL_CORE, 6, 7),
+
+	/* CRU_SOFTRST_CON08 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_BUS_VOPGL_BIU, 8, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_A_BUS_H_BIU, 8, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_A_SYSMEM_BIU, 8, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_A_BUS_BIU, 8, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_H_BUS_BIU, 8, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_P_BUS_BIU, 8, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DFT2APB, 8, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_P_BUS_GRF, 8, 15),
+
+	/* CRU_SOFTRST_CON09 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_BUS_M_BIU, 9, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_A_GIC, 9, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_A_SPINLOCK, 9, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_A_DMAC, 9, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_P_TIMER, 9, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER0, 9, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER1, 9, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER2, 9, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER3, 9, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER4, 9, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER5, 9, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_P_JDBCK_DAP, 9, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_JDBCK_DAP, 9, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_P_WDT_NS, 9, 15),
+
+	/* CRU_SOFTRST_CON10 */
+	RK3528_CRU_RESET_OFFSET(SRST_T_WDT_NS, 10, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_H_TRNG_NS, 10, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART0, 10, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART0, 10, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_PKA_CRYPTO, 10, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_A_CRYPTO, 10, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_H_CRYPTO, 10, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DMA2DDR, 10, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_A_DMA2DDR, 10, 14),
+
+	/* CRU_SOFTRST_CON11 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_PWM0, 11, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_PWM0, 11, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_P_PWM1, 11, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_PWM1, 11, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_SCR, 11, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_A_DCF, 11, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_P_INTMUX, 11, 12),
+
+	/* CRU_SOFTRST_CON25 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_VPU_BIU, 25, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_H_VPU_BIU, 25, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VPU_BIU, 25, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_A_VPU, 25, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_H_VPU, 25, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CRU_PCIE, 25, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VPU_GRF, 25, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SFC, 25, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_S_SFC, 25, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_C_EMMC, 25, 15),
+
+	/* CRU_SOFTRST_CON26 */
+	RK3528_CRU_RESET_OFFSET(SRST_H_EMMC, 26, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_A_EMMC, 26, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_B_EMMC, 26, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_T_EMMC, 26, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_GPIO1, 26, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_DB_GPIO1, 26, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_A_VPU_L_BIU, 26, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VPU_IOC, 26, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SAI_I2S0, 26, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_M_SAI_I2S0, 26, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SAI_I2S2, 26, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_M_SAI_I2S2, 26, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_ACODEC, 26, 13),
+
+	/* CRU_SOFTRST_CON27 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_GPIO3, 27, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_DB_GPIO3, 27, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_P_SPI1, 27, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_SPI1, 27, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART2, 27, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART2, 27, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART5, 27, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART5, 27, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART6, 27, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART6, 27, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART7, 27, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART7, 27, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C3, 27, 15),
+
+	/* CRU_SOFTRST_CON28 */
+	RK3528_CRU_RESET_OFFSET(SRST_I2C3, 28, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C5, 28, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C5, 28, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C6, 28, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C6, 28, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_A_MAC, 28, 5),
+
+	/* CRU_SOFTRST_CON30 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_PCIE, 30, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_PCIE_PIPE_PHY, 30, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_PCIE_POWER_UP, 30, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_PCIE_PHY, 30, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_PIPE_GRF, 30, 7),
+
+	/* CRU_SOFTRST_CON32 */
+	RK3528_CRU_RESET_OFFSET(SRST_H_SDIO0, 32, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SDIO1, 32, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_TS_0, 32, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_TS_1, 32, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CAN2, 32, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_CAN2, 32, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CAN3, 32, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_CAN3, 32, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_P_SARADC, 32, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_SARADC, 32, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_SARADC_PHY, 32, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_P_TSADC, 32, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_TSADC, 32, 15),
+
+	/* CRU_SOFTRST_CON33 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_USB3OTG, 33, 1),
+
+	/* CRU_SOFTRST_CON34 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_GPU_BIU, 34, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_GPU_BIU, 34, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_A_GPU, 34, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_REF_PVTPLL_GPU, 34, 9),
+
+	/* CRU_SOFTRST_CON36 */
+	RK3528_CRU_RESET_OFFSET(SRST_H_RKVENC_BIU, 36, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_A_RKVENC_BIU, 36, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_P_RKVENC_BIU, 36, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_H_RKVENC, 36, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_A_RKVENC, 36, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE_RKVENC, 36, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SAI_I2S1, 36, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_M_SAI_I2S1, 36, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C1, 36, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C1, 36, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C0, 36, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C0, 36, 14),
+
+	/* CRU_SOFTRST_CON37 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_SPI0, 37, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_SPI0, 37, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_GPIO4, 37, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_DB_GPIO4, 37, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_P_RKVENC_IOC, 37, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SPDIF, 37, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_M_SPDIF, 37, 15),
+
+	/* CRU_SOFTRST_CON38 */
+	RK3528_CRU_RESET_OFFSET(SRST_H_PDM, 38, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_M_PDM, 38, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART1, 38, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART1, 38, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART3, 38, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART3, 38, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_P_RKVENC_GRF, 38, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CAN0, 38, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_CAN0, 38, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CAN1, 38, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_CAN1, 38, 10),
+
+	/* CRU_SOFTRST_CON39 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_VO_BIU, 39, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_H_VO_BIU, 39, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VO_BIU, 39, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_H_RGA2E, 39, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_A_RGA2E, 39, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE_RGA2E, 39, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_H_VDPP, 39, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_A_VDPP, 39, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_CORE_VDPP, 39, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VO_GRF, 39, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_P_CRU, 39, 15),
+
+	/* CRU_SOFTRST_CON40 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_VOP_BIU, 40, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_H_VOP, 40, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_D_VOP0, 40, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_D_VOP1, 40, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_A_VOP, 40, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_P_HDMI, 40, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_HDMI, 40, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_P_HDMIPHY, 40, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_H_HDCP_KEY, 40, 15),
+
+	/* CRU_SOFTRST_CON41 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_HDCP, 41, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_H_HDCP, 41, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_P_HDCP, 41, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_H_CVBS, 41, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_D_CVBS_VOP, 41, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_D_4X_CVBS_VOP, 41, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_A_JPEG_DECODER, 41, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_H_JPEG_DECODER, 41, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_A_VO_L_BIU, 41, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_A_MAC_VO, 41, 10),
+
+	/* CRU_SOFTRST_CON42 */
+	RK3528_CRU_RESET_OFFSET(SRST_A_JPEG_BIU, 42, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SAI_I2S3, 42, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_M_SAI_I2S3, 42, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_MACPHY, 42, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VCDCPHY, 42, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_P_GPIO2, 42, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_DB_GPIO2, 42, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_VO_IOC, 42, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_H_SDMMC0, 42, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_P_OTPC_NS, 42, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_SBPI_OTPC_NS, 42, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_USER_OTPC_NS, 42, 13),
+
+	/* CRU_SOFTRST_CON43 */
+	RK3528_CRU_RESET_OFFSET(SRST_HDMIHDP0, 43, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_H_USBHOST, 43, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_H_USBHOST_ARB, 43, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_HOST_UTMI, 43, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_UART4, 43, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_S_UART4, 43, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C4, 43, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C4, 43, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_P_I2C7, 43, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_I2C7, 43, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_P_USBPHY, 43, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_USBPHY_POR, 43, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_USBPHY_OTG, 43, 15),
+
+	/* CRU_SOFTRST_CON44 */
+	RK3528_CRU_RESET_OFFSET(SRST_USBPHY_HOST, 44, 0),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDRPHY_CRU, 44, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_H_RKVDEC_BIU, 44, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_A_RKVDEC_BIU, 44, 7),
+	RK3528_CRU_RESET_OFFSET(SRST_A_RKVDEC, 44, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_H_RKVDEC, 44, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_HEVC_CA_RKVDEC, 44, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_REF_PVTPLL_RKVDEC, 44, 12),
+
+	/* CRU_SOFTRST_CON45 */
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDR_BIU, 45, 1),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDRC, 45, 2),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDRMON, 45, 3),
+	RK3528_CRU_RESET_OFFSET(SRST_TIMER_DDRMON, 45, 4),
+	RK3528_CRU_RESET_OFFSET(SRST_P_MSCH_BIU, 45, 5),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDR_GRF, 45, 6),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDR_HWLP, 45, 8),
+	RK3528_CRU_RESET_OFFSET(SRST_P_DDRPHY, 45, 9),
+	RK3528_CRU_RESET_OFFSET(SRST_MSCH_BIU, 45, 10),
+	RK3528_CRU_RESET_OFFSET(SRST_A_DDR_UPCTL, 45, 11),
+	RK3528_CRU_RESET_OFFSET(SRST_DDR_UPCTL, 45, 12),
+	RK3528_CRU_RESET_OFFSET(SRST_DDRMON, 45, 13),
+	RK3528_CRU_RESET_OFFSET(SRST_A_DDR_SCRAMBLE, 45, 14),
+	RK3528_CRU_RESET_OFFSET(SRST_A_SPLIT, 45, 15),
+
+	/* CRU_SOFTRST_CON46 */
+	RK3528_CRU_RESET_OFFSET(SRST_DDR_PHY, 46, 0),
+};
+
+void rk3528_rst_init(struct device_node *np, void __iomem *reg_base)
+{
+	rockchip_register_softrst_lut(np,
+				      rk3528_register_offset,
+				      ARRAY_SIZE(rk3528_register_offset),
+				      reg_base + RK3528_SOFTRST_CON(0),
+				      ROCKCHIP_SOFTRST_HIWORD_MASK);
+}
-- 
2.48.1


