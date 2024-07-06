Return-Path: <linux-kernel+bounces-243168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620839292B2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6DB1F21DC3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 10:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CC973478;
	Sat,  6 Jul 2024 10:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iNdP4Hjb"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B226E61B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720263559; cv=none; b=VX2ujk9H2VecA9qNYSyiPuMURifNNtdPZo489hstKq01yXMQScn4qnqw7aPtLdN4tuE98HmIPsd+GW39fWH4qdy73ZPj2LfRIczmMaF/lIamso0BbYwgsDOMQZfVeUphjXDnuP1QA0f5CxJks6d4e/Xgpl7Oe4UntTuKkVij5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720263559; c=relaxed/simple;
	bh=DFneIP49bQnhsMfGzKFKrTQK25QZpicdIXrVgMS9Z7I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnTueniWVxjjxajrnWyVknPDKv1EC9HLWd/s5NiEvRHsRm1XOIC54WdZFVzufri8KQZ/GlzrGWXzYKouq2954GXUCKii4ie9QlmxbWZdyBCjGl9Dre09KQc56sFKPpA0Q2tkeXcq+3N82N+l45AEdBu65Eey2Z8RrAd1Am34DZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iNdP4Hjb; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1720263555; x=1720522755;
	bh=T5iCOqkiGA7Prh1iXnrm7Tr90baz6asH5eAGyQoZ3kc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iNdP4HjbZ9uKUCcL2MnhRpDV1szaivcoZuEIAeecvpiBasuDFQCFgFRMQK38MfrUW
	 L86t+hQvsg173uZMc8YvwnJXjYq8ISplwpLE63RN13Z71u4/FKjlautm4VfU2qC7Yw
	 PK9GZfdhd5uFIQcYrXqpzwRwvMKg32R/jDxQvXiBH+ZcxV/ypH8GnqCQHgK7Lt8k91
	 0SY/mVXoZVjhuMDE48HbqJ/KnNHRRuvo6A+KVFFA/3vkP3KcHGke6F/0uBH5iJ33lc
	 JPxCJe2Cy1MyV5+C3Lu2p7L+5Btbuf48HClwVyJFTqPcSSi3dpbTC86vn0vwcVJeYA
	 7/Yh1puF3l5VQ==
Date: Sat, 06 Jul 2024 10:59:09 +0000
To: Danilo Krummrich <dakr@redhat.com>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 09/20] rust: types: implement `Unique<T>`
Message-ID: <fa6d6c0a-17eb-4280-baa3-df5f97e58497@proton.me>
In-Reply-To: <20240704170738.3621-10-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com> <20240704170738.3621-10-dakr@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 495c9c2ed9f3ec199f011a4edabab598ca598bda
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.07.24 19:06, Danilo Krummrich wrote:
> Implement the `Unique` type as a prerequisite for `KBox` and `Kvec`
> introduced in subsequent patches.
>=20
> `Unique` serves as wrapper around a `NonNull`, but indicates that the
> possessor of this wrapper owns the referent.
>=20
> This type already exists in Rust's core library, but, unfortunately, is
> exposed as unstable API and hence shouldn't be used in the kernel.

It's not really exposed, as the feature (ptr_internals) is an internal
unstable feature and thus probably perma-unstable.

(but your argument still holds, this just means that we *really* should
not be using it)

> This implementation of `Unique` is almost identical, but mostly stripped
> down to the functionality we need for `KBox` and `KVec`. Additionally,
> all unstable features are removed and / or replaced by stable ones.
>=20
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/kernel/types.rs | 176 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 176 insertions(+)
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 2e7c9008621f..281327ea2932 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -409,3 +409,179 @@ pub enum Either<L, R> {
>      /// Constructs an instance of [`Either`] containing a value of type =
`R`.
>      Right(R),
>  }
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

Since you copied this directly from the stdlib, should this be citing
it?

> +#[repr(transparent)]
> +pub struct Unique<T: ?Sized> {
> +    pointer: NonNull<T>,

Gary and I already mentioned this in the meeting, but I will put it here
for the record:

The `Unique` from std is special, in the sense that the Rust compiler
will emit the `noalias` LLVM attribute.

This gives std's `Box` type a possible performance advantage (IIRC Gary
had a compiler explorer example that showed different instruction
count).

I thought that we could mimic this behavior if we would change the type
of `pointer` to `ManuallyDrop<Box<T>>`. But that only works if the
pointer is always valid, since otherwise we can't call `Box::from_raw`.

So currently I don't see a workaround that would give us the noalias
attribute back.

It would be a good idea to get some benchmarks on how this affects
performance, Andreas or Alice do you think you can give a bit of compute
time, once this patchset is more mature?

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

I think we should give `Unique` the invariant that it is unique, making
this function `unsafe`, since the caller must ensure that only this
unique has access to the pointee.

---
Cheers,
Benno

> +        if let Some(pointer) =3D NonNull::new(ptr) {
> +            Some(Unique {
> +                pointer,
> +                _marker: PhantomData,
> +            })
> +        } else {
> +            None
> +        }
> +    }


