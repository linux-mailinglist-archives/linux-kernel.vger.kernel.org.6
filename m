Return-Path: <linux-kernel+bounces-267808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B716B9415B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726D72856E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488111BA86A;
	Tue, 30 Jul 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cj9AwbfL"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2057.outbound.protection.outlook.com [40.107.241.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94D1B5808;
	Tue, 30 Jul 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354524; cv=fail; b=o6b79ejecwhYJwvd3mkTSwMOjxDShnKfiQYlbGT6mKallRYhrIlY7p9D3VA6erR5V3k1lXYh1Rhpwr4F4FhYOPUZ8kmQmaSmZYIs2a9msj85Sq69dl1/jx3I7ya/vdE2PJud5NgSpyiITZRp7Ektz9Uhf8NVGGgLTNZ60mS11Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354524; c=relaxed/simple;
	bh=LMWnbSrtaR4qWrU/o5yEYHwnhFjP2yRg0OF69n7CBnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b9GLksAsq7mwaL+/H5sfVwo841+sCcTaBABFpJyVw8g7/ypzansXPEI4r7bnW7DnFIdZNuMx0KmxKjzG8UdC45bfYE9aLu6Uz39Ybl2MS0U1WzzwjBfWm3e9uo0hF5KPX44/gt4GArpGqQgLr+scOwTYDcmgOwtT7K0U7F9Xhhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cj9AwbfL; arc=fail smtp.client-ip=40.107.241.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbSsftcOnnhxi9tPasU+ZcZjOx+hEjKWI3OJPSQiz0BnpQVM5SwiMEIBZdP6Xr6szimGMNbGrX/U2oO9zDuAiMM2EICFCByRcjz7dWJM5NCa8rzN2VgNLWYyH10VAc86Qe8Pw4JgNuNCRZZiXI4+ctXbzDHPKiyam1DjnABx7aOqvylmP4p2wcISzpv0y4iyKunWusc4dsre5lJDduejHsPwmKuwqtZW3bi1zYK9tq6obMci0dqoV2lGwl1a/GQVlxTVRjhc0qbrbj8rLznjwZRB+nHcfkXYd1LJf/aI/r/JH65Z4vMAnUvyzyAkbYZfeSMATtZVqXdxqzHQZ629SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxgr+jGJ26Td48XD0u4lS6ZxKlCIkQ7YPu2en6xMBUA=;
 b=wtp+vDtGorM4mbEOrCu3uzzjjilkB93z4ZExdsUz7XP+EJf8HdOwqbjERMr7s72uJG0imz+QmBQjoNS2CTJf6qb6opqw02l6TKs1TaiARzhw8ex2uDE8koZxHFC3k7rgnVsc9pfjhYkXW56nSIB6MK7wmyKF1n/81g6+NMK/k4IV1YwR+AEqR9cyoduSLPvWeD34b5nMCd8/aw50cZE7zY0JnT6z61FRJ+hxuXaZhPMPGzcp2OaWZeza0Z9XbhSKOVYE5olYB3IJPJSKfUewQ2BuSo+degCno5X6G+ljc1hPhw29+Frh6CjwkU9cSnoeWJGPmy//Xm3nDyt0uQjbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxgr+jGJ26Td48XD0u4lS6ZxKlCIkQ7YPu2en6xMBUA=;
 b=Cj9AwbfLcgcyVs2vx/ri226cmkYYbnFpGnLmGFv4P4wI0SHrBlm/LrLdv5ImiOx5cBkhraO09B/9O1pkaMoNSz551OWlzRxhfzn0OZPa5noxWmvmAQ8v23eVE0tTJgEXvDgrc286wK3YEC0JqjW2WYH2D5jEFqohZyBl8bcRiKOi3U5Cd4xL4AHZIz0OoBbmRtIqNoy+Abzi9xV7cypyYA2NVCnkEOMZzvwvoakpJFanZxGPm+sttpyMGGm5WG9yoQnS9pE+RD9W+n26beEWhA1WH6pukjPq5T54xb42OkpNU2gfOZNtEegrysbDzE8DPvCmw5ZwT7Dtrp9NSrXTsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7864.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 15:48:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 15:48:38 +0000
