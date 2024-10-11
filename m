Return-Path: <linux-kernel+bounces-359053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BDB9986DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621002884F4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DDB1C9B9A;
	Thu, 10 Oct 2024 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nlwj8SA4"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012066.outbound.protection.outlook.com [52.101.66.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BAC1C9B97;
	Thu, 10 Oct 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564972; cv=fail; b=gbLRE2xuyhunFyHOImir37y59S6VzV0pN2Y9xTnbiyxhlTI8MU5288jOLToXI8VKkb4V2SdsrSdUX9Zs1at0b6xW3R1QTOtvb3M0PwYZ1MnrAkj5GjXLYAYYBmSsEL/ZYW7C/gmxXNIHdINHa2jVSmeXD6oheRGP6IcVcKRuNCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564972; c=relaxed/simple;
	bh=USNJcKRuKuGM5Sr6lfPchDj4s29SiM2AkVoiMwLu1JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWsNI1lQHeRuIGTT1ZMK/lhtqpA34NRIN3uQtq5tDCTZ+eftk8XW3nBxiq0bqNVYzsTlh+Fbh7gB4XHRNWcp1tLBUtJG2L5bjG223KvbxZdxJcC0OLNooDDNiQIE+Gi5tuFya143vyj0b7cWRTtuyTWHbh4O7evfsr7p8ccDdrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nlwj8SA4; arc=fail smtp.client-ip=52.101.66.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3gozPbQE6TEvXt6RkVjtRhov0WceuM0FUjLdOb1FejG9VPV69BhkXhG3zBAXHTb3zLu6T7w7/VQw3R2Ek9BdQRFcTfl8uWUXdumUfTTaWl78eph1w0bp6LdNDRhu5TpKzXiZBZnHZ5t4y0nKOq3DjE2CfhOobUTs7HBoeTM5FMdhTrprnlcFQfGHsk6nOWv2GgO0PrBWz78OFG0A0YKxL+plB6jKSxLibkit39R5qb5ImQW28KIozqsxpKlJpdZnF9zZdHynI9LkItzqEgQJpiGWHfjw8PJA9zpJ924lho2mgr2uCGI2bagS3xTgsoQQa3Nkg14ja0zYxYifBxAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KD1kPCyYYL/ugWzWI5oeEDh9fbcVd3NfghHQ1aajR4=;
 b=u2H+AKEGSNoRqsFnhkMquK1wVG3/1Q0674elx5hUWxBuQ6+/hMD44bsu6+ojiYw2TInCdx+a1HhNBIFXyzyQmaTmZYyaiYNYTWHDAtL42tvsZE5saSs2nT2yovCPBC6oK9MkTWkUIEleRM/NoE6MlsPCsYrLO10XA+AC+CvJHChTlcyMQO6BaVJ+H9sZET8VMQCmPAg1uKbqYHWbkGM2H5GfsHsLHFcEioHrODJSD1sxPY643dOF+9OCaRYEcFSWfuvkt5ctahGu5BzAJKqNqZjNXhWsMs43TgTnzfobShgVI1WVDwA5cHeU2oHRLVrJL3ZFUR+kafnmCTNhoT361A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KD1kPCyYYL/ugWzWI5oeEDh9fbcVd3NfghHQ1aajR4=;
 b=nlwj8SA41eQ8W1wO650s3DKlTN/0GeYkIOM53E5d1q9htmtdGo7hPZRBVrl6iJjPmSsctRhgDm7rM8TD4O6mVDHLszj0tZPgtJVW3uQI5UyjB08bZF14JnKDRiJp2s6z2xQAYNgx9/EbinHRy2AoNE1n2asPKIBA+c/f/qvaaxjzpVzNSZZlSDA8QbWMYmK8eUWIeV3xUaRY6aFpukQ50WAI9A7ZTBhu9ZRWXa7F/sUvjV/UTPcigp33+c19QVTq1W44j24w4HjpPSREvgBe5AxUhhzsuci57KH3UsJGMKITcKTPq2304vtaqbb3VuuDeyAxg/XcvfOQ0qVnCZhnGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DU2PR04MB8776.eurprd04.prod.outlook.com (2603:10a6:10:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 12:56:06 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 12:56:03 +0000
From: Pengfei Li <pengfei.li_1@nxp.com>
To: krzk+dt@kernel.org,
	robh@kernel.org,
	abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	ping.bai@nxp.com,
	ye.li@nxp.com,
	peng.fan@nxp.com,
	aisheng.dong@nxp.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] clk: imx: add i.MX91 clk
