Return-Path: <linux-kernel+bounces-264959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1246D93EA9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328FB1C20A09
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C163E7D088;
	Mon, 29 Jul 2024 01:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fBNUbU6d"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467F7C086;
	Mon, 29 Jul 2024 01:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217295; cv=fail; b=c92hzESCqjTRaYGaKY4rh+bFn3kQ/OLU0I3W66P1TxNBRMrZA8ERG05L5LsK8drNrpt11dYY69GUpjoJ9kuBiWQ9eAtGvjmnvag47KyAibigj3SUJAo8i6MP+sGIgPuBM6icTr67uEn7oMqofZZ66aJP26X17Kkz0VZVVQQ0jMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217295; c=relaxed/simple;
	bh=EYOviFq8hYkt6NAutvuesP2ejTXt7ALm52Qzde7HO/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=luWvtEaoSsO4XmO1aK3Fh2zc3VM9O2tDZaZLKFzp01KLWwarNNarWZwe0ib5i0Yy/36xIbX4Ms770nYvfhhgZ50MbEpSJ32QUsMU3aSGcMt2tPlXs8q4yRmUo9AjCd24KL4+UqtqhlGmIJcypbU6fqOK31nZPvoHZ1U0fEeZKJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fBNUbU6d; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7kxFdCvHwCNORTTYOKKT/LN4iATLvAT8neX5uF0YumEfRIdItcjoa3hxzwjrW8XzUkFUHIw3Km0L8F0N9Bvt/Pgn/gu/HSM/g5Ok/aYqASbGWh9KEEseUQoSCL3ojvcs0z/H1BWsfpRGlvQEqHBDz7BNBmhXqfcOSQ5n8Q//TYTc4JdVepH4RkEYq3sFaD56Gfhm4q5EGjHzMk+h6UzK48vH0OF6Qg8iBtIQSpJQbRaE1YCBdCBddQLmE2xE+gPkwishnPK+QtGDPVZ+Yr6ulLVi+7ZiZFghNVWDdX8oCo5viCcRzl+wS6uiaFOueseEQ34Z3pQHbaUQL3e0DUj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUJji3CwxHa2eKv1eEevXAwfhAeqyeO+Z4rFtAH5qMw=;
 b=IQcaocvewvSTdU3kz1bwTVtTQ3yVwBP5h1Iqy2wqGIQkhVF1nNyA1zyb/VkFbxGRUC/IQMvEh7U5zU48Z2cmNeq7IzOKzYKgRPFpsvyqvC3SEuY7scOefsFshhANPNC3O00NdyD7zW5EksMWgWK7uj2lptqRByumduCjrHvaG1bL5AXeL3BFbIKd2C0OIXNKK5HxmIjNXkzxCNiRr1pxblegergya7uV55KKfq4b3E5yKbmXOeK7UZ40YVbjv7YkNnq7dNPhZJE7m1QtapoyrNhnAhzZt28won9X95CK1fiXA8Ct0lMJCCo80bqEn+xdGSWJ/GjnmVmDOGC3u0r14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUJji3CwxHa2eKv1eEevXAwfhAeqyeO+Z4rFtAH5qMw=;
 b=fBNUbU6d5gyUtibaGYdYRePd+tLoj9lpb/C7A7WKbu3IPbtjxL6BcBtd21b9AwLnonE2pMafasDDtdDnQ2C+ReCtUSPwPLkkqhEE0CKn+Ur8zL1ggi4f9YrcUjL4Gp3oyHPph0NTJnjJbITr1tmlz3R7s7sA/x4HsgkeCREF+z+elYRVPBH2GJVnpcAjP8Jtx+xCWr5YiVXEzRUDFmQ666LNN6PgZENqclHF9KEvu4rz/V1VR2GtHBbbiM+DkofhiFaI2LjDYbD3kImr3iM++Il8lWY1aKZ3gBDI4Zcg4VmZ/e4Xvo3GoPKShHI5TVSyjoLfR8JVdHLsd1BNkTFRLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7610.eurprd04.prod.outlook.com (2603:10a6:10:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 01:41:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7784.017; Mon, 29 Jul 2024
 01:41:31 +0000
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
Subject: [PATCH v2 RESEND 3/4] clk: imx95: enable the clock of NETCMIX block control
Date: Mon, 29 Jul 2024 09:27:55 +0800
Message-Id: <20240729012756.3686758-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729012756.3686758-1-wei.fang@nxp.com>
References: <20240729012756.3686758-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: cc181883-95e1-4c58-6f62-08dcaf6f9228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1xQSwh/t+5qEo8jJc0/jOVI/RJeda0XKFrpRc4YEebiwtsg9cRYygbBonDZG?=
 =?us-ascii?Q?KL9uYoedfJJV2TVoTZ3jt1/nGwZJ5l2bxuFNr0yrVEHIgBKA8d95SUNSmz+r?=
 =?us-ascii?Q?7komhuFUQlZQW4OuiMLBtnu+EvJaFIdfSE4AdxcNuX3PMEF1lWKpGDI5AASE?=
 =?us-ascii?Q?jOfrYBHAE6Y7Yh6mvM8HEG/sRPCe2ISPvcrGfJDzifzfzmhvyY8sDs/0MPRT?=
 =?us-ascii?Q?odHqR5MzWjKz2kUaYw8pKgww51Oe+m2ObtIbqRfUZLAwIDlWzdlUmQwpwQ2w?=
 =?us-ascii?Q?WRc0vSkJcRJ5iYpUxzEya9YgO+EVFITItirrTg1WqHb2/K1bmqx6/Nps+tCX?=
 =?us-ascii?Q?dW5XYXP5x1RauvsdnJVikuPSb6GG6fhmph9cqx6Bh0Z9Dc5RycebDymj4PyA?=
 =?us-ascii?Q?UsUqxlOds0VTCeuLEO5hjg+BHvDScMfYzr9kk5TCT61XRr8jlNOV0Rpfunmd?=
 =?us-ascii?Q?etWHF3tKvMFe/xALZ8OH2jEcuHEr/oT6gRnIhGpbaLyodic1gixZjFYE/+Jz?=
 =?us-ascii?Q?IOuohgSsnsUwHBPYNu/uPJ0u5HQDyaBcbXu26t9m3eNXs9L9NOAVAXLg59vz?=
 =?us-ascii?Q?UUwBpwL3IY7gl8b8IbNguKOUH8kSLkafDVUSvLowvBVXMZiZTteMAIdJGxsk?=
 =?us-ascii?Q?xPySBvDgKPhQUa6XsqNK7VezLrHeKWzZ5upVNBVPuYPAgzr1F+lSRYhNOCh0?=
 =?us-ascii?Q?C2EDb1RId0p8AnxTCZ2vGBEitUtejTFQunQ8cDPUiuTeltFZXSv9NKdGqax2?=
 =?us-ascii?Q?loOJ/tTxIx1Oi4xUoSIAwcOT+KUGXJVVmW9AK0mtnKIBFsCstLYB/yDrIoKE?=
 =?us-ascii?Q?9yA/W9P2TGuUTbC3AGhFuJMGLEoMAKaia1z//0oOg4oLmJF1ptKDL35jW/2A?=
 =?us-ascii?Q?wixhe4HrgSMxO1oY4vmji1XcHm0Q6bseNK1Ogs4TSb1Zp+jDUggry5wCyJnr?=
 =?us-ascii?Q?Kw3hW96aXGjwX07cfhYIpQDrz+hXSaL1T6fkvmU/OSCg5D64Pcjo/4rimqN4?=
 =?us-ascii?Q?rf0MpGYiPwcZ/VNq3W718fQgVQ8yH1/6b8J8gKFisTYeeWr2GNRwqzasRZ6W?=
 =?us-ascii?Q?R6Hzghr6pGqUvFvePBhEbi1k/Gxg9mPSfDUqxHXRAGquAPa/KbcoxiZV3W1H?=
 =?us-ascii?Q?QISbR235YKe1rXnqEB129fsjSaTyqj03yUs8c/vcstRYLU5NTBIrxjeauL8u?=
 =?us-ascii?Q?ANIByuB30nS0QJISadNUhCa+r8psvh+9L9N5lESmtIwPR60YpnSmM4lmAk1r?=
 =?us-ascii?Q?/O5y91Pz0st9Hqyy7W/l3UOJWeeCkTeVYOJXDB5eGaX1mJT/fI5z+LW+h730?=
 =?us-ascii?Q?x3iklGuTqN5WQqgC0dKuVF9jiycxJWq267RP4aEVG6NVzc1PX4haafC70FG0?=
 =?us-ascii?Q?fID3SmkHs4opJm+oP2qaw4papWYnx+p/DzRgrSdN4Kr+VNBW9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cz8txV3Hi7nipGkJfZcYq/DA+nwK63ts3VY3ADtNWwQkjdINBpcLZLRcaZ6h?=
 =?us-ascii?Q?78gCYgo17IrLy9Ku11lJluIBWh6LtnzFJhQE/StJvaIFo8Ox1guydEATGiVn?=
 =?us-ascii?Q?dgLTLsQT4ynFMonL0CcK1siIHVWZTOAFLC6NcPiiDAlArvu7krU7cemXrapI?=
 =?us-ascii?Q?HNI+/76tC0fBpALJVdhNBrDtSMfLqM1OGA0WnBRecUAyT1lkgaajWyGu1bdO?=
 =?us-ascii?Q?AGtho3i2KPEyHpEnYjz29TaHx4ODrLFOZ6aozh9zIKfymTeMnd1WNSsICG3i?=
 =?us-ascii?Q?nNZ1A5A6MwMHzaz00pBxHq4FY0Mic9f6WjzjNtKu+Zqkcph6fPlzOrzpKKfr?=
 =?us-ascii?Q?uUxoHw617Q2bEgDK/5STb62l5/pcxnt8PBNdXw/qSAIXtrJ7iREyjSZkJpm/?=
 =?us-ascii?Q?f9KX4dJ4PcMvb8PZu9DZhe2qKfE1S+H6rrUdUoeCjt0Gmi8ioi27n3B3WcuI?=
 =?us-ascii?Q?K02MbnU+TGri5+rd5tXvrKoDQOhX2SP1zrH6SYgCrRSzVs1+fLj8qoxcRVJO?=
 =?us-ascii?Q?6GtUGJHXT1qYCb7cKFzV3Wk6Ca1zXUsf3PRG+29DgyptEYFWOneMq7R+FsJy?=
 =?us-ascii?Q?VNfgbBevzPGqjyHSW58WMi4cufjufWap20djp1Hh5ZKgdHRi7ZrHowRIRR+V?=
 =?us-ascii?Q?GhPTk5bSsrgooe6DtBEoFKcKZE3fao2LA7RoEiuCBML0LxDuPTmoMTM/1//o?=
 =?us-ascii?Q?KyFACsH+YML6acHBj3Kg7+468jaWpoIY9QDmbbICyyyqd39n0eD+PxNA8bZl?=
 =?us-ascii?Q?lESNGSQTcyLaMv81PziX9piWaPuqi0NeQSj/dLvW7X4hoPPPN0Gkc/EuE5ld?=
 =?us-ascii?Q?muQ7R65B3WebdM+RUQYbtT8uT3wCNhW/kT72Tf8gdeKPyGwVsuvgPhjQxv7k?=
 =?us-ascii?Q?ALMKgLEpbLhx9MoD+/6bivuYobLhTF7hbsgtxrPf1KAxdRcK5CZW4K14O+o0?=
 =?us-ascii?Q?y4CS+XtqfK8S1xcUqXNYE3vweJcWuONO33PtZcKPnZ6qi4vL+cNzgtbVey3s?=
 =?us-ascii?Q?qSTywQvRjFDoJHKF/N7E70Y6Vi6mBRJrvnUefRYRr9nuuaDrXgYAeBNf98UY?=
 =?us-ascii?Q?LlN7I8ql8CQVKDyfbPKXa7QVdUnEX/7mMuTuTT18mPxSpfeIBU9KsgY2Spvu?=
 =?us-ascii?Q?OLFZdZPOmDcFzBP0P+zmqd2k75tu3fc3RHWQkv6R10gsVKImg6PbLknNlX6R?=
 =?us-ascii?Q?ErXfIFZWi1E5+PHTVE0I7DT4jM635XXMcfTPTkCz/m+0LNZVyQ1X8lw8o0CY?=
 =?us-ascii?Q?0V/69iFnZkBIRFUZQFKbPhNUVucUoaOQq2macHDlDJVSP8WZRO1DSnc/Yezt?=
 =?us-ascii?Q?+j94FFm5HDFSO7vbr3aElCcarq2oSaOzIPQ3gbQ3xkSajqYMRKj0OhAgMG+w?=
 =?us-ascii?Q?JcY28tnh+6vX/bYX31SYwCu0OBFq8WPAJxNxwxImDwdaJkIu23oYb1gEd/Bw?=
 =?us-ascii?Q?f3TZjAWFeDUrmByXuUyQFFVqYaSN3fyNkgXzbEVu3d5x50iCdYLA6R2n+wHi?=
 =?us-ascii?Q?WI1fGjjO0oZ3WLARWqWq1XifTDlbNchmRwcwgDiZkzBHHXuVhysYT1VZ+o8Q?=
 =?us-ascii?Q?Kt6fZKAjhb7OY9019kACL40vfTHefELiLEuZKFAA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc181883-95e1-4c58-6f62-08dcaf6f9228
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 01:41:31.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22oZwAItNg6MFKwSkcaYUtiXu4K8UwXbZ5V1O/F2wJ0B9iYiGFhVD1w55duAmDd3eGbKX3B+sRLVbnTtBcN+6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7610

The NETCMIX block control consists of registers for configuration of
peripherals in the NETC domain, so enable the clock of NETCMIX to
support the configuration.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
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


