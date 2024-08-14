Return-Path: <linux-kernel+bounces-287229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF72952506
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CFB28592F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE91E1C8FB2;
	Wed, 14 Aug 2024 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7w3kvYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1661BBBF4;
	Wed, 14 Aug 2024 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672697; cv=none; b=ceqnhONekaBes5hFxFAO/3XznAt/SHAqX3Zd6qBh8aO91PFvbGADINPLKxaSuMOfZoonJofiAy/zibtacf/kOQelBSZJmIS/cCjBtPvlIMcd98XOhxPY3BJTQC0AyHTdXnvUtYBplvT6RPdq1ECq1TEYQiViCqkbvyL3/aBlBNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672697; c=relaxed/simple;
	bh=WF7mh1nnaAx+2BtQVDbvZ9mTMjWH5kKojT+9NKpDGDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQ2HhSry+ymTGrJYt/Mrk/0yo2plxi43/W/q6VqRN9LW+e4tHhAAp4HSmLpOmiEGWlTr8eqN3jFbw9+B6B+jYKVz+3uC0z4KK+djFM8GXIq0KUfvtZlK7yK5WT+4uyYVJT12Yq00p0aAJkDv2l00i8Rj4QP5tQFJJZGo6Y0vaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7w3kvYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE173C116B1;
	Wed, 14 Aug 2024 21:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723672696;
	bh=WF7mh1nnaAx+2BtQVDbvZ9mTMjWH5kKojT+9NKpDGDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k7w3kvYtTLgFnwfGAbkC9JLrNGliHDW5YldIQLHAnWlAQGLs5TsJfY66aO72aESXS
	 NKAzOS5reSFyMrmYzZ6KT8V7gvFvZ8RKwAiLJsMU3kolElPZKA1GKL7EtSHkv4IDfZ
	 OrcYAKWjTCHnih6lBPj/FTY+Ps8T/7fVqhjQB4/wMuu4lJEx4eGp2LQ0aQb+Ya88lX
	 eRD4kWGW5rTkeu7hPh90Tlpo7OFTwu0dbV4ED5qAEDdyopTMmdoH/WIrQ0YNW1FTLP
	 xj9y8L/Brrs+/tYVEm9lgyMshxJo91uuSjbWuSsRZehjzQQBzGRva4ZNBNFvz+ypmx
	 6Me9Hd3WpGkEw==
Date: Wed, 14 Aug 2024 23:58:08 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 09/26] rust: alloc: implement kernel `Box`
Message-ID: <Zr0ocI-j3fZZM7Rw@cassiopeiae>
References: <20240812182355.11641-1-dakr@kernel.org>
 <20240812182355.11641-10-dakr@kernel.org>
 <a69e7280-7291-49f7-a46f-1ad465efce04@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a69e7280-7291-49f7-a46f-1ad465efce04@proton.me>

On Wed, Aug 14, 2024 at 05:01:34PM +0000, Benno Lossin wrote:
> On 12.08.24 20:22, Danilo Krummrich wrote:
> > +/// The kernel's [`Box`] type - a heap allocation for a single value of type `T`.
> > +///
> > +/// This is the kernel's version of the Rust stdlib's `Box`. There are a couple of differences,
> > +/// for example no `noalias` attribute is emitted and partially moving out of a `Box` is not
> > +/// supported.
> 
> I would add "But otherwise it works the same." (I don't know if there is
> a comma needed after the "otherwise").

There are more differences we don't list here, and probably don't need to.
Hence, saying that it otherwise works the same isn't correct.

> Also I remember that there was one more difference with a custom box
> compared to the stdlib, but I forgot what that was, does someone else
> remember? We should also put that here.

Obviously, there are also quite some API differences. For instance, `Box`
generally requires two generics, value type and allocator, we take page flags
and return a `Result`, where std just panics on failure.

> 
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
> 
> "pointer always properly" -> "pointer is properly"
> 
> > +/// for zero-sized types, is a dangling pointer.
> 
> I think this section would look nicer, if it were formatted using bullet
> points (that way the bracketing of the "or" is also unambiguous).
> 
> Additionally, this is missing that the pointer is valid for reads and
> writes.
> 
> > +pub struct Box<T: ?Sized, A: Allocator>(NonNull<T>, PhantomData<A>);
> 
> Why no `repr(transparent)`?

I wasn't entirely sure whether that's OK with the additional `PhantomData`, but
I think it is, gonna add it.

> 
> > +
> > +/// Type alias for `Box` with a `Kmalloc` allocator.
> 
> I think we should add that this is only designed for small values.

I don't want duplicate the existing documentation around kmalloc and friends
[1].

Maybe we can refer to the existing documentation somehow.

[1] https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html

> 
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
> 
> Same here, add that this is supposed to be used for big values (or is
> this also a general-purpose allocator, just not guaranteeing that the
> memory is physically contiguous? in that case I would document it
> here and also on `Vmalloc`).

Same as above, I'd rather not duplicate that. But I'm happy to link things in,
just not sure what's the best way doing it.


