Return-Path: <linux-kernel+bounces-441503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B629ECF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A70C188CE83
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC281D63E4;
	Wed, 11 Dec 2024 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I29Hz50s"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DBA1A4E9E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929444; cv=none; b=KXt54cOApuXyK3p7WJoZXpfZ1nRZlGrnao759EIDsARN0rnKlwSyJ10v++ULbNlXRCTSERPwfm0kf1zFruhdjRV7cr8jzAPmhjZDWJi98MP6sV/k7e25v7gzB9YOnf5VThrxffoI+pPeW/udyFuX40IL/CkaDWq+BIRrwG7vM/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929444; c=relaxed/simple;
	bh=FnhU2praw0bB4VtzV6HLfwRiA25LXxb8uuqysDoTf+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jQyakbK9jNQTbQJCEAq1gU7qHzoTjVRMHc58lWp6z43S5CCqs+1ZWjiqIFwmpezgTamkcGw+RDYS01tZKGkstDUDljyick7uIi14Xu+pe4YW4lzQVYDMIW/3NlwYqc3Q7l/toaHLKZsJY3AcKIAVNejQVvX+fUfbqzfnBFtf4PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I29Hz50s; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc88476a02so5563682a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 07:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733929441; x=1734534241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbrY5ksbJ6+ZMkKR5x9F9/LGb7S/4RpLy2ateNBN4Mc=;
        b=I29Hz50sWemtQuqlhD+iWRGfuZHu4BwMlOK9A2qOeCFNKzGeaGFT4SgTyIKLCETjyp
         DcMI/x1xQI7/nlIoGaoFRNnFTlTw1qqsmCaV/j27n9dzQjbejUEdGy7NzbLSId7jEX7G
         Yql6d76nECZhHSHg80zdVPEkChU+P8mQBHhLOm33RKr9mBl+eCDDyRfaT8zDgaaJxS1h
         11ahR5IfgcESLgYEC/BD4Gme4o+BKOZJActhCfkXCXMeRDb6Q1OstxxXzVCNOLEZggSa
         4NqdOPMj+rI7BOXTX6URKOkaNmq36Bna47nXl6Oi+OORM10oH1PGIPVQu1p2k1634JN1
         MzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733929441; x=1734534241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbrY5ksbJ6+ZMkKR5x9F9/LGb7S/4RpLy2ateNBN4Mc=;
        b=S7lueZg7V6N2BCCniCww8cgs/cRt1TQYwpR0mwcH57wQNd8UtQmKJVr4iEFwBGrA2g
         spHUqsduYzJJBIWeL16sj7bD4CDBNIOkkY6/Ej3xs8gG7A55owDZq4y3rnKZIcohP7bR
         h5mIt42DxqfBOsGvGypPJAY2ynRftCCyT75hp+ZGvKrVwBfcdp+QdAGwuxz+E5HPy67F
         BdZuYqcfabSr+fnz7qaRBFH5LeVgeomUJcg5WpUVW5m3UuNdUE49cQ0bzBJv6N+JeNeC
         xQ3mSbJdrYvS+vjTyNEuwAokuFj/jZs5obUuiNHQ7qnzTDw4DNsBd9UvmGqHB0zoyoAj
         SEbw==
X-Forwarded-Encrypted: i=1; AJvYcCV+YaGhethRVBGJf8/tN1iIGFhy4p4Byivbbr4Lvc/KQWyf/2H+49HsMsqWbBU22573+B/nSCH1l6uiHAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRSjPDHeY7JcO4m41nxlRghtjrxT5eoGeu7CDd3ffrIJNXxITt
	hKaHILpJ+96XPQiQ28v88ryzxhk/DeghX5nCA/0KUHRIspGV8SMY+L4mK5ngzacTdfeee06E8qt
	/Dx00FCyoPr13ESxQcGNUM4NYH9hNNahknWqH12OrzgfxDtplu0iq
X-Gm-Gg: ASbGnctmnXEEZ2OSHqcn3SblhcUTR35SiRap3FgUWI0y7/1hfaJ1qOtaAadCqlVFhAg
	chc5jp4tglLnXrL3vLx450hM411TBXaOlh5QC5bLSNUdFoiMUCCjjXdnHvaWgBy/61A==
