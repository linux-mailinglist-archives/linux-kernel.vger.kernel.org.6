Return-Path: <linux-kernel+bounces-268057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23E5941FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391D1B26A81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD2C18C90A;
	Tue, 30 Jul 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hhnXRvYP"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248418990F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364637; cv=none; b=YYMJMGkpG7yw1ayFaqLsLXsW/mGCnLIM5TJcKZcupXHGcz5F2PPdOhP9Tybnm0ICYYpvV6mZMod60cwJuu/PqSnbN/kdNmsK3Jk1MvPwtq/rIgA2rLSvSoXzQkddv2v0fz0OcaQ6vAtg8tY82XOsrObIOaC3zVlg1FwpFcIhY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364637; c=relaxed/simple;
	bh=FWHoaka0YcBdOZsa+TFaE5PxkJUctI/50mek4bbCdv4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Im5lkZvKb7ELhNLuwOSUZs4EQwrPtbzDT0V/poAH9E1MeRDoYijZCAzwvs7Yl8tLlXce2UTkUqvgP2dJhhCVjREPtu1j9vcktgorgYURrfJQBZlM6iZaU1qh6T75WZjo++t/mhAJ2nvTuGt2q/zUQk0HdinIM1sVQ/ZZz1jmuWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hhnXRvYP; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722364632; x=1722623832;
	bh=+vUfzUTV6ECXtEhzuiHcq10NNoZ0aUeyonhn6MPajjM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hhnXRvYPdwDJm0sDMSAlhzBaKPObPYjaqs256POG7Vu+inSDOYGJ5sWjPeoNOgL+z
	 x2hjtSWbC+0gA+DcIkioo4E7fSgIDq/SVcI/Hwe2Tl9CcmISZGK2B3OafQHEJ0NGMK
	 spDZayA36Lay7Qq3MjsxKK9UdOVxfTH1EY0EY/3qjqEozz5d7v4n32LWuEImV931C4
	 +iSOLqdUI+OoR+J3YFRP7sQBlaDAJ7qsU6uit0AoVfai8VCfKP95u1g6qjME5/FPhB
	 Q3biHra3qLPCt5MM7X4ihF0DTq3rwu9h+9+sjdqXoM1zMLvGYaw2npsmIq0yL22yPm
	 Mm5H66ps5ZZ3w==
