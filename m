Return-Path: <linux-kernel+bounces-243337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 628E39294D6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C09B282759
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7DC13C3D2;
	Sat,  6 Jul 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="i7wUGTiJ"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905D8C8E1;
	Sat,  6 Jul 2024 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720285718; cv=none; b=lHh6SxsflOWmLXw4dPI4UP14BDn7C3k5BQ3Eqs1KnREsNvYGMjTEMomi4ZeC5Dq8Nz5U7nOFuZe+yxhG99skGgA8WQDb8Ohw0ROQXUjuvs+9jsbCQVIaxYpESlG7+XVd/YJnUs3QRfBdcUHqOAnQPKwEorqL18MdCwdY4i9h5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720285718; c=relaxed/simple;
	bh=YVYwmjJQsFDS+/AJGerBDH2OI18Kty9wvVpIO/WbQb0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iwLZ/ys+eyEz1L6M3LrkOoxWizyjqqg+ydgU6PmPLPE5ZFEU4V1nj8bzkYyngSx0qySvvoKIJ6peMlZbdBMVlqgYRlJ/Vo81i+t2nvfirgJO5Q+8uTO+NrtT99yaqNUg7Q79+GvChMeRQo+fXpdC0spsZX5whUej9VE4Xc5PjBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=i7wUGTiJ; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vbqa6ovzqjfitn4fueqk25whzi.protonmail; t=1720285711; x=1720544911;
	bh=OFZvvFzBv8jODnO/TSNLuq8SNJy61p4LUEc/kevAEok=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=i7wUGTiJNXuCBxeXE6vKjR8x3htton4EKWMFdQz6JympSh9WUWUrVzxSO1c5sRVc/
	 qzqTdkP8qQZ9f09NalaI63UeKpgRwzzTEywYiZXvOGIb35aq220C2lvjEHjB+tczKX
	 4ioumphiLgvyeC+fF1czWIkARdJcf8J/N459PN12XiVQf2Ov0edg5uQePcV/881AAp
	 UcbMpEUhIYN6CkUWsKtMs0DjqiG03ByXQx/6Sol8s5C1yYjmFN53C+bhh9q1XRDLrI
	 bAYjXnSEvYLlZzM3wA7yYMeX1xxtZKyoz8LvfeK4boPG+ae2R5Sueqe5hHxDfNJKaI
	 W6jBOhAEF7blA==
Date: Sat, 06 Jul 2024 17:08:26 +0000
To: Danilo Krummrich <dakr@redhat.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 01/20] rust: alloc: add `Allocator` trait
Message-ID: <50cec075-04f4-4267-8d19-1b498a9f51bf@proton.me>
In-Reply-To: <ZolerSMkVl0C4yfF@pollux.localdomain>
References: <20240704170738.3621-1-dakr@redhat.com> <20240704170738.3621-2-dakr@redhat.com> <37d87244-fbef-414c-a726-60839b305040@proton.me> <ZoklB7aLyc90kWPT@pollux.localdomain> <2c322b00-20f8-4102-9f3b-edab0c0907b9@proton.me> <ZolerSMkVl0C4yfF@pollux.localdomain>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a279f52ef1706d27a0662c0fd8cd9eba6f14da67
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.07.24 17:11, Danilo Krummrich wrote:
> On Sat, Jul 06, 2024 at 01:17:19PM +0000, Benno Lossin wrote:
>> On 06.07.24 13:05, Danilo Krummrich wrote:
>>> On Sat, Jul 06, 2024 at 10:33:49AM +0000, Benno Lossin wrote:
>>>> Similarly, it might also be a good idea to let the implementer specify=
 a
>>>> custom error type.
>>>
>>> Same here, why?
>>
>> In this case the argument is weaker, but it could allow us to implement
>> an allocator with `Error =3D Infallible`, to statically guarantee
>> allocation (e.g. when using GFP_ATOMIC). But at the moment there is no
>> user.
>=20
> GFP_ATOMIC can fail, I guess you mean __GFP_NOFAIL.
>=20
> Not really sure how this would work other than with separate `alloc_nofai=
l` and
> `realloc_nofail` functions?

You could have an Allocator that always enables __GFP_NOFAIL, so the
error type could be Infallible. But this doesn't seem that useful at the
moment, so keep the AllocError as is.

