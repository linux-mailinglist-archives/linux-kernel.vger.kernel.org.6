Return-Path: <linux-kernel+bounces-274978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A694947F07
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C231C22056
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9D515B554;
	Mon,  5 Aug 2024 16:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ycy/f/cU"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1A154C0E;
	Mon,  5 Aug 2024 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874462; cv=fail; b=GOt85l/siO1LtTOSCRESlReJZ2I+OojCnoCvzmGIyuFPtFO1HfED03alArdjqwV2NN4+42UexnUhTZOzlfZhiAsGaQoTgykKh4oqqJWDfzhwoLBl3p/TvWWpe6hcFLfBD5kK+7fpc7b2OKWpNIZzpaFjibMmLqsPOfzErD34iqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874462; c=relaxed/simple;
	bh=YHGVOWWF6i2CiV/R5B6HVrReXqFjmmubGzB7kxA5n8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s8x0CFsGpmNtsaQ9FG4oymMmfm09mI4IsuKbir1XCR/mCqSARdaHTgfCRehojZNtVj/t4dYuNVwcebHHdrn+JEhflA+B95kyIUvJB0JLzOumBtYl7Vw2oEtsT5BHlJlBhaFg1qPSJKy10JjNfvTtGVpxTGVUO2Y60C4Xs2nIGfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ycy/f/cU; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hlm7s1Dddod/SpaQ68WcF6HdB/Ta+a6N1vT/FLfK+tIK+Bz/F1SadXmI85ELt/zifi0Ph4o4xiQTgys5cfGePkQtgtsyg2EDueX4dA1qTaC4wMDaR1CAXyrTFqIYnrCpMSqLklQgdvnVQ3J52gx/E2vfou21MRTnCTc/W/Vq5Upsbr62DIYYfvnS2tp1HC8gz0izWhF+sacgLDvEgsG9dZZns5unfcrDxHAnA6Lt8NygWfrs1IlQfTET2jkWD4905rUYStcxv8Unep81kFaXPYVxFq5N3WIKbmvdlnV4TMiA6REmvefAona7pUn0Qlr+9vQOZjnXyJ39ICJUP46Uiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rm1dbwt+46nk3YnZWct4qZ3tFaRTj/1MzGiS7UhrF7c=;
 b=PZTtlQHWQhW+0xxPXBWj5cxzopWvUt+VwPwP30zvUsdfh3mbWbDbn+mIsIq065NbIlTCiv4zxe5TGmXHewStsanb5v1VadJhMGO8mWnY9TlTIunijiJR/h0eDPXmsP+kPszhjwZVAmkkzz7R6eJMp7PoMMyEIxtLmnfrY8NEs9bNMRCLsJFPG817FRuQa7xXAhUdn1Ibg68z0LIewITjY8IDQRtmMn+MUhqMQcxC0pUAURQq3cydYCuWhKC1khWhyDo8k6CJOct7eIBRu4sj3hDgXXLFHOKB5hqsyYEszHTESfXu0KImu7RrwEChNQnJmHSvf1rwqXersNQVveIWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm1dbwt+46nk3YnZWct4qZ3tFaRTj/1MzGiS7UhrF7c=;
 b=Ycy/f/cURZoWEdrfYmPm7LHOgCIkDvm/aKp8OzKlc1VmLvF/iXuvwS62XVYjZd/5sJEFcPYRT1SfGByawwTMd+VKo7NkqVcJZGKqCmzhjCwe6M/v/otuNbw44gv1YS8QM48szyGtSAir6CCahVM5mkBVlp5arc9DFTgXh9pSsFnLMeAimWDKVyWpTA3bhlbash+2iq8O/u/iDX7s5XVtlNmEPIUw5tIKKiDAi1MSxDe27RpKbBO+49rP4hA0XBgwehzBZ7t7IyNr/MG2o2Zcf018CH8sw7fs0eW85EYJlmmkHMwy4PCIweUE3B7F9s+FzkNswjmkfuD4qtb9kET6zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8613.eurprd04.prod.outlook.com (2603:10a6:10:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 16:14:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 16:14:18 +0000
Date: Mon, 5 Aug 2024 12:14:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/9] arm64: dts: imx: add fallback compatible string
 fsl,imx8mm
