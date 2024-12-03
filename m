Return-Path: <linux-kernel+bounces-429705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403B89E20B9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5CB160F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574BC1F7584;
	Tue,  3 Dec 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0fq5Z5a"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B31E3DF9;
	Tue,  3 Dec 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238049; cv=none; b=ZnZ3Amgs9mQ2cNpdXYhtdvDLPtk4l36EKGWl9PLCJDXDUm7jXbBqKR92jwA573hUwN9WpzlaDHhao+k0exds9qEYZYK/GS1Zmk8DyI/7jkmOuwTtHQQpvfLD2pL33dRf2QumH/B6xq2zMSX4YB3FGdKy9vmiF/efyV4zv/htMkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238049; c=relaxed/simple;
	bh=w1S2QtBu8NpOJWjWCQJBaj93AiVg1uopnnApO9QkHkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0UyhznVowl3xLkbJ6tzH3otFS88ZJrGbl62vfH0XQqCK6SaYXCxah6EVoaXeuvcqdqOJsA2YDc2NExv02/JWnqC5kd88Jj8j/TWGcBsCMPmZxIsdJ8wBUB5SXD8I93d8NgkkWG9KAcFDnvdJHXqhXEjfdPWRoDVRH7RF/KZjtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0fq5Z5a; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ffbf4580cbso58999921fa.2;
        Tue, 03 Dec 2024 07:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733238045; x=1733842845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhNXdstEHHFJuwU79Sz5JeRVHY61t9PGs76Ymhp6/1g=;
        b=g0fq5Z5agcqLNpIQJjWt0XOQsuCISyyMt8UEjiRnainNIsx6v5Iq/lXFTEvM7c6RaJ
         kQEwR8noKu/vSk0iRbco5qEKjSczx1nwmsUvk48w/kTol+ofmZmAeZIwgMtY3t4703nv
         IId1W6FnkTHzAeAXrfDA0Gv8ITBWml2S5R6QnB3hKEOFak6MM5gYexQMfYxNlZTDnoOv
         9i77R/kgbEZa9ThaEMa9gzEWNXA924ODzLz4t6qkHN8r/b+c6pOzZiYKpK24e52/ek9F
         Pr9plMybWo8jUAI2kwTIeVmt2/YU0ugOtAJ4pAk2A/Xljk/F/AeCevCl3vFDAq8grlyl
         e2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733238045; x=1733842845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhNXdstEHHFJuwU79Sz5JeRVHY61t9PGs76Ymhp6/1g=;
        b=MxP+wznJBbXggX/7B3fxltq/pu1pXN2IK6w0R70ckD87/ByVbu1U8AXkxMFRocpcPV
         pGg0wTtzkkT6AsqLz8G2jQ4B0TTj1eWcfq4eXDSiOLfzpJs7pIIvT3R7+guGEAkmfCR7
         RSZxzB1NDBkL4Ymhu+T5zLuq54k4WVJS0jiiO8bpowKL+ME8p1ddwwopQfJeqT1kPN4B
         GzFAw/SuV+ce8rx2kGeX23lIsW7ak8rBGFtvtSV2+FfeIcu2JATtRic8paTX7lRa71CO
         +CZFM+8rrsIjOmLB3Iafi1D6N42CCYHd9f++AzAj8ZZc7zhAFSNGoXnY2eSeb6PV5unb
         fdqg==
X-Forwarded-Encrypted: i=1; AJvYcCU8qHt/G6fA+NdMkC/gSUMgm6iusUmZjvTVkRzef88ei01nFNmP92KadNGMLLv+G3e6pLCopgyb427tB6ZJYWU=@vger.kernel.org, AJvYcCXfVlN3GFwHr/+GRtEzhBlKWFsH38w+vDZiZvLxu+OFuD9JT5fdTUjhT9pcfjIpHL68COzdSzl/QUi5o/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Of9heql/A2gbiCwZ0bzVSxqvKvmDMVOfzaokVDC3kFNtA6+B
	SeLFfUeV7XkBD+6BgJ1pLWdDkrly+M2OIAD8hA67Vk120Cxla8wr1L0OpZX+LWiW/Q9uNEyCHDe
	NGw+JhU2lc+5thLHwEZ+/0xmSl00=
X-Gm-Gg: ASbGncsfipwaSj/P0n/RBq/Z+Qg6wEXviGumTcTjE7fxnU3nfF52je9yXF00zy9yhW/
	7nU0iXlwi4KP3BjIGpYn5jHK9l6LHjl23gUAp5AQUr/00nCw=
