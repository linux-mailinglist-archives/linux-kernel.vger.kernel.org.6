Return-Path: <linux-kernel+bounces-345901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9198BCAF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E881F245B0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEA1A0AFB;
	Tue,  1 Oct 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UrHRXMUg"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B01C244D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787062; cv=fail; b=h3N1FClfJDTD91r99MS+QgBk4SCAVj3G/tXS7zL330J1ozLwEEkPfq+hI696yCnQ9oM26851gabyIlWlghw49aPZ5DPTtgZzLg4U6qGSDIz4FZMjgzDESGHuoOouoFmgHzMgzifUpV1VVM1iGRaJgGBXREhNCbXHwGhxNYbjz+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787062; c=relaxed/simple;
	bh=yFMbKr/uzGkyf89c9+g/ffMyCKJ59GKXt2wODUUNiMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Abb5OqLtemnOaAkf5C2cdTOlzNH2tQcM4d3aP17uq9vpw7Mutd+d2n7kX2ZVTgkmyOLgry/aWzygNSaC1ktzfpM5U/zrF8sV2eoZRlNwZEosjAkZsmc8evJ8yJpJCbhAhOzGi6W1UVebdMqVgiRMG7Ne6/ddBdphQwGAIVold94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UrHRXMUg reason="signature verification failed"; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBAaFaXmBXMW0mqQqjA0nvCkTQf0ZO3cbnOqteHEigqIB9gI+RriURytx1yezJvcUQuvkZRj9wYS6yBtw8ekKzB5kFicq1V5MK5h3KDdEnXdFzAU4D3Rw4iZA3zvveAffDN78GngzJCXRo7hsKegrNmxiQFBLBdyWr3xdMNXFWsJkeqnGI8R3u5pzW7AfowuSP3gX4aPQbpVRqP1Wy5XJyGjy4Heb5BjX5tS6aA99GGRaAmfM4mymc/bjLdgDkofjKDXfnPudHIh5lV2rQSJYNfuZ4dW1y9XsHuS2t1brhbZHqOI3xUUXxE2+WBxzuLAYKkXxvBrrpbwubVI+vjyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoMphusbHiagqwnISl+TR+0lTg88k2H+QRO0SGOWQnA=;
 b=JqUWeeVBvjBcwRJZY5C+lndqlKTSIditrCJudDIrSIpUr6FVzLuJXen4a75D6cvJFGLDWYwP2KJ4Fv6TeAWjXVdrPb1THyTgAZQSBGD9PQbxVsZIxr4mW6w117t+dTf6qhRUZhFcYXaKQrFSjxUvLHr4XCqpBGUKVGw25VMrah4GNqtUnI74jT91Hscyu19ALcv9A8yBl4WW+S41Tif/DaVZ1t3+2ezzoiWxMy0O+9G+drEcHfLx/lVxRhfwr1q8HY0X/5FEkjuVjyXHdK98E1odq7I7PwTGCISvILcg6YnlcjpAIahDGipLmv7onNPTa4ETFcZzCYE0NLrOw5RYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoMphusbHiagqwnISl+TR+0lTg88k2H+QRO0SGOWQnA=;
 b=UrHRXMUg+apXP9dqA6G10aTl4f2iM9rC3s+q82jC7VcKeEx8kuIGQ+N1gYiCgWJVcZN6umO/NqXuHVE97YKBJ0aIVPQbRKwSAy049a3SBSNO1imapweRLvuqxKkU7LI5orAlvD6jJ/qeYpTZ4ogjwrtVO61hpVcoUYUMYZeMw3EiHRrnHf8QkFpGkprUf53ebsHkPyVhjE5KT0IoHbkkpT/U4yNxbUv0kYrJ1TtUvyd6XFLPB4FlXAxPfZa/GCPeSq/s37MVq2znlsyhwfBQeq+sjdGAnmZ8lZp0w4tRcHDXv2luZCyY2JT0Carfiv1QinPQfgtqWfSm8EWzlgiF4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8362.eurprd04.prod.outlook.com (2603:10a6:10:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 12:50:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 12:50:53 +0000
Date: Tue, 1 Oct 2024 08:50:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: alexandre.belloni@bootlin.com, arnd@arndb.de, bbrezillon@kernel.org,
	boris.brezillon@collabora.com, conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org, imx@lists.linux.dev,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	pthombar@cadence.com
Subject: Re: [PATCH v2 1/1] MAINTAINERS: I3C: Add Frank Li as nxp I3C
 controller driver maintainer
Message-ID: <ZvvwJXuaFzttwchv@lizhi-Precision-Tower-5810>
References: <20240815141609.4089406-1-Frank.Li@nxp.com>
 <Zt9VDJ546znNR7AT@lizhi-Precision-Tower-5810>
 <20240930182235.52c4530e@xps-13>
 <Zvra9mFa9vD30PGO@lizhi-Precision-Tower-5810>
 <20241001121027.29a51284@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001121027.29a51284@xps-13>
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c509b5c-4a41-44a7-f94c-08dce217af35
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?+RlkTjdOGSTlLC1ObmITm2kpnNUn8JyUSgTnOAnFv5AJ+FPgEcto2dVVgO?=
 =?iso-8859-1?Q?+7NF6pRplgajaN2qgHRrOoJK6925HdbEMiy33Zjf892wJdbeHUQ+IomPSv?=
 =?iso-8859-1?Q?M0pmJssssxX4BIji9B6iY7LVIQx6nnLluU6ylFb4FAG2hxMV6qozkIKHaH?=
 =?iso-8859-1?Q?pSRv/WEKL3qFyFjqZX3M+jf3XXDXaL/WIL+9md5x/wOD8zk1JdMUJhWSf/?=
 =?iso-8859-1?Q?z64u4BD+i3LkOdkczifg/kpLvAJNwVj4YLRLwsh6HrY6ih/za7O3BY/+A2?=
 =?iso-8859-1?Q?3ZrZ7SRn2MSgCrqLfg9LGAYqEwQv4RL9qSxmE4Ci0Yyp+jU2XSs4Zdt11R?=
 =?iso-8859-1?Q?C5B552pUh6eAU7lgbySN3XgReJ+kdJRgXVCWkWDKo7v4OcEtroMymcUsXc?=
 =?iso-8859-1?Q?KLXvXL7nnyYHOZgfthTfFF9mU57xl730GAeVTrOuP3+uSvATC73OdKmjA/?=
 =?iso-8859-1?Q?O5MLDH0CeWw9AAFpa4cki8ipogIbgv8MKUc0mKZQdunbUPk3hJBLhAxtX7?=
 =?iso-8859-1?Q?Q4ZgWxWrtBS05/9hRi9N6b7GWiI/ovctUozeYQpsan2vddQQuW5TRqt+Nj?=
 =?iso-8859-1?Q?yFhi8uSIqKeaT00MRQ5ujvGGfbc2jyRv1mum+c1JGJSxmnlIbjMQRmyZ6B?=
 =?iso-8859-1?Q?oy+VLF+JQO3xuCSoRuKBDLRFIGy9GJVVM3XWRmlthGkAR8/pDOTBl5MCib?=
 =?iso-8859-1?Q?CII81IOokW5NPf9Bj9o2WfaO6yCqWv1R2XnEJHIzFGp2h4yyjbA+a5Ooxb?=
 =?iso-8859-1?Q?DGQxvqXqmotgcJ6acg8HNH6LOTnwmZ8ycrKvj6hV08CX3QVXRObW2A+B2H?=
 =?iso-8859-1?Q?bvi7cXYy0WNzoZ9vXH1/4zrSzLpLbRWMCkL9uqOF7NkCpxCQIp5HVzU1/b?=
 =?iso-8859-1?Q?UJBLuAlNOSfo/PvlGeNLB3WE6amL1m4rIp14RM2YcCR/UEMM+OTCG8UKpZ?=
 =?iso-8859-1?Q?alxx8z0bXKXhopp0mjSDCqdO1oEqa85YlWjGmYYZl9ifHnzPMlQVcj0Yqm?=
 =?iso-8859-1?Q?NmJJk1LY3MXXNCW1425ZDnUnsw1tL+LtwOwfDcDepgtQCF/FVukyPJFpVn?=
 =?iso-8859-1?Q?45oV4Meb/XJ3xLLCyCQe6+LCnd1M3MujXBFSdI3Q9ts3RcA375T+dbdi6g?=
 =?iso-8859-1?Q?Cfjfe2wjxG2TjjzbX5iIUHPJhb2OE+8LHcj+Dc8qSkgV1FuU6XXl2yQ725?=
 =?iso-8859-1?Q?cOQCK0q7YQp3RkP5DLZFimqNzQXJ8FNACtsWiW+75D4LIih7YxKGqOQPrN?=
 =?iso-8859-1?Q?H9cZCJCTz427ofq/pVO7CbAhsPqSpsbXkZxL6hZOXogWuZLkuadaI2py3g?=
 =?iso-8859-1?Q?imiJB6h/ProEd2U4KmSDltynmMWfWnNCRDE90PyUGwslIIdLeRkKbh8FsS?=
 =?iso-8859-1?Q?+dPzuttIheOf7kXhtDKb2sPCcN/VkDzA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?DyUYpitGjn7qPRDD0uSqWZl56kFZYCGXn1ga2fWAHzfeV7l6/M3YDkZbNN?=
 =?iso-8859-1?Q?pGZViTsWbL1A3KKT7a+qFjD5fwHSOABqfs0BUBNxhl//MoiG9TVpvnyiFK?=
 =?iso-8859-1?Q?Lo+45UeeRtA5gPRwF117YE7sz1ANneC1RreP+u4dVInDfXy+0/IVBnKxvw?=
 =?iso-8859-1?Q?YqN+ApDs8FsaO/xaKQfQ/Is4N1qsDOj6Rx27Z6Kd+IbfU7RZzLn+YbAWNM?=
 =?iso-8859-1?Q?lt2KFs9mmYdgwMegakR4oBGR2K6oaSpKdvDeQ6v5hJbMHyeGns9tJBFXN8?=
 =?iso-8859-1?Q?hrl1iySP2B5SVLrS3hCQn1S2cIZh6BQwguEVjY9MjSBeF16T1JIH1BxjaD?=
 =?iso-8859-1?Q?dAEY8WsIDDICrset8QEcxJDSjZGipX2HFNTpDRlMKz5l42tmIIbARiGW6I?=
 =?iso-8859-1?Q?zBuDKgia/Z9hled3JodtO1UZF7r6G+x2xQmKzRnxEEQRJA4WJulkCwwgGD?=
 =?iso-8859-1?Q?dq1ula7w2Oo9mHjkxWuMrpQBoAcHuEBpd7M6NEcrJSX/uIY1Vdbmta7fn9?=
 =?iso-8859-1?Q?5GyPYI1aso8hRIH5BPdzMibZYmQlr96Nk9fI0hTK6uukPstnnr0Q7rfNAj?=
 =?iso-8859-1?Q?0cwWTpsk6JQE6wDnNlDOS9V8mNsbTF64qAnuu7caPdGGbcBzGyoBajToPu?=
 =?iso-8859-1?Q?VVnYoWfa2OVWRSmO8788jyC1tFds+FofNT79uMPYIo8TNGWKt6vSxtozaM?=
 =?iso-8859-1?Q?hn9+mk8h/JYdUnAYvWtOVZjWviUlyT1+rSUQTMnWXdUS1GD0Sm+SPwTjD5?=
 =?iso-8859-1?Q?6MSjvOHT1+gbkVDf8v9kR/lnfVWw0suTtXDu0q9DALkS1gM+6NuOsLkJwB?=
 =?iso-8859-1?Q?oWPhaStfvyQ2QxXCu0JNqTpgnsCvMcbMOr5RTk1xwEVeW9vhuG+5h6121x?=
 =?iso-8859-1?Q?MoRSIsslDTK7V+TqRoeiaJ86PADutJyojoDySixVEUvGNPs1VgrSU/lWuy?=
 =?iso-8859-1?Q?Yo5N6Ui7R9VmcP200y5pauXNud8eUMMm5nZmbfiIzHvcOX4APTEwf/wamG?=
 =?iso-8859-1?Q?LlH7LN3y7lgSDj7Vc8xGruFWjzyriTYdNpcy+K7sKgWz2M/TJqhlxsReQO?=
 =?iso-8859-1?Q?1lhb4QWbaPwR6Pidr/EqkAjJfe37HRQz6uQncKL+XXDxXu2322uhmblXDQ?=
 =?iso-8859-1?Q?vKOmUCkxv8/lvCb4pb1A/X710koKq3RQ3fqMwSG8eWWk0ZJxJodPqN89d7?=
 =?iso-8859-1?Q?hA7aTvj0VC5hhwebw2Jky+nZR/KFKXQYsK8XXMlEm9bafMNaiy3akNYw1s?=
 =?iso-8859-1?Q?FZnH0xWpNPcL4BdhP33QIIY50WtSTSgnH3yEiRqP3MNFzw1ZDsxj/R0zlO?=
 =?iso-8859-1?Q?LqJ+dIG62dGCl/oWj+N3f75ExyHajpF0PT+KfmBb/GMphQHbt5PW4sZfAg?=
 =?iso-8859-1?Q?5fsVfDPihdldsL5Hkzzh+5meayPKiDDNc65s04O4+CnG6lNkYvXt0wtS7A?=
 =?iso-8859-1?Q?YeXpC5PN7qCaP5RjHebursgIz8kq211wHQHMKJrbmUqsWeTCN/evcAyNun?=
 =?iso-8859-1?Q?fn2o4imUW0Jm0ISsKFMJI8ZgaISpHhWyyY/wPH+mSqu+k7c7lxQQH2+PGb?=
 =?iso-8859-1?Q?zToPrSUX1IEdZQEV+hyJ5ThscssWwfUpAXuNw4dHGqeKO/YLm/4JVpNogE?=
 =?iso-8859-1?Q?TX8IRMxpP79AosD8tKafS2qDmf397wTlsD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c509b5c-4a41-44a7-f94c-08dce217af35
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 12:50:53.2623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iLn+SLBcWt96W8Jr7Qe/r8jKx5hjaS3uf5H15w2AbsLFaLJXDuCCBk8WA4fwq04hLZK1na+X7RSTQANO8tdag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8362

On Tue, Oct 01, 2024 at 12:10:27PM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.li@nxp.com wrote on Mon, 30 Sep 2024 13:08:06 -0400:
>
> > On Mon, Sep 30, 2024 at 06:22:35PM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > >
> > > Frank.li@nxp.com wrote on Mon, 9 Sep 2024 16:05:32 -0400:
> > >
> > > > On Thu, Aug 15, 2024 at 10:16:09AM -0400, Frank Li wrote:
> > > > > Add Frank Li as NXP i3c controller driver as maintainer and add mail list
> > > > > imx@lists.linux.dev for it.
> > > > >
> > > > > Add Frank Li as I3C subsystem reviewer.
> > > > >
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > >
> > > > Miquel:
> > > > 	Any comments?
> > >
> > > I guess we'll happily take your feedback on patches targeting the SVC
> > > driver, you've been working a lot on it. However, in general there has
> > > been a lot of discussions happening on your substantial patchsets and
> > > little to no convergence in the end.
> >
> > I think this can't prevent no any feedback at this thread for more than
> > 1 month.
>
> Well, there's been a lot of discussion, then no convergence, that's
> what I am pointing out as well. You cannot say there has been no
> discussion.

Yes, but I can't understand what's that related with this independent
thread. and it is fact of no feedback on this thread over 1 months and
missed one merge windows.

I read your comments again.
"I understand you want to push your patches upstream and I also want to
make things move forward",

I think you mis-understand that I want to be maintainer to make ungoing
patch "i3c: master: some fix and improvemnt for hotjoin" go forward.

That no convergence patch is i3c common master part, not svc driver part.
Even I become svc maintainer, no help for go forward at all.

>
> > Basic, this patch did two things,
>
> Actually 3, and this is usually too much.
>
> > one add mail list imx@lists.linux.dev to
> > keep us track all imx related patch in one mail list. generally, we don't
> > check linux-i3c mail list frequently.
> >
> > The other things is add me to maintainer, If you have concern about it.
> > You'd better said as
> > - point to the path to be maintainer, such as do reviewer first for some
> > times.
> > - or simple reject this, I can post the patch, which only add
> > imx@lists.linux.dev.
> >
> > Keep simple, two questions:
> > 1: are you agree on add imx@lists.linux.dev?
> > 2: are you agree on I as reviewer?
>
> I've already answered these questions and made a difference between
> reviewing driver changes and core changes.

Can you explicite anwer yes/No for above 2 items, so I rework patches.

Frank

>
> > > I understand you want to push your
> > > patches upstream and I also want to make things move forward, but maybe
> > > one of the reasons for the stalls is the lack of fluent exchanges
> > > between us and the difficulty to explain bigger pictures in a clear
> > > way.
>
> Thanks,
> Miquèl
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

