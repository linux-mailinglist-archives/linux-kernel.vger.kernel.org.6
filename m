Return-Path: <linux-kernel+bounces-276757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317CE949802
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541CA1C220E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542F83CC7;
	Tue,  6 Aug 2024 19:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="B27VXmpb"
Received: from mail-40141.protonmail.ch (mail-40141.protonmail.ch [185.70.40.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B718D62B;
	Tue,  6 Aug 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722971241; cv=none; b=n8d2Oa22rNARFiffyYdQ0XT5DfeQ7bTrwTk9GMZaM+eG+Xyyu2c8qJ371eRslHBC4+g+jHqfEhsEsbkair5J1P/DE+SJMraqYkie35kChT6tiY6bBodSAaEHcYbgU2SbkUZtPYAPaaP2Osgz2/8GMd18x/cVT7Jj8tdgyrJ9Gcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722971241; c=relaxed/simple;
	bh=zeNlpKKv6ykuvm6nb/GDwYgHxUicuQv3O5Z95Pv2y10=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lArWVtatqUI2gOJpGJvvC60z+sWjqo/fZw7Ot9y+yrYImpLfNK9bFO5LsWxGkn4m1Hp5DtF7CRt2bThOccj4og441cc5yVgqL2gsmXmc73cCoYRb975akysalXr/kgTgE0DOu9jmx+rvu7cYC6zm0xJ8mud81XBt2KaVrVQTfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=B27VXmpb; arc=none smtp.client-ip=185.70.40.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722971232; x=1723230432;
	bh=z+H0eZKtffc5wg82zek5HMwYdDr+PMyIR4bABPA+ZKc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B27VXmpb4+D0N9qtJKUygaQeEJFVDNxxG3SSIiLC+xUxUK6a9dnKdVLwioT2u88ih
	 8v94mK5RzX9BvveWsGEf5tzkNnFikmhPtIgKXhtV4usBHv8ehDa5W7iT3NRU06FIwW
	 b038Jwty6JZzSMA7i3WoKeCxvV48cFRjzEn0irkaBNMpeq/pxt/T/BQdnS/WKsMjqX
	 KKrqNnhf7qkdif1ffzb+L4ercGJPPDremlFcnn6H68aGUSqNC40+232x59dT4cl7u8
	 02ZCw1KC/vVSU2vZGvh96CCOM9JvkP+SbRGMW3QSx23zh0PS7sqQMmVRgDSR2D36d1
	 ogja2O7q59zog==
Date: Tue, 06 Aug 2024 19:07:07 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 21/28] rust: alloc: remove `GlobalAlloc` and `krealloc_aligned`
Message-ID: <6HIL4hSg3hOCh5IDDOtdEaEy89ZksSJmSLNiKrSvpu2Q78wA5KdrCCrcPSD_p4jB7IlmVRyVBnvBllU4irzuYgpQJOBtwUInAKdOibtRjVc=@protonmail.com>
In-Reply-To: <20240805152004.5039-22-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-22-dakr@kernel.org>
Feedback-ID: 27884398:user:proton
X-Pm-Message-ID: 7d0611c0d8cfb94cead6d48af71725ae727aa1b0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, August 5th, 2024 at 17:19, Danilo Krummrich <dakr@kernel.org> wr=
ote:

> Now that we have all the `Allocator`s and the kernel `Box` and `Vec`
> implementations in place, remove `GlobalAlloc` and `krealloc_aligned`.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/allocator.rs | 63 ++--------------------------------
>  1 file changed, 2 insertions(+), 61 deletions(-)
>=20
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
.rs
> index 91ff21372a8f..6abd55694422 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -2,8 +2,8 @@
>=20
>  //! Allocator support.
>=20
> -use super::{flags::*, Flags};
> -use core::alloc::{GlobalAlloc, Layout};
> +use super::Flags;
> +use core::alloc::Layout;
>  use core::ptr;
>  use core::ptr::NonNull;
>=20
> @@ -40,27 +40,6 @@ fn aligned_size(new_layout: Layout) -> usize {
>      layout.size()
>  }
>=20
> -/// Calls `krealloc` with a proper size to alloc a new object aligned to=
 `new_layout`'s alignment.
> -///
> -/// # Safety
> -///
> -/// - `ptr` can be either null or a pointer which has been allocated by =
this allocator.
> -/// - `new_layout` must have a non-zero size.
> -pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, =
flags: Flags) -> *mut u8 {
> -    // SAFETY:
> -    // - `ptr` is either null or a pointer returned from a previous `k{r=
e}alloc()` by the
> -    //   function safety requirement.
> -    // - `size` is greater than 0 since it's from `layout.size()` (which=
 cannot be zero according
> -    //   to the function safety requirement)
> -    unsafe {
> -        bindings::krealloc(
> -            ptr as *const core::ffi::c_void,
> -            aligned_size(new_layout),
> -            flags.0,
> -        ) as *mut u8
> -    }
> -}
> -
>  /// # Invariants
>  ///
>  /// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
> @@ -129,41 +108,6 @@ unsafe fn realloc(
>      }
>  }
>=20
> -unsafe impl GlobalAlloc for Kmalloc {
> -    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> -        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> -        // requirement.
> -        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL) }
> -    }
> -
> -    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
> -        unsafe {
> -            bindings::kfree(ptr as *const core::ffi::c_void);
> -        }
> -    }
> -
> -    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usi=
ze) -> *mut u8 {
> -        // SAFETY:
> -        // - `new_size`, when rounded up to the nearest multiple of `lay=
out.align()`, will not
> -        //   overflow `isize` by the function safety requirement.
> -        // - `layout.align()` is a proper alignment (i.e. not zero and m=
ust be a power of two).
> -        let layout =3D unsafe { Layout::from_size_align_unchecked(new_si=
ze, layout.align()) };
> -
> -        // SAFETY:
> -        // - `ptr` is either null or a pointer allocated by this allocat=
or by the function safety
> -        //   requirement.
> -        // - the size of `layout` is not zero because `new_size` is not =
zero by the function safety
> -        //   requirement.
> -        unsafe { krealloc_aligned(ptr, layout, GFP_KERNEL) }
> -    }
> -
> -    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> -        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> -        // requirement.
> -        unsafe { krealloc_aligned(ptr::null_mut(), layout, GFP_KERNEL | =
__GFP_ZERO) }
> -    }
> -}
> -
>  unsafe impl Allocator for Vmalloc {
>      unsafe fn realloc(
>          ptr: Option<NonNull<u8>>,
> @@ -204,9 +148,6 @@ unsafe fn realloc(
>      }
>  }
>=20
> -#[global_allocator]
> -static ALLOCATOR: Kmalloc =3D Kmalloc;
> -
>  // See <https://github.com/rust-lang/rust/pull/86844>.
>  #[no_mangle]
>  static __rust_no_alloc_shim_is_unstable: u8 =3D 0;

This can be removed too. liballoc needed it for us to acknowledge that we
were linking liballoc in a way that isn't guaranteed to be stable, but now
that we are removing liballoc entirely, this static is no longer necessary.

> --
> 2.45.2

