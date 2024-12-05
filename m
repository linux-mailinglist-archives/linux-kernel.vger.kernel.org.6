Return-Path: <linux-kernel+bounces-433021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8079E52F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEDD188069D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829811DA602;
	Thu,  5 Dec 2024 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WuQwMi9G"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD11DD87C;
	Thu,  5 Dec 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395869; cv=none; b=sVDyYs6qpaP/hrnyznsyVWZ7jim/S7YFZFZ1euiZtDfph4LfP33yHf+L1Cto56nNcjhoACl/zDn259WThCED12tsiEcgG1SJ4FnFmhFAAFdDXFHX6QUvPda0q4VW4R3ThpYk6GSWkIXFqc+8zTHZ4oOv0RnLNJiPbSJUqUelKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395869; c=relaxed/simple;
	bh=ARvnduVUYcy8RNNDTsHKz6NOUlGXZwr1ILNb0Ft9KWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=To7Cseeb6h9ee7qiHrI5J4g5uzsTc1qMSGvYhB6NAzh17UHNCMx3hNpt2eEKde3A7Tx08t+ppVuqICnBbydsiZir8bUyeYs1lsD9/y2UafPRRBpoRbblILllsbCdy6+S8B2Y5ROlDQxVliQxXu+egMVtH4ZlAHyTnM9/0caVvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WuQwMi9G; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B5Aor6C1935941
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 04:50:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733395853;
	bh=BkpVXwWuotXxa9vkpl5KFFoSmocApd4ODUbu3hO56t8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WuQwMi9G2tn9bHE8rmNKRlohI35zYJBdgnuxWADNJyMYAqGCwgvFm1pTOF4wna6J+
	 Hy9gEf8VVKfZa8QAqh6G/JiUr5Y/qSEdtyLwTGvLTRdyHtlktMobxc1FyBYwcSNPxK
	 xlgxTKFDniWW2vueirR2l7BBLWs63gZS3o50xE5M=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B5AorlF093394
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Dec 2024 04:50:53 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Dec 2024 04:50:52 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Dec 2024 04:50:52 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B5AofJs110686;
	Thu, 5 Dec 2024 04:50:49 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 2/4] arm64: dts: ti: k3-j721e-evm: Add overlay for PCIE1 Endpoint Mode
Date: Thu, 5 Dec 2024 16:20:34 +0530
Message-ID: <20241205105041.749576-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241205105041.749576-1-s-vadapalli@ti.com>
References: <20241205105041.749576-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add overlay to enable the PCIE1 instance of PCIe on J721E-EVM in Endpoint
mode of operation. Additionally, in order to support both PCIE0 and PCIE1
in Endpoint Mode of operation, enable applying device-tree overlays on
"k3-j721e-evm-pcie0-ep.dtb", thereby allowing the overlay for PCIE1 in
Endpoint mode to be applied on the aforementioned DTB.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
v3:
https://lore.kernel.org/r/20241010100933.2492806-1-s-vadapalli@ti.com/
Changes since v3:
- Rebased on next-20241204.

v2:
https://lore.kernel.org/r/20240222065733.1213434-1-s-vadapalli@ti.com/
Changes since v2:
- Rebased patch on next-20241010.
- Moved vendor specific property "ti,syscon-pcie-ctrl" to the end of the
  node.

v1:
https://lore.kernel.org/r/20240220105006.1056824-1-s-vadapalli@ti.com/
Changes since v1:
- Created a new overlay for PCIE1 based on Andrew's suggestion at:
  https://lore.kernel.org/r/415ee6d4-fe26-4582-80f3-9b503d308fdf@ti.com/
- Updated Makefile to allow applying overlay on
  "k3-j721e-evm-pcie0-ep.dtb"

 arch/arm64/boot/dts/ti/Makefile               |  5 ++
 .../boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso    | 53 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 379bfa4425d4..03bacbc589ee 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -107,6 +107,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board-infotainment.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-gesi-exp-board.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie0-ep.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j721e-evm-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk-csi2-dual-imx219.dtbo
 
@@ -200,6 +201,8 @@ k3-j721e-common-proc-board-infotainment-dtbs := k3-j721e-common-proc-board.dtb \
 	k3-j721e-common-proc-board-infotainment.dtbo
 k3-j721e-evm-pcie0-ep-dtbs := k3-j721e-common-proc-board.dtb \
 	k3-j721e-evm-pcie0-ep.dtbo
+k3-j721e-evm-pcie1-ep-dtbs := k3-j721e-common-proc-board.dtb \
+	k3-j721e-evm-pcie1-ep.dtbo
 k3-j721e-sk-csi2-dual-imx219-dtbs := k3-j721e-sk.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtbo
 k3-j721s2-evm-pcie1-ep-dtbs := k3-j721s2-common-proc-board.dtb \
@@ -233,6 +236,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-j7200-evm-pcie1-ep.dtb \
 	k3-j721e-common-proc-board-infotainment.dtb \
 	k3-j721e-evm-pcie0-ep.dtb \
+	k3-j721e-evm-pcie1-ep.dtb \
 	k3-j721e-sk-csi2-dual-imx219.dtb \
 	k3-j721s2-evm-pcie1-ep.dtb \
 	k3-j784s4-evm-pcie0-pcie1-ep.dtb \
@@ -255,6 +259,7 @@ DTC_FLAGS_k3-am68-sk-base-board += -@
 DTC_FLAGS_k3-am69-sk += -@
 DTC_FLAGS_k3-j7200-common-proc-board += -@
 DTC_FLAGS_k3-j721e-common-proc-board += -@
+DTC_FLAGS_k3-j721e-evm-pcie0-ep += -@
 DTC_FLAGS_k3-j721e-sk += -@
 DTC_FLAGS_k3-j721s2-common-proc-board += -@
 DTC_FLAGS_k3-j784s4-evm += -@
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso
new file mode 100644
index 000000000000..a8cccdcf3e3b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j721e-evm-pcie1-ep.dtso
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT Overlay for enabling PCIE1 instance in Endpoint Configuration with the
+ * J7 common processor board.
+ *
+ * J7 Common Processor Board Product Link: https://www.ti.com/tool/J721EXCPXEVM
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
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
+/*
+ * Since Root Complex and Endpoint modes are mutually exclusive
+ * disable Root Complex mode.
+ */
+&pcie1_rc {
+	status = "disabled";
+};
+
+&cbass_main {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic500>;
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
2.43.0


