Return-Path: <linux-kernel+bounces-195626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C020C8D4F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33401C23498
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F373D2032B;
	Thu, 30 May 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GWP2dobI"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2064.outbound.protection.outlook.com [40.107.6.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439BD1F94C;
	Thu, 30 May 2024 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084430; cv=fail; b=OdaVx9yXsXhjzVpM6irV+yQMLg6wzSyf6tXlfdJND7aHjoUwUcCnNRRqMyPWKlF3ezXUsD9ZP3+wAUk4PW2IrjwMrWw5NOaruqyMGHsZuN+/Bk0CmYJuiDWoiz/suyQAbju4yNvoPuyp2AM9bAUDPYNDtOb0fxZ6cMXAeI3a9dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084430; c=relaxed/simple;
	bh=3XnOY2xaBKdKdBFa39nO34QaiAHSxPXvbBu2F5VXnvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m1Gu1F9Xqymvu+0my9MRs/5aUWF5ZTTJ8X7jop+6M4mvqevO1iMt49oMy7at7Z0HlDUEuArtOjaHut6RpggpvnbV7D3aH4D9k2pjDPWtwxNehQQXZ6UA386ri1tij7Td8RMrlBNkBM37Ug3yuZcI5OSp/Gs9A56dbV8/w9rqpPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GWP2dobI; arc=fail smtp.client-ip=40.107.6.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfECGlppZpDmoaObOAJEccvTgtsmgQI/gukCzIwM3SQdYAV1uP9FWh49+51FEOwbnbP4sq5QaE14M0laxP069Vy45f3FSaJnxB1usDMnf9tUZCDjR/rXcFqls8tEMWyN60opMmnYrnXOyFQ8EBAgFRZY4+Ki9hEC0YG7fhJMeDcA6aHXB2HC08WjGAjmGECFstMPmefl7J17MYiF7AS4Xv3O05ae2PZ0I/U0c8NWP6lCU9GGT018Xq9cOZbXw6dwOy3oOGVZj8N33kVdnTgDX5h/WfylUDKKgPWgcRmuFkoK1rs+nrdG9z41txYxK6DSiW32immDo1LC5x8H0bTy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D3088++fLuPxjFaA/xdrJVvMbNlD5ML66JdlzqBOsI=;
 b=KhmUfcRnq7FeANWSlNZoxU8NCzcRXABjYOru4CkxJjXl0lUUGaWEPrjAZWFFXNLPYD94JswVlSmVm9monzLsMswX/WnQk+qPZkx0uQ0JLQmKz0TYwRX+xTE1QGyP+4f4ZuXZpVIrQyKqi9PkZ2L1lsCxDgSY4Gr99b3b1S0u6mybZ1OwDbkvDFrn7vOJvIIh+NwtJW/4kZK3s21VBQr/ZCxqRD/t4VOulbEFZw0rzaTwxD5cP0MXgaWWgBjwIPVxnbZFmIsD5o+PpeDgcbcNpDQGR1IEk67W4usb9m3YPBbr7W7dt5gPZE7UU1pNyAZHj+URneWa16cVP5yATElU0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D3088++fLuPxjFaA/xdrJVvMbNlD5ML66JdlzqBOsI=;
 b=GWP2dobIB8o94xqOZVbPrnQZ6cBea6wcHy6Bi0ezCT3dXbkNPjJlUzWTjxk+tZz2amVj/z1dFgxVh/nc0K3mdcS72xUZWsIONCbrR5oSKExez4hSUTNt5KnKyVYMwfnCmXKQCgrK6w9nDdrzewpx+Xz6L2+Xx10Rbv7jJSeWWHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 15:53:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 15:53:44 +0000
Date: Thu, 30 May 2024 11:53:33 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, p.zabel@pengutronix.de,
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, marex@denx.de,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH v6 3/5] reset: imx-aux: Add i.MX auxiliary reset driver
Message-ID: <Zlig/Z7u4nxvKLoQ@lizhi-Precision-Tower-5810>
References: <1717036278-3515-1-git-send-email-shengjiu.wang@nxp.com>
 <1717036278-3515-4-git-send-email-shengjiu.wang@nxp.com>
 <20240530090558.53reobf2zea22oi2@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530090558.53reobf2zea22oi2@pengutronix.de>
