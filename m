Return-Path: <linux-kernel+bounces-244021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759E1929E15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E573F1F21E75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD73BBDE;
	Mon,  8 Jul 2024 08:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Uy8IWMaf"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9531864C;
	Mon,  8 Jul 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426371; cv=none; b=HDdlBsTYSAbM392Y/SNH/M3+0l5NnKCd/lkhbP2S72uCXZDghD5iLTEhpRlB2qU82ueymuRj4sm7dx8brwXKKc5U2zcWr2h4VM0cMkjOuQfB9oe7kZ19Qpcx/2hbgx/xXGlGC1PrDeR/VsCB5iBrmobsLtvH+MEz+nfPxfoYPOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426371; c=relaxed/simple;
	bh=XQe62ZyTOEoRiduvusCL/q8/fQjihKu6X4uLszViecE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Esgz1st4lcchpiL9fdVrgkTsnovFACN/Z8me/uNaaCYU0u1DvWGPxLeCH1VxeRQexTWzTNjcZLjN5bcUMbDnpdr2EkuUDuF8/C7BjMytzMMUYHRSw7teS34NfTLkVDFlPafM70Wxbo4hjaGUg/RI529gNLb8xzVs2D/x5I2UYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Uy8IWMaf; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1720426361; x=1720685561;
	bh=L+zTwXfvHIAolDRxRlsyaU2fxyf/8YP3cmYvff3qA98=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Uy8IWMaf14rIx+VTvzaKEKtxmFg/nEAqPAF5x3ASxk862EiUP+U9z6U4/Dxt+5W8T
	 nPqwb4RgmXTa652gXd86/lmot5AD3maRbj4QMGN0F1OW2CSEKRjCfoWkkGyfX5FZgZ
	 mP+LczrxDnIEqtvW60zUB80+M7MeDNF1AwseC1pSZ+FWDdpte7LpKpiaP+yR+iuHpE
	 nZ4WSH6K/6PG7yuCuNOMaFXDBwopJ4aoff/M8qJ1eIYmUxdqGgnt3JXaZ/5T6vksEa
	 XWP/vuaUXhcn63bUufn/kohCQIMMYeBfkkdKRBp+jkQrA4V2r3lySxux4aYWS1Egkr
	 HifaRM1WXqJrQ==
