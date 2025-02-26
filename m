Return-Path: <linux-kernel+bounces-533710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DEFA45E07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5620D1886251
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECAE2163AA;
	Wed, 26 Feb 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="nuBLeMa3"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020141.outbound.protection.outlook.com [52.101.195.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42C13A88A;
	Wed, 26 Feb 2025 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571073; cv=fail; b=uqYL2gNZdJ5EbEV1oK5PqZZ2nd1MQg00mjhydUeUfNPv95d8JBdyh50Y9mm5LEvAGH/Zd7vEdBYJ+5S9g20LY8hi7h7xSt5jPs5IO20xH56v5eAmxA9S4DOgjuG6L6CdpJchGl4zQftT+Nz/mdkV7bq9DLMP6nE7+LOzu8vtrfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571073; c=relaxed/simple;
	bh=uuRbqAxkDh+lI75jitsWtCrnz0niEI0soJna7LPfpDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SVAuSNwIh0Bk535B5pe/Pe3Ypqual3ogXbDqfc8CGcFJ0PTgCUsPIJwEt7quc573d7j48f5HIsjrl2o4rzzIMlrKPruGDXqm4fZq0yupsz0J7YbmsPPMtrrl0oE0WCwDx3hxCUt100c831yH54S3zaKi62cCASKOdCcR/8aSNFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nuBLeMa3; arc=fail smtp.client-ip=52.101.195.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rqit6h+NnxGlyArTokMpr2eRCF9ruiOS+SLORYTMRU7mJe7Nf+wXLtUUALmxkRIPwpKWH76ExJYdeZSW2iAAb+lX2Iay70Bzdbs/X9ckLWJn2r7Wvf6MnYzsZdd2Ncn1pcvqxxJqhDE72WU8UTz9dlZxzecIGdiZo+Tzd+rv+7AC1uyKnxdpB1CEZab3fby8xVp3qcINELJOBNi2oB5SsOe4kwA3e6Wsx5zZ8Uyqs1lohh3jZYDpPMer4lDpuyLgCBxdv69Zijd3robqQEYKI1HuD33CgTBUvUVd1vgStwJRBk56dGmuja3IJdyUzjMIOfNTpYh0Zm/iJGqlAnptFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7HqFOjV42iJPd5Wl8RBtrSDpJRZQEIJt6MqYA0OKw8=;
 b=whgrfUarER+fnfoZaTwxKIJD2GHJ+7eM0+9CZ4IJizx2WJssCsMXIqtMSgeRCmhBaXc16vZCNLaShkA0sGaGFPdWvKr/umQW/3JyAk5Nsfv/Qnqk7n6e27IG8xCZWHY8PUykXnI1ch8XblQo6zme44E6D0cDzZyrkmU2C+UcIpoqWFuXcggXr6lPL6cD3wXpd/B+FWn3cgmpjEBqD/iQt085XUkW5mvEAwzUz6hJGJAgrjaFgerm/wYQRvQyIWtC272i2yZ32HslQuzKH5+GGBHYczyY9sMCdMX+oJKjlF/vGcftvqVDi8LmLB1e6RI3mDZ8FbUsUvR4jvgFoaTFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7HqFOjV42iJPd5Wl8RBtrSDpJRZQEIJt6MqYA0OKw8=;
 b=nuBLeMa3/ihVbp+dgvTlMtV3bSSQSBqEGhAlXKbb5HfeCA7YZNZwq4yCTWEE4SzcnBfmDy9sUcdlA5I8OGLZ5FnNQwwMa+UgWZ/l7g3sCiH8lnMZ5yOfTaJg+SnLR/nU/dKk3d+QISneDwtnoY8NsZBShdakWZxFa/J3nkyt1yY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6674.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Wed, 26 Feb
 2025 11:57:47 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 11:57:47 +0000
Date: Wed, 26 Feb 2025 11:57:44 +0000
From: Gary Guo <gary@garyguo.net>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alice Ryhl
 <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>,
 airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com,
 ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
 ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <20250226115744.024184b5.gary@garyguo.net>
In-Reply-To: <hofm7mo46jzkevpr6fkqe2jnl3zrp5uxdux457hli3ywkneaij@yhhibsnuqfny>
References: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
	<6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
	<CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
	<CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
	<CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
	<CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
	<gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
	<CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com>
	<4l6xl5vnpulcvssfestsgrzoazoveopzupb32z5bv6mk23gazo@qn63k7rgsckv>
	<CAHk-=wgMnSOnaddFzfAFwjT-dGO9yeSkv6Lt21LgWmCKYCM7cg@mail.gmail.com>
	<hofm7mo46jzkevpr6fkqe2jnl3zrp5uxdux457hli3ywkneaij@yhhibsnuqfny>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0505.eurprd06.prod.outlook.com
 (2603:10a6:20b:49b::31) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a09c30b-6600-4a2e-d5dc-08dd565cc95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tF1hH18i9He2Jq0wEtz+vMpWcEKAivbJOnikGGKNHWbtEDGv6St2iu+jNTU/?=
 =?us-ascii?Q?iSnqKE4Fr2IdWVn0Cnyeo7Vu/th3yLXqZ45QXkWDTC0p8TTRoO76Zz+6f2QY?=
 =?us-ascii?Q?4wr2kKH2uY6MHE9B0xFf9cmdXSe2sYhNegKBEUqlb6WvCWynOXvSVbkx8aNn?=
 =?us-ascii?Q?Sp10HT9/AGP9KrCwuQlGehdhIQVdIPy8jQ4c7ucjgST3cZa+bJeIlSSdsOGH?=
 =?us-ascii?Q?qi26qLmTX9kkX+M1g5rxhZzJKsN2K7I8mwKZ6t+QljwWzTX2aqpmtyWXvZcv?=
 =?us-ascii?Q?PDCTecBIEa+8VqlaovrqPRbjj2d3gmGB+GyB8wiWZ//Pd7hpg2ugVteDFH72?=
 =?us-ascii?Q?nBVVASDcYld3dtwh+C2bLprhn2cZ6OhJbf937zYLaoyNNug7OJuKvOVt+1NM?=
 =?us-ascii?Q?QZwXrtIDSvGlj94PeMDL7OHy/NC5/xmH2IBerJhlmkxEqa7X4DHffP7Yp/CK?=
 =?us-ascii?Q?OekcTwvnLkYpjc7AkmfsDjUHMP89L5O9lZVY9MR6lzbYiNqlxrqg4u3zfbPW?=
 =?us-ascii?Q?cLwxxSNZajY+8rZx63nWuhLeL23WcRAPqaw1etkwBpYpJr1KhvquSyuMrrin?=
 =?us-ascii?Q?U4iiGP8KPp8ltysGzW+1u8EKAB7Dr3x20fdieSkotD0NPxttLRcgBNN64pyh?=
 =?us-ascii?Q?v7+mcdVk84M7HZMrMktd3L1B1yMDw9hCCkZjuvh2P9bDkPzxKvFVvjv+rp2v?=
 =?us-ascii?Q?l/vHs6+LaGQywZ25GH3VwYCFyub+zRL5kKRorXRoaUGOWu3mzzSRwhfbsnfH?=
 =?us-ascii?Q?uMKQvJ/pP74NMSPjvZp0dk50tx0C8sPlrLZxnKEwcPXCRZQFAZxKXCtczhZj?=
 =?us-ascii?Q?PJBWc+VaTw42YqvRfGf1o06tLYaKblhDxpv/uhOmoDZqh8a05wAXqoemmTau?=
 =?us-ascii?Q?irfn18gFNte5kl896faxn7G8TwzUgBeJGe0qhdKRi3R37vHLDsA5ORUJCoxz?=
 =?us-ascii?Q?VfHE9j/smH4k/bD9EAONGFNKvY9ZF12+qtxo19Z9zVs73hbqs9Mw/Hysq3e3?=
 =?us-ascii?Q?lO039kg4tLsbImIT69gkk2IqDheDHigNowao1Fj99nrXWWVB5UKruZ9F8uhM?=
 =?us-ascii?Q?R0B1qG/KUxEvknw9MEv3gxaJNTkycLS40I16R87anRZ013qcFznFiHB+izGy?=
 =?us-ascii?Q?nnI50MJDC+Ypv/qCiE+tvJa9mHEfOJALNiG+7tHckEQXUz2FYWCWqhA0cdRv?=
 =?us-ascii?Q?4uZnjJISIE/J1LI04BqQbpigX/t1rILC4hwvL1dz9qsThR8BaX5Y7Ow7kmw5?=
 =?us-ascii?Q?jAWOyezO0Jgmv5DjCYVcmsQxptYkrfpDObuVl9loJBdUHgyfIhYubmVZLYz6?=
 =?us-ascii?Q?BKglPYGEGnad/uEscvEpymDY1VZWOjtJSqDPdPDQ72CfR1MpG4lu9e8z37Cw?=
 =?us-ascii?Q?U38I68st//CrmvUgJfudizP2Q1om?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PcN24a+qmJyBrpXmqU1sk+mjWe+C8m7FNvpELANl4BZ1JQYo5Y7FFbV1pQPP?=
 =?us-ascii?Q?MAhhvwOUq7vIAgvi9/kmcEevLSZ6lVAfwHr/NsryINxDiTux/nKlKGbIOV+2?=
 =?us-ascii?Q?doDQbTn0QxC+VrsF3GsU/wAwGYrCr+8Y6gw5ygTIf9S9ZWgOH2vDuBlbMMS8?=
 =?us-ascii?Q?SIQKas+ZZokykGyiQnOAEpvKo5qkahPBmgb5QPWCpxSRsyKG4P+ik4FiKMk6?=
 =?us-ascii?Q?1SiORUJatlklguToDNSCa0rFRQnQ2dh1eWjg23pls5B8h9VOallCcUEkqilg?=
 =?us-ascii?Q?cfFSnBMgoHF58bWRsA1D+a52V8PL3MjrxO9tMoLnUTyHI5mTrAa/upS7mzWJ?=
 =?us-ascii?Q?s6FE5bo5rnXdEJaPIEU0M9AVityL6S8pQ1rte7MZhH+H7dPoBOCLROx/OyNU?=
 =?us-ascii?Q?RtFRKZGYqfiN/D1TqEzSigZoAvrzef5aWhZlXEb3+bQFDOtMv/gRz+w5iAah?=
 =?us-ascii?Q?EaYcIKRpNf3mhdUN1iHZamIjaThCFVm2pxu6AM5kpHYO7VIfY3fTg2h/m62Y?=
 =?us-ascii?Q?X9McQ2pookIaicLDcsYXf6+a/zDoI9cT4jyv6lfxSK5UAKlvi67g4utsEgdl?=
 =?us-ascii?Q?MjP83BTAOMVapyeDHImcn6RPJDUS0c8M7/auZBQlPWBl8XKjgMupjTMiSg2r?=
 =?us-ascii?Q?3oPgeesGHcax+raTYvcucjzkR1Tvh50jcDlxgT95KuLWwJw3roaMh39/w/lg?=
 =?us-ascii?Q?2AD9jZ97cL7X5yKRHaeO6DLKpeJzCoQ81h3DzHjtc03vRDxZ4wvOjN2ahuSb?=
 =?us-ascii?Q?fYap2L99Dgwcw6QnZjKWiZs07g7MJcLFuuCYV33O6FMFI2Rrj7d1X8JKv4Sx?=
 =?us-ascii?Q?38bKBpTtJelLurRHxLLxTt4JAEmE//gDpKaVB5iYwF0rJ/XIP30RzI1bIgiW?=
 =?us-ascii?Q?K1bMDDOD5bIaC+ycpmV4DAUniAa+kNFWaQ0Ckvp4RvrstPvOGzSR/fiEiR0z?=
 =?us-ascii?Q?SxT76wyyfJw5c1ytQxN3Q3FR6pooBNQkpa5Gk5h2p/ZerDK1CJUlWK9ei3FH?=
 =?us-ascii?Q?ILqvqB55GjimVjGHHLjv3qr88m6tBGqQwkwtuICEVFfcBtWL/dht+ZeowMS5?=
 =?us-ascii?Q?6IOiRdg/h93+/P36IMRYQ1J7FvkTo+DuqfsynBQYs/SITNWVbdDQrsH9X4pn?=
 =?us-ascii?Q?if8X4HvjLKTQ97UTyNcgk4zRn+XcJjxT9qqnR1CXXq2+kilu9vVhEFTR6ZmK?=
 =?us-ascii?Q?q1jN4mnEjAtobcdueTVL8jbG66QJCloQgOW5ac6gql/2Sdn+iYXfUJvSKTfs?=
 =?us-ascii?Q?g2smBzkE1t+H6iNedS+57uixqSlqDqyRV8UitUdXXV7va5jFFj4SpHtN2iiX?=
 =?us-ascii?Q?koGYTyh7W+i99gvyhdJl2fNYXULrP+KJUiPnX5RlpzEC5tY8crIQy9HzoBTG?=
 =?us-ascii?Q?o+x4ERgkftlogHCoeb4TW2SXFyZU4883ItTgo675c6qzca2bC8sj46C3VBGh?=
 =?us-ascii?Q?aYlKpKA8Aixv4BKwd3RyQ3q/a5v1Z/C/F53tVTfXUoVvzIix6f2Wz5vZDOB6?=
 =?us-ascii?Q?ew9KZxnNG+2Raeee7fejhIqM+tBcPDK2X8aag0gG8GccESz7jtSaY9LstIKu?=
 =?us-ascii?Q?4LiZsRfkKOp6rhUV7dV1OmFFSTgT8xXEteUGzI01bR9UwcYBMmiyeljKQvE4?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a09c30b-6600-4a2e-d5dc-08dd565cc95b
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:57:47.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdnD2LlQiALPCLaVgUJ2nfNXUFNhvochDgo80JvqgmxApsimGt51wlPa5d21Ln6U4Lf158/932JJ0UHVaxZ/3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6674

On Tue, 25 Feb 2025 18:34:42 -0500
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Tue, Feb 25, 2025 at 01:24:42PM -0800, Linus Torvalds wrote:
> > On Tue, 25 Feb 2025 at 12:55, Kent Overstreet <kent.overstreet@linux.dev> wrote:  
> > >
> > > The problem isn't that "pointer aliasing is fundamentally unsafe and
> > > dangerous and therefore the compiler just has to stay away from it
> > > completely" - the problem has just been the lack of a workable model.  
> > 
> > It's not entirely clear that a workable aliasing model exists outside
> > of "don't assume lack of aliasing".
> > 
> > Because THAT is the only truly workable model I know of. It's the one
> > we use in the kernel, and it works just fine.
> > 
> > For anything else, we only have clear indications that _unworkable_
> > models exist.
> > 
> > We know type aliasing is garbage.  
> 
> The C people thinking casting to a union was a workable escape hatch was
> hilarious, heh. But now we've got mem::transmute(), i.e. that can (and
> must be) annotated to the compiler.

