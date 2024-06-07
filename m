Return-Path: <linux-kernel+bounces-206143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DAB9004C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F611F214FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CC3199E85;
	Fri,  7 Jun 2024 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GC0+Odpw"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A04199222;
	Fri,  7 Jun 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766736; cv=fail; b=kId889LMDqDI4XhuiybX9XnOYfHW6thmwhSQ1t8YbBuZAk+k+ayrPl3Q+JDc0CA3nvT9Z7npeKNmJlFXwa6hCopaA9plABb1qzOBw6m4cOg8tpk87SjcePPA1n09XKyMRVE7ou08gkLPyEJ6qLSUTeryvgoyPhENeQNkpZMtSnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766736; c=relaxed/simple;
	bh=PSjXT+k6Fxy7gFIVyoB3y5GuPSoSlR9Cj2YFxgccOhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S4zZDjHnBq12+aZm9TKKgwThQXWPl4uu28IF44u7KGbC5AYokIREdejI6/rky/c8Sdi8B2SYZiny+1RgrlF62myn1pj2ubs+AmSCQftd3ORWv2nvkBborqwCz8m+XWyN7G3xrCE5oekHq0pM00zhkn+m054De/RiX8AX/Um2QFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GC0+Odpw; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRfp7Jxi/ejfq4gl7Jr+3fRzVjhcgXAVw8d7l2AT/RlfEqDiT0ZN3rOi6Bov+2+iFarvmNyJtkLNaTlES2sfCl7puK5RIRHxpXQRb74r5wO/VullSZFxhwPaI73q6AB+MTZcTO0X8ulTD+viq8LC7neEOuzKtbQO952edgQxv9TcLGyFpACEu38O7w08Y1TW/bZ5qB/juwiAfEdmSfs0toPXLa9Kt5JDA6wq515mupq4YS5tQMOfzLDSg7Jwi6tXaGAGL7pD3w949HzhS1triu0f5nalUO9LOKaGZ9ewdlnxBOdYxyQ2bv9aUarzkBPaT7TaCI2eaa8JGCF7DGPhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czXHM1+CEsAPPreOACA9UXclXD4URmA4vbbLhAjEV2M=;
 b=JCyeIwlMgPTRR9D7jULK9McGciLP0a/+McBvneOLRqpif00gIEmZgR8DaVq1QEOJoMzS4FoDWmb0jCg9gQhbbCy3kguzBomIMejaL8l/G2A5lzWEEAgJH8abOs+c/HoO56xzPbusEFS1xmxv5gsETkj091d0cDTcHJWyH+5ZAPqocB63OClqRA7bjFhbF5TKzV7lrxM9CDQZFID3c4YIAqZ9pBALhrhhHcRGenQ4pqs9merk7UjJ6HjjNKjlbAl4py25jUNctZhwV40mDd9KtGRmmmxEFoGgk3AWokflkPvy7eUV9wa7iQOsLtXk/xecIBAJJ/q+p0m/jeMlskQi3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czXHM1+CEsAPPreOACA9UXclXD4URmA4vbbLhAjEV2M=;
 b=GC0+OdpwJe6kV49aMnEL2S2eGgCYGJOCIr4TefSG7Mgog7YToSGESyocpH55xZC4f3KLT8pT5a8HXCzLLwKlyxov7r7jtrP2w9qTqKgZ44X+pFZF3D6dGCYJpypd4u4oaZNka2pMDva4f1VI0tLJ+Bb9bNsOWVFHLKA8MTmkko0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 7 Jun
 2024 13:25:28 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: abelvesa@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH V3 05/15] clk: imx: imx8mp-audiomix: remove sdma root clock
