Return-Path: <linux-kernel+bounces-363090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4399BDC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 04:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4886E1F210F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 02:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA9938DFC;
	Mon, 14 Oct 2024 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g340pS4H"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F828136353;
	Mon, 14 Oct 2024 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728872647; cv=fail; b=j4XzmzDE1Ub3aNM0eqnghBaOhM7kDge+SRovjAux7FaQvthbENpXu9p7yQvcvsOXqoduv4otQuvOFPB8KMGZRuTBksB25l4TNiwUIxnNN9AIlOxT/DoXctBSah5Y1dgraB2Wji78eOPXpT2NHsFNWh8KJf1xzGdqIRQMA5TsymA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728872647; c=relaxed/simple;
	bh=0tK5pxzW6EX1Yt9NnGPlWdu+lCZB1stadVajiiZ7Joo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gZQh2F8oTOvJRNmpAe/rvzdwkibCpnp/1OwQi4yIcZSbg3KzNnzGMjlG4k5xRc1FWrXeAAYtHSZbKJD15yBlFBf5j4mYpiiamLqR4vWBrRdWZiOuldHyB7ij6es8QLe3YRQGo1ui48DHozH3tnpFMIFoMsKMEYtWN7HTX6k57Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g340pS4H; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWQJriXLMkzI8sBwsyvJIxs6fegy3ek91ZqJeC5NwjL6kpAQOfjGsq2E40rJG1kxoZlv2iQlDjdXUoQnCSU9EvgCnL300PTdrp4LyMSy8S5rp9fgs1bL4y5vkCu/qqZUN5bElvpBGkwlXSlReJ9C4SGIPLdqH5hTHmX/02vW7CD8XkHpLIbIU9Tzwn4NKzOrFEXJe85geUIYHA32u25fXBcPxvov5dwh3z0ZvWycsDVxaREtub5G5GxRVuzIfnVnOQP+Jy2QbcA3HjdrdwvWUxhy0NUTkw2ZownssZL1hceY27zzPPh/BzatO9SVjPw5DU3zJWWMS+Q9py/057zbrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRz9LDeDCS8uHYwuZ5jm+hLyanYM/G7FTb4tvvbVrH8=;
 b=UgBxb6UoKhWszzuEE+KeRgpyNTOUZnbsDlA1MPf9x0B3yrFgZ2L4NiSjMMzpFt/wpKSxAbb1K0+MIP+NCtTo6eRkIz9dPgdSeuvNlK8g0kyeJ/SNDbxwCLeu20fRWU6szc1Q/iY0SMpvFJ+m5ojqID9UjJ0FRjshVwqLQS+1sEHdBokgUWHYvPrZ1RJSDcDktbriCYHrlxGLtbdOaG/2cEGxz/jTccHO6DjTyeqtrmJvc5tzfjR5Y9vz9vHCDUug+Oucm/SPkh3nVea6TuVDmt9L/a82oFqyR4cN4qsD5Q11qhsVnjw6EzrIfXNKrtVunj/GxLkBb8B24Jid+P6MuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRz9LDeDCS8uHYwuZ5jm+hLyanYM/G7FTb4tvvbVrH8=;
 b=g340pS4HNcptBCcZANFh+QDKYPJfQvUb5QA/QQHgBMWVB2r+g39DuqaGBUqO8m6TjLxB4bIki6OF7Dsb4VySpDVGpJohRP47zaRQZ+Lzk3fqNamKRSELQGqts0psSbBi1+f66vWqL2HZ6OqmSsdSxuh/H75D2IepPRYd7mnzQqTP7LhVifLjlOvTHzS2EBBWX9GG/76xJhtn8tu78DIdJIjDQNcZpTfU3MylHYv4Ar9n8NQmmsTQNwpR+WWUoqNCmNcVIslhKGqIj4gs4TN69LI2plbsE4+ZqyUEiDUmgDhuuDRtxQ8UQF6Ch3Ybs9HXvg6f6NC2S/tgcLDcO/Jxfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Mon, 14 Oct
 2024 02:24:02 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 02:24:02 +0000
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
Subject: [PATCH v4 4/4] clk: imx: add i.MX91 clk
Date: Mon, 14 Oct 2024 11:24:38 -0700
Message-Id: <20241014182438.732444-5-pengfei.li_1@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014182438.732444-1-pengfei.li_1@nxp.com>
References: <20241014182438.732444-1-pengfei.li_1@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|DB9PR04MB9378:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3ac55f-d861-4a48-ba0a-08dcebf744c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wq9i2X3A/8a87MF8c/y01fat6fawaQNtZfZhdjnbwUVdrGNfPbBpN0yJanTD?=
 =?us-ascii?Q?Imh9WCaD4b0cL31cuN+aRyrxnzqjIdROl0sMS+iWzMFiKObsOxMOVR90bCHc?=
 =?us-ascii?Q?iHUaRMzzP04RWxx0dGdUWFnY0WX7PUEmWX9fPZzDjKGXXw8LG7R6ydb1Prj4?=
 =?us-ascii?Q?lQai9cfvUEuReJFTLdsQPSiQIi3jvShEXQouaTREtvgTHgoUg52OW5PCLktw?=
 =?us-ascii?Q?vAUKUaffUyBybJQ8pwt3zt2jgTCBDXdL8ieuBepc0LGr78btAGoVp3i7Pb7D?=
 =?us-ascii?Q?vPk+qDdmx74hmTqQ/0wGxaO47grXcsPDXDHzO1wBel4Km3JV62+zlvWNu5zK?=
 =?us-ascii?Q?nXYbdftLeFarwpaXU6vnCRrlg5HW9kP68T1Vj+Z48MPiiv0BCbhE0QccCi0B?=
 =?us-ascii?Q?HK+rTAWh0V3nsk12DyxPvM0sFdWrZzZK3NYmEyEqnfcfLNJbHMXj6WlGUahs?=
 =?us-ascii?Q?Ida8RRSXcYh7h67NHOIS04tQzq9IGXCTFUPN/JPjON9ckAhC6mw/8QRI8fUB?=
 =?us-ascii?Q?xHJCZuYcXunBz2fUIMaZ5jwtWWXWpP8eIjPJl69otqcOxIi1P2Njir3qywQI?=
 =?us-ascii?Q?qa0lU5HG9GPlKu00WjgO6Lj5Pn2/BHWSO93NwHZSuyvTVfFDEyr/a7ntDUJk?=
 =?us-ascii?Q?ncF1D11FZsoaGLsRKMRae+fCShy+Ew3GIkqG0K0QnjUQ1pqGDniBUpTNaFzf?=
 =?us-ascii?Q?hP2aOUdvSpSmxGUxaA95JWup/sJP/T6VYkpa15EtBDuXM6FwYH9I8Dhyy76Y?=
 =?us-ascii?Q?kzfxBPrZYWHRFmlB41S5pSE+EviZxrADsrhQ1VBarpokFwKxdqFonAJQl0w/?=
 =?us-ascii?Q?HmWimPmP65z/tNay653CTUkiP6ed5iWS2g6iYJBgS5nVEGR/huHWBlFvk43B?=
 =?us-ascii?Q?PPDFGfSUP0EWgvR0GD99WosCDRNhZNAmfRMFRthQROMYlec87/F+5bdhD3Hj?=
 =?us-ascii?Q?el7Gdcep5GhOHb+DLxwI2dnGw/gh8+NFW3624+0GUhvoBeWChjVobRXz5pc9?=
 =?us-ascii?Q?mI8+elpSHX4Nxm/2MVbqrkaeRwrdkoGCNkatU3s5hnLI99kZI8Wwof36e39N?=
 =?us-ascii?Q?rLyIgctEqCwQTPTWT8Gumdx1ui4x9e32H3JKE6Xy30+2FzhRN64jrP3MePZF?=
 =?us-ascii?Q?iMZCQLpjvP+EJK4RxdyvLU608hRoHFFHOPgmXKnDP8JMB+yyCr2hm2IX0a42?=
 =?us-ascii?Q?ZVhTB0kwRUD8NKApRctCnTgUgDqbZffXNGQRvRKFr12UxDG648+DziybY+8E?=
 =?us-ascii?Q?MVbW7dJbgWZge6cl0dFahCcRGNd5BVTCSuysqnC51gDrr3tX6jUBcBpk2lGY?=
 =?us-ascii?Q?U4xH0sIDIR2FB+OQ9nxdhTtcTowqeVC7MuEG6AymBoMB5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RgtPlznmnI+uwiWsOMOHFiB2nIt2PDwvCcLgo/4Tbrxx7LXsV1FLCLhP0o9Z?=
 =?us-ascii?Q?r7GRcXzTFJE0LHLpcIjU7ix2zod/Bk5NxL7M8UlEmJuQzWZY4D+9cnbJReFv?=
 =?us-ascii?Q?YpYFKmL0wBdk+kTSmP2/8xixS2/v0jN2k2PQUWabGDgWx3nwSe0/rV0aPVAx?=
 =?us-ascii?Q?kBdq1UWrDKe/AgR3sG56KHm5D76mRYxUFS423KzTN0JEwAHF0hfQmuKvgf4B?=
 =?us-ascii?Q?M9GJ6LvsqI66Hm2NqHc54Ab8mMPCbX1H7uWU6TLFrxu4WV867eo0l/1GRrXW?=
 =?us-ascii?Q?Dee+C+k3R47b6HS3iDGcBerelh8hQShqDIu0Ov6XjJW8ZHn1w7+kQWZuJ9h3?=
 =?us-ascii?Q?vlLFVthy8OdyPvWQQATHUyl5sJiAAq9DoAuCXrDvwPGtdqJXujOycMaE2YnD?=
 =?us-ascii?Q?DP1P0rz7wPuDJw2C4Md06omUeVj9Pino442oFDLjz3ouXAeUklTUfFiIHYpG?=
 =?us-ascii?Q?MjAxA6jyn+5QucYE0WwrZ8xttBbgRJYIauJmbbfJxyZ9zXBGg246LqxH9cMD?=
 =?us-ascii?Q?Q3kmseZqCpkRBB5VOzXP34lGj6ybsnIh1hSUA31WYEQbjqH2FLhjaApESDoC?=
 =?us-ascii?Q?6sTMPQ83hflrMkCY/zYC3R3sHCPAyAiJaHam0vJEC2KCo/0gA3HxTAvUJc4k?=
 =?us-ascii?Q?HCP1cKXxpwqUJIQzv1FLLra2BlPdLGbwlvRrE5AfX6FhWPqMD9lLfedSv1st?=
 =?us-ascii?Q?FQBdwTP2eZJpRgu8hCiDqK82OeuGij9v0NgVlQ9j8epEyr5HaecgN2HYfiQ8?=
 =?us-ascii?Q?m1XfbBRBne4OQb0GpcY+Sm9SWX2ydUxUGLyrUYzsiv0UZI+/0Vpc3/YyU/AL?=
 =?us-ascii?Q?hrOkQzKT0gxZ88NJSRqMQmrVRVIsWids+wG1tZXf8DnGyT/KWeYGxuI77gdr?=
 =?us-ascii?Q?dDbfEnjMhb7HT++04qtlP+mEYYnwZM7Dtu5n8G9d1j+xLAfWINxx+gSz6Lf0?=
 =?us-ascii?Q?0+Pww/rFM0HPj3CIG7xgViE8GZlGMRa/URkGmPujD+WBohcL3HOHXtwAV1zS?=
 =?us-ascii?Q?Oe2rOjMHbgTrNTgJxaa0NCJG3MiOkF5rRKG+LCZB6nypcoP2ys9vUoW0dsoA?=
 =?us-ascii?Q?UfOQZHOuOiABkFNSD47rJPM2+BPNyC6eGet27wIVejxz5UT1M9c++PF5oF9W?=
 =?us-ascii?Q?3fFHe8XEzUA25GvVpPpnQsHFpuN8Cb37eMGamUD+ACXcKxisDRGI24eR/gwa?=
 =?us-ascii?Q?6FhOVpK05Lxm/nT+ZI32iGrBms9p6345XKDEymDmWRT5IXzBLxj2JZYKx8IX?=
 =?us-ascii?Q?edmswZDjwUbM54cRW4zKTHyYuSApVr9meW+iiFgJCPb9IiGQ1vf4JfDZP7v2?=
 =?us-ascii?Q?1MDgZatMu0QjteCenAJIujw1NcJnB/J0HQzONpS5/ICulw0QnxQYSYNNXALA?=
 =?us-ascii?Q?U3WUs/IHxPZhrPpPp/vYDoui9qeQQU997AmLqhFejpjqwxn1AZjmyLyzTqd3?=
 =?us-ascii?Q?D3yZbtXhzSfY9BgXPODqzG7I91nXwtQIQ73N209wLqCBHfdeuUMGiNRmGH6p?=
 =?us-ascii?Q?M8srzja8TXuSKYl79ZAWNrSf3MuaR7EVNZnvnfp0LoHWwYxKSCNRKGLbWxe3?=
 =?us-ascii?Q?GcTEg2e1S6zT5FGm2sU/I1nYf9g3IkvefQ86uXxt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3ac55f-d861-4a48-ba0a-08dcebf744c1
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 02:24:02.6365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7ldV/pTBksyiTYovdiIL0te5E1fGSqTxijiRzB1EkC6xD7Vkl1OZwrGHbisYZvx0D6FFjSHaatPgN3QtOcvmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9378

