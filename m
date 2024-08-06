Return-Path: <linux-kernel+bounces-276724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6AE949794
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D981284D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D57BB15;
	Tue,  6 Aug 2024 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmlvxWup"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FF3A267;
	Tue,  6 Aug 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969045; cv=none; b=deDU+kSl5JENPjs8hq73alrbL81ZuKQzCeYiHFNMS4AzKpgFRwotmgPiQS0aPsSy6D7ktqxoOip5SYeiKRsb81BEiWHLxtLzolI5yLN1V50rvTUDNZrn+8A0bNzDKjhMfKSfBNbKmQAM4q1+Z9L72lSa+R+j9ofnhwVSP4vjpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969045; c=relaxed/simple;
	bh=xzUaVigbSo2U9gvf8g+JYKGYUwxk0Mq+AUKIOZLie1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5/Lo29GtiR1b57r2P31VQtNZXY/YL70bWIgz4qUswlSSEzd9hdY1e27VDooYNGJsBH93pFK4u2hQLhVjjkPrhHM9R+8wvCEB7nBjlFYlnSkriNYtRsWo20CSfWuxSSt87RU3YYoApBMVOq2qvqalHhslNDpOVXNPhkiq9irVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmlvxWup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74045C4AF0D;
	Tue,  6 Aug 2024 18:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722969045;
	bh=xzUaVigbSo2U9gvf8g+JYKGYUwxk0Mq+AUKIOZLie1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmlvxWuprz9MPJBlYtCskMFrF6/nFDIYhMLOuPg2/4mk8fI/IlRLcyYrCCdrKpT+5
	 wAt0xOTzu52GzSl3D6rhaOOPgwdpCURiZi2uMd1RgLNjIE8bU5DZaQPjAw5JIp/yPP
	 sDRBs5FMQmHhZPnS+8nc5AYPWwvPcLEyXAGhPOs4ol9fnFcCe+Xuga0ZKaYKQm9YMI
	 /z5spQjk3wJu8sA87vAqNO5vhjs7BkOxbxwD6N5PGw1VxWaxu0+x0zbqxf6lnv/eSm
	 HYwlX3Deu/S1wDwXqdgm7SsLy0N6hqjNyntoIuSH4Bm2ozx/PjBC6IO/nSd0PneQSV
	 xG4xGJ57ly2Eg==
Date: Tue, 6 Aug 2024 20:30:37 +0200
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
Subject: Re: [PATCH v4 01/28] rust: alloc: add `Allocator` trait
Message-ID: <ZrJrzYXM9RffF4kf@pollux.localdomain>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-2-dakr@kernel.org>
 <470b5f70-b592-43a7-81ba-c7f1c852b9f3@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470b5f70-b592-43a7-81ba-c7f1c852b9f3@proton.me>

On Tue, Aug 06, 2024 at 04:03:49PM +0000, Benno Lossin wrote:
> On 05.08.24 17:19, Danilo Krummrich wrote:
> > Add a kernel specific `Allocator` trait, that in contrast to the one in
> > Rust's core library doesn't require unstable features and supports GFP
> > flags.
> > 
> > Subsequent patches add the following trait implementors: `Kmalloc`,
> > `Vmalloc` and `KVmalloc`.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 79 insertions(+)
> > 
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 1966bd407017..8a71a589469d 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -11,6 +11,7 @@
> >  /// Indicates an allocation error.
> >  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
> >  pub struct AllocError;
> > +use core::{alloc::Layout, ptr::NonNull};
> > 
> >  /// Flags to be used when allocating memory.
> >  ///
> > @@ -86,3 +87,81 @@ pub mod flags {
> >      /// small allocations.
> >      pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
> >  }
> > +
> > +/// The kernel's [`Allocator`] trait.
> > +///
> > +/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffer described
> > +/// via [`Layout`].
> > +///
> > +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
> > +/// an object instance.
> 
> This will prevent us from implementing arena-type allocators [^1]. Do we
> want/need those?

I'm not aware of any code in the kernel that does exactly this, but kmem_cache
is rather close to that.

