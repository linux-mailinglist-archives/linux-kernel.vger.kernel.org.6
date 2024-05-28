Return-Path: <linux-kernel+bounces-192573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0173E8D1F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807301F2176A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF9E170845;
	Tue, 28 May 2024 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AdHfiqMV"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2086.outbound.protection.outlook.com [40.107.7.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6E79F6;
	Tue, 28 May 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907960; cv=fail; b=u2/8UU1k7TNMPMlwyCgQGWW6VsrHSu42iPfF6wa6pbbIkV1bFCshQ49H0vfITMbx5WT7DIMgkxI53RPnGcibb9CSyconjbWznv3jR2Zf0uQiC1rsZma2ln4XxC9BUXGv0RMxJ+YSqMqfqC/132p/JccBg39yKEyWO2Z2Mcmrckk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907960; c=relaxed/simple;
	bh=pqyWkp5Tq0EB4a49pgKsrmTj5280aEQftCX2TCB2MXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X+6XLlobZ06RECAnfmOMoT2YuUwUOnTkZvRgRfOuJzwW75xSNdu3S14v/Ph4ZHdfr5ZerpCl7t4tziXAWwngwovWE/7JOLBmmKTDt3Dp2jbDKjzICZOE7TRBK2OhiQ3iZTPxewNU2zKhLa5cb/vruPpke2GvZmg1u8vtMBqjVXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AdHfiqMV; arc=fail smtp.client-ip=40.107.7.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqgErbEqY+ZMgn71ar4BPAi24Q+DikkQkx34+Y20f+SZmW+7GO87odbGl2WSqFUrpYQK+U9XHIsKind5oicequ+jlTofqAP0ThYeqN4bLH/NA0yBiB4yomQLk83E5Y2c9+bl1I5XAcNiqy3mP5i6C0sWbhfU3dwvDVlO9/H9oFU2JX11PbVKnSXh/k2cGrXKP10Pf/K0zNbPHtbgn5XLmhZRZlHDjJ43PLarskusyqWV7Ji1tKIglkfkJGzWt2ZM7PQkAyTQ6GlQGI3Aqw0h5h0KgQvedW7O7kz5YBvfNNJArSAqF+ANalgEOmyHpWAQUggGsS0YxzTPK8Ejy1rG1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/6ABDYpiS+nNvX6AIcMJZm+AArxjgKYlT1CWaTm0+k=;
 b=awd+d2qrGJljH0hOTYy9TMDNMIyL7mKuwnLL6OG9P0pbiRnefVOtne5V4KbmwpKfq7FL4aJa91PVBRiG25xcIwMd10iYjn9xO6He9QQdG0pGR4/xR748fw7sjTfCP45NSfmgIVccqyiVRoMjOmxB/pjoWb1YLny+uThqkl/ly5AwC+hktSQ1pU9/iw/DAX63Cr2Yd0bFlt+o5HKOPB4adxWdEW9f5xXMwvVqB718bYfqPhu4rDbKzOVgVK3QP/S0PKUCJMI/XQ5XTsc/7qIOYfEIEmxmdd/BqAyGjRjI/4jA/yp/vreWdgvrzrbBypB361w5gRrmeNIWANuJnM3UeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/6ABDYpiS+nNvX6AIcMJZm+AArxjgKYlT1CWaTm0+k=;
 b=AdHfiqMVno5hnoDBEp6A8l1QGtvAF/mpHe4YxXL8XLytkGWKQqEoHfMllTJvPHOY4OYc34clvtIzHBjxi95UzApU1vc0kQRj3In8VegAyv5CkJm2ZHQFzXpLCL8CYrSCa0MyKKbxOZgVVoQMDkaPY9jW1hlKxU8zuadykNwG8fM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6860.eurprd04.prod.outlook.com (2603:10a6:10:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 14:52:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7611.016; Tue, 28 May 2024
 14:52:34 +0000
Date: Tue, 28 May 2024 10:52:26 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: conor@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 2/2] phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY
 driver support
