Return-Path: <linux-kernel+bounces-329927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEFD979791
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 17:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB95B20D98
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDCC1C9841;
	Sun, 15 Sep 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ln56yi6Q"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2106.outbound.protection.outlook.com [40.107.122.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0E95A79B;
	Sun, 15 Sep 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726414101; cv=fail; b=PfjFSFRUQRnJE1I8G2UsFhmQRFliGtH4+rSsLwPsVzntKDeZc7p/3kJL55F3S8NeCjPOD2j8MXSm7uDoOYz96MKy9VyXjSYeJoe87sG9BO9sLwT2hgZphNq21xUaYrQI+h4XCx/HN3wJsDZzWoOMH0Oknby/KoqQn2FlbTAJIbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726414101; c=relaxed/simple;
	bh=FXH4VZElxMMS0V4oD1zftgikf75batzbJbHgC/gxmfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h20iC5kArouaGgcDdu04zH3/N0u1qa3tfJr449szAs0x29g9wNNbOgViWGkoTVirqs8lkFXQpqa870tAmHJalSfwNiQIrDzEJbCeZKXdbIq0FHcEV0Pqwt1BtkiBVCK0n4I033QHiMtxqB6Vut2J8CUFHCxcv27Sq2QfEp+znzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ln56yi6Q; arc=fail smtp.client-ip=40.107.122.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVghCejYF27QwHWG8zHzrDB/xTPjLPI+bPEq1XByVlfD7uN3fBW8buc1WKW4zsLDupVI5dG8jA79ns7DX5F8lGGMnKj/s+3RuM0Gfjh2NlfPEJaEjd9+8vQVjj4yytS/8w7lr+t18TWTQGjQAFo6NWZ00VP29k/SVk//DqZJGO2EYtPPfbZeJa6Ki8YiTgYAM3eY6M770KTy56LGPeMVHgaPXbvxnmPmn9rSrDAXKpfcbN0AZ4oaeoiycQNnfnyAhLN77zr9gSctpZA3+o5KPe+SUYZf5peWf2JakWmFhVjw2gB9MW9KcYUMW9ef//F5yctOoNCFhiWTgqucheqhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5HTMH5JvtmzpX/bxBl5bRADLAnopzwh9bOxfIxhdbA=;
 b=aAk70RE4btV9Z8mxp11oK1I0bi8CIt50lEOJJfpF1P7rAwnvFS9t8Cu1PZWwSjuZ+R0bBOrND4BL4y9cyTITwWuRaQEPs0ygR98pNzPrDR15BCFnfCwZKqqLPbEiIe0XmRipLnaf9nlbkaKlWR9gIrsOp8HUzf8DLPlIIBhdFloE2lfOHAN2wVTs2ezGqNVRTUf1KYJfcy254qgwdNDMv59r3hhudGAdF415Y/xYPfvbuYF5WMNnajcrz9RKgJujW9euSVsOvqginX6KWD+61OIb1T8GCVHXX/Rk0vUHUNmbV6y36QxhJYhnZj6ODOqJvIyBoDquQIkWNN7grLLDLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5HTMH5JvtmzpX/bxBl5bRADLAnopzwh9bOxfIxhdbA=;
 b=ln56yi6QcB7Iheem2b4uev9lZpn8W4fKo58AuEpcFGNxKhxhwAtEvttYo/yrnRHj7PuPYDOUe+ysoSd/RhOXZu0dihn231V7Q73mmM2sCJhh3+xBL/DKy1ioJU/wgMI0LFoPtDSj1gZVsC+KuRRZ2pV96xklas1UgokfgtG0+bU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB1767.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:41::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 15:28:16 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 15:28:16 +0000
Date: Sun, 15 Sep 2024 16:28:13 +0100
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
Message-ID: <20240915162813.149e21f2.gary@garyguo.net>
In-Reply-To: <20240911225449.152928-2-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
	<20240911225449.152928-2-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0063.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB1767:EE_
