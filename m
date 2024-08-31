Return-Path: <linux-kernel+bounces-309962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD2696727C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE731F22628
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F84B39FEB;
	Sat, 31 Aug 2024 15:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="riEQrZcd"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2068.outbound.protection.outlook.com [40.92.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D3738FAD;
	Sat, 31 Aug 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.52.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725119262; cv=fail; b=nfWrpN6U84bMWiGjm4J8kgtyRNtRm5U1MoyrGiUG5Z/7vCoXvaV+gbQmO7KI2oEGQ6EDZ4NBCNDgNTNhkwe8D3trjns1gbaDFBvz8MTxfCGKvvgrlJuSV7t+f261aCOs+C025BUW7gffSfHOPkn6JDmz2mv76FfSFJqaniM7o04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725119262; c=relaxed/simple;
	bh=AdZTT9Dc0IVaDKF2BRknqNPxwDrclW9NZRlJX0yVgKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UcYvDcfMTrEktV6eaJyFIQBRDLHXN5a0N9uqHQ7PwjS5l5Bstie47VbRn66a8QU+tV27s8ay5KZxgqTLkA4k82HAnznZ99+QDAxkB4lEOB9DWM4T8BXI9auPSs95W8/TT6MTJqyZG04zevwSomOmocrdnzyte5+WrhbaW0RQhfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=riEQrZcd; arc=fail smtp.client-ip=40.92.52.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aB10FmnTc/KDKEubDMAQhwQPxZjA99rN5J6t/YIyyrsKg4TN3d/VD27sTzrQeIymZzq2nwYgc2f0FncA+J/Ra6HNFKG8aXJS+xa5rMQ41iRIhXyjEPR3w5abARbcfq2M3IxEoEx9chHEdo3YabxlnxsSflONALaptN93B4fLIv17I8XMFCD2HUf/gpmsCN07Mb6Eo1glNlu2YEbqsI+6d9mX+5m2bMya8vVcyG0SZbMq3Mv0flAdfp3aWwnDwD6W1V/4zIZ93gYYaEsfGGOConIM9maYJpD30Nd2ZrVJawvKsbsquo1uzRqjoPK7hmdHo0vZ53YpEoausL+GQAzCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfb+vA6P/M9WiGcagLV97BInfAceyQdNQRlTfopUfMg=;
 b=rlzrpWF5Zgj2arVbaMYFuDAmP5qkTUW6lngbEH8Xb32n0ZS5vYw5SOyJn6XRe/CX3tHYlBvgbvUJZPSTzHovjfOunCZIZqrl9jbqmfteoG+Sjv8Y409by0YWbyfyS/av61A21zfyIXEI+UPSMQOyvpf4x4z/VsfQ8jzSw3EUZHgwSncnShIdv9iALtDDyX/HCN/Vl1Bm4KssCYq1WOxWcfJg1x4gQFctgOLJyKOEcc9jUKbJPkff9WlgVvrfkO670CDaxr+3jaSqKr2Q+gGAE9SfbyrwmVTaDq/dPeoVUDpmcwFIHCfgFlkrmiZODpU2vQLE3z3lTVo6JPmTSnvH6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfb+vA6P/M9WiGcagLV97BInfAceyQdNQRlTfopUfMg=;
 b=riEQrZcd/R+IIobGz+owe9t2r4AZtO0mqXHgrBrKEEtQxNLYE0qhWD0mftsNTpchyOZ2gt2TjBaO3APUtMgOlcDgmA1Oo9rBPgHE0rfB5g+DyoMtrEoYdFfkHU2ds8XNBcG6hdMVpIby00uIDwaHzL3URCl1/kTwPT2GetVdsURohpwkUx1bxvC2DaCIGGomEPvjw67ddENs9CSS/8gTE7cfPOedHZSYZKefQkp142+1+jVDcMrQhW9oasV+uI7mfwy6AgxEfEPfTEeHVsprglSmakWGFY2Je/ud6qn8H04P6keogeAFhbaGmoQCW4iyYRylpgLyoJtVGalecpa85w==
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12) by SEZPR01MB4757.apcprd01.prod.exchangelabs.com
 (2603:1096:101:a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21; Sat, 31 Aug
 2024 15:47:33 +0000
Received: from SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756]) by SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 ([fe80::b674:8f70:6e29:3756%6]) with mapi id 15.20.7897.027; Sat, 31 Aug 2024
 15:47:33 +0000
From: Haylen Chu <heylenay@outlook.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haylen Chu <heylenay@outlook.com>
Subject: [PATCH 2/2] clk: spacemit: Add clock support for Spacemit K1 SoC
Date: Sat, 31 Aug 2024 15:47:13 +0000
Message-ID:
 <SEYPR01MB4221573F5964162AC9FCD983D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
References: <SEYPR01MB4221B3178F5233EAB5149E41D7902@SEYPR01MB4221.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [AD4XvbjfZOk/6aiF4EvkaK/y/Ne3MF52]
X-ClientProxiedBy: TYCP286CA0359.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::13) To SEYPR01MB4221.apcprd01.prod.exchangelabs.com
 (2603:1096:101:56::12)
X-Microsoft-Original-Message-ID: <20240831154713.24814-2-heylenay@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB4221:EE_|SEZPR01MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f23111e-9fd4-4fcd-90e3-08dcc9d43a80
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|8060799006|15080799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	J39DXBJqJC8tWRuGWttMHGksPtjOWVGvHzTmlC4EKqi9m+eNVuIv0s4fG+s4EWNnxIuIpuGGbxMHn6FuhxBNhkJ+SFfRN6i8T/Ax411rLvjZWNol2ynd7uUD/l5EIG7NAa+pGZwerzAP05T2oMA6/IMWOUmIrLG5bNBSPJNsVUzzKLrYZz5FEx8VSmlQADtgtKydUv+KOCDWed27s4Rz4ran/eZlct0JnjMo2YvibexPUJMkvjl/WMMSEnX+mT+FhpZfBEn9vLBvfAXrFMBQ3iDTQFvjGsZjogz1Dj86LkaCDS9ncM9CbsWu4qBxamou0YmZA6Pu9imCu1O8cpAV64wdKjkY4h//xnC2GDlROFV7GMuPBiPgQfe2s0llshsOh8oBIMvrgqzQgULb2iY8KfrIkzjCe03tUU8u/0V1hROneakR3rzbjZNKZOFNXGz/74FCvuyU8C34ODz6pncGx1wVnmjpJaiOvBvOCWnPAlKxMvfj+VAEzs5bHi1Topnsx7lVfcVMnLuQht/9ulGsi5WHLquTtqITnTddujJQfU37ESVjXXtRn8wWzLb8yUSaiLJl5GLvV2VcIuz9d0cHLcjxRffWXAdiWlIMXjtm1apdzQ80PDjgYQdHrXkAe0KbA1ThLj2xFQpGgYj3XPPCYxLpj6rFG1RH6jvwXbqrJLdeTi6uV/uwSfofQTVXQFrq+BSiAax+xWfk4B+F42iYGYi3jMCX7f1KC/5eONo/VwM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ErnMPUHI+B0Vn34pVX+1gibhe12HvKFIMci+UXK/zX7KCz51UyIHrUmJ1z5b?=
 =?us-ascii?Q?/44wfTyd9eNw//x7F5Wg7Ed+8qx8t3LkhjuLKmBso6scZy21ZxTYKDgsoDFd?=
 =?us-ascii?Q?YqDDRLplJwnjoU+Fc6Lbt0bg61BKOgsoJIxUazRgjPccIK1rvSRXtop881t8?=
 =?us-ascii?Q?dSoHdak6A+1o0MfgTvvif0IuIO18oPekUw5Byj/SnJBLR6I/IPp5rqFxvEPY?=
 =?us-ascii?Q?hV8jyVGkCvoV0kw348zQPb5Th3GONICaXiRM3JnrEQH5bBCuScB3cZA8gswx?=
 =?us-ascii?Q?aKQZCnXhKIQ0F2/1lgUEqM+8KHr39eclnzFhoZXG9ulmj2QBmTtkI/w86jab?=
 =?us-ascii?Q?TvaeWVJOJcn9wuaa4UELDPdeNlGDT/A41RMYoco323NyulUz0GXgbRbuB0JQ?=
 =?us-ascii?Q?beJlnWTWFcwszhuUhDIhcChbnjD5lvIBdBnYXLH8Wp/2rovZq47wEwl5hs2y?=
 =?us-ascii?Q?xLhTCdlmhrresvN5p6yXpf4kcQ9LbEzDqxLkfF4nuxfuEvoRlRwfYDegxyQa?=
 =?us-ascii?Q?D/8L8oZvKdrnLgrfVD7qD8yNctPsU4HL1vByfaWfGWOsac+YYN8I5fSNI1Zg?=
 =?us-ascii?Q?vp/4ZWEamuE6HQdvKsc1W060xyTkxT9rKffGSSdTEsU2QpPYZZlT8WYU3Ez+?=
 =?us-ascii?Q?uwm0vsrrsggx5cK6eHsXC574riRKB5OVOEIYfZFvQagm8iFU4PVXKsp5OsL0?=
 =?us-ascii?Q?3qbmFnOrgjeBbVi/HbvnY0vRdpmYJjWLScrPJXXlF08K/uXm5upkyVH8acoD?=
 =?us-ascii?Q?AKUtoSY9bONjXkJnw80TKHUVi8W3UQx5IzIYjhN/AkjH+f858nrhh7PMN20M?=
 =?us-ascii?Q?vtCLtdUD1Pppio3gtxjXKcChv0F6WhYGugBgIOPhFZ9Gm8R43hxaVrqwUuq1?=
 =?us-ascii?Q?eM3To8Te8WXod+j+SDWHDn1ftNxvswofb8oqDLGIX94A3LExlycgnp3nedsP?=
 =?us-ascii?Q?dr3N8mzGJVAI/eQA7WYXA2orbqn92K6FJjxBu+x1a9Dpdvg5Avkhu331c5yI?=
 =?us-ascii?Q?+0QvGXa6cST3XBOx4gpCfn4wOr9R1ld9MjlZzy9OmTzVLO/Ptw5e8vGwdcDF?=
 =?us-ascii?Q?imw60Yna9DZzVhPHoyjlw4I/AI630q1kJPzqLOY2XTxwI5PPzsvvOtKAP5Q8?=
 =?us-ascii?Q?ahFEdCKZiPPb21ydejiQ5ZXkiizPUBFDobYOvt2aKNVk3YOvnmCGs2Mnp0CQ?=
 =?us-ascii?Q?vetiVCT+qTiukn76WJDv9LYvosdDOOckmSKCKsMtb8cpWm/rpeeFiPahThQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f23111e-9fd4-4fcd-90e3-08dcc9d43a80
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB4221.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 15:47:33.6519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4757

