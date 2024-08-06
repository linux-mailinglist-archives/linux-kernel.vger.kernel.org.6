Return-Path: <linux-kernel+bounces-276655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49AB949699
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10DB51C213E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2964AEF4;
	Tue,  6 Aug 2024 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Jp6B52kx"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7B51C3E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722964953; cv=none; b=GhhCLw4A/crTgnWERyP844psqW4Ve4LFm7uu9dAAjQcy0yCdbYDhcMDtTZAyPXX9qw3w1UwOsAXJLUde/Dznpj1ONr2+s93sKAyVpi/y1FhpGmw1IaR4a88TC2CNvGsPzst0KNChBoNXuzDSSBFxFdNSEEir6WOpdDHm5q8nLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722964953; c=relaxed/simple;
	bh=m5kxkaXfCyTE8Wd83ongz8t5b5x/+elgqIVQ+v9kOtw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LtNuGE6MNqhnpDLe+ypVhBvuYQyCJpmwVTPke2nbJafgfG7RT9vJl31Bs08t6FQ8eEFWjOdo4DMtOVYMRYlTSkXu5ZTbNdVBl9Qhv+DH3tfEPILpyHfuccPrzh8i3Clzc9I9mZ6p/xIXk2JzkDQsgSHuWboB6CKCvh5XszEmbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Jp6B52kx; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722964947; x=1723224147;
	bh=KwacUaqJ5YYWRVk8ykzjM7Y6SD6C+YG7cpGeuP2M4TE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Jp6B52kxI5n1YaZZZWjw0rHdJWSv4GmOv6fBaO0THOOH61gXplkoVp2llxoc3hsAW
	 XHx86PKgIdakNV8LE1KWhD4P7CIROJEfCsqEtZNUeLhpbC9Sjw8ejVzIamyN9flQK8
	 qsew6EwgExhFV8vlQ84jALYyX2fB3Lp1BA3GXZMRJyvdfgAYKIBHANofTd66djbI3Z
	 GVRwFlLBR2FOv7le9k0rqsXWRukKbZInu/lIElIR4ynUPeBPSduf7OyhIhdPKA6Z4I
	 CtIf8KsbImIUfv+yNqQ4uUpHJwzjvsePw6YhzrRiu7tasfUAWzFrx5eIfScNrWr8+8
	 Az1jBtENXUMSQ==
Date: Tue, 06 Aug 2024 17:22:21 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 08/28] rust: types: implement `Unique<T>`
Message-ID: <ff0826af-9430-4653-abe8-25fb80cd0e97@proton.me>
In-Reply-To: <20240805152004.5039-9-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-9-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 716c158e9305903de2f6bf86a219c931834c4384
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.08.24 17:19, Danilo Krummrich wrote:
> Implement the `Unique` type as a prerequisite for `Box` and `Vec`
> introduced in subsequent patches.
>=20
> `Unique` serves as wrapper around a `NonNull`, but indicates that the
> possessor of this wrapper owns the referent.
>=20
> This type already exists in Rust's core library, but, unfortunately, is
> exposed as unstable API and hence shouldn't be used in the kernel.
>=20
> This implementation of `Unique` is almost identical, but mostly stripped
> down to the functionality we need for `Box` and `Vec`. Additionally, all
> unstable features are removed and / or replaced by stable ones.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/types.rs | 183 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index bd189d646adb..7cf89067b5fc 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -473,3 +473,186 @@ unsafe impl AsBytes for str {}
>  // does not have any uninitialized portions either.
>  unsafe impl<T: AsBytes> AsBytes for [T] {}
>  unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
> +
> +/// A wrapper around a raw non-null `*mut T` that indicates that the pos=
sessor
> +/// of this wrapper owns the referent. Useful for building abstractions =
like
> +/// `Box<T>`, `Vec<T>`, `String`, and `HashMap<K, V>`.
> +///
> +/// Unlike `*mut T`, `Unique<T>` behaves "as if" it were an instance of =
`T`.
> +/// It implements `Send`/`Sync` if `T` is `Send`/`Sync`. It also implies
> +/// the kind of strong aliasing guarantees an instance of `T` can expect=
:
> +/// the referent of the pointer should not be modified without a unique =
path to
> +/// its owning Unique.
> +///
> +/// If you're uncertain of whether it's correct to use `Unique` for your=
 purposes,
