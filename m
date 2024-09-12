Return-Path: <linux-kernel+bounces-327304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF29773BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F251C23DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F5E1C2334;
	Thu, 12 Sep 2024 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="V6KiqOkg"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazrln10220002.outbound.protection.outlook.com [52.103.192.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0243A2C80;
	Thu, 12 Sep 2024 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.192.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726177484; cv=fail; b=rEMJmzC6Td4vLBA5QYWqaiiU6DO7lVDLGGgDI4MQxoBzPHDGyTkDigONi8gN3NvRN0W5jKBK/1xsc/79y3fnlYpD8uml//kCJoajiDnBLZ1pYSIHQj3gscPx37JjZxYa7YR4r8lvTMR6Ofu0TqzHbgS7qyCu1rs0B9ArkQingNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726177484; c=relaxed/simple;
	bh=OykJf/+w3rzOfF+wZRtjEb5+6+4Ny8YiZSFmJ0OUqBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQQiT320VJ6HwpW6DKZ1sArAGl7I+t/0x79F3ik2O4BDRqbtokSxbSJKPtLy767cZilrJBWchShFssj+9GxhhX2DN5HQivMPF/vlnvy71AlaGOUKFe275FB+QbcflrnUllKhG6JsXr+hpz60obA/AUuf8R+gvH7lmtjEVtRS/D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=V6KiqOkg; arc=fail smtp.client-ip=52.103.192.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI+66piJqjSpxJ5lFYzCvmj8j0gtu768MEOiGAWOqWTKUyDXLZnvWYszUfGCkiTxyqeKK3nRw+F6W0CuLDMKCarUdIPuO6N1oHp++ZropBcfMlsQpME2XHV0INZKZl4HhLjN8MgbwKGt2BsrSix0hL2YN2/W6i+tQAMmUCnVkCYh17VTIk4aYkCVQwtGH7x4KefW95cJyCYxwGdAV8nUPiR8KdJsaC0q29UJpkotA5svfUceZUbpHTXq2AHIaZ+PI5xVgorTR9MLYoL0ktgbKPgBGFUFKfo9G0byxGUkDsh38RkvMEZ6lM2YczdwKr5qcyqIq5YdnK40GN7qVwg85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BleYNzqeBhbUWlftD+xYBcElw3W8s17V2KOudDr6CLw=;
 b=a8tlCGdDiLKL/1pYRZyZ7GpudP+3+rCGRfCdV7ZE7BLCgf5oQhamIVCX2QcwDQ5SSkHXLVx+1nQowPFzmw1rBEPkaKIZ5pQ5FzO1vX69O0GkpPIFdqs9fIFcf0IUwSv7rym9GXJY8N3Fi6sbqoHTTLfqvgc0HOKKb95tM0irSdg71wY6xc6lIwxqH0/2DnDplKOhBmhOtfcphHXjAJNHJLApEinnr8xuP6R6e/JXOmOzyQApqy85gG1vt/DLyQP4wLQmfFK1M8VRnTbFccO4tJfl1RLpBzquDepHYeOrve8x7yG99GxDuaKwmWN2LSkTsbIYM9Npg0v2fk1/UjpUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BleYNzqeBhbUWlftD+xYBcElw3W8s17V2KOudDr6CLw=;
 b=V6KiqOkg7ZHvFsKAZvhCilHDkjVTYAiTQ1sulscEwRSRw+lQildqExOqZXWThy4bDkJfIayaFimwBYCT4XbTVPdeiejBjOmGKThP+Xy7R7A5oMBUGnfvtImmJxPMFxZCvQpeOIgde+bkYFw6ynGX6va4eh6pK/SHgpJB6AWe/d8=
Received: from SI2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::21) by
 TYSPR03MB7738.apcprd03.prod.outlook.com (2603:1096:400:414::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7939.23; Thu, 12 Sep 2024 19:10:47 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::14) by SI2P153CA0015.outlook.office365.com
 (2603:1096:4:140::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.9 via Frontend
 Transport; Thu, 12 Sep 2024 19:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:10:46 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 03:10:41 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Sep
 2024 03:10:41 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 13 Sep 2024 03:10:40 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 244D75F64D;
	Thu, 12 Sep 2024 22:10:40 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 21749DC0800; Thu, 12 Sep 2024 22:10:40 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v28 3/3] clk: npcm8xx: add clock controller