>>>>> +        // SAFETY: Passing a NULL pointer to `realloc` is valid by i=
t's safety requirements and asks
>>>>> +        // for a new memory allocation.
>>>>> +        unsafe { self.realloc(ptr::null_mut(), 0, layout, flags) }
>>>>> +    }
>>>>> +
>>>>> +    /// Re-allocate an existing memory allocation to satisfy the req=
uested `layout`. If the
>>>>> +    /// requested size is zero, `realloc` behaves equivalent to `fre=
e`.
>>>>
>>>> This is not guaranteed by the implementation.
>>>
>>> Not sure what exactly you mean? Is it about "satisfy" again?
>>
>> If the requested size is zero, the implementation could also leak the
>> memory, nothing prevents me from implementing such an Allocator.
>=20
> Well, hopefully the documentation stating that `realloc` must be implemen=
ted
> this exact way prevents you from doing otherwise. :-)
>=20
> Please let me know if I need to document this in a different way if it's =
not
> sufficient as it is.

It should be part of the safety requirements of the Allocator trait.

>>>>> +    ///
>>>>> +    /// If the requested size is larger than `old_size`, a successfu=
l call to `realloc` guarantees
>>>>> +    /// that the new or grown buffer has at least `Layout::size` byt=
es, but may also be larger.
>>>>> +    ///
>>>>> +    /// If the requested size is smaller than `old_size`, `realloc` =
may or may not shrink the
>>>>> +    /// buffer; this is implementation specific to the allocator.
>>>>> +    ///
>>>>> +    /// On allocation failure, the existing buffer, if any, remains =
valid.
>>>>> +    ///
>>>>> +    /// The buffer is represented as `NonNull<[u8]>`.
>>>>> +    ///
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// `ptr` must point to an existing and valid memory allocation =
created by this allocator
>>>>> +    /// instance of a size of at least `old_size`.
>>>>> +    ///
>>>>> +    /// Additionally, `ptr` is allowed to be a NULL pointer; in this=
 case a new memory allocation is
>>>>> +    /// created.
>>>>> +    unsafe fn realloc(
>>>>> +        &self,
>>>>> +        ptr: *mut u8,
>>>>> +        old_size: usize,
>>>>
>>>> Why not request the old layout like the std Allocator's grow/shrink
>>>> functions do?
>>>
>>> Because we only care about the size that needs to be preserved when gro=
wing the
>>> buffer. The `alignment` field of `Layout` would be wasted.
>>
>> In the std Allocator they specified an old layout. This is probably
>> because of the following: if `Layout` is ever extended to hold another
>> property that would need to be updated, the signatures are already
>> correct.
>> In our case we could change it tree-wide, so I guess we could fix that
>> issue when it comes up.
>=20
> Yes, I think so too.
>=20
>>
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
>>>>> +    unsafe fn free(&self, ptr: *mut u8) {
>>>>
>>>> `ptr` should be `NonNull<u8>`.
>>>
>>> Creating a `NonNull` from a raw pointer is an extra operation for any u=
ser of
>>> `free` and given that all `free` functions in the kernel accept a NULL =
pointer,
>>> I think there is not much value in making this `NonNull`.
>>
>> I don't think that this argument holds for Rust though. For example,
>> `KBox` contains a `Unique` that contains a `NonNull`, so freeing could
>> just be done with `free(self.0.0)`.
>=20
> Agreed, we can indeed make it a `&NonNull<u8>`. However, I find this a bi=
t

I think you mean `NonNull<u8>`, right?

> inconsistent with the signature of `realloc`.
>=20
> Should we go with separate `shrink` / `grow`, `free` could be implemented=
 as
> shrinking to zero and allowing a NULL pointer makes not much sense.
>=20
> But as mentioned, I'm not yet seeing the benefit of having `realloc` spli=
t into
> `grow` and `shrink`.

I would not split it into grow/shrink. I am not sure what exactly would
be best here, but here is what I am trying to achieve:
- people should strongly prefer alloc/free over realloc,
- calling realloc with zero size should not signify freeing the memory,
  but rather resizing the allocation to 0. E.g. because a buffer now
  decides to hold zero elements (in this case, the size should be a
  variable that just happens to be zero).
- calling realloc with a null pointer should not be necessary, since
  `alloc` exists.

This is to improve readability of code, or do you find

    realloc(ptr, 0, Layout::new::<()>(), Flags(0))

more readable than
   =20
    free(ptr)

>>>>> +        // SAFETY: `ptr` is guaranteed to be previously allocated wi=
th this `Allocator` or NULL.
>>>>> +        // Calling `realloc` with a buffer size of zero, frees the b=
uffer `ptr` points to.
>>>>> +        let _ =3D unsafe { self.realloc(ptr, 0, Layout::new::<()>(),=
 Flags(0)) };
>>>>
>>>> Why does the implementer have to guarantee this?
>>>
>>> Who else can guarantee this?
>>
>> Only the implementer yes. But they are not forced to do this i.e.
>> nothing in the safety requirements of `Allocator` prevents me from doing
>> a no-op on reallocating to a zero size.
>=20
> Ah, I see now, this is the same as your comment on the documentation of
> `realloc`. So, this indeed just about missing a safety comment.
>=20
>>
>>>>> +    }
>>>>> +}
>>>>> --
>>>>> 2.45.2
>>>>>
>>>>
>>>> More general questions:
>>>> - are there functions in the kernel to efficiently allocate zeroed
>>>>   memory? In that case, the Allocator trait should also have methods
>>>>   that do that (with a iterating default impl).
>>>
>>> We do this with GFP flags. In particular, you can pass GFP_ZERO to `all=
oc` and
>>> `realloc` to get zeroed memory. Hence, I think having dedicated functio=
ns that
>>> just do "flags | GFP_ZERO" would not add much value.
>>
>> Ah right, no in that case, we don't need it.
>>
>>>> - I am not sure putting everything into the single realloc function is=
 a
>>>>   good idea, I like the grow/shrink methods of the std allocator. Is
>>>>   there a reason aside from concentrating the impl to go for only a
>>>>   single realloc function?
>>>
>>> Yes, `krealloc()` already provides exactly the described behaviour. See=
 the
>>> implementation of `Kmalloc`.
>>
>> But `kvmalloc` does not and neither does `vmalloc`. I would prefer
>> multiple smaller functions over one big one in this case.
>=20
> What I forsee is that:
>=20
>   - `alloc` becomes a `grow` from zero.
>   - `free` becomes a `shrink` to zero.
>   - `grow` and `shrink` become a `realloc` alias,
>      because they're almost the same
>=20
> Wouldn't this just put us were we already are, effectively?

We could have a NonNull parameter for realloc and discourage calling
realloc for freeing.

---
Cheers,
Benno


