Return-Path: <linux-kernel+bounces-277059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83131949BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107C91F228D7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B54175D2F;
	Tue,  6 Aug 2024 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCga8lOW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1858B16F27E;
	Tue,  6 Aug 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985275; cv=none; b=j5mVOHkdH/fWA2c2e3xDVkp41z2xe/a6zv0vzQJq6LbSmdl/NTq+QseseLVfzFhq+ad6UcNf9c96fRfcYlFVn9cNkXJBxKctpfoaLi59Jw40kRE+4Dj5HkhPnqCEl6s22zW8vusU2yc09Hms+lIAKrH3xgjom0fC1gWAIgoi7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985275; c=relaxed/simple;
	bh=VT/t8xi2XQhMWBtU/nRyUl6WDtHH1fAaE+epdvkYA/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9sC/627U6H/PQVMTxVJN2KReoa/Emu8FnKdBzJy2SnBFOpzT6Ts/SxfULxQRMveFX9iyxZJCrA5ziPl4nfd2iSDJsT56ZFjlZlsQ6uhzqh3oMHypcicf5aeX3DVIV1qhGxYgRz1mXxb6chYavoYdV16IHUHUs1Hu92x4HGYuc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCga8lOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBF5C4AF09;
	Tue,  6 Aug 2024 23:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722985274;
	bh=VT/t8xi2XQhMWBtU/nRyUl6WDtHH1fAaE+epdvkYA/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCga8lOWcZf+cJOYXJzqZvd8e5egGKN3KAXKjEInRB+vxawWOAFNM0cXXCx/HVN4s
	 WNUM88owjXWzn9ymmgoS6Jv17j3I8GNpFuPN/hkykI7b4cmDv8kMTcebJcEhKX0hj2
	 jEoFAIwOAZ1Rtf9G/EcVpvElrwpnbjF/R23tPx7b2zMdr9JUGRcJjbkWK6dmolg9BW
	 BgmXciUJVOy7LiOwGSF7da1kNAYPZ45bfUadzwK8yT+q7q0toVLOUJSObwBvhlYfua
	 nrQLeEeh8yPmM1qaN4l9CdReQ2wY4Z9TDbzAmFpWM8kzUWWzaqQrMeOfI8r+e5SgAs
	 SThj7h9af5WEw==
Date: Wed, 7 Aug 2024 01:01:06 +0200
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
Subject: Re: [PATCH v4 09/28] rust: alloc: implement kernel `Box`
Message-ID: <ZrKrMrg5E85y7jkj@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-10-dakr@kernel.org>
 <a1c1e273-2d40-4114-b3b9-f27c73e3d122@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1c1e273-2d40-4114-b3b9-f27c73e3d122@proton.me>

On Tue, Aug 06, 2024 at 07:47:17PM +0000, Benno Lossin wrote:
> On 05.08.24 17:19, Danilo Krummrich wrote:
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
> >  rust/kernel/alloc/kbox.rs | 330 ++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/init.rs       |  35 +++-
> >  rust/kernel/prelude.rs    |   2 +-
> >  rust/kernel/types.rs      |  56 +++++++
> >  5 files changed, 427 insertions(+), 2 deletions(-)
> >  create mode 100644 rust/kernel/alloc/kbox.rs
> > 
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index 942e2755f217..d7beaf0372af 100644
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
> > index 000000000000..4a4379980745
> > --- /dev/null
> > +++ b/rust/kernel/alloc/kbox.rs
> > @@ -0,0 +1,330 @@
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
> > +use core::result::Result;
> > +
> > +use crate::types::Unique;
> > +
> > +/// The kernel's [`Box`] type.
> > +///
> > +/// `Box` provides the simplest way to allocate memory for a generic type with one of the kernel's
> > +/// allocators, e.g. `Kmalloc`, `Vmalloc` or `KVmalloc`.
> > +///
> > +/// For non-zero-sized values, a [`Box`] will use the given allocator `A` for its allocation. For
> > +/// the most common allocators the type aliases `KBox`, `VBox` and `KVBox` exist.
> > +///
> > +/// It is valid to convert both ways between a [`Box`] and a raw pointer allocated with any
> > +/// `Allocator`, given that the `Layout` used with the allocator is correct for the type.
> > +///
> > +/// For zero-sized values the [`Box`]' pointer must be `dangling_mut::<T>`; no memory is allocated.
> 
> Why do we need this to be in the docs?

