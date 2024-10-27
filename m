Return-Path: <linux-kernel+bounces-383562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B065B9B1D5D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 12:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DA71C20974
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3238D14B941;
	Sun, 27 Oct 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RJd+tBlr"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC491422AB
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730028443; cv=fail; b=iQupxHsQfzuSazcmAKtUsbgZZezTLmdipudrVdA8N4TlD2LH/INOHjHiZ3afwp+RXhj//6VFcMN8kMexkcZ0VnwhNiH+63cOkUAcWilEASoqRElUn2NOPy3efZ5qu5SmCSuoyxShkJ8ogq/wbYscubq9Pp/Lxy8bRyRzW7DmJGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730028443; c=relaxed/simple;
	bh=Y4Qn3Nd6qit4G4mx4CyHFcxkjO6438SfDODGa3v1PSM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mouNjPto8rFvgWPT2A87CJB0njHV/8bMcJh4nyfguVs5M0EQ31wNL9Nc4yyZ0WfY3MzhdSDXOYcc1zqf5r62UebaPlZVOR/meoUYROHZ6UrGc+6Lv/KkazevRb1Uim7v6PUGh/D7puoJRPF52/s97LKdjj/Zmy70h+PP7Eswiow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=RJd+tBlr; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZgmHvJIsvrOrfWL88En+9dlxa0ia1/oZJzpaKKxmo/EMmTPw/0u66PvW1uPbutEXlNszmWFe6TVF7HJ3UZhoPJAx9Cy78Aic8e2T6tTfZP4kHLSfb98gas97Wc+V7qZwrXChXBlEiiVLZ8/2pxQeV77046FDC5P1yVQCShq8LP/rR8UFQu9+W56x/Gww05ApDi6tmTy24NYZOCtuB3wEeUmw9JQvxiVF/f2d6vRW7HnWf2a2ODjQLNW1Nr558y/gdf0qrYVLtQkKEi6PYAX+ie+JMzZKuk9m/BcykowU6Ol/WK22cd2RcHiDKu4yBRb0mThv6irA7+A/Vwx4RMobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQYxqCNqjgBgoADfol0s8i3WZwblUUwlEvY2lkYP0+o=;
 b=S9Hbz8daV4rgfOzsVOuyT9qCmuITNx2eNFy5HzNONk71VVbMvRXBNr8tJifHfuKR7FEmqPO3qxwP/GYy1/sskT6biz+onwBfXG3L/16FjatnqjWTPZeKO80LKkUzd1rYrjBh90dJxi3IVo4UD/57s8hpT/qBZ76Upo4NP8bNYtDI+UffqXOkI38CVkj74UMM//ZHcto1VK47WMPc6fiXDkznV8rw/fA/T3+Lz7gf9e7zTkYZA8CsqDGYEx7bvCEq0uHOheQegjtTyum8wQJ9YoLBP4rgJDR0NEBuffhDw5wW7L2F2xvfvWNQpUbRLTAMIs2Tq8GJ+U954XmlCwNtvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQYxqCNqjgBgoADfol0s8i3WZwblUUwlEvY2lkYP0+o=;
 b=RJd+tBlr4Gxh9dmaYYA5oUTb6h5dXRHL02g43Cem5i/gNcbAhu9xHf8BzJSxKLIn/buMGaQur/2WYRqXUu5iveTP6ZNoCa/DzDF4gl9wrC78/K5B1RsCLsbwIStwsN1la/yCKAq20tLyw/Vld+ihy4wE2akyjJmCScZrRXy/mUOTKwPf6QYhsCKU0hG/mW7eOBmAciHJ2ueo4wwN3iIk4GKyZplobPzNaQYd4/fo4MQqHzzoje6bGcqCvYayaCjJZsycUHX9mXOkT6Zrit5N8GjwA/buuXaA2o8eBnmY5bKUm9pbQ+xU8/D3kjNZ3O1krvL+xa4zXayn/YfjWIF2hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8470.eurprd04.prod.outlook.com (2603:10a6:20b:415::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Sun, 27 Oct
 2024 11:27:16 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8093.021; Sun, 27 Oct 2024
 11:27:16 +0000
From: alice.guo@oss.nxp.com
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"alice.guo" <alice.guo@nxp.com>
Subject: [PATCH v1] soc: imx: Add SoC device register for i.MX9
Date: Sun, 27 Oct 2024 19:25:57 +0800
Message-Id: <20241027112557.3866257-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:3:17::33) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d40c47-cf74-4857-349e-08dcf67a4f6e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v8oy6HP4bF6C6aUeqk25ICTuCwk9VRB9zjVv2j2OAxJIqteA5INSWDB01YdC?=
 =?us-ascii?Q?fDT43AN84Sr6JEPhpinAzLffSpY1YfVLCMlFlqe2KsYbeo1E2XsDFGYbFlaS?=
 =?us-ascii?Q?LT2eRRP3vUKZyy6tvHZFnnV0Pz+9U6Fsza3MK8vnLbdDohKvK7Cg1DVAYI0j?=
 =?us-ascii?Q?NxOMmStzgW+wl3TiIq0RNOjaIbBl4QW52ywXRoTmuyAe7rkvc5TON+MjwUBf?=
 =?us-ascii?Q?Ay1cEcni6OCxovLYjRiFyX7OewQsmIi3YQdj+7eqvG/jysjhFcSKSTeTXPOY?=
 =?us-ascii?Q?oNtJ37llcHpw2MMMpmfacENrS6ngvHteBTiWAYdPgwF1AhQhaRahMYzLTDTx?=
 =?us-ascii?Q?/u6Jf8YtUW0ISs1kI9GKM/ku4kPq+BLTgglQiyhp3VC4Q0pm49jMnGi6K2t3?=
 =?us-ascii?Q?fe0Bsms4iKGKcXobwN5VdQa70mIgXt6EOGd5xgqf8PIWs1Bu+tjlOzoqkxrK?=
 =?us-ascii?Q?sefQFvCkZkFA+QvhKETHybNaeeadqOcjtmmM7x6IVbJdhmRolgYXQ8g9vbc7?=
 =?us-ascii?Q?DT2LijA9krFTc/G7tdEXSLUeelYICj+TMDqixQW6HjJEQSkRgPaGMBG/79UA?=
 =?us-ascii?Q?VHozTEfLYdxO/2xdd4iELbsVEdqQmRLxhZu02YuWuWhX46Y7N0hlaC8HyZX/?=
 =?us-ascii?Q?YlqrLHidIPltFWYVWaTOg3El/Pq11zsE/vht7FDJnxKAtfgiRFpDbEJlzI7I?=
 =?us-ascii?Q?yrUxDyXb+1gGZQaQNMrvkIM2w6QypYyZJGTJ+0PBfE1F/3ZX5immVCWu+bXe?=
 =?us-ascii?Q?kcKbxiHwMGvLYGy/kCr/eaQ7+wGMiMbpmmypUNkiCi46bfeKLTFp1d1I8S/r?=
 =?us-ascii?Q?+VELV0phQhIzAaJIDJXb8/76Aukp11KwQxJRIhgLdHFLP/Ux/UHLRYewX2JQ?=
 =?us-ascii?Q?ReChDk4FJlq98lEmRw1fqhNn+LCig+0K2Z2X+Dw7VB94fhEI9wYmLpvfdAek?=
 =?us-ascii?Q?LXbuKNEuSXcCNn+nr3668einYM4F0nyiziVjJgG+N8uvnUDMzcAY6BL3wkbm?=
 =?us-ascii?Q?J1CLAl/C7ck/NeBAwxPE6z4EPDLArNh92YGyUz+xW1PI9iMab406widYq5Q7?=
 =?us-ascii?Q?0F0H0wLKJY4MmR9CmQUYcEILUaILXZ+F0iydfoF1/duhEn1lnoksFhhXoioZ?=
 =?us-ascii?Q?A59Vlce2I+QCm3mtEetTFc7kla2u0YB4+CokszpLq5la/XENjBnm89/M693R?=
 =?us-ascii?Q?XkgUtzh3XzsiWI/mCyjaQLlliZGM5OpfIwa4Z6Nb1RcOeFI26BxbHImAepzR?=
 =?us-ascii?Q?b5Q+2Oi2hC/jJjFhZBU7PsLN7eeGIKjEF5KzhOtH/oW83ECEj242PQdq7VBg?=
 =?us-ascii?Q?KRHu1/l9+7BjRRvENSo2y1NlC7we+Se8H9o0VI3HuE1EIkz8CaKCTXv1Bf9F?=
 =?us-ascii?Q?kqFZuDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LuMivvl7zcBY9dHzu5c7LfkwXgRnfEyZ9cZw0KLRY6dt6HtE4SswqD/iZVgH?=
 =?us-ascii?Q?Isw2ou8ZnCpMHzpmFDYizcVmxqPnsqH4Vr6ofsSAKXwU+CfBCmaeSm8i7FJK?=
 =?us-ascii?Q?LEaZPotU59GTwspnbZ5tKfTDCsFpgavL74GfNjdEgF8oDtmE04uWVfmP2WsJ?=
 =?us-ascii?Q?t6R6ODp2SqLd6c04jHWQtDBjf1kWRyD4flMfIQde4StgSSwX1boRBJ7wF4Fj?=
 =?us-ascii?Q?DL+cFIjb9bKZqLK1GyO57hyjcqFruDdreQp3d8VTPCg6k17bFcVLdF8aZ2zG?=
 =?us-ascii?Q?O67CpgwYAHRdDX+qFzAUvP4wcCUfeIrTwZH2kbDW5hTiRWJaLONoRTzkiWG2?=
 =?us-ascii?Q?0kwAH+K0h6di60oo58KfqpieQNtIj40LBPnlRxfNuNds6b4jDfLzfb8r3oZN?=
 =?us-ascii?Q?ziTmoD1PZBPMIPoh2gUEcjqzQkjXvh63O1UlDgTYkFWbcJtdMk5bt6RC2CpL?=
 =?us-ascii?Q?o23GWtl7bgdikWm40uyXFt1v0POcLu/ZEVJVy8n4QQ4LPdkX+WkrBp8rmOBM?=
 =?us-ascii?Q?lZeVddHiJFprV1YkepM1/yMDwfV8/L/RL3PCoEThRHcM7JQ4riFeDVMXsC5q?=
 =?us-ascii?Q?JQdah0mVFoapGHuSV38RdgsqtI0csLlOtbo4a8Jnm7YqNYk8jCcHjM0YkyEn?=
 =?us-ascii?Q?2x+QGkSOrPQwt/c4kHUKluVTd5omuAOKx7BNPhq3r+o48mNrXOt6Adb2uNLn?=
 =?us-ascii?Q?zUzS+l+dE/ea/JRQLODgnH/xeNHtLmPV105gXvavW9grJkEV84zeyS+brJlI?=
 =?us-ascii?Q?OFP7fGq6qJQXdTj3hH6tjgo/qKdnHnk5jtyCTSkREu1tPhZwkYHvIJ/XTM5w?=
 =?us-ascii?Q?UM6MLwDHQPWhLJyN+XloMODaMa9d+xGEIlWqVIRtvAdOFj4Brp8s9ArcXdan?=
 =?us-ascii?Q?752Y6/p1l0w+7FgDJx4MCo/WiZePQxdeu7O4SSkZLg1c9sRLxJZj2ZOpuhej?=
 =?us-ascii?Q?vhI3liq96YsF+tH5o13aCLYWqQxseBDz+Jb3hphFNcba9ryZ90z9yxiQ4F/x?=
 =?us-ascii?Q?wnFm+oh6wH4JlrvrPTqaue+bL+ZXi5klz1W9aApg1YOn4aZ9QoOEZJI9Ct9D?=
 =?us-ascii?Q?PLhF4tuBm3yvbxaBybVhUX+irdEvIrI4QWJZy1DhY2SHHK6rthlukfZJqu8f?=
 =?us-ascii?Q?Mk0riLo9EPrl/WnY2EncL9kDZGgzMvZhhiuoPCldNYbGx7s5uPfyyL+aMfMF?=
 =?us-ascii?Q?6MvNTPj+DyjK6WMaMdV/ci8k8f0nm+x7o/DnktLcWtnzPVUt5qCcFGcBrAhm?=
 =?us-ascii?Q?wlHnGYFpddCSQ9FBx1Co3QRFvqXFLi14ztYtM+YWKBaWdeS6aUCOe7oMUwei?=
 =?us-ascii?Q?oMnpYsZlJaOSuy4okWhysID9gcfmNhab2kbzWVYNzmh9LEUWhWsCYO72/74s?=
 =?us-ascii?Q?LPQ7v0dyjh0eqOM8251anViXLJvSoWVxuqwhyfjJJnCX+jC1jFGZOjMn1xBd?=
 =?us-ascii?Q?/fCWxLX0qympHf4S97ff4YFyUydiIP1QQrVQJPsJwxhXMgLeIOdMIiAb3b2x?=
 =?us-ascii?Q?lmQPR1Q9uem1ppqYG/AyJJBYpvn73bv7qFSc8NGjvCXTZWcirBuCRbZiy/y9?=
 =?us-ascii?Q?r6veTC+s1aw2Cfq2gXocJO14KSBx6VHiKadWovp+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d40c47-cf74-4857-349e-08dcf67a4f6e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2024 11:27:16.1514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AiGo5F7pru/F3oIVF2LIwCJ5gyB9RQ7kDIMY8eHu2s2rRTFgg+4XUS0oipidKbBLJfRdDXsMkZd44w6n4j527Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8470

