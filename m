Return-Path: <linux-kernel+bounces-175304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AA88C1DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBF7B22058
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743CC1527BE;
	Fri, 10 May 2024 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="Etn+Ermi"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01rlnn2054.outbound.protection.outlook.com [40.95.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9ACA6F;
	Fri, 10 May 2024 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.95.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715320664; cv=fail; b=i+2Pmzrq7Yx/ifyIgBl2fasl6PV0XLP9YPRv6taq03QAsNE0n3mdcUo3haUG5tdfyCLcGHdtq5nwO7fQ+VqHMUcSQR6VwRxg962QRXcE2hn6qovngsG5oH84izDFsUiNzLWKPBjOXPWD0JFzHNhzgtg0LeFPS6ebIOqouKZTtbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715320664; c=relaxed/simple;
	bh=iv6UGE6j6jk+1FO9Ss8y/ZFF+eU35vcIHyMBxlCIcSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fupBexhdpsWLwj0Fe32ubPuo1FWjlGDBZOGVVNpX3cb2qfvrOKwocSg07ctvQsScy6LoI7eR8DcRIOiesMp86AQmvxOufO/hYpMRKDnmFeHmXozkiaJqLT3XEhVRlP5hDJz5LIMQT4Nrt3xaU9t/7FizTDq5G+VOadC2H7SE++w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=taln60.nuvoton.co.il; dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b=Etn+Ermi; arc=fail smtp.client-ip=40.95.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFv0Mgr7K5UQKJdhyusUGgQ3uuQoF1Cuh8e9TtI4r29RjM9O7M3Iv6ZyRpL2NGymBoTonA/jOnx8NV3ckk0tP/Fu8I4eh7eb7R4CsGIDxgfTYG9JNT93i+/pTZgXLVi6cD0f6hrm40Jx11WCZ1J5AYC/dMGS/WYmaXkkjzMtGp5s1TKBjXsdhM5SXRuwcwN5t3Ao/LXi078tLKJbc563frWKm7hS92nY7MI4zokuNIe6cYwSSLXWLg62Uih2BYDZ/cfOJt0/Igxo5jGjpAaP0u91GrzUUZoJ4LrdtSLzBszxIA/ordxJVwombEVhhXFqk3Zi9xa0VGK6q5UxkGHLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNqO4ACGampLf2RuTRfI2Uld0X9gooK+fAr7OJuuJ04=;
 b=JBy3/EHffJJEImV15rGSKOG/gv9yyZ7kI/ueSDxGHZdkVjdaZsyX3oMbC0Yx8d+SDS4iQrElb4MghB65INFfE5C34+ClPm9LriaQXDLD/V/ZV8f4l7uqpvgTytDGTKXbqoY6oDIzrGSqzZ2L+ij133AhLu1dAW71/CrY61Rj4bExIPN7o7uhtBuQ2rMY1WlkBhPawdvmOSkMWysLpB7WSGZ1JxCN2n0nAPNyHpUz6t307NRFgwfX5hTS0Eu64rmQzD76VIqrTQ+BB7JKo9dm8EoIdmvc1emBm0dE4BXOcSaGlTaB235P01OhGG9eA1w7+vb8HjFJvaaEfDhqsp9kyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 175.98.123.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNqO4ACGampLf2RuTRfI2Uld0X9gooK+fAr7OJuuJ04=;
 b=Etn+ErmiY7IC1TBus7oEr4wpqu9Gg1eP+YKN4A9ciMpCJXICuu0yEOMdFk/0cxZXSbPrb9xtI6yXHocj6DDrT6NKk+B7YO5O5KeamfyC9ju3DOXWReVDvlOXD5ne8n82hpA8vzBYq5mCWLwko4puqYOLyJ8JI1didFl8xPHcZHo=
Received: from SI2P153CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::20) by
 KL1PR03MB8288.apcprd03.prod.outlook.com (2603:1096:820:114::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.15; Thu, 9 May 2024 19:24:18 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:140:cafe::52) by SI2P153CA0003.outlook.office365.com
 (2603:1096:4:140::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.9 via Frontend
 Transport; Thu, 9 May 2024 19:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 175.98.123.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 19:24:17 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 10 May
 2024 03:24:14 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 10 May 2024 03:24:14 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id D48D55F66B;
	Thu,  9 May 2024 22:24:13 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id D27B2DC0BCE; Thu,  9 May 2024 22:24:13 +0300 (IDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <p.zabel@pengutronix.de>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
	<yuenn@google.com>, <benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v24 3/4] clk: npcm8xx: add clock controller
Date: Thu, 9 May 2024 22:24:10 +0300
Message-ID: <20240509192411.2432066-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509192411.2432066-1-tmaimon77@gmail.com>
References: <20240509192411.2432066-1-tmaimon77@gmail.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|KL1PR03MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 114971cb-f3db-4591-b9cc-08dc705d9eda
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|35950700004|7416005|61400799018|48200799009|82310400017|7093399003|921011|35450700002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?It+53YZpR0UqLWiQMpWjoP4LfoZycnY4Z39ZuSHAi4XftjIZKpBG1Hd/loun?=
 =?us-ascii?Q?/iA8QmQ3YpYuNr+uQT61+dOAhWHCkXD0fImI850Y1tZA8wYV6K5gH7nkTok4?=
 =?us-ascii?Q?PhJnAa176Uw1FrekTKWjvVsIx+/j7lWh7JxsXBGeHtq6r11eKRIK+Ii+yiul?=
 =?us-ascii?Q?Lhho9RcIxkuzPYLjjDgCTqHtbiMsDPD5yYG/ttliEQenAIOOReHiy7hqkMoj?=
 =?us-ascii?Q?1WcsIk+qFSC/Py0x+T8GZuP5qkwdu0pU0+ralYscanfBqU4WtopwsRAZtFs/?=
 =?us-ascii?Q?4VsXbm87soNR4A9O44AP9SvuTAZ6uhB2yU0BAeRzqtcLxWFFXwCm3bPLLC1f?=
 =?us-ascii?Q?lCxmOGEcpV2pLRA1HaywmEp6vQkm8Ca2Ic4x9oVj33isFudR9aqbWJYbAQBF?=
 =?us-ascii?Q?QlO9N+x0dZK2kmut9zukctmSQQ5AF9tgu4vWoQGxO7NUD6tEo/d1m4Qo5XZk?=
 =?us-ascii?Q?4tsE/sYFCgxEhfCv1coEL5a2XGBsMFNxXjs8mz7STCub/bIx6pyTAPE4KvXQ?=
 =?us-ascii?Q?G00QZ5J/bH0kfM5Wtu2ogIK/411NmKu/DiRp9K7RWqZWPhjxXXOVeWAgRNdn?=
 =?us-ascii?Q?JN/40eb9FUg9ODllqCiPWrvVbzhNMUrUBF3IpwwhbeWArz++ATqmMS71O16H?=
 =?us-ascii?Q?0JwmeW90cL0aRcKZ4fu2/Q1YRcq1r/6opdQahXm8xTOxDcgQZzzO5S0PLjhL?=
 =?us-ascii?Q?znbSIDBNTpjxmIzn7pVGNZlbEsF5OMfgnhuG8AkQ20z8NwSXYaVl5QRVTMrO?=
 =?us-ascii?Q?dNIfyIanV+VxX0bIx+lqaQyMWhbsFDt+FzRwg9SUp4NGSfQ6H0b9ZlNgs8m6?=
 =?us-ascii?Q?J1p5PJCi3jk26oZTjZIaVC6zrNYY4M9SjAHIRYLl8s7xmUq+5TT7hdRQJtO6?=
 =?us-ascii?Q?hLq1cdoBeprGGWEVfIFLTrya2Ary8bKtuad7FRXD5il8uDaRUdrwDClNFbL3?=
 =?us-ascii?Q?+T1tJ/8hidJ5cdC+oHymsg0U2BOFUNNzAfgpPomJ+YNADZrQUjAZ9uHAr/oX?=
 =?us-ascii?Q?kis4bNvaaCR4pbJAOW07qiaRlP7uzjdXMpQC1JBw3gPfHyNfgzHXxfC98xDZ?=
 =?us-ascii?Q?MX7CEhQZVdp6NSOExUJzWrQznMu5Uec4vr50yhJmiQksH8iCdTcZ/xhpMTJs?=
 =?us-ascii?Q?i3UeQfvQjQnwSv0r6+W+sBJ5gRT85nXC+Dt7D9N5ydzYEc6ghY9QZ8eWrJUT?=
 =?us-ascii?Q?zRA3wtldEW409jKYjoaxdsQXrk0RSeRUufhl/KbPlwtKi7hMwPAvEgZI+yqz?=
 =?us-ascii?Q?sdYeedcYlrhaVYIUWB1K/srjPOS+gip1bfblHPJMELL27GNQRFSWBQdmIcam?=
 =?us-ascii?Q?vXQCV6Hy8LiQRa/MOs9JAQtlkT+3sO9DLoTOZU9VFoBWDwIRm0bX/+71YiUZ?=
 =?us-ascii?Q?Ngd/LYff570ZokTMm0gYuPDKHg2r7Y1ghTD2N3Fq+iM200m5GThL+z++vxtc?=
 =?us-ascii?Q?kXTmG5gmw2hoM+vMuBSDiFhMwNDfaNXi?=
X-Forefront-Antispam-Report:
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(376005)(35950700004)(7416005)(61400799018)(48200799009)(82310400017)(7093399003)(921011)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 19:24:17.8234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 114971cb-f3db-4591-b9cc-08dc705d9eda
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8288

Add auxiliary driver to support Nuvoton Arbel BMC NPCM8XX contains an
integrated clock controller which generates and supplies clocks to all
modules within the BMC.

The NPCM8xx clock controller is created using the auxiliary device framework
and set up in the npcm reset driver since the NPCM8xx clock is using the
same register region.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Acked-by: Joel Stanley <joel@jms.id.au>
---
 drivers/clk/Kconfig       |   8 +
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-npcm8xx.c | 429 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 438 insertions(+)
 create mode 100644 drivers/clk/clk-npcm8xx.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 50af5fc7f570..a324678f3e12 100644
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
index 14fa8d4ecc1f..584fc82061f8 100644
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
index 000000000000..979877c6b14c
--- /dev/null
+++ b/drivers/clk/clk-npcm8xx.c
@@ -0,0 +1,429 @@
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


