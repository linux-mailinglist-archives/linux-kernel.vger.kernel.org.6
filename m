Return-Path: <linux-kernel+bounces-193728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31408D3132
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66FF1C223B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6C16DED5;
	Wed, 29 May 2024 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dORxQD5c"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F616E896;
	Wed, 29 May 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971008; cv=none; b=hFL7EZJ6DG0VdiY1pOtP6pNvbeEQ9wcRjv5TlscD/4T30RjkaxYU7x0LXAE/qEtSW93U1RWQUlKfI6P8bzF0P9+AROt6mlcj1Gnkr6BmJ1n8GpIFfCGFQTy2mr4L2tB6Fhqg5+mPGK2iYXd+Rjp+gmQDRDf3GhILI99XCOTz/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971008; c=relaxed/simple;
	bh=WNW0zZk5rHXnwxxR5BfxZbWHgUtzyaX7P640I3WX5bc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6UnDkXxutTjqK2QAR9DXvieuvBNq1cnb7oTCKNHNyLzHyESmAct0lU3yt6C5x0Uv5DxwPT8IeRQr8TTqqF6PXAomgCyV7miwYIeIclEx121QrSWqwG0ziA0Ri/OT7TvTnEMqfCyjHlDFWOIXlJDC8OjuU5uCJ6ZVlbz5xiLq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dORxQD5c; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44T8N9Rc098569;
	Wed, 29 May 2024 03:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716970989;
	bh=iQiml4Nmsvc9o6LE63TNChQyg7cpSwsjXKi5J9+9AY8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dORxQD5cr7wMXCGP9ueqRwU9zEsHFtF4LEUUmvLvatFB7Zy/HkAkinZlspIbe8AI+
	 6DoODcKtovanU1LDk1HRTsKOruEQQ4bIIUKY9aqfL3ozVDZxzKKC4KgWnm59dAJy/c
	 ++tBYUXN3yqSz9kNaCA1wMN4WUaYMdT1fLw/OF3o=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44T8N9pH021676
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 03:23:09 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 03:23:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 03:23:09 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44T8N0d7084708;
	Wed, 29 May 2024 03:23:05 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <francesco@dolcini.it>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <sabiya.d@ti.com>,
        <u-kumar1@ti.com>, <danishanwar@ti.com>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 1/4] arm64: dts: ti: k3-j784s4-main: Add PCIe nodes
Date: Wed, 29 May 2024 13:52:56 +0530
Message-ID: <20240529082259.1619695-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240529082259.1619695-1-s-vadapalli@ti.com>
References: <20240529082259.1619695-1-s-vadapalli@ti.com>
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
v3:
https://lore.kernel.org/r/20240523111008.4057988-2-s-vadapalli@ti.com/
Changes since v3:
- Added ranges for PCIe2 and PCIe3 in k3-j784s4.dtsi which was missed in
  v3 series.

 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 136 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi      |  10 +-
 2 files changed, 145 insertions(+), 1 deletion(-)

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
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index da7368ed6b52..73cc3c1fec08 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -238,7 +238,10 @@ cbass_main: bus@100000 {
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
 			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
 			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
-			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* PCIe Core*/
+			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIe0 Core*/
+			 <0x00 0x0d800000 0x00 0x0d800000 0x00 0x00800000>, /* PCIe1 Core*/
+			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x00800000>, /* PCIe2 Core*/
+			 <0x00 0x0e800000 0x00 0x0e800000 0x00 0x00800000>, /* PCIe3 Core*/
 			 <0x00 0x10000000 0x00 0x10000000 0x00 0x08000000>, /* PCIe0 DAT0 */
 			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
 			 <0x00 0x64800000 0x00 0x64800000 0x00 0x0070c000>, /* C71_1 */
@@ -248,7 +251,12 @@ cbass_main: bus@100000 {
 			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
 			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00400000>, /* MSMC RAM */
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
+			 <0x40 0x00000000 0x40 0x00000000 0x01 0x00000000>, /* PCIe0 DAT1 */
 			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
+			 <0x42 0x00000000 0x42 0x00000000 0x01 0x00000000>, /* PCIe2 DAT1 */
+			 <0x43 0x00000000 0x43 0x00000000 0x01 0x00000000>, /* PCIe3 DAT1 */
+			 <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* PCIe2 DAT0 */
+			 <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* PCIe3 DAT0 */
 			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
 
 			 /* MCUSS_WKUP Range */
-- 
2.40.1


