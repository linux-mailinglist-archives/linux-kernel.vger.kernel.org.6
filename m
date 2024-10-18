Return-Path: <linux-kernel+bounces-370899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361379A336C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6E41C239E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBDC173326;
	Fri, 18 Oct 2024 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IMNRL94K"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8E15CD74;
	Fri, 18 Oct 2024 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729222629; cv=fail; b=iMtCCoKtF35w8RI33R61taNXbg9nUWFOtywTOD8V78QezCTx7m+sbSzqZ1kd7C9Cr+ZTR8RJelEkSw7Cv5+zUyQu5YebaW+P7mydR4FptK+ltUvWCtiRVRRGbOLviXhqCLhCt9cZ4TwHuU2KaCb6sNRG0EtvuIukv//s8JF9YIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729222629; c=relaxed/simple;
	bh=j01v1TyHEbWCuXQyKyx+WJH4ucETePeZ7xPzacM9IQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZatyMVPGX7litHizmBUGzjgoWtlMOe7AVU5hVy8WX5g6MspLSAWlnu0jNJ9qUMcGHkm6tUX2vEyZZHntDHvJJbVV1wBnCgUhLM6QsXjzMXiV40P9Boej69r/4Ujp8o1ERh41rhI+XDMuoaDZQr8bAAWs6Q47kLZ/00Z9AwnYAcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IMNRL94K; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJnoZELTDpJRpEt6FlBOB3TKLs8S33sMTjcKi8IepYwPrhUjTZQlqswxwQnS4Bt88BrBKVmq409NBK4OjWdN4mLOnBt7lFEiXel8JyuRZvS35t5uHPIVBUCtQWAJ7fRScs1mV/KAPWt5rp5AUPiKGINMhovX68fCYHuVhhg85y0AE9m6/SX1TqgCZxLdurrX7brBlIJL6ByeRWTO7EKmPGMNPuWYqJGxj1pqNIChI7OAqMFz6m9HdA34Fq6vb+XkMjhTTfq4XV9/Nd257OwgorXL/0wB9EBdACCbrdjz5bJbjgpNt3GDKrZ2VstDVs3syh70ZSDsgvidgBubb56NBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ttgmMJlfUesMUIhlKhU5suWvQTo7nVfG8A9YhfbuLo=;
 b=RqEGvA+FTYRCzAyMpTh+7gKGATOdieHbekjJw2aWLEr0a05W/CjoIDKWTvdM83U2Y+WZi3uBxomOhiMtWhz5aljxTjrUVvfCRrvBBl70cB0nQHuYdVdm6/muw7g35mOjelVgtGZzYdZM62vaoEPfGECfT8Sh4nf8FC52Wk4JjNQfkaP567tiRjV9pn4AZjGXXkBBVznCSVXj+q0YOGFapqTSy6XFTj9RjEvWxgwmAlm3EJOPjJb+BfIIm1MbSVeyYXZp6OQfVlGRkaF461b/9Z6hgKSZnHBRr5V7PLhZkTTZ4zvOH0BSfGHTBsMPN6zOrcYkT+PBz5zgYmonvz+iwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ttgmMJlfUesMUIhlKhU5suWvQTo7nVfG8A9YhfbuLo=;
 b=IMNRL94Kw9rP8SxP710TyZvxQ8D3H2R5siOeAWfPx1lfnHBTwTyf20pQAucCcFc1ZxXJgldTWERU6e5kPpHe8I1DiBAB9jlQjPRQSgAGxjuOelNoNJ4Jt5TTp11OWsYnJ0Ju8A5aX48HvQ01ZHgkqPcWK5ULi5jtPLy3KpW3or/AIfbYB7Lna+fVg5frwwn7jz6vBZt58Kfz9YBk5w5P6orNKFEC42l5lQ0YtMNC0IF8AWHPSFoFdR+MmlDa5OTCRd2RxJM36q70wJXZL48y+WfA3V4LWqd+gKPylbV7pTtHU8u7CWzjKb4sjXJB5EltQg68nbb6wT0E574I7wa+kg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
 by PAXPR04MB8110.eurprd04.prod.outlook.com (2603:10a6:102:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 03:37:02 +0000
Received: from AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0]) by AM0PR0402MB3937.eurprd04.prod.outlook.com
 ([fe80::4e37:f56b:8a3e:bff0%4]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 03:37:02 +0000
From: carlos.song@nxp.com
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com,
	frank.li@nxp.com
Subject: [PATCH 2/5] arm64: dts: imx8qm: Add LPSPI alias
Date: Fri, 18 Oct 2024 11:45:29 +0800
Message-Id: <20241018034532.2552325-3-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018034532.2552325-1-carlos.song@nxp.com>
References: <20241018034532.2552325-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To AM0PR0402MB3937.eurprd04.prod.outlook.com (2603:10a6:208:5::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3937:EE_|PAXPR04MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adb5e42-0d9d-4428-6aa2-08dcef261953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mh6rVj4T3iCKc2JIs4DFgyfxsMfBYTfebn3aSrwNPUYSEg0ui1jx1ReFUwTj?=
 =?us-ascii?Q?HLtk+BjF8LzwTUu01lPi+6qg4Onk5JiXXlyRR9tBlN74MjXosFaX4LCLBwNR?=
 =?us-ascii?Q?ZwnHHwxWIwjX1s7X/BM4fX6WmVm+7bAWjBmr14PTMxpAUJIauo8P2lYlQUx1?=
 =?us-ascii?Q?qaDPAFgj3aht2DMXzELOcwOfZr70zEacVd80/jmhD7LsQ3tuVf2AlxAMmXN3?=
 =?us-ascii?Q?anxaJPfH9cNTxptILtcf7w6uzW2sOA4cNB96O7QGWC0an2r2YFtVm8tfcwUV?=
 =?us-ascii?Q?M6D7ohU2cnu6J/CuXyPvxXjnERwsyLz5+Lbbwpqfri5voOD5UTrWH/LZxV2J?=
 =?us-ascii?Q?wNf4GxHollgIhq1cTAsSzzzT7P7j0OKd1o7HXns67QTaeyKIiUBTJ0VKa2Ic?=
 =?us-ascii?Q?CWlZBFEq/EFR0RpqK4A0ExhdDao3xfMoAGBA5FFD5bhU+4BylwPiQu5DIfw6?=
 =?us-ascii?Q?6xUFTG2dfmldycIVexs2VWJzu8o7zQog2H94SCEaL9AdttCrKLu8frHGUIXX?=
 =?us-ascii?Q?1nh3eoW5rbutkl9ueSKQk3EwjqqzxQxrx1pWyH3JvPOFekP5TiRoRu+7i0x4?=
 =?us-ascii?Q?ft3lFU7igVUcB60i795m0UkExpqoSKpO8akUTZhk3R2FjFgg1mkcmB1c+gCG?=
 =?us-ascii?Q?JewCDtteh/Aa5pRU6+r4s238b6P+KhRon7uz9QPBwYDTy5+mtoOrGBcTAsDI?=
 =?us-ascii?Q?2Ms4g33BMgcIk/GDytmjOVl1DjPny20iEQaAA6CVJN38Vg9Yfj0eythS2pTD?=
 =?us-ascii?Q?SxijSLCyPqz33IVAJ1RyAITg4fhBFer7jjzsx9TrgDtvkaJeGMEJmtLZojxP?=
 =?us-ascii?Q?G8vHGgUhgxg7k9H41r3HhT2gF62lZmUB1LNwYWdOe53eWSI6fHBMacqIV1xU?=
 =?us-ascii?Q?DBmz15+UBpIt0Yr9GLQ+OMmCvKX69uAjwXzd7Syo5pktaV2bS+hs0N2C2VCB?=
 =?us-ascii?Q?p78hywDcksDWfHUAzBhmGWtmtrPLpleE7+xfND8mMEYJa4nNjU8vfpJFqpsL?=
 =?us-ascii?Q?CIagknflbkYGH2Yj+eR98OrcskLEYmLyanJLubA4C3raD6fJNm6wUPk7U0zd?=
 =?us-ascii?Q?ANil2rmvskD2xHkYqbkEqcqy7r2rbTJWF/eZxVtNpPC8P8XPt1bXTTygu05g?=
 =?us-ascii?Q?zpSOt1Y9ukJgWgZAE+05/8+AvcIuA7sUUiBGmkXwVe8/hP2qX9ApbGqVs37U?=
 =?us-ascii?Q?ieW4cajQRkvnzfapUhHVIn/5ehzHJjF9wKzSBDl7jYptdyaSf043coRVCA6p?=
 =?us-ascii?Q?vp4g/fapFiMjjdtGG7lvtQZFr5mF9FkgQSrOcnzPvSzqB48IaIQB6QOnzo61?=
 =?us-ascii?Q?oqgFktrU+BsomXQ1DzcBey+bDUe7LeNW3Yfyz4SHLskCPb/bSOiEe/ARP3il?=
 =?us-ascii?Q?F0zDfEg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3937.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fa6cS7F+aQfuDsJYVrikN6Z8dO7nMbgrUk+Iv9fSW8XrBVDt/1tI79Z2aByo?=
 =?us-ascii?Q?DyFkLYusCiv6/i0HU9Ase52KksRvBRR8t2qyod4fN+QT9D6QQCExXZR/yYEq?=
 =?us-ascii?Q?BUpoCHtm3cxv1hUjpXyJgJ5JbbAkuxd7QSZXiTz7Jo8KPtXULWT1uxijoncY?=
 =?us-ascii?Q?uxrpCewfCMdUbHghVkZvkP0UNhW6ROJZQ9bNBfLuKfvUovNbnPFDjF+RogdQ?=
 =?us-ascii?Q?GxZ5sNFghnLzytSfZzaV+fOukg2lVoknYb7hi82IxY98xMZS/awgRFpVzL1Y?=
 =?us-ascii?Q?i4xppTOYx2AlQFsFqeZL7KN5xMNEVpA/1k0O5Kx3Z5eoTMnvbQ6dWCPZfaWR?=
 =?us-ascii?Q?Ea7BWVeB3WDULr7gbocrn/BvyioK4QjnZqbrE4OxEQpXaYX4n8zJs6oIOjrK?=
 =?us-ascii?Q?tys65xE1ROe8KQxjrDhEcYGOx4u3cCe4Rq+Bk4INUf42pfgzndbnXpETLMT1?=
 =?us-ascii?Q?0SiMPzGWj7hQy0q0TMIHYsZQ8eLyQO841ELL7sX99hynWqohjj/lIAbh57Tg?=
 =?us-ascii?Q?ta/fi572yCEchVlNCoFz/iRCPyJgY6kIttyGmHDhHsOWKuIBIh8BnXSroVBN?=
 =?us-ascii?Q?slWl3pIPUYQhIzig9oTFj/Ux8RvHwO2u537GSBkBTxIVHYxxpOsusiEtlAbA?=
 =?us-ascii?Q?ujy9JPLCVenU4/Swzettzhel/8gMkovSf3AHSlJE1vn8J7RLsq72hFGsgTwy?=
 =?us-ascii?Q?mHMEvsv13Q/nQ/gMFe6vI2VZtZvY0ZIaQQXJJh9RB9ysNIRC/GafpdCd/XVw?=
 =?us-ascii?Q?6T/1uyL3GBP89Q8l8dZzkXQww6cB0rPiPrFL+6QP5JoGhmZoX0vSiYWKiBIw?=
 =?us-ascii?Q?fLhdYDZckWj4OM6Fibjfa3S2Gwu+0Oy7Dydw1HUf2OraTc7yHnmi+68Xw5Jn?=
 =?us-ascii?Q?h4YCj+GZvkeeF/AUU6i2I39TauqzrcFd1/vzowf3suo+s/yeBIDK+0qFVStf?=
 =?us-ascii?Q?vjK+9lpmE4da/YqO0zuqnUk9CjzX0T8QAWMS+yWHFC7/PXAzOyrN6TWMjW4f?=
 =?us-ascii?Q?7PfQzeaQsA+WHDbj3j/Ik9B4+sVWYuMKgxe8YFg8UFOVzBAv5mGDCMjmBypl?=
 =?us-ascii?Q?liP6g3J/yny/vwAdkWdTtPGJLlw9Dv7WWGlKYa+xVE3QrjskDWVNqyvnFhw5?=
 =?us-ascii?Q?EkDGCUhRMcpTIJbCaXO+aFqU0/Qx2ZaWHZXYbrQQgiiuXDEpOSlbCT3FN84f?=
 =?us-ascii?Q?n2N2MK3QnizYBI1R7MxR5ktUPgjm8So1hm6rf0G5/+wnCnfOe+2GuwuqpIop?=
 =?us-ascii?Q?O8ClcmItAIPF41FQklAUh87tLPsZfJ0b+KCDybAM/R/gbE3R5zFCMphc96tP?=
 =?us-ascii?Q?terSIS1oBOmPL0k8pI9bXiSLRrCXYksZ0Nty9jfZ508bkuDWG8+kYZmCWfp9?=
 =?us-ascii?Q?mtXKS/9Be7MK8y3sjPHo57G9a15bwG2prgOKByPUJW6H2y58B9b0WHlYqmEN?=
 =?us-ascii?Q?ZGtsTKkWRYyxjc9Ad2gq48ru6DVmA0r5hpuUaR/EMCAtYtseogGztOktSixu?=
 =?us-ascii?Q?76TGkiR8mcaSr0Xe6xajAacZKs944wP9jm2ONbxeysa9NWYB8ec8zCkwfaRc?=
 =?us-ascii?Q?FqiSzwkqpc7NAnF07cMrVE68FyLuThcX5n7qHAJf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adb5e42-0d9d-4428-6aa2-08dcef261953
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3937.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 03:36:49.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIozmGBq+VectWABPSMigLjTIsj9gY7RU0JNUB3WSWmX3EQC9ivF+Lyd+OTYestxeN8ExMKpFZ4H/FCTdyCoXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8110

From: Carlos Song <carlos.song@nxp.com>

Add i.MX8QM LPSPI alias for kernel LPSPI driver usage.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 3ee6e2869e3c..f364c9240381 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -24,6 +24,10 @@ aliases {
 		serial1 = &lpuart1;
 		serial2 = &lpuart2;
 		serial3 = &lpuart3;
+		spi0 = &lpspi0;
+		spi1 = &lpspi1;
+		spi2 = &lpspi2;
+		spi3 = &lpspi3;
 		vpu-core0 = &vpu_core0;
 		vpu-core1 = &vpu_core1;
 		vpu-core2 = &vpu_core2;
-- 
2.34.1


