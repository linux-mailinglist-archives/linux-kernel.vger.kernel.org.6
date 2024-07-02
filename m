Return-Path: <linux-kernel+bounces-237244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC6591EDD7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3879282F77
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B977C374DD;
	Tue,  2 Jul 2024 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fgF8N83i"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914D946C;
	Tue,  2 Jul 2024 04:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719894170; cv=fail; b=W8mt5ivxTaoVM71hqaW6WptxXqxPTK7WuBGDrP/NQYlMZVR2UmsfLN3N6+6KfwOGpRARYmh3zMcJisfyVTuq/Z6ydQwjSjx0C3bbmGTZgK3jVnys3+m0x10X0vlFgBpZ6q4Z3YTM5GbFojB0TJ2Ogz+yEjeDRiUXOja2xXlPOus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719894170; c=relaxed/simple;
	bh=MADVXObtM7Szyo5Gkqs6OBvkrIbEse27CqOrhT2/d4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XotQPiLqFNwvIrmAqpLQn5fDO1en+SXJUrauXn3ZONqPSj3I+nTZWnnA4I6QnywHQtoFcX+UHSp5yDUtIBqeD1Yu89fkXHBXeuQKClXIHbH66jyEiELYpBi879yI1KU2sfi2dC7v/gZYMct10oZkkXlc2BK/e/XwIY7XVcqCIUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fgF8N83i; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kR0NSf573KG0+JRlUvlNHpMHcJv3AU6Pn/QH+Kf3kVwO0gMWBB8uIMh2FjzoDrD+PBEfXCS8ZWa1Votq9NM5oaYQAPlDT+DGTjBzFzgVrrW3IOWC89bh2ZtgQheujRJMWO6NbK3v7zNsR9mihk3V3kFFc5xs2ZANY0+UgOkUDHVHhw6xL1PmWeOKTY0pOFide5lW28kE1uisdxzDFe/0NsYDhkTx4XHM6KwnE8en8fJqqFzwqmJxeIOpqEG0YIsBriJOIqb4edevHt0mxHM38urQCJM7U0+xkqKXbF3xqJSlhj1MFph7wMPjBK/3ZwLDX4TWjOKVHbpnEaSQFTiIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaeEU1pqnCPcNJHLPoed9KNb52IXKv89WKlEao0QDCA=;
 b=aqGzHkZA4dsIz7lGIVTMHncRQbFHDOWZ1KfX+CRFB4QD8aediM7S+qHPhXADp9op+MXu87L7D8OMzSwdUuObVhDofI9+upwlm/JkE6PPROryNNBkv9c2kwBygd8WIv8RTeGP+ORNFqxsbuYYtZsgmXIU1Sl/mY8so5sylmx3AgO1upRP45u+i3weygNcOkBDL1jEBOHVYKVUg1RPYOeTV/YP0c9URuPJzKyuRmcOaZ0CysaJN1t7zVsGyGLDy3+DJeqdZi7MhJFveQy5TIqFkhFOniTQFXfeZc237FYLE2HC+oSSUILrmDLIzJRgkIDZLG28iV5FpwkPsyTOVOV7lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oaeEU1pqnCPcNJHLPoed9KNb52IXKv89WKlEao0QDCA=;
 b=fgF8N83iwIscDJLIzBEhKBJVEVSCh5A35E2dZayIe8tLczlun2jlLDHAGvDQsCv2tUWtQpSr1sBJ6Gb9jCI12wdqVm0lwkT/wPNNHoKEmCumzFtxwjjffxAovtiir14ImtfGP1EnEPm2sLveEeseSIb3+GBo+W2IDIixM0Hh5mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8492.eurprd04.prod.outlook.com (2603:10a6:102:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 2 Jul
 2024 04:22:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 04:22:45 +0000
Date: Tue, 2 Jul 2024 00:22:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] arm64: dts: imx8qm: add lvds subsystem
Message-ID: <ZoOAjSUp29DBhY+/@lizhi-Precision-Tower-5810>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
 <20240701-imx8qm-dts-usb-v4-2-03cdbc8c44b6@nxp.com>
 <ZoN90rHfpK7niqEr@dragon>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoN90rHfpK7niqEr@dragon>