X-Google-Smtp-Source: AGHT+IFmQrmzaV2VIRgt69ksXgPX3dxpX5wXIS0XisTRLl5vLkgdmewExuQJvvgrRzZ+Je23HcUb2gtzkmYf+8mz4XQ=
X-Received: by 2002:a2e:a906:0:b0:2ff:c86b:5b4f with SMTP id
 38308e7fff4ca-30009cb18a4mr18248751fa.21.1733238044176; Tue, 03 Dec 2024
 07:00:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
 <20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com> <CAH5fLgipntMtu7_pdZDZGerGRO499yxDdz2dP=2Bb5FobcykYg@mail.gmail.com>
In-Reply-To: <CAH5fLgipntMtu7_pdZDZGerGRO499yxDdz2dP=2Bb5FobcykYg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 3 Dec 2024 10:00:07 -0500
Message-ID: <CAJ-ks9kwGi+hhsNUC=Ti3CL8iJ4mEN2vSkoFUnz67Usu+-_P6Q@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] rust: xarray: Add an abstraction for XArray
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Wed, Nov 20, 2024 at 12:48=E2=80=AFPM Tamir Duberstein <tamird@gmail.c=
om> wrote:
> >
> > `XArray` is an efficient sparse array of pointers. Add a Rust
> > abstraction for this type.
> >
> > This implementation bounds the element type on `ForeignOwnable` and
> > requires explicit locking for all operations. Future work may leverage
> > RCU to enable lockless operation.
> >
> > Inspired-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> > Inspired-by: Asahi Lina <lina@asahilina.net>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/bindings/bindings_helper.h |   6 +
> >  rust/helpers/helpers.c          |   1 +
> >  rust/helpers/xarray.c           |  28 +++++
> >  rust/kernel/alloc.rs            |   5 +
> >  rust/kernel/lib.rs              |   1 +
> >  rust/kernel/xarray.rs           | 266 ++++++++++++++++++++++++++++++++=
++++++++
> >  6 files changed, 307 insertions(+)
> >
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index 5c4dfe22f41a5a106330e8c43ffbd342c69c4e0b..9f39d673b240281aed2759b=
5bd076aa43fb54951 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -30,6 +30,7 @@
> >  #include <linux/tracepoint.h>
> >  #include <linux/wait.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/xarray.h>
> >  #include <trace/events/rust_sample.h>
> >
> >  /* `bindgen` gets confused at certain things. */
> > @@ -43,3 +44,8 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO =3D __GFP_ZE=
RO;
> >  const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM =3D ___GFP_HIGHMEM;
> >  const gfp_t RUST_CONST_HELPER___GFP_NOWARN =3D ___GFP_NOWARN;
> >  const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL =3D BLK_FEA=
T_ROTATIONAL;
> > +
> > +const xa_mark_t RUST_CONST_HELPER_XA_PRESENT =3D XA_PRESENT;
> > +
> > +const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC =3D XA_FLAGS_ALLOC;
> > +const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 =3D XA_FLAGS_ALLOC1;
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index dcf827a61b52e71e46fd5378878602eef5e538b6..ff28340e78c53c79baf18e2=
927cc90350d8ab513 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -30,3 +30,4 @@
> >  #include "vmalloc.c"
> >  #include "wait.c"
> >  #include "workqueue.c"
> > +#include "xarray.c"
> > diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..60b299f11451d2c4a75e50e=
25dec4dac13f143f4
> > --- /dev/null
> > +++ b/rust/helpers/xarray.c
> > @@ -0,0 +1,28 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/xarray.h>
> > +
> > +int rust_helper_xa_err(void *entry)
> > +{
> > +       return xa_err(entry);
> > +}
> > +
> > +void rust_helper_xa_init_flags(struct xarray *xa, gfp_t flags)
> > +{
> > +       return xa_init_flags(xa, flags);
> > +}
> > +
> > +int rust_helper_xa_trylock(struct xarray *xa)
> > +{
> > +       return xa_trylock(xa);
> > +}
> > +
> > +void rust_helper_xa_lock(struct xarray *xa)
> > +{
> > +       return xa_lock(xa);
> > +}
> > +
> > +void rust_helper_xa_unlock(struct xarray *xa)
> > +{
> > +       return xa_unlock(xa);
> > +}
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index f2f7f3a53d298cf899e062346202ba3285ce3676..be9f164ece2e0fe71143e02=
01247d2b70c193c51 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -39,6 +39,11 @@
> >  pub struct Flags(u32);
> >
> >  impl Flags {
> > +    /// Get a flags value with all bits unset.
> > +    pub fn empty() -> Self {
> > +        Self(0)
> > +    }
>
> Is this used anywhere?

It was used in an older version to fill reservations which were
expected to not need to allocate memory. Technically it is public API
so calling `store` on an occupied entry with `Flags::empty()` would be
a valid use.

> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index e1065a7551a39e68d6379031d80d4be336e652a3..9ca524b15920c525c7db419=
e60dec4c43522751d 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -68,6 +68,7 @@
> >  pub mod types;
> >  pub mod uaccess;
> >  pub mod workqueue;
> > +pub mod xarray;
> >
> >  #[doc(hidden)]
> >  pub use bindings;
> > diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..acbac787dc9a38684538697=
d53f590880fa9903a
> > --- /dev/null
> > +++ b/rust/kernel/xarray.rs
> > @@ -0,0 +1,266 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! XArray abstraction.
> > +//!
> > +//! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.=
h)
> > +
> > +use core::pin::Pin;
>
> Could be merged with the imports below.