Well, you can still use unions to transmute different types in Rust,
and in addition to that, transmuting through pointers is also
perfecting valid. These don't need special annotations.

There's simply no type aliasing in Rust. In fact, there's a whole
library called zerocopy that exactly give you a way to transmute
between different types safely without copying!

I can completely concur that type aliasing is garbage and I'm glad that
it doesn't exist in Rust.

> > We know "restrict" doesn't work very well: part of that is that it's
> > fairly cumbersome to use, but a large part of that is that a pointer
> > will be restricted in one context and not another, and it's just
> > confusing and hard to get right.  
> 
> And it only works at all in the simplest of contexts...
> 
> > What we do know works is hard rules based on provenance. All compilers
> > will happily do sane alias analysis based on "this is a variable that
> > I created, I know it cannot alias with anything else, because I didn't
> > expose the address to anything else".  
> 
> Yep. That's what all this is based on.

Correct. In fact, Rust has already stabilized the strict provenance
APIs so that developers can more easily express there intention on how
their operations on pointers should affect provenance. I'd say this is
a big step forward compared to C.

> 
> > So *provenance*-based aliasing works, but it only works in contexts
> > where you can see the provenance. Having some way to express
> > provenance across functions (and not *just* at allocation time) might
> > be a good model.  
> 
> We have that! That's exactly what lifetime annotations are.
> 
> We don't have that for raw pointers, but I'm not sure that would ever be
> needed since you use raw pointers in small and localized places, and a
> lot of the places where aliasing comes up in C (e.g. memmove()) you
> express differently in Rust, with slices and indices.