Date: Thu, 10 Oct 2024 21:57:36 -0700
Message-Id: <20241011045736.308338-4-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011045736.308338-1-pengfei.li_1@nxp.com>
References: <20241011045736.308338-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DU2PR04MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 06af7c09-652a-48f7-bea8-08dce92ae5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cAWVDOgJuo+LcwEQGJZxpOFbq8L2sXLDrlOVOEmVroIpWSAv5UZAijHU9EhZ?=
 =?us-ascii?Q?CkIvDUMc0hcmbIHGtmJIgBxmO3MUnG2xuZ6GXY1NtcrRr4Z1EnmJkA0ijjEY?=
 =?us-ascii?Q?wXJFGWa3uCvbo4zjhdMSJOf3qfcb3L86DxzDy1UQDKOAtZBIA2ZASvFWdUxv?=
 =?us-ascii?Q?DOdvc2q2inIBcBAGoH9s60W0Hz2zr6hyLdcOVq3M+4VZFtuVXoa7lwmDTN0b?=
 =?us-ascii?Q?XQ3IMjzInACWfYQ/nnxduzGAWx44mF4G/32qoeKWUAsDWITHzVN9dUppCwwd?=
 =?us-ascii?Q?oMbgFqkf0RzJiIz3JgrlpPSBSC/gIZBruYEIFYgAGgYctT2hEdi4P0iBL+uM?=
 =?us-ascii?Q?xsCU6/63dFshMge7QcgPlUm7B0yp7mcNdNvdv3kKuCe86qTclwCY4qZ4FEbO?=
 =?us-ascii?Q?7JKyyR1p4HxpScYhBgHOo2rGbP2imTKQ2KCakgsgPaUoN9pmg1GSY/Edsoc9?=
 =?us-ascii?Q?aKmqYNwlHY1TTvrl+E1lIrKL08yJivNyQdZ89D+K8Nkka1t7UMsIy8Kg6aIq?=
 =?us-ascii?Q?uxC52XQTZctozIYNrji5B32SFvowWvKygd0wAM/yoJx7ew/YQpCY8Afqeb5G?=
 =?us-ascii?Q?S2O70/6Crz/+wP3oXlneiB/PyqjhXnu/cYuR+2Qv/xEqMrbl3W0ce8IffbB+?=
 =?us-ascii?Q?3Ms2ld9rDB7nuUm+amztekdwG9ZXmCuAc/SXHxDYmweimYr5z7DtCCcdMFgw?=
 =?us-ascii?Q?IPBqzlFkz278TFav/t9hgLlJxfoi5PubQrGcewcqBWL9UsF2+6oVZc6bCYQN?=
 =?us-ascii?Q?p1tcjL0K/DyeoOU9PPHhP736mN63jZdolSccHsSqtkEalZVL1wrX85MjGuth?=
 =?us-ascii?Q?AGGDhtyPa6RwMgBAL9MdxdUBz97+j2RZCKLisBEZVlMAWrOU0AHXuzv5RbCe?=
 =?us-ascii?Q?6JgfmqBakCacREa4iYjR5FHDZDCuzVGpq5g6/My6GPi5qcrLEU+5vivtfkoQ?=
 =?us-ascii?Q?LWWyB+ck2IADSP/UtPEYPGTrVDYFtCxPRKN2gwL5C4BYvX8+jxdfNbUkHQUg?=
 =?us-ascii?Q?PUfCR+5FwHs4JY3hUW8XoyJa8BeBlz1I74IYJAehHdqsfYWvrWEUbI8D7O/H?=
 =?us-ascii?Q?hth5NbrYsDkdxLdrKbeJ3hVfBi+2f+opXkYeOcvyp+uE7kC2k9OepXu+UE01?=
 =?us-ascii?Q?0NVMDhVPcdo66hy4rpqiE7pS5A7Kzmtx08mYVqe2yOe3BzzLKTD5PKDdlZ4H?=
 =?us-ascii?Q?gDmmpoT7Pe+MeHtbdSrKmBBwxmcKd5p5X6UiltATdb6hmaDivP4Fnnvwm2O3?=
 =?us-ascii?Q?dfhJ2PF1dl2G8P7pM2kE/WU54mxZdVdnMe9uxIa3NoeP+mgfvPKAnloUWIin?=
 =?us-ascii?Q?bxgWIA6bjw6wqrtlC/HjzEtWnb/c4Y1oWUYAyKG//XmHjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?94HOeKAPPDrrjaEOeSacVIVDnk9kZi6DJdzBXIVi1eq753cJLYf0sdScq0aK?=
 =?us-ascii?Q?FH1KpX/pr//6/YSrUCB+dx8fz7WtbVmXZPxe0yw2/7dzA0SYKdNnkKOAH2FZ?=
 =?us-ascii?Q?vGRX/DPCYIV+C8+zAybUikdvD9Lcxw1/7B60KpudxHUnObRIUeWtQ1NvwH/D?=
 =?us-ascii?Q?ZFu5LpdBVuczssptuaPWtEWnLCm6LXCFRXie21Qt03QOZbRldG+HDiRYxgov?=
 =?us-ascii?Q?gaRqaUyiO0imm5Pa5xZhojY+Pu309hPl6L8L7eB1z3v50tPKPVTfyRt0uVuh?=
 =?us-ascii?Q?sj9JeFTKCmoKiS4X+NUGB46NHpSqssjhPKff6u9OmNAGrLveg1vHIQO+xU2B?=
 =?us-ascii?Q?GWBTKZaf8HSnezvShBMXZ2df+sobxQ3uQOOG9xuIB2RPxZnVyg5Hl5ze44Hb?=
 =?us-ascii?Q?lciBCBzUzCLr+/AK0aYbgzy0q/fvRpElobvvoxdh7bNiNJNJ8qwlH3h41JQy?=
 =?us-ascii?Q?m1vMWxg405z4F4iHTnP0iu7TGUSo0sTX3aX9sNJyHGDtc29YhnQ8SeFvfg7t?=
 =?us-ascii?Q?QFQm/2M+/5EX9cegI3lO6WJ1rv13BrFJZtdvh9Bpl5Qyu1A/l2Rv4ztqq+zr?=
 =?us-ascii?Q?6yA0/Gb7gVHgI35aGXmvWSwu6NF/AiL4F/Ts7DkvhDmeJ5lxETtFZqdW/xsu?=
 =?us-ascii?Q?GKv/oZ4cV2gUrVA/TmhNihmgHDSu0lVQQplGSRchIjfMXb1OaF+v57YYMXZB?=
 =?us-ascii?Q?HbSmxwKevPNOnLTK4T88sZlBpJa187ZCB+IB7vh4urwyReIyASNUxUTFSR8m?=
 =?us-ascii?Q?03+UOj7uI+vzaIvkbCg8mHjJ6qki0CtWsPm74TwiUbpiC37yrHWHmw1Kuq9o?=
 =?us-ascii?Q?dJuGmakqD9d8fIgy+vt2OVy82e0gb8teD6uP57MGdn0wYnRUEnlCm0L6Q1TE?=
 =?us-ascii?Q?oKtbCvBR+hz1S06fy3VOKFXCePNYXI1yof8fd5JGFTkrWLi7o7TQ5g7OyASy?=
 =?us-ascii?Q?8NATWj3mxfoGy6CZz2ga1cl/1CeR0LipIC/rwwQqtyyAn3xq7kUhZUP87ulf?=
 =?us-ascii?Q?3PhiORV+crFMZIIErX2zC9hIpJBJTnXcuE7UDU2Icoj4dwoV1RH7d2kXeYwG?=
 =?us-ascii?Q?KvhgnsjNmoVQxybWLnMjylnmzf2LZktPRlk0XS3nXyyIaRLEW3MkdUwAad9z?=
 =?us-ascii?Q?ByeO9EX89GNNg6ON9z3pdQTtPo4fB5EBMX1OKqrIxtANMMUYDIBR+z4/L93G?=
 =?us-ascii?Q?foUoOkwUWkcmNjuWmHd8O1b3KhcmOX45diJbQcWA0U8FB4v6wnx5AtgcZFvp?=
 =?us-ascii?Q?h5nefizbMvkoPDCz/NZB0qGI3WHDuGYYe3VNblU40txoST46x+V9eGzWDurd?=
 =?us-ascii?Q?jJQ2DdPFzJPMvSML/wPeyMS7V7j6GjzTLrTCbvz/T3Z+4ontFqVtbx1y1gIM?=
 =?us-ascii?Q?vRlq1Xlu5+0Cx8WSJY5DOyT9HfuDMAP2j8P/CTsmDoBp7zbMqzBhQ3RK91DS?=
 =?us-ascii?Q?Ds0AiOGXGEOWGKBlaa3GjjE00If937YFdKkve6BEwsEPO7JkKDrYuthAtJBr?=
 =?us-ascii?Q?ZgsevAosD1j/q2hcFawXZi4N+gwZnGSNIX2guBYludxPzHsh+zIm04FPbwG7?=
 =?us-ascii?Q?tiAbxtbjPAfUNPmyyL43fqZJIOKFwCT7BXdDp6Ht?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06af7c09-652a-48f7-bea8-08dce92ae5b5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 12:56:03.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0X8jPzIhhiZPn9wKpuorU8F8rcWcPOHwjVCIkjx6DuDHRzwX00JFBW9tk8+jYDYb6AB2RZ6XJ7v4ualxFwk+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8776