Date: Thu, 12 Sep 2024 22:10:38 +0300
Message-ID: <20240912191038.981105-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912191038.981105-1-tmaimon77@gmail.com>
References: <20240912191038.981105-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|TYSPR03MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: f40bfa0f-03f2-431a-e511-08dcd35e9b80
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|48200799018|82310400026|7093399012|7416014|376014|61400799027|921020|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?raEIXBHUlaho+UseuVtBDTa1qtYC3G4fY/3fpkPg8yd2rRo1i1VFtbKZ8IPJ?=
 =?us-ascii?Q?uZr7c15VzW+gd7Ag3caIge7vBapRv8AJfqp/j7QNVAjoxZE1PkZqdBt6eTq6?=
 =?us-ascii?Q?W7D71EbNg+Oam3lBNuO0vQG7Y/LnvFye0z1acWZAzvBSGz+eNzcqqBqBd5vr?=
 =?us-ascii?Q?hpzBnrJYWrGMGL+s9EhT0xrFiC/l8AEQ7bNEs+MIo54wFA/j319NKXhPocGQ?=
 =?us-ascii?Q?aK3WPn5ezQwsbx4a4aWDj9AU6+kwgE9ky5qKSBRhRgT1YOW9hwrldVyZwgL6?=
 =?us-ascii?Q?PaUQaKanipaeGzBqmManeYXHlIh+yoBmUUWGocZktPZ7HOFbOeGw+yL4touu?=
 =?us-ascii?Q?TrD4OOP6lVZeksWSf+EN5WW0pMSDd1pWG61FN/Hp8V4zOs8IuuN3P4hEA6p5?=
 =?us-ascii?Q?acDLU6eTpp1IaxxicawGWOdUSP68YTmgFUtmgSIvzqvxGkaNWoWX6nnRDfxp?=
 =?us-ascii?Q?IZhZkK7WpUt1AHIOMNCwo7F2HgItMEh8dS9ph1zJnvUBorvZqJpI6bxct61X?=
 =?us-ascii?Q?moEALas1qwUbETtvFnFPvx19+vONKdjq0Qs0FWZr+t3AxxAQ9BSoym9Aa5+s?=
 =?us-ascii?Q?ygSO70WeXmJ+Vf18Gkuucx3shlh96nMTBe5I4ySE0LJtawH9mBHv/FrzqHtC?=
 =?us-ascii?Q?l3cMW40t0eQLR59SiZyAC/evV8ZI4e8yvxb35DVFZHIjZK49T5d2NUTBFogc?=
 =?us-ascii?Q?oHEmSRvd+9EQ2Q6J0sy3Gyh+7QlRztMI0KFl5QK221N7FHtOV/7uvJH4sHfy?=
 =?us-ascii?Q?IrBkFliGSkU8Pzj6BYqJ40665ozaE9Z4azx78m1etDdTGJrVjo+MHUEbAsPF?=
 =?us-ascii?Q?k+AWUjEWefn6RtCh3ZM9FriR0OWz4WtyIAWsmGcyz9qc2XVBDjTB8mmeQ2M0?=
 =?us-ascii?Q?pNSG/M9+Udw+pB85a6s0yAEgZqV6+R0Y0m1N+PjQIWblq1euz1uLy1X91rLd?=
 =?us-ascii?Q?KxkDz9/H1k2Wob9+D8IdLSAwZvx88d5Xj4S7cJFQGB4pedouRXm2RKibJyqL?=
 =?us-ascii?Q?ZQ4OnIulLN761180Cg1dA0g1BzWq9YvEGKVDfYrEjvxUQKVCze0T4tHoc32j?=
 =?us-ascii?Q?PqNi3nLCSuvRPjl+PWXKVcPRN3PShRAAqcPGqtDgPNkG5h0bvBGjkldiOIvr?=
 =?us-ascii?Q?4xcT7HQM5FU9zUtf3nEC377fOfAT4dxypULLoQ5GhNYTxgzCYzhFmkjt3dbm?=
 =?us-ascii?Q?CcFJSItBvpoIIKDcV1OcnUnrcfcMgbwi+ks9O6dHxrF4ilIIYKCgXR+wPxAy?=
 =?us-ascii?Q?iLdW96eZCdQHsBzvUUW3KTSK3I6R2VYxA7Dy/+OIaKdb2iLdRzx4g94xreQr?=
 =?us-ascii?Q?TNgQVv2V7x6hRSVpCoerXSSA5dUI9YuczPPQgpfM+IRC4ponlAYWy8q325/6?=
 =?us-ascii?Q?WrXJhl27qrMrNdeSg0lY0pU+FwipmHtdTpJOxT0yIvvEHqFNAJp8/t+fVdxy?=
 =?us-ascii?Q?WG6oP/MJq0h/bVx3lFK2ZdMfl7Qx9SreDcwtECh3e9dGPzLs2ujICJGq+IV0?=
 =?us-ascii?Q?FJ97jhv5uirDrrU=3D?=
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(35950700016)(48200799018)(82310400026)(7093399012)(7416014)(376014)(61400799027)(921020)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:10:46.7976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f40bfa0f-03f2-431a-e511-08dcd35e9b80
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7738

