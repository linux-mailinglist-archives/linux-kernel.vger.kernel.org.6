Return-Path: <linux-kernel+bounces-271392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44889944D91
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671F21C22BBE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DBE1A4870;
	Thu,  1 Aug 2024 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="B6EY1Z51"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB414A601
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520932; cv=none; b=WppjWypnNtAAeRPkIGdyHWrw1YKL1hfWrlyjm4eRza1UE6fYKac9iynzV3Bky4CbHfRPG6U8hfEZHyT1MP/dcIh67wGa+zmJyzqxHeGzWpSZT1tw/DrLMEER7/jGo+X0eFjgcrjusaC3K+JELqMjvCxt3ejjVIORPh1R6g+arW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520932; c=relaxed/simple;
	bh=3rDFTnKrFTVelFXBWY8Fla6t5KNytE4LmE+lo4BsHZE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cn2rsmFqGJmymS2wKjLNGjHqeisrTP/uLAwzpta2+vuHPrd/Oa4ssp9IuSeyS+DxKnvUSrOc/uZ/2SyQXrQC3T4oUP6o/B4NkFP3y2wE62xU7kjO9ThnLMm8D6fPQgsrir8vxtg0nG9sptBKPO29i/7LbOku6T0lZgfaM0X+fIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=B6EY1Z51; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722520924; x=1722780124;
	bh=sr4WeHf3fgnQqbWXVbnaeKVIjMkwrY2mcG/IiWbhHvk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B6EY1Z514XkP1xCh7HFWOPDR6AIbBoD9RS9Tosoy3rr0QxTWaQd9s79qogyE1Omtn
	 h4RLrLYnTyFKrN+pV3rVd43Xg9n1HrxvUGNO4Gd8EyMiEg++nQ+bsl8b24BT39bnlO
	 8HvhnsiQrtyyXssh2ZxujaSZuRphpOUhrBH/FgrA8inQvO4c0SAyNKmvDPF9GnWz6X
	 VLTcRrdkvkwMSDYfkiA8O8TDmywa3oRIxZX47ULJd2mf++V3wAh11zCFrVpmf6cbzk
	 0eSK9z5pzpZCpqOcMsngcBQgZRaXCXMdzK//KNhmPhIUO6DRQWNpYX4GMWnaleUuV0
	 CGYH553uw2jOw==
Date: Thu, 01 Aug 2024 14:01:45 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] rust: mm: add abstractions for mm_struct and vm_area_struct
Message-ID: <82e4816c-cada-46f3-bebf-882ae8ded118@proton.me>
In-Reply-To: <20240801-vma-v3-1-db6c1c0afda9@google.com>
References: <20240801-vma-v3-1-db6c1c0afda9@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 26750703ee0fd483967e00faa06470dcd6368aaa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.08.24 14:58, Alice Ryhl wrote:
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> new file mode 100644
> index 000000000000..ed2db893fb79
> --- /dev/null
> +++ b/rust/kernel/mm.rs
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Memory management.
> +//!
> +//! C header: [`include/linux/mm.h`](../../../../include/linux/mm.h)
> +
> +use crate::{
> +    bindings,
> +    types::{ARef, AlwaysRefCounted, Opaque},
> +};
> +
> +use core::{
> +    ops::Deref,
> +    ptr::{self, NonNull},
> +};
> +
> +pub mod virt;
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// Since `mm_users` may be zero, the associated address space may not e=
xist anymore. You must use

Can it also be the case that the space never existed to begin with? Then
I would write "the associated address space may not exist."

Also I think it makes more sense to use "You can use [`mmget_not_zero`]
to be able to access the address space." instead of the second sentence.

> +/// [`mmget_not_zero`] before accessing the address space.
> +///
> +/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destruc=
tor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted.

Would be good to record the refcount used in the invariant.

> +///
> +/// [`mmget_not_zero`]: Mm::mmget_not_zero
> +pub struct Mm {
> +    mm: Opaque<bindings::mm_struct>,
> +}
> +
> +// SAFETY: It is safe to call `mmdrop` on another thread than where `mmg=
rab` was called.
> +unsafe impl Send for Mm {}
> +// SAFETY: All methods on `Mm` can be called in parallel from several th=
reads.
> +unsafe impl Sync for Mm {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for Mm {
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmgrab(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmdrop(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// This type is used only when `mm_users` is known to be non-zero at co=
mpile-time. It can be used

I find the "This type is used only when" a bit weird, what about "Like
an [`Mm`], but with non-zero `mm_users`."?

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
> +
> +// SAFETY: It is safe to call `mmput` on another thread than where `mmge=
t` was called.
> +unsafe impl Send for MmWithUser {}
> +// SAFETY: All methods on `MmWithUser` can be called in parallel from se=
veral threads.
> +unsafe impl Sync for MmWithUser {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for MmWithUser {
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmget(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmput(obj.cast().as_ptr()) };
> +    }
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
> +}
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// This type is identical to `MmWithUser` except that it uses `mmput_as=
ync` when dropping a
> +/// refcount. This means that the destructor of `ARef<MmWithUserAsync>` =
is safe to call in atomic
> +/// context.

Missing Invariants.

> +#[repr(transparent)]
> +pub struct MmWithUserAsync {
> +    mm: MmWithUser,
> +}
> +
> +// SAFETY: It is safe to call `mmput_async` on another thread than where=
 `mmget` was called.
> +unsafe impl Send for MmWithUserAsync {}
> +// SAFETY: All methods on `MmWithUserAsync` can be called in parallel fr=
om several threads.
> +unsafe impl Sync for MmWithUserAsync {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for MmWithUserAsync {
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmget(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmput_async(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +// Make all `MmWithUser` methods available on `MmWithUserAsync`.
> +impl Deref for MmWithUserAsync {
> +    type Target =3D MmWithUser;
> +
> +    #[inline]
> +    fn deref(&self) -> &MmWithUser {
> +        &self.mm
> +    }
> +}
> +
> +// These methods are safe to call even if `mm_users` is zero.
> +impl Mm {
> +    /// Call `mmgrab` on `current.mm`.
> +    #[inline]
> +    pub fn mmgrab_current() -> Option<ARef<Mm>> {
> +        // SAFETY: It's safe to get the `mm` field from current.
> +        let mm =3D unsafe {
> +            let current =3D bindings::get_current();
> +            (*current).mm
> +        };
> +
> +        let mm =3D NonNull::new(mm)?;
> +
> +        // SAFETY: We just checked that `mm` is not null.
> +        unsafe { bindings::mmgrab(mm.as_ptr()) };
> +
> +        // SAFETY: We just created an `mmgrab` refcount. Layouts are com=
patible due to
> +        // repr(transparent).
> +        Some(unsafe { ARef::from_raw(mm.cast()) })
> +    }
> +
> +    /// Returns a raw pointer to the inner `mm_struct`.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::mm_struct {
> +        self.mm.get()
> +    }
> +
> +    /// Obtain a reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at an `mm_struct`, and =
that it is not deallocated
> +    /// during the lifetime 'a.
> +    #[inline]
> +    pub unsafe fn from_raw_mm<'a>(ptr: *const bindings::mm_struct) -> &'=
a Mm {

Why not just `from_raw`?

---
Cheers,
Benno

> +        // SAFETY: Caller promises that the pointer is valid for 'a. Lay=
outs are compatible due to
> +        // repr(transparent).
> +        unsafe { &*ptr.cast() }
> +    }


