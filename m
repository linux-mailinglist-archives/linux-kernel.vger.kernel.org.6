Return-Path: <linux-kernel+bounces-286754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FAC951E99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372BD1F22CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337C41B4C54;
	Wed, 14 Aug 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iQoJO201"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323E1B3F26;
	Wed, 14 Aug 2024 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723649516; cv=fail; b=CXKOFCXV2TO/dPyJy7rOPvngbxt/zic/kRf0S8eOu/E7KrQkdH6eBrViI1Tgf3enzRZZxv7Br9gkE45JoZ54F7fqU5vGV5R/2MQJ97Qa4bVKlwzVlTcazKXrWcky7A0Jn47wqXqeLyBeuO491UoDrdtM7lyGHtWxl0x9fTySvWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723649516; c=relaxed/simple;
	bh=N8W1j3RzOGd6KhNmWX+0d408nOJzdDC36+VuvNSBS7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kBwFPaD8s8aXa0BphV1mgxTem9ib23nms/+LYr2RA4vXNHTXULHnFZPfjt59LWz12KCw5VGtqwCeGaU7g0go8Y5MbetjaITbKB4u1dGPLDMMfsMbHchjboiL5BS86AZg3PyeisZ9tVman50ZdckoWtQ1Mn2H+E+C5AVZIrjLAtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iQoJO201 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+oq3sGpjAsYGXKB/Xh3Nzdu+N6k4tnXPLSRE+RIXK9bix9CRvsMyXCAVXBw6HqOoqNfLa2YH5dPfPVEsecDP/k1i/ZIkCsmnf0p33KKI7YyQiTrwweNNQW3r/sMXzSzRx6hiMnNiAQEc/FoGru0zVALUvrSml/y19XtCXHBm1mhzdiekmRd7FcyY06NWG7J6KUgSWcDRPEncgGXFUmTw8IZ3+Z5UwihuIYdKqzTYFhorBMRq5AVbM1v+q5NM6lFZ2yrCH0LVrhiwtmzjkmpfADwOU6jV7QCXg63nq9wiiq8coH3iAQJV82AFCgePx1fMOsJPPEmAiARpK0X1Iwh7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSTuzYxn0klauS2SYdT0OVQVnl/uDksa8DmvORtICOQ=;
 b=tbyCeFPdZMzxZIozIvhNwFlzd7AUlKGnyBHVX1juf+w3jqHEMx7FFRvPWNAaVFlmCinR5jCutWppAiNlFh0bG2tyHrtPirK1TPXJN+hoXgdypzQZT7c1OlclTFLcTx4uDCUjzSmOqNVyru8PkIB3eVl1fzDlmzRTdu+RLtHlDClF8Nry1EkrLiLHB8Uvc6hNgAEfKscwvpKXEJXxjwmfRqVUKjAJeFGDm5Eh9zaQargKOMJvdeR4HZO+bqcvAVc7Ut5tILmpQYUKwv3m5QEgcmR7bPZZzQN+lKyZQBo5qdrc3Li92loXJw4/q0QOvVjP2j1YZT7Q5wJR0XFL82U39Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSTuzYxn0klauS2SYdT0OVQVnl/uDksa8DmvORtICOQ=;
 b=iQoJO201vOmOIgYRCn4dr7pbUnzh++w5/j5J64FnQBlUDP4MqsPDNRSTN7ohCTq2N0RuASD6w3XAmV62oQApUQerMUy6OEaKGxEpgGZGj36TZoyGMyUuX1CQVswrk/ARNcZlWjJeXOi3VMBNhTRn7ZJNsy5T0khzsNV13QAmurk8IzXq2TjVYaAsI50JWHyE9RxQSYx+a4/wEYwwnEGQ0YFUstqGXsIxTGS4yNqTclFtRKRMQw1G6Sm19TNQWqO1zirMc/4IjnDbFEac+gIkhTN5U7iy/5K+oSQuVyDDIJ5VkQM3Lcjn+27o+I/eVelhnW4YfTxKDE9MTm+Qsn7fcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB11056.eurprd04.prod.outlook.com (2603:10a6:10:58c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 15:31:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 15:31:49 +0000
Date: Wed, 14 Aug 2024 11:31:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: Re: [PATCH 06/17] arm64: dts: layerscape: remove undocument
 big-endian in watchdog
Message-ID: <ZrzN2lQeMhJcGWHz@lizhi-Precision-Tower-5810>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
 <20240813-imx_warning-v1-6-3494426aea09@nxp.com>
 <7700102.EvYhyI6sBW@steina-w>
 <ZruROoTQeYWgcw1c@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZruROoTQeYWgcw1c@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SJ0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB11056:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddf7d16-e9a7-4cc0-f491-08dcbc7636c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?93kjd05WplDltumoFxPkCVUR96xTKpjKntjqVl8lhuz104ck1uOWcWIluu?=
 =?iso-8859-1?Q?1+Flkd/0DpytGhzvVRl1CUgFnXytKo3Uj1ELX243ETh1uNGA2QfMxw9i3l?=
 =?iso-8859-1?Q?zMIlaKHvaP7gL6eQySGh9eqtSpaOZM7V125CFu0l7FnQj4RbN/RXfLyJ2L?=
 =?iso-8859-1?Q?qzJllPqYqDH9kRr6M7RsmXyFrndLyMib3IM5VpYXpi/Y3TWqYCLRCF3hUW?=
 =?iso-8859-1?Q?KHaLNqjNj59CXh4FbWxyCoL6GOk25FEla1i3yGPJ5vVjrFT1EhS38SXt3F?=
 =?iso-8859-1?Q?5bchf2uz71vvyTUjv0+POnhraK4rP1gg4dQgvo7ZMJHUx3Uusl4QbeXzUq?=
 =?iso-8859-1?Q?0iPTrAMd662f2S3Mj9XnvF5U8o+l1gqflpwMY2hn9FXHtEuYtl7GVOQcPC?=
 =?iso-8859-1?Q?y9tI3gT5tPE8g6PNjzu1FdDKTCFm84NvExU8epG87Mzvn9QMdLaTs9l80f?=
 =?iso-8859-1?Q?zXUorhfiISl+kgqzD9taYZkVdEoa1+xcegahAsGdkUDnBPOCW4QEH00Wti?=
 =?iso-8859-1?Q?DHccPlfK5dT8N0KEUPp0T7bJ5/CVxzwafEqz4jBnE2BGIEQK8c0FaNWLit?=
 =?iso-8859-1?Q?uSg4hIJfa7Xxvqi4HcVpMdzW0olshSVqhwBQhAsI0sK1UDwzdN1di64uUc?=
 =?iso-8859-1?Q?iYwoC3tEdB0dPlDcrt4ix100+K9cwnguIizVLbF6I+/915TQs+tJyToVa1?=
 =?iso-8859-1?Q?QpSsIRZFaCEoEd4tHKvQlKRo5WJ8g2CvROS/FnIZrl+SwJEQ1SDvi+J/se?=
 =?iso-8859-1?Q?eiAk/u+e2mIrwVpttSTNGYnj2+/58PyqEvlhr3rLIGhlceZzUI5TdIlG4G?=
 =?iso-8859-1?Q?Vzd8RLKYgy9XhYg5dHehZA8JhjVwIgGYfFYjiPcy8C4kL7XnnPyuj8yPFg?=
 =?iso-8859-1?Q?SFJHR8rIg9xNNrWUSghEr+BLTMPRTagrIOQwau8a4BXPs3PFVCfs9VfCBi?=
 =?iso-8859-1?Q?ArK/VqKCcA98k37YW0IudOiRC69LhsSssErGDb+YXIo4ifkEHLnWqjBljr?=
 =?iso-8859-1?Q?VhDGT4wgTA84hUlCoG6m5mqX2fW4FSD0sjySKWpFYdFWoQobupo0dBEtCk?=
 =?iso-8859-1?Q?5GAf1I2VpRon9i03E8HrCHBcth1D2CB6pglAxXPpM/AS0DsgMLb9Lmsaqt?=
 =?iso-8859-1?Q?QtfPF+CGvSspP804m8316lS5IDm3p2r/kR50R+yND/JGN4jNV0RdMUrayr?=
 =?iso-8859-1?Q?e9+TuqCkpV9qrX1HZBY5JTb06gG8tZY3Y9kCLu2sykQ06GDnTBE/DyNolS?=
 =?iso-8859-1?Q?Lc3JAR3oTzjakfe4Rhbgd+RoyVhkgc5wMsy/SldJOGWhqr757fYGgIbexh?=
 =?iso-8859-1?Q?FJwLwoYYQEE03jqq3z5wnVe3K+ypRcQLvZpx0mJKM1Nzoupof05tTZ71Mg?=
 =?iso-8859-1?Q?cREcWwGKrZA9OA0a9a4a2u7s04ssz6IyPj02qvxjM2rkST7yOh+MU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Dwy88PrCn/ZYTPBn38gN8eQUKBfMd60zDlYYEYhtkUQAqOP4dCGrapGo6n?=
 =?iso-8859-1?Q?wZl3a/OR8C9Du6ggPHv0DmELQCvkOEGxI6ITVSErKoca5LVPljM4LUtXnP?=
 =?iso-8859-1?Q?kk7Uxdi7+cro/ZhO/gLJHk9CyUdiWHHmtNaqJy0CBwUO1d3VeJqBUcvOjF?=
 =?iso-8859-1?Q?lkeWnIBs86c0RnzeddYXCuroQj+YEKl2BaaJr3+3vfzuBRzT4awIChSHUb?=
 =?iso-8859-1?Q?mgAuUbkCdDrwnXL3JSPdAGitpx9jjMSd9O9ovxtOOUGVuRNsnEKVIrSGhX?=
 =?iso-8859-1?Q?v8pmPvVOWuRUfjeN4viIaGrx6kPJbQjCAwZVRkl5FthPESIw4GhXvsJ3fg?=
 =?iso-8859-1?Q?r6RKmGN4HEe2FRiUUTeQuvdpjvpiXxnR3Mg8pZ6hCrQXmk9WK0GSczdS8C?=
 =?iso-8859-1?Q?nyttp/oBWbAt2X2kyU3tgw6+obyU+KNyEuAHO/h5gdd/tpstb28vrK5d7U?=
 =?iso-8859-1?Q?+rWaTBzqvMRGp/5rnBfhfWz8Oy0ghlf9t/Cf+j6ZO7ey4tF4CKP0YbBgzq?=
 =?iso-8859-1?Q?ZAcz48ZGNS8qfu5b4F5DY+A4pDMZU9e8JP98UAkoNA+lbSpz9tMj23QntI?=
 =?iso-8859-1?Q?8V5KO5DMKYj4Ev+tZBmHV7Y8N1uT16bn+/+GCUBQDDR7uyGwLjL9IuP6TN?=
 =?iso-8859-1?Q?UEP5MM6g8HybZPeDEH0TJLwP473DLDFIz6sGpE5Ehx+bppX82+FuWO+VR4?=
 =?iso-8859-1?Q?ZVXqVsCD204F5+WYkcY4INE7kr8Wxvlc6gMZikhKnpHk4MvwA4cE2axiQ2?=
 =?iso-8859-1?Q?uYHLUDleVHvxRfqlnCoYtWh0SPQbD9PAdzVfUL6uQVqjG7mruzlDGmDGeH?=
 =?iso-8859-1?Q?K/dsg3CGbHNnCGRZVPNXs9zS/xtAjxarnN5m4RN5x4Al128/qcz5Wsyb9w?=
 =?iso-8859-1?Q?6bEjpNPdmFmyRaxSVRP8a6NQ4edcDxRlATtinrlsZeA/KUTxlLrsGi2+HD?=
 =?iso-8859-1?Q?V5+KjCAc6Qe0PqFw5UC0VFVjyosfwdp1TnCOYVIZlum3cNE7WH35biZ6QB?=
 =?iso-8859-1?Q?erTvrT4L+T5CRSPZyuB/Pfzg5OjcwzBXbpnk4glpSOZeg5/GWaysROZJDb?=
 =?iso-8859-1?Q?3u2OUdDlwMTCqhfenxHNTrePD91xKSbbbHxUljFGSUaswSwNy1kChTFz84?=
 =?iso-8859-1?Q?uZEt0HG1hBD2UoFEeIfeaGhGIael9Qb2IU3A+6p0c1uEoHwPso1YBADTsq?=
 =?iso-8859-1?Q?RmFpebFs8MMPCEUEaiH1VEWLNruSnnq17fWODRxVIynK5dU/CY0YjC+CA0?=
 =?iso-8859-1?Q?mzwJCF1PGigJ8ZAo6Ft5rGHgdDjeahV7391SySDu7rSVZGdFbtu5JQ4bR9?=
 =?iso-8859-1?Q?W33hxBEXLWiiRHcI74ISl8keDYGlhiOJXG0R7BxZgFk/yImoB/+QPi36Vo?=
 =?iso-8859-1?Q?aeP+4gDcs/s1D7djBAnnJcjzERm7tIjuPyyMyj8P8iw6aMpGtlSw18Zw//?=
 =?iso-8859-1?Q?uIl1lqJeYMePaIpx4lK9KaNhKLY/dZ2Gu4N2T992RA7oOR67Nz+vWnikvI?=
 =?iso-8859-1?Q?0Z2lP7rLok66yaM1zlJr3GrmprIfkmxZNfJrZJpYV3+Rn++3FewTtFTbPZ?=
 =?iso-8859-1?Q?KJ6jKtkZDyLv17ypkVPc86aDmQ5ItxlvaZnId0F1mg3YNKpR6BUgXtnymi?=
 =?iso-8859-1?Q?AH/pIZQAHQKRU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddf7d16-e9a7-4cc0-f491-08dcbc7636c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 15:31:49.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+JPTJCDge3Ig0ybxRmJOgBru6PiqdFGv5b2962lXHQgEFnJgYrGJZtkGhUg76aeT1lLzGLsu3hD3nhuAyNhMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11056

On Tue, Aug 13, 2024 at 01:00:42PM -0400, Frank Li wrote:
> On Tue, Aug 13, 2024 at 10:31:23AM +0200, Alexander Stein wrote:
> > Am Dienstag, 13. August 2024, 06:35:01 CEST schrieb Frank Li:
> > > Remove undocument property big-endian in watchdog.
> > > drivers/watchdog/imx2_wdt.c also never parser it.
> > >
> > > Fix below wanring:
> > > arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: watchdog@2ad0000:
> > > 	Unevaluated properties are not allowed ('big-endian' was unexpected)
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 -
> > >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 -
> > >  2 files changed, 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > > index a3c57da63a01b..b84512bc4c881 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > > @@ -430,7 +430,6 @@ wdog0: watchdog@2ad0000 {
> > >  			reg = <0x0 0x2ad0000 0x0 0x10000>;
> > >  			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > >  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(1)>;
> > > -			big-endian;
> >
> > RM LS1012A Rev3 10/2020 lists WDOG1 (2ad_0000) as big-endian.
>
> Thank you point this. I remember I run this last month, but not sure if
> 1012 platform. let me double check again.

I really thanks you for your careful review. I dump reset value of one
watch dog at 1043 platform.

0x02A80000:  00 30 00 00 00 10 00 04 00 01 00 00 00 00 00 00

It is big endian.

Frank

>
> Frank
> >
> > >  		};
> > >
> > >  		sai1: sai@2b50000 {
> > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > > index c0e3e8fa1e794..5837f1b15dccb 100644
> > > --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > > @@ -776,7 +776,6 @@ wdog0: watchdog@2ad0000 {
> > >  			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> > >  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> > >  					    QORIQ_CLK_PLL_DIV(1)>;
> > > -			big-endian;
> >
> > RM LS1043A Rev6 07/2020 lists WDOG1 (2ad_0000) as big-endian.
> >
> > What about ls1021a? According to RM this is also big-endian.
> > regmap_get_val_endian() parses this property and regmap is used
> > by drivers/watchdog/imx2_wdt.c
> >
> > Best regards,
> > Alexander
> >
> >
> > >  		};
> > >
> > >  		edma0: dma-controller@2c00000 {
> > >
> > >
> >
> >
> > --
> > TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> > Amtsgericht München, HRB 105018
> > Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> > http://www.tq-group.com/
> >
> >

