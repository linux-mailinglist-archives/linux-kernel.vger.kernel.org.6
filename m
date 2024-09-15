Return-Path: <linux-kernel+bounces-330029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DBD9798A4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 22:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6E71C218AA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A790D1CA691;
	Sun, 15 Sep 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pVzmRkVY"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020072.outbound.protection.outlook.com [52.101.195.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D399DEAE7;
	Sun, 15 Sep 2024 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726430916; cv=fail; b=gVDtfPAxJisFIDKMmQxV4svnxtuXG5/ctoOEu3JkoorVt5E1deF957Dh+Q3nUh8tnODi/nNcQrPhVFyMcW7ivNU0yFb8ACORPZdEkD6sm3jfTQPB9D+deYt7d6mz20mSwCxFyaEmBRy8iBr0xeALSD1EcA1tN7G0tbktM20Wnho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726430916; c=relaxed/simple;
	bh=sxDuSQScMBaGeo0h1y+LiRtkn68K6AMS9PgOv3NZSug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fzu9pNcLKvPeYgziRtca+zXmlbclm528sIk7GYMysHGwQvxTt5IEH4rakeLDOYNywrJfUJdGhiGtd6H9E5m4SBjtlBJ1LxAG+xhvjE+FbXbVDbJwRuzAkez9ju5GWpvniR2jnDU//6gxdzyjj9ggo6tdw0ljwXNvvin6hf12v7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pVzmRkVY; arc=fail smtp.client-ip=52.101.195.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsrrDC4vJSNRDvQuoNr2/rTQpCjEl8ZghVDCe2rvg5fqfp99k2dOI4mTkBVKYUx4y42POv3RyYf1I7jEPZy0ljoMR3q9btqmNt9pm2cb3xI5Yr/SBKp60pPk+MTLH0gmMy9wO/xxdnh7R8JCHxeKbQIihj0tStLgHrgrPoM/rzP9sh04RR50Cj+Y5K5D8VKhcEb0BIc5UVae141orxYzjL7Vq7X2GJ913DIociaPC/yy2XpErXK4jDT205FGG8uA8/uGsZRKQx6XLZSkmLvwqp8ScAKvzilYd62mFiISEzpGFApwt/e6jIcf130ievgz1p4erdXN2VJzkzFH7N4HOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55DjzzudYgBYYcrnuiSkzzcg+DLCf8JioRVIw+5NiTA=;
 b=pSP38Pj01BHoXlHz3iSaRpFZqgH1I1GjWJztLPovIuWeNbRKWjjvBHX0nD4tPMiG7OYlchNOaF15XpgRaFC1jESPA5TyQ2x70MF8rQeZW3HBTHyMp9vL95/9u1agGSz3331cPNQoTFVcsZZwKkkqmuno2ce7dr23RO49kDmw3CaGcG28ruws3ipy5g24A99RcHPhkcKrWtihEM/Tc6HAMgAUyfruCB0/evRLhKzuFonNt/WArNH7VU/esGjQxgVi1ayRHr7Z2C/ZP0BBckLeANjQDd5tTmx8XO7S9e1CuOq11TifxJDaiiD5PkFDuBK1qrJ49lr4mBYFvHALzNf7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55DjzzudYgBYYcrnuiSkzzcg+DLCf8JioRVIw+5NiTA=;
 b=pVzmRkVY7QxfDihOrtLWR5fzRBFTNBjLWgcJ7xXfjd7Eo0s1cNe5VKRrzcjBKhBmJ+oU3J0IoKkSCuD7Dh+VaEXPAxIA9HPPcS79iyeQIudJ/nAefiR48WscU0Sp38u9uQ0mnEBNX3sdKRS6MdQfNsb4U6jtmNVgXUn3pDZ4eP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6204.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 20:08:29 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 20:08:29 +0000
Date: Sun, 15 Sep 2024 21:08:27 +0100
From: Gary Guo <gary@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org,
 daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
 boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com,
 zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 01/26] rust: alloc: add `Allocator` trait
