Return-Path: <linux-kernel+bounces-308966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10185966466
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB091C23B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED41B3B1A;
	Fri, 30 Aug 2024 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GMgTiV+F"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D11B3B02;
	Fri, 30 Aug 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029144; cv=none; b=NnlpkdDHg6JcWrGjf8jLrMRa+RUrRaNt+vrjHlQhW9rWpJTH1po/ubD4664g+56TO48tygqbPY1/9Ex9gqDsU5HuKiQgdea9GoqQw0/ztNRrCmy3+5ThaQ7n7uSjtQskkNbBIlxVYiLlUJKgqnjh968EoR5PIJqNnzHrZ4xbDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029144; c=relaxed/simple;
	bh=km8oswvcmy7Ce+qJYMjwpSQS4fRtIG7BVd+0xRhZeDc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ktgvvjtg9rCBfWmqol3JZbmFfC91On9m3zDQNtvQLrVOuFVVPlJGuayzhpJxPvm23fEjeb1Ye6oqhGBsyH+6zRLozy+Yy6GNTggOkJgYzQxaz3SG1FWPtz0iBZPwQETevMeF1qWYYkOa6i29+ROiPp8OWslriB8qe+nMXbvxfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GMgTiV+F; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=5q2up3ofgncadkny3wyoyno2ja.protonmail; t=1725029140; x=1725288340;
	bh=lDrgNLurCO2zu020kbYPhmcx626n1iMltAE+xBnSpfE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GMgTiV+FOG0Km/cJUhTiV0DqC1197TvKWvKc7FDVOHniAx/iq0LYHZiGr3f7L4Btz
	 YvzY5NPpVbYE30Dmx0/TNjX5ZaHlVpy1xnwFK6FXI69v/uBIemWFTcqErUsDsm3DxP
	 i8w/PsVOjlfkyOgVSTUu4ZnTWeLtXOfcWJTP6eNaichSMYH+EovB4ajeVhg0hkRcTY
	 6xkqnkFAT2ELckpuoYpv0mOIpCrRONC3nZkMmA9MZ5GoOowF0sK0zADaMWf0iHwrBZ
	 zB8ZwRkwFNCV2UzbrYH9rmdH2jrRL7EcOai/Kr8uEmDP15fSrB9RnOTKi5ZWRIMmZD
	 hiWsuuVMfQGng==
Date: Fri, 30 Aug 2024 14:45:35 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <962b7014-4f8b-4abe-8774-636b612a051c@proton.me>
In-Reply-To: <ZtDwduKjIEZ3RQtk@pollux.localdomain>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-5-dakr@kernel.org> <2dd02834-b2b6-4ff6-9e29-43c9d77b69e2@proton.me> <ZtDwduKjIEZ3RQtk@pollux.localdomain>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a53d2602eff2a73467727cc4929fbe17bc517745
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.08.24 00:04, Danilo Krummrich wrote:
> On Thu, Aug 29, 2024 at 06:32:42PM +0000, Benno Lossin wrote:
>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>> Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
>>> typically used for objects smaller than page size.
>>>
>>> All memory allocations made with `Kmalloc` end up in `krealloc()`.
>>>
>>> It serves as allocator for the subsequently introduced types `KBox` and
>>> `KVec`.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>>>  rust/kernel/alloc.rs           |  2 +-
>>>  rust/kernel/alloc/allocator.rs | 72 +++++++++++++++++++++++++++++++++-
>>>  2 files changed, 72 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
>>> index 9932f21b0539..477dbe3c5a2f 100644
>>> --- a/rust/kernel/alloc.rs
>>> +++ b/rust/kernel/alloc.rs
>>> @@ -4,7 +4,7 @@
>>>
>>>  #[cfg(not(test))]
>>>  #[cfg(not(testlib))]
>>> -mod allocator;
>>> +pub mod allocator;
>>>  pub mod box_ext;
>>>  pub mod vec_ext;
>>>
>>> diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocat=
or.rs
>>> index e32182f91167..78e7d5488843 100644
>>> --- a/rust/kernel/alloc/allocator.rs
>>> +++ b/rust/kernel/alloc/allocator.rs
>>> @@ -1,12 +1,28 @@
>>>  // SPDX-License-Identifier: GPL-2.0
>>>
>>>  //! Allocator support.
>>> +//!
>>> +//! Documentation for the kernel's memory allocators can found in the =
"Memory Allocation Guide"
>>> +//! linked below. For instance, this includes the concept of "get free=
 page" (GFP) flags and the
