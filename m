Return-Path: <linux-kernel+bounces-329951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CBA9797E2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8491F21672
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303B41C9DEF;
	Sun, 15 Sep 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxAD4kir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C66913DDA7;
	Sun, 15 Sep 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726419770; cv=none; b=FZMY/4ZT+qUp8GrDTV05HPbvYNv6tdymdB8MniMRc/PUtFZgU2n80ET+8DAf7euIlC0JvjPjzeodMcoqD5FEOcxHZfsv948RcIGAKS41VLgyX+bKhBYXGWI0jQcslkgAAfd2MtB6xmLgCGMwD9U0q9mqDzsvSPWGudTnR2GSX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726419770; c=relaxed/simple;
	bh=WZPk9opx1LCJC7OYBNPeFY2ZfjHr6lwUOVaXxUc2F7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz2/CLeupFd+LEs787YwN2fDBG4De5pwFbn8YmnrEWnRzzN0Y48iTyA74gPFsxfFaemlIxTgxGvQcQJuktg2Du5lSU+LX6AEsABpBEoUyyJFX04xc9KBwjJrBJxQuJGHV7AUCboEgBB6HDy4ssmyPaByq/0hewFp6tyO4FpY77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxAD4kir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46ACC4CEC3;
	Sun, 15 Sep 2024 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726419769;
	bh=WZPk9opx1LCJC7OYBNPeFY2ZfjHr6lwUOVaXxUc2F7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxAD4kirRf0SB3OWr5tAIElLJ+h/srBrqfqxiF9IbMY3xLtbqVBmUYKYsKcyHEaaS
	 CqfvJ5yp7GUpXw9mfNND4M+1n6eNkIYKIz529VjyAcPMvp+1K9iYqdJqxA46DoVDFU
	 K5pY9upd5kang/dd1cLjrr6+A9X+km9WwgyD/K57dVBIMItaTGrYo3jVYYlsP3pG/C
	 bOV9KShXS4jIuHfdRMm+xBLBzrGydy5QK4cjLaZYowqA+vdBb+Ie+dzZI/Ccjl9ko6
	 DtgKYgWgu/bjQbzFhoB6tni1l+3AEFYoMLNtxMdFJubdUzaz/b3QyDlu+Vp/9KQyVq
	 UbQZ6TcTWE6gQ==
Date: Sun, 15 Sep 2024 19:02:40 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 01/26] rust: alloc: add `Allocator` trait
Message-ID: <ZucTMDCcoVH4oGs1@pollux>
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-2-dakr@kernel.org>
 <20240915162813.149e21f2.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915162813.149e21f2.gary@garyguo.net>

Hi Gary,

thanks for taking a look.

On Sun, Sep 15, 2024 at 04:28:13PM +0100, Gary Guo wrote:
> On Thu, 12 Sep 2024 00:52:37 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Add a kernel specific `Allocator` trait, that in contrast to the one in
> > Rust's core library doesn't require unstable features and supports GFP
> > flags.
> > 
> > Subsequent patches add the following trait implementors: `Kmalloc`,
> > `Vmalloc` and `KVmalloc`.
> 
> Hi Danilo,
> 
> I think the current design is unsound regarding ZST.
> 
> Let's say that `Allocator::alloc` gets called with a ZST type with
> alignment of 4096. Your implementation will call into `krelloc` with
> new_size of 0, which gets turned into of `kfree` of null pointer, which
> is no-op. Everything is fine so far. Krealloc returns `ZERO_SIZE_PTR`,
> and then implementation of `<Kmalloc as Allocator>::realloc` throws it
> away and returns `NonNull::dangling`.
> 
> Since `NonNull::dangling` is called with T=u8, this means the pointer
> returns is 1, and it's invalid for ZSTs with larger alignments.

Right, this interface is not meant to handle "allocations" for ZSTs.

But you're right, since `alloc` is a safe function, we should return a properly
aligned pointer.

> 
> And this is unfixable even if the realloc implementation is changed.
> Let's say the realloc now returns a dangling pointer that is suitable
> aligned. Now let's see what happens when the `Allocator::free` is
> called. `kfree` would be trying to free a Rust-side ZST pointer, but it
> has no way to know that it's ZST!

Right, that's why it's not valid to call `free` with dangling pointers.

From the safety comment of `free`:

"`ptr` must point to an existing and valid memory allocation created by this
`Allocator` and must not be a dangling pointer."

We still need the same in `realloc` though.

> 
> I can see 3 ways of fixing this:
> 1. Reject ZSTs that have larger alignment than 16 and fix the realloc
> implementation to return suitable aligned ZST pointer. I don't
> particularly like the idea of allocating ZST can fail though.
> 2. Say ZST must be handled by the caller, and make alloc function
> unsafe. This means that we essentially revert to the `GlobalAlloc`
> design of Rust, and all callers have to check for ZST.
> 3. Accept the `old_layout` and use it to check whether the allocation
> is ZST allocation.
> 
> My personal preference is 3.

There is also 4.

Let `alloc` and `realloc` return a properly aligned dangling pointer for
`size == 0` and don't accept dangling pointers in `realloc` and `free`.

And 5.

Reject the combination of `None` and `size == 0` entirely, as earlier proposed
by Benno.

I'm fine with both, 4. and 5. with a slight preference for 4.

I'd also go along with 1., as a mix of 4. and 5.

I really don't like making `alloc` unsafe, and I really don't want to have
`old_layout` in `free`. Please let's not discuss this again. :-)

