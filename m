Return-Path: <linux-kernel+bounces-511937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A9A331C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7847D7A39A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4E920408C;
	Wed, 12 Feb 2025 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cAIItm8Q"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1F620370A;
	Wed, 12 Feb 2025 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739397190; cv=none; b=FTj6dL/5pmNYOe4yPix3RVBc7qGYM6UMBTVu214FC4VWd0xNPsh5SoPKF/6giYMzpNeKbUK/SYSqldpnuoF+ESfxeoj93SI42oP+E/6Uv0RlmWuxnkkH6v3BKlM+dQosXYQt6qwfBCUnZnuAOA4+/XEbswTcjhzn/CfqAoG6RHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739397190; c=relaxed/simple;
	bh=i3HhJVSj9vjuZZvsLqx6As8CpYfTt4PDTtl75v1pVT8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LxrbM9KWaZ8i2re10nDlwGFdiuYqzOHELcqftIfNmZF7cWioFSZvUmxs4TwcG7K9Eyjx/bhobA2GKZ0+5TfSvBQpRIHMGhimoSXWFqYnFO7PqRvKx1LpuzMxjyStVwVksF+c8x3/arexvg8Ni0+Uy5Z/kVe4mX+2v1awT6AI4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cAIItm8Q; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51CLqnwT3881030
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 15:52:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739397169;
	bh=7hCe79F8mvGMzccqeFPQ8ZkkWiDeQrrKNKFDBMGlSGs=;
	h=From:To:CC:Subject:Date;
	b=cAIItm8QUtj4Cz72EXw6XANksZqdSf198oJrMq2riMGvGh5i78uQFyJZdgtXnjJo1
	 jHFKUcmin/gDxM5CSR4oJHM+RxnN2KcikATjFV5YddgYVOWCRd+caJLsireziHtS9V
	 TGnff8fR4k0JdrI+doKAiZEsIdWBvRiC+sSoG2aU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51CLqn6N044538
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 15:52:49 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Feb 2025 15:52:48 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Feb 2025 15:52:48 -0600
Received: from uda0506412.dhcp.ti.com (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51CLqmj4123789;
	Wed, 12 Feb 2025 15:52:48 -0600
From: Kendall Willis <k-willis@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <d-gole@ti.com>, <tony@atomide.com>, <msp@baylibre.com>,
        <khilman@baylibre.com>, <k-willis@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: dts: ti: k3-am62p-j722s-common-wakeup: Configure ti-sysc for wkup_uart0
Date: Wed, 12 Feb 2025 15:52:48 -0600
Message-ID: <20250212215248.746838-1-k-willis@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Vibhore Vardhan <vibhore@ti.com>

Similar to the TI K3-AM62x Soc commit ce27f7f9e328c8582a169f97f1466976561f1
("arm64: dts: ti: k3-am62-wakeup: Configure ti-sysc for wkup_uart0")
The devices in the wkup domain are capable of waking up the system from
suspend. We can configure the wkup domain devices in a generic way using
the ti-sysc interconnect target module driver like we have done with the
earlier TI SoCs.

As ti-sysc manages the SYSCONFIG related registers independent of the
child hardware device, the wake-up configuration is also set even if
wkup_uart0 is reserved by sysfw.

The wkup_uart0 device has interconnect target module register mapping like
dra7 wkup uart. There is a 1 MB interconnect target range with one uart IP
block in the target module. The power domain and clock affects the whole
interconnect target module.

Note we change the functional clock name to follow the ti-sysc binding
and use "fck" instead of "fclk".

Also note that we need to disable the target module reset as noted by
Markus. Otherwise the sysfw using wkup_uart0 can get confused on some
devices leading to boot time issues such as mbox timeouts.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Tested by suspend/resume with WKUP UART wakeup source on AM62P.

Similar patch was sent for AM62x by Tony,
https://lore.kernel.org/all/20231219072503.12427-1-tony@atomide.com/

Similar patch was sent for AM62a by Dhruva,
https://lore.kernel.org/all/20241231-am62a-dt-ti-sysc-wkup-v1-1-a9b0d18a2649@ti.com/

Original patch for AM62p existed in the TI Vendor tree with Vibhore's
authorship:
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/commit/?h=ti-linux-6.6.y&id=efab3fb636673837886599a49cddf1e862c8aeb6
---
 .../dts/ti/k3-am62p-j722s-common-wakeup.dtsi  | 36 +++++++++++++++----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
index 6f32135f00a5..6757b37a9de3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
@@ -2,9 +2,11 @@
 /*
  * Device Tree file for the WAKEUP domain peripherals shared by AM62P and J722S
  *
- * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2023-2025 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <dt-bindings/bus/ti-sysc.h>
+
 &cbass_wakeup {
 	wkup_conf: bus@43000000 {
 		compatible = "simple-bus";
@@ -41,14 +43,34 @@ usb1_phy_ctrl: syscon@4018 {
 		};
 	};
 
-	wkup_uart0: serial@2b300000 {
-		compatible = "ti,am64-uart", "ti,am654-uart";
-		reg = <0x00 0x2b300000 0x00 0x100>;
-		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+	target-module@2b300050 {
+		compatible = "ti,sysc-omap2", "ti,sysc";
+		reg = <0 0x2b300050 0 0x4>,
+		      <0 0x2b300054 0 0x4>,
+		      <0 0x2b300058 0 0x4>;
+		reg-names = "rev", "sysc", "syss";
+		ti,sysc-mask = <(SYSC_OMAP2_ENAWAKEUP |
+				 SYSC_OMAP2_SOFTRESET |
+				 SYSC_OMAP2_AUTOIDLE)>;
+		ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+				<SYSC_IDLE_NO>,
+				<SYSC_IDLE_SMART>,
+				<SYSC_IDLE_SMART_WKUP>;
+		ti,syss-mask = <1>;
+		ti,no-reset-on-init;
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 114 0>;
-		clock-names = "fclk";
-		status = "disabled";
+		clock-names = "fck";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x2b300000 0x100000>;
+
+		wkup_uart0: serial@0 {
+			compatible = "ti,am64-uart", "ti,am654-uart";
+			reg = <0 0x100>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
 	};
 
 	wkup_i2c0: i2c@2b200000 {

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.34.1


