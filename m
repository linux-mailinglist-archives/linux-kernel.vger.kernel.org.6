Return-Path: <linux-kernel+bounces-211556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E34BF9053B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88E51C211BC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C10153BFA;
	Wed, 12 Jun 2024 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O3jnTtQX"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77017D357;
	Wed, 12 Jun 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198671; cv=none; b=cVBkHE1wUGyczI+m0Tm/EF5Op3lPxLD2gXmzVkZkMUvAcrV6X0XHTtT4gRve4eluNHz3gssga+Fc6yH+mtdg82FVQKAjK48a/9bJ1WE8NonrF0A9WABAut4NubDbBgHB9Ov8d38sLpVuC5EF67xZLRAr6nBuCPnFLmiHCyZRij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198671; c=relaxed/simple;
	bh=d9FiH6JH4g82H1Nr3+zmOenqtMz+LCVhMLVvh/05eEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1vL2wYV3qu5Xp52LD5RdGaT3OJiRGLq7VUEncqUgRqmX7BkwuityRKy/BnmMka8OJ0l8fSZIuZqieovEJeZheSHpV78m8GLfAbj0jJyaKzxHMRspfoKh5+Px7WeRAoeIrR6GMDXLYfwT23Pmmu6BjN2OimSfnNJFeDAdPS6jqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O3jnTtQX; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOO2m111047;
	Wed, 12 Jun 2024 08:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718198664;
	bh=pulxDMoAOMZ/SXEx0WN/NAJhy74GxqbdqyHws5Urke4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=O3jnTtQXzJeMU6NSMxXwQN87k5RUBp8myUwt3kAyBDBWwjNKobRY1F2UlH3Otpios
	 dynR58H2/Dazz7x0XEkW3PHUX4A6ld67ufpdt4+VzgU9oPmCyobsbmt7ijdsS9xUc3
	 eiIam0Hw4f6kkyNWDQm0d3OgQBe2RywQK+w8KzUE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45CDOOXc094597
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Jun 2024 08:24:24 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 08:24:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 08:24:23 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45CDOAms046478;
	Wed, 12 Jun 2024 08:24:20 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v6 2/8] arm64: dts: ti: k3-am62p-j722s: Move AM62P specific USB1 to am62p-main.dtsi
Date: Wed, 12 Jun 2024 18:54:03 +0530
Message-ID: <20240612132409.2477888-3-s-vadapalli@ti.com>
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

The USB1 instance of USB controller on AM62P is different from the USB1
instance of USB controller on J722S. Thus, move the USB1 instance from
the shared "k3-am62p-j722s-common-main.dtsi" file to the AM62p specific
"k3-am62p-main.dtsi" file. Include "k3-am62p-main.dtsi" in "k3-am62p.dtsi".

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Acked-by: Roger Quadros <rogerq@kernel.org>
---
v5:
https://lore.kernel.org/r/20240604085252.3686037-3-s-vadapalli@ti.com/
Changes since v5:
- Since this v6 series contains "k3-am62p.dtsi" rather than
  "k3-am62p-j722s-common.dtsi", the equivalent change of the v5 patch
  applies to "k3-am62p.dtsi" in the current patch.
- Collected Acked-by tag from Roger Quadros <rogerq@kernel.org>

 .../dts/ti/k3-am62p-j722s-common-main.dtsi    | 26 --------------
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi     | 34 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi          |  3 ++
 3 files changed, 37 insertions(+), 26 deletions(-)
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


