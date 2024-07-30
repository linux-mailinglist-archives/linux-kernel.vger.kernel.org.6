Return-Path: <linux-kernel+bounces-266903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBF9940942
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A642846A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAA0191F66;
	Tue, 30 Jul 2024 07:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nJbxj+J7"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3704190475;
	Tue, 30 Jul 2024 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722323653; cv=none; b=QWl339zrlSSCCdGSdcQaHA39aKyYyfi5A8K5PWNDX6+daqLoP9RpPNppJ0ogtbaAz41/LwQwn23nXKJYeFPjXKviAf2IiaZzFGkjbwGdxZIdaQ1UY/RKW/Pzsur9wqG/z9Fl/nElN7GNameqWHE8ovXlB4xrq1VOvfnwF1+VDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722323653; c=relaxed/simple;
	bh=vnHnHt9hwib7yx9pu29W9soQMYvsXQMVRMVZbvbUSVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=b9kQCmoPaQ07h2fbZpxNxHqglHt6BMjFX/k9arL0OZHvToeL46saePOHJuZTggrp+q/JEPenE/TslfMmJqrkikTbiB91we+plhK7aTfDQU26TT0mrLDJ6L1M5nEjszHrSTJudaWWVp20mLusjXXZSTW7aG+SqGtIRwQ0hxvpdt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nJbxj+J7; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46U7E5hx086161;
	Tue, 30 Jul 2024 02:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722323645;
	bh=vfBncIRIpciT17g47+zXiPoXk4m1FMyX9lO4aRW8rO0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=nJbxj+J7gTrnmL7jLubpZr2NJ1/zNEJPH237VTJ4AlPSvfM5PYjmDm1pH+YJAL+aX
	 omp2IsFe4lBgDN51sCq/UmBQkkJqn9YozJuPqIzYZeHcDWRwnpd4NkJSrrHHs2nyzW
	 RLRcSwxO3mvTadJm6H5M55NkMYjm2xFqprN0vkFA=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46U7E53l014216
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jul 2024 02:14:05 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jul 2024 02:14:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jul 2024 02:14:04 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46U7DqUX078253;
	Tue, 30 Jul 2024 02:14:01 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 30 Jul 2024 12:43:48 +0530
Subject: [PATCH v2 2/3] arm64: dts: ti: Introduce J742S2 SoC family
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240730-b4-upstream-j742s2-v2-2-6aedf892156c@ti.com>
References: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
In-Reply-To: <20240730-b4-upstream-j742s2-v2-0-6aedf892156c@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722323632; l=3006;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=vnHnHt9hwib7yx9pu29W9soQMYvsXQMVRMVZbvbUSVs=;
 b=NqrKQjMvwzVnsTZGNtXwt+KyWFubZSad4VO9ASyjnSfFoqooioR4++x9XInYEo0fSjUp2xw+G
 W3ilaYyrLH5Bhh8tvJtRqchlrF1m/ZDZ3WEgOfTFMqrMsvR+UGYt/v0
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
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi | 44 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j742s2.dtsi      | 26 ++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi
new file mode 100644
index 000000000000..13b83560d5a2
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j742s2-main.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001
+ */
+
+/delete-node/ &c71_3;
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
index 000000000000..0b20c992d664
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-j742s2.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001
+ */
+
+#include "k3-j784s4.dtsi"
+
+/ {
+	model = "Texas Instruments K3 J742S2 SoC";
+	compatible = "ti,j742s2";
+
+	cpus {
+		cpu-map {
+			/delete-node/ cluster1;
+		};
+	};
+
+	/delete-node/ cpu4;
+	/delete-node/ cpu5;
+	/delete-node/ cpu6;
+	/delete-node/ cpu7;
+};
+
+#include "k3-j742s2-main.dtsi"

-- 
2.45.1


