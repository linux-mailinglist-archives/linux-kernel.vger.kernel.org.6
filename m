Return-Path: <linux-kernel+bounces-403543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 967B99C3703
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282A21F22390
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22A82C18C;
	Mon, 11 Nov 2024 03:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wqAyjgv9"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E523417BCE
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731295474; cv=fail; b=hRaL7WtuQ5tvjGUOhyIlo/SCkFhAKP0pH4Wo3Cd1OxOK6G3Iu3vaA9/+WI4tTvLOCL1eBy4FDAn4qMilWh1O/VXVPHNJAe35MKlfAAxx/xRou10K7kc2iL+aI8pKfUzwvUuq7QKuUhx5IBciqBWx2MfJOgeBWvHhbOmEZXssF34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731295474; c=relaxed/simple;
	bh=KqVJA59h+Ytoiv9s8KnQ2d8GQcbgzX53vPaF1eKSifY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jTi+c8HZS4Q4b62TTw9nmP/lGdol4t8gLWTXJrqaOr+zNyqvxGeGtXS7cclYvbkAK4pwr4d6irChwYB6+YKWCXGFwSQVjtxE/RXZhf/8eFlzaQM53wNZhkHmWw4Vx1/6/xEbP7NdA662cK37hYkExn8Xhp+ScAKT4w2M91Sb6E0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wqAyjgv9; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k9IodmNUH2qkflR8evFU6H+4jid2iZm7ngwGACrI9AU9wJPrhLZBwJ/aOJBFnYI0KsGK25w7txsDL8UMM+ezn9HZJe8OUVWKULxD4JH3xcOUdT1Q1L6grZfRSNF0aANKIT0lQ2/gSzhmBFncjjHWBkBeQwaN7NWV/1jK8tRIGEoO0iICBX2Lez3lsAFq0YROVTpchweHdG0oBDMfJMSeL+50AUyEo4YrV4Owv1CxzH/RCW3pMwK752ZodbHEaueGyuzayieySzzVOJXtqBQ6np9whn8Ie226+uMQNAfIN7CKMnUe855b7pM6e2Kc6rixbELQUGHZpst4K2jky8VxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uPWLL7nMZNMt5vxpZsxG2gxVkvZ0Et7ICMcm8fc4IQ=;
 b=NS42MubEZjbhCgHt5B9tzHBGrZMdh14O99+ualLwne3MswsrFyDHS9/1mRPE4YMUtxbbRrMHOftcb84L6siruN7espvo7JXFy/ZA19ZXLTHEy7dbMCJYZcBmohW6XpFeRdjs6+ndigARBCxmY/IhPJq9I6IXsE1/wPwm7Zg//TE6EgCSJo6VQkpIsxpuD6wy0rhY904Z6MKqSb/8H3xCFK+tl/z2UPqf8rsBZZqYiQS1LnIu7XkmN8qvEb8BRpp2bTwYM0xKSADBwebxOrSkhAfqXsQdw6tIrZfBtcXr7lVYT10Q9cd4/cOWxEtrPVNFjkMVVIGhcKsHB7YVcalS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uPWLL7nMZNMt5vxpZsxG2gxVkvZ0Et7ICMcm8fc4IQ=;
 b=wqAyjgv9x42P3pOfRIV7fTnVIWidZC/gUk25s9tVOsZ7aCNv+v8hD5HHKPs9n/aIJAz9SVqdQ4g6KWWGtcVR5hqSudHJAHji+U2mQ0PkZuUt9scIfai4DLynE7/clhT8uLsNVWX6B7But/L6o0rg14bXxwHkCjGXULm4NqAVZZeMNI/zMDUI7EGOA5ggqyRV6FDwzaAWmewEJ6ptMUde2dRuDI+4ziwwwCXWJJnZnWOWJkhVPOewam5u1hKEMPVMEZt5vY8iBSBtRxsD/1YfsWrfalGzz7pF7MRBa19ZWFcuURyEJpxGZoa71VW/Aqxvzs8dwW2qYhxvSDTpcS6DCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI2PR04MB11051.eurprd04.prod.outlook.com (2603:10a6:800:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Mon, 11 Nov
 2024 03:24:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 03:24:27 +0000
From: alice.guo@oss.nxp.com
To: alexander.stein@ew.tq-group.com,
	wahrenst@gmx.net,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"alice.guo" <alice.guo@nxp.com>
Subject: [PATCH v5] soc: imx: Add SoC device register for i.MX9
Date: Mon, 11 Nov 2024 11:23:07 +0800
Message-Id: <20241111032307.144733-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI2PR04MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f772d4e-b419-4176-e102-08dd02005903
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yTgXABIxsUxiDW0Zv6fVmwykOYdkWp5G5dhi1ZW1bugwiUNfach7kku26f9+?=
 =?us-ascii?Q?D5/G5Q9bKveOzYhcz3S8r7D08xUDQBS7J9N8iWJoQu5reLMWlY9OaAIT42mI?=
 =?us-ascii?Q?Ic5aKx6qEFiQc8Jx5LXH4AJ3Ap9e5niNS7C0oVrMzTSmtRMA4+u0b2K0yzqg?=
 =?us-ascii?Q?jZZMy65nHfX73qpULQzXIbQdW5hjEott0O/mDaBeDoPbs1l9c+Wl1dFoFTDZ?=
 =?us-ascii?Q?/kmmyBk/1QJ1RF4s0dZ+yhRGMLjliHGKK8PpnPeqSu04O2+lPITVm98i5HbD?=
 =?us-ascii?Q?y8K8BT5691xU4z2WmLb8Ygr1RAuiZvQDL6ULux9DVPxdFESMsLrtuV9QltkI?=
 =?us-ascii?Q?W5hqwY5D7HmtiddpyqzHt+gb7JHnApNR/O/i4rk9BNWgAv4sop785ccQM+bv?=
 =?us-ascii?Q?Xh8O4A3N2oF+SM3N0A+8ZFoTc9NwWraZ0j2uBo1A0kemX2tYuaUteUnI+eWa?=
 =?us-ascii?Q?4ueuOvq4jmWVt6LPJL666Zry4cM5+JvGgkV6PzIyYL7+f3k/Ee2l1h4iYupb?=
 =?us-ascii?Q?09N7191lBNNg5iF9A4+vD1pWTj6hytpEU2KMBgl4ODU5mQITIx/qIBgo3av3?=
 =?us-ascii?Q?h/bTFAbWNVHq3iOLJugupIMcWOGbEFwFZJiUDlMdk/LCOEh3qtSquvCVUW6M?=
 =?us-ascii?Q?cTmiiq27xOVGAntyYm5vXix8Ter/d+AQp3QLks0jR0kzKWThSvgZqC5o3Abz?=
 =?us-ascii?Q?RpkSZbmWqhWWT+3poaZlkOpu+qnqAsix3wzLnleDRo8hE1zM+7GdRmC1/KrC?=
 =?us-ascii?Q?Y5yl6j75bXgkDvAfFaHU3JfzS8P1QBcucJzj800KCeiOS4NKnTEGxzrDbVb3?=
 =?us-ascii?Q?xNHYaKaMk8m6CWUE9nbcfsSvFzVQruTRAGRjba6qLyHHfXqGAbTz7J8WkZGv?=
 =?us-ascii?Q?pBBOGnGErChlkx+5Avo9dK6BpAXnx2BplpT1N2Vtb6wi3Bo/RhAATrv53US8?=
 =?us-ascii?Q?mlgtthpJ9lTSUyBpBJCfrMNtinYhvTs/wsYT5tSbn6A+uftNLQw6zxawNADo?=
 =?us-ascii?Q?0vbdv48QStwzXf++ykkE2Kc6zlrCqrVAGL+E6Ch0AeMFJ2jH8qSBdBxmuD4T?=
 =?us-ascii?Q?yXfPh12vDaxVoxpezHJeNzUlSwVPdIyuXZHGtdpN64d5VD5uxH4HYvBsdQPU?=
 =?us-ascii?Q?3yU5MdnSvgzjex579LNM+1Ax/FBq4eVbr28T5mB5pbFyaKEhu887FyA9FYUb?=
 =?us-ascii?Q?b7bCHVzaiqbTELV5QrDhN4b461jHOg0jRONTV3saT3ZMZRv0IRP1qLrKagZq?=
 =?us-ascii?Q?ceNdn+93BDq01U9KFB3DMwH9rVxJ3Gkn2sjS1lnmkICSmOJzgYNOusYh/lUi?=
 =?us-ascii?Q?08/78Pcv8lE+DkYoVXk9CPGrHsEy8Z9Yms3DmaajNXmFSqO2TnGuCoSSGUb3?=
 =?us-ascii?Q?OYzX3tY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+SSGDqEiaBwq5P0hH2yNz1aFp+kRZ15AyFfCqx1pxRG4EHsUCT2reeC0103g?=
 =?us-ascii?Q?hiFQOkYpamb0+oklA10Z0YBt2HGCNrsXL4nysLuhMkxGTkR1/4stShrBeZ3Q?=
 =?us-ascii?Q?lWWkV9CE5/wpjIOy0q+bkA0YRK12gSLpgN/pp6tb4cflwe7RZIYl+3arVKdC?=
 =?us-ascii?Q?sLLnbMnOviwGn91cIE67KxeYynpQzqa9bNn+VCBSDQsg0xlgMcQYCZ3vrk/k?=
 =?us-ascii?Q?kKAJXeTmMX7grf9YD+KPMn9FNb22UnOm8BFp7Z/laqUAAaWpgA+kdGB67ITu?=
 =?us-ascii?Q?8tWBu8gYkZEXaobHu3uQpMsz2pw0N1vF2DS9gW+2M/KiPMiCMQDwa2St46IR?=
 =?us-ascii?Q?Jt4Lsemm3yfhsDQR6HewrOjWzI1hO9fOzGZzzWUwGr7OUI7ysGPKKdV/O5Ji?=
 =?us-ascii?Q?2a/tHw5T5lW58K5Z6lLxCKv5vYGu49QpQ6ddwwBykiomud17EYXYe/Z75WZR?=
 =?us-ascii?Q?nNoPdUmsg/YA9IzYlu/ZoWgpl1EHfj8zHj0wFVGDsIlHgQ1wXoIe7p78zYly?=
 =?us-ascii?Q?qAeC4Ee1MESNu9pH+0kxy2wjoxvbYmqdbjeihWAVQ0y4JdbWgzu84KbcRwvX?=
 =?us-ascii?Q?LuS26qLZl3F/DyFMiAC/tV9A3GDQVAWSm4Zkgyusm4ObxdAL5Zeam2n+wggW?=
 =?us-ascii?Q?/kPnvb2Dhf7XztMZuSZsWLKzXImSMjY6dHp4/VFuhQMqTDBuYjiJWLVFaHk5?=
 =?us-ascii?Q?rIrm8FeVrmgxUzSOsh3IsPKBTk+EtsAWnNTUhDBySjmPf86JV/ZO0Ac5WlNL?=
 =?us-ascii?Q?E3c/U6SNO3ecntlE7OXw2weTk/6vBqDifAAZhF8xHOF4z0vXHOOFtVI+UGVZ?=
 =?us-ascii?Q?fjwneMt0KuYqD+a23OLdZzEP5sx7QeiOqrxKAf8gxohRtcMUNwo9m14juYky?=
 =?us-ascii?Q?PRtyc+ppfDXDBon8pQk8W2xDyHXbwPpO/1SFGoZmNOlCF/bJIQB3pzLH8PUH?=
 =?us-ascii?Q?cYn2ngVTEBHKvShv/a1w71cQzIwiWPRCNhms4gvSaGhqe8Sc+dHXje9OL6si?=
 =?us-ascii?Q?U76pSlGjGChZuoczt68lTe4UN9TBLblJPKHahb9feLn1Es4bTWi7UsqYktm4?=
 =?us-ascii?Q?H7SP5bBzAXbPuFwIaPTN+g9T/CeRWB2XTdRTgDc1BuqerFrwzYLU1K9LO0t+?=
 =?us-ascii?Q?ftqqyrKFZ0HTZjKxSZkC5eiH+Q9STQsIgPXN8Tbs26m1nu33OLV0U/dRZ/QP?=
 =?us-ascii?Q?x61zhZcWi5xYcUwX6o+HzALO1F1rQTmLsqMajiBTdwwK164xyu2KotyHmys+?=
 =?us-ascii?Q?DOFGGBZAfWhqzXkUl+6jkkFp6qTHFyCbqiNZXK+HI0YagRGy0mU38AtpnLZ9?=
 =?us-ascii?Q?/yaD5dMGbJWr8H+WjPV9aqi67VRmX9gYYlGiy2OqXJUFHnunH9pm4OIOQpC7?=
 =?us-ascii?Q?/jWFOriZkG2punhs9/Ed8qBMK8jaeMMmiqznSAYAKAwYnHrbB6kgyI1q9CGW?=
 =?us-ascii?Q?Bgv03v0hd9tXF7GMv5XzJlz4nXQYAB0Y7SMF/STRPBfjlhdFjEpzpbbRoJDD?=
 =?us-ascii?Q?uOQiCJA46lWraAW4XyyBJzoWcsSMRFWOwx+F3mwd09Ln/khdWK5kJnvLhaMi?=
 =?us-ascii?Q?/3A0pHaASH5OTOgbTpegotsNheYmI7ZIc3787lVt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f772d4e-b419-4176-e102-08dd02005903
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 03:24:27.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3a3vuJ3kACx1vGpFxXA8OUPDvGNqm+IVB3HDhaVgnrgizz/57tDVMUiWMCPBK6OfntX01K8BJisRrHnHlhHKxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11051

From: "alice.guo" <alice.guo@nxp.com>

i.MX9 SoCs have SoC ID, SoC revision number and chip unique identifier
which are provided by the corresponding ARM trusted firmware API. This
patch intends to use SMC call to obtain these information and then
register i.MX9 SoC as a device.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
---

Changes for v2:
 - refine error log print
Changes for v3:
 - return -EINVAL when arm_smccc_smc failed
 - fix the build warning caused by pr_err("%s: SMC failed: %d\n", __func__, res.a0);
 - drop the pr_err in imx9_soc_init
 - free the memory in the reverse order of allocation
 - use of_match_node instead of of_machine_is_compatible
Changes for v4:
 - fix the build warning: 'imx9_soc_match' defined but not used [-Wunused-const-variable=]
 - add Tested-by and Reviewed-by
Changes for v5:
 - probe imx9 soc driver as a platform driver

 drivers/soc/imx/Makefile   |   2 +-
 drivers/soc/imx/soc-imx9.c | 124 +++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 1 deletion(-)
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
index 000000000000..4ef92260e8f9
--- /dev/null
+++ b/drivers/soc/imx/soc-imx9.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+
+#define IMX_SIP_GET_SOC_INFO	0xc2000006
+#define SOC_ID(x)		(((x) & 0xFFFF) >> 8)
+#define SOC_REV_MAJOR(x)	((((x) >> 28) & 0xF) - 0x9)
+#define SOC_REV_MINOR(x)	(((x) >> 24) & 0xF)
+
+static int imx9_soc_probe(struct platform_device *pdev)
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
+		pr_err("%s: missing model property: %d\n", __func__, err);
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
+		pr_err("%s: SMC failed: 0x%lx\n", __func__, res.a0);
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
+		err = PTR_ERR(sdev);
+		pr_err("%s failed to register SoC as a device: %d\n", __func__, err);
+		goto serial_number;
+	}
+
+	return 0;
+
+serial_number:
+	kfree(attr->serial_number);
+	kfree(attr->revision);
+	kfree(attr->soc_id);
+family:
+	kfree(attr->family);
+attr:
+	kfree(attr);
+	return err;
+}
+
+static __maybe_unused const struct of_device_id imx9_soc_match[] = {
+	{ .compatible = "fsl,imx93", },
+	{ .compatible = "fsl,imx95", },
+	{ }
+};
+
+static struct platform_driver imx9_soc_driver = {
+	.probe = imx9_soc_probe,
+	.driver.name = "imx9-soc",
+};
+
+static int __init imx9_soc_init(void)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	/* No match means it is not an i.MX 9 series SoC, do nothing. */
+	if (!of_match_node(imx9_soc_match, of_root))
+		return 0;
+
+	ret = platform_driver_register(&imx9_soc_driver);
+	if (ret) {
+		pr_err("failed to register imx9_soc platform driver: %d\n", ret);
+		return ret;
+	}
+
+	pdev = platform_device_register_simple("imx9-soc", -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		pr_err("failed to register imx9_soc platform device: %ld\n", PTR_ERR(pdev));
+		platform_driver_unregister(&imx9_soc_driver);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+device_initcall(imx9_soc_init);
+
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("NXP i.MX9 SoC");
+MODULE_LICENSE("GPL");
-- 
2.34.1


