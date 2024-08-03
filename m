Return-Path: <linux-kernel+bounces-273505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA2946A0A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 16:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C39E281DE2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ADCC8F3;
	Sat,  3 Aug 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HV0n45/U"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B4139597
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722694634; cv=none; b=BEKfzQlBN67gMUP4OIrLyxCVxx/0vrj5ui8VOiBg3j4y5/A5c0kq1cs1jP4LOVHpIBgDBrO2n+xAShuP9li5Q41k50YbQVIFMfvPPnCoVJoWd7RKSytA8xwo/55VfKNuXvRXBUknEY19N1GnZG9mLvBLALu39Di39adDwX6YP40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722694634; c=relaxed/simple;
	bh=+Wz/JzyO/naFy2iv92vbkWTby2zuodX2V+rVk2GbOig=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9HETMZWZp/ZPzzLep3LdvYBEpiQ6hmdjx7O96pEwhC2nJqV4kXawE0m5sB90yzZ5Xbbcg7z0yAHSI3H7WBqHJrK+CHhKe5Ye0QC+YuQnzwO5sgvob9KrIBgAG9qNydGxu0hPS7zf11xylxvhFpVch8n2XUsnjdbn+HwErbvYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HV0n45/U; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=5w2iepqulvfafch45xcsfmkhy4.protonmail; t=1722694630; x=1722953830;
	bh=VBEiPMDKUfBvlgmknURWvfBzxOEScFpdr4XW+bF7XLI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HV0n45/UgbtYdkYQGwSEXR096BQaLjj9gLbSUBi4J1/QMGf5ycZnjOLeuE3iKFcdl
	 c3UP7sjH8RTnSfDvOxOgRN/fTKASSToSa0jyQxTsVXO48IOasRmFxzbygsqWDXtPOq
	 uCsLPV1BuBrDEKx/q/9fdePXWXRver7v6hPDmMn16IP28653+9WEZGV/Thr8r06KgI
	 J2wr7vvf+ZwFaLRWQVPyGGAHcs66vXYAzcnw0u4RKfUVVBN2Z0X4/9QGCrISzkmMMg
	 z0rOc4zwZ+NI5kaf9FMVWTrIfkBeIpQbubvh7dohI2+woiw9+GCRIDTgWIY/CL3ZcR
	 YChguBTtATX/A==
Date: Sat, 03 Aug 2024 14:17:03 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] rust: init: add `write_[pin_]init` functions
Message-ID: <20240803141639.3237686-2-benno.lossin@proton.me>
In-Reply-To: <20240803141639.3237686-1-benno.lossin@proton.me>
References: <20240803141639.3237686-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f3cfd9de4165d3ff9f6272329a422dda40e0dd95
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sometimes it is necessary to split allocation and initialization into
two steps. One such situation is when reusing existing allocations
obtained via `Box::drop_contents`. See [1] for an example.
In order to support this use case add `write_[pin_]init` functions to the
pin-init API. These functions operate on already allocated smart
pointers that wrap `MaybeUninit<T>`.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/rust-for-linux/f026532f-8594-4f18-9aa5-57ad3f=
5bc592@proton.me/ [1]
---
 rust/kernel/init.rs    | 84 ++++++++++++++++++++++++++++++------------
 rust/kernel/prelude.rs |  2 +-
 2 files changed, 61 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 495c09ebe3a3..1c3cfad89165 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1154,13 +1154,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: =
Flags) -> Result<Pin<Self>,
     where
         E: From<AllocError>,
     {
-        let mut this =3D <Box<_> as BoxExt<_>>::new_uninit(flags)?;
-        let slot =3D this.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
-        // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() }.into())
+        <Box<_> as BoxExt<_>>::new_uninit(flags)?.write_pin_init(init)
     }
=20
     #[inline]
@@ -1168,13 +1162,7 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) =
-> Result<Self, E>
     where
         E: From<AllocError>,
     {
-        let mut this =3D <Box<_> as BoxExt<_>>::new_uninit(flags)?;
-        let slot =3D this.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
-        // slot is valid.
-        unsafe { init.__init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() })
+        <Box<_> as BoxExt<_>>::new_uninit(flags)?.write_init(init)
     }
 }
=20
@@ -1184,13 +1172,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: =
Flags) -> Result<Pin<Self>,
     where
         E: From<AllocError>,
     {
-        let mut this =3D UniqueArc::new_uninit(flags)?;
-        let slot =3D this.as_mut_ptr();
-        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
-        // slot is valid and will not be moved, because we pin it later.
-        unsafe { init.__pinned_init(slot)? };
-        // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() }.into())
+        UniqueArc::new_uninit(flags)?.write_pin_init(init)
     }
=20
     #[inline]
@@ -1198,13 +1180,67 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags)=
 -> Result<Self, E>
     where
         E: From<AllocError>,
     {
-        let mut this =3D UniqueArc::new_uninit(flags)?;
-        let slot =3D this.as_mut_ptr();
+        UniqueArc::new_uninit(flags)?.write_init(init)
+    }
+}
+
+/// Smart pointer containing uninitialized memory and that can write a val=
ue.
+pub trait InPlaceWrite<T> {
+    /// The type `Self` turns into when the contents are initialized.
+    type Initialized;
+
+    /// Use the given initializer to write a value into `self`.
+    ///
+    /// Does not drop the current value and considers it as uninitialized =
memory.
+    fn write_init<E>(self, init: impl Init<T, E>) -> Result<Self::Initiali=
zed, E>;
+
+    /// Use the given pin-initializer to write a value into `self`.
+    ///
+    /// Does not drop the current value and considers it as uninitialized =
memory.
+    fn write_pin_init<E>(self, init: impl PinInit<T, E>) -> Result<Pin<Sel=
f::Initialized>, E>;
+}
+
+impl<T> InPlaceWrite<T> for Box<MaybeUninit<T>> {
+    type Initialized =3D Box<T>;
+
+    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Init=
ialized, E> {
+        let slot =3D self.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
         // slot is valid.
         unsafe { init.__init(slot)? };
         // SAFETY: All fields have been initialized.
-        Ok(unsafe { this.assume_init() })
+        Ok(unsafe { self.assume_init() })
+    }
+
+    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin=
<Self::Initialized>, E> {
+        let slot =3D self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { self.assume_init() }.into())
+    }
+}
+
+impl<T> InPlaceWrite<T> for UniqueArc<MaybeUninit<T>> {
+    type Initialized =3D UniqueArc<T>;
+
+    fn write_init<E>(mut self, init: impl Init<T, E>) -> Result<Self::Init=
ialized, E> {
+        let slot =3D self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid.
+        unsafe { init.__init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { self.assume_init() })
+    }
+
+    fn write_pin_init<E>(mut self, init: impl PinInit<T, E>) -> Result<Pin=
<Self::Initialized>, E> {
+        let slot =3D self.as_mut_ptr();
+        // SAFETY: When init errors/panics, slot will get deallocated but =
not dropped,
+        // slot is valid and will not be moved, because we pin it later.
+        unsafe { init.__pinned_init(slot)? };
+        // SAFETY: All fields have been initialized.
+        Ok(unsafe { self.assume_init() }.into())
     }
 }
=20
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index b37a0b3180fb..4571daec0961 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -37,6 +37,6 @@
=20
 pub use super::{str::CStr, ThisModule};
=20
-pub use super::init::{InPlaceInit, Init, PinInit};
+pub use super::init::{InPlaceInit, InPlaceWrite, Init, PinInit};
=20
 pub use super::current;
--=20
2.45.2



