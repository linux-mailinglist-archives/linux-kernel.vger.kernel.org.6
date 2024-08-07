Return-Path: <linux-kernel+bounces-277749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B894A5BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651AB1F239C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4A71DF687;
	Wed,  7 Aug 2024 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJqLvm3r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B113F435;
	Wed,  7 Aug 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027120; cv=none; b=dPpl09wxjN5vPtTzAV4Kw+4B14Ji+FjW3oD8SK3uOFDb/ovpzK9A0vPF4DzPtk8bKiciMKdrtQMotyBXvRYZ3joeeLbh/naBnnD655Q15jxGpiGmNdgWSqSt9ukLIRb7Rwzge/FS7UqQ/UTFOL64WEZQ16pJZA3/7DxsQyCowfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027120; c=relaxed/simple;
	bh=STvcnja0Tc7ymfqdtiFmaSa11SWIguyBpn2081WtcHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPI7jAhO/Jv/IQfZDH/cobC3fFRlntOtq/rBj0e+jF3+lqJVL5puKGKTbDwVjDBqA1rGe2nsxNAu3/oG/323fx8pQUIU6vRoasKiY+4tM89t1GjPpXQrhwzrA7AqmCngM4goYEgrIiMdNnH5O0HKxcYMD1k9GaePkN9cALEtXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJqLvm3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F15CC4AF0F;
	Wed,  7 Aug 2024 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027120;
	bh=STvcnja0Tc7ymfqdtiFmaSa11SWIguyBpn2081WtcHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJqLvm3rHVOLyaq8smuVjQQdSzNS+oIsNqbbIxgDoY3OrwVHwOvTMPeQf3qwxqA04
	 a4RwUgcFD8wBSqgdMqrZlKjrFl10baZNlqCj51dHK3DedijW/iDCNTX9l+RfIjYYzo
	 6HkFYnrqjkVFwQLahF9tTAGsb58s4HOHI1M/sWSRHeCSIAGYqcYvYZ+pClgEXu2teR
	 gHlyU0HHgsxqZXcMmDDG56V/2Zhx+8PTCrwXswJkeKdmtgq5mmxNt4DmsOdoSXKQaB
	 XFAOXCoSb80CcybPCnq3WBPvD3JyJ7L4Dh4JJBBk50r1XikM09jgBrSrQlq6V67YgM
	 1FkHh8+eTfTgQ==
Date: Wed, 7 Aug 2024 12:38:32 +0200
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
Message-ID: <ZrNOqEXo_V4O4srC@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-10-dakr@kernel.org>
 <a1c1e273-2d40-4114-b3b9-f27c73e3d122@proton.me>
 <ZrKrMrg5E85y7jkj@pollux>
 <012f5a12-2408-4658-8318-55fa8d4285e1@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <012f5a12-2408-4658-8318-55fa8d4285e1@proton.me>

On Wed, Aug 07, 2024 at 07:49:31AM +0000, Benno Lossin wrote:
> >> With this requirement and the invariant on `Box`, I am lead to believe
> >> that you can't use this for ZSTs, since they are not allocated with `A`.
> >> One solution would be to adjust this requirement. But I would rather use
> >> a different solution: we move the dangling pointer stuff into the
> >> allocator and also call it when `T` is a ZST (ie don't special case them
> >> in `Box` but in the impls of `Allocator`). That way this can stay as-is
> >> and the part about ZSTs in the invariant can be removed.
> > 
> > Actually, we already got that. Every zero sized allocation will return a
> > dangling pointer. However, we can't call `Allocator::free` with (any) dangling
> > pointer though.
> 
> The last part is rather problematic in my opinion, since the safety
> requirements of the functions in `Allocator` don't ensure that you're
> not allowed to do it.

Yes, I think it needs to be added.

> We should make it possible to free dangling
> pointers that were previously "allocated" by the allocator (ie returned
> by `realloc`).
> Maybe we do need an `old_layout` parameter for that (that way we can
> also `debug_assert_eq!(old_layout.align(), new_layout.align())`).

Please see my reply in [1] - let's continue the discussion there.

[1] https://lore.kernel.org/rust-for-linux/ZrNIaAcGkGU0d8I3@pollux/

> 
> >>> +    {
> >>> +        Ok(Self::new(x, flags)?.into())
> >>> +    }
> >>> +
> >>> +    /// Drops the contents, but keeps the allocation.
> >>> +    ///
> >>> +    /// # Examples
> >>> +    ///
> >>> +    /// ```
> >>> +    /// let value = KBox::new([0; 32], GFP_KERNEL)?;
> >>> +    /// assert_eq!(*value, [0; 32]);
> >>> +    /// let value = KBox::drop_contents(value);
> >>> +    /// // Now we can re-use `value`:
> >>> +    /// let value = KBox::write(value, [1; 32]);
> >>> +    /// assert_eq!(*value, [1; 32]);
> >>> +    /// # Ok::<(), Error>(())
> >>> +    /// ```
> >>> +    pub fn drop_contents(this: Self) -> Box<MaybeUninit<T>, A> {
> >>> +        let ptr = Box::into_raw(this);
> >>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> >>> +        unsafe { core::ptr::drop_in_place(ptr) };
> >>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
> >>> +        unsafe { Box::from_raw(ptr.cast()) }
> >>> +    }
> >>
> >> I don't particularly care in this instance, but you just took my patch
> >> and folded it into your own without asking me or specifying it in the
> >> commit message. In general I would have assumed that you just put the
> >> entire patch into the series (with correct From:... etc).
> > 
> > When I asked about this in [1] my understanding was that we expect [1] to land
> > prior to this series. So, I'm just anticipating a future rebase where I move
> > this code from box_ext.rs to kbox.rs, just like Alice suggested for her
> > "ForeignOwnable for Pin<crate::alloc::Box<T, A>>" implementation.
> > 
> > I also understand your later reply, where you said: "[...] then you can just
> > include it when you remove the `BoxExit` trait." as confirmation.
> > 
> > Probably that's a misunderstanding though. Sorry if that's the case.
> 
> Yeah what I meant by that was you base it on top and then move it from
> the `BoxExt` trait over to `Box` in a correctly attributed patch.