Date: Mon, 08 Jul 2024 08:12:34 +0000
To: Danilo Krummrich <dakr@redhat.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 01/20] rust: alloc: add `Allocator` trait
Message-ID: <5197ac37-ab92-4d99-a2e1-82d1cd9dc7e7@proton.me>
In-Reply-To: <ZomRT_PQHVMVQ_RY@cassiopeiae>
References: <20240704170738.3621-1-dakr@redhat.com> <20240704170738.3621-2-dakr@redhat.com> <37d87244-fbef-414c-a726-60839b305040@proton.me> <ZoklB7aLyc90kWPT@pollux.localdomain> <2c322b00-20f8-4102-9f3b-edab0c0907b9@proton.me> <ZolerSMkVl0C4yfF@pollux.localdomain> <50cec075-04f4-4267-8d19-1b498a9f51bf@proton.me> <ZomRT_PQHVMVQ_RY@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 970b5d08fd1eca9213c31b16e372ed5847539a46
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.07.24 20:47, Danilo Krummrich wrote:
> On Sat, Jul 06, 2024 at 05:08:26PM +0000, Benno Lossin wrote:
>> On 06.07.24 17:11, Danilo Krummrich wrote:
>>> On Sat, Jul 06, 2024 at 01:17:19PM +0000, Benno Lossin wrote:
>>>> On 06.07.24 13:05, Danilo Krummrich wrote:
>>>>>>> +        layout: Layout,
>>>>>>> +        flags: Flags,
>>>>>>> +    ) -> Result<NonNull<[u8]>, AllocError>;
>>>>>>> +
>>>>>>> +    /// Free an existing memory allocation.
>>>>>>> +    ///
>>>>>>> +    /// # Safety
>>>>>>> +    ///
>>>>>>> +    /// `ptr` must point to an existing and valid memory allocatio=
n created by this `Allocator`
>>>>>>> +    /// instance.
>>>>>>> +    unsafe fn free(&self, ptr: *mut u8) {
>>>>>>
>>>>>> `ptr` should be `NonNull<u8>`.
>>>>>
>>>>> Creating a `NonNull` from a raw pointer is an extra operation for any=
 user of
>>>>> `free` and given that all `free` functions in the kernel accept a NUL=
L pointer,
>>>>> I think there is not much value in making this `NonNull`.
>>>>
>>>> I don't think that this argument holds for Rust though. For example,
>>>> `KBox` contains a `Unique` that contains a `NonNull`, so freeing could
>>>> just be done with `free(self.0.0)`.
>>>
>>> Agreed, we can indeed make it a `&NonNull<u8>`. However, I find this a =
bit
>>
>> I think you mean `NonNull<u8>`, right?
>=20
> Yes, but I still don't see how that improves things, e.g. in `Drop` of
> `KVec`:
>=20
> `A::free(self.ptr.to_non_null().cast())`
>=20
> vs.
>=20
> `A::free(self.as_mut_ptr().cast())`
>=20
> I'm not against this change, but I don't see how this makes things better=
.

Ah you still need to convert the `Unique<T>` to a pointer...
But we could have a trait that allows that conversion. Additionally, we
could get rid of the cast if we made the function generic.

>>> inconsistent with the signature of `realloc`.
>>>
>>> Should we go with separate `shrink` / `grow`, `free` could be implement=
ed as
>>> shrinking to zero and allowing a NULL pointer makes not much sense.
>>>
>>> But as mentioned, I'm not yet seeing the benefit of having `realloc` sp=
lit into
>>> `grow` and `shrink`.
>>
>> I would not split it into grow/shrink. I am not sure what exactly would
>> be best here, but here is what I am trying to achieve:
>> - people should strongly prefer alloc/free over realloc,
>=20
> I agree; the functions for that are there: `Allocator::alloc` and
> `Allocator::free`.
>=20
> `KBox` uses both of them, `KVec` instead, for obvious reasons, uses
> `Allocator::realloc` directly to grow from zero and `Allocator::free`.
>=20
>> - calling realloc with zero size should not signify freeing the memory,
>>   but rather resizing the allocation to 0. E.g. because a buffer now
>>   decides to hold zero elements (in this case, the size should be a
>>   variable that just happens to be zero).
>=20
> If a buffer is forced to a new size of zero, isn't that effectively a fre=
e?

I would argue that they are different, since you get a pointer back that
points to an allocation of zero size. A vector of size zero still keeps
around a (dangling) pointer.
You also can free a zero sized allocation (it's a no-op), but you must
not free an allocation twice.

> At least that's exactly what the kernel does, if we ask krealloc() to res=
ize to
> zero it will free the memory and return ZERO_SIZE_PTR.

Not every allocator behaves like krealloc, in your patch, both vmalloc
and kvmalloc are implemented with `if`s to check for the various special
cases.

> So, what exactly would you want `realloc` to do when a size of zero is pa=
ssed
> in?

I don't want to change the behavior, I want to prevent people from using
it unnecessarily.

>> - calling realloc with a null pointer should not be necessary, since
>>   `alloc` exists.
>=20
> But `alloc` calls `realloc` with a NULL pointer to allocate new memory.
>=20
> Let's take `Kmalloc` as example, surely I could implement `alloc` by call=
ing
> into kmalloc() instead. But then we'd have to implement `alloc` for all
> allocators, instead of having a generic `alloc`.

My intuition is telling me that I don't like that you can pass null to
realloc. I can't put my finger on exactly why that is, maybe because
there isn't actually any argument here or maybe there is. I'd like to
hear other people's opinion.

> And I wonder what's the point given that `realloc` with a NULL pointer al=
ready
> does this naturally? Besides that, it comes in handy when we want to allo=
cate
> memory for data structures that grow from zero, such as `KVec`.

You can just `alloc` with size zero and then call `realloc` with the
pointer that you got. I don't see how this would be a problem.

>> This is to improve readability of code, or do you find
>>
>>     realloc(ptr, 0, Layout::new::<()>(), Flags(0))
>>
>> more readable than
>>
>>     free(ptr)
>=20
> No, but that's not what users of allocators would do. They'd just call `f=
ree`,
> as I do in `KBox` and `KVec`.

I agree that we have to free the memory when supplying a zero size, but
I don't like adding additional features to `realloc`.

Conceptually, I see an allocator like this:

    pub trait Allocator {
        type Flags;
        type Allocation;
        type Error;
   =20
        fn alloc(layout: Layout, flags: Self::Flags) -> Result<Self::Alloca=
tion, Self::Error>;
   =20
        fn realloc(
            alloc: Self::Allocation,
            old: Layout,
            new: Layout,
            flags: Self::Flags,
        ) -> Result<Self::Allocation, (Self::Allocation, Self::Error)>;
   =20
        fn free(alloc: Self::Allocation);
    }

I.e. to reallocate something, you first have to have something
allocated.

For some reason if we use `Option<NonNull<u8>>` instead of `*mut u8`, I
have a better feeling, but that might be worse for ergonomics...

---
Cheers,
Benno


