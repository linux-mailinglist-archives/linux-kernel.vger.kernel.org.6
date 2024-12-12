Return-Path: <linux-kernel+bounces-443597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C72E9EF9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75854179AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4655223C7A;
	Thu, 12 Dec 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GobkwRP8"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E313C918;
	Thu, 12 Dec 2024 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025560; cv=fail; b=se/XYrmqJGli0KdykcSufVgMLSevYClfYfI/SeLhhaAjEXL2EN/Zw0EeW68jEMm06JMc/j28EHLm/xJk28wBZAclicOxTstRdKHJvLV4nPuqMiOhdMHFH2W9cK7Zi6HNQwIsq3C3G6hwvAHYd64kj4/c476PFH97Mc/TNRUvUEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025560; c=relaxed/simple;
	bh=dxpa0hih9dLzXkLowAQeH7cfQfvq8cq8CKrMsA9SWv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bXlsepd0VkDG4WrmMRI68Eo4xu2mcrFh3+Bx553JfEfu2B4+IwXEsRBRTYXCQX5HZEjA9LYjBf/lNT7rF2W3Kl356MTMxHDZKpKZVVKHXXoGoSSITizLfNipN7LvBhlOCSEYU3tmoE8qyoOrSBo8k6yJQwGex5cTwRvH5+bV6bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GobkwRP8; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxZI/DBiUEw8nz3IgEtnwYNe86Q4zciweFMQ4LzCdYBET82gTCD+K4NveHmDkn3Eb0GyfUVFlRe364vwqy8L3TcWrfNhgM1DaAQ2vQAKCD6cEctOIBmB20ZG2WVEZIFHau8/FTbrHst+gQlFB/ioITw+TQpBFiFmZcIYaMF0W9ovbdeFMefCC5fkpXVHtoYodjBWanZ2InEVcRyLa7/zqWJoi1U/D61Ov4XzuZ9t/lblKHlY6v3PYPz2+hISmnX5w6pYK8zusM1geIbqK2TOu10p6Bm4UYPT34z1KMF3rgz6AhOsN+OlpwHOzsi/8gC2Z3txsxtwV8EJ5PCYIysJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9UQqUq7ijyv+gyaX+bIZ7XsRR+WvZ1EzAd7InLGlHw=;
 b=RtqRS4Sq14EyJNEr/kbD0q8rU27yBMVVP4uq2OMS5ECRveI85h9crNeKs4cK/Y538lkor9vNsQFZVj4DCgQilg1iobqg4CKiLavj1rU3ypUUs554Elr4BE6OtQ6WDMC6+qhIkPdHH0T+7ajrNio4c9DC/toWF3Euq2/MsfdIxNVJTPClBcwVLKK/dvSvv7oWKueZzbJFXWYTuQZSRZQzUe2Svc6oU53TxDnS++JhXwzF01ZsV9uYrWdnoXC8WkQbunOwsWmqD9+Epjkb0ECdXHqoRqRhqmD0MkCxttCI77bLAP0xhmXd98acOO6Xc7Nle15n++ac4s1XDQB0xOgRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9UQqUq7ijyv+gyaX+bIZ7XsRR+WvZ1EzAd7InLGlHw=;
 b=GobkwRP8EdOEik/q166DDBdzvXtFMkBaoyrupLpc2SkR41sJOz7HSv8Xwjya1GQ9Kcm9TOV9Gq32O/iiHvzbcLZaAPSm0DPbJuW7UM6mLfeXNFJtyaffqsDamQVpSQtLcVH4vyPcjy45laleo8JZwpTnACPOQgrDiQ/m5RcYyHYOWZvGOi0B66++k1s9NSd/q4HcQCBe05ALn3VvvsHdNmUEc3Ng5uq9CCZpkhtezpEc+r8gn59l0NvJ8wRtmOMXloReEjGMaYMRxP3KXNNbtoeEGXMUp9SGayYaU+28qdiedPu5gNq+iBb8CQMLPakHmY3X/kFYfcLYNTf3gDEcdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 17:45:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 17:45:55 +0000