Probably not - do you suggest to remove it entirely? Otherwise, where do you
think we should move it?

> 
> > +///
> > +/// So long as `T: Sized`, a `Box<T>` is guaranteed to be represented as a single pointer and is
> > +/// also ABI-compatible with C pointers (i.e. the C type `T*`).
> 
> You did not make `Box` `repr(transparent)`, so this is not true.
> Additionally, `Box<T>` (from stdlib) is not FFI-safe [1], this might be
> surprising, given that it is ABI-compatible (and the documentation seems
> to suggest that one *can* just use it across FFI). I think we should
> generally avoid using `Box` in glue code between Rust and C. I would
> remove this paragraph.

Agreed.

> 
> [1]: https://github.com/rust-lang/unsafe-code-guidelines/issues/334
> 
> 
> I think there are also other improvements, how about the following (feel
> free to adapt it):
> 
>     /// A heap allocation for a single value of type `T`.
>     ///
>     /// When dropping a [`Box`], the value is also dropped and the heap memory is automatically freed.
>     ///
>     /// This is the kernel's version of the Rust stdlib's `Box`. There are a couple, for example no
>     /// `noalias` attribute is emitted and partially moving out of a `Box` is not supported.
>     ///
>     /// `Box` works with any of the kernel's allocators, e.g. [`Kmalloc`], [`Vmalloc`] or [`KVMalloc`].
>     /// There are aliases for `Box` with these allocators ([`KBox`], [`VBox`], [`KVBox`]).

That sounds good, I will take this with a few minor adjustments, thanks.

> 
> > +///
> > +/// # Invariants
> 
> Please move this section below the examples section.
> 
> > +///
> > +/// The [`Box`]' pointer always properly aligned and either points to memory allocated with `A` or,
> 
> "The [`Box`]' pointer" -> "`self.0` is"
> 
> > +/// for zero-sized types, is a dangling pointer.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let b = KBox::<u64>::new(24_u64, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(*b, 24_u64);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> 
> Do you think it would be a good idea to have an example that fails (ie
> allocate with Kmalloc more than PAGE_SIZE)?

I think that's a good idea, I'll add one.

Please note that kmalloc() can allocate larger buffers than PAGE_SIZE. We can
request something larger than KMALLOC_MAX_SIZE though.

> 
> > +///
> > +/// ```
> > +/// struct Huge([u8; 1 << 24]);
> 
> I know that this is ~16MB, but are there test-vms with less memory (I
> have no idea how much you normally run these at, I usually give my vms
> plenty of ram, but when testing, people might not [my intuition is
> telling me that 16MB should be fine, but I am not sure]).

I think it's pretty reasonable to ask for 16MiB for a test case to succeed.

