Return-Path: <linux-kernel+bounces-309882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FBA967179
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D851C21504
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5661C17E46E;
	Sat, 31 Aug 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FJP/cnF2"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2122.outbound.protection.outlook.com [40.107.122.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A217BB19;
	Sat, 31 Aug 2024 12:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725106573; cv=fail; b=P44icWgcxgU/qgs0CzSdhC06rhd58j7v80LcCPybdejC/lcIn9xGaWB+6m1D3XMSEoYiDapGNfuAQDj0rF96L/dM73BdURv4Qlqhblm2tV0po+DhmUhlXTejsIvUrofoZALD6Z11AuYlaMyVJBwGcMd2KVMRDMTuERFHyzbl6iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725106573; c=relaxed/simple;
	bh=DoX+0LS/xzDtA+QjlhC5RATksqJwhnuoxLj390otEnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VeHPbozTjarSAX8k1pJmmgcJGF/6ZhtxM0+qvoHmiVTw/5l+27mJ8nJKnBjoyy66S+MhW5AxtjEeCysBrd9Ot3sa+4oDxO5aEVTh3tvsfrHo65h6Y7eDgD7rw48LvzlVKjq2EOcLhTThdW2cYlmcSbvmH5/tAmmB0b1WGR2PrKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FJP/cnF2; arc=fail smtp.client-ip=40.107.122.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7ZR0M616B/adhH6NgLeongXbr83PmK5Ik9MfTT21NTcVHZA/DNKmmIGcM5y+LALNxkuiMeQRtAYokT35/hobynUxKtak1O4BzKmHURyFdlJRorKd+d40M3tRBU38CxxokIbr0tpCeb946DdRWgxrYMx9zHYhkTV5CPVMy8D9lN/2fms+kBL61/nsfc+yUzNZJT04Xg0h2mBNJm9HsuyXCsoQ8SdDCQcWLhRtjylNp6fKtyqqQdNniGXBnUJE8mLo8s5YzfiuLNp8+aeJBcRSFbNDy1ptTxYq3pXDtpCUc22mqXUg7c4mslJ44oFD8yVDiTrdedqA/GzTWpJ1P38Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxCWA+N7MDEFds4ulOnG+tg+kGwI7Xft5R11KnecwJ0=;
 b=VgantBY2iJH8JGCquj/a/TmYos6HG/f0UTaw8Nzj9O2dF1kGyR9NY63xAnBbNqeOz5NcFsJELYLQADdfwtpGHd9MvyBibd3449ErAZ1E44nApAxkAHVhy4qNU9/lhyo3NdUUT3ZuqgNSPL9SV/OCi8+fpxVtKuEy/AxpIFVFvBQ9A5+8jpsOuuOEXJwkdDn9bjntlP4MUMSkxrVKmlqvASMSqK92bZ9XQkBZqVYg4+AlC/Ctl4Sqfkl1cWaYtenX9ea5gpW4+h4KnHJPF8xnFGm4Mh97OBOueEOf+GBj8lU8QCiAnqr4RKcIXqU6U2YghRWK2fDilRlxEzOEp1tG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxCWA+N7MDEFds4ulOnG+tg+kGwI7Xft5R11KnecwJ0=;
 b=FJP/cnF2MSB7hQxjzscqQmL81/UMzEy8VxWoAyQOApqCK0170EgBz0WVXGA9nv7+BGU8bpzv4OVMIE7Yax1AbgnE7+vfacF2IMdXxowQ1B7RBU1hF+O4Z7jaU6SBqG0N+8VxsvwYt/dfV3fTvQ0t9yU2CSN6ehpCJ396SmoGKlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO2P265MB5757.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Sat, 31 Aug
 2024 12:16:08 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%7]) with mapi id 15.20.7918.020; Sat, 31 Aug 2024
 12:16:08 +0000
Date: Sat, 31 Aug 2024 13:16:06 +0100
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
Subject: Re: [PATCH v6 02/26] rust: alloc: separate `aligned_size` from
 `krealloc_aligned`
