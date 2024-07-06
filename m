Return-Path: <linux-kernel+bounces-243261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE89293BC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38001C20F65
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028C412F373;
	Sat,  6 Jul 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bsQGwG6C"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B024689;
	Sat,  6 Jul 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720271849; cv=none; b=GT/OMXw8lUsY4D85AlJyhCsiHKkmLkfubWQ3vf9hiNpf6XctXm6YEsuHkFUr2WYvbguKC60TUjLTANOuoM+NBLotOvTMDVWxz0W8PPfXz3G8qA9U3Dj+wsDBCN4pvnoaumfCNZCUxdXKCqY58NKMt/ZItEvxjK9VUk4b2TXHRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720271849; c=relaxed/simple;
	bh=pMQLgWXUUWUAcKGKTvjEGo2+7LQpB4vTwVyoEBfH2tY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkX0EmOTnwe/S3Rqcu5h1CcEZTl/RPDTZKD8Q73R0bgZYcpVgIjCEOgnp4b4wJArOuZTmR9T0a3A4mFhRiozGU9J6wHgYzbGa+Yn4BnkiJ/gYzXQnE45DGsTB4Ju2WLLvZoutO4EsIBh7WjlAY7nHh9K/UAXERoGJV/OMb2uVuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bsQGwG6C; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1720271845; x=1720531045;
	bh=J2SLCWi/cOCEUrc6au+4ffzQRV6ykGZST0O878MKXZc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bsQGwG6CdvT08BjAAX72dAa+EDd1sSGqXLHZvyVGXtoOsdiDS4005vxtBewpIBOjx
	 uoCrwkH0Q8sC55qrJpb3XJNR7SRJ+nu9D6aaWh9873A3QdndT4QZtaiLclS4tZcZWK
	 qgbePpJnjF9hMP4qYivO8WoR4ZfXHaELSHUMolkbemxVYoBJynHUOT0QF+pVZz2zzx
	 nAb6pI6FnLymBIKpNkkvAXzolMftooxHJ3Ufds2iJ6Yyw7jtM9NSYlF2zknx8qbA4X
	 gkfqZ2tMx2Ahct9gndrHJeIfB1wv5Q1XdttNhjywuQh/3EacN5P7x4r7LqTGiyqCkm
	 7EB7NgDllZeVA==
Date: Sat, 06 Jul 2024 13:17:19 +0000
To: Danilo Krummrich <dakr@redhat.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 01/20] rust: alloc: add `Allocator` trait
Message-ID: <2c322b00-20f8-4102-9f3b-edab0c0907b9@proton.me>
In-Reply-To: <ZoklB7aLyc90kWPT@pollux.localdomain>
References: <20240704170738.3621-1-dakr@redhat.com> <20240704170738.3621-2-dakr@redhat.com> <37d87244-fbef-414c-a726-60839b305040@proton.me> <ZoklB7aLyc90kWPT@pollux.localdomain>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3947ba9fb484c06126e658095a623c4bee782b03
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.07.24 13:05, Danilo Krummrich wrote:
> On Sat, Jul 06, 2024 at 10:33:49AM +0000, Benno Lossin wrote:
>> On 04.07.24 19:06, Danilo Krummrich wrote:
>>> +pub unsafe trait Allocator {
>>> +    /// Allocate memory based on `layout` and `flags`.
>>> +    ///
>>> +    /// On success, returns a buffer represented as `NonNull<[u8]>` th=
at satisfies the size an
>>
>> typo "an" -> "and"
>>
>>> +    /// alignment requirements of layout, but may exceed the requested=
 size.
>>
>> Also if it may exceed the size, then I wouldn't call that "satisfies the
>> size [...] requirements".
>=20
> Do you have a better proposal? To me "satisfies or exceeds" sounds reason=
able.

I think "satisfies the layout constraints (i.e. minimum size and
alignment as specified by `layout`)" would be better.

>>> +    ///
>>> +    /// This function is equivalent to `realloc` when called with a NU=
LL pointer and an `old_size`
>>> +    /// of `0`.
>>
>> This is only true for the default implementation and could be
>> overridden, since it is not a requirement of implementing this trait to
>> keep it this way. I would remove this sentence.
>=20
> I could add a bit more generic description and say that for the default i=
mpl
> "This function is eq..."?
>=20
>>
>>> +    fn alloc(&self, layout: Layout, flags: Flags) -> Result<NonNull<[u=
8]>, AllocError> {
>>
>> Instead of using the `Flags` type from the alloc module, we should have
>> an associated `Flags` type in this trait.
>=20
> What does this give us?

1. IIRC not all flags can be used with every allocator (or do not have
   an effect) and it would be best if only the working ones are allowed.
2. that way the design is more flexible and could be upstreamed more
   easily.

>> Similarly, it might also be a good idea to let the implementer specify a
>> custom error type.
>=20
> Same here, why?

In this case the argument is weaker, but it could allow us to implement
an allocator with `Error =3D Infallible`, to statically guarantee
allocation (e.g. when using GFP_ATOMIC). But at the moment there is no
user.

>>> +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it'=
s safety requirements and asks
>>> +        // for a new memory allocation.
>>> +        unsafe { self.realloc(ptr::null_mut(), 0, layout, flags) }
>>> +    }
>>> +
>>> +    /// Re-allocate an existing memory allocation to satisfy the reque=
sted `layout`. If the
>>> +    /// requested size is zero, `realloc` behaves equivalent to `free`=
.
>>
>> This is not guaranteed by the implementation.
>=20
> Not sure what exactly you mean? Is it about "satisfy" again?

