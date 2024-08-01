Return-Path: <linux-kernel+bounces-271223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC62944B3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD581F2267A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D401A01BC;
	Thu,  1 Aug 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0HL747l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3E17084F;
	Thu,  1 Aug 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515215; cv=none; b=HBnttaYMI8XZVqkKf3tFMx7hqk5kOzdMD4LR2cjexWlNM6wh1050NezvXY00kEH55Ib8zYtsgKm7+OcB0rciy+psakwWU9OwY+lQMHroYeDUc8cd+Qgo08QbaoZTiBk/xVdZDvqA8qTmIS7UDoG/Ss0HOaVBUAHFo+NIJGBBGwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515215; c=relaxed/simple;
	bh=ko15EhQwm6KYZ8dfClKPHYYoNPMirgGgRV4mpM7ac0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WywwV4HjzySaDLW3s8ye9p/DKWgQXDyVogUb6+zPAOEfx3nD3egDq/lQX22UxNEu6Z06swjhyqfcHAicSnWV9FcSWEaLnnbQfM36NpYg0DNnQBmF2va8dT5TAGHNgB70MZ588YbLWbdoOGHPNbDwpy4lsnn4HtOdZrfB9y/MyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0HL747l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3896AC32786;
	Thu,  1 Aug 2024 12:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722515215;
	bh=ko15EhQwm6KYZ8dfClKPHYYoNPMirgGgRV4mpM7ac0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K0HL747ltC9X04VfLIHkN2XEFIWEwV3eTrltLBqTO1zz+S/IZ74h5EtpjMzxEMW96
	 6k47pjMBx4e44sGBKY7a7CmH59BcERjCr2Z7TWywCGJLDE+htE0tj+4S5tfchZjrxW
	 0WTR8xN3r9+RQrd4jsaVKAr1o8xji2uaWh0xeXFRbMSkmRrDn74RdUdZIqjXHSLxeK
	 c95I/gwN7rkxOJL02U3LKzubI23/zcP3tH83E4hVqAdf+Oyi90dOXl1F7r5lFUc0K2
	 gPPQsfY9m6yhw+ioXp6Is5A7Fn3GQ5m3acjvqEcmZDCS5332KCPmhXH5+B6PybSxpp
	 DGo7zJ6S/a/uA==
Date: Thu, 1 Aug 2024 14:26:46 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com,
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 01/25] rust: alloc: add `Allocator` trait
Message-ID: <Zqt_BuyoUk12m61Q@pollux>
References: <20240801000641.1882-1-dakr@kernel.org>
 <20240801000641.1882-2-dakr@kernel.org>
 <CAH5fLgj5xf4QdDU7yWrqUjcmJw4Rqe0-UzesHLhfQRvPqAv8eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgj5xf4QdDU7yWrqUjcmJw4Rqe0-UzesHLhfQRvPqAv8eA@mail.gmail.com>

On Thu, Aug 01, 2024 at 10:19:41AM +0200, Alice Ryhl wrote:
> On Thu, Aug 1, 2024 at 2:07 AM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > Add a kernel specific `Allocator` trait, that in contrast to the one in
> > Rust's core library doesn't require unstable features and supports GFP
> > flags.
> >
> > Subsequent patches add the following trait implementors: `Kmalloc`,
> > `Vmalloc` and `KVmalloc`.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> It could be nice to mention that the design without `self` parameters
> is necessary for compatibility with #[derive(SmartPointer)].

Agreed, will do.

> 
> >  rust/kernel/alloc.rs | 73 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 1966bd407017..b79dd2c49277 100644
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
> > @@ -86,3 +87,75 @@ pub mod flags {
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
> > +/// # Safety
> > +///
> > +/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
> > +/// it is explicitly freed.
> > +///
> > +/// Any pointer to a memory buffer which is currently allocated must be valid to be passed to any
> > +/// other [`Allocator`] function. The same applies for a NULL pointer.
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
> > +    /// `ptr` must point to an existing and valid memory allocation created by this allocator
> > +    /// instance.
> > +    ///
> > +    /// Additionally, `ptr` is allowed to be a NULL pointer; in this case a new memory allocation is
> > +    /// created.
> > +    unsafe fn realloc(
> > +        ptr: Option<NonNull<u8>>,
> > +        layout: Layout,
> > +        flags: Flags,
> > +    ) -> Result<NonNull<[u8]>, AllocError>;
> 
> Is it intentional that this allows you to change the alignment of an
> allocation? If so, that could use a note in the docs.

Yes, it's intentional and yes it really misses a note in the documentation.

The idea is to allow a change of alignment as long as the new alignment is
smaller than the old alignment.

In terms of safety, it is the callers responsibility to ensure constant
alignment throughout re-allocations (if required).

> 
> > +    /// Free an existing memory allocation.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
> > +    /// instance.
> > +    unsafe fn free(ptr: NonNull<u8>) {
> > +        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
> > +        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
> > +        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
> > +    }
> 
> At the very least, the provided implementation of `free` changes the
> alignment when it calls `realloc`.

Yes, I think that's fine though. Hopefully no one attempts to use the memory
anymore once `free` is being called.

> 
> Alice
> 