X-MS-Office365-Filtering-Correlation-Id: 3462624b-49ca-48fd-f1a7-08dcd59b04dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j5AIRvoN3ZdYx6u+3PoWvN+HRpWys6/3yEKtpOtwZX05QnMhgJvxfCxt6MEL?=
 =?us-ascii?Q?KPBgdUtJkuCJWn2y7OOaHDl/sGBYIfHtBwbuHCcK5cdod83/GX9RbOAapTg7?=
 =?us-ascii?Q?vVmS25Rxepd0shL4cOvZagqDlRovgRtW0wseCLQ7i9Xj0vxd/ouIp+QhbDu8?=
 =?us-ascii?Q?oEHiYLJBt0+alVr7SkiaO+/bAL5JWyYMEzsrE981R+ub2ZCpSNErsToUlADx?=
 =?us-ascii?Q?4lePlPE5F8A5OE15uPBYBskvF22cW/AR9OCL9faG9GWRHO78aeGeHFg6Ip/c?=
 =?us-ascii?Q?6XhLegC6UUihXTcQnMeimda3tIuIiToGuyySZFpv2PJAk3pnUv0Kngrx9S4R?=
 =?us-ascii?Q?XDAKO2o4b9XmeSJK7NyIT2lS2UfYKGFoBFZyNYhE+5mR0Grtq4llcpI8k7oK?=
 =?us-ascii?Q?nSqu5ZZaC4fXkhYpIBzp0CwbQvKHTlfa7sGt0+TFbx6jRcBs6kMgFSHTHDUt?=
 =?us-ascii?Q?raCwJXdhUd97kMkHFPRSe6ErEHyEOzNzOakq1XdJl2VmUngh62+ALNDu7+pE?=
 =?us-ascii?Q?6CO+TIHXNrWY/cRO5ar5RUdFauJ1Xdr13mbjvNLUAn00NcnMOTH0DPIxMH7+?=
 =?us-ascii?Q?6e1/UCvdNqske7OY+7ErpH3Tl+7ZvI543Ix/wrgQJX5IGJdvqiRojSum/XMj?=
 =?us-ascii?Q?O9zhEeMfVzceVlrtFPRvX97WCurLGjQQPmbIWtEF+Wu5FUSrZgKOTm4IMCj9?=
 =?us-ascii?Q?zeufxvAWu91ETU3z/lq3s0cunEZzQNVGgVj1SrgpUxQyOQHkfxfPTQeAhV3u?=
 =?us-ascii?Q?WoJBZAI+0oTj8h953UwhT9WA6NWBnr8HVhJwoJOZKOhmRAFYqQMjqyryPLy1?=
 =?us-ascii?Q?3cA8EBXNj9j7boQJChr/sKp280ag6lLBlw7keM4Zw7eD+gSvmGR9pH7yYnlD?=
 =?us-ascii?Q?bSobouKXTjBJBFMYYJtwjvfj1Te2DMHy/OJsHwpvj22aI2UVl1DmaWf1yFhS?=
 =?us-ascii?Q?PaciQAW0aT2iKy5OoRdUHNvGoBP9Asb2cg/+5ndqKFCztQZa8UjUB0Tr6PxC?=
 =?us-ascii?Q?nPmijXJn0FiPGwU41Yrusl69L+hxa3G6EfciuNpfiR2WYwWtXo/Xtq09nkH9?=
 =?us-ascii?Q?Dg6A7E3wqO/B5E+SVc4ouz/um3xSTXV9+G43dhnElhvF61cPT4UYqFs4Nd+1?=
 =?us-ascii?Q?a+M46Ncb+m3igSUhL9OhfAQ6+Mqgg2he8d+Qw667qezN4RRFUPEI/aBJ1X6s?=
 =?us-ascii?Q?hPMbhxcQEbVUc+4WMWoMkfOxso1ULXo78eznu27kmLP127wmKHFybUyIbf5X?=
 =?us-ascii?Q?GG3jwByEqWmh8Txe1Ojl5GdbKo9G9defwDA4Xgr4UapKPMMIxG2YEI3a/eDy?=
 =?us-ascii?Q?B6XS0OPxYw3TwS4Jg4acP6jkOOIBnncxVDZWO7kqqB5LRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FpGWkUMKkPHajGHZz0Zf1JtxEspEZuh2KTtFNhOfUfjBKx4j9HakP+kVvUgf?=
 =?us-ascii?Q?q+QBNOYiMZg6X8xiuRie2lD5eQGBzJfOy2yWE7PrhgOJGC4xgJ3oLSFsEMIL?=
 =?us-ascii?Q?Nifr+r2dx6KuOswL0Huhb6qKQH/eCPN5Lvl9nNQzAaU1IwyDl/Aj4eJDTBOu?=
 =?us-ascii?Q?YORQioPs3WZd1aKdxEdmAG0m3sE90EOTpkgpORNa6BB4WSgtN9bHLRK3OdeW?=
 =?us-ascii?Q?VocZxXqC0sV3tED1FMei7YEu+irxiR6YnkghBYKaPjfInUTaGBGYL7u4Rd3q?=
 =?us-ascii?Q?J5c4xTcBQngT0YH2Ey9EihEAyYuFhmUEA4AXOcFgBBEG/ysAFoUkQA23u7bp?=
 =?us-ascii?Q?T9B3jC3VippV1e90PEdtg4anuLTZPWURVEQHXnTALQ4jA++Uq7bhNkVIAWHX?=
 =?us-ascii?Q?+Q1f9I3zDA3Ud630irKRnLtJW+fhSInnUJDjRzAX7q3pTBtNuck5AlfCrB5J?=
 =?us-ascii?Q?Xn9eEZ0RO9RSfrhGHuyRF/+cCAZF1PAr8cp4Ly6KbhE+3BT+U/VvJ+PQkIyJ?=
 =?us-ascii?Q?1KCkHAowgSswcjZL+6IR+q93tm+iY0auxviexOE9Qp2XClejuTgimJVBHOxY?=
 =?us-ascii?Q?fj2bP4Vrm4oxKIC/dKK8nbb3QceT3R9V4Gqcwm0aWcKpF+snM7kSs1HfM0wG?=
 =?us-ascii?Q?DeXZx0Kal+BLkAtsKbCgIQMv1cpC3ng3Pkio21zRgf8t/NDtL3mYI/RAJ09V?=
 =?us-ascii?Q?Fgnptzx/kbUmKENuIV2t1VMyxDFlXzv+Ci7qe5AqqPnPIiXHUDabDnYadOK9?=
 =?us-ascii?Q?CP4DteMU07PuLNkJdFlhTWtkTttrSYaXNnUvQI18y/5nnYCy9w9bjhC/JPua?=
 =?us-ascii?Q?mVA23bmfwDtC85UZhdZyeIZTcaQRB8xtEojk99+zHf3PGxQ7nTGWJdTR8M9S?=
 =?us-ascii?Q?upz1y6mQkLs33aI46q6jmYuJlicsI0YnjMD1mKx8FZpy25k0VXxKUvUfuEiT?=
 =?us-ascii?Q?Wi8Wg0ueFnU5OGOBV4oCGwNCEXF7BdheUaW/OYmacm5BtMcLVPiTdIBSbmKX?=
 =?us-ascii?Q?jLB5Zoido9rV/o3DDaki2SjRaK1Sol6UhVoskDb9nyj9TDTQM7Z3OtKH3STu?=
 =?us-ascii?Q?PvyWFNrWk1f5YyXS1CGD4Sw5k8Jbcw9OnvPZxvJ6FFm6QpMNEqtrUN1t+tzD?=
 =?us-ascii?Q?PJOxIRQfo7Fnuw2iswjV2Osi9/Ey8pJzWB7vOwnYcG/b31Ix48D3FspGAcXS?=
 =?us-ascii?Q?nT85cFgaa1SqUDt4OYbfJgN6Pqy+E0HXIBYUwRXowPg+RuiG9GQXtpMMFswv?=
 =?us-ascii?Q?RU2CLnj88KnAwjQIU1hZBvNh5sI/DBY1rnKZCFQjHN106Z+VIv1Lpm1V7SG7?=
 =?us-ascii?Q?smwv9GEqZIDE7DLIREU/HvXdLxjkYcFMWLlnQ+Rpgc+ftapL9xjhTIg6Gtlx?=
 =?us-ascii?Q?N4/jxeZszkkIPwhgB+Kla2LHm4O2j8UsbminYmEaSKsMHqe1ZIcrsDdX+IL+?=
 =?us-ascii?Q?pi/sSTmQyuYjfuDTM6kFPjNaPky7zLYmYy3RGEjGb0xocA2qh87mtNuisSTS?=
 =?us-ascii?Q?OX65uczAf/WTcl+VynKeY56HFtmEonwiN6zBOqkX7omDQfFWNyD5hq14o57t?=
 =?us-ascii?Q?OWq6Cco/0fKaJ6Amxxyls1GUGtZXPQkKNM5NzeA92zBcxgbhxis1ffLqfBDp?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3462624b-49ca-48fd-f1a7-08dcd59b04dd
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 15:28:15.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nyQdlnBMId4F8nHKWLiZ5t95EwPAJJaA6GbhDmsa59uIAc98edYGdVsqvBu55yxwXaXO3JFuKW0PZqOxsS7oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1767

