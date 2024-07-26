Return-Path: <linux-kernel+bounces-262975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE94593CF56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8EBB20E86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A98176ACA;
	Fri, 26 Jul 2024 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TlLy6pTi"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB207745E4
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981468; cv=none; b=niAB77ttHe6i+/wBkp0WIqlRAgxFM62OoHSIFN86UiI+pLHfZco/yukK3HmoxnudIB/WcFf8jK5QaJVOGRlpCvkeKhuX1adN9jvgKjvP+DgEv+TXxsod9JPv8L3qfnRcdiqU/+QxjdRYitw6Hb6jKlwkF1hbrUAKJwHQaFqMizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981468; c=relaxed/simple;
	bh=nWpeU9EYIexqET5NVIy7I+Ieuy25samgl8Nt5DW/UaE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHyLtWYW5DxjDGI2Nanvu5Zbh6j7LLW6sER5CL4spM4KoEc9oY8u7jgH9IZ8EfGdyVjXLsH7PgDxJK2tLFAPXbvAuBup4Hop/EMQQO7rG7Xj2b06tvPBgMb1lOgNwoXhBL+kniHbJvA/U2/go8/VfSoUtJzipAGzPR/Bt6UNAzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TlLy6pTi; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721981463; x=1722240663;
	bh=Tb0bny82xw3N+xnAGMVpo1hM7rDm1n5+a9liM28zCuw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TlLy6pTi5sm5nCahQ0gIP4yk5KAf7jnvliUr9AFllJT9uPlAjgDd+bcaIxUh1CuhM
	 +zX4hcau5TXNEWrUN0XcesR/ZfxWda0uYJq03z5Tc6eBM3xrqOKtUIHlTYLZ+MnIY9
	 uKybJ+q/dxbKasr5C18nS4zPxx6vymFpilRfFujJuCZb45O4oUn2KRQh+rqJW/ueDi
	 bp1/HaMOPchxX9ZTxmr9VeDNu5YG8o7hYb/eXlmyf8Df2vfw4Kgq6oyjnhAcx+NMRc
	 EjRCdYgB2EsyCHUO/HQhVWFrW7ayoxCradonct5ezsI7VFkzztQJiYyxnjm6W83xNR
	 7e1jO+kkH2bAg==
Date: Fri, 26 Jul 2024 08:10:58 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: mm: add abstractions for mm_struct and vm_area_struct
Message-ID: <3bf6bfdc-84af-442a-acec-a58f023d1164@proton.me>
In-Reply-To: <20240723-vma-v1-1-32ad5a0118ee@google.com>
References: <20240723-vma-v1-1-32ad5a0118ee@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a645426bb3ef230cdfb577940ac1e8add4755bc6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.07.24 16:32, Alice Ryhl wrote:
> This is a follow-up to the page abstractions [1] that were recently
> merged in 6.11. Rust Binder will need these abstractions to manipulate
> the vma in its implementation of the mmap fop on the Binder file.
>=20
> The ARef wrapper is not used for mm_struct because there are several
> different types of refcounts.

I am confused, why can't you use the `ARef` wrapper for the different
types that you create below?