Add i.MX91 clk driver which reuses the 93 driver and removes
some clks.

Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 64 +++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index c8b65146e76e..4d1123f51903 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -15,7 +15,11 @@
 
 #include "clk.h"
 
-#define IMX93_CLK_END 202
+
+#define IMX93_CLK_END 207
+
+#define PLAT_IMX93 BIT(0)
+#define PLAT_IMX91 BIT(1)
 
 enum clk_sel {
 	LOW_SPEED_IO_SEL,
@@ -55,6 +59,7 @@ static const struct imx93_clk_root {
 	u32 off;
 	enum clk_sel sel;
 	unsigned long flags;
+	unsigned long plat;
 } root_array[] = {
 	/* a55/m33/bus critical clk for system run */
 	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
@@ -65,7 +70,7 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_WAKEUP_AXI,		"wakeup_axi_root",	0x0380,	FAST_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_SWO_TRACE,		"swo_trace_root",	0x0400,	LOW_SPEED_IO_SEL, },
-	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, },
+	{ IMX93_CLK_M33_SYSTICK,	"m33_systick_root",	0x0480,	LOW_SPEED_IO_SEL, 0, PLAT_IMX93, },
 	{ IMX93_CLK_FLEXIO1,		"flexio1_root",		0x0500,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_FLEXIO2,		"flexio2_root",		0x0580,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_LPTMR1,		"lptmr1_root",		0x0700,	LOW_SPEED_IO_SEL, },
@@ -122,15 +127,15 @@ static const struct imx93_clk_root {
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
@@ -139,13 +144,16 @@ static const struct imx93_clk_root {
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
@@ -157,6 +165,7 @@ static const struct imx93_clk_ccgr {
 	u32 off;
 	unsigned long flags;
 	u32 *shared_count;
+	unsigned long plat;
 } ccgr_array[] = {
 	{ IMX93_CLK_A55_GATE,		"a55_alt",	"a55_alt_root",		0x8000, },
 	/* M33 critical clk for system run */
@@ -246,8 +255,10 @@ static const struct imx93_clk_ccgr {
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
@@ -267,6 +278,7 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	const struct imx93_clk_ccgr *ccgr;
 	void __iomem *base, *anatop_base;
 	int i, ret;
+	const unsigned long plat = (unsigned long)device_get_match_data(&pdev->dev);
 
 	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
 					  IMX93_CLK_END), GFP_KERNEL);
@@ -316,17 +328,20 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 
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
@@ -356,7 +371,8 @@ static int imx93_clocks_probe(struct platform_device *pdev)
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


