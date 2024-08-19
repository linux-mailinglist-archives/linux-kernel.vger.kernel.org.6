Return-Path: <linux-kernel+bounces-292024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DB5956A47
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F80280F14
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF7616A945;
	Mon, 19 Aug 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QQQQwlb1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="C0cpD21W"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834D16B749;
	Mon, 19 Aug 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069037; cv=none; b=gIk29rk2qXf8A8xB4gmIJpAs2wiIN0oTp41uy0SKapl23oZRltaa/Uwhc8DG4Mb3HIMhUj4nXYniL/1KN9CC1SH1Vua9dEiLSmYzpCC8cgHqz7GOHjy8+xzc0s9E/7/9sf9yewa+E5A56NPQ7hZEBIv7BXBdHrWrhtt/FKq66fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069037; c=relaxed/simple;
	bh=ku5tuzXWXgycatxekqFSs1URMzUbY1bnh3FnSTqmLvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WX0nXGgMaTmCszpp16pZnJN9SsFCXZtzFm/NH9PLDzL4/M18v9KyBx+el1R61sscUKfh+vr5G7SLqWWAuEekpdezhviOS848aMoxopjXkEl98z5yEmffylj2Ft17PYe3HzYd2khvQyUrNSG3LoXYaKb8WhhhRGmNnMm5jRoUqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QQQQwlb1; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=C0cpD21W reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069034; x=1755605034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5qyXLJxp2Olpp0b4I+lhhwywezjIj1XY/F02aYOHYh8=;
  b=QQQQwlb15kY/NP8YColoT/D+SR5hO9M4JC/PRGwCYuOFgosWLyTxjLUo
   0O9zszvZNbrRIanJ31hFLbMmYWJvSP5IJ/EJ1QU10xEEdavsdQ0CK/8xF
   1m2QPE9iIHqSROJyFunvzhPUHLZ/INdIwxPQmpfDZdBOkNi6nnAFQTwjo
   cvyd9Rh8JzdlNfKbWkQZGpUmPxgbvFLf8wAEaOfT+Ps28dWp9VryDhMHK
   1fhc8jLqUBiVOxGyjJZas98fkwFaRhSpzlA91832ildcG8iOn35MIYjSj
   HciK1DNicX6UAl1hc+E0iNIuHP5qFUsgV4Z0x0AplB6qhBby2+JAJ9g25
   A==;
X-CSE-ConnectionGUID: zroHvyvbQcq030OOtLXdWw==
X-CSE-MsgGUID: IsACh3XnSX6v5/2otgBMhA==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467109"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:03:53 +0200
X-CheckPoint: {66C334A9-D-78509F09-E532FC2E}
X-MAIL-CPID: E7BC7746B63DBC1E9E597AC2DC2513FF_1
X-Control-Analysis: str=0001.0A782F17.66C334A9.00D4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B7C9166A00;
	Mon, 19 Aug 2024 14:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069028; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5qyXLJxp2Olpp0b4I+lhhwywezjIj1XY/F02aYOHYh8=;
	b=C0cpD21Wgts+evBzHHmZq829k94aXkatuXceYEgm4+njnMDypeNulQhlPlsJpcAzKCvXmE
	fWqVOuz+m9lZSyb3SAToASlr/sg6wjnhfJb3Lyka0klIqm91fBx9B2ojNbHTtTKiLuNw4K
	1H1UFaApI5pR/ZJ2mwRlaCfl5yh3wGUtI1K6OPsizupg0iHll6K3Fs2PqWSTopaiwH/+v0
	YIVQnS/Kipclo+4xVXcYfaZtYaXfuuosILcAu8LTLjd/X7UHZjJlARFlHINmFT/njRR00E
	kLIN6wMxTFSL8h+MUEEik22yALuwXdFFGJjB0/Rorf4WM/5RMmyLyyVXW1bY1A==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 03/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla: improve pad configuration
Date: Mon, 19 Aug 2024 14:03:17 +0200
Message-Id: <20240819120328.229622-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
References: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

- disable PU/PD if already done with external resistors
- do not configure Schmitt Trigger for outputs
- do not configure DSE / FSEL for inputs

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 170 ++++++++++--------
 1 file changed, 97 insertions(+), 73 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index 6bca1187b2a98..bbe0fcf97b2a5 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -512,22 +512,23 @@ &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
 			/* PD | FSEL_2 | DSE X4 */
