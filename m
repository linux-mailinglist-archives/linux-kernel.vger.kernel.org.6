Return-Path: <linux-kernel+bounces-287345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CBE9526B5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5B52838B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8007C18D626;
	Thu, 15 Aug 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHyTNH2Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD8A32;
	Thu, 15 Aug 2024 00:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680982; cv=none; b=jOgNYPDGdNIUghC1aSqaVZ2dJdQ//EtFCVS3p4H4h5mraff5cA8CeNB1CpZNsrK4CBKidFGp+KCrWgKilmWHrsBgJVeyEL7Zc6ZeZtOYubCgQjAXfPmCWzSZD4wneaBrKcPmiaeFC5yQrotNQF9DDN0ozhpCUiEhKMmFa9DyTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680982; c=relaxed/simple;
	bh=8n714ePaEc1LnJejZ6lCUckFCOLvDCkdBz92Ksi4mCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5zijoo4VaokopWvBzr9QtLE2U2vsd4blcid3hegGb9/K5pdM4Qw7jKxo9zHYqansXFNzYlL+4vcIZdASa9UEPVKBJ7iNVYB7DekiMMeka0T7UWrq+nWlVgWvXOdCqW1YKGY9Yx7HmgQjtE1WMMxp6/6NJgIPihaIU++F+RXvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHyTNH2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3F8C116B1;
	Thu, 15 Aug 2024 00:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723680982;
	bh=8n714ePaEc1LnJejZ6lCUckFCOLvDCkdBz92Ksi4mCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHyTNH2QfiCQCfU8sclHYwXUoDgaB3GJCWBMNhzTG1hDk3Zt+z0BYOqDZoTBc72Wp
	 a6mJZ0QaHN/kaKkbqtqwodHhs0p5LKL+Z85mD3Z9YEopckDKlMW1XexyTV+y7rdCFk
	 JKlNa8bOVwGu82TXzNZG8lccY3aYprCupiPwBgxB6tX+TjYqjCqetK2u2DkAJ8GBKX
	 OvmQbx/WDyP0XUIMC5AoKNpCxWSjTRtt9dEalFnIr20qn96wZXQ88zNRLC3s3atFKW
	 KZ3/tyNCfExKeENCFoYeRgC6wHU5+7ao5ZiH9/3+Rz9ALTTGR4FaGsS7si4an5bURQ
	 aBSj3fCJDheFA==
Date: Thu, 15 Aug 2024 02:16:14 +0200
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
Subject: Re: [PATCH v5 01/26] rust: alloc: add `Allocator` trait
Message-ID: <Zr1Izo9Qp8mYkbpr@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-2-dakr@kernel.org>
 <cfcdaa42-6a62-4a17-a8dc-2382e88774dc@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfcdaa42-6a62-4a17-a8dc-2382e88774dc@proton.me>

