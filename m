Return-Path: <linux-kernel+bounces-276805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F40C94989A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CFA1F2296B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E1714F9D7;
	Tue,  6 Aug 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="j/wL6Hru"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782E3770FB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973653; cv=none; b=a9Vqp7k9Ie2XET9EKBVSTERNlAUNdJ+YuH8fFn8m7y+mrJQKsMINyMoZXG3k6Ye8gwV5bkDCtJl4pgMcnBS/RYpgv27RE5iU7t0vBIB1f79QbFTtPaCkm/UyoYB5mybzwXMzCsg8K2AINsvKNc3wAR0yKc+3GCglYnoXIEZ7YEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973653; c=relaxed/simple;
	bh=S1EPP7PFwxV4ExDABuYvJrjYLVg2ko9eWODDVD/l4QU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkmUQuRiO3ZPcoYOAERuR/dEeYhXCJprar6H2ZlCo3iPQJjEQXAf6QjHHSBVEWUt33uJBHrlSt55CvvuGP/MN2URQsbahUC/s9GK3pACGbIfF+vbu1QPRzq0HrgRtHnfPS2amsv3RiWTaP5ujtlSSktg2paL/2ruThOL0PUr1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=j/wL6Hru; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722973641; x=1723232841;
	bh=CyiI2uUE8hxQogNm/4iSO3lXwrnOWukY9Yg82nB+Qeg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j/wL6Hru4obZVaBQ+D/LZgli255sa49hZ170UM4zM1zcvojzqRYY4M+i0dFoETm7k
	 Xt1vrjPF6xf/vfNCbCH31XbT4c5FGEXTIaHx+08JPyskDzUJ16DiRS3j2KSPa0uY0q
	 fTA354pzLEWEOF5QYDtQ2RTAfn3HVX8jIAsZYlU2zeVw/Oycvd8JYeZPR+lNXPNEYq
	 vGSzd1zvgf9JBHnMK4cQXdUVdl+PgTnEtK62bLbLxMj0oJR94VSFr++39i3vVLqYSz
	 cbcolW8FVVQWIPYzypY38kTdwDzfxEFKew+kQ0abXeFGPl/AAYv5QJpJlY5Dy6GnEY
	 48cX8ptFaPH3Q==