X-Google-Smtp-Source: AGHT+IGzr/9yG8z+M2r9AobHR7zDW/UkxRhv7RE1X5M0cGBdzSKXaDNUdZCduo0+RNvYHdgA1a4nFYotZQjrxPLI9/4=
X-Received: by 2002:a17:90b:4b4f:b0:2ee:863e:9fe8 with SMTP id
 98e67ed59e1d1-2f1392b7534mr361755a91.18.1733929440337; Wed, 11 Dec 2024
 07:04:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-rust-xarray-bindings-v11-0-58a95d137ec2@gmail.com> <20241203-rust-xarray-bindings-v11-2-58a95d137ec2@gmail.com>
In-Reply-To: <20241203-rust-xarray-bindings-v11-2-58a95d137ec2@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Dec 2024 16:03:45 +0100
Message-ID: <CAH5fLgjPir8LfzfouBd3PYBvfCkWgQEw+im-=Vo7z8kBmFLtrw@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] rust: xarray: Add an abstraction for XArray
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

On Tue, Dec 3, 2024 at 11:44=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
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
>  rust/kernel/xarray.rs           | 270 ++++++++++++++++++++++++++++++++++=
++++++
>  6 files changed, 311 insertions(+)
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
> +
>      /// Get the raw representation of this flag.
>      pub(crate) fn as_raw(self) -> u32 {
>          self.0
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
> index 0000000000000000000000000000000000000000..39163ea037cb393a7c32a40b3=
e6539be33986b45
> --- /dev/null
> +++ b/rust/kernel/xarray.rs
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! XArray abstraction.
> +//!
> +//! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
> +
> +use crate::{
> +    alloc, bindings, build_assert, build_error,
> +    error::{Error, Result},
> +    init::PinInit,
> +    pin_init,
> +    types::{ForeignOwnable, NotThreadSafe, Opaque},
> +};
> +use core::{iter, marker::PhantomData, mem, pin::Pin};
> +use macros::{pin_data, pinned_drop};
> +
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
> +        const MAX: core::ffi::c_ulong =3D core::ffi::c_ulong::MAX;

I think you can use kernel::ffi::c_ulong already. Enough things were
merged in 6.13 for that to work. If you import kernel::ffi::c_ulong at
the top of this file, then you can just do c_ulong::MAX in the
function calls below.

> +        let mut index =3D 0;
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

You use core::ptr::NonNull in many places. Consider importing it.

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
> +        // SAFETY:
> +        // - `self.xa.xa` is always valid by the type invariant.
> +        // - The caller holds the lock, so it is safe to unlock it.
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
> +        // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.
> +        unsafe { T::try_from_foreign(ptr) }
> +    }
> +
> +    /// Stores an entry in the array.
> +    ///
> +    /// May drop the lock if needed to allocate memory, and then reacqui=
re it afterwards.
> +    ///
> +    /// On success, returns the entry which was previously at the given =
index.
> +    ///
> +    /// On failure, returns the entry which was attempted to be stored.
> +    pub fn store(
> +        &mut self,
> +        index: usize,
> +        value: T,
> +        gfp: alloc::Flags,
> +    ) -> Result<Option<T>, (T, Error)> {

We can see in your examples that this return type is inconvenient.
Perhaps it would be better to make a new error type containing a T and
an Error, and implement From so that the question mark can convert
directly to Error (throwing away the T).

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
> +                //
> +                // NB: `XA_ZERO_ENTRY` is never returned by functions be=
longing to the Normal XArray
> +                // API; such entries present as `NULL`.
> +                Ok(unsafe { T::try_from_foreign(old) })
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
is `Sync`); additionally, it
> +// needs `T` to be `Send` because any thread that has a `&XArray<T>` may=
 lock it and get a
> +// `Guard<T>` on that thread, so the thread may ultimately access `T` us=
ing a mutable reference, for
> +// example, using `get_mut` or `remove`.
> +unsafe impl<T: ForeignOwnable + Send + Sync> Sync for XArray<T> {}

I don't think Sync is needed due to the spinlock.

Alice

