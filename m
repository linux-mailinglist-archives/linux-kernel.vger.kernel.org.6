Return-Path: <linux-kernel+bounces-533870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC38EA45F96
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3303D1884977
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E6D1DF990;
	Wed, 26 Feb 2025 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h04EESzj"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D42153D1;
	Wed, 26 Feb 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573786; cv=none; b=Agk1l5+NE7dqgehixuAOuIfsFq1xpnH8rbnYw+NvS/vfR/PBOhHH0GZz24oNTDyPnwaM39HNCz3j3buolwp3QPfYzm8rs5PGWfruYpjFEP84/7tcT681KNKKK1dOd8qJapTpDDfJXNCr0HqxLk3g4QFWTpSe+xcxDa7H040JP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573786; c=relaxed/simple;
	bh=Qbhck5mS6GaBXSveDh/psL3NZTL5zZOKulYq0ktGfOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTW2/hVIWJyjb7IAP0fjnCRJc7lq8k0EXc9PB6Ba5hIuJOj91QERPb93oObQDfKs7yPFKjpOpkbuI8k+SuppVDhSxVJaOkrWZcipSsJOIlzfLOk1o8DZOCoXlv4QBBSxd3AA2uusOyEY9VludKcAX7ojHJtoIDuT6mEs9aVdoFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h04EESzj; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QCgr291545397
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 26 Feb 2025 06:42:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740573773;
	bh=3/MzlDt4nccr9eA0LZJQ9BAeCHX8O6hwCYvepjAbJsE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=h04EESzjT6nkM5ceC6GMeCJJS7bFVk5oHKdbhdpDXyeaR15duQkpX4IeWjxmnqwxQ
	 xsS8xXygothqGlagWejBY9XXPUKdp6hIRAqzAwCajhjNRVKVG2S4nk0wZprWeXsq69
	 LdZXcB2RRxa+ihHiCTBWcgHV5urwO1cV6nCJOAZg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QCgrmW051671;
	Wed, 26 Feb 2025 06:42:53 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 06:42:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 06:42:53 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QCgkI1094589;
	Wed, 26 Feb 2025 06:42:50 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 1/3] arm64: dts: ti: k3-j721e-evm: Add overlay for PCIe NTB functionality
Date: Wed, 26 Feb 2025 18:12:43 +0530
Message-ID: <20250226124245.9856-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226124245.9856-1-s-vadapalli@ti.com>
References: <20250226124245.9856-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

PCIe NTB (Non-Transparent-Bridge) allows connecting the memory of
multiple PCIe Hosts (Root-Complex). The number of such hosts is
determined by the number of PCIe instances configured for NTB operation
on the device which intends to enable NTB functionality. Add a device-tree
overlay to configure PCIE0 and PCIE1 instances of PCIe on J721E EVM for NTB
operation. This shall allow connecting the memory of two PCIe Hosts via
PCIE0 and PCIE1 on J721E EVM.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250202093636.2699064-2-s-vadapalli@ti.com/
Changes since v1:
- s/epf_bus/epf-bus since node names shouldn't contain underscores.

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/Makefile               |  4 +
 .../boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso    | 91 +++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 8a4bdf87e2d4..1097ab30f5a9 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -102,6 +102,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board-infotainment.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie-ntb.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
@@ -201,6 +202,8 @@ k3-j7200-evm-pcie1-ep-dtbs := k3-j7200-common-proc-board.dtb \
 	k3-j7200-evm-pcie1-ep.dtbo
 k3-j721e-common-proc-board-infotainment-dtbs := k3-j721e-common-proc-board.dtb \
 	k3-j721e-common-proc-board-infotainment.dtbo
+k3-j721e-evm-pcie-ntb-dtbs := k3-j721e-common-proc-board.dtb \
+	k3-j721e-evm-pcie-ntb.dtbo
 k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
 	k3-j721e-evm-pcie0-ep.dtbo
 k3-j721e-evm-pcie1-ep-dtbs := k3-j721e-common-proc-board.dtb \
@@ -239,6 +242,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am69-sk-pcie0-ep.dtb \
 	k3-j7200-evm-pcie1-ep.dtb \
 	k3-j721e-common-proc-board-infotainment.dtb \
+	k3-j721e-evm-pcie-ntb.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
 	k3-j721e-evm-pcie1-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso
new file mode 100644
index 000000000000..9b6b3e153e91
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie-ntb.dtso
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT Overlay for enabling NTB functionality using PCIE0 and PCIE1 instances of
+ * PCIe on the J7 common processor board.
+ *
+ * J7 Common Processor Board Product Link: https://www.ti.com/tool/J721EXCPXEVM
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+#include "k3-pinctrl.h"
+
+&{/} {
+	epf-bus {
+		compatible = "pci-epf-bus";
+
+		ntb {
+			compatible = "pci-epf-ntb";
+			epcs = <&pcie0_ep>, <&pcie1_ep>;
+			epc-names = "primary", "secondary";
+			vendor-id = /bits/ 16 <0x104c>;
+			device-id = /bits/ 16 <0xb00d>;
+			num-mws = <4>;
+			mws-size = <0x100000>, <0x100000>, <0x100000>, <0x100000>;
+		};
+	};
+};
+
+&pcie0_rc {
+	status = "disabled";
+};
+
+&pcie1_rc {
+	status = "disabled";
+};
+
+&cbass_main {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic500>;
+
+	pcie0_ep: pcie-ep@2900000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02900000 0x00 0x1000>,
+		      <0x00 0x02907000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x10000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
+		max-link-speed = <3>;
+		num-lanes = <1>;
+		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 239 1>;
+		clock-names = "fck";
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
+		dma-coherent;
+		phys = <&serdes0_pcie_link>;
+		phy-names = "pcie-phy";
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
+	};
+
+	pcie1_ep: pcie-ep@2910000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 240 1>;
+		clock-names = "fck";
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 8 <4 4 4 4 0 0>;
+		dma-coherent;
+		phys = <&serdes1_pcie_link>;
+		phy-names = "pcie-phy";
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
+	};
+};
-- 
2.34.1