On thing to note is that Rust aliasing rules are not tied to lifetime
annotations. The rule applies equally to safe and unsafe Rust code.
It's just that with lifetime annotations, it *prevents* you from
writing code that does not conform to the aliasing rules.

Raw pointers stil have provenances, and misusing them can cause you
trouble -- although a lot of "pitfalls" in C does not exist, e.g.
comparing two pointers are properly defined as
comparision-without-provenance in Rust.


> 
> (You want to drop from references to raw pointers at the last possible
> moment).
> 
> And besides, a lot of the places where aliasing comes up in C are
> already gone in Rust, there's a lot of little things that help.
> Algebraic data types are a big one, since a lot of the sketchy hackery
> that goes on in C where aliasing is problematic is just working around
> the lack of ADTs.
> 
> > But in the absence of knowledge, and in the absence of
> > compiler-imposed rules (and "unsafe" is by *definition* that absence),
> > I think the only rule that works is "don't assume they don't alias".  
> 
> Well, for the vast body of Rust code that's been written that just
> doesn't seem to be the case, and I think it's been pretty well
> demonstrated that anything we can do in C, we can also do just as
> effectively in Rust.
> 
> treeborrow is already merged into Miri - this stuff is pretty far along.
> 
> Now if you're imagining directly translating all the old grotty C code I
> know you have in your head - yeah, that won't work. But we already knew
> that.


If you translate some random C code to all-unsafe Rust I think there's
a good chance that it's (pedantically) undefined C code but well
defined Rust code!