Will do.

> > +use crate::{
> > +    alloc, bindings, build_assert, build_error,
> > +    error::{Error, Result},
> > +    init::PinInit,
> > +    pin_init,
> > +    types::{ForeignOwnable, NotThreadSafe, Opaque},
> > +};
> > +use core::{iter, marker::PhantomData, mem};
> > +use macros::{pin_data, pinned_drop};
>
> I think these are in crate::prelude.

I prefer to be explicit, unless there's guidance on this somewhere?

> > +/// An array which efficiently maps sparse integer indices to owned ob=
jects.
> > +///
> > +/// This is similar to a [`crate::alloc::kvec::Vec<Option<T>>`], but m=
ore efficient when there are
> > +/// holes in the index space, and can be efficiently grown.
> > +///
> > +/// # Invariants
> > +///
> > +/// `self.xa` is always an initialized and valid [`bindings::xarray`] =
whose entries are either
> > +/// `XA_ZERO_ENTRY` or came from `T::into_foreign`.
> > +///
> > +/// # Examples
> > +///
> > +/// ```rust
> > +/// use kernel::alloc::KBox;
> > +/// use kernel::xarray::{AllocKind, XArray};
> > +///
> > +/// let xa =3D KBox::pin_init(XArray::new(AllocKind::Alloc1), GFP_KERN=
EL)?;
> > +///
> > +/// let dead =3D KBox::new(0xdead, GFP_KERNEL)?;
> > +/// let beef =3D KBox::new(0xbeef, GFP_KERNEL)?;
> > +///
> > +/// let mut guard =3D xa.lock();
> > +///
> > +/// assert_eq!(guard.get(0), None);
> > +///
> > +/// assert_eq!(guard.store(0, dead, GFP_KERNEL).unwrap().as_deref(), N=
one);
> > +/// assert_eq!(guard.get(0).copied(), Some(0xdead));
> > +///
> > +/// *guard.get_mut(0).unwrap() =3D 0xffff;
> > +/// assert_eq!(guard.get(0).copied(), Some(0xffff));
> > +///
> > +/// assert_eq!(guard.store(0, beef, GFP_KERNEL).unwrap().as_deref().co=
pied(), Some(0xffff));
> > +/// assert_eq!(guard.get(0).copied(), Some(0xbeef));
> > +///
> > +/// guard.remove(0);
> > +/// assert_eq!(guard.get(0), None);
> > +///
> > +/// # Ok::<(), Error>(())
> > +/// ```
> > +#[pin_data(PinnedDrop)]
> > +pub struct XArray<T: ForeignOwnable> {
> > +    #[pin]
> > +    xa: Opaque<bindings::xarray>,
> > +    _p: PhantomData<T>,
> > +}
> > +
> > +#[pinned_drop]
> > +impl<T: ForeignOwnable> PinnedDrop for XArray<T> {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        self.iter().for_each(|ptr| {
> > +            let ptr =3D ptr.as_ptr();
> > +            // SAFETY: `ptr` came from `T::into_foreign`.
> > +            //
> > +            // INVARIANT: we own the only reference to the array which=
 is being dropped so the
> > +            // broken invariant is not observable on function exit.
> > +            drop(unsafe { T::from_foreign(ptr) })
> > +        });
> > +
> > +        // SAFETY: `self.xa` is always valid by the type invariant.
> > +        unsafe { bindings::xa_destroy(self.xa.get()) };
> > +    }
> > +}
> > +
> > +/// Flags passed to [`XArray::new`] to configure the array's allocatio=
n tracking behavior.
> > +pub enum AllocKind {
> > +    /// Consider the first element to be at index 0.
> > +    Alloc,
> > +    /// Consider the first element to be at index 1.
> > +    Alloc1,
> > +}
> > +
> > +impl<T: ForeignOwnable> XArray<T> {
> > +    /// Creates a new [`XArray`].
> > +    pub fn new(kind: AllocKind) -> impl PinInit<Self> {
> > +        let flags =3D match kind {
> > +            AllocKind::Alloc =3D> bindings::XA_FLAGS_ALLOC,
> > +            AllocKind::Alloc1 =3D> bindings::XA_FLAGS_ALLOC1,
> > +        };
> > +        pin_init!(Self {
> > +            // SAFETY: `xa` is valid while the closure is called.
> > +            xa <- Opaque::ffi_init(|xa| unsafe {
> > +                bindings::xa_init_flags(xa, flags)
> > +            }),
> > +            _p: PhantomData,
> > +        })
> > +    }
> > +
> > +    fn iter(&self) -> impl Iterator<Item =3D core::ptr::NonNull<T::Poi=
ntedTo>> + '_ {
> > +        // TODO: Remove when https://lore.kernel.org/all/2024091321304=
1.395655-5-gary@garyguo.net/ is applied.
> > +        const MIN: core::ffi::c_ulong =3D core::ffi::c_ulong::MIN;
> > +        const MAX: core::ffi::c_ulong =3D core::ffi::c_ulong::MAX;
>
> Isn't MIN just zero?

I liked the symmetry, but I could change it if you feel strongly.

> > +        let mut index =3D MIN;
> > +
> > +        // SAFETY: `self.xa` is always valid by the type invariant.
> > +        iter::once(unsafe {
> > +            bindings::xa_find(self.xa.get(), &mut index, MAX, bindings=
::XA_PRESENT)
> > +        })
> > +        .chain(iter::from_fn(move || {
> > +            // SAFETY: `self.xa` is always valid by the type invariant=
.
> > +            Some(unsafe {
> > +                bindings::xa_find_after(self.xa.get(), &mut index, MAX=
, bindings::XA_PRESENT)
> > +            })
> > +        }))
> > +        .map_while(|ptr| core::ptr::NonNull::new(ptr.cast()))
> > +    }
> > +
> > +    /// Attempts to lock the [`XArray`] for exclusive access.
> > +    pub fn try_lock(&self) -> Option<Guard<'_, T>> {
> > +        // SAFETY: `self.xa` is always valid by the type invariant.
> > +        (unsafe { bindings::xa_trylock(self.xa.get()) } !=3D 0).then(|=
| Guard {
> > +            xa: self,
> > +            _not_send: NotThreadSafe,
> > +        })
> > +    }
> > +
> > +    /// Locks the [`XArray`] for exclusive access.
> > +    pub fn lock(&self) -> Guard<'_, T> {
> > +        // SAFETY: `self.xa` is always valid by the type invariant.
> > +        unsafe { bindings::xa_lock(self.xa.get()) };
> > +
> > +        Guard {
> > +            xa: self,
> > +            _not_send: NotThreadSafe,
> > +        }
> > +    }
> > +}
> > +
> > +/// A lock guard.
> > +///
> > +/// The lock is unlocked when the guard goes out of scope.
> > +#[must_use =3D "the lock unlocks immediately when the guard is unused"=
]
> > +pub struct Guard<'a, T: ForeignOwnable> {
> > +    xa: &'a XArray<T>,
> > +    _not_send: NotThreadSafe,
> > +}
> > +
> > +impl<T: ForeignOwnable> Drop for Guard<'_, T> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> > +        //
> > +        // SAFETY: The caller holds the lock, so it is safe to unlock =
it.
> > +        unsafe { bindings::xa_unlock(self.xa.xa.get()) };
> > +    }
> > +}
> > +
> > +// TODO: Remove when https://lore.kernel.org/all/20240913213041.395655=
-5-gary@garyguo.net/ is applied.
> > +fn to_index(i: usize) -> core::ffi::c_ulong {
> > +    i.try_into()
> > +        .unwrap_or_else(|_| build_error!("cannot convert usize to c_ul=
ong"))
> > +}
> > +
> > +impl<'a, T: ForeignOwnable> Guard<'a, T> {
> > +    fn load<F, U>(&self, index: usize, f: F) -> Option<U>
> > +    where
> > +        F: FnOnce(core::ptr::NonNull<T::PointedTo>) -> U,
> > +    {
> > +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> > +        let ptr =3D unsafe { bindings::xa_load(self.xa.xa.get(), to_in=
dex(index)) };
> > +        let ptr =3D core::ptr::NonNull::new(ptr.cast())?;
> > +        Some(f(ptr))
> > +    }
> > +
> > +    /// Loads an entry from the array.
> > +    ///
> > +    /// Returns the entry at the given index.
> > +    pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
> > +        self.load(index, |ptr| {
> > +            // SAFETY: `ptr` came from `T::into_foreign`.
> > +            unsafe { T::borrow(ptr.as_ptr()) }
> > +        })
> > +    }
> > +
> > +    /// Loads an entry from the array.
> > +    ///
> > +    /// Returns the entry at the given index.
> > +    pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'=
_>> {
> > +        self.load(index, |ptr| {
> > +            // SAFETY: `ptr` came from `T::into_foreign`.
> > +            unsafe { T::borrow_mut(ptr.as_ptr()) }
> > +        })
> > +    }
> > +
> > +    /// Erases an entry from the array.
> > +    ///
> > +    /// Returns the entry which was previously at the given index.
> > +    pub fn remove(&mut self, index: usize) -> Option<T> {
> > +        // SAFETY: `self.xa.xa` is always valid by the type invariant.
> > +        //
> > +        // SAFETY: The caller holds the lock.
> > +        let ptr =3D unsafe { bindings::__xa_erase(self.xa.xa.get(), to=
_index(index)) }.cast();
>
> Two safety comments?

There are two properties that must be upheld. How would you like to
see it formatted?

> > +        // SAFETY: `ptr` is either NULL or came from `T::into_foreign`=
.
> > +        unsafe { T::try_from_foreign(ptr) }
> > +    }
> > +
> > +    /// Stores an entry in the array.
> > +    ///
> > +    /// On success, returns the entry which was previously at the give=
n index.
> > +    ///
> > +    /// On failure, returns the entry which was attempted to be stored=
.
>
> I'd like to see documentation about the gfp flags. This may unlock the
> spinlock temporarily if GFP_KERNEL is used.

Will add the language from the C documentation: "May drop the lock if
needed to allocate memory, and then reacquire it afterwards."

> > +    pub fn store(
> > +        &mut self,
> > +        index: usize,
> > +        value: T,
> > +        gfp: alloc::Flags,
> > +    ) -> Result<Option<T>, (T, Error)> {
> > +        build_assert!(
> > +            mem::align_of::<T::PointedTo>() >=3D 4,
> > +            "pointers stored in XArray must be 4-byte aligned"
> > +        );
> > +        let new =3D value.into_foreign();
> > +
> > +        let old =3D {
> > +            let new =3D new.cast();
> > +            // SAFETY: `self.xa.xa` is always valid by the type invari=
ant.
> > +            //
> > +            // SAFETY: The caller holds the lock.
> > +            //
> > +            // INVARIANT: `new` came from `T::into_foreign`.
> > +            unsafe { bindings::__xa_store(self.xa.xa.get(), to_index(i=
ndex), new, gfp.as_raw()) }
> > +        };
> > +
> > +        // SAFETY: `__xa_store` returns the old entry at this index on=
 success or `xa_err` if an
> > +        // error happened.
> > +        match unsafe { bindings::xa_err(old) } {
> > +            0 =3D> {
> > +                let old =3D old.cast();
> > +                // SAFETY: `ptr` is either NULL or came from `T::into_=
foreign`.
> > +                Ok(unsafe { T::try_from_foreign(old) })
>
> It can't be XA_ZERO_ENTRY?

No it can't. XA_ZERO_ENTRY is never returned from the "normal" API.
XA_ZERO_ENTRY presents as NULL.

> > +            }
> > +            errno =3D> {
> > +                // SAFETY: `new` came from `T::into_foreign` and `__xa=
_store` does not take
> > +                // ownership of the value on error.
> > +                let value =3D unsafe { T::from_foreign(new) };
> > +                Err((value, Error::from_errno(errno)))
> > +            }
> > +        }
> > +    }
> > +}
> > +
> > +// SAFETY: It is safe to send `XArray<T>` to another thread when the u=
nderlying `T` is `Send`
> > +// because XArray is thread-safe and all mutation operations are synch=
ronized.
> > +unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
> > +
> > +// SAFETY: It is safe to send `&XArray<T>` to another thread when the =
underlying `T` is `Sync`
> > +// because it effectively means sharing `&T` (which is safe because `T=
` is `Sync`). Additionally,
> > +// `T` is `Send` because XArray is thread-safe and all mutation operat=
ions are internally locked.
> > +unsafe impl<T: ForeignOwnable + Send + Sync> Sync for XArray<T> {}
> >
> > --
> > 2.47.0
> >