> 
> > +///
> > +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> > +/// ```
> > +pub struct Box<T: ?Sized, A: Allocator>(Unique<T>, PhantomData<A>);
> > +
> > +/// Type alias for `Box` with a `Kmalloc` allocator.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let b = KBox::new(24_u64, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(*b, 24_u64);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +pub type KBox<T> = Box<T, super::allocator::Kmalloc>;
> > +
> > +/// Type alias for `Box` with a `Vmalloc` allocator.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let b = VBox::new(24_u64, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(*b, 24_u64);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +pub type VBox<T> = Box<T, super::allocator::Vmalloc>;
> > +
> > +/// Type alias for `Box` with a `KVmalloc` allocator.
> > +///
> > +/// # Examples
> > +///
> > +/// ```
> > +/// let b = KVBox::new(24_u64, GFP_KERNEL)?;
> > +///
> > +/// assert_eq!(*b, 24_u64);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +pub type KVBox<T> = Box<T, super::allocator::KVmalloc>;
> > +
> > +impl<T, A> Box<T, A>
> > +where
> > +    T: ?Sized,
> > +    A: Allocator,
> > +{
> > +    /// Constructs a `Box<T, A>` from a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `raw` must point to valid memory, previously allocated with `A`, and at least the size of
> > +    /// type `T`.
> 
> With this requirement and the invariant on `Box`, I am lead to believe
> that you can't use this for ZSTs, since they are not allocated with `A`.
> One solution would be to adjust this requirement. But I would rather use
> a different solution: we move the dangling pointer stuff into the
> allocator and also call it when `T` is a ZST (ie don't special case them
> in `Box` but in the impls of `Allocator`). That way this can stay as-is
> and the part about ZSTs in the invariant can be removed.

Actually, we already got that. Every zero sized allocation will return a
dangling pointer. However, we can't call `Allocator::free` with (any) dangling
pointer though.

> 
> > +    #[inline]
> > +    pub const unsafe fn from_raw(raw: *mut T) -> Self {
> > +        // SAFETY: Validity of `raw` is guaranteed by the safety preconditions of this function.
> 
> This is not a safety requirement of `Unique::new_unchecked`. Instead it
> is a type invariant of `Box`, so it should be an INVARIANT comment.
> You still need to justify `new_unchecked` though (which is requires that
> `raw` is not NULL.

Agreed.

> 
> > +        Self(unsafe { Unique::new_unchecked(raw) }, PhantomData::<A>)
> 
> You don't need the `::<A>`.
> 
> > +    }
> > +
> > +    /// Consumes the `Box<T>`, returning a wrapped raw pointer.
> > +    ///
> 
> Please add a new paragraph: "This will not run the destructor of `T` and
> the allocation will stay alive indefinitely. Use [`Box::from_raw`] to
> recover the [`Box`], drop the value and free the allocation.".
> 
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let x = KBox::new(24, GFP_KERNEL)?;
> > +    /// let ptr = KBox::into_raw(x);
> > +    /// let x = unsafe { KBox::from_raw(ptr) };
> > +    ///
> > +    /// assert_eq!(*x, 24);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    #[inline]
> > +    pub fn into_raw(b: Self) -> *mut T {
> > +        let b = ManuallyDrop::new(b);
> > +
> > +        b.0.as_ptr()
> > +    }
> > +
> > +    /// Consumes and leaks the `Box<T>`, returning a mutable reference, &'a mut T.
> 
> The last part seems a bit weird, it should definitely be enclosed in
> '`', but it also seems unnecessary. Instead I would stress that this
> will never drop the value and also never free the allocation.

Agreed, for this and the above.

> 
> > +    #[inline]
> > +    pub fn leak<'a>(b: Self) -> &'a mut T
> > +    where
> > +        T: 'a,
> > +    {
> > +        // SAFETY: `Box::into_raw` always returns a properly aligned and dereferenceable pointer
> > +        // which points to an initialized instance of `T`.
> > +        unsafe { &mut *Box::into_raw(b) }
> > +    }
> > +
> > +    /// Converts a `Box<T, A>` into a `Pin<Box<T, A>>`.
> > +    #[inline]
> > +    pub fn into_pin(b: Self) -> Pin<Self>
> > +    where
> > +        A: 'static,
> 
> Why do we require this? Our `Box` doesn't store an allocator.

I just forgot to remove it.

> 
> > +    {
> > +        // SAFETY: It's not possible to move or replace the insides of a `Pin<Box<T, A>>` when
> > +        // `T: !Unpin`, so it's safe to pin it directly without any additional requirements.
> > +        unsafe { Pin::new_unchecked(b) }
> > +    }
> > +}
> > +
> > +impl<T, A> Box<MaybeUninit<T>, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    /// Converts to `Box<T, A>`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// As with MaybeUninit::assume_init, it is up to the caller to guarantee that the value really
> > +    /// is in an initialized state. Calling this when the content is not yet fully initialized
> > +    /// causes immediate undefined behavior.
> 
> This also looks like it was copied from the Rust stdlib, please see
> Miguel's response as to what to do about that.

Yeah, I think there are a few places more places where I forgot about that, will
fix all of them.

> 
> Additionally, this Safety section is not up to par with the rest of the
> kernel, for me this sounds better:
> 
>     /// The pointee must be a valid value of type `T`.
> 
> > +    pub unsafe fn assume_init(b: Self) -> Box<T, A> {
> > +        let raw = Self::into_raw(b);
> > +        // SAFETY: Reconstruct the `Box<MaybeUninit<T>, A>` as Box<T, A> now that has been
> > +        // initialized. `raw` and `alloc` are safe by the invariants of `Box`.
> > +        unsafe { Box::from_raw(raw as *mut T) }
> > +    }
> > +
> > +    /// Writes the value and converts to `Box<T, A>`.
> > +    pub fn write(mut b: Self, value: T) -> Box<T, A> {
> > +        (*b).write(value);
> > +        // SAFETY: We've just initialized `boxed`'s value.
> > +        unsafe { Self::assume_init(b) }
> > +    }
> > +}
> > +
> > +impl<T, A> Box<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    fn is_zst() -> bool {
> > +        core::mem::size_of::<T>() == 0
> > +    }
> > +
> > +    /// Allocates memory with the allocator `A` and then places `x` into it.
> > +    ///
> > +    /// This doesn’t actually allocate if T is zero-sized.
> > +    pub fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> > +        let b = Self::new_uninit(flags)?;
> > +        Ok(Box::write(b, x))
> > +    }
> > +
> > +    /// Constructs a new `Box<T, A>` with uninitialized contents.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let b = KBox::<u64>::new_uninit(GFP_KERNEL)?;
> > +    /// let b = KBox::write(b, 24);
> > +    ///
> > +    /// assert_eq!(*b, 24_u64);
> > +    ///
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>, A>, AllocError> {
> > +        let ptr = if Self::is_zst() {
> > +            Unique::dangling()
> > +        } else {
> > +            let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
> > +            let ptr = A::alloc(layout, flags)?;
> > +
> > +            ptr.cast().into()
> > +        };
> > +
> > +        Ok(Box(ptr, PhantomData::<A>))
> > +    }
> > +
> > +    /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then `x` will be
> > +    /// pinned in memory and unable to be moved.
> > +    #[inline]
> > +    pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
> > +    where
> > +        A: 'static,
> 
> Again, we don't need this.
> 
> > +    {
> > +        Ok(Self::new(x, flags)?.into())
> > +    }
> > +
> > +    /// Drops the contents, but keeps the allocation.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let value = KBox::new([0; 32], GFP_KERNEL)?;
> > +    /// assert_eq!(*value, [0; 32]);
> > +    /// let value = KBox::drop_contents(value);
> > +    /// // Now we can re-use `value`:
> > +    /// let value = KBox::write(value, [1; 32]);
> > +    /// assert_eq!(*value, [1; 32]);
> > +    /// # Ok::<(), Error>(())
> > +    /// ```
> > +    pub fn drop_contents(this: Self) -> Box<MaybeUninit<T>, A> {
> > +        let ptr = Box::into_raw(this);
> > +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> > +        unsafe { core::ptr::drop_in_place(ptr) };
> > +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> > +        unsafe { Box::from_raw(ptr.cast()) }
> > +    }
> 
> I don't particularly care in this instance, but you just took my patch
> and folded it into your own without asking me or specifying it in the
> commit message. In general I would have assumed that you just put the
> entire patch into the series (with correct From:... etc).

