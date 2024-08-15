Return-Path: <linux-kernel+bounces-287878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0142952D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2351F24B51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7994E1714C7;
	Thu, 15 Aug 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="ZVUEjPTI"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF151714C0
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721565; cv=none; b=G18Yvnt7Sivjb/yUTyq9nQUttJAXLBUSr7uBNBOySdsj49B2OCDVrmcutC3bzH7hbFFtOWcs727GvTIL9PP7bxyFG+3QpUzHY1NcRnLC/HBgERKNnRV0LIx0GXNUeyaspWIazCOFV5QIF2CZ8AD/z4iWm0IwQVwVCQRe55AezhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721565; c=relaxed/simple;
	bh=pCAr7LzPRJpBSpOND0OK/TVOvncaQwCo+as3ES+VTmA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZRSwK0gZlxZ3YTqZi+RaE1wAH5MWRA7gkhT+6lFcQbk+Ug9GRorM5YP6sOE2Jf9SPbrJmKIdqjmfO9uxYeJTf57zw/82TO73ZPWihmVuTRHZF5rfrsv9/Ko9gkrk8fy+WTzRftrlOOKWrW9oIW/Nf3KSgO7a5BsiPwx6HTW9Q1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=ZVUEjPTI; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1723721551; x=1726313551;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pCAr7LzPRJpBSpOND0OK/TVOvncaQwCo+as3ES+VTmA=;
	b=ZVUEjPTINfR8y68X6TG8UQmN1pe2t0EZAM/Gh1ZP9XsvsO8fGSk7RfmTlznco0rv
	0/34k7d+wpRxxmrwBsS2zoyG4iWw1F0Fjz2RDlnmVsBfrgyOgk0fCLXsCNsIvO/F
	JgcRzXX4Fb81YxTfkyNd1QRX62OEpfD9EBxCFLmpHe4=;
X-AuditID: ac14000a-03e52700000021bc-dd-66bde74fd287
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7C.2B.08636.F47EDB66; Thu, 15 Aug 2024 13:32:31 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 15 Aug
 2024 13:32:31 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>
CC: <nm@ti.com>, <robh@kernel.org>, <conor+dt@kernel.org>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v2] arm64: dts: ti: am642-phyboard-electra: Add PRU-ICSSG nodes
Date: Thu, 15 Aug 2024 13:32:11 +0200
Message-ID: <20240815113212.3720403-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWyRpKBR9f/+d40g8WfJC3W7D3HZDH/yDlW
	i+WfZ7NbvJx1j81i0+NrrBaXd81hs3jz4yyTxf89O9gtut+pW/w/+4Hdgctj06pONo/NS+o9
	+rtbWD2O39jO5PF5k1wAaxSXTUpqTmZZapG+XQJXRsOaI0wFK2wr1p6NaWB8Y9jFyMkhIWAi
	ce7FW8YuRi4OIYElTBIvZ11ng3AeM0q8nP2VHaSKTUBd4s6Gb6wgCRGBNkaJWWuusYAkmAUq
	JaZ0XwErEhbwl2jue8AIYrMIqEqcatzHCmLzClhKTL8+jRlinbzEzEvf2SHighInZz6BmiMv
	0bx1NjOELSFx8MULMFsIKP7i0nIWmN5p515DzQmV2PplO9MERoFZSEbNQjJqFpJRCxiZVzEK
	5WYmZ6cWZWbrFWRUlqQm66WkbmIEhb4IA9cOxr45HocYmTgYDzFKcDArifAGmuxKE+JNSays
	Si3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cC4n1P2kOuO7w13nMvt
	kldfuHfXT2Tejy67m31680QrjCtmFsWvu7Ci9YuVjRBvxJLngle3zjrHtvrO1R91/yrlmOR7
	NnZaLfNfbpn0NeQi+/QpE193fU4NWP7y/4dfoXUPN9tnp6/9FJZf8XX/oUfi3sFBujXZZuyC
	L//92lyTrbZoFpvn2ndrlFiKMxINtZiLihMB49p4jWsCAAA=

The phyBOARD-Electra implements two Ethernet ports utilizing PRUs.
Add configuration for both mac ports & PHYs.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
v2: 
  - Style fixes according to dts-coding-style
  - Moved vendor-specific properties & status to the end
  - Separated pinctrl array of phandles using <>
---
 .../dts/ti/k3-am642-phyboard-electra-rdk.dts  | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
index 30729b49dd69..60285d736e07 100644
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
+		pinctrl-0 = <&icssg0_rgmii1_pins_default>, <&icssg0_rgmii2_pins_default>;
+
+		interrupt-parent = <&icssg0_intc>;
+		interrupts = <24 0 2>, <25 1 3>;
+		interrupt-names = "tx_ts0", "tx_ts1";
+
+		sram = <&oc_sram>;
+		firmware-name = "ti-pruss/am65x-sr2-pru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru0-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-pru1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-rtu1-prueth-fw.elf",
+				"ti-pruss/am65x-sr2-txpru1-prueth-fw.elf";
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
+		ti,prus = <&pru0_0>, <&rtu0_0>, <&tx_pru0_0>, <&pru0_1>, <&rtu0_1>, <&tx_pru0_1>;
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
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			icssg0_emac0: port@0 {
+				reg = <0>;
+				phy-handle = <&icssg0_phy1>;
+				phy-mode = "rgmii-id";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				ti,syscon-rgmii-delay = <&main_conf 0x4100>;
+			};
+
+			icssg0_emac1: port@1 {
+				reg = <1>;
+				phy-handle = <&icssg0_phy2>;
+				phy-mode = "rgmii-id";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+				ti,syscon-rgmii-delay = <&main_conf 0x4104>;
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
@@ -198,6 +316,34 @@ AM64X_IOPAD(0x0040, PIN_OUTPUT, 7)	/* (U21) GPMC0_AD1.GPIO0_16 */
 	};
 };
 
+&icssg0_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&icssg0_mdio_pins_default &clkout0_pins_default>;
+	status = "okay";
+
+	icssg0_phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
+		reg = <0x1>;
+		tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		reset-gpios = <&main_gpio1 18 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <1000>;
+		reset-deassert-us = <1000>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+	};
+
+	icssg0_phy2: ethernet-phy@2 {
+		compatible = "ethernet-phy-id2000.a231", "ethernet-phy-ieee802.3-c22";
+		reg = <0x2>;
+		tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		reset-gpios = <&main_gpio1 19 GPIO_ACTIVE_LOW>;
+		reset-assert-us = <1000>;
+		reset-deassert-us = <1000>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
+	};
+};
+
 &main_i2c1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.34.1


