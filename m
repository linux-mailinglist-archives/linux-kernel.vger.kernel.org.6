Return-Path: <linux-kernel+bounces-245606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FED492B4DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3271F1C229CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825A1155CB3;
	Tue,  9 Jul 2024 10:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="GzEGvIvi"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85C149C79
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519939; cv=none; b=ql0CtJtVbaVjYoUGVJdACuRbOjA+V/OkWcfBYRjRMQCzSS2uqoqc+lWVaFOEmMc9gGPJ3BiTT54JWTHyy8gOVbYG7431DcpadxS1HaUAQxZin6r11/PpVRzJZP4128+VViSYm4ks6nTEkqqeJANxkhlK4uKXZ+MhBhljU04Kq6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519939; c=relaxed/simple;
	bh=JzTV9pIdctu6iSCRfcsT8ted6LsnSLQTnPRPdGhiTNo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O7ptjrko5Y2/zSCBi4rw3j0ndLld/9qsLnXEJmYjyXwaVhCD2PXT5uFgc9Jn8Ar9oEN08sOSbJGSFwWmaKTezCs2tUjKD370SuZQlEryWr3okDDjVNof05Fya3VQabaWzZ72J0jVt70MTEjDapjlQJujL8cSzLNhYr3GkoSTjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=GzEGvIvi; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1720519933; x=1723111933;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JzTV9pIdctu6iSCRfcsT8ted6LsnSLQTnPRPdGhiTNo=;
	b=GzEGvIvi9v23eQ1Gz8OPT2wW9AG5g+OnrA8IGmR5eiTU/SIvLRTDDaRENpga3WFo
	7XRwauDHmtqGiaMesOfIy2ACNDGxpkKTBthzha7mYtnl2bu6it2XVhpZPV7yvaHK
	GKLbVaYNOFlb6LXrkz84OCQ/q3O9a2p3nqHS6dJ+UAY=;
X-AuditID: ac14000a-03e52700000021bc-ad-668d0cfdba0b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id CB.98.08636.DFC0D866; Tue,  9 Jul 2024 12:12:13 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 9 Jul 2024
 12:12:13 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <d.schultz@phytec.de>
Subject: [PATCH] arm64: dts: ti: am642-phyboard-electra: Add PRU-ICSSG nodes
Date: Tue, 9 Jul 2024 12:12:05 +0200
Message-ID: <20240709101205.891587-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWyRpKBR/cvT2+awZHfShZr9p5jsph/5Byr
	xfLPs9ktXs66x2ax6fE1VovLu+awWbz5cZbJ4v+eHewW3e/ULf6f/cDuwOWxaVUnm8fmJfUe
	/d0trB7Hb2xn8vi8SS6ANYrLJiU1J7MstUjfLoEr48med8wF/60rXqxoY2tgfGHQxcjBISFg
	ItFwtbaLkZNDSGAJk8SsVRpdjFxA9iNGiXknp7GBJNgE1CXubPjGCpIQEWhjlJi15hoLiMMs
	MIFRYvuv3WBVwgI+EpPXfAKzWQRUJOYvmcQMYvMKWEjs/HGDEcSWEJCXmHnpOztEXFDi5Mwn
	LCA2M1C8eetsZghbQuLgixfMECfJS7y4tJwFpnfaudfMEHaoxJFNq5kmMArMQjJqFpJRs5CM
	WsDIvIpRKDczOTu1KDNbryCjsiQ1WS8ldRMjKPRFGLh2MPbN8TjEyMTBeIhRgoNZSYR3/o3u
	NCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2MS68zHxau
	W1b9evLP6znxb5uOf6w7ZHzyx0u73vYOxjeSjlsWqruZbueyDc+dfmvPL8eu2P/Brg+uz+O4
	uHkO24eJB01mzBAK4nHYya6ccd36Gu8mxgfXTv6xcGqoe9vSt3f9qYQ53goGLAb/lvDNkxIS
	qeBumXm/d9KPUNW30zLOsDLbz17HqcRSnJFoqMVcVJwIAPveZYxrAgAA

