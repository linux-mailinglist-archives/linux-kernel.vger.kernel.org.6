Return-Path: <linux-kernel+bounces-429442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B656C9E1C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7720F2835A9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A471E47D1;
	Tue,  3 Dec 2024 12:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJwTgqh3"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40EB1DF982
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229051; cv=none; b=oidbi7jASoQCRCptMCigXhjP0g5zLOWfBbNkSmwtnihkQBJFyhY0KYLltj3hEqZ4IAKfl+mynmRhMhHSLKeK6CKgLOv+CPt6eXajS1l+gGKdTNjHqB9GqtJPv2feoECIm7xzJAk1/tzkaB6nYdDzdJULDh9MBH2LnDXWK1TwcUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229051; c=relaxed/simple;
	bh=UcO8ZYL7qbbdz/ImP/+lAtmzv28xaiGQ5At/6Xt+xoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnJKsdesaTwmhe2nxMH74KTqI3tu5kUIGYyRAIXggRUc2DDnsTes77lUAONAIo8Ug3CXVSRCAhcPlZuHswc2Dx8tfwzlDRm3b14YBidYVpvt1wD7HSH3u8oM6xMKYCnomnesPmSPBD6KH9SIO6J6vzBor1lfQBbhCHMD2PbprWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJwTgqh3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-434a45f05feso67540535e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 04:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733229047; x=1733833847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdOD1pghQiXd9Gj0pHnZhVE4QHkGcohUPtvCTKMFtH8=;
        b=NJwTgqh3jaIeapT6gSiO1RwVA+flZRNDAdIH5h74hRlUrzb0SkqHgzDH1t5NapIYpG
         j4CWuFCYrhRNfRel01pAvhMUknW3T26sBJXijy3FMCY2QOGLbFZChKFGi71Csd4jsBa2
         DCPUV2SjhUi/Kh73eknOR96gxug07wcn5TcgbUeFTrb1M4dAmLV6x9Cd5K1hKBdCxb6z
         IrxyugHcHotiM7eQqZiJ8XCUeIz9jkSvfaGCyQLr2egXDTXLfoBdVmcEWul63elmd5ND
         kXr90thErE4+GbeMlvdgd1wvC8ZClJrmZ/gyN+SczcalVSYdrLbCYpsbeeaNnqw7Ye43
         9Mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229047; x=1733833847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdOD1pghQiXd9Gj0pHnZhVE4QHkGcohUPtvCTKMFtH8=;
        b=KTK8RibRGNxD4IZb8ZnJdG7Pi4pXc55bzAp2ptij5URAX0qQs58Vz7JX/iUKTOiw4S
         EqcDc/JLTsNfexlWADTksJBk7YG+o6sHen8Yx1Ep5ndn2hN2plkOLUGsUqlmT1FyAuEP
         GLiGnZxaKwUWLp8ZpzvtBtGamHP0HenL04rjOz8xkr9Ez55qBhhFfdzXOaHL8ax//Btk
         4bn/XGBgkfuRZJ8MUDgBaMf5/gdMNbhBd/sfkh1hb2P6H7Fq3Big3QY6GJarcnOddHCK
         P2yy1OQUGX53irn1IcfkY2VA72jM7bXhwMymtDEPoQoF9N21M5i7rAwdKkGdrxQJ7DSQ
         qyiA==
X-Forwarded-Encrypted: i=1; AJvYcCU/gw2Pbqu/0RmjOFnnnk29+fdN6GbHqVLIJsEnS1IWMmY/ZDUQakp+d+ZaN+ijZ0lxEb/9RVwpWWonjjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyvG9omFukg2tfo4LRJ1mgeBxBlS9F4JHRmPJd5jg1etgednKT
	+VL6R4/tUB1P+gF2Oq1K0bocDUkFBb0GiWHIKSaUd8505poLNaM2/KaGsoXVBGzMcKPn7vldpEB
	oLH98f22ANWkspgT/OqpQS/7dj4aiGZUJGmAh
