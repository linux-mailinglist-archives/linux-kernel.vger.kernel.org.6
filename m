Return-Path: <linux-kernel+bounces-522529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30F3A3CB82
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29293A8F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67332580CC;
	Wed, 19 Feb 2025 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lD1imvK0"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012013.outbound.protection.outlook.com [52.101.71.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9452147E4;
	Wed, 19 Feb 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000795; cv=fail; b=n75MeVehnHeGhaCk3E/XM7viMQt/eyZtIk7/bvPSJ46tgwjtYw9deL++kZv1ucMOyngqdbH5vBe/l1sopxYzWv2vPCbDOHabhbHG8AUE3OBcE/td2uFFwk3qkVCSWsGIWrqbq7AO3KPY4Rnnm12780bnGon+hZsEnMZKXJGqLWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000795; c=relaxed/simple;
	bh=V0RrQvQS59nGzQkJfZOlOX/tf+9TzVo7yWQ3X9XC9nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p//iWk8aIniOKP0nKw9dS8gWscIvLXpBnqxz7UV44MWyk8rxABzWftzQOFmeZ6Q/PX3Kx/faFubOOuYovH07rFHHPHQcyiU77q8AmXys1a6KUC3J0y7OQDxVOMiCdcvfogJ9RPCzTHzyFigjHSbZBOcSrHA2lKg7Yjfqrvy/ZgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lD1imvK0; arc=fail smtp.client-ip=52.101.71.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqAO59vthm2xf4pjGT5tXVm1wNQCEl/9/EhzNM2Lhu6Xm5p7/shfQFcCq2Q+YI85U3ilDeDg7ceY22sIj6pgBPVHDOmd/P6ykXYyX/QesB5e1KlH58rDvTIvjDgGBUUQaQx9xycXvztTz0NJxr19t61/t0W62qnNlNcMB06eyvRtibfcibPo+xbw2rl873UpsDfH/Esf44Ket0WuMcnxnQ5IAGqWFpzMfNABw4qJY1H6mIRuodmPHlMpT237NNWmNl2+SSPKIPYqkxt+ww66DI+JIGMpoeDyRdn9txQOJ5euEzaC+REQZtsnfe6YPXcnC1eIuCW8ZSfkjawLWfYY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFuaSnrc68rqu34kpKA6/Z0ITdEvHIFEpnGvEbxv4fY=;
 b=D4EKLXbfg0+r8AFa/U2Hkv0n/Ws2ztdC6yAzxXituXcb5U9jCiOtPZ31Byl1pxp9cQrThoQ8ThdjXjDC0pfPE4lYsFcORioF2Fu0ONZ40p4uXqGXTq36CEboc/wCxFCoJWDlHqSOgVmnACzJPSi5yJQ2GtXUOzdrLKYcgf/dL8gy0081wrnItO6rrGFKXs5mrA9L6E1KqvaEMgwXtRnaFYk10em+nTLC9hWFh8Hpcsk4iO+TjU0+EcDg55pH5L4Hk61Mbrw3hWiVgEAGs+JknOfseFq3+ujRfeVHmctqVhMxKLPtTz60Dm3RyvDPxAI4h9uJh34b3gryrySjU7N5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFuaSnrc68rqu34kpKA6/Z0ITdEvHIFEpnGvEbxv4fY=;
 b=lD1imvK01jGDYvnwBjMQRameaymp3Nqpm5tuFICiaXFPQ50EvwJhktKpeiW2h7MileQ2eb7KXGSu0xjs3ynIlP+fnVBSgrL4GM8TWsFfO4zWH1jJgMUacupuChG+vJZq2yQFdLvrFklAyN3Vlj6k6syKoLVy1BN3xDiZA5fIv1LJw+6DF9E5moHjF3e4rIA7Zy1GIkgUvWuFE9v1u5a8e3bACkqT9LDLpU5Q5115QWB+0+KocFJeXmmgrDj0Ygr53avihaUARNCRav5YfgH0RGfbSGOZkYiqPXcdBOMvZLhaJGLDsGfkfuu4qKTq2q1Mxwo5reCK74yBx+NjygNcOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB10058.eurprd04.prod.outlook.com (2603:10a6:20b:683::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 21:33:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:33:10 +0000
Date: Wed, 19 Feb 2025 16:33:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: p.zabel@pengutronix.de, robh@kernel.org, shawnguo@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org, shengjiu.wang@nxp.com, peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Subject: Re: [PATCH v2 8/8] imx_dsp_rproc: Use reset controller API to
 control the DSP
Message-ID: <Z7ZOEDV3GnO7mAwx@lizhi-Precision-Tower-5810>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-9-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219192102.423850-9-daniel.baluta@nxp.com>
X-ClientProxiedBy: SA1P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB10058:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d847d2-8e68-4ed5-2b55-08dd512d01a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3nXg0WX+3kTBjYurkMiYXuL1z/t90qSunGg64CUl7RufJ2lrWmVsnXiDpYkz?=
 =?us-ascii?Q?09u8khe8coI/FqfPvT9PU2ZE4qorLDk2+FhgfrHWj1DeNzy02Ca6Y+JZSQmJ?=
 =?us-ascii?Q?cXkrXC6bGx13t/B89IgBZA/SFRNpqBhnl+SKT5xmL+/R0eOoNlnnGRfqhawq?=
 =?us-ascii?Q?Gk089WLQfuVLyVpSE2x4B5yiy6+vT83ab6LrGKsAGQC8/6fh8certnb48u5L?=
 =?us-ascii?Q?QzOgYNnmB3rboTYUsf/Vf26PcrBN7+ttybGFWxla1BWV1034tK2G/ohgRnMC?=
 =?us-ascii?Q?rnfXAA9IMW5eWSSIKev4gp1sOmwcJCAWP71s0XcwyhoWIJOyUj0ASj90uo9M?=
 =?us-ascii?Q?ArTfN4K4BKlwg+0hPnyqSTBJXm32BeiyAPLrxoABe+2E6yzzQUe30zL1HbI8?=
 =?us-ascii?Q?WTj2VRqxLnR4k2c1YNE2MFY9nWvtMTW5cgKv+EgARqh2YqXsCm7vUeXAy+QP?=
 =?us-ascii?Q?nWXkOYXr92pwd4Rrd9hH3WiWTidBZFpJ7khHhoHKQh6liiCBgRVMC4vYQqX1?=
 =?us-ascii?Q?Tr6H/QkH2J5jNoY88lK/3vC1sWP/6tYgvj9sqdALdAqV6irtOdSA2R5CFrWa?=
 =?us-ascii?Q?TrfY0G4Z+YmBC45ilhBrLuHflbhl0dpoojYdjgogjXL3jKm98Bn9zVtT3qrR?=
 =?us-ascii?Q?ID64VeK0lvA7HpxI6psgcdRFZVxgmBddaCwWj+ZfgaYJyiDQyqHffEzW9hPE?=
 =?us-ascii?Q?xcWnRsMZPY5/F9qXJBDAaWvGKjbR5EgAK85kTnoZpL0aoLsh4nBOAPupizE+?=
 =?us-ascii?Q?9FvUJ0oQ8w+BnWtzTYU40aN0jwb8tR7GjuUC4eAVJiu5dCdjrMlC+875UFxO?=
 =?us-ascii?Q?mkAJME8JV+TH1vJ49aMSpTB0XgysaYrqfLjugRI2m6Qq7qNgTLBCjqgVcOM6?=
 =?us-ascii?Q?azP0SE9i6h9IISPnbDmvGqky4Xuv8gJ3GOuOWmAwqCa5C+7gl/lBeIbZIgxZ?=
 =?us-ascii?Q?1ZP8LoT4iIgotz4WUxoaX7ZxPV0nsk44WLrzqwjk09Ex2LvvveXyKjqanVYN?=
 =?us-ascii?Q?iE8JspLkQ54mVXT8AUReZAcDrrYF76KAA7GiDbI06xdBPtBz+NeipKqc3756?=
 =?us-ascii?Q?Ut11v/gzulIWTVoyaF2QEqFcBG3EBZb0irhxy7I94xVEC/wvsY9+W3d32pMq?=
 =?us-ascii?Q?hYAYMxVODlXMlnWX3ZdDJA7k6lY2OUpgVdOWjP0hcPRE+mSDvvkxkB8sWvBc?=
 =?us-ascii?Q?XPtZM8uNL0WJo0hjtdIHd1YAL6tefXO8IOJ0YOavId1KaEhckQgGY/U0tjT2?=
 =?us-ascii?Q?BQWFYoWUFgHHeIb07Az/YMFCI6SSPq+E130JC04miIv9gXiy1XdN75pe31O7?=
 =?us-ascii?Q?CYofUq70O6zdqQkdcDQNGVTPjBWvIMHF/nV5DAuQVYOL2EV1G9N2o3z9+Z4w?=
 =?us-ascii?Q?ObmIMpmQvSWBS2K8R6GJGXZscGNqEpfJ4IzTnCgy4EL85i8FDIDjgHnclrDW?=
 =?us-ascii?Q?pq4w9SRSZcWfpNdKvwwIATNjoH+t6xNo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2aXyXDhGqmQ2xn9NZhRGyPU5MV0z0qjwFvYiRDW8ZLXVzNJz0zb+7E4FiSXJ?=
 =?us-ascii?Q?UNzSqGGI+xYh5v6TFVLcCeenQhULrm+eJWx1UOx2Sk+nqDvlL0Ad/nbnff4V?=
 =?us-ascii?Q?O9CyFb7V6KRCscA0PtAJEmwNftpyamLTlaR2aITt41eoW2Bt5lbjeb59047p?=
 =?us-ascii?Q?iCJMxFf5Xcigai7UKkgaU3DaFady/uqaWmLi5QAASczpWARK5MUN1aNpz+bA?=
 =?us-ascii?Q?DeGntoXs/DQbTb4aFCXVkUtrRi/pvV5duX5WGf6SPGqWOeB7lSeamvZTtr9U?=
 =?us-ascii?Q?6wBnbfOgGbPFPEPGQophGwkRTqXRm7vEuQAMuSJM/D7FwzdGx9gmYSv+vFRk?=
 =?us-ascii?Q?bpJkOKWDVPdKBcgjyCx3hPdvMI7PsVEP136k0fPL0tjMQcq4jw0gBOoO5VIH?=
 =?us-ascii?Q?YAssil6XOS6kOslnZpeNxxn+DiSXPwGdRZNp+YHzpHh/0ANPsrB6YYlsdnEK?=
 =?us-ascii?Q?H1inrw2FZQ5UvKBoqOixabuumgMfo9pZZ3+E548iXulxuH8fB/pJpokzVL9z?=
 =?us-ascii?Q?WC0Kv0p5/YYzpS+QALs/9nqBCrKgNCvHprtJ7LyZFo6MEnhIcsTcQ9RYTfYY?=
 =?us-ascii?Q?H0f2R1Dp8CXf36ABDX2NEQPh8iF8J+KkSKvIw1zeTSM6kOBSb1spG4wxRuai?=
 =?us-ascii?Q?ycdNUf59S96s+BWKO9OYQLqHiMbrLNslGcQzQBbhKp8AYwVoVtFpF+7g+8nu?=
 =?us-ascii?Q?ReT2YFnxRC1aJ15+eTO1I3U7XPscdg5ueyHq+MGUMT+zhBwQTCqSnPjZrJNg?=
 =?us-ascii?Q?G5N+2GhEl0XSbhpSi5tHDmKMyZSbH2F8rZMjRsMerdlj9E8bkUfhAtiWainE?=
 =?us-ascii?Q?Bf4UH0Q/qv4tTeo1ISxMo3yLACBqjUgO7NIMWQyULsbPfmA/W8AuOby3I10f?=
 =?us-ascii?Q?Zk+ybzt80TOb+wOAPsiqaTviGW4uxqjU5RFr+Ey+m6PjpkttEjP8RIEDnsBv?=
 =?us-ascii?Q?YLP+jFBt2xl+ZptVyd1fWWWUxR0CNqyx9OO5kq7E9WPGSNc8py/64P7/Xk4R?=
 =?us-ascii?Q?ce+suPyk2SHcVT+ac543dcwZ7mZjEV7HKv0R6n+iEFDt534tajMsZgaTymJy?=
 =?us-ascii?Q?PcBEfm0faEtbdL7RaYbd/RS0ahAmqiWzYRlBOM6WrKDA5VFWAABk0ejZB0iE?=
 =?us-ascii?Q?wD4PEP3k8vkLSFrWmDVrFig/a+/2c7zG1Ym2OeScWmr2f3SbVTDHRH4r/nfz?=
 =?us-ascii?Q?P+nNQbmlfcD9O5PCl5Eh6+OxaPKB4wCWIwrapVp2JeJHMIeZjbmBN+17skuY?=
 =?us-ascii?Q?mpYQF9iN5wkCPDAwWp/LeyxDrinVGriML+TQVMDidm1fgj6WHxmLxAyv7SK9?=
 =?us-ascii?Q?Lywc5P7ViGL6Gp+kDzKxnLxlvJWRqawKwsVKingeBUga+YK0YBtv+kLko+iG?=
 =?us-ascii?Q?n5CTjGlTb9trZfkgm++nJtVO2kJSHYZ2ulBrCLhdVcJHptBMVcnkMuuq+E+r?=
 =?us-ascii?Q?x4Y+XhzlbKSmQzey5FL964Ydt9QZG2SPeUf07Qi9evmzlixjLbRhVBI2Cjbu?=
 =?us-ascii?Q?/Jssihf3Mu1Slx5QarmKtN+9PZNtGIoB3s7IoVD+T11UsgAwXIXP3oUpqJ9s?=
 =?us-ascii?Q?7NJoWL+Te38Ljf0LABPAZFOJ8heD8uwa2AdR0KtZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d847d2-8e68-4ed5-2b55-08dd512d01a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:33:10.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTFiMEW3nGMjWTxAQTXAfyvow3pVC4kU0frUcJuaNo9+/vTORi5dT+flh0iXaiGxjcuu8D9I0RjYjjQ6rl7Svg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10058

On Wed, Feb 19, 2025 at 09:21:02PM +0200, Daniel Baluta wrote:
> Use the reset controller API to control the DSP on i.MX8MP. This way
> we can have a better control of the resources and avoid using a syscon
> to access the audiomix bits.
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/remoteproc/imx_dsp_rproc.c | 25 +++++++++++++++++--------
>  drivers/remoteproc/imx_rproc.h     |  2 ++
>  2 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index ea5024919c2f..631563e4f86d 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -19,6 +19,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/remoteproc.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>
>  #include "imx_rproc.h"
> @@ -111,6 +112,7 @@ enum imx_dsp_rp_mbox_messages {
>   */
>  struct imx_dsp_rproc {
>  	struct regmap				*regmap;
> +	struct reset_control			*reset;
>  	struct rproc				*rproc;
>  	const struct imx_dsp_rproc_dcfg		*dsp_dcfg;
>  	struct clk_bulk_data			clks[DSP_RPROC_CLK_MAX];
> @@ -192,9 +194,7 @@ static int imx8mp_dsp_reset(struct imx_dsp_rproc *priv)
>  	/* Keep reset asserted for 10 cycles */
>  	usleep_range(1, 2);
>
> -	regmap_update_bits(priv->regmap, IMX8M_AudioDSP_REG2,
> -			   IMX8M_AudioDSP_REG2_RUNSTALL,
> -			   IMX8M_AudioDSP_REG2_RUNSTALL);
> +	reset_control_assert(priv->reset);
>
>  	/* Take the DSP out of reset and keep stalled for FW loading */
>  	pwrctl = readl(dap + IMX8M_DAP_PWRCTL);
> @@ -231,13 +231,9 @@ static int imx8ulp_dsp_reset(struct imx_dsp_rproc *priv)
>
>  /* Specific configuration for i.MX8MP */
>  static const struct imx_rproc_dcfg dsp_rproc_cfg_imx8mp = {
> -	.src_reg	= IMX8M_AudioDSP_REG2,
> -	.src_mask	= IMX8M_AudioDSP_REG2_RUNSTALL,
> -	.src_start	= 0,
> -	.src_stop	= IMX8M_AudioDSP_REG2_RUNSTALL,
>  	.att		= imx_dsp_rproc_att_imx8mp,
>  	.att_size	= ARRAY_SIZE(imx_dsp_rproc_att_imx8mp),
> -	.method		= IMX_RPROC_MMIO,
> +	.method		= IMX_RPROC_RESET_CONTROLLER,
>  };
>
>  static const struct imx_dsp_rproc_dcfg imx_dsp_rproc_cfg_imx8mp = {
> @@ -329,6 +325,9 @@ static int imx_dsp_rproc_start(struct rproc *rproc)
>  					  true,
>  					  rproc->bootaddr);
>  		break;
> +	case IMX_RPROC_RESET_CONTROLLER:
> +		ret = reset_control_deassert(priv->reset);
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -369,6 +368,9 @@ static int imx_dsp_rproc_stop(struct rproc *rproc)
>  					  false,
>  					  rproc->bootaddr);
>  		break;
> +	case IMX_RPROC_RESET_CONTROLLER:
> +		ret = reset_control_assert(priv->reset);
> +		break;
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -995,6 +997,13 @@ static int imx_dsp_rproc_detect_mode(struct imx_dsp_rproc *priv)
>
>  		priv->regmap = regmap;
>  		break;
> +	case IMX_RPROC_RESET_CONTROLLER:
> +		priv->reset = devm_reset_control_get_exclusive(dev, NULL);
> +		if (IS_ERR(priv->reset)) {
> +			dev_err(dev, "Failed to get DSP reset control\n");
> +			return PTR_ERR(priv->reset);
> +		}
> +		break;
>  	default:
>  		ret = -EOPNOTSUPP;
>  		break;
> diff --git a/drivers/remoteproc/imx_rproc.h b/drivers/remoteproc/imx_rproc.h
> index 17a7d051c531..cfd38d37e146 100644
> --- a/drivers/remoteproc/imx_rproc.h
> +++ b/drivers/remoteproc/imx_rproc.h
> @@ -24,6 +24,8 @@ enum imx_rproc_method {
>  	IMX_RPROC_SMC,
>  	/* Through System Control Unit API */
>  	IMX_RPROC_SCU_API,
> +	/* Through Reset Controller API */
> +	IMX_RPROC_RESET_CONTROLLER,
>  };
>
>  /* dcfg flags */
> --
> 2.25.1
>