If the requested size is zero, the implementation could also leak the
memory, nothing prevents me from implementing such an Allocator.

>>> +    ///
>>> +    /// If the requested size is larger than `old_size`, a successful =
call to `realloc` guarantees
>>> +    /// that the new or grown buffer has at least `Layout::size` bytes=
, but may also be larger.
>>> +    ///
>>> +    /// If the requested size is smaller than `old_size`, `realloc` ma=
y or may not shrink the
>>> +    /// buffer; this is implementation specific to the allocator.
>>> +    ///
>>> +    /// On allocation failure, the existing buffer, if any, remains va=
lid.
>>> +    ///
>>> +    /// The buffer is represented as `NonNull<[u8]>`.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `ptr` must point to an existing and valid memory allocation cr=
eated by this allocator
>>> +    /// instance of a size of at least `old_size`.
>>> +    ///
>>> +    /// Additionally, `ptr` is allowed to be a NULL pointer; in this c=
ase a new memory allocation is
>>> +    /// created.
>>> +    unsafe fn realloc(
>>> +        &self,
>>> +        ptr: *mut u8,
>>> +        old_size: usize,
>>
>> Why not request the old layout like the std Allocator's grow/shrink
>> functions do?
>=20
> Because we only care about the size that needs to be preserved when growi=
ng the
> buffer. The `alignment` field of `Layout` would be wasted.

In the std Allocator they specified an old layout. This is probably
because of the following: if `Layout` is ever extended to hold another
property that would need to be updated, the signatures are already
correct.
In our case we could change it tree-wide, so I guess we could fix that
issue when it comes up.

>>> +        layout: Layout,
>>> +        flags: Flags,
>>> +    ) -> Result<NonNull<[u8]>, AllocError>;
>>> +
>>> +    /// Free an existing memory allocation.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `ptr` must point to an existing and valid memory allocation cr=
eated by this `Allocator`
>>> +    /// instance.
>>> +    unsafe fn free(&self, ptr: *mut u8) {
>>
>> `ptr` should be `NonNull<u8>`.
>=20
> Creating a `NonNull` from a raw pointer is an extra operation for any use=
r of
> `free` and given that all `free` functions in the kernel accept a NULL po=
inter,
> I think there is not much value in making this `NonNull`.

I don't think that this argument holds for Rust though. For example,
`KBox` contains a `Unique` that contains a `NonNull`, so freeing could
just be done with `free(self.0.0)`.

>>> +        // SAFETY: `ptr` is guaranteed to be previously allocated with=
 this `Allocator` or NULL.
>>> +        // Calling `realloc` with a buffer size of zero, frees the buf=
fer `ptr` points to.
>>> +        let _ =3D unsafe { self.realloc(ptr, 0, Layout::new::<()>(), F=
lags(0)) };
>>
>> Why does the implementer have to guarantee this?
>=20
> Who else can guarantee this?

Only the implementer yes. But they are not forced to do this i.e.
nothing in the safety requirements of `Allocator` prevents me from doing
a no-op on reallocating to a zero size.

>>> +    }
>>> +}
>>> --
>>> 2.45.2
>>>
>>
>> More general questions:
>> - are there functions in the kernel to efficiently allocate zeroed
>>   memory? In that case, the Allocator trait should also have methods
>>   that do that (with a iterating default impl).
>=20
> We do this with GFP flags. In particular, you can pass GFP_ZERO to `alloc=
` and
> `realloc` to get zeroed memory. Hence, I think having dedicated functions=
 that
> just do "flags | GFP_ZERO" would not add much value.

Ah right, no in that case, we don't need it.

>> - I am not sure putting everything into the single realloc function is a
>>   good idea, I like the grow/shrink methods of the std allocator. Is
>>   there a reason aside from concentrating the impl to go for only a
>>   single realloc function?
>=20
> Yes, `krealloc()` already provides exactly the described behaviour. See t=
he
> implementation of `Kmalloc`.

But `kvmalloc` does not and neither does `vmalloc`. I would prefer
multiple smaller functions over one big one in this case.

---
Cheers,
Benno


