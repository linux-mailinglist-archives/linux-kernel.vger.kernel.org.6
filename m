Return-Path: <linux-kernel+bounces-311319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534BB96877C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12180281B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEF420013C;
	Mon,  2 Sep 2024 12:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qmbJPAKy"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452D20010C;
	Mon,  2 Sep 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280043; cv=none; b=jN8nVe2Nfen3OelHSrsD8HHFCqMid8scs1rFAscjQZvPuLzMtLVgO6lPs9Kwu/g1DJU0Tjp9XWjiajLbr3TQhVmKUAtHKpQKNniLljTtKpIrhxP3+Se/fLIeFZEBFNRn+/AFV6HyWf0atxzKsqb/kPtky5XSvyLmEgKdfCwx/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280043; c=relaxed/simple;
	bh=KtDuyuvFIQe6hwFdkONOf46WKT+lVLl+CmT9GmjDIz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=j9VP8aQy7W5ENZhS6O2ose8dYnrXPplr86CLycgxzIaAv4YzCmwOndV6afPJ6uJn29yuX2WNFxxEbEFkaZ+NMXTf3038Jjp1a5miWqh1w71+xWEQdPbLda4RUB4SwWicz4JumjDqWyuPv0Z3TmuyULDmyzMfQnWriSOtbV0J+bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qmbJPAKy; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 482CRHiM126825;
	Mon, 2 Sep 2024 07:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725280037;
	bh=dqcViqQMZg3TxndfXto2impA/z+wIpmvtwl97nJ4kjM=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=qmbJPAKyhcnY5ltdryN53pch4gLmvzdH6+xozSihYJ+phnSy1gWuW0+zn8ryftJ8W
	 16JW/vr2JCxE0qbb/Hcr3w2PJWYJCbgVJ2rQjS6/o63mAo/KZWaMrdlABwqnvE9W65
	 fOVQ03u6XiFDVcY9pHHzzvHZo1cY2lqdffyuDa5g=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 482CRHft128559
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 07:27:17 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 07:27:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 07:27:17 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 482CQpGJ023644;
	Mon, 2 Sep 2024 07:27:13 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 2 Sep 2024 17:56:53 +0530
Subject: [PATCH v6 5/5] arm64: dts: ti: Add support for J742S2 EVM board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240902-b4-upstream-j742s2-v6-5-6a7aa2736797@ti.com>
References: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
In-Reply-To: <20240902-b4-upstream-j742s2-v6-0-6a7aa2736797@ti.com>
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
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Manorit Chawdhry
	<m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725280011; l=2872;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=KtDuyuvFIQe6hwFdkONOf46WKT+lVLl+CmT9GmjDIz0=;
 b=VRH6dugKhmNARPdILqU5gZbdcXk2RQNXHPrSSd+gVrsYx3AyT54EgT44tnEm//pEZ6nn1vR7/
 94k5FzjfymjAEz7zCNudSs3WPEOSPYglIK5sBpSXpPNQZyM102CmMmG
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

Notes:
    v6: No change

 arch/arm64/boot/dts/ti/Makefile          |  4 ++++
 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index bcd392c3206e..5ed463cc06d5 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -126,6 +126,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-pcie0-pcie1-ep.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
 
+# Boards with J742S2 SoC
+dtb-$(CONFIG_ARCH_K3) += k3-j742s2-evm.dtb
+
 # Build time test only, enabled by CONFIG_OF_ALL_DTBS
 k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
 	k3-am625-beagleplay-csi2-ov5640.dtbo
@@ -247,3 +250,4 @@ DTC_FLAGS_k3-j721e-common-proc-board += -@
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

-- 
2.46.0


