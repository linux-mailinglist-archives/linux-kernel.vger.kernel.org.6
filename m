Return-Path: <linux-kernel+bounces-312441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 681329696A8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26586284C70
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57082101A3;
	Tue,  3 Sep 2024 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aa3/PAJo"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA892205E24;
	Tue,  3 Sep 2024 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351179; cv=none; b=az80B4bt6QYQ4aKK7Itl1prIZtkojtxIe1Fl/CpVSk4bX7/DGw3qjbbllBD4JqmB+7Jyt45SJm2S6DUEv4j2RG7CjaK7cYH//Ca1YUGMGta+J2TtWvm8Kx4xbTqQMbpMpPx9zIa8SZF+QS3QcpdbALqx+0e4czYp+kleLYo+jPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351179; c=relaxed/simple;
	bh=KtDuyuvFIQe6hwFdkONOf46WKT+lVLl+CmT9GmjDIz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=n/HnY7bOwzT17yDEKd4xPF0yzo6BpGR8g8p+YU43AgD9nHPVYsHZ8fmhAeIBlTklcyBGpTihN0ucP7jOba60r8Fx84z6HeVsZ97amIEgq3f43xgn+qBsD+16sTtYZ/44CSk3U2gyt5u4F2cvWQYlcTJL2Q3KOygXi4608nuFANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aa3/PAJo; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4838CqVj049943;
	Tue, 3 Sep 2024 03:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725351172;
	bh=dqcViqQMZg3TxndfXto2impA/z+wIpmvtwl97nJ4kjM=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=aa3/PAJowfx2kioaA2YnAJrMag4NeMb1CXl+TBHenTekw9UJhdR1GqiJV/5vMYiLI
	 SxjhF0yPJ85OrEUFLfCwgmX5Fbs3epNr6Ynm4oyIBUUKhvFmtqP4/Cndij/rgUGztW
	 E6eh7TmNZiGmfD2KmIKxXA7dteOMDyoHrPHZPCRM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4838Cqnm058994
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 03:12:52 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 03:12:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 03:12:52 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4838CQoD062032;
	Tue, 3 Sep 2024 03:12:48 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 3 Sep 2024 13:42:23 +0530
Subject: [PATCH RESEND v6 5/5] arm64: dts: ti: Add support for J742S2 EVM
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240903-b4-upstream-j742s2-v6-5-49d980fed889@ti.com>
References: <20240903-b4-upstream-j742s2-v6-0-49d980fed889@ti.com>
In-Reply-To: <20240903-b4-upstream-j742s2-v6-0-49d980fed889@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725351146; l=2872;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=KtDuyuvFIQe6hwFdkONOf46WKT+lVLl+CmT9GmjDIz0=;
 b=jNwuxd0Ldnk3xC+/z6EOPR8b6cb8JrE1HHW9BApja8Alhh41bduPfom/GxZD4ovnmOj4zqJeJ
 YERIAsfLkKcAjQa72uRF/R87sVibgt7l/pKRcPL9nIOAkmb5XUB9GoM
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


