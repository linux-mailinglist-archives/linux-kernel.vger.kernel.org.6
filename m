Return-Path: <linux-kernel+bounces-183923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4388C9FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86426280E97
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB76137921;
	Mon, 20 May 2024 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AHWSK9TD"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2072.outbound.protection.outlook.com [40.107.104.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C1E13791F;
	Mon, 20 May 2024 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219884; cv=fail; b=YE7oaDOs3Lsepo5lJxUgjhT27sZlRywJWxyFNmnFlf2SRwv8NvOYtbD21vtO2bX2cudeyhCBIwvXlQFAnpxNZvO7RkBEfq5Co3z9DiWsf/y/Yr2FzUXGbx3koXA4zc/4wQQK5WrF5yajpfvOsfc56wHNr2tJ/XQZjM1gX2RxXvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219884; c=relaxed/simple;
	bh=GHMBgasvbe9I4qb42G22z721lmtl683Ltn7M68ms+7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IrQ5HW9F+qqBqDruQheivFNdUclDIeD1ud0u/6e6AFrMKJj8C8PG8D/5RROa9zlmH/EBWyvJ+6kNphE9KA2fEmFGnf7NidrzMzg1sRVhriSYNiDfdiICxw+vjhFQZT3OQirHz44MxT8FDEoqIu4lGUqyd0k2frKPsY0IE4yzN3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AHWSK9TD; arc=fail smtp.client-ip=40.107.104.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWEeH4bE9uRnPNA7ls5ST2+CHOdRramSTvqt6cSh3WIQsSTN22FN6b6DBNeHtDJHpMtPXULuV8UEqxqZEVLvsSAjd7hJq4ZCmAQhWV9Rd2KXv8Oufi4rbLTpZfbjAxgaEwpu6SVhw8cwcmXGfBYZ03PpyRDVsdQiWf0rCcIIhElYEdNTnfY601KbpIak2+FDx2yZJcb8ut5r1ABQxhQK/HWczg0oCbc/vvaSEVxpkkRUEo0B1iLWf/+1OFPpnU/aWeSRkhpKKgBY7FbvaIGJ2M5A5nw6d+F0UGkL5+MLPCVlKraDCCPVpxmOOH+qJ0NHTZqgMLfBbqzyACHr/FRvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3dSTccWiVFO5uW8KhqNCmZpfiPtc0LPiyweWivA0ls=;
 b=SdF6vGsFR/Prw4GpodVWNY9eo0RFheDD0Ca7w4M9kvs51eEwCPGl3Eyl+NJ7k0iDxaCYQjVnyBU7ZVr8o5BmjPJpDbwBXm8myFwewxpA9tKdJGu7akZzANHysHbIS1GXbJs652tDLORjuzhCq0oOSgr3wtjSdai9HybnpeS4/pK3co6GRWfhVESVZjxTqeFD4HX0/1M6BoP4BHqkRBXAZhEi9NB6Z+IPnMdk9i7zwGhuopYHPY4LA3evP0GIqBt7rjz8eb9wpsXiBoCmTDxkPP9lp9Z8Zp/8vZD4k4YZDbwppzlJWkFnhiD1+PxGAsAqiVBZaq2eIH8qSAhGFZSPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3dSTccWiVFO5uW8KhqNCmZpfiPtc0LPiyweWivA0ls=;
 b=AHWSK9TDl0bpeXBasCJCEUSIWb4iT162ojjZzRrXyNzMwD4VRraQMxqFjwa6m0LhlMk3ss3yZsZB0Su/B3A27uiA0zZyK490CwEpkYfEsKXTTjPBy4JfKJ22pK2zHJwMW8J9jFCP+t1m4aJ1VL880FpwktHFjtuUx/K5G9kwwUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9370.eurprd04.prod.outlook.com (2603:10a6:10:359::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 15:44:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 15:44:39 +0000
Date: Mon, 20 May 2024 11:44:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, marex@denx.de,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v4 2/5] clk: imx: clk-audiomix: Add reset controller
Message-ID: <Zktv3OcDbV1cggP1@lizhi-Precision-Tower-5810>
References: <1716188963-16175-1-git-send-email-shengjiu.wang@nxp.com>
 <1716188963-16175-3-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716188963-16175-3-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: BYAPR08CA0060.namprd08.prod.outlook.com
 (2603:10b6:a03:117::37) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9370:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8e66e2-79f7-402b-5e81-08dc78e3c271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|7416005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GBt05SBQvIQx/sOM3J6IREW86mGW/bvk3XOp5PhYNRVUk/lNTLEipmi1lFq+?=
 =?us-ascii?Q?3irnbIAbA6hsTNxcQGP3WyQq8JR4tdmC0FFspDn0njG5Uav8uAEhHwpERYbW?=
 =?us-ascii?Q?OFNdWMU/KJbhQP0xm2CWxnvgMg3eR0TZX9U2dj97WuodusMfyhxUAepJl7Vc?=
 =?us-ascii?Q?WYbv55RSa23KkaSIWD2R/9hrEWMQpi++eRyPqS2QtONKrEt0tM1g3oEQESp9?=
 =?us-ascii?Q?E/jDrU1Ez0kPkpuWeoswOwQ1Yi7JSpmnyJb6MRm5mYjEUDG0w+lSQzYI8ewB?=
 =?us-ascii?Q?g7Q9HaIqB2T+XXmcxE3xEMWFBM9kTGsrsdxggTWd33uruoZ2ttXSA+KBAFsD?=
 =?us-ascii?Q?a6KwGdexpY8tK6kSewSvLVylWyrEhKv70UBxPyg8HsWibcZJ408+ctjr/bp4?=
 =?us-ascii?Q?3Xp2egCO1X7uwvwsYN66Ob1WFvzwDKJHG2F0RXm3sCrvWF8tjIEQcDDeRAkE?=
 =?us-ascii?Q?cH6sNuEN4dUn842ApAvsZrzRk1ATp70uq1haiZDTHG4ccLvKRd/hMk4VxGAc?=
 =?us-ascii?Q?Y/+puTJkThCjZJlMTPYxLZkc4OhP0xU6Wf8QaOCJBaf4qo7nIySYvRlbnnYb?=
 =?us-ascii?Q?IfniA6oixxRcNQX6SrcM3KZe2LvJn9M37g7gsHpLnbKwka5iK+h0Xh1HWb/6?=
 =?us-ascii?Q?o4zRAmWCfiDItK5uh3S/vAYOCGqHcyX5BTaRdq/NLBKZbL5fL/Tldl9OTzgm?=
 =?us-ascii?Q?6AorYXXpOt7yE1ZTGatEwdfPu95aSD6xOJEgSHB4dnwyFtPCp1EfLJOiSEHF?=
 =?us-ascii?Q?smCYryA/pGvme71fLCj+WaLW4pwzyRwZ1fMr+NtllIDTpck6XcUOmWIssIGR?=
 =?us-ascii?Q?xt/d7RjJgbrVgqHov1p8bCKV4Y5/3VjA6lYNRyIMRbpV2SwIXhCxWFHy8FVK?=
 =?us-ascii?Q?GD4V548JUjBEiF0fLZkd8g4ZLEq1Innx0uV5KdM2HJyNGdmO+ZNFsz1IJFUY?=
 =?us-ascii?Q?30U3fymGJkH1J/55afJzrFD8n/GwMXaI34sZnQ/pt/hn24t9EZTZDHupCsNj?=
 =?us-ascii?Q?nN9icFsdhnT8cdw7AVufXmrH8+enZFMvGQGoOhUW9NHyUrUZyDApOtx/Fgh7?=
 =?us-ascii?Q?EFxT1WSSRcOk17erdjC5Wz1cVb0zh5sFT7VPVRwD8BkJSdGBHfI7O/FKDc1s?=
 =?us-ascii?Q?2pQLZUAgFwzztn+y/z0vyPy7znkCefJqGYQItz4RbEV1LJLJwq0pzPhzT8P7?=
 =?us-ascii?Q?+sg4OMVlUBLTFhl6E4iVIc1yhOMrquVW7FhYnygQn9v5ZDl1AiYF5s82XEZm?=
 =?us-ascii?Q?WStU/16BoPU7YSypZOGLLLR2aNnX2ogODjn12z0z6i1BcUU3yajPyULexEMg?=
 =?us-ascii?Q?1PyFylyQOwPf6MbKghs0jwxxiHGL3cRjK8k5ZN+n6u8whg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5GtSpWwmTcnFNlcTaliMC3o/kmPSEzmrdZYcY+9JU/eu9n8ghumUuXdB9/Nf?=
 =?us-ascii?Q?S9KfqCCf3jJdZYUOs35ntmSpLtXNhO+/MUI2xgT1O/jN/cgxKJ5KaCD/vAsp?=
 =?us-ascii?Q?YflPy0Av8SPXWeIDz/U+J+mAfVHqxUaEDLImfEctTV9ygSsNzpaTJdJcc38D?=
 =?us-ascii?Q?MyGN1sSrkk9Q35YpFFs2pGYJq1JiLuChOfiPyRwHqJi/P+DtshaF4w1Pqjbz?=
 =?us-ascii?Q?75EXrSCvPzuHwmn7N3zAQKBhby5wC8VewyJd8TlaZYZAPUbzvDkEpZx5f2bJ?=
 =?us-ascii?Q?7nR90GYFAwp7c9WM8z8X0QyjoDR3zMiQ5/HM6atrTWx/lAbV/oerkVoZ59DE?=
 =?us-ascii?Q?X7KqIttodfhV8ioAopJs5CHrovcDvrv5DbSxqHinCpJCsBCqcbBEBunv3WPO?=
 =?us-ascii?Q?xBquE5SPJryAntq+vWQ3zaGRLPsAZJZUmYhtlrEDRor2u1gxhstt0TnQ6owC?=
 =?us-ascii?Q?Q5QngH9eIIeQktkQ+/lnoThlvBD2ha/NPxj61fyGlob1r1hqIDWP1j4YrMAy?=
 =?us-ascii?Q?opbZjtFKXOi5HXQBAtDrVq6bs6Amb8RHqb8i1pdujXyTCSVZtsVO/0QC9Hjf?=
 =?us-ascii?Q?tsxHUywIovemhRGB32iYkUDf22XfdXkq4ZTRkGvaHTrOyrsH1W9DZMx2xgYC?=
 =?us-ascii?Q?MN+G9zlNrnOd7L7FrlC8qVmWDaPe+Oz7KDq5YEc4ERmodIKQ3VLa/8A3COel?=
 =?us-ascii?Q?JVemwDZpZDh3FXJQ0roGhDCDppY/Sn0ItijGbQ6JuGxQnmHsKaHmEJcqNVlx?=
 =?us-ascii?Q?xONRZQEhDK15o28Z1M65UHsXxObq9NWmM5CSDVSkmEDkkzsd2piPROuxwttN?=
 =?us-ascii?Q?udPTgWsnw+Km80xVEF6ZZLsrkYmb2PM9vF199Wr8c2I6U25GO0IXcAZ9UA1J?=
 =?us-ascii?Q?pEqbNY1d0A3pKimYducJVh0MRQWIhAPn0YNrT9JmMM0WE0BcEGdzLa9powGd?=
 =?us-ascii?Q?CuHMdRHsb5qpLtIklMd79nJkw6KdqQaBIGaDs9jkxAijXMz1c+aYBhmUCkDF?=
 =?us-ascii?Q?xlKD8P2cuQDY/jP78hZgHxr5FuZ+95TBe9ENgczvAvQ/dHIp8e8ugyiW2hoi?=
 =?us-ascii?Q?BOz842q47DhHoEquTQqB+3o68/N6t6ictixNZkoPE+08JWNBGkd+mFZy6pf0?=
 =?us-ascii?Q?sLqRpDY+cNm8hNQlDsZWBt3G0ZA4g1wo9VCugecf0QYxxJVhx1eyVEwp4RBL?=
 =?us-ascii?Q?TGf6ZJG4LVVTOV+pdKLCNNcmC4FId4SatwaXMyyoCxhYayn9TRAczEBzytQC?=
 =?us-ascii?Q?o3BM1Dujlc5JkwFmifJy855FaA6lRKssuDDs/JWwWhghpEnH+FP/f9mEIwYb?=
 =?us-ascii?Q?XN44K5BI+T7lr1v7mmVeSqTDnkAs/o8wCagQlW+6O2Lfovi0tFuqTmJRIsFl?=
 =?us-ascii?Q?WfzdkBxkbjXyoJd1GnJGqRdfIv/VKi5Dv22oXcAhBlezXoqK76dggXbzRB5y?=
 =?us-ascii?Q?f2onCg5U819usUBcigJ3i4HSpJg+TxIr7shgi8v9V7IftGvY9Mf5Yf9ADsff?=
 =?us-ascii?Q?4lCdnH6jwCWMJobD8GrMW/FRwBsgi/C3/K4leHoVD8zXhbkXOF7EkwaZtc9O?=
 =?us-ascii?Q?NvwxxKs6poU+QxslwAt/BWO1kbOud4eYX3qTnezS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8e66e2-79f7-402b-5e81-08dc78e3c271
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 15:44:39.6136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/TNDr1tHyQSn+pINnOAm7QnzKabc4c0k3skFH5rOMwWREtcclzPdFf6WUSiRpIJZe4un2Rl+UwyT3xS+VtoFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9370