Message-ID: <20240915210827.3ee9adcd.gary@garyguo.net>
In-Reply-To: <20240915202242.7a16b3d3.gary@garyguo.net>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-2-dakr@kernel.org>
	<20240915162813.149e21f2.gary@garyguo.net>
	<ZucTMDCcoVH4oGs1@pollux>
	<20240915202242.7a16b3d3.gary@garyguo.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0037.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::11) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ec0843-94e3-4133-a6e6-08dcd5c22abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?71axJxR8Qn4J7HfAzVAuZXlWl0OG/HlEiz9d0FEMaM/jKc+ZcsLfJUmpGqJI?=
 =?us-ascii?Q?iQukRn3Fn29FYDZuf465yQ6NEL9t0pPV8bmF1ttPuLn/oEyqliYL2YybOf4c?=
 =?us-ascii?Q?bSSwBBfP9nc20pHjMAYh/LHPYs2IlQ/SGMQRxon+AwYT8quLI73ZflbLLhUF?=
 =?us-ascii?Q?bCaLfOf3Ks++LvLqX7WPFj7XT+FBpxKkEP8/6AOIuE6VJG9Kuzg1VdSv0fDJ?=
 =?us-ascii?Q?tUjKeOPWG3GCuDvZgmvP4xOE6ngIQuLVb+reD5MKQ/cDZXeYpfr1ssTFrwPV?=
 =?us-ascii?Q?RIBwno014xu+u8QjzjUkx/4ytAMHUc23dmA2ha+OfrB3gxKkDKo6P6nHXQ3p?=
 =?us-ascii?Q?a9WINJH1jOpS/Uf47+Wh1KssdMsOZ9R2Wim+u0XO5s4d/w6kH4VGqueUMEM8?=
 =?us-ascii?Q?8B0oBVwCegtSVAlTANHO4Jk/LRJmxEatSbddGMzsG/g37c5TuFQ4iRLdoE5u?=
 =?us-ascii?Q?+vXs9tu4IonEtbG8Qq6Imq1VejT7UdHzRCmG1Dj5A+5OvyVHC0GNNqWw1oIl?=
 =?us-ascii?Q?fGkcI8dP+mhODYEu9GkOgLuC9cSBTllB6B9fG+K6TxIQsQgopIvkydDcD1Ln?=
 =?us-ascii?Q?AckKTAbK4lo9xK3DUKZE1wWiRqo23OZyU4wVlj4uISlXbu2jWn0z/3BIyrIg?=
 =?us-ascii?Q?Ibw4wZedOW25PejbAshnOiR8Nsy10HKMzXz4R+SLaQWWRYbUH2g6//qDYxfn?=
 =?us-ascii?Q?/Q4rGrdOzzPJanp0W4IML39CwbmoclwVKOBizV6WBSiAeZHggf/MH1zrxz6A?=
 =?us-ascii?Q?9Zq9ZmEA5QeBLdu/maLI/AAMWs+MvnazVRoIEPC/rln+aU4PcEr71UEA8HEV?=
 =?us-ascii?Q?BLtmw+TfoucyaQ0KoWu7mDoB9Qm/Lt289/5rwwMGScSW3lXgmrQ6pI1MYRAf?=
 =?us-ascii?Q?JHC2cNwl92jYIWOUsx7sUt3z8K67kGVloJ35UKbl2UwG5KGjCcA679MUExnl?=
 =?us-ascii?Q?cI8T+XZ0PTxDx+5gpUxiWJgFpSJ3OrL8w+mxw/8zzH8Mm9tgQIem8NSzIbAd?=
 =?us-ascii?Q?/V1qaZQYLmWXZgdlCNMF9FrUQ1Utwe52VpJoSaA+zKDjuaAW/byHtuu5nrcd?=
 =?us-ascii?Q?VTKKYONOvnj2Lcr3k5MqichGviKgLjTcn0yguVRaZh6v16iuneM3IL3fmc4I?=
 =?us-ascii?Q?SkVGUHAumIWD+cSqHVfgVP1OL/gaqWKtm0KIDgF1RXrRAgl+PM5Oc7tRGNao?=
 =?us-ascii?Q?EVrK+GQIZh9vgmU8BTvwxPnjJ+9G8fYlvs2SIF1e42EALnCVVcYC8aN+ih1T?=
 =?us-ascii?Q?LmwPwS5620xG0wAxqNGxEdNYK6TSngnzfW5sfoNvcl14dI6eBX4NNDxKjco7?=
 =?us-ascii?Q?be4blB4VHAgUFn8cW2MlzuJFnSwYytp7DLiSHMWtd243xA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?helQBr6MZiHgkq3bv8AvmXntwZE9hx+YoB2kROHYbD9eTUv0NzS/Z/GOBaAu?=
 =?us-ascii?Q?IYbbumAD/o3WoEwSkKrIjTK9W8pZrBnP05PSIEy8I98d3RtPO8Ucq8SqWk8a?=
 =?us-ascii?Q?oKklkZxvBoB6o2x+dLBjLT3s62xKep7sRveqIugENQp5FjJ7VI+khc6EPB6O?=
 =?us-ascii?Q?UM9x33ZBX9vk0VdL49CEPTuBBizrUEBArLQzA+v2Oax5H1aCZM0bxsiNxxQM?=
 =?us-ascii?Q?HSgsOuAqMCAcuCiu/qYix+Si2SdXF4CQ4vptapj65APvTykSlyOhTtrJbnNE?=
 =?us-ascii?Q?nLmfwKUvnzIIMktrD3PUMPh6gRPxMEUC7LS3/uWRpZviGyEe1o2y3vgpjZZG?=
 =?us-ascii?Q?ig4caXh/aDhlKba7NdEuXtsmbsQ0nfRONQR1vbxha90QuRWayIbLPj6D7lu5?=
 =?us-ascii?Q?WP7jqrST8TBokCqg0o0fvRCqA+p8Sm7v01NqTAtku/NoZEfxIYIyuVD9QxDF?=
 =?us-ascii?Q?Lw31eZoA14iLlGD5/NO4ILaPN1jiGjzw7F2dPLMiaJY+yXzHx+Qagwd6UG7s?=
 =?us-ascii?Q?TDuK/MKRR+fn5UTTA3fzpei6Mm7ELkm5vF77WAEXGO1MeD/RYxdu7MbkS4jT?=
 =?us-ascii?Q?OhNg1WhMsrC2EyYoAEpTU1+yan3Io9cjhlm8XiT+fMHPlHTw5gbJxB7D0TfG?=
 =?us-ascii?Q?Ozmzd3ufZh0FxDfp+7yfF4wolZBRl/Xm8RAW9aljF0/NrtnGj89xo5+YWsYS?=
 =?us-ascii?Q?bfKS5uytPNp8heh3iBBi/o6ijdMuAbkzBS6Rfzear1GjHGiBZCl4tPtXFjFx?=
 =?us-ascii?Q?l7aIXKpdeLlBV8Cpe8p7WVa+Ox0BQrIX+ULX0O+q1YJXvbqeVZ+BicMNfXPx?=
 =?us-ascii?Q?3N00VG/Zkmho1jBHbr54+QBjXycO1vUrXV/GOpEsG3xuhxMPf77Fd/4UZCAD?=
 =?us-ascii?Q?2mbt9R38DAyx4mkCD31xZ3MeaeMHnFeW0IgP+zE0JesWNBxJ124mnOYJv5OI?=
 =?us-ascii?Q?605Z1+x4R2n3M7HfJSjdo02oqNjdsYYM61bZJy5bisuAzykA9ILxBQrBJ56j?=
 =?us-ascii?Q?YeUDdnoIM6/65pemCmGeTJ9kUSwTj20FB3ow+g1U1qLgEzGLMG0LQMT/e2Ix?=
 =?us-ascii?Q?Eo8wy2tXYHVxXg1e/8eUeko1K+X5t3Rxj8negxCQQP61dgIaDP5amW2EsdnT?=
 =?us-ascii?Q?tMR79/2z7SarEnFqmTtazvbawTQWoXzDcVUZhVNVYoNs9Zr/tPTBNj/c1MA+?=
 =?us-ascii?Q?8Oh9SZeVSmRGD5ikgrHyJyzYUQLXeYzjBIJY2gpVg86oNHoaqswii0KMXeuD?=
 =?us-ascii?Q?9gZSIIPPFF1R7NNcuWoqEwxeHSJ0aVStJ9DVPb7QDsgSHZXhyVYv8qO7EZtb?=
 =?us-ascii?Q?jmif2MuSpRe8v67B0K6EuzwLAqo1pTDFX85h3fYBu2EdOZDt8lFF6jYclFkh?=
 =?us-ascii?Q?zK5pTWjOReaBaDzRHHwoi2r4pqnmElXMXQTEbmceaUv2qrQmdc67RvdcJ9Te?=
 =?us-ascii?Q?P3CA33Yb7bqZx/e8VbgCdH37aEKipbMi3ACxK3bE8gHbdPHH/yvku6Gd1Oip?=
 =?us-ascii?Q?NYSADuat19R0dAucdrNRAdVILwiz65WnifKWRXzd6nIbLsnu0wf1yRhhPyEd?=
 =?us-ascii?Q?UF0UpAb1yZzpdfqOs3NvTfwIoZ/7WksBG8q5fmzdBwj6xjaDXbNTG5wiQF/Q?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ec0843-94e3-4133-a6e6-08dcd5c22abc
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 20:08:29.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTs7R6Mr+MAFk3qPDHD4LJrEFJRWHd2LQZJBka4v71hbzSEwDNnQdgnqEgJgeZIxcINegrQNO8OCf3+kDi/p4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6204