On Thu, 12 Sep 2024 00:52:37 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Add a kernel specific `Allocator` trait, that in contrast to the one in
> Rust's core library doesn't require unstable features and supports GFP
> flags.
> 
> Subsequent patches add the following trait implementors: `Kmalloc`,
> `Vmalloc` and `KVmalloc`.

Hi Danilo,

I think the current design is unsound regarding ZST.

Let's say that `Allocator::alloc` gets called with a ZST type with
alignment of 4096. Your implementation will call into `krelloc` with
new_size of 0, which gets turned into of `kfree` of null pointer, which
is no-op. Everything is fine so far. Krealloc returns `ZERO_SIZE_PTR`,
and then implementation of `<Kmalloc as Allocator>::realloc` throws it
away and returns `NonNull::dangling`.

Since `NonNull::dangling` is called with T=u8, this means the pointer
returns is 1, and it's invalid for ZSTs with larger alignments.

And this is unfixable even if the realloc implementation is changed.
Let's say the realloc now returns a dangling pointer that is suitable
aligned. Now let's see what happens when the `Allocator::free` is
called. `kfree` would be trying to free a Rust-side ZST pointer, but it
has no way to know that it's ZST!

I can see 3 ways of fixing this:
1. Reject ZSTs that have larger alignment than 16 and fix the realloc
implementation to return suitable aligned ZST pointer. I don't
particularly like the idea of allocating ZST can fail though.
2. Say ZST must be handled by the caller, and make alloc function
unsafe. This means that we essentially revert to the `GlobalAlloc`
design of Rust, and all callers have to check for ZST.
3. Accept the `old_layout` and use it to check whether the allocation
is ZST allocation.

