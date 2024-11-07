Return-Path: <linux-kernel+bounces-400254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45BB9C0B07
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36389B22A40
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442572185B5;
	Thu,  7 Nov 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dc3RdW6w"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB09216DEB;
	Thu,  7 Nov 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995808; cv=fail; b=NzkJxr4vaHK2xF42r6TbJVJeP0cgYFYNgUY8tQSsu3UxC4sGJPshFKBYOPl14zyLaJMOrsat3thVEfH5MlGYvS2TBWRIPwjhwcmti3pyyHbp2vjMj1ZC+E+O/qO/46dlKKAjDhW/HEjNGtbiYoXX5HGNG/T+BR8NGdaGSWw/Ihg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995808; c=relaxed/simple;
	bh=H98LhaEXY8FKf5zr/lGGFpHNe8/IIHspbYpU+2NWBLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I6f6n0NWJ0aRe+ta2b6Q7rRITJtU3CPTIo7ed0gg7Q4xJBcfBzM0vINNSQG2+MDo6L2ioiuoLSfhP1L7ceM7Z1mivRsPubEbtKSg/wjayXjuZ6BPGvqZ3rhLHjf45fuATDzPNUUmA41Tq/HXeTWq1g5kxxZeS2H7RdeaFnyvuOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dc3RdW6w; arc=fail smtp.client-ip=52.101.65.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4KaHqTaPQt834ofmxDNnOMNVQ1dKI+AJupfJo+TabCC3inh/jvHK34u20KyU8Owjopo7bvlDIrgYUYLt0gfLzN7LsJ/RpKLNeQ4AQkP4IPrvggMO8d/9nlgmgGlLeomV6KG7/GSaw296eI2E+JvxeUj+fIxV8pf7veJbSEwghx/hvI5k4yFLGyCGMPN3Whpk0Vwf6k1Sra2DVzFwLdFioDFGgpczfvf97O82G2BdjGkOysNG91+5xIXcf5wxCXedAZpn4wslFY03sF4YW96oB7d+2KbJW7Tmu67gbUMerte/H+A7AaukoTX0zs7xBtC2zooM9hLVtC07Riv0CxVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekxa2E/MJp/T6VV6vBEWa0FKkWLiS4MepydyaoKjTBw=;
 b=TVNCxqhpzvnxbGcQyiUWeC7AwLM9baXaBBVpmb+KaR+v49JzgMxDA+9FomlDevDluLXw+7Nkaitm+HwPS5MYPcZALuggMkE5mRIKUFSNgGWEZvoOBajz1JgiiwvALNYJooXuIYaAYMfXrJZ3L3JU9xdKbWNte2ADu6vhzmsX7fcHJfq2vV6cLGCnv/3yqR7QvHOnPeiHoSCGsJDSvk88DbYNmmAaJTbVN/mVJ/yn5pJlf5+fdKtlxdkz5JWRBLVa26tJ/1aCoED0hPGVS+sxXyz8XBuPHBgV2M1u5JnkhDAv8fUbzVZScsTplxolXHWBGD1MYcdvka2Jua8zYaPyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekxa2E/MJp/T6VV6vBEWa0FKkWLiS4MepydyaoKjTBw=;
 b=Dc3RdW6wRo8NkmoMnuur7dQOQW8DOFH9UIcZ+uo1a3Quz/0Vg6upMTIG90W95br5Ev4EI2MmADCNNUAFZWz5DzNq1MMEWtPOLNV5dnZwJuP9IgTEIzvjH7BKe3+/V3C9bUKsWg31Dv74nHNDzRwD6EfmQJJeKEAF1+A5ZP72L6mVDnuvtZttG2MMJ6duS0LDXnIgEzg3QCgPx04h6SPkJAPc7YBx5R408rtX/YWkq+gvhkTk4OJyRgbBC7UuuD9kAU7+603t/OQXvQQarM/CSxDjHfNgNOJ8GKPNa7zu9/kZBs5oyxIEVX7SOZU1UY8JQXGSCoCR7AOXG81XGeqkgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6838.eurprd04.prod.outlook.com (2603:10a6:20b:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 16:10:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:10:03 +0000
Date: Thu, 7 Nov 2024 11:09:54 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	shengjiu.wang@gmail.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx93: Add SPDIF IPG clk
Message-ID: <ZyzmUvMHQCZDKp9K@lizhi-Precision-Tower-5810>
References: <20241107102008.3626023-1-shengjiu.wang@nxp.com>
 <20241107102008.3626023-2-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107102008.3626023-2-shengjiu.wang@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 2accc5fb-c4bb-402d-0a86-08dcff46a360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2yzfzacvqdP5wC9Xu6A7mk6sh54ZKcaxzAiDKQtFa4xwYNyJgl5MP2StCHQZ?=
 =?us-ascii?Q?p0ODn7oCAcjAK6PCSSAjNDAhvVMGisiWVRmNDWNFiRE/9Cmz1+g0cR/XEofu?=
 =?us-ascii?Q?Ay7YOOxhd3q4fhafg2ZQx3owZx6IofimWNN8dy44EtNivDTpPfUnjMGREqkS?=
 =?us-ascii?Q?yMQ9BfCv9CjbuU0+KpPAgK/DEUU8JfqRVtP/G36FtLrmF0WoE6KtDb8bSlT3?=
 =?us-ascii?Q?I7gRPR/FskbyIAkyYBfgdlXQ1OKwk3zAYZhOsjS0L/p6z6NU6+t0rYd8bXcI?=
 =?us-ascii?Q?2o5aE4TcpHxNRxHBRibC5+kRInLWN86bC44IFpVSW4j/zbRiZks2oCBuGF58?=
 =?us-ascii?Q?2JuRjVpyfJA54MPKCIXX8wV0YxEkMQ5XLRmpHHEO5a6AHwF87z4V+EkgwuBm?=
 =?us-ascii?Q?nAyd0HvolW6eCs5JM7T3xvKZRwxNLyJREDmIaLG3M2whLUxDN6VF5ZSbCmiz?=
 =?us-ascii?Q?xGuSBVI6R9HyuxzdGDWdq2Y/rfYlLC8VnksqAEqqus8APDBmEqDj4ZWdriOu?=
 =?us-ascii?Q?Q2la1t7cR2EVESIHXE8dfAw1bUd9JC8D+JDENfE0hiQwF0XQ1PGDb4wYhYMp?=
 =?us-ascii?Q?Zz7SBDyq8r+RF/lkaoQGb53M6Q3j5JyWXrg18L5QX+y8T9DoxDytygUArRzx?=
 =?us-ascii?Q?te6FqCmyuKaqI86Tsu4C1ozzxqFoRtbH0X4cywhYzUT7wl8+izhfIvELMH+7?=
 =?us-ascii?Q?/zZFuaRDYW3f5Spfmlic2ZwhOrxwLVJRFAfuJADCFTEU1bYo1gfYfo7uvdBu?=
 =?us-ascii?Q?V8u01agWkHEL5Iy67BBJCeezTY4t4W7WByCVQJTMkO4ZbWZeiEtyWDfGw8iC?=
 =?us-ascii?Q?QPs5jMP+xnLVD0ubZHxMwKQlQPv+glzFeTSC5VI//tpnAjVUHlDIMB04E0mx?=
 =?us-ascii?Q?0gbLtS1AsqbqJq8ZG/hKYDwnnIbZ4l0/xaQC+h0jjxnI+KwH/q/t3h+DMq/P?=
 =?us-ascii?Q?lZEhqx+CbfeL9glYxqJIxY6bQYh7aiPQrx9E+Bgy+EVNyREXs/L7cMn120g2?=
 =?us-ascii?Q?anm5O1Hsj43/148JgRO30w8ZmaXlBPiIIJJKGWKaJlzWcSroTA1mCFiYmFZs?=
 =?us-ascii?Q?NHHJKpxw306AEw9uieNvN0juffTLUbV9Ed8GCzMiTnej2iF/2ufugaSItuVY?=
 =?us-ascii?Q?GAQpOHTckBWtCsraXu+xOl57v8t/o7FR7RSGf5pPN/w/220+xn1WuD/ZKgu6?=
 =?us-ascii?Q?HP8NvVffTxM+2c2kICYTZp29Bcur2/28GFT1RGkvBx+Ffk1+6lOeLUdzWK4b?=
 =?us-ascii?Q?UxpvbYxrEbDXeC2Qq1xgW5qiP/NN/26N1/jxuQFii4cdQ9BVgsNl4ymfEsZb?=
 =?us-ascii?Q?Z6C64fPWY1+8EEUve4ve1wvIeLvD+I3pt2+5IjULvJvxPqGvDfB7YZ27b56C?=
 =?us-ascii?Q?UVxZ4So=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbhrm+YAumYGH/LN9NNoKvjESIwHfg6CMkUBhYKXI/uHOaFxrzDYj+4ffYBI?=
 =?us-ascii?Q?00DYfniAjHiPTCn0uXGI2OJh8RK8caL9BLDNhdmE1uN8Rux2xUlf/YMg3Kv3?=
 =?us-ascii?Q?CTFjrxCOYr4syF4j5VKIeZ1fiL1PDNJGYZqrds2GZHRZf48ZNgYQ4G1eTlS6?=
 =?us-ascii?Q?yObIo74NKgAKrEe+L1Nq5J3q2TvQnJMiAWRyk/a2P9mD1eoG0iPwXo6QLLau?=
 =?us-ascii?Q?1TdxIES2qMjgrxcbkHn4F8dXGRX/pbehRI3X+LxSWzI0tDix2ZFM6BNHM4YD?=
 =?us-ascii?Q?D9c+l1HT9giMq8zUPm5ttfAvnwXYnS/uHJPY+V/B8FE5B/C8+qXs4RchcnS2?=
 =?us-ascii?Q?PxSWEqTVMuIzMwuEk4K4FfSS1RW2sBdKN7rdYPsvmv6nNuhS1LgJVaXET7bA?=
 =?us-ascii?Q?CmUv5LUadA8z1520X5qDRThu89oU6L2t5t3mimvW8KiGuX+aaybzVUBJUFui?=
 =?us-ascii?Q?Q9Hj08t8h9nyUeKenE7WRi/qqKqz8fTLp5etBdXhMH0oq9E7GM06tWElT/dn?=
 =?us-ascii?Q?FT1tPY3QyhAsSjDmTwOmQxMZSQt2kw6awMyRG3FZPF7gtfvFuzqivCfbzWO+?=
 =?us-ascii?Q?WVqjD8EDV+YhFI3Y0vc1QPHR9iVPtOqoLfr5ek6+vnc4YiLDrt5WSgUwYz9x?=
 =?us-ascii?Q?V33cdOrS0irQ13ecqS+EbVMTKrD/ZGxnRDVlXWJvf1KBTkHp8q9I18LZ/Zmz?=
 =?us-ascii?Q?QZtZDEclUYJJwXPIpKU/oC/R3AvOiA6jzQmRG+FQEywNBayrv82y4NG9Lsbv?=
 =?us-ascii?Q?9YZRz895qdlKwCosqcrYK9qBbCUzdJEi70xr1RCHKYryGMTNO/f5+avqlTfv?=
 =?us-ascii?Q?hMN69NPNpXCI8kuRF5xytCb4YIHHaEWoYYcFc3YWO/ZqbFfF7sTFpwyYHBPp?=
 =?us-ascii?Q?kWO1BWyKRIkdr5rLtb6OTgOEovgaVNNHDRiRGK1MQT6eM10gUFZN22XJAynl?=
 =?us-ascii?Q?7qY0pGLeRvz20AVlocPBZCD5GDKgH8yCCbcEi4mLc0LSFPnnfdcGRA1v+W5P?=
 =?us-ascii?Q?oPrazIU0wz8Pumu+aZldPwdFgrnuLyg5lZvEwCBhcC8l1Ix91J8MN1VHPcTQ?=
 =?us-ascii?Q?4RiImHBTMgxz/ONQ/6ZeGyl+80HyziaCfT1+roQXa4VmQzs0abmBDtUgUbz3?=
 =?us-ascii?Q?jyp352VhIt6vsOpgPja6q4KLtkNjsDOtsVZjLjkNPE/NqAHN869VgaJV07AV?=
 =?us-ascii?Q?3H+OzPRvneUYsRRMqtQcbSM2D1d/bjJIdGWp0PCeD4WLCWsKqXImh5IGgwJ0?=
 =?us-ascii?Q?mxPl5ocBCgTer/hE7PdoPxmEmzSJyhiADdZh37YQ6GZf5wHwjEr3MSHXREf8?=
 =?us-ascii?Q?NmnLepx3V1Q3fj5lfMMYbxjZxRuP3AFseGG29IuICJNZ3n0MeszI88mLkM5K?=
 =?us-ascii?Q?beAKgu88z98cxlqmZmM94c3du5MZVztsj+g8R18XcGMh9sqzdKAuTw+yQyBj?=
 =?us-ascii?Q?hwrvHe/aEry76k0Tt2wX1CLh3fcwmU/XmjmgEZgzpeUX1vH4AO5BsmlajRN5?=
 =?us-ascii?Q?pLYokQ8dcBSYS/D3YpIA5o6xzvFJrfFTxcU7WNe+zVKdV/7f6Ok5HAGnDRtb?=
 =?us-ascii?Q?5ps8/bNr0hOiu0SYlpvXwJ2FXzvEZNDil5OMlrh4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2accc5fb-c4bb-402d-0a86-08dcff46a360
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:10:03.5204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbDHxGTQ9Ju/qus7WPvUDUmZKnVxvHSYbtLGe6vjtCNz1n4hQU4LLmv7L2i3+lCi3Y3bpfrUuAX36RfbyZ/2lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6838

On Thu, Nov 07, 2024 at 06:20:06PM +0800, Shengjiu Wang wrote:
> Add SPDIF IPG clk. The SPDIF IPG clock and root clock share
> same clock gate.

nit: wrap at 75 char
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  include/dt-bindings/clock/imx93-clock.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
> index 6c685067288b..c393fad3a346 100644
> --- a/include/dt-bindings/clock/imx93-clock.h
> +++ b/include/dt-bindings/clock/imx93-clock.h
> @@ -209,5 +209,6 @@
>  #define IMX91_CLK_ENET2_REGULAR     204
>  #define IMX91_CLK_ENET2_REGULAR_GATE		205
>  #define IMX91_CLK_ENET1_QOS_TSN_GATE		206
> +#define IMX93_CLK_SPDIF_IPG		207
>
>  #endif
> --
> 2.34.1
>

