Return-Path: <linux-kernel+bounces-286945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2109520A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF451C216E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F431BD4F7;
	Wed, 14 Aug 2024 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VXY8DMqR"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9621BD011
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654903; cv=none; b=I/b1jDbASYamzBgE67MnxV9Kjz/WLgZclcxhAv1RbeBXaSw0zQu7/AOS4Kn53jj4jf1eDX7n2T+LoNaLoUaHJppdZ5m2L8xVb17ESxKfV0po9XqXaYqegZPR6l3bCCx7wfpmJZA+GpjJAegorzsMErZQNPCue+N1fqKalm4uKZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654903; c=relaxed/simple;
	bh=UcqdvuijSH1jKUQK6Hrxwduc9aVGZw3b0c23txWaJos=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgBdIcaUAf3/6l3Q5imRHXAbL5zHDctqwb5ZCHlGoSWM9sZgHlJ9PvOPlOScMDRVcuoqmWsMZDnvMu0uuUZy3VIZeE6vYbzG+H5m5i0iMGoe9TeB6UYOypXAI2f7ozT6/C1tc5qLo3AYdtM11ioihBfJou0b2ZcBJficSagPv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VXY8DMqR; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723654898; x=1723914098;
	bh=FYIDwo42GSydB8Cho/K5oGRFpWUC2sxe7phTeXQHbYU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VXY8DMqRrvHDq7+UNN7fv19bOU/xOporU5f339bF+O8eHNQgO3nOEL2NOLK2XqfK6
	 rhBZfmOUp5i7eO7z630axmqjyNSXnR+zPdvtwVTT5Imfu0LElBOim1JWof7lisiN+y
	 hJDw2+mm9LxOZDTo82L1SStNafXZK9P4DJyVcOMoW/ZEtNNZ0HSUD3a6WA1KX3qbBg
	 eyQGIIviaxbHsdzPCeeQXN1zcRryoiuQ4hQN2nFtBROG4hk4MDgLX5tI4L78OUq2p9
	 veOqlCeEFsTD9apCkaGrZM2X8ZebE5Ze0QL8D9FJALTalvgqNb8xERZwHqL+fbEeJQ
	 0nLH5Z8WfOGLw==
Date: Wed, 14 Aug 2024 17:01:34 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 09/26] rust: alloc: implement kernel `Box`
Message-ID: <a69e7280-7291-49f7-a46f-1ad465efce04@proton.me>
In-Reply-To: <20240812182355.11641-10-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-10-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7b6c5c29aefcbab38be1671307f4ade33ed6d891
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.08.24 20:22, Danilo Krummrich wrote:
> +/// The kernel's [`Box`] type - a heap allocation for a single value of =
type `T`.
> +///
> +/// This is the kernel's version of the Rust stdlib's `Box`. There are a=
 couple of differences,
> +/// for example no `noalias` attribute is emitted and partially moving o=
ut of a `Box` is not
> +/// supported.

I would add "But otherwise it works the same." (I don't know if there is
a comma needed after the "otherwise").
Also I remember that there was one more difference with a custom box
compared to the stdlib, but I forgot what that was, does someone else
remember? We should also put that here.

> +///
> +/// `Box` works with any of the kernel's allocators, e.g. [`super::alloc=
ator::Kmalloc`],
> +/// [`super::allocator::Vmalloc`] or [`super::allocator::KVmalloc`]. The=
re are aliases for `Box`
> +/// with these allocators ([`KBox`], [`VBox`], [`KVBox`]).
> +///
> +/// When dropping a [`Box`], the value is also dropped and the heap memo=
ry is automatically freed.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b =3D KBox::<u64>::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +///
> +/// ```
> +/// # use kernel::bindings;
> +///
> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
> +/// struct Huge([u8; SIZE]);
> +///
> +/// assert!(KBox::<Huge>::new_uninit(GFP_KERNEL | __GFP_NOWARN).is_err()=
);
> +/// ```
> +///
> +/// ```
> +/// # use kernel::bindings;
> +///
> +/// const SIZE: usize =3D bindings::KMALLOC_MAX_SIZE as usize + 1;
> +/// struct Huge([u8; SIZE]);
> +///
> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// The [`Box`]' pointer always properly aligned and either points to me=
mory allocated with `A` or,

