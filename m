Return-Path: <linux-kernel+bounces-244880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC93E92AAC8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665F21F22517
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA30514EC40;
	Mon,  8 Jul 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Dk+AQc69"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0884014E2C4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472038; cv=none; b=mcAqRJZvlUiWvUfiV0GECM5mhp+Q3VM6kyFyz9tv3w8ZEqBl1C1UzZdzHSZKXjvdB8X6MUH3baresL+RoXNbsig2kcChNPhJJhTJVpSbL26V+61a+xAzj7XkA1X5m3Z9ZGL7dRjMvxZU2yRry4aVCn+1Chuk06XSjO64YOYRPf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472038; c=relaxed/simple;
	bh=M50r1p+wX+D8O/Gj9/J9aTnngzd/9LCvtljgGPuAQps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3wUROjx+Ec7MupmHZk6Z5iweq/lLWxkGmA1qEmrEnCDVUWMvy2EeWgtHidYQGOWnQGe7ZmfFeL6mTAokwxtDL2kjIyxY1Qj7+CPLz8ZrZR+QI3nXPc1AksNFsNvsPNnqZ3mkXdBBFpdC9f2qORlVq2a6z+K4iCCeMz46xV5Vk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Dk+AQc69; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bqbxzyfywbabng7dcfeap4poum.protonmail; t=1720472029; x=1720731229;
	bh=Ya6tGpyaUQLdXjSguh1J6q5GTPWFH0r0g0wkmTrbCiA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Dk+AQc692Me/3mqQ6qrOs3hnrzRvDh80+ZcL9F2dtmEZzx9YZhBye1mdFPqG2ya9t
	 i768IQWN87nSFOfjNSUQ81fa0MCsum1iDjwoLvyFLMLQVKOqPDoPRa1hXLMc1XFFP2
	 nLRYGGPJ6SyLUwTw9s4RqoO/ZM0AE/2rUp0alG3PaAS2nWEAGezqhdQH6XQFD/iIsH
	 iMNMhB1m6j+y9rvpBo+FSgQfgHp+wp1JUJeNO9Ixh0oU+rwDC1jzNFB7DkxnrxoxiF
	 YPhCNuk3k3Vrj4DNDVivT4GXfIN9/CgbxE0om0OtBEcOv+EVVL+r0Hdjb185C7Jsz6
	 b23kC7+VZTddQ==
Date: Mon, 08 Jul 2024 20:53:46 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] rust: init: add `write_[pin_]init` functions
Message-ID: <20240708205325.1275473-2-benno.lossin@proton.me>
In-Reply-To: <20240708205325.1275473-1-benno.lossin@proton.me>
References: <20240708205325.1275473-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6389381ecf3d1c44981fa7e9970a6c93895262d5
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
index 9608f2bd2211..35c4d9b75a97 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1159,13 +1159,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: =
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
@@ -1173,13 +1167,7 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) =
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
@@ -1189,13 +1177,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>, flags: =
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
@@ -1203,13 +1185,67 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags)=
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
2.44.0