On Sun, 15 Sep 2024 20:22:42 +0100
Gary Guo <gary@garyguo.net> wrote:

> On Sun, 15 Sep 2024 19:02:40 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Hi Gary,
> > 
> > thanks for taking a look.
> > 
> > On Sun, Sep 15, 2024 at 04:28:13PM +0100, Gary Guo wrote:  
> > > On Thu, 12 Sep 2024 00:52:37 +0200
> > > Danilo Krummrich <dakr@kernel.org> wrote:
> > >     
> > > > Add a kernel specific `Allocator` trait, that in contrast to the one in
> > > > Rust's core library doesn't require unstable features and supports GFP
> > > > flags.
> > > > 
> > > > Subsequent patches add the following trait implementors: `Kmalloc`,
> > > > `Vmalloc` and `KVmalloc`.    
> > > 
> > > Hi Danilo,
> > > 
> > > I think the current design is unsound regarding ZST.
> > > 
> > > Let's say that `Allocator::alloc` gets called with a ZST type with
> > > alignment of 4096. Your implementation will call into `krelloc` with
> > > new_size of 0, which gets turned into of `kfree` of null pointer, which
> > > is no-op. Everything is fine so far. Krealloc returns `ZERO_SIZE_PTR`,
> > > and then implementation of `<Kmalloc as Allocator>::realloc` throws it
> > > away and returns `NonNull::dangling`.
> > > 
> > > Since `NonNull::dangling` is called with T=u8, this means the pointer
> > > returns is 1, and it's invalid for ZSTs with larger alignments.    
> > 
> > Right, this interface is not meant to handle "allocations" for ZSTs.
> > 
> > But you're right, since `alloc` is a safe function, we should return a properly
> > aligned pointer.
> >   
> > > 
> > > And this is unfixable even if the realloc implementation is changed.
> > > Let's say the realloc now returns a dangling pointer that is suitable
> > > aligned. Now let's see what happens when the `Allocator::free` is
> > > called. `kfree` would be trying to free a Rust-side ZST pointer, but it
> > > has no way to know that it's ZST!    
> > 
> > Right, that's why it's not valid to call `free` with dangling pointers.
> > 
> > From the safety comment of `free`:
> > 
> > "`ptr` must point to an existing and valid memory allocation created by this
> > `Allocator` and must not be a dangling pointer."
> > 
> > We still need the same in `realloc` though.  
> 
> I don't agree with this reading. If you allocate something with `alloc`
> and it doesn't return an error then you should be able to feed it to
> `free`. Whether the allocator does actual allocation when size is zero
> or return a dangling pointer shouldn't matter to the caller.
> 
> The fact you `Kmalloc` returns a dangling pointer for ZST is an
> implementation detail and the caller shouldn't care (and it also
> couldn't check whether it's a dangling pointer). Nothing in your
> `alloc` doc mention about dangling pointer return for zero-sized alloc
> at all.
> 
> >   
> > > 
> > > I can see 3 ways of fixing this:
> > > 1. Reject ZSTs that have larger alignment than 16 and fix the realloc
> > > implementation to return suitable aligned ZST pointer. I don't
> > > particularly like the idea of allocating ZST can fail though.
> > > 2. Say ZST must be handled by the caller, and make alloc function
> > > unsafe. This means that we essentially revert to the `GlobalAlloc`
> > > design of Rust, and all callers have to check for ZST.
> > > 3. Accept the `old_layout` and use it to check whether the allocation
> > > is ZST allocation.
> > > 
> > > My personal preference is 3.    
> > 
> > There is also 4.
> > 
> > Let `alloc` and `realloc` return a properly aligned dangling pointer for
> > `size == 0` and don't accept dangling pointers in `realloc` and `free`.  
> 
> I'll consider the API design to be bad if I can't pass allocated pointer to
> free. If caller needs to handle ZST specially then we might as well
> just ban it completely.
> 
> > And 5.
> > 
> > Reject the combination of `None` and `size == 0` entirely, as earlier proposed
> > by Benno.
> > 
> > I'm fine with both, 4. and 5. with a slight preference for 4.
> > 
> > I'd also go along with 1., as a mix of 4. and 5.
> > 
> > I really don't like making `alloc` unsafe, and I really don't want to have
> > `old_layout` in `free`. Please let's not discuss this again. :-)  
> 
> I don't buy it.
> 
> Your argument for having `old_layout` is so that the caller doesn't
> need to care about the size. But as demonstrated the caller *does* need
> to care about whether the size is zero.
> 
> Our previous discussion doesn't cover the particular case of ZST and
> you said that it reason arise that we need this extra parameter, then
> it could be added. It feels to me that sane behaviour when it comes
> to ZST allocation is a very good reason.

Just to add that if you *really* want to avoid the old layout param,
another approach accceptable to me is to have a `NonZeroLayout` and have
`alloc` only accept that.

Either `Allocator` trait handles ZST well or it refuses to handle them
at all. No "it works for alloc but not for free" please.

Best,
Gary

> > >     
> > > > 
> > > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > ---
> > > >  rust/kernel/alloc.rs | 112 +++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 112 insertions(+)  
> 


