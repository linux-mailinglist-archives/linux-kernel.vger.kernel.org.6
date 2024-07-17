Return-Path: <linux-kernel+bounces-255301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B25933EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8861C21165
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BAF181304;
	Wed, 17 Jul 2024 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RTLbBIFh"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3781109;
	Wed, 17 Jul 2024 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226964; cv=fail; b=LpcOONnIlunm6zjYjEVwcwWJMhtYhF8FCJZHWwdz2THm3Vmk8S1JWqT5rwhy+viqmTrLtTGsI7gw55X6ghPBQ0hTtx0GuYmxD9BjROV2k1yid+Dusz/x7xv4ELt/tXrR8qLMrYH2RPS6j8fXBwKxwclBpkdvUFLmC/46yZJofMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226964; c=relaxed/simple;
	bh=BEwcKd6ucRB1dNB6PP5lBm0zWq9/mxYL3Rg6wJHl+Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q4NR9Gy40ihMcnGZmPAG6QLULKPcTLTwENb3Vjtfkghn7AMA0kVvrgd86pz6wCfoicJI9tRwS5V559eblKjd9LKKcFGTaSplvLNABhpJccxLneG1gnYNMZRwrbn81M5/IRqnjE8l2XTogt31pXOx24lz8jUlRDMXaR/t5U94ug4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RTLbBIFh; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxzPAgwiWbYvB0GAe4UoycCdCHdoKlT83DDfpL3qZtbpiy6HzvzmDgkDoHeqZ5SmXdDz2eP3rHQnQxSJd72cGf81Bogcg78QHzJO4OCwfryXiHGlstzUAd+m76p0lTDVWtdybQl10CHqlySNrG5/orBO04JtGYNZ4UeZELOHlMF/VEv4C7TtF8o1qj3omqNvTPz0AnxvheOnb7GlAdRkRDdt2hRguADU2igDsSOqZEOnrLtRoj0tLTevZSbi41q44LwKAyKT4g2OFXdKE6YTYbzrFmYlWglGHfaUec7fEGAqZBQ0H8iWSf/VWQebKw/KlX2ossc6j75wVYX4/ormXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAnhf6Yyw8k32jyykkBYg+PRCCY38szr3hhy+sP7V/U=;
 b=t//+aRZM1rk4VuEZpIJvl6gxAUiJjgyr1XQV06JdiVYgw5d8+aIEqfTi1YHW3kvslpjhh0RFSBfmXGJI32J8+TllDXACIJtYMqHpELb5Yp9BnxaS/TzjrrRi08d99Q0tUo77W27jB1VxHvWKBo/LOCHAznigVllUcbHFY8P1R5GsXgOObBz8ancxHJJMbnM19ORatt/hSWRNQilUax5KYkXsr1usBhtVMwBTpPvd2aD3qdq50C4TwhTXznwEBnp6COXGwBFRUGBiPomE4m+LQqEPcjMm1jTpNbYV1XamUIWi4z475Yc4GGKwj1cUYGiqeQhzaZYbZThwhQUGK6C1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAnhf6Yyw8k32jyykkBYg+PRCCY38szr3hhy+sP7V/U=;
 b=RTLbBIFhE3VhKOIMNrnRQxql54eNqEM/Ayp+SmjOgxjojlM8JR8h0o29KuzkgnqAkopP4OSih/2XJ19JO7/myk0dTVn9VQEEOp8zIaf18kiDe7RjmQSUNhRwNYB8HHraw9VSQRp6u2Dp+k1xKC6zs4PGViygr2gyfRUi/MmrEZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7015.eurprd04.prod.outlook.com (2603:10a6:20b:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 14:36:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 14:36:00 +0000
Date: Wed, 17 Jul 2024 10:35:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8-ss-dma: add #address-cells and
 #size-cells to LPI2C nodes
Message-ID: <ZpfWx4jlZmrA2Tqx@lizhi-Precision-Tower-5810>
References: <20240717135027.4116101-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717135027.4116101-1-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: BY3PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:a03:255::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: b2048344-b6e9-4358-481e-08dca66dc6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hqinOSRDIkq4Hrj9gDeDxatA9ZTTWSg2KCZnTPDZ3d4YX6BOnNDYiFtKHJd4?=
 =?us-ascii?Q?mkz4MncC1vKQ46FlxyC6BnnnvptVKtKOO1GLfMZh1U7x3fzMTJOcCTyOTsoO?=
 =?us-ascii?Q?8BgAATiwT9pUomWFhCZHaDybqJmwKiEdRH4ccBgTSNvn1kBlqbSGuS8pw7Hq?=
 =?us-ascii?Q?BIIXS1X+cugWVAPzNvcfQvEPGrNfcqQiBlXBDCyj9f+7cC+KeYLOUVgdFiDE?=
 =?us-ascii?Q?PsZDPYc6XYpDnUAdV8c/nN/P08ClHo0Y+FDv9JHXzcBkM/w1MhT8iKUUw/hq?=
 =?us-ascii?Q?kDvPwRz76PXs7T8NP3nvEXr/mnFQRziku80ilquFUWyD4qNbbIEOqmimrnfJ?=
 =?us-ascii?Q?W386RcQ6ijHsyjpjyTSzml3RX9cilfVyqS8wp49k3it57AjJ8Qj+vrXCm9O3?=
 =?us-ascii?Q?Nv9QFHbBMLFuQrV7/Suc/O6tekkuGh9jWN8rMRKxuDqkai56Nb4koYwNb/0K?=
 =?us-ascii?Q?c07KHtUSIudMK+VcYGKJ5ha+aWSinrkBWXaqRdYE1G+4/tOEDnX23OwuJl/p?=
 =?us-ascii?Q?P0Aault75TudLTHd4ngDgV+5M9lypJ1V3exq0skeGgztADv17z5wlbjf24uB?=
 =?us-ascii?Q?29dRcNixfyKS4vQMLsUBIsiwpMKBfp0XrA4GxZicJEy9FlXqsoHSwBPsjuEg?=
 =?us-ascii?Q?0iLVBQN2AhclpZZO8kwu6ajnf6gfi5CiPdUWjbBhq9FB93pg/wAt2XxkvpE0?=
 =?us-ascii?Q?wHVil5O6Th8rpjiyiZj+NDYF8bGp2FElYYBTDId2wHKOt0PBshKNxsoPk9Gv?=
 =?us-ascii?Q?ci3CpVFyLksgMqtJWtqe81dzJ8cgqt8QC5lNYgM0Cf6j/5oYm6HLogRIF0eK?=
 =?us-ascii?Q?sLHGuoF2r4zt+wEp3WPVSTem7Lod5m+yLr0jEwaY2Af9Bz151K7SFk5DogsP?=
 =?us-ascii?Q?SbyXxhHwVNYRy6GsnibDOD2f1CnlDvhyOMq1hwy4XnJJFsc3O3cT58PKKDZR?=
 =?us-ascii?Q?knYfeiRYcPygsonOLXHZuQoSHGjAwW+4YDsFH5ULsPI6i456O8zyOEdQa3Qj?=
 =?us-ascii?Q?zidgIjy9hkLeiZmho8w0v9IHI4DaEPe5WGgcPSrqHVN2XwD4pMt1lVCjsbJy?=
 =?us-ascii?Q?xzjoE6a1B1tXeqhNoGVyQ2xejjSj41j85qM6vcSjgZYo0USHVsC4v/xuirRi?=
 =?us-ascii?Q?dD5ULKrWxsp8PiwLPsphunJB1bp3nykujN9V1Ptt9fj13YjYGrKszNgTxYk7?=
 =?us-ascii?Q?tFSvTfWy9msLkslFUACApmT+SVIIRyD2KAKCoAPFmpcpDF2OFJPeAGUMpZ0p?=
 =?us-ascii?Q?o9tjQldAwoP1wnwDQH24InivOtDvvfLmv3dyMwNlkLG4RuOM0uUlAa8pi3IY?=
 =?us-ascii?Q?7z7RJazE7u/3Ue5d7mZA/nDBdH95Cmk8AbWPwhdKl5JPtbuQdBwl31so3J+D?=
 =?us-ascii?Q?b8EnH41RSq/KIzDNixGk9xc1dX1nkA2EqhKi+5xHDksQMIqigw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FXWrld51plGEfd57rd5UvVCDhZrHsILJzT2UlSDzBakKxzFdnzz8H+x4W4ip?=
 =?us-ascii?Q?LpzW3x+1j8U/TUMmnzNsQ0wz2QdMAJLcNoxEn+agVSpM4DUYNGeVsNTIp/NY?=
 =?us-ascii?Q?o3JFObTgikxpMlKgEbE0qQcvIglDx25JuEe6BhQ5SFP3s6iQtbP7vaJkMEUx?=
 =?us-ascii?Q?5++M+5C6SirI4xxByDiof14Nt2T8B5h3VmKb9d/+9nCJLcf4zQfni9KbT1qB?=
 =?us-ascii?Q?A74A4XFYgyMIi32DC8yH0UoZnpFsv5CjhRtHaDvdnCCClI9X1+LEHxz4q/AD?=
 =?us-ascii?Q?Qo9b66vGhs/S5oXqQMb319gXjWfxssov9thIfPvct11EWNJQAjvql35h3Lul?=
 =?us-ascii?Q?qomS6iH4qtdmv7necd26apigB+/RFyjv1Pp5hY3qWz9OI1PPwXWmBwMFwrFr?=
 =?us-ascii?Q?FFJW5Ln+GFx2vzJfACowVp5EFKktmvxg6hB2KxLzQqP/XoALVk7RiKh2i9JF?=
 =?us-ascii?Q?df+HV/4m0n7eZrV89y1Tr/dO4SAK4NlvNhGmGhPRmmp4o9WSbkpsTHQjKGrN?=
 =?us-ascii?Q?7yJKiGXUTQ8v2ecAJuV2ZEsCXwNRhNBRtsPgVonk3UieF2AUHf0irfqdwDfE?=
 =?us-ascii?Q?l9qPkJDkFALh672XxyUgBBa0cE2MqmcfA9pTUeOWvbVeGcxzGA/1s4OH+nSi?=
 =?us-ascii?Q?PczMJQT7s6pMvAXxJVqLArNV39cF+ae7wEQOR3G+Db6uYoRzUNt5OfQpB4iQ?=
 =?us-ascii?Q?z0YbWZHMUioFS/YfdaylrUozLo33NemSnA21fPFxbygp0BXE6aDs/Y0vQMRj?=
 =?us-ascii?Q?mOMTcfZH3b0g38nWea40wLu4AQPsHtLZxnq96mUP6lmzHThhbnmFTD6W3U9o?=
 =?us-ascii?Q?cKJ92FcCzeIabJVMovLG9cdA6gVsUNv2gVe1E6v53kWTqU4aH85WokChS5Pu?=
 =?us-ascii?Q?9A9nrkyrZ96C0UwQxJrRXpGN+GUJDAKRUOCGk6TYeeAQAJclyTVD8ju8GVmj?=
 =?us-ascii?Q?2hbAJ07V4R2wnfrAaNnKsf0Sl4z1LN7yccX4J0pjL/2YxZd/SUvNFlke9MRM?=
 =?us-ascii?Q?40m+DM4CW7uMM4lS4/x+kUDptFOB/f9fYDGI8T3SHaxa4UvKzcgY65yaG9Vr?=
 =?us-ascii?Q?lexQbsdtyowsaz6wb7kGy/tJAqbSMT3W0//JTaXG4nD0M2evFMNXd4gm3bfb?=
 =?us-ascii?Q?HeWa6GFEy/qal3tqmW8n33Wv9e9Tg/7KDM6vuCtSELPuKuSiBCXdathyl03F?=
 =?us-ascii?Q?tzArgsOvxbSIwko8AMewXGsjQcomutBCobGi1PMptQhQ0nkvxt0CRHTeVdyE?=
 =?us-ascii?Q?PEXXtd4d7iEIPQqlCNpAamRiDG7/Z+egbEaJW7MSEnUQBVIMjACE5ssG/53g?=
 =?us-ascii?Q?82axvwsJzOnZlw+b1uDqR3b+CDUPK4iYrYbRyuhR/S6YK707Dyp9H1W6w9dD?=
 =?us-ascii?Q?nhEm9LqILF/oJjWqjUz4CMWH0xpOlLI7XyAQ90FUu2a08QipbBu90IDB4Qph?=
 =?us-ascii?Q?GbuLi0u4fB54rilKl6bBTezb+bQwrbyGKS0UTVjtJdtmBQLKcby8+0oaViW1?=
 =?us-ascii?Q?pCNf9Phwj3HyPZ6JOTyS163vKzVcmxRYI1BKr4k9S/2w60mIp/KvkohN1sDz?=
 =?us-ascii?Q?UCDcwxtSt//WA4++Eyj34ubyolejr9Ms2KOYkNKf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2048344-b6e9-4358-481e-08dca66dc6ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 14:35:59.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71gInDpn/JDOTMjWKVG+2sYlya4rIP1L7exO4jbFs/60LAOJQ85oBmSUaXFAZXlsIJiqQIouNfDzPMq9Ni1CSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7015

On Wed, Jul 17, 2024 at 03:50:25PM +0200, Alexander Stein wrote:
> These properties are required by i2c-controller.yaml bindings.
> Add them on SoC level, rather than on board level.
> 

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> index f7a91d43a0ffe..3f521441faf7e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -303,6 +303,8 @@ adma_pwm_lpcg: clock-controller@5a590000 {
>  
>  	i2c0: i2c@5a800000 {
>  		reg = <0x5a800000 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&i2c0_lpcg IMX_LPCG_CLK_0>,
>  			 <&i2c0_lpcg IMX_LPCG_CLK_4>;
> @@ -315,6 +317,8 @@ i2c0: i2c@5a800000 {
>  
>  	i2c1: i2c@5a810000 {
>  		reg = <0x5a810000 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&i2c1_lpcg IMX_LPCG_CLK_0>,
>  			 <&i2c1_lpcg IMX_LPCG_CLK_4>;
> @@ -327,6 +331,8 @@ i2c1: i2c@5a810000 {
>  
>  	i2c2: i2c@5a820000 {
>  		reg = <0x5a820000 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&i2c2_lpcg IMX_LPCG_CLK_0>,
>  			 <&i2c2_lpcg IMX_LPCG_CLK_4>;
> @@ -339,6 +345,8 @@ i2c2: i2c@5a820000 {
>  
>  	i2c3: i2c@5a830000 {
>  		reg = <0x5a830000 0x4000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
>  		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&i2c3_lpcg IMX_LPCG_CLK_0>,
>  			 <&i2c3_lpcg IMX_LPCG_CLK_4>;
> -- 
> 2.34.1
> 