Date: Thu, 12 Dec 2024 12:45:48 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] nvmem: imx-ocotp-ele: Support accessing controller
 for i.MX9
Message-ID: <Z1shTD5QLRXB1wAk@lizhi-Precision-Tower-5810>
References: <20241212-imx-ocotp-v1-0-198bb0af86a0@nxp.com>
 <20241212-imx-ocotp-v1-2-198bb0af86a0@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212-imx-ocotp-v1-2-198bb0af86a0@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:a03:505::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d86dd30-a494-4374-c837-08dd1ad4d446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqvO1Kn20z+hPa7TBw7pVV8RhMEEssSYz4/3mGTcDRmur6KY9P+YxwmfT5zg?=
 =?us-ascii?Q?DAtrqpzZojdrOcNuFD0PjmTdRbaKIvnxlHrNsUVTdFM6Zq6dKMJUdqMGqlo/?=
 =?us-ascii?Q?R9rmDX9frKnTpuxdaBeBf6mp4Zuqm63Kj47BlsxF+4RLN87OzDKSnaAT6CjI?=
 =?us-ascii?Q?DbGaanewsiZuJ7xaLpgNXCnle/KkCV3MSdoQUUxKIx+33zzUoRnKSxvzWwmz?=
 =?us-ascii?Q?4Q2j9QgJHE/4B+nneVLMEQv3h/+YWwag2nP8OMEtT9tLvt6DJTZBB6GB+Nly?=
 =?us-ascii?Q?pm02w1RWaC5o/7r/k8MDNxWFNpq4MqSxVCuia3ydbHyj4n1Pu50PhC/Fh5Dm?=
 =?us-ascii?Q?ZJCY2fRauAcOVD1+RRR4IxF4XBNJwief2ylT5/+84iJdN98JA4Mjrqw5T7fW?=
 =?us-ascii?Q?40fpRKn6zUoqfFpEtJ86+2dMLPRReZtyoRGxW0r3mAB+t7LuJsVe0mqIe6CN?=
 =?us-ascii?Q?NOZoQV0arKzgg64AC2u1/z0AFyE9xN57HLjNfRvKx6CbPY6qP6IECHmbx15p?=
 =?us-ascii?Q?doFivvyupfAnBD1qvnV39kQ1871LtaqFMZVcF0jGQePrvDMiB7wk1mI8AI/o?=
 =?us-ascii?Q?t7wGY8hniLYHdvzoW8vRbuoIwweO+Fkn+engu/OHejXfD1uBWqhE1elLfeOn?=
 =?us-ascii?Q?WWFYx98jY4SA+yjb1dV3SUsPNl/1einubZetaoQZnFG4uh8oTba2ncoFK6AY?=
 =?us-ascii?Q?bcB34n+W/J4SHbnylGjBvpVLpkyhgaV4no0Sr1PBWFfRGvlokxY0nmHDjm9i?=
 =?us-ascii?Q?quj2TzeW7MV3/cbwFQQFslnSmYVerBu55vSJNt2zwTPTLQC+0SSGne3brUhW?=
 =?us-ascii?Q?43vkeJXnhZ4El8k1E9VflY4fjY1ZFC//GF4Hl6K+b6UbXqjWc+fYLY1a103O?=
 =?us-ascii?Q?AyQEtoxNLNr2+mb4Ha7Q7QpkRU89qIoBkAGTXOz+UyIasABSiiIUBv3HuoRv?=
 =?us-ascii?Q?cBqU5ohvIeRglneo37TCIG7kMwFwqhB3EMAEpOhSvzo+jCPXjmoN4C2k3Agz?=
 =?us-ascii?Q?HnFaklf+t4muVRCJoL4ol7tJnWR3aF+zvREPGShK5iUQMbK606BlHlRgfV2k?=
 =?us-ascii?Q?tQDglPMDMJCTHy9EOzDUn7hKlPfvqgdJJoUuhZ3uTJVlUJNeTh9gtwZHdWDF?=
 =?us-ascii?Q?KC8Pz2JU9spLjWG87EqMa99BQhxMO82zf7tSrdGME1ZRrHgkvwUY3gRSKrCd?=
 =?us-ascii?Q?BGKS4x39zPLWYQwAYoXQmeJwYPQRDB8wAGd7LkyhqEyDAo1O3O32v8Sk0coc?=
 =?us-ascii?Q?JnkU8AsYnqERk6BF0UuJXfX8MRQo1xI2En6d075AGo+CmR4YNoP/ewsL5b5H?=
 =?us-ascii?Q?gpbpju4jaAAA4CxKtTkEWpDZCXdpinbCxR+9gWroYmwxyiOkrA5KeafFDKL5?=
 =?us-ascii?Q?lXMxhK1jehfNiwJj+JzuHJCPtFBJaGKCsjqNPP6ZSAH+KXBKDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L+XhWvuhBcoK4+Ng+qWVVp6erp2YjMXg/+YB3nBZUrLreGviV40A2iFNJyqT?=
 =?us-ascii?Q?Sjjet40MtLuIiStF3SPZz+T4xDsvrF6zOKQQmvrrkFlvk02xepEEGMB9rntS?=
 =?us-ascii?Q?JwJwdFhUFNQrghFNwASgl68ZtG9tav388q8zAxGZif2efpyENypHHs1+zKwD?=
 =?us-ascii?Q?4YpziinYrmeEw0fjaUPoSJsKMyWBje3hgWPqTrRNTQHq8x8xihD9sgxTmX4/?=
 =?us-ascii?Q?LGxlUsL+18z7S4RqVzPv2BZisAG2bBIFO4Ij/uZmT4N3HkRRn9IfANLzPzkb?=
 =?us-ascii?Q?TT16ux8ikuVA/1vv9xbqAtwJDPL8XsAhZVtuhpaHvDMx0uBQJKPZ/yMDwS8R?=
 =?us-ascii?Q?JjBok8LBzg6QCEbgYI2jEoH5MueHuTX0g61OkG4ekPWSYcgnRjBUROpZKq2W?=
 =?us-ascii?Q?SunWljtTVnA+5XbSJORzkBgdsXcq0BmKNaHHEirlbSGEwVOFnpcPPvZzDqIa?=
 =?us-ascii?Q?MBu8qMn7lnc8x4M5w8ucXcUCpVTDi1AC0QJ0ztsAwaCK5bwmA+cCdZgWRie4?=
 =?us-ascii?Q?0pChLunj/ZFZk7s9OFypeePRI0LF1wFGsWhFfhaRsseiQYybbEPxtRs8Jsps?=
 =?us-ascii?Q?i/vkU6KHRFFCmXqfWxCfi4m75ga7MQ3Qo8s20QQANkWGAeK4gymhyVvvXxgI?=
 =?us-ascii?Q?RKOQYwsmUTV+kbJbMZPf6PCW/MMpSPSbuGwB0fTKYK3P76WbHeUS9HrkNYcd?=
 =?us-ascii?Q?ckHyURQ1vr4UOSD2q33RSbZ7G/z85/LTyeIygiyh5hvHuH2jjRI7AJyRbgmG?=
 =?us-ascii?Q?1lDx4murTxH4kBNff2SQuiVLoeAXCSxC6VEffzEaa18litNBVs0cKkJFgG1y?=
 =?us-ascii?Q?VFLsOy4MEITuAKk3WYgFx+eP5sjVJHipSSQvXS8DKgMxgWVYWIv0WMy0W/Vk?=
 =?us-ascii?Q?ykXhfhosWVc8A1l1XbP2JgBHfvx6PmoJYUFSx/XkJBiz+8081WaCOsdpHP2G?=
 =?us-ascii?Q?LZUNlSrhJC8jmFwOCCFx8bE+UjSOOFj5+6+6XRpCqvz2rj+3WNP5+No1+66s?=
 =?us-ascii?Q?uY0wWCahIkBRlgi7mEBIBZ2ZlOSp0cZMeU559/q7Ii5m/NtPPHVFBVa1IFPS?=
 =?us-ascii?Q?faPycEbNWhFMRG/2XtkdicFf+GesB/Ldm5M+D4R1hkwkHqLcSrrIagAPtHhN?=
 =?us-ascii?Q?Zz7ykMC5v6GhLAc5Q4O3W9EkmiMFGWVbzVODcj+f3vYGpKzk8PxZ3gdCrJ0H?=
 =?us-ascii?Q?XClLkS4saLOtRG2U3u3jMGZBBo07sN1q1095XjXZxq3jYI61Rk9Q5CsYuZLI?=
 =?us-ascii?Q?BxL+oOE++7IO1Mdw3N1a+vLU4/7ivTA9nXDfKlVfzngb2HQAQ0zzN/C557qp?=
 =?us-ascii?Q?1omS7hT65Mjs1pXzEWqYEzmZcUaCj2Ikosa3GYY788EDf5Cnprsov0katyTP?=
 =?us-ascii?Q?t68cvhxEVTB+/+kvoUUaCrGDtfwe0+/WnNGSUBiBdndZ7d4NzXCG5hHV7/03?=
 =?us-ascii?Q?/whIxqbWjYrYWoTiviH0XQfFEdWgwlA5uN7xgFhXJYdrIpo2L68zaf3/nLCw?=
 =?us-ascii?Q?u7bPphb3pK6RtPF4tKWChULE3kO8zspyabE0cmZtuoLb1w2JdWhr8FRJX8Bq?=
 =?us-ascii?Q?bTpJKi/e5FsD0TDGKx0KrWiAmu8+7MaBoHgvAsEa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d86dd30-a494-4374-c837-08dd1ad4d446
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 17:45:55.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n0ywdI9quRmUCt4XjjyqRq7AROVI/Me/myGVMiVntTewFa5icWlW5XxhVevOFCyn+5AdZQftA8UHsFnwOCZK4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681