Date: Tue, 30 Jul 2024 11:48:31 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Shawn Guo <shawnguo@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH 3/3] arm64: dts: layerscape: move dwc3 usb under glue
 layer node
Message-ID: <ZqkLT/2myU7S4uYu@lizhi-Precision-Tower-5810>
References: <20240710-ls-dwc-v1-0-62f8cbed31d7@nxp.com>
 <20240710-ls-dwc-v1-3-62f8cbed31d7@nxp.com>
 <20240711213846.GA3049961-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711213846.GA3049961-robh@kernel.org>
X-ClientProxiedBy: SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: cf09440e-1775-440f-4aa5-08dcb0af1414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vYjrNpm2+oX06Ad7f6hbaaYv4CBUOjNMu/ZG7nIfzhQhS0hv19SRH/zvt7qW?=
 =?us-ascii?Q?hb+OEHXsg6Xj6p9VGv9PJ5HGxaG3FdH33VAImOV69JEDS6/FLsc9hC5pOo01?=
 =?us-ascii?Q?kyO0tT/oT9DcIyAacVk3Edn3x8ZGIK2kxmiozDyGX4/g+fLt8EoYPT7G8iZF?=
 =?us-ascii?Q?Wf1o4u+6YiKND1QvgVrUmRBiedLndRMQC9bJd8JChOUyJTMs3K0tZmHU0X2g?=
 =?us-ascii?Q?Ya4ZI2W0jFayePpaj4XYTX7huCkV2nYbAVc0uHK80vYBRD8VjLbKAmW8If6z?=
 =?us-ascii?Q?167yifBnn3Gj2tnS/q2c9gCBmFqQNKMp3jvsohaz0aJb0Ger2clNnb6kDG2A?=
 =?us-ascii?Q?OUnW2rBTVIMsXuvzGX6XLWs8WEk4tnjFYKctBDMuho79+i+w8phpHWxIV+Js?=
 =?us-ascii?Q?vypfVr9z8MxOVfeN+unCcahVvm4340P2XZXlya8suGlP8ZhE39op2AReFI/N?=
 =?us-ascii?Q?WKZPiV+bbIgo88U9OllnPxWuOsjo1BDoh3Y6oKZl5Q3yAgmvvEmmbqSe0NIC?=
 =?us-ascii?Q?bN4of/reXwPSg+3RovABLIFshPtTQutFiOIuJvqsXUnKBJbc5a5ygCxwftJI?=
 =?us-ascii?Q?QEyRZeUb0ljTvKqvxeoh9gTuSV6Xx+9PNa5/FHn5JaUgegwVALlOGf+BxTZS?=
 =?us-ascii?Q?ITmhWHeDPaAuZfLscOISdMi/KBO6tGaTUj7ahvxF9HAdpc6D6SJqfBkdTr3e?=
 =?us-ascii?Q?pB3WJWEDV9n7bYrmoOnFoQ9M3sZdOD+F3T3PGIDkOg3gqTKrcegQKZBeqaSs?=
 =?us-ascii?Q?4dtzQyQe1ZvmHuwf5PHNwolkxRugzSpemqKbQWPmYEzBNgy+k2niDf88cZXF?=
 =?us-ascii?Q?/A0AymEst0rq2/vPYjufCEfOvVF9SNCzQhqBdjSbycYlHkPb8btBAt2D+ucX?=
 =?us-ascii?Q?hRW0oGe4aiQCYkkQTC7f0VrLVVmK1dktdVJN7PvXbShuVUdvzjp1C5kqtbfL?=
 =?us-ascii?Q?EKTZo4FhCTZmSewxKf7g08ybzTYMCpvof8oZSvMcXXWDZyP5S8mPKc/s+Mxc?=
 =?us-ascii?Q?mRAkCT27NwnO93G/KrD33FtBFSMN2o3V0HYQAFXoBgnW83FXEukBD4ncGC2O?=
 =?us-ascii?Q?Fy3H0wTI5XsSZUUPiqw2Y6EUgDJu2JGLihO44B/pUA5S//JLJtLWYSlaJzgr?=
 =?us-ascii?Q?BCoc2b5MEe0qTktylDwJ1RqFKDBu5NyWbTKqg3KgQDQk1q6eZF7Kn5VOMUKm?=
 =?us-ascii?Q?fYUKagTpo8g2j9ifAQ8OyMGrzH5kSEeBX6FTaLOhJSKB1oN+g54WincNRrvw?=
 =?us-ascii?Q?Z5x6caQ8e+WmwjZw3QpjJHqK3dSOa19Ax+hWfzVow1T0+TOOuTzC0h4ggCGP?=
 =?us-ascii?Q?uPtOZv2O1CQgoLOZDPRRXkptb2eSDk1O8z5w5fjriLJ9IxglCXtlBw+mA34P?=
 =?us-ascii?Q?7PuN6+bWxq19l602fmV0msF1epfSZ2JqCuycdI2RWy2wOMnD1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kFlk8kJZg6eE1JBEoxndD++NONuBlpA9e0IuwBiIisJk158SEM4cl+k945se?=
 =?us-ascii?Q?AIMPcccarjPPK0rAbLOyl4J+QpqC6WmytpJVfBQv2jwUMgDZmDPSAlhvOLpm?=
 =?us-ascii?Q?UsNcAARwgIyJ4Cc+ln8zzQwBxfoiRgRBwqUnrksxMwL//1DFWWhf/w6b7C4n?=
 =?us-ascii?Q?8DbXeG3gWeZyHK63GO4qXGQxHAKh20ZHxwWndghDIwH4QWA/GtEcjMDO83lX?=
 =?us-ascii?Q?x8MAuFjVUswk6YwrJimvSRusIUY5zRP2BXwYP+8vU7/i0fv9NT02FTTi/0EF?=
 =?us-ascii?Q?HDIBOWsp9BiYzrrF7eH0I3D8S6aWwEV4OnOI6IrYeWf2kdBSjUkdSj2O3DpL?=
 =?us-ascii?Q?Z2vOo3nVsJQYggJtDcmz+k71OS7cd4/8+qyxyO5rHrFixctYXpNJ+DPhlRdn?=
 =?us-ascii?Q?yOQ6prnywXtoMBoOxx9zwSU+Pf8yZJuMyzcTMfRvYur/TfDtz0jhXogjgsiQ?=
 =?us-ascii?Q?jl537wkHdTGbiPQaAiww9UjO2ucJQsimYRKFrT+h7BhQxHmK88ufBSDwzpt1?=
 =?us-ascii?Q?hrQSp759/5L/wBZgvRGCq20tbMvgMNcnIPM1DBBgbAfTEuoFs8chA2jok+xr?=
 =?us-ascii?Q?OlCVsCnIR3+web64ZLJBSHdw5S3Wfh1WRo2bLuKIQBAUvQMQgVnjcUrsfC7E?=
 =?us-ascii?Q?so+OD63exPDhEeSegeTh3JOb7p2VvPG8EVAq0ZTN4czUYRmVfE0n1SO0DNKx?=
 =?us-ascii?Q?nlyU8wC1kIX/R4Yb4qhnZ1cblYzBa/UQMZDuSkrUacCTdCqxIRqB/htShqvS?=
 =?us-ascii?Q?m3KzOnc2fDRjKvWrls0coOziNBSy5LLIuKmY98SiNm2RvdUVB8pGO0LuNifx?=
 =?us-ascii?Q?J6Zwe9f8TU/FHn84OBV1z6GqucAeIiw24pMGeLX3WCXJMyUculNAbNGG1FlC?=
 =?us-ascii?Q?WZ88ZZa73563a2NUym+DUdRf6qDW8iDbDhXWHxLkeIUdFR6jcttp7Yc5LWwI?=
 =?us-ascii?Q?JL0/pO33Kiq4xbKr1YsFjBHhORAq7ryJ6DTyzfDUzs+RX/P2KRov/eaFOH0Y?=
 =?us-ascii?Q?zvzDNl5wXIp33K/CfUUFrhAr9zOc3G5kdYFRQVZ+WlM9003tGnLpqy3dr+xB?=
 =?us-ascii?Q?tyK2ivk/BkdG6XJ9tphCE/0gpqMei/0pNPXxsMCAaf68kYccblMqvI/YeJ0F?=
 =?us-ascii?Q?jslCmvZVaPoAsBQ+PuD7pyqyhMC1Zd8vI1s8TExD5rRUSEA3ybjoDX6rgJE/?=
 =?us-ascii?Q?z/GOjwdRnQl3LD3yId1GISgTngX/r0toQa2zTznWGYmZyLFzcXLaLUg6fGNp?=
 =?us-ascii?Q?xBFyZu45Iusez7MW4dYA22iqSFmfyQpkld8nM4eqvf5bjB8zVcNMvbjA2QO0?=
 =?us-ascii?Q?jRSUyegN0N3C9z/81Hhjs5M+9lMzQFlIA5hY/wxLZZ63hB2xfhBRqyKXf5Eu?=
 =?us-ascii?Q?geVtAiXfXovluX/rHi7ofJantGhE8szjn4qMjLqtt5xygtiaNpFCv6kQI+Kw?=
 =?us-ascii?Q?3kKLTlvUqDLj+f4oiWI5cz9VAtgvkWrOEa0VJlzjLxU8cfBJgTKX/EJF0zpe?=
 =?us-ascii?Q?PUSeLeYAp+Bq2k/jbGfFVjMa1nhQH8m/P0pdCc5YOVZrzreAceZCpD7fgOg7?=
 =?us-ascii?Q?02qePoCL9gjqXQnGacEeud7BlsEU2mg7YnF+uPEW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf09440e-1775-440f-4aa5-08dcb0af1414
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 15:48:38.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlo+CDgUuLCdChnhtO1tv+aZ1/kcImdmyp1b/UOk1itFeufIk1PPIxZwkSFH/9hqU7VZofO0ZFGCOyM0sZfY7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7864

