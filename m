Return-Path: <linux-kernel+bounces-262551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C304893C881
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10091C216A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B576B48CE0;
	Thu, 25 Jul 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="J12IDo0r"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F026208A5;
	Thu, 25 Jul 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721933527; cv=none; b=Np/zrtBv1tZXgQTqFRaXqMohqqzSn1ScBM9nAJ9wcH80rRRdhz8EOzPmZoe0gfzSXRIwnXNskxU+D8F9xsAm6GHYgQWZZcWAmx7VXFdyKvgLgCBcqC4fGts1gKkEqSn6zLZHxRqlhy0rKHJgHc0gl6eFDKXUH/Vo8aQF59DcMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721933527; c=relaxed/simple;
	bh=x5Q/vqQivDUshKWSSQsKeEPW9Hi9EddcG25YvAeNxWg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e6/APwBiuqtOR+pd96DZpJrEbL9XXaXbQBj6iojrWInOf6rqDhnA4aenBO0Z6T0BMR5S6VUXQi0PYLwR8f41vVl4DmoUvP5W4mGpivZ8Wb70HD13V7dztzApTpGFBbGxiz170cNCpyK8fhinQHsiaqzbMe6i5PloNgmLDoRVEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=J12IDo0r; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721933522; x=1722192722;
	bh=2/iHL9RDUaFm8LFQlEZRxYfxCLwC3hkGSlCmcbv2QwU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=J12IDo0rtDuUOnv+9qJKuDBNGs0XZ1SA2KwTPCozDTVfsPG20Abj61JqRRQb85mio
	 JzsFBbSe7WRQBZDVaNhU1wkEDfKRvufu6C2RtLIuzfGgktaeTNNSjGS4DfGm21FATP
	 /kXsrgDEkenaYQAGHs3d4gvX97w0DCSFGsY1JGvW0BWRTomiWqq7yEiOSuRFkx8a1Z
	 foIFhyABGGmrdXDhmOf+MZeU4s5QHYFdUsWYvsJrXEx/NfUaQtaV8vMvN+4Hgx3LD5
	 OVek2zOriXvfn4T8+RgQ8OA1qaElZ7alAedc4pV+gRgb1PBDX5JLO1zwo54zhYfSNq
	 VhwP5rEo+uB5g==
