Return-Path: <linux-kernel+bounces-532782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD41A45228
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8076189CD6B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6102198E84;
	Wed, 26 Feb 2025 01:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="MnjTorrM"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FDE17DE2D;
	Wed, 26 Feb 2025 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532907; cv=fail; b=TW9nSW+7rintAI9AiTWWJ4Q59pcusv8gJTz2WRQWA9RRologsJSexjLqMX5oS9W2HjeMuqz+VXJxgQVSEVhBmZ8psTD2yeXozamN5aVJAldCqNg9Z6LwJuDo3inKD41XGrbjwtS8kctyJm1ln1j+siFZnIxM/+CA3J2fLRUxz0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532907; c=relaxed/simple;
	bh=2p/Guila4LCF/7gozcPQcDlNSI/Huu9OxnM6BAHmuEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfWtiMHdQfYoZZDl5DAqx+Cx3tf4JXYXXSYMjCxalOYq7zqE38bppEnTK9SRuYZCCcTGEFWCsfpObMe8h3wJ3mpSri8PFaX6TvCYUR2AuliNOrNulsywVUX9M8n+0UP2+zq543xmgtsP0mhAMD41TVPNtZ+Dciz8uEwH1u8i7MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=MnjTorrM; arc=fail smtp.client-ip=40.107.255.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzybrVI2xrbJDZutv7sRvw580bumB1EQp5zf+OH55wup5HwmXQ7Brjg3CKkkKaTqDsgPtDIVY3aMfIrSnTPQt2IdMP/4FbL45mPgEmpdRd8NfNAyMhJ4yZPXImYnxPTwohH01mUie7g3Okylrx3cH/5/hR9NqAxL/Uo122eVc1s6yQzk2bpNm1Gvm98rdk+k0+UTSYvlJomjKBIMtx6Rrgl/F1BvZ9YNRMpWkEUD2W7HID0F2jRINtzt05Kl1P47J2iV0n8oOiX48KDS0vtSEhIWAcCtlK/5fkC8EFm3mkGxKZS/YfN33wCkWQUqm0r1NGOdGMkEpwXWnnBFFks0sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xxr5H9xXvu4J+corMKr7pcwAxa9W0tEQvisl6LjYPts=;
 b=nZdeVzyBrEyKgI3duiHcCv5/2bJkucYxjk69Vrvo7jizEZcw/gs/srhHWNgfBShyq2XuTKHOUAOR7xrEqncsZpIcmq/fWFCjBEHC3Z33I6hj/pJCTcC2athwWEbGkVcIDhqq18RriIbkqfkdUk4VsMMEloI99WN+7u7gjPFmj0FtzZlR3zLYKAevViG2fbG7AXAElkD8iiDdcyq6E7i2eRJhVI8iAQ7fSOM4UbKNypWRY0AVsOSzJC4Fj0jGAGwLTXhFrE2GZh0TqVYanr1/0mVa0Z1ZfCVH7MiYqwtUEzGU5WVLB6CG5BEAdfjBg2GLh+5pVNmUJehhlvSBUGHXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xxr5H9xXvu4J+corMKr7pcwAxa9W0tEQvisl6LjYPts=;
 b=MnjTorrMbvN7LnGJLnDJ3NjWhbVuKfiAmPeB+mtYf5YTOEexdjcAssX6Kaee1fCCtuqbP7h5nRWR3w6t2h4S1z1Qktyd94BwhwYHY4vUqpaA1jzY3+4JPkR3u4XL9plGD7YawM7mhSeOZuBHrGdlIvuSo1fQktx5pqmhCH5x1YaXN75UxO3EN728LHspdjOmK7P/mGlV4aMNfVispBnal7EBBu+Ba1uclA7cmsJD98aYCHushkfPHOlQWSz+sW3FXyX/+X/2O8+yMrLDbPl7mXkjXNg3bY5OWDItMIJedx1T+tqJzl0hyb6K7G+48wCQGro/AAj6uN41uJ4sW7DtmA==
