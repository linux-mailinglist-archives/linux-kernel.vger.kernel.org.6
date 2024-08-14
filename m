Return-Path: <linux-kernel+bounces-286422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66495951ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15191285161
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328A31AC427;
	Wed, 14 Aug 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxSprWST"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA41B0106;
	Wed, 14 Aug 2024 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638130; cv=none; b=G7MZ7BjWvwDvc0/LxxxCRJ9AZ5YyEFuxTyuEvBKTgATUu5fih5JSo2ozSz6xz8gkYMqyZi7ZWy0GXLC/uY7PgKdooADEwEHMWC9nHP/MOU7vzU+FmTCe4sNvRcYIiga4XevWTZeqn02eT53z7sEzXG8+l+PoKHbttKIA/qPJuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638130; c=relaxed/simple;
	bh=LY2WEiT97Ay4nDCBo8MD19QX9cPTqZ1QXq9WM5bDD8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlYFYZmo/3wfwITOht47AIzzQDUxy3kBqbixwbUuFgcXwULaLqzeiEZMwyZDU8HI2dIFYnaJRJwbCzbw+2WANjEBslC3RgBwSdhiqRYqJ/OMHAQyFNj2CcNDBrsLbEwrTml6/fZ82O4gfAkrp/g0yZ8Abu0j+tm1JCDYtQTiKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxSprWST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F9CC4AF0D;
	Wed, 14 Aug 2024 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723638128;
	bh=LY2WEiT97Ay4nDCBo8MD19QX9cPTqZ1QXq9WM5bDD8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxSprWSTSJw/Uqfe8Ub8AgSg3IrQH90TcRM/jX4OFm3yTnQ1Ke4K49UGLTu0nM1A9
	 W+eoVPB1K3RzPvsczO5hmhILiV8bvtI585YApdh9aQmFVEE8VA2JxMbbPbo2qgJqYQ
	 6VhiKjkSr+4SGJsmYiZSeaQiNxfJyGBdVY3ARlLg+Cm1nNuxr5rqSL10CLlYphNvJ5
	 TxdGAr4xlANk60rrah/rUu6+V+x8LhNftftTSv8BKCBdawD1SoJWuh5Qgkbm1jSSNG
	 5AH81MwevsDt4FLt/1qt3sf3zYCLUrhwI0T76BHM9i68+BN4nDZRcRUx6cMKtcBEm9
	 BP1jDq97QWWDw==
Date: Wed, 14 Aug 2024 14:22:01 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 09/26] rust: alloc: implement kernel `Box`
Message-ID: <Zryhae9OXD_dqfR8@pollux>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-10-dakr@kernel.org>
 <CAH5fLgiyDtMWKe0db+uvKGPoPRepjiSxddSrBh8jF1N1COpdDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiyDtMWKe0db+uvKGPoPRepjiSxddSrBh8jF1N1COpdDg@mail.gmail.com>

On Wed, Aug 14, 2024 at 10:26:10AM +0200, Alice Ryhl wrote:
> On Mon, Aug 12, 2024 at 8:25 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > `Box` provides the simplest way to allocate memory for a generic type
> > with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> > `KVmalloc`.
> >
> > In contrast to Rust's `Box` type, the kernel `Box` type considers the
> > kernel's GFP flags for all appropriate functions, always reports
> > allocation failures through `Result<_, AllocError>` and remains
> > independent from unstable features.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs      |   6 +
> >  rust/kernel/alloc/kbox.rs | 423 ++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/prelude.rs    |   2 +-
> >  3 files changed, 430 insertions(+), 1 deletion(-)
> >  create mode 100644 rust/kernel/alloc/kbox.rs
> >
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 295107777a12..ed46b69204d0 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -5,6 +5,7 @@
> >  #[cfg(not(any(test, testlib)))]
> >  pub mod allocator;
> >  pub mod box_ext;
> > +pub mod kbox;
> >  pub mod vec_ext;
> >
> >  #[cfg(any(test, testlib))]
> > @@ -13,6 +14,11 @@
> >  #[cfg(any(test, testlib))]
> >  pub use self::allocator_test as allocator;
> >
> > +pub use self::kbox::Box;
> > +pub use self::kbox::KBox;
> > +pub use self::kbox::KVBox;
> > +pub use self::kbox::VBox;
> > +
> >  /// Indicates an allocation error.
> >  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
> >  pub struct AllocError;
> > diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> > new file mode 100644
> > index 000000000000..67bdfc0712d2
> > --- /dev/null
> > +++ b/rust/kernel/alloc/kbox.rs
> > @@ -0,0 +1,423 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Implementation of [`Box`].
> > +
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
> > +use crate::init::{InPlaceInit, Init, PinInit};
> > +use crate::types::ForeignOwnable;
> > +
> > +/// The kernel's [`Box`] type - a heap allocation for a single value of type `T`.
> > +///
> > +/// This is the kernel's version of the Rust stdlib's `Box`. There are a couple of differences,
> > +/// for example no `noalias` attribute is emitted and partially moving out of a `Box` is not
> > +/// supported.
> > +///
> > +/// `Box` works with any of the kernel's allocators, e.g. [`super::allocator::Kmalloc`],
> > +/// [`super::allocator::Vmalloc`] or [`super::allocator::KVmalloc`]. There are aliases for `Box`
> > +/// with these allocators ([`KBox`], [`VBox`], [`KVBox`]).
> > +///
> > +/// When dropping a [`Box`], the value is also dropped and the heap memory is automatically freed.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(*b, 24_u64);
> > +///
> > +/// # Ok::<(), Error>(())
> 
> This is a minor nit, but when hiding lines in examples you should
> avoid having the rendered docs have empty lines at the beginning/end.
> There are also several examples of this below with the
> kernel::bindings import.

