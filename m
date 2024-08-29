Return-Path: <linux-kernel+bounces-305998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E819637CF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92FC1F2253E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A45122EE4;
	Thu, 29 Aug 2024 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bHvLFwDS"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A203C482;
	Thu, 29 Aug 2024 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724895223; cv=fail; b=gmDLuPZUFTzFx4nnZt8APJ+kMSWzjI+oirxWPQdmTOL8+0I2Y/2vUb7WA4OaojpZzLc2OHZtBOs7AkVjSQVo7qiKzfFEMT9Z19Zuy8BFS5kSHavL5XnwpSFIJy4OoIezDmCo97AZsp1TgsRbd76nQRUQvgA9eTGFfCuYBvTJkZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724895223; c=relaxed/simple;
	bh=pZfuSoS7W1ZYhGCcPpAEjeYd7NmvmO0HquYFmpAzy5E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hm8dDI6Dh0FDONWIzJj/aL88HKDfydDJpmLba9+Itk/1NJmY12GadRTmU4q2HBpx+oMON7QlTWVJ3zkE8uVM43EUu23zJJ76HwlVQRkOOjuTuF+jv1Xy6DpXF5U9lz/gPCKRXKObH/MG0mpQmYu5cY4fHVQ4qv/4ZciXFIziovo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bHvLFwDS; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNai01Nqz+NZ14Tj2WAh+LDnUixgNHWqx2vK9Hs2XXzBBV6wltPWZPNWCnsldj2dPWpxglrllO9T+/AhtK+BBAcazgw2od6M79kR94llq+9M5wXEOnQMR7slFdlPiy1JoBBRuepTUikt7+dPZN62hNYky9A/DYClTOI1S157EdZBY+6FeONWK6QxuYoXkohhqCk/FRffQVpFi2SkKTKRwG+pmQe1TCZ0mYpcqnOvBVxWO12OWEg+MsDJwa79H9fc6ff0eowsYBH1Cxq6fDHV2Oe9Yr34gRhm+Dk21t99UUYhOsQ4dg+viErMJ3DfQrBF59rfhbSTSe/JofvOcLaVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3L3lnuxnZ0opOV9a9SJbN4kZZVhFcRgpET+X/DEgXxs=;
 b=sGnQ2/nsI1Jk6tZ3XPhGfDy2mVOo0yH1YuLJ00yFSguuUQV79U/GsMOGuRF0O5WeOuWsfwwhY7om2W8zThVmW7IXIK+mbni5y5fU8zx9PRERnAFQR5FrBel5pBpChjXZLecP3z0xfEp+gJJUi3aFCoeFf0XF5g+cIexO1uvAYX4hZCLBQTsKATsFucMO9+L0/+x3t8mc4XdrCb0Q+1lYi7CbryKzNJdm5ucT0hUb0LVo3gTWZUc44JBPeixplK5cMucDQ+7xGkEzi2qzIrU8zD57GwzIi7wJy4H/XO9evK9FqLTdIERj+x58WDAfchDUWJyjyOi4UOljJLC7lTYh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3L3lnuxnZ0opOV9a9SJbN4kZZVhFcRgpET+X/DEgXxs=;
 b=bHvLFwDSsmbKqciQuZiNquLscnXzDAGVPe0RN4jrVfIp1WXyH60humairAGfsWHtCVJLklhhk/s3d5YFH36z4e3pGsEI2PLJdrUpPwmrycfHrDf8mtf29ydgd3SIjYOzxIsIUgn+fGUfELD1esfI5jQVZKdbcw7jTdHNmUSk8XCj1CvAyANDuZ+Gj0MqYiFtSBa+N/3Ydf9DtV5Hn4mMty5csSQEpUuRfkWeaOgWvPt8TLRU+zYJ+Q5xO7spQNSyiOjJx3QyFHEiq//2/d/IBCpbq1nOlABHl4iu0W0FEiFlzYER6PPotzWHUXpi8khCQe3WPD7ISLOGZoxK2AMHfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB10924.eurprd04.prod.outlook.com (2603:10a6:150:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 01:33:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 01:33:38 +0000
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
Subject: [Patch v3 3/4] clk: imx95: enable the clock of NETCMIX block control
Date: Thu, 29 Aug 2024 09:18:48 +0800
Message-Id: <20240829011849.364987-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829011849.364987-1-wei.fang@nxp.com>
References: <20240829011849.364987-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB10924:EE_
X-MS-Office365-Filtering-Correlation-Id: b3698ca1-bd28-4770-4c7a-08dcc7ca9b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v8aZQtscFyq5HTt210ysb4SmD//Wlzd5AL/oT2SsJuWKeetODpY4r1pEArVO?=
 =?us-ascii?Q?Ve1zVHwZRA++GxyaUaSNCELd2UYxoq9jx77+NZX0G4CCxGQLbkNqFCccc53Q?=
 =?us-ascii?Q?oZpQH2pNA3NgND7GAyhYw3lS2vD7QAXcS0PFdbo5MooI7J7xZ/2v1XYyNEPx?=
 =?us-ascii?Q?2JwzLoEfvNiIxwirlHlB4FFGfhUAygPDEMTh/qeVZd84s6nQp/vKuyrSTcbb?=
 =?us-ascii?Q?fzOVv9+yR/k/H3M605O57ZfrccWdip/28+hXAUz9EF3oO2WMh0mm6PAP5kBh?=
 =?us-ascii?Q?XyV0li9DrHmLRwpIh9i+Nm0H+DZkSIA0UehxQBLuSl/S6LcnjxB6diVpwN00?=
 =?us-ascii?Q?J9urN9Vhue6siJ5+eY7XWhTzJZ/QcvrqwvhW2kh3mPIqM/tXRodjtY/ogwj8?=
 =?us-ascii?Q?mxB6zRKqxWwSorhIPxFVYhuAR3qFaq3c/7BoyKsJV6ImREKS7k0y46AzP+Yp?=
 =?us-ascii?Q?rJP8WqqvgPq2DIMAfMjvX1WgZxvC74xA4sDnQ4t2F9051UD4IWeTIQGtC4XX?=
 =?us-ascii?Q?E4klljVMdDxapoF+J0kiTTTe7Q34Cm/Mcdy2jhvXqdPZbm8zkJ9FxgIFWsYz?=
 =?us-ascii?Q?53O+e/J+PhcjJwPPUtUpTh59GUlcVLBUeFMGGDVoQW/YVa4akCaNdLyPn3yH?=
 =?us-ascii?Q?fbcukMtlxSbstjRupQ7X27tNDFYaJq8gs4KYCIpmXIrXMd7HfxnuCisZYiDX?=
 =?us-ascii?Q?myNOORwDnIEkiSrsPITDFi29MruBF2EUUR6gEveAT2Yh3olmp1Y+nuRJp8eD?=
 =?us-ascii?Q?2hjPLqIfO88CxH0na5e9xRqdrqLjBJXNhihOTe/nnk1dHlhtTnQF5tNRAtJC?=
 =?us-ascii?Q?cyBHbZzZ/+ci8shlcHXTdWTMSy6SxwHGESbjF1C6KGxM4aeeRZaZL/7ks70t?=
 =?us-ascii?Q?rpzNskTic247l1wPVQgPC8iyBQp3uug9bRc6pyRXfvr+nZoSUmXx63tppSL1?=
 =?us-ascii?Q?uIDEM9RE7/S6NNxvLg59AookTI44HmTRi08K1tP/Ys6JlBWXiX7R5W1fVZUe?=
 =?us-ascii?Q?4vilYtN9H7DQbGdQY08pHj8psgM18bc02S8um4fZx5iybnJ+BJnmns7+61Iq?=
 =?us-ascii?Q?xn9dVJ4asM4hVkYFk0NIVOk9NW8ObH/0T7YsKzU/K7PFh34FOXm9FMQ0pIhx?=
 =?us-ascii?Q?rF1JCv61iyfYBSKj2Un2P2a83VVkwJ6EYis8770Mt0mwDIqoevzssFCJ1pOK?=
 =?us-ascii?Q?141jYuqjrFFziLrFvNMMV2JqNN1LHTyN/xZP6dLNWPlaClP/LrYRAv7DjhVW?=
 =?us-ascii?Q?qrcYVhOsfNt3XeBopeQNK6RIWfH/cKqF2BKegjk3wZunFpmSA8h0VtSI68e2?=
 =?us-ascii?Q?WK8ql4ZPoaDwMYco5cG0/QmzW/obE1n7YHl/pYEtyt4F1SH+wYBB+gCCzu8M?=
 =?us-ascii?Q?84HwODUy+VgO1X1tmAbQEyHioKQpNvDVOyxbHlcCG9HOCLoLSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UA7s7Fv2LKO239ESqm2fdqkz3qAjaHX5wWzhcS+5s0dcNbfMawYuY607+v2w?=
 =?us-ascii?Q?xftCoR2rg9htsqMw/loXJUlTeG3D1nji0z5glwAdg+X2aslqydEXMygQ4G8M?=
 =?us-ascii?Q?3r9UVfE2f4dzu6RXeBCXXKDDC7DnDP4M5LYTe140RGT3S4Ph72u6/4dDkpYB?=
 =?us-ascii?Q?v4+TWcT+sXCwpeFDEdhbUpqeEyv29wCXn1uFOdPXy+mKL+jt90+Is29i9ukQ?=
 =?us-ascii?Q?C9IumkoS5YperBC4w4ilAwr4hxPjL9forY+3wRwAJO6SlEW4pfGPmb6+SOTu?=
 =?us-ascii?Q?kNgHG0hh1XjYJKcB0WzTHng5JQBK3kWik8UHp2WVO3ocz8Nb9KdA5EPt3DOV?=
 =?us-ascii?Q?AW7bzdEhRAy6YZQ3j0mcl6xdjGaGIOteJuC7PDR1ANflfpyU/nVugr7bl8AP?=
 =?us-ascii?Q?udPhgfCBQiM7iW1Fi4Y+JRwvbqrRL2Dmlc6xy9yHEuY5x9gmRbER1iZeI1O0?=
 =?us-ascii?Q?h6A71+X37wUHkghPnf+SBzFKnMWZmMl+PabeemhMTuS85/kaPjUh8X3OYDiS?=
 =?us-ascii?Q?ld3T23z4J8n+tfF71KnoHayDN0pNafcRubn00qPKAR2qrDqBgir6VobgEmyT?=
 =?us-ascii?Q?fHLVV3BdVCD0lC2M1BzJ7IIGkMqY9/4fDUzj1TbaCo4WkexYmYzKxBt3zDm8?=
 =?us-ascii?Q?SJwRWnRWXFUhYo2DB7OPwLNgY2HVldrPYtssqZ4uUlopB+EOxCVes8kISBUT?=
 =?us-ascii?Q?SG6TESUlfxZVM6yifcnADl1nIBCa0nMYR8828B6ZDr6Evoh447qxxRJv88MJ?=
 =?us-ascii?Q?nkk2CN9SSF547wpePPIuW7hzNO2omwSmLqdnxqzhlIfIPlf2fr+mlzSLLLoP?=
 =?us-ascii?Q?qcPJs9B0JVys0XGHTkCOUIvrVmQNWxptthikWNWLA9rDZD9pb8GeWZd5hKgw?=
 =?us-ascii?Q?m/lVEK8Ab7uhQeRCPHjmdvd5ZUxZcLjoWhxvvC+Qn+qG5RDYi4HiSdhlApYE?=
 =?us-ascii?Q?BLvMN4RnftlOZh2BJc4WyOLR7OtO1VKHaU+KwpD5YN006iBLDM3HN2ecds7X?=
 =?us-ascii?Q?Tg4dTGcx5MTzwUWLVAABmodp5GyBAZMqFh86IWRCmiip0wA/qTMtrs5+QVd/?=
 =?us-ascii?Q?JfqVlDMIsVKW+7rvgnCvW5g8Nx16EKGi0S/fdgG4LuGoTDjpNL9dyLlMcecC?=
 =?us-ascii?Q?0hrhYXFf2cHoAair2V/XPIrHLeb138Escx8vFmMjBhVFjjLWqbFli6/HsyIF?=
 =?us-ascii?Q?RvpLJBJ74syKHrfA0D419H0rjmRjGLvZK4FqZfHRDqTvZiPnE36Z5HQRqCie?=
 =?us-ascii?Q?y0FtGhA9J9r3FwOiBkQOPCgK+UeoN9kJJQ3s2sTPL8xQehcQ2BVbjD17JYmk?=
 =?us-ascii?Q?jiBKK1SvQfb3R6HJzyyTWyJJIwrD1yitrbBAbO008VqWSyNSREhBdRe7Sa0q?=
 =?us-ascii?Q?Ji45/HwivUJ6vD7oAGgsy5Bjn3fjfkYe2ZkeXdYxKnQWeU13S44qNRyXUXc0?=
 =?us-ascii?Q?thKZmu/OsZSN76ZbskIF3Y0w1DSyzdgvABq0j/R9NtFbbfPEE+yURw6h3e94?=
 =?us-ascii?Q?U4Ys8sqv40pIEsssik5oFpO/i2DAwj3NHTyHp4iLxW2CNBkpI+j6v1kvBotf?=
 =?us-ascii?Q?/oxmD5Mc4ANe3GiBIazjBjWWGibiPUfEBVBcK5q7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3698ca1-bd28-4770-4c7a-08dcc7ca9b53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 01:33:38.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwCFna8cMn4xpC/YlOyIiA5hHYHElVSUlFHZFR8jnDgUMCEC/cz5sILSMe/BTC0VnzfKrxfvPr6eBfTr/Qq1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10924

The NETCMIX block control consists of registers for configuration of
peripherals in the NETC domain, so enable the clock of NETCMIX to
support the configuration.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
V3 no changes
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


