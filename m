Return-Path: <linux-kernel+bounces-545733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD1A4F0CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0B03ADB58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E71227C167;
	Tue,  4 Mar 2025 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fq2UswUO"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB671F4611;
	Tue,  4 Mar 2025 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128873; cv=none; b=iGTewmlDSXS5PW8npOSn1/itbhpC1HZFZ5oZBjXQH+KYXpEhaEkWQP2vBgLdKDpEIOEvd0tVbdGq+WWRSiHcg7ZRJiBSNlNwCJttk91X0BhI9LiFomJPzLqQj7k+AAJ2Yd7tWInmFha1zuowpHauA+gaiM0hi9yIwercVehi64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128873; c=relaxed/simple;
	bh=QYM/KZsr08dUOWKi39enstgK4vzuMEEcQupufK2iuHk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxBOYaPEtJSHSTGtv/O7gSe56sO4kU/TFpJ+/Cedi58qFagK3SRWwxglrzn8LsTplI/O17TUVYzMR13ifkSIw76YrKGonLVTZdtclXQ7cRFBQbYRFxc180j6Tvv0hsQCx48HSUNAgkR7h8339+kcUkrfikusFmB6dHaV4kNAv4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fq2UswUO; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ml7mmob3ijfpph32mhxgb2odpi.protonmail; t=1741128869; x=1741388069;
	bh=lGnM/FI8igBGIU3f/heCqjXG7yU1y0fum0npFdaJwiM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=fq2UswUOyfTy9b7qpML6nxG5uVdSBcYJNamdqUvz5fx8gTaGJ2iTGU808gXSWn8kh
	 Hb222ZY3G2kkXUEy/VbRNaqBUahAU800nLL9v/gTTEwgg9if5YWsS8H3K3XOmIGWSK
	 yXJlXybgtwgR713TAvDHgNTGcX1/vcNRDl0oFNLrPFvsajsuCqstjII1y7qnQfqktO
	 rmvnUoiMlKVKHuGRrWDOofeMR0dWoFaMGfYCBr1FiApyTGs4E3W3FQana5J/FZ7IJB
	 XzBo/2dulBOQNCkPamg8owSIu5pDA7EYcGrVkX74PrqsGfmW7bSKPx6IFob1VeHviS
	 lr6veGECZEA8Q==
Date: Tue, 04 Mar 2025 22:54:23 +0000
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/22] rust: pin-init: move impl `Zeroable` for `Opaque` and `Option<KBox<T>>` into the kernel crate
Message-ID: <20250304225245.2033120-10-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: feb4b354f9b3c64ac380e5ad9947f007b9d997c0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In order to make pin-init a standalone crate, move kernel-specific code
directly into the kernel crate. Since `Opaque<T>` and `KBox<T>` are part
of the kernel, move their `Zeroable` implementation into the kernel
crate.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/alloc/kbox.rs | 8 +++++++-
 rust/kernel/types.rs      | 5 ++++-
 rust/pin-init/src/lib.rs  | 8 +-------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 39a3ea7542da..9861433559dc 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -15,7 +15,7 @@
 use core::ptr::NonNull;
 use core::result::Result;
=20
-use crate::init::{InPlaceWrite, Init, PinInit};
+use crate::init::{InPlaceWrite, Init, PinInit, Zeroable};
 use crate::init_ext::InPlaceInit;
 use crate::types::ForeignOwnable;
=20
@@ -100,6 +100,12 @@
 /// ```
 pub type KVBox<T> =3D Box<T, super::allocator::KVmalloc>;
=20
+// SAFETY: All zeros is equivalent to `None` (option layout optimization g=
uarantee).
+//
+// In this case we are allowed to use `T: ?Sized`, since all zeros is the =
`None` variant and there
+// is no problem with a VTABLE pointer being null.
+unsafe impl<T: ?Sized, A: Allocator> Zeroable for Option<Box<T, A>> {}
+
 // SAFETY: `Box` is `Send` if `T` is `Send` because the `Box` owns a `T`.
 unsafe impl<T, A> Send for Box<T, A>
 where
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2bbaab83b9d6..9f75bd3866e8 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,7 +2,7 @@
=20
 //! Kernel types.
=20
-use crate::init::{self, PinInit};
+use crate::init::{self, PinInit, Zeroable};
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
@@ -309,6 +309,9 @@ pub struct Opaque<T> {
     _pin: PhantomPinned,
 }
=20
+// SAFETY: `Opaque<T>` allows the inner value to be any bit pattern, inclu=
ding all zeros.
+unsafe impl<T> Zeroable for Opaque<T> {}
+
 impl<T> Opaque<T> {
     /// Creates a new opaque value.
     pub const fn new(value: T) -> Self {
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 49e31228c14a..5fd8fa7c2ce9 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -211,10 +211,7 @@
 //! [`pin_data`]: ::macros::pin_data
 //! [`pin_init!`]: crate::pin_init!
=20
-use crate::{
-    alloc::KBox,
-    types::{Opaque, ScopeGuard},
-};
+use crate::{alloc::KBox, types::ScopeGuard};
 use core::{
     cell::UnsafeCell,
     convert::Infallible,
@@ -1342,8 +1339,6 @@ macro_rules! impl_zeroable {
=20
     // SAFETY: Type is allowed to take any value, including all zeros.
     {<T>} MaybeUninit<T>,
-    // SAFETY: Type is allowed to take any value, including all zeros.
-    {<T>} Opaque<T>,
=20
     // SAFETY: `T: Zeroable` and `UnsafeCell` is `repr(transparent)`.
     {<T: ?Sized + Zeroable>} UnsafeCell<T>,
@@ -1358,7 +1353,6 @@ macro_rules! impl_zeroable {
     //
     // In this case we are allowed to use `T: ?Sized`, since all zeros is =
the `None` variant.
     {<T: ?Sized>} Option<NonNull<T>>,
-    {<T: ?Sized>} Option<KBox<T>>,
=20
     // SAFETY: `null` pointer is valid.
     //
--=20
2.47.2



