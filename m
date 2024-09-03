Return-Path: <linux-kernel+bounces-312845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7F969C60
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E86DA1F251B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F841A42AE;
	Tue,  3 Sep 2024 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="giQfQLrz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8119F41F;
	Tue,  3 Sep 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364096; cv=none; b=f6Ci7AKGQdF/rf995DLffGE2h8XIf3xzRUqIE2f8x2TAqwCE6i879q3U94KvT3kto27h93qYSWR8c2CWBBra0NEMHavDutcFg6f8PJh8Dvs8Skhj5E4LIM13SQa2sxVKPlDiNUr7OPfb8RDeXJA5QlzQgxd62oMzJKeWVh3mwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364096; c=relaxed/simple;
	bh=hO+C6A+eNj4TLJv4y9Ur2zuJIyl6632D7KN1QOitnwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGyMi7Jm0Ffto8/he2IIs/2kfTbF1dw9T8llHJv/vbNpnY2+Sftd08rbbzG99aPpZIeYC+qyfv1galD0WD/+soZfdv+qwAb9yPdu3/AVcDzz9/0/shM62AxPgqNhbwkgOawubcqOQjCaDnluTU7a1FdkqvX0nCkk4IsAc9EVsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=giQfQLrz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44806C4CEC4;
	Tue,  3 Sep 2024 11:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725364096;
	bh=hO+C6A+eNj4TLJv4y9Ur2zuJIyl6632D7KN1QOitnwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=giQfQLrzY36BKYRDcJhzPoonO1XaZH7XMyEOZQCSMUhI7M5tJhJcaZikNwl4grBHf
	 VX9XzP0K16WgKmhqZau2oAj//nc0Qf5KA73BbtZtoAP7ASbO3U2lHScDOaEdAzIs/S
	 7CWYIObPpKVOvv4SfugJXrirPWtQ21D3t/cc+ttnzOJEROnFRSpEuydTXAJcPiI7kb
	 Ls3FYy4tVKWeoggy3QYThENIM2PwVS8MC/mW6mDS94DDqbzA1m4cNQzCL7b+jAAbcE
	 q3HD+CT5xlChoD36S7MGox4Rvc9X+N0jdSj22wDkxxhiYcQgNXBuzxyKi8sFz71STk
	 J7l9sdehKqyxQ==
Date: Tue, 3 Sep 2024 13:48:08 +0200
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
Message-ID: <Ztb3eOoiHs2rLCoH@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-5-dakr@kernel.org>
 <2dd02834-b2b6-4ff6-9e29-43c9d77b69e2@proton.me>
 <ZtDwduKjIEZ3RQtk@pollux.localdomain>
 <962b7014-4f8b-4abe-8774-636b612a051c@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <962b7014-4f8b-4abe-8774-636b612a051c@proton.me>