On Mon, May 20, 2024 at 03:09:20PM +0800, Shengjiu Wang wrote:
> Audiomix block control can be a reset controller for
> Enhanced Audio Return Channel (EARC), which is one of
> modules in this audiomix subsystem.
> 
> The reset controller is supported by the auxiliary device
> framework.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/clk/imx/Kconfig               |  1 +
>  drivers/clk/imx/clk-imx8mp-audiomix.c | 61 +++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 6da0fba68225..9edfb030bea9 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -81,6 +81,7 @@ config CLK_IMX8MP
>  	tristate "IMX8MP CCM Clock Driver"
>  	depends on ARCH_MXC || COMPILE_TEST
>  	select MXC_CLK
> +	select AUXILIARY_BUS
>  	help
>  	    Build the driver for i.MX8MP CCM Clock Driver
>  
> diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> index b381d6f784c8..d2eaabe431cd 100644
> --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2022 Marek Vasut <marex@denx.de>
>   */
>  
> +#include <linux/auxiliary_bus.h>
>  #include <linux/clk-provider.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
> @@ -217,6 +218,62 @@ struct clk_imx8mp_audiomix_priv {
>  	struct clk_hw_onecell_data clk_data;
>  };
>  
> +#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
> +
> +static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
> +{
> +	struct auxiliary_device *adev = _adev;
> +
> +	auxiliary_device_delete(adev);
> +	auxiliary_device_uninit(adev);
> +}
> +
> +static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
> +{
> +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> +
> +	kfree(adev);
> +}
> +
> +static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
> +							 struct clk_imx8mp_audiomix_priv *priv)
> +{
> +	struct auxiliary_device *adev;
> +	int ret;
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);