X-ClientProxiedBy: BY5PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea0168b-1ebf-4907-8570-08dc80c0af83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|52116005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?blaGuisN/7XCvh77NjAs+InWCBhcVgNuHJrvXs/xExJJInetquSEJWQrpiiv?=
 =?us-ascii?Q?cm3f95uoEtjsdQOBLoy7YFPIvioUGzaOA/RH9LfsTkmAMjksC60PdWXN3VBG?=
 =?us-ascii?Q?r5L1bjDym3cxWmhr4p813VPiByQUaQLOLJC3pS9/mVUkX5U++DzNmRRZPZrl?=
 =?us-ascii?Q?7YG9iM22BFwoGqtvOcNTF8/Rh7pzWN72ubRO/jxsdvIAkLjwh5NsNlPQZP0k?=
 =?us-ascii?Q?5CZMeEpY9K8XZVOARzSlNbSfTQwJgHGyEc2PBYcVNbgyvvqKVf/0N/BWbUbQ?=
 =?us-ascii?Q?A8k9JpFbBJWUwaHq3ZOgR/tv8MlXCLK9rcuf0YMZKGScM/LPmoOXvBxxaXde?=
 =?us-ascii?Q?eycSKJ3jqjT4tLaDH7sUyerEQv/LQ0uq8sx9jVQ22wE4iYCZAvIlEPcAhpr6?=
 =?us-ascii?Q?KDb2r/x6Bd8pi0L2EC0V46oBKGAeRWu26+qJa6iupCiBRpTMULGEcpOVkmd2?=
 =?us-ascii?Q?lIpWM5aOWM+1Gv0vq440CxPl7pVSst41OUy/Q5EATLsx5k+a/1G3kfmBjXrB?=
 =?us-ascii?Q?1VQfR9wX8affuPl+g0/48QPfYfvPDfLaX3uAeB4OyDF13ku9Z9IOsasPsa29?=
 =?us-ascii?Q?kKbbKsN+DS154GVxTV/ll+ad6JhpHccVSWkQo6Y5TxQDuGQgAEwfdmzR2Yu2?=
 =?us-ascii?Q?QJxckXxXkDKUKqlVzU/b26pr54+FMAiInNPB3Rdl+88Kg+BT8iR/9HddBicI?=
 =?us-ascii?Q?xm4ufDZ8cYwjUQW9BrWUc8ubECrDOoB6ZvTuBgA344CcZp5/HOxPRtI3MAVR?=
 =?us-ascii?Q?iK8HBN1jUzJ4yYejBxR8urLY3ZcQywX60f0MOcmHie5FA4aGP9+lJ3Dk/HA1?=
 =?us-ascii?Q?ZDl1t/vjAwCSOctRagKJ3BNWUOmpVYYPvpmtByUV4GTcVssMNRh6IZ3vjNQk?=
 =?us-ascii?Q?Rb/ZKkTEPmsrrc/FzDGMIdzjecjNvKHb0ZskzgrjJ8SAmhr2l3SuWnAmWBaO?=
 =?us-ascii?Q?tfly+j7owEG84w0CKMrE14m33zHu7xS8JTj4JDZQEijp3fM5TbqZbCMWCPE+?=
 =?us-ascii?Q?apGi2YK7X0uEhNM65/+sHWUTigNT7C1pSFZSgquEfsyZHSnCDmhSsO1aTj11?=
 =?us-ascii?Q?MGdu/6MgcVTZl4/0ykIz/GOxI+mPbaSWzIz55gfG22kaAng4sBJJmiCKUSAZ?=
 =?us-ascii?Q?Ew6z3X29dH4D3sD/3fF0WvBqkNy7G5qN+U54jPcR8dhpomNZqbU2Uk59rXld?=
 =?us-ascii?Q?EbCYnjP674gdzvQFHO2X0AjfsZUADEcKJRQX6Apoo0PdCkD9stlihBa0Tf9U?=
 =?us-ascii?Q?UihxIZ32YMQibL29USJZoqrMG+dG0RLHsNiJPfL/Dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CVWi2Nl5OgsmaPPBEnHJj8mbSDd8o7UZjHZiZlm4mVQBrYtplV7rggwYSkuc?=
 =?us-ascii?Q?4KuuRuWxC8JnEVD8P+wFOQYrSgfw3E0/Gf0rN5leetKELcAzQjS1080lj/U2?=
 =?us-ascii?Q?OmEI3ZKEMW36TmmBmmOkGuhbiSDgjUeK/CpFjdVPj3dWm8q6tcCS7CX4/5AQ?=
 =?us-ascii?Q?xdJwyW0oREO/iB2PLaO3TvsYAKF4a0nPb0My7FWNg1o8LY7sGMquw7EonyH0?=
 =?us-ascii?Q?4QgqunRcOm3n/PFM286u1WiKx72ne23LtrAjUSvqWY0bgB664KAzxZG2uSCS?=
 =?us-ascii?Q?E+W4oGnPtPQbWHBSQka7kV+/0sfT9H0rUJdUnWVPEBA9HolHOKrMzP3eOjQ6?=
 =?us-ascii?Q?xNq1MOqa26H/ZW5o6dBM1BxNDOrDSRtC/2UTkR9PdVXcjbdTpbJHc0pD/GgN?=
 =?us-ascii?Q?JGKcsWy4KsNCLl/uGQ2CGVhVSla8MITvDZTHiM+fTObRBKe+/mZuMKzgh6lT?=
 =?us-ascii?Q?xAQTPwgzc6PCjcWVXpfJPq7w+qmqJJnDwt259ROmWq3OKvL7LGQlhtK7Twy/?=
 =?us-ascii?Q?Xnd6uuvLUe/ITPAx1bSxc9XsoueHnfbIjfhNjXZ30Be/AXK6l/dWxyxKmmjQ?=
 =?us-ascii?Q?A3mbcybt0MCe6YqFPv268yuXw44ShT6XQBbgwE3TfKXkNmUpS886f+Y6TEoo?=
 =?us-ascii?Q?5lj5v8y95CFW3Qw4UjNLTkpNR9/YvdlTUIoHe9+Abiq6F7t2jWFqMSJOiH3q?=
 =?us-ascii?Q?48SetFK3qCv949zaHp5UTbC2YjOC9YD3A0PCAMli/uhVy7QKf+pj177GN8yP?=
 =?us-ascii?Q?JDuPhX3Kka9IY4zLOBhQTJxEtrTOup1LfubNXECL9YyIxPeKcF/gJ3qZQwTL?=
 =?us-ascii?Q?ruPggq6TeH6ErYaMamdCMnDweK/hX14JXK08zwaUELhWDvpTXOmiqFVpRP16?=
 =?us-ascii?Q?1RmmxTzxeDcnsTbLIu0D1tHeMTo2JMjdILKE9Dt887PB6h04lIAf1v/Piytp?=
 =?us-ascii?Q?BSWLwvAUU/4SBBAOhbKOH/g98+9uZQyIgHaiO6sF2YeGJV4iIAXB1qM8VhLn?=
 =?us-ascii?Q?SkPWqiz5ofcBefUNcmyYwOtI/alurgx7Xmv+CMatSJxMz7cCJliOKAsOMZqx?=
 =?us-ascii?Q?dXxtdNYfU+ldxb8v/rDhLajB29+zHXltrjNGqPqgUrvjc5XvsOLCHSEHVW/n?=
 =?us-ascii?Q?A+Ks/+AjYdF9W2X6DffeoFDP44Jn1WC9cHd02Ck+vvpP0gcAbXs78/qtdLy5?=
 =?us-ascii?Q?5G0n3KF/3aBedTV00QW3y/nDtUPQmEVP1O7aOJ5q8kM71kyTSYCPay5VNNNj?=
 =?us-ascii?Q?0zSHthzYdH+3cZRtLVVeudbfaZK4SA0OQqYAS9othVtGzB2L+h/iFKPNaOCW?=
 =?us-ascii?Q?KlaDlj4OFpKqxDg+QRCK1ZtH+n+TBxSN4AuMXWUuwtjimFipYt8CSkaOGvXZ?=
 =?us-ascii?Q?XRjdpacRbkY8RobF+VPXVOT7oK72/4dTn0NLP88AELx2N2c8G4BvZHy9bM6I?=
 =?us-ascii?Q?ZTZqMb8cw5Y0U84bDmYBXFakLjUbTTVg8D4A/iPkg4XXDdQtoEpN+LEgUsjv?=
 =?us-ascii?Q?7uX8oqubhw5/xrFO+FrrPnPzg8ktceR+yoFW4K6ggNRveQXvruODiL92UicQ?=
 =?us-ascii?Q?agef2zh28Ito9JAF95w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea0168b-1ebf-4907-8570-08dc80c0af83
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 15:53:44.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5+Zx2wEqiYn0PrJ2PbFDTGJMQRAZ5lzputQWaAsh8E60bS5qb/CDIHDFBp5DV+8/JAH803Y87Dl5J3rPGEUZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9079