X-ClientProxiedBy: BYAPR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:74::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 677bca1d-ddbe-41d2-5a04-08dc9a4e9fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wa9cpbjw29RRUYUxntL6xxFDJMsFoiPhJgDF7qP2zIEpjJPlbsDoKTiO9e6t?=
 =?us-ascii?Q?XysGyVytdqTfR4ji1qxJRYHnc7De/qfZGVycQKYBDgtO12bOT02Wjz2vQxnP?=
 =?us-ascii?Q?xyxZpdhWhixTrCKdaIEctU54kbY8Y5EEdZVOwCIp6M/NV3Qkr8lhWG7oVSnz?=
 =?us-ascii?Q?1Bkvj+MPHOlgyFfZZi9uoi+1XQQKaeOrCASyhO1EnLCN3QiIPOHQ32zJGPQh?=
 =?us-ascii?Q?KuUBeQ/20p0h/+8QjU5CTcNvNlnAZa92KtIlJZ5/rYeCdvbmN0PE1GDQRQuY?=
 =?us-ascii?Q?brcDJPlg2GAcVq3hRxnNG/DosHEwC68ueVlBqTcLJZ1UYR/7qN4eVAm38F7B?=
 =?us-ascii?Q?qsEXIE6yJKOQF4WMFBjVKoclzqdafiExgoAarcvkkeozM44zZU9f/fZ8CJbW?=
 =?us-ascii?Q?yPQmyU/oahklFNXNJiF3kBTq0idv2Ae3oY+mAD0mqxJsTJTO9Uuq/N8dngxc?=
 =?us-ascii?Q?pbFyfM6M+SMEJ6BC1WX+7SNLM1U52panGGTiaEHgNu745a2fX6EZIPz7E6V+?=
 =?us-ascii?Q?jCzqhat2eij9k9B1OTBbAy89ccm7j4bfIPPvNRBBDZjLinChqdVEXA+eG+pi?=
 =?us-ascii?Q?lsqDZicfq0QP0PUtl65s3wOmqWURVmgrpF4TT9rjqDLXh7wIRtYnHe3QdBAf?=
 =?us-ascii?Q?OO+wKq7oefwCiprfQ18OSNjykjtt9olPMpx0R5zR4B/Pg7ig7TwAcP8ITkQN?=
 =?us-ascii?Q?CighW8fmSciPRkInxdbHCMOEpcuXVDZ4kJNbiJXYAzkIsAopEDR26KEIqfgV?=
 =?us-ascii?Q?bvLyIrkKqqeK2XcxziAzvcmnH53buQtZyx4zD5ZE1sKtxdrV0dz0A4wnVA5a?=
 =?us-ascii?Q?1sbsB7mILzMHf9AMpVBDo+ATWuQKp/7kZ42EHosOKpY7yCR77FAyGykIpaUc?=
 =?us-ascii?Q?lcm7q0HHnOPV1d2YszRN3dio1ZyvilwRNv9VEPu2AbxlvACTdjsVhPcG7l6E?=
 =?us-ascii?Q?NcADZL+W311hHVsneVHZ12pSxmZypVHH4TY//9WdGMYagjIsb3lV2Dx2oSxU?=
 =?us-ascii?Q?JFGu6vfi8zU81GfHKaY0fEAeuSKMSFtncbdIsAWoUquDvI6c6RP+T7WmVC8U?=
 =?us-ascii?Q?Urs37IV4O+8YnFFvIUX7OR89m9A/k/Yz4qtmGQL4AcIybsvL3+Lw1NNtXgeH?=
 =?us-ascii?Q?Y6CS30+ubggInM1dH+KheU4bY18OAVw7cNzDOo/W78otPJsP6pSld0kgGX60?=
 =?us-ascii?Q?oLUiJBtoMwLHsD9kJ8ODM7nqPb72YFNR9eOBVK/x5MI8x8IXVAMdUwhep3Fw?=
 =?us-ascii?Q?31E7QkiV4VuJowP8MD2JXDKLeq7F5FXMpgX6y8C3WuZrRO/EXhP0jv+sUKTB?=
 =?us-ascii?Q?MC73iTYKlkK9F97SxetNsJQ7bcdp83pYxOGTCUsvWAEKMrbv46GWHK/GKZgu?=
 =?us-ascii?Q?xvGf6Fg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Al0mVDi2f2MC/DfmUShRjHpb5A0JEl4mLku3ce6cUNno2X6Iwv2QlP7KYUYW?=
 =?us-ascii?Q?pHpFbtwthg87UPlDqnEN16oaMb8Cvu/IXOzP2OC63S70NByYcYFt5DulaTrP?=
 =?us-ascii?Q?rbq9erUPzRfpKIfoxQC5fBTKfEul8YRvtWSPJBJ01BeBeifRcbeeVImhYgst?=
 =?us-ascii?Q?mgsG2Fe/qNeySleaFr/HDTXJIkfQ3GY/2ydZWo/3gMh5xl8ivcwZyRYpDecW?=
 =?us-ascii?Q?FpRuSdJ/T3hcHLS3x2s3+CeU8uBus/HSqfT6kgyLOSTBlkZVIYMeXNZDXr6Y?=
 =?us-ascii?Q?oM5hWPPDAHS23WuC83KO5wIaoboYySndMLhvcqvIfMlr7WlRsaHpJWFVjuPb?=
 =?us-ascii?Q?W/f4CRH/fEi7HtSHwPEcyHH9AMYtHHdF3oNigychmT916jwFQ8D9rcn1J2qW?=
 =?us-ascii?Q?SfOvQQ0WMtG+rj+CfNickApDKeogd4BOZL6yvtKX/RbE7FDk3SvrR3Eiw9Ix?=
 =?us-ascii?Q?e6O+SUk8AR0o/Kh/LXjdCEJ2daEzk1Wtroj5sSjSordY3NE7VGlZMBz404to?=
 =?us-ascii?Q?qQjMqHLckXe2GM3ltg5lChnCOLK4QCrsVWPpNs2DElGvuSCaMROtzXbEmyAI?=
 =?us-ascii?Q?+r7bu7P5YZVoJ5UwjOcHbtrESoGFyRksM4LA4wW4ucjhftKU4hHWJ7cUR83x?=
 =?us-ascii?Q?ou/x76EdQrNyzAfm/71JPg8c7VkYhrOybsBdyGFslyAk+rq8mVbvz4umakyk?=
 =?us-ascii?Q?JrKVRz0nc/MymCiAKOJPQ7ybIFyodYpXiKiGluQjlg+208jUK+io92G/gt/g?=
 =?us-ascii?Q?0dIkrr9fddkt8R7QVq0koR5IJHGMH9IcWhU+8Qszv+2fUC16SQkkiJ8XG+Oc?=
 =?us-ascii?Q?B+HcyfipM9vLMrgJyTCqsqGPhVlydNzz/NM8qfI/d5QFvmm5AsmVlKt16nhn?=
 =?us-ascii?Q?7EOB3u1ymmjohuJcz6iUuu5Y5qj0MedAgrefEMFP+tSIT+qMAhM2Al9FFhHH?=
 =?us-ascii?Q?MDXmOqbArDnBJ/SH9FGsZWgXaPx/3krRlCYHEdS1SpwzZQB8SIS0Gd+SAUTv?=
 =?us-ascii?Q?PUaiepor9sA0XW9BPc6lUdmMX234A4yaO6DRBZiKw02NzxKn0r8rB+ZVjWn7?=
 =?us-ascii?Q?Yq4YZnEM5vdq1f/+lFoqETgNNy0v6Y2g/WqC8uHu9DurggaTHwiS1EvMjRHz?=
 =?us-ascii?Q?JeRfOl+6ZAPhYaq2XAF4cqjRHYKL+HmO/rjTRg9J+79E62RRZg4Xref4vmX3?=
 =?us-ascii?Q?EfBGUVDDTyZE1duKAsjOqhVwd4KRsfObe7yhF4CtzDNqE1PfrXSvb4HwxyYE?=
 =?us-ascii?Q?8NOY2uCk9OdoQ+nqaLh9luPRUgbDwL2vwfIEHjba2XeQa1pz6ddhkqOMtOy0?=
 =?us-ascii?Q?7uOL/eP/yLBdLcjqbSUBdz+WIdZ6m8OtrNdM7x3AB0rlLQcXKsvR5qkALXfH?=
 =?us-ascii?Q?TweRDZlsJ8ISP8JcUKNSDXMo/sm38xAAAvu6cgtq+O2u3VTqkoohZLmYEnNp?=
 =?us-ascii?Q?G4VShiis8/PJOSY24gVnFBOjqM/7HgisUbLfhh4FdvVzOLR8+VaE+GYBKKa3?=
 =?us-ascii?Q?3U8FGaJ0JjJ3xCHmG6Gc5K/wJzFkdpsZ16vmZFKnsE0EphFUANzC8fkOvIkU?=
 =?us-ascii?Q?tz/GMbXL4YoscmnF77k8wIGaX97QUKmHCi1y3JJc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677bca1d-ddbe-41d2-5a04-08dc9a4e9fa2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 04:22:45.7031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pdbc6TWnZ73WaLggrw5JEuBhegbHm5E+dKqhxvXrsHgcze+1RhDhw9/KaLya6V8ixNOq1zkb1DZw4qRuOB0Tfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8492