On Thu, Jul 11, 2024 at 03:38:46PM -0600, Rob Herring wrote:
> On Wed, Jul 10, 2024 at 07:02:24PM -0400, Frank Li wrote:
> > New usb glue layer driver support enable dma-coherent. So put dwc3 usb node
> > under glue layer node and enable dma-coherent.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 43 ++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > index 70b8731029c4e..24b937032480f 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> > @@ -615,24 +615,33 @@ gpio3: gpio@2320000 {
> >  			little-endian;
> >  		};
> >  
> > -		usb0: usb@3100000 {
> > -			compatible = "fsl,ls1028a-dwc3", "snps,dwc3";
> > -			reg = <0x0 0x3100000 0x0 0x10000>;
> > -			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> > -			snps,dis_rxdet_inp3_quirk;
> > -			snps,quirk-frame-length-adjustment = <0x20>;
> > -			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> > -			status = "disabled";
> > -		};
> > +		usb {
> > +			compatible = "fsl,ls1028a-dwc3";
> > +			#address-cells = <2>;
> > +			#size-cells = <2>;
> > +			ranges;
> 
> No, the existing way is preferred unless you have actual glue/wrapper 
> registers. Plus this breaks compatibility.

Actually, it has glue layer, such as wakeup controller. Remote wakeup have
not implement at layerscape platform yet. But this register distribute to
difference place with other module misc controller registers. It is
difference for difference chips. I can think deep how to handle this. 

but anyways, it will break compatibility. I have not find good way to
keep compatibility and add glue layer, such as wakeup support.

Frank

> 
> > +
> > +			usb0: usb@3100000 {
> > +				compatible = "snps,dwc3";
> > +				reg = <0x0 0x3100000 0x0 0x10000>;
> > +				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> > +				dma-coherent;
> > +				snps,dis_rxdet_inp3_quirk;
> > +				snps,quirk-frame-length-adjustment = <0x20>;
> > +				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> > +				status = "disabled";
> > +			};

