Return-Path: <linux-kernel+bounces-206153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CBF9004DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195D71C23B21
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6519B3C1;
	Fri,  7 Jun 2024 13:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ac814FzC"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B3219B3E3;
	Fri,  7 Jun 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766788; cv=fail; b=qCBbJTB1Ls1r1pw5LODx/1TjRA8msyZVFiDJdVDHDnA6H8IkQRf15VGfbBXcETFqejV86E6jtKNZIUQytEp013ni/BRflIq+Sa8QR1IKq3Td2QGfTzUScbm2vx3YYWjh+jgiNT7BQgXvw7cZDnL6XTpGr4/ucPBqI80saWbrZ6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766788; c=relaxed/simple;
	bh=xJBa0WD53HaixdlhZTi1U6QrOzHN5rLI8R9GHZa5RQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jr67xArKGGy+/3g7XJcPtqXidZ1/ME4IjAd54PnYojjAWN10kzKPfwAx/z0ah2lTrxaXBXQtNk2jg2WndMJIcwYe4yLffSEt82iCHGGLZYvbSoG1nFztEwivBhcJpqcOmlg/trHwEoR6dVI1XemMn/Ph7qDcnqL/nFpY/NqnpsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ac814FzC; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB0htSJx3rrJdoE/dT8hD5vxA8JvhNfYZxJyoijRq/PROxSnUHmuiGW6Tte/JfVr0ibSPe+WGM2O6i9LQ/9aXH9fJdGvbBWCUBoYzPgYYWSHrZXlYoO1m4A8H1gIpWj1SQm38zO1Zf99RSj4ZUy5kgN4UWyH3G1n9GuD4sGvDkYf1F+0j71d8jST91AjtScekOUJb/8F0iyz6P69Csz1Grv0mpq88+BpKZEoBPg/Ne1y8J8YpcrnsvDxRRZMp4p9hNfn1lKbS1mEh49n3Q23PKLHqUDDF/6zGy338yht00mtAqsDGjoYam9Z6heslmGjUCplfkHgrz23uQsN5A4CGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGjcDPlfx4EBUGIdAYBES9oDt3BCuZGJnIimG4jRo4o=;
 b=PC3RIoxXcSTKoR1pxWZxVETWXB0nGAJIuBgXCwyq1+GUBu91lXCTf+grQh0DKSlmD5rSntaBLhFWwboDUm5r6TmOyh3MUyLbqJJ2TjUt4uQHevDD3LFDO+B2Jn68hIBlxcGuhdi9QH5nalCDodYoOa6UijB5LMyjTm8tGLG8tbRaIELpqZoKvvknhX2AsoVNrYSPo+KTvOA5G9QEkr0FlkBju4kCucTbjsDB3OjCilMfJSGiQRsasL3PKurWgYuwE/sHaCIejLIvVjRdX3exW9BJAfyMTR6tJiOBexhlCGyjc5e4uxM54BmG+y6DFROpnrMWrDFt2Pa/+BBLY8Dp5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGjcDPlfx4EBUGIdAYBES9oDt3BCuZGJnIimG4jRo4o=;
 b=ac814FzCec8sqitbqlOaO7qdF7jJ/qlLGuteql1x1wXj9Ti6Qio30OSKi2fLh1QQ5lNSnHK9VA4u9Ts+V9SN4jnzK1Oe8vKPZzWvv30Lp0zkFsBvumPdsVfk/6zxxG4QEdVng5hIT15UwrJT555id6fU0CS9ijK6vGH0iNbiKc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Fri, 7 Jun
 2024 13:25:53 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:25:52 +0000
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
	Jacky Bai <ping.bai@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 10/15] clk: imx: imx8mm: Change the 'nand_usdhc_bus' clock to non-critical one
