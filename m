Return-Path: <linux-kernel+bounces-279171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B200394B9E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB161C21C2E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDABC189BA4;
	Thu,  8 Aug 2024 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPPpeXhO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D184086A;
	Thu,  8 Aug 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110149; cv=none; b=CmO4uNpiZLTVBuqXH5m4K4QTgnyjVGC6YPc2TYKWiIQGg6/ONqj7Ft88ETrA1rpRvXSf4/LgTHsEyq3Tn/HzeC8LyEcuPEUxVxQla+pvLiqzh4lL1R5I2GNQInHzV4kL5RXtn5B+PZpSZlgMypcDCY/a+emBzhubp85BHjgBvqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110149; c=relaxed/simple;
	bh=Ruu1Dibsz/xmziCilreMjnHwkPH7+MJ6SjlGdxeoEDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUdVbzIL0dmzPPnC1PKSV3Qs8Aubr3ChF08witgzyQwj9bxxmXNS6UeLE3AedTRuDWBnCqzCgcBoEg/PXNX6v9l2qS7Kq3gnxDbHACHMpUtZzn2B8NOsyZKwu9e69AomGV7MMfdbvKJ6SCbyDwvG0GWcVXe+hOV0KUK3R+mjUyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPPpeXhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7D3C32782;
	Thu,  8 Aug 2024 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723110148;
	bh=Ruu1Dibsz/xmziCilreMjnHwkPH7+MJ6SjlGdxeoEDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPPpeXhO4FAZMRakG3y7vAqRGeL1HUCfD1TObCc+Vp6GKpvNzJk0yrNDPsl++4blV
	 f7ab4r5Vev2Jh5VYOOfqX/dVJ0kFU66V+X9JiF1HREsw2yviNl4ajGRPD4Rs+yogvE
	 9qlvO53cvT1PjBTgAPSDXU4l06K2D0HPdlp9l5eCen7pWPDzf6zA74EtveZMqb8nAA
	 p9ilGoqpH5vsvu0Yy3pViuT+PxYyBOMqXrFKH+imxJ1hKmITyJgL8cvd2BCdblGMEP
	 ThoBCHryJKOdTcasDgndCZKEr0XF1rPv+z18ZTzoi3mAu1eH1VdOaOgNkkvyKzBSL0
	 xmgfnvKicJAgg==
Date: Thu, 8 Aug 2024 11:42:20 +0200
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
Subject: Re: [PATCH v4 04/28] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <ZrSS_N1R7zkiH_-E@pollux>
References: <20240805152004.5039-1-dakr@kernel.org>
 <20240805152004.5039-5-dakr@kernel.org>
 <fe982cb6-4910-4ba2-ae4d-892514c9e7f7@proton.me>
 <ZrJxkwF2Y59xln1e@pollux.localdomain>
 <8ab83e4b-9c72-4a5d-974a-7f123753e7fe@proton.me>
 <ZrNIaAcGkGU0d8I3@pollux>
 <9e22d4ab-eff2-4c69-8a2f-f55a8eaeb892@proton.me>
 <ZrP90NR1lOpDrQ0X@pollux>
 <d005fe7e-74a8-4609-92e0-5dd3743ca060@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d005fe7e-74a8-4609-92e0-5dd3743ca060@proton.me>

On Thu, Aug 08, 2024 at 08:55:29AM +0000, Benno Lossin wrote:
> On 08.08.24 01:05, Danilo Krummrich wrote:
> > On Wed, Aug 07, 2024 at 08:15:41PM +0000, Benno Lossin wrote:
> >>> So, that's not permitted. `free` can't be called with a dangling pointer. The
> >>> kernel free functions (*1) can't handle it, and I can't detect it, since a
> >>> dangling pointer does not have a descrete value.
> >>
> >> That is true, but only if we do not have access to the old layout of the
> >> allocation. If we add `old_layout` as a parameter, then we can handle
> >> dangling pointers.
> > 
> > Then we'd need `free` to be `fn free(ptr: NonNull<u8>, layout: Layout)` just to
> > compare whether `ptr.as_ptr() == layout.align() as _`. Same for `realloc`, but
> > that's less weird.
> 
> I don't think that's a problem (though we would check against the size
> and not compare the address!). `Allocator` from stdlib also has the
> extra argument.

Because `Allocator` from stdlib actually needs it, e.g. they have to open code
`realloc`, since userspace allocators don't give proper alignment guarantees.

Again, the kernel allocators neither need, nor take and honor this extra
information.

> 
> > It's also not that we safe code with that. `Box`, `Vec`, any other user, still
> > would have to create the `Layout` before they call `A::free`.
> 
> But for `Box` it would just be `Layout::<T>::new()` and `Vec` needs
> `Layout::<T>::new().repeat(self.cap)`.

