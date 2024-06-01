Return-Path: <linux-kernel+bounces-197834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0440A8D6FC7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DA21F21979
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A51152DF5;
	Sat,  1 Jun 2024 12:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d6BDR0Re"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19C14F9CA;
	Sat,  1 Jun 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717244198; cv=none; b=YIzONn0ryl/Wq//fF6v8RzJ1G/AC9Lg3B8W5n+dUT3zNyTW939uSwgFPOOnp7lwxI2uP/9rbKibH0/gi3Z6cGEgVVFws1VX9NG3eyCRlzZxvsP3vRK8thmbtrRW6D+Lz1kHn/5ukgMf9XwYaGCDahR+F+sNgjVfHyXFZtteZdHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717244198; c=relaxed/simple;
	bh=13mmVT1PUQiOftL33hsOPpELQyZBLcyyM2rYl9byZjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6M0n7zw+pfgu/gT599dcw0tdoYLFHn7NaHT+sn6bElwIM5TufvVBZWvsP5TsyRADMMckj8+y5ywoop4hr4myWIWqxZl3GkjlkOX9T0ycdtLr+FQRKX1ukVvo597VtBBnkPFzLixIZAvJez9DWyyCK2EF6TKvU0BoZUHN4iutIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=d6BDR0Re; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 451CGUO1120010;
	Sat, 1 Jun 2024 07:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717244190;
	bh=8B8UAkBYxOJZjWDsFXMi5T9OfURc8ZbfCGJJV5hjsLM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=d6BDR0RevKQIQ3oKPmKZvvBHVq6ZNGtpCb7C57SGGpHwZFrWb2SNKShGWwAbrssZ+
	 3yRV2WfOmo5h5ILrFz1Hqhr5T4JjQBFVhbSPgAG+5C2jp3z4oRK/lrs1+wEdo9z+EI
	 qQnPudTq9FZ+FuNKu3L0LNBxS4zC2wPJWb+DKa9U=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 451CGUWi019930
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 1 Jun 2024 07:16:30 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Jun 2024 07:16:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Jun 2024 07:16:30 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 451CFtkL009323;
	Sat, 1 Jun 2024 07:16:26 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 7/7] arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM
Date: Sat, 1 Jun 2024 17:45:54 +0530
Message-ID: <20240601121554.2860403-8-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240601121554.2860403-1-s-vadapalli@ti.com>
References: <20240601121554.2860403-1-s-vadapalli@ti.com>
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
v3:
https://lore.kernel.org/r/20240524090514.152727-4-s-vadapalli@ti.com/
and
https://lore.kernel.org/r/20240524090514.152727-8-s-vadapalli@ti.com/
Changes since v3:
- Above patches have been squashed into this patch.

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 72 +++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index bf3c246d13d1..3145e680e2d3 100644
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
 
@@ -384,3 +399,60 @@ &sdhci1 {
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
+	status = "okay";
+	reset-gpios = <&exp1 18 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes1_pcie_link>;
+	phy-names = "pcie-phy";
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