> I have heard that some people use them in embedded systems, but I can't 
> say for sure. But this is a rather big design decision, so we should
> discuss it now.
> 
> [^1]: For those who don't know what I mean by that here is a quick
> sketch (without handling flags and optimizations):
> 
>     pub struct ArenaAlloc<const SIZE: usize> {
>         memory: Opaque<[u8; SIZE]>,
>         head: Cell<usize>,
>     }
> 
>     impl<const SIZE: usize> ArenaAlloc<SIZE> {
>         pub fn new() -> Self {
>             Self {
>                 memory: Opaque::uninit(),
>                 head: 0,
>             }
>         }
>     }
> 
>     impl<const SIZE: usize> Allocator for ArenaAlloc<SIZE> {
>         fn alloc(&self, layout: Layout, _flags: Flags) -> Result<NonNull<u8>, AllocError> {
>             let head = self.head.get();
>             if head + layout.size() >= SIZE {
>                 return Err(AllocError);
>             }
>             let ptr = self.memory.get();
>             let ptr = ptr.cast::<u8>();
>             let ptr = unsafe { ptr.add(head) };
>             self.head.set(head + layout.size());
>             unsafe { NonNull::new_unchecked(ptr) }
>         }
> 
>         unsafe fn realloc(
>             &self,
>             ptr: Option<NonNull<u8>>,
>             old_layout: Layout, // Note that we also need `old_layout`!
>             layout: Layout,
>             flags: Flags
>         ) -> Result<NonNull<u8>, AllocError> {
>             let new = self.alloc(layout, flags)?;
>             let Some(ptr) = ptr else { return Ok(new); };
>             unsafe { core::ptr::copy_nonoverlapping(ptr.as_ptr(), new.as_ptr(), old_layout.size()) };
>             self.free(ptr);
>             Ok(new)
>         }
> 
>         fn free(&self, ptr: NonNull<u8>) { /* noop */ }
>     }
> 
> > +///
> > +/// In order to be able to support `#[derive(SmartPointer)]` later on, we need to avoid a design
> > +/// that requires an `Allocator` to be instantiated, hence its functions must not contain any kind
> > +/// of `self` parameter.
> 
> Ah I see, so since `#[derive(SmartPointer)]` needs `Box` to only consist
> of one non ZST field... I skimmed the RFC discussion and it seems like a
> problem that *might* be solved in the future, but probably not in the
> (very) near future. I guess this is just a bullet that we have to bite.
> We can always have an `ArenaBox` that can deal with that (although
> without `DispatchFromDyn`).
> We should revisit this when `#[derive(SmartPointer)]` becomes advanced
> enough.

Agreed.

> 
> > +///
> > +/// # Safety
> > +///
> > +/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
> > +/// it is explicitly freed.
> > +///
> > +/// Any pointer to a memory buffer which is currently allocated must be valid to be passed to any
> > +/// other [`Allocator`] function of the same type. The same applies for a NULL pointer.
> > +///
> > +/// If `realloc` is called with:
> > +///   - a size of zero, the given memory allocation, if any, must be freed
> > +///   - a NULL pointer, a new memory allocation must be created
> > +pub unsafe trait Allocator {
> > +    /// Allocate memory based on `layout` and `flags`.
> > +    ///
> > +    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
> > +    /// constraints (i.e. minimum size and alignment as specified by `layout`).
> > +    ///
> > +    /// This function is equivalent to `realloc` when called with a NULL pointer.
> > +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> > +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's safety requirements and asks
> > +        // for a new memory allocation.
> > +        unsafe { Self::realloc(None, layout, flags) }
> > +    }
> > +
> > +    /// Re-allocate an existing memory allocation to satisfy the requested `layout`. If the
> > +    /// requested size is zero, `realloc` behaves equivalent to `free`.
> > +    ///
> > +    /// If the requested size is larger than the size of the existing allocation, a successful call
> > +    /// to `realloc` guarantees that the new or grown buffer has at least `Layout::size` bytes, but
> > +    /// may also be larger.
> > +    ///
> > +    /// If the requested size is smaller than the size of the existing allocation, `realloc` may or
> > +    /// may not shrink the buffer; this is implementation specific to the allocator.
> > +    ///
> > +    /// On allocation failure, the existing buffer, if any, remains valid.
> > +    ///
> > +    /// The buffer is represented as `NonNull<[u8]>`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `Some(ptr)` must point to an existing and valid memory allocation created by this allocator
> 
> This is the wrong way around, `ptr: Option<NonNull<u8>>`, so
> `Some(ptr): Option<Option<NonNull<u8>>>`. Instead I would write
> "If `ptr = Some(p)`, then `p` must point to...".

Yes, makes sense.

> 
> > +    /// instance. The alignment encoded in `layout` must be smaller than or equal to the alignment
> > +    /// requested in the previous `alloc` or `realloc` call of the same allocation.
> > +    ///
> > +    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
> > +    /// created.
> > +    ///
> > +    unsafe fn realloc(
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError>;
> > +
> > +    /// Free an existing memory allocation.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
> > +    /// instance.
> 
> Additionally, you need "The memory allocation at `ptr` must never again
> be read from or written to.".

I'm fine adding it, but I wonder if technically this is really required? The
condition whether the pointer is ever accessed again in any way is not relevant
in terms of being a precondition for `free` not causing UB, right?

> 
> ---
> Cheers,
> Benno
> 
> > +    unsafe fn free(ptr: NonNull<u8>) {
> > +        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
> > +        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
> > +        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
> > +    }
> > +}
> > --
> > 2.45.2
> > 
> 

