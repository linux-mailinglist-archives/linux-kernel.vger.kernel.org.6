Return-Path: <linux-kernel+bounces-334068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3976597D241
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76213B20FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FB06F2F4;
	Fri, 20 Sep 2024 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P+ZRCVUT"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9E6E2AE;
	Fri, 20 Sep 2024 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726819353; cv=fail; b=aWtHKOS60SCoVTmUDaL3UMLc99EfAQJ7S7WAQjZbgthI+7fZGSfXCYjwTZwT+V2JT1hZeW5chlBspZ7B2z90fQmKcvpg6rRTcYzdjqzGY+HwKX5xklNZS/mgWlgN9JLaBYPa4PDsrTxwcv0RZ6m43WTICJoJ88E3xgiMVP+HsSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726819353; c=relaxed/simple;
	bh=yYKEbA21jDafxKZziN8CVp7J79MVqMq1S9Nd85HaBHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GtvJWwfoma+SJqvxxJz/QcoDYrRbih9uggBfLg5nKkfAHnEzpl7FJKAaeTimWxnxZiitYYAfC9Rk7a7moHdhS9j4qtDlqiKcNn2inirYdIJ0S/PVUq+XuQKvHF5NRsk7Ba/+LIjMKynM5UFKCg6iJMrR0YPD7dX4jQ05rBtqN08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P+ZRCVUT; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ueo7uzt2ZXcV6xrqOZiM6Rix1uzil3GS3+Tmc02Z+tU5nJ07fUppdSQk3gr3ia8o78pA2TQKZMmtSTW1b2W9FzOEq1x+CGmhjkALLhSgHO5toh0eUiqBcUE66TqFvX6jV4jCEBROnmmtorrs5zx7fVPjrsPaP15+WXjEI9HlJOTxYyg/BzTfVo3K0I4xycmkGf5yc2nDfmnSq16jzOzcg7vFOLw6tClXfcs7abBTTwaVlVM236kurwL6umU3o3ErKwSmqofzUd0Hjo/TSiFtvL/AaWNi2+2IFFMIJP+j6lfhBEPFjFRD1prtk7yxPJdDwJaZK89JS4oVdHsNFPc88g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0eDkm6a87mRDn1DwvuZAAsJ+xNntA+Du036K0tky1c=;
 b=RK03HgUiO+t9IrMv76jVrxLUtnkgQlMvZiMSDTSY/8kj9m67FrFPmG2DcJNyogpJbykXqtmBh7RKSU0XBQVj5uq0m0ua5h8NExEYvc7EaesOcGtsFFrHZYA5EClxaUd2hqcDyiUgq3fqih26eFN/1hZM58bfXRJ30+aCix/4VHQe1GCui4sHFJlcmiGZRwnWqtNCZz7Yl1f+6JH65hsD+Ll0bfV8AtAorBeK4DiGu1z2Ta/h2YHnAzhQqxZSKuR92rJssaajRTTnBWesh0bp1Ep5c4bMqHB9tJYc0m5ZP/ygLrmitJT0DP4zB+sZLAkGulhk3nYuLNyybmkmcafuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0eDkm6a87mRDn1DwvuZAAsJ+xNntA+Du036K0tky1c=;
 b=P+ZRCVUTGLixHIT4B/bkIvq1V4m9BXSYtOfyzPN9sTLbBqyrDwuoH0FrKZwmsDBkTUX4Lt+ZycMV9W60DymoeIYxbmpmg/QH/Ah4qzydIaX4O3Q26F7Uss4olmvXY2BMrhCX5fbs0qJyLpdPtYfcRKJwmA0R8DkmyxH0PErKiZbKulJPOxLS+OoA4tI3BsamNtH+FJIeSoKtNIoPyXWLanjESknPTkqj50qjeKqCXDhrzRlRTgqVJC4dKZkKtb47K5Pk5SS55xr4yM3t1Bs4C8n+a6NI5YLhqGNXntTp57pMJUq6LTlcTFTQECw9s5KAkUxF/LabarglMM0gVexOUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by PA1PR04MB10649.eurprd04.prod.outlook.com (2603:10a6:102:48c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Fri, 20 Sep
 2024 08:02:27 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::8af7:8659:9d42:bd84%6]) with mapi id 15.20.7982.012; Fri, 20 Sep 2024
 08:02:27 +0000
