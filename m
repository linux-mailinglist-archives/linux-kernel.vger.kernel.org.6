Return-Path: <linux-kernel+bounces-323629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A649740E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623111F22BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FF91A7AD0;
	Tue, 10 Sep 2024 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJpvi9On"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C328F1A38D4;
	Tue, 10 Sep 2024 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990053; cv=none; b=LwBdUv+0DHnJuoiPKL7v3gFfzjcOCfZVDFz82zgDPjQA3muvLjP9keq3kSwECCGjxqJtaWA/1X5Egkv8yuMgJxjJWpPZF3mC+ZE7/Aem3LLwQY3/N3VEo0SqCong64IF5SzGXxK2wPzl6V7syNWuMB8DtcrwKa4XlG59oeFmvvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990053; c=relaxed/simple;
	bh=sMaXYdfbLEdc5LCVMNz0SSbctxSq28mn5Ng5vutS7JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHtdS0/MJCPd7FaSyIXEGVorYg2NKMWzldK4edUyhZrhJ5GIVXyuASGgU4hITt91X+SoR8w0z4NhqgQIlfqooGcUqrNJN20qLwL1++w+0oAsz+bMFePT8+5t9ncfBVaYc9LoC9jbAeQnwISEbkh12qx8qCwUuH1jE4uJefTBVkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJpvi9On; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8338BC4CECC;
	Tue, 10 Sep 2024 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725990053;
	bh=sMaXYdfbLEdc5LCVMNz0SSbctxSq28mn5Ng5vutS7JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJpvi9OnRBgXfwxDXjYXMxDeXhGTfNaQYfGeoQHfQZj5gPQa20Yxoo04D9gQDMSym
	 B1AJavkFZDFmYMZLzEQhOiJMnjAYqvlCQBqjZ91mydn84SJ9OY/YNsPdzamo7YY6cE
	 YCH7HHcDXrcr9AW40s3EPCS421gjZEM2Vbt93BGfnqUz164miq0zv46UI0ESjkqY1f
	 ilPucW/cuVTKFHqB3VYJ4wSTelHOH3Brt+WXJXSsYDEGJd8uLKtZvtVHLxHc6g+dm9
	 5ZS+bP9UIbOHptxEJ3iuO0Fi7KlpcvkclBXqYlQYerYpZLZnE+7DLgxx4BE0vWSkQm
	 plGjsUXByXDrA==
Date: Tue, 10 Sep 2024 19:40:45 +0200
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
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <ZuCEneJeXcRo5qs8@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-10-dakr@kernel.org>
 <0146cb78-5a35-4d6b-bc75-fed1fc0c270c@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0146cb78-5a35-4d6b-bc75-fed1fc0c270c@proton.me>

On Sat, Aug 31, 2024 at 05:39:07AM +0000, Benno Lossin wrote:
> On 16.08.24 02:10, Danilo Krummrich wrote:
> > diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> > new file mode 100644
> > index 000000000000..93b1ab9de6e8
> > --- /dev/null
> > +++ b/rust/kernel/alloc/kbox.rs
> > @@ -0,0 +1,480 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Implementation of [`Box`].
> > +
> > +#[allow(unused_imports)] // Used in doc comments.
> > +use super::allocator::{KVmalloc, Kmalloc, Vmalloc};
> > +use super::{AllocError, Allocator, Flags};
> > +use core::fmt;
> > +use core::marker::PhantomData;
> > +use core::mem::ManuallyDrop;
> > +use core::mem::MaybeUninit;
> > +use core::ops::{Deref, DerefMut};
> > +use core::pin::Pin;
> > +use core::ptr::NonNull;
> > +use core::result::Result;
> > +
> > +use crate::init::{InPlaceInit, InPlaceWrite, Init, PinInit};
> > +use crate::types::ForeignOwnable;
> > +
> > +/// The kernel's [`Box`] type - a heap allocation for a single value of type `T`.
> 
> A single `-` doesn't really render nicely in markdown, instead use a
> double or triple dash (`--` or `---`).
> 
> > +///
> > +/// This is the kernel's version of the Rust stdlib's `Box`. There are several of differences,
> > +/// for example no `noalias` attribute is emitted and partially moving out of a `Box` is not
> > +/// supported. There are also several API differences, e.g. `Box` always requires an [`Allocator`]
> > +/// implementation to be passed as generic, page [`Flags`] when allocating memory and all functions
> > +/// that may allocate memory are failable.
> 
> Do you mean fallible?
> 
> > +///
> > +/// `Box` works with any of the kernel's allocators, e.g. [`Kmalloc`], [`Vmalloc`] or [`KVmalloc`].
> > +/// There are aliases for `Box` with these allocators ([`KBox`], [`VBox`], [`KVBox`]).
> > +///
> > +/// When dropping a [`Box`], the value is also dropped and the heap memory is automatically freed.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(*b, 24_u64);
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +///
> > +/// ```
> > +/// # use kernel::bindings;
> > +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> > +/// struct Huge([u8; SIZE]);
> > +///
> > +/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err());
> > +/// ```
> 
> It would be nice if you could add something like "KBox can't handle big
> allocations:" above this example, so that people aren't confused why
> this example expects an error.

