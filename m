Return-Path: <linux-kernel+bounces-247294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2365892CDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EB91F255E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E520517E464;
	Wed, 10 Jul 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VoI4CfKi"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C38417E44C;
	Wed, 10 Jul 2024 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601818; cv=fail; b=jDcgAw7eYUmq+tQ2zAgCJZEws5UfueLlYVeleUYvFZqp2meG++8w19YOzL9lKPKeG3hR0O8dIQSCn4dSdnCWLAkz0p82/ybYegowHLOXzgriSpxrZxo/cOudw/VPBrtbRUIi4mMW0Mt0CFgrzhdDIlvW1EWmxmbsh1e86Kd2dP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601818; c=relaxed/simple;
	bh=/fzDV2Nan1lgpWSImF/sC+kX+ZAEX65f4H1vkT3ITlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOj/LLetaKydyG5YRzTjgdinEDrs2JcNNA/0k4SsyJFTQrB3v5YpU0clnzaH8+74CHpsEEWBfO5e8A/JZhoDA/JvFV8Cvu3RQuYTrfmqj8JdXzQCZa0PDmdLz/tD2P0BH7l0uP0prnUUNWXI5QTLPDvZ5mMbzvBq8LsQRkaIV8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VoI4CfKi; arc=fail smtp.client-ip=40.107.105.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zikchw19ltJ/6EgkkxjuX+mNrqz8aiLvQilxE4Q0wipCH54Vgeb8d5F50M8b4M1TnwVZ2bsKWWA0ORIGrNGwVm1Z2r5vg7cVbJxLcD4IId0EAtKtUlJAU9bXr9o/27t/NClWqhbL4MZLXdYDBBFyujstaCihUi5PmAO+OyyRwM0y7vzdsRoHsDcflOHbyHiP477S93CLT/srrzQ89Zutng/vXgQxPtxBA/ShBeBrySy2N8LALCMwKxE/Qm+i2zzV216sdNUxw/01nqHcyNv0YtoR6WFEQTyp9zB60k37v/+GQSwqClSd1xbWhoFcK1JglZwj68FexRsCbNU06804rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiWwBcz1V2AvNsZIDyZ/10t74v4+Ct6ckyULp5PrwVY=;
 b=FUKKmjunrtZJJt9eI7V5b8/u6Fxg341sp9KLroqqIX5JKXMQmF6HxJ0KKo1KflTyZKCtWBVi5tV/CTq6arsHh/3OaIsPyWvdNNr/abQQVUQAP7tpU91y4wzVJEo30llXE4OU14VNEiuDeNPVe3VxBBMwQ3JhZQNp5PW5oYUO9W3qffCP7rdFIr/BL/K17uj2FdG+gS5AZh2lY4kmGzX4+7abXk/hTBc612ZdFTPCw+Q1/0EBy3aFNbpl67kiGs1j8zvN03HHx6KJcLlOxcJR7dIHNwBvQs6zzMnaUH8GFgw3iDvTXwKt711yGup/enJpr8Uz8JuC2TroOxsepycVfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiWwBcz1V2AvNsZIDyZ/10t74v4+Ct6ckyULp5PrwVY=;
 b=VoI4CfKiKl6PQ10Endeg3rVsEOf2xtF1pPZ4JC18u7/7Bo5x8BSoMWzbcn0kSw4CzpTzPKpowm2RuRYhxKp37awiSDlx9HQYAXwylIjmH3PbgW0zfcCMFEWy4NFMd3yxIB2wtME2AwHAnN9J+Xl0iDRR/LCEOR3DhMDDreZVgkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8580.eurprd04.prod.outlook.com (2603:10a6:20b:427::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 08:56:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:56:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] clk: imx95: enable the clock of NETCMIX block control
