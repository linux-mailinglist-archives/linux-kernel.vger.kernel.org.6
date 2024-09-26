Return-Path: <linux-kernel+bounces-340544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62379874FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482ECB271E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF71292CE;
	Thu, 26 Sep 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eKDJA8Zs"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9511C6B2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359258; cv=none; b=kYv7SNNu91r/Odyz1c32SSV/xbg6Zws0u1iLjeJQVC0s3bgMr9k+lw9SZMKvWnJWFtBtCsE4m9u95QnrAHM8lP4XVtc5iRlTpFPP281gZcx0zApm8fug05H2tE/l5ge2iRHp0biV+l/gSD5bgt4Ehcxx33mn9xxD+zLUFLLsvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359258; c=relaxed/simple;
	bh=qgBaXqfX83aV77/+rHU79HQLVsBXPykW7+xvP58AVYs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YD+FnhHUpep2OwEslz39c2lzsmo+EplEzPcCJVNs+gMc0bEjwCK7ZFoVSbfk4aAXzzitp6BFCfHWELBssOvdcihgPZd8aAvnQj5l2Uf6/7C0leYG7reGAaOMIM7tWjRhwJKFcTem99rJ1If01TDbOUIvJb00nRCLDGp7lRsNLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eKDJA8Zs; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727359254; x=1727618454;
	bh=+WWEUbHKcNY3jXi+az00t/iEtyJ5NJxJuuESqUIiLvI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eKDJA8ZsepSStAinu05nkqg9IxmoQzqO19goRvSM9tAkpt6BivEWMEcIHZc7TSd3Y
	 V0PTL13PuYuNRxYy6eV2HMJmXV/ygh0lB9aGOKyT4iZhIBA+m7nHJHbJa3aM7LSWjK
	 ZKMJLJmA7zZ7H4QisuM1oY5rgLzDIcM741TlsZDDBnte5RewhCDPAhCv3ouwdjP38k
	 GRJkAmn1aVi/MFUpxjuIidFvQ9kw4M9bSTsq5rXFw+h7iYrDcDjYenUMqbxM2CYMw0
	 ghn2MRllwCSHH2d3DmV4lDgBn/iteg9XaZDhQ7K0FkoQeJzTLMv+hNre58R3IphviK
	 3i/8ItehQCiYA==
Date: Thu, 26 Sep 2024 14:00:50 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 04/26] rust: alloc: implement `Allocator` for `Kmalloc`
Message-ID: <cfc4e3e4-6df6-43e2-bd2d-e2928dffe8c3@proton.me>
In-Reply-To: <ZvVgimoQPoL1trmJ@cassiopeiae>
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-5-dakr@kernel.org> <15f42ddd-b011-4136-b2e4-bc266fab25b6@proton.me> <ZvVgimoQPoL1trmJ@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a662ef8837cfaa33d2d32dd6e8dc52cc57197097
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.09.24 15:24, Danilo Krummrich wrote:
> On Thu, Sep 26, 2024 at 01:00:58PM +0000, Benno Lossin wrote:
>> On 12.09.24 00:52, Danilo Krummrich wrote:
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
>>> +    ///
>>> +    /// # Guarantees
>>> +    ///
>>> +    /// This method has the same guarantees as `Allocator::realloc`. A=
dditionally
>>> +    /// - it accepts any pointer to a valid memory allocation allocate=
d by this function.
>>> +    /// - memory allocated by this function remains valid until it is =
passed to this function.
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
>>> +        // SAFETY:
>>> +        // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc` an=
d thus only requires that
>>> +        //   `ptr` is NULL or valid.
>>> +        // - `ptr` is either NULL or valid by the safety requirements =
of this function.
>>> +        //
>>> +        // GUARANTEE:
>>> +        // - `self.0` is one of `krealloc`, `vrealloc`, `kvrealloc`.
>>> +        // - Those functions provide the guarantees of this function.
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
>>
>> I remember asking you to split this into a different commit. I think you
>> argued that it would be better to keep it in the same commit when
>> bisecting. I don't think that applies in this case, are there any other
>> disadvantages?
>=20
> I don't really like the intermediate `#[expect(dead_code)]`, plus it's
> additional work you didn't really give me a motivation for, i.e. you did =
not
> mention what would be the advantage.

The advantage would be that it's easier to review (granted it probably
is a bit late for that). I got confused a couple of times (but that's
probably on me).

> But sure, I will change it for the next version.

Thanks

---
Cheers,
Benno