Date: Fri, 20 Sep 2024 17:04:19 -0700
From: Pengfei Li <pengfei.li_1@nxp.com>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: krzk+dt@kernel.org, robh@kernel.org, abelvesa@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, ping.bai@nxp.com,
	ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
	frank.li@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] clk: imx93: Move IMX93_CLK_END macro to clk driver
Message-ID: <Zu4Ng6DAYcQHCqPJ@pengfei-OptiPlex-Tower-Plus-7010>
References: <20240627082426.394937-1-pengfei.li_1@nxp.com>
 <ZtAeGWtJDMyTVkjc@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtAeGWtJDMyTVkjc@linaro.org>
X-ClientProxiedBy: AM0PR03CA0002.eurprd03.prod.outlook.com
 (2603:10a6:208:14::15) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7065:EE_|PA1PR04MB10649:EE_
X-MS-Office365-Filtering-Correlation-Id: d32a7f2c-128d-44b8-98df-08dcd94a916b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aj97ziWStHAZGGD/WVQVL1RAdY1pxzRUNdA9taUYK5TWAxb9bTCeuuzSHMzY?=
 =?us-ascii?Q?Szr+iNFMedvUevu2govIeuab+aNCOVJZ1iLvG1YkVGjkFKwi/cdfMpWnpSvM?=
 =?us-ascii?Q?Nx2+09PKLA/6mp8JhqAqi0lF36tfbk69za7Aoy69oK3i2qXyWtHc7UCFZGrS?=
 =?us-ascii?Q?cBAyrN3kDKTwzx0xlDowwil8u6+WJYUnbUKbqK8VAaVLgVMIcrZS14MjzywI?=
 =?us-ascii?Q?BJCIVavWqN9RL5uTaViZlHsyxvHJHe2FTDITLTGV9jfjvi3KYg7tkFfF2C+T?=
 =?us-ascii?Q?q4xJcJ7Y40090sNeoT1jtSEoP4fOQEY1LOR1DmPXv8OYTeWt3wBfDWDhxwNq?=
 =?us-ascii?Q?1gFo101PDQNK4jWy0S8A2Wkn4N4gxfU2OwO0V6646juXBD3RqZOOCPlSsiKw?=
 =?us-ascii?Q?AzQcOFxU+9HhbgCat0o4UbBHEs2MGEfRQLArGg899GV8z9R2m7GgEyknLSdb?=
 =?us-ascii?Q?vTBcneCQC33QMYJbM4fz2U93TWY8z480FAigFDH8PbvL71kQs5bUEMKoho6F?=
 =?us-ascii?Q?BzAleaV3/i8a4LF9bN9yb2MzpxjkPAG0dfG3kYh96vH+fEZkPjEek8Js2Wj6?=
 =?us-ascii?Q?+lISHleb5bhIiGZygD1HfyBFVkc9Ps3MQIkoTDlaNHdBqlmzDmKySRJlY64q?=
 =?us-ascii?Q?AlZ/cUYuTJDvu4U6TNdvzuH/PjCejIyuuRIEek8PmwUA1Nlz167O1y7Zclk0?=
 =?us-ascii?Q?bAqgxHNk+tnyWl9eAD+mpu350+bQL4X4KGFYJ+h25NYMZeZk1YlxHmw0+G0q?=
 =?us-ascii?Q?mt6IKuFYyfEpGv+WFd+nKCdxMMxw3nLSy1bG+x/yaVtS8nnnJkLEgOORU+hJ?=
 =?us-ascii?Q?tqoEKixgkZtCVi+eGQ4BEHE8i/U+EYtwCpWxOdC4ZRPTTrvRT0BM1SgOiVUI?=
 =?us-ascii?Q?2n7z+zdGZH7n86yD3MToG3InD74sT7jUVhRtk4UZpjNH6i9tWGh8JFaYOR/p?=
 =?us-ascii?Q?wcpjr047KVryfdcUr6kg15C5FpPqiWvrK39V5/LVRTUr35dbw+2VP0X1CPnT?=
 =?us-ascii?Q?DRqazChYbGi2O8AbdPRCQYMtSe+H+WivraYJFkjAOUB3X8JolbjEYmSj7iT7?=
 =?us-ascii?Q?ucSLsVmcQdVmzCM09hz9nslwfQakUIuMKHALC0RRms7AOEov6+BvfJ2ZhQgB?=
 =?us-ascii?Q?3le6kF+ighvYyKYmlJe6xEaInyVscCG4cvb5i4rV9pzb2HKuAzHul0LCOxG5?=
 =?us-ascii?Q?BhED32qtVEl5OCXoz6rawNYptg5JeH3yJfp9/dnv5DsQ705E0d9fsF7EFhHa?=
 =?us-ascii?Q?+m60kuDuw7piompeU8MaU/+/Fi72aY963GWi14OBZLxflAzKdhalwZqkTDSS?=
 =?us-ascii?Q?Hr6Vkbb0DruGkEg+z1n17Q1xonuUoJgU4wXBQEZJf4StLFr13td7psQA9YPc?=
 =?us-ascii?Q?g2oDCKzp+JYPDEihpOgVFZfsyUTOL6j7gp+FOZ5SJOJXhMfKMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TWvaZu9WLRvc7ha6n9gequ8dxQ1KIf8XAvGK1nUzKdp+I6IG+oxwykbpLIwt?=
 =?us-ascii?Q?FIRWzuKy73pUfQcXmb01ViAWLvpwGYX1YUAWFISJEc1KliAyMLLX/o5xg1kQ?=
 =?us-ascii?Q?7b26jfsYRv1l8gVT0MdEWh3fxRGnu66t8NswVOqjwa52dTN0XhoZiQDHaf1Z?=
 =?us-ascii?Q?KcPAjAx2P6Uz3MODyW9J3Wckaessu0MS8mfp0CctbJyHa9TIHeCSxz9fGs2q?=
 =?us-ascii?Q?uU0ZTXKGedOUkq3+61+ipndI+JgkkTGCwfRIM+6tg5FLKof1vLrCnEEoz3j1?=
 =?us-ascii?Q?JyxH0laZfcx6PymXWd6AiJCHRGNeZpdvJj4IH3nVffKgB2bC11nnRsAVwFGf?=
 =?us-ascii?Q?AVFUz5ZTZQSgBS9FvJ1+3AwS6Sc+Ogl7SNoCSbIc95MYuwp/q1CDM4ZrJQ02?=
 =?us-ascii?Q?An2ZTE/mnHchoR5w5UVsavyOTvGorNLW5qafrZifh/OMYG+r2sxBbhYjy5gp?=
 =?us-ascii?Q?/jvtuDkA+r0ObTV8yo7n+9zSBDN3sUo5fgV0P3uee5SuTHyudEkcMy0TPX8n?=
 =?us-ascii?Q?EgauI0opB2tMWX2RRNwc33CQ8KbzLfq61ET+bGfn57kMQFpmlnXe9EIL1PPt?=
 =?us-ascii?Q?J6Ap7sVs4sruTibNFHE6pEzLzzUPhjx7dbp9i8F1BIdUqIh1h1tUR3d+IGXN?=
 =?us-ascii?Q?WwNvJa5cTXQFfmfOK8vvuzPHtA0c7yVb619zsv3WFE7jj5GowdSSD7plLgFv?=
 =?us-ascii?Q?pYpfb0CAOKrTm06mAPtCq5LTRGEZwEm+psIlHJ/kL1w8Ja85j0u9eGefRqM9?=
 =?us-ascii?Q?QGLXw0e2mANmuIEZ1V0e1wt3JOUlla7G2dXLgPD8QaAFpLzRT6khp9cs7b6/?=
 =?us-ascii?Q?C9MUmeFYiSq7hYZdUo7MRzq03ZqdNRq/LJTTVZyPlBt+Szuoh7mWhzTzNbQx?=
 =?us-ascii?Q?sqweLuq1rC8YE5prWxELB486M7By/UB9U5mMKAKuzifEGb6wczV7MDuTrY2F?=
 =?us-ascii?Q?jXks61pgMZ4cKnXw0NwfcyHDCRjcEvLy2jajK7TlL5k4nSatVJmARhdsD4jY?=
 =?us-ascii?Q?sQ+Ag0FAIj/zEbNUIh0ATTYTe0jIwvi+lfhRKtVAfKr6ZKtd58hK/K7XVyXy?=
 =?us-ascii?Q?OswbGj6DBUV8s1tOV0kCXm9Gw7tFk/U2SJmZW6FzAV9CI4jkeLgyiGOxniip?=
 =?us-ascii?Q?vhtk7DlyRT+rFZyuqJO7iIHDgIJPEENSfo0XpEF+KpCyMANuETJNbcAPEguE?=
 =?us-ascii?Q?tG0KuKS5tGE0OzLr3pwQB7LGdEFZM7JPa0q/HnMRFdSKDNtjoDO280YI9mlV?=
 =?us-ascii?Q?unQq8glrSuasEDrUpnjmTBe9euIxNIxfZ5fw75AJbQ/Tb3vM1RnI5udXK/Y9?=
 =?us-ascii?Q?d0AOP5qWcBNxZf5rYyi1BuD0jnuJMSORleoJlPxYWbUEOBsQU7dpft7MayBa?=
 =?us-ascii?Q?9MnrQwyqRTvrIcg18UbzxJYjEFiOatCRHUc/Oh1+D6GS9TfslhBcbawWk1ia?=
 =?us-ascii?Q?ggGQ+o2cquyKKxP7uU617OAtxRM4t7l6eq73sImny2XHqMld6AoDgMIFnKmA?=
 =?us-ascii?Q?C9t8sLteiJqyleHoCJkpYnMarZY7Y9w3gIADu4KH8EarWW6k0c9YxCIYgqvO?=
 =?us-ascii?Q?MJy1urn3WwWRqxR4R6qkPXL/d8gyNRXxzyXwrRD0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d32a7f2c-128d-44b8-98df-08dcd94a916b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:02:27.1912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClzBuZlYA3EcYdh3b34T1ZPd+dmYiV0bbp+5p2/shh4G7O0vwGv4S0sggT1WQeOjgt9B9da7ccGdTqTmnVFLAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10649

