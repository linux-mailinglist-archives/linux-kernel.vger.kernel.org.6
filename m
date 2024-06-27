Return-Path: <linux-kernel+bounces-233070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D8991B1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F5E1F23D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01E21A2FC2;
	Thu, 27 Jun 2024 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ovUIvPba"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2041.outbound.protection.outlook.com [40.107.241.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D51A2C27;
	Thu, 27 Jun 2024 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719525633; cv=fail; b=u0GaDLZ1GlFupczSh9+SQE5ePZE+ayEQXYZMD5FjYoJGCaTeD7KkWuaCAfRktsFAKUClH+eH3D+GXKThv/XvcNc9ycS8/KN2QyqE5IXNizGxsxRUnwt4i0twJfa8mHVYdk4rebsl59QtqOZPFYlamKq2wNA/EFlU5HoRkKCkkEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719525633; c=relaxed/simple;
	bh=4MHVNdNLwMLZaGZZPpkfsHMLfOrLWkQuSB9MA4L8qgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mOpB6sTH2V0bVQ/yhHHu7WmuX2NUB4SkA5YQxef6v6sZ66ZobjrUT9jx36BUPTH8aZ8YDhvHIFJzW9oWq+/A053UQ7YNUy4VMfJvRvsYT/TfGZN4COdjk0DwsHy8f8ordDaHPBU3qIc0T+FisabJYvmVPRiBMG/Z/at+bwSNEFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ovUIvPba; arc=fail smtp.client-ip=40.107.241.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrAfuuI6uexodNqImfVYLVYumYZ2I31zBo/JayPJ0o3erlBH0cVpKrbp5BH5P+T852xlEgy+/Mhj4m/7FEHmI56mChKZ9mrT/pFCl0cEa+XopK5oqYJXn6ni29jm/PudzpaxomN4HOusgQEbg/jSN+/y6sXPV3fArXnGBwT8i08oGA4+7roLDCC24i/9eS+76zc845K3pdUMPMP5VaBZ0i0vzJ/1BZf+Fo0tcWIF6rQxYyYJ1PHl9uaJYoMJ1UCS2ENhk6tc7DMDqHNHSMQgIp2gib7pVBA9tZGJi3+nRXnHt431EBfz3PHSBPthpe6oHUQOVZsGe3PH4fipNNJ1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDZ9/a5ZeOg3QCENW2r9U9bY+E8knzLnMkrJXXCSfQ8=;
 b=JzOsS4fd/hf1CFHfYN+G9AM7Rnv0+FVcHfoxhLG7ltKhlkfIWDln5vFdUaL5me6wHgGYl3MSntY+ChRBGJ06Jw45V8B5PoG8q34OcZc61XvFTdRQQYU+B8ZoHTdLuFvYCG1nypOLubnc1lhlnp0gp4nTp9hlUO4tfmJCE/XjvBv6Gz+8dX/mzzj7L+nlK9fkM3Moo0iPbkQx0TFwKiwLkV/DyNEViGpl8pvE1xghzztvQY8ydxpuHo4g8/qLXU8ds0yty4kncEKjw8p8uDVfcDUPz885xeo56vVquRDt9THkKGHEUpBzbETh/gW9iUlvfB1wZG7tIC53jKmp78dsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDZ9/a5ZeOg3QCENW2r9U9bY+E8knzLnMkrJXXCSfQ8=;
 b=ovUIvPbaPUxYfFS3EmrAgrOaBSKM7zRXmyoI4OC000Ro/DA9PWWHno+DSf5yMUiTleaWVUBtgRyqQd6itXSvwU6flw45cnawbLYhdaaPGb1eY8c2aJ5vIXJnqyegTjDo7yCjZH807VCfdMT9rpBzxH6lhHilh71H2cTVQsjnC+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7259.eurprd04.prod.outlook.com (2603:10a6:102:8a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 22:00:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 22:00:24 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 5/7] arm64: dts: imx95-19x19-evk: add flexspi and child node