Date: Tue, 06 Aug 2024 19:47:17 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 09/28] rust: alloc: implement kernel `Box`
Message-ID: <a1c1e273-2d40-4114-b3b9-f27c73e3d122@proton.me>
In-Reply-To: <20240805152004.5039-10-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-10-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 08323a408f87f11b4a4137478d8f8f723020b331
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> `Box` provides the simplest way to allocate memory for a generic type
> with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> `KVmalloc`.
>=20
> In contrast to Rust's `Box` type, the kernel `Box` type considers the
> kernel's GFP flags for all appropriate functions, always reports
> allocation failures through `Result<_, AllocError>` and remains
> independent from unstable features.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs      |   6 +
>  rust/kernel/alloc/kbox.rs | 330 ++++++++++++++++++++++++++++++++++++++
>  rust/kernel/init.rs       |  35 +++-
>  rust/kernel/prelude.rs    |   2 +-
>  rust/kernel/types.rs      |  56 +++++++
>  5 files changed, 427 insertions(+), 2 deletions(-)
>  create mode 100644 rust/kernel/alloc/kbox.rs
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 942e2755f217..d7beaf0372af 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -5,6 +5,7 @@
>  #[cfg(not(any(test, testlib)))]
>  pub mod allocator;
>  pub mod box_ext;
> +pub mod kbox;
>  pub mod vec_ext;
>=20
>  #[cfg(any(test, testlib))]
> @@ -13,6 +14,11 @@
>  #[cfg(any(test, testlib))]
>  pub use self::allocator_test as allocator;
>=20
> +pub use self::kbox::Box;
> +pub use self::kbox::KBox;
> +pub use self::kbox::KVBox;
> +pub use self::kbox::VBox;
> +
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> new file mode 100644
> index 000000000000..4a4379980745
> --- /dev/null
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Implementation of [`Box`].
> +
> +use super::{AllocError, Allocator, Flags};
> +use core::fmt;
> +use core::marker::PhantomData;
> +use core::mem::ManuallyDrop;
> +use core::mem::MaybeUninit;
> +use core::ops::{Deref, DerefMut};
> +use core::pin::Pin;
> +use core::result::Result;
> +
> +use crate::types::Unique;
> +
> +/// The kernel's [`Box`] type.
> +///
> +/// `Box` provides the simplest way to allocate memory for a generic typ=
e with one of the kernel's
> +/// allocators, e.g. `Kmalloc`, `Vmalloc` or `KVmalloc`.
> +///
> +/// For non-zero-sized values, a [`Box`] will use the given allocator `A=
` for its allocation. For
> +/// the most common allocators the type aliases `KBox`, `VBox` and `KVBo=
x` exist.
> +///
> +/// It is valid to convert both ways between a [`Box`] and a raw pointer=
 allocated with any
> +/// `Allocator`, given that the `Layout` used with the allocator is corr=
ect for the type.
> +///
> +/// For zero-sized values the [`Box`]' pointer must be `dangling_mut::<T=
>`; no memory is allocated.

Why do we need this to be in the docs?

> +///
> +/// So long as `T: Sized`, a `Box<T>` is guaranteed to be represented as=
 a single pointer and is
> +/// also ABI-compatible with C pointers (i.e. the C type `T*`).

You did not make `Box` `repr(transparent)`, so this is not true.
Additionally, `Box<T>` (from stdlib) is not FFI-safe [1], this might be
surprising, given that it is ABI-compatible (and the documentation seems
to suggest that one *can* just use it across FFI). I think we should
generally avoid using `Box` in glue code between Rust and C. I would
remove this paragraph.

[1]: https://github.com/rust-lang/unsafe-code-guidelines/issues/334


I think there are also other improvements, how about the following (feel
free to adapt it):

    /// A heap allocation for a single value of type `T`.
    ///
    /// When dropping a [`Box`], the value is also dropped and the heap mem=
ory is automatically freed.
    ///
    /// This is the kernel's version of the Rust stdlib's `Box`. There are =
a couple, for example no
    /// `noalias` attribute is emitted and partially moving out of a `Box` =
is not supported.
    ///
    /// `Box` works with any of the kernel's allocators, e.g. [`Kmalloc`], =
[`Vmalloc`] or [`KVMalloc`].
    /// There are aliases for `Box` with these allocators ([`KBox`], [`VBox=
`], [`KVBox`]).

> +///
> +/// # Invariants

Please move this section below the examples section.

> +///
> +/// The [`Box`]' pointer always properly aligned and either points to me=
mory allocated with `A` or,

"The [`Box`]' pointer" -> "`self.0` is"

> +/// for zero-sized types, is a dangling pointer.
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

Do you think it would be a good idea to have an example that fails (ie
allocate with Kmalloc more than PAGE_SIZE)?

> +///
> +/// ```
> +/// struct Huge([u8; 1 << 24]);

I know that this is ~16MB, but are there test-vms with less memory (I
have no idea how much you normally run these at, I usually give my vms
plenty of ram, but when testing, people might not [my intuition is
telling me that 16MB should be fine, but I am not sure]).

> +///
> +/// assert!(KVBox::<Huge>::new_uninit(GFP_KERNEL).is_ok());
> +/// ```
> +pub struct Box<T: ?Sized, A: Allocator>(Unique<T>, PhantomData<A>);
> +
> +/// Type alias for `Box` with a `Kmalloc` allocator.
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
> +impl<T, A> Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    /// Constructs a `Box<T, A>` from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `raw` must point to valid memory, previously allocated with `A`,=
 and at least the size of
> +    /// type `T`.

With this requirement and the invariant on `Box`, I am lead to believe
that you can't use this for ZSTs, since they are not allocated with `A`.
One solution would be to adjust this requirement. But I would rather use
a different solution: we move the dangling pointer stuff into the
allocator and also call it when `T` is a ZST (ie don't special case them
in `Box` but in the impls of `Allocator`). That way this can stay as-is
and the part about ZSTs in the invariant can be removed.

