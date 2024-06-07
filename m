Return-Path: <linux-kernel+bounces-206151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215DB9004DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD9A1C20987
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B80194AD5;
	Fri,  7 Jun 2024 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NsQaIwVm"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1019AD9D;
	Fri,  7 Jun 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766778; cv=fail; b=euWvP+x9z5IQ0a+eqEh21hrO7af3Ggi8DttpDf3QySb4c6BAwivvo/WI0tjxXaS5dx+/usxxePCLZJ8LbdyIhB7MYM4M49yvXMQGz8AiCT3nLWr1P7lyOR9Ly/+bxXDc/ngu16uF21cF8OB5qb2YckAta2HeyFYA6nCmTv+qKEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766778; c=relaxed/simple;
	bh=DAtln0hS9ESg9HdiTMH193rDHwvqDGbFVdaFpskCbkQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qjoW+SUxu9DpBGmLUiDlydqDI1cRw+QbxMmpw+nrNKMssC0mkCzPPvAtscjiZhStMe8GUIFzWLSO7l3uhXhT97VfL5Bj9cZhNFbH5sQP+ue5LRXNf4cd70n4csfrhT0+/lM+QPIf00CQ0KRabkReOCIl4NwoRnd7zwM9PH6eEYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=NsQaIwVm; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+vaaQMSQSf3UPoOMltvDiAf94X5rRVo725PkvwMYuGNqVo7WtAZDlJFvA0rDYy0QVmmNNP++YI/7izZLp31kyaaZznue2CN4kc/f9J+rhbotUYXSg/5KThJUL4vsL6v1S7/nC9fhayFpe4+IAEaFVvsF68DFG9vvYQiLrJbLB8a8qEdA9VdEio5zHSwzkzn3Swjkz0NhEUTHk3mF6pKIbUBH+LKH/iiKWXpV7iFao6w1VkKrWehowIN5KXNNZ2uBYKUH0iEYleDJiZrnrRtyQi7zW4Cge/aKvP3TRJaV9rkCVuTsTtRodV5waOYvHxB5et5wytH7x6GgH4c36RxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aULyerQTbMPwwykQsB4jIb0ibvLOOqWXxjF521jufAs=;
 b=f9fICEFGfHNXZC2u6FCYMGw7ZuqEVPFgbQlWaCmsl7d/nOY5QbU06mZ446Nez1se8B+4Ki0yWZWKENFEivashiJ5wuKOHRpRvnv/YbIgdWnW3wqA7qe0vTPYVQ3AfntbrGAiPxT6zrJ26wnlRJ9/63kG4QE8BFkFfDCKCMvf0z0L+5v8fVyD8WmnoIyp3cDmZaXQXgvM0+UMzPxjL75xfB27XWU4CghcH9SN5k5ERwQ/RH9QGgZXCehp2wPiF+KL9Se5guEsRlU99w+ehPH9tJnwdNsgTqRc6dh7DerZ6RZSNg44jR2kBGeRZTOZ7sbPXU/mWWpPNR6hlFtiIl2TUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aULyerQTbMPwwykQsB4jIb0ibvLOOqWXxjF521jufAs=;
 b=NsQaIwVmDxtg/h3mt3AWDBZU7Kp96rljubV/IWV7ZerbjiJ4IWaXcB54tLRzE/NUN25nCfDolQAB8b0aSKq1ooJefAeqwfIAE/+Byyc4T1fcHRDi3EqMllUcg7avRM0UiqLHnM+DkRYRz6SAP0ZrLM3b0Q8IGgwCjZj7m5P0KMU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:26:13 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:26:13 +0000
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
Subject: [PATCH V3 14/15] clk: imx: imx8qxp: Parent should be initialized earlier than the clock
Date: Fri,  7 Jun 2024 21:33:46 +0800
Message-Id: <20240607133347.3291040-15-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 796d14fe-104d-44e7-3e4f-08dc86f5669b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UNrbfxzJAQdSJumZsOsdHqGt8r6es1IoUoFX50cdOwKUI7EliO/5H5du6uVA?=
 =?us-ascii?Q?MIZ7gL2ZuVmFdfkumnFk1/80QlCppzsZdIVWa9Aqz9piRlcg84EV/ZBejHD/?=
 =?us-ascii?Q?9veTzo+752l1INRi+Sn4/prw17itZZa0NzFqVVXclKVSgJW77M+tzDMY3X1z?=
 =?us-ascii?Q?njmG+WDso4cZ9p/MOIW8vW4QTKVx2US19DCK8va0B9bCwS5YZmv7Ha9PCk05?=
 =?us-ascii?Q?5F3ZQ44QnwyUnmcQQxGrgIJDSIgk9jyCOIA0q+wajm5P+7WJHYheT3YSQnKW?=
 =?us-ascii?Q?H94+UOtktRRit7GMX2vMyEdLIfSfxBV5u3o9xt+eXKjH8pw3B79yYj8kyRwH?=
 =?us-ascii?Q?smGMIG7U3eab47P6EX2YUD54uNH13Kns7479lf2SVgONTpKCZzUwfT+/sHPt?=
 =?us-ascii?Q?shdj++PkJu2klYN4raYnYyzXFE2svRPuvZgZZZW0sEj595MdstLbFaJoy+RF?=
 =?us-ascii?Q?BR+qZ9xKO/nYGAzqXECUCnCPo8E44odklgOX14pxoY2QDyAEmhtnhBYEWiYp?=
 =?us-ascii?Q?A4pGzTvWGe5cKgoG15RJaEcdOfEGKv4SAp7DYaQiL3wCGkiX247+CPP5QIdH?=
 =?us-ascii?Q?Zj02ioGT3N+umOX+MkpSG0ax9WokOJMmvWeCat5hSRlqvYX7XJwDv3sW8HMZ?=
 =?us-ascii?Q?disvCZhCjKVy44ClIY88Mlqjs3iFHiqElPddfpxsPVtmNRAz2jNCF+8fouyq?=
 =?us-ascii?Q?nqU1PZ7WTrs7O02JN+yplzlrFTkWg3x9rO/Ofwa/1K9Y4ssvXyCpV6XywhdE?=
 =?us-ascii?Q?VtQsoUrucLo97l3lh9jaTXYsPLAImOyzwU2b/nZADaZVt6whuQsfUpvmIc22?=
 =?us-ascii?Q?rbmEB7jo/zOxaprYQB9rM8um1rt6+/sGhqrAlXts5f8QoWBkFjGkvrOTKPcx?=
 =?us-ascii?Q?jV/D+RbbQ1mgFfIbFN9bjQ3WpvaxVMNZrLUsq5E2lMdmQUuZNcGhN0kqlif2?=
 =?us-ascii?Q?2oHlIgcJhUos4mNm/WwOrzc5Eq5fvsYKHhPWSmumjZs3KRZhG8GZgdwpUtr4?=
 =?us-ascii?Q?lJIW+XfuQe6T9VKRezqWvOrx2IUxjn0qs+x+Z5+kV/AJkZAvfwX9ShJF+XYs?=
 =?us-ascii?Q?za1MFODFTJf2bIEaMWNUB0ZBk8i1ZTMDZVMXc3PHKQEe0e2wOn186WDAYs3V?=
 =?us-ascii?Q?WdpYCVU+b1uKGZ5kxuoPPQYXtkQjUQcixfzY+YmXV9QpxnWb+BBrQlFrzaRn?=
 =?us-ascii?Q?8Tn1kWJr3IfaTZwhE1Cw4/Yn3WkhQPOQ5A0gmuILi1eqlt7Ao9PZKAATBSQW?=
 =?us-ascii?Q?4CR8hmW6cm1KWpwil1tmYyp+v0yxH5qFKzchw+r1AHNZOcrTPvXgQ2PWCh7e?=
 =?us-ascii?Q?XbktnQto8j0hOzCiiU+VOva6yz4sHeOGDyRgTnDEV7zhj2fO+Qa3WxJLxdcb?=
 =?us-ascii?Q?5Pb+2kU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vn/nL8yUr+s8oTpflzI/vYI8MSCdhLe7D5Dc5V9fV6sscRigW73V0/Uh8yNi?=
 =?us-ascii?Q?RPuMzYbN8r1DOXWUsrAbqRd8baldocucbbR7P5SmKFvF/ivkBk7ulMIecjx3?=
 =?us-ascii?Q?thxLrh/hE1YZvd80kkvIXnj+FNcBPJX6Fc3vLsdSbDvgbzLvDXlcNLkUjykF?=
 =?us-ascii?Q?zBaCcU+QMACZivo1AHGPtGGiD6lH7bIE0FsZI7SNCuTeyKepp+hIqcsK4A48?=
 =?us-ascii?Q?vdyIWTQgtmtqFgpOrFbJIS0rzL3hqZPM7YkQ5ACvEkbw/zMJvirRCZzdmVwd?=
 =?us-ascii?Q?9IujPNsk/I3vyuYzGWZC/Ke/InV4q/4imFGcaCbeyeU7MXX+7hW5knPXvsAV?=
 =?us-ascii?Q?0WW15sr079UZma/54QWcrelPWmRnwhNChd8hpx3UTi2QRfQOSqxnqK7G9oSo?=
 =?us-ascii?Q?ktBxV7c8xk0xyZ9Eqp+MHAtO4abBew13NqHMLwxK4h6iSDFONHgJMwFmODY1?=
 =?us-ascii?Q?R7gssnGbkvZXvVjl7swEwywasVF5PIb3CslIdhPzr1dI5yS9CjYTjYhxDHBE?=
 =?us-ascii?Q?k5R1MTZ9zErI/eOwtAvQlLb3kxPVeubdLyXLtEdG0Odz7IlI0T8/7KkYoZkR?=
 =?us-ascii?Q?QyrXj6cOlHcJGZDx5g3LjYljVMmo7ZswGevhqzjVjgZuXhOV8C0FrX8nsX6R?=
 =?us-ascii?Q?S7/rQeBjlGzefIk5He21XUVYEkUFhpg+pdXgzGobmHhdh3Tyk7L5Qj1T0+ar?=
 =?us-ascii?Q?7GeieYCfKa825ErUIqHokmIf8bsqd05J4VgxE7AQ1o2Pr5iqecKauej2xs+L?=
 =?us-ascii?Q?+E+fg+HdLeMbfInS8ph1Djbfjqd7f+m9SJ4DcpMv5NlJBF+l37EQz2hzyZum?=
 =?us-ascii?Q?MXhp3j5FAy/rUK1VrEyX27mgOLFNld168jOiE2XSp9ntD21MssCylWulaMMM?=
 =?us-ascii?Q?MQAzUv7M5hN71KHdbvM4IW7cDeR2qE88lkAL8xJEDrpS08GBqdCFVWIAZnMD?=
 =?us-ascii?Q?JshHGysuNmqQcKA+HR9iwsgqRBaCosT/52g93uceExu5wIjMoTnP+KgTZD9j?=
 =?us-ascii?Q?fmaT0K65g66gzUVq54U7BDrtzh7Z0vZtkH5pO47Jj869GYVCnqcsu3LkULvM?=
 =?us-ascii?Q?KKPhVlKlzJfFKrgB917LYg7htvbp08CWBsxUU1qdXpN3U1Snta+q5Z2KBTMA?=
 =?us-ascii?Q?1HDgk94WUGjJPCVIypZBeyAMUNcS5S6EVYfFJQpIMt5YCalouYkTnzWuai2P?=
 =?us-ascii?Q?lx6uiz3fZpGurO9mpK2iiJRfaFXkp4mULsMd+exBBKgnexsC0N3ZX9wzA2y7?=
 =?us-ascii?Q?ye1pXCWaMr9d/06AQz906/mRLZsMu0TfYgZXazJxAmydx+gHYgPc5MDsJKjc?=
 =?us-ascii?Q?O/O/uZh3UWfnFre91XZxGQX92+ifA7BQ6pjnv1B3ZntROMB2N/YtWGXoiRuU?=
 =?us-ascii?Q?TLkKtc9TrAaHGzn1CbcgiKwEhh6+sajpLJZ0bbMFhcPgLNsFKHQp2vhmxB3w?=
 =?us-ascii?Q?dVe6LZh61GpPo2bVSDosY4jnQQSKS7RZmwpvzXVSTofTkxlP1PC+T7+PW2jn?=
 =?us-ascii?Q?EuUWBy4iLoMi3Jq+v+A4E2Y0YoYC+F3ko6ObCHXcB/zsIZojxluRKikWMzAu?=
 =?us-ascii?Q?H+KGIcs2JFngQG5c+JM6QfTmIysOwJOdxiqca1Eb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796d14fe-104d-44e7-3e4f-08dc86f5669b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:26:13.2920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +qZzpX0CzHxL9LW4rT5Y2vnlQ8WxqdTb7OGgrokQy4Xsaa0x8CAjlaeYrch3J16+er18pQNmtqkEhpKEQqLiHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9020