"pointer always properly" -> "pointer is properly"

> +/// for zero-sized types, is a dangling pointer.

I think this section would look nicer, if it were formatted using bullet
points (that way the bracketing of the "or" is also unambiguous).

Additionally, this is missing that the pointer is valid for reads and
writes.

> +pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);

Why no `repr(transparent)`?

> +
> +/// Type alias for `Box` with a `Kmalloc` allocator.

I think we should add that this is only designed for small values.

> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b =3D KBox::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type KBox<T> =3D Box<T, super::allocator::Kmalloc>;
> +
> +/// Type alias for `Box` with a `Vmalloc` allocator.

Same here, add that this is supposed to be used for big values (or is
this also a general-purpose allocator, just not guaranteeing that the
memory is physically contiguous? in that case I would document it
here and also on `Vmalloc`).

> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b =3D VBox::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type VBox<T> =3D Box<T, super::allocator::Vmalloc>;
> +
> +/// Type alias for `Box` with a `KVmalloc` allocator.

Ditto.

> +///
> +/// # Examples
> +///
> +/// ```
> +/// let b =3D KVBox::new(24_u64, GFP_KERNEL)?;
> +///
> +/// assert_eq!(*b, 24_u64);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +pub type KVBox<T> =3D Box<T, super::allocator::KVmalloc>;
> +
> +// SAFETY: `Box` is `Send` if `T` is `Send` because the data referenced =
by `self.0` is unaliased.
> +unsafe impl<T, A> Send for Box<T, A>
> +where
> +    T: Send + ?Sized,
> +    A: Allocator,
> +{
> +}
> +
> +// SAFETY: `Box` is `Sync` if `T` is `Sync` because the data referenced =
by `self.0` is unaliased.
> +unsafe impl<T, A> Sync for Box<T, A>
> +where
> +    T: Send + ?Sized,
> +    A: Allocator,
> +{
> +}
> +
> +impl<T, A> Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    /// Creates a new `Box<T, A>` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `raw` must point to valid memory, previously be allocated with `=
A`, and provide at least
> +    /// the size of type `T`. For ZSTs `raw` must be a dangling pointer.
> +    #[inline]
> +    pub const unsafe fn from_raw(raw: *mut T) -> Self {
> +        // INVARIANT: Validity of `raw` is guaranteed by the safety prec=
onditions of this function.
> +        // SAFETY: By the safety preconditions of this function, `raw` i=
s not a NULL pointer.
> +        Self(unsafe { NonNull::new_unchecked(raw) }, PhantomData::<A>)
> +    }
> +
> +    /// Consumes the `Box<T, A>` and returns a raw pointer.
> +    ///
> +    /// This will not run the destructor of `T` and for non-ZSTs the all=
ocation will stay alive
> +    /// indefinitely. Use [`Box::from_raw`] to recover the [`Box`], drop=
 the value and free the
> +    /// allocation, if any.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let x =3D KBox::new(24, GFP_KERNEL)?;
> +    /// let ptr =3D KBox::into_raw(x);
> +    /// let x =3D unsafe { KBox::from_raw(ptr) };
> +    ///
> +    /// assert_eq!(*x, 24);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    #[inline]
> +    pub fn into_raw(b: Self) -> *mut T {
> +        let b =3D ManuallyDrop::new(b);
> +
> +        b.0.as_ptr()
> +    }
> +
> +    /// Consumes and leaks the `Box<T, A>` and returns a mutable referen=
ce.
> +    ///
> +    /// See [Box::into_raw] for more details.
> +    #[inline]
> +    pub fn leak<'a>(b: Self) -> &'a mut T
> +    where
> +        T: 'a,

This bound shouldn't be needed, it is implicit, since `T` appears in the
type `&'a mut T`.

