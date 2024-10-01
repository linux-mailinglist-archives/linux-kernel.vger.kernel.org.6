Return-Path: <linux-kernel+bounces-345192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB898B2F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72371C22C50
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A241B5837;
	Tue,  1 Oct 2024 04:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YJskmHWT"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D31B580E;
	Tue,  1 Oct 2024 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727756746; cv=none; b=FRvDMd6R4dnuT64JZbNy1TR2Ab49TA6F7m1ZL8G5cuLXIuip0IYugOMTrPYbYwXoRWRO68qvK773wyp3DFr0nKpoJ2RCqtJbif99W4Sz2YaZLKo1sYvHpvp1fSnUMxmbt3xyex1lruERZjHctd3YCKbwGFkUOhNLxN+h9/uheHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727756746; c=relaxed/simple;
	bh=qINmKLYPVDbFQb7u+E4PtU9YtutM9VRX2dikTr6h06I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YHXgJMOIbyYcyDQcGvf+O/ox0Jhm0V6LPEFOj+Nd1Zzw1kRwSZHlvGeANOX0rAcbg3xq5Hb4Nj04/05fi6Gmy/UN/DHapgWV3igXbWfxiucYWpqWuWgiSKqTVzCoEuEYrGQY5r8Rg6RN6/pIREAUndm5E9YcAILQ3ThDTCQG+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YJskmHWT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9FAE423D2F;
	Tue,  1 Oct 2024 06:25:42 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TGsxb-HfGSLC; Tue,  1 Oct 2024 06:25:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1727756741; bh=qINmKLYPVDbFQb7u+E4PtU9YtutM9VRX2dikTr6h06I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YJskmHWTCpm9UzqOx11Uhw+08ZHtmlPthbGoGVmFhvh2lbEpHBnuPsH8ZcgwKpMAs
	 /fkOn/WCqdAC5PEVjszVqfc2GoZNk8EOvilh5q+r+ti3+b7HgJ0z1TxYKVXEDxpmb1
	 S3jWapPWsLm8olGTyub+Syh9aVpj3fZSQdghXfp/cExAl78QIDjErFWwMiOHn4av18
	 L01wooxivajWvhSB/Dlh7+NEmTZHTxr0SIwfDMW+T2vGJRAIMHtQEmrQKErblMiqYY
	 r61HoI+MK/xF6dQWT+COLg/RKMXgmuJxm7A2wuqJ/pZ16VwqCCT/yx1/0X8/AO3Qj8
	 8ng9iD5XVPrng==
From: Yao Zi <ziyao@disroot.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Celeste Liu <CoelacanthusHex@gmail.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/8] dt-bindings: reset: Add reset ID definition for Rockchip RK3528
Date: Tue,  1 Oct 2024 04:23:56 +0000
Message-ID: <20241001042401.31903-4-ziyao@disroot.org>
In-Reply-To: <20241001042401.31903-2-ziyao@disroot.org>
References: <20241001042401.31903-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to previous Rockchip generations, reset IDs for RK3528 SoC
are register offsets.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 .../dt-bindings/reset/rockchip,rk3528-cru.h   | 292 ++++++++++++++++++
 1 file changed, 292 insertions(+)
 create mode 100644 include/dt-bindings/reset/rockchip,rk3528-cru.h

