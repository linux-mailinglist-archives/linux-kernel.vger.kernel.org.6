Return-Path: <linux-kernel+bounces-323130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE9973851
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 15:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCEF1C24595
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECEC192581;
	Tue, 10 Sep 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cX2nj/pu"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3A524B4;
	Tue, 10 Sep 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973905; cv=none; b=SP/5xzVfpW/tlr/74VU4j8RqRrD2chaBEV4MEMlNCReHX1lZ+zBEwboXcQEpvHDDeE9yXRu1uhFUJuX+AA/7yW2QwZTu1gsIhOsNB6CweXfgpPhHLZTk/FuqIIoBBbUa+mrg/99HLZs+S262kgYWQgkpTIz+GSg5MhZ5ZUhIHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973905; c=relaxed/simple;
	bh=eZJMTwDZsZ3u3Vnwo7L3iDJIRTPqmoQL/gw+hqmv7xE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngeWA4XAhUd/RTGf7PcBerX1+dhgG0dwiLbhK76YQbZ/vFvPrDN/Zw/TuD0S01jDr7zxgOCqJbq2V7KX6Vj8bKdgQyP9ldf9KgI702zw/GB9UYJP8njjhR/Jmxz4D991wHQQsrRf/t29No6j8PJUcpGlmbV6O7EQeniLHVHgnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cX2nj/pu; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725973900; x=1726233100;
	bh=mnlXkr0yAHPxzB8SG1XOTQ0pcrTuw/ZPfcKb1TqAiGk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cX2nj/pueP9K15+l0RJYaOfFC64SNnLtLF8Vuxyy/b1Q20lJaMdbyIWkRIXbzNz4l
	 4XI2LwE+sACpZxutYZyo/ZkhFFGjRYANSZeiRE+5ENY+/0CJPGAdotl4husv8SfY5z
	 DLyTRSXE4jdlCK+kvJY8VoIc8GzYfYH3/aH6eXa6mGwZREFEXVYOT3QBtFNv71AfsJ
	 tN9clvoFG37LxJV00IhT7zZ4hrtQ8jbtj1TM3h2/DfsXoveKuUS1sJMadnNG7mWOW6
	 VSFH0rBoTPQgKdgDyTPr/kUGzuXohgmHzynqlI3AKprgW4MQYvjRCSiHINvL4Fmemn
	 rohs+/yThc71Q==