The phyBOARD-Electra implements two Ethernet ports utilizing PRUs.
Add configuration for both mac ports & PHYs.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 6df331ccb970..364a7582cf99 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
@@ -28,6 +28,8 @@ / {
 	model = "PHYTEC phyBOARD-Electra-AM64x RDK";
 
 	aliases {
+		ethernet1 = &icssg0_emac0;
+		ethernet2 = &icssg0_emac1;
 		mmc1 = &sdhci1;
 		serial2 = &main_uart0;
 		serial3 = &main_uart1;
@@ -55,6 +57,73 @@ can_tc2: can-phy1 {
 		standby-gpios = <&main_gpio0 35 GPIO_ACTIVE_HIGH>;
 	};
 
+	/* Dual Ethernet application node on PRU-ICSSG0 */
+	ethernet {
+		compatible = "ti,am642-icssg-prueth";
+		pinctrl-names = "default";
+		pinctrl-0 = <&icssg0_rgmii1_pins_default &icssg0_rgmii2_pins_default>;
+
+		sram = <&oc_sram>;
+		ti,prus = <&pru0_0>, <&rtu0_0>, <&tx_pru0_0>, <&pru0_1>, <&rtu0_1>, <&tx_pru0_1>;
+		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
+
+		ti,pruss-gp-mux-sel = <2>,	/* MII mode */
+				      <2>,
+				      <2>,
+				      <2>,	/* MII mode */
+				      <2>,
+				      <2>;
+
+		ti,mii-g-rt = <&icssg0_mii_g_rt>;
+		ti,mii-rt = <&icssg0_mii_rt>;
+		ti,iep = <&icssg0_iep0>, <&icssg0_iep1>;
+
+		interrupt-parent = <&icssg0_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		dmas = <&main_pktdma 0xc100 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc101 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc102 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc103 15>, /* egress slice 0 */
+		       <&main_pktdma 0xc104 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc105 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc106 15>, /* egress slice 1 */
+		       <&main_pktdma 0xc107 15>, /* egress slice 1 */
+		       <&main_pktdma 0x4100 15>, /* ingress slice 0 */
+		       <&main_pktdma 0x4101 15>; /* ingress slice 1 */
+		dma-names = "tx0-0", "tx0-1", "tx0-2", "tx0-3",
+			    "tx1-0", "tx1-1", "tx1-2", "tx1-3",
+			    "rx0", "rx1";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			icssg0_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg0_phy1>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&main_conf 0x4100>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+
+			icssg0_emac1: port@1 {
+				reg = <1>;
+				phy-handle = <&icssg0_phy2>;
+				phy-mode = "rgmii-id";
+				ti,syscon-rgmii-delay = <&main_conf 0x4104>;
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
+
 	keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -118,6 +187,12 @@ AM64X_IOPAD(0x0090, PIN_OUTPUT, 7)	/* (P17) GPMC0_BE0n_CLE.GPIO0_35 */
 		>;
 	};
 
+	clkout0_pins_default: clkout0-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0274, PIN_OUTPUT, 5)	/* (A19) EXT_REFCLK1.CLKOUT0 */
+		>;
+	};
+
 	gpio_keys_pins_default: gpio-keys-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0044, PIN_INPUT, 7)	/* (T18) GPMC0_AD2.GPIO0_17 */
@@ -125,6 +200,49 @@ AM64X_IOPAD(0x0054, PIN_INPUT, 7)	/* (V20) GPMC0_AD6.GPIO0_21 */
 		>;
 	};
 
