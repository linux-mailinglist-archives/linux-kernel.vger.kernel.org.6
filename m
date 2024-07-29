Return-Path: <linux-kernel+bounces-266076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644A793FA62
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87BAD1C222FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836FB15CD64;
	Mon, 29 Jul 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IW/kefeb"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC180038
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269621; cv=none; b=qH/9Bg7MuJXKynO3Kxm5rhTfY6I86PTggDFNBelC5r9YKHgdukdwRqNVeuGfh/l//kxucX3vCXADscy1+a1KHMHuBU0mI+QoeiHfdQEaEBGTdK+iE6SO0ktD+3swVJ6chQGV/dwAj+kboaypHkxN25X3pLjAiyFZw086nQg1msI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269621; c=relaxed/simple;
	bh=znhya54z2ld7dTBBKj0U5bhZH6mAdbGsxk8Xp0+F1NU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hsIlHboq4Sn+i+jr1QEXr2dhQUoDxS78Vi5ls98zBAZKp78zTSXWQq0Klt+7+d5IzDSyRdvjeEV9pmsO6x2XDRwv6WTvUYiOxul3SwfMJYKgZxnkmNuywomGxDxbujZElGNMwOxuKhLSZL1ps+SAQkT4MQfj4aVRNCYaJNDJ2Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IW/kefeb; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722269610; x=1722528810;
	bh=DmiCz9CBV2cOT6+9yNy9Fwokps+X5J3kz+JDsmEjePE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IW/kefebBzp4GDVMAwZ9/upV9CuyhkYG4TTIA/1iqlP7HKj4bU8ymWkHw/KBt8Aip
	 A5GcVOBUXbsqc375EvdE3hAFJAmB7yk4c8KMbvGCZeM+qpHQk5AeKmjyScgqT5HA5D
	 H4LySmnwd/shARqMTpsPWAM3hWwlkrwdOBAOJB+elAu1sq9AZQO1+Kpm6dAL5RtDhl
	 i0pUA4fo38hzoZAsmjuZ/LQxnTFk5KHfrSoZgFRkGl97lmYWNHWIuY2yYdN+s0nwii
	 LCysYb8flnQrvUwTE5RdjHLH9T2SEHXdOmGwixHtYsmQOS2CUcaXK3EyCpYhWJTDr6
	 ijJuSMv70wiKg==
Date: Mon, 29 Jul 2024 16:13:08 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: mm: add abstractions for mm_struct and vm_area_struct
Message-ID: <3ffd4742-7a84-434d-ad0d-962f302b977a@proton.me>
In-Reply-To: <20240727-vma-v2-1-ab3e5927dc3a@google.com>
References: <20240727-vma-v2-1-ab3e5927dc3a@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3803aa190f7afa36c652f96134003f25723ecc16
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.07.24 11:03, Alice Ryhl wrote:
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// Since `mm_users` may be zero, the associated address space may not e=
xist anymore. You must use
> +/// [`mmget_not_zero`] before accessing the address space.
> +///
> +/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destruc=
tor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted.
> +///
> +/// [`mmget_not_zero`]: Mm::mmget_not_zero
> +pub struct Mm {
> +    mm: Opaque<bindings::mm_struct>,
> +}
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// This type is used only when `mm_users` is known to be non-zero at co=
mpile-time. It can be used
> +/// to access the associated address space.
> +///
> +/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. Its =
destructor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted. The value of `mm_users` i=
s non-zero.
> +#[repr(transparent)]
> +pub struct MmWithUser {
> +    mm: Mm,
> +}

I personally wouldn't sort it this way (so struct decls, methods and
then AlwaysRefCounted impl), but I would sort it first by the struct.
I find it helpful to have the `AlwaysRefCounted` impl close to the
struct declaration (similarly for `Drop`). But that might just be me.

> +
> +/// Equivalent to `ARef<MmWithUser>` but uses `mmput_async` in destructo=
r.
> +///
> +/// The destructor of this type will never sleep.
> +///
> +/// # Invariants
> +///
> +/// `inner` points to a valid `mm_struct` and the `ARefMmWithUserAsync` =
owns an `mmget` refcount.
> +pub struct ARefMmWithUserAsync {
> +    inner: NonNull<bindings::mm_struct>,

I am confused, why doesn't `mm: MM` work here? I.e. also allow usage of
`ARef<MmWithUserAsync>`.

Another approach might be to have the function on `MmWithUser`:

    fn put_async(this: ARef<Self>)

Or do you need it to be done on drop?

> +}
> +
> +// Make all `Mm` methods available on `MmWithUser`.
> +impl Deref for MmWithUser {
> +    type Target =3D Mm;
> +
> +    #[inline]
> +    fn deref(&self) -> &Mm {
> +        &self.mm
> +    }

Does it really make sense to expose every function? E.g.
`mmget_not_zero` would always succeed, right?

> +}
> +
> +// These methods are safe to call even if `mm_users` is zero.

[...]

> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> new file mode 100644
> index 000000000000..2e97ef1eac58
> --- /dev/null
> +++ b/rust/kernel/mm/virt.rs
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Virtual memory.
> +
> +use crate::{
> +    bindings,
> +    error::{to_result, Result},
> +    page::Page,
> +    types::Opaque,
> +};
> +
> +/// A wrapper for the kernel's `struct vm_area_struct`.
> +///
> +/// It represents an area of virtual memory.
> +#[repr(transparent)]
> +pub struct VmArea {
> +    vma: Opaque<bindings::vm_area_struct>,
> +}
> +
> +impl VmArea {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, =
with shared access. The
> +    /// caller must ensure that using the pointer for immutable operatio=
ns is okay.

Nothing here states that the pointee is not allowed to be changed,
unless you mean that by "shared access" which would not match my
definition.

> +    #[inline]
> +    pub unsafe fn from_raw_vma<'a>(vma: *const bindings::vm_area_struct)=
 -> &'a Self {
> +        // SAFETY: The caller ensures that the pointer is valid.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, =
with exclusive access. The
> +    /// caller must ensure that using the pointer for immutable and muta=
ble operations is okay.
> +    #[inline]
> +    pub unsafe fn from_raw_vma_mut<'a>(vma: *mut bindings::vm_area_struc=
t) -> &'a mut Self {
> +        // SAFETY: The caller ensures that the pointer is valid.
> +        unsafe { &mut *vma.cast() }
> +    }
> +
> +    /// Returns a raw pointer to this area.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::vm_area_struct {
> +        self.vma.get()
> +    }
> +
> +    /// Returns the flags associated with the virtual memory area.
> +    ///
> +    /// The possible flags are a combination of the constants in [`flags=
`].
> +    #[inline]
> +    pub fn flags(&self) -> usize {
> +        // SAFETY: The pointer is valid since self is a reference. The f=
ield is valid for reading
> +        // given a shared reference.

Why is the field not changed from the C side? Is this part readonly?

---
Cheers,
Benno


