Return-Path: <linux-kernel+bounces-552438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 712E3A579E0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 12:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6205172702
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 11:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B801D5AA8;
	Sat,  8 Mar 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aXYgwpG8"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6AF1BC07B
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741431886; cv=none; b=lBv52loFcOMgYzvgCkMaJRjHoJkf+yLSykBXJ1FgbI3OCrAJ99+cznnQ6x5R5E7Ui7q6HnxEwptjFvubNxP8wqxqhWCjED9e9XArfWaxs0WsQ8Cti6s73gVVJJP4uo5WeObcGMSnn4ZMdacqKH7pXREC2LSi00SVBvATAERJ0Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741431886; c=relaxed/simple;
	bh=Cv8yLwbZ54ztujdJDy4GXf0RTyiqGT3c5Gf6cEjc1v4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opFkFwGJLHUGuhoPMtBCSH42RNZAAI70yYrObcpdtOGeotWyR4ZCWFncSzt1zR9DvSQSVDer5qnC12nFYservVSTnLshZOzILSFUh8tRU8Rs/TSHjCixp/wPMBYsnl22rqYy0gOeHTAptwFf9WlOJtpBiUI8XW4IjwjyVZFQ6ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aXYgwpG8; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741431882; x=1741691082;
	bh=YvmHMVnA0MqvSaMvuMvUz1JFqvgwrqZZuq2Id0CRuV0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=aXYgwpG88KJf3iRuDaenMerj4h+eJXDyLUjZCd27CCagywhhVxPURmvcnKmQFHeDY
	 iPbca8TG3Nl/vuDK9DhV70B5TJYfKzi297oRXK7mbspp/9NPOhnmwyOSKJFpTNLdHq
	 hQ8gq3rj8V734qMaY1HUUBTtWw0u/S25mbA9HEiJtTh0v7PeRvhFhsg1xNF7hT0b8F
	 tOmbQdqo2QpvHlUWTb9oggdL+m3VPqyILWQpTA9DzJSTQTHkDygPN9GzKdNE12Cnki
	 fziXuoOI/UCZ/VusDTKi9svnBlD+pAYMkJuWZj6cDmDwNmASu02ZTrKuFORf0esVjF
	 9CfCncfDtgTUA==
Date: Sat, 08 Mar 2025 11:04:38 +0000
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/22] rust: pin-init: move impl `Zeroable` for `Opaque` and `Option<KBox<T>>` into the kernel crate
Message-ID: <20250308110339.2997091-10-benno.lossin@proton.me>
In-Reply-To: <20250308110339.2997091-1-benno.lossin@proton.me>
References: <20250308110339.2997091-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1204f5869b32382a06f3112f30f27ea552541ce0
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
Tested-by: Andreas Hindborg <a.hindborg@kernel.org>
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
index f88465e0bb76..aad6486d33fc 100644
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



