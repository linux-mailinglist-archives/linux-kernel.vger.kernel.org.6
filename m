Return-Path: <linux-kernel+bounces-343788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E9F989F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2C4B24518
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3344518A926;
	Mon, 30 Sep 2024 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="S1A4Gpad"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49561741D1;
	Mon, 30 Sep 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692466; cv=none; b=llOioANUGSEHsePzTDXLEs1DAgIxWE5/d2C7TB8CtEVuvGYu4qg3oQZbbNdHEOeq7+euacDFPAaiSDz2Th1GuWwrFemV0AfnufPBo5f+i2BZQvQ5lt6t6rke8ASpbz1woUKSyTBxUD5iV7CbjWKr8vwDR+vAnH36pyGYlojka0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692466; c=relaxed/simple;
	bh=IYOqevHyIhjK/PhsNoeCcGvpHqEq4H8Wi3Oxk0NdzkM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WasLlITtxmZC3O6Hx0lesXPCAQolpMrfZHxGk1Ls0rlbjuLh3729h5EKeGhJjP7+Aj0hU4ehAaP9xMyVlQTGb2MT2CKB1hfyjRx9jqs4AbKG4BLc2t6J+oq+kERbnlL8ejKV3A2IoxyzwCzxekwhR0i6t+mk1iJH/lckCHeSCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=S1A4Gpad; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48UAYHEX003645;
	Mon, 30 Sep 2024 05:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727692457;
	bh=8ZWya66Wrk3d2reuZyBB9skj19ZrGqZzSN/E8Z86hfY=;
	h=From:To:CC:Subject:Date;
	b=S1A4Gpad1EGHuHFs1o/5ohEVYwMkL3qA+/r+Qxa7cKY1krDOsAcC64OUxCOUDZYar
	 x8z+FbXYR8NL4bFE3959ySqSp1Uv5SYhHfV8LQzPRW4YRE9qknTi7+b9aO46ZNQ9ef
	 aECu8szBjXriKgjGhHRjhhZF/AIO6Wh0X9YIFsWg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48UAYH3q030401
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Sep 2024 05:34:17 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 30
 Sep 2024 05:34:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 30 Sep 2024 05:34:17 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48UAYDA6111596;
	Mon, 30 Sep 2024 05:34:14 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am642-evm: Add overlay for PCIe0 EP mode
Date: Mon, 30 Sep 2024 16:04:13 +0530
Message-ID: <20240930103413.3085689-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add overlay to enable the PCIe0 instance of PCIe on AM642-EVM in
Endpoint mode of operation.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20240930.

Logs validating the device-tree overlay with AM642-EVM as Endpoint and
J784S4-EVM as Root Complex:
https://gist.github.com/Siddharth-Vadapalli-at-TI/d3c071d0a34b7ef162e1413f1688cc9d

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/Makefile               |  4 ++
 .../boot/dts/ti/k3-am642-evm-pcie0-ep.dtso    | 51 +++++++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-pcie0-ep.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index bcd392c3206e..c1417b38a4e6 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -48,6 +48,7 @@ k3-am642-hummingboard-t-usb3-dtbs := \
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac-mii.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-pcie0-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-pcie.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am642-hummingboard-t-usb3.dtb
@@ -168,6 +169,8 @@ k3-am642-evm-icssg1-dualemac-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
 k3-am642-evm-icssg1-dualemac-mii-dtbs := \
 	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac-mii.dtbo
+k3-am642-evm-pcie0-ep-dtbs := \
+	k3-am642-evm.dtb k3-am642-evm-pcie0-ep.dtbo
 k3-am642-phyboard-electra-disable-eth-phy-dtbs := \
 	k3-am642-phyboard-electra-rdk.dtb k3-am6xx-phycore-disable-eth-phy.dtbo
 k3-am642-phyboard-electra-disable-rtc-dtbs := \
@@ -217,6 +220,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am62p5-sk-csi2-tevi-ov5640.dtb \
 	k3-am642-evm-icssg1-dualemac.dtb \
 	k3-am642-evm-icssg1-dualemac-mii.dtb \
+	k3-am642-evm-pcie0-ep.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
 	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
 	k3-am68-sk-base-board-csi2-dual-imx219.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-pcie0-ep.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-pcie0-ep.dtso
new file mode 100644
index 000000000000..6b029539e0db
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-pcie0-ep.dtso
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT Overlay for enabling PCIE0 instance in Endpoint Configuration with the
+ * AM642 EVM.
+ *
+ * AM642 EVM Product Link: https://www.ti.com/tool/TMDS64EVM
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
+&pcie0_rc {
+	status = "disabled";
+};
+
+&cbass_main {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic500>;
+
+	pcie0_ep: pcie-ep@f102000 {
+		compatible = "ti,am64-pcie-ep", "ti,j721e-pcie-ep";
+		reg = <0x00 0x0f102000 0x00 0x1000>,
+		      <0x00 0x0f100000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x68000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 203 IRQ_TYPE_EDGE_RISING>;
+		max-link-speed = <2>;
+		num-lanes = <1>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 114 0>;
+		clock-names = "fck";
+		max-functions = /bits/ 8 <1>;
+		phys = <&serdes0_pcie_link>;
+		phy-names = "pcie-phy";
+		ti,syscon-pcie-ctrl = <&main_conf 0x4070>;
+	};
+};
-- 
2.40.1


