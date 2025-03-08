Return-Path: <linux-kernel+bounces-552442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A48A579E3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19FC189A372
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFAE1DC99A;
	Sat,  8 Mar 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ecXxLDh8"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84481DDA0F;
	Sat,  8 Mar 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431900; cv=none; b=eSmEG598I1D1qp3iQK9zycHWmqEm9GzO2pjpC9TjayorwBusNTsEglUFxPeQqUM1egbtrtgS6Hg/QI5Yod2O46rgkC3Lt8hYRW/GNBjb66cNnh66AMlfN3qI/TFHlct+8DPJ8oPlG8OSK2I/UC9u0Rq6gm0UFdSRpYqYgMlriNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431900; c=relaxed/simple;
	bh=QNgZFBY/Dzaz9nyjrEQxwqnODE7QCPw4W7K2uib3xts=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iv152cwtHGVBtP7W3M0zjr0ra35NRwhJL7CofPCM7RUZI6nx14gXiBRLvP2hyuAbl8RewaqeJSU+NxcFRHBDIrxeMgWp//KaSdh+XdHZwWEyiEQfLnh95QBwbsIaZSQrWrMzx9UAOjAuqmmZtLl9ysEOn3W7pjFbiKHKwTUrAh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ecXxLDh8; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bc326m62obbrlbb3reaerfvkhq.protonmail; t=1741431896; x=1741691096;
	bh=9dQq2Y19fn9p4RwJZKhOKeMBVN1bW2dQAVL+BoE0sVA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ecXxLDh84gO3GdUwNNBsYh8rNlFLJtGE8/CWs8nWUj0mlRBFk+MK58SiY7mw/LTiC
	 lKadw8P6BfOWlP+3YDSLWv4SJTdSqehd7yPwkrThBoL+YFxx3VhR53XP8xmfaggBoo
	 OTPmX68dxOyk3Md6aZ8ja71J4ncwvZ8sK8RG9/SazmG/OB4TbLi8hGuN9UHaYhrP4A
	 rKz5NwPhwbE+TGjAgIPXerfy7AutMohMCN9ohmMhglf5iVMi8eJa6NsvgurodeDDw1
	 JZvh3uYzuSBi/3AF0BOwojOqBeIWLLVrE5C4YBGBZF2zruSdKLA2M0UJDQfxK3M1Va
	 05utkanpL98Gw==
Date: Sat, 08 Mar 2025 11:04:52 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Fiona Behrens <me@kloenk.dev>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/22] rust: pin-init: remove kernel-crate dependency
Message-ID: <20250308110339.2997091-13-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6becb1ddac76725f375e2ef98f39af8e9723ae09
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In order to make pin-init a standalone crate, remove dependencies on
kernel-specific code such as `ScopeGuard` and `KBox`.

`ScopeGuard` is only used in the `[pin_]init_array_from_fn` functions
and can easily be replaced by a primitive construct.

`KBox` is only used for type variance of unsized types and can also
easily be replaced.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/pin-init/src/__internal.rs |  5 +++-
 rust/pin-init/src/lib.rs        | 41 +++++++++++----------------------
 2 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal=
.rs
index 0db800819681..8a53f55e1bbf 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -11,6 +11,9 @@
=20
 /// See the [nomicon] for what subtyping is. See also [this table].
 ///
+/// The reason for not using `PhantomData<*mut T>` is that that type never=
 implements [`Send`] and
+/// [`Sync`]. Hence `fn(*mut T) -> *mut T` is used, as that type always im=
plements them.
+///
 /// [nomicon]: https://doc.rust-lang.org/nomicon/subtyping.html
 /// [this table]: https://doc.rust-lang.org/nomicon/phantom-data.html#tabl=
e-of-phantomdata-patterns
 pub(super) type Invariant<T> =3D PhantomData<fn(*mut T) -> *mut T>;
@@ -105,7 +108,7 @@ fn make_closure<F, O, E>(self, f: F) -> F
     }
 }