Date: Thu, 25 Jul 2024 18:51:56 +0000
To: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>, Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@redhat.com>, Trevor Gross <tmgross@umich.edu>, gregkh@linuxfoundation.org
Subject: Re: [RFC PATCH] rust: types: Add explanation for ARef pattern
Message-ID: <ef9c98ea-b8ce-4017-9db8-177731996513@proton.me>
In-Reply-To: <20240710032447.2161189-1-boqun.feng@gmail.com>
References: <20240710032447.2161189-1-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 60bbb0953f2d803181d5422728035a11970ee060
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.07.24 05:24, Boqun Feng wrote:
> As the usage of `ARef` and `AlwaysRefCounted` is growing, it makes sense
> to add explanation of the "ARef pattern" to cover the most "DO" and "DO
> NOT" cases when wrapping a self-refcounted C type.
>=20
> Hence an "ARef pattern" section is added in the documentation of `ARef`.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> This is motivated by:
>=20
> =09https://lore.kernel.org/rust-for-linux/20240705110228.qqhhynbwwuwpcdeo=
@vireshk-i7/
>=20
>  rust/kernel/types.rs | 156 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 156 insertions(+)
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index bd189d646adb..70fdc780882e 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -329,6 +329,162 @@ pub unsafe trait AlwaysRefCounted {
>  ///
>  /// The pointer stored in `ptr` is non-null and valid for the lifetime o=
f the [`ARef`] instance. In
>  /// particular, the [`ARef`] instance owns an increment on the underlyin=
g object's reference count.
> +///
> +/// # [`ARef`] pattern
> +///
> +/// "[`ARef`] pattern" is preferred when wrapping a C struct which has i=
ts own refcounting

I would have written "[...] struct which is reference-counted, because
[...]", is there a specific reason you wrote "its own"?

> +/// mechanism, because it decouples the operations on the object itself =
(usually via a `&Foo`) vs the
> +/// operations on a pointer to the object (usually via an `ARef<Foo>`). =
For example, given a `struct

Not exactly sure I understand your point here, what exactly is the
advantage of decoupling the operations?
In my mind the following points are the advantages of using `ARef`:
(1) prevents having to implement multiple abstractions for a single C
    object: say there is a `struct foo` that is both used via reference
    counting and by-value on the stack. Without `ARef`, we would have to
    write two abstractions, one for each use-case. With `ARef`, we can
    have one `Foo` that can be wrapped with `ARef` to represent a
    reference-counted object.
(2) `ARef<T>` always represents a reference counted object, so it helps
    with understanding the code. If you read `Foo`, you cannot be sure
    if it is heap or stack allocated.
(3) generalizes common code of reference-counted objects (ie avoiding
    code duplication) and concentration of `unsafe` code.

In my opinion (1) is the most important, then (2). And (3) is a nice
bonus. If you agree with the list above (maybe you also have additional
advantages of `ARef`?) then it would be great if you could also add them
somewhere here.

> +/// foo` defined in C, which has its own refcounting operations `get_foo=
()` and `put_foo()`. Without
> +/// "[`ARef`] pattern", i.e. **bad case**:

Instead of "bad case" I would have written "i.e. you want to avoid this:".

> +///
> +/// ```ignore
> +/// pub struct Foo(NonNull<foo>);
> +///
> +/// impl Foo {
> +///     // An operation on the pointer.
> +///     pub unsafe fn from_ptr(ptr: *mut foo) -> Self {
> +///         // Note that whether `get_foo()` is needed here depends on t=
he exact semantics of
> +///         // `from_ptr()`: is it creating a new reference, or it conti=
nues using the caller's
> +///         // reference?
> +///         unsafe { get_foo(ptr); }
> +///
> +///         unsafe { Foo(NonNull::new_unchecked(foo)) }
> +///     }
> +///
> +///     // An operation on the object.
> +///     pub fn get_bar(&self) -> Bar {
> +///         unsafe { (*foo.0.as_ptr()).bar }
> +///     }
> +/// }
> +///
> +/// // Plus `impl Clone` and `impl Drop` are also needed to implement ma=
nually.
> +/// impl Clone for Foo {
> +///     fn clone(&self) -> Self {
> +///         unsafe { get_foo(self.0.as_ptr()); }
> +///
> +///         Foo(self.0)
> +///     }
> +/// }
> +///
> +/// impl Drop for Foo {
> +///     fn drop(&mut self) {
> +///         unsafe { put_foo(self.0.as_ptr()); }
> +///     }
> +/// }
> +/// ```
> +///
> +/// In this case, it's hard to tell whether `Foo` represent an object of=
 `foo` or a pointer to
> +/// `foo`.
> +///
> +/// However, if using [`ARef`] pattern, `foo` can be wrapped as follow:
> +///
> +/// ```ignore
> +/// /// Note: `Opaque` is needed in most cases since there usually exist=
 C operations on

I would disagree for the reason that `Opaque` is needed. You need it if
the `foo` eg contains a bool, since C might just write a nonsense
integer which would then result in immediate UB in Rust.
Other reasons might be that certain bytes of `foo` are written to by
other threads, even though on the Rust side we have `&mut Foo` (eg a
`mutex`).

> +/// /// `struct foo *`, and `#[repr(transparent)]` is needed for the saf=
ety of converting a `*mut
> +/// /// foo` to a `*mut Foo`
> +/// #[repr(transparent)]
> +/// pub struct Foo(Opaque<foo>);
> +///
> +/// impl Foo {
> +///     pub fn get_bar(&self) -> Bar {
> +///         // SAFETY: `self.0.get()` is a valid pointer.
> +///         //
> +///         // Note: Usually extra safety comments are needed here to ex=
plain why accessing `.bar`
> +///         // doesn't race with C side. Most cases are either calling a=
 C function, which has its
> +///         // own concurrent access protection, or holding a lock.
> +///         unsafe { (*self.0.get()).bar }
> +///     }
> +/// }
> +/// ```
> +///
> +/// ## Avoid `impl AlwaysRefCounted` if unnecesarry

I would move this section below the next one.

> +///
> +/// If Rust code doesn't touch the part where the object lifetimes of `f=
oo` are maintained, `impl
> +/// AlwaysRefCounted` can be temporarily avoided: it can always be added=
 later as an extension of
> +/// the functionality of the Rust code. This is usually the case for cal=
lbacks where the object
> +/// lifetimes are already maintained by a framework. In such a case, an =
`unsafe` `fn(*mut foo) ->
> +/// &Foo` function usually suffices:
> +///
> +/// ```ignore
> +/// impl Foo {
> +///     /// # Safety
> +///     ///
> +///     /// `ptr` has to be a valid pointer to `foo` for the entire life=
time `'a'.
> +///     pub unsafe fn as_ref<'a>(ptr: *mut foo) -> &'a Self {
> +///         // SAFETY: Per function safety requirement, reborrow is vali=
d.
> +///         unsafe { &*ptr.cast() }
> +///     }
> +/// }
> +/// ```
> +///
> +/// ## Type invariants of `impl AlwaysRefCounted`

I think you should first show how the example looks like with `ARef` and
then talk about type invariants.

> +///
> +/// Types that `impl AlwaysRefCounted` usually needs an invariant to des=
cribe why the type can meet
> +/// the safety requirement of `AlwaysRefCounted`, e.g.
> +///
> +/// ```ignore
> +/// /// # Invariants:
> +/// ///
> +/// /// Instances of this type are always refcounted, that is, a call to=
 `get_foo` ensures that the
> +/// /// allocation remains valid at least until the matching call to `pu=
t_foo`.
> +/// #[repr(transparent)]
> +/// pub struct Foo(Opaque<foo>);
> +///
> +/// // SAFETY: `Foo` is always ref-counted per type invariants.
> +/// unsafe impl AlwaysRefCounted for Foo {
> +///     fn inc_ref(&self) {
> +///         // SAFETY: `self.0.get()` is a valid pointer and per type in=
variants, the existence of
> +///         // `&self` means it has a non-zero reference count.
> +///         unsafe { get_foo(self.0.get()); }
> +///     }
> +///
> +///     unsafe dec_ref(obj: NonNull<Self>) {
> +///         // SAFETY: The refcount of `obj` is non-zero per function sa=
fety requirement, and the
> +///         // cast is OK since `foo` is transparent to `Foo`.
> +///         unsafe { put_foo(obj.cast()); }
> +///     }
> +/// }
> +/// ```
> +///
> +/// After `impl AlwaysRefCounted for foo`, `clone()` (`get_foo()`) and `=
drop()` (`put_foo()`)  are

Typo: it should be `impl AlwaysRefCounted for Foo`.

---
Cheers,
Benno

> +/// available to `ARef<Foo>` thanks to the generic implementation.
> +///
> +/// ## `ARef<Self>` vs `&Self`
> +///
> +/// For an `impl AlwaysRefCounted` type, `ARef<Self>` represents an owne=
r of one reference count,
> +/// e.g.
> +///
> +/// ```ignore
> +/// impl Foo {
> +///     /// Gets a ref-counted reference of [`Self`].
> +///     ///
> +///     /// # Safety
> +///     ///
> +///     /// - `ptr` must be a valid pointer to `foo` with at least one r=
eference count.
> +///     pub unsafe fn from_ptr(ptr: *mut foo) -> ARef<Self> {
> +///         // SAFETY: `ptr` is a valid pointer per function safety requ=
irement. The cast is OK
> +///         // since `foo` is transparent to `Foo`.
> +///         //
> +///         // Note: `.into()` here increases the reference count, so th=
e returned value has its own
> +///         // reference count.
> +///         unsafe { &*(ptr.cast::<Foo>()) }.into()
> +///     }
> +/// }
> +/// ```
> +///
> +/// Another function that returns an `ARef<Self>` but with a different s=
emantics is
> +/// [`ARef::from_raw`]: it takes away the refcount of the input pointer,=
 i.e. no refcount
> +/// incrementation inside the function.
> +///
> +/// However `&Self` represents a reference to the object, and the lifeti=
me of the **reference** is
> +/// known at compile-time. E.g. the `Foo::as_ref()` above.
> +///
> +/// ## `impl Drop` of an `impl AlwaysRefCounted` should not touch the re=
fcount
> +///
> +/// [`ARef`] descreases the refcount automatically (in [`ARef::drop`]) w=
hen it goes out of the
> +/// scope, therefore there's no need to `impl Drop` for the type of obje=
cts (e.g. `Foo`) to decrease
> +/// the refcount.
>  pub struct ARef<T: AlwaysRefCounted> {
>      ptr: NonNull<T>,
>      _p: PhantomData<T>,
> --
> 2.45.2
>=20


