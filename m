Return-Path: <linux-kernel+bounces-220729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B37790E658
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BB31F235EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8835B7E794;
	Wed, 19 Jun 2024 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PzXPGTkO"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C57CF18
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787201; cv=none; b=ILTlQu9ZvOEX6/1Gf+dXdN8wPvbvA7g0qTJ1tMXY1MClLPhgWRwIsja1grk8vfu9UmTMPS7mcfLXH3kUbCoyD/ed0W6oIrlHNbl/KlBwHjb34oUpuZlZt4y1qoCiqntwF60b85XOioqj15VtkugBO4X5+QmnyHDZJlTABaLLLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787201; c=relaxed/simple;
	bh=JzOv+FKo4c0KcRrvkL0lGpzjLRpDDjA9GmnK9SkYkJg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGpThd6SRWP/KzU2TnWE6ylzcQy/yIiFyYhDsMLauG8dLOasO1MC78luwhOVNGS49f0JMWgMM65ui/je6S6ucjIkgb9DoD7yQyIKFVcXayJ/QAO9/fMRUgd/cRZ3YCcqZuqTkZiErlaDj6xi1zj1/fDl8zaNVG4p/cHUcDd8cn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PzXPGTkO; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=snlegwbmlfertojwo6ecli3wve.protonmail; t=1718787195; x=1719046395;
	bh=bznw5tDTy8icVqH5yxfNfTnDKC6dWBkUO+jA+0XZCX8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PzXPGTkO7Q57ToUKolhivkewFshNFBAKwcxnDMYFQAB6fkffK2ugxPbENVNr5qco/
	 V+v5xHUfQsgTfs0mNOfkpd512GcFUOk+Ry0Umsnb4MziWPVc1Pady/jAfG1rgqA7om
	 4/RoJLpJQjS3FMKBTM9b4zuhWBXHYj2xZppE4GI6BClkrvkemR+F0TfhCwh8StGQ1G
	 IBNr8ZVn6VIuA8SofDTP9ZUanHfQgdaAYlmbjbnQJMTNwRizf/c93QSaPdUpJppuaE
	 lR8dTu5DvbNnplQlSdIOxYlBDOt6GIYM6AW0+TmrPXO+MGPOt3RAjCmGC5+8VxHqR4
	 Kv8/NtwcrntvA==