> 
> Best,
> Gary
> 
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs | 112 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> > 
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 1966bd407017..6c21bd2edad9 100644
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
> > @@ -86,3 +87,114 @@ pub mod flags {
> >      /// small allocations.
> >      pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
> >  }
> > +
> > +/// The kernel's [`Allocator`] trait.
> > +///
> > +/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffers described
> > +/// via [`Layout`].
> > +///
> > +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
> > +/// an object instance.
> 
> I think whether the Allocator is ZST or not doesn't matter anymore
> since we say that functions do not operate on an instance.

IMO, It's still valid to say that it's designed to be implemented as ZST,
especially since it's never instantiated.

> 
> > +///
> > +/// In order to be able to support `#[derive(SmartPointer)]` later on, we need to avoid a design
> > +/// that requires an `Allocator` to be instantiated, hence its functions must not contain any kind
> > +/// of `self` parameter.
> 
> 
> nit: this is the reason for `Allocator` to not have instances, so
> should be merged together with the preceding sentence into one
> paragraph.
> 
> > +///
> > +/// # Safety
> > +///
> > +/// - A memory allocation returned from an allocator must remain valid until it is explicitly freed.
> > +///
> > +/// - Any pointer to a valid memory allocation must be valid to be passed to any other [`Allocator`]
> > +///   function of the same type.
> > +///
> > +/// - Implementers must ensure that all trait functions abide by the guarantees documented in the
> > +///   `# Guarantees` sections.
> > +//
> > +// Note that `Allocator::{realloc,free}` don't have an `old_layout` argument (like stdlib's
> > +// corresponding `Allocator` trait functions have), since the implemented (kernel) allocators
> > +// neither need nor honor such an argument. Thus, it would be misleading to make this API require it
> > +// anyways.
> 
> I would drop the "honor" part, and drop the sentence saying it's
> misleading to require it. The documentation should say why we don't
> have the `old_layout` argument (because we don't need it for now), and
> shouldn't be trying to dissuade it from being added if it ends up being
> useful in the future.

But the honor part is the crucial one for me. Just because it's not needed it
could still be optional (and honored). But that's not the case. And because of
that it would indeed be misleading to have the argument.

That's really just my reason, I'm not trying to dissuade anyone from adding it
if it's actually needed.

If there's a good reason to add it, and it's honored by (other) implementations,
it wouldn't be generally misleading anymore.

> 
> > +//
> > +// More generally, this trait isn't intended for implementers to encode a lot of semantics, but
> > +// rather provide a thin generalization layer for the kernel's allocators.
> > +//
> > +// Depending on future requirements, the requirements for this trait may change as well and
> > +// implementing allocators that need to encode more semantics may become desirable.
> 
> Not sure what's the purpose of these two paragraphs. They sound
> contradictory to each other.

I tried to articulate what it is currently intended for, but, depending on
future requirements, this may change.

I was asked by Benno to somehow add that we're open for changes...

> 
> > +pub unsafe trait Allocator {
> > +    /// Allocate memory based on `layout` and `flags`.
> > +    ///
> > +    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
> > +    /// constraints (i.e. minimum size and alignment as specified by `layout`).
> > +    ///
> > +    /// This function is equivalent to `realloc` when called with `None`.
> > +    ///
> > +    /// # Guarantees
> > +    ///
> > +    /// When the return value is `Ok(ptr)`, then `ptr` is
> > +    /// - valid for reads and writes for `layout.size()` bytes, until it is passed to
> > +    ///   [`Allocator::free`] or [`Allocator::realloc`],
> > +    /// - aligned to `layout.align()`,
> > +    ///
> > +    /// Additionally, `Flags` are honored as documented in
> > +    /// <https://docs.kernel.org/core-api/mm-api.html#mm-api-gfp-flags>.
> > +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
> > +        // SAFETY: Passing `None` to `realloc` is valid by it's safety requirements and asks for a
> > +        // new memory allocation.
> > +        unsafe { Self::realloc(None, layout, flags) }
> > +    }
> > +
> > +    /// Re-allocate an existing memory allocation to satisfy the requested `layout`.
> > +    ///
> > +    /// If the requested size is zero, `realloc` behaves equivalent to `free`.
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
> > +    /// If `ptr == Some(p)`, then `p` must point to an existing and valid memory allocation created
> 
> nit: maybe
> 
> 	If `ptr` is `Some(p)`?
> 
> because `ptr` carries the provenance not only addresses.

I don't mind either versions, this one was proposed by Benno.

> 
> > +    /// by this allocator. The alignment encoded in `layout` must be smaller than or equal to the
> > +    /// alignment requested in the previous `alloc` or `realloc` call of the same allocation.
> > +    ///
> > +    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
> > +    /// created.
> > +    ///
> > +    /// # Guarantees
> > +    ///
> > +    /// This function has the same guarantees as [`Allocator::alloc`]. When `ptr == Some(p)`, then
> > +    /// it additionally guarantees that:
> > +    /// - the contents of the memory pointed to by `p` are preserved up to the lesser of the new
> > +    ///   and old size,
> > +    ///   and old size, i.e.
> > +    ///   `ret_ptr[0..min(layout.size(), old_size)] == p[0..min(layout.size(), old_size)]`, where
> > +    ///   `old_size` is the size of the allocation that `p` points at.
> > +    /// - when the return value is `Err(AllocError)`, then `p` is still valid.
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
> 

