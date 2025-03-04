Return-Path: <linux-kernel+bounces-545728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3538EA4F0C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34642188C9E8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9B251791;
	Tue,  4 Mar 2025 22:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="E4ICbS+h"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FE277020
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128831; cv=none; b=botoa9CBeCi18TXWR47CQxCbthFd4mn1QnGzVR53wfv6LVra/yESuRQDNnZOrbvq8EcgJ6BmzRfTk6ycJwhSPPyCBeJELskdaKtn2MDzSA2WLQ4415kGotKTZ1V76ISLM9mlx7k5HTAqJuMwToFR3m9jVZqRPDRVMCvW+8GxmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128831; c=relaxed/simple;
	bh=az6Q0Ud17khHJJMAoC+nzpq7PrQP7kvEuVyLyVlpK2s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtUW+ulCix0JwyZyxvuI00yZ++6imn3bFEB3TTeP+AwHbPiTOMhIN8V/rUWRQqRJkVVzU9IaFasbx49HI5PyQB5YTizmq9yQzwVqRKdIYFr0gfSJtFR6+ljmUkLAI0Yv3REHzZ8dCAo6rRvBumPmzqwMUENUwpQgVRel1LpOXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=E4ICbS+h; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128821; x=1741388021;
	bh=vCjmMujcSAwyT1oS3ztx64YxrIabIuLX9i3mBOZxMu8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=E4ICbS+hNVrOZr9Hdu1YfwY5pwQuHRCMq2OvnJeeLrmE21W0HPcWNHENHNb56nmuu
	 Y/O+L0mhncVUvnZCjyeEu+4AMJTdiZL8dhq9sJ55llggWRShr+Fcqc7qu4IJ9Fh1I1
	 cV1fEjJb5vndrGm/ymWPFOOVKWeE9xRkmU2NAWGHPu7KsVdli185Zj6wKWyow5QI9d
	 CzoXhxf2EGJWWigKlxLCHnMgEObQtoPxJhjhoDFvlPw3cPWrgjnmVdJM4eSQGYdlvt
	 P6NOQTyKYNj5bactJPBsftgeRPpTTECjfjl7Tw3vRRAZfpuaWK+H1zNkDzmTcie+0D
	 f/htEu2O9zHSg==
Date: Tue, 04 Mar 2025 22:53:36 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/22] rust: pin-init: move proc-macro documentation into pin-init crate
Message-ID: <20250304225245.2033120-5-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8a0d8c6c7612de12d50014c89cebc61e29edbf05
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Move the documentation of proc-macros from pin-init-internal into
pin-init. This is because documentation can only reference types from
dependencies and pin-init-internal cannot have pin-init as a dependency,
as that would be cyclic.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/internal/src/lib.rs | 109 +----------------------------
 rust/pin-init/src/lib.rs          | 111 ++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+), 106 deletions(-)

diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src=
/lib.rs
index 0a2761cc793c..bf66cbee2531 100644
--- a/rust/pin-init/internal/src/lib.rs
+++ b/rust/pin-init/internal/src/lib.rs
@@ -1,121 +1,18 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
=20
-/// Used to specify the pinning information of the fields of a struct.
-///
-/// This is somewhat similar in purpose as
-/// [pin-project-lite](https://crates.io/crates/pin-project-lite).
-/// Place this macro on a struct definition and then `#[pin]` in front of =
the attributes of each
-/// field you want to structurally pin.
-///
-/// This macro enables the use of the [`pin_init!`] macro. When pin-initia=
lizing a `struct`,
-/// then `#[pin]` directs the type of initializer that is required.
-///
-/// If your `struct` implements `Drop`, then you need to add `PinnedDrop` =
as arguments to this
-/// macro, and change your `Drop` implementation to `PinnedDrop` annotated=
 with
