Return-Path: <linux-kernel+bounces-323798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D040097439F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B391F2896B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4C51A76A2;
	Tue, 10 Sep 2024 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cRjU1mPe"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716EA17C7B1
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725997385; cv=none; b=kdiSM8HLgyrkPO8vT1GB8i7YylkgdV1CpLouE42nfEn0rOFi6lj9kzkF1w2vdqO0CuJiQu3mYCdQNUkkKjTPZuTfxzcgvDDmZ2ez3U5w6Nq/8DSYZwlTdxgGO2iPf5cDn44IgAvBLDxAeG0QzM/VdbN4aw2FCNak+swg8oQ7X+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725997385; c=relaxed/simple;
	bh=gZVB/MuRCS4h6Lo4R860D4eofVdYx9DrfzSc39kyhbQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBJwTkCm5MhAnP9HqNPJCEOkcyemAHkHUfhBdEZ+uSNxjZyAEIId3RYiTXjJNaAPMJMEDMoOphp+HQ+97OWvWGltd3r1P3eu6ZV5rMD2CtkMsfNA6RXsG6kGNfk23DuANPz8KhhCBTO1naS1xM6VxJu/6h9ijOAmSwZp+z/fOC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cRjU1mPe; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725997381; x=1726256581;
	bh=Us6VG5nQDdDxL5urD5Sho4IxwJbjQmA55je3Wx4UKTM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cRjU1mPefQYidYLc2FHqC23tY/cq/DraTfUuUu+j6KF6KRZqrbLJLWzGTCX3br1ZB
	 Tx7zRCuTXovxyh+Z5PmZ6twptgWvVsRFduJwNwLlrQtkC/deZv0gv0udGblD3qBzpl
	 nptWS+Nw2vi6xRLtyMUO86Sdhp1ZQo18EATHtnvZCHkHVz5Tzp6kJXyg0ZyRkqB991
	 GqsbekkADqjESz3RXmB0Z30Z+IR2rSVAAO69bD2K4CkcwBXjvmi3dNEVg51fDgK1DI
	 epDDhS+Xhn/gkWjCX9KEa9HFFcstwk2UHy52E/F0qdefrxQls1GoHIintejdf5wLJq
	 i+1U/7s5LYqJQ==
