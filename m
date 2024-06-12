Return-Path: <linux-kernel+bounces-211562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0FD9053C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8732B21C44
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7202417E913;
	Wed, 12 Jun 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qqpxEutQ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291DC17D37E;
	Wed, 12 Jun 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198699; cv=none; b=UewIw9NzYiCZNIui6D2sr3Rm7cz+Q/fIhOha0O/LomXhlkjwxHLrOrKEXW4FBlyWKE7ldfe3pyGVcqTKFJDgo7vV+YXQTwoKh2jzXAUJ6hrV0AdRnixVUT95twc9m4EUbd65TIjubF2+kGSEWE8acB8ZMuOJZJTJDhx7LePPysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198699; c=relaxed/simple;
	bh=u7cOhAUlcCLOtHvuKlvu2uyBSo9uHR1KkshWdVt+35g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4nzqtohDVfaT0+WGcqRNylX8lUDYyaVZSPR5LH5T49yqSxGOoos+CXJGw/FzO/GPoyeZtgyle4bj9ZjqeEMp1deliQcfJcTzlNXaVBH91jangCAQ/v0xxnIiuuaajx5163TavU33fFtEBjw64DYmBsqx5lN/J9uBu1CJ12GVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qqpxEutQ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOoVb058171;
	Wed, 12 Jun 2024 08:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718198690;
	bh=w9gp9P44R9xsyv4UKTJqmc7QxN/dMZhqt9ukCqRVI7A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qqpxEutQPFnbXY/odu7WQ+03wWbpmiA9XEQ4PoVsrfVZItENIYrWMEdoeCS6ERI97
	 UJFKUVVSsbSMiV2aX80nmZO4HfVnNeIHmLjmtgI/Il6DILbFIeMEKDubhsB6jcvV5U
	 zDSlqbmijaEg2LmiL+dyqeHAziyBc6OV/lR20orI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDOo4E094739
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:24:50 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:24:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:24:49 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOAn0046478;
	Wed, 12 Jun 2024 08:24:46 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v6 8/8] arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM
Date: Wed, 12 Jun 2024 18:54:09 +0530
Message-ID: <20240612132409.2477888-9-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240612132409.2477888-1-s-vadapalli@ti.com>
References: <20240612132409.2477888-1-s-vadapalli@ti.com>
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
Acked-by: Roger Quadros <rogerq@kernel.org>
---
v5:
https://lore.kernel.org/r/20240604085252.3686037-7-s-vadapalli@ti.com/
Changes since v5:
- Collected Acked-by tag from Roger Quadros <rogerq@kernel.org>

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


