Return-Path: <linux-kernel+bounces-206149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF11B9004D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552CE1F2470F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E2319AD62;
	Fri,  7 Jun 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y3Vrl1rk"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9F19AD4B;
	Fri,  7 Jun 2024 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766769; cv=fail; b=LxQp/+QW/PGBuuL4QYlDIJ2uj8PDVfg2JIWyAoD9pku9zeKfaQaokOpnyQJBHcB3ZQVo/4I78PpVTSVDn8onJQT3RYYDjBGtqjIi0/FHoZRYPclniGpWODiX2BfewF9SS3bWKzxNhmwfJGDoZU3GktWcuGy7u7sqP2XemZRcxUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766769; c=relaxed/simple;
	bh=ruZsi1O2S5acQChmk5hX2dXn9L4XhsemxTunXk8FL8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chf3d0cRPr9n5lHtEauiO/fuX0NHAqnT4sTOTffaYgF4kYwq+NWOg07HuxKhgxNRMel/1cd0G4H8xq3ZZ3zD61GtSGpOKA7aHbfo6Z5hlF1J71/OPSIwW8ztuFConI44tVMgaLDa1+k0CdzUjwjCnYaHC2O0P/EHn7dkrYS5bEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y3Vrl1rk; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrWEULUHuNp62ovqlsaiabonuzqnMJUfcMvVTWLmF8I8lblOoMeKRCCfvpDYJwGD/JvqlQERoThY96htJrXBUy4iVU+w2hsD6WAMbRzw/hE6puKO0fSiY5McfWqUi9K9zKMFUxBJMWiKEsOlXTdwHeZlPB/9uDq0JSkSbbHGhx5khQ0dSxvdcFWE/1TJnfdU0x7rbJJHG8q/0au2/m6GSjNwvMtFp+a+qxOoQlx11IJchV3qrCQvKWq2Hvg88J852ypN2ytxuI54jTGdxvwy2/70c416Xli7VliMf4jgKHEQ/wIy9M7ntn4BoqQHUz3ULS/m4YzJKV70yIDJWoAd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/E6WUiZos1D7g/E4yBNbqCq23pvb6v6xSIu4m7sz6k=;
 b=hSnFlTn4M10jX0yH5eRbm8rbx2WTmuQzOYxdtyIs1axTSi9cNw3H02cgf3vTTQwcc9ap5wbI+TUXh8ZS3alFsP9jBTaf9D6WvEjeZ+aGilacaTWSKevf91ovzdkoI4q16Yi2sE7X4JzcHsk+n8o+5YYO2SWxz6xNJLsQCvo6iqNgjxQT89NsVnrOyKd/sLLP/se3if12oMVpmayKdH+Dd44BcJ1Ff1PMoalz7z9JNi71AaGq1Osma8LTbfebpdKvqXewLWKADSaIaSVGMa2wh4re6IdkQ4m0JXxduFcx2BgSchchF3oYhYCQ5SoZ2UVD6PdOc8OXItmbPAasrD6SJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/E6WUiZos1D7g/E4yBNbqCq23pvb6v6xSIu4m7sz6k=;
 b=Y3Vrl1rkjC8Q9VWJjE6b5VLtvxQvD+xm7s9pOXNZzpFYMXXZLO+efadcZ7TGcwOy4DMIrZIyXQQh6KbI2uLcfvQGW1HORd5Z5FrRQHm+Z8IAMlxb8EFTiTghQN/a6GGNi0Ob40iL2+3Jnou8jipQzN2QDyD6D/wsBTCNkI9AFc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU2PR04MB9020.eurprd04.prod.outlook.com (2603:10a6:10:2e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 13:26:03 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 13:26:03 +0000
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
	"Oliver F. Brown" <oliver.brown@oss.nxp.com>,
	Robert Chiras <robert.chiras@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 12/15] clk: imx: imx8qxp: Add clock muxes for MIPI and PHY ref clocks