Date: Thu, 27 Jun 2024 17:59:59 -0400
Message-Id: <20240627220001.692875-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627220001.692875-1-Frank.Li@nxp.com>
References: <20240627220001.692875-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0286.namprd03.prod.outlook.com
 (2603:10b6:610:e6::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7259:EE_
X-MS-Office365-Filtering-Correlation-Id: 4781132c-e9bb-4737-efbc-08dc96f48c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p+aFGVl8TRp0MYeUFx/VFUJwPSeRJ6A2oaI1cPVc5FXi9IC/H2r3nbqKlQgm?=
 =?us-ascii?Q?qRnTp64qYGkWjua9emYMoKQ545mh/SYs26aGbGvkeGMP0GuqaUh2EC+Lg4ur?=
 =?us-ascii?Q?WDuNd4BwLW3HepHuGkSgSgbKiiQEM2L05GM9BTvVLs5EcrGCTxDqAZWnNUBs?=
 =?us-ascii?Q?wz5rAo6PVJpI8mjNNgJOns1C1YfmTrb5QK+8s4xPt2GxGBqinvgyTfQxnSuS?=
 =?us-ascii?Q?VpqpnOAjdWrt+jH/dXtO1tgbYXWCrb3oQsyUI3BZmczBby7zONfH1mQmMmL9?=
 =?us-ascii?Q?96qPOJsaF1ugsIO+wS6Nh2NbeFoJv04hWsrGjBPLJOp73g5PLQfkzlmPJOkU?=
 =?us-ascii?Q?WLUl71eEGMv0GDcXFQ178DhtHmbSsfwckQ7gICwUkRGO3K3AVEG5azARHfO9?=
 =?us-ascii?Q?Whm2eEHz8CBJ4pvyhmSM6CVA9bwkN8X3zTKQWxCUUD2bTTy7C5/JObaCBm8B?=
 =?us-ascii?Q?KWy3tks9dWmjdhrsfXfsPicjqkaIbYR/WJUKoHtLrFkaIbvZ2u4IURYM+/lT?=
 =?us-ascii?Q?A71OnbH580mpHYWX/C557hExZ9h3fIWKHqOADP9KL9d61/GTwiBY0SsVsx0R?=
 =?us-ascii?Q?5rDEFsxQ7tWjMcRxI5SwxpUD5JjJYDes+OfNjY/5MQlQPtGpj0d/AdNcA7tF?=
 =?us-ascii?Q?1B/tPTl5gU249qMk7UpAS74qKg6hQY7T275zWVoHoWmwvOTuvYodSSm7x8iH?=
 =?us-ascii?Q?tBiu28E8Z0mFZqhUzd8zqqQmjXDctRAo1pb+clRDKqBLmb1z0SLEyLvDQwX8?=
 =?us-ascii?Q?bJbUHb109tFlDSi9WDavbMomY023mFZJm4SEUKMSa7WD1uQHABCRbl+kfucF?=
 =?us-ascii?Q?VXfc26NJpNwsDylIqh9HhqORs95O7u+F4KiqLQzy1hYNG3fXPHsHHABmPYxm?=
 =?us-ascii?Q?nZT0lscqWKHkv4Aag+JZsu4ztg4Vks+O0midLC3kuGeVUmpJX4ItLFAeCM9U?=
 =?us-ascii?Q?H/WVCduKFya5qxYsnDK7g7WsgHRqEQSYt0xu7HoZzPLDGbTj601rOSJbkSqk?=
 =?us-ascii?Q?1OX7fdArw8jqfGnFNZatxGyVQ+NBzADLA9KpF59J5QSCTPlStn1HPIW5GYdy?=
 =?us-ascii?Q?I1v1It1CuYxiSDdKbkCQINLAUVqLXaMTm6nheTHRPVuU5NDjx0MN+HCX3gie?=
 =?us-ascii?Q?yJsLikt5RLSngAxdtW+XP5HSe+cWC1llCSozJT7MKcDgsFvG1sm0Au6w0VGk?=
 =?us-ascii?Q?PubfPTHCdBmPT4ZsaB298Ryf9ubznRbkr9HmfhmBb99RxaXSCHq0vlB2RslW?=
 =?us-ascii?Q?4w226GV0kMJi5rgN/1eET137ZFsvyez3qbVKqeH5A7Uw2Mp+/t3adf4Bld6X?=
 =?us-ascii?Q?kwl6m/+m1vLoP6q3JzcnyDf6875+rdCfJEAzIGorQVFelp6if7gPkqLQKy9t?=
 =?us-ascii?Q?GEHVZE1DLEA7uif18qHZJHZU+wGC4bTUgy19EBH0VbajVso7FYM4oO6qkz3A?=
 =?us-ascii?Q?HCHUNo0vdZ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dtw3KU/BE2iW2DfpErgasDlr9dLVdTC/iUQaCF6/iDwoTECsnczykip884ff?=
 =?us-ascii?Q?YV0NyMWZ+1jNRmyxlMg4YlDJ9o83JNXEPhPMMV0sIZwXtB+2PIqoMMdp4cdp?=
 =?us-ascii?Q?Oq+j57ibFK7sRCLtLKVQZp0eP/cvCe7BfLLp3fyXWgGr0Us9/++XTFKRHmtl?=
 =?us-ascii?Q?iivoMfitFO+52Dca10ZnkgUwgQd6DLEvNi+vudV8lphVAK2CwIKCpDhd+V4p?=
 =?us-ascii?Q?j3S8GHhQn0bf4eYccCTy+CwK1L9NdDcXQ5+FUuPXwcrlgWgRAZcYhP784iYY?=
 =?us-ascii?Q?t0EmOvGqc+0Ez8eUt+VaOWwnMxCQxMO4clpsOIAlR5SscSYmmAmKQlPKXfj0?=
 =?us-ascii?Q?sb1aK5fS+EW9eFmXHevnMGlIvLt5z2zKt8tn6sHXpLTjx0gLJM7G6/+8+j6n?=
 =?us-ascii?Q?gjGd7zbW+buQ8apR7XBdJHwPUvxeXTnYFnxDkB62pnSlY63xab3T7RsD/292?=
 =?us-ascii?Q?7c44rYFtBp0SzhgKZ90czUxOaI3ncwiwWNaOnzKbImFeourPRNQE4SbIuPUq?=
 =?us-ascii?Q?QFd1ARPgm6yLPFowy7qny1X0UxPEH7y5Gg3AcIprvsaHasqhhCpeygIRSQ2a?=
 =?us-ascii?Q?9OB7lG5P+4k8BDzAvi2O4zPAFMAbwQWRwRHiEcMr39nEkm/cuXmOlYLJRmNm?=
 =?us-ascii?Q?eJpKCmX588Mr/1d/Vsfllep1GCJn5qT37iaRZC9cyA5vXzNku5g/TuBvtzkj?=
 =?us-ascii?Q?nUYXs70DCix38tBzurm8tgiomE0I+EwmGYKuYDVGU37IhQCakxiWBV5l5QPB?=
 =?us-ascii?Q?Ro3uyDoLIDt+NQSO934cTd7hn0ob1elG4j19JiRwEVBopDHLWnkF++OaDsWH?=
 =?us-ascii?Q?a+KkcXo23WGfP9Tjgz0rRGYWroWAm+9QZ644MLeALphGerpH3LZo2wq6Ars3?=
 =?us-ascii?Q?CB9icrNP+s2W5wyofGzyL9GOH9LM/xWHiwTaLDulw5gF9LW/HKk8x47ln73s?=
 =?us-ascii?Q?u0vNdRDaNBHAA8Zdru5xSv4DqzkBcdH7Ew60M4eE2SfHaVn/vKi3fVRamjvF?=
 =?us-ascii?Q?yHXLNTqCpGsTpjXa7eHwuQ6N6ITVTHjqKQ3tc6/IwUkOngjOxmmseBoShOjX?=
 =?us-ascii?Q?y8S17o/O3y0cfaILdceRDju/gV7bxkMQ80G4GqePDe88zvuSXYirK3L0pndC?=
 =?us-ascii?Q?SQ2S/XS7JIt0h5/HeRW+6xvRVsG4ARMVM2VYUMrojT+XJ12WhCRueCGcLkWq?=
 =?us-ascii?Q?CJqnKe3QSNqBcsHAHZFHUDC6p4CTKbLIKBGAmb0wscowH3muEv+hXaParEA2?=
 =?us-ascii?Q?DKz/gM0n4gV1vplAE3uLcXcJ5WweqZa8EWSUD49JEf+j/xvFR7ER0tn9sLVK?=
 =?us-ascii?Q?t2c4rlvEvXGavX7SeRkEhGSEiSIvwB9kD9YwBGxwh8QEXcv48P2QqsR8gl0l?=
 =?us-ascii?Q?ctbHUoY2YEQg6Z0gvaga797ZiC7t1jeSASuqcKLxt891gLBqfaAamblzekea?=
 =?us-ascii?Q?kjYRxv45YE/rZFKdJrGTO5i7Kye8Klfj2g2CvELwU4U07sNP3/g9RD7orzKt?=
 =?us-ascii?Q?d8EsKQ5z3ovEwTDLnnSVUD0ZZSKTVrl/5ncHqbj0BwCgBZxwXiOweWJpIJY/?=
 =?us-ascii?Q?GWEKRJ+j/8butbnYT8k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4781132c-e9bb-4737-efbc-08dc96f48c07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 22:00:24.6544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dzCvSTLgkfxVR0O+K/fr+sVCFUg/V3Z74Lt3rNan2Ow2J6S7AeSoyfQaNtuUUY8K5hIN3HNDiEXgIgJabIFzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7259

Add flexspi and child flash node.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 660e623f4f964..ed8921d6217b8 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -163,6 +163,22 @@ sound-wm8962 {
 	};
 };
 