Add auxiliary driver to support Nuvoton Arbel BMC NPCM8XX contains an
integrated clock controller which generates and supplies clocks to all
modules within the BMC.

The NPCM8xx clock controller is created using the auxiliary device
framework and set up in the npcm reset driver since the NPCM8xx clock is
using the same register region.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Tested-by: Benjamin Fair <benjaminfair@google.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/Kconfig       |   8 +
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-npcm8xx.c | 430 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 439 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 983ef4f36d8c..335cd2ede139 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -334,6 +334,14 @@ config COMMON_CLK_LOCHNAGAR
 	  This driver supports the clocking features of the Cirrus Logic
 	  Lochnagar audio development board.
 
+config COMMON_CLK_NPCM8XX
+	tristate "Clock driver for the NPCM8XX SoC Family"
+	depends on ARCH_NPCM || COMPILE_TEST
+	help
+	  This driver supports the clocks on the Nuvoton BMC NPCM8XX SoC Family,
+	  all the clocks are initialized by the bootloader, so this driver
+	  allows only reading of current settings directly from the hardware.
+
 config COMMON_CLK_LOONGSON2
 	bool "Clock driver for Loongson-2 SoC"
 	depends on LOONGARCH || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f793a16cad40..b8367b47d2b8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_ARCH_MILBEAUT_M10V)	+= clk-milbeaut.o
 obj-$(CONFIG_ARCH_MOXART)		+= clk-moxart.o
 obj-$(CONFIG_ARCH_NOMADIK)		+= clk-nomadik.o
 obj-$(CONFIG_ARCH_NPCM7XX)	    	+= clk-npcm7xx.o
+obj-$(CONFIG_COMMON_CLK_NPCM8XX)	+= clk-npcm8xx.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= clk-nspire.o
 obj-$(CONFIG_COMMON_CLK_PALMAS)		+= clk-palmas.o
 obj-$(CONFIG_CLK_LS1028A_PLLDIG)	+= clk-plldig.o