I don't think that's needed, it's implied by
`SIZE == bindings::KMALLOC_MAX_SIZE + 1`.

Surely, we could add it nevertheless, but it's not very precise to just say "big
allocations". And I think this isn't the place for lengthy explanations of
`Kmalloc` behavior.

> 
> > +///
> > +/// ```
> > +/// # use kernel::bindings;
> > +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> > +/// struct Huge([u8; SIZE]);
> > +///
> > +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> > +/// ```
> 
> Similarly, you could then say above this one "Instead use either `VBox`
> or `KVBox`:"
> 
> > +///
> > +/// # Invariants
> > +///
> > +/// The [`Box`]' pointer is always properly aligned and either points to memory allocated with `A`
> 
> Please use `self.0` instead of "[`Box`]'".
> 
> > +/// or, for zero-sized types, is a dangling pointer.
> 
> Probably "dangling, well aligned pointer.".

Does this add any value? For ZSTs everything is "well aligned", isn't it?

> 
> > +#[repr(transparent)]
> > +pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);
> > +
> > +/// Type alias for `Box` with a [`Kmalloc`] allocator.
> 
> Can you make these `Box` references links?
> 
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let b = KBox::new(24_u64, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(*b, 24_u64);
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +pub type KBox<T> = Box<T, super::allocator::Kmalloc>;
> > +
> > +/// Type alias for `Box` with a [`Vmalloc`] allocator.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let b = VBox::new(24_u64, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(*b, 24_u64);
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +pub type VBox<T> = Box<T, super::allocator::Vmalloc>;
> > +
> > +/// Type alias for `Box` with a [`KVmalloc`] allocator.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let b = KVBox::new(24_u64, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(*b, 24_u64);
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +pub type KVBox<T> = Box<T, super::allocator::KVmalloc>;
> > +
> > +// SAFETY: `Box` is `Send` if `T` is `Send` because the `Box` owns a `T`.
> > +unsafe impl<T, A> Send for Box<T, A>
> > +where
> > +    T: Send + ?Sized,
> > +    A: Allocator,
> > +{
> > +}
> > +
> > +// SAFETY: `Box` is `Sync` if `T` is `Sync` because the `Box` owns a `T`.
> > +unsafe impl<T, A> Sync for Box<T, A>
> > +where
> > +    T: Sync + ?Sized,
> > +    A: Allocator,
> > +{
> > +}
> > +
> > +impl<T, A> Box<T, A>
> > +where
> > +    T: ?Sized,
> > +    A: Allocator,
> > +{
> > +    /// Creates a new `Box<T, A>` from a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// For non-ZSTs, `raw` must point at an allocation allocated with `A`that is sufficiently
> > +    /// aligned for and holds a valid `T`. The caller passes ownership of the allocation to the
> > +    /// `Box`.
> 
> You don't say what must happen for ZSTs.

Because we don't require anything for a ZST, do we?

> 
> > +    #[inline]
> > +    pub const unsafe fn from_raw(raw: *mut T) -> Self {
> > +        // INVARIANT: Validity of `raw` is guaranteed by the safety preconditions of this function.
> > +        // SAFETY: By the safety preconditions of this function, `raw` is not a NULL pointer.
> > +        Self(unsafe { NonNull::new_unchecked(raw) }, PhantomData::<A>)
> > +    }
> > +
> > +    /// Consumes the `Box<T, A>` and returns a raw pointer.
> > +    ///
> > +    /// This will not run the destructor of `T` and for non-ZSTs the allocation will stay alive
> > +    /// indefinitely. Use [`Box::from_raw`] to recover the [`Box`], drop the value and free the
> > +    /// allocation, if any.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let x = KBox::new(24, GFP_KERNEL)?;
> > +    /// let ptr = KBox::into_raw(x);
> > +    /// let x = unsafe { KBox::from_raw(ptr) };
> > +    ///
> > +    /// assert_eq!(*x, 24);
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    #[inline]
> > +    pub fn into_raw(b: Self) -> *mut T {
> > +        let b = ManuallyDrop::new(b);
> > +
> > +        b.0.as_ptr()
> > +    }
> > +
> > +    /// Consumes and leaks the `Box<T, A>` and returns a mutable reference.
> > +    ///
> > +    /// See [Box::into_raw] for more details.
> > +    #[inline]
> > +    pub fn leak<'a>(b: Self) -> &'a mut T {
> > +        // SAFETY: `Box::into_raw` always returns a properly aligned and dereferenceable pointer
> > +        // which points to an initialized instance of `T`.
> > +        unsafe { &mut *Box::into_raw(b) }
> > +    }
> > +}
> > +
> > +impl<T, A> Box<MaybeUninit<T>, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    /// Converts a `Box<MaybeUninit<T>, A>` to a `Box<T, A>`.
> > +    ///
> > +    /// It is undefined behavior to call this function while the value inside of `b` is not yet
> > +    /// fully initialized.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that the value inside of `b` is in an initialized state.
> > +    pub unsafe fn assume_init(b: Self) -> Box<T, A> {
> > +        let raw = Self::into_raw(b);
> > +
> > +        // SAFETY: `raw` comes from a previous call to `Box::into_raw`. By the safety requirements
> > +        // of this function, the value inside the `Box` is in an initialized state. Hence, it is
> > +        // safe to reconstruct the `Box` as `Box<T, A>`.
> > +        unsafe { Box::from_raw(raw as *mut T) }
> 
> You should be able to use `.cast()` instead.
> 
> > +    }
> > +
> > +    /// Writes the value and converts to `Box<T, A>`.
> > +    pub fn write(mut b: Self, value: T) -> Box<T, A> {
> > +        (*b).write(value);
> > +        // SAFETY: We've just initialized `boxed`'s value.
> 
> The variable is called `b`.
> 
> > +        unsafe { Self::assume_init(b) }
> > +    }
> > +}
> 
> [...]
> 
> > +impl<T, A> Drop for Box<T, A>
> > +where
> > +    T: ?Sized,
> > +    A: Allocator,
> > +{
> > +    fn drop(&mut self) {
> > +        let size = core::mem::size_of_val::<T>(self);
> > +
> > +        // SAFETY: We need to drop `self.0` in place, before we free the backing memory.
> 
> This is the reason you are calling this function, not the justification
> why it is OK to do so. (the pointer is valid)
> 
> > +        unsafe { core::ptr::drop_in_place(self.0.as_ptr()) };
> 
> Instead of using the raw pointer directly, you can also just use
> `deref_mut`.
> 
> > +
> > +        if size != 0 {
> > +            // SAFETY: `ptr` was previously allocated with `A`.
> 
> There is no variable `ptr`, this is guaranteed by the type invariant of
> `Self`.
> 
> ---
> Cheers,
> Benno
> 
> > +            unsafe { A::free(self.0.cast()) };
> > +        }
> > +    }
> > +}
> > diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> > index 4571daec0961..a9210634a8c3 100644
> > --- a/rust/kernel/prelude.rs
> > +++ b/rust/kernel/prelude.rs
> > @@ -14,7 +14,7 @@
> >  #[doc(no_inline)]
> >  pub use core::pin::Pin;
> > 
> > -pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt};
> > +pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt, KBox, KVBox, VBox};
> > 
> >  #[doc(no_inline)]
> >  pub use alloc::{boxed::Box, vec::Vec};
> > --
> > 2.46.0
> > 
> 

