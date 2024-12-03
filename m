Return-Path: <linux-kernel+bounces-429508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF999E1EEA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36AE4B28A1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ED21EC013;
	Tue,  3 Dec 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f7zwxNIr"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6B41DE2DE;
	Tue,  3 Dec 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231162; cv=fail; b=HZ8CNw4Tso4JhfzMN1S99GWT3iXkwR6OYTy8h1p91YAbKjknSzG2zXlYiXIt17Jbe1chMNPphFoQFc2zubBnLjLo+RtOa/GcsE5lrnTP0WUknMbBrYtUnCui0s/rIm89QCEXPp0LiraQ9wgyNOKU2riv7gasf1gRBKLSB1rKD1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231162; c=relaxed/simple;
	bh=6G/45fb6miEdR9X6Gtt9qn+KD0QX5OA+7ejSEXUSAsE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y3uzKHtEHpgNPuiEG8jcuAb6CqOFQ3N4zaSjK+7C6MbQwr6Al8P6H9W7fqFhRbuN1ULiChw89yq8+3tw8HKrlyfPRX7LfYBD3ZxltoohbuPgCYJWrhS/nzt9El7eI9cTXm4XGXrwwnS13tSkgmbX7n3abII4CWLPbQ8bMO5OHdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=f7zwxNIr; arc=fail smtp.client-ip=40.107.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5BiI0ZRi9aCDke/XvSqSwDEscnmfSITfadVg/9LlPYwDAo7itOTvUhcZiqdU5RWNmp6Ad82rvNEwTm/PLCRR0t63dpodyHw1X8mLsoQzInd1l3UiJVe1bH8nE/cNNAyufoCf95/CvtQnlVjZiqIu3XBGsK15CdHZjnVa3E1x1xigdlY3zUBBBCdQlbYy+gosovfdC+0onzd9ToeKUFzmUJAfo6JpqoViF2vPDnvPEQ6ijpHTzQ6eja4TbOUfM36menICLPVsLhCoWvJuR22StVeiiBEKMy3olfwjDd7605/EmpCN2EieAKz/LIvTJV7fwQyFiVwfpWOWVe3udSTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x05kfaQVpCRcdfAVgIfJ3QfKGZdtodktYmBmdDZf4A=;
 b=QLLkpN2YWmddTeAIrTvPt0Awhsk6qwV9PphAbVpvh+XkdudWT2Z6ImbZba4ATbV2PQge1orB6jLvd9jN5HtFED7HmjgXtR3zc20EIeSMOEPZMbBghL783NIe1RjSRsRnB8JKO8Eh04lFFSwXlL6Vs0fZagpC/zYlqaDHUakDZhWpw1coJ9L5ZhIaPbQCho2fUm5VwZxLONVULu5A7a3jrsKKdwtVHUbPeY7B58gBaZUHbm2d4hd/TOK6PDf/pvKRJLPBW1H0OUhyO1AYpDgxG9tRMmGTtTYQMrqF7rG7FsbPRg8yIsqjmH2h9cQM/sRfzwFEXkZ3tCn35LwtO7iJOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x05kfaQVpCRcdfAVgIfJ3QfKGZdtodktYmBmdDZf4A=;
 b=f7zwxNIrvMjfYzpbXL6hMgKH1HBxEgXj/H18A7WVfJAn6VCLW6w90QhFB1d524lV05Op6bMJlxdmFlURdZB1Yr45hpycMeQ19hBQEqzcncGVnV89PFZFJ8HPD2YqTo8asFT9a6R8+BShLCbFezezcWDw8mffwTbhFLLHMppqh5cTq3t42h3zY82B7wFuNgshbYXgJmHILDwrmjOW9j/ODzL7f8DMYlGmP0lHaCP6Yn3wBoVcyrugrGd+UD1iancbGHcQRH7A/THKC9ONwk/UAt7y96CGtw9vR0HQ7oiAhW9iMxuBue9ImhvMHUco1qwskQ4u1PfEfkIi7kopWHyrNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 13:05:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 13:05:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengfei Li <pengfei.li_1@nxp.com>,
	linux-clk@vger.kernel.org (open list:NXP i.MX CLOCK DRIVERS),
	imx@lists.linux.dev (open list:NXP i.MX CLOCK DRIVERS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] clk: imx: Enable IMX93_CLK_LVDS_GATE only for i.MX93