-			MX93_PAD_ENET1_MDC__ENET_QOS_MDC		0x51e
-			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO		0x4000051e
-			/* PD | FSEL_2 | DSE X6 */
-			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0		0x57e
-			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1		0x57e
-			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2		0x57e
-			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3		0x57e
-			/* PD | FSEL_3 | DSE X6 */
-			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x5fe
-			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL	0x57e
+			MX93_PAD_ENET1_MDC__ENET_QOS_MDC			0x51e
+			/* SION | HYS | FSEL_2 | DSE X4 */
+			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO			0x4000111e
+			/* HYS | FSEL_0 | DSE no drive */
+			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0			0x1000
+			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1			0x1000
+			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2			0x1000
+			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3			0x1000
+			MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL		0x1000
+			/* HYS | PD | FSEL_0 | DSE no drive */
+			MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_CLK	0x1400
 			/* PD | FSEL_2 | DSE X4 */
-			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0		0x51e
-			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1		0x51e
-			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2		0x51e
-			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3		0x51e
-			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL	0x51e
+			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0			0x51e
+			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1			0x51e
+			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2			0x51e
+			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3			0x51e
+			MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL		0x51e
 			/* PD | FSEL_3 | DSE X3 */
 			MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
 		>;
@@ -535,7 +536,8 @@ MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
 
 	pinctrl_eqos_phy: eqosphygrp {
 		fsl,pins = <
-			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x1306
+			/* HYS | FSEL_0 | DSE no drive */
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26			0x1000
 		>;
 	};
 
@@ -543,15 +545,16 @@ pinctrl_fec: fecgrp {
 		fsl,pins = <
 			/* PD | FSEL_2 | DSE X4 */
 			MX93_PAD_ENET2_MDC__ENET1_MDC			0x51e
-			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x4000051e
-			/* PD | FSEL_2 | DSE X6 */
-			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
-			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
-			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x57e
-			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x57e
-			/* PD | FSEL_3 | DSE X6 */
-			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x5fe
-			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
+			/* SION | HYS | FSEL_2 | DSE X4 */
+			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x4000111e
+			/* HYS | FSEL_0 | DSE no drive */
+			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x1000
+			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x1000
+			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2		0x1000
+			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3		0x1000
+			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x1000
+			/* HYS | PD | FSEL_0 | DSE no drive */
+			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC		0x1400
 			/* PD | FSEL_2 | DSE X4 */
 			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x51e
 			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x51e
@@ -565,139 +568,160 @@ MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x58e
 
 	pinctrl_fec_phy: fecphygrp {
 		fsl,pins = <
-			MX93_PAD_CCM_CLKO2__GPIO3_IO27		0x1306
+			/* HYS | FSEL_0 | DSE no drive */
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x1000
 		>;
 	};
 
 	pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
-			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX	0x139e
-			MX93_PAD_PDM_CLK__CAN1_TX		0x139e
+			/* HYS | PU | FSEL_0 | DSE no drive */
+			MX93_PAD_PDM_BIT_STREAM0__CAN1_RX		0x1200
+			/* PU | FSEL_3 | DSE X4 */
+			MX93_PAD_PDM_CLK__CAN1_TX			0x039e
 		>;
 	};
 
 	pinctrl_flexcan2: flexcan2grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO25__CAN2_TX		0x139e
-			MX93_PAD_GPIO_IO27__CAN2_RX		0x139e
+			/* HYS | PU | FSEL_0 | DSE no drive */
+			MX93_PAD_GPIO_IO27__CAN2_RX			0x1200
+			/* PU | FSEL_3 | DSE X4 */
+			MX93_PAD_GPIO_IO25__CAN2_TX			0x039e
 		>;
 	};
 
 	pinctrl_lpi2c3: lpi2c3grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO28__LPI2C3_SDA		0x40000b9e
-			MX93_PAD_GPIO_IO29__LPI2C3_SCL		0x40000b9e
+			/* SION | HYS | OD | FSEL_3 | DSE X4 */
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x4000199e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x4000199e
 		>;
 	};
 
 	pinctrl_lpi2c5: lpi2c5grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO22__LPI2C5_SDA		0x40000b9e