When I asked about this in [1] my understanding was that we expect [1] to land
prior to this series. So, I'm just anticipating a future rebase where I move
this code from box_ext.rs to kbox.rs, just like Alice suggested for her
"ForeignOwnable for Pin<crate::alloc::Box<T, A>>" implementation.

I also understand your later reply, where you said: "[...] then you can just
include it when you remove the `BoxExit` trait." as confirmation.

Probably that's a misunderstanding though. Sorry if that's the case.

[1] https://lore.kernel.org/lkml/24a8d381-dd13-4d19-a736-689b8880dbe1@proton.me/

> 
> > +}
> > +
> > +impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>
> > +where
> > +    T: ?Sized,
> > +    A: Allocator,
> > +    A: 'static,
> > +{
> > +    /// Converts a `Box<T>` into a `Pin<Box<T>>`. If `T` does not implement [`Unpin`], then
> > +    /// `*boxed` will be pinned in memory and unable to be moved.
> > +    ///
> > +    /// This conversion does not allocate on the heap and happens in place.
> > +    ///
> > +    /// This is also available via [`Box::into_pin`].
> > +    ///
> > +    /// Constructing and pinning a `Box` with <code><Pin<Box\<T>>>::from([Box::new]\(x))</code>
> > +    /// can also be written more concisely using <code>[Box::pin]\(x)</code>.
> > +    /// This `From` implementation is useful if you already have a `Box<T>`, or you are
> > +    /// constructing a (pinned) `Box` in a different way than with [`Box::new`].
> 
> This also looks very much like something from the stdlib...

Yeah, I'll replace that.

> 
> > +    fn from(b: Box<T, A>) -> Self {
> > +        Box::into_pin(b)
> > +    }
> > +}
> > +
> > +impl<T, A> Deref for Box<T, A>
> > +where
> > +    T: ?Sized,
> > +    A: Allocator,
> > +{
> > +    type Target = T;
> > +
> > +    fn deref(&self) -> &T {
> > +        // SAFETY: `self.0` is always properly aligned, dereferenceable and points to an initialized
> > +        // instance of `T`.
> 
> If `T` is a ZST, then it is not dereferenceable.

Why not? If `T` is a ZST `self.0` is `Unique::<T>::dangling()`. So, in the end
this is the same as `NonNull::<T>::dangling().as_ref()`.

> 
> > +        unsafe { self.0.as_ref() }
> > +    }
> > +}
> > +
> > +impl<T, A> DerefMut for Box<T, A>
> > +where
> > +    T: ?Sized,
> > +    A: Allocator,
> > +{
> > +    fn deref_mut(&mut self) -> &mut T {
> > +        // SAFETY: `self.0` is always properly aligned, dereferenceable and points to an initialized
> > +        // instance of `T`.
> > +        unsafe { self.0.as_mut() }
> > +    }
> > +}
> > +
> > +impl<T, A> fmt::Debug for Box<T, A>
> > +where
> > +    T: ?Sized + fmt::Debug,
> > +    A: Allocator,
> > +{
> > +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> > +        fmt::Debug::fmt(&**self, f)
> > +    }
> > +}
> > +
> > +impl<T, A> Drop for Box<T, A>
> > +where
> > +    T: ?Sized,
> > +    A: Allocator,
> > +{
> > +    fn drop(&mut self) {
> > +        let ptr = self.0.as_ptr();
> > +
> > +        // SAFETY: `ptr` is always properly aligned, dereferenceable and points to an initialized
> > +        // instance of `T`.
> > +        let size = unsafe { core::mem::size_of_val(&*ptr) };
> 
> 1. `size_of_val` is not `unsafe`.

Right, but dereferencing the `ptr` is unsafe.

> 2. why not use `&*self` instead of using the raw pointer? (then move the
>    let binding below this line)

If we ever support non-ZST `Allocator`s using `self` would not always evaluate
to the correct size. I think evaluating the size of `T` rather than `Box<T>` is
the correct thing to do.

> 
> > +
> > +        // SAFETY: We need to drop `self.0` in place, before we free the backing memory.
> > +        unsafe { core::ptr::drop_in_place(ptr) };
> > +
> > +        if size != 0 {
> 
> Making zero-sized allocations possible with Allocators would also
> simplify this.

As mentioned, it's possible already. But we still can't pass any dangling
pointer to `free`.

> 
> > +            // SAFETY: `ptr` was previously allocated with `A`.
> > +            unsafe { A::free(self.0.as_non_null().cast()) };
> > +        }
> > +    }
> > +}
> > diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> > index 495c09ebe3a3..5fd7a0ffabd2 100644
> > --- a/rust/kernel/init.rs
> > +++ b/rust/kernel/init.rs
> > @@ -211,7 +211,7 @@
> >  //! [`pin_init!`]: crate::pin_init!
> > 
> >  use crate::{
> > -    alloc::{box_ext::BoxExt, AllocError, Flags},
> > +    alloc::{box_ext::BoxExt, AllocError, Allocator, Flags},
> >      error::{self, Error},
> >      sync::UniqueArc,
> >      types::{Opaque, ScopeGuard},
> > @@ -1178,6 +1178,39 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
> >      }
> >  }
> > 
> > +impl<T, A> InPlaceInit<T> for crate::alloc::Box<T, A>
> > +where
> > +    A: Allocator + 'static,
> > +{
> > +    #[inline]
> > +    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
> > +    where
> > +        E: From<AllocError>,
> > +    {
> > +        let mut this = crate::alloc::Box::<_, A>::new_uninit(flags)?;
> > +        let slot = this.as_mut_ptr();
> > +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> > +        // slot is valid and will not be moved, because we pin it later.
> > +        unsafe { init.__pinned_init(slot)? };
> > +        // SAFETY: All fields have been initialized.
> > +        Ok(unsafe { crate::alloc::Box::assume_init(this) }.into())
> > +    }
> > +
> > +    #[inline]
> > +    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
> > +    where
> > +        E: From<AllocError>,
> > +    {
> > +        let mut this = crate::alloc::Box::<_, A>::new_uninit(flags)?;
> > +        let slot = this.as_mut_ptr();
> > +        // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
> > +        // slot is valid.
> > +        unsafe { init.__init(slot)? };
> > +        // SAFETY: All fields have been initialized.
> > +        Ok(unsafe { crate::alloc::Box::assume_init(this) })
> > +    }
> > +}
> 
> Please move this impl into kbox.rs, for the stdlib `Box`, this was here,
> since we did not own that `Box`.
> 
> > +
> >  impl<T> InPlaceInit<T> for UniqueArc<T> {
> >      #[inline]
> >      fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Pin<Self>, E>
> > diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> > index b37a0b3180fb..39f9331a48e2 100644
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
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index 7cf89067b5fc..9fe87528d129 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -2,6 +2,7 @@
> > 
> >  //! Kernel types.
> > 
> > +use crate::alloc::Allocator;
> >  use crate::init::{self, PinInit};
> >  use alloc::boxed::Box;
> >  use core::{
> > @@ -9,6 +10,7 @@
> >      marker::{PhantomData, PhantomPinned},
> >      mem::MaybeUninit,
> >      ops::{Deref, DerefMut},
> > +    pin::Pin,
> >      ptr::NonNull,
> >  };
> > 
> > @@ -89,6 +91,60 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> >      }
> >  }
> > 
> > +impl<T: 'static, A> ForeignOwnable for crate::alloc::Box<T, A>
> > +where
> > +    A: Allocator,
> > +{
> > +    type Borrowed<'a> = &'a T;
> > +
> > +    fn into_foreign(self) -> *const core::ffi::c_void {
> > +        crate::alloc::Box::into_raw(self) as _
> > +    }
> > +
> > +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> > +        // SAFETY: The safety requirements for this function ensure that the object is still alive,
> > +        // so it is safe to dereference the raw pointer.
> > +        // The safety requirements of `from_foreign` also ensure that the object remains alive for
> > +        // the lifetime of the returned value.
> > +        unsafe { &*ptr.cast() }
> > +    }
> > +
> > +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> > +        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
> > +        // call to `Self::into_foreign`.
> > +        unsafe { crate::alloc::Box::from_raw(ptr as _) }
> > +    }
> > +}
> > +
> > +impl<T: 'static, A> ForeignOwnable for Pin<crate::alloc::Box<T, A>>
> > +where
> > +    A: Allocator,
> > +{
> > +    type Borrowed<'a> = Pin<&'a T>;
> > +
> > +    fn into_foreign(self) -> *const core::ffi::c_void {
> > +        // SAFETY: We are still treating the box as pinned.
> > +        crate::alloc::Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
> > +    }
> > +
> > +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
> > +        // SAFETY: The safety requirements for this function ensure that the object is still alive,
> > +        // so it is safe to dereference the raw pointer.
> > +        // The safety requirements of `from_foreign` also ensure that the object remains alive for
> > +        // the lifetime of the returned value.
> > +        let r = unsafe { &*ptr.cast() };
> > +
> > +        // SAFETY: This pointer originates from a `Pin<Box<T>>`.
> > +        unsafe { Pin::new_unchecked(r) }
> > +    }
> > +
> > +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> > +        // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
> > +        // call to `Self::into_foreign`.
> > +        unsafe { Pin::new_unchecked(crate::alloc::Box::from_raw(ptr as _)) }
> > +    }
> > +}
> 
> Ditto for these two.

Agreed, will do.

> 
> ---
> Cheers,
> Benno
> 
> > +
> >  impl ForeignOwnable for () {
> >      type Borrowed<'a> = ();
> > 
> > --
> > 2.45.2
> > 
> 

