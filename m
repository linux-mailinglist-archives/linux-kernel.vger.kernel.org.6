Return-Path: <linux-kernel+bounces-523198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB45A3D36F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDA7A3EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328041EE004;
	Thu, 20 Feb 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="dtY2ObCR"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA21E9B16;
	Thu, 20 Feb 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040830; cv=fail; b=h7OurS865MbjVvaDWWy4EKDDRjNg398h9psrAPmghxE6zssrDgKrvPrn3SrVJ+USHGbN5m8eHDsBaGnb2tE9D2+dJMpmmWY7uFOc0lCmfjzbT55T6Vafksmy2n8zFmvolyaaKQ5cyyjAbQAUldjaX0zjEdz1kKcmtJqvT+C/h80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040830; c=relaxed/simple;
	bh=rezB+cFRaAmFTOaogPFuppxRnWN+EeiKsOci+jvPkQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKFPLJQSSxa3c9A8sjNqHuIdcGnQPJp0R5kSFph/0/htwEqNcycEyRx+OkerfXgnzZRocFxr7ALwpzt6ATE9zOlSg4Javm1wGI7X2OPqcfTDpVP7G98QuKdbkdK7knW7vFeuuBaDTlU9lzxY4Z2H/6PGxf31Y1enKfLHx+VFW+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=dtY2ObCR; arc=fail smtp.client-ip=40.107.255.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktD3jDj2nf3sHeYPWsrOBxcXzUoy52TcXaZELF0fks9qDLlI6YtSbA6x4cViWB7RkYT5/WOX5uVr1tUpf6gL0qGxQzw0kP8hC2k2AUCFFj4B6R2SMV0IFGqDgIWsrMbE7HeP1g227M8Szni/j5dIUXobvUrD5bgEayx8KOKyCxQ3gVNEO1Ny0gQ6jjcJWoAYhYCEcT6FMaP+i/0epN+7x+oo2DZdlWgLOVl9b/fmDrnfy9jOCMWL62XacaLCGn1ZRUo2mW2Pi1XlQ7UYPydwykuBSElemcyGTLNO05aKLcLa0DHlv+q3CoxPiJgfUxEvYMSkOjdm1RzoFWUzigTMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8p/6+QGbppW065mj787knZL8lR1F5KFuopLVqtmfV7o=;
 b=TLsWNXBZXB9Q52mXHAi9r96NKbOKTQuJYaAhf06JcH1DufV9uRBq3OryJB7k5KEwbTXIqdOtJx/WUPEvvbt9u8ZKhYkioUezcxV34hv47BCptftxK2WPAFh7wGEkwRtWquggCEukciR7L6aS1jzr84Wcz82hzf3nECVeWSkcM3Aj1tMKQ7mBCpej935ZqDuan2aLHq9+nuL1qnZdBmAz0lZMNpN+gteFXVD7Plh4ODdpcw+BsMVkJrUzb5JV84GT3eQbgARpxCW0wDbT/QbgtsiV0twsOktt/1wqMixfxlAE7Cex6VGxv2ofC7jq3KB+QSY76Z5zFg5nVfiv2Kw7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8p/6+QGbppW065mj787knZL8lR1F5KFuopLVqtmfV7o=;
 b=dtY2ObCRYe96cmzeozt0S0lJ6pvNz6aVsz1vbXMri//R4tGgfzrqUsooKhfHaIkhqgNDQRJ113sWBqn3TiyIlgTSHmSnOoyxsEK27Ekpswg6oUp7uIjqq65AB1exhZtTlNfx1sejg0vbmOrrEdRsXKfdwR5GDHai/A/Osc7r/AMdqEDEDsmMas2oihKp5z0H+DUUrjN/rf8Vm+BQgG88FOA7Y0Yn1gbzO1fVMr1TrTppR5yfN9eZdPCZ+btzpTTQZPaniz6qJslqsFXabY0lahMMgSi5rE41DspPdJGSRghhoKGdcOu0pLIABvqITR51v6jUZPjXS+jd2qCprr9c9w==
