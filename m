Return-Path: <linux-kernel+bounces-241388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154FF927AC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372D81C217CC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B5B1AE0A6;
	Thu,  4 Jul 2024 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="klClIM5y"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE96F1A2C1E;
	Thu,  4 Jul 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108870; cv=fail; b=tN2YPbYYohd75QxNvRA08C5J3x9qFab5uuEMwAOslqR0R+JkyhpYDcOzeuS/Icf9/UvNB/3mvu/fEy5CtYCEbHSQ0KaFcLtd8/DojBu47Q4LrYTfq6XIw6KPvy8H7uyShjZaasVvCP15wcK9MNgVSKtyqTHwx8VkPN2EFerM29s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108870; c=relaxed/simple;
	bh=IXV2qV30cSXeucJALgM0nDZoHXr5+Ymfs4Kia8vG2QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j2FRZXn9fkcBaAaDZ1CbyIJ0utRhxxzh4VfsTibU9xwFTNELW5kunSG1xzRGj7KEg3Y+oxxipZGfQGU8PKCHvZ2QshGqeH7Uj1q2aWRxrVFHsMlKM7T/v/K3ZAcy63vKfi4ecbkHqdU5XVbzWl7AhoGeIrVy6OVMAto1r2tTKxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=klClIM5y; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW6Al1cZqDE8OcmXM9m14UZT5ftRd0rbrA9CzeQMdiAPP8B0YVdmnMNa8YMCto5xJQMZ+qjwy+Wf3GaNexdS6UJB0PlXqxL9MC2iZ6P0In1h+epBL18xcnfBaz4ww4hDG9VWfB++BDiJqSMPzh3CYOuIqh4Zb2Iwocgz6wenRHmpBT7NEr4MMfXE2E6Ul09ybtOvHpSgerOLs4rofIdqyiqCB5BEOdU4GkkMJKSXbq/dwBxrJaLGvFZPLlxkfQ0F+A8ObGdwzEeSrCQQzP1PWEBFUusymjqfWdDuuHdr7Rl+ZXhJbnrrU+lD+5LCpV2aZSgvuC6nESGsSmTFPyGuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF0RzoyMYT9jmvmtScpSlGi8X6Gy4KiLtnyr9+mNJys=;
 b=Y2ndYkiEBRI2Vr3gfDkbqD9eNJ08qBjU9qiW762Zcs+itj9TSBJkxWmf4PrbYEvK4EDj4X2AlLep8kPK7slZL5VakicO59lYUv7a4TGcZL2b0X/DuIzzLAaFc6r7liAJXJjCf4MT6xOCoYRzBtwWkuBu61i7D1g5vQsSh2fL5tkCIwO64WtaDxTaIK+GxyW/Dh/LtxGAobfPCauoW/QSUXivNI70f+IdWyUhyKWV1a/ktud2DL3pd/rCMBv+CxISEiFFtNkmiYZQ3csXjbTlpGwP2r59odPjUTw58MMNP+DgMXn+mbSbKy9hjL6AhS2pUiqoscMsLxz44oZ7SKXyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF0RzoyMYT9jmvmtScpSlGi8X6Gy4KiLtnyr9+mNJys=;
 b=klClIM5ygDtAaTqLmTmvdVsxDX80BU8uFpImbfEmuaF6l5yEYrLtNd/Brnqspbb9Du3US0OIz7mijHLBVMzFxGvNawlka5XmiU79G9HgVAwjCX7+DkRER4S37/sRQ/uPOYiQ/BiE37vPkQV1aiSkVgs/6oSfyh4DxtOQieYK0o4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9950.eurprd04.prod.outlook.com (2603:10a6:150:11a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Thu, 4 Jul
 2024 16:01:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 16:01:02 +0000
Date: Thu, 4 Jul 2024 12:00:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Ran Wang <ran.wang_1@nxp.com>, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH 0/2] usb: dwc3: Add cache type configuration support for
 freescale layerscape
Message-ID: <ZobHNfI9doRyd+nj@lizhi-Precision-Tower-5810>
References: <20240703-dwc-v1-0-9cbc93d49180@nxp.com>
 <20240703233310.2oxguahed2g2lknm@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703233310.2oxguahed2g2lknm@synopsys.com>
