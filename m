Return-Path: <linux-kernel+bounces-562885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F2CA63438
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3DC6189096F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5201D17B506;
	Sun, 16 Mar 2025 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="N++fQf5C"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5084183CA6
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106028; cv=none; b=nOtWFT/k9OEXIVwxwQGF7Bigb6UNw1nhz6Cc7DZKJ1QR0C358uRdlEm9gRNWrkPGSNM+TXoi2IGkIOwuuYKums1urqDy3f+c7gIS1WfUM7E/vGej91B2telSqSe1rQkQE52WAF+ucG8sV8e+87eRw3QeCqU2vHQlBH29Op+WoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106028; c=relaxed/simple;
	bh=v0Gbis5USumbGOIqt4qWHI7in1EgH6KrfLpAwsYTzW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYBLL00SYPydjISSCm/+Yi6lpToNgpuEEgnbop5U00oxu/Fq/AaQNdbdBrhn4O+HQZfKVUM7COZdEs4voIS6fucA4gTTuZEKQRwoc7KOQfa6CEiPCxkMpTW/4T1V5OoGFcM60y7pp9q4ijDHMv88eSXxLJF+sMuVUHvjFGcfHz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=N++fQf5C; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e3978c00a5aso2808822276.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106025; x=1742710825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkgyPJA9Bj//05ph35KmseZL6QJ2Okjtw5udMh9eAmA=;
        b=N++fQf5Cbm+N/NJ9TmsHupPlETvMKegA2+lFQATbe+it4CDuQrMYih7jZGvhKQLFRP
         TWT1wGgr0zfsBnCeoYYpWGEPACEO5Li20nh9iHwV8q5U1uykGGjROgYFYw69Ef1tRfzT
         9ds8SJkJtVDFHyT6KdLGlWBBG933G/Q/5bixiIw956ol0JYCt+Z9wjB2gTwifz0baZcI
         1BW3YkhztjrPRCfxdgrWTU8ELmdm5eMsVK/9Ysqh7/byGjaaYhxDkZrfnQHKndKZ4uUm
         7JqLMR+M2a5y6y3oMQG0WITqbCtTG1MDFyU2TMcAx9vwyKhgKiOIKC+VxFPyknVlkQxL
         wQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106025; x=1742710825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkgyPJA9Bj//05ph35KmseZL6QJ2Okjtw5udMh9eAmA=;
        b=LHyJKEkX2WgvsWf+Pu+6DRajdn99Q4RzPA6ZsBZknEYlosnlpaOukZ8gMROQL3KtYc
         ELyJEO7mIei4obYUhdVw8NOnZFl7DFGVnll865dvWDEc9DhzBWiGe9cLxg8uNjmwvX4/
         6MhzfmdiPuiU6E2JLAQVloLQ7T81pMiG9oaLeE8I7T8ZhE4Q12eewx0+2lXzp2QetCWI
         msCZ+Sw9C3gkrD3utrB5zBwt1ECSDcvH1xsd/Zq7dqM6CpxVIORg+fcfqhNlRAavfB7v
         iAZZsVRAtOla2st8LGHRv2Ij4YA4Bs7E8PuP3498Lu3Xt9GflDxQ+u3LBv1rGhTz+r8+
         r5dA==
X-Forwarded-Encrypted: i=1; AJvYcCVvc3C1HERsl5k7LcyM4qCLjTml9RbIlTsog2xhrXWGunQe8nK43tbl6LkdpJqmf0oPQpCeW8NoTNjpeps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyohakrNgaTRnJvotsb7cyy15fyYlybgqZ7n4eUBB3jbbd6R+9B
	8saVJDzuKsCB1jKFdrj1V7q6vQzF0nESczBx9DwnDGcnftHcxazYtG+JIHW2HEg=
X-Gm-Gg: ASbGncvMx8J09jxsHTDNGdVhAONifdjdtSvkoaIktzaiJ+XqtDGQopqtcV7GAIq9cIE
	PF5s5lgH/gej8C7BmlRS0BUmyITDkRtScuZP9iI41K5lDWy0dgmIa49FLqZtiypNN9Pt79oSLST
	ENZoXZ4tmTfsUmIFyuV9axtOxKiwEeFKFB0xOa30AtiLoldgM3TeLscUL/DoLwi9XPwzQboydKc
	52fiHR90BKU4Z2A9xe6IH6fXeU/J885J0At/rNnUsVsmF56JSsVgxcdLB55cD3yoLqkZLOYFFj/
	sLOKIMUfNW03pryT3RC4fqTnQdpOzWjju+jQbXZmF5GgEq51htEEC1amuotPd1iiX7VDKho9G02
	Kq0wfGs1bfinxEHVo4GPw/8E1H2pURA==
X-Google-Smtp-Source: AGHT+IEIY3KlLGdHBucI7guM9FS4cln8/Iqy1NOCtDS+HUzwXyiR53aESxAsysN+QgSaY9KadOPQyg==
X-Received: by 2002:a05:6902:2182:b0:e60:acd0:fe34 with SMTP id 3f1490d57ef6-e63f652c246mr9706823276.24.1742106025620;
        Sat, 15 Mar 2025 23:20:25 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:25 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/16] rust: init: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:11 -0400
Message-ID: <20250316061429.817126-3-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/init.rs        |  8 ++++----
 rust/kernel/init/macros.rs | 28 ++++++++++++++--------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 7fd1ea8265a5..53dd39f9a550 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -122,7 +122,7 @@
 //! ```rust
 //! # #![expect(unreachable_pub, clippy::disallowed_names)]
 //! use kernel::{init, types::Opaque};