Let's take `Vec` for instance, there it's either

current code
------------
```
	if cap != 0 {
		unsafe { A::free(self.ptr.as_non_null().cast()) };
	}
```

your proposal
-------------
```
	let layout = Layout::<T>::array(self.cap).unwrap();
	unsafe { A::free(self.ptr.as_non_null().cast(), layout) };
```

I really don't see how that's an improvement.

> 
> Though for `repeat` we need the `alloc_layout_extra` feature, which is
> an argument against doing this.
> 
> >>> Surely, we could also let the caller pass the old alignment, but this all sounds
> >>> complicated for something that is very trivial for the caller to take care of,
> >>> i.e. just don't try to free something that was never actually allocated.
> >>>
> >>> It can also lead to subtle bugs, e.g. what if someone calls `Box::from_raw` for
> >>> a ZST with some other random pointer? Currently, that doesn't hurt us, which for
> >>> robustness, seems to be a good thing.
> >>
> >> I think we should forbid that. To me it's just plain wrong to take a
> >> random integer literal and cast it to a ZST. IIRC it even is UB if that
> >> points to a previously allocated object that has been freed (but I don't
> >> remember where I read it...).
> > 
> > I think my argument about robustness still holds even if we forbid it.
> > 
> > The documentation says "For operations of size zero, every pointer is valid,
> > including the null pointer." [1]
> 
> How does this increase robustness? I am not allowed to call `free` with
> a random pointer, only pointers returned by that allocator. The same
> should also be true for `Box::from_raw`. That way the ZST dangling
> pointer stuff leaks into that API.

This point was about your first proposal to use the alignment. With cosidering
only the alignment we can't handle the case where `Box::from_raw` is called with
a random pointer for a ZST, which *technically* isn't illegal. We can define it
as illegal, but I'd consider it to be more robust, if we don't oops in case.

But as you say checking the size instead of the alignment does not have this
problem.

> 
> > [1] https://doc.rust-lang.org/std/ptr/index.html
> > 
> >>
> >> Also if we use the size of the old layout instead of comparing alignment
> >> with the address of the pointer, then we avoid this issue.
> > 
> > That is just another problem when passing the old `Layout` (or maybe just the
> > old size as usize). Neither do we need the old size, nor do we honor it with any
> > kernel allocator. This has the following implications:
> > 
> > (1) We never see any error if the old size that is passed is garbage (unless
> >     it's non-zero, when it should be zero and vice versa), which is bad.
> 
> We could add debug support for that though?

And add even more complexity just to avoid a simple `if !zero` check before
calling `free`? I don't like that.

Just to clarify, I'm not against passing the old layout in general. But I really
don't want to pass something in that is not required *and* not honored by a
single kernel allocator.

IMO, the only other valid reason to accept unneeded arguments would be if we
could use the `Allocator` interface from stdlib.

> 
> > (2) We'd need `free` to be `fn free(ptr: NonNull<u8>, size: usize)`, which is
> >     confusing, because it implies that an actual free relies on this size for
> >     freeing the memory.
> 
> I don't think that it is confusing to ask for the old layout.

It is always confusing if a function asks for information that it doesn't need
and doesn't consider, because asking for it in the first place creates the
impression that it is indeed needed and considered.

> 
> > If we want to avoid (1) and (2), we'd need to make it
> > `fn free(ptr: NonNull<u8>, zero: bool)` instead, but then also the caller can
> > just check this boolean and conditionally call `free`.
> 
> Yeah having `free` with a `zero: bool` sounds like a bad idea.
> 
> > I don't really see why it's better to let `free` do the `if !zero` check.
> 
> You did not reply to my last argument:
> 
> >> I think it's better to just let `Box` and `Vec` figure out if calling `free` is
> >> the right thing to do. The code for that is simple and obvious, i.e. check if
> >> `T` is a ZST.
> >
> > I don't think that it is as simple as you make it out to be. To me this
> > is functionality that we can move into one place and never have to think
> > about again.
> > Also if we at some point decide to add some sort of debugging allocator
> > (am I right in assuming that such a thing already exists for C?) then we

The C side allocators have quite a lot of debugging capabilities, but there is
no separate one.

> > might want to tag on extra data in the allocation, in that case it would
> > be very useful if the allocator also saw zero-sized allocations, since
> > we should check all allocations.

What would such a debugging allocator do on the Rust side?

The allocators we have are just simple wrappers around the real kernel
allocators from the C side.

I don't really see the need for some sort of debugging allocator.

