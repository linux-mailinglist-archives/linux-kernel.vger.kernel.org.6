Return-Path: <linux-kernel+bounces-279132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF4794B965
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAD51C20971
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C39189BA7;
	Thu,  8 Aug 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Z/mk2TOG"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39114658D;
	Thu,  8 Aug 2024 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107337; cv=none; b=fk52LsOtPXEz6RBFogg478k6qyq+Ff1YQgGIknfL9ESGGCiCnlvEya+4OXxEYZmFDMAdnr0vgIVGyGOBkr9tPlStRvVqGZvLxZoPWXEOCWpqqy4TuQlCdxTWfeUKK1QQ0XVaUqT453lMAgmIfprIuv7tXCOigjolhVG2xyCt8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107337; c=relaxed/simple;
	bh=dipW0hAO1cmggCsC6AnWetuslUxQqg2fKB9dwryeTCU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V29VGTtQbIpwJSnzXbdFVo05TbiZmKzTuIFdF8/gycQJuILec0zZGFIjZsRIjJXya2mCmJELP/FDyTiWsQc4ZJeSAG4yd+nOsLq0TNlC2DWE0tIhZfHyso7FJGxYaq1ZV2ccdQlBj2RrnGGOmrw14oF0F6t89Kwu3vZBiyol8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Z/mk2TOG; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723107333; x=1723366533;
	bh=wkJEAdDhl6yHFGILgjqVF0fRuiGpIv73wXmrWkNdHzk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Z/mk2TOGozrUpa2k7RU9Ww0mf3nQwyIhjUBXFiAlVijcafxN08Q1SdYYtCQOMNVyP
	 hQwmBs7oj7RuLG/OmEiVmeL0ZAH/Yq6dlFI62Q9Y6L9OHIBh5JPCEn3FkehxUEMgrn
	 sL/JB45+MZ2pV1BUr7eH6I5iH9QKMEtUbDXEOWKWp/lFGjtexHYvCnqHjF0Ad2PGSq
	 PCKeWjiGOcjE2SnLTODo0eUCiU/TSrNoYbTOi3W3oy81DupnTIppfRAmrsPRlBGwDV
	 6Ou+7NGvZJr8wZGhZQV9Uyif02EWalQPrzxR6TBPKHtHhYh9Pw7QSIfu+CQT9BeqbV
	 5T9nHv3BlLV8Q==
Date: Thu, 08 Aug 2024 08:55:29 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 04/28] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <d005fe7e-74a8-4609-92e0-5dd3743ca060@proton.me>
In-Reply-To: <ZrP90NR1lOpDrQ0X@pollux>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-5-dakr@kernel.org> <fe982cb6-4910-4ba2-ae4d-892514c9e7f7@proton.me> <ZrJxkwF2Y59xln1e@pollux.localdomain> <8ab83e4b-9c72-4a5d-974a-7f123753e7fe@proton.me> <ZrNIaAcGkGU0d8I3@pollux> <9e22d4ab-eff2-4c69-8a2f-f55a8eaeb892@proton.me> <ZrP90NR1lOpDrQ0X@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f8f2ac30aed48680ece9b5b1e3e92bc7a6c94097
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.08.24 01:05, Danilo Krummrich wrote:
> On Wed, Aug 07, 2024 at 08:15:41PM +0000, Benno Lossin wrote:
>>> So, that's not permitted. `free` can't be called with a dangling pointe=
r. The
>>> kernel free functions (*1) can't handle it, and I can't detect it, sinc=
e a
>>> dangling pointer does not have a descrete value.
>>
>> That is true, but only if we do not have access to the old layout of the
>> allocation. If we add `old_layout` as a parameter, then we can handle
>> dangling pointers.
>=20
> Then we'd need `free` to be `fn free(ptr: NonNull<u8>, layout: Layout)` j=
ust to
> compare whether `ptr.as_ptr() =3D=3D layout.align() as _`. Same for `real=
loc`, but
> that's less weird.

I don't think that's a problem (though we would check against the size
and not compare the address!). `Allocator` from stdlib also has the
extra argument.

> It's also not that we safe code with that. `Box`, `Vec`, any other user, =
still
> would have to create the `Layout` before they call `A::free`.

But for `Box` it would just be `Layout::<T>::new()` and `Vec` needs
`Layout::<T>::new().repeat(self.cap)`.

Though for `repeat` we need the `alloc_layout_extra` feature, which is
an argument against doing this.

>>> Surely, we could also let the caller pass the old alignment, but this a=
ll sounds
>>> complicated for something that is very trivial for the caller to take c=
are of,
>>> i.e. just don't try to free something that was never actually allocated=
.
>>>
>>> It can also lead to subtle bugs, e.g. what if someone calls `Box::from_=
raw` for
>>> a ZST with some other random pointer? Currently, that doesn't hurt us, =
which for
>>> robustness, seems to be a good thing.
>>
>> I think we should forbid that. To me it's just plain wrong to take a
>> random integer literal and cast it to a ZST. IIRC it even is UB if that
>> points to a previously allocated object that has been freed (but I don't
>> remember where I read it...).
>=20
> I think my argument about robustness still holds even if we forbid it.
>=20
> The documentation says "For operations of size zero, every pointer is val=
id,
> including the null pointer." [1]

How does this increase robustness? I am not allowed to call `free` with
a random pointer, only pointers returned by that allocator. The same
should also be true for `Box::from_raw`. That way the ZST dangling
pointer stuff leaks into that API.

> [1] https://doc.rust-lang.org/std/ptr/index.html
>=20
>>
>> Also if we use the size of the old layout instead of comparing alignment
>> with the address of the pointer, then we avoid this issue.
>=20
> That is just another problem when passing the old `Layout` (or maybe just=
 the
> old size as usize). Neither do we need the old size, nor do we honor it w=
ith any
> kernel allocator. This has the following implications:
>=20
> (1) We never see any error if the old size that is passed is garbage (unl=
ess
>     it's non-zero, when it should be zero and vice versa), which is bad.

We could add debug support for that though?

> (2) We'd need `free` to be `fn free(ptr: NonNull<u8>, size: usize)`, whic=
h is
>     confusing, because it implies that an actual free relies on this size=
 for
>     freeing the memory.

I don't think that it is confusing to ask for the old layout.

> If we want to avoid (1) and (2), we'd need to make it
> `fn free(ptr: NonNull<u8>, zero: bool)` instead, but then also the caller=
 can
> just check this boolean and conditionally call `free`.

Yeah having `free` with a `zero: bool` sounds like a bad idea.

> I don't really see why it's better to let `free` do the `if !zero` check.

You did not reply to my last argument:

>> I think it's better to just let `Box` and `Vec` figure out if calling `f=
ree` is
>> the right thing to do. The code for that is simple and obvious, i.e. che=
ck if
>> `T` is a ZST.
>
> I don't think that it is as simple as you make it out to be. To me this
> is functionality that we can move into one place and never have to think
> about again.
> Also if we at some point decide to add some sort of debugging allocator
> (am I right in assuming that such a thing already exists for C?) then we
> might want to tag on extra data in the allocation, in that case it would
> be very useful if the allocator also saw zero-sized allocations, since
> we should check all allocations.

---
Cheers,
Benno


