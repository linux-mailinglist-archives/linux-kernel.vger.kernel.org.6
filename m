Return-Path: <linux-kernel+bounces-200288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F43C8FAE1E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC415282116
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CCE1448E0;
	Tue,  4 Jun 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J01bgPaW"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3E1448D8;
	Tue,  4 Jun 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491218; cv=none; b=QpgIlZR0Bhg78B515akhVihuqU0+bDqIEPSTaTGEJMyQ7lgDdP12aZzqfLo/sROXxc4HghP8dYxDShSuy8pWOi6zZViK+U1+Atog9izjE0HLSApdvrCU12CbJ9BRFR2vMqnNAEUZjyemEp6YWYJSRkQ1Cy9G0eGHupGUCfoHHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491218; c=relaxed/simple;
	bh=MMpITXPM4C0ivfbrTMWWRhwxZMMMyv+M0uOugvKNaU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeaxVJXmgZqlYNTINXt7qGvjwahzYN0D0uubLfpvdSd+MpoIet8mgF3inX8pRVtFlbxH1jBJ6xacnOKbuAFVZYKO28FJfd8L1NIttjobF2PDE6WKLK00F5V6L+3BwRmD8j6lisQ9kqbxNEO+qAZBIyFYl07jBY2ghg66WlwAoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J01bgPaW; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4548rSd2069328;
	Tue, 4 Jun 2024 03:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717491209;
	bh=XOI5HnJnHNLJ54u/KSVaU0exWK4JxEf2xnlqQDUnx8w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=J01bgPaWdbVipsdj8jQ+Hsj7IB/kDywipsK4nuT82DfpviqLrbuVnVeuc5b3ZCApT
	 tBPvzLyxfsImVc7MLU8GXA/g+GZrxLDHa6J8j5IrE30UWSdryRCDjFGaE8ImvGm7cQ
	 1Qug7UHTnbQXw4+XWgTWRDjWlYDS4yrqfaz+8r2w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4548rSg2016178
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 03:53:28 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 03:53:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 03:53:28 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4548qqQo066926;
	Tue, 4 Jun 2024 03:53:24 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 7/7] arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM
Date: Tue, 4 Jun 2024 14:22:52 +0530
Message-ID: <20240604085252.3686037-8-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240604085252.3686037-1-s-vadapalli@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Enable PCIe0 instance of PCIe in Root Complex mode of operation with Lane 0
of the SERDES1 instance of SERDES. Also enable USB0 instance of USB to
interface with the Type-C port via the USB hub, by configuring the pin P05
of the GPIO expander on the EVM. Enable USB1 instance of USB in SuperSpeed
mode of operation with Lane 0 of the SERDES0 instance of SERDES.

Co-developed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
v4:
https://lore.kernel.org/r/20240601121554.2860403-8-s-vadapalli@ti.com/
Changes since v4:
- Based on Andrew's feedback at:
  https://lore.kernel.org/r/183a9d15-939e-433b-84ba-8a64eb8ef3ec@ti.com/
  the `status = "okay";` line has been moved to the end of the
  `pcie0_rc` node referenced in k3-j722s-evm.dts following the updated
  ordering rules.
- The SERDES1 node has been enabled in the k3-j722s-evm.dts file since
  it has been disabled in the k3-j722s-main.dtsi file in the previous
  patch.

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index bf3c246d13d1..253b02f0437d 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -9,7 +9,9 @@
 /dts-v1/;
 
 #include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/phy/phy.h>
 #include "k3-j722s.dtsi"
+#include "k3-serdes.h"
 
 / {
 	compatible = "ti,j722s-evm", "ti,j722s";
@@ -202,6 +204,12 @@ J722S_IOPAD(0x0130, PIN_OUTPUT, 0) /* (AG26) RGMII1_TXC */
 			J722S_IOPAD(0x012c, PIN_OUTPUT, 0) /* (AF25) RGMII1_TX_CTL */
 		>;
 	};
+
+	main_usb1_pins_default: main-usb1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0258, PIN_INPUT, 0) /* (B27) USB1_DRVVBUS */
+		>;
+	};
 };
 
 &cpsw3g {
@@ -301,6 +309,13 @@ exp1: gpio@23 {
 				  "PCIe0_1L_RC_RSTz", "PCIe0_1L_PRSNT#",
 				  "ENET1_EXP_SPARE2", "ENET1_EXP_PWRDN",
 				  "PD_I2ENET1_I2CMUX_SELC_IRQ", "ENET1_EXP_RESETZ";
+
+		p05-hog {
+			/* P05 - USB2.0_MUX_SEL */
+			gpio-hog;
+			gpios = <5 GPIO_ACTIVE_HIGH>;
+			output-high;
+		};
 	};
 };
 
@@ -384,3 +399,61 @@ &sdhci1 {
 	status = "okay";
 	bootph-all;
 };
+
+&serdes_ln_ctrl {
+	idle-states = <J722S_SERDES0_LANE0_USB>,
+		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;
+};
+
+&serdes0 {
+	status = "okay";
+	serdes0_usb_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_USB3>;
+		resets = <&serdes_wiz0 1>;
+	};
+};
+
+&serdes1 {
+	status = "okay";
+	serdes1_pcie_link: phy@0 {
+		reg = <0>;
+		cdns,num-lanes = <1>;
+		#phy-cells = <0>;
+		cdns,phy-type = <PHY_TYPE_PCIE>;
+		resets = <&serdes_wiz1 1>;
+	};
+};
+
+&pcie0_rc {
+	reset-gpios = <&exp1 18 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes1_pcie_link>;
+	phy-names = "pcie-phy";
+	status = "okay";
+};
+
+&usbss0 {
+	ti,vbus-divider;
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "otg";
+	usb-role-switch;
+};
+
+&usbss1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_usb1_pins_default>;
+	ti,vbus-divider;
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "host";
+	maximum-speed = "super-speed";
+	phys = <&serdes0_usb_link>;
+	phy-names = "cdns3,usb3-phy";
+};
-- 
2.40.1


