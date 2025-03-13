Return-Path: <linux-kernel+bounces-559721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0502BA5F89A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD9882C71
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6EB267F7D;
	Thu, 13 Mar 2025 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZjqIPTTp"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343622686B4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876450; cv=fail; b=Ct2GdjSfdsLgESssGHt3DMyDGZYvIhb+9tzYfiWfk0IWs2BloMLJ+Qg75gA4KyAiYEvPT3UBAirPmoEKElOgYTVkqMpJiQzMks79v0msKAfh1UUtzKgv0FY/aj9QLd6a/KugRG7DKwCeq6i7RJe1sGRg2iM2ZFdPg1D/R0G+yHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876450; c=relaxed/simple;
	bh=3lZ754Idtn/XpLCZwSmKtV0ou6yfyosNshCYBI1Fn0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cDwf517XZ+25a2ZUbHTG4gDy0EFwPnoArHzOHhIc5e9zoW6SUd4DCkQRD4MZpXTKmdRTK21R7keUP9Xc1EXdceaQPK432bL7HSTDgW7y9uAgJbpPnd2DlC+WkKhb77x2BT57XnioU4HHn4Z+yP+54KT8Hc9PmZEu8MI5YFijaJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZjqIPTTp; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU/TW+9zUCSrNdLbdnE1HCORNls6Y90GOZc/kgEBrri90ipba6hhzlCy2Lbqtt0Q0UOHgY399xjygRoJ1LOLx5a0QA6LQwokkr8ubKG6X3pdcKy1X6nAgI+5ApzrA9KHgXxhLr0Xw3c+t8yc+ia8zys9Z+pENrAfO7dC2k0MzhYgTLONyABY+1rumTQ9eUX1RWhzEGRATFIdIMEuw2eHuC7r2zpUfcg2OZNo2a2EbxrnG1ZRbMv9Y/mo2bT/34yQoxOOO5FMe53KeZBeNXm6m5TFLKg2Rcu5GLrl72r0gr5XUqEktFRDfWj0eS2d7GAqLiscbckjRF8R4c5roBefnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76HK8py4bEYNRaSMHf3VK0Vvco3MsbNIgtXLex+l+bY=;
 b=mH3Tso4PF3vQ6Q2Ft8o6qo3HuLFrVLwg0bBoKcwjPkHJ4/AvYmrJSz5MvMq3jz8fK3wcer0ykSKibedWeHMRovPl8OlyyYoiHSnyxwwrDtr3z4L+tnA2KNx7M8VzXbv/bEvqBs3f4XHHPevDCCvpDnmrSWGyyU2L7+4WsZsnJ0PkSd7VvaStcGgt+Rk877SZULFjXmSsHvA87+lZTpEwPnGQBELeltitYxaXsBoFh/Bv44x40KjtvGm/0uMfJ5QtFqS80bmHaWUzeMGKPh6Jv9vrHsneOa50KtX6hWSPEvgxpILSxZTUjiUUQWomGghje0SBjCvSHVKUafN5WZVaDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76HK8py4bEYNRaSMHf3VK0Vvco3MsbNIgtXLex+l+bY=;
 b=ZjqIPTTpg4IsZKBxpPHRF8up9JFhl9pS3HlWseEI2A3bxeVyi/hMkppIG/7bYaFjsuRkkJTL9jwMQH5I3aTvre1irHXKKIXQrJVQTRmmqGt4Bt99fnKDihj0g0/4gXfSjB2j5TgVneuU9nRmN2Y32/Zq06KYdKtfms7ObS/YRsaub+kZ2ryBN0xsQASfa4jM2zkbXoRaFE2oFYuWRpIue2T9L9+GAOY7OkwqYCoA2Cx9ISsgReUIncaIF7MEKMMY58ktEGqaRzGqefhKJiA9HVr45i7oIsQZbzrHd9cjm7OavmEziRgIa4b6fu+ACCiiJodgEK3z+J9nMMpoQ6XKIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by VE1PR04MB7376.eurprd04.prod.outlook.com (2603:10a6:800:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Thu, 13 Mar
 2025 14:34:03 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 14:34:02 +0000
Date: Thu, 13 Mar 2025 09:33:55 -0500
From: "han.xu" <han.xu@nxp.com>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com, hs@denx.de,
	david@protonic.nl, jre@pengutronix.de,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/2] mtd: rawnand: gpmi: Use str_enabled_disabled() in
 gpmi_nand_attach_chip()