Date: Fri,  7 Jun 2024 21:33:37 +0800
Message-Id: <20240607133347.3291040-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
References: <20240607133347.3291040-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To DB7PR04MB5948.eurprd04.prod.outlook.com
 (2603:10a6:10:8b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DU0PR04MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 890edf75-0b63-41e9-6119-08dc86f54b8a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2+uAOtwlwF+yqbiJgck15891zoMLu2/5YQLsxTILNQ/QBpGZEr600hgP8FoM?=
 =?us-ascii?Q?cijeQ2qRnYbmJ9yl6NLpqjLO9oO+ZagHrjUI57eNf/9cwSPvfhD/rV2KDfPU?=
 =?us-ascii?Q?wXIutT5M4VL7OfiJy5SoSzlJXbguux0o4nN+XPt7AuBnHcQzNk4q97oI6Rm3?=
 =?us-ascii?Q?8DzyavPqyGb5S9v+yoX09pmM9xloK1YR4NiGHJmtYQfw75JP6uxCoMr1C7Nz?=
 =?us-ascii?Q?yVywr8ldJ5azg4H006miMh8/4O3Guew3xnvwv0XsJVITCkFoBr8+d2WuoHKF?=
 =?us-ascii?Q?NPcd2KuXIhmLh/smKAd6/5NomZDQwtaIS1hk3oRUouP9KdoJrnpuAycdYcE9?=
 =?us-ascii?Q?Hrx6NE4RtiVA1pEwFNjCJGjcDCzFVWHymrYEr8kQVqWEHfsyW98WbJ5ja2EI?=
 =?us-ascii?Q?aBIGBpxW70/HCLPUCtmZktsIfOO3t53EeZBtF1p9/W4F5nORdim9sCHmc931?=
 =?us-ascii?Q?awgjZGI0pr/mnpnaU4uv7SkAaN5g5W1Nxh4SkmU+pgI8XfZSp5wpU85JxXnk?=
 =?us-ascii?Q?Y/YVGEqVkfhv90Fb+gJkrcGKYjch+CxgwWRxQedjFBXYtZ0JknOFOsdtabTn?=
 =?us-ascii?Q?5eyuj/bGZdDEcfoWmLOmeOmiYGgU2P28GIfIWdLyxdgqboqyUL9zjZSTPtYl?=
 =?us-ascii?Q?EDCP4W0u7i9U4DU0aPPvOOaHKlLqo6NWpJvK38hAzZ2zY7OEcyMG5Fjh8jQa?=
 =?us-ascii?Q?NjziJXZ3R6g55htCeF6XN/iZsFa/KArCbXOrNEUeSQ3PnEKzvYkVDTbZKJVp?=
 =?us-ascii?Q?jKnclnyStE/rO8hAO8WPIZ38cPft7BhtdyLwCGvFfrBcZ5roBfmt9GjSOJua?=
 =?us-ascii?Q?JtIcVCAXQ2fQ29YrlbCbYC+cNs/8wml0AM1Rm/p4gCXdct6iYqncVWIFWeXh?=
 =?us-ascii?Q?HJjYJ9vQKDEzy/xzAOsf7ZGRJkVV99tYK1BAwcEemTXlyS5eTVHqj/xO32Fv?=
 =?us-ascii?Q?dF0etTtzlSKLNbaSBTeYxYc06sDp040zt3MhIk0rbgDSBha+K88l67I695Pn?=
 =?us-ascii?Q?V9Rkd0P62K/8XxyI9da2MVrDyhF9JmnG7bwPPcJXBgVd+H0aJE4NZUNrFwIx?=
 =?us-ascii?Q?fuRFY1bWtkXnjNuQmewugJ71D9vtwtg3Y5HPfm8eZpXRD2RC1TdCL/OySTba?=
 =?us-ascii?Q?z6a5nsJ21Du3pdw+/1EqvI0nOvuH2SXJSuPwg3qF+V2AQlZENXifZLsYCv+v?=
 =?us-ascii?Q?FOWZ69omS2mHJY8QYxxoyuAS2gUXIE16JqS5JI+bPAYG8muYSNV2Vrfljld2?=
 =?us-ascii?Q?B+sLSeWpdIRtAVBP7DpV7hEpLmJdv7yRaSi6KYjWLNWwJV8fxX8EdgCI1N9t?=
 =?us-ascii?Q?YdWtL35uQKZeG95BkeerkpFzLQ1/0zqlVkXMTv6tiLttXeGWLRTIhZHlrGz7?=
 =?us-ascii?Q?Nq258cE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o06Keee4RH+jymJcXcwYT1+twmN5q7Ae0Fx/w5MNY5GwPx451RMUGj4swiI0?=
 =?us-ascii?Q?ff0cw72ljw3GFJE7AjmpJ33c0eXChX8KB73Jgh7is12+xO6SgiUqpNYZMcZN?=
 =?us-ascii?Q?MDebx2ew7unTd07P91UeR1DiqY/iC7jyzf3zfGY2hTe7KRKgY9UDcyYFRgl2?=
 =?us-ascii?Q?TXVn416ZyPYSNWTVeYaq/11a9I0BE3mcG/KYDrif4r2fea9lbrzOFqhJOqyM?=
 =?us-ascii?Q?BD4rIct4aC1npqEDz3R90U4gyH+2niVkiCSbByi5BfiOWCeSDmkH6ef970Cl?=
 =?us-ascii?Q?d9hlsLPHmFAGkdRaaaZVKz0oQyaLDSX/Mfjylt7rKJpZW0XL92Yfj+aP1np8?=
 =?us-ascii?Q?1BHGf0ae0EZ2k2qz1NbmDEUQHXxYH40nsxL0H7MF+JgWgvIA5bIhvCNzlBKS?=
 =?us-ascii?Q?a1gVvZdH9Xbuf0aLIhrBKu7KH2PS+35sask043HYlCDy0cbaPJNVMd9tFYzd?=
 =?us-ascii?Q?JxIMwKvVL+tCfOX5zl4wot4gsRiwZMwzVtkucWVegUeNqAU2hgeRGoaEfQ0M?=
 =?us-ascii?Q?x07IJXFNIhYPy34NOAdj7JgFW3/3J4AHvUAtpSKaiKnqTLMtbwRW88qpgUZB?=
 =?us-ascii?Q?AS5GfTsVItKpahhAzE8AdFzXoiCzsKueCQ2/Dja1eJ1Z5Y6jYGME35wv14sm?=
 =?us-ascii?Q?BIvGj2L/An3S+hmtYqozQIaflKvRwNMLrAZPt9VuTvZYPdmA9cGq9oP0/0EJ?=
 =?us-ascii?Q?GJPDQdAKVnuQYC8oz/vtGvVf9mv/v+UMr8F1IsvP0pke9JDZ7zs96x7TAy7D?=
 =?us-ascii?Q?mIDzCnVU3ePZ88ZYxGk1jMuu0XhoKt1Wx2xe71VNh5NKqWmcFAWV8M9hEZug?=
 =?us-ascii?Q?x+IsB7Daw4b3m+s4gPmZ3MaOU73fqhBKPLsP4tNyEt6WITRnio5xN4QTblMU?=
 =?us-ascii?Q?ca0xonSoOnCz7g8erqBQQ3h7Vb+LrykCTVXI1J16WjaUvi9OwNbcAZVsyOD5?=
 =?us-ascii?Q?YSUYxwAr/5RGVbe7oQi1CmQ7XYyAj4vzDRQ2pt4H0ZgyX6Pjzk/xrwIEb58M?=
 =?us-ascii?Q?ByfkvjfCbs2QyLmUDherawCijPP6ZLKftXQQe7yrqplK63/T9KM9hqOrCLvM?=
 =?us-ascii?Q?jsoFR48gR0ISGR5gVw8F1H/h6tyTbjvPvEQZMXvbonBvzlOj092yZQNat+ZT?=
 =?us-ascii?Q?rxzMe3gQbqU/oiymoQ3wO+YrVlRKdLX0w2ulUK9T2cpL9mBxloIdH8RFloum?=
 =?us-ascii?Q?Ioq12MaM1zyZRCy22bFlru/QQ26Ao0sWzxibYnhgEAW5AQLnA4G+Z1oiWl51?=
 =?us-ascii?Q?WQGY0YwrLeC4pMbXSz2t80AYdmfZV2axGQJnsy6lIr63PAb/uOfou2ImqsyL?=
 =?us-ascii?Q?5tLSccGqdah8iG4gCwqlwkb5MKo6Qt0EALhfYkub3oDxErNF2lCM2WMBvhFc?=
 =?us-ascii?Q?otIF2loTstbWpxbQVVWeQ++q3p0SdmYyM1KovYVxIDk7dOXpuU4c4Y3fNMix?=
 =?us-ascii?Q?zd8Oh+zK9wMNx3wBcOZb7bU1ypAu4Lsy+J2X143q4fbr9KMqB+mzvGmursb/?=
 =?us-ascii?Q?MIPVadzkuCuq1sdSe51Cz7HAVnWGrp9YhqnaMDbhM/6w2uNlCxITtuSN/buL?=
 =?us-ascii?Q?sqnXb6P4KY1vLFkr/5NXV4yflKvrX+LJKeucV44d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890edf75-0b63-41e9-6119-08dc86f54b8a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:27.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeET6vyhCg/uNcVES5TbfnbcJ8b4BTIDyb6lmr4RUEBdKVIW1vY3ia57IhXUhpg+VrNoxZdoGVjtRnx67x35cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249

From: Peng Fan <peng.fan@nxp.com>

There is an issue:
SDMA3 can't work without setting AUDIOMIX_CLKEN0[SDMA2] (bit-26) to 1

The workaround is:
As the reset state of AUDIOMIX_CLKEN0[SDMA2] is enabled,
we just need to keep it on as reset state, don't touch it
in kernel, then every thing is same as before, if we register
the clock in clk-audiomix, then kernel will try to disable
it in idle.

Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")
Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp-audiomix.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
index b381d6f784c8..88d8ba975b5a 100644
--- a/drivers/clk/imx/clk-imx8mp-audiomix.c
+++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
@@ -172,7 +172,6 @@ static struct clk_imx8mp_audiomix_sel sels[] = {
 	CLK_GATE("ocrama", OCRAMA_IPG),
 	CLK_GATE("aud2htx", AUD2HTX_IPG),
 	CLK_GATE("earc_phy", EARC_PHY),
-	CLK_GATE("sdma2", SDMA2_ROOT),
 	CLK_GATE("sdma3", SDMA3_ROOT),
 	CLK_GATE("spba2", SPBA2_ROOT),
 	CLK_GATE("dsp", DSP_ROOT),
-- 
2.37.1