X-Gm-Gg: ASbGncv+DQYW3psZuWFePBmCAPq5NOORcJQV6+WqahId7/XUrX2/QEDKfDAlWXIBpc8
	BaAVeLYyiolhTs1UbO0aJ0KMP6t4O13YMBhLeWUKuWa0KqFUqvaKLsFomLVAlWw==
X-Google-Smtp-Source: AGHT+IHIdBim0FEGmGHLEgqoqMHccUi+r6eVOeRGTpmw6QbUq/HmfLGVkF34Bza6IVIaV4ClobgJvxCz4xAJakdzUgg=
X-Received: by 2002:a5d:64e6:0:b0:385:e176:43e8 with SMTP id
 ffacd0b85a97d-385fd3f38b0mr2265391f8f.33.1733229046778; Tue, 03 Dec 2024
 04:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com> <20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com>
In-Reply-To: <20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 3 Dec 2024 13:30:34 +0100
Message-ID: <CAH5fLgipntMtu7_pdZDZGerGRO499yxDdz2dP=2Bb5FobcykYg@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] rust: xarray: Add an abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 12:48=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
>
> `XArray` is an efficient sparse array of pointers. Add a Rust
> abstraction for this type.
>
> This implementation bounds the element type on `ForeignOwnable` and
> requires explicit locking for all operations. Future work may leverage
> RCU to enable lockless operation.
>
> Inspired-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Inspired-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/bindings/bindings_helper.h |   6 +
>  rust/helpers/helpers.c          |   1 +
>  rust/helpers/xarray.c           |  28 +++++
>  rust/kernel/alloc.rs            |   5 +
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/xarray.rs           | 266 ++++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 307 insertions(+)
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 5c4dfe22f41a5a106330e8c43ffbd342c69c4e0b..9f39d673b240281aed2759b5b=
d076aa43fb54951 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -30,6 +30,7 @@
>  #include <linux/tracepoint.h>
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
> +#include <linux/xarray.h>
>  #include <trace/events/rust_sample.h>
>
>  /* `bindgen` gets confused at certain things. */
> @@ -43,3 +44,8 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO =3D __GFP_ZERO=
;
>  const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM =3D ___GFP_HIGHMEM;
>  const gfp_t RUST_CONST_HELPER___GFP_NOWARN =3D ___GFP_NOWARN;
>  const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL =3D BLK_FEAT_=
ROTATIONAL;
> +
> +const xa_mark_t RUST_CONST_HELPER_XA_PRESENT =3D XA_PRESENT;
> +
> +const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC =3D XA_FLAGS_ALLOC;
> +const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 =3D XA_FLAGS_ALLOC1;
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index dcf827a61b52e71e46fd5378878602eef5e538b6..ff28340e78c53c79baf18e292=
7cc90350d8ab513 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -30,3 +30,4 @@
>  #include "vmalloc.c"
>  #include "wait.c"
>  #include "workqueue.c"
> +#include "xarray.c"
> diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..60b299f11451d2c4a75e50e25=
dec4dac13f143f4
> --- /dev/null
> +++ b/rust/helpers/xarray.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/xarray.h>
> +
> +int rust_helper_xa_err(void *entry)
> +{
> +       return xa_err(entry);
> +}
> +
> +void rust_helper_xa_init_flags(struct xarray *xa, gfp_t flags)
> +{
> +       return xa_init_flags(xa, flags);
> +}
> +
> +int rust_helper_xa_trylock(struct xarray *xa)
> +{
> +       return xa_trylock(xa);
> +}
> +
> +void rust_helper_xa_lock(struct xarray *xa)
> +{
> +       return xa_lock(xa);
> +}
> +
> +void rust_helper_xa_unlock(struct xarray *xa)
> +{
> +       return xa_unlock(xa);
> +}
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index f2f7f3a53d298cf899e062346202ba3285ce3676..be9f164ece2e0fe71143e0201=
247d2b70c193c51 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -39,6 +39,11 @@
>  pub struct Flags(u32);
>
>  impl Flags {
> +    /// Get a flags value with all bits unset.
> +    pub fn empty() -> Self {
> +        Self(0)
> +    }

Is this used anywhere?

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e1065a7551a39e68d6379031d80d4be336e652a3..9ca524b15920c525c7db419e6=
0dec4c43522751d 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -68,6 +68,7 @@
>  pub mod types;
>  pub mod uaccess;
>  pub mod workqueue;
> +pub mod xarray;
>
>  #[doc(hidden)]
>  pub use bindings;
> diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> new file mode 100644
> index 0000000000000000000000000000000000000000..acbac787dc9a38684538697d5=
3f590880fa9903a
> --- /dev/null
> +++ b/rust/kernel/xarray.rs
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! XArray abstraction.
> +//!
> +//! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
> +
> +use core::pin::Pin;

Could be merged with the imports below.

> +use crate::{
> +    alloc, bindings, build_assert, build_error,
> +    error::{Error, Result},
> +    init::PinInit,
> +    pin_init,
> +    types::{ForeignOwnable, NotThreadSafe, Opaque},
> +};
> +use core::{iter, marker::PhantomData, mem};
> +use macros::{pin_data, pinned_drop};

I think these are in crate::prelude.

> +/// An array which efficiently maps sparse integer indices to owned obje=
cts.
> +///
> +/// This is similar to a [`crate::alloc::kvec::Vec<Option<T>>`], but mor=
e efficient when there are
> +/// holes in the index space, and can be efficiently grown.
> +///
> +/// # Invariants
> +///
> +/// `self.xa` is always an initialized and valid [`bindings::xarray`] wh=
ose entries are either
> +/// `XA_ZERO_ENTRY` or came from `T::into_foreign`.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// use kernel::alloc::KBox;
> +/// use kernel::xarray::{AllocKind, XArray};
> +///
> +/// let xa =3D KBox::pin_init(XArray::new(AllocKind::Alloc1), GFP_KERNEL=
)?;
> +///
> +/// let dead =3D KBox::new(0xdead, GFP_KERNEL)?;
> +/// let beef =3D KBox::new(0xbeef, GFP_KERNEL)?;
> +///
> +/// let mut guard =3D xa.lock();
> +///
> +/// assert_eq!(guard.get(0), None);
> +///
> +/// assert_eq!(guard.store(0, dead, GFP_KERNEL).unwrap().as_deref(), Non=
e);
> +/// assert_eq!(guard.get(0).copied(), Some(0xdead));
> +///
> +/// *guard.get_mut(0).unwrap() =3D 0xffff;
> +/// assert_eq!(guard.get(0).copied(), Some(0xffff));
> +///
> +/// assert_eq!(guard.store(0, beef, GFP_KERNEL).unwrap().as_deref().copi=
ed(), Some(0xffff));
> +/// assert_eq!(guard.get(0).copied(), Some(0xbeef));
> +///
> +/// guard.remove(0);
> +/// assert_eq!(guard.get(0), None);
> +///
> +/// # Ok::<(), Error>(())
> +/// ```
> +#[pin_data(PinnedDrop)]
> +pub struct XArray<T: ForeignOwnable> {
> +    #[pin]
> +    xa: Opaque<bindings::xarray>,
> +    _p: PhantomData<T>,
> +}
> +
> +#[pinned_drop]
> +impl<T: ForeignOwnable> PinnedDrop for XArray<T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        self.iter().for_each(|ptr| {
> +            let ptr =3D ptr.as_ptr();
> +            // SAFETY: `ptr` came from `T::into_foreign`.
> +            //
> +            // INVARIANT: we own the only reference to the array which i=
s being dropped so the
> +            // broken invariant is not observable on function exit.
> +            drop(unsafe { T::from_foreign(ptr) })
> +        });
> +
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        unsafe { bindings::xa_destroy(self.xa.get()) };
> +    }
> +}
> +
> +/// Flags passed to [`XArray::new`] to configure the array's allocation =
tracking behavior.
> +pub enum AllocKind {
> +    /// Consider the first element to be at index 0.
> +    Alloc,
> +    /// Consider the first element to be at index 1.
> +    Alloc1,
> +}
> +
> +impl<T: ForeignOwnable> XArray<T> {
> +    /// Creates a new [`XArray`].
> +    pub fn new(kind: AllocKind) -> impl PinInit<Self> {
> +        let flags =3D match kind {
> +            AllocKind::Alloc =3D> bindings::XA_FLAGS_ALLOC,
> +            AllocKind::Alloc1 =3D> bindings::XA_FLAGS_ALLOC1,
> +        };
> +        pin_init!(Self {
> +            // SAFETY: `xa` is valid while the closure is called.
> +            xa <- Opaque::ffi_init(|xa| unsafe {
> +                bindings::xa_init_flags(xa, flags)
> +            }),
> +            _p: PhantomData,
> +        })
> +    }
> +
> +    fn iter(&self) -> impl Iterator<Item =3D core::ptr::NonNull<T::Point=
edTo>> + '_ {
> +        // TODO: Remove when https://lore.kernel.org/all/20240913213041.=
395655-5-gary@garyguo.net/ is applied.
> +        const MIN: core::ffi::c_ulong =3D core::ffi::c_ulong::MIN;
> +        const MAX: core::ffi::c_ulong =3D core::ffi::c_ulong::MAX;

Isn't MIN just zero?

> +        let mut index =3D MIN;
> +
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        iter::once(unsafe {
> +            bindings::xa_find(self.xa.get(), &mut index, MAX, bindings::=
XA_PRESENT)
> +        })
> +        .chain(iter::from_fn(move || {
> +            // SAFETY: `self.xa` is always valid by the type invariant.
> +            Some(unsafe {
> +                bindings::xa_find_after(self.xa.get(), &mut index, MAX, =
bindings::XA_PRESENT)
> +            })
> +        }))
> +        .map_while(|ptr| core::ptr::NonNull::new(ptr.cast()))
> +    }
> +
> +    /// Attempts to lock the [`XArray`] for exclusive access.
> +    pub fn try_lock(&self) -> Option<Guard<'_, T>> {
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        (unsafe { bindings::xa_trylock(self.xa.get()) } !=3D 0).then(|| =
Guard {
> +            xa: self,
> +            _not_send: NotThreadSafe,
> +        })
> +    }
> +
> +    /// Locks the [`XArray`] for exclusive access.
> +    pub fn lock(&self) -> Guard<'_, T> {
> +        // SAFETY: `self.xa` is always valid by the type invariant.
> +        unsafe { bindings::xa_lock(self.xa.get()) };
> +
> +        Guard {
> +            xa: self,
> +            _not_send: NotThreadSafe,
> +        }
> +    }
> +}
> +
> +/// A lock guard.
> +///
> +/// The lock is unlocked when the guard goes out of scope.
> +#[must_use =3D "the lock unlocks immediately when the guard is unused"]
> +pub struct Guard<'a, T: ForeignOwnable> {
> +    xa: &'a XArray<T>,
> +    _not_send: NotThreadSafe,
> +}
> +
> +impl<T: ForeignOwnable> Drop for Guard<'_, T> {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> +        //
> +        // SAFETY: The caller holds the lock, so it is safe to unlock it=
.
> +        unsafe { bindings::xa_unlock(self.xa.xa.get()) };
> +    }
> +}
> +
> +// TODO: Remove when https://lore.kernel.org/all/20240913213041.395655-5=
-gary@garyguo.net/ is applied.
> +fn to_index(i: usize) -> core::ffi::c_ulong {
> +    i.try_into()
> +        .unwrap_or_else(|_| build_error!("cannot convert usize to c_ulon=
g"))
> +}
> +
> +impl<'a, T: ForeignOwnable> Guard<'a, T> {
> +    fn load<F, U>(&self, index: usize, f: F) -> Option<U>
> +    where
> +        F: FnOnce(core::ptr::NonNull<T::PointedTo>) -> U,
> +    {
> +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> +        let ptr =3D unsafe { bindings::xa_load(self.xa.xa.get(), to_inde=
x(index)) };
> +        let ptr =3D core::ptr::NonNull::new(ptr.cast())?;
> +        Some(f(ptr))
> +    }
> +
> +    /// Loads an entry from the array.
> +    ///
> +    /// Returns the entry at the given index.
> +    pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
> +        self.load(index, |ptr| {
> +            // SAFETY: `ptr` came from `T::into_foreign`.
> +            unsafe { T::borrow(ptr.as_ptr()) }
> +        })
> +    }
> +
> +    /// Loads an entry from the array.
> +    ///
> +    /// Returns the entry at the given index.
> +    pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'_>=
> {
> +        self.load(index, |ptr| {
> +            // SAFETY: `ptr` came from `T::into_foreign`.
> +            unsafe { T::borrow_mut(ptr.as_ptr()) }
> +        })
> +    }
> +
> +    /// Erases an entry from the array.
> +    ///
> +    /// Returns the entry which was previously at the given index.
> +    pub fn remove(&mut self, index: usize) -> Option<T> {
> +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> +        //
> +        // SAFETY: The caller holds the lock.
> +        let ptr =3D unsafe { bindings::__xa_erase(self.xa.xa.get(), to_i=
ndex(index)) }.cast();

Two safety comments?

> +        // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.
> +        unsafe { T::try_from_foreign(ptr) }
> +    }
> +
> +    /// Stores an entry in the array.
> +    ///
> +    /// On success, returns the entry which was previously at the given =
index.
> +    ///
> +    /// On failure, returns the entry which was attempted to be stored.

I'd like to see documentation about the gfp flags. This may unlock the
spinlock temporarily if GFP_KERNEL is used.

> +    pub fn store(
> +        &mut self,
> +        index: usize,
> +        value: T,
> +        gfp: alloc::Flags,
> +    ) -> Result<Option<T>, (T, Error)> {
> +        build_assert!(
> +            mem::align_of::<T::PointedTo>() >=3D 4,
> +            "pointers stored in XArray must be 4-byte aligned"
> +        );
> +        let new =3D value.into_foreign();
> +
> +        let old =3D {
> +            let new =3D new.cast();
> +            // SAFETY: `self.xa.xa` is always valid by the type invarian=
t.
> +            //
> +            // SAFETY: The caller holds the lock.
> +            //
> +            // INVARIANT: `new` came from `T::into_foreign`.
> +            unsafe { bindings::__xa_store(self.xa.xa.get(), to_index(ind=
ex), new, gfp.as_raw()) }
> +        };
> +
> +        // SAFETY: `__xa_store` returns the old entry at this index on s=
uccess or `xa_err` if an
> +        // error happened.
> +        match unsafe { bindings::xa_err(old) } {
> +            0 =3D> {
> +                let old =3D old.cast();
> +                // SAFETY: `ptr` is either NULL or came from `T::into_fo=
reign`.
> +                Ok(unsafe { T::try_from_foreign(old) })

It can't be XA_ZERO_ENTRY?

> +            }
> +            errno =3D> {
> +                // SAFETY: `new` came from `T::into_foreign` and `__xa_s=
tore` does not take
> +                // ownership of the value on error.
> +                let value =3D unsafe { T::from_foreign(new) };
> +                Err((value, Error::from_errno(errno)))
> +            }
> +        }
> +    }
> +}
> +
> +// SAFETY: It is safe to send `XArray<T>` to another thread when the und=
erlying `T` is `Send`
> +// because XArray is thread-safe and all mutation operations are synchro=
nized.
> +unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
> +
> +// SAFETY: It is safe to send `&XArray<T>` to another thread when the un=
derlying `T` is `Sync`
> +// because it effectively means sharing `&T` (which is safe because `T` =
is `Sync`). Additionally,
> +// `T` is `Send` because XArray is thread-safe and all mutation operatio=
ns are internally locked.
> +unsafe impl<T: ForeignOwnable + Send + Sync> Sync for XArray<T> {}
>
> --
> 2.47.0
>