Message-ID: <20240831131606.32427c73.gary@garyguo.net>
In-Reply-To: <20240816001216.26575-3-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
	<20240816001216.26575-3-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0302CA0023.eurprd03.prod.outlook.com
 (2603:10a6:205:2::36) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO2P265MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1a9303-5802-4660-8abd-08dcc9b6b1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cn2A1j4mPqofngR+9nwxgk9uDEy6QIQIyYGf9A5yVbnh05jfb5GHyE2Bceuy?=
 =?us-ascii?Q?ZBKq8LMAefu3baOvzXw1BCXdNJ/RcC1suGbIpUso4pZIGrLKiRtemsNIUP2q?=
 =?us-ascii?Q?xwis6DdWxQ42S9j5MlNDij07SkSXrk6ZeAI/LwTwzQ1yGG3is6bpEYO+OR7u?=
 =?us-ascii?Q?CNa6nydj6Seo19GWOyEjS5u/a+K5CaxkLniHCyPE/2uuunavtXYTnrI+gda6?=
 =?us-ascii?Q?EwU7sWASp+w4gdFZLoXVVU1Zt8mU035bpAdvwZIssbntMopNkO4Rm0iUbYv/?=
 =?us-ascii?Q?78rBRtX5GtcHx24Pl+FwnqHTmXjZRWfi3R74u3KlOCFtAlOFeNELIbVsQH8n?=
 =?us-ascii?Q?UpnkTh0vuGG3aM4+SSW9UzNY+yNQBThBZJo9LVP4XVh2H54yFwKoIUA23Xug?=
 =?us-ascii?Q?a9kH8FGbLBuAB0y8gSYKXECrrw4DV1V2sYMqexpfLxN7lTeHzaO6Mj8tai1W?=
 =?us-ascii?Q?+xBRxeBrE+HMG1f9xaufJAilhbFRUvr2m3aFQQxv5e0+ttYnoy4Al/1C0PEZ?=
 =?us-ascii?Q?SlyWD06JUU3FlL9AVcOKGIIREr212R9/EkW2PmAqHJ74WlltvGbZhQESgb8B?=
 =?us-ascii?Q?a8jdqyzQwIcZX+vozeZxv1FgFxnK1jpF/64Wiv/58EmeX9kl2BvMXKcsrtCi?=
 =?us-ascii?Q?Oo35ZuoqxxtCS+idZvHUFfDJKXzyPvxWCoNPk/vqVheGzapu/bxFGxJ0R8dh?=
 =?us-ascii?Q?h20YhfjDQVkdIWKixZCZAN4MVAtazjaoyfJZssFDRswiRqBnhWGPLYYVfeRM?=
 =?us-ascii?Q?nB6yUaSCqMLORNDT4Adp96M6xwOrnWSpDzMRba5mBkGJJmKMVm9uye/a5FLB?=
 =?us-ascii?Q?niOmr6xTf4oVmu9IQGW/uT3ODt+UuX3h8yacpkJej7jx6FOXTQdko+ud3KRO?=
 =?us-ascii?Q?M9gtaaEVz3s4fF3nwqE+oRGFE10PZb9iLncjX4aDgffocmbxuQX6UBpGIOd3?=
 =?us-ascii?Q?VjZ0qi+bQaEGPoBoHRE9lklu15KEKrlJ9F9NqQx2iUNr6kGoc6XdPeYXA08d?=
 =?us-ascii?Q?NHlRtH5VoDV8evazdUMHn5vGLU89EHtJ4e6S7PaaOFfetiyiSJUR+nCu3LNE?=
 =?us-ascii?Q?FbBXG2V3u5GAWMQ09JghEnV2BB7kUGMXzD6ZWz57/LsGly0QqRvojbBHQupN?=
 =?us-ascii?Q?jOvUtlF6ZOH664Zl6VIYc3NYvfW75xVPBU3gGgfb3uS1H0/eDmSai0BhpXLm?=
 =?us-ascii?Q?zt9IO82DOK+jGGmZAQKvN0a4kZNfP/KgcufMTiCiJZIBlgwhc6+y+SftyFTC?=
 =?us-ascii?Q?XdTwvjvP/9eaeRLSokPEO3IxRRX4sEbwqlv80Oyy15SxGaCHQL7GS63BRcqG?=
 =?us-ascii?Q?MW7FtfoRlc3LP5V+FCzsR8EBzwRABKpSRe8BPWac5K8V0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jai0i+upLNHGSbXWrEDccPhs5qs6NoYZCZZXeqfHqR2N1Jfcdd495F63GCrN?=
 =?us-ascii?Q?92NETcYW3XY/chxXI60DsPJnQOOE570xA+51Aq155/LqpTUcMB3AHv4o3h0Z?=
 =?us-ascii?Q?d8jGnxNKl5Lp4Sbo0ykqqGCTzC2n35aCBumpbd4JdiA0EDzWSmzVz9MBQ1cg?=
 =?us-ascii?Q?/luLTCQovyg/J80g86kcNVxyWky5DM4a+7HVj4ioRLibVUQtSrqKsgX3Ckdz?=
 =?us-ascii?Q?0MG7E9ZziFCWZETnVYy5/wfKZpwo1AY+T24CuX2AyfU7e4MWdc4LbRqoctPL?=
 =?us-ascii?Q?4AzZnZarr3QCM5h74ff7B2yQH8CNrrg67i2nkSTZ7w2ICVS2MlO7tQ186fjD?=
 =?us-ascii?Q?Wt9P2kEkPuNzjCTsyDuEL1qCJU1dh71xLQUE2J/vdWKwePEhO9tUj2AUmp8x?=
 =?us-ascii?Q?lf4tn4kAalt2rQm2+qV+Jm3nSZRW3YClxyhvkl4msh4x+2wrjyQTtQJf44T+?=
 =?us-ascii?Q?SUn2HdWDdmUr/ZL1Tv7k/W1Ar61UQDrlR5AWfxxEAU1TnjY2npR8i7bvhtr6?=
 =?us-ascii?Q?vzbR0LtHMUj14TotvQSBpSajWtBclsUNsHbANcRvbPyYheH9AvQneBDkwDNh?=
 =?us-ascii?Q?65aW5ett922cua/BeXW3jwkkwanFeZyKhW6Sg1mOWRYkVYT4fazNrr4C535F?=
 =?us-ascii?Q?pTwjYy9rgzdUfP1c6t8CvLkDeko+1wuS66s1dDpe1ANpRD9YVlDPrqzpmquR?=
 =?us-ascii?Q?vqDoPCfmvo5fx5gvlbwv/VDHGHLzycdoL41t3WcC1ZvQDpSKd++t2XmmGlyO?=
 =?us-ascii?Q?5woh1wA7EG9sxbVKFBA+xe5cUdHgaaWl6rNm64PML7qHdeRK3C0uPn1mf0J9?=
 =?us-ascii?Q?sjYsVWAztXP6A6OO5xiExxBDFSJ7zM7T6cIKiD7/qAxardzxRG9MRUopywmd?=
 =?us-ascii?Q?baMUCB1MwB/1wree/MpudrGAR5OvzlTsGePLpL9S071jfsd0vzod3ndzgKnq?=
 =?us-ascii?Q?h5kgNSAO/EjeyGSs3iLYahHKjiaPBHjPJlvU0V1/+kGyjQlwILNM6T3qqqMc?=
 =?us-ascii?Q?6+Ru5lFWD8pH91cZYsScuSksybeDqQ6QZPIj86Yi/H5gLnrDqBMjwB5w/KkP?=
 =?us-ascii?Q?jg3and/BMuyKSZHVoD3XPoe3LwND/ppDuyoyz0XlJ2AG6zWbpOqGnfuDCX7N?=
 =?us-ascii?Q?3Wr57GCMrw9GqDUYrkdpmXtTiSV7uHoMM3GKgkimOkg9anJB5VhoSeJv/Sd1?=
 =?us-ascii?Q?YxIx7YDCVe/3fYF2dlveMg3hZV1TiXDhyHgwIEitIxqTt3fxHqfs1TnqyKTx?=
 =?us-ascii?Q?6FG1TMc+wEJquVBec49Yl3cfYfiObPPb/qqv0rL1sCCgLD3cg2YxMkUo5QpE?=
 =?us-ascii?Q?wCw5Qj5pOmkUI5dMGOXYWN1LrUIwSJqQmMLoesAklOxvTq1fYxDsfTAzOogJ?=
 =?us-ascii?Q?6z9UBw+fMkF/wQZTA+ffCjGlod5DLTO9GItcSI1MZ0LD27Nnv4bnGXbi3Z1o?=
 =?us-ascii?Q?1NsvLq7uODuIXEj90J0PCBYr5+2lvPxP+rGfP2tEvHJUfkb/NNGnehvLGxGB?=
 =?us-ascii?Q?q+aUlgw81SBKX1dOt/zbKcD6NYWcxWaaPwZUKWew4Pwx9jDOBpN/NVmdAd15?=
 =?us-ascii?Q?WUi55WDsGlYjHMFJeUnwBLWed3iEY5+VgtAhfMVKNPM/sJgZgs9YrwLbnPQ8?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1a9303-5802-4660-8abd-08dcc9b6b1f6
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 12:16:08.8731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXgqsH+zklM5Djd6Um3hLJm13vtuNlSrVmatpMq9m78PpTjXGq8h6WlPLihW4wgASxwFkUbfsC87lPSSL93oeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5757