Date: Tue, 30 Jul 2024 18:37:07 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: mm: add abstractions for mm_struct and vm_area_struct
Message-ID: <87034744-5d9b-4ac6-bc36-a54aa32eafb2@proton.me>
In-Reply-To: <CAH5fLgg1DR2mLDvP6J=+Zp-OJWHfL-hXdZ3HioueXF=rg9yN9w@mail.gmail.com>
References: <20240727-vma-v2-1-ab3e5927dc3a@google.com> <3ffd4742-7a84-434d-ad0d-962f302b977a@proton.me> <CAH5fLgg1DR2mLDvP6J=+Zp-OJWHfL-hXdZ3HioueXF=rg9yN9w@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 0bad8e60e31edf27af4145b663e083c67d2abd79
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.07.24 12:57, Alice Ryhl wrote:
> On Mon, Jul 29, 2024 at 6:13=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> On 27.07.24 11:03, Alice Ryhl wrote:
>>> +/// Equivalent to `ARef<MmWithUser>` but uses `mmput_async` in destruc=
tor.
>>> +///
>>> +/// The destructor of this type will never sleep.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// `inner` points to a valid `mm_struct` and the `ARefMmWithUserAsync=
` owns an `mmget` refcount.
>>> +pub struct ARefMmWithUserAsync {
>>> +    inner: NonNull<bindings::mm_struct>,
>>
>> I am confused, why doesn't `mm: MM` work here? I.e. also allow usage of
>> `ARef<MmWithUserAsync>`.
>=20
> We could do that, but I don't know how much sense it makes. With Mm
> and MmWithUser there's a legitimate distinction between them that
> makes sense regardless of whether it's behind an ARef or &. But with
> the `mmput_async` case, the distinction only makes sense for ARef
> pointers, and &MmWithUser and &MmWithUserAsync would be 100%
> interchangeable.
>=20
> That is to say, this is a property of the pointer, not the pointee. I
> don't think it makes sense semantically to have it be a wrapper around
> MmWithUser.

Hmm, I don't think that is a problem. We have `ARef` for the following
reasons (quoting myself from the ARef pattern thread):
(1) prevents having to implement multiple abstractions for a single C
    object: say there is a `struct foo` that is both used via reference
    counting and by-value on the stack. Without `ARef`, we would have to
    write two abstractions, one for each use-case. With `ARef`, we can
    have one `Foo` that can be wrapped with `ARef` to represent a
    reference-counted object.
(2) `ARef<T>` always represents a reference counted object, so it helps
    with understanding the code. If you read `Foo`, you cannot be sure
    if it is heap or stack allocated.
(3) generalizes common code of reference-counted objects (ie avoiding
    code duplication) and concentration of `unsafe` code.

If you don't use `ARef`, you
- have to implement `Deref`, `Drop`, `From<ARef<_>>` manually,
- have a rather ugly name,
- don't benefit from the three points above.

I don't really see a downside to just using `ARef` in this case.

>> Another approach might be to have the function on `MmWithUser`:
>>
>>     fn put_async(this: ARef<Self>)
>>
>> Or do you need it to be done on drop?
>=20
> This needs to happen in drop so that use of the question mark
> operation doesn't suddenly result in sleep-in-atomic-ctx bugs.
>=20
>>> +}
>>> +
>>> +// Make all `Mm` methods available on `MmWithUser`.
>>> +impl Deref for MmWithUser {
>>> +    type Target =3D Mm;
>>> +
>>> +    #[inline]
>>> +    fn deref(&self) -> &Mm {
>>> +        &self.mm
>>> +    }
>>
>> Does it really make sense to expose every function? E.g.
>> `mmget_not_zero` would always succeed, right?
>=20
> I don't think it's a problem. Right now it exposes mmget_not_zero,
> is_same_mm, and as_raw. The only one where it doesn't make much sense
> is mmget_not_zero, but I don't think it hurts either.
>=20
>>> +}
>>> +
>>> +// These methods are safe to call even if `mm_users` is zero.
>>
>> [...]
>>
>>> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
>>> new file mode 100644
>>> index 000000000000..2e97ef1eac58
>>> --- /dev/null
>>> +++ b/rust/kernel/mm/virt.rs
>>> @@ -0,0 +1,199 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +// Copyright (C) 2024 Google LLC.
>>> +
>>> +//! Virtual memory.
>>> +
>>> +use crate::{
>>> +    bindings,
>>> +    error::{to_result, Result},
>>> +    page::Page,
>>> +    types::Opaque,
>>> +};
>>> +
>>> +/// A wrapper for the kernel's `struct vm_area_struct`.
>>> +///
>>> +/// It represents an area of virtual memory.
>>> +#[repr(transparent)]
>>> +pub struct VmArea {
>>> +    vma: Opaque<bindings::vm_area_struct>,
>>> +}
>>> +
>>> +impl VmArea {
>>> +    /// Access a virtual memory area given a raw pointer.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// Callers must ensure that `vma` is valid for the duration of 'a=
, with shared access. The
>>> +    /// caller must ensure that using the pointer for immutable operat=
ions is okay.
>>
>> Nothing here states that the pointee is not allowed to be changed,
>> unless you mean that by "shared access" which would not match my
>> definition.
>=20
> How about this?
>=20
> Callers must ensure that:
> * `vma` is valid for the duration of 'a.
> * the caller holds the mmap read lock for 'a.
>=20
> And `from_raw_vma_mut` would instead require the caller to hold the
> mmap write lock.

SGTM.

>>> +    #[inline]
>>> +    pub unsafe fn from_raw_vma<'a>(vma: *const bindings::vm_area_struc=
t) -> &'a Self {
>>> +        // SAFETY: The caller ensures that the pointer is valid.
>>> +        unsafe { &*vma.cast() }
>>> +    }
>>> +
>>> +    /// Access a virtual memory area given a raw pointer.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// Callers must ensure that `vma` is valid for the duration of 'a=
, with exclusive access. The
>>> +    /// caller must ensure that using the pointer for immutable and mu=
table operations is okay.
>>> +    #[inline]
>>> +    pub unsafe fn from_raw_vma_mut<'a>(vma: *mut bindings::vm_area_str=
uct) -> &'a mut Self {
>>> +        // SAFETY: The caller ensures that the pointer is valid.
>>> +        unsafe { &mut *vma.cast() }
>>> +    }
>>> +
>>> +    /// Returns a raw pointer to this area.
>>> +    #[inline]
>>> +    pub fn as_ptr(&self) -> *mut bindings::vm_area_struct {
>>> +        self.vma.get()
>>> +    }
>>> +
>>> +    /// Returns the flags associated with the virtual memory area.
>>> +    ///
>>> +    /// The possible flags are a combination of the constants in [`fla=
gs`].
>>> +    #[inline]
>>> +    pub fn flags(&self) -> usize {
>>> +        // SAFETY: The pointer is valid since self is a reference. The=
 field is valid for reading
>>> +        // given a shared reference.
>>
>> Why is the field not changed from the C side? Is this part readonly?
>=20
> Because we hold the mmap read lock. (or the write lock)

Oh, then it would be good to have it be an invariant.

---
Cheers,
Benno