> This patch is based on Wedson's implementation on the old rust branch,
> but has been changed significantly. All mistakes are Alice's.
>=20
> Link: https://lore.kernel.org/r/20240528-alice-mm-v7-4-78222c31b8f4@googl=
e.com [1]
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers.c         |  49 ++++++++++
>  rust/kernel/lib.rs     |   1 +
>  rust/kernel/mm.rs      | 259 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  rust/kernel/mm/virt.rs | 193 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 502 insertions(+)
>=20
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 305f0577fae9..9aa5150ebe26 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -199,6 +199,55 @@ rust_helper_krealloc(const void *objp, size_t new_si=
ze, gfp_t flags)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_krealloc);
>=20
> +void rust_helper_mmgrab(struct mm_struct *mm)
> +{
> +=09mmgrab(mm);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mmgrab);
> +
> +void rust_helper_mmdrop(struct mm_struct *mm)
> +{
> +=09mmdrop(mm);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mmdrop);
> +
> +bool rust_helper_mmget_not_zero(struct mm_struct *mm)
> +{
> +=09return mmget_not_zero(mm);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mmget_not_zero);
> +
> +bool rust_helper_mmap_read_trylock(struct mm_struct *mm)
> +{
> +=09return mmap_read_trylock(mm);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mmap_read_trylock);
> +
> +void rust_helper_mmap_read_unlock(struct mm_struct *mm)
> +{
> +=09mmap_read_unlock(mm);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mmap_read_unlock);
> +
> +void rust_helper_mmap_write_lock(struct mm_struct *mm)
> +{
> +=09mmap_write_lock(mm);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mmap_write_lock);
> +
> +void rust_helper_mmap_write_unlock(struct mm_struct *mm)
> +{
> +=09mmap_write_unlock(mm);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mmap_write_unlock);
> +
> +struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
> +=09=09=09=09=09      unsigned long addr)
> +{
> +=09return vma_lookup(mm, addr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_vma_lookup);
> +
>  /*
>   * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we c=
an
>   * use it in contexts where Rust expects a `usize` like slice (array) in=
dices.
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 5d310e79485f..3cbc4cf847a2 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -33,6 +33,7 @@
>  pub mod ioctl;
>  #[cfg(CONFIG_KUNIT)]
>  pub mod kunit;
> +pub mod mm;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
>  pub mod page;
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> new file mode 100644
> index 000000000000..7fa1e2431944
> --- /dev/null
> +++ b/rust/kernel/mm.rs
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Memory management.
> +//!
> +//! C header: [`include/linux/mm.h`](../../../../include/linux/mm.h)
> +
> +use crate::bindings;
> +
> +use core::{marker::PhantomData, mem::ManuallyDrop, ptr::NonNull};
> +
> +pub mod virt;
> +
> +/// A smart pointer that references a `struct mm` and owns an `mmgrab` r=
efcount.
> +///
> +/// # Invariants
> +///
> +/// An `MmGrab` owns an `mmgrab` refcount to the inner `struct mm_struct=
`.

You also need that `mm` is a valid pointer.

> +pub struct MmGrab {
> +    mm: NonNull<bindings::mm_struct>,
> +}
> +
> +impl MmGrab {
> +    /// Call `mmgrab` on `current.mm`.
> +    #[inline]
> +    pub fn mmgrab_current() -> Option<Self> {
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
> +        // INVARIANT: We just created an `mmgrab` refcount.
> +        Some(Self { mm })
> +    }
> +
> +    /// Check whether this vma is associated with this mm.
> +    #[inline]
> +    pub fn is_same_mm(&self, area: &virt::Area) -> bool {
> +        // SAFETY: The `vm_mm` field of the area is immutable, so we can=
 read it without
> +        // synchronization.
> +        let vm_mm =3D unsafe { (*area.as_ptr()).vm_mm };
> +
> +        vm_mm =3D=3D self.mm.as_ptr()
> +    }
> +
> +    /// Calls `mmget_not_zero` and returns a handle if it succeeds.
> +    #[inline]
> +    pub fn mmget_not_zero(&self) -> Option<MmGet> {
> +        // SAFETY: We know that `mm` is still valid since we hold an `mm=
grab` refcount.
> +        let success =3D unsafe { bindings::mmget_not_zero(self.mm.as_ptr=
()) };
> +
> +        if success {
> +            Some(MmGet { mm: self.mm })
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +// SAFETY: It is safe to call `mmdrop` on another thread than where `mmg=
rab` was called.
> +unsafe impl Send for MmGrab {}
> +// SAFETY: All methods on this struct are safe to call in parallel from =
several threads.
> +unsafe impl Sync for MmGrab {}
> +
> +impl Drop for MmGrab {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: This gives up an `mmgrab` refcount to a valid `struct=
 mm_struct`.
> +        // INVARIANT: We own an `mmgrab` refcount, so we can give it up.

This INVARIANT comment seems out of place and the SAFETY comment should
probably be "By the type invariant of `Self`, we own an `mmgrab`
refcount and `self.mm` is valid.".

> +        unsafe { bindings::mmdrop(self.mm.as_ptr()) };
> +    }
> +}
> +
> +/// A smart pointer that references a `struct mm` and owns an `mmget` re=
fcount.
> +///
> +/// Values of this type are created using [`MmGrab::mmget_not_zero`].
> +///
> +/// # Invariants
> +///
> +/// An `MmGet` owns an `mmget` refcount to the inner `struct mm_struct`.

Ditto with the valid pointer here and below.

> +pub struct MmGet {
> +    mm: NonNull<bindings::mm_struct>,
> +}
> +
> +impl MmGet {
> +    /// Lock the mmap read lock.
> +    #[inline]
> +    pub fn mmap_write_lock(&self) -> MmapWriteLock<'_> {
> +        // SAFETY: The pointer is valid since we hold a refcount.
> +        unsafe { bindings::mmap_write_lock(self.mm.as_ptr()) };
> +
> +        // INVARIANT: We just acquired the write lock, so we can transfe=
r to this guard.
> +        //
> +        // The signature of this function ensures that the `MmapWriteLoc=
k` will not outlive this
> +        // `mmget` refcount.
> +        MmapWriteLock {
> +            mm: self.mm,
> +            _lifetime: PhantomData,
> +        }
> +    }
> +
> +    /// When dropping this refcount, use `mmput_async` instead of `mmput=
`.

I don't get this comment.

> +    #[inline]
> +    pub fn use_async_put(self) -> MmGetAsync {
> +        // Disable destructor of `self`.
> +        let me =3D ManuallyDrop::new(self);
> +
> +        MmGetAsync { mm: me.mm }
> +    }
> +}
> +
> +impl Drop for MmGet {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: We acquired a refcount when creating this object.

You can just copy-paste the SAFETY comment from above (if you don't use
the `ARef` pattern). Ditto below.

---
Cheers,
Benno

> +        unsafe { bindings::mmput(self.mm.as_ptr()) };
> +    }
> +}
> +


