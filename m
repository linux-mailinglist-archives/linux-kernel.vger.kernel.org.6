Return-Path: <linux-kernel+bounces-510183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FEAA31977
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74B8167968
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716FC267AFD;
	Tue, 11 Feb 2025 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a81JVSSH"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2059.outbound.protection.outlook.com [40.107.103.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0C8267AF5;
	Tue, 11 Feb 2025 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316243; cv=fail; b=lPsS/ILF+gSletwAnwDBXILGPp/6m5/ESp0iZdR2vXQYuqc7a366XARQkBWOS4PQiCgAkjNpvl0cj3DaYOKr8NsTtZg8WS1J6NjFWgUjQRV5lhDFKaVL1/AtDmEIUSUE4VoQmmP1NisfyWlruc4NOXQ7dSrlXnezPpwD4q2hbQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316243; c=relaxed/simple;
	bh=2ZS3NYgBmdpFgDhCGfMQGasJGGN26VSNrRA23t/SO2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fWuPm0Rq9AW58lAW1F0Ph9SVLT0yFyKpAa2yw+4DbnzfU0raGpSdFFw+qNL0ln2pwbX3HbjEvQIf4hVdehj/e6Epa1VwDzfSgcXuJf0KEsrVUJIxli9XvCH82KhdhMEI2YHUVees144Prgw4q+VglwnW8YqhmBDIPcRaq5AxNmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a81JVSSH; arc=fail smtp.client-ip=40.107.103.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVzQtSgBMqYXI3KBMPHlP9vZSa8UvVfSGaVOj+YkM78p8eXMtMs80Hn8Koyx4+UUFDaicVZk4eKGP5d3SY6nvien6WTcKCM5APrOpt5Y21BnEd0iDuYRHrWAwC2gW9VYs+NZZU/+Y537wQRZcaAPESjVULBYk3N5QBzktVGQ5Xhs2q3n0RWJCxAsSG1VSxxXEMx6PuVrtVIkaMcGcjIb9RJ0uJzFCApu1zMZhIg+2CAukUiDZzhvHHSi0VTcWUTZlM8FtnERFpcqmX+jjMOWYU2z5dymwx+xGrD2r/NAiqMqPKUojC1Grh+k+Y56MjTgPd8THlE4dQHXfQN+VVBoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6bbsh/S9dSTNp0T2vBCSNa9UyjVcXkD4p+5u4l0wtE=;
 b=SXZ0JuIh/Of1B4H1cdDSpAnRcBCnYGQobZQ6RM2YQKdCkCoVb+a8kgHitntv1YfHhyaEWmqnXzAB/KawR0WnzAYWzenfq4m0iqthb2jNBUb0Q6onWE6V1cKsDzl76rWLU6ftZUGvmIRvZjbshaHA45lN1/1c1CqbqutMio93lSZPtZsjf0Ok4dSpO0J1fYOwK7nIhaFw2mXNnXSf+lg94Kda4SW3W1kSchNE7OMVaNNFvHedRylBJC3yl/BEMsPC5fbW3QBuHEFHbW3IzMiBk9cwaTgXDkFhuJA2hwHd03hYuB8RxjbTBF//SFrUAGssAuL2pVsHA5UyKBR59iTgBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6bbsh/S9dSTNp0T2vBCSNa9UyjVcXkD4p+5u4l0wtE=;
 b=a81JVSSHAoxDMM/FQ2LXB7JvNYgl1BGDtzv57aZCS8MjlHCOhOL4n0eZ7oNvXU2+yVrRzkbkdb+mUyOYPZzhZfPJi3eww/ci4W22kL3O3DhOlstjnXeaVuXPAG94BeWLXSxWXCR3bNUd9jKrhFORwfFsvbDNdjOPSl0otAwsS9pFC6PTZsb+tRewXkz0R6+cwIhxx9IumOVgi18llhuzxI0SfQ+HBq8KFjXOQ/OTkvG1sygHZc82O0Nbms4Vsrs+7N3TCbR2WhzrVOm0PdJwqnuPB1301WR4R3Gp5QFtJcB6mbFacr+ZD/SSQpfbU8q+iIUtyMCvjv9PQB7hJ74Hzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Tue, 11 Feb
 2025 23:23:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 23:23:57 +0000