> +    #[inline]
> +    pub const unsafe fn from_raw(raw: *mut T) -> Self {
> +        // SAFETY: Validity of `raw` is guaranteed by the safety precond=
itions of this function.

This is not a safety requirement of `Unique::new_unchecked`. Instead it
is a type invariant of `Box`, so it should be an INVARIANT comment.
You still need to justify `new_unchecked` though (which is requires that
`raw` is not NULL.

> +        Self(unsafe { Unique::new_unchecked(raw) }, PhantomData::<A>)

You don't need the `::<A>`.

> +    }
> +
> +    /// Consumes the `Box<T>`, returning a wrapped raw pointer.
> +    ///

Please add a new paragraph: "This will not run the destructor of `T` and
the allocation will stay alive indefinitely. Use [`Box::from_raw`] to
recover the [`Box`], drop the value and free the allocation.".

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
> +    /// Consumes and leaks the `Box<T>`, returning a mutable reference, =
&'a mut T.

The last part seems a bit weird, it should definitely be enclosed in
'`', but it also seems unnecessary. Instead I would stress that this
will never drop the value and also never free the allocation.

> +    #[inline]
> +    pub fn leak<'a>(b: Self) -> &'a mut T
> +    where
> +        T: 'a,
> +    {
> +        // SAFETY: `Box::into_raw` always returns a properly aligned and=
 dereferenceable pointer
> +        // which points to an initialized instance of `T`.
> +        unsafe { &mut *Box::into_raw(b) }
> +    }
> +
> +    /// Converts a `Box<T, A>` into a `Pin<Box<T, A>>`.
> +    #[inline]
> +    pub fn into_pin(b: Self) -> Pin<Self>
> +    where
> +        A: 'static,

Why do we require this? Our `Box` doesn't store an allocator.

> +    {
> +        // SAFETY: It's not possible to move or replace the insides of a=
 `Pin<Box<T, A>>` when
> +        // `T: !Unpin`, so it's safe to pin it directly without any addi=
tional requirements.
> +        unsafe { Pin::new_unchecked(b) }
> +    }
> +}
> +
> +impl<T, A> Box<MaybeUninit<T>, A>
> +where
> +    A: Allocator,
> +{
> +    /// Converts to `Box<T, A>`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// As with MaybeUninit::assume_init, it is up to the caller to guar=
antee that the value really
> +    /// is in an initialized state. Calling this when the content is not=
 yet fully initialized
> +    /// causes immediate undefined behavior.

This also looks like it was copied from the Rust stdlib, please see
Miguel's response as to what to do about that.

Additionally, this Safety section is not up to par with the rest of the
kernel, for me this sounds better:

    /// The pointee must be a valid value of type `T`.

> +    pub unsafe fn assume_init(b: Self) -> Box<T, A> {
> +        let raw =3D Self::into_raw(b);
> +        // SAFETY: Reconstruct the `Box<MaybeUninit<T>, A>` as Box<T, A>=
 now that has been
> +        // initialized. `raw` and `alloc` are safe by the invariants of =
`Box`.
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
> +    /// Allocates memory with the allocator `A` and then places `x` into=
 it.
> +    ///
> +    /// This doesn=E2=80=99t actually allocate if T is zero-sized.
> +    pub fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
> +        let b =3D Self::new_uninit(flags)?;
> +        Ok(Box::write(b, x))
> +    }
> +
> +    /// Constructs a new `Box<T, A>` with uninitialized contents.
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
> +            Unique::dangling()
> +        } else {
> +            let layout =3D core::alloc::Layout::new::<MaybeUninit<T>>();
> +            let ptr =3D A::alloc(layout, flags)?;
> +
> +            ptr.cast().into()
> +        };
> +
> +        Ok(Box(ptr, PhantomData::<A>))
> +    }
> +
> +    /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement [`U=
npin`], then `x` will be
> +    /// pinned in memory and unable to be moved.
> +    #[inline]
> +    pub fn pin(x: T, flags: Flags) -> Result<Pin<Box<T, A>>, AllocError>
> +    where
> +        A: 'static,

Again, we don't need this.

> +    {
> +        Ok(Self::new(x, flags)?.into())
> +    }
> +
> +    /// Drops the contents, but keeps the allocation.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let value =3D KBox::new([0; 32], GFP_KERNEL)?;
> +    /// assert_eq!(*value, [0; 32]);
> +    /// let value =3D KBox::drop_contents(value);
> +    /// // Now we can re-use `value`:
> +    /// let value =3D KBox::write(value, [1; 32]);
> +    /// assert_eq!(*value, [1; 32]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn drop_contents(this: Self) -> Box<MaybeUninit<T>, A> {
> +        let ptr =3D Box::into_raw(this);
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> +        unsafe { core::ptr::drop_in_place(ptr) };
> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> +        unsafe { Box::from_raw(ptr.cast()) }
> +    }