X-ClientProxiedBy: SJ0PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6795cd-1296-4833-569d-08dc9c428105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3XLGbUf42UDmzfUoF+3B4a9CSUYHAfsXcRFjlganpODT1jLYwrbw/39N9Nkl?=
 =?us-ascii?Q?X4rTg48wxCCzc73Io0vrSZHJrGlTPVpdWndoizlSRPjw5wJZEZqrMn+rB1LL?=
 =?us-ascii?Q?W+T76fiHUjNUHQl4cNqsbfdUGB4wQz/j6xtsYEedCq9vkuwE0yCNQ2d8OvIN?=
 =?us-ascii?Q?/3NrXPZii/USfR0ql3ogbzh+yB8WDz7dybgjnTN6soMlhqUTVVZ/QzFbRozG?=
 =?us-ascii?Q?+RNHN9OFew1sITBOYUKFTDC1OZnHAgXhrM802VGIdhTXwXNW1W/YXDEo4hS1?=
 =?us-ascii?Q?ip5nP6t9RH1dVo/O4W+CIZlJ7pRhWv/BA6NjhtqwZ5tb61SdRsXcT6ZMbTZb?=
 =?us-ascii?Q?FsrmUbIFBqsubSAX964uqysSbllAkS4YTNGaSWBIWJw+oQrzP4vpRhF0ELMm?=
 =?us-ascii?Q?d04yRxvLul5KQb1MEhDpI4augE3uvMgHmVGt/phwWgsrSAxAQV9BL6tFuYFg?=
 =?us-ascii?Q?YTKcfOZ5osx2eo6/UKFZuRYbNdp/sqvEOkg0OpH9mGm7ZBnbTDi4QqjnJQWE?=
 =?us-ascii?Q?3JIp6kV0BW4mnej2p0oAG/5wC4ftbMlIx0ezcv3Mdd/AZO4vwHYNpT1szFc9?=
 =?us-ascii?Q?wxwiPt7fV6RMtCHi8BDiq3W9Fvw4gHRzCJpNokU2Y0uVrQvjaApLAFgMwYIG?=
 =?us-ascii?Q?Q1oART+dFddR3W284xiAJ0CxYVgyFPPnIBtD1WRIMer/h1Ot0OKbHQLHRpxJ?=
 =?us-ascii?Q?ebplGkMxOAH9VNyhlMbaTvEKvuVekm3rmzV4PxSPXKtd/Ku3VL6NBhWo87Bc?=
 =?us-ascii?Q?BnVcQM/m48I+wx4ygaDXKwPKR9xtxK0tdfXRonHd45oPfetOtHH8NuMFQo8b?=
 =?us-ascii?Q?HWD1wKjDlUAGmSWpSQFTsQR/Y37GrwLfHdqk6eVy4rzQTo2FclfLOKEfa+kh?=
 =?us-ascii?Q?NtFr2h5xqZv7JmXZzPjMGVUxmGERj8En2Zrl8CdtMEsF2pp/y1oLnSpQgNpN?=
 =?us-ascii?Q?pNZLcxlerTPBDXZUKnxU8lEqErXlUJKkDquoeFRQOHM3KpVhpIlripT4UMmC?=
 =?us-ascii?Q?rgQ7BkDJLgdoAjbZdMQD1+rMN77qkrNRbeSaGSFrbbBkRYQTzG7808PZNg8k?=
 =?us-ascii?Q?npQ+u7xylKkkO0B3kDg/i+bBnaZxLl0+/ZnZiBjjFXtHFbw2BvQjtbtVsurq?=
 =?us-ascii?Q?dUW/DjU0o6pVmSlfvwwiVr73hjZUa8KPqrRCQOzZnSiccOn8C/7cn0pI3/sO?=
 =?us-ascii?Q?L3eP1Cxiq2RrzqiJwfKq/WYYVUn69d2SvyQBvrSLBSuAJnaCe7SFAE/sSlIs?=
 =?us-ascii?Q?L8jdvyxsyjbpWnwND60TL0iQrqE92BbrMEljxi3voR4Akn4grwm7ztL5Z6i5?=
 =?us-ascii?Q?SfWI3HvkXBGofzFrzb/AXF1xYG9C2imJe0RdlJP5lDvBLx/3GCr0+ROaK6E7?=
 =?us-ascii?Q?SqLS5Hc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?39bgXEE2UBcKr6Rrx2R+ksOlatb6NWXchzVYgOAw6Nj4oJQY5NmHiZF9YsgP?=
 =?us-ascii?Q?vnjGqjmF+Z2oFiqlmUUkKNeuvuCuFcYSeAn7AXoMKFuHWxeYP/DcM986BdD2?=
 =?us-ascii?Q?Ernn5AAcJRsrbviaR0BsxmEfwdtiMrPO8y/7ZJyP9CnwCJD28KS9E0cfR12n?=
 =?us-ascii?Q?UKLVkH2sgyeKSXq7q+Ed2Iupw6NaVUlTL1gqsrK9RUY3QC0CUxdGfVtsEkRz?=
 =?us-ascii?Q?1DTlGUsB0sCkF+xAK5gjR5Tc73lBtlt1XYVrdEz/i2Y4LTvTF7ak17uHW2YL?=
 =?us-ascii?Q?Xn8scHLbhcHLUxVBYO/UbtF5WZLGSVvhP9WWW3gN9MXWPxICnJLVebWH2gzs?=
 =?us-ascii?Q?MvxCMoYMqp9BBAIcO+frrw9GIB6jO93C448umbPF3hm4nHa/QViH+In78Zwg?=
 =?us-ascii?Q?d7kCAr/d90yGM+9Ygz41tP6d9Pinj7+atB2aES1dlFRGEEeWO5xuFQLzOYWs?=
 =?us-ascii?Q?6uiUnXdBtZmg/eNtnBmpD4TFsQpHHEIQM0lRf6eWuwTXrPbMbEKDxJTxuBit?=
 =?us-ascii?Q?YNxGSb7n6EzbuDryvoGvzQrR6F8oZtgIsj7qYTQiNs9ex7tY102Wi1fl5jWJ?=
 =?us-ascii?Q?K0Mcrjang9BzL/OaIE5pafhJPCOgI5ekyIySqbeAnOmtdgG4pyDv3MAEc0Ep?=
 =?us-ascii?Q?93svg7eJY3NLImZ1CbTX4CECPjMKOliH14v5n3QlBWvXCtz0NsNA14nh+qki?=
 =?us-ascii?Q?pcRG3B8QxEUm7F61AkSnqnn1H4c2aI0/QLDPvnL3tyfjXc0GeS+5wFaYxpUQ?=
 =?us-ascii?Q?lMYa8Z5HLaW2RbzfbrG6hycanVOU2Zyd9RIVF7mFHze20Ps2YJ/Izm/jNGe8?=
 =?us-ascii?Q?fBzdG5EZUca6uCfT1yvhyBVArV5NUZb3HQadBKdJfLKYWMI3RZIqUXkQwhdS?=
 =?us-ascii?Q?HpXGBnNacPXD7wjQuCUuN1RmTqK2MwaHolXr+4E4fIlzzHyK5J9sm9rNDPMW?=
 =?us-ascii?Q?Ukrn82ZzwJ8wYqSbUIgpEnPqjHP29H825xsSoLIPF0zOHpZUe8V0OxQt0IUR?=
 =?us-ascii?Q?2UawznS9o2Hae7v2uPKFx2rjgE0i8CjxqTLecYe80GYO7h7jY1e23K1y1Vzo?=
 =?us-ascii?Q?0Ba2DxLYApRWEJXliPH088DpQWxJFeReMUoeg4IDqI9yIhiP1xdRj6GWWLPy?=
 =?us-ascii?Q?fkkmMaC+7U85GBCjXL7eOR3NTBdWoHt0xU/YnsWKjVf9bEykU1iQeVaoNwVE?=
 =?us-ascii?Q?fEZwgIsyYEt4rBuoezd6cK39tTzDmCc6S1zySdaJsfVaypwdalo9jYgPXa3V?=
 =?us-ascii?Q?ql8ULxzGTysFV16TvzpQs9yf3OXobbNoMpqTU5riD/WQYdGxbTMK4X1M09Bm?=
 =?us-ascii?Q?JxZ6R2wxB7RxCd54djW0km6wzu8efnQyHkBhlliZ4jk12V92zNv8oimmjji4?=
 =?us-ascii?Q?bEiaNnkas7wXpFuuqmdaBp9EfNLsbJ3A5aheB/A4GLRPsTeVG0kUzl2QZ2WL?=
 =?us-ascii?Q?9g3Z/RMd9w2exBNEJOcoxXb/q8WZwyTuBKcSLNrsket9zHGTW0GS9YhX0wvT?=
 =?us-ascii?Q?QZTmB8LoHc0IH9ggvh2AGKnZZXcRXYBVk/DUbBQMUYtqOvEfqge9G2pkimzA?=
 =?us-ascii?Q?X2/pujB6KtJCjcrbW176eX0i02s+zCmd4zCTqyo0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6795cd-1296-4833-569d-08dc9c428105
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 16:01:02.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0Olf1DUyYUU0hQVX5+9bGrZ1AlJylooyRSlhqbdZ7DBK/9yurtUQ6mNKrFdoBeReVZ2RU/zoyp/oP+7mJxW8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9950

On Wed, Jul 03, 2024 at 11:33:23PM +0000, Thinh Nguyen wrote:
> Hi Frank,
> 
> On Wed, Jul 03, 2024, Frank Li wrote:
> > There are several attempt to upstream this code in past year.
> > 
> > The first attempt:
> > https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20191121095356.GB7503@b29397-desktop/__;!!A4F2R9G_pg!cdNydVZ64br9EHG13lgP3lKWe5VuXQvvfvA1CzKJqhXZZB1H9vcJlwI1vj1EF3ynRFl2u8tD3lYqRvrJFSs2$ 
> > 
> > cache type is dwc core setting, not glue layer. So It'd better change in
> > dwc core instead of glue layer code.
> 
> Why not glue layer?

I understand glue layer is what provide clock, reset, power and other
control for dwc usb core and have a seperate mmio register space. All dwc
core register access should belong to dwc-core part. You may have
difference defination for glue layer.

> 
> > 
> > The second attempt:
> > https://urldefense.com/v3/__https://lore.kernel.org/linux-usb/20240123170206.3702413-1-Frank.Li@nxp.com/*t__;Iw!!A4F2R9G_pg!cdNydVZ64br9EHG13lgP3lKWe5VuXQvvfvA1CzKJqhXZZB1H9vcJlwI1vj1EF3ynRFl2u8tD3lYqRh7SiHmM$ 
> > 
> > DT team think there are not variable for property 'snps,dat-wr-reqinfo'.
> > And suggest use vendor compatible string.
> > 
> > This is third attempt:
> > Compared with first attempt:
> > - reduce compatible string to one 'fsl,ls-dwc3' because all setting are the
> > same.
> > - move update burst type code into dwc3_set_incr_burst_type(). and check
> > compatible string 'fsl,ls-dwc3'.
> > - Using bit field help macro.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Ran Wang (2):
> >       dt-bindings: usb: Add chip-specific compatible string 'fsl,ls-dwc3'
> >       usb: dwc3: Set cache type to 'snoop' for freescale layerscape chip
> > 
> >  Documentation/devicetree/bindings/usb/snps,dwc3.yaml |  1 +
> >  drivers/usb/dwc3/core.c                              | 12 ++++++++++++
> >  drivers/usb/dwc3/core.h                              |  4 ++++
> >  3 files changed, 17 insertions(+)
> > ---
> > base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
> > change-id: 20240703-dwc-5be3e378ddbe
> > 
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> > 
> 
> This may blow up the dwc3 core from various platforms and compatible
> strings. This can be handled in the glue driver and create the software
> property instead.
> 
> Radhey Shyam is working on this also. You can check his work here:
> 
> https://lore.kernel.org/linux-usb/1717657279-2631757-1-git-send-email-radhey.shyam.pandey@amd.com/

This is quite good.

Frank

> 
> Thanks,
> Thinh

