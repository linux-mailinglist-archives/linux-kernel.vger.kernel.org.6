Return-Path: <linux-kernel+bounces-269607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4489434C7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC858B21800
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6131C1BE865;
	Wed, 31 Jul 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xySRrZLp"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84B1BD038;
	Wed, 31 Jul 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445858; cv=none; b=gjWuWnZHmg9GTipWlpy1Y3dkwfsREpOkuLdJTgovyO8yIU1rpMgUl1Ex1P3OClIX89/mzAdnaLGN7Ig+zBmTCxVjn38e2Q9NuoPGMZp3CWgArsuH4Km5VmGDLg+jKRjEfU5DRa3i8m6Ku3GYC8kkeWZNfV/xtBNRVmhfJW8XJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445858; c=relaxed/simple;
	bh=NQJhLkVUf4L1m2n4sGBHvUR7/0T/0z4Uo6zxCI/5Gsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=glR9frBLgx50tYxl8GuOBNP+bVsNC8UijlHpJJhL/OQebBlXrWQL75HBFI9nzNvNCH07SwyUahkmtBN9sA6FXXQxuP6s10erDp0YIV2z5ADRcPbuGedCih8PSs8t/IxknanYsrswM8px70+RSZfaVH1KlHXgZ/DyyetRFF34Hns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xySRrZLp; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAhCM108324;
	Wed, 31 Jul 2024 12:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722445843;
	bh=Trcpyc/NIUJEZNBzu4/5khk9DVmAdX9BtlRoMb1AqFU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=xySRrZLp50/u6wIv4Lk+iTS0vw0/WI81d3EwNqLNensUSTiV9Jc6qr3CnA8a0U2PQ
	 vZy3NcmiKUgfP+dT6dzk+K5hDrE3o1WiaEp/0Rs5QlKlLWF6mQoHfkUVGUh/GWPJdw
	 9XmgHKFPWUA5wCLJ4LMVRmr2R4yTokryjASo0i9o=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46VHAh2t123626
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jul 2024 12:10:43 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jul 2024 12:10:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jul 2024 12:10:43 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46VHAVgP036362;
	Wed, 31 Jul 2024 12:10:39 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 31 Jul 2024 22:40:28 +0530
Subject: [PATCH v3 2/9] arm64: dts: ti: Move k3-j784s4.dtsi to
 k3-j784s4-j742s2-common.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240731-b4-upstream-j742s2-v3-2-da7fe3aa9e90@ti.com>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
In-Reply-To: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722445831; l=19673;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=NQJhLkVUf4L1m2n4sGBHvUR7/0T/0z4Uo6zxCI/5Gsk=;
 b=FemCBjcj974/U58xhgeJzduBXBKMKSE1jnfiMNoeUSSAqAt2wDRVe5HnHVDNwvsJAx9nbD4l0
 AVqCvn2UEgIAfhv9OFIFlnJWmSCxbxpUG/w/9abcss2IMgsMG1sFWti
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This is to introduce j742s2 support later, things from here will be
moved to appropriate location.

File k3-j784s4.dtsi is not exactly removed as the EVM files are
dependent on that. Hence to keep the compatibility, after moving;
k3-j784s4.dtsi is including k3-j784s4-j742s2-common.dtsi

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 .../arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi | 305 +++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi              | 295 +-------------------
 2 files changed, 306 insertions(+), 294 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
