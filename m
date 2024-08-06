Return-Path: <linux-kernel+bounces-276740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A019497C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6F82843DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DAF7CF30;
	Tue,  6 Aug 2024 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSDO4Ue5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF38F77;
	Tue,  6 Aug 2024 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722970524; cv=none; b=rIBIqjk/q8MW8DRo+zmCdBsJf3cCO6ZgJxSH1lhigW8pTup2HIgT9de3uv1MxrQQTiCdpkv3+cbRQTrQd3PjijR/o2uD3f2Nh6FckLxjrDZ3X7UhG293+ilEmI9XA/mkHeH/vzeofsbFvjTLCEEDEZa/nyIexShJdMm2lqGxrlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722970524; c=relaxed/simple;
	bh=ELUeXZjEYZYjTPyhCLfB8jFhtbY1lakHB6CZNBbwEko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kw3iiJh9VsCxq9trImSNDbVtbHsserqRFtup5i9hI3tiA2Do1AhCVOE9IKqLKI8DigAHZplRazash4wSvoILfi3LQbQn7MkDupRPUttCkX70GkVIMBCqei3zQQqOsYlhb+HW9KDMrGfEq7F4UBVExHploqMsjz/q6/zyvZMMeiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSDO4Ue5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6CAC32786;
	Tue,  6 Aug 2024 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722970523;
	bh=ELUeXZjEYZYjTPyhCLfB8jFhtbY1lakHB6CZNBbwEko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSDO4Ue5H+ByvMwMXjciLxo2r8Fc769DAl5UF4s+nCOXJOQCsWf7T2GytSco06nGB
	 lEzsxmFwFX0jYI9ghSJSKg74Z+Y20YDemSHIKLvdHzlD7rusKjXSnpa9bIHBOQ0b/T
	 awWIMhxDV88LlCWWdAqfI9hjF88p8+elzKAj8PU4rydujEvqKhErCQMw5BT0Bueeqs
	 Le6gRqtQC5o1WRp5JjW2SYRhdLyEXhV/P99otkBgW8yakfSCX4rsC172fjJW1QMReB
	 ycYafQNrtax0WWeC00f1vflEWu/olRbUFoz73yB0Bz2NWOIMbr3X9fIZTpbxoRdDOg
	 uYpbEehhH1Oeg==
Date: Tue, 6 Aug 2024 20:55:15 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4 04/28] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <ZrJxkwF2Y59xln1e@pollux.localdomain>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-5-dakr@kernel.org>
 <fe982cb6-4910-4ba2-ae4d-892514c9e7f7@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe982cb6-4910-4ba2-ae4d-892514c9e7f7@proton.me>

On Tue, Aug 06, 2024 at 04:51:28PM +0000, Benno Lossin wrote:
> On 05.08.24 17:19, Danilo Krummrich wrote:
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
> >  rust/helpers.c                 |  3 +-
> >  rust/kernel/alloc.rs           |  2 +-
> >  rust/kernel/alloc/allocator.rs | 68 +++++++++++++++++++++++++++++++++-
> >  3 files changed, 69 insertions(+), 4 deletions(-)
> > 
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 92d3c03ae1bd..9f7275493365 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -193,8 +193,7 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> > 
> > -void * __must_check __realloc_size(2)
> > -rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> > +void *rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
> >  {
> >  	return krealloc(objp, new_size, flags);
> >  }
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 8a71a589469d..bc01a17df5e0 100644
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
> > index 2c1eae25da84..c6ad1dd59dd0 100644
> > --- a/rust/kernel/alloc/allocator.rs
> > +++ b/rust/kernel/alloc/allocator.rs
> > @@ -5,8 +5,16 @@
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
> > +/// The contiguous kernel allocator only ever allocates physically contiguous memory through
> > +/// `bindings::krealloc`.
> > +pub struct Kmalloc;
> > 
> >  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
> >  fn aligned_size(new_layout: Layout) -> usize {
> > @@ -40,6 +48,64 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
> >      }
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
> 
> This INVARIANT comment should be moved one line downwards.
> 
> > +    fn krealloc() -> Self {
> > +        Self(bindings::krealloc)
> > +    }
> > +
> > +    /// # Safety
> > +    ///
> > +    /// This method has the exact same safety requirements as `Allocator::realloc`.
> 
> I would remove "exact", I don't think we want to mean "almost the same"
> when we write just "same".
> 
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
> > +        // SAFETY: `ptr` is valid by the safety requirements of this function.
> 
> "`ptr` is either NULL or valid by the safety requirements of this
> function."

Agreed, for this one and the above ones.

> 
> > +        let raw_ptr = unsafe {
> > +            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
> > +            self.0(ptr.cast(), size, flags.0).cast()
> > +        };
> > +
> > +        let ptr = if size == 0 {
> > +            NonNull::dangling()
> 
> If we call `realloc(Some(ptr), <layout with size = 0>, ...)`, then this
> leaks the pointer returned by the call to `self.0` above. I don't know
> what the return value of the different functions are that can appear in
> `self.0`, do they return NULL?

That is fine, we don't care about the return value. All `ReallocFunc` free the
memory behind `ptr` if called with a size of zero. But to answer the question,
they return either NULL or ZERO_SIZE_PTR.

> 
> What about the following sequence:
> 
>     let ptr = realloc(None, <layout with size = 0>, ...);
>     let ptr = realloc(Some(ptr), <layout with size = 0>, ...);
> 
> Then the above call to `self.0` is done with a dangling pointer, can the
> functions that appear in `self.0` handle that?

This would be incorrect.

Calling `realloc(Some(ptr), <layout with size = 0>, ...)` frees the memory
behind `ptr`. This is guranteed behavior for all `ReallocFunc`s, i.e.
krealloc(), vrealloc(), kvrealloc().

> 
> > +        } else {
> > +            NonNull::new(raw_ptr).ok_or(AllocError)?
> > +        };
> > +
> > +        Ok(NonNull::slice_from_raw_parts(ptr, size))
> > +    }
> > +}
> > +
> > +unsafe impl Allocator for Kmalloc {
> > +    unsafe fn realloc(
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError> {
> > +        let realloc = ReallocFunc::krealloc();
> > +
> > +        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
> > +        // allocated with this `Allocator`.
> 
> What about the other requirements? (they should be satisfied, since they
> are also requirements for calling this function)

Indeed, I think we should just write that by definition `Realloc::call` has the
same safety requirements as `Allocator::realloc`.

> 
> > +        unsafe { realloc.call(ptr, layout, flags) }
> 
> If you make `ReallocFunc::krealloc()` into a constant
> `ReallocFunc::KREALLOC`, then we could avoid the let binding above.

Agreed, sounds good.

> 
> ---
> Cheers,
> Benno
> 
> > +    }
> > +}
> > +
> >  unsafe impl GlobalAlloc for Kmalloc {
> >      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> >          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
> > --
> > 2.45.2
> > 
> 