Received: from SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) by TY0PR06MB5283.apcprd06.prod.outlook.com
 (2603:1096:400:210::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.13; Wed, 26 Feb
 2025 01:21:40 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:193:cafe::22) by SI2PR01CA0053.outlook.office365.com
 (2603:1096:4:193::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.22 via Frontend Transport; Wed,
 26 Feb 2025 01:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 01:21:39 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id A6A4B416050B;
	Wed, 26 Feb 2025 09:21:36 +0800 (CST)
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
	Fugang Duan <fugang.duan@cixtech.com>
Subject: [PATCH v2 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
Date: Wed, 26 Feb 2025 09:21:36 +0800
Message-Id: <20250226012136.854614-7-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226012136.854614-1-peter.chen@cixtech.com>
References: <20250226012136.854614-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|TY0PR06MB5283:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4240c86b-a05a-4877-c354-08dd5603eba5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ss71d/YyOx/unc29GfEpATGI9zlHTlfqBMJtliDJ3vbxMy6R74Htsg0tuSsg?=
 =?us-ascii?Q?gwEJF2OpzMtCU9mlo1a5fxK3Qk8c+IWy3oy5jIRiFDjdJo4sFX2syksn9SMf?=
 =?us-ascii?Q?KrWv2/UTNb8xNPAPB7M3lzbfoZZB9lE+Cz891pQRflqvhMq6t7iwHd4zPhXf?=
 =?us-ascii?Q?Rzs0jbohpVI0LOWVUrlLO6pakhL7l8yFbmHI3ofYq6/4TefSN2bb6M4ba9VL?=
 =?us-ascii?Q?ILOsMnbXPVHxw/q9Z3EbivsnTkfeuGIlq78xKNgoNGcJDpSthUR9Quw9K2cr?=
 =?us-ascii?Q?SlfkeM4KvHwYSX699NAvKBOjIjC0sapBRPaHkSbx27E6Q+qawqkOmliTct7G?=
 =?us-ascii?Q?lP+cGj1PPYwunkqQRMeiOH7bm+DgoI/pl6NpnMdkrCKG8o8YF2Vy/wvt9/UQ?=
 =?us-ascii?Q?cUrPKlJBvJjOtuIqM35Z/uRCFeFxxKcxhFvEqsDwcjou9TeW6/gLaakwTm2H?=
 =?us-ascii?Q?iwdoxEOUO3FL8FPrKbKxYKm4TzItlRws/hWR2FXh0fKEAT39vk3fLV/53ChT?=
 =?us-ascii?Q?KGvkKV3fVaw7SNicg1FE4p987NoN9R6Ur9LgjNhyR5/oDnHfvn+cc0nOZyeB?=
 =?us-ascii?Q?vosv9mmX5jSH7/hvKRumvmNAuROgOqdanMvfWfVhkuWvCMQGDKk+c7Jqqnbj?=
 =?us-ascii?Q?c48gQR4aDtQjhNu1AmUtLTlh3Ltx103B+HFw/o3bRopj8F0Vcy6QlmNy5qOb?=
 =?us-ascii?Q?BmJjINVFBYkDuOu7Z3qnrLApy7dhnEtoxN/fNwntkp2fEHUby3XjNt/BQEeo?=
 =?us-ascii?Q?C3CZvtg+GwyakrrT4RUgd4Jy7fwNxjmrh04r5+Us9bHuynQotG43oHsoLrYh?=
 =?us-ascii?Q?U4gregH3IpH1l/eK0c1MOT48skl9UKREkRklgcMOEEnTFFjQQjJ2A/3rBopo?=
 =?us-ascii?Q?8me2Wi4KSR6WRqbVc/nezcrmQNIaSGIxbcwfezf5A0N8qDkT9NsD131CdSVh?=
 =?us-ascii?Q?OtAv0N6DIgnSqYT5WcM3GTVRm3et8W1A3BEIZHm6fNRJ4OFO8vxNhby7vCh1?=
 =?us-ascii?Q?39SkuG+0P6hFv2YC6r8TQ8jlXysMUnu0e31aC8F4dl5fPZTIfEELTJg9qoe+?=
 =?us-ascii?Q?+TqWsO2VH955NXesCHMpN9ITBQAX1mcZ0Xjq8xtJ3oKLKdawmcTq1XkVmAxX?=
 =?us-ascii?Q?3cDADPJYTvnFVx5NRCn9wFO2tiaJtAGmXIj1S/nh51FGjMB15WyY2awN1EE5?=
 =?us-ascii?Q?9ZHMYlpOT0gYRUaD8uMdMF6cE4KqkWKShNRiv9Rd3UtaAg3iWnICWRVAifdj?=
 =?us-ascii?Q?3JsvHBc4hXD+WgtmB99a92Zbyk9aIbZWVzYRYAXjg74z5LV7OfcHGhXr73aV?=
 =?us-ascii?Q?soEsjwvJrk2hhEsPDNHGLTjh6wSHvUPV5TlpVaCISkLXVh3R//ThgDQ38LTn?=
 =?us-ascii?Q?hAKjWeQKKbkltgXPZwmctdeMWmFxAz4Gmk3Z4Y6JHNw8KmY4bwehgu/FwpoR?=
 =?us-ascii?Q?yIByb2DRjM0=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:21:39.3159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4240c86b-a05a-4877-c354-08dd5603eba5
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5283

CIX SKY1 SoC is high performance Armv9 SoC designed by Cixtech,
and Orion O6 is open source motherboard launched by Radxa.
See below for detail:
https://docs.radxa.com/en/orion/o6/getting-started/introduction

In this commit, it only adds limited components for running initramfs
at Orion O6.

Acked-by: Fugang Duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
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
 arch/arm64/boot/dts/cix/sky1.dtsi         | 217 ++++++++++++++++++++++
 4 files changed, 246 insertions(+)
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
index 000000000000..709512fafe51
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -0,0 +1,217 @@
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
+
+	};
+
+	pmu-a520 {
+		compatible = "arm,cortex-a520-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-a720 {
+		compatible = "arm,cortex-a720-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmu-spe {
+		compatible = "arm,statistical-profiling-extension-v1";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0 0 0 0 0x20 0>;
+		dma-ranges;
+
+		gic: interrupt-controller@e010000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
+			      <0x0 0x0e090000 0 0x300000>;       /* GICR * 12 */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			redistributor-stride = <0 0x40000>;
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
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-names = "sec-phys", "phys", "virt", "hyp-phys", "hyp-virt";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
+		clock-frequency = <1000000000>;
+		arm,no-tick-in-suspend;
+	};
+};
-- 
2.25.1


