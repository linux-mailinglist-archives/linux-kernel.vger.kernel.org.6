Return-Path: <linux-kernel+bounces-340794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94BA9877F6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DA31C22769
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E809515C127;
	Thu, 26 Sep 2024 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Srhe7VNz"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2073.outbound.protection.outlook.com [40.107.103.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F8158853
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369834; cv=fail; b=aOGvmNuDOTZtGFd0neXlt5fWlSCH69ZCq38caQNtwJH7RyFWAIAAHFvqeIrTzrvjq12pKgZ+g1rvRGxlBuF+ZiBVE8gsl0xJ4Zv8D5i0PKAASMKYJBO4ilbqfdc3T/AvPVJ8KXhJ7PBhBnZ2Vf/RKux5lLOLsPzk/jBTlTIlFtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369834; c=relaxed/simple;
	bh=3my6L3FTCbwov3/nXxXcMSfmCqGl4ohHAl3FouHoPlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ebMqMLFREfip7eEkErQKXAq0qzykCu7B89pQbaFO5MY+c375d0G0ndji0B89xjrXzggYzLdEu44i6vfB/owDNkIrjLGVtOj3XNogJbPlBkjuGRcLfvR6ygNYoaf1zAWEyRiwifdEqS7KqvdapitDlL1rHh+OcxzyEag9kp/nJTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Srhe7VNz; arc=fail smtp.client-ip=40.107.103.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHU8P7kYG/D7ORHaSMeTLOQaUjjuIzO7nclhcdql29dwI2mLvEO3ZDc1sQDZaJgTRL762/s1EiG1ycZA71jenPSRnSmY/lgstqXtS0bZXd810pa+xJC0Tzl9/5yHPI+s89ur1huVweM0HHguGzwNouTi4Yx6FDUOtVx+PqbLiJZVUtYUSjiNn70gUHiGN2hoG8X8nPpGIkm6A0Yb0Low3rh/WpnEfOhkzHIFI10kdCOYV6bZJfCVg5Dg65/84pbidKQHf14c694h5G2Pj64Uhnk+G98ryK8+z8y+EY3KHZLpjed71XPwyr759lACh9hGlNW/iuPVb8lGAiYCniqn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BI41ZiPCDuszVpAtuNlNxIc77TO+zwtZrZlsjljcm7Q=;
 b=K3F5rbJQLAabVaq1xn65UiQ2f+5ke7IwI7Au2WguV2C+kPCmvLmxlUoIsN3evmwYySDGPghfQXYgQ+GvK6K6ZxA2Agom5/tlP2+U+f3LN0sm9F67tDyOlMPGhUDW9poUQWDa9nfPk/buT5MbHk26oLEolRquc58d1BxnKGsXU35cGfuJUVLh8NFZpec9WkuQVQqPUUhXPW+PWTRBBfYyTpbYVO+Fre+5VpdNczEAYSAmNYN1QFSaxZ6v8/MuMpv7Dz2rW4qCT+SPanxVmUCcDPHCi1VeQrApSMHZsuphA5BM3BdN5jxlF8EBikCf9qg/ZeHRylwHfcQzQSWVHabcJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BI41ZiPCDuszVpAtuNlNxIc77TO+zwtZrZlsjljcm7Q=;
 b=Srhe7VNzf27zp3bSOvPayDWVL62MXdNCHLpViO2Ke42X4yG6uTq0VQH8uF4LMrgoVgWI9y6ScgrcXq8JfDm9H31M7c4zoNuaumHlNs1QYLRykdbRmN4oHojjEhYGqkJgeeBytbtze9jO2dhwjZQcDbqnqwW8SgG4iGtF50gDsRIDRExnMwRESuD51lYQ3QkhbrURjMZz29l2BGIjvt7iqpIQ2+0SArsubDYO7vpIumdadLEmFv6zsUASMykvJRmIZFNvTHVgm6TM4XOJ51whuKz9491K/pA25q1/hHdOuPosCukwMJLbB1Je9Q2PPahh8oVSoyUIUc2nRJLp86vP+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10600.eurprd04.prod.outlook.com (2603:10a6:10:588::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 16:57:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 16:57:04 +0000
Date: Thu, 26 Sep 2024 12:56:57 -0400
From: Frank Li <Frank.li@nxp.com>
To: alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com
Cc: arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, pthombar@cadence.com
Subject: Re: [PATCH v2 1/1] MAINTAINERS: I3C: Add Frank Li as nxp I3C
 controller driver maintainer
Message-ID: <ZvWSWepBxc9wluw9@lizhi-Precision-Tower-5810>
References: <20240815141609.4089406-1-Frank.Li@nxp.com>
 <Zt9VDJ546znNR7AT@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt9VDJ546znNR7AT@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10600:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b797f79-10e7-4a46-8ee1-08dcde4c3f64
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ngGatgLKwdPByWtUlLNKAN/wZUuF4CYmw7Bd2ndj/0uNVMhOaVPyJIsTjamY?=
 =?us-ascii?Q?7Gt/Rhn+kGCeoBzW38WWbRfT+GlUmjs6JdP+ss0eFb4N+Kqd3zzhmHWVmsaD?=
 =?us-ascii?Q?8+0cwK9nEbTJSpSdYWDiT50Z61kPH9lRX2bU26uNH3eyCdaoYIs0WmylcKl/?=
 =?us-ascii?Q?Bo0YfO7rx+Dn9OKDDfG+avAPtcYua5N+dmXosH66ZF1zxTv2uxp30+CqQULe?=
 =?us-ascii?Q?MomGepmKWDfeDaEDACcp1PwERpkXhMF327W56zts6jjEOqUKc0clVZd9P2w+?=
 =?us-ascii?Q?iWrbUi4HbtfDQ0pYJkl0XzAzvrVtLPo20i8jR9/MltiY+dhCdnIEgFFOLpp8?=
 =?us-ascii?Q?AfLsMuXKU/Y/4Mw5bt8VkOJZxT1M0BMcrVbs4EX70RCsYv27mPXq75uqDl4z?=
 =?us-ascii?Q?dgpBXsmTX7HzrBqPj8s/y8oSXLfhdk616QQWmdOENh2qf29lxUR38euo55K5?=
 =?us-ascii?Q?IYxpdZT+ayJct3tao32ipXBCmKVQ9KwCHeAa/nSJx9Li2fzohqxIxgu02yQe?=
 =?us-ascii?Q?dl/vX3WSUSPYsKS8Ay+8ecNh5GTrck3ZeX44cEbgTFU9Fd6W8X2TNXIGSQp1?=
 =?us-ascii?Q?5WXOFFFifZwKHlaoBGCTuoq+wC45pcssTMlNqRpoeKXKMAx6e9Nphu20J6WT?=
 =?us-ascii?Q?6gMhOOS6Lpu/9mGrBcmaXILSNfxhZW8i+3zveZihAyZarnSiCDyCpbxrfY66?=
 =?us-ascii?Q?hMEvtX1kupYvroDQD/2aI26JwPo9yNPvox5A83S8i/hAIAnfvQzA2/FbZkRP?=
 =?us-ascii?Q?HefHkeoLhKAYviP0fdXuvBjnNaNYMkhMZZpGnY8C2BJoO0CesljJLFkwJfGI?=
 =?us-ascii?Q?OSexdneGP2UmeaIka2lUyiwjcO7yNprDF+pSez7HjyIUddh+bexsVLVXl2cr?=
 =?us-ascii?Q?tu+yrzpfghDzTBqvwibMDHOtyg/d0RYwgKOLXiRz2GBlkOeK2aDmOyuvxC1u?=
 =?us-ascii?Q?nXZpSxYglO3dHDtXEI2BBacRswcNzG4/U5NH9Q7s5wA8x/ncZ8HfFLxYh9Cb?=
 =?us-ascii?Q?UYg9Q+/9xHnv/UCahrixI0ayjqdr6p34Ri0Pu9kO0gAEmRXu4JUe/oWhyslG?=
 =?us-ascii?Q?H8sCDjtIXN/JFe6fK49VtBohJ97BRs+t8WLLEO0wGkeP0DW0vFjwgZE9EI3s?=
 =?us-ascii?Q?0wxfBI82xqIb7t9h71qI54sm9gB7rXOtdxPCILiE4JnF57xEDt10zmRdzqwY?=
 =?us-ascii?Q?TGvV7LIVLtXjiZMX3NyUF5oPekoFoN7L3wMZ0bPczGfcnMrlTLJt7XgUhO/3?=
 =?us-ascii?Q?vQtoH/GzaQydr1fKZH1GE2pZ1XirmiqhTsMNbY9bNxfUxD1ofHiY/unuKG1H?=
 =?us-ascii?Q?s8kvc6KyFjAe5BnkW/ekuB+0JLgulDmSf0xbTIrtbGftig=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?2BlV9R6xab00ZUzO3I97eYPmh8natckfmXXuORzb4DF0anMcbFMnVDWGIHVX?=
 =?us-ascii?Q?pb0DFeaVB3ufkf5z3wmSb+5uED4+qdyN5tL9ZvdRNH//SdosxbOWHQ/sWHie?=
 =?us-ascii?Q?daYMdqSxZGncrHYbQ604+p4O9c8Vt4zMOSe9JxnC6XpStzn9SBu+N8jnN42I?=
 =?us-ascii?Q?gVeZbVPqdvBj8hDnhH6lnF/rv9s57S3kxE6hB5IhBlLCoH3m2yQ+mFOmzSe2?=
 =?us-ascii?Q?j2uzXa/dHoZLWn21uSbGnuPVE74QO/gvrTPgdG2CldliEMGazke0JrrY/dUq?=
 =?us-ascii?Q?2UDh/7hxbBXkJ5EoQD8f7fNdqcUwO3vBszCBmkJIHgciOUXg+78Z/uOxGaex?=
 =?us-ascii?Q?jIequhY37FHkjOw7lVZfnIb/LXayK27skxSUXgxyLkYHJxmsWg3IC5hyuwbb?=
 =?us-ascii?Q?4L6cXJ5sPOVaQ078kZSt58+CJwPyJRqjJERl6MX4Nkf7+KS8vrn0STThdIwF?=
 =?us-ascii?Q?Lc8dG0s5Dwt2jRU4mbQ8uWiP+Qx6w19Rbu09gEZcpTdRHuDFP989oOL5vqoU?=
 =?us-ascii?Q?9zod78PxXYlWjK0Q2yPBlxBgwwWbDUcG5G0W4jUHos9ZY5y+HoZYqi0KPZcA?=
 =?us-ascii?Q?xj1baWkXUTeJVV8vHjtJP4KUbU9FpzJjUPp7fD0jmHouZZM9Ws/LfYzTOLEW?=
 =?us-ascii?Q?o7p/1u6EbVM8gKYvn4ciQ6DUy5P/lzgeYqptxir1sSQuAXwDYaKtKW0zDiVe?=
 =?us-ascii?Q?CEDrJ4nRiMSyp3sNZsXYdgMIl78fp/u2DhZ7ggwcsDDeQwK3MpiRpW0Cn46q?=
 =?us-ascii?Q?sZoloedv6GqgjL2UsahFR2Z4ZteUJcMgpuRtzMl5OGyFW3+D7FUTHs8EJaj9?=
 =?us-ascii?Q?HEKaTNXO1oPclgScu/SIsgc3EdhmQ0TPFdqgkX522e6JrSSNKdQlMQ6Q2SLq?=
 =?us-ascii?Q?23Z6fyq1c1ueu+BH1wWAW0A/TTv6I1bAmLJ9gY9f2qKt4ePDrwCADxmvJ4kW?=
 =?us-ascii?Q?PuaK48DF30Mc68gb/Rqszk3hYILfwqPR7h3H7WvTVqhSfty5u2wFvLlNDnbu?=
 =?us-ascii?Q?jkVQ5EQATPpKPSFtvVBIR+hEh55BRp7pJBO1t6Wf9j4+cVc7BeoqgS7efgje?=
 =?us-ascii?Q?QEnLUX3sYWy/9lX9+ikxbTTLH3X3gS010JJfAGcHA0PpbiAp7pCOM4A4oX1q?=
 =?us-ascii?Q?stggU/tYmWjl1m4fGApPlYa9TWMnp9LrRTYTXt23TJypViw/RLQeMKw6X9HR?=
 =?us-ascii?Q?vG3F6wqrvWgXIfzXHCSgRIpbHwq69ZvV1wIoo3a33OPk0LTs4qTHKZ8Yu/yN?=
 =?us-ascii?Q?1HwYdpTAbQHsob86N5csmb7gKTOBMWfhhXDYRFU2jEnFLP/V2NyoH6djmaG/?=
 =?us-ascii?Q?DeBlzeGhDVkJNNQwyXHVmZ0z02TD7bLTMgPoA7pQdh072ycSC9ZuD74mGGVO?=
 =?us-ascii?Q?diJJtKMgzVIGVw4eqBtkutEvVjRplzVWWUh25vyPyUKzUPG14Bgs47sLGzgB?=
 =?us-ascii?Q?A+5ujnjHftM6pmuyZnkgQwxrV6QbUj6/eA7we1XYUBeFLsgi0SHXbkqdc8Fx?=
 =?us-ascii?Q?+9UHANHFLl4VCtj0iMuvhmkzEtAPIKKiYUzuxE7bA2UjUnvoF0hu+CSaB11e?=
 =?us-ascii?Q?GKGUfkhY4uYsh7MNh2I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b797f79-10e7-4a46-8ee1-08dcde4c3f64
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:57:04.3472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g166KFz9pRDaUBr/oRB8wqQ5hZe5rStcM2kb6kSKixzlr6YgWDbKo7sQKgDkMGQSQXMRSPCLrPXgAgn9i4i/jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10600

On Mon, Sep 09, 2024 at 04:05:32PM -0400, Frank Li wrote:
> On Thu, Aug 15, 2024 at 10:16:09AM -0400, Frank Li wrote:
> > Add Frank Li as NXP i3c controller driver as maintainer and add mail list
> > imx@lists.linux.dev for it.
> >
> > Add Frank Li as I3C subsystem reviewer.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
>
> Miquel:
> 	Any comments?
>
> Frank

Alex:
	Almost one month passed, how make this go forward?

Frank

>
> > Change from v1 to v2
> > - Added to exist item
> >
> > Recently, I submit many i3c related patches and become familiar with i3c
> > protocol. So add me as svc-i3c-master.c maintainer.
> >
> > I reviewed other i3c patches. So add me as i3c subsystem reviewer.
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2b96899a78890..077e37eb018ce 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10708,6 +10708,7 @@ F:	drivers/i3c/master/dw*
> >
> >  I3C SUBSYSTEM
> >  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> > +R:	Frank Li <Frank.Li@nxp.com>
> >  L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> >  C:	irc://chat.freenode.net/linux-i3c
> > @@ -20961,8 +20962,10 @@ F:	drivers/video/fbdev/sm712*
> >
> >  SILVACO I3C DUAL-ROLE MASTER
> >  M:	Miquel Raynal <miquel.raynal@bootlin.com>
> > +M:	Frank Li <Frank.Li@nxp.com>
> >  M:	Conor Culhane <conor.culhane@silvaco.com>
> >  L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
> > +L:	imx@lists.linux.dev
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
> >  F:	drivers/i3c/master/svc-i3c-master.c
> > --
> > 2.34.1
> >

