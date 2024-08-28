Return-Path: <linux-kernel+bounces-304848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C1C9625B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5BCCB22851
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09861171E40;
	Wed, 28 Aug 2024 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PeVMoMtL"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F46116D4F3;
	Wed, 28 Aug 2024 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843731; cv=none; b=ksiiqkTlIZn18gtKB6zCwPCo1oD/Mc3eLlpkEJ14K6A6UL9A9qVAx8QFf+u1ZVOogNnn5mqVLdOc9n2pwygJReKmV9UwOY6G+1+os+Mm/gdKT+V4Nf0zojYv8PMkdph2Yemvk6qqrEfTP6HfABPMM0ie6gXtHh8R4fnG08ue0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843731; c=relaxed/simple;
	bh=jTnswQ6MZuIICPIfNk1+1Otuk/XWmkVfEg9QpHwux5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XUdbUCzulwkmKKKTpfdCrW3tZD5x+/GyBZ6s8ANKvDD1wIq9R69hqg1/Zxanyt5bL5Y9jTPzgfIK9iZz9PWzCZ8nHcvGnHKJVAJAECU7FMWprO6In2Srr+12+jgJ0o/QAyVZ+SjcTwhKn9PVYdyDr93cMyRLFy4zrSKtJcvSGc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PeVMoMtL; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47SBFNfN016200;
	Wed, 28 Aug 2024 06:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724843723;
	bh=c/Dyhf6X8DdjfqN1z7ITLdRcHgBahZ71/8doZdMztaU=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=PeVMoMtLFDwg9a5RBn+INKYLQPalHsuQvQeEuJ2jFghn/QnnD/hvpdE485esFrU46
	 2SKILJBKnAp906PCxtbzLAgdN0kBAP1BlX1oDh3giNM6xudFzA4AnThK13Mm53RnBU
	 eOTM31StyxpYyx49TGLbtR8Y2GYZdkyj6eZRqA7s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47SBFNPc130888
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 06:15:23 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 06:15:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 06:15:22 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47SBF10B122618;
	Wed, 28 Aug 2024 06:15:19 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 28 Aug 2024 16:45:02 +0530
Subject: [PATCH v5 4/5] arm64: dts: ti: Introduce J742S2 SoC family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240828-b4-upstream-j742s2-v5-4-9aaa02a0faee@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724843701; l=4678;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=jTnswQ6MZuIICPIfNk1+1Otuk/XWmkVfEg9QpHwux5Q=;
 b=C6mAmESFGXZBu5znoHISatK7wUedp+K95akQCFr7xSU7E3J5B6uvTz5yWg9MP7gHdTQ6mPyU1
 rhxORfKv2u7AZNs9m9H51Mk+lzOqw+Gs502/shdjq0ShwL0CC7sCqqD
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

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

Some changes that this devices has from J784S4 are:
* 4x Cortex-A72 vs 8x Cortex-A72
* 3x C7x DSP vs 4x C7x DSP
* 4 port ethernet switch vs 8 port ethernet switch

( Refer Table 2-1 for Device comparison with J7AHP )
Link: https://www.ti.com/lit/pdf/spruje3 (TRM)
Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi | 45 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi      | 98 ++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi
new file mode 100644
index 000000000000..b320c27f7afe
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for J742S2 SoC Family
+ *
+ * TRM: https://www.ti.com/lit/pdf/spruje3
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
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
diff --git a/arch/arm64/boot/dts/ti/k3-j742s2.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
new file mode 100644
index 000000000000..7a72f82f56d6
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Device Tree Source for J742S2 SoC Family
+ *
+ * TRM: https://www.ti.com/lit/pdf/spruje3
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+#include "k3-j784s4-j742s2-common.dtsi"
+
+/ {
+	model = "Texas Instruments K3 J742S2 SoC";
+	compatible = "ti,j742s2";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
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
+	};
+};
+
+#include "k3-j742s2-main.dtsi"

-- 
2.46.0


