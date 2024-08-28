Return-Path: <linux-kernel+bounces-304850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34E9625BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8EEB1F225E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD4916D4EA;
	Wed, 28 Aug 2024 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dS+FAs1K"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C2E16D4C4;
	Wed, 28 Aug 2024 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843740; cv=none; b=NPn9v4YWp3xEPrbjwcFWCHDbALe4NuIpr6k+0ODNUyOxPXS3DodHW6Rb8TQ3iGVrtZwGAlss3dpAn7Q0ev+ILmatoo9Nwzd7WWZYwg2vyQ4ZKt7sve5qAZ19e5DevgFJCSYhQRwizRvUK1eXwcD8KiGuckB0yCRZtZcJLWQ8oVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843740; c=relaxed/simple;
	bh=rqA7jF7A7vz8n74HxzUFOh3lgDGvDqNaspxJBN9Qh/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SM5FyxuD8wkQC2DAzQO3LSlT4Z5p32T6fbm9TPyQcuA9A1c9fI51tvOzqSLbPIlR0Xz80TBy7ODvWAQxAm3E2MttJNodRgI3RRqPe2HL72h4zZqse9uaP9HELWO5XiW6gU3rx5vpsfWZzyI52qdBJyIRsY/AQtKSMcjbPuNuzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=dS+FAs1K; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SBFRwY110003;
	Wed, 28 Aug 2024 06:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724843727;
	bh=ThdwiZjEeutdAObkB4+YI1yvrwfMFiN+aq8QuXwJeGk=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=dS+FAs1KwCvK4BrOXZKrqRynDuFzZ1sHQ2I0toZT+ulfQfjpQq2RFlSBZBx7cZ11I
	 gLhivQ63bY0CeF6daiigTHDgzfqkh5J9qn81mQtLGXp1h5hZAUUAXgDvDxSzqJZgbs
	 fKkuWB7DaI1ojubm4SjAkhKFtE0s7C7MQC4hn1Hg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SBFRmW130933
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 06:15:27 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 06:15:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 06:15:26 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SBF10C122618;
	Wed, 28 Aug 2024 06:15:23 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 28 Aug 2024 16:45:03 +0530
Subject: [PATCH v5 5/5] arm64: dts: ti: Add support for J742S2 EVM board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240828-b4-upstream-j742s2-v5-5-9aaa02a0faee@ti.com>
References: <20240828-b4-upstream-j742s2-v5-0-9aaa02a0faee@ti.com>
In-Reply-To: <20240828-b4-upstream-j742s2-v5-0-9aaa02a0faee@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724843701; l=2841;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=rqA7jF7A7vz8n74HxzUFOh3lgDGvDqNaspxJBN9Qh/w=;
 b=SwbZv6TaZMqwIK8yRlEkTGHnhuXm+gbMpVPOjJvCnyzVbdWzDSzxtpDaosre16Xkkosq+D3mY
 AZwF8JXha1vC43XwiHhsMZ4td32w5ibnC4r8PspPgSwem1x0rh1dkRo
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
 arch/arm64/boot/dts/ti/Makefile          |  4 ++++
 arch/arm64/boot/dts/ti/k3-j742s2-evm.dts | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

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

-- 
2.46.0


