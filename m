Return-Path: <linux-kernel+bounces-400286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4CD9C0B71
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F170C2850DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421812170CF;
	Thu,  7 Nov 2024 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f1jsVH0R"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D1F2170AE;
	Thu,  7 Nov 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996278; cv=fail; b=kHzUSlgsfTzEHeFK7S9LYpNgRHlJkgCwgQ2UtwVoygJwjG5ZWzF1emJexHumKdTyFP/CLNrIry3VZ7odvhzQv6F3haFde/uV2PCY+k+hBaegrOhHrzrFaj/CeMfPIZRSjshAc7Uub3GBN4CzeF6IEbhfLu3AmBphXeRJ3qHXSFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996278; c=relaxed/simple;
	bh=sZQpt+rNciLawWdOzCf97DDHRP8rH+3jdrH84Zv/amM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DWq4VVhJSUKhjqtShphr+A3sPWtgA4ndVgPxPmts0EzQxVzmtu6fHvZjG2SymO7CsepnEewe/VfCU2pvVorQgyt1aOqLW8yTlzuzqG2PkDmAgXDtgPqvhJ49NOQ37uB38oBeijhY7Kl4SYKUOeAH83g9IVZ/mCgRvIPlfqFxAjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f1jsVH0R; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqiVoI7A8+l4fcRt3gESpnLqojMBpdDEBTtm2Gx+Qp1P8Ypq9749b+ITBZ0vxqmT5zawU/kz6vgQUfjbwSAyRMp0XznWA0zT8k36+dnxjZK1ZC2H62ERcJEDHNjKXvSujh6dtmEn+frnJWk+RvuA0xK7pmYT2Y6yRWwxsPEEg3XmqRvzbcKPoM6id0Uqsuwu8FVIhnb/juH5uc3uiJJ5fTaJ7ZAUIknJh8zoE5ozoUBM9LesdYWYT0Fpg4krzzvT7XQlHIQWnGxbMdC4KicpLsUEUuUKp5nCPYS2dZwqPWMCGHzWPKYTf4SpuIyqtuaGTpQslabW5FBuhv2+9F4MXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJz+ZzS4wZ4Gj3qpiPafRnM6egxTGM++kl8E5bNHkCY=;
 b=izUR2exN+U/p+VZIEhJrxt2FWhi3w7PmC6Y13+BANaimicNEPOCSAX5lEgaRS51A3SWNhTHlQiJC+l/swSX9zCivljXrhprvAdfTCEWy+7x2hJ2lSHECNqBOICT3nVlR/5wXRun+xCADT8Vt5t5z4A4I8+JhmF6IyBZnQp+BaoVorGBhOud2gsZ2GINDxzgkDfT8GBhjV8ywycl+TalE4nBmmqqO4gPmckuIv6KjnWZSwM9IvCobos3hXqgphJrSEIxMisfpujqiQ9mxCfu9nXu//8FdaDCIS1uwLv1opec7R1DprZy9ICVLY5TSNgtOJjbydPYGmT7ew7pLggDsUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJz+ZzS4wZ4Gj3qpiPafRnM6egxTGM++kl8E5bNHkCY=;
 b=f1jsVH0R7KiB9n+SfXXJJw4NQBRgW0LP1/zTobxcoJRxpWXmh3vrEggJnkepe5qkQa+/pU9NYfAtwD+sRX+7JG5YiHUdi14uwEz/Ak9sE9NSAkhwADw5ag9s3HicYyeCFKSjyCWq2G4ZBeHyi/vfXAwYoCBIde6BXBYFfUPnWAS9c9D7ZdZPIAOf3hRZI1sHlbxfO29ebPnMSwJNgTbKaXHJJvpJwDCWwfUY1FeMqhJGqfpQxaPzSzgNDg1g/4PuHT2tY0bGoBMFJyb3/3syAmFu5ReuFPgkq2Lps6PwmM9yXIZoe4WGCp0s7ACT/NZ9PovQMMLPSQFmn9cP/m0Zvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11044.eurprd04.prod.outlook.com (2603:10a6:150:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 16:17:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 16:17:52 +0000
Date: Thu, 7 Nov 2024 11:17:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	shengjiu.wang@gmail.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] clk: imx93: Add IMX93_CLK_SPDIF_IPG clock
Message-ID: <ZyzoJwojl9akhYR5@lizhi-Precision-Tower-5810>
References: <20241107102008.3626023-1-shengjiu.wang@nxp.com>
 <20241107102008.3626023-3-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107102008.3626023-3-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BYAPR21CA0017.namprd21.prod.outlook.com
 (2603:10b6:a03:114::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11044:EE_
X-MS-Office365-Filtering-Correlation-Id: 661f0163-4843-4aa7-8806-08dcff47bb0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DdHTDJkXADs5ZNAE8PJUZC2ZbTV3f6ryqj8BG4rSf9u6Qql8XxiN/QHce3Mv?=
 =?us-ascii?Q?gwH2jZHlgpsCpaRwwjZ9agw7/nW5fkHemy7VL+hBy7fqeYb8zfIBjuWQfHhP?=
 =?us-ascii?Q?v70E47uzFzmvBHq4hXYBJ1rZegEWjTAuRLn3u9L7qQ748CRB2/kiay4F1zOu?=
 =?us-ascii?Q?Pt43cENwH6T1GzowQsXMYMVmZPCbxWMbRIi/0qzDJVTtUTxxkVJU/bVntKom?=
 =?us-ascii?Q?7aRxjxReWkJkEqJCCUsjRHNX4fRnznkzpZAYOmeTH2wGEDj5kvxAKh7ZHwPQ?=
 =?us-ascii?Q?5R5xMolVZD/vhTp6fEfnSpe/SPa/sidRY2VwNzXrZDfbSI7pp2sDRyQ3Durb?=
 =?us-ascii?Q?t3520INzqqA/IUE0EG8fpgloqU7lYJvwEz9rwp/19pIuG5hk6ZS120FEHFB9?=
 =?us-ascii?Q?oTNlTKA3ifIab9R1Z5QiS7/Pz3QwTkGodRSBWLbhfPVyf9krBh4p8NK7+PST?=
 =?us-ascii?Q?9TvhMpLfdFsfaE1MTmtaXqGmSBHeluWxzHxl3vhC+9TYhth8QSZ1Pp4iWVxJ?=
 =?us-ascii?Q?GDzfglGZtqH9WCw7+ApXfhe38KokPRtLacpZd1f5mJ1598gQnjEqKCOwMRkl?=
 =?us-ascii?Q?l4+i71TtzizE59I28Ax3WVmoDDJBn5cihS04VAFBzSUJOUT/zg37shjhtJgO?=
 =?us-ascii?Q?oDQMbKdLlPo2k7cWt22ZYEGyQ2KPfzrMfB/5SrNePj2zrT1nIkeJkQtCPevV?=
 =?us-ascii?Q?cZ9G63d/B5XdrMwDZ0znrEXhhM8XPzBY/A7jJ88g/Dct6iakfzqoWCEvZ5tp?=
 =?us-ascii?Q?ZJyvhd6zCOvBSodPRJYfjJNWBgrTrvc6NmBCOhoCtRniU110oFQI5DvI7+BN?=
 =?us-ascii?Q?mavdyvx4gm7bnLjAJ5rbuKKLU+dlZft3DYY83mmu7czA32ScZhGqU7PpAhmz?=
 =?us-ascii?Q?A+OvVikcSCD3lHS7zAPzbKQeKTEry8PYFbybjsEXUQ2t1rrlfPGgLsnhBJXb?=
 =?us-ascii?Q?DGJajZRhnmWhiWFM5Sk2Vhh208GX8IlaI6bUeUijXwT+/ZwagS/0kE7lKuB8?=
 =?us-ascii?Q?O07gd7kHdFCxg5ws6XjKP07SRfOcmrvoRcYe9suzodb2Xt6SqFR5CNQqdhYY?=
 =?us-ascii?Q?hkAP+CzysHPdWvenYwIpDw4oI0zY3VlCXMkVqSVXPIb4xkd1jRpb9+DAIaao?=
 =?us-ascii?Q?mLi5EBBjMLD785FgFe6Gr53jjs+J66OvQMsZc3ySmK6iqZ4sZjUvtK2aXLIh?=
 =?us-ascii?Q?3Ci0zWhkxNCRdCf21fCG4A9EwplLIjaeIcgH7GwGj2ZbUiUCx8o1UYqOzCC7?=
 =?us-ascii?Q?WbekIt5Ztpo07EhGEghO23fXcTwi0sr18FiVxDI6IGocWisY2p2fKu2g27A7?=
 =?us-ascii?Q?I4R+7oS51HkmB0iEtLtVDCZrJGxRxkVbPPe6NouozNqnHvE6IfIt/179P/jX?=
 =?us-ascii?Q?4BjmJb0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MIrqzSjnvFmEqBRxRGs0CuZf55OHyQb4RMW0o15bJxrmoyaJfqmGjbizq3I6?=
 =?us-ascii?Q?zo6NXaYauPLO89CLNQXd8Elg2pgUgYGar+Cg0YUn8qxwfESUF1KSwy6ptYaO?=
 =?us-ascii?Q?xuDRRzexULsY47z+TFk59ZGFQWy98uE6C7DcW/fnp+k5GdTKVquCRb0PC/rY?=
 =?us-ascii?Q?gFOd5F+5qA1pDPXyxEWcUPOHWJa3FdhpbolVtzH8wBJf4mPYdFzejVoo5obg?=
 =?us-ascii?Q?krefvtQWbayAiYXp9Zs9V6S3gy7Di2rcS5LvLDSKmrx8/nrEu/KQMKLjtcrt?=
 =?us-ascii?Q?aKelEjk686OFGiebIyg0Zv00M/DKep72yi16OYuc00YSZhWr6MFFzVVK5O6G?=
 =?us-ascii?Q?Xd3ANCLZzQZHmA1sEbtYBGPioyBP0WgH/0zLklcSaT41E7REcxHfogo3onpf?=
 =?us-ascii?Q?RMdvWMfBdU1PoSRRwk3f3x+NRoYM8/ZJ+VHgi/PTtOkPUyXOy9DiGLqgliWH?=
 =?us-ascii?Q?OuD9+O3D8fNNV2nHpCnFNaBMTJFUb+PVLDncVRvOsmG4mt1bouvBbsslchSJ?=
 =?us-ascii?Q?HajkIm+Rk6M90fenmKdbQs8pcocB11eovHfqNnORtHnul5w1L+mRcA+z1QNC?=
 =?us-ascii?Q?AFcz/H561uD+UnOsA1O9t+/audXo2xAqV+pFls7+KoKWET9FqIKGNv+tV3av?=
 =?us-ascii?Q?9QmnLNRwlXvO4jVj0IBGQCSjsKXozmQ3Y2WPKhAN/8BVJLFuUzw2RNC/Q/wx?=
 =?us-ascii?Q?aaD0QeInzUZfw5iSVNqJP0myCpKT0CbGIeBs04i8mJmrju4WUUXdCxtYfWOm?=
 =?us-ascii?Q?/7cHt9oubKUxbNFf1LGvurPrY6UQlxJ3cO0WaHOmdYoJp80cWSCJICClv4nw?=
 =?us-ascii?Q?vSI4EFL/sVRi5akwXk+JsCH8jC0XOEhJmX4eo2PbJ+8OJIr30HRVAAZ/J/oX?=
 =?us-ascii?Q?q8JOz1BBfT6GQrDnk4pMMFhCmg9L6e5Vj2UJqJ+NeDGfGfDSNWB9YRH8EdRG?=
 =?us-ascii?Q?1xrY0f70QDWvzCYxbZQ46b6st3ZegfdEE9M9maZaumygCLfstr1ImlF5y1lr?=
 =?us-ascii?Q?9BaRgbwtHxlL40I6AkAh13bmL8Cu6mUGLeA0Cl+dnH+KD9Wk7/yHR9DRFbdm?=
 =?us-ascii?Q?CuXgyKMC6PZa9M+MGk/1gye+am/lEflfxEN1S41NW/53mdcwxq3L6THrko/p?=
 =?us-ascii?Q?VqsHG5u+jpcyCJm2AS/uO8tH8tvzkI1VBMCyB7xi30Wpm3w6ouMD5cj8z3A0?=
 =?us-ascii?Q?dNa+AQlLXIJgqQ0h6EiddkjJ1NrjMhIGbNiGRsNaZfwaDAavsqrqAvUdtI5w?=
 =?us-ascii?Q?mk8Y6jMcnZnodqc82878VunZVaoejVrFiWAI7iW3DHV/nhdv1KyQ6lM9Znbc?=
 =?us-ascii?Q?J78F96epIP86UgyWdsTUyBX8CQZDi2inT+AOeyliWv5dr9QMT/0M4EjT5yiu?=
 =?us-ascii?Q?A1BeGd+O/bV8R7QHpGpAaZKabOlD4ATwm1q5atL5NM7wPfSe7G1yyBpajfoo?=
 =?us-ascii?Q?A5bJehvJjmBIc7yH8JPsrz49m4m9up0lV18hVq/TALZRiGsyUEGyOSPPwSQJ?=
 =?us-ascii?Q?BKyWwFIzpffFLY3KWKI7BpgRHSuPyXuPTmYGSi7M7YTMUYGo7ZZEart4rteS?=
 =?us-ascii?Q?HwGVUBdXXTxBokCzZxLqJItBuVJowJzBiNB9XIS0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661f0163-4843-4aa7-8806-08dcff47bb0a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 16:17:52.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lv/jykiaWa8nfptBMOa5jeoZaG2Dy1d+KRoI5eI/ink4QLjG0YudCHWG5i/elLBNaGuZQnTIn5iV65p33kqTMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11044

On Thu, Nov 07, 2024 at 06:20:07PM +0800, Shengjiu Wang wrote:
> The IMX93_CLK_SPDIF_GATE also controls the gate of IPG clock
> and root clock, need to define them separately.
> Otherwise driver disable IMX93_CLK_SPDIF_GATE will cause
> IPG clock is also disabled, then register accessing fail.

suggest:

Split IMX93_CLK_SPDIF_IPG from IMX93_CLK_SPDIF_GATE because the
IMX93_CLK_SPDIF_GATE controls the gate of IPG clock and root clock. Without
this change, disabling IMX93_CLK_SPDIF_GATE would also disable the IPG
clock, causing register access failures.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx93.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index 58a516dd385b..eb818db008fb 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -15,7 +15,7 @@
>
>  #include "clk.h"
>
> -#define IMX93_CLK_END 207
> +#define IMX93_CLK_END 208
>
>  #define PLAT_IMX93 BIT(0)
>  #define PLAT_IMX91 BIT(1)
> @@ -38,6 +38,7 @@ static u32 share_count_sai2;
>  static u32 share_count_sai3;
>  static u32 share_count_mub;
>  static u32 share_count_pdm;
> +static u32 share_count_spdif;
>
>  static const char * const a55_core_sels[] = {"a55_alt", "arm_pll"};
>  static const char *parent_names[MAX_SEL][4] = {
> @@ -252,7 +253,8 @@ static const struct imx93_clk_ccgr {
>  	{ IMX93_CLK_MQS1_GATE,		"mqs1",		"sai1_root",		0x9b00, },
>  	{ IMX93_CLK_MQS2_GATE,		"mqs2",		"sai3_root",		0x9b40, },
>  	{ IMX93_CLK_AUD_XCVR_GATE,	"aud_xcvr",	"audio_xcvr_root",	0x9b80, },
> -	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, },
> +	{ IMX93_CLK_SPDIF_IPG,		"spdif_ipg_clk", "bus_wakeup_root",	0x9c00, 0, &share_count_spdif},
> +	{ IMX93_CLK_SPDIF_GATE,		"spdif",	"spdif_root",		0x9c00, 0, &share_count_spdif},
>  	{ IMX93_CLK_HSIO_32K_GATE,	"hsio_32k",	"osc_32k",		0x9dc0, },
>  	{ IMX93_CLK_ENET1_GATE,		"enet1",	"wakeup_axi_root",	0x9e00, 0, NULL, PLAT_IMX93, },
>  	{ IMX93_CLK_ENET_QOS_GATE,	"enet_qos",	"wakeup_axi_root",	0x9e40, 0, NULL, PLAT_IMX93, },
> --
> 2.34.1
>