>>> +//! typical application of the different kernel allocators.
>>> +//!
>>> +//! Reference: <https://docs.kernel.org/core-api/memory-allocation.htm=
l>
>>
>> Thanks, this nice.
>>
>>>
>>>  use super::{flags::*, Flags};
>>>  use core::alloc::{GlobalAlloc, Layout};
>>>  use core::ptr;
>>> +use core::ptr::NonNull;
>>>
>>> -struct Kmalloc;
>>> +use crate::alloc::{AllocError, Allocator};
>>> +use crate::bindings;
>>> +
>>> +/// The contiguous kernel allocator.
>>> +///
>>> +/// `Kmalloc` is typically used for physically contiguous allocations =
up to page size, but also
>>> +/// supports larger allocations up to `bindings::KMALLOC_MAX_SIZE`, wh=
ich is hardware specific.
>>
>> Does putting a link here work? (I guess we don't yet export the bindings
>> documentation, so it will probably fail... When we decide to enable it,
>> we should create an issue to add missing links)
>>
>>> +///
>>> +/// For more details see [self].
>>> +pub struct Kmalloc;
>>>
>>>  /// Returns a proper size to alloc a new object aligned to `new_layout=
`'s alignment.
>>>  fn aligned_size(new_layout: Layout) -> usize {
>>> @@ -36,6 +52,60 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, =
new_layout: Layout, flags: F
>>>      unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size,=
 flags.0) as *mut u8 }
>>>  }
>>>
>>> +/// # Invariants
>>> +///
>>> +/// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
>>> +struct ReallocFunc(
>>> +    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut=
 core::ffi::c_void,
>>> +);
>>> +
>>> +impl ReallocFunc {
>>> +    // INVARIANT: `krealloc` satisfies the type invariants.
>>> +    const KREALLOC: Self =3D Self(bindings::krealloc);
>>> +
>>> +    /// # Safety
>>> +    ///
>>> +    /// This method has the same safety requirements as [`Allocator::r=
ealloc`].
>>> +    unsafe fn call(
>>> +        &self,
>>> +        ptr: Option<NonNull<u8>>,
>>> +        layout: Layout,
>>> +        flags: Flags,
>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>> +        let size =3D aligned_size(layout);
>>> +        let ptr =3D match ptr {
>>> +            Some(ptr) =3D> ptr.as_ptr(),
>>> +            None =3D> ptr::null(),
>>> +        };
>>> +
>>> +        // SAFETY: `ptr` is either NULL or valid by the safety require=
ments of this function.
>>
>> You need some justification as to why calling the three allowed
>> functions here.
>=20
> What kind of justification do I need? Can you please share some more deta=
ils on
> what you think is missing here?

So, you are calling a function pointer to an `unsafe` function. This
means that through some invariant you have to know what the safety
requirements are (otherwise how can you guarantee that this is OK?). You
have the invariant that the pointer points at one of the three functions
mentioned above. What are the safety requirements of those functions? I
would assume that the only one is that `ptr` is valid. So you can use:

    // SAFETY:
    // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` and thus on=
ly requires that `ptr` is
    //   NULL or valid.
    // - `ptr` is either NULL or valid by the safety requirements of this f=
unction.

>>> +        let raw_ptr =3D unsafe {
>>> +            // If `size =3D=3D 0` and `ptr !=3D NULL` the memory behin=
d the pointer is freed.
>>> +            self.0(ptr.cast(), size, flags.0).cast()
>>> +        };
>>> +
>>> +        let ptr =3D if size =3D=3D 0 {
>>> +            NonNull::dangling()
>>> +        } else {
>>> +            NonNull::new(raw_ptr).ok_or(AllocError)?
>>> +        };
>>> +
>>> +        Ok(NonNull::slice_from_raw_parts(ptr, size))
>>> +    }
>>> +}
>>> +
>>> +unsafe impl Allocator for Kmalloc {
>>
>> Missing SAFETY comment.
>=20
> Yeah, I think we came across this in an earlier version of the series. I =
asked
> you about the content and usefulness of a comment here, since I'd just en=
d up
> re-iterating what the `Allocator` trait documentation says.
>=20
> IIRC, you replied that you want to think of something that'd make sense t=
o add
> here.

Oh yeah, sorry I forgot about that.
=20
> What do you think should be written here?

I think the best way to do it, would be to push this question down into
`ReallocFunc::call`. So we would put this on the trait:

    // SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees=
 that
    // - memory remains valid until it is explicitly freed,
    // - passing a pointer to a vaild memory allocation is OK,
    // - `realloc` satisfies the guarantees, since `ReallocFunc::call` has =
the same.

We then need to put this on `ReallocFunc::call`:

    /// # Guarantees
    ///
    /// This method has the same guarantees as `Allocator::realloc`. Additi=
onally
    /// - it accepts any pointer to a valid memory allocation allocated by =
this function.
    /// - memory allocated by this function remains valid until it is passe=
d to this function.

Finally, we need a `GUARANTEE` comment (just above the return [^1]
value) that establishes these guarantees:

    // GUARANTEE: Since we called `self.0` with `size` above and by the typ=
e invariants of `Self`,
    // `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`. Those functi=
ons provide the guarantees of
    // this function.

I am not really happy with the last sentence, but I also don't think
that there is value in listing out all the guarantees, only to then say
"all of this is guaranteed by us calling one of these three functions.


[^1]: I am not sure that there is the right place. If you have any
      suggestions, feel free to share them.


>>> +    #[inline]
>>> +    unsafe fn realloc(
>>> +        ptr: Option<NonNull<u8>>,
>>> +        layout: Layout,
>>> +        flags: Flags,
>>> +    ) -> Result<NonNull<[u8]>, AllocError> {
>>> +        // SAFETY: `ReallocFunc::call` has the same safety requirement=
s as `Allocator::realloc`.
>>> +        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
>>> +    }
>>> +}

Oh one more thing, I know that you already have a lot of patches in this
series, but could you split this one into two? So the first one should
introduce `ReallocFunc` and the second one add the impl for `Kmalloc`?
I managed to confuse me twice because of that :)=20

---
Cheers,
Benno

>>> +
>>>  unsafe impl GlobalAlloc for Kmalloc {
>>>      unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>>>          // SAFETY: `ptr::null_mut()` is null and `layout` has a non-ze=
ro size by the function safety
>>> --
>>> 2.46.0
>>>
>>


