Return-Path: <linux-kernel+bounces-346494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAAE98C54A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5108A1F25256
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57471CCB37;
	Tue,  1 Oct 2024 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="as+1wxMc"
Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2109.outbound.protection.outlook.com [40.107.121.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF11CCB34;
	Tue,  1 Oct 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807183; cv=fail; b=Z62Md/fLvwbpVb0nCH7f2iuUJqCtZMhRyDLzLxBU7Wg4Vwu2Eye9UjNY75eh1gURlWpJZg7Qq9XJc3x1PUltTylb0DuO856FijLs4wHnsmM6FdQ3hL6W3uf2pZpdPNwdUbRDPUGjZzDrLkJt6Ztt6U1KCKO+sXdWMucd1bzA9jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807183; c=relaxed/simple;
	bh=noCkP/34vNtHrKePmq/RirPDnVtX2OVJIyyWGudHd10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJHdmsn+8lehU9YOoasAedPpxJyhaa/h6cShWEM8VQFIwhOdkS2fSClirtqNyTup5N/WueIq3rhpLrGeNaTei39EKPNxEW1JBj6U533IwHaKRYPsksrQ+ONLyGOcmTFCBzshsSgsYmGNdecrzix9sZeDBjXeWS5dzY4vjOmdaTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=as+1wxMc; arc=fail smtp.client-ip=40.107.121.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdN8J4A56iA/Yi/3LXmBrEB7A8CM+J0IcM9jhKufFj7EL36aH6H5APq9pyJ8utzhX5urjFDKf4MLOi9Q0SpBQeoY9mFX9e/3UwRsxr5aitv1lpRwPLTQmIxU218mWdf7tg2zd2rBi6gIT4swnDyxnWMnXy8XK8VTiCAPtBAdNK3zBMeIt/fISISSe0j4rNGn38chq5X2EIj6f/23Xz9S867rVz+E3TAacP3iFn41ERikt4B0v+uDAvxy0bHfBxLyboVyJOU/Fk46NwQ0lc6YfrCv83kV/o6wUmOF9XAoHvjSsKEux3H5mf9Xkak1UmAnZ9VeMZFvTXFNRkmRjIu+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSHeQOq6jF97iT+jogQsm+QbOZF5ggB5PghQrqy60fk=;
 b=sZaAVnTzGv7i1mmuiCBU4aBjHfuXchY+z0QEQJmoJcv6A197zqQwfwslxj8WcOcPI3aXPzILzxxg51i9BvgUJJuvMzW9xNElQY0n7I91gwX5qUbsNKdhXzcrRhmwSW9RFkwSSG2dcDpdIUo5L2qN2YU9UNME5RYZ5+rAREGmtG3bGw7B02nTKh8SuH6eVUeyg7LAMT+FNYTI0A3UcbkaviV/dcVrnjM8TAUzaFqb1bKw2nyNfKtMaKaRd5Lnr5vJdgnCViaqcXRgnvV0wKDoZDgiLJhqBX7yziKpdhLI6LglJG15odirVo36WqHGoZSJ6XWiSTqkRBqZk2uhGAKyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSHeQOq6jF97iT+jogQsm+QbOZF5ggB5PghQrqy60fk=;
 b=as+1wxMcZmIUWlwdXcKzB1cw71/QqNKJeSFbwCtJirjsXayxIVvCc4mA09efjYwzrS1VmChuECBROQxrc+uvhFVl1PnLZsEVODcsZ1jq9P61tSdIvOIcvXhgUZJzFqtgaUEvsnZQ5XWmQrpKazOu2za7r1bxW2peGzDEni61YxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7730.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 18:26:18 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:26:18 +0000
Date: Tue, 1 Oct 2024 19:26:16 +0100
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
Subject: Re: [PATCH v8 06/29] rust: alloc: implement `Allocator` for
 `Kmalloc`
Message-ID: <20241001192616.1e4e654a.gary@garyguo.net>
In-Reply-To: <20241001150008.183102-7-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
	<20241001150008.183102-7-dakr@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: cb931fbd-5766-4e75-daac-08dce2468ac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4uHjvjjYEL27FDcp+d9FA84VN0Wg87jWBOGlxoyJO9f3nvFQgK/pxDBIAac6?=
 =?us-ascii?Q?R8N1m8ZOsR3cHA1LiHmpJBuzKZiFMkI/PMoGlcUelISrhiGalTjlwocypQAZ?=
 =?us-ascii?Q?dEOXm4a0O0qJkXmobYcu0qURA1TPMxFStZsN8blqpZVh7ZPgVjVFtWf+Pfb2?=
 =?us-ascii?Q?K2lPdcqYzKm+4YY6t2GINfPuv4tKut613rwPBBarsxrWsexCBfrggXk+rJjJ?=
 =?us-ascii?Q?XuDH8oj4QKpT44IewC6MX3vQWTaadbP+oQiltsZ7GkQlxJfvIBtkBBUr4xkG?=
 =?us-ascii?Q?lZM0X5Ch+5WQQbT+93ccCmEF+j84pp5QzS9jm00BU0P3TPxwpAFrjpNt9Y5j?=
 =?us-ascii?Q?UaT7NFNwgBaT9K7k23A1WnZxabDAHV7BD3KH48K3SjmUs6qsDRhR2B1vmCG+?=
 =?us-ascii?Q?p7w33evYpSuFSYo8TAaW362XWIkzIbpH4ak9PrNu7tDVDtTlI5swKBHJDzsJ?=
 =?us-ascii?Q?6FXQvqQwye2bK8rc4AMeyzf/quKcU1w0oHRtk3UI3gMNBnAVoCoHSvLUuzPN?=
 =?us-ascii?Q?0c6HrcOeMnxgVys0T3sqMD7qavuIZlPl7W0PT4VaVD3lEweEJ0kdwEz2OfuU?=
 =?us-ascii?Q?29aEgLh2AoKtht6qgigmODZf8jOaXlb4VZM2ZcXQD0NAJgwmCkAZGus0/Wpr?=
 =?us-ascii?Q?Ee71txlx2AvaNhQMAoGZFKgYbiQVW1ZbWgV4IGNizd1ysvzMO8aaHAd622oq?=
 =?us-ascii?Q?Ii2dookReyHteJ2yyN3H5yPa5PviVbOxZgUGOoh1dS3yFl4gsk8taAyrvYHS?=
 =?us-ascii?Q?KG+ItkBhmI3sP7WFhiMAI7nXAaybEsOVle0SCfexhQfFDPtNs8dQw1FpX6Tq?=
 =?us-ascii?Q?5U9Rk9eKnndSA00JhNEb81ECCJn3ov9rpQSUGAU+Fb+LOqapSTnwna241FSR?=
 =?us-ascii?Q?1EM+gt5JdOD52O2tUnGJtexN+44NgzjBf61d80aWIWF848Lx31BkGS3izm2Q?=
 =?us-ascii?Q?7gWM+UIzmtAvMhL3EWODSSG+8vD8nv85dT79feReHLrKT2VJcKq8OTY3tkc1?=
 =?us-ascii?Q?DYZBnYr4DnI8ARuqAX2JtsRVQREkidjv6zY8zN5JZIyx3/Z3O/WYVN+/Z7oS?=
 =?us-ascii?Q?JzFgevwNaM7Yg3c2CpWcZp1ogeW5mEKOKeAZJ5lgYNaiwUPyHcEBItMqky5Y?=
 =?us-ascii?Q?ollmoQKnrlYs/JfwnKbEyZYKJl/XpBhOwGMxwU72KdYYHHXkcPN7jqQf7iPH?=
 =?us-ascii?Q?A7LZW43uQDBfm2N63UeK5bMzMg8IRJKMbfmxKbdo/B9bTAhEJ62B5EIO+GqU?=
 =?us-ascii?Q?9Ew1fIjDzRXv1y+O8x094tHhJXP0WdFC81xSENyELA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rluo+alpi1XN26I76D89CRWhRT9c0HV1ch7S+b3YZ64BLnj+zghdXp0c3Txx?=
 =?us-ascii?Q?2tv7ZiS8xL68guio/TFgvGmiqU1Sjeqf91MRPCedrI1cYHScM2xRSEF8OLCg?=
 =?us-ascii?Q?ni2wnCsBOk1jryzOn4FDnq0ZzQ9BPY1QfyEylkGbGfyyPBWw4UHxG3i5GdX3?=
 =?us-ascii?Q?/kJ4Kie5vsDWJmCWvx4jbPPk/3N/qJNL+MXC4VPsDmqioqSFtx5jNTuUB9g3?=
 =?us-ascii?Q?nQiwMGrIxA0lOeBb05hMVItu1byKmXZ1ohnhWqlS3Ly67ggmNU/Sw1ru1HOK?=
 =?us-ascii?Q?4E77sq2KrhdnCKVoow6Ijjjb/+PDjhIFhwQYe6PSuIZAiwoKd1UFsbMxPv2I?=
 =?us-ascii?Q?Zfc/jsrqU5z6w3CXBjtvLNm8bW4rpGfBWwVsPdRsoWpQA+M/dbJrFZy+u6do?=
 =?us-ascii?Q?7UXrwcLlUYSgIMU3Gqyz3uCA/zmliuQCHF7CZNFIZaXwOrooeS9M9OIdVx13?=
 =?us-ascii?Q?IVAjGMhicMl2LvtAlIVDQ3nQ5z9HIaqAIACiT0xNIFL9owpZw5zoK12L9r12?=
 =?us-ascii?Q?TmchwvUYc+/bXep5sGhZjR6R4Zgpncihlq87EkJN0bYj5cGrHfQn4kX8yALp?=
 =?us-ascii?Q?jSPunmdy9/YDFsux/JNZ0CEpUIW6ridFp4o3kIsGZUlu4f6LaUpCrFNln385?=
 =?us-ascii?Q?6z978dDuDft6NoMeTAm+XKkS0YjuEUnZHrvPaswwuaWeFpH6jIDAkbm3zxgk?=
 =?us-ascii?Q?hyF/nRVNeMh8dYMIN51Yr1PWPC5WnQ6SGYZINCqIiszjdbXCNVbmO6kIEvU9?=
 =?us-ascii?Q?Tm3W98qgJOSSKL38W6SHGtE3xMeY8BE0WzXLVHoyeEuw6u3m3UOYPGPnpMMq?=
 =?us-ascii?Q?Jz2gQmfU0BY6jfqnGdUtkEbx032/Xe0cRzBIhnk1uo0WrKdupO86W0+dcTCZ?=
 =?us-ascii?Q?y//VYgYBAl+HuGJ28IOh0pam/E8QxgHXAkGtnMaD6kcBvxMmfWWymqQWfrLE?=
 =?us-ascii?Q?jI/l4QolvJrP6jBulw1GzfeadS/UDYOYz1hcG5RW18Ykmk/oHTrs9WO6M2TO?=
 =?us-ascii?Q?kk4ZnmAG/AWKK89MKxO4oE4iTKZdgC8XB9sEF5CekpRdYqDzO+HE08gSMpAO?=
 =?us-ascii?Q?gLGZ9hc3NTlNaG96arc5JfvWXzXu7wYtabKtcORcJ6+xOLo/YWU6BaEFNz1y?=
 =?us-ascii?Q?QZIcyJ6kCQmAyZuZ6XbYrYwlRcS2vz33a6VT7xjCagL5k1jfll8gLbEGK+CK?=
 =?us-ascii?Q?DXjFzWXeV6q4p4EUoHXwV9eFsZAfGE1aDv2lrY/JmxrqnNPXBmtbH6wuXfx1?=
 =?us-ascii?Q?QuNKerGJC0JoAx9qw/jsfwe5LsFE9iZ4uMMcGIuhnx6dXPwx5V98KxDct2Zu?=
 =?us-ascii?Q?rERa+qiCiZoAZWUyr9ux3Eht9WEFw3DtdXcXgsGmlCVp+wuJjKg7wI2ik0xM?=
 =?us-ascii?Q?o32zKKGsBILfuA4uMXVwFV1zl27vO+uaZT+1WKWMe8WsuJmUvnHVM0yLKgGG?=
 =?us-ascii?Q?Ikjkga2ALTLTkgT8iJobzH2iLG9oFD/Co6VMqF77CD8e6sWdVNeE5JQ5KTib?=
 =?us-ascii?Q?Gca0AGVBMBQjs1u/7kbPEvG/1y/5syaS4DPE5pcWFXwl1kCjfxnzU5S1oS52?=
 =?us-ascii?Q?hBMXA1htn2U4HKUK5Nhvq6SIZ/tDvLd2AiGOyzZq?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cb931fbd-5766-4e75-daac-08dce2468ac1
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:26:18.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vawB7Uh/H4gn0qi+IbqPCE8olGH8JPQOneJE/bbqfSCPdi7K22fd2CJ9Djhla65bCPkdEZW3wbNg/THbRy4V0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7730

On Tue,  1 Oct 2024 16:59:41 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
> typically used for objects smaller than page size.
> 
> All memory allocations made with `Kmalloc` end up in `krealloc()`.
> 
> It serves as allocator for the subsequently introduced types `KBox` and
> `KVec`.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/alloc/allocator.rs | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> index 1f28b004b447..4f3c3ab7c7a2 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -13,10 +13,16 @@
>  use core::ptr;
>  use core::ptr::NonNull;
>  
> -use crate::alloc::AllocError;
> +use crate::alloc::{AllocError, Allocator};
>  use crate::bindings;
>  
> -struct Kmalloc;
> +/// The contiguous kernel allocator.
> +///
> +/// `Kmalloc` is typically used for physically contiguous allocations up to page size, but also
> +/// supports larger allocations up to `bindings::KMALLOC_MAX_SIZE`, which is hardware specific.
> +///
> +/// For more details see [self].
> +pub struct Kmalloc;
>  
>  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
>  fn aligned_size(new_layout: Layout) -> usize {
> @@ -53,8 +59,10 @@ struct ReallocFunc(
>      unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
>  );
>  
> -#[expect(dead_code)]
>  impl ReallocFunc {
> +    // INVARIANT: `krealloc` satisfies the type invariants.
> +    const KREALLOC: Self = Self(bindings::krealloc);
> +
>      /// # Safety
>      ///
>      /// This method has the same safety requirements as [`Allocator::realloc`].
> @@ -106,6 +114,23 @@ unsafe fn call(
>      }
>  }
>  
> +// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
> +// - memory remains valid until it is explicitly freed,
> +// - passing a pointer to a valid memory allocation is OK,
> +// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
> +unsafe impl Allocator for Kmalloc {
> +    #[inline]
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        old_layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
> +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, old_layout, flags) }
> +    }
> +}
> +
>  unsafe impl GlobalAlloc for Kmalloc {
>      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety


