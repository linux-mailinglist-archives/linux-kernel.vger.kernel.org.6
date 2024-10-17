Return-Path: <linux-kernel+bounces-369252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691269A1AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269DC28604D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B421925A5;
	Thu, 17 Oct 2024 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dBxVzCEs"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE318E04E;
	Thu, 17 Oct 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729147280; cv=none; b=S4BJ50h+IrqElh+uLvydI03cir2qGjtocvRRYs4JGenBxpEi4AvVKLmZ8hNsxCOWCTEkBESoGFc2SflkaU9wBT+bFX2X8yPkis/7PbADZpbg01R5w1sTBBGWv9mxCTilhc+stIL8fryoUSWDrNaduJCY5EsrExQTcDR8tC5rWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729147280; c=relaxed/simple;
	bh=UKK7eZz1Pu+wcpVxUWu2FCVh5OPes/KX5YioqbbLOzU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P3NOwWhxcSmS4dO+7V2iqDGpFO6iYAfOv4IxDOSADmgcw28tRVt4iXT7f+g/UIt/b0ZkVhJYGaQgD0a6TR/ACj75JdTQytMTdCIGeA5Gkdr662XqDVCPEw3fagLP4bJC02QB2yoqTJGq6d4lN9Jsz/xuGugiAkwpjG28ydQE+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dBxVzCEs; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49H6ekfq002881;
	Thu, 17 Oct 2024 01:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729147246;
	bh=SXZs1tZeO5dv/QQF+M6mQqAm8Zl6lz5X0ZWRJcpLVxk=;
	h=From:To:CC:Subject:Date;
	b=dBxVzCEs2VvkJCD2urQId1wklK1n+2wtc2w8ir0YWIIeBir1TETj4ycdYD6lZDbT5
	 qL9NsL/YbfwcGjiWn3r0gy/fqJu8AkSY2qkfPyxeyweKM7nawmsIV/gFR2+uxIdZTa
	 TnePGIBG9H0/79a2SsGgq5DMnageGauCKI/olpyE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49H6ek3J030539
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Oct 2024 01:40:46 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Oct 2024 01:40:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Oct 2024 01:40:45 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49H6efL4009875;
	Thu, 17 Oct 2024 01:40:42 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add overlay for USB2.0 Type A functionality
Date: Thu, 17 Oct 2024 12:10:41 +0530
Message-ID: <20241017064041.880119-1-s-vadapalli@ti.com>
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

The USB0 instance of the USB controller on the J784S4 SoC supports a single
USB interface with the possible choices being:
1. USB3.1 Gen1 Type C interface
2. Two USB2.0 Type A interfaces via an on-board USB Hub.

Add overlay to enable USB2.0 Type A functionality by:
1. Configuring the "USB2.0_MUX_SEL" mux to enable the USB Hub connected to
   the two USB2.0 Type A interfaces on the J784S4-EVM.
2. Set the Dual-Role Mode to Host.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on linux-next tagged next-20241016.

Logs validating USB2.0 Type A interface on the J784S4-EVM:
https://gist.github.com/Siddharth-Vadapalli-at-TI/41bbcb39f331aa3bb6fd4dd694015189

Regards,
Siddharth.

 arch/arm64/boot/dts/ti/Makefile               |  4 +++
 .../arm64/boot/dts/ti/k3-j784s4-evm-usb2.dtso | 26 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j784s4-evm-usb2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index bcd392c3206e..fc75d0365558 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -124,6 +124,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-pcie0-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usb2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
 
 # Build time test only, enabled by CONFIG_OF_ALL_DTBS
@@ -200,6 +201,8 @@ k3-j784s4-evm-pcie0-pcie1-ep-dtbs := k3-j784s4-evm.dtb \
 	k3-j784s4-evm-pcie0-pcie1-ep.dtbo
 k3-j784s4-evm-quad-port-eth-exp1-dtbs := k3-j784s4-evm.dtb \
 	k3-j784s4-evm-quad-port-eth-exp1.dtbo
+k3-j784s4-evm-usb2-dtbs := k3-j784s4-evm.dtb \
+	k3-j784s4-evm-usb2.dtbo
 k3-j784s4-evm-usxgmii-exp1-exp2-dtbs := k3-j784s4-evm.dtb \
 	k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
 dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
@@ -227,6 +230,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-j721s2-evm-pcie1-ep.dtb \
 	k3-j784s4-evm-pcie0-pcie1-ep.dtb \
 	k3-j784s4-evm-quad-port-eth-exp1.dtb \
+	k3-j784s4-evm-usb2.dtbo \
 	k3-j784s4-evm-usxgmii-exp1-exp2.dtb
 
 # Enable support for device-tree overlays
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm-usb2.dtso b/arch/arm64/boot/dts/ti/k3-j784s4-evm-usb2.dtso
new file mode 100644
index 000000000000..02f97819aa82
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm-usb2.dtso
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/**
+ * DT overlay for USB2.0 Type A functionality on J784S4-EVM.
+ *
+ * J784S4 EVM Product Link: https://www.ti.com/tool/J784S4XEVM
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+&exp2 {
+	p12-hog {
+		/* P12 - USB2.0_MUX_SEL */
+		gpio-hog;
+		gpios = <12 GPIO_ACTIVE_HIGH>;
+		output-high;
+	};
+};
+
+&usb0 {
+	dr_mode = "host";
+};
-- 
2.40.1


