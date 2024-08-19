Return-Path: <linux-kernel+bounces-291952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C64A5956949
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA921C21566
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C743E1667E1;
	Mon, 19 Aug 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ri/BvfJK"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A351662F8;
	Mon, 19 Aug 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066703; cv=none; b=KScAnf3B80wSJyq3t1IqXWbO+IGbb00OhhasQtR1Vur0d3vM+lmqRROPUK+/lG7iadUo6G0XuhFpKNCFyTJ/s0O0resc5fi48TZmSFStrkASPURP+LMzOgUj2hPVf8gfrk44BY+j7CgyODIVkYJS8ZQS8nxJZnRV2W5A5SapZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066703; c=relaxed/simple;
	bh=OEhg4+4NgFoWZdQTcDfb7RN3PRIxTJo86WNF9W77sHc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mj/gmuLaxS8gOkcIYBL4AMbKOWrXdhwYo2u5LQ6WJhnz5SDkjzbTBd9Z/87v1KUkaOUANkYT+tk16FI+SD2WGyzp6Tqde9PVHADxqtWCC1+6C0+l6Bz4DbRJgjM45sVtXNF1WyEHGTSdTlp3yWr1Tmge3vVlTvJ1maALunivJlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ri/BvfJK; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724066700; x=1724325900;
	bh=ekC0hZ33vLEALrIbcNG5Fi6IKIlXVqV7q/+8PKPYqpA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ri/BvfJKll4t237sJakBgKRVM8LFWWVuAsXimtSV2jgKldCPIEqDLv630y046l+jg
	 AevqJwMiTPIvvRX4d4fSKP0sAoNwrF3LkuqXcEL9WvosNHKuWLzNeY2k/zIKlreiTt
	 u78RZ4zE9tsfpSOWXAJ5lfD2jsZd5MTLBcLh7/m5ljhdGNwm1rxvnuyN8waMyc4g2S
	 PDkmShPAaCi3pjQVB59uR+GzfjuCm8QzEuYajN/okJwUluUjYa+CdjH5TXw5NkjI0F
	 b98UV69cT3yJIDG7wxW3vcxv1a2+pXNGaVZNNLWwyMOKuoioO65VyUQOR7OAtebgTt
	 2TZQcTh10A+SA==
Date: Mon, 19 Aug 2024 11:24:39 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] rust: init: add `write_[pin_]init` functions
Message-ID: <20240819112415.99810-2-benno.lossin@proton.me>
In-Reply-To: <20240819112415.99810-1-benno.lossin@proton.me>
References: <20240819112415.99810-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 843fbb34f02895b1b167d0d052e11d95215c2747
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
index 771701805a97..a8068f99fcaa 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1183,13 +1183,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: =
Flags) -> Result<Self::Pinne
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
@@ -1197,13 +1191,7 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) =
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
@@ -1215,13 +1203,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: =
Flags) -> Result<Self::Pinne
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
@@ -1229,13 +1211,67 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags)=
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



