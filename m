Return-Path: <linux-kernel+bounces-545742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6FCA4F0D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25FD7A367D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1649527D77E;
	Tue,  4 Mar 2025 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Z7v2yPLi"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B227C86A;
	Tue,  4 Mar 2025 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128963; cv=none; b=gBB+lfKfArVByupbNO5MaSlNmPJUbx3I4b4ia+rtZWnbL/zidp0W/bMgcqt5dJLslDvTjb5YXDrzi0DxX2mUTxuLG28mAAWT/0NrmRcmBrRp/59EC1Us5+P07cq4kUgBBWblcbubdxtOa3Drpa0riisKVKChMQJRE3DXSzUjnSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128963; c=relaxed/simple;
	bh=y+Dp6mzFNWY1seM1AZEtKhcT5s715UfnWSESbegzT24=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLBW5fKC3hnN6GHoJw12hRXr9Kl0xNcYb43GPysQkXtJ0EiftK1dUExgXIu/wxE3CSxdwNh5pL5D4D9jkSj8AJ0mKSYEb4EYi5QaTvbpMXBL6w5bYm3+HHx+6+XOdtB+DXcoF0wjl6sOzAY6aiatOKgUI+oZmR0UTWWTIE4IaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Z7v2yPLi; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741128959; x=1741388159;
	bh=Nphs9UOdohoaKlRWuIgVc75QAjk0JeO6llKw3EfG8Kg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Z7v2yPLiWFHNH6L7dVFILqD722+PcSsWMNX+K/CCeeG2WOzfo11tc7WhggmmIlRai
	 B95ZkuNXJx5QsWJzvfZFARBvmyfu1L4+/mBHDtklM86c6gQ8BfYR5xClJo9Y0P6zKz
	 2yzdlU2Sq8noqUKlFSc/uBIHIgj3v+EUDUmUZX0/7Mk0NkbyJKbwHis+krAwkkSMIb
	 nEZB4gAPuaNdWRL7JZcWNh5aDXU3c5azFSWncSdZLTHp3Q6OUyJWthuXNPBxjLJ++L
	 +3NMLJNEkWxo66vX6JRi4RyVBtMwjw8GK73mNyD50lGWF6T/G9NDkTmNRyRWEMj6ME
	 Gs5/4FjfXKJDQ==
Date: Tue, 04 Mar 2025 22:55:52 +0000
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/22] rust: pin-init: internal: synchronize with user-space version
Message-ID: <20250304225245.2033120-19-benno.lossin@proton.me>
In-Reply-To: <20250304225245.2033120-1-benno.lossin@proton.me>
References: <20250304225245.2033120-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f2073127e2161c7172385f6e5cb03a6ef028214f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This commit synchronizes with the user-space version that uses the
quote crate [1] instead of a custom `quote!` macro.
The imports in the different version are achieved using `cfg` on the
kernel config value. This is always set in the kernel and never set in
the user-space version.

Since the quote crate requires the proc_macro2 crate, imports also need
to be adjusted and `.into()` calls have to be inserted.

Link: https://crates.io/crates/quote [1]
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/pin-init/internal/src/helpers.rs     |  3 +++
 rust/pin-init/internal/src/lib.rs         | 16 +++++++++++++---
 rust/pin-init/internal/src/pin_data.rs    |  3 +++
 rust/pin-init/internal/src/pinned_drop.rs |  3 +++
 rust/pin-init/internal/src/zeroable.rs    |  3 +++
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/rust/pin-init/internal/src/helpers.rs b/rust/pin-init/internal=
/src/helpers.rs
index 78521ba19d0b..236f989a50f2 100644
--- a/rust/pin-init/internal/src/helpers.rs
+++ b/rust/pin-init/internal/src/helpers.rs
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
=20
+#[cfg(not(kernel))]
+use proc_macro2 as proc_macro;
+
 use proc_macro::{TokenStream, TokenTree};