=20
-pub struct AllData<T: ?Sized>(PhantomData<fn(KBox<T>) -> KBox<T>>);
+pub struct AllData<T: ?Sized>(Invariant<T>);
=20
 impl<T: ?Sized> Clone for AllData<T> {
     fn clone(&self) -> Self {
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 47954bc1dc2f..5f1afd3abb56 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -212,7 +212,6 @@
 //! [`pin_data`]: ::macros::pin_data
 //! [`pin_init!`]: crate::pin_init!
=20
-use crate::{alloc::KBox, types::ScopeGuard};
 use core::{
     cell::UnsafeCell,
     convert::Infallible,
@@ -944,7 +943,7 @@ fn pin_chain<F>(self, f: F) -> ChainPinInit<Self, F, T,=
 E>
 }
=20
 /// An initializer returned by [`PinInit::pin_chain`].
-pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E=
, KBox<T>)>);
+pub struct ChainPinInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E=
, T)>);
=20
 // SAFETY: The `__pinned_init` function is implemented such that it
 // - returns `Ok(())` on successful initialization,
@@ -1043,7 +1042,7 @@ fn chain<F>(self, f: F) -> ChainInit<Self, F, T, E>
 }
=20
 /// An initializer returned by [`Init::chain`].
-pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, K=
Box<T>)>);
+pub struct ChainInit<I, F, T: ?Sized, E>(I, F, __internal::Invariant<(E, T=
)>);
=20
 // SAFETY: The `__init` function is implemented such that it
 // - returns `Ok(())` on successful initialization,
@@ -1140,25 +1139,19 @@ pub fn init_array_from_fn<I, const N: usize, T, E>(
 {
     let init =3D move |slot: *mut [T; N]| {
         let slot =3D slot.cast::<T>();
-        // Counts the number of initialized elements and when dropped drop=
s that many elements from
-        // `slot`.
-        let mut init_count =3D ScopeGuard::new_with_data(0, |i| {
-            // We now free every element that has been initialized before.
-            // SAFETY: The loop initialized exactly the values from 0..i a=
nd since we
-            // return `Err` below, the caller will consider the memory at =
`slot` as
-            // uninitialized.
-            unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_mut(slot=
, i)) };
-        });
         for i in 0..N {
             let init =3D make_init(i);
             // SAFETY: Since 0 <=3D `i` < N, it is still in bounds of `[T;=
 N]`.
             let ptr =3D unsafe { slot.add(i) };
             // SAFETY: The pointer is derived from `slot` and thus satisfi=
es the `__init`
             // requirements.
-            unsafe { init.__init(ptr) }?;
-            *init_count +=3D 1;
+            if let Err(e) =3D unsafe { init.__init(ptr) } {
+                // SAFETY: The loop has initialized the elements `slot[0..=
i]` and since we return
+                // `Err` below, `slot` will be considered uninitialized me=
mory.
+                unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_mut(=
slot, i)) };
+                return Err(e);
+            }
         }
-        init_count.dismiss();
         Ok(())
     };
     // SAFETY: The initializer above initializes every element of the arra=
y. On failure it drops
@@ -1189,25 +1182,19 @@ pub fn pin_init_array_from_fn<I, const N: usize, T,=
 E>(
 {
     let init =3D move |slot: *mut [T; N]| {
         let slot =3D slot.cast::<T>();
-        // Counts the number of initialized elements and when dropped drop=
s that many elements from
-        // `slot`.
-        let mut init_count =3D ScopeGuard::new_with_data(0, |i| {
-            // We now free every element that has been initialized before.
-            // SAFETY: The loop initialized exactly the values from 0..i a=
nd since we
-            // return `Err` below, the caller will consider the memory at =
`slot` as
-            // uninitialized.
-            unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_mut(slot=
, i)) };
-        });
         for i in 0..N {
             let init =3D make_init(i);
             // SAFETY: Since 0 <=3D `i` < N, it is still in bounds of `[T;=
 N]`.
             let ptr =3D unsafe { slot.add(i) };
             // SAFETY: The pointer is derived from `slot` and thus satisfi=
es the `__init`
             // requirements.
-            unsafe { init.__pinned_init(ptr) }?;
-            *init_count +=3D 1;
+            if let Err(e) =3D unsafe { init.__pinned_init(ptr) } {
+                // SAFETY: The loop has initialized the elements `slot[0..=
i]` and since we return
+                // `Err` below, `slot` will be considered uninitialized me=
mory.
+                unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_mut(=
slot, i)) };
+                return Err(e);
+            }
         }
-        init_count.dismiss();
         Ok(())
     };
     // SAFETY: The initializer above initializes every element of the arra=
y. On failure it drops
--=20
2.47.2