On Fri, Aug 30, 2024 at 02:45:35PM +0000, Benno Lossin wrote:
> On 30.08.24 00:04, Danilo Krummrich wrote:
> > On Thu, Aug 29, 2024 at 06:32:42PM +0000, Benno Lossin wrote:
> >> On 16.08.24 02:10, Danilo Krummrich wrote:
> >>> Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
> >>> typically used for objects smaller than page size.
> >>>
> >>> All memory allocations made with `Kmalloc` end up in `krealloc()`.
> >>>
> >>> It serves as allocator for the subsequently introduced types `KBox` and
> >>> `KVec`.
> >>>
> >>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >>> ---
> >>>  rust/kernel/alloc.rs           |  2 +-
> >>>  rust/kernel/alloc/allocator.rs | 72 +++++++++++++++++++++++++++++++++-
> >>>  2 files changed, 72 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> >>> index 9932f21b0539..477dbe3c5a2f 100644
> >>> --- a/rust/kernel/alloc.rs
> >>> +++ b/rust/kernel/alloc.rs
> >>> @@ -4,7 +4,7 @@
> >>>
> >>>  #[cfg(not(test))]
> >>>  #[cfg(not(testlib))]
> >>> -mod allocator;
> >>> +pub mod allocator;
> >>>  pub mod box_ext;
> >>>  pub mod vec_ext;
> >>>
> >>> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
> >>> index e32182f91167..78e7d5488843 100644
> >>> --- a/rust/kernel/alloc/allocator.rs
> >>> +++ b/rust/kernel/alloc/allocator.rs
> >>> @@ -1,12 +1,28 @@
> >>>  // SPDX-License-Identifier: GPL-2.0
> >>>
> >>>  //! Allocator support.
> >>> +//!
> >>> +//! Documentation for the kernel's memory allocators can found in the "Memory Allocation Guide"
> >>> +//! linked below. For instance, this includes the concept of "get free page" (GFP) flags and the
> >>> +//! typical application of the different kernel allocators.
> >>> +//!
> >>> +//! Reference: <https://docs.kernel.org/core-api/memory-allocation.html>
> >>
> >> Thanks, this nice.
> >>
> >>>
> >>>  use super::{flags::*, Flags};
> >>>  use core::alloc::{GlobalAlloc, Layout};
> >>>  use core::ptr;
> >>> +use core::ptr::NonNull;
> >>>
> >>> -struct Kmalloc;
> >>> +use crate::alloc::{AllocError, Allocator};
> >>> +use crate::bindings;
> >>> +
> >>> +/// The contiguous kernel allocator.
> >>> +///
> >>> +/// `Kmalloc` is typically used for physically contiguous allocations up to page size, but also
> >>> +/// supports larger allocations up to `bindings::KMALLOC_MAX_SIZE`, which is hardware specific.
> >>
> >> Does putting a link here work? (I guess we don't yet export the bindings
> >> documentation, so it will probably fail... When we decide to enable it,
> >> we should create an issue to add missing links)
> >>
> >>> +///
> >>> +/// For more details see [self].
> >>> +pub struct Kmalloc;
> >>>
> >>>  /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
> >>>  fn aligned_size(new_layout: Layout) -> usize {
> >>> @@ -36,6 +52,60 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
> >>>      unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
> >>>  }
> >>>
> >>> +/// # Invariants
> >>> +///
> >>> +/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
> >>> +struct ReallocFunc(
> >>> +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
> >>> +);
> >>> +
> >>> +impl ReallocFunc {
> >>> +    // INVARIANT: `krealloc` satisfies the type invariants.
> >>> +    const KREALLOC: Self = Self(bindings::krealloc);
> >>> +
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// This method has the same safety requirements as [`Allocator::realloc`].
> >>> +    unsafe fn call(
> >>> +        &self,
> >>> +        ptr: Option<NonNull<u8>>,
> >>> +        layout: Layout,
> >>> +        flags: Flags,
> >>> +    ) -> Result<NonNull<[u8]>, AllocError> {
> >>> +        let size = aligned_size(layout);
> >>> +        let ptr = match ptr {
> >>> +            Some(ptr) => ptr.as_ptr(),
> >>> +            None => ptr::null(),
> >>> +        };
> >>> +
> >>> +        // SAFETY: `ptr` is either NULL or valid by the safety requirements of this function.
> >>
> >> You need some justification as to why calling the three allowed
> >> functions here.
> > 
> > What kind of justification do I need? Can you please share some more details on
> > what you think is missing here?
> 
> So, you are calling a function pointer to an `unsafe` function. This
> means that through some invariant you have to know what the safety
> requirements are (otherwise how can you guarantee that this is OK?). You
> have the invariant that the pointer points at one of the three functions
> mentioned above. What are the safety requirements of those functions? I
> would assume that the only one is that `ptr` is valid. So you can use:
> 
>     // SAFETY:
>     // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and thus only requires that `ptr` is
>     //   NULL or valid.

I'm fine adding it, but I'd like to understand why you think it's required in
the safety comment here? Isn't this implicit by being the type invariant?

>     // - `ptr` is either NULL or valid by the safety requirements of this function.

This is the part I already have.

> 
> >>> +        let raw_ptr = unsafe {
> >>> +            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
> >>> +            self.0(ptr.cast(), size, flags.0).cast()
> >>> +        };
> >>> +
> >>> +        let ptr = if size == 0 {
> >>> +            NonNull::dangling()
> >>> +        } else {
> >>> +            NonNull::new(raw_ptr).ok_or(AllocError)?
> >>> +        };
> >>> +
> >>> +        Ok(NonNull::slice_from_raw_parts(ptr, size))
> >>> +    }
> >>> +}
> >>> +
> >>> +unsafe impl Allocator for Kmalloc {
> >>
> >> Missing SAFETY comment.
> > 
> > Yeah, I think we came across this in an earlier version of the series. I asked
> > you about the content and usefulness of a comment here, since I'd just end up
> > re-iterating what the `Allocator` trait documentation says.
> > 
> > IIRC, you replied that you want to think of something that'd make sense to add
> > here.
> 
> Oh yeah, sorry I forgot about that.
>  
> > What do you think should be written here?
> 
> I think the best way to do it, would be to push this question down into
> `ReallocFunc::call`. So we would put this on the trait:
> 
>     // SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
>     // - memory remains valid until it is explicitly freed,
>     // - passing a pointer to a vaild memory allocation is OK,
>     // - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.

So, we'd also need the same for:
  - `unsafe impl Allocator for Vmalloc`
  - `unsafe impl Allocator for KVmalloc`

> 
> We then need to put this on `ReallocFunc::call`:
> 
>     /// # Guarantees
>     ///
>     /// This method has the same guarantees as `Allocator::realloc`. Additionally
>     /// - it accepts any pointer to a valid memory allocation allocated by this function.

You propose this, since for `Allocator::realloc` memory allocated with
`Allocator::alloc` would be fine too I guess.

But if e.g. `Kmalloc` wouldn't use the default `Allocator::alloc`, this would be
valid too.

We could instead write something like:

"it accepts any pointer to a valid memory allocation allocated with the same
kernel allocator."

>     /// - memory allocated by this function remains valid until it is passed to this function.

Same here, `Kmalloc` could implement its own `Allocator::free`.

Maybe just "...until it is explicitly freed.".

Anyway, I'm fine with both, since non of the kernel allocators uses anything
else than `ReallocFunc::call` to allocate and free memory.

> 
> Finally, we need a `GUARANTEE` comment (just above the return [^1]
> value) that establishes these guarantees:
> 
>     // GUARANTEE: Since we called `self.0` with `size` above and by the type invariants of `Self`,
>     // `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`. Those functions provide the guarantees of
>     // this function.
> 
> I am not really happy with the last sentence, but I also don't think
> that there is value in listing out all the guarantees, only to then say
> "all of this is guaranteed by us calling one of these three functions.
> 
> 
> [^1]: I am not sure that there is the right place. If you have any
>       suggestions, feel free to share them.

Either way, I'm fine with this proposal.

> 
> 
> >>> +    #[inline]
> >>> +    unsafe fn realloc(
> >>> +        ptr: Option<NonNull<u8>>,
> >>> +        layout: Layout,
> >>> +        flags: Flags,
> >>> +    ) -> Result<NonNull<[u8]>, AllocError> {
> >>> +        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
> >>> +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
> >>> +    }
> >>> +}
> 
> Oh one more thing, I know that you already have a lot of patches in this
> series, but could you split this one into two? So the first one should
> introduce `ReallocFunc` and the second one add the impl for `Kmalloc`?
> I managed to confuse me twice because of that :) 

Generally, I'm fine with that, but I'm not sure if I can avoid an intermediate
compiler warning about unused code doing that.

> 
> ---
> Cheers,
> Benno
> 
> >>> +
> >>>  unsafe impl GlobalAlloc for Kmalloc {
> >>>      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> >>>          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
> >>> --
> >>> 2.46.0
> >>>
> >>
> 