Date: Wed, 10 Jul 2024 16:43:44 +0800
Message-Id: <20240710084345.2016687-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710084345.2016687-1-wei.fang@nxp.com>
References: <20240710084345.2016687-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 00701909-2b09-4808-5355-08dca0be3eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6Y9nxzZx0aXtR7w9WqM4prGyjzLx2Q0CYaOCLbm/Rqdznw9t6vEzb0b6JRB?=
 =?us-ascii?Q?PD34m6mJ4rS/3Fj2qvZFfbInWe49ITFr6FPr4ZAyEsvJos1pmt1xB7Wpqoi1?=
 =?us-ascii?Q?TzaeoI4agjllRtCy3gx2L1ao9zegbkPer3THYnhDLPimoGPcOChi+VU3ViU1?=
 =?us-ascii?Q?pWz9iYHUDheEc6oFrss+YxMRmzaC54kr4NrCK4vXfqxi0avWap/CcD5f+TiS?=
 =?us-ascii?Q?cDxukGrnF7K0fcg3NbjZSHDX6R63kNKcQ23hgNyJ8EjEip7f/biReftLU28U?=
 =?us-ascii?Q?yQaYKN3yDbCUGv6rfVbn+OTttcoVT/lT038/sy5LvsfFfChh7cbxMB+arP8+?=
 =?us-ascii?Q?W7JqqG6+4LC7j0/tjRq5JmhHvqvIfLPaIFnj+rOjjEbWojqmFSKJ/pKz6QRL?=
 =?us-ascii?Q?DxoEeI6gr/KwTnw0KrUTqJ+exyLEzX3BxSzjzvi0P5eFHydDkDWGFSQ5H70j?=
 =?us-ascii?Q?FBxMN1aNZX9JKXXMv/0I9IxQ8+mRl5eiaEwiatX/2Vf8KLoknZgird0FgNKe?=
 =?us-ascii?Q?oI1PioE1w90yDJVg7f2ZtuaJJNPfcSSLKlqRgV5AVTthtaYKmRzyfHGqIsB2?=
 =?us-ascii?Q?3L9rz0i1xJKaQa3V1sqyN/tC3hT7ti6ishjw7SZENoIkox4Wf0zmR7oZoOqA?=
 =?us-ascii?Q?F/SRr6bQBczY5VpveLEKZeOEE/tCIqs7+SdNWc0OTqxodRtCrds2XJPuyDd6?=
 =?us-ascii?Q?u4vW1vTLFeqmK7zqI4e1ta66GzXXIu1Mjrn5qOdODsS3j0dv30k3uav4k0bL?=
 =?us-ascii?Q?ucDkGsZ0FWhYAkiBAKokbKI9n+o4b3aDEycLBQAZzbyt0TG8QmefCVjcqjjz?=
 =?us-ascii?Q?YaaqQcF23Xa+q6ztaYhVHeMB9QoflrJAihBn4uRAGyOxjNvYP/divRqZDl2C?=
 =?us-ascii?Q?xNoD3UC8Ha5Lw7FJkLtXX01GK04Zy14McRPGEgwnSAbp90KNcJMyjSYKg0Qj?=
 =?us-ascii?Q?LPt3Vhfh0TCVd/cVC9+tnhSNuluwoWyv45eahs6wIZE/FWIa81srrRaLnj5q?=
 =?us-ascii?Q?uT8E5Z8RzpS/ufutqKE9mXbNR8d5F/IxGFulO9LKtDCxRLZj1hjdJutBGzU2?=
 =?us-ascii?Q?PveKpbm8piBJqiQwyowNo5MJ+ErvFlVUjEX//Wv5FuETwPCoaORxlyKdMBQo?=
 =?us-ascii?Q?uD94Z1S8Rd9X97KViYAO6muMvMMEmRLNGwKGPXOS3Oi4lMvlAE+ay0TINOAu?=
 =?us-ascii?Q?WLl93ASRLZnUZrZmhE1PzApjjrWAP/VWTZKJAeV3Z9IyqAe7pmiGu7yOllAr?=
 =?us-ascii?Q?clelsm6G3uOD0690FTl06LrM0y1Y8Z13Rec9F3hxGlxaV3o2sHpYMYosF34P?=
 =?us-ascii?Q?WSvKJCeA+wEffjY14LbNMGKLObLsdy3MX6vuyqIlwcas1nw7pG5zN2I79Lab?=
 =?us-ascii?Q?ck/cAWifIx4TfQTXsR0QycphYQRf7IBf5NdmGWfIsxObJ6t9dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+togap7coyNMcyTVZFJxGcUk6c1zJfdTFCIFOzjgsgirpoKpsUMhyZqwuq1?=
 =?us-ascii?Q?zvvrFoHgkcx/7vEX90kvchQjmJnEFSFTGpEd4Y8CmXaAK3li5hkJUbFr4rRz?=
 =?us-ascii?Q?cie2tTr+ZgzGVsGOGpFq+InaRzEoZzeY99Y9FA0of2UiTN/BsuE78kHT1gIa?=
 =?us-ascii?Q?bcYKRV0GTqvkob5IlPacXHmeIOFVBKvsQE9iw1UwnohKKpDci2e51Mbssz2N?=
 =?us-ascii?Q?YgeQSc6uWNUsmiXgrJWwvjlmgnwHKzzqT/quCUz28zyGVYzyqJwceSbg37Wi?=
 =?us-ascii?Q?O09VcyFZe7U1NJhO5E7BBp7DBiBAurp1U1ruPEVgE2LP8SDMnwHH+8beHNu1?=
 =?us-ascii?Q?nTbnFN1Pn4Pth5qW00UGr1pfSr47Duoqh0ARZmjfHKsSNViedxLWKX4SII1L?=
 =?us-ascii?Q?DIiYznEF4/uiAfCi1Ks6m38wkmmbaRP8xpOeaMTprbYq5XkTjP83Cz67ce51?=
 =?us-ascii?Q?Z1A8g4hSjSISKmQurIE4JIxEPXpLUb/+unzrXFZ+/fJ1Oy7EbhLU5+3e3drb?=
 =?us-ascii?Q?ARCsgsRUszTCYGXj5T2Xorl/XriqWHw1DeV/oKnB3DrjMtKyOWbrJPb2adS9?=
 =?us-ascii?Q?EonpSlpGeTcjim7o0TIRTVjhYjNhrt/p7y6ls7jDBbPk5laXU4bhxTktdVlv?=
 =?us-ascii?Q?lGXDI2b8AOpiNz6d46oQNM6ootKZYFZjFCETTjB8W5abfUb4rKR+TCobMJ8i?=
 =?us-ascii?Q?7asEGizcdyxuXXMXeG7itkOJpBqjXs+5A8usPozGaJn3JsaIANQS3wRsNrUj?=
 =?us-ascii?Q?VXPzJ64lyyrVwSU0TwH/FNfhLpaeuLJS2gs3f//0wa35gKxqkqO6FJ7KpxYi?=
 =?us-ascii?Q?eKIwI9JQ9ybldBfnvQRhg8JvWBTGsqGN26oDooM3d8pMP9d0pmnUM59ai/AE?=
 =?us-ascii?Q?H0YHvB3HB/aC9/GaKZ0Pv9Glehg5lbejXZAy5yiiD4YYTZn7Orauu2P5hDFY?=
 =?us-ascii?Q?Pf3qQjIL7Dz5LAegob4mR9KT4FKD2KqKd/UIR3cxyl6Ke6D0vfC4/OrOFRDl?=
 =?us-ascii?Q?BqwIEzZxd7I8miuxXQ3s7cdrgHdA4HK7z9CMVpETUHUd1dEiMc8vwmVljcn8?=
 =?us-ascii?Q?LD62tCQGrTv7dPn4bpdO3/H+O0fHk1K6Ra/kbhnP8ns80xxi3d6TfzBAXHzU?=
 =?us-ascii?Q?8+5K+1E60Q4wZJ869YkAYvUaESeGM8h2Nea1p4urqnFq4lUrMBtqirWGD71U?=
 =?us-ascii?Q?FbE1KsEq358GvzE+efRFrZS7CwFvOHBn1B+Jlr/a8tOlnySE9j/iQsecdiK4?=
 =?us-ascii?Q?dbHgSyXaQVdvHV/BAg4OgVh2dd2B0xR8HKoMUS3wTDzyy75p3Q9KtCHDgG0R?=
 =?us-ascii?Q?dz5yV66VH59m46ID1kvcJiCrYOXyro/pxgKxp34eesbVH+Tdd5273KhDOxxA?=
 =?us-ascii?Q?c6EQTKiZ95V2jw9m5EwBr4Uua05kopQMNKVRycu7GyfMmWMujvdS/ZCOHXXP?=
 =?us-ascii?Q?4T40hRfdLnalebn8oByuYsM0tUjxxSrDzAHUGXnwryW0PlPlM0QKon7gm1vV?=
 =?us-ascii?Q?DRHOv/Qbt9fVmLXD5TxWSK5wwHWMO1TGJPmKX8wEWgIU2lZgNF3f5NYtC2iy?=
 =?us-ascii?Q?mwIu5b+Sqc2dQrzwnSezPZK2mq1adfny6qtC+Z+/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00701909-2b09-4808-5355-08dca0be3eef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:56:54.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkgpCHf2oVT4SaN/ewnljIlbVS1w3RC7mx9ricYp++50ZpFfMVJ7vbicHeX8HN3PFjS/m/dLtwZLtGcXZyxmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8580