-/// `#[`[`macro@pinned_drop`]`]`, since dropping pinned values requires ex=
tra care.
-///
-/// # Examples
-///
-/// ```ignore
-/// # #![feature(lint_reasons)]
-/// # use kernel::prelude::*;
-/// # use std::{sync::Mutex, process::Command};
-/// # use kernel::macros::pin_data;
-/// #[pin_data]
-/// struct DriverData {
-///     #[pin]
-///     queue: Mutex<KVec<Command>>,
-///     buf: KBox<[u8; 1024 * 1024]>,
-/// }
-/// ```
-///
-/// ```ignore
-/// # #![feature(lint_reasons)]
-/// # use kernel::prelude::*;
-/// # use std::{sync::Mutex, process::Command};
-/// # use core::pin::Pin;
-/// # pub struct Info;
-/// # mod bindings {
-/// #     pub unsafe fn destroy_info(_ptr: *mut super::Info) {}
-/// # }
-/// use kernel::macros::{pin_data, pinned_drop};
-///
-/// #[pin_data(PinnedDrop)]
-/// struct DriverData {
-///     #[pin]
-///     queue: Mutex<KVec<Command>>,
-///     buf: KBox<[u8; 1024 * 1024]>,
-///     raw_info: *mut Info,
-/// }
-///
-/// #[pinned_drop]
-/// impl PinnedDrop for DriverData {
-///     fn drop(self: Pin<&mut Self>) {
-///         unsafe { bindings::destroy_info(self.raw_info) };
-///     }
-/// }
-/// # fn main() {}
-/// ```
-///
-/// [`pin_init!`]: ../kernel/macro.pin_init.html
-//  ^ cannot use direct link, since `kernel` is not a dependency of `macro=
s`.
+#[allow(missing_docs)]
 #[proc_macro_attribute]
 pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
     pin_data::pin_data(inner, item)
 }
=20
-/// Used to implement `PinnedDrop` safely.
-///
-/// Only works on structs that are annotated via `#[`[`macro@pin_data`]`]`=
.
-///
-/// # Examples
-///
-/// ```ignore
-/// # #![feature(lint_reasons)]
-/// # use kernel::prelude::*;
-/// # use macros::{pin_data, pinned_drop};
-/// # use std::{sync::Mutex, process::Command};
-/// # use core::pin::Pin;
-/// # mod bindings {
-/// #     pub struct Info;
-/// #     pub unsafe fn destroy_info(_ptr: *mut Info) {}
-/// # }
-/// #[pin_data(PinnedDrop)]
-/// struct DriverData {
-///     #[pin]
-///     queue: Mutex<KVec<Command>>,
-///     buf: KBox<[u8; 1024 * 1024]>,
-///     raw_info: *mut bindings::Info,
-/// }
-///
-/// #[pinned_drop]
-/// impl PinnedDrop for DriverData {
-///     fn drop(self: Pin<&mut Self>) {
-///         unsafe { bindings::destroy_info(self.raw_info) };
-///     }
-/// }
-/// ```
+#[allow(missing_docs)]
 #[proc_macro_attribute]
 pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
     pinned_drop::pinned_drop(args, input)
 }
