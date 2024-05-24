Return-Path: <linux-kernel+bounces-188522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CC8CE301
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BBF1F2203E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98012BEBA;
	Fri, 24 May 2024 09:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qORj5Z04"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A487129A8D;
	Fri, 24 May 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541562; cv=none; b=dCZ6iyvvrJYykkWyWagmlhPB/df3qDdT8BDkzMe8YV8b+NqJxrZkfB4P7peCkRNK9Cjh2cBVxzStFRkpTyZ2FJ06dq9ODoPQW+ZWBCzxjzgwLA3mfbc02YLSDg9DPbCamkPfLT719gQgGqFuF4vMCcs8JJ3EFcU+ETSx8M+/UUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541562; c=relaxed/simple;
	bh=xZA4BkXOmae5sDVcBgar+n9txAQk3eLKOo8BzZvDjQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVsq0jLMTD72SIJgJXzmnRysfxW7iTwBPIsXCdYLlWjscAUv0jRsfPU+RAW48kkA4gKpjrfZd+VwnC5/9xoogZvHoYUJqcmUAE3iARBoC4jgCM2Ls45D2ys4wlgNYcPUKNqPmBDBlc+zJud4pR9vsAu669LnW1eIewMBZFQqsoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qORj5Z04; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O95one001503;
	Fri, 24 May 2024 04:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716541550;
	bh=wc2dY3olrF19WzQwpC81iLuubWXUUGHsClDovydRv+Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qORj5Z04dneFzn3FQgVf9t0N/bd2S6sV/hcobafNt5zvPbk99kMyMWwN3gYlW3jOa
	 w3/FR32Y3GdodpQN4OULuWAlxvMwD6+Ruu5d67s026MtO2EhzMkt9sTNiEWjZ1Nu0f
	 RrU0SCzU7DNdq+o0pVkWg9pE10JRvMZBcBOulylU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O95ocA028968
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 04:05:50 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 04:05:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 04:05:50 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O95F7M017455;
	Fri, 24 May 2024 04:05:46 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 7/7] arm64: dts: ti: k3-j722s: Add support for PCIe0
Date: Fri, 24 May 2024 14:35:14 +0530
Message-ID: <20240524090514.152727-8-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524090514.152727-1-s-vadapalli@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The PCIe0 instance of PCIe on TI's J722S SoC is a Gen3 single lane PCIe
controller. Add the device-tree nodes for it and enable it in Root Complex
mode of operation using Lane 0 of the Serdes1 instance of Serdes.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Current patch is v1. No changelog.

 arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 17 +++++++++++
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 37 +++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index 16c6ab8ee07e..d2d7de5cfe27 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -416,6 +416,16 @@ serdes0_usb_link: phy@0 {
 	};
 };
 
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
 &usbss0 {
 	ti,vbus-divider;
 	status = "okay";
@@ -439,3 +449,10 @@ &usb1 {
 	phys = <&serdes0_usb_link>;
 	phy-names = "cdns3,usb3-phy";
 };
+
+&pcie0_rc {
+	status = "okay";
+	reset-gpios = <&exp1 18 GPIO_ACTIVE_HIGH>;
+	phys = <&serdes1_pcie_link>;
+	phy-names = "pcie-phy";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 19a7e8413ad2..0b32893eb75e 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -4,6 +4,7 @@
  * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <dt-bindings/phy/phy-cadence.h>
 #include <dt-bindings/phy/phy-ti.h>
 
 /*
@@ -96,6 +97,35 @@ serdes1: serdes@f010000 {
 		};
 	};
 
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
@@ -138,3 +168,10 @@ serdes_ln_ctrl: mux-controller@4080 {
 				<0x10 0x3>; /* SERDES1 lane0 select */
 	};
 };
+
+&wkup_conf {
+	pcie0_ctrl: pcie0-ctrl@4070 {
+		compatible = "ti,j784s4-pcie-ctrl", "syscon";
+		reg = <0x4070 0x4>;
+	};
+};
-- 
2.40.1