Date: Tue, 11 Feb 2025 18:23:50 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] arm64: dts: imx: add imx95 dts for sof
Message-ID: <Z6vcBvs4xGQ+pGCJ@lizhi-Precision-Tower-5810>
References: <20250211225808.3050-1-laurentiumihalcea111@gmail.com>
 <20250211225808.3050-4-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211225808.3050-4-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: BY3PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:a03:255::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: f1480771-c296-4410-e9bb-08dd4af328bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SPckUijSzuiyRRlDBXzR7qp6tfFXbeRTsFpUEicVHgFjJFNrDQRoN3qSBGWv?=
 =?us-ascii?Q?tQaSVt46yRi6+hLHwOQXFJiqbxUvq7SkbKVKBK585Sk8153AkR4ovW9uDyOM?=
 =?us-ascii?Q?2q1U5PfenZPpfueuMGWhtzNvfKbmvGh+AhdAOGp33Jr8IKbbM+Rl7ZAmlRc7?=
 =?us-ascii?Q?VGctzfYrbITrH9l0PANeXCUMXCtAMRnJB5hzYMctDcXnRkWzh262fj+FWNRv?=
 =?us-ascii?Q?qRpzVkj7K9/hFmTH6FgT8dLrezQkBuxY409lHWnB3+6CoqzB4kFiHn7wt9pl?=
 =?us-ascii?Q?uiLxfM8wAm2dZDt1AJcwDqvY/4Bg/FZ54bGxmynoMfRdrMpO6Gf94Ih2DGYM?=
 =?us-ascii?Q?W3Rl+2swI6Jyy9qoGzaHJn7534Crcie9BDZFqv71a7h/sabMg/7hbxVNC77b?=
 =?us-ascii?Q?gnKiETyXEhdhCK8wvkw+1qSF9J6CHmewRxO5Bk4KjkwPZ3iehACz1rwdTq3N?=
 =?us-ascii?Q?uRJJPeYYDH5OY9MYrRJ7T/K/ZxNCxC8Qi47KFTdUH4eMxjcvfVpQLftEJaTr?=
 =?us-ascii?Q?EKl+uAM+r/xFNKswMv41InNQ4H56Pzh2DfMe9Qj3D650yT28f5d51J8G8EXy?=
 =?us-ascii?Q?QDx1Lasp79LI1v9OXwlJnZY47XmYtQyq/FeCvwXE14gcLT6zgBt+/Z0BdHbW?=
 =?us-ascii?Q?a8yA9D3gzcjOxsSWF6Yrxm8erE9WqcKSyO8+TE7CzXRtl+20x4W4UD7W4NsG?=
 =?us-ascii?Q?LVgNbFmqqCACbsfV7W0Ev+NMSSmZnY4Oq9mFdWkZBnba6GfEEdxxOBCHLA95?=
 =?us-ascii?Q?/C/TJjPft5wDAz252qYM2dNst/rD9rW08s8EFucoIUIr9kHtyoTsSVjsQgxa?=
 =?us-ascii?Q?i7vkdxRU6qauLmxXMM86B5uIMZfiAjaE3s9abA1A4iqBsl2+ovYv26Cn7t2c?=
 =?us-ascii?Q?o+NvPwDK0KqS88/jq6GOzgF4HWW3bjrIDyG6k1m+47RNnYephvT3Ul0gfHgZ?=
 =?us-ascii?Q?GF44ftM9IAB9O0stKgqNPP17qoQoyiPEqiK1kaJPBtT0Gb96QGTiEAH2+E2e?=
 =?us-ascii?Q?UQWSaxDqoVK5mXWbmd6pQXmQxIkAV9nELcMSigMmx3dimgLdev4UDbQjWC/r?=
 =?us-ascii?Q?IM8ybYxPmwK+dFosM2JlnvoZxnQ90Rf3tnSUV8Q9GtpybLnxXwKAvCODMyvY?=
 =?us-ascii?Q?mj290OsLdsaPpDWj0MFDKtBr0RLWfs6EJnSSKhjsFkuGcn3XjLLqMH3CQwcL?=
 =?us-ascii?Q?UpBZUX7EcbCO9Uj0ZKaSDMwaEA1RFcLbQrdVT309/o3Dt07/Ect/IWTE1oBF?=
 =?us-ascii?Q?58d559G85yn4jRs6TmtvhUYNib9z2SBkR8Kc/l+H/FaYzYAFWY0+HIGb5rEL?=
 =?us-ascii?Q?SG5Xz6IUaGcjnk7zWmNqHWiXNYsI35PiAVQWFA4iSuwK4UAt7gPCvxb1z38x?=
 =?us-ascii?Q?zjcqprZb/h8MnH2YGqbMAQLwUToQ/6LwN0/2XU/Wc7IcQuSRcKTO2Tpm7quH?=
 =?us-ascii?Q?7FAOjOnpkvGWycX3u/sU0dmLymGDGOsI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1R5Ul0y2ZoTHwa56iiCT24tFTYMLzTOpg3RnbUd6ZtSXgeou7sDgrXdS3o8J?=
 =?us-ascii?Q?hWH7ETxPtLDiDGr7l0DWrUt6Sq0KnHlwW0zfQLkb9oL4TmyYBWBMW/uyqxfL?=
 =?us-ascii?Q?RjxLxQuR6NZpH8k/KBtdPMnGRg0jNCwglbDfF9ESy1Rj5JfLEu0NQucoxucH?=
 =?us-ascii?Q?0igFr5Vz/QAa6On+c2vH7t1D9YpKHIBLeUZC7zybmYma1YFmG3nJBK9JH2g0?=
 =?us-ascii?Q?lRMJ+A92tDNLQfZJwDx4oSL2qKhPlEP2E12UJaCVY9oDEAvg0TtsD4oSLyd3?=
 =?us-ascii?Q?HOv9MMlEeP4UtP4amjdMbq7zchg91jCvrkQcFtk6qaA0HH3gvIQu5GQuRgfZ?=
 =?us-ascii?Q?B46WRKyhyexciuuwxMICWpTMruh4spXzklO2ModxQkRgslrbI/r6tgtxRytL?=
 =?us-ascii?Q?T7weyk6ehmVThElaML+Yqleivedc0LmpvOknad8LvSivbpVV4DntwveoJJIK?=
 =?us-ascii?Q?C5alSx1C6Or6O55nHwkHhbOJGRUMk5vIP2tLjap6XZd7Gx3SnICNmp/K28mE?=
 =?us-ascii?Q?cdegBDkpT3wVnZogH38X/zz71dj9IGvVx1u0Y9OYAqfChCslFuc9GTtGYbcg?=
 =?us-ascii?Q?iZm/zwjtmuDwXxFL/moAT3/kFoR25BcgtAa1yVRBjnjd6yFharbJxWIsV1iZ?=
 =?us-ascii?Q?TTBYYV7ygTz2T0OYhG1q8R4CdPgykyCCNNkn/E+eVc5O5tcY/Xef6Vfg4fTN?=
 =?us-ascii?Q?NGQIgaqSoFFCxNspewXiTAG6YpRKLqRDSO5WWx3Goxy5X89Nw5bMmi7GTd81?=
 =?us-ascii?Q?8hT+kYcFT5DA0dv5Hd29Nw3Ql5165UhHthlzYRdx3uIuJMoLQtA5n5UcmCsl?=
 =?us-ascii?Q?VHB+mf0mv6DczmzN583a0iCkWIYd7fF85ZU3f8DzG7hq3fQgqJ/ySVRrblXi?=
 =?us-ascii?Q?csDdaK1wHO+IspyK4huZHcXTMOkitrlvP1X6IklXJB6iRBivRIuJj4lWh7+Z?=
 =?us-ascii?Q?TLwlI/A1AYXtxTSsfD5nWJ/nImEZCm46jXybwM2xk26edjfRBHw9Zn3PHtkY?=
 =?us-ascii?Q?12v989jv7IpgaZRtoK+Zfnwjr3jiJYZBRpOGkIyPyUBapvCxmJeYTOsi7Wp/?=
 =?us-ascii?Q?gkuetdniErhEKl98io0wqyUcMSyXT3w4GUT1Ou1YhQBUNvT2Bwfu5p+9CJvg?=
 =?us-ascii?Q?w+6UevTbqt5Ny6wEY3EqZVadQibLmUKlPqSxQ2n1xA+ESGobi8/CdMoXXR9j?=
 =?us-ascii?Q?AvrrpabQiGzlu4Y7STBjJG0iwH9DDP+gVg3hqOhh9XnjGMesM2b4obR5BXwW?=
 =?us-ascii?Q?71a3cFMYAiWxuNW1M+YQ4nj8Kwr4dFZi0Z7ZSwVphIG3d66o9X44AEjmDhXQ?=
 =?us-ascii?Q?U8/+79h93fQdn6lqTRtm1wNSYlccFvWdUpko+uF/fY+JqurgirqlaiRcQT5f?=
 =?us-ascii?Q?2aci9OYL1RaXI9ehEItVwdI71ZJ8l3TDymzmimd+srllxnZj88OPPx3QzgNH?=
 =?us-ascii?Q?iZOeJzg6JIEY9gitXxPi2GRJ/VRS47zlVQHRTOxD2kHQEospFLbaSenTlFzc?=
 =?us-ascii?Q?qqqcbXifYpgmqQfssaOmGKdgXYgph5MiEu9/ZyX7eyVApEVIYFJ6jK9XtQje?=
 =?us-ascii?Q?YxUS6ktngMjw06WzP0QQ5t5E4QG7+XOt4WQl+Wn0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1480771-c296-4410-e9bb-08dd4af328bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 23:23:57.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1djSHDanqOvNQoQPcA5wK7Arw8OkWZPRj5OiQvmtx+XzA0IjOF8iS1GAnvaRUb/EN/1Pw3oMoRt5lqPn1YBfEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