On Thu, Dec 12, 2024 at 04:24:42PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX9 OCOTP supports a specific peripheral or function being fused
> which means disabled, so
>  - Introduce ocotp_access_gates to be container of efuse gate info
>  - Iterate each node under '/soc' to check accessing permission. If not
>    allowed to be accessed, detach the node
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/nvmem/imx-ocotp-ele.c | 187 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 186 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
> index ca6dd71d8a2e29888c6e556aaea116c1a967cb5f..542539b86efd2d38be2903c1d0ea72f918ff5b75 100644
> --- a/drivers/nvmem/imx-ocotp-ele.c
> +++ b/drivers/nvmem/imx-ocotp-ele.c
> @@ -5,6 +5,8 @@
>   * Copyright 2023 NXP
>   */
>
> +#include <dt-bindings/nvmem/fsl,imx93-ocotp.h>
> +#include <dt-bindings/nvmem/fsl,imx95-ocotp.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -27,6 +29,7 @@ struct ocotp_map_entry {
>  };
>
>  struct ocotp_devtype_data {
> +	const struct ocotp_access_gates *access_gates;
>  	u32 reg_off;
>  	char *name;
>  	u32 size;
> @@ -36,11 +39,26 @@ struct ocotp_devtype_data {
>  	struct ocotp_map_entry entry[];
>  };
>
> +#define OCOTP_MAX_NUM_GATE_WORDS 4
> +#define IMX93_OCOTP_NUM_GATES 17
> +#define IMX95_OCOTP_NUM_GATES 36
> +
> +struct ocotp_access_gates {
> +	u32 num_words;
> +	u32 words[OCOTP_MAX_NUM_GATE_WORDS];
> +	u32 num_gates;
> +	struct access_gate {
> +		u32 word;
> +		u32 mask;
> +	} gates[];
> +};
> +
>  struct imx_ocotp_priv {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct nvmem_config config;
>  	struct mutex lock;
> +	u32 value[OCOTP_MAX_NUM_GATE_WORDS];
>  	const struct ocotp_devtype_data *data;
>  };
>
> @@ -131,6 +149,100 @@ static void imx_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
>  	cell->read_post_process = imx_ocotp_cell_pp;
>  }
>
> +static int imx_ele_ocotp_check_access(struct platform_device *pdev, u32 id)
> +{
> +	struct imx_ocotp_priv *priv = platform_get_drvdata(pdev);
> +	const struct ocotp_access_gates *access_gates = priv->data->access_gates;
> +	u32 word, mask;
> +
> +	if (id >= access_gates->num_gates) {
> +		dev_err(&pdev->dev, "Index %d too large\n", id);
> +		return -EACCES;
> +	}
> +
> +	word = access_gates->gates[id].word;
> +	mask = access_gates->gates[id].mask;
> +
> +	dev_dbg(&pdev->dev, "id:%d word:%d mask:0x%08x\n", id, word, mask);
> +	/* true means not allow access */
> +	if (priv->value[word] & mask)
> +		return -EACCES;
> +
> +	return 0;
> +}
> +
> +static int imx_ele_ocotp_grant_access(struct platform_device *pdev, struct device_node *parent)
> +{
> +	struct device_node *child;
> +	struct device *dev = &pdev->dev;
> +
> +	for_each_available_child_of_node(parent, child) {
> +		struct of_phandle_iterator it;
> +		int err;
> +		u32 id;
> +
> +		of_for_each_phandle(&it, err, child, "access-controllers",
> +				    "#access-controller-cells", 0) {
> +			struct of_phandle_args provider_args;
> +			struct device_node *provider = it.node;
> +
> +			if (err) {
> +				dev_err(dev, "Unable to get access-controllers property for node %s\n, err: %d",
> +					child->full_name, err);
> +				of_node_put(provider);
> +				return err;
> +			}
> +
> +			/* Only support one cell */
> +			if (of_phandle_iterator_args(&it, provider_args.args, 1) != 1) {
> +				dev_err(dev, "wrong args count\n");
> +				return -EINVAL;
> +			}
> +
> +			id = provider_args.args[0];
> +
> +			dev_dbg(dev, "Checking node: %s gate: %d\n", child->full_name, id);
> +
> +			if (imx_ele_ocotp_check_access(pdev, id)) {
> +				of_detach_node(child);
> +				dev_err(dev, "%s: Not granted, device driver will not be probed\n",
> +					child->full_name);
> +			}
> +		}
> +
> +		imx_ele_ocotp_grant_access(pdev, child);
> +	}

Does it mean ocopt driver have to probe before other driver probe?

Frank

> +
> +	return 0;
> +}
> +
> +static int imx_ele_ocotp_access_control(struct platform_device *pdev)
> +{
> +	struct imx_ocotp_priv *priv = platform_get_drvdata(pdev);
> +	struct device_node *soc __free(device_node) = of_find_node_by_path("/soc");
> +	const struct ocotp_access_gates *access_gates = priv->data->access_gates;
> +	void __iomem *reg = priv->base + priv->data->reg_off;
> +	u32 off;
> +	int i;
> +
> +	if (!priv->data->access_gates)
> +		return 0;
> +
> +	if (!soc)
> +		soc = of_find_node_by_path("/soc@0");
> +
> +	/* This should never happen */
> +	WARN_ON(!soc);
> +
> +	for (i = 0; i < access_gates->num_words; i++) {
> +		off = access_gates->words[i] << 2;
> +		priv->value[i] = readl(reg + off);
> +		dev_dbg(&pdev->dev, "word:%d 0x%08x\n", access_gates->words[i], priv->value[i]);
> +	}
> +
> +	return imx_ele_ocotp_grant_access(pdev, soc);
> +}
> +
>  static int imx_ele_ocotp_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -161,14 +273,43 @@ static int imx_ele_ocotp_probe(struct platform_device *pdev)
>  	priv->config.fixup_dt_cell_info = imx_ocotp_fixup_dt_cell_info;
>  	mutex_init(&priv->lock);
>
> +	platform_set_drvdata(pdev, priv);
> +
>  	nvmem = devm_nvmem_register(dev, &priv->config);
>  	if (IS_ERR(nvmem))
>  		return PTR_ERR(nvmem);
>
> -	return 0;
> +
> +	return imx_ele_ocotp_access_control(pdev);
>  }
>
> +static const struct ocotp_access_gates imx93_access_gates = {
> +	.num_words = 3,
> +	.words = {19, 20, 21},
> +	.num_gates = IMX93_OCOTP_NUM_GATES,
> +	.gates = {
> +		[IMX93_OCOTP_NPU_GATE]		= { .word = 19, .mask = BIT(13) },
> +		[IMX93_OCOTP_A550_GATE]		= { .word = 19, .mask = BIT(14) },
> +		[IMX93_OCOTP_A551_GATE]		= { .word = 19, .mask = BIT(15) },
> +		[IMX93_OCOTP_M33_GATE]		= { .word = 19, .mask = BIT(24) },
> +		[IMX93_OCOTP_CAN1_FD_GATE]	= { .word = 19, .mask = BIT(28) },
> +		[IMX93_OCOTP_CAN2_FD_GATE]	= { .word = 19, .mask = BIT(29) },
> +		[IMX93_OCOTP_CAN1_GATE]		= { .word = 19, .mask = BIT(30) },
> +		[IMX93_OCOTP_CAN2_GATE]		= { .word = 19, .mask = BIT(31) },
> +		[IMX93_OCOTP_USB1_GATE]		= { .word = 20, .mask = BIT(3) },
> +		[IMX93_OCOTP_USB2_GATE]		= { .word = 20, .mask = BIT(4) },
> +		[IMX93_OCOTP_ENET1_GATE]	= { .word = 20, .mask = BIT(5) },
> +		[IMX93_OCOTP_ENET2_GATE]	= { .word = 20, .mask = BIT(6) },
> +		[IMX93_OCOTP_PXP_GATE]		= { .word = 20, .mask = BIT(10) },
> +		[IMX93_OCOTP_MIPI_CSI1_GATE]	= { .word = 20, .mask = BIT(17) },
> +		[IMX93_OCOTP_MIPI_DSI1_GATE]	= { .word = 20, .mask = BIT(19) },
> +		[IMX93_OCOTP_LVDS1_GATE]	= { .word = 20, .mask = BIT(24) },
> +		[IMX93_OCOTP_ADC1_GATE]		= { .word = 21, .mask = BIT(7) },
> +	},
> +};
> +
>  static const struct ocotp_devtype_data imx93_ocotp_data = {
> +	.access_gates = &imx93_access_gates,
>  	.reg_off = 0x8000,
>  	.reg_read = imx_ocotp_reg_read,
>  	.size = 2048,
> @@ -183,7 +324,51 @@ static const struct ocotp_devtype_data imx93_ocotp_data = {
>  	},
>  };
>
> +static const struct ocotp_access_gates imx95_access_gates = {
> +	.num_words = 3,
> +	.words = {17, 18, 19},
> +	.num_gates = IMX95_OCOTP_NUM_GATES,
> +	.gates = {
> +		[IMX95_OCOTP_CANFD1_GATE]	= { .word = 17, .mask = BIT(20) },
> +		[IMX95_OCOTP_CANFD2_GATE]	= { .word = 17, .mask = BIT(21) },
> +		[IMX95_OCOTP_CANFD3_GATE]	= { .word = 17, .mask = BIT(22) },
> +		[IMX95_OCOTP_CANFD4_GATE]	= { .word = 17, .mask = BIT(23) },
> +		[IMX95_OCOTP_CANFD5_GATE]	= { .word = 17, .mask = BIT(24) },
> +		[IMX95_OCOTP_CAN1_GATE]	= { .word = 17, .mask = BIT(25) },
> +		[IMX95_OCOTP_CAN2_GATE]	= { .word = 17, .mask = BIT(26) },
> +		[IMX95_OCOTP_CAN3_GATE]	= { .word = 17, .mask = BIT(27) },
> +		[IMX95_OCOTP_CAN4_GATE]	= { .word = 17, .mask = BIT(28) },
> +		[IMX95_OCOTP_CAN5_GATE]	= { .word = 17, .mask = BIT(29) },
> +		[IMX95_OCOTP_NPU_GATE]		= { .word = 18, .mask = BIT(0) },
> +		[IMX95_OCOTP_A550_GATE]	= { .word = 18, .mask = BIT(1) },
> +		[IMX95_OCOTP_A551_GATE]	= { .word = 18, .mask = BIT(2) },
> +		[IMX95_OCOTP_A552_GATE]	= { .word = 18, .mask = BIT(3) },
> +		[IMX95_OCOTP_A553_GATE]	= { .word = 18, .mask = BIT(4) },
> +		[IMX95_OCOTP_A554_GATE]	= { .word = 18, .mask = BIT(5) },
> +		[IMX95_OCOTP_A555_GATE]	= { .word = 18, .mask = BIT(6) },
> +		[IMX95_OCOTP_M7_GATE]		= { .word = 18, .mask = BIT(9) },
> +		[IMX95_OCOTP_DCSS_GATE]	= { .word = 18, .mask = BIT(22) },
> +		[IMX95_OCOTP_LVDS1_GATE]	= { .word = 18, .mask = BIT(27) },
> +		[IMX95_OCOTP_ISP_GATE]		= { .word = 18, .mask = BIT(29) },
> +		[IMX95_OCOTP_USB1_GATE]	= { .word = 19, .mask = BIT(2) },
> +		[IMX95_OCOTP_USB2_GATE]	= { .word = 19, .mask = BIT(3) },
> +		[IMX95_OCOTP_NETC_GATE]	= { .word = 19, .mask = BIT(4) },
> +		[IMX95_OCOTP_PCIE1_GATE]	= { .word = 19, .mask = BIT(6) },
> +		[IMX95_OCOTP_PCIE2_GATE]	= { .word = 19, .mask = BIT(7) },
> +		[IMX95_OCOTP_ADC1_GATE]	= { .word = 19, .mask = BIT(8) },
> +		[IMX95_OCOTP_EARC_RX_GATE]	= { .word = 19, .mask = BIT(11) },
> +		[IMX95_OCOTP_GPU3D_GATE]	= { .word = 19, .mask = BIT(16) },
> +		[IMX95_OCOTP_VPU_GATE]		= { .word = 19, .mask = BIT(17) },
> +		[IMX95_OCOTP_JPEG_ENC_GATE]	= { .word = 19, .mask = BIT(18) },
> +		[IMX95_OCOTP_JPEG_DEC_GATE]	= { .word = 19, .mask = BIT(19) },
> +		[IMX95_OCOTP_MIPI_CSI1_GATE]	= { .word = 19, .mask = BIT(21) },
> +		[IMX95_OCOTP_MIPI_CSI2_GATE]	= { .word = 19, .mask = BIT(22) },
> +		[IMX95_OCOTP_MIPI_DSI1_GATE]	= { .word = 19, .mask = BIT(23) },
> +	}
> +};
> +
>  static const struct ocotp_devtype_data imx95_ocotp_data = {
> +	.access_gates = &imx95_access_gates,
>  	.reg_off = 0x8000,
>  	.reg_read = imx_ocotp_reg_read,
>  	.size = 2048,
>
> --
> 2.37.1
>

