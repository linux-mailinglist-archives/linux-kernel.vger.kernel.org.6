Return-Path: <linux-kernel+bounces-307447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E41964DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BDB8B21B97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5671B86F2;
	Thu, 29 Aug 2024 18:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ftcn2N2e"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3405C14A09E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956369; cv=none; b=p2zqACbf+Qce30bm9Np9JlOB0mUfA3h+kq65raa+d7DA+7xmtTaKcQeE38EBIKIDBzwjmckDsmoEJHJUhr/guFjHNcSDSVlES17+vxWnIqJo/ZmFNiV4Qi7f9dYe+mYUSR49p+JbpohDuHkVplX/47HD8cj5DFen8ciqzdXxMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956369; c=relaxed/simple;
	bh=XE8VsHrTihT1SQ8vq+VttOG+6NW/1znWtgXdQzKIXbU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZrBA9mp4ekVKTqvA6/7GdLcMy+KXnKWaAxrmiVP6GW8dAz37gci2ppZVTxUMi+LsR/ZgC+CO8h1gh3l9kv/egfkqtJvUg2i0DxDskj7XmKzle7nkCydea+MckRmKNVqr4F1p0+tGguj6wLTZnVDiD3nIoEv4LoDB0Q3TbE5nGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ftcn2N2e; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724956366; x=1725215566;
	bh=YOfxQtw40ZXlYY9ClmFMSo+YqxH/dt5Klo4ck81NB/A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ftcn2N2eOuSuiG7u+g7CIp+3zJMQ2q7LYMg+6er7KOtGiO3B+XOy07ntPSylMjvfd
	 NzNi6QgtNPVwtvm64/ROgFqUtonPV6cMdkpAEqAzKiwVey+Ip4xqkBiW24nokrunAu
	 2EUG9eb+iq4iBusYzszjJq4NaoZcaVh7Ktwx5DZyVtIKvL/XcrndPSZaxD5QVIGXCm
	 CwAirNhHIymW+wIi68sQuNxUfMk191Ugh80bk4VvpZZUKB8CUmC2AU+Ot0HtXI8+nu
	 BhG9U3FGqWt/lroWdN1mKMilS4lUq9jZWs+dF6nz5MRNZ27/LkJznJ+XZzzd5KR7Wr
	 xSUSEduTqoZ6Q==
Date: Thu, 29 Aug 2024 18:32:42 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <2dd02834-b2b6-4ff6-9e29-43c9d77b69e2@proton.me>
In-Reply-To: <20240816001216.26575-5-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-5-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5d22a818e5a4787a27c7c22d2758781a7315a81e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
> typically used for objects smaller than page size.
>=20
> All memory allocations made with `Kmalloc` end up in `krealloc()`.
>=20
> It serves as allocator for the subsequently introduced types `KBox` and
> `KVec`.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs           |  2 +-
>  rust/kernel/alloc/allocator.rs | 72 +++++++++++++++++++++++++++++++++-
>  2 files changed, 72 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 9932f21b0539..477dbe3c5a2f 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -4,7 +4,7 @@
>=20
>  #[cfg(not(test))]
>  #[cfg(not(testlib))]
> -mod allocator;
> +pub mod allocator;
>  pub mod box_ext;
>  pub mod vec_ext;
>=20
> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator=
.rs
> index e32182f91167..78e7d5488843 100644
> --- a/rust/kernel/alloc/allocator.rs
> +++ b/rust/kernel/alloc/allocator.rs
> @@ -1,12 +1,28 @@
>  // SPDX-License-Identifier: GPL-2.0
>=20
>  //! Allocator support.
> +//!
> +//! Documentation for the kernel's memory allocators can found in the "M=
emory Allocation Guide"
> +//! linked below. For instance, this includes the concept of "get free p=
age" (GFP) flags and the
> +//! typical application of the different kernel allocators.
> +//!
> +//! Reference: <https://docs.kernel.org/core-api/memory-allocation.html>

Thanks, this nice.

>=20
>  use super::{flags::*, Flags};
>  use core::alloc::{GlobalAlloc, Layout};
>  use core::ptr;
> +use core::ptr::NonNull;
>=20
> -struct Kmalloc;
> +use crate::alloc::{AllocError, Allocator};
> +use crate::bindings;
> +
> +/// The contiguous kernel allocator.
> +///
> +/// `Kmalloc` is typically used for physically contiguous allocations up=
 to page size, but also
> +/// supports larger allocations up to `bindings::KMALLOC_MAX_SIZE`, whic=
h is hardware specific.

Does putting a link here work? (I guess we don't yet export the bindings
documentation, so it will probably fail... When we decide to enable it,
we should create an issue to add missing links)

> +///
> +/// For more details see [self].
> +pub struct Kmalloc;
>=20
>  /// Returns a proper size to alloc a new object aligned to `new_layout`'=
s alignment.
>  fn aligned_size(new_layout: Layout) -> usize {
> @@ -36,6 +52,60 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, ne=
w_layout: Layout, flags: F
>      unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, f=
lags.0) as *mut u8 }
>  }
>=20
> +/// # Invariants
> +///
> +/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
> +struct ReallocFunc(
> +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut c=
ore::ffi::c_void,
> +);
> +
> +impl ReallocFunc {
> +    // INVARIANT: `krealloc` satisfies the type invariants.
> +    const KREALLOC: Self =3D Self(bindings::krealloc);
> +
> +    /// # Safety
> +    ///
> +    /// This method has the same safety requirements as [`Allocator::rea=
lloc`].
> +    unsafe fn call(
> +        &self,
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        let size =3D aligned_size(layout);
> +        let ptr =3D match ptr {
> +            Some(ptr) =3D> ptr.as_ptr(),
> +            None =3D> ptr::null(),
> +        };
> +
> +        // SAFETY: `ptr` is either NULL or valid by the safety requireme=
nts of this function.

You need some justification as to why calling the three allowed
functions here.

> +        let raw_ptr =3D unsafe {
> +            // If `size =3D=3D 0` and `ptr !=3D NULL` the memory behind =
the pointer is freed.
> +            self.0(ptr.cast(), size, flags.0).cast()
> +        };
> +
> +        let ptr =3D if size =3D=3D 0 {
> +            NonNull::dangling()
> +        } else {
> +            NonNull::new(raw_ptr).ok_or(AllocError)?
> +        };
> +
> +        Ok(NonNull::slice_from_raw_parts(ptr, size))
> +    }
> +}
> +
> +unsafe impl Allocator for Kmalloc {

Missing SAFETY comment.

---
Cheers,
Benno

> +    #[inline]
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError> {
> +        // SAFETY: `ReallocFunc::call` has the same safety requirements =
as `Allocator::realloc`.
> +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
> +    }
> +}
> +
>  unsafe impl GlobalAlloc for Kmalloc {
>      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> --
> 2.46.0
>=20


