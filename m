Return-Path: <linux-kernel+bounces-264961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3A493EAA0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399331C2114D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805C7FBB7;
	Mon, 29 Jul 2024 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eQLummLX"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AB7D412;
	Mon, 29 Jul 2024 01:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217302; cv=fail; b=AAptbycYlJbwqmvQL9zEp+omtqUInf5xilhGsUEc5YsA9tsNRLZq5/Kf3ISLb88BsmIrKNZPLPTNx7wmxkSrgh926xoHvzDJGslso7iCsQWqh9U3stVHZbHTM2BCFtmCL5JDD54tTrH+gcVZ4+SxFnCxhxB6pG505VRLwZMJ6C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217302; c=relaxed/simple;
	bh=zNY590q6+8yJC3pAAmNOdkFfDBXbKx6fCyVYAo8P5qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gj/Pom0ZApZ6cYoaP67FIMuwurO3uu3E+dSIkjLmnBXBos8xk5O/3wZWtuZtAX6zaFWgmGju/q3dgPsFQOXh4+0Wv6OcOBaFCQj3LvVaJkTT3ctV0ep9hAlbOSQGLZIZ1Z0VcZvb6lcQn5M2ogXKPZIy+cNnC5i2zXxRlv8draU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eQLummLX; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xot+2mdf4Xfj8W35ux0qPaQ8/sYMhczoPmEDwGDxv2Qq8MkhkZWANuSQOQIjyLmF32ZJXUqxyXpXjFur2gNRYxbWiveGqT5vueAqnE46eO5dfgdu3w1CVxbcACTL6KzHWmN9z5wpt67CzFdCd1Ov+RV6eND1+JqRdScw+HH82gXHF8ab/hGTKDIVXBrb39ta99vagsNMCxPZ8lMsstbH506B6ps2uOcgTtky8WNTR9BKvkugemTW9s2RW3Q2hNap1+/6UxHOz6zopDTORu/kEPAix7OeS6AKsXNzFatTwZHNlTidS5I8x0F+uA8f3dFmdGY4HcnBf26S8+KmBm0gyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Nr9d1IQk0+V1y6Z8fUPxO9OjKqrugvL4SRS4Hr2be8=;
 b=rjKY7NFlPZfpwBHbt7QkKP7IP9QH4Mey0LxAGVZojIPuJtVtassd1ZztVue6Z3vuXn8zTVrjZ51DYixb6pxcAai//nr2d+sGSux7ME6PZRnibEFXydkeHF+OgQPrtyv1daW+ZdRn1fX7CWKiOFfKMqC+ch/h4/Ig+xdD6fnfnN/5bnw7C5JI504jN2ym7W7e1ovEVuh1JS58hhwV+ieh/uLHWEmCeSxhYhOEJVncHUZcpXiqs6I21wNVOgTZuCimo2Kz2ay8iHQEgvs6A4rtHCxMzE5XMweuHynvh8fAhWW+6trhKIfGwLSG6lvp9M1QdsBnQTF7LzcGRIBamcfSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Nr9d1IQk0+V1y6Z8fUPxO9OjKqrugvL4SRS4Hr2be8=;
 b=eQLummLX8tJHC8ZU+XZJrYJzpmQvQYRItzY5iDkV3z5LGzW1GA5fcLUCCIT6kDGEkhZVqQ4ppw0GKytYtKkuWMedZ91SGwEfiXqAKf3vQ0HiBpPJiI0z1MWhqVzigykWLL4ev7ddI8oVzdc/kuCir5k71Cr4BHbYeH3pNrib2YFnKyZmvm7+kzGbIFJzqoogg0MLvrYQRu8GPFEHz+uShOC12X6XM8hLiQXB33fT7P0VePrEL/LhRKwT6QhrwUDj39njbOr2Gu+QFmhfvbjk+yqc6m9weVKyn7FZL2XEGm225xPr52hlzlhPmhGlfX2wRB3UQMNn6GbzkzruAd1X0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 01:41:37 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7784.017; Mon, 29 Jul 2024
 01:41:36 +0000
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
Subject: [PATCH v2 RESEND 4/4] arm64: dts: imx95: Add NETCMIX block control support
Date: Mon, 29 Jul 2024 09:27:56 +0800
Message-Id: <20240729012756.3686758-5-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: cc42553b-b622-4f49-3753-08dcaf6f9599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlavhssY34pCKJghBB5voK3jdQ/dZPQRNNIoQAJrOaOL2pzX04ytvcPRZeIv?=
 =?us-ascii?Q?fygLGAWCziPffRcTuliIRxa9r0bG/AupjRvhm1shjRpgTPqulag9bZZ8Eajj?=
 =?us-ascii?Q?8/y7CLVSB26D9o9UFvwPuoFrqxkXJ68n0xKR20PT1okh7cEbVpDrsWCgJFuD?=
 =?us-ascii?Q?WZTk7Y2tGSdzsB/Z+cJAPOHQ5ryOXxpxtSrUpbFpOViapKBNLe2zI0Q9x8Dv?=
 =?us-ascii?Q?uUyOaFu3Q6LX7lnpXQNmre9Oh10kcrWmheE2K26giOFK6+ccKtVx1p5PRN3Z?=
 =?us-ascii?Q?uoxbxZRc/XOLfQTy8NtmZE+lICjGknLZcBCoXuG/2PfSRJzFuAlaLDzIMslV?=
 =?us-ascii?Q?lOWz/Rqsz96tANwghstVNTjYmGRGohYPCy24CbPmXLr1FNYOq69XWg9ezm3l?=
 =?us-ascii?Q?MEaTfqsZc/MJZIy5LYqwijJWGojTEV9aOpP/bmtKiLdYf3ft4x4vW8/yHEw/?=
 =?us-ascii?Q?S1ZeWtlceeY8PBFtyyiSeOdD/kWp1iWZDHGbq4/qCftm4TTdVe6dWHFtJzFH?=
 =?us-ascii?Q?QxcEswRCQ6Gc2f7ProRyz2i6aoQFCjfBgr/oVMuKjTQlZRmxNtiY27S5jzBB?=
 =?us-ascii?Q?CumS5NqJ0wMz/2OkF6HzK7/i7l7QjHASPCedE3yNFmtNeGitbZebnLWlrpM8?=
 =?us-ascii?Q?luKCobDDyma++pGRQbQXuGUfDieLh/AtvLTVeWrZ4odozbuSJXr/4AnjRQKu?=
 =?us-ascii?Q?bjxxIJmioYotC9zt14PjNHMatGVPDEoxS6lrHOTw9dlY9CaOcP88+rBkSx0a?=
 =?us-ascii?Q?B9un7nVr0gYM90hGVHRgA9VD4ax7a88SzkOoN6TXOOPhsbQ/AVmivaYG153u?=
 =?us-ascii?Q?7HCoJdeSZ19ByHcnUL+Q3lSQQG+qvBQA1KqfipoRLxfXHCEd3/jvMcpffAIB?=
 =?us-ascii?Q?P/ZabKj1FJeKkY/wlmvFituQ27nZL3APkE8ih2IA+BwOlMb70asr049ofz3L?=
 =?us-ascii?Q?mXDh7IPm4D9N6YCragRtHHNVdiZ7SIVfDDaZAssHA0qBN7QaPT52ASQeNof7?=
 =?us-ascii?Q?gMUz8iXZ/jwDMrOI5HY8dTrFCT26GqUMbnIBznZpzyQJ+ckQP8VqETB24hum?=
 =?us-ascii?Q?hm885gwZEPVtb63NYUNZUCi68tYScwozDv23uZ9RZpniyVqDBVHVVdUaufE4?=
 =?us-ascii?Q?xpY+HOOqKnyDH9L3GulX67dqDvf+8nXFdWd4uCAjyHwTcNQQiJ6t/4EAKL6L?=
 =?us-ascii?Q?2B7U5+ZLdv9oSPgnWSOBRNCdLhV+CLqxGMsG5A1pdk77t+847n+nlJSAo9p2?=
 =?us-ascii?Q?4+DoT7HHMDVFIQyn12JzpYUjsunRD5RYEddzPTbHvmFrgOjDV+ALT4Hp9vte?=
 =?us-ascii?Q?pBhxiLwgDTrwNPhtyQHBkj1uBxGqUuXNOdTCWEWHJOYhRDkVC3PjChQDBrsp?=
 =?us-ascii?Q?i8DgU3eAnvXgvJdS83R8bb5TwT/oRqaGwha1eVKTGdSDFWM5OQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wj4DznYo8m46DpB14cVAmCIl3G+Ivpi2Q5P8xeSKHytK+dxQfIkh0tclAVq7?=
 =?us-ascii?Q?V+BShqpz8LN51amCusoBCn5/6+xsOI0UOLeUdTXft/3mewbX53KJTdVxGOR4?=
 =?us-ascii?Q?kJdfXrtSrI2jlbuvgot2mjzgAaK/TUp+dToStrTuaed6GLfPNv49qc7z9xIO?=
 =?us-ascii?Q?M3mcLZmYjlBUU1pVe1d0aj6QFMv6NMF3I7sPF+cDp0yByZ6PNaMkvEulk9ID?=
 =?us-ascii?Q?/9/hv31lquYaX2sAUmyt8hxLlRnxGcLkkBuJpWGzR2W5+ZiWIQ6cmfKgf7lb?=
 =?us-ascii?Q?Q5ASzQNxNXLH+kh4Kjv6wfJkxvodAddqwqKBZq0FPf6XktaDUuj7DzSFw3HB?=
 =?us-ascii?Q?N8wfptSfA1DdDKXw47PJ5SRQWkPFtFSqTujlqRS99J4ZqWP4Uk/q1veE7ERG?=
 =?us-ascii?Q?5YslUds2iohHTPzoSmDxdnoK9r70I9aRMR74gN1h/cvy3O5KkGk6z1QJczwG?=
 =?us-ascii?Q?hxMVTB2OFjT1tqCRx5Jj8pKWZAMxMkpHmoyBmfEonAGUaqlj/QF7bcn1zoPJ?=
 =?us-ascii?Q?caCUF3xrQy0S1QSaaJRb63gphae2t3emHFyfGb6yqjTpHFV2lTeIA/kNQsl2?=
 =?us-ascii?Q?iw/3FSTw9UJjaI8d2w9TILP8fIlFoDoxFxooBM1DGyCehP8bB5nLhpda5Ghr?=
 =?us-ascii?Q?1vFK0IPNxLKMugw5ocyfU5/473l9ZajVCCS+6prYn5iehmdjK0xRQDgmOpXu?=
 =?us-ascii?Q?hko2pcnTcOzTkZqlU/VvRzc09XSuHF0pqEHNpvRZ88FKTeCm+ZRIUxcQgeWT?=
 =?us-ascii?Q?leroNqHwnuRARPgGvwWuz0s0ygDW4XISbDK271TU1vx6KdgFtUDEdzje0o7l?=
 =?us-ascii?Q?jpaBmMbU8v/hvMGnAyypuXP6o+K7MDeVt08dfG+ivG6tl/tijVHU3KzMKeLf?=
 =?us-ascii?Q?9TRNj9tuufNqtBdLAsnOQzra1DcRp8afK6ml0HuQDdOmDtZeLhIljumFdgHk?=
 =?us-ascii?Q?mDMYqe5Co+qofwI9xYbujuZdaWAnj+uGoO0LgJqKcZCdVahYLKegbA5VMkEn?=
 =?us-ascii?Q?Yex8m7EgRIx1CXb0FLQWMMp+8hMfpk23300+OLOSKun5W9qb7NDcjKxxt2yn?=
 =?us-ascii?Q?EHS60R3qvAgIi+TWpZhiV9YtYLXfuVzhNmJNGBT6x9O1tiKFdhfLibI23GL7?=
 =?us-ascii?Q?D7zJ7uO7D+yGaMHwKEvTdi146g91kgbl26lVRPdh9quSXb62BkWLm1ZbBFR9?=
 =?us-ascii?Q?P2Tv5rruoFFcAVLGBJ0tqdoK+vlbXSZWyh8dd6ExCQu3nx7i2AbRGAB7WljB?=
 =?us-ascii?Q?fBVb3r6SDRAxbBQL/wPtPC8RBaaB/XhHXhBMHfnLmfdX/6ea78IxZcnacjZ6?=
 =?us-ascii?Q?7pdy3Q1tMnv9TaFWYPUjpMmxGVp0ai3Sy5+vduN2Fi1o4dvD0TXIqPNdiXuI?=
 =?us-ascii?Q?IywkRBXjMIfBlkghRGlAFYpTvAkA04cLoSxGdWRt4FLfCNN3AuHgUHkatBoG?=
 =?us-ascii?Q?nEWNi2lRzUSHMLbJs+rbMZ2ueznccilw3xf+Q8/FYRfUbYI3AQsjuElBhgw3?=
 =?us-ascii?Q?ETfFQir8O9uJZufKf5HNM+WMO/ZIQF8RhVD3xR0vXARyyE0LEHtH/YzZ1TbL?=
 =?us-ascii?Q?8zJ4XzwLohxclRVXvu/4lc0Mixrj5xeetqB0BFQQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc42553b-b622-4f49-3753-08dcaf6f9599
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 01:41:36.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFDFjAap6X+Uy4M/r5mzU/Xlr59mjKnb33O30p6KwM2JEKbkrRi00BdaawUbqWI3D2/AGMIQwgG2fonXAqy1Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

Add NETCMIX block control support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 1bbf9a0468f6..6e86aa98b431 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1188,5 +1188,17 @@ pcie1_ep: pcie-ep@4c380000 {
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};
+
+		netcmix_blk_ctrl: syscon@4c810000 {
+			compatible = "nxp,imx95-netcmix-blk-ctrl", "syscon";
+			reg = <0x0 0x4c810000 0x0 0x10000>;
+			#clock-cells = <1>;
+			clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>;
+			assigned-clocks = <&scmi_clk IMX95_CLK_BUSNETCMIX>;
+			assigned-clock-parents = <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			assigned-clock-rates = <133333333>;
+			power-domains = <&scmi_devpd IMX95_PD_NETC>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.34.1


