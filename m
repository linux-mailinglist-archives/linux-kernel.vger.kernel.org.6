Return-Path: <linux-kernel+bounces-277086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A37A949C2D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B61282DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4750178376;
	Tue,  6 Aug 2024 23:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRV6bPSP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61D080043;
	Tue,  6 Aug 2024 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722985972; cv=none; b=VL6/gGDpCPrZkoOEbuR7Ea0JanAg6VPd7T/AqJOdCZhn8mD9HDx3c0PTrTPMmy0k+gJEnpMbuagVBSG1uqPabN90yxXh1lngaqR4gQXnF3WTUjQ2PK8e7UJnL7dfQ5jOYoa0yujDvG8GW1g6o2e+9UgSuRKLwmiDDjK9kI56CkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722985972; c=relaxed/simple;
	bh=PAZHp6OtLIaKqZLMIql6pp3yAxafXT5yMkj2WORwzWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltd61jZni8eVUmDB6Xm4gr7G0Jg61E/Fki1TWQ5RlC2sJCkE2sTBn5xf6aDYZN0oBQNoPzLaJ0aP4YH0iXcUv7iB4EzfGwbXS6bQdgoB+1BocZjdZMgc2bZ+uOq2EYtD31oTHXQNRL8B2IqYqDA5FOyXoYKZ9uuv+JO74e/YaAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRV6bPSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5C0C32786;
	Tue,  6 Aug 2024 23:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722985972;
	bh=PAZHp6OtLIaKqZLMIql6pp3yAxafXT5yMkj2WORwzWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRV6bPSPu+tWCj5dJAT8oGX+HX9gboBatMkUNYwYRilr2cCX5GryoKcOlfsdwAgOj
	 6OQXnHlXEYsh/lL15SVQVKWUn3096vN6GGTC6BVSomWlwgx+42OqlNP7DnQIRC3SYv
	 OKBgn6DR5tVQXpr07RzzsuiQA5FmSPe5or6uVh6aG3vVtg05bmFekaI6DmOt13vMk/
	 cVXM3aZM1G4XrScOTEdCJcZT7HC49ZBnWaS3X0L0E237mLutYuOYh75cxoT7pp4DTG
	 O876lwkdg/Sv4B3VCG9LBqGYb8OG/cBElt/5G0YvCXe6e5EiknAjhS+3c9rcA6PQEW
	 bogFENTq8iu3A==
Date: Wed, 7 Aug 2024 01:12:44 +0200
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
Subject: Re: [PATCH v4 08/28] rust: types: implement `Unique<T>`
Message-ID: <ZrKt7K68W1Jh6nhr@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-9-dakr@kernel.org>
 <ff0826af-9430-4653-abe8-25fb80cd0e97@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff0826af-9430-4653-abe8-25fb80cd0e97@proton.me>

