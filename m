Return-Path: <linux-kernel+bounces-248593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940ED92DF6C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A681C213FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861FB5C8EF;
	Thu, 11 Jul 2024 05:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ks7Ek/fw"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5561C3D;
	Thu, 11 Jul 2024 05:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675606; cv=none; b=tFR1z4ATXhXwbsBFDZOs+OBdjDeqshhpm5RofQHM8Zfncgpdry4cQe0I7V4l4zaqwv7SDbxwdJTpS02jtF2wc7JUYkWp63+nCRxQKbr/5lg0v/iGWjSJhjiGUjLB/S1W0XOk9lSqqIMHC61PkRjvSoohkgXUCmrSfpDjLX/1lFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675606; c=relaxed/simple;
	bh=sRgIAHPbPKqzxulmJz3xHOn7iC1HbZdUZKFpu4fiGqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=s815UqGOHCXqFkfvskB9ZKGzJe0XHvxfgYMhGSSqcQrcI4M30hOo/UvC/dTGZpzGUJRYuGahMyjSK/NIqjr0nyDoSUmipKC/dOd6WAzTn19/UmecQBdk2bQTCOMdyaLPW9Xjhcxuy1C635hwu2x/iLo8kYRydbfQxYfz78Do3cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ks7Ek/fw; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46B5QM0T038490;
	Thu, 11 Jul 2024 00:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720675582;
	bh=0L9mOJEi4vQvykZ1Spo67bhERE5D3SGr0AJ01gDpG04=;
	h=From:Date:Subject:To:CC;
	b=ks7Ek/fwYVaHzaVJuSZTeVPC2dKoUSmTKh0rKqW8BSpkRnMqVz1D9ofap7m0BviJn
	 RAeVglO8CbCEaaR39+umtpoK0jv/X/3LZBZsVF3cGPRkaulef53ayoR2UVjeijzoIC
	 naa4Mmdq8P6MR6JZzEgWRXbLX68MmJwp09u3vTMA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46B5QMks107207
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jul 2024 00:26:22 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jul 2024 00:26:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jul 2024 00:26:21 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46B5QH6w073418;
	Thu, 11 Jul 2024 00:26:18 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 11 Jul 2024 10:56:14 +0530
Subject: [PATCH] arm64: dts: ti: Introduce J742S2 SoC and EVM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240711-b4-upstream-j742s2-v1-1-8b9e41c18f91@ti.com>
X-B4-Tracking: v=1; b=H4sIAPVsj2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyMD3SQT3dKC4pKi1MRc3SxzE6NiI13zpEQzUyMDS0NTUwMloMaCotS
 0zAqwodGxtbUAA68yHmQAAAA=
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
        Aniket Limaye <a-limaye@ti.com>, Manorit Chawdhry
	<m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720675577; l=5566;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=sRgIAHPbPKqzxulmJz3xHOn7iC1HbZdUZKFpu4fiGqI=;
 b=HIaJWIhb7Y1dCtTB8ZrW1LfpifS/Bvfz4VNQAzXEcFt0VNwBlIDpSpSOFfuKd4XPwhbvldPbc
 oAnDaZ/O/Q/BXx4wPLVRkzLv8yVEasNq+ElNRvbp7KHiTA7eMIdlpQI
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series add the Linux support for our new family of device J742S2.
This device is a subset of J784S4 and shares the same memory map and
thus the nodes are being reused from J784S4 to avoid duplication.

Here are some of the salient features of the J742S2 automotive grade
application processor:

The J742S2 SoC belongs to the K3 Multicore SoC architecture platform,
providing advanced system integration in automotive, ADAS and industrial
applications requiring AI at the network edge. This SoC extends the K3
Jacinto 7 family of SoCs with focus on raising performance and
integration while providing interfaces, memory architecture and compute
performance for multi-sensor, high concurrency applications.

Some highlights of this SoC are:
* Up to Four Arm® Cortex®-A72 microprocessor subsystem at up to 2.0GHz,
  3 C7x floating point vector DSPs with Up to Two Deep-learning matrix
  multiply accelerator (MMAv2),
* 3D GPU: Automotive grade IMG BXS-4-64 MC1
* Vision Processing Accelerator (VPAC) with image signal processor and
  Depth and Motion Processing Accelerator (DMPAC)
* Three CSI2.0 4L RX plus two CSI2.0 4L TX, two DSI Tx, one eDP/DP and
  one DPI interface.
* Integrated gigabit ethernet switch, up to 4 ports ,two ports
  support 10Gb USXGMII; One 4 lane PCIe-GEN3 controllers, USB3.0
  Dual-role device subsystems, Up to 20 MCANs, among other peripherals.

( Refer Table 2-1 for Device comparison with J7AHP )

Link: https://www.ti.com/lit/pdf/spruje3 (TRM)
Link: https://www.ti.com/lit/ug/sprujd8/sprujd8.pdf (EVM user guide)
Link: https://www.ti.com/lit/zip/SPAC001 (Schematics)
---
The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
Support and re-uses most of the stuff from the superset device J784s4.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/Makefile            |  3 ++
 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts   | 22 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi | 47 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi      | 18 ++++++++++++
 4 files changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index e20b27ddf901..4d0688c5cff7 100644
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
diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts b/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts
new file mode 100644
index 000000000000..98088ccfd76d
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001
+ */
+
+#include "k3-j784s4-evm.dts"
+#include "k3-j742s2.dtsi"
+
+/delete-node/ &c71_3_dma_memory_region;
+/delete-node/ &c71_3_memory_region;
+
+/ {
+	model = "Texas Instruments J742S2 EVM";
+
+	memory@80000000 {
+		/* 16G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
+		      <0x00000008 0x80000000 0x00000003 0x80000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi
new file mode 100644
index 000000000000..4ac424d793e6
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001
+ */
+
+/delete-node/ &c71_3;
+
+/delete-node/ &vpu1;
+
+&c71_0 {
+	firmware-name = "j742s2-c71_0-fw";
+};
+
+&c71_1 {
+	firmware-name = "j742s2-c71_1-fw";
+};
+
+&c71_2 {
+	firmware-name = "j742s2-c71_2-fw";
+};
+
+&main_r5fss0_core0 {
+	firmware-name = "j742s2-main-r5f0_0-fw";
+};
+
+&main_r5fss0_core1 {
+	firmware-name = "j742s2-main-r5f0_1-fw";
+};
+
+&main_r5fss1_core0 {
+	firmware-name = "j742s2-main-r5f1_0-fw";
+};
+
+&main_r5fss1_core1 {
+	firmware-name = "j742s2-main-r5f1_1-fw";
+};
+
+&main_r5fss2_core0 {
+	firmware-name = "j742s2-main-r5f2_0-fw";
+};
+
+&main_r5fss2_core1 {
+	firmware-name = "j742s2-main-r5f2_1-fw";
+};
+
diff --git a/arch/arm64/boot/dts/ti/k3-j742s2.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
new file mode 100644
index 000000000000..ceee5f03ed14
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001
+ */
+
+/* Delta SoC file for j742s2 */
+/* Include this in the file where you want to convert j784s4 to j742s2 */
+
+/delete-node/ &cluster1;
+
+/delete-node/ &cpu4;
+/delete-node/ &cpu5;
+/delete-node/ &cpu6;
+/delete-node/ &cpu7;
+
+#include "k3-j742s2-main.dtsi"

---
base-commit: 523b23f0bee3014a7a752c9bb9f5c54f0eddae88
change-id: 20240620-b4-upstream-j742s2-7ba652091550

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


