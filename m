Return-Path: <linux-kernel+bounces-303606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F6B9610A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E12B21626
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BE01C68BE;
	Tue, 27 Aug 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BV6+3oqt"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E191C57A9;
	Tue, 27 Aug 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771482; cv=fail; b=cPL8wgm/t5A/zPC8AkM6lJmOyFbIaIeuXLiaTTB0J77t/7WFt1UVZc3sxbBS33Hy2TEJNat2XLdbFazA0gSdArLnIHklq44iM5B9v1CoRUUR9pwq1bzs5vSG2Yo+6m2k6opbtnPxshtMDg0CbpbXO2ijnHYF2GeltHeksDmW0M0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771482; c=relaxed/simple;
	bh=DWDTXBgS6ImwavmIdeSj6Ka7PBhv6sRCIzvi0HWaqFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iz3EmDucaEHEsv5R8adH8PPpmhheV3bqIZZ8aEGtTX61ZGN/1Ag1oAOEHdGTXq8ehF7u4ocN41u05byme3T46TLb6EcBVIHBeuJGEUuX96g+bvnvAp5rui3ImchSs9s8dNFrCDbqGJp9pSf7sC3vJCyhk2LbGUn65JbzcYsDUsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BV6+3oqt; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQT43MtsKIPWVHnMxh4mhYtp+5SrFp4yWwWZKGAFmvWYwMTdN5gvnLgrS+IF1ETzimW5Q/IOgwsuQdS6zAd4cNrzUDBmFsSuESVKLn7/FWJz1eGD8u467u1ClhCDx2cT/lXSKB67qoMR723ZFvw8Jjqe391p467arLbo827acnBObWQvALo7ilsBOzvvuTAXTT82rQ1nw3aB1Cdjkdno2ly1eI26gF+GRF18oydjcQSv77fqSCEw/+So1VYcJdY8B59Da290WOg4kI6bzVObfHw/F1egoNBNdKumqASZySOJMgXU54X+RmrEsqlrSM/G83uWdOfOTVim5h/huU+c9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdDN0RRdKHURXzJWZ9kiSBnOOZG+Ez+PLJY0tCijJTY=;
 b=qs6M8rNa6NIbLijrTmXouf73SnggaG85WidwynkFgJor/pX4bjoxXtau80AhzzCj6yExJlEkNhP7/BaHLRxQc4LGIL5g7YtayZpsH/G27pvSZWZU2CEpUHpyA2Ua5nuDmhD/63IDgaiu0ZGf8bwBgN+MeB9ly28LTJVRwB+lFCuQ49FdnAZTwJjz/WplHk74xbloE4GUJf285EYw1h06Nhy71Jri0mz0HkSRZG6U1pKrd77ZtchExD030o98Tm9JxrKPAOfMAhu2iyBPySp8rAAiYdKK5ATXpVK8DsjXRHo8UJ24vTEfyHqZXhvpkAk6nCDSq76D1+eY/cT/B2E45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdDN0RRdKHURXzJWZ9kiSBnOOZG+Ez+PLJY0tCijJTY=;
 b=BV6+3oqtbkQrXKatb6QGo0H/6N3huT3BYg9aEObc8+kpOIKjkvYosxX+EzV9nfsf7TUmz1aq8Ag81e1kLmUX1mToieknn9PzxdfA0l1F1qO4014z3xnPhstBr8M+08zTGEAhAN6eSMeL9E84Tlg35VKhpvoi31RaN1ShLPcW29egPCuKI24FNFRzir4aO+X7LqTmS60SdPKWz7j3H7NljoQk4yrNPqFTWyb0jiyamy9MJ75mOQv1rbrgFlAVlsV0WPnQPv1jEDS4nZe8b9Kvdv+PtNXLMSAuTtlkEC6nfaVLgb4vsRBZFLkLqBPVocOfGwkjMgXfhS4ZL6tKiSxgNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10820.eurprd04.prod.outlook.com (2603:10a6:102:487::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 15:11:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 15:11:17 +0000
Date: Tue, 27 Aug 2024 11:11:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: David Leonard <David.Leonard@digi.com>
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: ls1046a: add pinctrl node
Message-ID: <Zs3sjN3HzO2PCdRw@lizhi-Precision-Tower-5810>
References: <1d7da01e-4f61-df0d-1795-5fbd78ae14b7@digi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d7da01e-4f61-df0d-1795-5fbd78ae14b7@digi.com>
X-ClientProxiedBy: BY3PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:217::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10820:EE_
X-MS-Office365-Filtering-Correlation-Id: 3276983a-7b61-472f-1fb2-08dcc6aa7fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YEGcu32XfEBhRmuGM3cpKncMXcXsK8DNkpwqgFsfj6OrTB91wTl7PQNAD6iq?=
 =?us-ascii?Q?OzmhtYIt0JmuLbnvVxZsTOWnXQk3vG9GDYR49LGsBh5Me9i6aXZQ4QnjbW7U?=
 =?us-ascii?Q?JH9B891yBZzD8OkVSkoYvHyoD5F3ZjPk+HDObJd/w0EllH/lSn4G762V+3um?=
 =?us-ascii?Q?H12R9Go3rJNuwkNPVUO68oRn3EwKhikXhVRKF8t2Oh27IPifGQBkU6Uq2AiW?=
 =?us-ascii?Q?00yW86A36DFEDNN69DzY/tvS88pLfCoLPueCwKIt56OsTU4C9D65gY5GEKQp?=
 =?us-ascii?Q?uonoSF+mwi8VOrO53wHJH2izZgRfgVqCPfyAzBhDFbaCL7gVwprzbTp7xf5o?=
 =?us-ascii?Q?wvVImtkb8QYsHsDTT/yhyKhtKWylM9vNAqwpySRscYUFqF9Qg++BeUZBYMwZ?=
 =?us-ascii?Q?hYLv3Xr0AImc3kbi57VtIjoLpAqYTrgnfBdmalSGnnC+v9+j78YUFxjeyBVB?=
 =?us-ascii?Q?d3w+pkSkhUO86kuGsSonbeGc5IibyUkX+wm+IpSbouL49HW+u/LyKsKCV347?=
 =?us-ascii?Q?IpJ+MpHrKiznQRnsiEIfEGr4x4uDtooF168rlEtj00UZsAhEmvXn31oy02/+?=
 =?us-ascii?Q?sPDve1/AQtZtsmokbXmK/jc/5qXTs0mEHN05YvP4YIxCsn+8xISUlGOVeRta?=
 =?us-ascii?Q?7Gh/peEmeXQHgCwzAKBARpy2Dx9HVjBbElrjmXMkitHkRBWM6fTrMWr6mXlV?=
 =?us-ascii?Q?DpvcYxEChJC9eYSt8ej7ZX1fTpndN2zVoIcuL+OrluWIKuAarSqSgdnFsmzg?=
 =?us-ascii?Q?fr0AY182/ribC3PmhcENCb83lETK4yIWj0rClgp+ufGuSC6sJGGeJziP44Xt?=
 =?us-ascii?Q?TmwehiqQ33ge+mls9d1nx6h68EfMc728uqYmENBV6PdzRJKFPpksOEhugzwv?=
 =?us-ascii?Q?yJM4FBvlYg8HFnKu7TW9K6lSIn2/7QGqS+3DM5igG8F2xLoApIOYICv8jjvb?=
 =?us-ascii?Q?COEVa7/0cAsyfnMu0CgLJH8SmhpmkecAyOuAG2352P03+VQnBnLtg0thPtYX?=
 =?us-ascii?Q?iLzlFyA5db/l5xU6SqXZ4xu3RcjVFyPb1gsmvz2OLULzt4sRvTV/y94YSSAk?=
 =?us-ascii?Q?01wGdr/dP47xN10Ka78o1pS2lkTgXHE0nZsqbgmPw71ucZCqnN4tYCsh/oaC?=
 =?us-ascii?Q?+51IB4mWTQ7eh6pAfh7VC+w14aR5l+hMjrVcGI55GSKXSFHhW38EoJGiiVZ9?=
 =?us-ascii?Q?5byXEkQLuoMCcMyJHntGqD7MifsllxYf8ddkfAZLOcTzhXZ86/2QTtHtKCVz?=
 =?us-ascii?Q?yfoUeflD/XEKdTb8B4q9GplvrrVMQmx3hDly7C0ekmpx8hjCBjAE+YIX07nC?=
 =?us-ascii?Q?Ne0tzshuFsfkD0yQQSmB7mJwN2Lg0Ermc/8ysWjXEL/bm5XklLpflIOFehv3?=
 =?us-ascii?Q?GIwUqnBELRLI7CuPFftvYhXIxnBg45MrvIqRfUWp/bhvd+PjJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cIPpyQj3q0+sAhGnmKyYhOf13XI5Uui3X/MZ9knEopWqpkTAVv5ig4EMIhjZ?=
 =?us-ascii?Q?kRQ0dtTFHshbns/gFUpt34sSAMN0KvDNxzzlsz2zVplAnLLwtbYouGK1p+xj?=
 =?us-ascii?Q?wlX5LQJZsMtLCX/99z6RrnxHEaK2Yc01/1GngOWyT94B0KpyojNCpoksoM43?=
 =?us-ascii?Q?9banG/FFSONp/yxXS7MlQZg/pzTQ+mj2igzuTGyNOtd7v/dYUvpR6kODhOtr?=
 =?us-ascii?Q?/t0wdcJRZuOhifTbK+arOKWM+Jk0f2abJvMU0k5O4dxGchB6NRwZsgrAAuNE?=
 =?us-ascii?Q?nNG0Ew2oT775lnF32ADUz2ByNztDIe8vE/+dnU51lq+E5ZGsQgTTQDuWG8gb?=
 =?us-ascii?Q?uEeDOGBQzPykHDjXCitZ7gGQwVufAnQjbNwjs3jih2SkzcQVfLCJC+c1MdHb?=
 =?us-ascii?Q?w4mz5ENPr3GSxWCfYSaZWDMtefoBDQe8ay4HGRaLxtn9arFUiD1ZaMYoIUh3?=
 =?us-ascii?Q?LCEyOowI22+gAJv4DNI/eDIlkvN+vsLBrySBE61wgQ2nSFxjLlqpEUlhfSlp?=
 =?us-ascii?Q?/Xa7frgigU718HtIzZUFNGxtrHII/5wodhp7jf02ZzgYihQ8FGDm54raqeyy?=
 =?us-ascii?Q?90FnvVjOtn73GXaQLPlrgLiKIMKGYJgrvHZIvJr5KEELUEeoKVSl6LXzMYHC?=
 =?us-ascii?Q?y4o5uUi51yBXpmlpOMsACcKdsQvwGFKv4ZkpPMniCC+v0sNH9B3AN3wDnlC5?=
 =?us-ascii?Q?86GpcWQYuMNWpdmb2vEkmHbryVUYvaccs1PIk7xHQhi2MAPlwC567tjLLru5?=
 =?us-ascii?Q?Jx5mhgtnpd70GVnsTaYH9i1cMP+4riHgimuBouhuhs5fKtJIobWM3NXrtVvp?=
 =?us-ascii?Q?M55ykk/bmmdEdSF956N8mFaOqQDxjFvrKmF9rzGp5XPbnWiLe4Yw28mVeeIc?=
 =?us-ascii?Q?v2haXjJZGSI2uvTi8F19QSURoNoLrrCWW3Alrn2oO095fXSWUtOBQxNbm45I?=
 =?us-ascii?Q?CGNoghTnHcE6phKODcNPSkZELYCRstQB7ORE1szhXwKRTYam6uo4rKop2rBq?=
 =?us-ascii?Q?VKTxPKyeTju6dSBgPyqodMmm0t6H/pjJLXrO/8XwsJrWIolo7zfPAv2P5amW?=
 =?us-ascii?Q?zYYc66jw/WjqBbBKn1/1TFfQzqAjtWW9/q17kmz96nZxWc5CnxZz2K1SnjYu?=
 =?us-ascii?Q?1iIDKQrvHv2GzKd7ThvFRiV5Ohb1AhqDY3IJCrivh5R2EqIjEj6IWMoK0j7x?=
 =?us-ascii?Q?FrDWSdQXe7/XCvs+zX1HfC2o/5cgupPow1aRYLxIf3fpX+1IzY4CUUN6wFaL?=
 =?us-ascii?Q?Zur5Rwkmldp+x1nq2ZorFMtqTWxCNtnV63bKNKrMKcwkh3z3drUtTYIPV+T6?=
 =?us-ascii?Q?sV8kHPx1vvjusJaYeMwQ4ZF9Wj1V0vnCEnWMsgOt/mazCXbreKMkynOXbZF/?=
 =?us-ascii?Q?nApJ1vorRdHsd74vx4MHdFmdWp4JaLF3qleFRGLlGemA8ek1q/NL3vCAmWyV?=
 =?us-ascii?Q?lR9XmvR86BeCIIcRSlNnaFASnvjjEWOQzN9YAqnCTU/lFKrMcJ8vZPQlBgNd?=
 =?us-ascii?Q?yQ1pfN8Xa7evmzykJeso4YFN4+5CljZ0hldtwAaHcGuH820SHKxp3NETi87R?=
 =?us-ascii?Q?xItWtLx3P1UwSAK/Gks2TJcSGld3TTRxQ06/kTHH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3276983a-7b61-472f-1fb2-08dcc6aa7fb6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 15:11:17.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 32Ot6PX+5cN5c/aU0b6R3if7gJZecqB0NL5vszWz2YK6PCoSjVYtU87w1AGjrpqpVNXWWSUe4dj9SFKFe4ro2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10820

On Tue, Aug 27, 2024 at 12:13:30PM +1000, David Leonard wrote:
>
> Add a node for the LS1046A's pinmux controller and related pinctrl
> properties for the nodes using the gpio and i2c functions it controls.
>
> Signed-off-by: David Leonard <David.Leonard@digi.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 200e52622f99..d2286fd6f972 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -350,6 +350,29 @@ extirq: interrupt-controller@1ac {
>  			};
>  		};
>
> +		pinmux: pinmux@157040c {
> +			compatible = "fsl,ls1046a-pinctrl";
> +			reg = <0 0x157040c 0 4>;
> +			big-endian;

I can't find fsl,ls1046a-pinctrl in binding doc.
git grep -r fsl,ls1046a-pinctrl Documentation/

I suggest you use pinctrl-single.

Frank

> +
> +			pinctrl_i2c2: pinctrl-i2c2 {
> +				groups = "L4", "M4";
> +				function = "i2c";
> +			};
> +			pinctrl_i2c2_gpio: pinctrl-i2c2-gpio {
> +				groups = "L4", "M4";
> +				function = "gpio";
> +			};
> +			pinctrl_i2c3: pinctrl-i2c3 {
> +				groups = "M3", "N3";
> +				function = "i2c";
> +			};
> +			pinctrl_i2c3_gpio: pinctrl-i2c3-gpio {
> +				groups = "M3", "N3";
> +				function = "gpio";
> +			};
> +		};
> +
>  		crypto: crypto@1700000 {
>  			compatible = "fsl,sec-v5.4", "fsl,sec-v5.0",
>  				     "fsl,sec-v4.0";
> @@ -537,6 +560,10 @@ i2c2: i2c@21a0000 {
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(2)>;
>  			scl-gpios = <&gpio3 10 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +			sda-gpios = <&gpio3 11 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +			pinctrl-names = "default", "gpio";
> +			pinctrl-0 = <&pinctrl_i2c2>;
> +			pinctrl-1 = <&pinctrl_i2c2_gpio>;
>  			status = "disabled";
>  		};
>
> @@ -549,6 +576,10 @@ i2c3: i2c@21b0000 {
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(2)>;
>  			scl-gpios = <&gpio3 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +			sda-gpios = <&gpio3 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +			pinctrl-names = "default", "gpio";
> +			pinctrl-0 = <&pinctrl_i2c3>;
> +			pinctrl-1 = <&pinctrl_i2c3_gpio>;
>  			status = "disabled";
>  		};
>
> @@ -626,6 +657,11 @@ gpio3: gpio@2330000 {
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> +			gpio-ranges = <&pinmux 10 0 0>,
> +				      <&pinmux 11 0 0>,
> +				      <&pinmux 12 0 0>,
> +				      <&pinmux 13 0 0>;
> +			gpio-ranges-group-names = "L4", "M4", "M3", "N3";
>  		};
>
>  		lpuart0: serial@2950000 {
> --
> 2.43.0
>