> +    {
> +        // SAFETY: `Box::into_raw` always returns a properly aligned and=
 dereferenceable pointer
> +        // which points to an initialized instance of `T`.
> +        unsafe { &mut *Box::into_raw(b) }
> +    }
> +
> +    /// Converts a `Box<T, A>` into a `Pin<Box<T, A>>`. If `T` does not =
implement [`Unpin`], then
> +    /// `*b` will be pinned in memory and can't be moved.
> +    ///
> +    /// This moves `b` into `Pin` without moving `*b` or allocating and =
copying any memory.
> +    #[inline]
> +    pub fn into_pin(b: Self) -> Pin<Self> {

I would agree with Alice, that this is not really needed, since you can
just as well write `Pin::from(my_box)`.

> +        // SAFETY: The value wrapped inside a `Pin<Box<T, A>>` cannot be=
 moved or replaced as long
> +        // as `T` does not implement `Unpin`.
> +        unsafe { Pin::new_unchecked(b) }
> +    }
> +}
> +
> +impl<T, A> Box<MaybeUninit<T>, A>
> +where
> +    A: Allocator,
> +{
> +    /// Converts a `Box<MaybeUninit<T>, A>` to a `Box<T, A>`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the value inside of `b` is in an initia=
lized state. It is
> +    /// undefined behavior to call this function while the value inside =
of `b` is not yet fully
> +    /// initialized.

The second sentence is unnecessary safety documentation. It might still
be useful as normal documentation though.

> +    pub unsafe fn assume_init(b: Self) -> Box<T, A> {
> +        let raw =3D Self::into_raw(b);
> +
> +        // SAFETY: `raw` comes from a previous call to `Box::into_raw`. =
By the safety requirements
> +        // of this function, the value inside the `Box` is in an initial=
ized state. Hence, it is
> +        // safe to reconstruct the `Box` as `Box<T, A>`.
> +        unsafe { Box::from_raw(raw as *mut T) }
> +    }
> +
> +    /// Writes the value and converts to `Box<T, A>`.
> +    pub fn write(mut b: Self, value: T) -> Box<T, A> {
> +        (*b).write(value);
> +        // SAFETY: We've just initialized `boxed`'s value.
> +        unsafe { Self::assume_init(b) }
> +    }
> +}
> +
> +impl<T, A> Box<T, A>
> +where
> +    A: Allocator,
> +{
> +    fn is_zst() -> bool {
> +        core::mem::size_of::<T>() =3D=3D 0
> +    }
> +
> +    /// Creates a new `Box<T, A>` and initializes its contents with `x`.
> +    ///
> +    /// New memory is allocated with `a`. The allocation may fail, in wh=
ich case an error is

Wrong case on "`a`" (can this also be a link?).

> +    /// returned. For ZSTs no memory is allocated.
> +    pub fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> +        let b =3D Self::new_uninit(flags)?;
> +        Ok(Box::write(b, x))
> +    }
> +
> +    /// Creates a new `Box<T, A>` with uninitialized contents.
> +    ///
> +    /// New memory is allocated with `a`. The allocation may fail, in wh=
ich case an error is

Ditto.

> +    /// returned. For ZSTs no memory is allocated.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let b =3D KBox::<u64>::new_uninit(GFP_KERNEL)?;
> +    /// let b =3D KBox::write(b, 24);
> +    ///
> +    /// assert_eq!(*b, 24_u64);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>, A>, Al=
locError> {
> +        let ptr =3D if Self::is_zst() {
> +            NonNull::dangling()
> +        } else {
> +            let layout =3D core::alloc::Layout::new::<MaybeUninit<T>>();
> +            let ptr =3D A::alloc(layout, flags)?;
> +
> +            ptr.cast()
> +        };
> +
> +        Ok(Box(ptr, PhantomData::<A>))

Missing INVARIANT comment.

---
Cheers,
Benno

> +    }


