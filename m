Return-Path: <linux-kernel+bounces-200285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5098FAE18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2121C20E53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D11143C6A;
	Tue,  4 Jun 2024 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s6gLD1HA"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBAD143C44;
	Tue,  4 Jun 2024 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491206; cv=none; b=bSrVkX/aHk7WjbCyTnqJjIa/6DayKowRz3icDLqoMDE3rUqLskOBZVginsbxLR9GOUAwmuP4puaCQ6sFgjop2369IkwkU6GePwhRFJCmHUwo6y9JfHgLF+cENpbc3VVVBHiG0p35RzI2ugvTIzlG/HdKs2rui4Xeiz5arg2C3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491206; c=relaxed/simple;
	bh=giGgyG+uBowzn1pZxxGxG2AQgr8MJfdVaHBdhehyj7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IszFDQmLEdCUCEHLJqkslAbOaZDBBM+fv1bj5nUja4m9wCIa0FDscAg9OZ0AVPRIM3xWOPuOB2qemMIiCA5VjNc4sQLSlXN9+q4MVjUGlLJfjOnPjfiJtMUbsyYIMJPEfYRFNqtWSnp2gEBphQZnXxqLFLrBrxL0p7qpfdl3A+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=s6gLD1HA; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4548r6R3056294;
	Tue, 4 Jun 2024 03:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717491186;
	bh=IFPvDohlPGXXqXCQGX0a2YhLsDb1v7coMiYchfsU0dc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=s6gLD1HAmWFV/Bnrx81H3yDPBRZqos6VhW7cIHhv0K4EYnR+ARGbaxRdP3Ae2kJDC
	 psMD5FkK61OIqAokRs+5XRGtMfVzsVhirlaqwEEKDA08Butt9Sr4ua1+aki7D+uiDq
	 vKr69HPyOkNNTH6zb1GXdhzLxYsDMzyReCfhLsfM=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4548r6jV016003
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 03:53:06 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 03:53:06 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 03:53:06 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4548qqQj066926;
	Tue, 4 Jun 2024 03:53:02 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 2/7] arm64: dts: ti: k3-am62p-j722s: Move AM62P specific USB1 to am62p-main.dtsi
Date: Tue, 4 Jun 2024 14:22:47 +0530
Message-ID: <20240604085252.3686037-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240604085252.3686037-1-s-vadapalli@ti.com>
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
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
v4:
https://lore.kernel.org/r/20240601121554.2860403-3-s-vadapalli@ti.com/
Changes since v4:
- s/main/MAIN in k3-am62p-main.dtsi

 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 26 --------------
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 34 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi         |  1 +
 3 files changed, 35 insertions(+), 26 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index bf6384ba824a..80d2e559a473 100644
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