You may use scoped free

	struct auxiliary_device *adev __free(kfree) = kzalloc(sizeof(*adev), GFP_KERNEL);

> +	if (!adev)
> +		return -ENOMEM;
> +
> +	adev->name = "reset";
> +	adev->dev.parent = dev;
> +	adev->dev.release = clk_imx8mp_audiomix_reset_adev_release;
> +
> +	ret = auxiliary_device_init(adev);
> +	if (ret) {
> +		kfree(adev);
> +		return ret;
> +	}

if use scoped free, 

	if (ret)
		return ret;

> +
> +	ret = auxiliary_device_add(adev);
> +	if (ret) {
> +		auxiliary_device_uninit(adev);
> +		kfree(adev);
> +		return ret;

the same here. 

> +	}
> +
> +	return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_unregister_adev, adev);

if use scope free
	return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_unregister_adev, no_free_ptr(adev));

> +}
> +
> +#else /* !CONFIG_RESET_CONTROLLER */
> +
> +static int clk_imx8mp_audiomix_reset_controller_register(struct clk_imx8mp_audiomix_priv *priv)
> +{
> +	return 0;
> +}
> +
> +#endif /* !CONFIG_RESET_CONTROLLER */
> +
>  static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
>  {
>  	struct clk_imx8mp_audiomix_priv *priv = dev_get_drvdata(dev);
> @@ -337,6 +394,10 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_clk_register;
>  
> +	ret = clk_imx8mp_audiomix_reset_controller_register(dev, priv);
> +	if (ret)
> +		goto err_clk_register;
> +
>  	pm_runtime_put_sync(dev);
>  	return 0;
>  
> -- 
> 2.34.1
> 

