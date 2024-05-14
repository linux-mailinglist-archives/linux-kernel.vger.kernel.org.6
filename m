Return-Path: <linux-kernel+bounces-178799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCE38C57D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B131C21A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E232145324;
	Tue, 14 May 2024 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AzvpNVx3"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0818F144D0B;
	Tue, 14 May 2024 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696626; cv=fail; b=ql1PHCkP1Q95rpQAgu88QmI5hzaLaTuMjSLpwuFZxC15BZue6bAKlq9Niuvx8xt2U3AOFgdWvzYU+KXQkQ5YGWMglSOt8Z218scl7AToR3FU2NmGTGioLJ1E61Q1nB4wuDHR5pJ2RkxXeQz/YJEr9VnSLpowPf5UH9VB4wh3eME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696626; c=relaxed/simple;
	bh=4v7lytVq53WcFe/DLMsEVvdqUJnVppPLLVvPdkpP/YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b/93la+dUsoQznpDda8waV3S3ITJSMB/y+gY+9pcec72j+wCDWYYM6g4p02mU2V6/HLQ9x70cgT3wY1UbBuVW47ER4DUhLh5pv/CDJgITTGcXu2P1n30GqwcCkOQe7evU6NCVeFpWNhYmoLc0qxU90ga01UqIHR+IGlOJxkzN2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AzvpNVx3; arc=fail smtp.client-ip=40.107.20.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XODPu4rjB+IzXM16ldngvYckqCoeJtcWKv/xGWL9+VjA0YPNT8DbExzjPqVDVMryXZKseajDIfpqYrjycUPb3Mp4O8us1Ad7u16ihJYLiK7K/o8VW5CVCDNtfeT90FzO/d+RM/ooVxw2jJl80onZR6lnBYdxY945EbFAl/x2J17DljU66IgGMTU64TeaJ58gYN7++zZJnyLu44gUQcNlC9GBPrUaE3N5JEPZewDsnQpREvrpJ6EOuoVSACKr1DQQqfs+LZigxyY1lj191ACQ37PmC8gMMCYvtq3xZA9MYGyTzVhtZeJQjHvPlF1NML3XOtI4YyE8nWEqdebJj9TwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Dwky9VEwH6xFQ7OpL/NOaH8vNh8+HedrvgeV3ghh5M=;
 b=AU7UbWANnwL7RuJwyQ4TB8+qbUvzluV8v/G5aff4Ykb6VAyqlcfx/KWz8liu1nY8DIl+swFcIeHRV3R8iywTUnu+rCzh497RlsKsNuvxInZY8XThqsiZXyqoyNO5g/85XNq7BNjSqZe4dKKQxz6IhTCKFwkLT3xf5gCdafd2O6By5jJ4p2YP+QIXsTbTs7bvcMMMlF0sPLIVDwCsCfURoXz+jncF+hZiRjkwmjCq17qzuJC0xyB0NxCS0RM4ZBSXnuEyDWvuTi5or+DWqvEIk0t7Ex6tVDywAb8fpadax4SzQONaSUuBJqfPqpFJd6k1aEkkS5x5dDB60fADXBurpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dwky9VEwH6xFQ7OpL/NOaH8vNh8+HedrvgeV3ghh5M=;
 b=AzvpNVx3bd4B6DEXbIWYUgc3FkSmuCiuPH4CHtaZMguDbAnfSHCL6AxH4pwbAoxzHIlgMRJcUvOAet6n0xixPnNFc64uhwX3MY+rgUxJPgI+GAa8TiWY3X0hhFu8IOdLV3hmQeX3fAF2rzG2HwZFjtcx3w6qI++IBuDD7SSCgrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB6853.eurprd04.prod.outlook.com (2603:10a6:20b:107::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 14:23:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 14:23:41 +0000
Date: Tue, 14 May 2024 10:23:29 -0400
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
Subject: Re: [PATCH v3 2/6] reset: imx8mp-audiomix: Add AudioMix Block
 Control reset driver
Message-ID: <ZkNz4ZJ772mlScoj@lizhi-Precision-Tower-5810>
References: <1715679210-9588-1-git-send-email-shengjiu.wang@nxp.com>
 <1715679210-9588-3-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715679210-9588-3-git-send-email-shengjiu.wang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: fa44b5bc-a600-46f4-dcbf-08dc742173fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|376005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZXITOvEH+6vLnrdvtabpmvkVAIouu5UkCc69934U7TpE4nK4BmbgQqMR5G3F?=
 =?us-ascii?Q?o58wUJLF3RjPlDbq5QskdGrMBiDOuMyHdD5BXzPoKmiX52JPOuFczpwoOL/I?=
 =?us-ascii?Q?xpfXnc4qZ8ys1GFeD13Iwd7mSVY4+tth6cp5pjawkTkJIOzRS1Ua4/5J/H8L?=
 =?us-ascii?Q?FC7F+q86ba1pWa8E3wZslEi5bqxzaub/ta0UQm8vM1lvc/NvdMvfKWlhEhWr?=
 =?us-ascii?Q?xWRFTXbTS48S494Bb8he52p6etX2EKCGQgvoRvgD+6KTzyEHrbOrh3/cxJWE?=
 =?us-ascii?Q?5H0Z8NSKjlpvjaA5fTTg5RxQNSXwK6e6jFNLEQvj7wRVfAQndpmBrKrC2agH?=
 =?us-ascii?Q?5ljmlLlDX4LX7MTUxP7vXoODI1tCIBgw3cKNsFIGKyUyGfRtCBgLqjSNcJ9u?=
 =?us-ascii?Q?aEYaC+8lXEL/rXk4BbCe+yNiOdWw/755IeepZecMJzP3xly/DaYYG6WGqJ5o?=
 =?us-ascii?Q?zr1FcRmQoJnkC0arOmAYnDQpjmSS/6EmTdRGrU7hPIvJuSKGojbvRBqX7qZz?=
 =?us-ascii?Q?GbnuV7aGVmHG0eRPNwXYLrun3uHkWfeYW+TW1Gib0+GGRHsJknpp2xpfBqft?=
 =?us-ascii?Q?JRLZGhtjGXmrnKoipPcuOh+znlngwZoyQObT/WB1qxeQhj7JbWO7zntrXH4R?=
 =?us-ascii?Q?I903W/ZdzenRgPoQ0IxJwLO9AtsbcBd2it4WYFiRY7sXvZ2d5RNKwFQswloJ?=
 =?us-ascii?Q?QRNA/6NfPZIgeyNCMeQ+nok64cxi/4yzKgNJL0isJmHEab+WIrXbzPJ0zxEa?=
 =?us-ascii?Q?aChOQrmsylIBC9Uv0+m69kHngEosI/oe7J/4cX2yR7UOr6B7mElZMXBYrpJZ?=
 =?us-ascii?Q?XLKlo0ktHYpb3z89QzrNT+uELR2fVlZxv2aP/xgrKGqQuNXUsG79GcDItb8z?=
 =?us-ascii?Q?cqGsUPpbVV148M3sBxHmk4rlQJnbTkyzlbio5f5sxCkOVfYvFEEEJNC10GOs?=
 =?us-ascii?Q?pqLMpBxIXR7eddvRV4BqVxI5A6PgwQeTKM9ZOfCJT7MBxHMXu4QXuXm+IuyQ?=
 =?us-ascii?Q?70JHhWLMmtkQ1oIeLPHL3CntdIPJNML/bvs88sakEUFgHYMIOZVT5OCVZe8C?=
 =?us-ascii?Q?oJ06nmVGjnKmQw4AeUQsv6Ywb0RwDD6CZjbavJ78VA2O5swmInOrZA3IL9Mg?=
 =?us-ascii?Q?Kt/oIVAkwW1hJHaHNU4BuKSTVCx2ziIZ0ZRtvanH6GLWsWnumN6v9WiASi/4?=
 =?us-ascii?Q?LpXtaHxNyyGo+L7Q7Gueapgyq5wXnPD8OHsZHOqvI13i1kCHvO/OGy+p379X?=
 =?us-ascii?Q?y6lqlxLoiu1fWV3r/jnecsZyf55i9vkOeZAGQmHY/TLZFm/j6XU2rAUJ1ptD?=
 =?us-ascii?Q?tbRpZ9bmLewCIq9RoUFFr7uJIpSym34ASSJ9Hj2ECYkr/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+DPgukLXdAFBqTqsG6Lp0GUbFtP42Julub+/jbUe7zx5bcaX73b3XROxSgV1?=
 =?us-ascii?Q?+AFpxzj6b6bY/bJkhlehwaH1YVxyIozXAVu7mILnCfVjJM2UME9NoS3TgKRZ?=
 =?us-ascii?Q?wBvs3l8rNfUlSFfZXCZKSZKX53CPHW0QnORmfDrv5CWDbSenMDn/2/UtZSfD?=
 =?us-ascii?Q?rsFQx4FOawTdkXAULOWebNUFnwCdTLltz2e5pm3juvTBC7DiWm2qHMM59wef?=
 =?us-ascii?Q?ID7ZQrDs1jmHugNQ05V2OLJ6vP3n7fGbNC7WDbN6JUahlLYm9nBfnN4iN115?=
 =?us-ascii?Q?94JXL4u9Vk/LBaCjJM1FdEJoF0ItHAvkWyR51nDcxGxk2grvxqe8pTCPQMEA?=
 =?us-ascii?Q?znYjmikmXXPA6Fb1YFk7TGgxn5N0OjJD91LXb/e2N6CBnTzqRYBNTVmLHBUt?=
 =?us-ascii?Q?UGRG8TGRCdJaC7aI6p3TzPNxFr/A+hZ5viQqRuAwN5fOVR8vli6KGs4daNU0?=
 =?us-ascii?Q?B08Ici+ATfI2zMBHkC4ci4NdBZdcM0D4dVHFTl7sJ2CmYps+o/noMjKZ8s+Y?=
 =?us-ascii?Q?uFBRmGv530eByDANzFUZYenQGqgMn5Ws2OaZXzQaO8FiJTWjSyAJHn1HbXFk?=
 =?us-ascii?Q?XQAhM0/GNYY9jEXWid6vH2n5RrmyoKPKFVSR3Ir5b5rPc1aD6HSQe+t764tL?=
 =?us-ascii?Q?NLDw6pC8+D/xgG53RBUCUpQiduOJk0OnSqbGclFUeXLkSucKIJ1eHY/mIMnP?=
 =?us-ascii?Q?jwLxYYC55asDL29EkIDbjEhz1oQ5uCPQMsqUDC8LQlv59bCTfSGnJbYYe0JO?=
 =?us-ascii?Q?CAU7iTGuEH6wEbkA1XQQRpmS4+26zprERlTKlQpGlVlQqV4LBj+XxbnWmULk?=
 =?us-ascii?Q?bHecSFh4Ffq7/Za3j0jML+EmE4masOE37ErCcPAeAeC80LJCdXsLvwoA/4aA?=
 =?us-ascii?Q?Vh90y3rjSEcuLD+HIlSPrs0zuAA4CuNkEt7pANbhbv5qRdfoxkdDblP67Xhe?=
 =?us-ascii?Q?pqFJPsTL7ALQqsqIfjQv7S2stob2TWGPcS9/He4OcZQl/VE6ymG4UF9f5fxu?=
 =?us-ascii?Q?4Tm2c4Wd4sIz6rLixWGDIY3fSNN3fZxgpQGkS6ckSnrlfRVXhxsoA8e2+CnI?=
 =?us-ascii?Q?YTvdBTY57e96lX7Pyvg5yNoQhMtlM/yG0NVbg7ybSm6ofe4/XWUJKjRztCF5?=
 =?us-ascii?Q?gUHREMxvn3wp6Pu/0fiGGJRg5bybO7pOJaFsElI8e3K5TPWVXOPFv93O9f/l?=
 =?us-ascii?Q?deOtQGo2F6P8z3deGdFhzyL6ElBuzsSH22gZVs4GBIPrJgyeIiJclrjlOvmH?=
 =?us-ascii?Q?i1KiIlh9eA55zWdXuLwwrDh7hSYfA2mYIvaZ+zVUQWoBZEfc0zAGsH2WoLkw?=
 =?us-ascii?Q?TTlfLyw82lnabviWzSKkoG54yrGa0z/Z1bah94UMjfwqwT/hLezZogy8Bidg?=
 =?us-ascii?Q?+PFctLcqkXNO5Qb+NV5AxaLK9qFJCG+ZECTnZLcQuMmuPOXjRH7TBa+G/2gT?=
 =?us-ascii?Q?geY4G8/W+ID7io0abRISazKs+zuY8agesTWCy0RLQaS7FM5XQniCjojEzjGF?=
 =?us-ascii?Q?5vyecWSFEZhQmaCeG6ZEVPAjdHG9poeJDARGDjWhvO9cAZvINN0UmQPl7k6I?=
 =?us-ascii?Q?eag0fHHgHss0CIma7OgHpC2bhA2OKMuGr/hSB0zT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa44b5bc-a600-46f4-dcbf-08dc742173fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 14:23:41.0120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9NNSVFG3Yy4C/4m+HmGGRZWNmkpcCAQh23GRYw26G4mE5XKNW9LacbwKk9Hcqf4vhQ0CWKtedP+Ew1fTiNNPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6853

On Tue, May 14, 2024 at 05:33:26PM +0800, Shengjiu Wang wrote:
> Audiomix block control can be a reset controller for
> Enhanced Audio Return Channel (EARC), which is one of
> modules in this audiomix subsystem.
> 
> The EARC PHY software reset and EARC controller software
> reset need to be supported.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  drivers/reset/Kconfig                 |   8 ++
>  drivers/reset/Makefile                |   1 +
>  drivers/reset/reset-imx8mp-audiomix.c | 117 ++++++++++++++++++++++++++

It is just some bit change. Can you reuse reset-ti-syscon.c ? 

Frank

>  3 files changed, 126 insertions(+)
>  create mode 100644 drivers/reset/reset-imx8mp-audiomix.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 7112f5932609..0e7da0bb0a21 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -91,6 +91,14 @@ config RESET_IMX7
>  	help
>  	  This enables the reset controller driver for i.MX7 SoCs.
>  
> +config RESET_IMX8MP_AUDIOMIX
> +	tristate "i.MX8MP AudioMix Reset Driver"
> +	depends on HAS_IOMEM
> +	depends on (ARM64 && ARCH_MXC) || COMPILE_TEST
> +	select MFD_SYSCON
> +	help
> +	  This enables the reset controller driver for i.MX8MP AudioMix.
> +
>  config RESET_INTEL_GW
>  	bool "Intel Reset Controller Driver"
>  	depends on X86 || COMPILE_TEST
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index fd8b49fa46fc..a6796e83900b 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
>  obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
>  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> +obj-$(CONFIG_RESET_IMX8MP_AUDIOMIX) += reset-imx8mp-audiomix.o
>  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
>  obj-$(CONFIG_RESET_K210) += reset-k210.o
>  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> new file mode 100644
> index 000000000000..8ba0d4406b36
> --- /dev/null
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +
> +#define EARC			0x200
> +#define EARC_RESET_MASK		0x3
> +
> +struct imx8mp_audiomix_rst_priv {
> +	struct regmap *regmap;
> +	struct reset_controller_dev rcdev;
> +};
> +
> +static int imx8mp_audiomix_reset_set(struct reset_controller_dev *rcdev,
> +				     unsigned long id, bool assert)
> +{
> +	struct imx8mp_audiomix_rst_priv *priv = container_of(rcdev,
> +				struct imx8mp_audiomix_rst_priv, rcdev);
> +	unsigned int mask = BIT(id);
> +
> +	/* bit = 0 reset, bit = 1 unreset */
> +	if (assert)
> +		regmap_update_bits(priv->regmap, EARC, mask, 0);
> +	else
> +		regmap_update_bits(priv->regmap, EARC, mask, mask);
> +
> +	return 0;
> +}
> +
> +static int imx8mp_audiomix_reset_reset(struct reset_controller_dev *rcdev,
> +				       unsigned long id)
> +{
> +	imx8mp_audiomix_reset_set(rcdev, id, true);
> +
> +	return imx8mp_audiomix_reset_set(rcdev, id, false);
> +}
> +
> +static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
> +					unsigned long id)
> +{
> +	return imx8mp_audiomix_reset_set(rcdev, id, true);
> +}
> +
> +static int imx8mp_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
> +					  unsigned long id)
> +{
> +	return imx8mp_audiomix_reset_set(rcdev, id, false);
> +}
> +
> +static int imx8mp_audiomix_reset_xlate(struct reset_controller_dev *rcdev,
> +				       const struct of_phandle_args *reset_spec)
> +{
> +	unsigned long id = reset_spec->args[0];
> +
> +	if (!(BIT(id) & EARC_RESET_MASK))
> +		return -EINVAL;
> +
> +	return id;
> +}
> +
> +static const struct reset_control_ops imx8mp_audiomix_reset_ops = {
> +	.reset = imx8mp_audiomix_reset_reset,
> +	.assert = imx8mp_audiomix_reset_assert,
> +	.deassert = imx8mp_audiomix_reset_deassert,
> +};
> +
> +static int imx8mp_audiomix_reset_probe(struct platform_device *pdev)
> +{
> +	struct device_node *parent_np = of_get_parent(pdev->dev.of_node);
> +	struct imx8mp_audiomix_rst_priv *priv;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->regmap = syscon_node_to_regmap(parent_np);
> +	of_node_put(parent_np);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->rcdev.owner     = THIS_MODULE;
> +	priv->rcdev.nr_resets = fls(EARC_RESET_MASK);
> +	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
> +	priv->rcdev.of_node   = pdev->dev.of_node;
> +	priv->rcdev.dev	      = &pdev->dev;
> +	priv->rcdev.of_reset_n_cells = 1;
> +	priv->rcdev.of_xlate  = imx8mp_audiomix_reset_xlate;
> +
> +	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
> +}
> +
> +static const struct of_device_id imx8mp_audiomix_reset_dt_match[] = {
> +	{ .compatible = "fsl,imx8mp-audiomix-reset" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx8mp_audiomix_reset_dt_match);
> +
> +static struct platform_driver imx8mp_audiomix_reset_driver = {
> +	.probe	= imx8mp_audiomix_reset_probe,
> +	.driver	= {
> +		.name = "imx8mp-audiomix-reset",
> +		.of_match_table = imx8mp_audiomix_reset_dt_match,
> +	},
> +};
> +module_platform_driver(imx8mp_audiomix_reset_driver);
> +
> +MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
> +MODULE_DESCRIPTION("Freescale i.MX8MP Audio Block Controller reset driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