On Fri, 16 Aug 2024 02:10:44 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Separate `aligned_size` from `krealloc_aligned`.
> 
> Subsequent patches implement `Allocator` derivates, such as `Kmalloc`,
> that require `aligned_size` and replace the original `krealloc_aligned`.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc/allocator.rs | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index e6ea601f38c6..c83b6dff896d 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -8,6 +8,17 @@
>  
>  struct KernelAllocator;
>  
> +/// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
> +fn aligned_size(new_layout: Layout) -> usize {
> +    // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> +    let layout = new_layout.pad_to_align();
> +
> +    // Note that `layout.size()` (after padding) is guaranteed to be a multiple of `layout.align()`
> +    // which together with the slab guarantees means the `krealloc` will return a properly aligned
> +    // object (see comments in `kmalloc()` for more information).
> +    layout.size()
> +}
> +
>  /// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
>  ///
>  /// # Safety
> @@ -15,13 +26,7 @@
>  /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
>  /// - `new_layout` must have a non-zero size.
>  pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
> -    // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
> -    let layout = new_layout.pad_to_align();
> -
> -    // Note that `layout.size()` (after padding) is guaranteed to be a multiple of `layout.align()`
> -    // which together with the slab guarantees means the `krealloc` will return a properly aligned
> -    // object (see comments in `kmalloc()` for more information).
> -    let size = layout.size();
> +    let size = aligned_size(new_layout);
>  
>      // SAFETY:
>      // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the