Date: Fri,  7 Jun 2024 21:33:44 +0800
Message-Id: <20240607133347.3291040-13-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b9cbf46-b31d-4f5e-d365-08dc86f560fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6EUGvpV4GB5xvfBip3YcUT6PH4ixZDWGnzyUwbL6T19QF2Tm0j7mMQGAaDYH?=
 =?us-ascii?Q?2UiwtRUQ/vCq3z28Ce7UUKcESZlj+midBT1UYRbvWVr+N4FH1ul8MB/D+aIY?=
 =?us-ascii?Q?+uhelxGeRc8bux0XrUgiaowFO8DpPO3739KVMXaru7UaXZS7PxPUHhZgizDH?=
 =?us-ascii?Q?NjdhGdhqjCt+krQ6Zi+eeuuKzsYMVlFlStHgQ1pc09naCRG9VVWOcyMkT/E4?=
 =?us-ascii?Q?O3UTpWrSfHBCGTFLvYqQX5rRxr01o9wgfAblDjp3T4M03cjfSgFAcr3G5aco?=
 =?us-ascii?Q?rh9qjcXsLhe4lsZqYK5uwkoZD+5gPvGTQSCL4CLmz57Der1yXfp+qGIt+ixa?=
 =?us-ascii?Q?BEEO7VdYVnjTlP0Hronn9iaIQDQOGg48aPU445SL6XQHSrqCq39l5xiPwcrY?=
 =?us-ascii?Q?zeL9n9+pzC2MMYUBDR8DXjZiEuukU79zlzECfAnSAOZy5xfidKJJVDWsO4Nx?=
 =?us-ascii?Q?NnL6nvfxOpJQypVp9fTQtNQ+whSvVbEBGRQi+W/jipQxp5M8gmzvca42YZEt?=
 =?us-ascii?Q?p+TpTqrGUNu4IapUE1iprfbWt3ZMPLWNJBgfUD8ki8k+UaeVIPUaVWmd1q3e?=
 =?us-ascii?Q?M/k9GT5Qa5dki6SdwoC7Q4ESo6eDJO4RyMfktfZqSa5Qgncg47C5+T7tbcqh?=
 =?us-ascii?Q?gZb8Sxddql2sC42PCgPQGkljAfugQ+z29zh2nXVIywB355/X3Inhf8rXuZQX?=
 =?us-ascii?Q?t0pM2yXb4iPNW8lRraDcUR/soz5FqD32vVPqH2xg7fEGARkFb9PKKSmRRHFm?=
 =?us-ascii?Q?q5d6ItuqzggAsu/8bnuxsGTF0l7iq5fp3H9TTa/OH/TZZPSxUADQUO4VD23Y?=
 =?us-ascii?Q?jARZyIZ79Kr+jdi46vmxiX/nycB3TMSM4A/2HfAAbfB1G4Dmpm1bc4M0swut?=
 =?us-ascii?Q?VRk4hzi4l1XVPyzj7Yi/rx82ZWTiO6Ag2m8cZg2bUqLrSgteFlItBy+cvn3J?=
 =?us-ascii?Q?HBO3E1vJrI3t2XCsD/9I2XPaxGF8rbWX4JpH9G1kcKLLwJqjgUHIuuf+uTbU?=
 =?us-ascii?Q?cxHMN42jUJTa+z/mCQhYI0JrsuoIamrUIuXOC31zYtc5Ygq5M6Jy9ylY5PBl?=
 =?us-ascii?Q?60n0mGKLYXl6XAtUIKDRqSFKMbddJO/nmFA+0gEXes36aPcBDqf98b+RGswS?=
 =?us-ascii?Q?l2rHCmzeGLqxVDvsgpu2EJXw6A2FqX46GvFUfwDYqQTg7dNLEk1Wf/ylUP1p?=
 =?us-ascii?Q?B6MnHU7OIcWw+Mo4pPNviZyCZ06+jNvCkB/Ct8SCHdsuA5nIj2xmOIZKQ6uS?=
 =?us-ascii?Q?Kt0ZyBVV1kx/B/brSw7hzIXv02yj9hqFjHj/a1iuqPsi8DqNOhgzjxkGx1vB?=
 =?us-ascii?Q?R2CQbHOJ2IQ1nLFmeNNAfzAUNDRPS3JalSQhEg0PaB1+/L/c0vJySaDeNDRJ?=
 =?us-ascii?Q?Y7u5XGc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5xy3E1Tb+aThvpSrQNmxxtIeGq23w/wqPsCzAyzvXif52r5APcGcdMlx8B0?=
 =?us-ascii?Q?jAetDg9wRgeQIQT/o1Mzx38hgbcbYSyr33K2be5t3AKivUTO/Ou1bPUoIgD8?=
 =?us-ascii?Q?/0GctRIP9HKVxxMhyB+6zgAlU2CTvt7JKpvCld7bBrftis7foJCb53siKVt3?=
 =?us-ascii?Q?YIv14dgqzf0n56lfqZBw19/JIWfOSYcUwUoLed+y0d/MhFpJuoOOzBqG+DGb?=
 =?us-ascii?Q?F/JC42G+GKLp15dSH5dGfwNKd5SqmwmZKOJqYImuxWkymHERwFH6pg0xC1xx?=
 =?us-ascii?Q?UGms5U2rf8LSjCn2y270FDFtytuy3+7wLCpoyHvN51m+TyTgNtSfBwDXsVXb?=
 =?us-ascii?Q?XCp6yiQOAm8TXp3jTWQCAzUMJ/m7M1q+HGeDxC7Dn8LVxLcTTpD3x/+/7VL6?=
 =?us-ascii?Q?t/TvaqGdQt3/2sjLWbtvyimjArxfBsTTm0j2yp7L1o7JTKDiiaTlWxXBbJE6?=
 =?us-ascii?Q?1cdd0JbdYCMQuF9HMLQ6T4ZUcWIdmmQYm4Ic3nmg8/wUI4sJ68P7k7K5lD46?=
 =?us-ascii?Q?MqfaHdE8o08TxiwgpyLgoJTPC8Lde5Vi3keHH0hvjE4Z2Gai99D4Awul7K03?=
 =?us-ascii?Q?wwWmd0KFqUxNDapi5u9xPfnPSkoVgqSQmnMUC0X7+6feRo/gMd5T1r/d0R9q?=
 =?us-ascii?Q?0otPHof96iTkfm9jXuIPsCHhzyGpjq3gYTjyYsGuznZcUhFbESJXyMFIuSe5?=
 =?us-ascii?Q?NznKsjlwGjR+830VSY3M5zQRXRGHC/O+383FfuQXCNTLMVvxfPKh+B+X4h42?=
 =?us-ascii?Q?JMZNTBRhPrAluq/rQCGfzVAdFksXKKxaRJujrx6DbSjK7IZ83e+FbKo/Etno?=
 =?us-ascii?Q?8lhljMC7whjENS2OG/8GlunMQkLD3Odgfu3WVTX7L4NXA7jfJ1i4kpywLSBT?=
 =?us-ascii?Q?dsDGLcQG6PvDwiwd3tZHE+dHQkldHebJ5Zn+wuikWjQsRIgwP62WDPKHruqF?=
 =?us-ascii?Q?0R1cyXRcKkS8bMwJBJrDL91WBVbdGuyw4en+sQIEEhWwSrCJ1HmEaMh98xyf?=
 =?us-ascii?Q?/gBLI2tAZSg7KjqjPvbFVv4VoLyFS1jN0ciAZfse+A9linkf62hSuIjJ7PD9?=
 =?us-ascii?Q?3kx+2fDyPHHzH/shk8hi1yrUB3Yc+aRgh3/gaJGVge04bEj1kefGWWPLWpBr?=
 =?us-ascii?Q?9EBYRlArcidHtERL1DKZiCkM4zm4vApM6WK6OKWruQ0Lqv2KSn+GWAxX+ECO?=
 =?us-ascii?Q?WslgO6jz4Ae37oG3ih8G3mR2KMPHGc1uUjbdKSaiL3GQmc4GunseMZeBJqPR?=
 =?us-ascii?Q?b0fQC469VYyNXGUvUmB9DIgjeKql4TghEx4Dc9FDKfjJG1CgS/mCmPD4YVpU?=
 =?us-ascii?Q?7XDq39Sl0DXgyt3GRxgqFHUnIKKuyQ+GCLdIHS/WqeA+CF3BjWMyD05HsO+y?=
 =?us-ascii?Q?qhJHd32V0KO2DwlPDoixchQeKGyN7GJ+lQ0HLoZlySbILn0MzSdI2uBSGIPB?=
 =?us-ascii?Q?5MclXEC67PXEZX+tqPFR6GNwiHFDPCxmW6YbfHp78mvVhyZkrn5Bd8JJBNyO?=
 =?us-ascii?Q?mmIlyUlbu6eGheX3yr7pcDXrrYb6MFRptgz9D0vdBCszJH3fzcNXMtKhMKQF?=
 =?us-ascii?Q?J7B02U5pzzQXxDMgnnOqoiIZGVD2yYrPlKlrgvXt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9cbf46-b31d-4f5e-d365-08dc86f560fa
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 13:26:03.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2S/ZrHPzLXBNq+Uz4TxtFmy/v1//6k/1xExre9zZkS3O9fEU5oSCvOzJVQm949PspcvUHohtTTr+Rs94VnQaPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9020