-			MX93_PAD_GPIO_IO23__LPI2C5_SCL		0x40000b9e
+			/* SION | HYS | OD | FSEL_3 | DSE X4 */
+			MX93_PAD_GPIO_IO22__LPI2C5_SDA			0x4000199e
+			MX93_PAD_GPIO_IO23__LPI2C5_SCL			0x4000199e
 		>;
 	};
 
 	pinctrl_pcf85063: pcf85063grp {
 		fsl,pins = <
-			MX93_PAD_SAI1_RXD0__GPIO1_IO14		0x1306
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_SAI1_RXD0__GPIO1_IO14			0x1000
 		>;
 	};
 
 	pinctrl_pexp_irq: pexpirqgrp {
 		fsl,pins = <
-			MX93_PAD_SAI1_TXC__GPIO1_IO12		0x1306
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_SAI1_TXC__GPIO1_IO12			0x1000
 		>;
 	};
 
 	pinctrl_tc9595: tc9595-grp {
 		fsl,pins = <
-			/* DP_IRQ */
-			MX93_PAD_CCM_CLKO4__GPIO4_IO29		0x1306
+			/* HYS | PD | FSEL_0 | no DSE */
+			MX93_PAD_CCM_CLKO4__GPIO4_IO29			0x1400
 		>;
 	};
 
 	pinctrl_tpm5: tpm5grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO06__TPM5_CH0		0x57e
+			MX93_PAD_GPIO_IO06__TPM5_CH0			0x57e
 		>;
 	};
 
 	pinctrl_typec: typecgrp {
 		fsl,pins = <
-			MX93_PAD_I2C2_SCL__GPIO1_IO02		0x1306
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_I2C2_SCL__GPIO1_IO02			0x1000
 		>;
 	};
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
-			MX93_PAD_UART1_TXD__LPUART1_TX		0x31e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_UART1_RXD__LPUART1_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_UART1_TXD__LPUART1_TX			0x011e
 		>;
 	};
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX93_PAD_UART2_TXD__LPUART2_TX		0x31e
-			MX93_PAD_UART2_RXD__LPUART2_RX		0x31e
-			MX93_PAD_SAI1_TXD0__LPUART2_RTS_B	0x51e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_UART2_RXD__LPUART2_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_UART2_TXD__LPUART2_TX			0x011e
+			MX93_PAD_SAI1_TXD0__LPUART2_RTS_B		0x011e
 		>;
 	};
 
 	pinctrl_uart3: uart3grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO14__LPUART3_TX		0x31e
-			MX93_PAD_GPIO_IO15__LPUART3_RX		0x31e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_GPIO_IO15__LPUART3_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO14__LPUART3_TX			0x011e
 		>;
 	};
 
 	pinctrl_uart6: uart6grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO04__LPUART6_TX		0x31e
-			MX93_PAD_GPIO_IO05__LPUART6_RX		0x31e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_GPIO_IO05__LPUART6_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO04__LPUART6_TX			0x011e
 		>;
 	};
 
 	pinctrl_uart8: uart8grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO12__LPUART8_TX		0x31e
-			MX93_PAD_GPIO_IO13__LPUART8_RX		0x31e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_GPIO_IO13__LPUART8_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO12__LPUART8_TX			0x011e
 		>;
 	};
 
 	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
-			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_SD2_CD_B__GPIO3_IO00			0x1000
 		>;
 	};
 
 	pinctrl_usdhc2_hs: usdhc2hsgrp {
 		fsl,pins = <
-			/* HYS | PD | PU | FSEL_3 | DSE X5 */
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x17be
-			/* HYS | PD | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
-			/* HYS | PD | PU | FSEL_3 | DSE X3 */
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x138e
-			/* PD | PU | FSEL_2 | DSE X3 */
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x50e
+			/* PD | FSEL_3 | DSE X5 */
+			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05be
+			/* HYS | PU | FSEL_3 | DSE X4 */
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
+			/* HYS | PU | FSEL_3 | DSE X3 */
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
+			/* FSEL_2 | DSE X3 */
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
 	};
 
 	pinctrl_usdhc2_uhs: usdhc2uhsgrp {
 		fsl,pins = <
-			/* HYS | PD | PU | FSEL_3 | DSE X6 */
-			MX93_PAD_SD2_CLK__USDHC2_CLK		0x17fe
-			/* HYS | PD | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x139e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x139e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x139e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
-			/* PD | PU | FSEL_2 | DSE X3 */
-			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x50e
+			/* PD | FSEL_3 | DSE X6 */
+			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05fe
+			/* HYS | PU | FSEL_3 | DSE X4 */
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x139e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x139e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x139e
+			/* FSEL_2 | DSE X3 */
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
 	};
 };
-- 
2.34.1