diff --git a/drivers/clk/clk-npcm8xx.c b/drivers/clk/clk-npcm8xx.c
new file mode 100644
index 000000000000..2138c011411d
--- /dev/null
+++ b/drivers/clk/clk-npcm8xx.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Nuvoton NPCM8xx Clock Generator
+ * All the clocks are initialized by the bootloader, so this driver allows only
+ * reading of current settings directly from the hardware.
+ *
+ * Copyright (C) 2020 Nuvoton Technologies
+ * Author: Tomer Maimon <tomer.maimon@nuvoton.com>
+ */
+
+#define pr_fmt(fmt) "npcm8xx_clk: " fmt
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/nuvoton,npcm845-clk.h>
+#include <soc/nuvoton/clock-npcm8xx.h>
+
+/* npcm8xx clock registers*/
+#define NPCM8XX_CLKSEL		0x04
+#define NPCM8XX_CLKDIV1		0x08
+#define NPCM8XX_CLKDIV2		0x2C
+#define NPCM8XX_CLKDIV3		0x58
+#define NPCM8XX_CLKDIV4		0x7C
+#define NPCM8XX_PLLCON0		0x0C
+#define NPCM8XX_PLLCON1		0x10
+#define NPCM8XX_PLLCON2		0x54
+#define NPCM8XX_PLLCONG		0x60
+#define NPCM8XX_THRTL_CNT	0xC0
+
+#define PLLCON_LOKI	BIT(31)
+#define PLLCON_LOKS	BIT(30)
+#define PLLCON_FBDV	GENMASK(27, 16)
+#define PLLCON_OTDV2	GENMASK(15, 13)
+#define PLLCON_PWDEN	BIT(12)
+#define PLLCON_OTDV1	GENMASK(10, 8)
+#define PLLCON_INDV	GENMASK(5, 0)
+
+static void __iomem *clk_base;
+
+struct npcm8xx_clk_pll {
+	void __iomem	*pllcon;
+	unsigned int	id;
+	const char	*name;
+	unsigned long	flags;
+	struct clk_hw	hw;
+};
+
+#define to_npcm8xx_clk_pll(_hw) container_of(_hw, struct npcm8xx_clk_pll, hw)
+
+struct npcm8xx_clk_pll_data {
+	const char *name;
+	struct clk_parent_data parent;
+	unsigned int reg;
+	unsigned long flags;
+	struct clk_hw hw;
+};
+
+struct npcm8xx_clk_div_data {
+	u32 reg;
+	u8 shift;
+	u8 width;
+	const char *name;
+	const struct clk_hw *parent_hw;
+	unsigned long clk_divider_flags;
+	unsigned long flags;
+	int onecell_idx;
+	struct clk_hw hw;
+};
+
+struct npcm8xx_clk_mux_data {
+	u8 shift;
+	u32 mask;
+	const u32 *table;
+	const char *name;
+	const struct clk_parent_data *parent_data;
+	u8 num_parents;
+	unsigned long flags;
+	struct clk_hw hw;
+};
+
+static struct clk_hw hw_pll1_div2, hw_pll2_div2, hw_gfx_div2, hw_pre_clk;
+static struct npcm8xx_clk_pll_data npcm8xx_pll_clks[] = {
+	{ "pll0", { .index = 0 }, NPCM8XX_PLLCON0, 0 },
+	{ "pll1", { .index = 0 }, NPCM8XX_PLLCON1, 0 },
+	{ "pll2", { .index = 0 }, NPCM8XX_PLLCON2, 0 },
+	{ "pll_gfx", { .index = 0 }, NPCM8XX_PLLCONG, 0 },
+};
+
+static const u32 cpuck_mux_table[] = { 0, 1, 2, 7 };
+static const struct clk_parent_data cpuck_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 },
+	{ .hw = &npcm8xx_pll_clks[2].hw }
+};
+
+static const u32 pixcksel_mux_table[] = { 0, 2 };
+static const struct clk_parent_data pixcksel_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[3].hw },
+	{ .index = 0 }
+};
+
+static const u32 default_mux_table[] = { 0, 1, 2, 3 };
+static const struct clk_parent_data default_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 },
+	{ .hw = &hw_pll2_div2 }
+};
+
+static const u32 sucksel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data sucksel_mux_parents[] = {
+	{ .index = 0 },
+	{ .hw = &hw_pll2_div2 }
+};
+
+static const u32 mccksel_mux_table[] = { 0, 2 };
+static const struct clk_parent_data mccksel_mux_parents[] = {
+	{ .hw = &hw_pll1_div2 },
+	{ .index = 0 }
+};
+
+static const u32 clkoutsel_mux_table[] = { 0, 1, 2, 3, 4 };
+static const struct clk_parent_data clkoutsel_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 },
+	{ .hw = &hw_gfx_div2 },
+	{ .hw = &hw_pll2_div2 }
+};
+
+static const u32 gfxmsel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data gfxmsel_mux_parents[] = {
+	{ .index = 0 },
+	{ .hw = &npcm8xx_pll_clks[2].hw }
+};
+
+static const u32 dvcssel_mux_table[] = { 2, 3 };
+static const struct clk_parent_data dvcssel_mux_parents[] = {
+	{ .index = 0 },
+	{ .hw = &npcm8xx_pll_clks[2].hw }
+};
+
+static const u32 default3_mux_table[] = { 0, 1, 2 };
+static const struct clk_parent_data default3_mux_parents[] = {
+	{ .hw = &npcm8xx_pll_clks[0].hw },
+	{ .hw = &npcm8xx_pll_clks[1].hw },
+	{ .index = 0 }
+};
+
+static struct npcm8xx_clk_mux_data npcm8xx_muxes[] = {
+	{ 0, 3, cpuck_mux_table, "cpu_mux", cpuck_mux_parents,
+		ARRAY_SIZE(cpuck_mux_parents), CLK_IS_CRITICAL },
+	{ 4, 2, pixcksel_mux_table, "gfx_pixel_mux", pixcksel_mux_parents,
+		ARRAY_SIZE(pixcksel_mux_parents), 0 },
+	{ 6, 2, default_mux_table, "sd_mux", default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 8, 2, default_mux_table, "uart_mux", default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 10, 2, sucksel_mux_table, "serial_usb_mux", sucksel_mux_parents,
+		ARRAY_SIZE(sucksel_mux_parents), 0 },
+	{ 12, 2, mccksel_mux_table, "mc_mux", mccksel_mux_parents,
+		ARRAY_SIZE(mccksel_mux_parents), 0 },
+	{ 14, 2, default_mux_table, "adc_mux", default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 16, 2, default_mux_table, "gfx_mux", default_mux_parents,
+		ARRAY_SIZE(default_mux_parents), 0 },
+	{ 18, 3, clkoutsel_mux_table, "clkout_mux", clkoutsel_mux_parents,
+		ARRAY_SIZE(clkoutsel_mux_parents), 0 },
+	{ 21, 2, gfxmsel_mux_table, "gfxm_mux", gfxmsel_mux_parents,
+		ARRAY_SIZE(gfxmsel_mux_parents), 0 },
+	{ 23, 2, dvcssel_mux_table, "dvc_mux", dvcssel_mux_parents,
+		ARRAY_SIZE(dvcssel_mux_parents), 0 },
+	{ 25, 2, default3_mux_table, "rg_mux", default3_mux_parents,
+		ARRAY_SIZE(default3_mux_parents), 0 },
+	{ 27, 2, default3_mux_table, "rcp_mux", default3_mux_parents,
+		ARRAY_SIZE(default3_mux_parents), 0 },
+};
+
+/* configurable pre dividers: */
+static struct npcm8xx_clk_div_data npcm8xx_pre_divs[] = {
+	{ NPCM8XX_CLKDIV1, 21, 5, "pre_adc", &npcm8xx_muxes[6].hw, CLK_DIVIDER_READ_ONLY, 0, -1 },
+	{ NPCM8XX_CLKDIV1, 26, 2, "ahb", &hw_pre_clk, CLK_DIVIDER_READ_ONLY, CLK_IS_CRITICAL, NPCM8XX_CLK_AHB },
+};
+
+/* configurable dividers: */
+static struct npcm8xx_clk_div_data npcm8xx_divs[] = {
+	{ NPCM8XX_CLKDIV1, 28, 3, "adc", &npcm8xx_pre_divs[0].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_ADC },
+	{ NPCM8XX_CLKDIV1, 16, 5, "uart", &npcm8xx_muxes[3].hw, 0, 0, NPCM8XX_CLK_UART },
+	{ NPCM8XX_CLKDIV1, 11, 5, "mmc", &npcm8xx_muxes[2].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_MMC },
+	{ NPCM8XX_CLKDIV1, 6, 5, "spi3", &npcm8xx_pre_divs[1].hw, 0, 0, NPCM8XX_CLK_SPI3 },
+	{ NPCM8XX_CLKDIV1, 2, 4, "pci", &npcm8xx_muxes[7].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_PCI },
+
+	{ NPCM8XX_CLKDIV2, 30, 2, "apb4", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB4 },
+	{ NPCM8XX_CLKDIV2, 28, 2, "apb3", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB3 },
+	{ NPCM8XX_CLKDIV2, 26, 2, "apb2", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB2 },
+	{ NPCM8XX_CLKDIV2, 24, 2, "apb1", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB1 },
+	{ NPCM8XX_CLKDIV2, 22, 2, "apb5", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_APB5 },
+	{ NPCM8XX_CLKDIV2, 16, 5, "clkout", &npcm8xx_muxes[8].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_CLKOUT },
+	{ NPCM8XX_CLKDIV2, 13, 3, "gfx", &npcm8xx_muxes[7].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_GFX },
+	{ NPCM8XX_CLKDIV2, 8, 5, "usb_bridge", &npcm8xx_muxes[4].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU },
+	{ NPCM8XX_CLKDIV2, 4, 4, "usb_host", &npcm8xx_muxes[4].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SU48 },
+	{ NPCM8XX_CLKDIV2, 0, 4, "sdhc", &npcm8xx_muxes[2].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SDHC },
+
+	{ NPCM8XX_CLKDIV3, 16, 8, "spi1", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI1 },
+	{ NPCM8XX_CLKDIV3, 11, 5, "uart2", &npcm8xx_muxes[3].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_UART2 },
+	{ NPCM8XX_CLKDIV3, 6, 5, "spi0", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPI0 },
+	{ NPCM8XX_CLKDIV3, 1, 5, "spix", &npcm8xx_pre_divs[1].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_SPIX },
+
+	{ NPCM8XX_CLKDIV4, 28, 4, "rg", &npcm8xx_muxes[11].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RG },
+	{ NPCM8XX_CLKDIV4, 12, 4, "rcp", &npcm8xx_muxes[12].hw, CLK_DIVIDER_READ_ONLY, 0, NPCM8XX_CLK_RCP },
+
+	{ NPCM8XX_THRTL_CNT, 0, 2, "th", &npcm8xx_muxes[0].hw, CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_POWER_OF_TWO, 0, NPCM8XX_CLK_TH },
+};
+
+static unsigned long npcm8xx_clk_pll_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct npcm8xx_clk_pll *pll = to_npcm8xx_clk_pll(hw);
+	unsigned long fbdv, indv, otdv1, otdv2;
+	unsigned int val;
+	u64 ret;
+
+	if (parent_rate == 0) {
+		pr_debug("%s: parent rate is zero\n", __func__);
+		return 0;
+	}
+
+	val = readl_relaxed(pll->pllcon);
+
+	indv = FIELD_GET(PLLCON_INDV, val);
+	fbdv = FIELD_GET(PLLCON_FBDV, val);
+	otdv1 = FIELD_GET(PLLCON_OTDV1, val);
+	otdv2 = FIELD_GET(PLLCON_OTDV2, val);
+
+	ret = (u64)parent_rate * fbdv;
+	do_div(ret, indv * otdv1 * otdv2);
+
+	return ret;
+}
+
+static const struct clk_ops npcm8xx_clk_pll_ops = {
+	.recalc_rate = npcm8xx_clk_pll_recalc_rate,
+};
+
+static struct clk_hw *
+npcm8xx_clk_register_pll(struct device *dev, void __iomem *pllcon,
+			 const char *name, const struct clk_parent_data *parent,
+			 unsigned long flags)
+{
+	struct npcm8xx_clk_pll *pll;
+	struct clk_init_data init = {};
+	int ret;
+
+	pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &npcm8xx_clk_pll_ops;
+	init.parent_data = parent;
+	init.num_parents = 1;
+	init.flags = flags;
+
+	pll->pllcon = pllcon;
+	pll->hw.init = &init;
+
+	ret = devm_clk_hw_register(dev, &pll->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &pll->hw;
+}
+
+static DEFINE_SPINLOCK(npcm8xx_clk_lock);
+
+static int npcm8xx_clk_probe(struct auxiliary_device *adev,
+			     const struct auxiliary_device_id *id)
+{
+	struct npcm_clock_adev *rdev = to_npcm_clock_adev(adev);
+	struct clk_hw_onecell_data *npcm8xx_clk_data;
+	struct device *dev = &adev->dev;
+	struct clk_hw *hw;
+	unsigned int i;
+
+	npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
+							 NPCM8XX_NUM_CLOCKS),
+					GFP_KERNEL);
+	if (!npcm8xx_clk_data)
+		return -ENOMEM;
+
+	clk_base = rdev->base;
+
+	npcm8xx_clk_data->num = NPCM8XX_NUM_CLOCKS;
+
+	for (i = 0; i < NPCM8XX_NUM_CLOCKS; i++)
+		npcm8xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	/* Register plls */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_pll_clks); i++) {
+		struct npcm8xx_clk_pll_data *pll_clk = &npcm8xx_pll_clks[i];
+
+		hw = npcm8xx_clk_register_pll(dev, clk_base + pll_clk->reg,
+					      pll_clk->name, &pll_clk->parent,
+					      pll_clk->flags);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register pll\n");
+		pll_clk->hw = *hw;
+	}
+
+	/* Register fixed dividers */
+	hw = devm_clk_hw_register_fixed_factor(dev, "pll1_div2", "pll1", 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register fixed div\n");
+	hw_pll1_div2 = *hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, "pll2_div2", "pll2", 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register pll2 div2\n");
+	hw_pll2_div2 = *hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, "pll_gfx_div2", "pll_gfx", 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register gfx div2\n");
+	hw_gfx_div2 = *hw;
+
+	/* Register muxes */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
+		struct npcm8xx_clk_mux_data *mux_data = &npcm8xx_muxes[i];
+
+		hw = devm_clk_hw_register_mux_parent_data_table(dev,
+								mux_data->name,
+								mux_data->parent_data,
+								mux_data->num_parents,
+								mux_data->flags,
+								clk_base + NPCM8XX_CLKSEL,
+								mux_data->shift,
+								mux_data->mask,
+								0,
+								mux_data->table,
+								&npcm8xx_clk_lock);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register mux\n");
+		mux_data->hw = *hw;
+	}
+
+	hw = devm_clk_hw_register_fixed_factor(dev, "pre_clk", "cpu_mux", 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register pre clk div2\n");
+	hw_pre_clk = *hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, "axi", "th", 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register axi div2\n");
+	npcm8xx_clk_data->hws[NPCM8XX_CLK_AXI] = hw;
+
+	hw = devm_clk_hw_register_fixed_factor(dev, "atb", "axi", 0, 1, 2);
+	if (IS_ERR(hw))
+		return dev_err_probe(dev, PTR_ERR(hw), "Can't register atb div2\n");
+	npcm8xx_clk_data->hws[NPCM8XX_CLK_ATB] = hw;
+
+	/* Register pre dividers */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_pre_divs); i++) {
+		struct npcm8xx_clk_div_data *div_data = &npcm8xx_pre_divs[i];
+
+		hw = devm_clk_hw_register_divider_parent_hw(dev, div_data->name,
+							    div_data->parent_hw,
+							    div_data->flags,
+							    clk_base + div_data->reg,
+							    div_data->shift,
+							    div_data->width,
+							    div_data->clk_divider_flags,
+							    &npcm8xx_clk_lock);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register pre div\n");
+		div_data->hw = *hw;
+
+		if (div_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
+	}
+
+	/* Register dividers */
+	for (i = 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
+		struct npcm8xx_clk_div_data *div_data = &npcm8xx_divs[i];
+
+		hw = devm_clk_hw_register_divider_parent_hw(dev, div_data->name,
+							    div_data->parent_hw,
+							    div_data->flags,
+							    clk_base + div_data->reg,
+							    div_data->shift,
+							    div_data->width,
+							    div_data->clk_divider_flags,
+							    &npcm8xx_clk_lock);
+		if (IS_ERR(hw))
+			return dev_err_probe(dev, PTR_ERR(hw), "Can't register div\n");
+
+		if (div_data->onecell_idx >= 0)
+			npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
+	}
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  npcm8xx_clk_data);
+}
+
+static const struct auxiliary_device_id npcm8xx_clock_ids[] = {
+	{
+		.name = "reset_npcm.clk-npcm8xx",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(auxiliary, npcm8xx_clock_ids);
+
+static struct auxiliary_driver npcm8xx_clock_driver = {
+	.probe		= npcm8xx_clk_probe,
+	.id_table	= npcm8xx_clock_ids,
+};
+module_auxiliary_driver(npcm8xx_clock_driver);
+
+MODULE_DESCRIPTION("Clock driver for Nuvoton NPCM8XX BMC SoC");
+MODULE_AUTHOR("Tomer Maimon <tomer.maimon@nuvoton.com>");
+MODULE_LICENSE("GPL v2");
+
-- 
2.34.1


