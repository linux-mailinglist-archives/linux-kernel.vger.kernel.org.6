Return-Path: <linux-kernel+bounces-183594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C022D8C9B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747CF281084
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F2252F74;
	Mon, 20 May 2024 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NWjGRL3v"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B03A4D599;
	Mon, 20 May 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199940; cv=none; b=jjTV1DrHCQVbmgDPtezncphKTIuf+UQ5vHTBa9uFUV/A6sOZzdzBQ+UoXFydQ+NY10iUq2ou+2/Dqtj2v+mMo4D/tguNmUfQT6imZ4RcY49ca4kPG+mGQLMoz4wJMN9zLTXjAm68r1VO+hNsZ/l18ilxzi3wsLE7KZjD+O27DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199940; c=relaxed/simple;
	bh=ZcPkxS3P380XaqV2xgAlw0pg5V+/1DyDcMR0C71xpSk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjleOYpA+xhKgsQ1wXXlIy71X9IZS+d1egcTEr1zfVw8EA+Zcfjslp70olGmlrEBBPyDuPVQirkKb/gPo5XwwaJfmAXADdOkS7LhknjLOI2dpaIBoVdQx+pK9fhti5kkX4cLdwADccQxvGh6Ahrlfy0Fxbooz8/Wr8bPIeIzYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NWjGRL3v; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44KABvQL112063;
	Mon, 20 May 2024 05:11:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716199917;
	bh=FIp0UYainfN6/ezcOoLRYohzBz3y0kiBmLwFxEBCHmE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=NWjGRL3vSZh8jfm+88v56KoWVwFMUG69PhAje8WQtlybuMXPJXFZwpS+PgkldO6tH
	 nbiEdYnMjgnGfZolxXdGcQ6IWODrmrr/+jv92/dp1a1iDAdnGF97vNLykq6Qmg/VjN
	 VRHf/LT8U10Rxxe9kkVgmLW/mMp6ryPEDUpVPJoI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44KABvnK009300
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 May 2024 05:11:57 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 20
 May 2024 05:11:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 20 May 2024 05:11:57 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44KABnjT060604;
	Mon, 20 May 2024 05:11:53 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <danishanwar@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
Date: Mon, 20 May 2024 15:41:47 +0530
Message-ID: <20240520101149.3243151-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240520101149.3243151-1-s-vadapalli@ti.com>
References: <20240520101149.3243151-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI's J784S4 has two instances of Gen3 x4 Lane PCIe Controllers namely
PCIE0 and PCIE1. Add support for the Root Complex Mode of operation of
these PCIe instances.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
v1:
https://lore.kernel.org/r/20240129114749.1197579-2-s-vadapalli@ti.com/
Changes since v1:
- Added "pcie0_ctrl" and "pcie1_ctrl" nodes within the "scm_conf" node
  in order to reuse the existing "ti,syscon-pcie-ctrl" property without
  having to map the entire "scm_conf" region for configuring the PCIe
  Control registers pointed to by the "pcie0_ctrl" and "pcie1_ctrl"
  nodes.

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 6a4554c6c9c1..c99bd1284c28 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -48,6 +48,16 @@ scm_conf: bus@100000 {
 		#size-cells = <1>;
 		ranges = <0x00 0x00 0x00100000 0x1c000>;
 
+		pcie0_ctrl: pcie0-ctrl@4070 {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x4070 0x4>;
+		};
+
+		pcie1_ctrl: pcie1-ctrl@4074 {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x4074 0x4>;
+		};
+
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
 			reg = <0x00004080 0x30>;
@@ -907,6 +917,90 @@ main_sdhci1: mmc@4fb0000 {
 		status = "disabled";
 	};
 
+	pcie0_rc: pcie@2900000 {
+		compatible = "ti,j784s4-pcie-host";
+		reg = <0x00 0x02900000 0x00 0x1000>,
+		      <0x00 0x02907000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x10000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie0_ctrl 0x0>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 332 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 332 0>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb012>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x10001000 0x0 0x10001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x10011000 0x0 0x10011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+				<0 0 0 2 &pcie0_intc 0>,
+				<0 0 0 3 &pcie0_intc 0>,
+				<0 0 0 4 &pcie0_intc 0>;
+		status = "disabled";
+
+		pcie0_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 312 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
+	pcie1_rc: pcie@2910000 {
+		compatible = "ti,j784s4-pcie-host";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl 0x0>;
+		max-link-speed = <3>;
+		num-lanes = <4>;
+		power-domains = <&k3_pds 333 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 333 0>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb012>;
+		msi-map = <0x0 &gic_its 0x10000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x18001000  0x00 0x18001000  0x0 0x0010000>,
+			 <0x02000000 0x0 0x18011000  0x00 0x18011000  0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 7>;
+		interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+				<0 0 0 2 &pcie1_intc 0>,
+				<0 0 0 3 &pcie1_intc 0>,
+				<0 0 0 4 &pcie1_intc 0>;
+		status = "disabled";
+
+		pcie1_intc: interrupt-controller {
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			interrupt-parent = <&gic500>;
+			interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
+		};
+	};
+
 	serdes_wiz0: wiz@5060000 {
 		compatible = "ti,j784s4-wiz-10g";
 		#address-cells = <1>;
-- 
2.40.1