I don't particularly care in this instance, but you just took my patch
and folded it into your own without asking me or specifying it in the
commit message. In general I would have assumed that you just put the
entire patch into the series (with correct From:... etc).

> +}
> +
> +impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +    A: 'static,
> +{
> +    /// Converts a `Box<T>` into a `Pin<Box<T>>`. If `T` does not implem=
ent [`Unpin`], then
> +    /// `*boxed` will be pinned in memory and unable to be moved.
> +    ///
> +    /// This conversion does not allocate on the heap and happens in pla=
ce.
> +    ///
> +    /// This is also available via [`Box::into_pin`].
> +    ///
> +    /// Constructing and pinning a `Box` with <code><Pin<Box\<T>>>::from=
([Box::new]\(x))</code>
> +    /// can also be written more concisely using <code>[Box::pin]\(x)</c=
ode>.
> +    /// This `From` implementation is useful if you already have a `Box<=
T>`, or you are
> +    /// constructing a (pinned) `Box` in a different way than with [`Box=
::new`].

This also looks very much like something from the stdlib...

> +    fn from(b: Box<T, A>) -> Self {
> +        Box::into_pin(b)
> +    }
> +}
> +
> +impl<T, A> Deref for Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &T {
> +        // SAFETY: `self.0` is always properly aligned, dereferenceable =
and points to an initialized
> +        // instance of `T`.

If `T` is a ZST, then it is not dereferenceable.

> +        unsafe { self.0.as_ref() }
> +    }
> +}
> +
> +impl<T, A> DerefMut for Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    fn deref_mut(&mut self) -> &mut T {
> +        // SAFETY: `self.0` is always properly aligned, dereferenceable =
and points to an initialized
> +        // instance of `T`.
> +        unsafe { self.0.as_mut() }
> +    }
> +}
> +
> +impl<T, A> fmt::Debug for Box<T, A>
> +where
> +    T: ?Sized + fmt::Debug,
> +    A: Allocator,
> +{
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        fmt::Debug::fmt(&**self, f)
> +    }
> +}
> +
> +impl<T, A> Drop for Box<T, A>
> +where
> +    T: ?Sized,
> +    A: Allocator,
> +{
> +    fn drop(&mut self) {
> +        let ptr =3D self.0.as_ptr();
> +
> +        // SAFETY: `ptr` is always properly aligned, dereferenceable and=
 points to an initialized
> +        // instance of `T`.
> +        let size =3D unsafe { core::mem::size_of_val(&*ptr) };

1. `size_of_val` is not `unsafe`.
2. why not use `&*self` instead of using the raw pointer? (then move the
   let binding below this line)

> +
> +        // SAFETY: We need to drop `self.0` in place, before we free the=
 backing memory.
> +        unsafe { core::ptr::drop_in_place(ptr) };
> +
> +        if size !=3D 0 {

Making zero-sized allocations possible with Allocators would also
simplify this.

> +            // SAFETY: `ptr` was previously allocated with `A`.
> +            unsafe { A::free(self.0.as_non_null().cast()) };
> +        }
> +    }
> +}
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 495c09ebe3a3..5fd7a0ffabd2 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -211,7 +211,7 @@
>  //! [`pin_init!`]: crate::pin_init!
>=20
>  use crate::{
> -    alloc::{box_ext::BoxExt, AllocError, Flags},
> +    alloc::{box_ext::BoxExt, AllocError, Allocator, Flags},
>      error::{self, Error},
>      sync::UniqueArc,
>      types::{Opaque, ScopeGuard},
> @@ -1178,6 +1178,39 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags=
) -> Result<Self, E>
>      }
>  }
>=20
> +impl<T, A> InPlaceInit<T> for crate::alloc::Box<T, A>
> +where
> +    A: Allocator + 'static,
> +{
> +    #[inline]
> +    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result=
<Pin<Self>, E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        let mut this =3D crate::alloc::Box::<_, A>::new_uninit(flags)?;
> +        let slot =3D this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated bu=
t not dropped,
> +        // slot is valid and will not be moved, because we pin it later.
> +        unsafe { init.__pinned_init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { crate::alloc::Box::assume_init(this) }.into())
> +    }
> +
> +    #[inline]
> +    fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, =
E>
> +    where
> +        E: From<AllocError>,
> +    {
> +        let mut this =3D crate::alloc::Box::<_, A>::new_uninit(flags)?;
> +        let slot =3D this.as_mut_ptr();
> +        // SAFETY: When init errors/panics, slot will get deallocated bu=
t not dropped,
> +        // slot is valid.
> +        unsafe { init.__init(slot)? };
> +        // SAFETY: All fields have been initialized.
> +        Ok(unsafe { crate::alloc::Box::assume_init(this) })
> +    }
> +}

Please move this impl into kbox.rs, for the stdlib `Box`, this was here,
since we did not own that `Box`.

> +
>  impl<T> InPlaceInit<T> for UniqueArc<T> {
>      #[inline]
>      fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result=
<Pin<Self>, E>
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index b37a0b3180fb..39f9331a48e2 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -14,7 +14,7 @@
>  #[doc(no_inline)]
>  pub use core::pin::Pin;
>=20
> -pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt};
> +pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt, KBox,=
 KVBox, VBox};
>=20
>  #[doc(no_inline)]
>  pub use alloc::{boxed::Box, vec::Vec};
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 7cf89067b5fc..9fe87528d129 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -2,6 +2,7 @@
>=20
>  //! Kernel types.
>=20
> +use crate::alloc::Allocator;
>  use crate::init::{self, PinInit};
>  use alloc::boxed::Box;
>  use core::{
> @@ -9,6 +10,7 @@
>      marker::{PhantomData, PhantomPinned},
>      mem::MaybeUninit,
>      ops::{Deref, DerefMut},
> +    pin::Pin,
>      ptr::NonNull,
>  };
>=20
> @@ -89,6 +91,60 @@ unsafe fn from_foreign(ptr: *const core::ffi::c_void) =
-> Self {
>      }
>  }
>=20
> +impl<T: 'static, A> ForeignOwnable for crate::alloc::Box<T, A>
> +where
> +    A: Allocator,
> +{
> +    type Borrowed<'a> =3D &'a T;
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        crate::alloc::Box::into_raw(self) as _
> +    }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> +        // SAFETY: The safety requirements for this function ensure that=
 the object is still alive,
> +        // so it is safe to dereference the raw pointer.
> +        // The safety requirements of `from_foreign` also ensure that th=
e object remains alive for
> +        // the lifetime of the returned value.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> +        // SAFETY: The safety requirements of this function ensure that =
`ptr` comes from a previous
> +        // call to `Self::into_foreign`.
> +        unsafe { crate::alloc::Box::from_raw(ptr as _) }
> +    }
> +}
> +
> +impl<T: 'static, A> ForeignOwnable for Pin<crate::alloc::Box<T, A>>
> +where
> +    A: Allocator,
> +{
> +    type Borrowed<'a> =3D Pin<&'a T>;
> +
> +    fn into_foreign(self) -> *const core::ffi::c_void {
> +        // SAFETY: We are still treating the box as pinned.
> +        crate::alloc::Box::into_raw(unsafe { Pin::into_inner_unchecked(s=
elf) }) as _
> +    }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
> +        // SAFETY: The safety requirements for this function ensure that=
 the object is still alive,
> +        // so it is safe to dereference the raw pointer.
> +        // The safety requirements of `from_foreign` also ensure that th=
e object remains alive for
> +        // the lifetime of the returned value.
> +        let r =3D unsafe { &*ptr.cast() };
> +
> +        // SAFETY: This pointer originates from a `Pin<Box<T>>`.
> +        unsafe { Pin::new_unchecked(r) }
> +    }
> +
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
> +        // SAFETY: The safety requirements of this function ensure that =
`ptr` comes from a previous
> +        // call to `Self::into_foreign`.
> +        unsafe { Pin::new_unchecked(crate::alloc::Box::from_raw(ptr as _=
)) }
> +    }
> +}

Ditto for these two.

---
Cheers,
Benno

> +
>  impl ForeignOwnable for () {
>      type Borrowed<'a> =3D ();
>=20
> --
> 2.45.2
>=20