From: "Oliver F. Brown" <oliver.brown@oss.nxp.com>

The MIPI Pixel and PHY Reference can use the bypass clock as a source. The
MIPI bypass clock is the Pixel clock from the Display controller via the
pixel link. Using the pixel clock for the PHY reference allows the MIPI bit
clock match the pixel rate exactly.

The MIPI pixel clock is currently set to be source from the bypass clock in
the SCFW. This patch allows the pixel clock parent to be set by the kernel
in the event that the SCFW default clock parent may change in the future.

Signed-off-by: "Oliver F. Brown" <oliver.brown@oss.nxp.com>
Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index a0654edaae83..fe6509be6ce9 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -90,6 +90,22 @@ static const char * const mipi_sels[] = {
 	"clk_dummy",
 };
 
+static const char * const mipi0_phy_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"mipi_pll_div2_clk",
+	"clk_dummy",
+	"mipi0_bypass_clk",
+};
+
+static const char * const mipi1_phy_sels[] = {
+	"clk_dummy",
+	"clk_dummy",
+	"mipi_pll_div2_clk",
+	"clk_dummy",
+	"mipi1_bypass_clk",
+};
+
 static const char * const lcd_sels[] = {
 	"clk_dummy",
 	"clk_dummy",
@@ -222,25 +238,25 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 
 	/* MIPI-LVDS SS */
 	imx_clk_scu("mipi0_bypass_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("mipi0_pixel_clk", IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
+	imx_clk_scu2("mipi0_pixel_clk", mipi0_phy_sels, ARRAY_SIZE(mipi0_phy_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("lvds0_bypass_clk", IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu2("lvds0_pixel_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu2("lvds0_phy_clk", lvds0_sels, ARRAY_SIZE(lvds0_sels), IMX_SC_R_LVDS_0, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi0_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi0_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_SLV_BUS);
-	imx_clk_scu2("mipi0_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
+	imx_clk_scu2("mipi0_dsi_phy_clk", mipi0_phy_sels, ARRAY_SIZE(mipi0_phy_sels), IMX_SC_R_MIPI_0, IMX_SC_PM_CLK_PHY);
 	imx_clk_scu("mipi0_i2c0_clk", IMX_SC_R_MIPI_0_I2C_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi0_i2c1_clk", IMX_SC_R_MIPI_0_I2C_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi0_pwm0_clk", IMX_SC_R_MIPI_0_PWM_0, IMX_SC_PM_CLK_PER);
 
 	imx_clk_scu("mipi1_bypass_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_BYPASS);
-	imx_clk_scu("mipi1_pixel_clk", IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
+	imx_clk_scu2("mipi1_pixel_clk", mipi1_phy_sels, ARRAY_SIZE(mipi1_phy_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("lvds1_bypass_clk", IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_scu2("lvds1_pixel_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu2("lvds1_phy_clk", lvds1_sels, ARRAY_SIZE(lvds1_sels), IMX_SC_R_LVDS_1, IMX_SC_PM_CLK_MISC3);
 	imx_clk_scu2("mipi1_dsi_tx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu2("mipi1_dsi_rx_esc_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_SLV_BUS);
-	imx_clk_scu2("mipi1_dsi_phy_clk", mipi_sels, ARRAY_SIZE(mipi_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PHY);
+	imx_clk_scu2("mipi1_dsi_phy_clk", mipi1_phy_sels, ARRAY_SIZE(mipi1_phy_sels), IMX_SC_R_MIPI_1, IMX_SC_PM_CLK_PHY);
 	imx_clk_scu("mipi1_i2c0_clk", IMX_SC_R_MIPI_1_I2C_0, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi1_i2c1_clk", IMX_SC_R_MIPI_1_I2C_1, IMX_SC_PM_CLK_MISC2);
 	imx_clk_scu("mipi1_pwm0_clk", IMX_SC_R_MIPI_1_PWM_0, IMX_SC_PM_CLK_PER);
-- 
2.37.1