On Tue, Jul 02, 2024 at 12:10:58PM +0800, Shawn Guo wrote:
> On Mon, Jul 01, 2024 at 11:03:28AM -0400, Frank Li wrote:
> > Add irqsteer, pwm and i2c in lvds subsystem.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi | 77 +++++++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx8qm.dtsi         | 10 +++
> >  2 files changed, 87 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> > new file mode 100644
> > index 0000000000000..1da3934847057
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi
> > @@ -0,0 +1,77 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +&qm_lvds0_lis_lpcg {
> > +	clocks = <&lvds_ipg_clk>;
> > +	clock-indices = <IMX_LPCG_CLK_4>;
> > +};
> > +
> > +&qm_lvds0_pwm_lpcg {
> > +	clocks = <&clk IMX_SC_R_LVDS_0_PWM_0 IMX_SC_PM_CLK_PER>,
> > +		 <&lvds_ipg_clk>;
> > +	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +};
> > +
> > +&qm_lvds0_i2c0_lpcg {
> > +	clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
> > +		 <&lvds_ipg_clk>;
> > +	clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +};
> > +
> > +&qm_pwm_lvds0 {
> > +	clocks = <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_4>,
> > +		 <&qm_lvds0_pwm_lpcg IMX_LPCG_CLK_0>;
> > +};
> > +
> > +&qm_i2c0_lvds0 {
> > +	clocks = <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_0>,
> > +		 <&qm_lvds0_i2c0_lpcg IMX_LPCG_CLK_4>;
> > +};
> > +
> > +&lvds0_subsys {
> > +	interrupt-parent = <&irqsteer_lvds0>;
> > +
> > +	irqsteer_lvds0: interrupt-controller@56240000 {
> > +		compatible = "fsl,imx8qm-irqsteer", "fsl,imx-irqsteer";
> 
> Is compatible "fsl,imx8qm-irqsteer" documented in bindings?

In rob' tree

https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=285c645d842c5a15d3be2d653faaa5f68d81be1f

Frank
> 
> Shawn
> 
> > +		reg = <0x56240000 0x1000>;
> > +		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-controller;
> > +		interrupt-parent = <&gic>;
> > +		#interrupt-cells = <1>;
> > +		clocks = <&qm_lvds0_lis_lpcg IMX_LPCG_CLK_4>;
> > +		clock-names = "ipg";
> > +		power-domains = <&pd IMX_SC_R_LVDS_0>;
> > +
> > +		fsl,channel = <0>;
> > +		fsl,num-irqs = <32>;
> > +	};
> > +
> > +	lvds0_i2c1_lpcg: clock-controller@56243014 {
> > +		compatible = "fsl,imx8qxp-lpcg";
> > +		reg = <0x56243014 0x4>;
> > +		#clock-cells = <1>;
> > +		clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>,
> > +			 <&lvds_ipg_clk>;
> > +		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
> > +		clock-output-names = "lvds0_i2c1_lpcg_clk",
> > +				     "lvds0_i2c1_lpcg_ipg_clk";
> > +		power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
> > +	};
> > +
> > +	i2c1_lvds0: i2c@56247000 {
> > +		compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
> > +		reg = <0x56247000 0x1000>;
> > +		interrupts = <9>;
> > +		clocks = <&lvds0_i2c1_lpcg IMX_LPCG_CLK_0>,
> > +			 <&lvds0_i2c1_lpcg IMX_LPCG_CLK_4>;
> > +		clock-names = "per", "ipg";
> > +		assigned-clocks = <&clk IMX_SC_R_LVDS_0_I2C_0 IMX_SC_PM_CLK_PER>;
> > +		assigned-clock-rates = <24000000>;
> > +		power-domains = <&pd IMX_SC_R_LVDS_0_I2C_0>;
> > +		status = "disabled";
> > +	};
> > +};
> > +
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> > index 61986e0639e53..1e8511e8d8577 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
> > @@ -560,11 +560,20 @@ clk_spdif1_rx: clock-spdif1-rx {
> >  		clock-output-names = "spdif1_rx";
> >  	};
> >  
> > +	lvds_ipg_clk: clock-controller-lvds-ipg {
> > +		compatible = "fixed-clock";
> > +		#clock-cells = <0>;
> > +		clock-frequency = <24000000>;
> > +		clock-output-names = "lvds0_ipg_clk";
> > +	};
> > +
> >  	/* sorted in register address */
> >  	#include "imx8-ss-cm41.dtsi"
> >  	#include "imx8-ss-audio.dtsi"
> >  	#include "imx8-ss-vpu.dtsi"
> >  	#include "imx8-ss-gpu0.dtsi"
> > +	#include "imx8-ss-lvds0.dtsi"
> > +	#include "imx8-ss-lvds1.dtsi"
> >  	#include "imx8-ss-img.dtsi"
> >  	#include "imx8-ss-dma.dtsi"
> >  	#include "imx8-ss-conn.dtsi"
> > @@ -576,3 +585,4 @@ clk_spdif1_rx: clock-spdif1-rx {
> >  #include "imx8qm-ss-conn.dtsi"
> >  #include "imx8qm-ss-lsio.dtsi"
> >  #include "imx8qm-ss-audio.dtsi"
> > +#include "imx8qm-ss-lvds.dtsi"
> > 
> > -- 
> > 2.34.1
> > 
> 