Message-ID: <20250313143355.j5ft7udrkclnlscv@cozumel>
References: <20250313095756.945890-1-zhangheng@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313095756.945890-1-zhangheng@kylinos.cn>
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|VE1PR04MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d2a475-ce81-4754-bf79-08dd623c19a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lIVbPNERrrKdCASu/fu560Kjh4Dd8+akMrPZGCJeBoU1dzlqLJomChHVntFV?=
 =?us-ascii?Q?tp+x45JDtL1O1ElcSjRM3tXfK3TRtReXKxHgHjfj2Z0BjUmYsKaKrleBICSe?=
 =?us-ascii?Q?doyxknDJSZR5hscuISphK8m1zZcYfHT0mGa705uV9zQic7f1TnWeW7y8lpQo?=
 =?us-ascii?Q?1TKhXzVMQJsFT6WRz5digShkcNQrpz4M/BG8Pm8zi/1Js02+fvbMTM9fqnrc?=
 =?us-ascii?Q?Yt+0UdB7eDsNx1SplahcIQiyUqxRjNmftPgsHhg52TravjWHJJ5nPo9hcQHF?=
 =?us-ascii?Q?WivDJa8ah8qSbcckHKCNHNZFYXjmv//u0Vv0nxiYUJNGZp4pwONuEnOs82fR?=
 =?us-ascii?Q?yEAM1A5zaqQ8kWdo796kSgxocBHkAu1297dmA6F3nRtbiZl1PlOlESfVYjNc?=
 =?us-ascii?Q?EoMSrU9s1teTCbm3CB2hSyUWWC+Ow5ERPpL1dBru4EC3LwYz0+eAxHqUbjcT?=
 =?us-ascii?Q?ZZ8dUc55FdaTSdpq6beskWqdt97J6aaHJGdsyD5aR/I++UwIt1Of074pVAdN?=
 =?us-ascii?Q?S7ex4FdcdNF75VYRtdZqww8/88JIem0vR3bX7Bxcz/7lx84dYh0rNDhzOS44?=
 =?us-ascii?Q?T+8dZBrkZV2xzE2mJTm2rhfqSiiiWQX9gzhiT5/F/CcvXE0IEmjLuHh6nvnH?=
 =?us-ascii?Q?RnTZF168RO6FNEYwcfVK/WAtPurBLeDp69xeW7Nx4YSsK1Qt6XRoQ5ksghB/?=
 =?us-ascii?Q?jCkMALrPZhm9SEQYYngbf5DCsabzIJQcAV2wB0jJkLxig92JOmBx9i2ZlrXt?=
 =?us-ascii?Q?lT6h6ocRa05GajY3pHYWh8Q3J+W8apDnTugt3zarfS1ZPE1HEvYryAIqorXi?=
 =?us-ascii?Q?qQ0gk8og1+9ImNWvcCvlecRQ2vNXLMGtTrKzBiG4MD7XxQ+KERXZX4eRQ5a3?=
 =?us-ascii?Q?/LZoWN7VUq8ugPqnP1qyX+XZm/r92qeLZ/povZeqvv4BBC3Mv5q8lnIDfTN/?=
 =?us-ascii?Q?+FcUAjNM8riDW5bwQg7arSBXm79kJiwN4rzm8YEUa5tNhjmRzZuN3gK6prpe?=
 =?us-ascii?Q?QX25Hljl8fGzF9xhpfNSmcVyDkCUs73WHYBxeAjUlRf4s6X8BAzolaz9idTO?=
 =?us-ascii?Q?HZ+x+DHbndgJYSbNQTbpMUrdcUHl4h8D0djzNHkhQ85MfCHs0STCVFcVS0kB?=
 =?us-ascii?Q?5MfZ4TMGJ3omoyS2GDHgLuTOIS74tChB8B/egfDUT6hZSeaz1hd+DGKpqL+Q?=
 =?us-ascii?Q?kHm2QqC/DLuhx+wry1M5TOsx42HdSA+mjI2rENQnRmuCOq+gk8KprEBcYV5B?=
 =?us-ascii?Q?b0FBU0XdfuOYbCrs+zmtFvx+MBtCyqKh02znTkRko/97KwKs+Di4MWt77Sa1?=
 =?us-ascii?Q?ixyV2UzTdQt1cnZksj0ZRsgILy/w+iu6SCp/POyKEKIUdvUi5HN8ZhTJOqaa?=
 =?us-ascii?Q?h5v1nG/Bn+/nclRzCXHZU+Z1swUxeJdcjYBw8hMaGfPUTNBotYqC7yBw586X?=
 =?us-ascii?Q?7uaZ9R3ws0S8Kux0xCx86/VWx87y989f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t7uoUCeqO10WzeBJcgxyPCWhZzt+BxWag1KYnN5LnE5V3kSt4ofh6uaqVmEx?=
 =?us-ascii?Q?RvY25vhtjQUHu+3+qTijkkdkbXS3cxXFDh1u07XhrCe10xOu2mFme6I3HyoX?=
 =?us-ascii?Q?mNpvadG/mmoEMQsDbFqJMqDNr/XBltdSp0sI0+gQIFLkk0Kt4MIa/OkGTmz2?=
 =?us-ascii?Q?qw8vEwPXgHZF86Dl6mncRdnsDsSbG9TtbI0UaEbW0pxTAeUrrbKaet2wMKQD?=
 =?us-ascii?Q?MJtRYB7D+y4siqSPHOipOe/v3sXSoDRceZWvpCNlufnikHOGYw9xAuWP0R9X?=
 =?us-ascii?Q?CCsB32TZs052Zk0awxVDAYSNRMYYio2RyB612ZSgRF50NC3IbRbLcCGe8cuH?=
 =?us-ascii?Q?H1+kwYKeuXd6Dby69RWyyWQ0h00S2U2NfvJMjK5rPd9lo8A3WyWc5Q3g4wF3?=
 =?us-ascii?Q?X/pkdh0XgyU0kOqaUWICBXyUM7MyWGcpOSgAUeOQG+n+/t3fahYtzKZwmCQZ?=
 =?us-ascii?Q?K6O+bgPgoHtm5sstI8LLcJTbKDyvRK1ucGHiJX8c9nm1ap6RIz0BVQAh2HOK?=
 =?us-ascii?Q?678+a+aUNF/lwYIJ5/iOjTgDpGvofWF5fEJEV5ieNceNKHmtFxCpi/9LGX0t?=
 =?us-ascii?Q?Q0QVYjrJSnuXDHypnN1n/HRO4DVeFqs5GEtk4xrPnwI3dJAbfCyMl1ePJ/66?=
 =?us-ascii?Q?1PUqrViTu9ZXY9arjQkGjGSoIvPTSBG7bjwyZPT3IG+lLK2h/LAKJmjlzi5D?=
 =?us-ascii?Q?7r7FRhE1Ar1FYnLCbq2FOx4aNaPokq9nbWMOLLiiLPMnjxf8AfHJXSOE04xv?=
 =?us-ascii?Q?WH08LiP+yWhZZkc6voMpCthl3Nx6JUbLvJts1e474nwPA8PNutRkVYFZKKyN?=
 =?us-ascii?Q?s4Q3A31rCcwgHamsfeIjSf6nL9enV/hhAJ2JS2K7t2AUQH2rk5doIHRIydxS?=
 =?us-ascii?Q?+nG4VCQsGDzqFvFgXdbs63GTV1cRxc7caQWvjnq8y3/JyDj6pcv5JNL4xAqh?=
 =?us-ascii?Q?fYu8kKMT2G6GbKguiGGXrvLF8cSjPcSmUq94srYdVZB9daMkMhEnhWEj+kX9?=
 =?us-ascii?Q?IvyPmafDwbZvkoXqA1sSLIjZXaJDXkEZGCQ2xXs6DPl0oLSm/Bej7IA4AGzi?=
 =?us-ascii?Q?wknejn8cidoNUYFc1in/aTq17uJ/QmJAa//kNW0CRlx/YGjD0GP1Me3Q/6FM?=
 =?us-ascii?Q?pFj3/s+4cnzOiCT5IRbsCOe0V1g9mdqpc0GeZs/NJE1T3ciYhhPNzpEJ4N/S?=
 =?us-ascii?Q?n/OO8e4pX+Shvcfgk8TWQ99rsZOJ3uRlBtT+1LGQrV4zBejIUtnVMf2YxY0N?=
 =?us-ascii?Q?OSPxFoNp2KdDhlmO+JJuRRnyqa6mtEowBLCaPcsS2s6CmA/AROQxZYZp1Ppo?=
 =?us-ascii?Q?AI2C3x7f65zfloSeIhGmNc+fmZxg7aKTwyuJLqi3xs3j+wX/XbUsFDWgv0Cw?=
 =?us-ascii?Q?FN7JwYcvU7yAFP5FpUfqUag4byMsTp3v57lZfxB3UlORL3NdrMUX/YCz3W81?=
 =?us-ascii?Q?aM9he4ZWHxT/kGxGujXbahhIv9dcKkQQ/lj7oj/kZqxrfkTw3cdYO1fHA9TB?=
 =?us-ascii?Q?I1bFHoCC2/cZVNLoMKTJJD8VMZLTMVGl4rzzvfsWflHs+e3gBJqsW8ss5ZDY?=
 =?us-ascii?Q?MKWG284tmWpR79qiIF4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d2a475-ce81-4754-bf79-08dd623c19a4
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:34:02.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z/eUIrPK65l2+SXrF07FLFYXgsauk6CXON0GyD13UUfXTo50r287rhllKKygyCp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7376

On 25/03/13 05:57PM, Zhang Heng wrote:
> [You don't often get email from zhangheng@kylinos.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Remove hard-coded strings by using the str_enabled_disabled() helper
> function.
> 
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
> ---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index d76802944453..f4e68008ea03 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -17,6 +17,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/dma/mxs-dma.h>
> +#include <linux/string_choices.h>
>  #include "gpmi-nand.h"
>  #include "gpmi-regs.h"
>  #include "bch-regs.h"
> @@ -2319,8 +2320,8 @@ static int gpmi_nand_attach_chip(struct nand_chip *chip)
>                                           "fsl,no-blockmark-swap"))
>                         this->swap_block_mark = false;
>         }
> -       dev_dbg(this->dev, "Blockmark swapping %sabled\n",
> -               this->swap_block_mark ? "en" : "dis");
> +       dev_dbg(this->dev, "Blockmark swapping %s\n",
> +               str_enabled_disabled(this->swap_block_mark));

Reviewed-by: Han Xu <han.xu@nxp.com>

> 
>         ret = gpmi_init_last(this);
>         if (ret)
> --
> 2.47.1
> 