Makes sense, gonna fix it.

> 
> > +/// ```
> > +///
> > +/// ```
> > +/// # use kernel::bindings;
> > +///
> > +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> > +/// struct Huge([u8; SIZE]);
> > +///
> > +/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err());
> > +/// ```
> > +///
> > +/// ```
> > +/// # use kernel::bindings;
> > +///
> > +/// const SIZE: usize = bindings::KMALLOC_MAX_SIZE as usize + 1;
> > +/// struct Huge([u8; SIZE]);
> > +///
> > +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> > +/// ```
> > +///
> > +/// # Invariants
> > +///
> > +/// The [`Box`]' pointer always properly aligned and either points to memory allocated with `A` or,
> > +/// for zero-sized types, is a dangling pointer.
> > +pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);
> 
> I was about to say this needs a PhantomData<T> too, but I guess it
> isn't necessary anymore.
> https://doc.rust-lang.org/nomicon/phantom-data.html#generic-parameters-and-drop-checking
> 
> > +// SAFETY: `Box` is `Send` if `T` is `Send` because the data referenced by `self.0` is unaliased.
> 
> Instead of "unaliased" I would probably just say "because the Box owns a T".

I'm fine with either one, if that's preferred, I'll change it.

> 
> > +
> > +// SAFETY: `Box` is `Sync` if `T` is `Sync` because the data referenced by `self.0` is unaliased.
> > +unsafe impl<T, A> Sync for Box<T, A>
> > +where
> > +    T: Send + ?Sized,
> > +    A: Allocator,
> 
> This needs to say `T: Sync` instead of `T: Send`. That matches the std Box.

Good catch, pretty sure `Vec` has the same copy-paste mistake.

> 
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
> > +    /// `raw` must point to valid memory, previously be allocated with `A`, and provide at least
> > +    /// the size of type `T`. For ZSTs `raw` must be a dangling pointer.
> 
> Hmm. I don't love this wording. How about this?
> 
> For non-ZSTs, `raw` must point at a live allocation allocated with `A`
> that is sufficiently aligned for and holds a valid `T`. The caller
> passes ownership of the allocation to the `Box`.

I'm fine taking that, I'm not so sure about "live allocation" though, we don't
use this wording anywhere else. It's probably fine to just say "allocation",
since once it's freed it technically isn't an allocation anymore anyways.

> For ZSTs, the pointer must be non-null and aligned.

Technically, for ZSTs any pointer is aligned and NULL should be valid as well.
Maybe we just don't mentioned ZSTs at all, since we don't really need to enforce
anything for ZSTs.

> 
> > +impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>
> > +where
> > +    T: ?Sized,
> > +    A: Allocator,
> > +{
> > +    /// Converts a `Box<T, A>` into a `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then
> > +    /// `*b` will be pinned in memory and can't be moved.
> > +    ///
> > +    /// See [`Box::into_pin`] for more details.
> > +    fn from(b: Box<T, A>) -> Self {
> > +        Box::into_pin(b)
> 
> I still think it makes more sense to match std and only provide From
> and not an into_pin, but it's not a blocker.

Yeah, I just kept it since I'm not (yet) entirely sure what to think of the
`From` and `Into` stuff in some cases.

I don't really like that, depending on the context, it may hide relevant
details.

In the kernel, no matter how well documented an API is, I think it's rather
common to look at the code for some implementation details before using it.

Sometimes it might not be super trivial for the "occasional" reader to figure
out what's the type of some variable. Calling `into_pin` vs. just `into`
immediately tells the reader that things need to be pinned from there on.

However, I had no specific example in my mind and I'm also not overly concerned
to remove `into_pin`, but I want to at least share the reason why I kept it in
the first place.

> 
> Alice
> 