Message-ID: <ZrD6Ue2sP+Fa3WZ2@lizhi-Precision-Tower-5810>
References: <20240805-fsl_dts_warning-v1-0-055653dd5c96@nxp.com>
 <20240805-fsl_dts_warning-v1-4-055653dd5c96@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805-fsl_dts_warning-v1-4-055653dd5c96@nxp.com>
X-ClientProxiedBy: BY3PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:a03:255::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e07a26b-a190-4419-ff32-08dcb569a831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BEPASl1cRa3VXPPIPfVok/djsWuapXGX2W96Ydjd6sqgSfm0l/Ss8n9wFzv4?=
 =?us-ascii?Q?NW6/L/DNbfkllJhX0RuYDKh8Ji5BB/MUycFCSIHaxicAjG9k/7cfT0vf7LD+?=
 =?us-ascii?Q?wkGpaJkFPGoJjcBM51qSG6b9L3e9K4jK4wqc3MfO/tB8tNCXHRAx4UmaZS9q?=
 =?us-ascii?Q?QiTYFKZKpnAhE3MtKnRwWujDLPflxBryo5jHFMyJLfyC1rhUlrIjiakOJ4A7?=
 =?us-ascii?Q?w82iw8kUwseARonajAFE3sV5tDXY7SiV7Rt6Ql19gDyuGUjTs3QFBW6cNbys?=
 =?us-ascii?Q?GCVsM8TRmG8XDmcETR+sVUfdMH6OFJL0eJYlncIkSif+mYas7asToNOLJPC6?=
 =?us-ascii?Q?NCRwIvwVFtjwv7eSk7pHTG+2xBmQSvXvCw3j14Y8bPik/XxzSFKnPUStQHeJ?=
 =?us-ascii?Q?mu0fRFR9cOkZkOdYdFLqlTuIrx8bMeydZdB6xXhDMWShlZwTMf8ffNDdzrF6?=
 =?us-ascii?Q?+9SlTG+QkdHSwDRhMiVWPAKg2Pg90PSYloDSZZUUuyqY40spWrbiHp58g0QN?=
 =?us-ascii?Q?8aD76gZmRKA1BvOzjQD1NsTH/nB5GiefMKuX6vXEbixjYEoF4woV9o8xUOQT?=
 =?us-ascii?Q?E4Q1sHagx0wiNgU3zD8bsg4EGSlgvXBlEPccynWG9f5rTP8q+LIw03G6bW9S?=
 =?us-ascii?Q?g0Zn6y/TgOJ48cnR/XU/jTcjsGXYEpvNOpGUvIqbI1ogmqpswFWtBzbJ613j?=
 =?us-ascii?Q?izovRXT9u9+5PZjlRRaxlVUpl83Ocani4xpg2xFYbl/Gi1Tz6QzAhynb8qjU?=
 =?us-ascii?Q?5XKXs9PzgO+HgOBMy9LN8+qkzK2+XdjqCRFSXZBClkAQDh8CmzMGuYyC5mK2?=
 =?us-ascii?Q?/R4msXrAIUMgN4NXNeJVyiBGS1iWd6Klu3whhdAXOCyviV/RNcz8s4GiUVmr?=
 =?us-ascii?Q?gk9u6stvg3z6y2mHlY2r7R6Y82aK5TO2D5H9u9cghRbEU78KHpBULlDrIymu?=
 =?us-ascii?Q?lhoO4hJvebfMOKNdRlCjgh0Q3B5KxB5roXveqrIyDU94vYnRt19PCl8/uHd1?=
 =?us-ascii?Q?K1UlHyeVY1ShsBo2DhsFpDgUw3gzrOpqBp8EriwGzzCBi27+rWMcCRZsGhoT?=
 =?us-ascii?Q?MlXYOVocgTchxk+xGmi06svG8N9AY0EC85JM5GGit7Qwe1nB5InqR6wCN0eb?=
 =?us-ascii?Q?BkWEjwvI8RCq9PFOhHbdWaCG+oQDfIBRfH6Vx2/fbY6+XteNtBdr723KEt1U?=
 =?us-ascii?Q?zFzL41VgrzRG+c+5nVYMX7YHV7DwCuWPXVWVKNr+Ehob0DWTHyXG6wFFZLqW?=
 =?us-ascii?Q?VwSGDEAfZs5ombc8UT3tYeCIwK0f9b7fVoi74mFrXMSIZEeZ509X/XH5CnHV?=
 =?us-ascii?Q?YjF0CpP/EcallSPu0LIWqT85zt/B2h3YRCYStearLUj6i66ZukAXqViUycyT?=
 =?us-ascii?Q?WuHPDfOVWkPKp2OoOpEGu8X0hs1fkkUggJbjUzS8OwmURMFfcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dFlyt5r8HTrBGh//iV2fJvwSZzfXNPKGwY8BzVutH+d5RT165XUHzYjcts/X?=
 =?us-ascii?Q?jju4k4W+B/ZEzc674Im+G108WFAzEYLf6rBFgeejvRcT4/52yO1M8bCeLyJx?=
 =?us-ascii?Q?G3qqG6vJcktvQgpScVRXq6Hfdy7Lq3DOq1aysL0NPN88b9OmBeSyFMwpD45x?=
 =?us-ascii?Q?jPDSAJEIBvpa0XPKjQJ4qwImpl9m+Gq7ghgFaI5OtLEJpyJWfAHUD02r1l/D?=
 =?us-ascii?Q?bPGxtQz1PJ7wfTD67hR5uVoyv5JnDH86QazzIn3J3S1xyw1WqxNq71Dt1ywE?=
 =?us-ascii?Q?8rICY2NNYYuh9vgfYTkjQB3jkwe5N2jgiZyMPLF5b4caP3Z/Uz3RGt3EysE2?=
 =?us-ascii?Q?t7WHsE04H4tnUN7hKp97AudD3EKK3edojnPmJcX9XPiPJ3tagI0PteHJKQ3u?=
 =?us-ascii?Q?5oCB2axAiOHaOk6Myc7RHFHxydE3epNcHv1vn04gGCvtCqYlmU08BauinMx/?=
 =?us-ascii?Q?8GPOIAXcvNuF+4kdHw5xNMRsSLL/ar+aSRUJ2Khp0j51Q0k4KS5EO6NUYjaX?=
 =?us-ascii?Q?kd+VubK97Ql+vkCi55mCWuPsf87UhyxdBmx3wuc/X+y8RV985FExGpU6oYDf?=
 =?us-ascii?Q?tjv63mc27L0n1G3o9xrS2MnkR38y1bopMl4gBgeL+HQ1f7EZkt3JCk0xM19P?=
 =?us-ascii?Q?1UlwDm0dCgsNRsGtTG90T0DPlAERu8iInIrCdqSrCZsfPStkdOGN0ZCB3Ja7?=
 =?us-ascii?Q?FaeCIO8KKN8VdVdbuxHrO0fk1Z2i7P0XyWSsq+gNuoxLkYp+6fyR5F1MHYXs?=
 =?us-ascii?Q?YcuiUCGdHx6852PFO3R34M0JxkjrntLw5xgGrSWAFOtKGNcvKsXSqoNnCT+A?=
 =?us-ascii?Q?SlyoOLyAZjoEUZQarqmCKAhgqIXRarBuwGSx7o4sIlhL12TMBHVN1RH29W8y?=
 =?us-ascii?Q?DSyrbTzNElUpOEeCC8rQ6/JpyO76nI8mQDPsllp+uiP0nFi+RwRvnSei/UfD?=
 =?us-ascii?Q?QqopjCN4s8pjyLMAtKcwEepc7SM1Kt0kO12rVVoCUo+3zb+HTjH8aJrvXxPh?=
 =?us-ascii?Q?1IoC3DgI0cRAsfCyX8V8xIBWsczeeIPc4+oKKvvLgru+S7TCZfzl/gwNKD8q?=
 =?us-ascii?Q?aTkTbgh1uywdfWhmIbpYMjzuSZD9SHSrycfAI1Mr4ssA3aixt8s031xpLU+Z?=
 =?us-ascii?Q?hRynmdnaLOwX/KIXesuHTkp/5tXqYszeoAOnZWukZLnjM4PXtLgXWm2VbB/B?=
 =?us-ascii?Q?kLapec48bIsfrPOOPsbIhUMA7w8l7Cg0D8TlcAy6pbk7jVv4h27qt6WTdXRJ?=
 =?us-ascii?Q?VlaaiUHlpfjALOylVjZSr1j+p5UTV/vUUNfu4eYntNG5XJR3GeVZSS9SXv9u?=
 =?us-ascii?Q?X+NP17MDsKWhUbsu6StOMXZcerkNYi7KeOKXc4q9zHtI2VWq3iidAvwke5s8?=
 =?us-ascii?Q?UOL0cMYxsIjRhNURGHaKgZIMYPrmB1pYpzjvVr3iK2KDYhuliSyAjy3cDLAo?=
 =?us-ascii?Q?51E13nrQIeggvBEtwLgRzhLLNTeqZ1Knb/TZ8veGb1kHfy2vhVNWuYEj5MCV?=
 =?us-ascii?Q?TyQLbAdzAY/wjWBhIDDYLYiLxAd+3DonFckTr8DfZfpL0klA7OgxhiK28ofa?=
 =?us-ascii?Q?MCxSZUbXF5QMdg+02Zlh86PbeDJrR3vT7nOaDiOW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e07a26b-a190-4419-ff32-08dcb569a831
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 16:14:18.0331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2y5ZjbcFoWqY/AzgPG0NIeA3Yapk8AO27Xt8K9GOk83F/k5XCZxFPjxLoQqQ1UMoirK1LdfLxNTX99PXJL6OdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8613

