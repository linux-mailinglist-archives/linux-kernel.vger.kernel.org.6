Return-Path: <linux-kernel+bounces-307760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1240A96529E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F9C1C248A7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C831BA891;
	Thu, 29 Aug 2024 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDtho+oY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066CB3AC28;
	Thu, 29 Aug 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724969088; cv=none; b=c+GA9N7nUavTKzDvqAv63v9MxjiRFR+FYwuKc2PClCMF4mzlSVD2OwTiDbU8Cknx1hQGhHSccvTB2tqGZEyln8Q5GnhxCRT7CFOsxa6Tfe1yQKgz6PAd9hxl9CODKo3pD4VNf4jRSroCuGZa7fnDTmR8Vb2HE183vs7FasLrf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724969088; c=relaxed/simple;
	bh=UZyETmbPwIfi25XbeaLZMvzZh202BJnxIB/La/RXXOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU2X5plqfMXv9mY6K66gE0aUARoApsIF2kHdGDmh72l0OCzCCcjy+62a7vcWNr/hXL7DPt6csPas6kFo2R1n/QFi3VVk2HMKMvYE7ZXDd+g0s3IF99Tru5d/VFlEtCW9jRqWV8i1YneKVjBIhtwq8BIA2V+rUo5kY1aXRE/USxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDtho+oY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF36AC4CEC1;
	Thu, 29 Aug 2024 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724969086;
	bh=UZyETmbPwIfi25XbeaLZMvzZh202BJnxIB/La/RXXOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDtho+oYVDPTVKfgrOYdPw3jXqlofGentNAB3BvW8FIz6GKIOqc/MLY2PP8qmSEGo
	 U2oKYtPaRWtpNl30Odn9jYRNhvl8fEVOTsFJzjaaj9KRW31LKPXIZ2BsxptY+ky8Vo
	 1MI0cou3urUefGbFR/0o4iaG051OKEew7Ibqmy5sBH4Nptf/j0Krt3jTAMYGAjEs61
	 WM0Q1/lGrvFb6Dkr1l4eDY9N6NE9TaCfw3bL+nQPsCBe4+Zm6ecazzgYnw5siuwGdO
	 zB/Q3t1SxZWSOIUn/S10Eanp/GhZ6wczC6iInsUfZK1ihE0HStVfJNE4Egl+Kxoj19
	 6XF7cwiwcMAyQ==
Date: Fri, 30 Aug 2024 00:04:38 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <ZtDwduKjIEZ3RQtk@pollux.localdomain>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-5-dakr@kernel.org>
 <2dd02834-b2b6-4ff6-9e29-43c9d77b69e2@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dd02834-b2b6-4ff6-9e29-43c9d77b69e2@proton.me>

On Thu, Aug 29, 2024 at 06:32:42PM +0000, Benno Lossin wrote:
> On 16.08.24 02:10, Danilo Krummrich wrote:
> > Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
> > typically used for objects smaller than page size.
> > 
> > All memory allocations made with `Kmalloc` end up in `krealloc()`.
> > 
> > It serves as allocator for the subsequently introduced types `KBox` and
> > `KVec`.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs           |  2 +-
> >  rust/kernel/alloc/allocator.rs | 72 +++++++++++++++++++++++++++++++++-
> >  2 files changed, 72 insertions(+), 2 deletions(-)
> > 
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 9932f21b0539..477dbe3c5a2f 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -4,7 +4,7 @@
> > 
> >  #[cfg(not(test))]
> >  #[cfg(not(testlib))]
> > -mod allocator;
> > +pub mod allocator;
> >  pub mod box_ext;
> >  pub mod vec_ext;
> > 
> > diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> > index e32182f91167..78e7d5488843 100644
> > --- a/rust/kernel/alloc/allocator.rs
> > +++ b/rust/kernel/alloc/allocator.rs
> > @@ -1,12 +1,28 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > 
> >  //! Allocator support.
> > +//!
> > +//! Documentation for the kernel's memory allocators can found in the "Memory Allocation Guide"
> > +//! linked below. For instance, this includes the concept of "get free page" (GFP) flags and the
> > +//! typical application of the different kernel allocators.
> > +//!
> > +//! Reference: <https://docs.kernel.org/core-api/memory-allocation.html>
> 
> Thanks, this nice.
> 
> > 
> >  use super::{flags::*, Flags};
> >  use core::alloc::{GlobalAlloc, Layout};
> >  use core::ptr;
> > +use core::ptr::NonNull;
> > 
> > -struct Kmalloc;
> > +use crate::alloc::{AllocError, Allocator};
> > +use crate::bindings;
> > +
> > +/// The contiguous kernel allocator.
> > +///
> > +/// `Kmalloc` is typically used for physically contiguous allocations up to page size, but also
> > +/// supports larger allocations up to `bindings::KMALLOC_MAX_SIZE`, which is hardware specific.
> 
> Does putting a link here work? (I guess we don't yet export the bindings
> documentation, so it will probably fail... When we decide to enable it,
> we should create an issue to add missing links)
> 
> > +///
> > +/// For more details see [self].
> > +pub struct Kmalloc;
> > 
> >  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
> >  fn aligned_size(new_layout: Layout) -> usize {
> > @@ -36,6 +52,60 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
> >      unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
> >  }
> > 
> > +/// # Invariants
> > +///
> > +/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
> > +struct ReallocFunc(
> > +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
> > +);
> > +
> > +impl ReallocFunc {
> > +    // INVARIANT: `krealloc` satisfies the type invariants.
> > +    const KREALLOC: Self = Self(bindings::krealloc);
> > +
> > +    /// # Safety
> > +    ///
> > +    /// This method has the same safety requirements as [`Allocator::realloc`].
> > +    unsafe fn call(
> > +        &self,
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > +        let size = aligned_size(layout);
> > +        let ptr = match ptr {
> > +            Some(ptr) => ptr.as_ptr(),
> > +            None => ptr::null(),
> > +        };
> > +
> > +        // SAFETY: `ptr` is either NULL or valid by the safety requirements of this function.
> 
> You need some justification as to why calling the three allowed
> functions here.

What kind of justification do I need? Can you please share some more details on
what you think is missing here?

> 
> > +        let raw_ptr = unsafe {
> > +            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
> > +            self.0(ptr.cast(), size, flags.0).cast()
> > +        };
> > +
> > +        let ptr = if size == 0 {
> > +            NonNull::dangling()
> > +        } else {
> > +            NonNull::new(raw_ptr).ok_or(AllocError)?
> > +        };
> > +
> > +        Ok(NonNull::slice_from_raw_parts(ptr, size))
> > +    }
> > +}
> > +
> > +unsafe impl Allocator for Kmalloc {
> 
> Missing SAFETY comment.

Yeah, I think we came across this in an earlier version of the series. I asked
you about the content and usefulness of a comment here, since I'd just end up
re-iterating what the `Allocator` trait documentation says.

IIRC, you replied that you want to think of something that'd make sense to add
here.

What do you think should be written here?

> 
> ---
> Cheers,
> Benno
> 
> > +    #[inline]
> > +    unsafe fn realloc(
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > +        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
> > +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
> > +    }
> > +}
> > +
> >  unsafe impl GlobalAlloc for Kmalloc {
> >      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> >          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
> > --
> > 2.46.0
> > 
> 