+	icssg0_mdio_pins_default: icssg0-mdio-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0200, PIN_INPUT, 0)	/* (P2) PRG0_MDIO0_MDIO */
+			AM64X_IOPAD(0x0204, PIN_OUTPUT, 0)	/* (P3) PRG0_MDIO0_MDC */
+			AM64X_IOPAD(0x01A8, PIN_OUTPUT, 7)	/* (V1) PRG0_PRU0_GPO18.GPIO1_18 */
+			AM64X_IOPAD(0x01AC, PIN_OUTPUT, 7)	/* (W1) PRG0_PRU0_GPO19.GPIO1_19 */
+		>;
+	};
+
+	icssg0_rgmii1_pins_default: icssg0-rgmii1-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x0160, PIN_INPUT, 2)	/* (Y1) PRG0_PRU0_GPO0.PRG0_RGMII1_RD0 */
+			AM64X_IOPAD(0x0164, PIN_INPUT, 2)	/* (R4) PRG0_PRU0_GPO1.PRG0_RGMII1_RD1 */
+			AM64X_IOPAD(0x0168, PIN_INPUT, 2)	/* (U2) PRG0_PRU0_GPO2.PRG0_RGMII1_RD2 */
+			AM64X_IOPAD(0x016c, PIN_INPUT, 2)	/* (V2) PRG0_PRU0_GPO3.PRG0_RGMII1_RD3 */
+			AM64X_IOPAD(0x0170, PIN_INPUT, 2)	/* (AA2) PRG0_PRU0_GPO4.PRG0_RGMII1_RX_CTL */
+			AM64X_IOPAD(0x0178, PIN_INPUT, 2)	/* (T3) PRG0_PRU0_GPO6.PRG0_RGMII1_RXC */
+			AM64X_IOPAD(0x018c, PIN_OUTPUT, 2)	/* (Y3) PRG0_PRU0_GPO11.PRG0_RGMII1_TD0 */
+			AM64X_IOPAD(0x0190, PIN_OUTPUT, 2)	/* (AA3) PRG0_PRU0_GPO12.PRG0_RGMII1_TD1 */
+			AM64X_IOPAD(0x0194, PIN_OUTPUT, 2)	/* (R6) PRG0_PRU0_GPO13.PRG0_RGMII1_TD2 */
+			AM64X_IOPAD(0x0198, PIN_OUTPUT, 2)	/* (V4) PRG0_PRU0_GPO14.PRG0_RGMII1_TD3 */
+			AM64X_IOPAD(0x019c, PIN_OUTPUT, 2)	/* (T5) PRG0_PRU0_GPO15.PRG0_RGMII1_TX_CTL */
+			AM64X_IOPAD(0x01a0, PIN_OUTPUT, 2)	/* (U4) PRG0_PRU0_GPO16.PRG0_RGMII1_TXC */
+		>;
+	};
+
+	icssg0_rgmii2_pins_default: icssg0-rgmii2-default-pins {
+		pinctrl-single,pins = <
+			AM64X_IOPAD(0x01b0, PIN_INPUT, 2)	/* (Y2) PRG0_PRU1_GPO0.PRG0_RGMII2_RD0 */
+			AM64X_IOPAD(0x01b4, PIN_INPUT, 2)	/* (W2) PRG0_PRU1_GPO1.PRG0_RGMII2_RD1 */
+			AM64X_IOPAD(0x01b8, PIN_INPUT, 2)	/* (V3) PRG0_PRU1_GPO2.PRG0_RGMII2_RD2 */
+			AM64X_IOPAD(0x01bc, PIN_INPUT, 2)	/* (T4) PRG0_PRU1_GPO3.PRG0_RGMII2_RD3 */
+			AM64X_IOPAD(0x01c0, PIN_INPUT, 2)	/* (W3) PRG0_PRU1_GPO4.PRG0_RGMII2_RX_CTL */
+			AM64X_IOPAD(0x01c8, PIN_INPUT, 2)	/* (R5) PRG0_PRU1_GPO6.PRG0_RGMII2_RXC */
+			AM64X_IOPAD(0x01dc, PIN_OUTPUT, 2)	/* (W4) PRG0_PRU1_GPO11.PRG0_RGMII2_TD0 */
+			AM64X_IOPAD(0x01e0, PIN_OUTPUT, 2)	/* (Y4) PRG0_PRU1_GPO12.PRG0_RGMII2_TD1 */
+			AM64X_IOPAD(0x01e4, PIN_OUTPUT, 2)	/* (T6) PRG0_PRU1_GPO13.PRG0_RGMII2_TD2 */
+			AM64X_IOPAD(0x01e8, PIN_OUTPUT, 2)	/* (U6) PRG0_PRU1_GPO14.PRG0_RGMII2_TD3 */
+			AM64X_IOPAD(0x01ec, PIN_OUTPUT, 2)	/* (U5) PRG0_PRU1_GPO15.PRG0_RGMII2_TX_CTL */
+			AM64X_IOPAD(0x01f0, PIN_OUTPUT, 2)	/* (AA4) PRG0_PRU1_GPO16.PRG0_RGMII2_TXC */
+		>;
+	};
+
 	main_i2c1_pins_default: main-i2c1-default-pins {
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0268, PIN_INPUT, 0)	/* (C18) I2C1_SCL */
@@ -210,6 +328,34 @@ AM64X_IOPAD(0x0040, PIN_OUTPUT, 7)	/* (U21) GPMC0_AD1.GPIO0_16 */
 	};
 };
 
+&icssg0_mdio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg0_mdio_pins_default &clkout0_pins_default>;
+
+	icssg0_phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		reset-gpios = <&main_gpio1 18 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <1000>;
+		reset-deassert-us = <1000>;
+	};
+
+	icssg0_phy2: ethernet-phy@2 {
+		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
+		reg = <0x2>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+		tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		reset-gpios = <&main_gpio1 19 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <1000>;
+		reset-deassert-us = <1000>;
+	};
+};
+
 &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1