Add i.MX91 clk driver which reuses the 93 driver and removes
some clks.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 63 +++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c6a9bc8ecc1f..406c98566271 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,6 +15,11 @@
 
 #include "clk.h"
 
+#define IMX93_CLK_END 207
+
+#define PLAT_IMX93 BIT(0)
+#define PLAT_IMX91 BIT(1)
+
 enum clk_sel {
 	LOW_SPEED_IO_SEL,
 	NON_IO_SEL,
@@ -53,6 +58,7 @@ static const struct imx93_clk_root {
 	u32 off;
 	enum clk_sel sel;
 	unsigned long flags;
+	unsigned long plat;
 } root_array[] = {
 	/* a55/m33/bus critical clk for system run */
 	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
@@ -63,7 +69,7 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_WAKEUP_AXI,		"wakeup_axi_root",	0x0380,	FAST_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_SWO_TRACE,		"swo_trace_root",	0x0400,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
@@ -120,15 +126,15 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
 	{ IMX93_CLK_NIC_AXI,		"nic_axi_root",		0x2080, FAST_SEL, CLK_IS_CRITICAL, },
-	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
+	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
 	{ IMX93_CLK_MEDIA_APB,		"media_apb_root",	0x2300,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, },
+	{ IMX93_CLK_MEDIA_LDB,		"media_ldb_root",	0x2380,	VIDEO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_MEDIA_DISP_PIX,	"media_disp_pix_root",	0x2400,	VIDEO_SEL, },
 	{ IMX93_CLK_CAM_PIX,		"cam_pix_root",		0x2480,	VIDEO_SEL, },
-	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, },
-	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, },
+	{ IMX93_CLK_MIPI_TEST_BYTE,	"mipi_test_byte_root",	0x2500,	VIDEO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_MIPI_PHY_CFG,	"mipi_phy_cfg_root",	0x2580,	VIDEO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_ADC,		"adc_root",		0x2700,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_PDM,		"pdm_root",		0x2780,	AUDIO_SEL, },
 	{ IMX93_CLK_TSTMR1,		"tstmr1_root",		0x2800,	LOW_SPEED_IO_SEL, },