From: Peng Fan <peng.fan@nxp.com>

The initialization order of SCU clocks affects the sequence of SCU clock
resume. If there are no other effects, the earlier the initialization,
the earlier the resume. During SCU clock resume, the clock rate is
restored. As SCFW guidelines, configure the parent clock rate before
configuring the child rate.

Fixes: babfaa9556d7 ("clk: imx: scu: add more scu clocks")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 47f4ceab1179..3ae162625bb1 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -186,8 +186,8 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu("pwm_clk",   IMX_SC_R_LCD_0_PWM_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("elcdif_pll", IMX_SC_R_ELCDIF_PLL, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu2("lcd_clk", lcd_sels, ARRAY_SIZE(lcd_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_PER);
-	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 	imx_clk_scu("lcd_pxl_bypass_div_clk", IMX_SC_R_LCD_0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("lcd_pxl_clk", lcd_pxl_sels, ARRAY_SIZE(lcd_pxl_sels), IMX_SC_R_LCD_0, IMX_SC_PM_CLK_MISC0);
 
 	/* Audio SS */
 	imx_clk_scu("audio_pll0_clk", IMX_SC_R_AUDIO_PLL_0, IMX_SC_PM_CLK_PLL);
@@ -229,11 +229,11 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_scu2("dc0_disp1_clk", dc0_sels, ARRAY_SIZE(dc0_sels), IMX_SC_R_DC_0, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc0_bypass1_clk", IMX_SC_R_DC_0_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
-	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);
-	imx_clk_scu2("dc1_disp1_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc1_pll0_clk", IMX_SC_R_DC_1_PLL_0, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc1_pll1_clk", IMX_SC_R_DC_1_PLL_1, IMX_SC_PM_CLK_PLL);
 	imx_clk_scu("dc1_bypass0_clk", IMX_SC_R_DC_1_VIDEO0, IMX_SC_PM_CLK_BYPASS);
+	imx_clk_scu2("dc1_disp0_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC0);
+	imx_clk_scu2("dc1_disp1_clk", dc1_sels, ARRAY_SIZE(dc1_sels), IMX_SC_R_DC_1, IMX_SC_PM_CLK_MISC1);
 	imx_clk_scu("dc1_bypass1_clk", IMX_SC_R_DC_1_VIDEO1, IMX_SC_PM_CLK_BYPASS);
 
 	/* MIPI-LVDS SS */
-- 
2.37.1


