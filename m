Return-Path: <linux-kernel+bounces-211561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B619053C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3531C20828
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED1217E8F8;
	Wed, 12 Jun 2024 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N8DIxdKk"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550917E8F2;
	Wed, 12 Jun 2024 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198693; cv=none; b=b6stImzM1zxWrWpLeVILTTFeOnAi3w6KaZ6L7OTFwuqGUVGx1jvEorupOVddWUIT9IPXkbHVJ3/gweAhpRZz7YMY9AYNAEvp2n4Yrxqs7LPRGDrwLWjOhYEWIT+OUusXoGnk6HcTy6Xb8/cMCRStW6bpFh8tLbYZv0skmQThbZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198693; c=relaxed/simple;
	bh=Q+8FM93nKywVlI/nXL2/Vx49wacxNg9AwN+P6tSTrOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7bs6rhgZr2qVJM7TEJsCuqq8wMyRTo+xUpRxfPGD0XnsKlo9xFK9s4M4oXwFFQZL8c9O8NGTmYnGDP3HHin6yGbliM7Q3VlieBtKSfU4xo7IgNOPNDlELtSKMx6uE7OI1Q7SL48BE5GK8P27zj0p60MN/O+kaVWlfiOZAoiZ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N8DIxdKk; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOkeV115313;
	Wed, 12 Jun 2024 08:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718198686;
	bh=kYN9IxkRa7Hxu1t+XCG1/vaKL4/nK6uH3vOzUxeK6Ug=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=N8DIxdKk7XwBchIUGAS8aOLtzaq9Ceg43ouxZHl4R/z72ml5ldImDKCKVsiC/laDd
	 a3CZSf4R7W+4/8fn+tKjw0lAQBh5VCJ9LTwUcVrY/MNSR3re6GCH0ZArdRZf2MNe8d
	 /zy72yv15eY5IEzNd0KiS8pl9k9tjLMJ3b35ZwiM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDOjCI065630
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:24:45 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:24:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:24:45 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOAmx046478;
	Wed, 12 Jun 2024 08:24:41 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v6 7/8] arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support
Date: Wed, 12 Jun 2024 18:54:08 +0530
Message-ID: <20240612132409.2477888-8-s-vadapalli@ti.com>
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

J722S SoC has two instances of SERDES namely SERDES0 and SERDES1 and one
instance of PCIe namely PCIe0. Both SERDES0 and SERDES1 are single lane
SERDES. The PCIe0 instance of PCIe is a Gen3 single lane PCIe controller.

Since SERDES and PCIe are not present on AM62P SoC, add the device-tree
nodes corresponding to them in the J722S SoC specific "k3-j722s-main.dtsi"
file.

Co-developed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Roger Quadros <rogerq@kernel.org>
---
v5:
https://lore.kernel.org/r/20240604085252.3686037-7-s-vadapalli@ti.com/
Changes since v5:
- Collected Acked-by tag from Roger Quadros <rogerq@kernel.org>

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 133 ++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index b75dab8230c2..e1465daa0c96 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -5,7 +5,123 @@
  * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <dt-bindings/phy/phy-cadence.h>
+#include <dt-bindings/phy/phy-ti.h>
+
+/ {
+	serdes_refclk: clk-0 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+};
+
 &cbass_main {
+	serdes_wiz0: phy@f000000 {
+		compatible = "ti,am64-wiz-10g";
+		ranges = <0x0f000000 0x0 0x0f000000 0x00010000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 279 0>, <&k3_clks 279 1>, <&serdes_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		num-lanes = <1>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+
+		assigned-clocks = <&k3_clks 279 1>;
+		assigned-clock-parents = <&k3_clks 279 5>;
+
+		serdes0: serdes@f000000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x0f000000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz0 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz0 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz0 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz0 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 279 1>,
+						 <&k3_clks 279 1>,
+						 <&k3_clks 279 1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+
+			status = "disabled"; /* Needs lane config */
+		};
+	};
+
+	serdes_wiz1: phy@f010000 {
+		compatible = "ti,am64-wiz-10g";
+		ranges = <0x0f010000 0x0 0x0f010000 0x00010000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 280 0>, <&k3_clks 280 1>, <&serdes_refclk>;
+		clock-names = "fck", "core_ref_clk", "ext_ref_clk";
+		num-lanes = <1>;
+		#reset-cells = <1>;
+		#clock-cells = <1>;
+
+		assigned-clocks = <&k3_clks 280 1>;
+		assigned-clock-parents = <&k3_clks 280 5>;
+
+		serdes1: serdes@f010000 {
+			compatible = "ti,j721e-serdes-10g";
+			reg = <0x0f010000 0x00010000>;
+			reg-names = "torrent_phy";
+			resets = <&serdes_wiz1 0>;
+			reset-names = "torrent_reset";
+			clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
+				 <&serdes_wiz1 TI_WIZ_PHY_EN_REFCLK>;
+			clock-names = "refclk", "phy_en_refclk";
+			assigned-clocks = <&serdes_wiz1 TI_WIZ_PLL0_REFCLK>,
+					  <&serdes_wiz1 TI_WIZ_PLL1_REFCLK>,
+					  <&serdes_wiz1 TI_WIZ_REFCLK_DIG>;
+			assigned-clock-parents = <&k3_clks 280 1>,
+						 <&k3_clks 280 1>,
+						 <&k3_clks 280 1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+
+			status = "disabled"; /* Needs lane config */
+		};
+	};
+
+	pcie0_rc: pcie@f102000 {
+		compatible = "ti,j722s-pcie-host", "ti,j721e-pcie-host";
+		reg = <0x00 0x0f102000 0x00 0x1000>,
+		      <0x00 0x0f100000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x68000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		ranges = <0x01000000 0x00 0x68001000  0x00 0x68001000  0x00 0x0010000>,
+			 <0x02000000 0x00 0x68011000  0x00 0x68011000  0x00 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 99 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		max-link-speed = <3>;
+		num-lanes = <1>;
+		power-domains = <&k3_pds 259 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 259 0>, <&serdes1 CDNS_TORRENT_REFCLK_DRIVER>;
+		clock-names = "fck", "pcie_refclk";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb010>;
+		cdns,no-bar-match-nbits = <64>;
+		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		status = "disabled";
+	};
+
 	usbss1: usb@f920000 {
 		compatible = "ti,j721e-usb";
 		reg = <0x00 0x0f920000 0x00 0x100>;
@@ -39,6 +155,23 @@ usb1: usb@31200000{
 	};
 };
 
+&main_conf {
+	serdes_ln_ctrl: mux-controller@4080 {
+		compatible = "reg-mux";
+		reg = <0x4080 0x14>;
+		#mux-control-cells = <1>;
+		mux-reg-masks = <0x00 0x3>, /* SERDES0 lane0 select */
+				<0x10 0x3>; /* SERDES1 lane0 select */
+	};
+};
+
+&wkup_conf {
+	pcie0_ctrl: pcie0-ctrl@4070 {
+		compatible = "ti,j784s4-pcie-ctrl", "syscon";
+		reg = <0x4070 0x4>;
+	};
+};
+
 /* MAIN domain overrides */
 
 &inta_main_dmss {
-- 
2.40.1