On Mon, Aug 05, 2024 at 11:49:46AM -0400, Frank Li wrote:
> Add fallback compatible string fsl,imx8mm to fix below warning
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['gw,imx8mm-gw72xx-0x'] is too short
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

I just saw Fabio's patch merge into shawn's dt64.

f384d2828f0d5 arm64: dts: imx8mm-venice-gw72xx-0x: Remove compatible from dtso

This is not needed at all. Please skip this one.

Frank Li

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso     | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso     | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso     | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso     | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
> index f6ad1a4b8b665..6930b2786afc2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
> @@ -16,7 +16,7 @@
>  /plugin/;
>
>  &{/} {
> -	compatible = "gw,imx8mm-gw72xx-0x";
> +	compatible = "gw,imx8mm-gw72xx-0x", "fsl,imx8mm";
>  };
>
>  &gpio4 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
> index c3cd9f2b0db34..a2d338ec714c3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
> @@ -19,7 +19,7 @@
>  /plugin/;
>
>  &{/} {
> -	compatible = "gw,imx8mm-gw72xx-0x";
> +	compatible = "gw,imx8mm-gw72xx-0x", "fsl,imx8mm";
>  };
>
>  &gpio4 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
> index cc0a287226ab8..19fff8473970c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
> @@ -19,7 +19,7 @@
>  /plugin/;
>
>  &{/} {
> -	compatible = "gw,imx8mm-gw72xx-0x";
> +	compatible = "gw,imx8mm-gw72xx-0x", "fsl,imx8mm";
>  };
>
>  &gpio4 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
> index 1f8ea20dfafcb..6092d37e0069e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
> @@ -16,7 +16,7 @@
>  /plugin/;
>
>  &{/} {
> -	compatible = "gw,imx8mm-gw73xx-0x";
> +	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
>  };
>
>  &gpio4 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
> index 3e6404340d529..5e7b2d639bff3 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
> @@ -19,7 +19,7 @@
>  /plugin/;
>
>  &{/} {
> -	compatible = "gw,imx8mm-gw73xx-0x";
> +	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
>  };
>
>  &gpio4 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
> index 2c71ab9854cb3..a1f0e4e85fd7d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
> @@ -19,7 +19,7 @@
>  /plugin/;
>
>  &{/} {
> -	compatible = "gw,imx8mm-gw73xx-0x";
> +	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
>  };
>
>  &gpio4 {
>
> --
> 2.34.1
>