On Thu, Aug 29, 2024 at 10:07:05AM +0300, Abel Vesa wrote:
> On 24-06-27 16:24:24, Pengfei Li wrote:
> > 'IMX93_CLK_END' macro was previously defined in imx93-clock.h to
> > indicate the number of clocks, but it is not part of the ABI, so
> > it should be moved to clk driver.
> > 
> 
> Right, why?
> 
> All other providers have been using the _CLK_END from the bindings
> header. What is so special about this ? AFAICT, nothing.
> 
> > ---
> > Change for v2:
> > - Use pre-processor define to simplify code.
> > - link to v1: https://lore.kernel.org/all/20240625175147.94985-1-pengfei.li_1@nxp.com/
> > 
> > Pengfei Li (2):
> >   clk: imx93: Move IMX93_CLK_END macro to clk driver
> >   dt-bindings: clock: imx93: Drop IMX93_CLK_END macro definition
> > 
> >  drivers/clk/imx/clk-imx93.c             | 2 ++
> >  include/dt-bindings/clock/imx93-clock.h | 1 -
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > -- 
> > 2.34.1
> > 
> 

Hi Abel,

This is a modification based on previous comments: https://lore.kernel.org/all/20240604150447.GA604729-robh@kernel.org/
Actually, whether this _CLK_END macro change is added or not, both is ok for me.
I just want to add some new clocks to bindings header.

BR,
Pengfei Li