Date: Tue, 10 Sep 2024 13:11:35 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <c1b5a3bf-b11c-4c33-9519-c93649860a9a@proton.me>
In-Reply-To: <Ztb3eOoiHs2rLCoH@pollux>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-5-dakr@kernel.org> <2dd02834-b2b6-4ff6-9e29-43c9d77b69e2@proton.me> <ZtDwduKjIEZ3RQtk@pollux.localdomain> <962b7014-4f8b-4abe-8774-636b612a051c@proton.me> <Ztb3eOoiHs2rLCoH@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: b4bfd8865feffd4b98a695d5f1227dd907e18a2d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.09.24 13:48, Danilo Krummrich wrote:
> On Fri, Aug 30, 2024 at 02:45:35PM +0000, Benno Lossin wrote:
>> On 30.08.24 00:04, Danilo Krummrich wrote:
>>> On Thu, Aug 29, 2024 at 06:32:42PM +0000, Benno Lossin wrote:
>>>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>>>> +///
>>>>> +/// For more details see [self].
>>>>> +pub struct Kmalloc;
>>>>>
>>>>>  /// Returns a proper size to alloc a new object aligned to `new_layo=
ut`'s alignment.
>>>>>  fn aligned_size(new_layout: Layout) -> usize {
>>>>> @@ -36,6 +52,60 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8=
, new_layout: Layout, flags: F
>>>>>      unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, siz=
e, flags.0) as *mut u8 }
>>>>>  }
>>>>>
>>>>> +/// # Invariants
>>>>> +///
>>>>> +/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
>>>>> +struct ReallocFunc(
>>>>> +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *m=
ut core::ffi::c_void,
>>>>> +);
>>>>> +
>>>>> +impl ReallocFunc {
>>>>> +    // INVARIANT: `krealloc` satisfies the type invariants.
>>>>> +    const KREALLOC: Self =3D Self(bindings::krealloc);
>>>>> +
>>>>> +    /// # Safety
>>>>> +    ///
>>>>> +    /// This method has the same safety requirements as [`Allocator:=
:realloc`].
>>>>> +    unsafe fn call(
>>>>> +        &self,
>>>>> +        ptr: Option<NonNull<u8>>,
>>>>> +        layout: Layout,
>>>>> +        flags: Flags,
>>>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>>>> +        let size =3D aligned_size(layout);
>>>>> +        let ptr =3D match ptr {
>>>>> +            Some(ptr) =3D> ptr.as_ptr(),
>>>>> +            None =3D> ptr::null(),
>>>>> +        };
>>>>> +
>>>>> +        // SAFETY: `ptr` is either NULL or valid by the safety requi=
rements of this function.
>>>>
>>>> You need some justification as to why calling the three allowed
>>>> functions here.
>>>
>>> What kind of justification do I need? Can you please share some more de=
tails on
>>> what you think is missing here?
>>
>> So, you are calling a function pointer to an `unsafe` function. This
>> means that through some invariant you have to know what the safety
>> requirements are (otherwise how can you guarantee that this is OK?). You
>> have the invariant that the pointer points at one of the three functions
>> mentioned above. What are the safety requirements of those functions? I
>> would assume that the only one is that `ptr` is valid. So you can use:
>>
>>     // SAFETY:
>>     // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and thus=
 only requires that `ptr` is
>>     //   NULL or valid.
>=20
> I'm fine adding it, but I'd like to understand why you think it's require=
d in
> the safety comment here? Isn't this implicit by being the type invariant?

You are calling a function pointer to an `unsafe` function that takes a
raw pointer. Without this comment it is not clear what the function
pointer's safety requirements are for the raw pointer parameter.

>>     // - `ptr` is either NULL or valid by the safety requirements of thi=
s function.
>=20
> This is the part I already have.

I kept it to ensure that you also keep it.

>>>>> +        let raw_ptr =3D unsafe {
>>>>> +            // If `size =3D=3D 0` and `ptr !=3D NULL` the memory beh=
ind the pointer is freed.
>>>>> +            self.0(ptr.cast(), size, flags.0).cast()
>>>>> +        };
>>>>> +
>>>>> +        let ptr =3D if size =3D=3D 0 {
>>>>> +            NonNull::dangling()
>>>>> +        } else {
>>>>> +            NonNull::new(raw_ptr).ok_or(AllocError)?
>>>>> +        };
>>>>> +
>>>>> +        Ok(NonNull::slice_from_raw_parts(ptr, size))
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +unsafe impl Allocator for Kmalloc {
>>>>
>>>> Missing SAFETY comment.
>>>
>>> Yeah, I think we came across this in an earlier version of the series. =
I asked
>>> you about the content and usefulness of a comment here, since I'd just =
end up
>>> re-iterating what the `Allocator` trait documentation says.
>>>
>>> IIRC, you replied that you want to think of something that'd make sense=
 to add
>>> here.
>>
>> Oh yeah, sorry I forgot about that.
>>
>>> What do you think should be written here?
>>
>> I think the best way to do it, would be to push this question down into
>> `ReallocFunc::call`. So we would put this on the trait:
>>
>>     // SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarant=
ees that
>>     // - memory remains valid until it is explicitly freed,
>>     // - passing a pointer to a vaild memory allocation is OK,
>>     // - `realloc` satisfies the guarantees, since `ReallocFunc::call` h=
as the same.
>=20
> So, we'd also need the same for:
>   - `unsafe impl Allocator for Vmalloc`
>   - `unsafe impl Allocator for KVmalloc`

Yes.

>> We then need to put this on `ReallocFunc::call`:
>>
>>     /// # Guarantees
>>     ///
>>     /// This method has the same guarantees as `Allocator::realloc`. Add=
itionally
>>     /// - it accepts any pointer to a valid memory allocation allocated =
by this function.
>=20
> You propose this, since for `Allocator::realloc` memory allocated with
> `Allocator::alloc` would be fine too I guess.
>=20
> But if e.g. `Kmalloc` wouldn't use the default `Allocator::alloc`, this w=
ould be
> valid too.

So if `Kmalloc` were to implement `alloc` by not calling
`ReallocFun::call`, then we couldn't use this comment. Do you think that
such a change might be required at some point?

> We could instead write something like:
>=20
> "it accepts any pointer to a valid memory allocation allocated with the s=
ame
> kernel allocator."

It would be better, if we can keep it simpler (ie only `realloc` is
implemented).

>>     /// - memory allocated by this function remains valid until it is pa=
ssed to this function.
>=20
> Same here, `Kmalloc` could implement its own `Allocator::free`.
>=20
> Maybe just "...until it is explicitly freed.".

I don't really like that, since by that any other function could be
meant. Do you need to override the `free` function? If not then it would
be better.

> Anyway, I'm fine with both, since non of the kernel allocators uses anyth=
ing
> else than `ReallocFunc::call` to allocate and free memory.
>=20
>>
>> Finally, we need a `GUARANTEE` comment (just above the return [^1]
>> value) that establishes these guarantees:
>>
>>     // GUARANTEE: Since we called `self.0` with `size` above and by the =
type invariants of `Self`,
>>     // `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`. Those fun=
ctions provide the guarantees of
>>     // this function.
>>
>> I am not really happy with the last sentence, but I also don't think
>> that there is value in listing out all the guarantees, only to then say
>> "all of this is guaranteed by us calling one of these three functions.
>>
>>
>> [^1]: I am not sure that there is the right place. If you have any
>>       suggestions, feel free to share them.
>=20
> Either way, I'm fine with this proposal.
>=20
>>
>>
>>>>> +    #[inline]
>>>>> +    unsafe fn realloc(
>>>>> +        ptr: Option<NonNull<u8>>,
>>>>> +        layout: Layout,
>>>>> +        flags: Flags,
>>>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>>>> +        // SAFETY: `ReallocFunc::call` has the same safety requireme=
nts as `Allocator::realloc`.
>>>>> +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
>>>>> +    }
>>>>> +}
>>
>> Oh one more thing, I know that you already have a lot of patches in this
>> series, but could you split this one into two? So the first one should
>> introduce `ReallocFunc` and the second one add the impl for `Kmalloc`?
>> I managed to confuse me twice because of that :)
>=20
> Generally, I'm fine with that, but I'm not sure if I can avoid an interme=
diate
> compiler warning about unused code doing that.

You can just use `#[expect(dead_code)]` for that in the intermediate
patches.

---
Cheers,
Benno


