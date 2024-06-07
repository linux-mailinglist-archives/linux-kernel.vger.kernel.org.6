Return-Path: <linux-kernel+bounces-206150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F49004D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B8D51C20F69
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A9419AD88;
	Fri,  7 Jun 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="aOkFs+dr"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513E019AD58;
	Fri,  7 Jun 2024 13:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766773; cv=fail; b=R2pRQasWZxpvC3Hl48w6aiccty4lmeTkqDAqklcWBwoj9amtQdmlrnTKinoMwoqygfoIhOgHQna6y3iFfHy/JAIwoX7y4fte/P38GpeeJjNlPhs/UKUngs999kATGPW0WkVblXmnqrSpYkZVGZ3gXm7v6sFj14pJYMC+HBuE6W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766773; c=relaxed/simple;
	bh=Hin8XZG+ZM07s/PVVMWOj0mgElZ2oQPM6Zhs6nOPcTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uefqET+vJ5q4P/SP+9BIFU0wURxGWe2w1gHRslWyoPObAPHUZtBvoQKtpt/GA2X6kN1Yd9oGXXJT0JG5Uk1q6JxnuZr+Y35iH63ZAG1i3H/mxLKgKqKFKaz7zM5eYAAfArh7YH+YR7bi6+VNEiYpQ6TtbokjQKuVCxt7lcGHgUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=aOkFs+dr; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCJPx1v8jWigVHlTPOIOgjAtYRBvAKzdIrmgRIkQVQQrJtehn3aMwjt6fOithyclDAilqqQLcs8q81J8Djwrv5T7FPAIlt1r4jlQcCM8aWwE1MwoTdXM8hLcU1Y5nfERhkxAVsE1DTE+zdTMOxVSufVl7flVM18rOnGasuBR1W6I5V12r5Q0H+7KTx2reuDdMmEn9ChVCwZ012Yl2bHBcl6hAsH2KorwMajiFYm3D2M8g0jjLu1KDdn0roctjSor5NtFsxx4JK0g37zF496b6dj1b33VkEZnsw4vUvVTvVmRBbBMiQm9E/eS3vzN40fxy8qfw4GIo4xAFkYCYnaunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRPX08fdxNqNP9Fr18EZvvjdw8lI+Fx74YhQA+6FV70=;
 b=S+v4eDo45Zf4yT6VOUonvgCFr2yIMKrLezuwlnU6Vsuy49HxHMqlgEcJ5Do8/oQ2nTKi9v+H95u6CNpp0YtJvUZ1jiHXKMeIZ77Yez310WhRlDKamrWqmRp44P2LLrXAJtTRCQb9W4jbTcF9gb9TbSTl+0vyxM9bVsYsN2x2FGqvWRQqDzk6aNVs2cYy7QiBz2rdpJ/rGr9xV5/95tWDK/5eqYp7ji7z1691lYv1X/jBcS+ME/5Qh1Sr3vqSZDL8d55COldurl7mJfGoS529hgQzbvhsa0iTN/xnMI/uIc93Pxk9kw9YFS4DFeGSomAkMPU7n3slS32XFm47mRHtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRPX08fdxNqNP9Fr18EZvvjdw8lI+Fx74YhQA+6FV70=;
 b=aOkFs+drBndMxEOnAkjOFHBD296Fa13bbiGL5wcD1agjou5SbgiUC+fOXPiozLXbsDKNbMpzXYU9SjvqK83WlLeydms5Ul2lNfCH1cNPCWRAPs5m2BtTFFnGHgpNUHCL4/ySgBe/Br86vZJEjOB9iBxz0rgs94Z/tZotaKjv1ow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:26:08 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:26:08 +0000
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
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 13/15] clk: imx: imx8qxp: Register dc0_bypass0_clk before disp clk
Date: Fri,  7 Jun 2024 21:33:45 +0800
Message-Id: <20240607133347.3291040-14-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DU2PR04MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d28e056-4d1c-4805-b2eb-08dc86f563d3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0xYKZgqI2Z50yqNv4ZZGtOyKtfCx12OPmiV+y0HsmvDkEdwlEWvB0VsRf96A?=
 =?us-ascii?Q?riaRSiL3h84/KvaRN305Qpca7hbYRcm1o1QroICLRvNpbbj6IbEHYmZE0yVV?=
 =?us-ascii?Q?S0Ve094KduhvmWLyeDE3YQZNFqMMINnfYqq1+BcKjIt106smFLeRHVlpZ1XX?=
 =?us-ascii?Q?ucFU7+9zZNCAC3oETTgk2FPDS8mfy9xLT5apR4vgKdQEcD/uuF0cxgfbSgxw?=
 =?us-ascii?Q?Cf6nH/av5jXdNR68WQyW15VVP0Ihy9KGhqLpK2T/Il+90oA5aSu7V4bHRkhu?=
 =?us-ascii?Q?W4tf91DTtm5LND8ZF6mqVkPt7IbVjviPwQeIo+ffFsXelOdbqAQ9+PCwPEnx?=
 =?us-ascii?Q?njEEysoA4iYaT9kCF/NNryU4XyEREIUPhBec+JG0KppUujdsmXzgLuCHqx7L?=
 =?us-ascii?Q?Xt6KW+amy2XMRSDntBnW/Df9fKQ5odNhyuDwUp4lekBUFUqz1Eh2FONGfhbZ?=
 =?us-ascii?Q?0yyZsz596fz9n2NTe6RcfqjU0bQo8lVnt5AFtTJOi9aQ8jYPIvB+qzQt4yOq?=
 =?us-ascii?Q?jhTez17ZKn8wvwdB2x7jF5Ct4Amvl5vwKUwAteAdsZpEZIbQOD46ir1bRWBA?=
 =?us-ascii?Q?l9ZSVXi65p0/cuUK+x3EF6BRnBSm+IdpfyStRIjlUy4S6iS6mRqUd0UJasHl?=
 =?us-ascii?Q?BaEPuyLIyHdvaAZrJUA8QLsAdZ5Z81MjjS3YwfEH7vaQcxhyr7jP8cqnLA22?=
 =?us-ascii?Q?d+XUZknso9UYRkLLwqDo4e4DINcCUBD9h37y0gR+uTOYj+8OyNkua7En5Oq8?=
 =?us-ascii?Q?ARSHOtThAQjnhDI+LQyBdqdWNVLxCfoi33gWzvPdbp8EOQPznWhqNyzC24Wo?=
 =?us-ascii?Q?uC/nTMkrrAoa8MX0NGziHxQYmu7DuWoU5YSH/+ijlolBpVi+5bKK5+KS1GeP?=
 =?us-ascii?Q?ZlMw7IS4mMOoCzaqy3uy9wo4wt8qXD5AkfnqshimDt4XFPT8DnmSEJ92l0bV?=
 =?us-ascii?Q?AXb3u+4YAxvbR8SDdnbe77PjKtfwPQp5HZtMXEMipzuFiTRjgMijG+4lie3j?=
 =?us-ascii?Q?bqeL1jdM34nI/dp0m0gWttkppwd8O0UICqClgkQIdSci9Gv0H9k3So6ZYQH2?=
 =?us-ascii?Q?t5+mCIweQjl1z4kdl5JPLJqDHlPJGapGG04bkLm4KJvmbmU+yG4j6ZUWI5d3?=
 =?us-ascii?Q?Yz4fZT5gU5bgKpLl3d+ysaSY9bx2syI+c39OHKheFcq2/6yOmKjUmXVNQ9MZ?=
 =?us-ascii?Q?T+LXGS8oBzPpuOLhnp9opEoTlpwoy2W7U/FuSNefNu0UEWnpaC6HL3VuxHDz?=
 =?us-ascii?Q?GG1Fr7Kgv7nJzjpAfa4P439HMMxbLMLUGbJfNNi7ml2sDNHVIWzyZNCmAR0i?=
 =?us-ascii?Q?R89r0oSy2FJPvjIlRp3e2nPqGi3UkpT7pVnSOzaiXXgnSsObcw1ZbZcYa7Cm?=
 =?us-ascii?Q?f/KXKuA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Duvnjlx8R0Dbtl7h8oMYi46j0875bEbgYGquuKq3UKVBrhfLUgwM816Zq/cu?=
 =?us-ascii?Q?uQCuRUx7vsKxyVDOo9pksdLCb6ao51WTejM5FDBkcUtWa9sstaNx3asKKYRT?=
 =?us-ascii?Q?DLiHEGcyZ/Dt9+PWdvp3AVXWEGNlMyhP0OnZJ7gTRJwzlIROizYvMs4VaSLH?=
 =?us-ascii?Q?0tCtjSPxY8KNvhQ5+CprQFnGSzei2UKAyawcSZEzuUpjWgV8lkzsHjDqaaxo?=
 =?us-ascii?Q?jQuNCLPL3fY9nQhA1MU910slKkEfcBi5WlGoXqP/Pah66C7Qo8TUXpInR8VY?=
 =?us-ascii?Q?jFLZXF0Cin0VlV2PaOSibhOOqW9C58xw4aX/DWQFVmxDkTqS6d9kEEhGa8W9?=
 =?us-ascii?Q?DTJP9IEXVJlwXASXkTNEdxdZKiPnurKCPVmMCtIf5cuS/OnhMS4F0osEz0Ar?=
 =?us-ascii?Q?fk/q7XFOdCpu+4nyaiwO8W22Las8D5124nu3GJWQw2k2MpRwpG/5ByBMS3kN?=
 =?us-ascii?Q?EJV45Umak3Sk7TLSeq/FVyiPcfM6poN6b/q01wqLkXRI0wNW4HjHMdwg07sf?=
 =?us-ascii?Q?NZuIFDHqnG/W4OcDYlnSYUnq3RPevWJZc6wOAVtr7QflHm8cUqLh2fziH66J?=
 =?us-ascii?Q?+rf69P0TGj3jpBmobT3JkKD68bJlnMJZOeYv8LaWqASRzxXDX2iy68H6SU9B?=
 =?us-ascii?Q?tyiUV3qhX59YNQr/HY42g793DECp2jrjrfEQBTFPdOZM1QYNvnR2sGeGq3Jl?=
 =?us-ascii?Q?onV5goRD/dzm9xpcRuOzHaYsL+fXQahvGHC1QdCcw6PAonvNyu607sueNRAr?=
 =?us-ascii?Q?gfnGqPMQMDpL/wuCzgnouKiMDqj1MT+7vPqTKC5T+xX51xuf/hW6zbhqoVhf?=
 =?us-ascii?Q?QWUsThA0CMhSbAVJo9kY70URKjQEqk7DsAObRp3izvtWRblOW5wQBY08aucG?=
 =?us-ascii?Q?NsvqBQqZEEnh/TSpVqq9nT2ZR6ZM9uCJ1XAG7W3vunJvGafER6I3StBMmEm3?=
 =?us-ascii?Q?QxcZ8RPJe1tC+LQK+skPWlP19enw/RtTVRZ3uQ5jsUzySDDGpNXouLH7LnUD?=
 =?us-ascii?Q?m8A25fBu/nt1eg5QAAF8oQIr3cLITCPFlW+pZdi5A9QViysvR1u560S8Qy+j?=
 =?us-ascii?Q?LQI5p1Lw/WAUH0rQq5KPgZ+E8ucotmhoUfG4OwhYJWuvH/JPV7C5pFgLFTs4?=
 =?us-ascii?Q?EWrvyufD4rMzyghRixDXuaPVwZl20MMpLldXS42qNGUozNzsFaWbrCctVgDo?=
 =?us-ascii?Q?UnitOQ9lxjXeHrw5lBj0kiNv/qKAqrh6ifysxbqjuetAFtqiQx8kbT7MmFFj?=
 =?us-ascii?Q?/oxZTsa5mzLNsdCxT2vabvLw3AX1dyFrnAq2FwNsGAF4pFRIVbISgpZixlNT?=
 =?us-ascii?Q?uGgC9i5Mip9s89/LzRHCVYBM0JbzmIUUXt80zOUKaMenbu5npwYEJRsndnk6?=
 =?us-ascii?Q?ZoABdjYaPWE+bfMDme/8IlLsTGFbUmPzspXVCzvlIYytLyrcL8byX0hFQdtZ?=
 =?us-ascii?Q?tkTvR6IWb2gpm2817N8V3tw6+wsSq6UPCSzn1XQ/i7wFlHZkc1gdTROishZg?=
 =?us-ascii?Q?Xkn1C/xx62xmgqK53VyNoVNXZS5dktXQIyx0uEC1YMLzIuC18/i6Wfo+3Z3R?=
 =?us-ascii?Q?bDPY15Qtm3FXzoRlthJuJ3yIz0R22wRtvDsV8itF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d28e056-4d1c-4805-b2eb-08dc86f563d3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:26:08.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+taw+49+jYkF3oSugZBWNGhaFJpM8AtezfQBl6nb0PsIIINL+kU9X9TGMppwMXtxe/garE2S4gBvA8AVXnSVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9020

From: Peng Fan <peng.fan@nxp.com>

The initialization order of SCU clocks affects the sequence of SCU clock
resume. If there are no other effects, the earlier the initialization,
the earlier the resume. During SCU clock resume, the clock rate is
restored. As SCFW guidelines, configure the parent clock rate before
configuring the child rate.

Fixes: 91e916771de0 ("clk: imx: scu: remove legacy scu clock binding support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index fe6509be6ce9..47f4ceab1179 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -222,11 +222,11 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("usb3_lpm_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_MISC);
 
 	/* Display controller SS */
-	imx_clk_scu2("dc0_disp0_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
-	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_pll0_clk", IMX_SC_R_DC_0_PLL_0, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc0_pll1_clk", IMX_SC_R_DC_0_PLL_1, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc0_bypass0_clk", IMX_SC_R_DC_0_VIDEO0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("dc0_disp0_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC0);
+	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_bypass1_clk", IMX_SC_R_DC_0_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
 	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);
-- 
2.37.1