My personal preference is 3.

Best,
Gary

> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs | 112 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 1966bd407017..6c21bd2edad9 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -11,6 +11,7 @@
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> +use core::{alloc::Layout, ptr::NonNull};
>  
>  /// Flags to be used when allocating memory.
>  ///
> @@ -86,3 +87,114 @@ pub mod flags {
>      /// small allocations.
>      pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
>  }
> +
> +/// The kernel's [`Allocator`] trait.
> +///
> +/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffers described
> +/// via [`Layout`].
> +///
> +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
> +/// an object instance.

I think whether the Allocator is ZST or not doesn't matter anymore
since we say that functions do not operate on an instance.

> +///
> +/// In order to be able to support `#[derive(SmartPointer)]` later on, we need to avoid a design
> +/// that requires an `Allocator` to be instantiated, hence its functions must not contain any kind
> +/// of `self` parameter.


nit: this is the reason for `Allocator` to not have instances, so
should be merged together with the preceding sentence into one
paragraph.

> +///
> +/// # Safety
> +///
> +/// - A memory allocation returned from an allocator must remain valid until it is explicitly freed.
> +///
> +/// - Any pointer to a valid memory allocation must be valid to be passed to any other [`Allocator`]
> +///   function of the same type.
> +///
> +/// - Implementers must ensure that all trait functions abide by the guarantees documented in the
> +///   `# Guarantees` sections.
> +//
> +// Note that `Allocator::{realloc,free}` don't have an `old_layout` argument (like stdlib's
> +// corresponding `Allocator` trait functions have), since the implemented (kernel) allocators
> +// neither need nor honor such an argument. Thus, it would be misleading to make this API require it
> +// anyways.

