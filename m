Return-Path: <linux-kernel+bounces-187375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67578CD0E8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCE6282F44
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B82146A75;
	Thu, 23 May 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HBsG00YF"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD23A144D09;
	Thu, 23 May 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462632; cv=none; b=Fh4NUaCuVQEdyzFTJFLLk3/rZ9gbCNAZcf9Hxl+/Uyk7IwZit3ROMMYTqLJxKLhtLOajYZm5KFQaLkro2Wz910BH+rTZMET6+ibedj1k/Nf6T8Z14RwbJj2XynL8UShI1qiOxvcNvpBkEeDUnweAdGGlLfdYL3O5cq0TvbjWDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462632; c=relaxed/simple;
	bh=ruO5STNrqAKsfC59jHBPLzGM7XAaqskhICqbSoVhV2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOMohmGcJPiRUkqsZMKKbJihIEwpQlStp5h1xsFZ7wuJqNhdODKsDxK+pJy1v+fAELv36rbAEVyMyTSsqvanDt3Z6f9UnSAzvyKdKsMVUJat+nETxwozHqcG14TzQsS6iuvcxXHiSY1kJEUhDRwuGuxFX0zXazXz9RfmzFG18MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HBsG00YF; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44NBAIrK092643;
	Thu, 23 May 2024 06:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716462618;
	bh=SgVAHz9Qy7B85Zjd7oF+BLCFlJG7GCZO8ndndgSvy2g=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HBsG00YFvquxdmAOmyYO1AoDrgJLhlcJyKLrSaZgPc+34xHpf4IEwuO3ApzsIxtVG
	 o05IuIieTKjzvk7EE4IHYOlBqXA5t8MqSUPyEhB+4xRKCCP3Xwrpa/t2PekKt7bgF9
	 iNca6nA9woBpKhwwUBEtlt+xXkFLvux4kplMIbuo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44NBAIQK051298
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 06:10:18 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 06:10:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 06:10:17 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44NBA9Eb082115;
	Thu, 23 May 2024 06:10:14 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <francesco@dolcini.it>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <danishanwar@ti.com>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 1/3] arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
Date: Thu, 23 May 2024 16:40:06 +0530
Message-ID: <20240523111008.4057988-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240523111008.4057988-1-s-vadapalli@ti.com>
References: <20240523111008.4057988-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

TI's J784S4 SoC has four instances of Gen3 PCIe Controllers namely
PCIe0, PCIe1, PCIe2 and PCIe3. PCIe0 and PCIe1 are 4-Lane controllers
while PCIe2 and PCIe3 are 2-Lane controllers.

Add support for the Root Complex Mode of operation of these PCIe instances.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 136 +++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
index 6a4554c6c9c1..7f89f8dc24df 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
@@ -48,6 +48,26 @@ scm_conf: bus@100000 {
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
+		pcie2_ctrl: pcie2-ctrl@4078 {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x4078 0x4>;
+		};
+
+		pcie3_ctrl: pcie3-ctrl@407c {
+			compatible = "ti,j784s4-pcie-ctrl", "syscon";
+			reg = <0x407c 0x4>;
+		};
+
 		serdes_ln_ctrl: mux-controller@4080 {
 			compatible = "reg-mux";
 			reg = <0x00004080 0x30>;
@@ -907,6 +927,122 @@ main_sdhci1: mmc@4fb0000 {
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
+		status = "disabled";
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
+		status = "disabled";
+	};
+
+	pcie2_rc: pcie@2920000 {
+		compatible = "ti,j784s4-pcie-host";
+		reg = <0x00 0x02920000 0x00 0x1000>,
+		      <0x00 0x02927000 0x00 0x400>,
+		      <0x00 0x0e000000 0x00 0x00800000>,
+		      <0x44 0x00000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie2_ctrl 0x0>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 334 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 334 0>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb012>;
+		msi-map = <0x0 &gic_its 0x20000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x00001000 0x44 0x00001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x00011000 0x44 0x00011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		status = "disabled";
+	};
+
+	pcie3_rc: pcie@2930000 {
+		compatible = "ti,j784s4-pcie-host";
+		reg = <0x00 0x02930000 0x00 0x1000>,
+		      <0x00 0x02937000 0x00 0x400>,
+		      <0x00 0x0e800000 0x00 0x00800000>,
+		      <0x44 0x10000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie3_ctrl 0x0>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 335 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 335 0>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xff>;
+		vendor-id = <0x104c>;
+		device-id = <0xb012>;
+		msi-map = <0x0 &gic_its 0x30000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x00001000 0x44 0x10001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x00011000 0x44 0x10011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		status = "disabled";
+	};
+
 	serdes_wiz0: wiz@5060000 {
 		compatible = "ti,j784s4-wiz-10g";
 		#address-cells = <1>;
-- 
2.40.1