> +/// consider using `NonNull`, which has weaker semantics.
> +///
> +/// Unlike `*mut T`, the pointer must always be non-null, even if the po=
inter
> +/// is never dereferenced. This is so that enums may use this forbidden =
value
> +/// as a discriminant -- `Option<Unique<T>>` has the same size as `Uniqu=
e<T>`.
> +/// However the pointer may still dangle if it isn't dereferenced.
> +///
> +/// Unlike `*mut T`, `Unique<T>` is covariant over `T`. This should alwa=
ys be correct
> +/// for any type which upholds Unique's aliasing requirements.
> +#[repr(transparent)]
> +pub struct Unique<T: ?Sized> {
> +    pointer: NonNull<T>,
> +    // NOTE: this marker has no consequences for variance, but is necess=
ary
> +    // for dropck to understand that we logically own a `T`.
> +    //
> +    // For details, see:
> +    // https://github.com/rust-lang/rfcs/blob/master/text/0769-sound-gen=
eric-drop.md#phantom-data
> +    _marker: PhantomData<T>,
> +}
> +
> +/// `Unique` pointers are `Send` if `T` is `Send` because the data they
> +/// reference is unaliased. Note that this aliasing invariant is
> +/// unenforced by the type system; the abstraction using the
> +/// `Unique` must enforce it.
> +unsafe impl<T: Send + ?Sized> Send for Unique<T> {}
> +
> +/// `Unique` pointers are `Sync` if `T` is `Sync` because the data they
> +/// reference is unaliased. Note that this aliasing invariant is
> +/// unenforced by the type system; the abstraction using the
> +/// `Unique` must enforce it.
> +unsafe impl<T: Sync + ?Sized> Sync for Unique<T> {}
> +
> +impl<T: Sized> Unique<T> {
> +    /// Creates a new `Unique` that is dangling, but well-aligned.
> +    ///
> +    /// This is useful for initializing types which lazily allocate, lik=
e
> +    /// `Vec::new` does.
> +    ///
> +    /// Note that the pointer value may potentially represent a valid po=
inter to
> +    /// a `T`, which means this must not be used as a "not yet initializ=
ed"
> +    /// sentinel value. Types that lazily allocate must track initializa=
tion by
> +    /// some other means.
> +    #[must_use]
> +    #[inline]
> +    pub const fn dangling() -> Self {
> +        Unique {
> +            pointer: NonNull::dangling(),
> +            _marker: PhantomData,
> +        }
> +    }

I think I already asked this, but the code until this point is copied
from the rust stdlib and nowhere cited, does that work with the
licensing?

I also think that the code above could use some improvements:
- add an `# Invariants` section with appropriate invariants (what are
  they supposed to be?)
- Do we really want this type to be public and exported from the kernel
  crate? I think it would be better if it were crate-private.
- What do we gain from having this type? As I learned recently, the
  `Unique` type from `core` doesn't actually put the `noalias` onto
  `Box` and `Vec`. The functions are mostly delegations to `NonNull`, so
  if the only advantages are that `Send` and `Sync` are already
  implemented, then I think we should drop this.

> +}
> +
> +impl<T: ?Sized> Unique<T> {
> +    /// Creates a new `Unique`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must be non-null.
> +    #[inline]
> +    pub const unsafe fn new_unchecked(ptr: *mut T) -> Self {
> +        // SAFETY: the caller must guarantee that `ptr` is non-null.
> +        unsafe {

The only unsafe operation in the body is `new_unchecked` only that one
should be wrapped in `unsafe {}`.

> +            Unique {
> +                pointer: NonNull::new_unchecked(ptr),
> +                _marker: PhantomData,
> +            }
> +        }
> +    }
> +
> +    /// Creates a new `Unique` if `ptr` is non-null.
> +    #[allow(clippy::manual_map)]
> +    #[inline]
> +    pub fn new(ptr: *mut T) -> Option<Self> {
> +        if let Some(pointer) =3D NonNull::new(ptr) {
> +            Some(Unique {
> +                pointer,
> +                _marker: PhantomData,
> +            })
> +        } else {
> +            None
> +        }

Why is this so verbose? You even needed to disable the clippy lint!
Can't this just be?:

    Some(Unique {
        pointer: NonNull::new(ptr)?,
        _marker: PhantomData,
    })

or maybe even

    NonNull::new(ptr).map(Unique::from)


> +    }
> +
> +    /// Acquires the underlying `*mut` pointer.
> +    #[must_use =3D "`self` will be dropped if the result is not used"]

This seems like an odd thing, there is no `Drop` impl that drops the
pointee...

---
Cheers,
Benno


