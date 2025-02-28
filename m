Return-Path: <linux-kernel+bounces-539630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687EA4A6B2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF3F177136
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A5F1DF271;
	Fri, 28 Feb 2025 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dugarreau.fr header.i=@dugarreau.fr header.b="ZNNbh250";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="gmrcGX1V"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409AF1DEFF9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740786167; cv=none; b=g1U3nl4ufeN5tLLBlCd64/eB5FQzdzSh8Xd4xqE2o8nt+pfgI6tx44IacYMoqJ2VaApvmhdFrv4+e9+7NyHDfQzv4kbjE57mRWJ+Me8KGcl9K3RbE3qglLGh17LkYxs1Ju1gUgVZlqABhoojl26faM80DJYX36YeS4KjkLBtX/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740786167; c=relaxed/simple;
	bh=R3VZYYkGu1elcWlh1q81WhppuHGbuLUWy14ujrQN6Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RID2UVJ8X1kR/3zvVJOSsJbSGmSJSlsJwrqtEWA/SzaiV+MbsRIPKHpwaW+GHUeoVbtx7epFw4KmKRwLc11hm3rDIAEi6XHqmRjHc6y4Xv/Qsa0vMHep3ziIzJLWdtV8eoVeAQYQDEK+4PVWwJ1gXVkpA586WocwnSYLL49reqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dugarreau.fr; spf=pass smtp.mailfrom=dugarreau.fr; dkim=pass (2048-bit key) header.d=dugarreau.fr header.i=@dugarreau.fr header.b=ZNNbh250; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=gmrcGX1V; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dugarreau.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dugarreau.fr
DKIM-Signature: a=rsa-sha256; b=ZNNbh250ph+Vxa7lHpJelJZ1Nklx+CpodWFC2APPXHUobef9HHidNoe8HdTIG7DZ+o8pL92xwt+rqJ9mw4eEmurLYaZb7Ouu0YGLYDmB73kH4TIKbCCqkl7AINOdP9AR5BFRgVvh1MeZ3J/pp2QemmjBLG2lW3S7AnV/xoJkr4Z5fbWvfbq1NICpHfhlO9kqVb68atcpOYzf0VY90thfdrzyGkNmbPyz1/rYbM7KYeA0qWl7rBymdRg52odDNZOQcvvE2BQ9ZI/aVpjcQ3sm1dT6F1HCcXSIeWmSnsc189VVz6AU1QqotT5jNILva+zJPdMeJK9PcXerush0FRtb4A==; s=purelymail2; d=dugarreau.fr; v=1; bh=R3VZYYkGu1elcWlh1q81WhppuHGbuLUWy14ujrQN6Dc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=gmrcGX1V8IBqWPyIYvqIQUVzexDaIeO1RDK5fG1ZIykF9d8kBtrFs6A4IbhcwjDlzf3Q3pY18ZvGER7jvuj1FqMgs6ch4BxgwDFns6taHu83eeXOJWSv74wHMks54PzLuQdN8wlkVGB9hrNAn28TJXgf7scQCAAAiB+62tMXii3lxG9lb8JAKRaWgi9vSJLDoqLdHSJNBzvKSlRRgOnSObg8mtuXJZEvUx6tu3Kp6GBpeO626gstnb9KD3nn7x7XLbzkiH8o65pegjSEkpHws9xIhaorOx5kcV8f54FqW1z1k0SbaZrgDODvDnlX/IMPxClGhZKnVs7+1Jx/VP7pow==; s=purelymail2; d=purelymail.com; v=1; bh=R3VZYYkGu1elcWlh1q81WhppuHGbuLUWy14ujrQN6Dc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 78338:10797:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1156556515;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 28 Feb 2025 23:42:03 +0000 (UTC)
From: =?UTF-8?q?Beno=C3=AEt=20du=20Garreau?= <benoit@dugarreau.fr>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: =?UTF-8?q?Beno=C3=AEt=20du=20Garreau?= <bdgdlm@outlook.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: adding UniqueRefCounted and UniqueRef types
Date: Sat,  1 Mar 2025 00:41:47 +0100
Message-ID: <20250228234148.7270-1-benoit@dugarreau.fr>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <EiaQ-C0o3GMQQpw3jCnXUnNgph2WIJ5-Cm8P5N9OysIlDKYrjHNun5Ol4Q1FfVGw64k6TGCfUVBJK5r0_2eypg==@protonmail.internalid>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

From: Beno=C3=AEt du Garreau <bdgdlm@outlook.com>

On Fri, 28 Feb 2025 14:43:03 +0000 Oliver Mangold <oliver.mangold@pm.me> wr=
ote:

> Hi,
>=20
> For usage with block-mq, we found that having a variant of ARef
> which is guaranteed to be unique being useful.
> As chances are it is useful in general, I implemented it
> as kernel::types::UniqueRef.
> The difference between ARef and UniqueRef
> is basically the same as between Arc and UniqueArc.
>=20
> This v2 of the patch, addressing the issues raised by Andreas Hindborg.
>=20
> On 250228 1417, Miguel Ojeda wrote:
> >=20
> > I think should be caught by Clippy -- Oliver, please try building with
> > `CLIPPY=3D1` (we would like Clippy-clean builds as much as reasonably
> > possible),
>=20
> Got it. This version should be okay for rustfmt, clippy and checkpatch :)
>=20
> Best regards,
>=20
> Oliver
>=20
> ---
>  rust/kernel/types.rs | 153 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 55ddd50e8aaa..72a973d9e1c7 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -543,6 +543,12 @@ fn from(b: &T) -> Self {
>      }
>  }
> =20
> +impl<T: UniqueRefCounted> From<UniqueRef<T>> for ARef<T> {
> +    fn from(b: UniqueRef<T>) -> Self {
> +        UniqueRefCounted::unique_to_shared(b)
> +    }
> +}
> +
>  impl<T: AlwaysRefCounted> Drop for ARef<T> {
>      fn drop(&mut self) {
>          // SAFETY: The type invariants guarantee that the `ARef` owns th=
e reference we're about to
> @@ -551,6 +557,153 @@ fn drop(&mut self) {
>      }
>  }
> =20
> +/// Types that are [`AlwaysRefCounted`] and can be safely converted to a=
n [`UniqueRef`]
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that the methods of the trait
> +/// change the reference count of the underlying object such that:
> +/// - the uniqueness invariant is upheld, i.e. it is not possible
> +///   to obtain another reference by any means (other than through the [=
`UniqueRef`])
> +///   until the [`UniqueRef`] is dropped or converted to an [`ARef`].
> +/// - [`UniqueRefCounted::dec_ref`] correctly frees the underlying objec=
t.
> +/// - [`UniqueRefCounted::unique_to_shared`] set the reference count to =
the value
> +/// - that the returned [`ARef`] expects for an object with a single ref=
erence
> +///   in existence.
> +pub unsafe trait UniqueRefCounted: AlwaysRefCounted + Sized {
> +    /// Checks if the [`ARef`] is unique and convert it
> +    /// to an [`UniqueRef`] it that is that case.
> +    /// Otherwise it returns again an [`ARef`] to the same
> +    /// underlying object.
> +    fn try_shared_to_unique(this: ARef<Self>) -> Result<UniqueRef<Self>,=
 ARef<Self>>;
> +    /// Converts the [`UniqueRef`] into an [`ARef`].
> +    fn unique_to_shared(this: UniqueRef<Self>) -> ARef<Self>;
> +    /// Decrements the reference count on the object when the [`UniqueRe=
f`] is dropped.
> +    ///
> +    /// Frees the object when the count reaches zero.
> +    ///
> +    /// It defaults to [`AlwaysRefCounted::dec_ref`],
> +    /// but overriding it may be useful, e.g. in case of non-standard re=
fcounting
> +    /// schemes.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The same safety constraints as for [`AlwaysRefCounted::dec_ref`]=
 apply,
> +    /// but as the reference is unique, it can be assumed that the funct=
ion
> +    /// will not be called twice. In case the default implementation is =
not
> +    /// overridden, it has to be ensured that the call to [`AlwaysRefCou=
nted::dec_ref`]
> +    /// can be used for an [`UniqueRef`], too.
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: correct by function safety requirements
> +        unsafe { AlwaysRefCounted::dec_ref(obj) };
> +    }
> +}

It would be great for this trait to only have a `is_unique` method, and tha=
t functions here
do the actual work. It would make it easier to implement and would avoid du=
plicating this
work.
Maybe this could even be a new method on `AlwaysRefCounted`?=20

> +
> +/// An unique, owned reference to an [`AlwaysRefCounted`] object.
> +///
> +/// It works the same ways as [`ARef`] but ensures that the reference is=
 unique
> +/// and thus can be dereferenced mutably.
> +///
> +/// # Invariants
> +///
> +/// - The pointer stored in `ptr` is non-null and valid for the lifetime=
 of the [`UniqueRef`]
> +///   instance. In particular, the [`UniqueRef`] instance owns an increm=
ent
> +///   on the underlying object's reference count.
> +/// - No other references to the underlying object exist while the [`Uni=
queRef`] is live.

I think you meant "no other refcount" or "only references borrowed from thi=
s".

> +pub struct UniqueRef<T: UniqueRefCounted> {
> +    ptr: NonNull<T>,
> +    _p: PhantomData<T>,
> +}
> +
> +// SAFETY: It is safe to send `UniqueRef<T>` to another thread
> +// when the underlying `T` is `Sync` because
> +// it effectively means sharing `&T` (which is safe because `T` is `Sync=
`); additionally, it needs
> +// `T` to be `Send` because any thread that has an `UniqueRef<T>` may ul=
timately access `T` using a
> +// mutable reference, for example, when the reference count reaches zero=
 and `T` is dropped.
> +unsafe impl<T: UniqueRefCounted + Sync + Send> Send for UniqueRef<T> {}

`UniqueRef` is essentially a `Box`, so it should have the same `Send`/`Sync=
` implementations. Here
I don't see how sending a `UniqueRef<T>` is sharing a `&T`.

> +
> +// SAFETY: It is safe to send `&UniqueRef<T>` to another thread when the=
 underlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` =
is `Sync`); additionally,
> +// it needs `T` to be `Send` because any thread that has a `&UniqueRef<T=
>` may clone it and get an
> +// `UniqueRef<T>` on that thread, so the thread may ultimately access `T=
`
> +// using a mutable reference, for example, when the reference count reac=
hes zero and `T` is dropped.
> +unsafe impl<T: UniqueRefCounted + Sync + Send> Sync for UniqueRef<T> {}

Same here: you can only get a `&T` from a `UniqueRef<T>`, definitely not cl=
one it.

> +
> +impl<T: UniqueRefCounted> UniqueRef<T> {
> +    /// Creates a new instance of [`UniqueRef`].
> +    ///
> +    /// It takes over an increment of the reference count on the underly=
ing object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the reference count is set to such a va=
lue
> +    /// that a call to [`UniqueRefCounted::dec_ref`] will release the un=
derlying object
> +    /// in the way which is expected when the last reference is dropped.
> +    /// Callers must not use the underlying object anymore --
> +    /// it is only safe to do so via the newly created [`UniqueRef`].
> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
> +        // INVARIANT: The safety requirements guarantee that the new ins=
tance now owns the
> +        // increment on the refcount.
> +        Self {
> +            ptr,
> +            _p: PhantomData,
> +        }
> +    }
> +
> +    /// Consumes the [`UniqueRef`], returning a raw pointer.
> +    ///
> +    /// This function does not change the refcount. After calling this f=
unction, the caller is
> +    /// responsible for the refcount previously managed by the [`UniqueR=
ef`].
> +    pub fn into_raw(me: Self) -> NonNull<T> {
> +        ManuallyDrop::new(me).ptr
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> Deref for UniqueRef<T> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is vali=
d.
> +        unsafe { self.ptr.as_ref() }
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> DerefMut for UniqueRef<T> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: The type invariants guarantee that the object is vali=
d.
> +        unsafe { self.ptr.as_mut() }
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> From<&T> for UniqueRef<T> {
> +    /// Converts the [`UniqueRef`] into an [`ARef`]
> +    /// by calling [`UniqueRefCounted::unique_to_shared`] on it.
> +    fn from(b: &T) -> Self {
> +        b.inc_ref();
> +        // SAFETY: We just incremented the refcount above.
> +        unsafe { Self::from_raw(NonNull::from(b)) }
> +    }
> +}

This is wrong: the reference borrows from a refcount (as per `AlwaysRefCoun=
ted`), and this
method increments it once more. It cannot be unique when the function retur=
ns.
Actually the only way such conversion could be written is by cloning `T`, w=
hich is probably
not what we want.

> +
> +impl<T: UniqueRefCounted> TryFrom<ARef<T>> for UniqueRef<T> {
> +    type Error =3D ARef<T>;
> +    /// Tries to convert the [`ARef`] to an [`UniqueRef`]
> +    /// by calling [`UniqueRefCounted::try_shared_to_unique`].
> +    /// In case the [`ARef`] is not unique it returns again an [`ARef`] =
to the same
> +    /// underlying object.
> +    fn try_from(b: ARef<T>) -> Result<UniqueRef<T>, Self::Error> {
> +        UniqueRefCounted::try_shared_to_unique(b)
> +    }
> +}
> +
> +impl<T: UniqueRefCounted> Drop for UniqueRef<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The type invariants guarantee that the [`UniqueRef`] =
owns the reference
> +        // we're about to decrement.
> +        unsafe { UniqueRefCounted::dec_ref(self.ptr) };
> +    }
> +}
> +
>  /// A sum type that always holds either a value of type `L` or `R`.
>  ///
>  /// # Examples
> --=20
> 2.48.1
>=20
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>

Beno=C3=AEt du Garreau