=20
 /// Parsed generics.
diff --git a/rust/pin-init/internal/src/lib.rs b/rust/pin-init/internal/src=
/lib.rs
index c201b8a53915..30e145f80bc0 100644
--- a/rust/pin-init/internal/src/lib.rs
+++ b/rust/pin-init/internal/src/lib.rs
@@ -7,6 +7,13 @@
 //! `pin-init` proc macros.
=20
 #![cfg_attr(not(RUSTC_LINT_REASONS_IS_STABLE), feature(lint_reasons))]
+// Allow `.into()` to convert
+// - `proc_macro2::TokenStream` into `proc_macro::TokenStream` in the user=
-space version.
+// - `proc_macro::TokenStream` into `proc_macro::TokenStream` in the kerne=
l version.
+//   Clippy warns on this conversion, but it's required by the user-space =
version.
+//
+// Remove once we have `proc_macro2` in the kernel.
+#![allow(clippy::useless_conversion)]
=20
 use proc_macro::TokenStream;
=20
@@ -14,6 +21,9 @@
 #[path =3D "../../../macros/quote.rs"]
 #[macro_use]
 mod quote;
+#[cfg(not(kernel))]
+#[macro_use]
+extern crate quote;
=20
 mod helpers;
 mod pin_data;
@@ -23,17 +33,17 @@
 #[allow(missing_docs)]
 #[proc_macro_attribute]
 pub fn pin_data(inner: TokenStream, item: TokenStream) -> TokenStream {
-    pin_data::pin_data(inner, item)
+    pin_data::pin_data(inner.into(), item.into()).into()
 }
=20
 #[allow(missing_docs)]
 #[proc_macro_attribute]
 pub fn pinned_drop(args: TokenStream, input: TokenStream) -> TokenStream {
-    pinned_drop::pinned_drop(args, input)
+    pinned_drop::pinned_drop(args.into(), input.into()).into()
 }
=20
 #[allow(missing_docs)]
 #[proc_macro_derive(Zeroable)]
 pub fn derive_zeroable(input: TokenStream) -> TokenStream {
-    zeroable::derive(input)
+    zeroable::derive(input.into()).into()
 }
diff --git a/rust/pin-init/internal/src/pin_data.rs b/rust/pin-init/interna=
l/src/pin_data.rs
index 9b974498f4a8..87d4a7eb1d35 100644
--- a/rust/pin-init/internal/src/pin_data.rs
+++ b/rust/pin-init/internal/src/pin_data.rs
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
=20
+#[cfg(not(kernel))]
+use proc_macro2 as proc_macro;
+
 use crate::helpers::{parse_generics, Generics};
 use proc_macro::{Group, Punct, Spacing, TokenStream, TokenTree};
=20
diff --git a/rust/pin-init/internal/src/pinned_drop.rs b/rust/pin-init/inte=
rnal/src/pinned_drop.rs
index 386f52f73c06..c824dd8b436d 100644
--- a/rust/pin-init/internal/src/pinned_drop.rs
+++ b/rust/pin-init/internal/src/pinned_drop.rs
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
=20
+#[cfg(not(kernel))]
+use proc_macro2 as proc_macro;
+
 use proc_macro::{TokenStream, TokenTree};
=20
 pub(crate) fn pinned_drop(_args: TokenStream, input: TokenStream) -> Token=
Stream {
diff --git a/rust/pin-init/internal/src/zeroable.rs b/rust/pin-init/interna=
l/src/zeroable.rs
index 0cf6732f27dc..acc94008c152 100644
--- a/rust/pin-init/internal/src/zeroable.rs
+++ b/rust/pin-init/internal/src/zeroable.rs
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
=20
+#[cfg(not(kernel))]
+use proc_macro2 as proc_macro;
+
 use crate::helpers::{parse_generics, Generics};
 use proc_macro::{TokenStream, TokenTree};
=20
--=20
2.47.2