Date: Tue,  3 Dec 2024 21:05:29 +0800
Message-Id: <20241203130530.1206526-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB7743:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f6b35e-a5eb-4dfc-17f9-08dd139b39a9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5UyrzVmwm4fEpya6MIUGARvfuCTeqocXnGDu1wpJxdgGXEyv00Bo0SlohDOE?=
 =?us-ascii?Q?6LjL0WTYEZJudw0oqzlZzHmnT/NUOZQegQX6Aj2/Dz+wP0m2FwWTaH7l/OP6?=
 =?us-ascii?Q?N/atLT9WXV8Rm9G1mMjy+LbzRsRFJNtT/lwm8P+h7mSnkdQmEaBtsot5fVfd?=
 =?us-ascii?Q?dFm2kD2+IdaiPGh25I88qddmfGN4RjbGyJN9BjBE1GIoKgXYGuwynG9sPFww?=
 =?us-ascii?Q?zEqg1vegTyfVvLggl5DPhWbxOKigyGcTNV5W8G9wvI830E+qJi8RT/qF/+Ox?=
 =?us-ascii?Q?XUKVPbi4Pru6pFbiPE0jyKcXv+dtgkCaF9myQzhKsgnmoD76h+Fwylu/9cCw?=
 =?us-ascii?Q?HQ9NdHIliarvK1ZLrcTrrQJQNi80dCBfMlXqc9Bdx0MhFNjp8G/ZhgR53Mtn?=
 =?us-ascii?Q?AxhFr/UmPmIf6Np9tfIJKkjN9FTxpMX+LuYBAerOTgkjQf8JYpl3pCs9blzj?=
 =?us-ascii?Q?RTLoMHzQ7XncM6XgSAhvzmFRp7opZWkWmA4Mm9OT3KoFfYfsCyTYW9goaCvr?=
 =?us-ascii?Q?l1VNk03Wf8uedjZ17yif3hUe0fLr6Y7tXwf3O8fgnkdD4rsSXg0w6X8YxYEW?=
 =?us-ascii?Q?rqLb+4w7fE1rX7ZVggmnrZuMjubAOOKoB9BbI3mC+TCOUP/waQwNEf96inBm?=
 =?us-ascii?Q?qY08Q8SbrAQurr1yKcubjNkXBVI1VdA+udqW71D5cu0suorWBi4J2Q3px5PT?=
 =?us-ascii?Q?KGTB/cmJv1eSVpnPsE9evZgEICxtoQ/3PVHVVyvNgNE38yEJ2toJaAUrdQ7a?=
 =?us-ascii?Q?SuQoNSHCBFhzVUd6rAfI0eulENLGJkY3pWUTau1O4drzi3kUEsnqihNyYL3F?=
 =?us-ascii?Q?LODgGw1JfzmDYq3F8M/q/up4a6pqwZlfZLsSnJxxMBCOHMIHljbgAj1iOTR7?=
 =?us-ascii?Q?LXRQ0iXW+EN1238aqy/5PyF/hgfem5PQui0jZ9ZoCF41mf56CunDBZ7lM6E5?=
 =?us-ascii?Q?+pIMGkxhImOPQTd/402zCEFwtcVa7jp9cyDM0lqiekLCjf7wU/xlB1/GdkiJ?=
 =?us-ascii?Q?lN/C8/dgxT3S58bFhNIj6FdxNDsF0RGnF7PUwiwlIcnxJeR9mb5obl9bpZFd?=
 =?us-ascii?Q?liRcp+7+ZGigEl0oR7U1vv1w6ip+Q3SashOnKJZlAl+r69936smb0QO4k+lM?=
 =?us-ascii?Q?7pzgW+FnRHKV2s3Msyc7im4iHIAVTNe5K1nC0djHS4lG/7Te70TJjqqxkvGw?=
 =?us-ascii?Q?sdNGyycAPVBAOhjag3eOCYCTE7FhTiKb9lp24nU6hj3Wtv4ACO38+M4eKzgd?=
 =?us-ascii?Q?+c1VMgxPJdtqx+Rj4Bj46mJMX2YDbDeoTl/7ZVWCJAYsPyzJyRjt3TgUC8iu?=
 =?us-ascii?Q?hegtTGB4lVcsO3P+1RdRhIRkUA0BREyJ4kQ3hz0P78dvtq6sz7CHnNoV3sr2?=
 =?us-ascii?Q?F3OZl2Sg5RHTzz6IT4wBvMYcFUJofwZD1W2aiYvhknM1bh987PELEapumetj?=
 =?us-ascii?Q?LPEKVDvuhd8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wKl5PuiCtUGB5wRVNganF0aCgS1UwYT0DvYnBfoh5yzQify8y2kVE0u94bFf?=
 =?us-ascii?Q?lJBe4aMDXsLhI3Uo9DTTwUDWkp9rb2naaHE6OoDphsCuaR8ZeLjLhZy49QnD?=
 =?us-ascii?Q?YoPFvt98gOQ6WaLh8OziyJ6Sf6aHpzVCHLj2uttmJO5IZXZ+UNaD8mA2rThX?=
 =?us-ascii?Q?KaQvst7QeRV7qQJ/d7oxJxuhdDjEjQ/qfoZNvFBV8Y1GwADOXo8Ye0lRYW7W?=
 =?us-ascii?Q?qQJLh4a4q4c7ZUcVriq0B2wPvA9j2R5OFGfRs7sB16pB7jcB7fuxxgp00bR/?=
 =?us-ascii?Q?QC1M1tSxmQxghSHjFAMm9ibovthyKc+V9V3ATj5ZJ5/3eSxeCLLFsA4wk5oo?=
 =?us-ascii?Q?Mcrq+4i5p0pQP8jPlLfTEc54l5kNBWB8756pIaIj/pB6dWI+wZoBnPu1hWlM?=
 =?us-ascii?Q?rWSd30CHEp1hN/eXi+yEFXO1tQspQOlWencqJvModja5oHMRCDXAF8dF2W04?=
 =?us-ascii?Q?uceoXDqVAoVtndogFYA0qZ0qPBgJUT790vQmF/iaANUQdRZlvubKt9No22W5?=
 =?us-ascii?Q?a64yS+07rAnledDUnwgy+u2BPckathxk1BH7aYToki3z5Z8fT9/Sxc/T6xId?=
 =?us-ascii?Q?fB9xj9QzpFweqKe/C6KxolLH4BBWfnqgFhwlCisTCDud1f+dVBFWaU97mipe?=
 =?us-ascii?Q?9Fg8AoxWiD+6hT3F+nnKfWcqzHEoJqT7hGpTEhvTr9BKTaH4sJPld2kSKcKT?=
 =?us-ascii?Q?/1y8jq7y6kBGcF/BdYiSLqD0xSKJtZjaYSuxMBgUO9dotCaA0bnAjbhGtOdZ?=
 =?us-ascii?Q?Qiw8OKnzhjk/8/bqU5h8/MceBeGIbLzJJveSD8HLWXiVAflp6zcbogBp08AI?=
 =?us-ascii?Q?Giw+xfPHETYwcayHNOVccn6N1tgqHKRPJ1IWKXs0iE6SXbbyTbmay1eV9dha?=
 =?us-ascii?Q?v0wHdTl+m0APNV3m3Q0T8xvU91Js6SW851WT9/iuqzjhyxJCLYPen6vzW0O9?=
 =?us-ascii?Q?CIWzonZSCsWgtRWHtJ0Y14qH3/6JapWNeHt08q2SmyJnEs/HEtzN/NzVjfpv?=
 =?us-ascii?Q?FPRQLGOIb2dFt3DgirQojuLJJSm+/UVKAKK9RbOXZ+vhm6YsrWOGxERxs5+r?=
 =?us-ascii?Q?5b35uFhN0JNot4c4q6bMbTmUi+alnTWvDTHQHkX0v7JDaMn8XRLBrwYmFqki?=
 =?us-ascii?Q?BvdKaTv2+Ed8fQXhAtM4G0pG8nFRBzn5j+coGxBucv9AzVMyZUFacIsxvc5V?=
 =?us-ascii?Q?+6LA/UY+bCNsfn/KoKilPGU8bqA54D5i6vHR4r2w52Q6hxQWNMN+2JElXeVL?=
 =?us-ascii?Q?Q6HrOxWMtNfrmPu/kvya+cz+0d7BixWfbwpgXkt8TS0g1EZmm8Turw/Sxu08?=
 =?us-ascii?Q?MeqwSp+3zZfuClZ1+io0tnhHLvUzSPnIRqAeKQIZrqe0nggDDIXh3Vfi5cb+?=
 =?us-ascii?Q?XkcfZoNJBgDVdSknn+yHCm9v5AHoX2k1pvrmMxki7Bx5R0rBFIG4PQ8jroyk?=
 =?us-ascii?Q?QEeSeDQVy8mRn8ABZM5MVibyycAwakl3QnVVNeB2n/FHiaBKIrZCK86r2vRJ?=
 =?us-ascii?Q?EzwpX3kXL6/zETvsPz4Tklq65IFWhpksTCy/hB5LBRHFS87GRS0AGfWItgm7?=
 =?us-ascii?Q?B3ZVes/8wb7AITCulGu886fc8/6R5ILrg8r2Fce2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f6b35e-a5eb-4dfc-17f9-08dd139b39a9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 13:05:56.8147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvReJ78x02y5/6hUDt4TtdXw6ZG3aa+fM3Gg6RifjbVxVpvkqx3UkiKPDPcyQEqnH7gvB6xxfFoTxEcSZY7oJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7743

From: Peng Fan <peng.fan@nxp.com>

Enable the LVDS gate only for i.MX93, because i.MX91 does not support
LVDS.

Fixes: a27bfff88dd2 ("clk: imx: add i.MX91 clk")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 58a516dd385b..a0d2972ba9cd 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -239,7 +239,7 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_SAI3_IPG,		"sai3_ipg_clk", "bus_wakeup_root",	0x94c0, 0, &share_count_sai3},
 	{ IMX93_CLK_MIPI_CSI_GATE,	"mipi_csi",	"media_apb_root",	0x9580, },
 	{ IMX93_CLK_MIPI_DSI_GATE,	"mipi_dsi",	"media_apb_root",	0x95c0, },
-	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, },
+	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, 0, NULL, PLAT_IMX93 },
 	{ IMX93_CLK_LCDIF_GATE,		"lcdif",	"media_apb_root",	0x9640, },
 	{ IMX93_CLK_PXP_GATE,		"pxp",		"media_apb_root",	0x9680, },
 	{ IMX93_CLK_ISI_GATE,		"isi",		"media_apb_root",	0x96c0, },
-- 
2.37.1


