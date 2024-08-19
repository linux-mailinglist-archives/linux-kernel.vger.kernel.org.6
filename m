Return-Path: <linux-kernel+bounces-292033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B8D956A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4EA1C23AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE26A16CD24;
	Mon, 19 Aug 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EEKJV1Ps";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="BUDvJKPa"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA1B16D304;
	Mon, 19 Aug 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069075; cv=none; b=KpAIa2jo+tkAn2ihQsBAE/h9xnhN/ayiTjR825Q5XnBWeZkdd0ms/0PwSKuAlBHmjTpc409GCK60e3RAsaWQkJnve4IzLL86FOPVXSPEoqsnbHM5v0NQHhRppFZfOHw8bkZhuQY+/+eAVPkCmRb/WLYVQscxf8lpECO23JrGltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069075; c=relaxed/simple;
	bh=qoYaGHGRZgEk6GCw486vDoAFRDfHmjthLulDPiOuHyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SPhkWFw3/X+rL0I5aWvcOo+QNpdCW5jP0U41zEAhi3vV0+Q07GNmAaMSxE8Ehgqar8Yq6P590wqONaj7GYooPIJzlDj2x7pbgwZOmJ5IZCCyXY361H1b/2GHhZFr5oeuPY799TtxeCarIhqU4pScqOjnob2VknjDNiyVvnvcZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EEKJV1Ps; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=BUDvJKPa reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069073; x=1755605073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0MYz10vhx2r+PKyHVHSxnxKrSy2guPTapKP0q6//jbc=;
  b=EEKJV1PslRZywybC4Rg9BSm7L/YuJrY4hlzXX2CREBL17Yu0MoCKdYne
   yOZVjbYSsWbzLdb2de/vb2zdoO634ldcReLB61piTeqvx1TzfijHbhlT0
   qZ2TO+SVfFc8uzRPkJno1vzOwY4HGoAuVg7KPXD3kKq4/xEKvXVSfQPtl
   envpEn6P6CpX6raxfwMBWyjC0/+yVXYyvISyntcKRu/Ct7HKnsZisBRYv
   OQrujpyRIxPz4UJzL1tA/XfHR4SfmyEtrCZldy8QuXDMktWqlgneEflVi
   zZd/4NfYKdZrfpS3ClcafTOOECizkSlwWU444GYEefpJ7RTyYkujexyAy
   w==;
X-CSE-ConnectionGUID: ejzI5FkpSA2Mj7p5jTH74w==
X-CSE-MsgGUID: JPxTA5vFR5KYYhjyKrQf4g==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467145"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:04:32 +0200
X-CheckPoint: {66C334D0-1A-E9ED6009-C4B0BEC8}
X-MAIL-CPID: 5A50B2D19A98CC96D602911C06D7897E_3
X-Control-Analysis: str=0001.0A782F1B.66C334D0.00D9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7CFCA166C38;
	Mon, 19 Aug 2024 14:04:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069068; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=0MYz10vhx2r+PKyHVHSxnxKrSy2guPTapKP0q6//jbc=;
	b=BUDvJKPapird1y2tJq0yQI8NamLVpbIlKe7P852GZbcXZgLRBOlraPnQlmXlxd/NRmZWPR
	ymyQHmoEcBgpW0SBhu9Kds+M8aMQRIiSfolBus2aDBipeGgUXyfjYIf0Thi5oE5GhcjeCh
	IsjTHWNxSChs/2pwQ8b0S7XLh3ziUeJhsknnBgmZGo67Cow3VedyJotyLb8q/Lj5/8FOwi
	Bu/ENnz9rb+VhVM+AWm9XggKzT9s2npm7+r0NXVHjlnPqgixsshTjt9CC0zZDyaPDAy7LI
	h+CBqk1bG72iFigJNx52WviJEAayJcAw1r+/L9/ZsdoWX2nAulfxFlejxT3zZA==
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
Subject: [PATCH v2 10/14] arm64: dts: freescale: imx93-tqma9352-mba93xxca: improve pad configuration
Date: Mon, 19 Aug 2024 14:03:24 +0200
Message-Id: <20240819120328.229622-11-alexander.stein@ew.tq-group.com>
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

Pad config changes suggested by hardware team.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 180 ++++++++++--------
 1 file changed, 104 insertions(+), 76 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 74e1347e25ea8..c673428a87999 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -575,22 +575,23 @@ &iomuxc {
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
@@ -598,7 +599,8 @@ MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_CLK	0x58e
 
 	pinctrl_eqos_phy: eqosphygrp {
 		fsl,pins = <
-			MX93_PAD_CCM_CLKO1__GPIO3_IO26		0x1306
+			/* HYS | FSEL_0 | DSE no drive */
+			MX93_PAD_CCM_CLKO1__GPIO3_IO26			0x1000
 		>;
 	};
 
@@ -606,15 +608,16 @@ pinctrl_fec: fecgrp {
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
@@ -628,44 +631,54 @@ MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC		0x58e
 
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
 
 	pinctrl_lpspi6: lpspi6grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO00__LPSPI6_PCS0		0x3fe
-			MX93_PAD_GPIO_IO01__LPSPI6_SIN		0x3fe
-			MX93_PAD_GPIO_IO02__LPSPI6_SOUT		0x3fe
-			MX93_PAD_GPIO_IO03__LPSPI6_SCK		0x3fe
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO00__LPSPI6_PCS0			0x011e
+			/* HYS | PD | FSEL_0 | DSE no drive */
+			MX93_PAD_GPIO_IO01__LPSPI6_SIN			0x1400
+			/* PD | FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO02__LPSPI6_SOUT			0x051e
+			MX93_PAD_GPIO_IO03__LPSPI6_SCK			0x051e
 		>;
 	};
 
@@ -677,13 +690,15 @@ MX93_PAD_SAI1_RXD0__GPIO1_IO14			0x1000
 
 	pinctrl_pexp_irq: pexpirqgrp {
 		fsl,pins = <
-			MX93_PAD_SAI1_TXC__GPIO1_IO12		0x1306
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_SAI1_TXC__GPIO1_IO12			0x1000
 		>;
 	};
 
 	pinctrl_pwmfan: pwmfangrp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO09__GPIO2_IO09		0x1306
+			/* HYS | PU | FSEL_0 | no DSE */
+			MX93_PAD_GPIO_IO09__GPIO2_IO09			0x1200
 		>;
 	};
 
@@ -696,92 +711,105 @@ MX93_PAD_SAI1_TXFS__GPIO1_IO11			0x1000
 
 	pinctrl_tpm5: tpm5grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO06__TPM5_CH0		0x57e
+			MX93_PAD_GPIO_IO06__TPM5_CH0			0x57e
 		>;
 	};
 
 	pinctrl_tpm6: tpm6grp {
 		fsl,pins = <
-			MX93_PAD_GPIO_IO08__TPM6_CH0		0x57e
+			MX93_PAD_GPIO_IO08__TPM6_CH0			0x57e
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
-			MX93_PAD_SAI1_TXD0__LPUART2_RTS_B   0x51e
+			/* HYS | FSEL_0 | No DSE */
+			MX93_PAD_UART2_RXD__LPUART2_RX			0x1000
+			/* FSEL_2 | DSE X4 */
+			MX93_PAD_UART2_TXD__LPUART2_TX			0x011e
+			/* FSEL_2 | DSE X4 */
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


