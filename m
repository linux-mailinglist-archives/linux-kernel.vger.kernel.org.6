Return-Path: <linux-kernel+bounces-546122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D1AA4F6A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8BC188BE59
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B61E9917;
	Wed,  5 Mar 2025 05:38:35 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2124.outbound.protection.outlook.com [40.107.117.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866801C8623;
	Wed,  5 Mar 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153114; cv=fail; b=aGQKxbGiEYLwgAI6u6nvAGBgM3xXPm6Knn7ReJyxah3NcmDL9ZX9OKydKgL7Pf17bTSkSnFDWUfLU/GjstJWiOJPjQWnVcXFCCh6r2vAylpOtb71Y0P1wNRCricRXuR7KiiT6rTbKWtdq32ghbBkeW17/W9IajRWVj5XWepIVeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153114; c=relaxed/simple;
	bh=zXAHzmZIDW9HNhmQrOQIaf1vDNHEjbrTOpQH6P/q1Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RH4v3EEj8g4scPW9gQhtANd67Ro1EKm9vkqb7w1huf8w4PW6svwYXwFsNj83RGAN61jMXmogaFsrf/n3eBJF+bSQsqK8QPE+Ju2k8b+VtO0QHCj88w8GdJzUjf3ieXNXD2b2wsVCDpm9LV7aCa550/FaOPGUlQqogPj1bTVhfyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.117.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb5dIwSCZXDiKHe20AVtTfkVE1V4/ho/bXIy4YRafrPF+SPbg+Ncn19oEBHAnIB2ePO5UOgF5uffc+4bpIYKIZOeMMYyiQDCM/wDegbhnXbkBT7GCTrtsy8elA0aTFNdYG2b9LhSS/7JN7CPSFMFCYrKYLgirRL5h/+eyPhflRSGcJtYuwHaAwjb5uLkqSsigXuiXEiqyCBXG5U9QOPZvczGt4JktkKE2QPAcYIsXthCIzlJiZLd/ft/r5k8CT6+a6EGSNH1IpPkVaWVbTww1YfSbpxkUrzQhlDEyNSiZJY8psvj+EnkVa1fSoAtcZ6x2HOV20JYgfgkn4ipsSMuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rw5XcIpbhzZitEnCHBvlFDCmaFY78PQmKO5kDwkVMo=;
 b=qvYu5Vb3JEz+A0Ni/yjM6j3jTdGdhVd0t0UFVaQV+D++efd8jL2Piu5uj8mnOiLyIRt+7F54PW0b4KU0o5dE7jjPO5Rd7ELhTMMynRf6bdXAffPU3OgkR/+CskvQDplzH21Rr4w3YAqYlWC++JhfktTlIZ7Y+LicAzzSxBm7Jn5kFHlZqDW1XR+oOHoQcwp+kIdqJbiAO4Zog62UziL2eGgwT6QIbL4G0bPQko6e3taGQIrEgyP9AcoPgRnjHDQgYgHMg9+wdIbtFk1Xf/UH+VUUOCK6Rap947mPj5h1yrroFKxZpyBjTeTj8oWK0uWpcxZuCafn5qHwlYWzoagFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::21) by TY0PR06MB5007.apcprd06.prod.outlook.com
 (2603:1096:400:1ac::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 05:38:27 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:300:2d:cafe::ed) by PS2PR01CA0009.outlook.office365.com
 (2603:1096:300:2d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Wed,
 5 Mar 2025 05:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 05:38:26 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D17EB4160510;
	Wed,  5 Mar 2025 13:38:23 +0800 (CST)
From: Peter Chen <peter.chen@cixtech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl,
	Peter Chen <peter.chen@cixtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v4 5/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
Date: Wed,  5 Mar 2025 13:38:22 +0800
Message-Id: <20250305053823.2048217-6-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305053823.2048217-1-peter.chen@cixtech.com>
References: <20250305053823.2048217-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TY0PR06MB5007:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 575a8b6a-f708-4aff-4430-08dd5ba7f3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8IrGwYOw/TCpmZQy9Gp9Ed2lkCXxU4EgbEYpBmWr5ZafxycrHLLK5M9xFJ02?=
 =?us-ascii?Q?ZO1qnbyE5xqDu/+bCUoivTBPFUbI/zsNKbOmS/dXfOwFZ02QaBH7eS4oIz6d?=
 =?us-ascii?Q?iM1v3I4pcCKfcOE2D2ppUMBsGiGHmAjRAUj/HhXvt9+s2xs9Py+IkHrsL+i/?=
 =?us-ascii?Q?HuQqrArT66QGzMZpPkpA9CKo46h6GwpVPRjMcj0nveShE/tfbT7J6jMPSAqX?=
 =?us-ascii?Q?GT+fjvTRytDHLohfb1Gx/7pXsht9TdTyOvw5zcZFLTW+Neb9dszogCNvZFsO?=
 =?us-ascii?Q?zVccEyYFXpYSiN7tfVAm8nuuO9+5PDbyAX2pwe2Z/YFdXc0mZ9ohHiWQb3Y3?=
 =?us-ascii?Q?wgY9dw6FZcPY7VGiAwKE0tjrb8EYUejgEA5Qd2Z9gcKR7B1KXuZ7dfS3tWNZ?=
 =?us-ascii?Q?cO2r+J1gaahS4SZwcpv7jLmUqAZVz6lqmC1pIJg0dLUjC9Io4kFJyi/gSV5J?=
 =?us-ascii?Q?On55xbYIU8tqNzALMLWRXpq7yLap7/rLsCCeBi4e4/PcxLtku5SYZc4i+3iz?=
 =?us-ascii?Q?Rjw+hP+xP3urtHx0dA4a4ra9ttRXMB0L7MfAU0jj8kLwvrlVHRWwvmYRhKKb?=
 =?us-ascii?Q?zs4oVLR/gI9yvnnvkjnuXPIJ3fydbJ3OuBo+m0/raf1v138m/pQqphCiBMc2?=
 =?us-ascii?Q?86XPE+VidLn9Fyyij5jOxVP2Bq3n0dcI9qhyiAeBFuhAcbt1PmWzqGbJy5Y5?=
 =?us-ascii?Q?Rrcyp8WxHpB5kAFwpBDz2oTJCDbbbWIErbkHGRsH6eScOl2cLa5wVIa/QQCw?=
 =?us-ascii?Q?61HU/YhXgSwzWuVDRSjYGrgjJ1rm9FFAoZJZbyFjDvArWh08WkE/Il/o6pgL?=
 =?us-ascii?Q?6YDjy/BsEUBb4YI/D23VOWvSikHBBjUBladU201I17TnkwPq+J/B5TgcbTV/?=
 =?us-ascii?Q?3eqO+hTMOZGJfKps7yAtHEm68VIbujjIBi90AdlKLzdjG3mcca92MHOIURSo?=
 =?us-ascii?Q?PSqJeaEcl5kVkLUNbdmEKDaYCeZM89Ktt2xIBLMFLhmtQNj6bL/tDkO9o7Y1?=
 =?us-ascii?Q?+ingL8vm/gVNZo5r3qyrtR13buf+GZVfqCfGxzvdmmRnloVBHiJLBh16LNb+?=
 =?us-ascii?Q?65pMzcZhm9lubfnmcViBoOciXNsD083xwiRMR7ojfeQNsG4fOg2Te167hEOi?=
 =?us-ascii?Q?wwES8v8IHK1udTj5MB/YqavQs2P0xu4u1QrCIpScoXTN7vzDjbm82ZhXkgCS?=
 =?us-ascii?Q?FQSzwYzYln8tK8X8+UxFQ2dE84hfzjaQ9F0P5zNdLFbs3X+MVdaAg6KP/XJv?=
 =?us-ascii?Q?MSsckFWiU55Wr6vmLoZwO8bW8uogNzhiFGE873yUgVUmicHlEvGJXUbkPOcM?=
 =?us-ascii?Q?AfRgkqtdsxlOfpKgbs32gtpAnMiW/Pgqlijq2pAsqRmChFbJ/qaabwChZjdt?=
 =?us-ascii?Q?h7HJmYpUoDg+MwlCM0AXMW/f70oSMNHyhiwPgFwlDKWnhnAFNvezz0tACRz7?=
 =?us-ascii?Q?6rgZdwJuVDM=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 05:38:26.4294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 575a8b6a-f708-4aff-4430-08dd5ba7f3f3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5007

CIX SKY1 SoC is high performance Armv9 SoC designed by Cixtech,
and Orion O6 is open source motherboard launched by Radxa.
See below for detail:
https://docs.radxa.com/en/orion/o6/getting-started/introduction

In this commit, it only adds limited components for running initramfs
at Orion O6.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
Changes for v4:
- Add ppi-partition entry for gic-v3 node, and let pmu-a520 and pmu-a720's interrupt entry
get its handle
- Remove gic-v3's #redistributor-regions and redistributor-stride properties
- Change gic-v3's #interrupt-cells as 4, and change all interrupt specifiers accordingly
- Remove "arm,no-tick-in-suspend" for timer due to global counter is at always-on power domain
- Remove timer's clock frequency due to firmware has already set it
- Add Krzysztof Kozlowski's reviewed-by
Changes for v3:
- Fix two dts coding sytle issues 
Changes for v2:
- Corrects the SoF tag's name
- Fix several coding sytle issues
- move linux,cma node to dts file
- delete memory node, memory size is passed by firmware
- delete uart2 node which will be added in future patches
- Improve for pmu and cpu node to stands for more specific cpu model
- Improve the timer node and add hypervisor virtual timer irq
- Pass "make O=$OUTKNL CHECK_DTBS=y W=1 cix/sky1-orion-o6.dtb"

 arch/arm64/boot/dts/Makefile              |   1 +
 arch/arm64/boot/dts/cix/Makefile          |   2 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts |  26 +++
 arch/arm64/boot/dts/cix/sky1.dtsi         | 222 ++++++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 arch/arm64/boot/dts/cix/Makefile
 create mode 100644 arch/arm64/boot/dts/cix/sky1-orion-o6.dts
 create mode 100644 arch/arm64/boot/dts/cix/sky1.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 79b73a21ddc2..8e7ccd0027bd 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -13,6 +13,7 @@ subdir-y += bitmain
 subdir-y += blaize
 subdir-y += broadcom
 subdir-y += cavium
+subdir-y += cix
 subdir-y += exynos
 subdir-y += freescale
 subdir-y += hisilicon
diff --git a/arch/arm64/boot/dts/cix/Makefile b/arch/arm64/boot/dts/cix/Makefile
new file mode 100644
index 000000000000..ed3713982012
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_CIX) += sky1-orion-o6.dtb
diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
new file mode 100644
index 000000000000..78f4fcd87216
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2025 Cix Technology Group Co., Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "sky1.dtsi"
+/ {
+	model = "Radxa Orion O6";
+	compatible = "radxa,orion-o6", "cix,sky1";
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x28000000>;
+			linux,cma-default;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
new file mode 100644
index 000000000000..5c5a2d1144c1
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright 2025 Cix Technology Group Co., Ltd.
+ *
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu1: cpu@100 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu2: cpu@200 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x200>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu3: cpu@300 {
+			compatible = "arm,cortex-a520";
+			enable-method = "psci";
+			reg = <0x0 0x300>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		cpu4: cpu@400 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x400>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu5: cpu@500 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x500>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu6: cpu@600 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x600>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu7: cpu@700 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x700>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu8: cpu@800 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x800>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu9: cpu@900 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0x900>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu10: cpu@a00 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0xa00>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu11: cpu@b00 {
+			compatible = "arm,cortex-a720";
+			enable-method = "psci";
+			reg = <0x0 0xb00>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+				core4 {
+					cpu = <&cpu4>;
+				};
+				core5 {
+					cpu = <&cpu5>;
+				};
+				core6 {
+					cpu = <&cpu6>;
+				};
+				core7 {
+					cpu = <&cpu7>;
+				};
+				core8 {
+					cpu = <&cpu8>;
+				};
+				core9 {
+					cpu = <&cpu9>;
+				};
+				core10 {
+					cpu = <&cpu10>;
+				};
+				core11 {
+					cpu = <&cpu11>;
+				};
+			};
+		};
+	};
+
+	pmu-a520 {
+		compatible = "arm,cortex-a520-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_partition0>;
+	};
+
+	pmu-a720 {
+		compatible = "arm,cortex-a720-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_partition1>;
+	};
+
+	pmu-spe {
+		compatible = "arm,statistical-profiling-extension-v1";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW 0>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		ranges = <0 0 0 0 0x20 0>;
+		dma-ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		gic: interrupt-controller@e010000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
+			      <0x0 0x0e090000 0 0x300000>;       /* GICR * 12 */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW 0>;
+			#interrupt-cells = <4>;
+			interrupt-controller;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			gic_its: msi-controller@e050000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x0 0x0e050000 0x0 0x30000>;
+				msi-controller;
+				#msi-cells = <1>;
+			};
+
+			ppi-partitions {
+				ppi_partition0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
+				};
+
+				ppi_partition1: interrupt-partition-1 {
+					affinity = <&cpu4 &cpu5 &cpu6 &cpu7 &cpu8 &cpu9 &cpu10 &cpu11>;
+				};
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW 0>;
+	};
+};
-- 
2.25.1