Message-ID: <ZlXvqhlMgUZeYoPk@lizhi-Precision-Tower-5810>
References: <1716865154-25044-1-git-send-email-hongxing.zhu@nxp.com>
 <1716865154-25044-3-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1716865154-25044-3-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a03:505::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 835c836d-6242-4a31-f70c-08dc7f25cebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sOmO66lF5jd+oAFq1NQY1iGjGUc8OE9o4qQRkTjtA6n5ftWDGTP+ef9aMuWb?=
 =?us-ascii?Q?SMrmAvGm9E9qoE7oYHYSbKbrHk/jVYsTabcoMf0zrEkcHu1RlTETqwWVNYdS?=
 =?us-ascii?Q?ATK/bk7D3UsKEEPb3Quf/MZB+C3vepXP9rv3Aa/saJk5xLNVI3YLnSATbrOn?=
 =?us-ascii?Q?7yR1vOWHMf8v8ogOukbUqlOgZitT7PRo/6KpDKBHJ048BDAJbMgAP7of+UEQ?=
 =?us-ascii?Q?2i22+GTmlt+50SS6gUm9uDDFnXJn5rFV+K8PtNqDtlre0EsAvLZ0ErdECsX3?=
 =?us-ascii?Q?O+OzdXJUpXmCQmW45lCTeP3dV+KrbzU21gU58Rbw5VeiSy206FnhOrkGAX7Y?=
 =?us-ascii?Q?DgI9oVxG4fvQRymi5pMvy7vQ5CpBFY7BFd84qIGkeXHd+N49rajr4387j325?=
 =?us-ascii?Q?fsuvIyfJSrc9FTG0AovQv+Xjhz2Lnx4diQdvMjU10WqpHvjfgY5jJbEVPKur?=
 =?us-ascii?Q?6yZKQa+Qzq2YBwg2DtpO1AkYwomkbi+ZhfXh4U866g44GL0dVgnDqkVx+ZMy?=
 =?us-ascii?Q?vLiYrVJdR5wTt+fkU1id+TArEKufrpi7aXIKa9uusaUsLficd+f7R5cL79Hm?=
 =?us-ascii?Q?k9uY/gOJB4cez/dwwUkLfaN29KLSje5BCzUw0rBeoGyhqgkOQuTZW1G+Y+J6?=
 =?us-ascii?Q?msXoudl1D9zEF/GX0koxZfeXYWDfzU7HzvJzR6cGF+GNBKoLgEIA8fY45D79?=
 =?us-ascii?Q?Us+gt2SvE5mFkL+fQ82oukR7zo7JZz9yjoarWWwn2v1HSgPfD+rvdGus6w7P?=
 =?us-ascii?Q?t96ABpfwhCWfZPB/NXtsD600op+Zgfe9tEdr38nvImihe6TQReAWOwNZF7kz?=
 =?us-ascii?Q?smyDSkvt13Arq3QkltY20rTLvEPBnVD54AI/ZF+ohytiZLq3cFL3BXuwdJ2w?=
 =?us-ascii?Q?QgnxWqBuR5I2DRCJj8b6dbel2NNiU8KieLOQzPrknYZCg8jEwllXuL5frz4a?=
 =?us-ascii?Q?XaP3N7NAsTjuzo/6qwfClWEZ6QZ1VWEPKhY2D9mq4YSde8V3Z0s+daqciM/I?=
 =?us-ascii?Q?3/1akuyQW0Xp8KhGPztJy+7+eR+jSiyJ2HKNfq1eQdPhF+Rx1htwJvLZ4GJW?=
 =?us-ascii?Q?6aCPP7ZikF0UV1n4YmxCSSKBX13WA+bz7IKVZCvTiKW6TvCPm5j7kVegCWZZ?=
 =?us-ascii?Q?MVJwL0uOsvTqXI5I0PHfRAqihM36dxgSvOgqfOq7h8vKxIgOJGW3vEZne7ox?=
 =?us-ascii?Q?F+XZpBawuapbMzTs0c9ztLn/zg0XacZYLKtXNeWDBvvS7qZS3r1BT//yPn3J?=
 =?us-ascii?Q?OUqFJzkJUHnIDz0WELi4ambXqp9trarvPYs7Q48olIVfG1+BcCX7AIhRXyPv?=
 =?us-ascii?Q?EN3ZoBSk9/0Cpdf6zphnmxpA1i9P8UNi8ibrejhf0oVJuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TYPR83SV+xGzyA1PHd2LbGEg6FdDGUVt7VlosPLDJ2ftbQncC+xWe00b+Z+D?=
 =?us-ascii?Q?czd3D9ZUXSsjEh4D7mLG4icCvu1+XQvywnvdYnX5WWey4gmigXPHCsLWSZU/?=
 =?us-ascii?Q?sTP58LF5b3lKXHs9RlJCUolDPQQS0eMELb6Ax9Cje6Js8U89uPtNzGOpC+Du?=
 =?us-ascii?Q?sd9VPaqVp5VakinrYfjOE8SYu/vfMR4rolxenbyGZxOLx1HpL27YUnw3F66H?=
 =?us-ascii?Q?4TYVt+x5vQuhe4UIjrHBuixkb4reD7CziSpxRlgtgkC5+2R4Uy15DvZVGOMy?=
 =?us-ascii?Q?DWZvBI31AE99IvihY97wypBD19bRceGxJV6ukpvvfF8CYnZV/E1S1PM4XPiG?=
 =?us-ascii?Q?JM2QT1BiyGBy6dMACakGfSNs4eBsi+q2PpeRkKIa10OcGq1uA5VEImH44S4J?=
 =?us-ascii?Q?9T2efH8PXtd1KqUN91O3qlryQ7NxFLzYgQu6dy+S1jVtdlNRiLeotBp8fIfb?=
 =?us-ascii?Q?z7Eojpz4E8yTa+0pVc4dRm4v6v+XuIHgDfhpyXsg8VdhOd+aeLgg0qULxd1K?=
 =?us-ascii?Q?Hk5Y5p4+r4SiHWqm7+DQZip2UCn630Xo2yJzcb4oQQWfC8CiDvux0oGjJHLg?=
 =?us-ascii?Q?rNdRTkN+aLspjOc9ez5ZB+Ypmcbl3OcYOXk8Ch50pQGPvE8DIUAW9hFXdwJW?=
 =?us-ascii?Q?A0RvitfEno0bEC1AtTkC4hjfzyneQbEr9+B4KRzJHQuPNzNlmCREjeN4BBJ3?=
 =?us-ascii?Q?Jj0mhsmHulezAfsIY5RYKLEKzjCVYtSpk4ZseiJ2BPUZwMQWF3f/560Yi4x9?=
 =?us-ascii?Q?ldm/E0JoVaiEdeIHb8DN3R5XfHKk656xjEbPb7mtuKbxis90PvbRbbXTRobE?=
 =?us-ascii?Q?K3Y/ZEk+qmMXtx5aeBWhmM9sRxg/JlJqO7azMpNGj/ygBbInrO1uCd8RZ8+2?=
 =?us-ascii?Q?asCiWwy0a+XqY3ur2dEPFjh74NBwbNaNhWy3Toqu9inOL1g2JzEy7X1cQuD+?=
 =?us-ascii?Q?Fp3w+TjCe/aHuSYBrEQO+3t0mvmi1C4dnLIw5SiiQF2E4Ea5+q6Dyw3w9Q/o?=
 =?us-ascii?Q?+MlB9RDcHKTzVr5/Vd2t4RX/OoJRpR+j877D47Q+mflp8Js9O7bauaf72qzc?=
 =?us-ascii?Q?jlQpzJLOOiF5n+FRPeC5PZ+z/jQ5H4DPRG42Kc9MCJg1XFMSErF/5Qnt4Rtu?=
 =?us-ascii?Q?1/hU5Bu+Gr0UrXA6z9bYGCPyp2detHa6jTEpwhDrsh6PJ/wKqin0yXAbKOD9?=
 =?us-ascii?Q?yGKi9CIFaJQBNvBGR8zCNlytJTUTltCJcfGbZjusoDcvXd+sDkGkRmUr8mC7?=
 =?us-ascii?Q?udUnqpR6yCtTTbL8zr3WHYQc6m0vIy38vSbizePQTeu08JnNUgq+//FUVBjC?=
 =?us-ascii?Q?GCf20GhRYRNd06p8lW8IWcBizy1zcyBhUcNS7VtgbSGM7M3Dk3OR93Ouzrb6?=
 =?us-ascii?Q?Sx0gAavzGO+5tcLXas/ScNXJq1B9Z71TtQ1UDqK5l5YRl9qe2SsCzjFyQiyP?=
 =?us-ascii?Q?b5PcfttuglYsf/ut5XHs+v/REagnzF6VsopcBLLZtPU3x6hvD1ScZIBYiZHw?=
 =?us-ascii?Q?yzzbQYbPVisRvowJUGBYB0bFBCBKDMoP6skEZGDxN5fozhF6JseBw7qqWF97?=
 =?us-ascii?Q?FLRfbw/tiz87mcHLDQYB0IF1CW2SPm5Q5ElfIoD3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835c836d-6242-4a31-f70c-08dc7f25cebf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 14:52:34.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jJ4KynCewsHZ/nTX9Z2+U/1gzPv8m3GlDBfR7yVENkA4wTjEjpGTxvRxaedyalXk6Vw1QYva/TWoZBuDjcCOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6860

