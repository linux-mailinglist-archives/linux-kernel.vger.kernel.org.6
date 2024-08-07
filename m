Return-Path: <linux-kernel+bounces-278479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1765694B0CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D42928407E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83701459E4;
	Wed,  7 Aug 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OnvOAytZ"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535A2B9C6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060845; cv=none; b=W5ybGY0ixAf/49lfjDabxzLioJBZIAMOIDbey2qgTt+5drX+ONJJWcOsOLv4b4mNSsL7Mw30jxd3EsKZ46CeIj38Lp9cXhaU6Mmz42kDG1D3tSggnoWK+OHBnegLRaT4yxiEdSIN4xp5J7Od4SFou7lA3tZOD0oQFHfF230LRr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060845; c=relaxed/simple;
	bh=DWQDHFpuKWvvnZPeDcxg7ENQalKiALDNIxmVJjcXELk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT+8Ypdst+jgC/QMz+TDi5c4jJALNrjWcPRuWYvlp6WnFcH2amTScz2b7J3KAbhBqFggljdgKIZbKXKNDN1ZYa+Zix1x48FrbqJKhjmNCBjKJ+sTQkbnQY4pOcqqflsDx0301cHrk4CCydxXvv/xiZzIWNby9F23ZEfCVMgc4oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OnvOAytZ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723060835; x=1723320035;
	bh=zu1rORrbF+TIF/UNStDvHRPRM8s1Kkx0uX6CdAA1WS0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OnvOAytZgfXahQ+PpHJUBITKr6ZaZYH/bTJcyoOSyt3wIb6CBwn/kTomPz4sQQXpH
	 Iw8KND+Fx5L925IdyjvCJxwguPz3HHvG3CVBZ28/xy3Qe/y6UCk7V9vMuXpQr+NE04
	 vzMVZErU4I8UqeVHhlGRcI4mH4+qEDjEOAg9WvAIOL+/D+n5+TNRvJXDAGfd2F8cDm
	 y1iKoeLYi8AB9/HlFmpa8KgvYzaHmRJ8UiFiY1DgyzgqZZR0lWgoT2Pm/FE0+zG+/H
	 IH909AfSE/UQLRqM1G9/S5Je6aB7eAZ8OXOVoJU7/dc72WYqzsI73v5VOhnOyTvV/v
	 iScNsXW/1Gaag==
Date: Wed, 07 Aug 2024 20:00:31 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 01/28] rust: alloc: add `Allocator` trait
Message-ID: <ab0a6cb7-037e-43af-a885-f848ca8e3add@proton.me>
In-Reply-To: <ZrNADDlM-RPS0Sze@pollux>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-2-dakr@kernel.org> <470b5f70-b592-43a7-81ba-c7f1c852b9f3@proton.me> <ZrJrzYXM9RffF4kf@pollux.localdomain> <52b1a806-48c7-4ae2-b78c-ca0e8bf5e1d7@proton.me> <ZrNADDlM-RPS0Sze@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9f1bd98ad2f020acae0ce2537b94d9087f911ed9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.08.24 11:36, Danilo Krummrich wrote:
> On Tue, Aug 06, 2024 at 08:04:30PM +0000, Benno Lossin wrote:
>>>>> +    /// instance. The alignment encoded in `layout` must be smaller =
than or equal to the alignment
>>>>> +    /// requested in the previous `alloc` or `realloc` call of the s=
ame allocation.
>>>>> +    ///
>>>>> +    /// Additionally, `ptr` is allowed to be `None`; in this case a =
new memory allocation is
>>>>> +    /// created.
>>>>> +    ///
>>>>> +    unsafe fn realloc(
>>>>> +        ptr: Option<NonNull<u8>>,
>>>>> +        layout: Layout,
>>>>> +        flags: Flags,
>>>>> +    ) -> Result<NonNull<[u8]>, AllocError>;
>>>>> +
>>>>> +    /// Free an existing memory allocation.
>>>>> +    ///
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// `ptr` must point to an existing and valid memory allocation =
created by this `Allocator`
>>>>> +    /// instance.
>>>>
>>>> Additionally, you need "The memory allocation at `ptr` must never agai=
n
>>>> be read from or written to.".
>>>
>>> I'm fine adding it, but I wonder if technically this is really required=
? The
>>> condition whether the pointer is ever accessed again in any way is not =
relevant
>>> in terms of being a precondition for `free` not causing UB, right?
>>
>> I don't see how else we would find the mistake in the following code:
>>
>>     let ptr =3D Box::into_raw(Box::<i32, Kmalloc>::new(42));
>>     // SAFETY: `ptr` came from `Box::into_raw` and thus is pointing to a
>>     // valid and existing memory allocation allocated by `Kmalloc`.
>>     unsafe { Kmalloc::free(ptr) };
>>     // SAFETY: `ptr` came from `Box::into_raw` and thus is pointing at a
>>     // valid `i32`.
>>     let v =3D unsafe { ptr.read() };
>=20
> Sure, but what I mean is that my understanding is that the "Safety" secti=
on in a
> comment describes the requirements of the function it documents. I.e. `fr=
ee`
> itself doesn't care whether the pointer is read or writted ever again.

So if you have an `unsafe` function, the safety requirements are not
limited to ensuring that that function does not exhibit UB. But in
general any correct usage of that function must not exhibit UB in
combination with any other correct usage of any other `unsafe`
functions.

> Or in other words, what are the rules where this belongs to? E.g. why not
> document this exact aspect in the safety section of `Allocator`?

That doesn't work, since the Safety section of `Allocator` is meant for
safety requirements for implementing `Allocator`. They should not be
relevant for using it.

>> Also see the `from_raw` for our `Arc`:
>>
>>     /// Recreates an [`Arc`] instance previously deconstructed via [`Arc=
::into_raw`].
>>     ///
>>     /// # Safety
>>     ///
>>     /// `ptr` must have been returned by a previous call to [`Arc::into_=
raw`]. Additionally, it
>>     /// must not be called more than once for each previous call to [`Ar=
c::into_raw`].
>>     pub unsafe fn from_raw(ptr: *const T) -> Self {
>>
>> That also requires that the function must not be called more than once.
>> This reminds me, I forgot to say that about `Box::from_raw`.
>=20
> Indeed, I also wonder if we ever have cases where C code gives us ownersh=
ip of a
> memory allocation of a certain type that fulfills the requirements we hav=
e for
> a `Box`, such that Rust code is tempted to pass it to `Box::from_raw`.
>=20
> It sounds a bit scary design wise, but in theory it's possible.

I don't think it's scary, in fact we are already doing it and have a
trait for that: `ForeignOwnable`. But that means that the pointer
originates from Rust, so it might not exactly be what you meant ie C
allocates the memory. But that case also doesn't seem too scary for me.
C just needs to respect alignment and then it should be equivalent to
Rust calling the allocator.

---
Cheers,
Benno


