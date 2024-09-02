Return-Path: <linux-kernel+bounces-311317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9D968778
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8682B1C222AE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D441D6180;
	Mon,  2 Sep 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="awgTfVoX"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8D1D2F5B;
	Mon,  2 Sep 2024 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280040; cv=none; b=hji8QWKOeyhmhZkKpd2d1L952RwvAd1VfG39aEklcxN49Q8N/QtdUd6huORoqhRMx2uwgORFiSU3D38q/E2kmziqqeMbgmoQLugbP46J16unJACwtU+8zALOf+zw+FIU2YdYTkAWLYh9morFsZ07K4HFywPMH6Q5F1E2FSWelVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280040; c=relaxed/simple;
	bh=r3FJ+NvcBswGiBVmjnktYvly72WHKYG9nwJXWnLXuZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GDT7ar+cd+RlNf4+CjS/PNVDgPceQ6z35V6HQm8AzCNaGKtSKJV45ipQBD7yS8cALHVN2+ufOhM4bl9yVtTATmNa8ovVlF0D2AZzPznlatHj+Tnu7ve6grTzfTfTdK1OKlQa5R11aCmPGmgspi3EJjH9RpXlnaN6nTzJSdCvQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=awgTfVoX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 482CRD5K099652;
	Mon, 2 Sep 2024 07:27:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725280033;
	bh=GdIgq7tTbqAET6t3ruFSw2Eycalp9QyuuesSwZolt+E=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=awgTfVoXjq+4NWVg394i0wEg35IQPQrsXdW/UchiLczSkZZHocvHQgENfYxfqgTjk
	 S9Ta/0xu3aA+4Uv8pcyDxUbHm6jcpiHLOTjPwmMjhXYWeDjMX1NaCDJJWmij3O+GOH
	 HZTftegRkTeKDprwT0vAVyspIYcvYP+DxNL1y6dE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 482CRDT2003851
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Sep 2024 07:27:13 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Sep 2024 07:27:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Sep 2024 07:27:12 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 482CQpGI023644;
	Mon, 2 Sep 2024 07:27:09 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 2 Sep 2024 17:56:52 +0530
Subject: [PATCH v6 4/5] arm64: dts: ti: Introduce J742S2 SoC family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240902-b4-upstream-j742s2-v6-4-6a7aa2736797@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725280011; l=4709;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=r3FJ+NvcBswGiBVmjnktYvly72WHKYG9nwJXWnLXuZQ=;
 b=tUtdMhcLlv6rqldQdjfcMFbas87B3FKvxSVOAlPU8r0pl7/EkKEjtrvvoTwZYSS1ygu9O4eJT
 f2VonmwSVz3CGwSfolaFE/HgxKUQzgaRejKgeaPeOCE/yOmGouE2J97
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

Notes:
    v6: No change

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


