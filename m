Return-Path: <linux-kernel+bounces-522525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B8BA3CB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0846E1896B89
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292472580C4;
	Wed, 19 Feb 2025 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GEQrpC8u"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012066.outbound.protection.outlook.com [52.101.71.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F02147E4;
	Wed, 19 Feb 2025 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000685; cv=fail; b=WBIjS8MyNAkUCAukZfsVK9jHtDoLvedc7sZwiVXd2+gY25gfUAVvkggCb01Y4NHFFuG6kidEdXHFnBLVkjhbTEg3TrJKHSmwLrpEzEh8Y7oY1Jew0bCggnC3v5Rf7iy+lpYc0IyCC2u91Z1Q4nfV+Cc6/fPOPqew8ntdbc3bFis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000685; c=relaxed/simple;
	bh=88ShTAG9VQg1fE3puVglwiZh6Zdy3xY396aWTerRCRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=agHzUlQNc9N4Y4S5JrNTT2YS4blcGlf7Vu8/zuLPDtOOlnxsrSEt0mOpto5O9XHcapr/TSsdKkJBlWtfjn70ZXrLZfM2BA01Ny/S9F6/KdDN2cztNM78ZB7KZ7tv1aPxKWycd16AuIrJEhhqPnKyknuW/rejsLeaEYyFwSUUYtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GEQrpC8u; arc=fail smtp.client-ip=52.101.71.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8ELIjBMHJXRSNIb1Ni09Xuh9LLrIrR5tRlwMZFAQKm5sPedP5EMq1OpRhMIfXkJ3qKJ235OCPpUj7i3J1JZjfSPBtIEQTNLU/qpsoclrg2i+AYAMz6p9jc2WF34s1OAesowvdVijFFK1XuNeag+rnY5nBMvbZbDjkWETANsG1PRAGrPMwJEJFRWv9hfUR1W+Szly+2uQGrW93zyqsrU3c1kAY3cMGHVoXdvp4m2ZmrL4nSwVO1/9uLKhx8Cr/Zi7Rcnntc1RuOb2NJpZPzrJbAW3SbSTU8SvRYQ6uhrFmAfWCJdy2/eNXqiN3IypUMuS6fblTZZA704qIs2fW+19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDArtaT8WIj9UpXkqw/lHAdqsmTjfvE2BTCZoh+GbiM=;
 b=ur3mdOwQsVeUrhpvFenTJ4oL67NsjJWY78BSmW45N04XYGaKvgo8Ncn15l4PKYPyl+bk9rLXjqsqmXwKUvHTlkXy1tRNZJIrNefX2J9PqsnPbOfHH+98XIXXN03Mr/HO6n60m1+1lXO9ryft+yjOgpU7QN6VvIMQ687LAF1lC2MCzGv8Ve93sd2r6jnYOgDx6peBxJaPVZblxZ9V0g2n3W150XjxiR8zlSK+cli1SMlRxGXM1nQOGaYnm/gMU3NPQhBvEPiGztXFNyksGv0iyvz7cbBlnwk78C1LOia4gVkNVC3K91m30frtW4VyBftoGj/CaTzrJYIY7HsTiYZvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDArtaT8WIj9UpXkqw/lHAdqsmTjfvE2BTCZoh+GbiM=;
 b=GEQrpC8unnnVqElt+TYAcztOo2U8uFlvQoRPB9FWnDZa2m3qY+zYKGCPUnpFkxV2Xf60mOkTwfusmlGWt+maoIHr2kZ/OHDYkIiurgSsusaoYVhhL16e6N1gHhrqiEq0cD9OBOQeSDOvCRfsp5pFcAn9g2a/XyluZmNXIUdgsr8OFSaSf3izhok+uDG8+QCuI3GQJizv7cafHUPIvHgKUTk8pOlPPE2x7Az4/FQsyZcjVgx4DIH+LukmBIEWclUFRRkRg/jQwX3JyTJ2ud3+lmox6LsQGI81Ty6rmJvy2hZjF2OKsJRroXOKuJx+bAsvyAj1WFEhKS1EnmGQHZXNbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB10058.eurprd04.prod.outlook.com (2603:10a6:20b:683::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Wed, 19 Feb
 2025 21:31:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:31:19 +0000
Date: Wed, 19 Feb 2025 16:31:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: p.zabel@pengutronix.de, robh@kernel.org, shawnguo@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org, shengjiu.wang@nxp.com, peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Subject: Re: [PATCH v2 5/8] reset: imx8mp-audiomix: Prepare the code for more
 reset bits
Message-ID: <Z7ZNngd3wtJ5MZgl@lizhi-Precision-Tower-5810>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
 <20250219192102.423850-6-daniel.baluta@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219192102.423850-6-daniel.baluta@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB10058:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c78f80-f187-4e26-dd12-08dd512cbfb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OUfatbjiPzz4Byew4qIWzgBBMYre09kPLglWPDIs/f9lubedqN/OnPG3Usr+?=
 =?us-ascii?Q?pHZLwj8VCpHND+mqOzAovyU8rt+H0x9HlVozfOHpve4UaHFHSoxZK6CJ9CoM?=
 =?us-ascii?Q?WAn98oDaKh0a1j0jOyGOEfjABFqyVKtMvWZGnOJ7e7UJxvEkb8wOUQonOdml?=
 =?us-ascii?Q?nFXmG6sjfkYXjJjrZTN36lTbCg1NUnFtiQyBkOwEMATuHhrXO6G/zA2lbCU0?=
 =?us-ascii?Q?t9FO10xPLOix3Su8OfkGshNC4WdjqwdncFuSThgG4+4u0dkeV5JyTctjcIYa?=
 =?us-ascii?Q?ElI/U26x0ICSohO4LJuUqHxe2jJmOLqcHjVlBjS60MW4FSyJvKKWiy25Xw22?=
 =?us-ascii?Q?OmM6OO5bsSyxecWNVMX61lSiA9JDovv49AslFl0VWZBNU2ehmvFqYpB1Gsxz?=
 =?us-ascii?Q?iNxxfacdV2ZtvRj6C9qk9jcfZSQ4kcOJibjz0qM9FqP61pyLZ8ROX2X0kqj5?=
 =?us-ascii?Q?zmxSf5GsOM1l28Kxy6nMPh9boP8TMMimMSq3SFeaF6Ky8wvHkUQjqaTDLTV0?=
 =?us-ascii?Q?SzSSW1SdkQ5AHtnNdwXtwcPTqsU0890e7RjlrvdRCvXCB4ukAOKZryy87PhT?=
 =?us-ascii?Q?ORf2A7zaWw4JlrI5CzDJ6mxjsjwMqchALYKtT37rXIs1QlOKiBMbEM94rqvf?=
 =?us-ascii?Q?NsnZ8Ju8hfZpEwmLxRvcJUIjowqUbz33wYJsOJqvWLauUNWE/DteKE520O2B?=
 =?us-ascii?Q?cghwDI9J9vWS6HHhAxN9XHoJpOHlXwNE88ZBip3PPoULgMYv6gW2MyH+Rsu5?=
 =?us-ascii?Q?1lO94FJs3L5wyhJsO+K/Y7fGHUvo8//jBWiB1sZ/dEngE9Xp10iL5IKFJqob?=
 =?us-ascii?Q?tO8UN4JM5/nN8Y2ozeE6nETMdFOnmFtWHMLLXraD4+s0xyfAGGGO6vZeBdra?=
 =?us-ascii?Q?sNwbtf3YuERsAt5/pZ5v1iQInpGlykJCowE1S8xBqG/5F8RggTvn4auYVhCY?=
 =?us-ascii?Q?AWqrwpnIagotXbzc+evUKOoBidaGD60Lgv7hs6RMqHV57Jml+AH30PTbHqOL?=
 =?us-ascii?Q?ut/ikCBxMPt47oJ5nA4xOpdytAe+KWVHY6F3A5gVTzpZuYUolPce7pbTqOBx?=
 =?us-ascii?Q?o8YOJh9G5SaPECJLW7Ww35wr+RqzMjLMo/3nbznwWeE3nNYjYkPlWy86qqiF?=
 =?us-ascii?Q?KB2LfLOupzxo8s0yY2V90dYVGnSnYGXMUrb8KF0BXfb26E2KCL1BKf1y6qZ4?=
 =?us-ascii?Q?GOL+nzBuva1YM3fLzwrYZIIxD0OkT56HWy7bWEOKqCSkCzelTDVS8mUo3+85?=
 =?us-ascii?Q?86PKRc5yYY7Zs/H9AwYFzOVfyU8NbWcz2HNZEi844RCE3uHx1deOTmS8cmke?=
 =?us-ascii?Q?icGfhorzvaLKcqCHzjURk9LOFq3+3eaGUgSqQdVTmHGz2EQnb1w5Ev4yfGrZ?=
 =?us-ascii?Q?nlP1+AbTLmUKnL134wydPehRUGsjTe3uOAUj4YDUKXA4Q7PBn0AyW3NN3bnO?=
 =?us-ascii?Q?/Ifmi6UmdS8XKf5eAEWKpu++KcM9U20k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xTo1jiJfmjlTeDDnm3DVoWKWO4+LUutRz9gmXG/ZVPbCueEiCQbg6OBQ12ix?=
 =?us-ascii?Q?P14PxQLnW3ruTvQ/85mt0gjrep5cFi9zehlNkl7J6LOwAGi6R9c2MTpbeOOz?=
 =?us-ascii?Q?k/qPSJg1pyqoV6h8Rlv+Fuolw0NVvebvOFLEU4O1PFQDq/mJG8W9MzdfJwsr?=
 =?us-ascii?Q?RSC7zdLqEP7fgJ59oFI9h80ToMEv5tVnuG3IukSZMt88kfckDWaA3rBy+rcY?=
 =?us-ascii?Q?DWQVuPmFYaekLcNWvdMvprTnnQdNNgFKeXwesymMxwgNehj75Fj8OieeT0vW?=
 =?us-ascii?Q?HWL4GQcoO0GFkVIr+LLC9FbVMBWJyL48O1KimnfAlqAZhkBKKLUjnRxMa/Os?=
 =?us-ascii?Q?N6a605uWqFhSyNPADjQxaARKbKhZYg9sl1kSOwJcEW7tNhxixH0BeWVaoxWK?=
 =?us-ascii?Q?dxk9c7sQjxXtU5BppPQJ+pB36YFtJQJe5XyQNdauutpBFf8jfiJUucJXlGgt?=
 =?us-ascii?Q?QmjEZekeDALuVL7RoVlZKcAx/42kbAN1qZJMD22/fNtppCtwyQnEcoWVLGYN?=
 =?us-ascii?Q?apDQpRwMVmoD0brcpmctZDlEowzNl1cpnrKUF3WEaX/fsIZIizM6qBjvhjf8?=
 =?us-ascii?Q?l7XBujb6GYL6Xv96u0POVSiYWJ6tqDtTZyG1cp9X9x0fjkQCKbuZdKMyL+Oq?=
 =?us-ascii?Q?gSh0V5A9cqZc2L2K2u3ytuidUMJXKZp3fwpCBhQuKegTitPW21YFmNzJk1I3?=
 =?us-ascii?Q?VB1U8uFKDZFH0qVDYF5XsrqauOsIEdJcjAnSCI+1M3k2gcWMowcH/XbSSOST?=
 =?us-ascii?Q?9NYVKx/DDuRDN19DWa3ByZVpiLKTct4/JH+AqhfIL5lTjXgUnVdnlQoVdn9D?=
 =?us-ascii?Q?bLzP0VFY1L0c1yHvxtrGvseKJqMwwLue5Z/0ZDLT6MDECoHqwTd4JJAlCxyh?=
 =?us-ascii?Q?YQVjE2ZwN35z5jDzJNoQoBtjN2OyrhnZ3kV36QX5ITy8bGwSTtBh556Oixo+?=
 =?us-ascii?Q?FdV+KWNoNejQ4t3I4Zw4JoUR9iwJgHIb1M2LhMt3QGg5wVjvAP6mqwhNs4dH?=
 =?us-ascii?Q?PdM4pbeBydUMEIpFRsDSAY9URbUObzfK9BkUbJDr4iJJCdEczsBwY6DxzZaj?=
 =?us-ascii?Q?n8cAl0DhSgYjHY1FZyU3cR/evr47WHPiRema0oqbkfF6qb1w9UAf0rRIg5Sr?=
 =?us-ascii?Q?TrCyEvfu9fstTgbHDmAFd5yU/CyZfol3G8p6AccaudkcVeJv7wZKJy+gm9wo?=
 =?us-ascii?Q?CrYe+0fn78/RKQsdb11689bjMrFTv9N3vzIKryr81I7BvKzxmsxIJFXfMDz0?=
 =?us-ascii?Q?f+jZV7Q2rkwfAaKyZrfZ0sJqC+VOvb4hHAdSAYo6YWfD/D+wiNBW8VMIMjjc?=
 =?us-ascii?Q?2s041v1Cv6UfT1oPwBSZLEIh1rOt5GSsU2j6ukQe+zAyPRxzj5CiWRd+fGQA?=
 =?us-ascii?Q?ogZRT/wE9USwFUzvn4mZtWFcCb+VJhSfcWrkFvWXFElySsQGkT4YJ9F8FI34?=
 =?us-ascii?Q?I23/v2/dZ40MsvbQsczWicvTlm8G60KF9yDJGeIYgV+u8o9csxNVfq10kDm/?=
 =?us-ascii?Q?oe0NFfq/UuMtW2le+PUefICd3ZHElNes+QiOb2cqE+CqzdVD17E8QuefF6Kj?=
 =?us-ascii?Q?uuolzGFLkuu9B9HfPgG+hfEgllJC2F/CWrp2iti1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c78f80-f187-4e26-dd12-08dd512cbfb7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:31:19.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjQSzwS7X/1Ioh8u3H8i0vMFhKg4VaHTqeEmW1neRtAatOSAH+JWFH6c3gTzvrkRVtuZMUZFstJwD4lxz8Jodg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10058

On Wed, Feb 19, 2025 at 09:20:59PM +0200, Daniel Baluta wrote:
> Current code supports EARC PHY Software Reset and EARC 	Software
> Reset but it is not easily extensible to more reset bits.
>
> So, refactor the code in order to easily allow more reset bits
> in the future.

If respin patch, please wrap at 75 char.

>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 42 ++++++++++++++++++++-------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index 1fe21980a66c..17f78ccc7820 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -3,6 +3,7 @@
>   * Copyright 2024 NXP
>   */
>
> +#include <dt-bindings/reset/imx8mp-reset-audiomix.h>

Add empty line here

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  #include <linux/auxiliary_bus.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> @@ -12,7 +13,24 @@
>  #include <linux/reset-controller.h>
>
>  #define IMX8MP_AUDIOMIX_EARC_OFFSET		0x200
> -#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		0x3
> +#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(1)
> +#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(2)
> +
> +struct imx8mp_reset_map {
> +	unsigned int offset;
> +	unsigned int mask;
> +};
> +
> +static const struct imx8mp_reset_map reset_map[] = {
> +	[IMX8MP_AUDIOMIX_EARC] = {
> +		.offset	= IMX8MP_AUDIOMIX_EARC_OFFSET,
> +		.mask	= IMX8MP_AUDIOMIX_EARC_RESET_MASK,
> +	},
> +	[IMX8MP_AUDIOMIX_EARC_PHY] = {
> +		.offset	= IMX8MP_AUDIOMIX_EARC_OFFSET,
> +		.mask	= IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK,
> +	},
> +};
>
>  struct imx8mp_audiomix_reset {
>  	struct reset_controller_dev rcdev;
> @@ -30,13 +48,15 @@ static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
>  {
>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
>  	void __iomem *reg_addr = priv->base;
> -	unsigned int mask, reg;
> +	unsigned int mask, offset, reg;
>  	unsigned long flags;
>
> -	mask = BIT(id);
> +	mask = reset_map[id].mask;
> +	offset = reset_map[id].offset;
> +
>  	spin_lock_irqsave(&priv->lock, flags);
> -	reg = readl(reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
> -	writel(reg & ~mask, reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
> +	reg = readl(reg_addr + offset);
> +	writel(reg & ~mask, reg_addr + offset);
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
>  	return 0;
> @@ -47,13 +67,15 @@ static int imx8mp_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
>  {
>  	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
>  	void __iomem *reg_addr = priv->base;
> -	unsigned int mask, reg;
> +	unsigned int mask, offset, reg;
>  	unsigned long flags;
>
> -	mask = BIT(id);
> +	mask = reset_map[id].mask;
> +	offset = reset_map[id].offset;
> +
>  	spin_lock_irqsave(&priv->lock, flags);
> -	reg = readl(reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
> -	writel(reg | mask, reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
> +	reg = readl(reg_addr + offset);
> +	writel(reg | mask, reg_addr + offset);
>  	spin_unlock_irqrestore(&priv->lock, flags);
>
>  	return 0;
> @@ -78,7 +100,7 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  	spin_lock_init(&priv->lock);
>
>  	priv->rcdev.owner     = THIS_MODULE;
> -	priv->rcdev.nr_resets = fls(IMX8MP_AUDIOMIX_EARC_RESET_MASK);
> +	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
>  	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
>  	priv->rcdev.of_node   = dev->parent->of_node;
>  	priv->rcdev.dev	      = dev;
> --
> 2.25.1
>