I don't understand this. What do you mean with "correctly attributed patch" in
this case?

There are various existing implementations around `Box` and `BoxExt`, are you
saying that I should create separate patches for moving / adapting all of them,
e.g. this patch adapts parts from `BoxExt`, the implementation of
`ForeignOwnable` for `Box<T>`, the implementation of `InPlaceInit<T>` for
`Box<T>`.

I don't think this is necessary.

I probably shouldn't anticipate a future rebase though, it just leads to
confusion. I'll drop it for now and re-add it once your patch lands in rust-next.

> As I
> said above, I don't really mind in this case, since it's trivial, so no
> worries. Just a heads-up for occasions where it is non-trivial.
> 
> > [1] https://lore.kernel.org/lkml/24a8d381-dd13-4d19-a736-689b8880dbe1@proton.me/
> > 
> >>
> >>> +}
> >>> +
> >>> +impl<T, A> From<Box<T, A>> for Pin<Box<T, A>>
> >>> +where
> >>> +    T: ?Sized,
> >>> +    A: Allocator,
> >>> +    A: 'static,
> >>> +{
> >>> +    /// Converts a `Box<T>` into a `Pin<Box<T>>`. If `T` does not implement [`Unpin`], then
> >>> +    /// `*boxed` will be pinned in memory and unable to be moved.
> >>> +    ///
> >>> +    /// This conversion does not allocate on the heap and happens in place.
> >>> +    ///
> >>> +    /// This is also available via [`Box::into_pin`].
> >>> +    ///
> >>> +    /// Constructing and pinning a `Box` with <code><Pin<Box\<T>>>::from([Box::new]\(x))</code>
> >>> +    /// can also be written more concisely using <code>[Box::pin]\(x)</code>.
> >>> +    /// This `From` implementation is useful if you already have a `Box<T>`, or you are
> >>> +    /// constructing a (pinned) `Box` in a different way than with [`Box::new`].
> >>
> >> This also looks very much like something from the stdlib...
> > 
> > Yeah, I'll replace that.
> > 
> >>
> >>> +    fn from(b: Box<T, A>) -> Self {
> >>> +        Box::into_pin(b)
> >>> +    }
> >>> +}
> >>> +
> >>> +impl<T, A> Deref for Box<T, A>
> >>> +where
> >>> +    T: ?Sized,
> >>> +    A: Allocator,
> >>> +{
> >>> +    type Target = T;
> >>> +
> >>> +    fn deref(&self) -> &T {
> >>> +        // SAFETY: `self.0` is always properly aligned, dereferenceable and points to an initialized
> >>> +        // instance of `T`.
> >>
> >> If `T` is a ZST, then it is not dereferenceable.
> > 
> > Why not? If `T` is a ZST `self.0` is `Unique::<T>::dangling()`. So, in the end
> > this is the same as `NonNull::<T>::dangling().as_ref()`.
> 
> You are right, I just looked at [1] again and they define
> dereferenceable as "the memory range of the given size starting at the
> pointer must all be within the bounds of a single allocated object", for
> a zero-sized allocation, this holds vacuously.
> 
> [1]: https://doc.rust-lang.org/core/ptr/index.html#safety
> 
> >>> +        unsafe { self.0.as_ref() }
> >>> +    }
> >>> +}
> >>> +
> >>> +impl<T, A> DerefMut for Box<T, A>
> >>> +where
> >>> +    T: ?Sized,
> >>> +    A: Allocator,
> >>> +{
> >>> +    fn deref_mut(&mut self) -> &mut T {
> >>> +        // SAFETY: `self.0` is always properly aligned, dereferenceable and points to an initialized
> >>> +        // instance of `T`.
> >>> +        unsafe { self.0.as_mut() }
> >>> +    }
> >>> +}
> >>> +
> >>> +impl<T, A> fmt::Debug for Box<T, A>
> >>> +where
> >>> +    T: ?Sized + fmt::Debug,
> >>> +    A: Allocator,
> >>> +{
> >>> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> >>> +        fmt::Debug::fmt(&**self, f)
> >>> +    }
> >>> +}
> >>> +
> >>> +impl<T, A> Drop for Box<T, A>
> >>> +where
> >>> +    T: ?Sized,
> >>> +    A: Allocator,
> >>> +{
> >>> +    fn drop(&mut self) {
> >>> +        let ptr = self.0.as_ptr();
> >>> +
> >>> +        // SAFETY: `ptr` is always properly aligned, dereferenceable and points to an initialized
> >>> +        // instance of `T`.
> >>> +        let size = unsafe { core::mem::size_of_val(&*ptr) };
> >>
> >> 1. `size_of_val` is not `unsafe`.
> > 
> > Right, but dereferencing the `ptr` is unsafe.
> > 
> >> 2. why not use `&*self` instead of using the raw pointer? (then move the
> >>    let binding below this line)
> > 
> > If we ever support non-ZST `Allocator`s using `self` would not always evaluate
> > to the correct size. I think evaluating the size of `T` rather than `Box<T>` is
> > the correct thing to do.
> 
> I mean use `Box::deref` (that's what `&*self` should do), you don't need
> to repeat the same SAFETY comment when it already is wrapped by a safe
> function.

Oh, yes, that's indeed a good suggestion.

> 
> ---
> Cheers,
> Benno
> 