On Tue, Feb 11, 2025 at 05:58:08PM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> Add imx95 DTS for SOF usage.
>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../dts/freescale/imx95-19x19-evk-sof.dts     | 85 +++++++++++++++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
>
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 839432153cc7..27f64e333e4b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -282,6 +282,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx93-var-som-symphony.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-sof.dtb

look like should use dt overlay ?

>
>  imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
> new file mode 100644
> index 000000000000..ce7b2384e459
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-sof.dts
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include "imx95-19x19-evk.dts"
> +
> +/ {
> +	sof_cpu: cm7-cpu@80000000 {
> +		compatible = "fsl,imx95-cm7-sof";
> +		reg = <0x0 0x80000000 0x0 0x6100000>;
> +		reg-names = "sram";
> +		memory-region = <&adma_res>;
> +		memory-region-names = "dma";
> +		mboxes = <&mu7 2 0>, <&mu7 2 1>, <&mu7 3 0>, <&mu7 3 1>;
> +		mbox-names = "txdb0", "txdb1", "rxdb0", "rxdb1";
> +
> +		cpu: port {
> +			cpu_ep: endpoint {
> +				remote-endpoint = <&codec_ep>;
> +			};
> +		};
> +	};
> +
> +	reserved-memory {
> +		adma_res: memory@86100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0x86100000 0x0 0x100000>;
> +			no-map;
> +		};
> +	};
> +
> +	sof-sound-wm8962 {
> +		compatible = "audio-graph-card2";
> +		links = <&cpu>;
> +		label = "wm8962-audio";
> +		hp-det-gpios = <&gpio2 11 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_hp>;
> +		widgets =
> +			"Headphone", "Headphones",
> +			"Microphone", "Headset Mic";

Generally, align to  =
	widgets = "Headphone", "Headphones",
		  "Microphone", "Headset Mic";

> +		routing =
> +			"Headphones", "HPOUTL",
> +			"Headphones", "HPOUTR",
> +			"Headset Mic", "MICBIAS",
> +			"IN3R", "Headset Mic",
> +			"IN1R", "Headset Mic";
> +	};
> +
> +	sound-wm8962 {
> +		status = "disabled";
> +	};
> +
> +};
> +
> +&edma2 {
> +	dma-channel-mask = <0xc0000000>, <0x0>;
> +};

Not sure why need mask edma2's some channel, can you add comments for it

Frank
> +
> +&sai3 {
> +	status = "disabled";
> +};
> +
> +&wm8962 {
> +	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL1>,
> +			  <&scmi_clk IMX95_CLK_AUDIOPLL2>,
> +			  <&scmi_clk IMX95_CLK_SAI3>;
> +	assigned-clock-parents = <0>, <0>, <0>, <0>, <&scmi_clk IMX95_CLK_AUDIOPLL1>;
> +	assigned-clock-rates = <3932160000>, <3612672000>,
> +			       <393216000>, <361267200>,
> +			       <12288000>;
> +
> +	port {
> +		codec_ep: endpoint {
> +			bitclock-master;
> +			frame-master;
> +			remote-endpoint = <&cpu_ep>;
> +		};
> +	};
> +};
> --
> 2.34.1
>