On Thu, May 30, 2024 at 11:05:58AM +0200, Marco Felsch wrote:
> Hi,
> 
> On 24-05-30, Shengjiu Wang wrote:
> > Add support for the resets on i.MX8MP Audio Block Control module,
> > which includes the EARC PHY software reset and EARC controller
> > software reset. The reset controller is created using the auxiliary
> > device framework and set up in the clock driver.
> > 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  drivers/reset/Kconfig         |   8 ++
> >  drivers/reset/Makefile        |   1 +
> >  drivers/reset/reset-imx-aux.c | 217 ++++++++++++++++++++++++++++++++++
> 			    ^
> You make use of the auxiliary bus but this isn't a aux driver, it's the
> i.MX8MP EARC reset driver. According the TRM only the EARC reset bits
> are covered by the AUDIOMIX blk-ctrl.
> 
> >  3 files changed, 226 insertions(+)
> >  create mode 100644 drivers/reset/reset-imx-aux.c
> > 
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 7112f5932609..38fdf05b326b 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -91,6 +91,14 @@ config RESET_IMX7
> >  	help
> >  	  This enables the reset controller driver for i.MX7 SoCs.
> >  
> > +config RESET_IMX_AUX
> > +	tristate "i.MX Auxiliary Reset Driver"
> 			^
>               Same applies here
> 
> > +	depends on CLK_IMX8MP
> > +	select AUXILIARY_BUS
> > +	default CLK_IMX8MP
> > +	help
> > +	  This enables the auxiliary reset controller driver for i.MX.
> > +
> >  config RESET_INTEL_GW
> >  	bool "Intel Reset Controller Driver"
> >  	depends on X86 || COMPILE_TEST
> > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > index fd8b49fa46fc..f078da14c327 100644
> > --- a/drivers/reset/Makefile
> > +++ b/drivers/reset/Makefile
> > @@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_BRCMSTB_RESCAL) += reset-brcmstb-rescal.o
> >  obj-$(CONFIG_RESET_GPIO) += reset-gpio.o
> >  obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
> >  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> > +obj-$(CONFIG_RESET_IMX_AUX) += reset-imx-aux.o
> >  obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
> >  obj-$(CONFIG_RESET_K210) += reset-k210.o
> >  obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
> > diff --git a/drivers/reset/reset-imx-aux.c b/drivers/reset/reset-imx-aux.c
> > new file mode 100644
> > index 000000000000..61c353abc84e
> > --- /dev/null
> > +++ b/drivers/reset/reset-imx-aux.c
> > @@ -0,0 +1,217 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset-controller.h>
> > +
> > +/*
> > + * The reset does not support the feature and corresponding
> > + * values are not valid
> > + */
> > +#define ASSERT_NONE     BIT(0)
> > +#define DEASSERT_NONE   BIT(1)
> > +#define STATUS_NONE     BIT(2)
> > +
> > +/* When set this function is activated by setting(vs clearing) this bit */
> > +#define ASSERT_SET      BIT(3)
> > +#define DEASSERT_SET    BIT(4)
> > +#define STATUS_SET      BIT(5)
> > +
> > +/* The following are the inverse of the above and are added for consistency */
> > +#define ASSERT_CLEAR    (0 << 3)
> > +#define DEASSERT_CLEAR  (0 << 4)
> > +#define STATUS_CLEAR    (0 << 5)
> > +
> > +/**
> > + * struct imx_reset_ctrl - reset control structure
> > + * @assert_offset: reset assert control register offset
> > + * @assert_bit: reset assert bit in the reset assert control register
> > + * @deassert_offset: reset deassert control register offset
> > + * @deassert_bit: reset deassert bit in the reset deassert control register
> > + * @status_offset: reset status register offset
> > + * @status_bit: reset status bit in the reset status register
> > + * @flags: reset flag indicating how the (de)assert and status are handled
> > + */
> > +struct imx_reset_ctrl {
> > +	u32 assert_offset;
> > +	u32 assert_bit;
> > +	u32 deassert_offset;
> > +	u32 deassert_bit;
> > +	u32 status_offset;
> > +	u32 status_bit;
> > +	u32 flags;
> > +};
> 
> Why do we make it this compicated for an simple EARC module reset? I
> understand that you want to provide a generic driver which can be
> re-used but there is actual no other user and may will get no other user
> in the future too. Therefore I would like to keep it simple at the
> begin and adapt the code on-demand.