Received: from SG2PR02CA0041.apcprd02.prod.outlook.com (2603:1096:3:18::29) by
 JH0PR06MB7296.apcprd06.prod.outlook.com (2603:1096:990:a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11; Thu, 20 Feb 2025 08:40:22 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::ad) by SG2PR02CA0041.outlook.office365.com
 (2603:1096:3:18::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 08:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:40:21 +0000
Received: from localhost.localdomain (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id BBA3B41C0A07;
	Thu, 20 Feb 2025 16:40:20 +0800 (CST)
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
	Peter Chen <peter.chen@cixtech.com>,
	"Fugang . duan" <fugang.duan@cixtech.com>
Subject: [PATCH 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
Date: Thu, 20 Feb 2025 16:40:20 +0800
Message-Id: <20250220084020.628704-7-peter.chen@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220084020.628704-1-peter.chen@cixtech.com>
References: <20250220084020.628704-1-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|JH0PR06MB7296:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5ee746e2-9e89-43f0-2696-08dd518a365a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DgkdrpJRR/t9dvLPnwac/P+yrxzkgMbshlnCcOwroTb7QZUTm1o6J/z7yWJH?=
 =?us-ascii?Q?Gj7OqHhGiXSw2GI4RyHilFn+axzm/VHS8vZdtffH7q06Gcj8omIYhnXLyaS8?=
 =?us-ascii?Q?R+OjTCyitfXUTIZGiybk9KJo0rVzUOFBMkx9yTwD/JHUM7uaXdoCeEdJos8+?=
 =?us-ascii?Q?Wl8Y84HTyHAdzn62GPuYhkjzq1tfKDGaRSJ4rOzseCQFfaEXjpNxuwfmYQGo?=
 =?us-ascii?Q?vk1AaD3apxXz7xROsgYVdrdxF+Y/rQJBiGkbBJ9wFIWIRnYJPEIXaB/sFI9Z?=
 =?us-ascii?Q?pDujvSp6VcSN3s1ki/YUTImUW+DZ/O7dwj3vDwR5Pj0cBtCz3cOpc9g8eQTX?=
 =?us-ascii?Q?frzcY9z7Iyn7Y5GCKAZMxA9dy/D54jGgi9huX5akguYuEeAKX4mSVIoWCn+Q?=
 =?us-ascii?Q?yEf3wos+of3240sOGXEsFKOvoL4FwokmBF/mUKQK/p+DB439MHv/bg+LwMqJ?=
 =?us-ascii?Q?jmMrTl45h4y21y3FV81cgOIQdvV/2DThS44YQZVG8Gpb/pGozEHGb82kcjSm?=
 =?us-ascii?Q?kjv9wCUccsQudhP0KijgEpWL6Tl0jrzEP3siNSiXVnSw8Qfn48FGEvxtvX5P?=
 =?us-ascii?Q?U75Fc3TCwAxxRQnyE4Oyw6W/Ok6aclir+7noZvZsJbmfjXA4cFb2p4RelPmB?=
 =?us-ascii?Q?cQl5imQSniI/gmQCtlDAWZJUb1XsjGvXpdQF1MYGPanEqngXx7upBWBWNh4y?=
 =?us-ascii?Q?VaS0GnsBMdafsmfscyhVe/t0+noSGXxzvYSB93poX7BkXYbExjClPefWBE48?=
 =?us-ascii?Q?xWorP8JuUd7hA8r5w19rIody6EyjIZHDbhZ48yXr4jBnxM2gMbh9tgs6X2+E?=
 =?us-ascii?Q?f5rKo8+mem9IfQk53uhaH6QdTCR64OueohEh9ZX+hmlB2d8i0jImOh2fsU8d?=
 =?us-ascii?Q?9wi2Xhd7/QG52A9Ta4fih2Cm6hzJrzVhIZkVrsR+H5bfPGJfLI2Nm/UEuiHq?=
 =?us-ascii?Q?3Gd9fpKAtWj+IqTmAsc3/iKWJSS5ye87JwcpebWjnA5YSsPwiVNL/JOYjJxH?=
 =?us-ascii?Q?0HI1SWGSVC92M73L70KDorH6ohzkx87ehoHzej4mYxhjpdY/bVC2g3SvquyH?=
 =?us-ascii?Q?0vjwDwkbuIlvUCaYJQSlEo/ow//BeI3pzVAyyKFiWWGc0fOxFHxnvb/EWij9?=
 =?us-ascii?Q?Sfmbjen0WGQEjyHt4QhS4IfX7t6hvy4T3a/vBaylJbggjcgqVrgXkyfl6H2z?=
 =?us-ascii?Q?lJG9eUXzMYsknZK7nm5ZhAZtvsulsDcZbnnvTTJ9tmEYh2DrF1DmZAIbzlvu?=
 =?us-ascii?Q?e7eC9oTiNXjGKLDCBsXkX74uW0AFEAvOQ2C9epRVsT4ct/oUu3+yYhzUQmDr?=
 =?us-ascii?Q?qMtUxOCkBEAvRhnHfEn0zE5kJbfaEBl91ZKeS3ZRw6orgsLOC7iHTYWoPNmH?=
 =?us-ascii?Q?QeNixfHfqRdQ4opjIkfLuS1+RAFaqtkXtNQK9Xbk2I6cSKtYiod3cAJ3mGGs?=
 =?us-ascii?Q?r5dllC5u26M=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:40:21.3974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee746e2-9e89-43f0-2696-08dd518a365a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7296

CIX SKY1 SoC is high performance Armv9 SoC designed by Cixtech,
and Orion O6 is open source motherboard launched by Radxa.
See below for detail:
https://docs.radxa.com/en/orion/o6/getting-started/introduction

In this commit, it only adds limited components for running initramfs
at Orion O6.

Acked-by: Fugang.duan <fugang.duan@cixtech.com>
Signed-off-by: Peter Chen <peter.chen@cixtech.com>
---
 arch/arm64/boot/dts/Makefile              |   1 +
 arch/arm64/boot/dts/cix/Makefile          |   2 +
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts |  21 ++
 arch/arm64/boot/dts/cix/sky1.dtsi         | 264 ++++++++++++++++++++++
 4 files changed, 288 insertions(+)
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
index 000000000000..dbee1616076d
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
@@ -0,0 +1,21 @@
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
+	compatible = "radxa,orion-o6";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
new file mode 100644
index 000000000000..d98735f782e0
--- /dev/null
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -0,0 +1,264 @@
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
+	aliases {
+		serial2 = &uart2;
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+				core1 {
+					cpu = <&CPU1>;
+				};
+				core2 {
+					cpu = <&CPU2>;
+				};
+				core3 {
+					cpu = <&CPU3>;
+				};
+				core4 {
+					cpu = <&CPU4>;
+				};
+				core5 {
+					cpu = <&CPU5>;
+				};
+				core6 {
+					cpu = <&CPU6>;
+				};
+				core7 {
+					cpu = <&CPU7>;
+				};
+				core8 {
+					cpu = <&CPU8>;
+				};
+				core9 {
+					cpu = <&CPU9>;
+				};
+				core10 {
+					cpu = <&CPU10>;
+				};
+				core11 {
+					cpu = <&CPU11>;
+				};
+			};
+		};
+
+		CPU0: cpu0@0 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0x0>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		CPU1: cpu1@100 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0x100>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		CPU2: cpu2@200 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0x200>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		CPU3: cpu3@300 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0x300>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <403>;
+		};
+
+		CPU4: cpu4@400 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0x400>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		CPU5: cpu5@500 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0x500>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		CPU6: cpu6@600 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0x600>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		CPU7: cpu7@700 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0x700>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		CPU8: cpu8@800 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0x800>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		CPU9: cpu9@900 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0x900>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		CPU10: cpu10@a00 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0xa00>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+
+		CPU11: cpu11@b00 {
+			compatible = "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0 0xb00>;
+			device_type = "cpu";
+			capacity-dmips-mhz = <1024>;
+		};
+	};
+
+	arch_timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+		clock-frequency = <1000000000>;
+		interrupt-parent = <&gic>;
+		arm,no-tick-in-suspend;
+	};
+
+	memory@80000000 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0x1 0x00000000>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	pmu: pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gic>;
+		status = "okay";
+	};
+
+	pmu_spe: pmu_spe {
+		compatible = "arm,statistical-profiling-extension-v1";
+		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gic>;
+		status = "okay";
+	};
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
+
+	};
+
+	sky1_fixed_clocks: fixed-clocks {
+		uartclk: uartclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+			clock-output-names = "uartclk";
+		};
+
+		uart_apb_pclk: uart_apb_pclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+			clock-output-names = "apb_pclk";
+		};
+	};
+
+	soc@0 {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-ranges;
+
+		uart2: uart@040d0000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x0 0x040d0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "uartclk", "apb_pclk";
+			clocks = <&uartclk>, <&uart_apb_pclk>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@0e001000 {
+			compatible = "arm,gic-v3";
+			#address-cells = <2>;
+			#interrupt-cells = <3>;
+			#size-cells = <2>;
+			ranges;
+			interrupt-controller;
+			#redistributor-regions = <1>;
+			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
+			      <0x0 0x0e090000 0 0x300000>;       /* GICR * 12 */
+			redistributor-stride = <0x40000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-parent = <&gic>;
+
+			its_pcie: its@e050000 {
+				compatible = "arm,gic-v3-its";
+				msi-controller;
+				reg = <0x0 0x0e050000 0x0 0x30000>;
+			};
+		};
+	};
+};
-- 
2.25.1