diff --git a/include/dt-bindings/reset/rockchip,rk3528-cru.h b/include/dt-bindings/reset/rockchip,rk3528-cru.h
new file mode 100644
index 000000000000..1f8c0d38bb88
--- /dev/null
+++ b/include/dt-bindings/reset/rockchip,rk3528-cru.h
@@ -0,0 +1,292 @@
+/* SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co. Ltd.
+ * Copyright (c) 2024 Yao Zi <ziyao@disroot.org>
+ * Author: Joseph Chen <chenjh@rock-chips.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
+#define _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
+
+// CRU_SOFTRST_CON03 (Offset: 0xA0C)
+#define SRST_CORE0_PO			0x00000030
+#define SRST_CORE1_PO			0x00000031
+#define SRST_CORE2_PO			0x00000032
+#define SRST_CORE3_PO			0x00000033
+#define SRST_CORE0			0x00000034
+#define SRST_CORE1			0x00000035
+#define SRST_CORE2			0x00000036
+#define SRST_CORE3			0x00000037
+#define SRST_NL2			0x00000038
+#define SRST_CORE_BIU			0x00000039
+#define SRST_CORE_CRYPTO		0x0000003A
+
+// CRU_SOFTRST_CON05 (Offset: 0xA14)
+#define SRST_P_DBG			0x0000005D
+#define SRST_POT_DBG			0x0000005E
+#define SRST_NT_DBG			0x0000005F
+
+// CRU_SOFTRST_CON06 (Offset: 0xA18)
+#define SRST_P_CORE_GRF			0x00000062
+#define SRST_P_DAPLITE_BIU		0x00000063
+#define SRST_P_CPU_BIU			0x00000064
+#define SRST_REF_PVTPLL_CORE		0x00000067
+
+// CRU_SOFTRST_CON08 (Offset: 0xA20)
+#define SRST_A_BUS_VOPGL_BIU		0x00000081
+#define SRST_A_BUS_H_BIU		0x00000083
+#define SRST_A_SYSMEM_BIU		0x00000088
+#define SRST_A_BUS_BIU			0x0000008A
+#define SRST_H_BUS_BIU			0x0000008B
+#define SRST_P_BUS_BIU			0x0000008C
+#define SRST_P_DFT2APB			0x0000008D
+#define SRST_P_BUS_GRF			0x0000008F
+
+// CRU_SOFTRST_CON09 (Offset: 0xA24)
+#define SRST_A_BUS_M_BIU		0x00000090
+#define SRST_A_GIC			0x00000091
+#define SRST_A_SPINLOCK			0x00000092
+#define SRST_A_DMAC			0x00000094
+#define SRST_P_TIMER			0x00000095
+#define SRST_TIMER0			0x00000096
+#define SRST_TIMER1			0x00000097
+#define SRST_TIMER2			0x00000098
+#define SRST_TIMER3			0x00000099
+#define SRST_TIMER4			0x0000009A
+#define SRST_TIMER5			0x0000009B
+#define SRST_P_JDBCK_DAP		0x0000009C
+#define SRST_JDBCK_DAP			0x0000009D
+#define SRST_P_WDT_NS			0x0000009F
+
+// CRU_SOFTRST_CON10 (Offset: 0xA28)
+#define SRST_T_WDT_NS			0x000000A0
+#define SRST_H_TRNG_NS			0x000000A3
+#define SRST_P_UART0			0x000000A7
+#define SRST_S_UART0			0x000000A8
+#define SRST_PKA_CRYPTO			0x000000AA
+#define SRST_A_CRYPTO			0x000000AB
+#define SRST_H_CRYPTO			0x000000AC
+#define SRST_P_DMA2DDR			0x000000AD
+#define SRST_A_DMA2DDR			0x000000AE
+
+// CRU_SOFTRST_CON11 (Offset: 0xA2C)
+#define SRST_P_PWM0			0x000000B4
+#define SRST_PWM0			0x000000B5
+#define SRST_P_PWM1			0x000000B7
+#define SRST_PWM1			0x000000B8
+#define SRST_P_SCR			0x000000BA
+#define SRST_A_DCF			0x000000BB
+#define SRST_P_INTMUX			0x000000BC
+
+// CRU_SOFTRST_CON25 (Offset: 0xA64)
+#define SRST_A_VPU_BIU			0x00000196
+#define SRST_H_VPU_BIU			0x00000197
+#define SRST_P_VPU_BIU			0x00000198
+#define SRST_A_VPU			0x00000199
+#define SRST_H_VPU			0x0000019A
+#define SRST_P_CRU_PCIE			0x0000019B
+#define SRST_P_VPU_GRF			0x0000019C
+#define SRST_H_SFC			0x0000019D
+#define SRST_S_SFC			0x0000019E
+#define SRST_C_EMMC			0x0000019F
+
+// CRU_SOFTRST_CON26 (Offset: 0xA68)
+#define SRST_H_EMMC			0x000001A0
+#define SRST_A_EMMC			0x000001A1
+#define SRST_B_EMMC			0x000001A2
+#define SRST_T_EMMC			0x000001A3
+#define SRST_P_GPIO1			0x000001A4
+#define SRST_DB_GPIO1			0x000001A5
+#define SRST_A_VPU_L_BIU		0x000001A6
+#define SRST_P_VPU_IOC			0x000001A8
+#define SRST_H_SAI_I2S0			0x000001A9
+#define SRST_M_SAI_I2S0			0x000001AA
+#define SRST_H_SAI_I2S2			0x000001AB
+#define SRST_M_SAI_I2S2			0x000001AC
+#define SRST_P_ACODEC			0x000001AD
+
+// CRU_SOFTRST_CON27 (Offset: 0xA6C)
+#define SRST_P_GPIO3			0x000001B0
+#define SRST_DB_GPIO3			0x000001B1
+#define SRST_P_SPI1			0x000001B4
+#define SRST_SPI1			0x000001B5
+#define SRST_P_UART2			0x000001B7
+#define SRST_S_UART2			0x000001B8
+#define SRST_P_UART5			0x000001B9
+#define SRST_S_UART5			0x000001BA
+#define SRST_P_UART6			0x000001BB
+#define SRST_S_UART6			0x000001BC
+#define SRST_P_UART7			0x000001BD
+#define SRST_S_UART7			0x000001BE
+#define SRST_P_I2C3			0x000001BF
+
+// CRU_SOFTRST_CON28 (Offset: 0xA70)
+#define SRST_I2C3			0x000001C0
+#define SRST_P_I2C5			0x000001C1
+#define SRST_I2C5			0x000001C2
+#define SRST_P_I2C6			0x000001C3
+#define SRST_I2C6			0x000001C4
+#define SRST_A_MAC			0x000001C5
+
+// CRU_SOFTRST_CON30 (Offset: 0xA78)
+#define SRST_P_PCIE			0x000001E1
+#define SRST_PCIE_PIPE_PHY		0x000001E2
+#define SRST_PCIE_POWER_UP		0x000001E3
+#define SRST_P_PCIE_PHY			0x000001E6
+#define SRST_P_PIPE_GRF			0x000001E7
+
+// CRU_SOFTRST_CON32 (Offset: 0xA80)
+#define SRST_H_SDIO0			0x00000202
+#define SRST_H_SDIO1			0x00000204
+#define SRST_TS_0			0x00000205
+#define SRST_TS_1			0x00000206
+#define SRST_P_CAN2			0x00000207
+#define SRST_CAN2			0x00000208
+#define SRST_P_CAN3			0x00000209
+#define SRST_CAN3			0x0000020A
+#define SRST_P_SARADC			0x0000020B
+#define SRST_SARADC			0x0000020C
+#define SRST_SARADC_PHY			0x0000020D
+#define SRST_P_TSADC			0x0000020E
+#define SRST_TSADC			0x0000020F
+
+// CRU_SOFTRST_CON33 (Offset: 0xA84)
+#define SRST_A_USB3OTG			0x00000211
+
+// CRU_SOFTRST_CON34 (Offset: 0xA88)
+#define SRST_A_GPU_BIU			0x00000223
+#define SRST_P_GPU_BIU			0x00000225
+#define SRST_A_GPU			0x00000228
+#define SRST_REF_PVTPLL_GPU		0x00000229
+
+// CRU_SOFTRST_CON36 (Offset: 0xA90)
+#define SRST_H_RKVENC_BIU		0x00000243
+#define SRST_A_RKVENC_BIU		0x00000244
+#define SRST_P_RKVENC_BIU		0x00000245
+#define SRST_H_RKVENC			0x00000246
+#define SRST_A_RKVENC			0x00000247
+#define SRST_CORE_RKVENC		0x00000248
+#define SRST_H_SAI_I2S1			0x00000249
+#define SRST_M_SAI_I2S1			0x0000024A
+#define SRST_P_I2C1			0x0000024B
+#define SRST_I2C1			0x0000024C
+#define SRST_P_I2C0			0x0000024D
+#define SRST_I2C0			0x0000024E
+
+// CRU_SOFTRST_CON37 (Offset: 0xA94)
+#define SRST_P_SPI0			0x00000252
+#define SRST_SPI0			0x00000253
+#define SRST_P_GPIO4			0x00000258
+#define SRST_DB_GPIO4			0x00000259
+#define SRST_P_RKVENC_IOC		0x0000025A
+#define SRST_H_SPDIF			0x0000025E
+#define SRST_M_SPDIF			0x0000025F
+
+// CRU_SOFTRST_CON38 (Offset: 0xA98)
+#define SRST_H_PDM			0x00000260
+#define SRST_M_PDM			0x00000261
+#define SRST_P_UART1			0x00000262
+#define SRST_S_UART1			0x00000263
+#define SRST_P_UART3			0x00000264
+#define SRST_S_UART3			0x00000265
+#define SRST_P_RKVENC_GRF		0x00000266
+#define SRST_P_CAN0			0x00000267
+#define SRST_CAN0			0x00000268
+#define SRST_P_CAN1			0x00000269
+#define SRST_CAN1			0x0000026A
+
+// CRU_SOFTRST_CON39 (Offset: 0xA9C)
+#define SRST_A_VO_BIU			0x00000273
+#define SRST_H_VO_BIU			0x00000274
+#define SRST_P_VO_BIU			0x00000275
+#define SRST_H_RGA2E			0x00000277
+#define SRST_A_RGA2E			0x00000278
+#define SRST_CORE_RGA2E			0x00000279
+#define SRST_H_VDPP			0x0000027A
+#define SRST_A_VDPP			0x0000027B
+#define SRST_CORE_VDPP			0x0000027C
+#define SRST_P_VO_GRF			0x0000027D
+#define SRST_P_CRU			0x0000027F
+
+// CRU_SOFTRST_CON40 (Offset: 0xAA0)
+#define SRST_A_VOP_BIU			0x00000281
+#define SRST_H_VOP			0x00000282
+#define SRST_D_VOP0			0x00000283
+#define SRST_D_VOP1			0x00000284
+#define SRST_A_VOP			0x00000285
+#define SRST_P_HDMI			0x00000286
+#define SRST_HDMI			0x00000287
+#define SRST_P_HDMIPHY			0x0000028E
+#define SRST_H_HDCP_KEY			0x0000028F
+
+// CRU_SOFTRST_CON41 (Offset: 0xAA4)
+#define SRST_A_HDCP			0x00000290
+#define SRST_H_HDCP			0x00000291
+#define SRST_P_HDCP			0x00000292
+#define SRST_H_CVBS			0x00000293
+#define SRST_D_CVBS_VOP			0x00000294
+#define SRST_D_4X_CVBS_VOP		0x00000295
+#define SRST_A_JPEG_DECODER		0x00000296
+#define SRST_H_JPEG_DECODER		0x00000297
+#define SRST_A_VO_L_BIU			0x00000299
+#define SRST_A_MAC_VO			0x0000029A
+
+// CRU_SOFTRST_CON42 (Offset: 0xAA8)
+#define SRST_A_JPEG_BIU			0x000002A0
+#define SRST_H_SAI_I2S3			0x000002A1
+#define SRST_M_SAI_I2S3			0x000002A2
+#define SRST_MACPHY			0x000002A3
+#define SRST_P_VCDCPHY			0x000002A4
+#define SRST_P_GPIO2			0x000002A5
+#define SRST_DB_GPIO2			0x000002A6
+#define SRST_P_VO_IOC			0x000002A7
+#define SRST_H_SDMMC0			0x000002A9
+#define SRST_P_OTPC_NS			0x000002AB
+#define SRST_SBPI_OTPC_NS		0x000002AC
+#define SRST_USER_OTPC_NS		0x000002AD
+
+// CRU_SOFTRST_CON43 (Offset: 0xAAC)
+#define SRST_HDMIHDP0			0x000002B2
+#define SRST_H_USBHOST			0x000002B3
+#define SRST_H_USBHOST_ARB		0x000002B4
+#define SRST_HOST_UTMI			0x000002B6
+#define SRST_P_UART4			0x000002B7
+#define SRST_S_UART4			0x000002B8
+#define SRST_P_I2C4			0x000002B9
+#define SRST_I2C4			0x000002BA
+#define SRST_P_I2C7			0x000002BB
+#define SRST_I2C7			0x000002BC
+#define SRST_P_USBPHY			0x000002BD
+#define SRST_USBPHY_POR			0x000002BE
+#define SRST_USBPHY_OTG			0x000002BF
+
+// CRU_SOFTRST_CON44 (Offset: 0xAB0)
+#define SRST_USBPHY_HOST		0x000002C0
+#define SRST_P_DDRPHY_CRU		0x000002C4
+#define SRST_H_RKVDEC_BIU		0x000002C6
+#define SRST_A_RKVDEC_BIU		0x000002C7
+#define SRST_A_RKVDEC			0x000002C8
+#define SRST_H_RKVDEC			0x000002C9
+#define SRST_HEVC_CA_RKVDEC		0x000002CB
+#define SRST_REF_PVTPLL_RKVDEC		0x000002CC
+
+// CRU_SOFTRST_CON45 (Offset: 0xAB4)
+#define SRST_P_DDR_BIU			0x000002D1
+#define SRST_P_DDRC			0x000002D2
+#define SRST_P_DDRMON			0x000002D3
+#define SRST_TIMER_DDRMON		0x000002D4
+#define SRST_P_MSCH_BIU			0x000002D5
+#define SRST_P_DDR_GRF			0x000002D6
+#define SRST_P_DDR_HWLP			0x000002D8
+#define SRST_P_DDRPHY			0x000002D9
+#define SRST_MSCH_BIU			0x000002DA
+#define SRST_A_DDR_UPCTL		0x000002DB
+#define SRST_DDR_UPCTL			0x000002DC
+#define SRST_DDRMON			0x000002DD
+#define SRST_A_DDR_SCRAMBLE		0x000002DE
+#define SRST_A_SPLIT			0x000002DF
+
+// CRU_SOFTRST_CON46 (Offset: 0xAB8)
+#define SRST_DDR_PHY			0x000002E0
+
+#endif // _DT_BINDINGS_RESET_ROCKCHIP_RK3528_H
-- 
2.46.0