-//! use core::{ptr::addr_of_mut, marker::PhantomPinned, pin::Pin};
+//! use core::{marker::PhantomPinned, pin::Pin};
 //! # mod bindings {
 //! #     #![expect(non_camel_case_types)]
 //! #     #![expect(clippy::missing_safety_doc)]
@@ -159,7 +159,7 @@
 //!         unsafe {
 //!             init::pin_init_from_closure(move |slot: *mut Self| {
 //!                 // `slot` contains uninit memory, avoid creating a reference.
-//!                 let foo = addr_of_mut!((*slot).foo);
+//!                 let foo = &raw mut (*slot).foo;
 //!
 //!                 // Initialize the `foo`
 //!                 bindings::init_foo(Opaque::raw_get(foo));
@@ -541,7 +541,7 @@ macro_rules! stack_try_pin_init {
 ///
 /// ```rust
 /// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
-/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
+/// # use core::marker::PhantomPinned;
 /// #[pin_data]
 /// #[derive(Zeroable)]
 /// struct Buf {
@@ -554,7 +554,7 @@ macro_rules! stack_try_pin_init {
 /// pin_init!(&this in Buf {
 ///     buf: [0; 64],
 ///     // SAFETY: TODO.
-///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
+///     ptr: unsafe { (&raw mut ((*this.as_ptr()).buf)).cast() },
 ///     pin: PhantomPinned,
 /// });
 /// pin_init!(Buf {
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index 1fd146a83241..af525fbb2f01 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -244,25 +244,25 @@
 //!                     struct __InitOk;
 //!                     // This is the expansion of `t,`, which is syntactic sugar for `t: t,`.
 //!                     {
-//!                         unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).t), t) };
+//!                         unsafe { ::core::ptr::write(&raw mut (*slot).t, t) };
 //!                     }
 //!                     // Since initialization could fail later (not in this case, since the
 //!                     // error type is `Infallible`) we will need to drop this field if there
 //!                     // is an error later. This `DropGuard` will drop the field when it gets
 //!                     // dropped and has not yet been forgotten.
 //!                     let __t_guard = unsafe {
-//!                         ::pinned_init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).t))
+//!                         ::pinned_init::__internal::DropGuard::new(&raw mut (*slot).t)
 //!                     };
 //!                     // Expansion of `x: 0,`:
 //!                     // Since this can be an arbitrary expression we cannot place it inside
 //!                     // of the `unsafe` block, so we bind it here.
 //!                     {
 //!                         let x = 0;
-//!                         unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).x), x) };
+//!                         unsafe { ::core::ptr::write(&raw mut (*slot).x, x) };
 //!                     }
 //!                     // We again create a `DropGuard`.
 //!                     let __x_guard = unsafe {
-//!                         ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).x))
+//!                         ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).x)
 //!                     };
 //!                     // Since initialization has successfully completed, we can now forget
 //!                     // the guards. This is not `mem::forget`, since we only have
@@ -459,15 +459,15 @@
 //!         {
 //!             struct __InitOk;
 //!             {
-//!                 unsafe { ::core::ptr::write(::core::addr_of_mut!((*slot).a), a) };
+//!                 unsafe { ::core::ptr::write(&raw mut (*slot).a, a) };
 //!             }
 //!             let __a_guard = unsafe {
-//!                 ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).a))
+//!                 ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).a)
 //!             };
 //!             let init = Bar::new(36);
-//!             unsafe { data.b(::core::addr_of_mut!((*slot).b), b)? };
+//!             unsafe { data.b(&raw mut (*slot).b, b)? };
 //!             let __b_guard = unsafe {
-//!                 ::kernel::init::__internal::DropGuard::new(::core::addr_of_mut!((*slot).b))
+//!                 ::kernel::init::__internal::DropGuard::new(&raw mut (*slot).b)
 //!             };
 //!             ::core::mem::forget(__b_guard);
 //!             ::core::mem::forget(__a_guard);
@@ -1210,7 +1210,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
-        unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
+        unsafe { $data.$field(&raw mut (*$slot).$field, init)? };
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1218,7 +1218,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         ::kernel::macros::paste! {
             // SAFETY: We forget the guard later when initialization has succeeded.
             let [< __ $field _guard >] = unsafe {
-                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
+                $crate::init::__internal::DropGuard::new(&raw mut (*$slot).$field)
             };
 
             $crate::__init_internal!(init_slot($use_data):
@@ -1241,7 +1241,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         //
         // SAFETY: `slot` is valid, because we are inside of an initializer closure, we
         // return when an error/panic occurs.
-        unsafe { $crate::init::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
+        unsafe { $crate::init::Init::__init(init, &raw mut (*$slot).$field)? };
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
@@ -1249,7 +1249,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         ::kernel::macros::paste! {
             // SAFETY: We forget the guard later when initialization has succeeded.
             let [< __ $field _guard >] = unsafe {
-                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
+                $crate::init::__internal::DropGuard::new(&raw mut (*$slot).$field)
             };
 
             $crate::__init_internal!(init_slot():
@@ -1272,7 +1272,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
             // Initialize the field.
             //
             // SAFETY: The memory at `slot` is uninitialized.
-            unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
+            unsafe { ::core::ptr::write(&raw mut (*$slot).$field, $field) };
         }
         // Create the drop guard:
         //
@@ -1281,7 +1281,7 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         ::kernel::macros::paste! {
             // SAFETY: We forget the guard later when initialization has succeeded.
             let [< __ $field _guard >] = unsafe {
-                $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
+                $crate::init::__internal::DropGuard::new(&raw mut (*$slot).$field)
             };
 
             $crate::__init_internal!(init_slot($($use_data)?):
-- 
2.48.1


