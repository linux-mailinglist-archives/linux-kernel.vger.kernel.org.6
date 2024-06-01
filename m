Return-Path: <linux-kernel+bounces-197833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D518D6FC5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F33A1F218F5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0A27C6D5;
	Sat,  1 Jun 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uFf1ah5K"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB52515218E;
	Sat,  1 Jun 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717244193; cv=none; b=FlAEXtpdst1kyxu5Rh0WcvseppKcvxa2NhuWpApWBtUZcyni82pnIX+XD7qtQZ5GxzQ2V74coUWAaMRp1TNIeEcFIo9hwXspacKiAiP2eVyWCUWu4HRCet2gMnLRo821KgqpWkH5yhoKS3KVIWZsQiJ7AE/Ge67VI9KicLCqNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717244193; c=relaxed/simple;
	bh=fdewn3kZ4VOAPVvT3269skqugIVq7i78Xs4TbwSXe7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqmDT9RQTwwk7faCtmCtrXl6BywmNIVMnfB5a273m761sY5IeN3/DBaTZW4ZDSAv2j6HkDHG3bM3WJ8bUBA0G3khIZtJGqXk2KZpP4yI4tAMxRe6wqoMb7nrOjFo4Qw3MeP10w7uIeIW5U8JvsyBxYVuyyd3gw0h4PPaMFLiqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uFf1ah5K; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 451CGQxT024794;
	Sat, 1 Jun 2024 07:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717244186;
	bh=EXhtDbOrPqTscAqtvx2BKTcA+Fkry31YTPhK0vA9/i8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uFf1ah5Kq2xnyMdcUkGcLO5D+/CCBVpZ3A6IFyQovjo94npjpbCnfnQ40CONBrpCI
	 FiRaDdzgvNC7tqkhDcEuzcApWvD5vpAPDUvqLgahUwbKDWYrlwHKET1djFy2fo+3bp
	 9Lo99/GIyYz6YugtVrNyIDofGxuC6Q8VzVIHUCik=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 451CGQLI091586
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 1 Jun 2024 07:16:26 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Jun 2024 07:16:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Jun 2024 07:16:26 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 451CFtkK009323;
	Sat, 1 Jun 2024 07:16:22 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 6/7] arm64: dts: ti: k3-j722s-main: Add SERDES and PCIe support
Date: Sat, 1 Jun 2024 17:45:53 +0530
Message-ID: <20240601121554.2860403-7-s-vadapalli@ti.com>
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

J722S SoC has two instances of SERDES namely SERDES0 and SERDES1 and one
instance of PCIe namely PCIe0. Both SERDES0 and SERDES1 are single lane
SERDES. The PCIe0 instance of PCIe is a Gen3 single lane PCIe controller.

Since SERDES and PCIe are not present on AM62P SoC, add the device-tree
nodes corresponding to them in the J722S SoC specific "k3-j722s-main.dtsi"
file.

Co-developed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
v3:
https://lore.kernel.org/r/20240524090514.152727-2-s-vadapalli@ti.com/
https://lore.kernel.org/r/20240524090514.152727-7-s-vadapalli@ti.com/
and
https://lore.kernel.org/r/20240524090514.152727-8-s-vadapalli@ti.com/
Changes since v3:
- The k3-j722s-main.dtsi specific changes in the above patches have been
  squashed into this patch.

 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 131 ++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 3ca3f0041956..91489014f09e 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -4,7 +4,121 @@
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
@@ -37,3 +151,20 @@ usb1: usb@31200000{
 		};
 	};
 };
+
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
-- 
2.40.1