On Tue, Aug 06, 2024 at 05:22:21PM +0000, Benno Lossin wrote:
> On 05.08.24 17:19, Danilo Krummrich wrote:
> > Implement the `Unique` type as a prerequisite for `Box` and `Vec`
> > introduced in subsequent patches.
> > 
> > `Unique` serves as wrapper around a `NonNull`, but indicates that the
> > possessor of this wrapper owns the referent.
> > 
> > This type already exists in Rust's core library, but, unfortunately, is
> > exposed as unstable API and hence shouldn't be used in the kernel.
> > 
> > This implementation of `Unique` is almost identical, but mostly stripped
> > down to the functionality we need for `Box` and `Vec`. Additionally, all
> > unstable features are removed and / or replaced by stable ones.
> > 
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/types.rs | 183 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 183 insertions(+)
> > 
> > diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> > index bd189d646adb..7cf89067b5fc 100644
> > --- a/rust/kernel/types.rs
> > +++ b/rust/kernel/types.rs
> > @@ -473,3 +473,186 @@ unsafe impl AsBytes for str {}
> >  // does not have any uninitialized portions either.
> >  unsafe impl<T: AsBytes> AsBytes for [T] {}
> >  unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
> > +
> > +/// A wrapper around a raw non-null `*mut T` that indicates that the possessor
> > +/// of this wrapper owns the referent. Useful for building abstractions like
> > +/// `Box<T>`, `Vec<T>`, `String`, and `HashMap<K, V>`.
> > +///
> > +/// Unlike `*mut T`, `Unique<T>` behaves "as if" it were an instance of `T`.
> > +/// It implements `Send`/`Sync` if `T` is `Send`/`Sync`. It also implies
> > +/// the kind of strong aliasing guarantees an instance of `T` can expect:
> > +/// the referent of the pointer should not be modified without a unique path to
> > +/// its owning Unique.
> > +///
> > +/// If you're uncertain of whether it's correct to use `Unique` for your purposes,
> > +/// consider using `NonNull`, which has weaker semantics.
> > +///
> > +/// Unlike `*mut T`, the pointer must always be non-null, even if the pointer
> > +/// is never dereferenced. This is so that enums may use this forbidden value
> > +/// as a discriminant -- `Option<Unique<T>>` has the same size as `Unique<T>`.
> > +/// However the pointer may still dangle if it isn't dereferenced.
> > +///
> > +/// Unlike `*mut T`, `Unique<T>` is covariant over `T`. This should always be correct
> > +/// for any type which upholds Unique's aliasing requirements.
> > +#[repr(transparent)]
> > +pub struct Unique<T: ?Sized> {
> > +    pointer: NonNull<T>,
> > +    // NOTE: this marker has no consequences for variance, but is necessary
> > +    // for dropck to understand that we logically own a `T`.
> > +    //
> > +    // For details, see:
> > +    // https://github.com/rust-lang/rfcs/blob/master/text/0769-sound-generic-drop.md#phantom-data
> > +    _marker: PhantomData<T>,
> > +}
> > +
> > +/// `Unique` pointers are `Send` if `T` is `Send` because the data they
> > +/// reference is unaliased. Note that this aliasing invariant is
> > +/// unenforced by the type system; the abstraction using the
> > +/// `Unique` must enforce it.
> > +unsafe impl<T: Send + ?Sized> Send for Unique<T> {}
> > +
> > +/// `Unique` pointers are `Sync` if `T` is `Sync` because the data they
> > +/// reference is unaliased. Note that this aliasing invariant is
> > +/// unenforced by the type system; the abstraction using the
> > +/// `Unique` must enforce it.
> > +unsafe impl<T: Sync + ?Sized> Sync for Unique<T> {}
> > +
> > +impl<T: Sized> Unique<T> {
> > +    /// Creates a new `Unique` that is dangling, but well-aligned.
> > +    ///
> > +    /// This is useful for initializing types which lazily allocate, like
> > +    /// `Vec::new` does.
> > +    ///
> > +    /// Note that the pointer value may potentially represent a valid pointer to
> > +    /// a `T`, which means this must not be used as a "not yet initialized"
> > +    /// sentinel value. Types that lazily allocate must track initialization by
> > +    /// some other means.
> > +    #[must_use]
> > +    #[inline]
> > +    pub const fn dangling() -> Self {
> > +        Unique {
> > +            pointer: NonNull::dangling(),
> > +            _marker: PhantomData,
> > +        }
> > +    }
> 
> I think I already asked this, but the code until this point is copied
> from the rust stdlib and nowhere cited, does that work with the
> licensing?
> 
> I also think that the code above could use some improvements:
> - add an `# Invariants` section with appropriate invariants (what are
>   they supposed to be?)
> - Do we really want this type to be public and exported from the kernel
>   crate? I think it would be better if it were crate-private.
> - What do we gain from having this type? As I learned recently, the
>   `Unique` type from `core` doesn't actually put the `noalias` onto
>   `Box` and `Vec`. The functions are mostly delegations to `NonNull`, so
>   if the only advantages are that `Send` and `Sync` are already
>   implemented, then I think we should drop this.

I originally introduced it for the reasons described in [1], but mainly to make
clear that the owner of this thing also owns the memory behind the pointer and
the `Send` and `Sync` stuff you already mentioned.

If no one else has objections we can also just drop it. Personally, I'm fine
either way.

[1] https://docs.rs/rust-libcore/latest/core/ptr/struct.Unique.html

> 
> > +}
> > +
> > +impl<T: ?Sized> Unique<T> {
> > +    /// Creates a new `Unique`.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must be non-null.
> > +    #[inline]
> > +    pub const unsafe fn new_unchecked(ptr: *mut T) -> Self {
> > +        // SAFETY: the caller must guarantee that `ptr` is non-null.
> > +        unsafe {
> 
> The only unsafe operation in the body is `new_unchecked` only that one
> should be wrapped in `unsafe {}`.
> 
> > +            Unique {
> > +                pointer: NonNull::new_unchecked(ptr),
> > +                _marker: PhantomData,
> > +            }
> > +        }
> > +    }
> > +
> > +    /// Creates a new `Unique` if `ptr` is non-null.
> > +    #[allow(clippy::manual_map)]
> > +    #[inline]
> > +    pub fn new(ptr: *mut T) -> Option<Self> {
> > +        if let Some(pointer) = NonNull::new(ptr) {
> > +            Some(Unique {
> > +                pointer,
> > +                _marker: PhantomData,
> > +            })
> > +        } else {
> > +            None
> > +        }
> 
> Why is this so verbose? You even needed to disable the clippy lint!
> Can't this just be?:
> 
>     Some(Unique {
>         pointer: NonNull::new(ptr)?,
>         _marker: PhantomData,
>     })
> 
> or maybe even
> 
>     NonNull::new(ptr).map(Unique::from)
> 
> 
> > +    }
> > +
> > +    /// Acquires the underlying `*mut` pointer.
> > +    #[must_use = "`self` will be dropped if the result is not used"]
> 
> This seems like an odd thing, there is no `Drop` impl that drops the
> pointee...
> 
> ---
> Cheers,
> Benno
> 