+&flexspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi1>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <200000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &lpi2c4 {
 	clock-frequency = <400000>;
 	pinctrl-names = "default";
@@ -336,6 +352,23 @@ &wdog3 {
 };
 
 &scmi_iomuxc {
+	pinctrl_flexspi1: flexspi1grp {
+		fsl,pins = <
+			IMX95_PAD_XSPI1_SS0_B__FLEXSPI1_A_SS0_B			0x3fe
+			IMX95_PAD_XSPI1_SS1_B__GPIO5_IO_BIT11			0x3fe
+			IMX95_PAD_XSPI1_SCLK__FLEXSPI1_A_SCLK			0x3fe
+			IMX95_PAD_XSPI1_DQS__FLEXSPI1_A_DQS			0x3fe
+			IMX95_PAD_XSPI1_DATA0__FLEXSPI1_A_DATA_BIT0		0x3fe
+			IMX95_PAD_XSPI1_DATA1__FLEXSPI1_A_DATA_BIT1		0x3fe
+			IMX95_PAD_XSPI1_DATA2__FLEXSPI1_A_DATA_BIT2		0x3fe
+			IMX95_PAD_XSPI1_DATA3__FLEXSPI1_A_DATA_BIT3		0x3fe
+			IMX95_PAD_XSPI1_DATA4__FLEXSPI1_A_DATA_BIT4		0x3fe
+			IMX95_PAD_XSPI1_DATA5__FLEXSPI1_A_DATA_BIT5		0x3fe
+			IMX95_PAD_XSPI1_DATA6__FLEXSPI1_A_DATA_BIT6		0x3fe
+			IMX95_PAD_XSPI1_DATA7__FLEXSPI1_A_DATA_BIT7		0x3fe
+		>;
+	};
+
 	pinctrl_hp: hpgrp {
 		fsl,pins = <
 			IMX95_PAD_GPIO_IO11__GPIO2_IO_BIT11		0x31e
-- 
2.34.1