From: "alice.guo" <alice.guo@nxp.com>

i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
which are provided by the corresponding ARM trusted firmware API. This
patch intends to use SMC call to obtain these information and then
register i.MX9 SoC as a device.

Signed-off-by: alice.guo <alice.guo@nxp.com>
---
 drivers/soc/imx/Makefile   |   2 +-
 drivers/soc/imx/soc-imx9.c | 102 +++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/imx/soc-imx9.c

diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 3ad321ca608a..ca6a5fa1618f 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -3,4 +3,4 @@ ifeq ($(CONFIG_ARM),y)
 obj-$(CONFIG_ARCH_MXC) += soc-imx.o
 endif
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
-obj-$(CONFIG_SOC_IMX9) += imx93-src.o
+obj-$(CONFIG_SOC_IMX9) += imx93-src.o soc-imx9.o
diff --git a/drivers/soc/imx/soc-imx9.c b/drivers/soc/imx/soc-imx9.c
new file mode 100644
index 000000000000..7e8a8b2efa61
--- /dev/null
+++ b/drivers/soc/imx/soc-imx9.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define IMX_SIP_GET_SOC_INFO	0xc2000006
+#define SOC_ID(x)		(((x) & 0xFFFF) >> 8)
+#define SOC_REV_MAJOR(x)	((((x) >> 28) & 0xF) - 0x9)
+#define SOC_REV_MINOR(x)	(((x) >> 24) & 0xF)
+
+static int imx9_soc_device_register(void)
+{
+	struct soc_device_attribute *attr;
+	struct arm_smccc_res res;
+	struct soc_device *sdev;
+	u32 soc_id, rev_major, rev_minor;
+	u64 uid127_64, uid63_0;
+	int err;
+
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	err = of_property_read_string(of_root, "model", &attr->machine);
+	if (err) {
+		err = -EINVAL;
+		goto attr;
+	}
+
+	attr->family = kasprintf(GFP_KERNEL, "Freescale i.MX");
+
+	/*
+	 * Retrieve the soc id, rev & uid info:
+	 * res.a1[31:16]: soc revision;
+	 * res.a1[15:0]: soc id;
+	 * res.a2: uid[127:64];
+	 * res.a3: uid[63:0];
+	 */
+	arm_smccc_smc(IMX_SIP_GET_SOC_INFO, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != SMCCC_RET_SUCCESS) {
+		err = -EINVAL;
+		goto family;
+	}
+
+	soc_id = SOC_ID(res.a1);
+	rev_major = SOC_REV_MAJOR(res.a1);
+	rev_minor = SOC_REV_MINOR(res.a1);
+
+	attr->soc_id = kasprintf(GFP_KERNEL, "i.MX%2x", soc_id);
+	attr->revision = kasprintf(GFP_KERNEL, "%d.%d", rev_major, rev_minor);
+
+	uid127_64 = res.a2;
+	uid63_0 = res.a3;
+	attr->serial_number = kasprintf(GFP_KERNEL, "%016llx%016llx", uid127_64, uid63_0);
+
+	sdev = soc_device_register(attr);
+	if (IS_ERR(sdev)) {
+		err = -ENODEV;
+		goto soc_id;
+	}
+
+	return 0;
+
+soc_id:
+	kfree(attr->soc_id);
+	kfree(attr->serial_number);
+	kfree(attr->revision);
+family:
+	kfree(attr->family);
+attr:
+	kfree(attr);
+	return err;
+}
+
+static int __init imx9_soc_init(void)
+{
+	int ret = 0;
+
+	if (of_machine_is_compatible("fsl,imx91") ||
+		of_machine_is_compatible("fsl,imx93") ||
+		of_machine_is_compatible("fsl,imx95")) {
+		ret = imx9_soc_device_register();
+		if (ret) {
+			pr_err("%s: imx9_soc_device_register returned %d\n", __func__, ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+device_initcall(imx9_soc_init);
+
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("NXP i.MX9 SoC");
+MODULE_LICENSE("GPL");
-- 
2.34.1