@@ -137,13 +143,16 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_MQS2,		"mqs2_root",		0x2980,	AUDIO_SEL, },
 	{ IMX93_CLK_AUDIO_XCVR,		"audio_xcvr_root",	0x2a00,	NON_IO_SEL, },
 	{ IMX93_CLK_SPDIF,		"spdif_root",		0x2a80,	AUDIO_SEL, },
-	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, },
-	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, },
-	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_ENET,		"enet_root",		0x2b00,	NON_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_TIMER1,	"enet_timer1_root",	0x2b80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_TIMER2,	"enet_timer2_root",	0x2c00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_REF,		"enet_ref_root",	0x2c80,	NON_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_REF_PHY,	"enet_ref_phy_root",	0x2d00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX91_CLK_ENET1_QOS_TSN, 	"enet1_qos_tsn_root",   0x2b00, NON_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX91_CLK_ENET_TIMER,		"enet_timer_root",      0x2b80, LOW_SPEED_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX91_CLK_ENET2_REGULAR,	"enet2_regular_root",   0x2c80, NON_IO_SEL, 0, PLAT_IMX91, },
+	{ IMX93_CLK_I3C1_SLOW,		"i3c1_slow_root",	0x2d80,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
+	{ IMX93_CLK_I3C2_SLOW,		"i3c2_slow_root",	0x2e00,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_USB_PHY_BURUNIN,	"usb_phy_root",		0x2e80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_PAL_CAME_SCAN,	"pal_came_scan_root",	0x2f00,	MISC_SEL, }
 };