The clock tree of K1 SoC contains three main types of clock hardware
(PLL/DDN/MIX) and is managed by several independent controllers in
different SoC parts (APBC, APBS and etc.), thus different compatible
strings are added to distinguish them.

Some controllers may share IO region with reset controller and other low
speed peripherals like watchdog, so all register operations are done
through regmap to avoid competition.

Signed-off-by: Haylen Chu <heylenay@outlook.com>
---
 drivers/clk/Kconfig                 |   1 +
 drivers/clk/Makefile                |   1 +
 drivers/clk/spacemit/Kconfig        |  10 +
 drivers/clk/spacemit/Makefile       |   4 +
 drivers/clk/spacemit/ccu-spacemit.c | 594 ++++++++++++++++++++++++++++
 drivers/clk/spacemit/ccu_common.h   |  55 +++
 drivers/clk/spacemit/ccu_ddn.c      | 167 ++++++++
 drivers/clk/spacemit/ccu_ddn.h      |  84 ++++
 drivers/clk/spacemit/ccu_mix.c      | 338 ++++++++++++++++
 drivers/clk/spacemit/ccu_mix.h      | 349 ++++++++++++++++
 drivers/clk/spacemit/ccu_pll.c      | 229 +++++++++++
 drivers/clk/spacemit/ccu_pll.h      |  82 ++++
 12 files changed, 1914 insertions(+)
 create mode 100644 drivers/clk/spacemit/Kconfig
 create mode 100644 drivers/clk/spacemit/Makefile
 create mode 100644 drivers/clk/spacemit/ccu-spacemit.c
 create mode 100644 drivers/clk/spacemit/ccu_common.h
 create mode 100644 drivers/clk/spacemit/ccu_ddn.c
 create mode 100644 drivers/clk/spacemit/ccu_ddn.h
 create mode 100644 drivers/clk/spacemit/ccu_mix.c
 create mode 100644 drivers/clk/spacemit/ccu_mix.h
 create mode 100644 drivers/clk/spacemit/ccu_pll.c
 create mode 100644 drivers/clk/spacemit/ccu_pll.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 983ef4f36d8c..04f4cb2d1127 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -490,6 +490,7 @@ source "drivers/clk/samsung/Kconfig"
 source "drivers/clk/sifive/Kconfig"
 source "drivers/clk/socfpga/Kconfig"
 source "drivers/clk/sophgo/Kconfig"
+source "drivers/clk/spacemit/Kconfig"
 source "drivers/clk/sprd/Kconfig"
 source "drivers/clk/starfive/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f793a16cad40..2b2532ebf5d0 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
 obj-y					+= socfpga/
 obj-y					+= sophgo/