new file mode 100644
index 000000000000..76e43ee44496
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-common.dtsi
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for J784S4 SoC Family
+ *
+ * TRM (SPRUJ43 JULY 2022): https://www.ti.com/lit/zip/spruj52
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+#include "k3-pinctrl.h"
+
+/ {
+	model = "Texas Instruments K3 J784S4 SoC";
+	compatible = "ti,j784s4";
+	interrupt-parent = <&gic500>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu-map {
+			cluster0: cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1: cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+
+				core2 {
+					cpu = <&cpu6>;
+				};
+
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a72";
+			reg = <0x000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a72";
+			reg = <0x001>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a72";
+			reg = <0x002>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a72";
+			reg = <0x003>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_0>;
+		};
+
+		cpu4: cpu@100 {
+			compatible = "arm,cortex-a72";
+			reg = <0x100>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu5: cpu@101 {
+			compatible = "arm,cortex-a72";
+			reg = <0x101>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu6: cpu@102 {
+			compatible = "arm,cortex-a72";
+			reg = <0x102>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+
+		cpu7: cpu@103 {
+			compatible = "arm,cortex-a72";
+			reg = <0x103>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0xc000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <256>;
+			next-level-cache = <&L2_1>;
+		};
+	};
+
+	L2_0: l2-cache0 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-unified;
+		cache-size = <0x200000>;
+		cache-line-size = <64>;
+		cache-sets = <1024>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	L2_1: l2-cache1 {
+		compatible = "cache";
+		cache-level = <2>;
+		cache-unified;
+		cache-size = <0x200000>;
+		cache-line-size = <64>;
+		cache-sets = <1024>;
+		next-level-cache = <&msmc_l3>;
+	};
+
+	msmc_l3: l3-cache0 {
+		compatible = "cache";
+		cache-level = <3>;
+		cache-unified;
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	a72_timer0: timer-cl0-cpu0 {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a72-pmu";
+		/* Recommendation from GIC500 TRM Table A.3 */
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	cbass_main: bus@100000 {
+		bootph-all;
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
+			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
+			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
+			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
+			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
+			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
+			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIe0 Core*/
+			 <0x00 0x0d800000 0x00 0x0d800000 0x00 0x00800000>, /* PCIe1 Core*/
+			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x00800000>, /* PCIe2 Core*/
+			 <0x00 0x0e800000 0x00 0x0e800000 0x00 0x00800000>, /* PCIe3 Core*/
+			 <0x00 0x10000000 0x00 0x10000000 0x00 0x08000000>, /* PCIe0 DAT0 */
+			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
+			 <0x00 0x64800000 0x00 0x64800000 0x00 0x0070c000>, /* C71_1 */
+			 <0x00 0x65800000 0x00 0x65800000 0x00 0x0070c000>, /* C71_2 */
+			 <0x00 0x66800000 0x00 0x66800000 0x00 0x0070c000>, /* C71_3 */
+			 <0x00 0x67800000 0x00 0x67800000 0x00 0x0070c000>, /* C71_4 */
+			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
+			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00400000>, /* MSMC RAM */
+			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
+			 <0x40 0x00000000 0x40 0x00000000 0x01 0x00000000>, /* PCIe0 DAT1 */
+			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
+			 <0x42 0x00000000 0x42 0x00000000 0x01 0x00000000>, /* PCIe2 DAT1 */
+			 <0x43 0x00000000 0x43 0x00000000 0x01 0x00000000>, /* PCIe3 DAT1 */
+			 <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* PCIe2 DAT0 */
+			 <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* PCIe3 DAT0 */
+			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
+
+			 /* MCUSS_WKUP Range */
+			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
+			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>,
+			 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>,
+			 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
+			 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
+			 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>,
+			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
+			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
+			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
+			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
+			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
+			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
+
+		cbass_mcu_wakeup: bus@28380000 {
+			bootph-all;
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
+				 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>, /* First peripheral window */
+				 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>, /* CTRL_MMR0 */
+				 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
+				 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
+				 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>, /* MCU SRAM */
+				 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP peripheral window */
+				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
+				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
+				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
+				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 0 */
+				 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS OSPI0 data region 3 */
+				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
+		};
+	};
+
+	thermal_zones: thermal-zones {
+		#include "k3-j784s4-j742s2-thermal-common.dtsi"
+	};
+};
+
+/* Now include peripherals from each bus segment */
+#include "k3-j784s4-j742s2-main-common.dtsi"
+#include "k3-j784s4-j742s2-mcu-wakeup-common.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
index 76e43ee44496..46cff5ed3730 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4.dtsi
@@ -8,298 +8,5 @@
  *
  */
 
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/soc/ti,sci_pm_domain.h>
+#include "k3-j784s4-j742s2-common.dtsi"
 
-#include "k3-pinctrl.h"
-
-/ {
-	model = "Texas Instruments K3 J784S4 SoC";
-	compatible = "ti,j784s4";
-	interrupt-parent = <&gic500>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		cpu-map {
-			cluster0: cluster0 {
-				core0 {
-					cpu = <&cpu0>;
-				};
-
-				core1 {
-					cpu = <&cpu1>;
-				};
-
-				core2 {
-					cpu = <&cpu2>;
-				};
-
-				core3 {
-					cpu = <&cpu3>;
-				};
-			};
-
-			cluster1: cluster1 {
-				core0 {
-					cpu = <&cpu4>;
-				};
-
-				core1 {
-					cpu = <&cpu5>;
-				};
-
-				core2 {
-					cpu = <&cpu6>;
-				};
-
-				core3 {
-					cpu = <&cpu7>;
-				};
-			};
-		};
-
-		cpu0: cpu@0 {
-			compatible = "arm,cortex-a72";
-			reg = <0x000>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu1: cpu@1 {
-			compatible = "arm,cortex-a72";
-			reg = <0x001>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu2: cpu@2 {
-			compatible = "arm,cortex-a72";
-			reg = <0x002>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu3: cpu@3 {
-			compatible = "arm,cortex-a72";
-			reg = <0x003>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_0>;
-		};
-
-		cpu4: cpu@100 {
-			compatible = "arm,cortex-a72";
-			reg = <0x100>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_1>;
-		};
-
-		cpu5: cpu@101 {
-			compatible = "arm,cortex-a72";
-			reg = <0x101>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_1>;
-		};
-
-		cpu6: cpu@102 {
-			compatible = "arm,cortex-a72";
-			reg = <0x102>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_1>;
-		};
-
-		cpu7: cpu@103 {
-			compatible = "arm,cortex-a72";
-			reg = <0x103>;
-			device_type = "cpu";
-			enable-method = "psci";
-			i-cache-size = <0xc000>;
-			i-cache-line-size = <64>;
-			i-cache-sets = <256>;
-			d-cache-size = <0x8000>;
-			d-cache-line-size = <64>;
-			d-cache-sets = <256>;
-			next-level-cache = <&L2_1>;
-		};
-	};
-
-	L2_0: l2-cache0 {
-		compatible = "cache";
-		cache-level = <2>;
-		cache-unified;
-		cache-size = <0x200000>;
-		cache-line-size = <64>;
-		cache-sets = <1024>;
-		next-level-cache = <&msmc_l3>;
-	};
-
-	L2_1: l2-cache1 {
-		compatible = "cache";
-		cache-level = <2>;
-		cache-unified;
-		cache-size = <0x200000>;
-		cache-line-size = <64>;
-		cache-sets = <1024>;
-		next-level-cache = <&msmc_l3>;
-	};
-
-	msmc_l3: l3-cache0 {
-		compatible = "cache";
-		cache-level = <3>;
-		cache-unified;
-	};
-
-	firmware {
-		optee {
-			compatible = "linaro,optee-tz";
-			method = "smc";
-		};
-
-		psci: psci {
-			compatible = "arm,psci-1.0";
-			method = "smc";
-		};
-	};
-
-	a72_timer0: timer-cl0-cpu0 {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
-			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
-			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
-	};
-
-	pmu: pmu {
-		compatible = "arm,cortex-a72-pmu";
-		/* Recommendation from GIC500 TRM Table A.3 */
-		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	cbass_main: bus@100000 {
-		bootph-all;
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
-			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
-			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
-			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0d000000>, /* Most peripherals */
-			 <0x00 0x04210000 0x00 0x04210000 0x00 0x00010000>, /* VPU0 */
-			 <0x00 0x04220000 0x00 0x04220000 0x00 0x00010000>, /* VPU1 */
-			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x00800000>, /* PCIe0 Core*/
-			 <0x00 0x0d800000 0x00 0x0d800000 0x00 0x00800000>, /* PCIe1 Core*/
-			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x00800000>, /* PCIe2 Core*/
-			 <0x00 0x0e800000 0x00 0x0e800000 0x00 0x00800000>, /* PCIe3 Core*/
-			 <0x00 0x10000000 0x00 0x10000000 0x00 0x08000000>, /* PCIe0 DAT0 */
-			 <0x00 0x18000000 0x00 0x18000000 0x00 0x08000000>, /* PCIe1 DAT0 */
-			 <0x00 0x64800000 0x00 0x64800000 0x00 0x0070c000>, /* C71_1 */
-			 <0x00 0x65800000 0x00 0x65800000 0x00 0x0070c000>, /* C71_2 */
-			 <0x00 0x66800000 0x00 0x66800000 0x00 0x0070c000>, /* C71_3 */
-			 <0x00 0x67800000 0x00 0x67800000 0x00 0x0070c000>, /* C71_4 */
-			 <0x00 0x6f000000 0x00 0x6f000000 0x00 0x00310000>, /* A72 PERIPHBASE */
-			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00400000>, /* MSMC RAM */
-			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
-			 <0x40 0x00000000 0x40 0x00000000 0x01 0x00000000>, /* PCIe0 DAT1 */
-			 <0x41 0x00000000 0x41 0x00000000 0x01 0x00000000>, /* PCIe1 DAT1 */
-			 <0x42 0x00000000 0x42 0x00000000 0x01 0x00000000>, /* PCIe2 DAT1 */
-			 <0x43 0x00000000 0x43 0x00000000 0x01 0x00000000>, /* PCIe3 DAT1 */
-			 <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* PCIe2 DAT0 */
-			 <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* PCIe3 DAT0 */
-			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
-
-			 /* MCUSS_WKUP Range */
-			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
-			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>,
-			 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>,
-			 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
-			 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
-			 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>,
-			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
-			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
-			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
-			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>,
-			 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>,
-			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>,
-			 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>;
-
-		cbass_mcu_wakeup: bus@28380000 {
-			bootph-all;
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
-				 <0x00 0x40200000 0x00 0x40200000 0x00 0x00998400>, /* First peripheral window */
-				 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>, /* CTRL_MMR0 */
-				 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
-				 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
-				 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00100000>, /* MCU SRAM */
-				 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP peripheral window */
-				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
-				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
-				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>, /* OSPI register space */
-				 <0x00 0x50000000 0x00 0x50000000 0x00 0x10000000>, /* FSS OSPI0/1 data region 0 */
-				 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS OSPI0 data region 3 */
-				 <0x07 0x00000000 0x07 0x00000000 0x01 0x00000000>; /* FSS OSPI1 data region 3*/
-		};
-	};
-
-	thermal_zones: thermal-zones {
-		#include "k3-j784s4-j742s2-thermal-common.dtsi"
-	};
-};
-
-/* Now include peripherals from each bus segment */
-#include "k3-j784s4-j742s2-main-common.dtsi"
-#include "k3-j784s4-j742s2-mcu-wakeup-common.dtsi"

-- 
2.45.1


