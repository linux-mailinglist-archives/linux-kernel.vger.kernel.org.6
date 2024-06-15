Return-Path: <linux-kernel+bounces-215770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3A59096D3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF7E1F23C39
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0801C280;
	Sat, 15 Jun 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bjJUzJkl"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6F61BDD5;
	Sat, 15 Jun 2024 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439382; cv=none; b=gYz4A5u7nEtbWdV5uovyrOgx508SgonWARZlh7oxtV4RV8ssPXHZxyvs+huY1YE2Z10HBx85lLYdQ5pfJm+RVlhmCXqjEQ4c/MZ2OdZpfJ3t9mQdsD1NbSPLxHa7OMSIG5nspVo/k+6EUzm0k2/u/YInoeKpaHvbVrhcMUi7WIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439382; c=relaxed/simple;
	bh=+SRjyz34vwVIuibXII0Eg3BWbbQMBpzw9/CeHkKe4vM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUM1j7CxyZPm3pQP//Mqd8PAXO5GRsawabFNvNBcGE+TIJ/lGl9sSGFE2iW7NCsNfCInqQq9yY/kkih6SDGHlbsBhC1w5J2N0S4mnMn8rUjkjJpbx1T5rWC5Cl9b/8hpAL3SPgcUn5UXoQyQW3Rsom69lyBR6jBHGrKsPaMp0G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bjJUzJkl; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45F8GFsF108560;
	Sat, 15 Jun 2024 03:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718439375;
	bh=Q3U5k6GG52V0GJuK2Hqmuiq5GKnG0BK75tPCOVYvyHQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bjJUzJklJ8WDb91u5LB10DAFNWbCstcIz3RrCMId5NyM5+cMM/tAx1xFyda67oYhE
	 ZuR7MgYy0eM/QGV6PPlVqQvYfweJd8CTvU7i7uXtdLj07l/toR2SHv5hy8c0T/gbrB
	 dWqgNeF6OceRb2XN0vvD1tNl61st3wK8DKEdw6+c=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45F8GFkM063833
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Jun 2024 03:16:15 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 03:16:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 03:16:14 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45F8G1QW024463;
	Sat, 15 Jun 2024 03:16:10 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v7 2/8] arm64: dts: ti: k3-am62p-j722s: Move AM62P specific USB1 to am62p-main.dtsi
Date: Sat, 15 Jun 2024 13:45:54 +0530
Message-ID: <20240615081600.3602462-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240615081600.3602462-1-s-vadapalli@ti.com>
References: <20240615081600.3602462-1-s-vadapalli@ti.com>
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
"k3-am62p-main.dtsi" file. Include "k3-am62p-main.dtsi" in "k3-am62p.dtsi".

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Roger Quadros <rogerq@kernel.org>
---
v6:
https://lore.kernel.org/r/20240612132409.2477888-3-s-vadapalli@ti.com/
No changes since v6.

 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 26 --------------
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 34 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi          |  3 ++
 3 files changed, 37 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index ff97e4a59e3b..870c95081ef5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -662,32 +662,6 @@ usb0: usb@31000000 {
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
index 000000000000..9caab7db5440
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree file for the AM62P MAIN domain peripherals
+ *
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
diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 2d11c80107b5..75a15c368c11 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -123,3 +123,6 @@ cbass_wakeup: bus@b00000 {
 #include "k3-am62p-j722s-common-main.dtsi"
 #include "k3-am62p-j722s-common-mcu.dtsi"
 #include "k3-am62p-j722s-common-wakeup.dtsi"
+
+/* Include AM62P specific peripherals */
+#include "k3-am62p-main.dtsi"
-- 
2.40.1