The NETCMIX block control consists of registers for configuration of
peripherals in the NETC domain, so enable the clock of NETCMIX to
support the configuration.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2:
Add RMII reference clock mux for ENETC0 and ENETC1.
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 30 +++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index 74f595f9e5e3..19a62da74be4 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -248,6 +248,35 @@ static const struct imx95_blk_ctl_dev_data dispmix_csr_dev_data = {
 	.clk_reg_offset = 0,
 };
 
+static const struct imx95_blk_ctl_clk_dev_data netxmix_clk_dev_data[] = {
+	[IMX95_CLK_NETCMIX_ENETC0_RMII] = {
+		.name = "enetc0_rmii_sel",
+		.parent_names = (const char *[]){"ext_enetref", "enetref"},
+		.num_parents = 2,
+		.reg = 4,
+		.bit_idx = 5,
+		.bit_width = 1,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	},
+	[IMX95_CLK_NETCMIX_ENETC1_RMII] = {
+		.name = "enetc1_rmii_sel",
+		.parent_names = (const char *[]){"ext_enetref", "enetref"},
+		.num_parents = 2,
+		.reg = 4,
+		.bit_idx = 10,
+		.bit_width = 1,
+		.type = CLK_MUX,
+		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct imx95_blk_ctl_dev_data netcmix_dev_data = {
+	.num_clks = ARRAY_SIZE(netxmix_clk_dev_data),
+	.clk_dev_data = netxmix_clk_dev_data,
+	.clk_reg_offset = 0,
+};
+
 static int imx95_bc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -419,6 +448,7 @@ static const struct of_device_id imx95_bc_of_match[] = {
 	{ .compatible = "nxp,imx95-lvds-csr", .data = &lvds_csr_dev_data },
 	{ .compatible = "nxp,imx95-display-csr", .data = &dispmix_csr_dev_data },
 	{ .compatible = "nxp,imx95-vpu-csr", .data = &vpublk_dev_data },
+	{ .compatible = "nxp,imx95-netcmix-blk-ctrl", .data = &netcmix_dev_data},
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, imx95_bc_of_match);
-- 
2.34.1


