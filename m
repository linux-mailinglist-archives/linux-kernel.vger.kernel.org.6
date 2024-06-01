Return-Path: <linux-kernel+bounces-197830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D263B8D6FBE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 14:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C582820C4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 12:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F61B152174;
	Sat,  1 Jun 2024 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c+Upr+/W"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E831509BD;
	Sat,  1 Jun 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717244183; cv=none; b=jVnN7SRCy3+uOuLdGd2cAOTALseqwXeaBGZyPzslUSU5tCmxNtBZ+YrygYpGEG95V5FMyAXqQqFPtDtVjvOjzB/3PBLVsC365I8H+M1g+QhZTVJ70Am1MC5nSfKXQV19p16JPwY+JKeSJZwMRXEVm31h/VzRhTdngHTb9i+ndVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717244183; c=relaxed/simple;
	bh=RhIREgC52qPhkBYgDaSoafNDjsYk2tGmUy7a0pq8GhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umWHcj4nKK2OqzbtdsRyWo+clV493qlNgXEY4c8++oWm9iNtWKPnyhmFKN9AUvc1YlN7YNA8h03hKZr6RY8NsYNuYkxbIDtTBQV+vq114YPH7AaYLic1Iu6ZKoGLGDmcAXfcJTDKscj1EU8tJK6eEn9JoI4PzrIgtnRxr2P44jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c+Upr+/W; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 451CG85L124540;
	Sat, 1 Jun 2024 07:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717244168;
	bh=HZeEi6H0mtTGz+4mjB5oPiuaJnMdbWaAbSXhIDC3kEo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=c+Upr+/WTvZO47pX6brakePqM+zTwJyq1Wb2LHPKvs4bbgHBIcV+/fSIXvQYcnKKz
	 SpFduTFg2SZ8ycXxFxgwzNxZDIihIQLrwZid6tNKUgPa0XrW7S3YxMp79XFjydqjrm
	 ntd3BnkWTBQErC8IAh2hd3rT2eoCSOaPmoaMFWMI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 451CG8EK019742
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 1 Jun 2024 07:16:08 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Jun 2024 07:16:08 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Jun 2024 07:16:08 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 451CFtkG009323;
	Sat, 1 Jun 2024 07:16:04 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 2/7] arm64: dts: ti: k3-am62p-j722s: Move AM62P specific USB1 to am62p-main.dtsi
Date: Sat, 1 Jun 2024 17:45:49 +0530
Message-ID: <20240601121554.2860403-3-s-vadapalli@ti.com>
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

The USB1 instance of USB controller on AM62P is different from the USB1
instance of USB controller on J722S. Thus, move the USB1 instance from
the shared "k3-am62p-j722s-common-main.dtsi" file to the AM62p specific
"k3-am62p-main.dtsi" file.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
No changelog since this patch is introduced in this version of the
series.

 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 26 ---------------
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 33 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi         |  1 +
 3 files changed, 34 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index ea214f649ebd..2305bf7cb28f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -661,32 +661,6 @@ usb0: usb@31000000 {
 		};
 	};
 
-	usbss1: usb@f910000 {
-		compatible = "ti,am62-usb";
-		reg = <0x00 0x0f910000 0x00 0x800>,
-		      <0x00 0x0f918000 0x00 0x400>;
-		clocks = <&k3_clks 162 3>;
-		clock-names = "ref";
-		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
-		#address-cells = <2>;
-		#size-cells = <2>;
-		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
-		ranges;
-		status = "disabled";
-
-		usb1: usb@31100000 {
-			compatible = "snps,dwc3";
-			reg = <0x00 0x31100000 0x00 0x50000>;
-			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
-			<GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
-			interrupt-names = "host", "peripheral";
-			maximum-speed = "high-speed";
-			dr_mode = "otg";
-			snps,usb2-gadget-lpm-disable;
-			snps,usb2-lpm-disable;
-		};
-	};
-
 	fss: bus@fc00000 {
 		compatible = "simple-bus";
 		reg = <0x00 0x0fc00000 0x00 0x70000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
new file mode 100644
index 000000000000..5187d55681cd
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree file for the AM62P main domain peripherals
+ * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_main {
+	usbss1: usb@f910000 {
+		compatible = "ti,am62-usb";
+		reg = <0x00 0x0f910000 0x00 0x800>,
+		      <0x00 0x0f918000 0x00 0x400>;
+		clocks = <&k3_clks 162 3>;
+		clock-names = "ref";
+		ti,syscon-phy-pll-refclk = <&usb1_phy_ctrl 0x0>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		power-domains = <&k3_pds 179 TI_SCI_PD_EXCLUSIVE>;
+		ranges;
+		status = "disabled";
+
+		usb1: usb@31100000 {
+			compatible = "snps,dwc3";
+			reg = <0x00 0x31100000 0x00 0x50000>;
+			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
+			<GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>; /* irq.0 */
+			interrupt-names = "host", "peripheral";
+			maximum-speed = "high-speed";
+			dr_mode = "otg";
+			snps,usb2-gadget-lpm-disable;
+			snps,usb2-lpm-disable;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
index b7bb04a7968f..9f5bd76bf050 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include "k3-am62p-j722s-common.dtsi"
+#include "k3-am62p-main.dtsi"
 
 / {
 	cpus {
-- 
2.40.1