I would drop the "honor" part, and drop the sentence saying it's
misleading to require it. The documentation should say why we don't
have the `old_layout` argument (because we don't need it for now), and
shouldn't be trying to dissuade it from being added if it ends up being
useful in the future.

> +//
> +// More generally, this trait isn't intended for implementers to encode a lot of semantics, but
> +// rather provide a thin generalization layer for the kernel's allocators.
> +//
> +// Depending on future requirements, the requirements for this trait may change as well and
> +// implementing allocators that need to encode more semantics may become desirable.

Not sure what's the purpose of these two paragraphs. They sound
contradictory to each other.

> +pub unsafe trait Allocator {
> +    /// Allocate memory based on `layout` and `flags`.
> +    ///
> +    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
> +    /// constraints (i.e. minimum size and alignment as specified by `layout`).
> +    ///
> +    /// This function is equivalent to `realloc` when called with `None`.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// When the return value is `Ok(ptr)`, then `ptr` is
> +    /// - valid for reads and writes for `layout.size()` bytes, until it is passed to
> +    ///   [`Allocator::free`] or [`Allocator::realloc`],
> +    /// - aligned to `layout.align()`,
> +    ///
> +    /// Additionally, `Flags` are honored as documented in
> +    /// <https://docs.kernel.org/core-api/mm-api.html#mm-api-gfp-flags>.
> +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> +        // SAFETY: Passing `None` to `realloc` is valid by it's safety requirements and asks for a
> +        // new memory allocation.
> +        unsafe { Self::realloc(None, layout, flags) }
> +    }
> +
> +    /// Re-allocate an existing memory allocation to satisfy the requested `layout`.
> +    ///
> +    /// If the requested size is zero, `realloc` behaves equivalent to `free`.
> +    ///
> +    /// If the requested size is larger than the size of the existing allocation, a successful call
> +    /// to `realloc` guarantees that the new or grown buffer has at least `Layout::size` bytes, but
> +    /// may also be larger.
> +    ///
> +    /// If the requested size is smaller than the size of the existing allocation, `realloc` may or
> +    /// may not shrink the buffer; this is implementation specific to the allocator.
> +    ///
> +    /// On allocation failure, the existing buffer, if any, remains valid.
> +    ///
> +    /// The buffer is represented as `NonNull<[u8]>`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// If `ptr == Some(p)`, then `p` must point to an existing and valid memory allocation created

nit: maybe

	If `ptr` is `Some(p)`?

because `ptr` carries the provenance not only addresses.

> +    /// by this allocator. The alignment encoded in `layout` must be smaller than or equal to the
> +    /// alignment requested in the previous `alloc` or `realloc` call of the same allocation.
> +    ///
> +    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
> +    /// created.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// This function has the same guarantees as [`Allocator::alloc`]. When `ptr == Some(p)`, then
> +    /// it additionally guarantees that:
> +    /// - the contents of the memory pointed to by `p` are preserved up to the lesser of the new
> +    ///   and old size,
> +    ///   and old size, i.e.
> +    ///   `ret_ptr[0..min(layout.size(), old_size)] == p[0..min(layout.size(), old_size)]`, where
> +    ///   `old_size` is the size of the allocation that `p` points at.
> +    /// - when the return value is `Err(AllocError)`, then `p` is still valid.
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError>;
> +
> +    /// Free an existing memory allocation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator` and
> +    /// must not be a dangling pointer.
> +    ///
> +    /// The memory allocation at `ptr` must never again be read from or written to.
> +    unsafe fn free(ptr: NonNull<u8>) {
> +        // SAFETY: The caller guarantees that `ptr` points at a valid allocation created by this
> +        // allocator. We are passing a `Layout` with the smallest possible alignment, so it is
> +        // smaller than or equal to the alignment previously used with this allocation.
> +        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
> +    }
> +}