Date: Tue, 10 Sep 2024 19:42:58 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <92ef0fb2-aa5a-451a-a79c-2d81e562da41@proton.me>
In-Reply-To: <ZuBLmwpwurxFwYG_@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-5-dakr@kernel.org> <2dd02834-b2b6-4ff6-9e29-43c9d77b69e2@proton.me> <ZtDwduKjIEZ3RQtk@pollux.localdomain> <962b7014-4f8b-4abe-8774-636b612a051c@proton.me> <Ztb3eOoiHs2rLCoH@pollux> <c1b5a3bf-b11c-4c33-9519-c93649860a9a@proton.me> <ZuBLmwpwurxFwYG_@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d22009bd5d0f6c20035602ec26b4f558f839fd62
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.09.24 15:37, Danilo Krummrich wrote:
> On Tue, Sep 10, 2024 at 01:11:35PM +0000, Benno Lossin wrote:
>> On 03.09.24 13:48, Danilo Krummrich wrote:
>>> On Fri, Aug 30, 2024 at 02:45:35PM +0000, Benno Lossin wrote:
>>>> On 30.08.24 00:04, Danilo Krummrich wrote:
>>>>> On Thu, Aug 29, 2024 at 06:32:42PM +0000, Benno Lossin wrote:
>>>>>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>>>>>> +///
>>>>>>> +/// For more details see [self].
>>>>>>> +pub struct Kmalloc;
>>>>>>>
>>>>>>>  /// Returns a proper size to alloc a new object aligned to `new_la=
yout`'s alignment.
>>>>>>>  fn aligned_size(new_layout: Layout) -> usize {
>>>>>>> @@ -36,6 +52,60 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut =
u8, new_layout: Layout, flags: F
>>>>>>>      unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, s=
ize, flags.0) as *mut u8 }
>>>>>>>  }
>>>>>>>
>>>>>>> +/// # Invariants
>>>>>>> +///
>>>>>>> +/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
>>>>>>> +struct ReallocFunc(
>>>>>>> +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> =
*mut core::ffi::c_void,
>>>>>>> +);
>>>>>>> +
>>>>>>> +impl ReallocFunc {
>>>>>>> +    // INVARIANT: `krealloc` satisfies the type invariants.
>>>>>>> +    const KREALLOC: Self =3D Self(bindings::krealloc);
>>>>>>> +
>>>>>>> +    /// # Safety
>>>>>>> +    ///
>>>>>>> +    /// This method has the same safety requirements as [`Allocato=
r::realloc`].
>>>>>>> +    unsafe fn call(
>>>>>>> +        &self,
>>>>>>> +        ptr: Option<NonNull<u8>>,
>>>>>>> +        layout: Layout,
>>>>>>> +        flags: Flags,
>>>>>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>>>>>> +        let size =3D aligned_size(layout);
>>>>>>> +        let ptr =3D match ptr {
>>>>>>> +            Some(ptr) =3D> ptr.as_ptr(),
>>>>>>> +            None =3D> ptr::null(),
>>>>>>> +        };
>>>>>>> +
>>>>>>> +        // SAFETY: `ptr` is either NULL or valid by the safety req=
uirements of this function.
>>>>>>
>>>>>> You need some justification as to why calling the three allowed
>>>>>> functions here.
>>>>>
>>>>> What kind of justification do I need? Can you please share some more =
details on
>>>>> what you think is missing here?
>>>>
>>>> So, you are calling a function pointer to an `unsafe` function. This
>>>> means that through some invariant you have to know what the safety
>>>> requirements are (otherwise how can you guarantee that this is OK?). Y=
ou
>>>> have the invariant that the pointer points at one of the three functio=
ns
>>>> mentioned above. What are the safety requirements of those functions? =
I
>>>> would assume that the only one is that `ptr` is valid. So you can use:
>>>>
>>>>     // SAFETY:
>>>>     // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and th=
us only requires that `ptr` is
>>>>     //   NULL or valid.
>>>
>>> I'm fine adding it, but I'd like to understand why you think it's requi=
red in
>>> the safety comment here? Isn't this implicit by being the type invarian=
t?
>>
>> You are calling a function pointer to an `unsafe` function that takes a
>> raw pointer. Without this comment it is not clear what the function
>> pointer's safety requirements are for the raw pointer parameter.
>=20
> That's my point, isn't this implicitly clear by the type invariant? If ne=
eded,
> shouldn't it be:

I would argue that it is not implicitly clear, since to the reader of
just that unsafe block it's totally unclear that `self.0` has such an
invariant. They would have to read the type definition.

> // INVARIANT:
> // - `self.0` is one of [...]
> //
> // SAFETY:
> // - `ptr` is either NULL or [...]
>=20
>>
>>>>     // - `ptr` is either NULL or valid by the safety requirements of t=
his function.
>>>
>>> This is the part I already have.
>>
>> I kept it to ensure that you also keep it.

[...]

>>>>>>> +    #[inline]
>>>>>>> +    unsafe fn realloc(
>>>>>>> +        ptr: Option<NonNull<u8>>,
>>>>>>> +        layout: Layout,
>>>>>>> +        flags: Flags,
>>>>>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>>>>>> +        // SAFETY: `ReallocFunc::call` has the same safety require=
ments as `Allocator::realloc`.
>>>>>>> +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
>>>>>>> +    }
>>>>>>> +}
>>>>
>>>> Oh one more thing, I know that you already have a lot of patches in th=
is
>>>> series, but could you split this one into two? So the first one should
>>>> introduce `ReallocFunc` and the second one add the impl for `Kmalloc`?
>>>> I managed to confuse me twice because of that :)
>>>
>>> Generally, I'm fine with that, but I'm not sure if I can avoid an inter=
mediate
>>> compiler warning about unused code doing that.
>>
>> You can just use `#[expect(dead_code)]` for that in the intermediate
>> patches.
>=20
> I usually try to avoid that, because it can be misleading when bisecting =
things.
>=20
> If the temporarily unused code contains a bug, your bisection doesn't end=
 up at
> this patch, but some other patch that starts using it.

I don't think it's a problem in this case, since the two patches are
directly next to each other and you're not changing existing code, just
splitting up the addition of new code.

---
Cheers,
Benno