@@ -155,6 +164,7 @@ static const struct imx93_clk_ccgr {
 	u32 off;
 	unsigned long flags;
 	u32 *shared_count;
+	unsigned long plat;
 } ccgr_array[] = {
 	{ IMX93_CLK_A55_GATE,		"a55_alt",	"a55_alt_root",		0x8000, },
 	/* M33 critical clk for system run */
@@ -244,8 +254,10 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
 	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
 	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
-	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, },
-	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, },
+	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, 0, NULL, PLAT_IMX93, },
+	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, 0, NULL, PLAT_IMX93, },
+	{ IMX91_CLK_ENET2_REGULAR_GATE, "enet2_regular",        "wakeup_axi_root",      0x9e00, 0, NULL, PLAT_IMX91, },
+	{ IMX91_CLK_ENET1_QOS_TSN_GATE,     "enet1_qos_tsn",        "wakeup_axi_root",      0x9e40, 0, NULL, PLAT_IMX91, },
 	/* Critical because clk accessed during CPU idle */
 	{ IMX93_CLK_SYS_CNT_GATE,	"sys_cnt",	"osc_24m",		0x9e80, CLK_IS_CRITICAL},
 	{ IMX93_CLK_TSTMR1_GATE,	"tstmr1",	"bus_aon_root",		0x9ec0, },
@@ -265,6 +277,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	const struct imx93_clk_ccgr *ccgr;
 	void __iomem *base, *anatop_base;
 	int i, ret;
+	const unsigned long plat = (unsigned long)device_get_match_data(&pdev->dev);
 
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX93_CLK_END), GFP_KERNEL);
@@ -314,17 +327,20 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(root_array); i++) {
 		root = &root_array[i];
-		clks[root->clk] = imx93_clk_composite_flags(root->name,
-							    parent_names[root->sel],
-							    4, base + root->off, 3,
-							    root->flags);
+		if (!root->plat || root->plat & plat)
+			clks[root->clk] = imx93_clk_composite_flags(root->name,
+						parent_names[root->sel],
+						4, base + root->off, 3,
+						root->flags);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ccgr_array); i++) {
 		ccgr = &ccgr_array[i];
-		clks[ccgr->clk] = imx93_clk_gate(NULL, ccgr->name, ccgr->parent_name,
-						 ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
-						 ccgr->shared_count);
+		if (!ccgr->plat || ccgr->plat & plat)
+			clks[ccgr->clk] = imx93_clk_gate(NULL,
+				ccgr->name, ccgr->parent_name,
+				ccgr->flags, base + ccgr->off, 0, 1, 1, 3,
+				ccgr->shared_count);
 	}
 
 	clks[IMX93_CLK_A55_SEL] = imx_clk_hw_mux2("a55_sel", base + 0x4820, 0, 1, a55_core_sels,
@@ -354,7 +370,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx93_clk_of_match[] = {
-	{ .compatible = "fsl,imx93-ccm" },
+	{ .compatible = "fsl,imx93-ccm", .data = (void *)PLAT_IMX93 },
+	{ .compatible = "fsl,imx91-ccm", .data = (void *)PLAT_IMX91 },
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
-- 
2.34.1