Date: Wed, 19 Jun 2024 08:53:11 +0000
To: Danilo Krummrich <dakr@redhat.com>, gregkh@linuxfoundation.org, rafael@kernel.org, mcgrof@kernel.org, russ.weight@linux.dev, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] rust: add abstraction for struct device
Message-ID: <a4bf20a0-60e9-4462-a9d7-7353514b02a7@proton.me>
In-Reply-To: <20240618154841.6716-2-dakr@redhat.com>
References: <20240618154841.6716-1-dakr@redhat.com> <20240618154841.6716-2-dakr@redhat.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: de6d3edd9df502580cfde2cd4dea14fba16b66df
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.06.24 17:48, Danilo Krummrich wrote:
> Add an (always) reference-counted abstraction for a generic C `struct
> device`. This abstraction encapsulates existing `struct device` instances
> and manages its reference count.
>=20
> Subsystems may use this abstraction as a base to abstract subsystem
> specific device instances based on a generic `struct device`, such as
> `struct pci_dev`.
>=20
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/helpers.c        |   1 +
>  rust/kernel/device.rs | 102 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs    |   1 +
>  3 files changed, 104 insertions(+)
>  create mode 100644 rust/kernel/device.rs
>=20
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 2c37a0f5d7a8..0e02b2c64c72 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -23,6 +23,7 @@
>  #include <kunit/test-bug.h>
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/errname.h>
>  #include <linux/mutex.h>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> new file mode 100644
> index 000000000000..e445e87fb7d7
> --- /dev/null
> +++ b/rust/kernel/device.rs
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic devices that are part of the kernel's driver model.
> +//!
> +//! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
> +
> +use crate::{
> +    bindings,
> +    types::{ARef, Opaque},
> +};
> +use core::ptr;
> +
> +/// A reference-counted device.
> +///
> +/// This structure represents the Rust abstraction for a C `struct devic=
e`. This implementation
> +/// abstracts the usage of an already existing C `struct device` within =
Rust code that we get
> +/// passed from the C side.
> +///
> +/// An instance of this abstraction can be obtained temporarily or perma=
nent.
> +///
> +/// A temporary one is bound to the lifetime of the C `struct device` po=
inter used for creation.
> +/// A permanent instance is always reference-counted and hence not restr=
icted by any lifetime
> +/// boundaries.
> +///
> +/// For subsystems it is recommended to create a permanent instance to w=
rap into a subsystem
> +/// specific device structure (e.g. `pci::Device`). This is useful for p=
assing it to drivers in
> +/// `T::probe()`, such that a driver can store the `ARef<Device>` (equiv=
alent to storing a
> +/// `struct device` pointer in a C driver) for arbitrary purposes, e.g. =
allocating DMA coherent
> +/// memory.
> +///
> +/// # Invariants
> +///
> +/// The pointer stored in `Self` is non-null and valid for the lifetime =
of the `ARef` instance. In

There is no pointer stored in `Self` directly. I think you can just
remove the first sentence.

The second sentence can also be improved, see `Task` in
`rust/kernel/task.rs:42`.

> +/// particular, the `ARef` instance owns an increment on the underlying =
object=E2=80=99s reference count.
> +///
> +/// `bindings::device::release` is valid to be called from any thread, h=
ence `ARef<Device>` can be
> +/// dropped from any thread.
> +#[repr(transparent)]
> +pub struct Device(Opaque<bindings::device>);
> +
> +impl Device {
> +    /// Creates a new reference-counted abstraction instance of an exist=
ing `struct device` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` is valid, non-null, and has a non=
-zero reference count,
> +    /// i.e. it must be ensured that the reference count of the C `struc=
t device` `ptr` points to
> +    /// can't drop to zero, for the duration of this function call.
> +    ///
> +    /// It must also be ensured that `bindings::device::release` can be =
called from any thread.
> +    /// While not officially documented, this should be the case for any=
 `struct device`.
> +    pub unsafe fn from_raw(ptr: *mut bindings::device) -> ARef<Self> {
> +        // SAFETY: By the safety requirements, ptr is valid.
> +        // Initially increase the reference count by one to compensate f=
or the final decrement once
> +        // this newly created `ARef<Device>` instance is dropped.
> +        unsafe { bindings::get_device(ptr) };
> +
> +        // CAST: `Self` is a `repr(transparent)` wrapper around `binding=
s::device`.
> +        let ptr =3D ptr.cast::<Self>();
> +
> +        // SAFETY: By the safety requirements, ptr is valid.

That is not the only requirement on `from_raw`, you also need to own
a refcount (which you do) on `ptr`.

---
Cheers,
Benno

> +        unsafe { ARef::from_raw(ptr::NonNull::new_unchecked(ptr)) }
> +    }
> +
> +    /// Obtain the raw `struct device *`.
> +    pub(crate) fn as_raw(&self) -> *mut bindings::device {
> +        self.0.get()
> +    }
> +
> +    /// Convert a raw C `struct device` pointer to a `&'a Device`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` is valid, non-null, and has a non=
-zero reference count,
> +    /// i.e. it must be ensured that the reference count of the C `struc=
t device` `ptr` points to
> +    /// can't drop to zero, for the duration of this function call and t=
he entire duration when the
> +    /// returned reference exists.
> +    pub unsafe fn as_ref<'a>(ptr: *mut bindings::device) -> &'a Self {
> +        // SAFETY: Guaranteed by the safety requirements of the function=
.
> +        unsafe { &*ptr.cast() }
> +    }
> +}
> +
> +// SAFETY: Instances of `Device` are always reference-counted.
> +unsafe impl crate::types::AlwaysRefCounted for Device {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
> +        unsafe { bindings::get_device(self.as_raw()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s non-zero.
> +        unsafe { bindings::put_device(obj.cast().as_ptr()) }
> +    }
> +}
> +
> +// SAFETY: As by the type invariant `Device` can be sent to any thread.
> +unsafe impl Send for Device {}
> +
> +// SAFETY: `Device` can be shared among threads because all immutable me=
thods are protected by the
> +// synchronization in `struct device`.
> +unsafe impl Sync for Device {}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fbd91a48ff8b..dd1207f1a873 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -28,6 +28,7 @@
>=20
>  pub mod alloc;
>  mod build_assert;
> +pub mod device;
>  pub mod error;
>  pub mod init;
>  pub mod ioctl;
> --
> 2.45.1
>=20


