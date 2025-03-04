Return-Path: <linux-kernel+bounces-545736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F2BA4F0D0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8488B3AE3A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD327CB0C;
	Tue,  4 Mar 2025 22:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lu890nF2"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9CC2780FD;
	Tue,  4 Mar 2025 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128901; cv=none; b=I3b6VoloJLIlKZ5B5juh4830Joxix2lexIJkJk9Z/FuHDAiiCA7gpBT71l7DGP45+MIBBZzTLJRo6mQG7zJje19uQT3sclv+hp1WkTYPArJUXoNld37Jyph+UxB4BxlClCUmFpcG//vtvNGQ5RrsWaM7xXJw9tHSSvikwTgt8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128901; c=relaxed/simple;
	bh=YGcxWovgTt7oPIdYo2UpptMwyVRBOkLsGci6ByclW94=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJpZZjfxiAVEaK2t9+xQWP3vvuduwr/GCrhE/3PDuvCpnrHBopvizOutIYNQzG90plrNNdhyLpy4Q3vrl3OInMla/3KCYDC/Z7dLzRdfVw3Z9MRclDvmKbHTQZyyn2llozlYy8nqhltjBDQXisRur9dQ8j257Ba7Cl+TMkyJEhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lu890nF2; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xaydcod4mbfyrda7wshyu67rkq.protonmail; t=1741128897; x=1741388097;
	bh=+/mmPkOVWnePA5lDhs7G8cFxv5QvuKB44NIyKF+a9b8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lu890nF2EzFDgyDr/nJOYZf3TfmcqqDpaLyqkbbYNdRJSrNXTZXEwFAoCCla0BKeg
	 p6FnVA3gWAc/CPWlDgJloxSZPQ2dg1cIagNdtGYXnObdP0Bruvzt/e9S0i2RJDgzRQ
	 jOn2A9yZ+Cj4e/1vdnUgThzK+PcOT5F2wVTyt8ZejP5VnzSS9vluveS5lu2w2f6Tui
	 JKlPkuP93IT+wu4k8w/n9tkBBLgvglxk+/NKLz+UB+8VDa2srHUw27tC36/SjebU3e
	 oDucltEZON0b68pgebH+BDClURY4NY08kRF1MgSvRZm9v4AS98wGQsYB7zA0QbzgwH
	 ZdGx8YOzZ9/FQ==
Date: Tue, 04 Mar 2025 22:54:50 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/22] rust: pin-init: remove kernel-crate dependency
Message-ID: <20250304225245.2033120-13-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9eefb34738cf566a71ced950b67258bfde1e9001
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
---
 rust/pin-init/src/__internal.rs |  2 +-
 rust/pin-init/src/lib.rs        | 41 +++++++++++----------------------
 2 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal=
.rs
index 0db800819681..74086365a18a 100644
--- a/rust/pin-init/src/__internal.rs
+++ b/rust/pin-init/src/__internal.rs
@@ -105,7 +105,7 @@ fn make_closure<F, O, E>(self, f: F) -> F
     }
 }
=20
-pub struct AllData<T: ?Sized>(PhantomData<fn(KBox<T>) -> KBox<T>>);
+pub struct AllData<T: ?Sized>(Invariant<T>);
=20
 impl<T: ?Sized> Clone for AllData<T> {
     fn clone(&self) -> Self {
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 4e1c57a358c2..29c0920d1bfe 100644
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