Date: Fri,  7 Jun 2024 21:33:42 +0800
Message-Id: <20240607133347.3291040-11-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 10f4b42a-40b9-43d6-0a8d-08dc86f55a9a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gk5VXua5cTTJOpEPVGzKJdte5YjySLlLRukunzCm+GlW8paBwcth4a32jZuj?=
 =?us-ascii?Q?HWNIfeDVF0nigV3itnIb+8BvElYwsXZP9zbkm7bzCMAjJ9UnbVBintduwfd3?=
 =?us-ascii?Q?KAcQXuJx4gU1WB0YZBEP2XuZRb655vUfsXHvlQk5DMhiXThKxrDQbTitaiPB?=
 =?us-ascii?Q?1YbROAycM15oq1TUdFX3Wz1Cr39QSgyE9kJG6GjCbD3WjpgXbQdCOhIKZtEC?=
 =?us-ascii?Q?tKA7ynH3zOW3Qq9XFJKeRew3XiH5pd+CBPPJT+sb7P8fnyEdsZrDuXTZZm06?=
 =?us-ascii?Q?iUVHntzLYG2sIR5XyCc9Dt2BUS5vvxRuB6Sz1gNrYDoClJxqwvgL0aEbhJXy?=
 =?us-ascii?Q?Icnego6inBkB+aJZA84bNjFnmoU9maO2eI9Cx8wkA4l9MerFvTA7xARPIYxL?=
 =?us-ascii?Q?A0+6x9neNrJznfMXcYbi1sgC/IqSkwgTPfU7Wzzf5tF0mFeE/ijNTT3gh5/M?=
 =?us-ascii?Q?mihJAWp4AmNx3HYkFjJHwVt6Ut+vm8RrFXl3kOZYd1BvIxijMfkVAIObGcCA?=
 =?us-ascii?Q?xcQIyv49trQyFC+hTg0pr6E9ZPfgjZUKltyy43UsKgASJQMDtDi0DtQ6q2an?=
 =?us-ascii?Q?E72vTkivybzY9hQ2e8QPDkPwqhG8U1WpHxatlvp1Ly25WjmCdSnakQaLt3KQ?=
 =?us-ascii?Q?zuvcbOIiMdcZdEWEffpXgKeEGJS9zTmG4NVlTv/O1kfCwM6jQCMReHCA4ybh?=
 =?us-ascii?Q?MRoPctvryyFC4KWoCL5Zf2bouN0ybRDh3oBxoXCwEXp8oQSQoZD0U0smCLVT?=
 =?us-ascii?Q?ejLawwXhBttzVPoThaij9xpNP10vgC8JdhirERgI5kZsyLtK3l/8ZRU+Vz76?=
 =?us-ascii?Q?09vH+ra1BN7kvF4k9lWRI6/K6gkLJSsXm+3HHYUUbs5P4yZmZVLoy3XWayIa?=
 =?us-ascii?Q?wvk6N3WyU5jAB6K18hoU2NJEV4eHq3QPsYh4xkEMohLnskxutlXW3nNLzPW2?=
 =?us-ascii?Q?UaycafBe5tgu6iBrrbUcczym7ZbI8BRng1U6WH0IyHsfmiV3ZY2hxH3n8Yxs?=
 =?us-ascii?Q?kAazeUyjpCnC3ihfpT9mwvy9H8D16UJteLjNx7DeAFxM1/MYxRgfhdqZF5oD?=
 =?us-ascii?Q?yRWV3Y6NdakU0lFal7FeXnRuKOiNVHEZza5aEyuSGYqlTKiN40xg0xjnGmwM?=
 =?us-ascii?Q?OnyGyD56J96KVxCFY4taBfWDPlZyUvdrFsD2cD6h0hcamSiSEa33DcCofr42?=
 =?us-ascii?Q?YIQoONTer6rO6+jBEwPRnUfDZNADOsVmft7kGMkC3BTjd5y/l7cMpWLxFtWj?=
 =?us-ascii?Q?eVjje/Ld2Q+DKu40g9B/ueTbR/4QT2+HJ+gG6qc4TDUIhO6FfrWhYtmOjiKG?=
 =?us-ascii?Q?Gj4Y04Xy9yCBpdhvJDBc8ISCd50hCetvyg+OeXyI//hEFBgTc7JKcO50b5qj?=
 =?us-ascii?Q?68CT8m8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QxE63yjkY/0X/uqEOHkwGhHEpiDK3/snqz5ZWuBhYHLanOe2IbUoqcsF6kVu?=
 =?us-ascii?Q?wEYNwJGuWOSmrrRVeBcibBpLDCHHD6y2mR88FYTp/e5yOMMc3Ugqu2Wdx+OY?=
 =?us-ascii?Q?XG+g19AMu5Dx0SE3dYCTm+1sSEUozeik5clAaR2NlCLGHB2+KqtOe8/+Ffz6?=
 =?us-ascii?Q?/iPh0t+TdqN/wz3ZJvt++lkbdAnZRHw+PBmpC9MHGOkMhbVH19yClVcKlEX6?=
 =?us-ascii?Q?4E8tLo9SSSANvoBWlV/ZYH1M1yUnrQSUWAWz06ATujr1PUao/HKvcQdVLpW2?=
 =?us-ascii?Q?3vTRjtLPLGjyMlTdlT4xJ7TjyBUQCyFmOFAC8ddcOwO8MqjYQcKWjcQnDHBy?=
 =?us-ascii?Q?nEpFv+q9AaqxlbtYE25t5LiKmE9cfErwXPKUauJo79ZZZAmx76n37n3u4Nen?=
 =?us-ascii?Q?MyU8iZBbMjdvuxz4YZANCxoROtox2hybvJIW4aIFDc2tAcP1AwyHqAwBP1W2?=
 =?us-ascii?Q?f2TSqRY77BAhPliLMIikWd9qsiuPdChVN2A26NbEAjvaUwWCImcUj5TYwRou?=
 =?us-ascii?Q?RGyUOklicQyM+N+phkjUMFNjw74YpujHygXRIlaSWGtUabsVGYJWPyeW7Iyr?=
 =?us-ascii?Q?rdyN6RpTehEX4S4i1x2arKleoTn84/Aw+3i8lg07/l4dp1wVSFuJAQtqZaVg?=
 =?us-ascii?Q?R8vNx7D/cYA6RWXWYykdH0vpBy+w7vPGrAtVQ9f44xfep6FyUIyCsRmqBX/+?=
 =?us-ascii?Q?GUBXSXaPGkSX2N9tCL/dnYE12C+lT2kV3feh61Y77pqz0lGC6iPUYA4/E0bt?=
 =?us-ascii?Q?hF64IKWREdy0E4WnW3rOK6LJJsUPcyWKYF45W2CXYErkpibmMqg6kw7I6Df1?=
 =?us-ascii?Q?jF6/Rk0KMsN9/2GoJ6NLEfEARPEfp1xAt87TtJxxOgjjqBQdsi0JiDoIRuAE?=
 =?us-ascii?Q?S/GvJtPVQRtm9MBH9F60HXrLzMLRWJBQ+QClajp3yreFZ+d2FrqHVqxCcI5O?=
 =?us-ascii?Q?a0ygxCA+dUEXxZLWnnJZ7LZMA96kwXtXM+7zFn8ACNmUcfxrdqOlX+KGJyvt?=
 =?us-ascii?Q?DDJgo696KeSZCte9lqGsokqDIZDd8v/6LZvcxinoy+b46UDjNwSuDzGacXI0?=
 =?us-ascii?Q?9XUTKIT8muMLXjAnTYC4GYmaFbe/Qb6rM2DBje5sRRNVX55wD2g+/a9i6ksC?=
 =?us-ascii?Q?ZlQs2msq6z3TKaXWOZRb9tJk0gcBj5HLN0R8R7n5Z7fuQiKKaAIuOJFX6IeJ?=
 =?us-ascii?Q?SIF56l+YvW67zDM1xFq7pyOidkm/OlhvCX5vUOat8A2MjcxOd6XSIYpdv8vL?=
 =?us-ascii?Q?zijDW+0qQizhEU6uxApqiJUJ/msFNfdOhYdlBFBZjL+1LoUsinTX8QO3lGR2?=
 =?us-ascii?Q?7xMxS/N/5uGul+ndks4nOrzya0aXcbU1JiM1EXrx0GJjg5CIt5PkkuNqQFd7?=
 =?us-ascii?Q?Yx7BgqoDQbRCtOMhSxTNytOZe1YqzklKQtgLEo4CMV4/U4SwBom6OcJJLcbH?=
 =?us-ascii?Q?VIme/lcFY7Y1Y/hhd5Cm1avZEHZOubd6j2igyR5mvnI46q5tvwBpWM8d0tRY?=
 =?us-ascii?Q?aV9cKLesKSROpyPWo5H8KCSXvwMn+6avhAiNOR+9y1vzmIGv4RklyutSg/hM?=
 =?us-ascii?Q?sUecniQUuDe4cTrvlQCWKm2uS2kbDa9J8FQJAc0M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f4b42a-40b9-43d6-0a8d-08dc86f55a9a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:25:52.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: siGC96Nhps6B6S53OBq7TXb/Ydr1Lhtilve+5MUcX7ma+lgBZhNoVmWE+gk/r2PyhLgpb/v4Htsvjl8bAdsQdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249

From: Jacky Bai <ping.bai@nxp.com>

The 'nand_usdhc_bus' clock is only need to be enabled when usdhc
or nand module is active, so change it to non-critical clock type.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 075f643e3f35..342049b847b9 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -432,7 +432,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	/* BUS */
 	hws[IMX8MM_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi",  imx8mm_main_axi_sels, base + 0x8800);
 	hws[IMX8MM_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mm_enet_axi_sels, base + 0x8880);
-	hws[IMX8MM_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus_critical("nand_usdhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
+	hws[IMX8MM_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite("nand_usdhc_bus", imx8mm_nand_usdhc_sels, base + 0x8900);
 	hws[IMX8MM_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mm_vpu_bus_sels, base + 0x8980);
 	hws[IMX8MM_CLK_DISP_AXI] = imx8m_clk_hw_composite_bus("disp_axi", imx8mm_disp_axi_sels, base + 0x8a00);
 	hws[IMX8MM_CLK_DISP_APB] = imx8m_clk_hw_composite_bus("disp_apb", imx8mm_disp_apb_sels, base + 0x8a80);
-- 
2.37.1