On Wed, Aug 14, 2024 at 04:13:06PM +0000, Benno Lossin wrote:
> On 12.08.24 20:22, Danilo Krummrich wrote:
> > Add a kernel specific `Allocator` trait, that in contrast to the one in
> > Rust's core library doesn't require unstable features and supports GFP
> > flags.
> > 
> > Subsequent patches add the following trait implementors: `Kmalloc`,
> > `Vmalloc` and `KVmalloc`.
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs | 81 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> > 
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 1966bd407017..194745498a75 100644
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
> > @@ -86,3 +87,83 @@ pub mod flags {
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
> > +///
> > +/// In order to be able to support `#[derive(SmartPointer)]` later on, we need to avoid a design
> > +/// that requires an `Allocator` to be instantiated, hence its functions must not contain any kind
> > +/// of `self` parameter.
> > +///
> > +/// # Safety
> > +///
> > +/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
> > +/// it is explicitly freed.
> 
> I wouldn't say that an allocator "returns memory", and in general I
> don't think the structure of the safety comment here is nice, how about
> the following: we put "Implementers must ensure that all trait functions
> abide by the guarantees documented in the `# Guarantees` sections."...

Sounds reasonable to me. Additionally, I'd still keep the part below, that says
that any pointer to a memory allocation must bbe valid to be passed to any other [`Allocator`]
function of the same type.

> 
> > +///
> > +/// Any pointer to a memory buffer which is currently allocated must be valid to be passed to any
> > +/// other [`Allocator`] function of the same type.
> > +///
> > +/// If `realloc` is called with:
> > +///   - a size of zero, the given memory allocation, if any, must be freed
> > +///   - `None`, a new memory allocation must be created
> > +pub unsafe trait Allocator {
> > +    /// Allocate memory based on `layout` and `flags`.
> > +    ///
> > +    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
> > +    /// constraints (i.e. minimum size and alignment as specified by `layout`).
> > +    ///
> > +    /// This function is equivalent to `realloc` when called with `None`.
> 
> ... Then we can add this here:
> 
>     /// # Guarantees
>     ///
>     /// When the return value is `Ok(ptr)`, then `ptr` is
>     /// - valid for writes (and reads after the memory has been initialized) for `layout.size()` bytes,
>     ///   until it is passed to [`Allocator::free`] or [`Allocator::realloc`],
>     /// - aligned to `layout.align()`,
>     /// - is valid for reads, if `flags.contains(flags::__GFP_ZERO)`,
> 
> Do we need to handle other flags?

The whole flags thing is a bit difficult to represent here properly.

Theoretically, we'd need to add that it guarantees that the memory is zeroed for
__GFP_ZERO, non-blocking for GFP_NOWAIT, etc. But, I think we shouldn't
re-iterate all different behavior for the different flags.

Another inconvenience is that not all page flags are honored or make sense for
all allocators. This is especially inconvenient for `KVmalloc` where we can't
even say if we end up in vrealloc() or krealloc(). kvmalloc() even contains a
couple of flag fixups for this reason [2].

I think we should just point to [1], which should document everything already.

[1] https://elixir.bootlin.com/linux/v6.10.4/source/include/linux/gfp_types.h
[2] https://elixir.bootlin.com/linux/v6.10.4/source/mm/util.c#L612

> Also IIRC the memory given to us by C is considered initialized by Rust
> (though it has a non-deterministic value), so we might have an
> unconditional "valid for reads". Am I correct?

Yes, but as you say, unless allocated with __GFP_ZERO, it contains non-deterministic data. It may
even contain old data from previous allocations.

> 
> 
> > +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> > +        // SAFETY: Passing `None` to `realloc` is valid by it's safety requirements and asks for a
> > +        // new memory allocation.
> > +        unsafe { Self::realloc(None, layout, flags) }
> > +    }
> > +
> > +    /// Re-allocate an existing memory allocation to satisfy the requested `layout`. If the
> > +    /// requested size is zero, `realloc` behaves equivalent to `free`.
> 
> I don't think we want to include the second sentence in the short
> description of this function, please add an empty line in between.
> 
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
> > +    /// If `ptr = Some(p)`, then `p` must point to an existing and valid memory allocation created
> 
> I don't like the single `=` (I might have written it in haste myself),
> how about `==` or we use if-let syntax?
> 
> > +    /// by this allocator. The alignment encoded in `layout` must be smaller than or equal to the
> > +    /// alignment requested in the previous `alloc` or `realloc` call of the same allocation.
> > +    ///
> > +    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
> > +    /// created.
> 
> This Safety section does not talk about the case `layout.size() == 0`,
> but it should have the same requirement as `free()`.
> 
> Also add a `# Guarantees` section here:
> 
>     /// # Guarantees
>     ///
>     /// This function has the same guarantees as [`Allocator::alloc`]. When `ptr == Some(p)`, then it
>     /// additionally has the following:
>     /// - when `Ok(ret_ptr)` is the return value, then
>     ///   `ret_ptr[0..min(layout.size(), old_size)] == p[0..min(layout.size(), old_size)]`, where
>     ///   `old_size` is the size of the allocation that `p` points at.

We could also say "The contents of the memory pointed to by `p` are preserved
up to the lesser of the new and old size." But I'm fine with both.

>     /// - when the return value is `Err(AllocError)`, then `p` is still valid.
> 
> ---
> Cheers,
> Benno
> 
> > +    unsafe fn realloc(
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError>;
> 
> > +
> > +    /// Free an existing memory allocation.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator` and
> > +    /// must not be a dangling pointer.
> > +    ///
> > +    /// The memory allocation at `ptr` must never again be read from or written to.
> > +    unsafe fn free(ptr: NonNull<u8>) {
> > +        // SAFETY: The caller guarantees that `ptr` points at a valid allocation created by this
> > +        // allocator. We are passing a `Layout` with the smallest possible alignment, so it is
> > +        // smaller than or equal to the alignment previously used with this allocation.
> > +        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
> > +    }
> > +}
> > --
> > 2.45.2
> > 
> 

