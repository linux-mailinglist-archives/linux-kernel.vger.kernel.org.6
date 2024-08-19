Return-Path: <linux-kernel+bounces-291812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 590D6956742
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF74B20F06
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3D815ECE8;
	Mon, 19 Aug 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t8qugMoa"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257515ECD5;
	Mon, 19 Aug 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060410; cv=none; b=hIe8BJOnib1z09u0XE+e+KAc/eISizx8WT4aOB3HMjST4QoUHM49z1yB7p6HQM6ygJamIYfWgD47vPv0H4pP6MT6owtLdb7z11p40YllYftpPKOfqAK87ao885mM1ADiOl4A9Oq/hBmB7GTFPYeGyGgpGeIEwHv5RTQ8F86XVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060410; c=relaxed/simple;
	bh=CceIZBexaBuqrKOM3lnKaoJ/9+ed7zFoJNiu80vtbmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IZ14xmylK5Jwc1N4TN6o6ddMUhLOaxtadIb0c3IhFObBD2Nsxphb3lhdOoCcegW0stjH3vCu7Sf0c0pivxnsWq05l2MuzwQX206ZWCDHBJxUZbtsR0RsjJyuasKUqWjs2j20S28Jx14PbRa5WzYeZ3QNx+DdqQTnb1N6yz0N99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t8qugMoa; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47J9e0OX114818;
	Mon, 19 Aug 2024 04:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724060400;
	bh=PcR3AOplWBTtVm25TAb+6FaDkyDmfWhdLfDcsTcmMXg=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=t8qugMoaboIc+9Gb9iDDFyYtJ3Qkx/FHTAIqQpwn+7wfXcY7kQNME3eJ9P2HLQU0M
	 SXM3v3sf7agJZHHzoyVhqb/skErUg51PK45KrpIq5Pu0vjL8iaU/J5QC8Yx4ODeG2Q
	 fUh//33oRqs0hoaS47I6//XBLxvaNQ0g21Rcg9Tw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47J9e0P0130711
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Aug 2024 04:40:00 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 19
 Aug 2024 04:40:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Aug 2024 04:40:00 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47J9daOH082967;
	Mon, 19 Aug 2024 04:39:57 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 19 Aug 2024 15:09:39 +0530
Subject: [PATCH v4 5/5] arm64: dts: ti: Add support for J742S2 EVM board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240819-b4-upstream-j742s2-v4-5-f2284f6f771d@ti.com>
References: <20240819-b4-upstream-j742s2-v4-0-f2284f6f771d@ti.com>
In-Reply-To: <20240819-b4-upstream-j742s2-v4-0-f2284f6f771d@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
	<b-padhi@ti.com>,
        Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724060376; l=3564;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=CceIZBexaBuqrKOM3lnKaoJ/9+ed7zFoJNiu80vtbmE=;
 b=KaRsO8q/wonUmLs7aoNKabiKp29xsErCsAreM0htKjbIql5o5MFesWwYJesgY+cAMnMsrcK+7
 pGGDrYNOx/1Bi0Ku9gJSjZJuw3OzBDHTHiUQO1+zYGIvNj9XK8b5TYF
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

J742S2 EVM board is designed for TI J742S2 SoC. It supports the following
interfaces:
* 16 GB DDR4 RAM
* x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
* x1 Input Audio Jack, x1 Output Audio Jack
* x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
* x1 4L PCIe connector
* x1 UHS-1 capable micro-SD card slot
* 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
  UFS flash.
* x6 UART through UART-USB bridge
* XDS110 for onboard JTAG debug using USB
* Temperature sensors, user push buttons and LEDs
* x1 GESI expander, x2 Display connector
* x1 15-pin CSI header
* x6 MCAN instances

Link: https://www.ti.com/lit/ug/sprujd8/sprujd8.pdf (EVM user guide)
Link: https://www.ti.com/lit/zip/SPAC001 (Schematics)
Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile                    |  4 ++++
 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts           | 26 ++++++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   |  3 ++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index e20b27ddf901..1bf645726a10 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -119,6 +119,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-pcie0-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
 
+# Boards with J742S2 SoC
+dtb-$(CONFIG_ARCH_K3) += k3-j742s2-evm.dtb
+
 # Build time test only, enabled by CONFIG_OF_ALL_DTBS
 k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-ov5640.dtbo
@@ -240,3 +243,4 @@ DTC_FLAGS_k3-j721e-common-proc-board += -@
 DTC_FLAGS_k3-j721e-sk += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
 DTC_FLAGS_k3-j784s4-evm += -@
+DTC_FLAGS_k3-j742s2-evm += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts b/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts
new file mode 100644
index 000000000000..fcb7f05d7faf
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/net/ti-dp83867.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "k3-j742s2.dtsi"
+#include "k3-j784s4-j742s2-evm-common.dtsi"
+
+/ {
+	model = "Texas Instruments J742S2 EVM";
+	compatible = "ti,j742s2-evm", "ti,j742s2";
+
+	memory@80000000 {
+		/* 16G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000003 0x80000000>;
+		device_type = "memory";
+		bootph-all;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
index 068ceed4ea15..a7bb1857b4e8 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
@@ -2,7 +2,8 @@
 /*
  * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
  *
- * EVM Board Schematics: https://www.ti.com/lit/zip/sprr458
+ * EVM Board Schematics(j784s4): https://www.ti.com/lit/zip/sprr458
+ * EVM Board Schematics(j742s2): https://www.ti.com/lit/zip/SPAC001
  */
 / {
 	chosen {

-- 
2.46.0