=20
-/// Derives the [`Zeroable`] trait for the given struct.
-///
-/// This can only be used for structs where every field implements the [`Z=
eroable`] trait.
-///
-/// # Examples
-///
-/// ```ignore
-/// use kernel::macros::Zeroable;
-///
-/// #[derive(Zeroable)]
-/// pub struct DriverData {
-///     id: i64,
-///     buf_ptr: *mut u8,
-///     len: usize,
-/// }
-/// ```
+#[allow(missing_docs)]
 #[proc_macro_derive(Zeroable)]
 pub fn derive_zeroable(input: TokenStream) -> TokenStream {
     zeroable::derive(input)
diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
index 0307a08ccee9..df6962460874 100644
--- a/rust/pin-init/src/lib.rs
+++ b/rust/pin-init/src/lib.rs
@@ -218,6 +218,117 @@
 #[doc(hidden)]
 pub mod macros;
=20
+/// Used to specify the pinning information of the fields of a struct.
+///
+/// This is somewhat similar in purpose as
+/// [pin-project-lite](https://crates.io/crates/pin-project-lite).
+/// Place this macro on a struct definition and then `#[pin]` in front of =
the attributes of each
+/// field you want to structurally pin.
+///
+/// This macro enables the use of the [`pin_init!`] macro. When pin-initia=
lizing a `struct`,
+/// then `#[pin]` directs the type of initializer that is required.
+///
+/// If your `struct` implements `Drop`, then you need to add `PinnedDrop` =
as arguments to this
+/// macro, and change your `Drop` implementation to `PinnedDrop` annotated=
 with
+/// `#[`[`macro@pinned_drop`]`]`, since dropping pinned values requires ex=
tra care.
+///
+/// # Examples
+///
+/// ```ignore
+/// # #![feature(lint_reasons)]
+/// # use kernel::prelude::*;
+/// # use std::{sync::Mutex, process::Command};
+/// # use kernel::macros::pin_data;
+/// #[pin_data]
+/// struct DriverData {
+///     #[pin]
+///     queue: Mutex<KVec<Command>>,
+///     buf: KBox<[u8; 1024 * 1024]>,
+/// }
+/// ```
+///
+/// ```ignore
+/// # #![feature(lint_reasons)]
+/// # use kernel::prelude::*;
+/// # use std::{sync::Mutex, process::Command};
+/// # use core::pin::Pin;
+/// # pub struct Info;
+/// # mod bindings {
+/// #     pub unsafe fn destroy_info(_ptr: *mut super::Info) {}
+/// # }
+/// use kernel::macros::{pin_data, pinned_drop};
+///
+/// #[pin_data(PinnedDrop)]
+/// struct DriverData {
+///     #[pin]
+///     queue: Mutex<KVec<Command>>,
+///     buf: KBox<[u8; 1024 * 1024]>,
+///     raw_info: *mut Info,
+/// }
+///
+/// #[pinned_drop]
+/// impl PinnedDrop for DriverData {
+///     fn drop(self: Pin<&mut Self>) {
+///         unsafe { bindings::destroy_info(self.raw_info) };
+///     }
+/// }
+/// # fn main() {}
+/// ```
+///
+/// [`pin_init!`]: crate::pin_init
+pub use ::macros::pin_data;
+
+/// Used to implement `PinnedDrop` safely.
+///
+/// Only works on structs that are annotated via `#[`[`macro@pin_data`]`]`=
.
+///
+/// # Examples
+///
+/// ```ignore
+/// # #![feature(lint_reasons)]
+/// # use kernel::prelude::*;
+/// # use macros::{pin_data, pinned_drop};
+/// # use std::{sync::Mutex, process::Command};
+/// # use core::pin::Pin;
+/// # mod bindings {
+/// #     pub struct Info;
+/// #     pub unsafe fn destroy_info(_ptr: *mut Info) {}
+/// # }
+/// #[pin_data(PinnedDrop)]
+/// struct DriverData {
+///     #[pin]
+///     queue: Mutex<KVec<Command>>,
+///     buf: KBox<[u8; 1024 * 1024]>,
+///     raw_info: *mut bindings::Info,
+/// }
+///
+/// #[pinned_drop]
+/// impl PinnedDrop for DriverData {
+///     fn drop(self: Pin<&mut Self>) {
+///         unsafe { bindings::destroy_info(self.raw_info) };
+///     }
+/// }
+/// ```
+pub use ::macros::pinned_drop;
+
+/// Derives the [`Zeroable`] trait for the given struct.
+///
+/// This can only be used for structs where every field implements the [`Z=
eroable`] trait.
+///
+/// # Examples
+///
+/// ```ignore
+/// use kernel::macros::Zeroable;
+///
+/// #[derive(Zeroable)]
+/// pub struct DriverData {
+///     id: i64,
+///     buf_ptr: *mut u8,
+///     len: usize,
+/// }
+/// ```
+pub use ::macros::Zeroable;
+
 /// Initialize and pin a type directly on the stack.
 ///
 /// # Examples
--=20
2.47.2