There are many similar cases. such as
https://elixir.bootlin.com/linux/v6.10-rc1/source/drivers/pci/controller/dwc/pci-layerscape.c#L251

Previously it use syscon and regmap to a global register space region and
direct operate the register. Now this way will not preferred. It needs
export as reset driver. but actually, it just write some bits. 

We face the similar problem at difference driver when do upstream.

One on going a discussion about sim module reset
https://lore.kernel.org/imx/131e46b1-61d9-41de-a225-853b09c765d1@gmail.com/

We hope an unified and simple method to handle these cases.

Frank

> 
> Regards,
>   Marco
> 
> > +struct imx_reset_data {
> > +	const struct imx_reset_ctrl *rst_ctrl;
> > +	size_t rst_ctrl_num;
> > +};
> > +
> > +struct imx_aux_reset_priv {
> > +	struct reset_controller_dev rcdev;
> > +	void __iomem *base;
> > +	const struct imx_reset_data *data;
> > +};
> > +
> > +static int imx_aux_reset_assert(struct reset_controller_dev *rcdev,
> > +				unsigned long id)
> > +{
> > +	struct imx_aux_reset_priv *priv = container_of(rcdev,
> > +					struct imx_aux_reset_priv, rcdev);
> > +	const struct imx_reset_data *data = priv->data;
> > +	void __iomem *reg_addr = priv->base;
> > +	const struct imx_reset_ctrl *ctrl;
> > +	unsigned int mask, value, reg;
> > +
> > +	if (id >= data->rst_ctrl_num)
> > +		return -EINVAL;
> > +
> > +	ctrl = &data->rst_ctrl[id];
> > +
> > +	/* assert not supported for this reset */
> > +	if (ctrl->flags & ASSERT_NONE)
> > +		return -EOPNOTSUPP;
> > +
> > +	mask = BIT(ctrl->assert_bit);
> > +	value = (ctrl->flags & ASSERT_SET) ? mask : 0x0;
> > +
> > +	reg = readl(reg_addr + ctrl->assert_offset);
> > +	writel(reg | value, reg_addr + ctrl->assert_offset);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_aux_reset_deassert(struct reset_controller_dev *rcdev,
> > +				  unsigned long id)
> > +{
> > +	struct imx_aux_reset_priv *priv = container_of(rcdev,
> > +					struct imx_aux_reset_priv, rcdev);
> > +	const struct imx_reset_data *data = priv->data;
> > +	void __iomem *reg_addr = priv->base;
> > +	const struct imx_reset_ctrl *ctrl;
> > +	unsigned int mask, value, reg;
> > +
> > +	if (id >= data->rst_ctrl_num)
> > +		return -EINVAL;
> > +
> > +	ctrl = &data->rst_ctrl[id];
> > +
> > +	/* deassert not supported for this reset */
> > +	if (ctrl->flags & DEASSERT_NONE)
> > +		return -EOPNOTSUPP;
> > +
> > +	mask = BIT(ctrl->deassert_bit);
> > +	value = (ctrl->flags & DEASSERT_SET) ? mask : 0x0;
> > +
> > +	reg = readl(reg_addr + ctrl->deassert_offset);
> > +	writel(reg | value, reg_addr + ctrl->deassert_offset);
> > +
> > +	return 0;
> > +}
> > +
> > +static int imx_aux_reset_status(struct reset_controller_dev *rcdev,
> > +				unsigned long id)
> > +{
> > +	struct imx_aux_reset_priv *priv = container_of(rcdev,
> > +					struct imx_aux_reset_priv, rcdev);
> > +	const struct imx_reset_data *data = priv->data;
> > +	void __iomem *reg_addr = priv->base;
> > +	const struct imx_reset_ctrl *ctrl;
> > +	unsigned int reset_state;
> > +
> > +	if (id >= data->rst_ctrl_num)
> > +		return -EINVAL;
> > +
> > +	ctrl = &data->rst_ctrl[id];
> > +
> > +	/* status not supported for this reset */
> > +	if (ctrl->flags & STATUS_NONE)
> > +		return -EOPNOTSUPP;
> > +
> > +	reset_state = readl(reg_addr + ctrl->status_offset);
> > +
> > +	return !(reset_state & BIT(ctrl->status_bit)) ==
> > +		!(ctrl->flags & STATUS_SET);
> > +}
> > +
> > +static const struct reset_control_ops imx_aux_reset_ops = {
> > +	.assert   = imx_aux_reset_assert,
> > +	.deassert = imx_aux_reset_deassert,
> > +	.status	  = imx_aux_reset_status,
> > +};
> > +
> > +static int imx_aux_reset_probe(struct auxiliary_device *adev,
> > +			       const struct auxiliary_device_id *id)
> > +{
> > +	struct imx_reset_data *data = (struct imx_reset_data *)(id->driver_data);
> > +	struct imx_aux_reset_priv *priv;
> > +	struct device *dev = &adev->dev;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->rcdev.owner     = THIS_MODULE;
> > +	priv->rcdev.nr_resets = data->rst_ctrl_num;
> > +	priv->rcdev.ops       = &imx_aux_reset_ops;
> > +	priv->rcdev.of_node   = dev->parent->of_node;
> > +	priv->rcdev.dev	      = dev;
> > +	priv->rcdev.of_reset_n_cells = 1;
> > +	priv->base            = of_iomap(dev->parent->of_node, 0);
> > +	priv->data            = data;
> > +
> > +	return devm_reset_controller_register(dev, &priv->rcdev);
> > +}
> > +
> > +#define EARC  0x200
> > +
> > +static const struct imx_reset_ctrl imx8mp_audiomix_rst_ctrl[] = {
> > +	{
> > +		.assert_offset = EARC,
> > +		.assert_bit = 0,
> > +		.deassert_offset = EARC,
> > +		.deassert_bit = 0,
> > +		.flags  = ASSERT_CLEAR | DEASSERT_SET | STATUS_NONE,
> > +	},
> > +	{
> > +		.assert_offset = EARC,
> > +		.assert_bit = 1,
> > +		.deassert_offset = EARC,
> > +		.deassert_bit = 1,
> > +		.flags  = ASSERT_CLEAR | DEASSERT_SET | STATUS_NONE,
> > +	},
> > +};
> > +
> > +static const struct imx_reset_data imx8mp_audiomix_rst_data = {
> > +	.rst_ctrl = imx8mp_audiomix_rst_ctrl,
> > +	.rst_ctrl_num = ARRAY_SIZE(imx8mp_audiomix_rst_ctrl),
> > +};
> > +
> > +static const struct auxiliary_device_id imx_aux_reset_ids[] = {
> > +	{
> > +		.name = "clk_imx8mp_audiomix.reset",
> > +		.driver_data = (kernel_ulong_t)&imx8mp_audiomix_rst_data,
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(auxiliary, imx_aux_reset_ids);
> > +
> > +static struct auxiliary_driver imx_aux_reset_driver = {
> > +	.probe		= imx_aux_reset_probe,
> > +	.id_table	= imx_aux_reset_ids,
> > +};
> > +
> > +module_auxiliary_driver(imx_aux_reset_driver);
> > +
> > +MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
> > +MODULE_DESCRIPTION("Freescale i.MX auxiliary reset driver");
> > +MODULE_LICENSE("GPL");
> > -- 
> > 2.34.1
> > 
> > 
> > 