+obj-y					+= spacemit/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-y					+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
new file mode 100644
index 000000000000..ce49568eec96
--- /dev/null
+++ b/drivers/clk/spacemit/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SPACEMIT_CCU
+	tristate "Clock support for Spacemit SoCs"
+	depends on ARCH_SPACEMIT || COMPILE_TEST
+	default y
+	select MFD_SYSCON
+	help
+	  This driver supports clock controllers integrated in Spacemit K1
+	  SoC. If unsure, say N.
diff --git a/drivers/clk/spacemit/Makefile b/drivers/clk/spacemit/Makefile
new file mode 100644
index 000000000000..2bcd5021670b
--- /dev/null
+++ b/drivers/clk/spacemit/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_SPACEMIT_CCU)	+= ccu-spacemit.o
+obj-$(CONFIG_SPACEMIT_CCU)	+= ccu_pll.o ccu_mix.o ccu_ddn.o
diff --git a/drivers/clk/spacemit/ccu-spacemit.c b/drivers/clk/spacemit/ccu-spacemit.c
new file mode 100644
index 000000000000..da557086824f
--- /dev/null
+++ b/drivers/clk/spacemit/ccu-spacemit.c
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#include <linux/delay.h>
+#include <dt-bindings/clock/spacemit,ccu.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include "ccu_common.h"
+#include "ccu_pll.h"
+#include "ccu_mix.h"
+#include "ccu_ddn.h"
+
+/*	APBS register offset	*/
+/*	pll1	*/
+#define APB_SPARE1_REG			0x100
+#define APB_SPARE2_REG			0x104
+#define APB_SPARE3_REG			0x108
+/*	pll2	*/
+#define APB_SPARE7_REG			0x118
+#define APB_SPARE8_REG			0x11c
+#define APB_SPARE9_REG			0x120
+/*	pll3	*/
+#define APB_SPARE10_REG			0x124
+#define APB_SPARE11_REG			0x128
+#define APB_SPARE12_REG			0x12c
+
+/* MPMU register offset */
+#define MPMU_POSR			0x10
+#define POSR_PLL1_LOCK			BIT(27)
+#define POSR_PLL2_LOCK			BIT(28)
+#define POSR_PLL3_LOCK			BIT(29)
+
+#define MPMU_WDTPCR			0x200
+#define MPMU_RIPCCR			0x210
+#define MPMU_ACGR			0x1024
+#define MPMU_SUCCR			0x14
+#define MPMU_ISCCR			0x44
+#define MPMU_SUCCR_1			0x10b0
+#define MPMU_APBCSCR			0x1050
+
+/* APBC register offset */
+#define APBC_UART1_CLK_RST		0x0
+#define APBC_UART2_CLK_RST		0x4
+#define APBC_UART3_CLK_RST		0x24
+#define APBC_UART4_CLK_RST		0x70
+#define APBC_UART5_CLK_RST		0x74
+#define APBC_UART6_CLK_RST		0x78
+#define APBC_UART7_CLK_RST		0x94
+#define APBC_UART8_CLK_RST		0x98
+#define APBC_UART9_CLK_RST		0x9c
+
+/* APMU register offset */
+#define APMU_CCI550_CLK_CTRL		0x300
+#define APMU_CPU_C0_CLK_CTRL		0x38C
+#define APMU_CPU_C1_CLK_CTRL		0x390
+
+/*	APBS clocks start	*/
+
+static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
+	CCU_PLL_RATE(3000000000UL, 0x66, 0xdd, 0x50, 0x00, 0x3f, 0xe00000),
+	CCU_PLL_RATE(3200000000UL, 0x67, 0xdd, 0x50, 0x00, 0x43, 0xeaaaab),
+	CCU_PLL_RATE(2457600000UL, 0x64, 0xdd, 0x50, 0x00, 0x33, 0x0ccccd),
+	CCU_PLL_RATE(2800000000UL, 0x66, 0xdd, 0x50, 0x00, 0x3a, 0x155555),
+};
+
+static const struct ccu_pll_rate_tbl pll3_rate_tbl[] = {
+	CCU_PLL_RATE(3000000000UL, 0x66, 0xdd, 0x50, 0x00, 0x3f, 0xe00000),
+	CCU_PLL_RATE(3200000000UL, 0x67, 0xdd, 0x50, 0x00, 0x43, 0xeaaaab),
+	CCU_PLL_RATE(2457600000UL, 0x64, 0xdd, 0x50, 0x00, 0x33, 0x0ccccd),
+};
+
+static CCU_PLL_DEFINE(pll2, "pll2", pll2_rate_tbl,
+		      APB_SPARE7_REG, APB_SPARE8_REG, APB_SPARE9_REG,
+		      MPMU_POSR, POSR_PLL2_LOCK, 0);
+static CCU_PLL_DEFINE(pll3, "pll3", pll3_rate_tbl,
+		      APB_SPARE10_REG, APB_SPARE11_REG, APB_SPARE12_REG,
+		      MPMU_POSR, POSR_PLL3_LOCK, 0);
+
+static CCU_GATE_FACTOR_DEFINE(pll1_d2, "pll1_d2", "pll1_2457p6_vco",
+			      APB_SPARE2_REG,
+			      BIT(1), BIT(1), 0, 2, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d3, "pll1_d3", "pll1_2457p6_vco",
+			      APB_SPARE2_REG,
+			      BIT(2), BIT(2), 0, 3, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d4, "pll1_d4", "pll1_2457p6_vco",
+			      APB_SPARE2_REG,
+			      BIT(3), BIT(3), 0, 4, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d5, "pll1_d5", "pll1_2457p6_vco",
+			      APB_SPARE2_REG,
+			      BIT(4), BIT(4), 0, 5, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d6, "pll1_d6", "pll1_2457p6_vco",
+			      APB_SPARE2_REG,
+			      BIT(5), BIT(5), 0, 6, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d7, "pll1_d7", "pll1_2457p6_vco",
+			      APB_SPARE2_REG,
+			      BIT(6), BIT(6), 0, 7, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d8, "pll1_d8", "pll1_2457p6_vco",
+			      APB_SPARE2_REG,
+			      BIT(7), BIT(7), 0, 8, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d11_223p4, "pll1_d11_223p4",
+			      "pll1_2457p6_vco", APB_SPARE2_REG,
+			      BIT(15), BIT(15), 0, 11, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d13_189, "pll1_d13_189", "pll1_2457p6_vco",
+			      APB_SPARE2_REG,
+			      BIT(16), BIT(16), 0, 13, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d23_106p8, "pll1_d23_106p8",
+			      "pll1_2457p6_vco", APB_SPARE2_REG,
+			      BIT(20), BIT(20), 0, 23, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d64_38p4, "pll1_d64_38p4", "pll1_2457p6_vco",
+			      APB_SPARE2_REG,
+			      BIT(0), BIT(0), 0, 64, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_aud_245p7, "pll1_aud_245p7",
+			      "pll1_2457p6_vco", APB_SPARE2_REG,
+			      BIT(10), BIT(10), 0, 10, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_aud_24p5, "pll1_aud_24p5", "pll1_2457p6_vco",
+			      APB_SPARE2_REG,
+			      BIT(11), BIT(11), 0, 100, 1, 0);
+
+static CCU_GATE_FACTOR_DEFINE(pll2_d1, "pll2_d1", "pll2", APB_SPARE8_REG,
+			      BIT(0), BIT(0), 0, 1, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d2, "pll2_d2", "pll2", APB_SPARE8_REG,
+			      BIT(1), BIT(1), 0, 2, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d3, "pll2_d3", "pll2", APB_SPARE8_REG,
+			      BIT(2), BIT(2), 0, 3, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d4, "pll2_d4", "pll2", APB_SPARE8_REG,
+			      BIT(3), BIT(3), 0, 4, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d5, "pll2_d5", "pll2", APB_SPARE8_REG,
+			      BIT(4), BIT(4), 0, 5, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d6, "pll2_d6", "pll2", APB_SPARE8_REG,
+			      BIT(5), BIT(5), 0, 6, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d7, "pll2_d7", "pll2", APB_SPARE8_REG,
+			      BIT(6), BIT(6), 0, 7, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll2_d8, "pll2_d8", "pll2", APB_SPARE8_REG,
+			      BIT(7), BIT(7), 0, 8, 1, 0);
+
+static CCU_GATE_FACTOR_DEFINE(pll3_d1, "pll3_d1", "pll3", APB_SPARE11_REG,
+			      BIT(0), BIT(0), 0, 1, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d2, "pll3_d2", "pll3", APB_SPARE11_REG,
+			      BIT(1), BIT(1), 0, 2, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d3, "pll3_d3", "pll3", APB_SPARE11_REG,
+			      BIT(2), BIT(2), 0, 3, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d4, "pll3_d4", "pll3", APB_SPARE11_REG,
+			      BIT(3), BIT(3), 0, 4, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d5, "pll3_d5", "pll3", APB_SPARE11_REG,
+			      BIT(4), BIT(4), 0, 5, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d6, "pll3_d6", "pll3", APB_SPARE11_REG,
+			      BIT(5), BIT(5), 0, 6, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d7, "pll3_d7", "pll3", APB_SPARE11_REG,
+			      BIT(6), BIT(6), 0, 7, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll3_d8, "pll3_d8", "pll3", APB_SPARE11_REG,
+			      BIT(7), BIT(7), 0, 8, 1, 0);
+
+static CCU_FACTOR_DEFINE(pll3_20, "pll3_20", "pll3_d8", 20, 1);
+static CCU_FACTOR_DEFINE(pll3_40, "pll3_40", "pll3_d8", 10, 1);
+static CCU_FACTOR_DEFINE(pll3_80, "pll3_80", "pll3_d8", 5, 1);
+
+/*	APBS clocks end		*/
+
+/*	MPMU clocks start	*/
+static CCU_GATE_DEFINE(pll1_d8_307p2, "pll1_d8_307p2", "pll1_d8",
+	MPMU_ACGR,
+	BIT(13), BIT(13), 0, 0);
+static CCU_FACTOR_DEFINE(pll1_d32_76p8, "pll1_d32_76p8", "pll1_d8_307p2",
+			 4, 1);
+static CCU_FACTOR_DEFINE(pll1_d40_61p44, "pll1_d40_61p44", "pll1_d8_307p2",
+			 5, 1);
+static CCU_FACTOR_DEFINE(pll1_d16_153p6, "pll1_d16_153p6", "pll1_d8",
+			 2, 1);
+static CCU_GATE_FACTOR_DEFINE(pll1_d24_102p4, "pll1_d24_102p4", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(12), BIT(12), 0, 3, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d48_51p2, "pll1_d48_51p2", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(7), BIT(7), 0, 6, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d48_51p2_ap, "pll1_d48_51p2_ap", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(11), BIT(11), 0, 6, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_m3d128_57p6, "pll1_m3d128_57p6", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(8), BIT(8), 0, 16, 3, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d96_25p6, "pll1_d96_25p6", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(4), BIT(4), 0, 12, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d192_12p8, "pll1_d192_12p8", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(3), BIT(3), 0, 24, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d192_12p8_wdt, "pll1_d192_12p8_wdt",
+			      "pll1_d8", MPMU_ACGR,
+			      BIT(19), BIT(19), 0x0, 24, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d384_6p4, "pll1_d384_6p4", "pll1_d8",
+			      MPMU_ACGR,
+			      BIT(2), BIT(2), 0, 48, 1, 0);
+static CCU_FACTOR_DEFINE(pll1_d768_3p2, "pll1_d768_3p2", "pll1_d384_6p4",
+			 2, 1);
+static CCU_FACTOR_DEFINE(pll1_d1536_1p6, "pll1_d1536_1p6", "pll1_d384_6p4",
+			 4, 1);
+static CCU_FACTOR_DEFINE(pll1_d3072_0p8, "pll1_d3072_0p8", "pll1_d384_6p4",
+			 8, 1);
+
+static CCU_FACTOR_DEFINE(pll1_d7_351p08, "pll1_d7_351p08", "pll1_d7",
+			 1, 1);
+
+static CCU_GATE_DEFINE(pll1_d6_409p6, "pll1_d6_409p6", "pll1_d6",
+		       MPMU_ACGR,
+		       BIT(0), BIT(0), 0, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d12_204p8, "pll1_d12_204p8", "pll1_d6",
+			      MPMU_ACGR,
+			      BIT(5), BIT(5), 0, 2, 1, 0);
+
+static CCU_GATE_DEFINE(pll1_d5_491p52, "pll1_d5_491p52", "pll1_d5",
+		       MPMU_ACGR, BIT(21), BIT(21), 0, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d10_245p76, "pll1_d10_245p76", "pll1_d5",
+			      MPMU_ACGR,
+			      BIT(18), BIT(18), 0, 2, 1, 0);
+
+static CCU_GATE_DEFINE(pll1_d4_614p4, "pll1_d4_614p4", "pll1_d4",
+		       MPMU_ACGR,
+		       BIT(15), BIT(15), 0, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d52_47p26, "pll1_d52_47p26", "pll1_d4",
+			      MPMU_ACGR,
+			      BIT(10), BIT(10), 0, 13, 1, 0);
+static CCU_GATE_FACTOR_DEFINE(pll1_d78_31p5, "pll1_d78_31p5", "pll1_d4",
+			      MPMU_ACGR,
+			      BIT(6), BIT(6), 0, 39, 2, 0);
+
+static CCU_GATE_DEFINE(pll1_d3_819p2, "pll1_d3_819p2", "pll1_d3",
+		       MPMU_ACGR,
+		       BIT(14), BIT(14), 0, 0);
+
+static CCU_GATE_DEFINE(pll1_d2_1228p8, "pll1_d2_1228p8", "pll1_d2",
+		       MPMU_ACGR,
+		       BIT(16), BIT(16), 0, 0);
+
+static struct ccu_ddn_info uart_ddn_mask_info = {
+	.factor		= 2,
+	.num_mask	= 0x1fff,
+	.den_mask	= 0x1fff,
+	.num_shift	= 16,
+	.den_shift	= 0,
+};
+static struct ccu_ddn_tbl slow_uart1_tbl[] = {
+	{ .num = 125, .den = 24 },
+};
+static struct ccu_ddn_tbl slow_uart2_tbl[] = {
+	{ .num = 6144, .den = 960 },
+};
+static CCU_GATE_NO_PARENT_DEFINE(slow_uart, "slow_uart",
+				 MPMU_ACGR,
+				 BIT(1), BIT(1), 0, 0);
+static CCU_DDN_DEFINE(slow_uart1_14p74, "slow_uart1_14p74", "pll1_d16_153p6",
+		      &uart_ddn_mask_info, slow_uart1_tbl,
+		      MPMU_SUCCR, 0);
+static CCU_DDN_DEFINE(slow_uart2_48, "slow_uart2_48", "pll1_d4_614p4",
+		      &uart_ddn_mask_info, slow_uart2_tbl,
+		      MPMU_SUCCR_1, 0);
+/*	MPMU clocks end		*/
+
+/*	APBC clocks start	*/
+static const char * const uart_clk_parents[] = {
+	"pll1_m3d128_57p6", "slow_uart1_14p74", "slow_uart2_48",
+};
+static CCU_MUX_GATE_DEFINE(uart0_clk, "uart0_clk", uart_clk_parents,
+			   APBC_UART1_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart2_clk, "uart2_clk", uart_clk_parents,
+			   APBC_UART2_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart3_clk, "uart3_clk", uart_clk_parents,
+			   APBC_UART3_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart4_clk, "uart4_clk", uart_clk_parents,
+			   APBC_UART4_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart5_clk, "uart5_clk", uart_clk_parents,
+			   APBC_UART5_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart6_clk, "uart6_clk", uart_clk_parents,
+			   APBC_UART6_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart7_clk, "uart7_clk", uart_clk_parents,
+			   APBC_UART7_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart8_clk, "uart8_clk", uart_clk_parents,
+			   APBC_UART8_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+static CCU_MUX_GATE_DEFINE(uart9_clk, "uart9_clk", uart_clk_parents,
+			   APBC_UART9_CLK_RST,
+			   4, 3, 0x3, 0x3, 0x0,
+			   0);
+/*	APBC clocks end		*/
+
+/*	APMU clocks start	*/
+static const char * const cci550_clk_parents[] = {
+	"pll1_d5_491p52", "pll1_d4_614p4", "pll1_d3_819p2", "pll2_d3"
+};
+static CCU_DIV_FC_MUX_DEFINE(cci550_clk, "cci550_clk", cci550_clk_parents,
+			     APMU_CCI550_CLK_CTRL,
+			     8, 3, BIT(12), 0, 2, CLK_IS_CRITICAL);
+
+static const char * const cpu_c0_hi_clk_parents[] = { "pll3_d2", "pll3_d1" };
+static CCU_MUX_DEFINE(cpu_c0_hi_clk, "cpu_c0_hi_clk", cpu_c0_hi_clk_parents,
+		      APMU_CPU_C0_CLK_CTRL,
+		      13, 1, 0);
+static const char * const cpu_c0_clk_parents[] = {
+	"pll1_d4_614p4", "pll1_d3_819p2", "pll1_d6_409p6", "pll1_d5_491p52",
+	"pll1_d2_1228p8", "pll3_d3", "pll2_d3", "cpu_c0_hi_clk"
+};
+static CCU_MUX_FC_DEFINE(cpu_c0_core_clk, "cpu_c0_core_clk", cpu_c0_clk_parents,
+			 APMU_CPU_C0_CLK_CTRL,
+			 BIT(12), 0, 3, CLK_IS_CRITICAL);
+static CCU_DIV_DEFINE(cpu_c0_ace_clk, "cpu_c0_ace_clk", "cpu_c0_core_clk",
+		      APMU_CPU_C0_CLK_CTRL,
+		      6, 3, CLK_IS_CRITICAL);
+static CCU_DIV_DEFINE(cpu_c0_tcm_clk, "cpu_c0_tcm_clk", "cpu_c0_core_clk",
+		      APMU_CPU_C0_CLK_CTRL, 9, 3, CLK_IS_CRITICAL);
+
+static const char * const cpu_c1_hi_clk_parents[] = { "pll3_d2", "pll3_d1" };
+static CCU_MUX_DEFINE(cpu_c1_hi_clk, "cpu_c1_hi_clk", cpu_c1_hi_clk_parents,
+		      APMU_CPU_C1_CLK_CTRL,
+		      13, 1, CLK_IS_CRITICAL);
+static const char * const cpu_c1_clk_parents[] = {
+	"pll1_d4_614p4", "pll1_d3_819p2", "pll1_d6_409p6", "pll1_d5_491p52",
+	"pll1_d2_1228p8", "pll3_d3", "pll2_d3", "cpu_c1_hi_clk"
+};
+static CCU_MUX_FC_DEFINE(cpu_c1_core_clk, "cpu_c1_core_clk", cpu_c1_clk_parents,
+			 APMU_CPU_C1_CLK_CTRL,
+			 BIT(12), 0, 3, CLK_IS_CRITICAL);
+static CCU_DIV_DEFINE(cpu_c1_ace_clk, "cpu_c1_ace_clk", "cpu_c1_core_clk",
+		      APMU_CPU_C1_CLK_CTRL,
+		      6, 3, CLK_IS_CRITICAL);
+/*	APMU clocks end		*/
+
+static struct clk_hw_onecell_data spacemit_ccu_apbs_clks = {
+	.hws = {
+		[CLK_PLL2]		= &pll2.common.hw,
+		[CLK_PLL3]		= &pll3.common.hw,
+		[CLK_PLL1_D2]		= &pll1_d2.common.hw,
+		[CLK_PLL1_D3]		= &pll1_d3.common.hw,
+		[CLK_PLL1_D4]		= &pll1_d4.common.hw,
+		[CLK_PLL1_D5]		= &pll1_d5.common.hw,
+		[CLK_PLL1_D6]		= &pll1_d6.common.hw,
+		[CLK_PLL1_D7]		= &pll1_d7.common.hw,
+		[CLK_PLL1_D8]		= &pll1_d8.common.hw,
+		[CLK_PLL1_D11]		= &pll1_d11_223p4.common.hw,
+		[CLK_PLL1_D13]		= &pll1_d13_189.common.hw,
+		[CLK_PLL1_D23]		= &pll1_d23_106p8.common.hw,
+		[CLK_PLL1_D64]		= &pll1_d64_38p4.common.hw,
+		[CLK_PLL1_D10_AUD]	= &pll1_aud_245p7.common.hw,
+		[CLK_PLL1_D100_AUD]	= &pll1_aud_24p5.common.hw,
+		[CLK_PLL2_D1]		= &pll2_d1.common.hw,
+		[CLK_PLL2_D2]		= &pll2_d2.common.hw,
+		[CLK_PLL2_D3]		= &pll2_d3.common.hw,
+		[CLK_PLL2_D3]		= &pll2_d4.common.hw,
+		[CLK_PLL2_D5]		= &pll2_d5.common.hw,
+		[CLK_PLL2_D6]		= &pll2_d6.common.hw,
+		[CLK_PLL2_D7]		= &pll2_d7.common.hw,
+		[CLK_PLL2_D8]		= &pll2_d8.common.hw,
+		[CLK_PLL3_D1]		= &pll3_d1.common.hw,
+		[CLK_PLL3_D2]		= &pll3_d2.common.hw,
+		[CLK_PLL3_D3]		= &pll3_d3.common.hw,
+		[CLK_PLL3_D4]		= &pll3_d4.common.hw,
+		[CLK_PLL3_D5]		= &pll3_d5.common.hw,
+		[CLK_PLL3_D6]		= &pll3_d6.common.hw,
+		[CLK_PLL3_D7]		= &pll3_d7.common.hw,
+		[CLK_PLL3_D8]		= &pll3_d8.common.hw,
+		[CLK_PLL3_80]		= &pll3_80.common.hw,
+		[CLK_PLL3_40]		= &pll3_40.common.hw,
+		[CLK_PLL3_20]		= &pll3_20.common.hw,
+
+	},
+	.num = CLK_APBS_NUM,
+};
+
+static struct clk_hw_onecell_data spacemit_ccu_mpmu_clks = {
+	.hws = {
+		[CLK_PLL1_307P2]	= &pll1_d8_307p2.common.hw,
+		[CLK_PLL1_76P8]		= &pll1_d32_76p8.common.hw,
+		[CLK_PLL1_61P44]	= &pll1_d40_61p44.common.hw,
+		[CLK_PLL1_153P6]	= &pll1_d16_153p6.common.hw,
+		[CLK_PLL1_102P4]	= &pll1_d24_102p4.common.hw,
+		[CLK_PLL1_51P2]		= &pll1_d48_51p2.common.hw,
+		[CLK_PLL1_51P2_AP]	= &pll1_d48_51p2_ap.common.hw,
+		[CLK_PLL1_57P6]		= &pll1_m3d128_57p6.common.hw,
+		[CLK_PLL1_25P6]		= &pll1_d96_25p6.common.hw,
+		[CLK_PLL1_12P8]		= &pll1_d192_12p8.common.hw,
+		[CLK_PLL1_12P8_WDT]	= &pll1_d192_12p8_wdt.common.hw,
+		[CLK_PLL1_6P4]		= &pll1_d384_6p4.common.hw,
+		[CLK_PLL1_3P2]		= &pll1_d768_3p2.common.hw,
+		[CLK_PLL1_1P6]		= &pll1_d1536_1p6.common.hw,
+		[CLK_PLL1_0P8]		= &pll1_d3072_0p8.common.hw,
+		[CLK_PLL1_351]		= &pll1_d7_351p08.common.hw,
+		[CLK_PLL1_409P6]	= &pll1_d6_409p6.common.hw,
+		[CLK_PLL1_204P8]	= &pll1_d12_204p8.common.hw,
+		[CLK_PLL1_491]		= &pll1_d5_491p52.common.hw,
+		[CLK_PLL1_245P76]	= &pll1_d10_245p76.common.hw,
+		[CLK_PLL1_614]		= &pll1_d4_614p4.common.hw,
+		[CLK_PLL1_47P26]	= &pll1_d52_47p26.common.hw,
+		[CLK_PLL1_31P5]		= &pll1_d78_31p5.common.hw,
+		[CLK_PLL1_819]		= &pll1_d3_819p2.common.hw,
+		[CLK_PLL1_1228]		= &pll1_d2_1228p8.common.hw,
+		[CLK_SLOW_UART]		= &slow_uart.common.hw,
+		[CLK_SLOW_UART1]	= &slow_uart1_14p74.common.hw,
+		[CLK_SLOW_UART2]	= &slow_uart2_48.common.hw,
+	},
+	.num = CLK_SLOW_UART2 + 1,
+};
+
+static struct clk_hw_onecell_data spacemit_ccu_apbc_clks = {
+	.hws = {
+		[CLK_UART0]		= &uart0_clk.common.hw,
+		[CLK_UART2]		= &uart2_clk.common.hw,
+		[CLK_UART3]		= &uart3_clk.common.hw,
+		[CLK_UART4]		= &uart4_clk.common.hw,
+		[CLK_UART5]		= &uart5_clk.common.hw,
+		[CLK_UART6]		= &uart6_clk.common.hw,
+		[CLK_UART7]		= &uart7_clk.common.hw,
+		[CLK_UART8]		= &uart8_clk.common.hw,
+		[CLK_UART9]		= &uart9_clk.common.hw,
+	},
+	.num = CLK_UART9 + 1,
+};
+
+static struct clk_hw_onecell_data spacemit_ccu_apmu_clks = {
+	.hws = {
+		[CLK_CCI550]		= &cci550_clk.common.hw,
+		[CLK_CPU_C0_HI]		= &cpu_c0_hi_clk.common.hw,
+		[CLK_CPU_C0_CORE]	= &cpu_c0_core_clk.common.hw,
+		[CLK_CPU_C0_ACE]	= &cpu_c0_ace_clk.common.hw,
+		[CLK_CPU_C0_TCM]	= &cpu_c0_tcm_clk.common.hw,
+		[CLK_CPU_C1_HI]		= &cpu_c1_hi_clk.common.hw,
+		[CLK_CPU_C1_CORE]	= &cpu_c1_core_clk.common.hw,
+		[CLK_CPU_C1_ACE]	= &cpu_c1_ace_clk.common.hw,
+	},
+	.num = CLK_CPU_C1_ACE + 1,
+};
+
+struct spacemit_ccu_data {
+	struct clk_hw_onecell_data *hw_clks;
+	bool need_pll_lock;
+};
+
+struct spacemit_ccu_priv {
+	const struct spacemit_ccu_data *data;
+	struct regmap *base;
+	struct regmap *lock_base;
+	spinlock_t lock;
+};
+
+static int spacemit_ccu_register(struct device *dev,
+				 struct spacemit_ccu_priv *priv)
+{
+	const struct spacemit_ccu_data *data = priv->data;
+	int i, ret;
+
+	for (i = 0; i < data->hw_clks->num; i++) {
+		struct clk_hw *hw = data->hw_clks->hws[i];
+		struct ccu_common *common;
+		const char *name;
+
+		if (!hw)
+			continue;
+
+		common = hw_to_ccu_common(hw);
+		name = hw->init->name;
+
+		common->lock		= &priv->lock;
+		common->base		= priv->base;
+		common->lock_base	= priv->lock_base;
+
+		ret = devm_clk_hw_register(dev, hw);
+		if (ret) {
+			dev_err(dev, "Cannot register clock %d - %s\n",
+				i, name);
+			return ret;
+		}
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   data->hw_clks);
+}
+
+static int spacemit_ccu_probe(struct platform_device *pdev)
+{
+	const struct spacemit_ccu_data *data;
+	struct regmap *base_map, *lock_map;
+	struct device *dev = &pdev->dev;
+	struct spacemit_ccu_priv *priv;
+	struct device_node *parent;
+	int ret;
+
+	data = of_device_get_match_data(dev);
+	if (WARN_ON(!data))
+		return -EINVAL;
+
+	parent   = of_get_parent(dev->of_node);
+	base_map = syscon_node_to_regmap(parent);
+	of_node_put(parent);
+
+	if (IS_ERR(base_map))
+		return dev_err_probe(dev, PTR_ERR(base_map),
+				     "failed to get regmap\n");
+
+	if (data->need_pll_lock) {
+		lock_map = syscon_regmap_lookup_by_phandle(dev->of_node,
+							   "spacemit,mpmu");
+		if (IS_ERR(lock_map))
+			return dev_err_probe(dev, PTR_ERR(lock_map),
+					     "failed to get lock regmap\n");
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->data	= data;
+	priv->base	= base_map;
+	priv->lock_base	= lock_map;
+	spin_lock_init(&priv->lock);
+
+	ret = spacemit_ccu_register(dev, priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register clocks");
+
+	return 0;
+}
+
+static const struct spacemit_ccu_data spacemit_ccu_apbs_data = {
+	.need_pll_lock	= true,
+	.hw_clks	= &spacemit_ccu_apbs_clks,
+};
+
+static const struct spacemit_ccu_data spacemit_ccu_mpmu_data = {
+	.need_pll_lock	= false,
+	.hw_clks	= &spacemit_ccu_mpmu_clks,
+};
+
+static const struct spacemit_ccu_data spacemit_ccu_apbc_data = {
+	.need_pll_lock	= false,
+	.hw_clks	= &spacemit_ccu_apbc_clks,
+};
+
+static const struct spacemit_ccu_data spacemit_ccu_apmu_data = {
+	.need_pll_lock	= false,
+	.hw_clks	= &spacemit_ccu_apmu_clks,
+};
+
+static const struct of_device_id of_spacemit_ccu_match[] = {
+	{
+		.compatible	= "spacemit,ccu-apbs",
+		.data		= &spacemit_ccu_apbs_data,
+	},
+	{
+		.compatible	= "spacemit,ccu-mpmu",
+		.data		= &spacemit_ccu_mpmu_data,
+	},
+	{
+		.compatible	= "spacemit,ccu-apbc",
+		.data		= &spacemit_ccu_apbc_data,
+	},
+	{
+		.compatible	= "spacemit,ccu-apmu",
+		.data		= &spacemit_ccu_apmu_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, of_spacemit_ccu_match);
+
+static struct platform_driver spacemit_ccu_driver = {
+	.driver = {
+		.name		= "spacemit,ccu",
+		.of_match_table = of_spacemit_ccu_match,
+	},
+	.probe	= spacemit_ccu_probe,
+};
+module_platform_driver(spacemit_ccu_driver);
+
+MODULE_DESCRIPTION("Spacemit CCU driver");
+MODULE_AUTHOR("Haylen Chu <heylenay@outlook.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/spacemit/ccu_common.h b/drivers/clk/spacemit/ccu_common.h
new file mode 100644
index 000000000000..c4406099c3fc
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_common.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _CCU_COMMON_H_
+#define _CCU_COMMON_H_
+
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+
+enum ccu_div_type {
+	CLK_DIV_TYPE_1REG_NOFC_V1 = 0,
+	CLK_DIV_TYPE_1REG_FC_V2,
+	CLK_DIV_TYPE_2REG_NOFC_V3,
+	CLK_DIV_TYPE_2REG_FC_V4,
+	CLK_DIV_TYPE_1REG_FC_DIV_V5,
+	CLK_DIV_TYPE_1REG_FC_MUX_V6,
+};
+
+struct ccu_common {
+	struct regmap *base;
+	struct regmap *lock_base;
+	spinlock_t *lock;
+
+	enum ccu_div_type reg_type;
+	u32 reg_ctrl;
+	u32 reg_sel;
+	u32 reg_xtc;
+	u32 fc;
+	bool is_pll;
+
+	unsigned long flags;
+	const char *name;
+	const char * const *parent_names;
+	int num_parents;
+
+	struct clk_hw hw;
+};
+
+static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
+{
+	return container_of(hw, struct ccu_common, hw);
+}
+
+#define ccu_read(reg, c, val)	regmap_read((c)->base, (c)->reg_##reg, val)
+#define ccu_write(reg, c, val)	regmap_write((c)->base, (c)->reg_##reg, val)
+#define ccu_update(reg, c, mask, val) \
+	regmap_update_bits((c)->base, (c)->reg_##reg, mask, val)
+#define ccu_poll(reg, c, tmp, cond, sleep, timeout) \
+	regmap_read_poll_timeout_atomic((c)->base, (c)->reg_##reg,	\
+					tmp, cond, sleep, timeout)
+
+#endif /* _CCU_COMMON_H_ */
diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
new file mode 100644
index 000000000000..bf2a790c3941
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_ddn.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Spacemit clock type ddn
+ *
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+
+#include "ccu_ddn.h"
+
+#define ddn_read_sel(common, val)	ccu_read(sel, common, val)
+#define ddn_read_ctrl(common, val)	ccu_read(ctrl, common, val)
+#define ddn_update_sel(common, m, v)	ccu_update(sel, common, m, v)
+#define ddn_update_ctrl(common, m, v)	ccu_update(ctrl, common, m, v)
+
+/*
+ * It is M/N clock
+ *
+ * Fout from synthesizer can be given from two equations:
+ * numerator/denominator = Fin / (Fout * factor)
+ */
+static void ccu_ddn_disable(struct clk_hw *hw)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_common *common = &ddn->common;
+	unsigned long flags;
+
+	if (!ddn->gate)
+		return;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	ddn_update_sel(common, ddn->gate, 0);
+
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static int ccu_ddn_enable(struct clk_hw *hw)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_common *common = &ddn->common;
+	unsigned long flags;
+
+	if (!ddn->gate)
+		return 0;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	ddn_update_sel(common, ddn->gate, ddn->gate);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
+
+static int ccu_ddn_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_common *common = &ddn->common;
+	u32 tmp;
+
+	if (!ddn->gate)
+		return 1;
+
+	ddn_read_sel(common, &tmp);
+
+	return tmp & ddn->gate;
+}
+
+static long clk_ddn_round_rate(struct clk_hw *hw, unsigned long drate,
+			       unsigned long *prate)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_ddn_config *params = &ddn->ddn;
+	unsigned long rate = 0, prev_rate;
+	unsigned long result;
+	int i;
+
+	for (i = 0; i < params->tbl_size; i++) {
+		prev_rate = rate;
+		rate = (((*prate / 10000) * params->tbl[i].den) /
+			(params->tbl[i].num * params->info->factor)) * 10000;
+		if (rate > drate)
+			break;
+	}
+
+	if ((i == 0) || (i == params->tbl_size)) {
+		result = rate;
+	} else {
+		if ((drate - prev_rate) > (rate - drate))
+			result = rate;
+		else
+			result = prev_rate;
+	}
+
+	return result;
+}
+
+static unsigned long clk_ddn_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_ddn_config *params = &ddn->ddn;
+	unsigned int val, num, den;
+	unsigned long rate;
+
+	ddn_read_ctrl(&ddn->common, &val);
+
+	num = (val >> params->info->num_shift) & params->info->num_mask;
+	den = (val >> params->info->den_shift) & params->info->den_mask;
+
+	if (!den)
+		return 0;
+
+	rate = ((parent_rate / 10000)  * den) / (num * params->info->factor);
+	rate *= 10000;
+
+	return rate;
+}
+
+/* Configures new clock rate*/
+static int clk_ddn_set_rate(struct clk_hw *hw, unsigned long drate,
+			    unsigned long prate)
+{
+	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
+	struct ccu_ddn_config *params = &ddn->ddn;
+	struct ccu_ddn_info *info = params->info;
+	unsigned long prev_rate, rate = 0;
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < params->tbl_size; i++) {
+		prev_rate = rate;
+		rate = ((prate / 10000) * params->tbl[i].den) /
+		       (params->tbl[i].num * info->factor);
+		rate *= 10000;
+
+		if (rate > drate)
+			break;
+	}
+
+	if (i > 0)
+		i--;
+
+	spin_lock_irqsave(ddn->common.lock, flags);
+
+	ddn_update_ctrl(&ddn->common,
+			info->num_mask | info->den_mask,
+			(params->tbl[i].num << info->num_shift) |
+			(params->tbl[i].den << info->den_shift));
+
+	spin_unlock_irqrestore(ddn->common.lock, flags);
+
+	return 0;
+}
+
+const struct clk_ops spacemit_ccu_ddn_ops = {
+	.disable	= ccu_ddn_disable,
+	.enable		= ccu_ddn_enable,
+	.is_enabled	= ccu_ddn_is_enabled,
+	.recalc_rate	= clk_ddn_recalc_rate,
+	.round_rate	= clk_ddn_round_rate,
+	.set_rate	= clk_ddn_set_rate,
+};
diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
new file mode 100644
index 000000000000..ac9c397c7cc9
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_ddn.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenayy@outlook.com>
+ */
+
+#ifndef _CCU_DDN_H_
+#define _CCU_DDN_H_
+
+
+#include <linux/spinlock_types.h>
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct ccu_ddn_tbl {
+	unsigned int num;
+	unsigned int den;
+};
+
+struct ccu_ddn_info {
+	unsigned int factor;
+	unsigned int num_mask;
+	unsigned int den_mask;
+	unsigned int num_shift;
+	unsigned int den_shift;
+};
+
+struct ccu_ddn_config {
+	struct ccu_ddn_info *info;
+	struct ccu_ddn_tbl *tbl;
+	u32 tbl_size;
+};
+
+struct ccu_ddn {
+	struct ccu_ddn_config  ddn;
+	struct ccu_common	common;
+	u32 gate;
+};
+
+#define CCU_DDN_CONFIG(_info, _table)					\
+	{								\
+		.info		= (struct ccu_ddn_info *)_info,		\
+		.tbl		= (struct ccu_ddn_tbl *)&_table,	\
+		.tbl_size	= ARRAY_SIZE(_table),			\
+	}
+
+#define CCU_DDN_DEFINE(_struct, _name, _parent, _info, _table,		\
+		       _reg_ctrl, _flags)				\
+	struct ccu_ddn _struct = {					\
+		.ddn	= CCU_DDN_CONFIG(_info, _table),		\
+		.common = {						\
+			.reg_ctrl = _reg_ctrl,				\
+			.hw.init  = CLK_HW_INIT(_name, _parent,		\
+					       &spacemit_ccu_ddn_ops,	\
+					       _flags),			\
+		}							\
+	}
+
+#define CCU_DDN_GATE_DEFINE(_struct, _name, _parent, _info, _table,	\
+			    _reg_ddn, _reg_gate, _gate_mask, _flags)	\
+	struct ccu_ddn _struct = {					\
+		.ddn	= CCU_DDN_CONFIG(_info, _table),		\
+		.common = {						\
+			.reg_ctrl	= _reg_ddn,			\
+			.reg_sel	= _reg_gate,			\
+			.hw.init = CLK_HW_INIT(_name, _parent,		\
+					       &spacemit_ccu_ddn_ops,	\
+					       _flags),			\
+		}							\
+		.gate	= _gate_mask,					\
+	}
+
+
+static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_ddn, common);
+}
+
+extern const struct clk_ops spacemit_ccu_ddn_ops;
+
+#endif
diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
new file mode 100644
index 000000000000..17182de761f6
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_mix.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Spacemit clock type mix(div/mux/gate/factor)
+ *
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+#include "ccu_mix.h"
+
+#define MIX_TIMEOUT	10000
+
+#define mix_read_sel(c, val)		ccu_read(sel, c, val)
+#define mix_read_ctrl(c, val)		ccu_read(ctrl, c, val)
+#define mix_update_sel(c, m, v)		ccu_update(sel, c, m, v)
+#define mix_update_ctrl(c, m, v)	ccu_update(ctrl, c, m, v)
+
+#define mix_hwparam_in_sel(c) \
+	((c)->reg_type == CLK_DIV_TYPE_2REG_NOFC_V3 || \
+	 (c)->reg_type == CLK_DIV_TYPE_2REG_FC_V4)
+
+static void ccu_mix_disable(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_gate_config *gate = mix->gate;
+	unsigned long flags = 0;
+
+	if (!gate)
+		return;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	if (mix_hwparam_in_sel(common))
+		mix_update_sel(common, gate->gate_mask, gate->val_disable);
+	else
+		mix_update_ctrl(common, gate->gate_mask, gate->val_disable);
+
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+static int ccu_mix_enable(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_gate_config *gate = mix->gate;
+	u32 val_enable, mask;
+	unsigned long flags;
+	u32 tmp;
+
+	if (!gate)
+		return 0;
+
+	val_enable	= gate->val_enable;
+	mask		= gate->gate_mask;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	if (mix_hwparam_in_sel(common))
+		mix_update_sel(common, mask, val_enable);
+	else
+		mix_update_ctrl(common, mask, val_enable);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	if (common->reg_type == CLK_DIV_TYPE_2REG_NOFC_V3 ||
+	    common->reg_type == CLK_DIV_TYPE_2REG_FC_V4)
+		return ccu_poll(sel, common, tmp, (tmp & mask) == val_enable,
+				10, MIX_TIMEOUT);
+	else
+		return ccu_poll(ctrl, common, tmp, (tmp & mask) == val_enable,
+				10, MIX_TIMEOUT);
+}
+
+static int ccu_mix_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_gate_config *gate = mix->gate;
+	unsigned long flags = 0;
+	u32 tmp;
+
+	if (!gate)
+		return 1;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	if (mix_hwparam_in_sel(common))
+		mix_read_sel(common, &tmp);
+	else
+		mix_read_ctrl(common, &tmp);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return (tmp & gate->gate_mask) == gate->val_enable;
+}
+
+static unsigned long ccu_mix_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_div_config *div = mix->div;
+	unsigned long val;
+	u32 reg;
+
+	if (!div) {
+		if (mix->factor)
+			return parent_rate * mix->factor->mul / mix->factor->div;
+
+		return parent_rate;
+	}
+
+	if (mix_hwparam_in_sel(common))
+		mix_read_sel(common, &reg);
+	else
+		mix_read_ctrl(common, &reg);
+
+	val = reg >> div->shift;
+	val &= (1 << div->width) - 1;
+
+	val = divider_recalc_rate(hw, parent_rate, val, div->table,
+				  div->flags, div->width);
+
+	return val;
+}
+
+
+static int ccu_mix_trigger_fc(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	int ret = 0, timeout = 50;
+	unsigned int val = 0;
+
+	if (common->reg_type == CLK_DIV_TYPE_1REG_FC_V2 ||
+	    common->reg_type == CLK_DIV_TYPE_2REG_FC_V4 ||
+	    common->reg_type == CLK_DIV_TYPE_1REG_FC_DIV_V5 ||
+	    common->reg_type == CLK_DIV_TYPE_1REG_FC_MUX_V6) {
+		timeout = 50;
+		mix_update_ctrl(common, common->fc, common->fc);
+
+		ret = ccu_poll(ctrl, common, val, !(val & common->fc),
+			       5, MIX_TIMEOUT);
+	}
+
+	return ret;
+}
+
+static int ccu_mix_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	return 0;
+}
+
+static long ccu_mix_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *prate)
+{
+	return rate;
+}
+
+static unsigned long
+ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate, u32 *mux_val,
+		       u32 *div_val)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_div_config *div = mix->div ? mix->div : NULL;
+	struct clk_hw *parent;
+	unsigned long parent_rate = 0, best_rate = 0;
+	u32 i, j, div_max;
+
+	for (i = 0; i < common->num_parents; i++) {
+		parent = clk_hw_get_parent_by_index(hw, i);
+		if (!parent)
+			continue;
+
+		parent_rate = clk_hw_get_rate(parent);
+
+		if (div)
+			div_max = 1 << div->width;
+		else
+			div_max = 1;
+
+		for (j = 1; j <= div_max; j++) {
+			if (abs(parent_rate/j - rate) < abs(best_rate - rate)) {
+				best_rate = DIV_ROUND_UP_ULL(parent_rate, j);
+				*mux_val = i;
+				*div_val = j - 1;
+			}
+		}
+	}
+
+	return best_rate;
+}
+
+static int ccu_mix_set_rate(struct clk_hw *hw, unsigned long rate,
+			   unsigned long parent_rate)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_div_config *div = mix->div;
+	struct ccu_mux_config *mux = mix->mux;
+	u32 cur_mux, cur_div, mux_val = 0, div_val = 0;
+	unsigned long best_rate = 0;
+	unsigned long flags;
+	int ret = 0, tmp = 0;
+
+	if (!div && !mux)
+		return 0;
+
+	best_rate = ccu_mix_calc_best_rate(hw, rate, &mux_val, &div_val);
+
+	if (mix_hwparam_in_sel(common))
+		mix_read_sel(common, &tmp);
+	else
+		mix_read_ctrl(common, &tmp);
+
+	if (mux) {
+		cur_mux = tmp >> mux->shift;
+		cur_mux &= (1 << mux->width) - 1;
+
+		if (cur_mux != mux_val)
+			clk_hw_set_parent(hw,
+					  clk_hw_get_parent_by_index(hw,
+								     mux_val));
+	}
+
+	if (div) {
+		cur_div = tmp >> div->shift;
+		cur_div &= (1 << div->width) - 1;
+
+		if (cur_div == div_val)
+			return 0;
+	} else {
+		return 0;
+	}
+
+	tmp = GENMASK(div->width + div->shift - 1, div->shift);
+
+	spin_lock_irqsave(common->lock, flags);
+
+	if (mix_hwparam_in_sel(common))
+		mix_update_sel(common, tmp, div_val << div->shift);
+	else
+		mix_update_ctrl(common, tmp, div_val << div->shift);
+
+	if (common->reg_type == CLK_DIV_TYPE_1REG_FC_V2 ||
+	    common->reg_type == CLK_DIV_TYPE_2REG_FC_V4 ||
+	    common->reg_type == CLK_DIV_TYPE_1REG_FC_DIV_V5)
+		ret = ccu_mix_trigger_fc(hw);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return ret;
+}
+
+static u8 ccu_mix_get_parent(struct clk_hw *hw)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_mux_config *mux = mix->mux;
+	u32 reg;
+	u8 parent;
+
+	if (!mux)
+		return 0;
+
+	if (mix_hwparam_in_sel(common))
+		mix_read_sel(common, &reg);
+	else
+		mix_read_ctrl(common, &reg);
+
+	parent = reg >> mux->shift;
+	parent &= (1 << mux->width) - 1;
+
+	if (mux->table) {
+		int num_parents = clk_hw_get_num_parents(&common->hw);
+		int i;
+
+		for (i = 0; i < num_parents; i++)
+			if (mux->table[i] == parent)
+				return i;
+	}
+
+	return parent;
+}
+
+static int ccu_mix_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct ccu_mix *mix = hw_to_ccu_mix(hw);
+	struct ccu_common *common = &mix->common;
+	struct ccu_mux_config *mux = mix->mux;
+	unsigned long flags;
+	int ret = 0;
+	u32 mask;
+
+	if (!mux)
+		return 0;
+
+	if (mux->table)
+		index = mux->table[index];
+
+	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
+
+	spin_lock_irqsave(common->lock, flags);
+
+	if (mix_hwparam_in_sel(common))
+		mix_update_sel(common, mask, index << mux->shift);
+	else
+		mix_update_ctrl(common, mask, index << mux->shift);
+
+	if (common->reg_type == CLK_DIV_TYPE_1REG_FC_V2 ||
+	    common->reg_type == CLK_DIV_TYPE_2REG_FC_V4 ||
+	    common->reg_type == CLK_DIV_TYPE_1REG_FC_MUX_V6)
+		ret = ccu_mix_trigger_fc(hw);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return ret;
+}
+
+const struct clk_ops spacemit_ccu_mix_ops = {
+	.disable	 = ccu_mix_disable,
+	.enable		 = ccu_mix_enable,
+	.is_enabled	 = ccu_mix_is_enabled,
+	.get_parent	 = ccu_mix_get_parent,
+	.set_parent	 = ccu_mix_set_parent,
+	.determine_rate  = ccu_mix_determine_rate,
+	.round_rate	 = ccu_mix_round_rate,
+	.recalc_rate	 = ccu_mix_recalc_rate,
+	.set_rate	 = ccu_mix_set_rate,
+};
+
diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
new file mode 100644
index 000000000000..f949afda3ab4
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_mix.h
@@ -0,0 +1,349 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _CCU_MIX_H_
+#define _CCU_MIX_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct ccu_gate_config {
+	u32 gate_mask;
+	u32 val_enable;
+	u32 val_disable;
+	u32 flags;
+};
+
+struct ccu_factor_config {
+	u32 div;
+	u32 mul;
+};
+
+struct ccu_mux_config {
+	const u8 *table;
+	u32 flags;
+	u8 shift;
+	u8 width;
+};
+
+struct ccu_div_config {
+	struct clk_div_table *table;
+	u32 max;
+	u32 offset;
+	u32 flags;
+	u8 shift;
+	u8 width;
+};
+
+struct ccu_mix {
+	struct ccu_factor_config *factor;
+	struct ccu_gate_config *gate;
+	struct ccu_div_config *div;
+	struct ccu_mux_config *mux;
+	struct ccu_common common;
+};
+
+#define CCU_GATE_INIT(_gate_mask, _val_enable, _val_disable, _flags)		\
+	(&(struct ccu_gate_config) {						\
+		.gate_mask   = _gate_mask,					\
+		.val_enable  = _val_enable,					\
+		.val_disable = _val_disable,					\
+		.flags	     = _flags,						\
+	})
+
+#define CCU_FACTOR_INIT(_div, _mul)					\
+	(&(struct ccu_factor_config) {					\
+		.div = _div,						\
+		.mul = _mul,						\
+	})
+
+
+#define CCU_MUX_INIT(_shift, _width, _table, _flags)			\
+	(&(struct ccu_mux_config) {					\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.table	= _table,					\
+		.flags	= _flags,					\
+	})
+
+#define CCU_DIV_INIT(_shift, _width, _table, _flags)			\
+	(&(struct ccu_div_config) {					\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.flags	= _flags,					\
+		.table	= _table,					\
+	})
+
+#define CCU_MIX_INITHW(_name, _parent, _flags) \
+	CLK_HW_INIT(_name, _parent, &spacemit_ccu_mix_ops, _flags)
+
+#define CCU_MIX_ORPHAN_INITHW(_name, _flags) \
+	CLK_HW_INIT_NO_PARENT(_name, &spacemit_ccu_mix_ops, _flags)
+
+#define CCU_MIX_INITHW_PARENTS(_name, _parents, _flags) \
+	CLK_HW_INIT_PARENTS(_name, _parents, &spacemit_ccu_mix_ops, _flags)
+
+#define CCU_GATE_DEFINE(_struct, _name, _parent, _reg, _gate_mask,	\
+			 _val_enable, _val_disable, _flags)		\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.common	= {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init	= CCU_MIX_INITHW(_name, _parent,	\
+						 _flags),		\
+	}								\
+}
+#define CCU_GATE_NO_PARENT_DEFINE(_struct, _name,  _reg, _gate_mask,	\
+				  _val_enable, _val_disable, _flags)	\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.num_parents	= 0,					\
+		.hw.init	= CCU_MIX_ORPHAN_INITHW(_name, _flags)	\
+	}								\
+}
+
+#define CCU_FACTOR_DEFINE(_struct, _name, _parent, _div, _mul)		\
+struct ccu_mix _struct = {						\
+	.factor	= CCU_FACTOR_INIT(_div, _mul),				\
+	.common = {							\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init	= CCU_MIX_INITHW(_name, _parent, 0),	\
+	}								\
+}
+
+#define CCU_MUX_DEFINE(_struct, _name, _parents, _reg, _shift, _width,	\
+		       _flags)						\
+struct ccu_mix _struct = {						\
+	.mux	= CCU_MUX_INIT(_shift, _width, NULL, 0),		\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	}								\
+}
+
+#define CCU_DIV_DEFINE(_struct, _name, _parent, _reg, _shift, _width,	\
+		       _flags)						\
+struct ccu_mix _struct = {						\
+	.div	= CCU_DIV_INIT(_shift, _width, NULL, 0),		\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init = CCU_MIX_INITHW(_name, _parent, _flags)	\
+	}								\
+}
+
+#define CCU_GATE_FACTOR_DEFINE(_struct, _name, _parent, _reg,		\
+			       _gate_mask, _val_enable, _val_disable,	\
+			       _div, _mul, _flags)			\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.factor	= CCU_FACTOR_INIT(_div, _mul),				\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init = CCU_MIX_INITHW(_name, _parent, _flags)	\
+	}								\
+}
+
+
+#define CCU_MUX_GATE_DEFINE(_struct, _name, _parents, _reg, _shift,	\
+			    _width, _gate_mask, _val_enable,		\
+			    _val_disable, _flags)			\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.mux	= CCU_MUX_INIT(_shift, _width, NULL, 0),		\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	}								\
+}
+
+#define CCU_DIV_GATE_DEFINE(_struct, _name, _parent, _reg, _shift,	\
+			    _width, _gate_mask, _val_enable,		\
+			    _val_disable, _flags)			\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_shift, _width, NULL, 0),		\
+	.common = {							\
+		.reg_ctrl	= _reg,					\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init	= CCU_MIX_INITHW(_name, _parent,	\
+						 _flags),		\
+	}								\
+}
+
+
+#define CCU_DIV_MUX_GATE_DEFINE(_struct, _name, _parents,  _reg_ctrl,	\
+				_mshift, _mwidth, _muxshift, _muxwidth,	\
+				_gate_mask, _val_enable, _val_disable,	\
+				_flags)					\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common	= {							\
+		.reg_ctrl	= _reg_ctrl,				\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	},								\
+}
+
+#define CCU_DIV2_FC_MUX_GATE_DEFINE(_struct, _name, _parents,		\
+				    _reg_ctrl, _reg_sel, _mshift,	\
+				    _mwidth, _fc, _muxshift, _muxwidth,	\
+				    _gate_mask, _val_enable,		\
+				    _val_disable, _flags)		\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common = {							\
+	    .reg_type = CLK_DIV_TYPE_2REG_FC_V4,			\
+		.reg_ctrl	= _reg_ctrl,				\
+		.reg_sel	= _reg_sel,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	},								\
+}
+
+
+#define CCU_DIV_FC_MUX_GATE_DEFINE(_struct, _name, _parents, _reg_ctrl,	\
+				   _mshift, _mwidth, _fc, _muxshift,	\
+				   _muxwidth, _gate_mask, _val_enable,	\
+				   _val_disable, _flags)		\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common = {							\
+		.reg_type	= CLK_DIV_TYPE_1REG_FC_V2,		\
+		.reg_ctrl	= _reg_ctrl,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	},								\
+}
+
+#define CCU_DIV_MFC_MUX_GATE_DEFINE(_struct, _name, _parents,		\
+				    _reg_ctrl, _mshift, _mwidth, _fc,	\
+				    _muxshift, _muxwidth, _gate_mask,	\
+				    _val_enable, _val_disable, _flags)	\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common = {							\
+		.reg_type = CLK_DIV_TYPE_1REG_FC_MUX_V6,		\
+		.reg_ctrl	= _reg_ctrl,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+		},							\
+	}								\
+}
+
+#define CCU_DIV_FC_WITH_GATE_DEFINE(_struct, _name, _parent, _reg_ctrl,	\
+				    _mshift, _mwidth, _fc, _gate_mask,	\
+				    _val_enable, _val_disable, _flags)	\
+struct ccu_mix _struct = {						\
+	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,		\
+				_val_disable, 0),			\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.common = {							\
+		.reg_type = CLK_DIV_TYPE_1REG_FC_V2,			\
+		.reg_ctrl	= _reg_ctrl,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.num_parents	= 1,					\
+		.hw.init	= CCU_MIXINITHW(_name, _parent,		\
+						_flags),		\
+	},								\
+}
+
+#define CCU_DIV_FC_MUX_DEFINE(_struct, _name, _parents, _reg_ctrl,	\
+			      _mshift, _mwidth, _fc, _muxshift,		\
+			      _muxwidth, _flags)			\
+struct ccu_mix _struct = {						\
+	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),		\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common = {							\
+		.reg_type	= CLK_DIV_TYPE_1REG_FC_V2,		\
+		.reg_ctrl	= _reg_ctrl,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags),		\
+	},								\
+}
+
+#define CCU_MUX_FC_DEFINE(_struct, _name, _parents, _reg_ctrl, _fc,	\
+			  _muxshift, _muxwidth, _flags)			\
+struct ccu_mix _struct = {						\
+	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),		\
+	.common = {							\
+		.reg_type	= CLK_DIV_TYPE_1REG_FC_V2,		\
+		.reg_ctrl	= _reg_ctrl,				\
+		.fc		= _fc,					\
+		.name		= _name,				\
+		.parent_names	= _parents,				\
+		.num_parents	= ARRAY_SIZE(_parents),			\
+		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,	\
+						  _flags)		\
+	},								\
+}
+
+static inline struct ccu_mix *hw_to_ccu_mix(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_mix, common);
+}
+
+extern const struct clk_ops spacemit_ccu_mix_ops;
+
+#endif /* _CCU_DIV_H_ */
diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
new file mode 100644
index 000000000000..2ab8d812d118
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_pll.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Spacemit clock type pll
+ *
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+
+#include "ccu_common.h"
+#include "ccu_pll.h"
+
+#define PLL_MIN_FREQ	600000000
+#define PLL_MAX_FREQ	3400000000
+#define PLL_DELAY_TIME	3000
+
+#define pll_read_swcr1(c, v)	ccu_read(ctrl, c, v)
+#define pll_read_swcr2(c, v)	ccu_read(sel, c, v)
+#define pll_read_swcr3(c, v)	ccu_read(xtc, c, v)
+
+#define pll_update_swcr1(c, m, v)	ccu_update(ctrl, c, m, v)
+#define pll_update_swcr2(c, m, v)	ccu_update(sel, c, m, v)
+#define pll_update_swcr3(c, m, v)	ccu_update(xtc, c, m, v)
+
+#define PLL_SWCR1_REG5_OFF	0
+#define PLL_SWCR1_REG5_MASK	GENMASK(7, 0)
+#define PLL_SWCR1_REG6_OFF	8
+#define PLL_SWCR1_REG6_MASK	GENMASK(15, 8)
+#define PLL_SWCR1_REG7_OFF	16
+#define PLL_SWCR1_REG7_MASK	GENMASK(23, 16)
+#define PLL_SWCR1_REG8_OFF	24
+#define PLL_SWCR1_REG8_MASK	GENMASK(31, 24)
+
+#define PLL_SWCR2_DIVn_EN(n)	BIT(n + 1)
+#define PLL_SWCR2_ATEST_EN	BIT(12)
+#define PLL_SWCR2_CKTEST_EN	BIT(13)
+#define PLL_SWCR2_DTEST_EN	BIT(14)
+
+#define PLL_SWCR3_DIV_FRC_OFF	0
+#define PLL_SWCR3_DIV_FRC_MASK	GENMASK(23, 0)
+#define PLL_SWCR3_DIV_INT_OFF	24
+#define PLL_SWCR3_DIV_INT_MASK	GENMASK(30, 24)
+#define PLL_SWCR3_EN		BIT(31)
+
+static int ccu_pll_is_enabled(struct clk_hw *hw)
+{
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	u32 tmp;
+
+	pll_read_swcr3(&p->common, &tmp);
+
+	return tmp & PLL_SWCR3_EN;
+}
+
+/* frequency unit Mhz, return pll vco freq */
+static unsigned long __get_vco_freq(struct clk_hw *hw)
+{
+	unsigned int reg5, reg6, reg7, reg8, size, i;
+	unsigned int div_int, div_frc;
+	struct ccu_pll_rate_tbl *freq_pll_regs_table;
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	struct ccu_common *common = &p->common;
+	u32 tmp;
+
+	pll_read_swcr1(common, &tmp);
+	reg5 = (tmp & PLL_SWCR1_REG5_MASK) >> PLL_SWCR1_REG5_OFF;
+	reg6 = (tmp & PLL_SWCR1_REG6_MASK) >> PLL_SWCR1_REG6_OFF;
+	reg7 = (tmp & PLL_SWCR1_REG7_MASK) >> PLL_SWCR1_REG7_OFF;
+	reg8 = (tmp & PLL_SWCR1_REG8_MASK) >> PLL_SWCR1_REG8_OFF;
+
+	pll_read_swcr3(common, &tmp);
+	div_int = (tmp & PLL_SWCR3_DIV_INT_MASK) >> PLL_SWCR3_DIV_INT_OFF;
+	div_frc = (tmp & PLL_SWCR3_DIV_FRC_MASK) >> PLL_SWCR3_DIV_FRC_OFF;
+
+	freq_pll_regs_table = p->pll.rate_tbl;
+	size = p->pll.tbl_size;
+
+	for (i = 0; i < size; i++)
+		if ((freq_pll_regs_table[i].reg5 == reg5) &&
+		    (freq_pll_regs_table[i].reg6 == reg6) &&
+		    (freq_pll_regs_table[i].reg7 == reg7) &&
+		    (freq_pll_regs_table[i].reg8 == reg8) &&
+		    (freq_pll_regs_table[i].div_int == div_int) &&
+		    (freq_pll_regs_table[i].div_frac == div_frc))
+			return freq_pll_regs_table[i].rate;
+
+	WARN_ON_ONCE(1);
+
+	return 0;
+}
+
+static int ccu_pll_enable(struct clk_hw *hw)
+{
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	struct ccu_common *common = &p->common;
+	unsigned long flags;
+	unsigned int tmp;
+	int ret;
+
+	if (ccu_pll_is_enabled(hw))
+		return 0;
+
+	spin_lock_irqsave(common->lock, flags);
+
+	pll_update_swcr3(common, PLL_SWCR3_EN, PLL_SWCR3_EN);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	/* check lock status */
+	ret = regmap_read_poll_timeout_atomic(common->lock_base,
+					      p->pll.reg_lock,
+					      tmp,
+					      tmp & p->pll.lock_enable_bit,
+					      5, PLL_DELAY_TIME);
+
+	return ret;
+}
+
+static void ccu_pll_disable(struct clk_hw *hw)
+{
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	struct ccu_common *common = &p->common;
+	unsigned long flags;
+
+	spin_lock_irqsave(p->common.lock, flags);
+
+	pll_update_swcr3(common, PLL_SWCR3_EN, 0);
+
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+/*
+ * pll rate change requires sequence:
+ * clock off -> change rate setting -> clock on
+ * This function doesn't really change rate, but cache the config
+ */
+static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	struct ccu_common *common = &p->common;
+	struct ccu_pll_config *params = &p->pll;
+	struct ccu_pll_rate_tbl *entry;
+	unsigned long old_rate;
+	unsigned long flags;
+	bool found = false;
+	u32 mask, val;
+	int i;
+
+	if (ccu_pll_is_enabled(hw)) {
+		pr_err("%s %s is enabled, ignore the setrate!\n",
+		       __func__, __clk_get_name(hw->clk));
+		return 0;
+	}
+
+	old_rate = __get_vco_freq(hw);
+
+	for (i = 0; i < params->tbl_size; i++) {
+		if (rate == params->rate_tbl[i].rate) {
+			found = true;
+			entry = &params->rate_tbl[i];
+			break;
+		}
+	}
+	WARN_ON_ONCE(!found);
+
+	spin_lock_irqsave(common->lock, flags);
+
+	mask = PLL_SWCR1_REG5_MASK | PLL_SWCR1_REG6_MASK;
+	mask |= PLL_SWCR1_REG7_MASK | PLL_SWCR1_REG8_MASK;
+	val |= entry->reg5 << PLL_SWCR1_REG5_OFF;
+	val |= entry->reg6 << PLL_SWCR1_REG6_OFF;
+	val |= entry->reg7 << PLL_SWCR1_REG7_OFF;
+	val |= entry->reg8 << PLL_SWCR1_REG8_OFF;
+	pll_update_swcr1(common, mask, val);
+
+	mask = PLL_SWCR3_DIV_INT_MASK | PLL_SWCR3_DIV_FRC_MASK;
+	val = entry->div_int << PLL_SWCR3_DIV_INT_OFF;
+	val |= entry->div_frac << PLL_SWCR3_DIV_FRC_OFF;
+	pll_update_swcr3(common, mask, val);
+
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
+
+static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	return __get_vco_freq(hw);
+}
+
+static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	struct ccu_pll *p = hw_to_ccu_pll(hw);
+	struct ccu_pll_config *params = &p->pll;
+	unsigned long max_rate = 0;
+	unsigned int i;
+
+	if (rate > PLL_MAX_FREQ || rate < PLL_MIN_FREQ) {
+		pr_err("%lu rate out of range!\n", rate);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < params->tbl_size; i++) {
+		if (params->rate_tbl[i].rate <= rate) {
+			if (max_rate < params->rate_tbl[i].rate)
+				max_rate = params->rate_tbl[i].rate;
+		}
+	}
+
+	return max_rate;
+}
+
+const struct clk_ops spacemit_ccu_pll_ops = {
+	.enable = ccu_pll_enable,
+	.disable = ccu_pll_disable,
+	.set_rate = ccu_pll_set_rate,
+	.recalc_rate = ccu_pll_recalc_rate,
+	.round_rate = ccu_pll_round_rate,
+	.is_enabled = ccu_pll_is_enabled,
+};
+
diff --git a/drivers/clk/spacemit/ccu_pll.h b/drivers/clk/spacemit/ccu_pll.h
new file mode 100644
index 000000000000..c5dec2c0394b
--- /dev/null
+++ b/drivers/clk/spacemit/ccu_pll.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024 SpacemiT Technology Co. Ltd
+ * Copyright (c) 2024 Haylen Chu <heylenay@outlook.com>
+ */
+
+#ifndef _CCU_PLL_H_
+#define _CCU_PLL_H_
+
+#include <linux/spinlock_types.h>
+#include <linux/clk-provider.h>
+#include "ccu_common.h"
+
+struct ccu_pll_rate_tbl {
+	unsigned long long rate;
+	u32 reg5;
+	u32 reg6;
+	u32 reg7;
+	u32 reg8;
+	unsigned int div_int;
+	unsigned int div_frac;
+};
+
+struct ccu_pll_config {
+	struct ccu_pll_rate_tbl *rate_tbl;
+	u32 tbl_size;
+	u32 reg_lock;
+	u32 lock_enable_bit;
+};
+
+#define CCU_PLL_RATE(_rate, _reg5, _reg6, _reg7, _reg8, _div_int, _div_frac) \
+	{									\
+		.rate		= (_rate),					\
+		.reg5		= (_reg5),					\
+		.reg6		= (_reg6),					\
+		.reg7		= (_reg7),					\
+		.reg8		= (_reg8),					\
+		.div_int	= (_div_int),				\
+		.div_frac	= (_div_frac),				\
+	}
+
+struct ccu_pll {
+	struct ccu_pll_config	pll;
+	struct ccu_common	common;
+};
+
+#define CCU_PLL_CONFIG(_table, _reg_lock, _lock_enable_bit) \
+	{									\
+		.rate_tbl	 = (struct ccu_pll_rate_tbl *)&(_table),	\
+		.tbl_size	 = ARRAY_SIZE(_table),				\
+		.reg_lock	 = (_reg_lock),					\
+		.lock_enable_bit = (_lock_enable_bit),				\
+	}
+
+#define CCU_PLL_HWINIT(_name, _flags) \
+	CLK_HW_INIT_NO_PARENT(_name, &spacemit_ccu_pll_ops, _flags)
+
+#define CCU_PLL_DEFINE(_struct, _name, _table, _reg_ctrl, _reg_sel,	\
+		       _reg_xtc, _reg_lock, _lock_enable_bit, _flags)		\
+										\
+	struct ccu_pll _struct = {						\
+		.pll	= CCU_PLL_CONFIG(_table, _reg_lock, _lock_enable_bit),	\
+		.common = {							\
+			.reg_ctrl	= _reg_ctrl,				\
+			.reg_sel	= _reg_sel,				\
+			.reg_xtc	= _reg_xtc,				\
+			.is_pll		= true,					\
+			.hw.init	= CCU_PLL_HWINIT(_name, _flags)		\
+		}								\
+	}
+
+
+static inline struct ccu_pll *hw_to_ccu_pll(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_pll, common);
+}
+
+extern const struct clk_ops spacemit_ccu_pll_ops;
+
+#endif
-- 
2.46.0