On Tue, May 28, 2024 at 10:59:14AM +0800, Richard Zhu wrote:
> Add i.MX8QM HSIO PHY driver support.
> 
> i.MX8QM HSIO has three lane PHY instances, and can be bound to the
> following controllers in the different use cases listed in below table.
> - two lanes capable PCIEA controller.
> - one lane PCIEB controller.
> - AHCI SATA controller.
> 
> i.MX8QM HSIO PHYs support the following use cases.
> +----------------------------------------------------+
> |                               | Lane0| Lane1| Lane2|
> |-------------------------------|------|------|------|
> | use case 1: PCIEAX2SATA       | PCIEA| PCIEA| SATA |
> |-------------------------------|------|------|------|
> | use case 2: PCIEAX2PCIEB      | PCIEA| PCIEA| PCIEB|
> |-------------------------------|------|------|------|
> | use case 3: PCIEAPCIEBSATA    | PCIEA| PCIEB| SATA |
> +----------------------------------------------------+
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

after fix below two nit.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/phy/freescale/Kconfig               |   8 +
>  drivers/phy/freescale/Makefile              |   1 +
>  drivers/phy/freescale/phy-fsl-imx8qm-hsio.c | 612 ++++++++++++++++++++
>  3 files changed, 621 insertions(+)
>  create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> 
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> index 853958fb2c06..c9ee48aeea9e 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -35,6 +35,14 @@ config PHY_FSL_IMX8M_PCIE
>  	  Enable this to add support for the PCIE PHY as found on
>  	  i.MX8M family of SOCs.
>  
> +config PHY_FSL_IMX8QM_HSIO
> +	tristate "Freescale i.MX8QM HSIO PHY"
> +	depends on OF && HAS_IOMEM
> +	select GENERIC_PHY
> +	help
> +	  Enable this to add support for the HSIO PHY as found on
> +	  i.MX8QM family of SOCs.
> +
>  endif
>  
>  config PHY_FSL_LYNX_28G
> diff --git a/drivers/phy/freescale/Makefile b/drivers/phy/freescale/Makefile
> index cedb328bc4d2..b56b4d5c18ea 100644
> --- a/drivers/phy/freescale/Makefile
> +++ b/drivers/phy/freescale/Makefile
> @@ -3,4 +3,5 @@ obj-$(CONFIG_PHY_FSL_IMX8MQ_USB)	+= phy-fsl-imx8mq-usb.o
>  obj-$(CONFIG_PHY_MIXEL_LVDS_PHY)	+= phy-fsl-imx8qm-lvds-phy.o
>  obj-$(CONFIG_PHY_MIXEL_MIPI_DPHY)	+= phy-fsl-imx8-mipi-dphy.o
>  obj-$(CONFIG_PHY_FSL_IMX8M_PCIE)	+= phy-fsl-imx8m-pcie.o
> +obj-$(CONFIG_PHY_FSL_IMX8QM_HSIO)	+= phy-fsl-imx8qm-hsio.o
>  obj-$(CONFIG_PHY_FSL_LYNX_28G)		+= phy-fsl-lynx-28g.o
> diff --git a/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> new file mode 100644
> index 000000000000..73e0c50fcdae
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-fsl-imx8qm-hsio.c
> @@ -0,0 +1,612 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 NXP
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pci_regs.h>
> +#include <linux/phy/phy.h>
> +#include <linux/phy/pcie.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/phy/phy-imx8-pcie.h>
> +
> +#define MAX_NUM_LANE	3
> +#define LANE_NUM_CLKS	5
> +
> +/* Parameters for the waiting for PCIe PHY PLL to lock */
> +#define PHY_INIT_WAIT_USLEEP_MAX	10
> +#define PHY_INIT_WAIT_TIMEOUT		(1000 * PHY_INIT_WAIT_USLEEP_MAX)
> +
> +/* i.MX8Q HSIO registers */
> +#define HSIO_CTRL0			0x0
> +#define HSIO_APB_RSTN_0			BIT(0)
> +#define HSIO_APB_RSTN_1			BIT(1)
> +#define HSIO_PIPE_RSTN_0_MASK		GENMASK(25, 24)
> +#define HSIO_PIPE_RSTN_1_MASK		GENMASK(27, 26)
> +#define HSIO_MODE_MASK			GENMASK(20, 17)
> +#define HSIO_MODE_PCIE			0x0
> +#define HSIO_MODE_SATA			0x4
> +#define HSIO_DEVICE_TYPE_MASK		GENMASK(27, 24)
> +#define HSIO_EPCS_TXDEEMP		BIT(5)
> +#define HSIO_EPCS_TXDEEMP_SEL		BIT(6)
> +#define HSIO_EPCS_PHYRESET_N		BIT(7)
> +#define HSIO_RESET_N			BIT(12)
> +
> +#define HSIO_IOB_RXENA			BIT(0)
> +#define HSIO_IOB_TXENA			BIT(1)
> +#define HSIO_IOB_A_0_TXOE		BIT(2)
> +#define HSIO_IOB_A_0_M1M0_2		BIT(4)
> +#define HSIO_IOB_A_0_M1M0_MASK		GENMASK(4, 3)
> +#define HSIO_PHYX1_EPCS_SEL		BIT(12)
> +#define HSIO_PCIE_AB_SELECT		BIT(13)
> +
> +#define HSIO_PHY_STS0			0x4
> +#define HSIO_LANE0_TX_PLL_LOCK		BIT(4)
> +#define HSIO_LANE1_TX_PLL_LOCK		BIT(12)
> +
> +#define HSIO_CTRL2			0x8
> +#define HSIO_LTSSM_ENABLE		BIT(4)
> +#define HSIO_BUTTON_RST_N		BIT(21)
> +#define HSIO_PERST_N			BIT(22)
> +#define HSIO_POWER_UP_RST_N		BIT(23)
> +
> +#define HSIO_PCIE_STS0			0xc
> +#define HSIO_PM_REQ_CORE_RST		BIT(19)
> +
> +#define HSIO_REG48_PMA_STATUS		0x30
> +#define HSIO_REG48_PMA_RDY		BIT(7)
> +
> +struct imx_hsio_drvdata {
> +	int lane_num;
> +};
> +
> +struct imx_hsio_lane {
> +	u32 ctrl_index;
> +	u32 ctrl_off;
> +	u32 idx;
> +	u32 phy_off;
> +	u32 phy_type;
> +	const char * const *clk_names;
> +	struct clk_bulk_data clks[LANE_NUM_CLKS];
> +	struct imx_hsio_priv *priv;
> +	struct phy *phy;
> +	enum phy_mode phy_mode;
> +};
> +
> +struct imx_hsio_priv {
> +	void __iomem *base;
> +	struct device *dev;
> +	struct mutex lock;
> +	const char *hsio_cfg;
> +	const char *refclk_pad;
> +	u32 open_cnt;
> +	struct regmap *phy;
> +	struct regmap *ctrl;
> +	struct regmap *misc;
> +	const struct imx_hsio_drvdata *drvdata;
> +	struct imx_hsio_lane lane[MAX_NUM_LANE];
> +};
> +
> +static const char * const lan0_pcie_clks[] = {"apb_pclk0", "pclk0", "ctl0_crr",
> +					      "phy0_crr", "misc_crr"};
> +static const char * const lan1_pciea_clks[] = {"apb_pclk1", "pclk1", "ctl0_crr",
> +					       "phy0_crr", "misc_crr"};
> +static const char * const lan1_pcieb_clks[] = {"apb_pclk1", "pclk1", "ctl1_crr",
> +					       "phy0_crr", "misc_crr"};
> +static const char * const lan2_pcieb_clks[] = {"apb_pclk2", "pclk2", "ctl1_crr",
> +					       "phy1_crr", "misc_crr"};
> +static const char * const lan2_sata_clks[] = {"pclk2", "epcs_tx", "epcs_rx",
> +					      "phy1_crr", "misc_crr"};
> +
> +static const struct regmap_config regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int imx_hsio_init(struct phy *phy)
> +{
> +	int ret, i;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +	struct device *dev = priv->dev;
> +
> +	/* Assign clocks refer to different modes */
> +	switch (lane->phy_type) {
> +	case PHY_TYPE_PCIE:
> +		lane->phy_mode = PHY_MODE_PCIE;
> +		if (lane->ctrl_index == 0) { /* PCIEA */
> +			lane->ctrl_off = 0;
> +			lane->phy_off = 0;
> +
> +			for (i = 0; i < LANE_NUM_CLKS; i++) {
> +				if (lane->idx == 0)
> +					lane->clks[i].id = lan0_pcie_clks[i];
> +				else
> +					lane->clks[i].id = lan1_pciea_clks[i];
> +			}
> +		} else { /* PCIEB */
> +			if (lane->idx == 0) { /* i.MX8QXP */
> +				lane->ctrl_off = 0;
> +				lane->phy_off = 0;
> +			} else {
> +				/*
> +				 * On i.MX8QM, only second or third lane can be
> +				 * bound to PCIEB.
> +				 */
> +				lane->ctrl_off = SZ_64K;
> +				if (lane->idx == 1)
> +					lane->phy_off = 0;
> +				else /* the third lane is bound to PCIEB */
> +					lane->phy_off = SZ_64K;
> +			}
> +
> +			for (i = 0; i < LANE_NUM_CLKS; i++) {
> +				if (lane->idx == 1)
> +					lane->clks[i].id = lan1_pcieb_clks[i];
> +				else if (lane->idx == 2)
> +					lane->clks[i].id = lan2_pcieb_clks[i];
> +				else /* i.MX8QXP only has PCIEB, idx is 0 */
> +					lane->clks[i].id = lan0_pcie_clks[i];
> +			}
> +		}
> +		break;
> +	case PHY_TYPE_SATA:
> +		/* On i.MX8QM, only the third lane can be bound to SATA */
> +		lane->phy_mode = PHY_MODE_SATA;
> +		lane->ctrl_off = SZ_128K;
> +		lane->phy_off = SZ_64K;
> +
> +		for (i = 0; i < LANE_NUM_CLKS; i++)
> +			lane->clks[i].id = lan2_sata_clks[i];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* Fetch clocks and enable them */
> +	ret = devm_clk_bulk_get(dev, LANE_NUM_CLKS, lane->clks);
> +	if (ret)
> +		return ret;
> +	ret = clk_bulk_prepare_enable(LANE_NUM_CLKS, lane->clks);
> +	if (ret)
> +		return ret;
> +
> +	/* allow the clocks to stabilize */
> +	usleep_range(200, 500);
> +	return 0;
> +}
> +
> +static int imx_hsio_exit(struct phy *phy)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +
> +	clk_bulk_disable_unprepare(LANE_NUM_CLKS, lane->clks);
> +
> +	return 0;
> +}
> +
> +static void imx_hsio_pcie_phy_resets(struct phy *phy)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			  HSIO_BUTTON_RST_N);
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			  HSIO_PERST_N);
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			  HSIO_POWER_UP_RST_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			HSIO_BUTTON_RST_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			HSIO_PERST_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			HSIO_POWER_UP_RST_N);
> +
> +	if (lane->idx == 1) {
> +		regmap_set_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +				HSIO_APB_RSTN_1);
> +		regmap_set_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +				HSIO_PIPE_RSTN_1_MASK);
> +	} else {
> +		regmap_set_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +				HSIO_APB_RSTN_0);
> +		regmap_set_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +				HSIO_PIPE_RSTN_0_MASK);
> +	}
> +}
> +
> +static void imx_hsio_sata_phy_resets(struct phy *phy)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	/* clear PHY RST, then set it */
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +			  HSIO_EPCS_PHYRESET_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +			HSIO_EPCS_PHYRESET_N);
> +
> +	/* CTRL RST: SET -> delay 1 us -> CLEAR -> SET */
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0, HSIO_RESET_N);
> +	udelay(1);
> +	regmap_clear_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +			  HSIO_RESET_N);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0, HSIO_RESET_N);
> +}
> +
> +static void imx_hsio_configure_clk_pad(struct phy *phy)
> +{
> +	bool pll = false;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	if (strncmp(priv->refclk_pad, "output", 6) == 0) {
> +		pll = true;
> +		regmap_update_bits(priv->misc, HSIO_CTRL0,
> +				   HSIO_IOB_A_0_TXOE | HSIO_IOB_A_0_M1M0_MASK,
> +				   HSIO_IOB_A_0_TXOE | HSIO_IOB_A_0_M1M0_2);
> +	} else {
> +		regmap_update_bits(priv->misc, HSIO_CTRL0,
> +				   HSIO_IOB_A_0_TXOE | HSIO_IOB_A_0_M1M0_MASK,
> +				   0);
> +	}
> +
> +	regmap_update_bits(priv->misc, HSIO_CTRL0, HSIO_IOB_RXENA,
> +			   pll ? 0 : HSIO_IOB_RXENA);
> +	regmap_update_bits(priv->misc, HSIO_CTRL0, HSIO_IOB_TXENA,
> +			   pll ? HSIO_IOB_TXENA : 0);
> +}
> +
> +static void imx_hsio_pre_set(struct phy *phy)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	if (strncmp(priv->hsio_cfg, "pcieax2pcieb", 10) == 0) {
> +		regmap_set_bits(priv->misc, HSIO_CTRL0, HSIO_PCIE_AB_SELECT);
> +	} else if (strncmp(priv->hsio_cfg, "pcieax2sata", 9) == 0) {
> +		regmap_set_bits(priv->misc, HSIO_CTRL0, HSIO_PHYX1_EPCS_SEL);
> +	} else if (strncmp(priv->hsio_cfg, "pcieapciebsata", 12) == 0) {
> +		regmap_set_bits(priv->misc, HSIO_CTRL0, HSIO_PCIE_AB_SELECT);
> +		regmap_set_bits(priv->misc, HSIO_CTRL0, HSIO_PHYX1_EPCS_SEL);
> +	}
> +
> +	imx_hsio_configure_clk_pad(phy);
> +}
> +
> +static int imx_hsio_pcie_power_on(struct phy *phy)
> +{
> +	int ret;
> +	u32 val, addr, cond;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	imx_hsio_pcie_phy_resets(phy);
> +
> +	/* Toggle apb_pclk to make sure PM_REQ_CORE_RST is cleared. */
> +	clk_disable_unprepare(lane->clks[0].clk);
> +	mdelay(1);
> +	ret = clk_prepare_enable(lane->clks[0].clk);
> +	if (ret) {
> +		dev_err(priv->dev, "unable to enable phy apb_pclk\n");
> +		return ret;
> +	}
> +
> +	addr = lane->ctrl_off + HSIO_PCIE_STS0;
> +	cond = HSIO_PM_REQ_CORE_RST;
> +	ret = regmap_read_poll_timeout(priv->ctrl, addr, val,
> +				       (val & cond) == 0,
> +				       PHY_INIT_WAIT_USLEEP_MAX,
> +				       PHY_INIT_WAIT_TIMEOUT);
> +	if (ret)
> +		dev_err(priv->dev, "HSIO_PM_REQ_CORE_RST is set\n");
> +	return ret;
> +}
> +
> +static int imx_hsio_sata_power_on(struct phy *phy)
> +{
> +	int ret;
> +	u32 val, cond;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	regmap_set_bits(priv->phy, lane->phy_off + HSIO_CTRL0, HSIO_APB_RSTN_0);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +			HSIO_EPCS_TXDEEMP);
> +	regmap_set_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +			HSIO_EPCS_TXDEEMP_SEL);
> +
> +	imx_hsio_sata_phy_resets(phy);
> +
> +	cond = HSIO_REG48_PMA_RDY;
> +	ret = read_poll_timeout(readb, val, ((val & cond) == cond),
> +				PHY_INIT_WAIT_USLEEP_MAX,
> +				PHY_INIT_WAIT_TIMEOUT, false,
> +				priv->base + HSIO_REG48_PMA_STATUS);
> +	if (ret)
> +		dev_err(priv->dev, "PHY calibration is timeout\n");
> +	else
> +		dev_dbg(priv->dev, "PHY calibration is done\n");
> +
> +	return ret;
> +}
> +
> +static int imx_hsio_power_on(struct phy *phy)
> +{
> +	int ret;
> +	u32 val, cond;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	scoped_guard(mutex, &priv->lock) {
> +		if (!priv->open_cnt)
> +			imx_hsio_pre_set(phy);
> +		priv->open_cnt++;
> +	}
> +
> +	if (lane->phy_mode == PHY_MODE_PCIE)
> +		ret = imx_hsio_pcie_power_on(phy);
> +	else /* SATA */
> +		ret = imx_hsio_sata_power_on(phy);
> +	if (ret)
> +		return ret;
> +
> +	/* Polling to check the PHY is ready or not. */
> +	if (lane->idx == 1)
> +		cond = HSIO_LANE1_TX_PLL_LOCK;
> +	else
> +		/*
> +		 * Except the phy_off, the bit-offset of lane2 is same to lane0.
> +		 * Merge the lane0 and lane2 bit-operations together.
> +		 */
> +		cond = HSIO_LANE0_TX_PLL_LOCK;
> +
> +	ret = regmap_read_poll_timeout(priv->phy, lane->phy_off + HSIO_PHY_STS0,
> +				       val, ((val & cond) == cond),
> +				       PHY_INIT_WAIT_USLEEP_MAX,
> +				       PHY_INIT_WAIT_TIMEOUT);
> +	if (ret) {
> +		dev_err(priv->dev, "IMX8Q PHY%d PLL lock timeout\n", lane->idx);
> +		return ret;
> +	}
> +	dev_dbg(priv->dev, "IMX8Q PHY%d PLL is locked\n", lane->idx);
> +
> +	return ret;
> +}
> +
> +static int imx_hsio_power_off(struct phy *phy)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	scoped_guard(mutex, &priv->lock) {
> +		priv->open_cnt--;
> +		if (priv->open_cnt == 0) {
> +			regmap_clear_bits(priv->misc, HSIO_CTRL0,
> +					  HSIO_PCIE_AB_SELECT);
> +			regmap_clear_bits(priv->misc, HSIO_CTRL0,
> +					  HSIO_PHYX1_EPCS_SEL);
> +
> +			if (lane->phy_mode == PHY_MODE_PCIE) {
> +				regmap_clear_bits(priv->ctrl,
> +						  lane->ctrl_off + HSIO_CTRL2,
> +						  HSIO_BUTTON_RST_N);
> +				regmap_clear_bits(priv->ctrl,
> +						  lane->ctrl_off + HSIO_CTRL2,
> +						  HSIO_PERST_N);
> +				regmap_clear_bits(priv->ctrl,
> +						  lane->ctrl_off + HSIO_CTRL2,
> +						  HSIO_POWER_UP_RST_N);
> +			} else {
> +				regmap_clear_bits(priv->ctrl,
> +						  lane->ctrl_off + HSIO_CTRL0,
> +						  HSIO_EPCS_TXDEEMP);
> +				regmap_clear_bits(priv->ctrl,
> +						  lane->ctrl_off + HSIO_CTRL0,
> +						  HSIO_EPCS_TXDEEMP_SEL);
> +				regmap_clear_bits(priv->ctrl,
> +						  lane->ctrl_off + HSIO_CTRL0,
> +						  HSIO_RESET_N);
> +			}
> +
> +			if (lane->idx == 1) {
> +				regmap_clear_bits(priv->phy,
> +						  lane->phy_off + HSIO_CTRL0,
> +						  HSIO_APB_RSTN_1);
> +				regmap_clear_bits(priv->phy,
> +						  lane->phy_off + HSIO_CTRL0,
> +						  HSIO_PIPE_RSTN_1_MASK);
> +			} else {
> +				/*
> +				 * Except the phy_off, the bit-offset of lane2 is same
> +				 * to lane0. Merge the lane0 and lane2 bit-operations
> +				 * together.
> +				 */
> +				regmap_clear_bits(priv->phy,
> +						  lane->phy_off + HSIO_CTRL0,
> +						  HSIO_APB_RSTN_0);
> +				regmap_clear_bits(priv->phy,
> +						  lane->phy_off + HSIO_CTRL0,
> +						  HSIO_PIPE_RSTN_0_MASK);
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx_hsio_set_mode(struct phy *phy, enum phy_mode mode,
> +			     int submode)
> +{
> +	u32 val;
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	if (lane->phy_mode != mode)
> +		return -EINVAL;
> +
> +	val = (mode == PHY_MODE_PCIE) ? HSIO_MODE_PCIE : HSIO_MODE_SATA;
> +	val = FIELD_PREP(HSIO_MODE_MASK, val);
> +	regmap_update_bits(priv->phy, lane->phy_off + HSIO_CTRL0,
> +			   HSIO_MODE_MASK, val);
> +
> +	switch (submode) {
> +	case PHY_MODE_PCIE_RC:
> +		val = FIELD_PREP(HSIO_DEVICE_TYPE_MASK, PCI_EXP_TYPE_ROOT_PORT);
> +		break;
> +	case PHY_MODE_PCIE_EP:
> +		val = FIELD_PREP(HSIO_DEVICE_TYPE_MASK, PCI_EXP_TYPE_ENDPOINT);
> +		break;
> +	default: /* Support only PCIe EP and RC now. */
> +		return 0;
> +	}
> +	if (submode)
> +		regmap_update_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL0,
> +				   HSIO_DEVICE_TYPE_MASK, val);
> +
> +	return 0;
> +}
> +
> +static int imx_hsio_set_speed(struct phy *phy, int speed)
> +{
> +	struct imx_hsio_lane *lane = phy_get_drvdata(phy);
> +	struct imx_hsio_priv *priv = lane->priv;
> +
> +	regmap_update_bits(priv->ctrl, lane->ctrl_off + HSIO_CTRL2,
> +			   HSIO_LTSSM_ENABLE,
> +			   speed ? HSIO_LTSSM_ENABLE : 0);
> +	return 0;
> +}
> +
> +static const struct phy_ops imx_hsio_ops = {
> +	.init = imx_hsio_init,
> +	.exit = imx_hsio_exit,
> +	.power_on = imx_hsio_power_on,
> +	.power_off = imx_hsio_power_off,
> +	.set_mode = imx_hsio_set_mode,
> +	.set_speed = imx_hsio_set_speed,
> +	.owner = THIS_MODULE,
> +};
> +
> +static const struct imx_hsio_drvdata imx8qxp_hsio_drvdata = {
> +	.lane_num = 0x1,
> +};
> +
> +static const struct imx_hsio_drvdata imx_hsio_drvdata = {

nit: imx8qm_hsio_drvdata looks better name.

> +	.lane_num = 0x3,
> +};
> +
> +static const struct of_device_id imx_hsio_of_match[] = {
> +	{.compatible = "fsl,imx8qm-hsio", .data = &imx_hsio_drvdata},
> +	{.compatible = "fsl,imx8qxp-hsio", .data = &imx8qxp_hsio_drvdata},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, imx_hsio_of_match);
> +
> +static struct phy *imx_hsio_xlate(struct device *dev,
> +				  const struct of_phandle_args *args)
> +{
> +	struct imx_hsio_priv *priv = dev_get_drvdata(dev);
> +	int idx = args->args[0];
> +	int phy_type = args->args[1];
> +	int ctrl_index = args->args[2];
> +
> +	if (idx < 0 || idx >= priv->drvdata->lane_num)
> +		return ERR_PTR(-EINVAL);
> +	priv->lane[idx].idx = idx;
> +	priv->lane[idx].phy_type = phy_type;
> +	priv->lane[idx].ctrl_index = ctrl_index;
> +
> +	return priv->lane[idx].phy;
> +}
> +
> +static int imx_hsio_probe(struct platform_device *pdev)
> +{
> +	int i;
> +	void __iomem *off;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct imx_hsio_priv *priv;
> +	struct phy_provider *provider;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &pdev->dev;
> +	priv->drvdata = of_device_get_match_data(dev);
> +
> +	/* Get HSIO configuration mode */
> +	if (of_property_read_string(np, "fsl,hsio-cfg", &priv->hsio_cfg))
> +		priv->hsio_cfg = "pcieapciebsata";
> +	/* Get PHY refclk pad mode */
> +	if (of_property_read_string(np, "fsl,refclk-pad-mode",
> +				    &priv->refclk_pad))
> +		priv->refclk_pad = NULL;
> +
> +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "phy");
> +	priv->phy = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->phy))
> +		return dev_err_probe(dev, PTR_ERR(priv->phy),
> +				     "unable to find phy csr registers\n");
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "ctrl");
> +	priv->ctrl = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->ctrl))
> +		return dev_err_probe(dev, PTR_ERR(priv->ctrl),
> +				     "unable to find ctrl csr registers\n");
> +
> +	off = devm_platform_ioremap_resource_byname(pdev, "misc");
> +	priv->misc = devm_regmap_init_mmio(dev, off, &regmap_config);
> +	if (IS_ERR(priv->misc))
> +		return dev_err_probe(dev, PTR_ERR(priv->misc),
> +				     "unable to find misc csr registers\n");
> +
> +	for (i = 0; i < priv->drvdata->lane_num; i++) {
> +		struct imx_hsio_lane *lane = &priv->lane[i];
> +		struct phy *phy;
> +
> +		memset(lane, 0, sizeof(*lane));

nit: not neccessary to call memset, because devm_kzalloc() already init
everything to 0

> +
> +		phy = devm_phy_create(&pdev->dev, NULL, &imx_hsio_ops);
> +		if (IS_ERR(phy))
> +			return PTR_ERR(phy);
> +
> +		lane->priv = priv;
> +		lane->phy = phy;
> +		lane->idx = i;
> +		phy_set_drvdata(phy, lane);
> +	}
> +
> +	dev_set_drvdata(dev, priv);
> +	dev_set_drvdata(&pdev->dev, priv);
> +
> +	provider = devm_of_phy_provider_register(&pdev->dev, imx_hsio_xlate);
> +
> +	return PTR_ERR_OR_ZERO(provider);
> +}
> +
> +static struct platform_driver imx_hsio_driver = {
> +	.probe	= imx_hsio_probe,
> +	.driver = {
> +		.name	= "imx8qm-hsio-phy",
> +		.of_match_table	= imx_hsio_of_match,
> +	}
> +};
> +module_platform_driver(imx_hsio_driver);
> +
> +MODULE_DESCRIPTION("FSL IMX8QM HSIO SERDES PHY driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.37.1
> 

