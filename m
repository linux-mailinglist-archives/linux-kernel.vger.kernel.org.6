Return-Path: <linux-kernel+bounces-569053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A7A69E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAFD16ADA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE070807;
	Thu, 20 Mar 2025 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="XtwHGobO"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48D1DE2CE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436487; cv=none; b=l879s+j4Iyg+MC4i2JTOE8PaKJH8MJ/lCckYJqntCVWbKxtNkv0CF5omj3NgXPOeR29wxJYiEFv1BsSWj/ulRyQEe1PSZWTE7Z9/zGKhuux41Yp7u/y8RdrsLAbsTgeA8oHeROwl3O0eEJmrURJybsFNtGNhM71vnlMMl+/9x4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436487; c=relaxed/simple;
	bh=nmTx/Uf67oypYQVl7Qq4I9TqxsY77W5DplonEcfyvYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeiotRKC9wGUQrYHpUamMY/ON3WGxVG/9Kh+q4Hm5AV3ifOcElIt/IPc/Ra8uElWwLGdiCIvO6gENppuYGbP7uxUaNtOfdzlzN1i0irjszBHROYSbYltUraOKEVD2xe5uAQQGTI3lTbsYBVJfkzVn78IFlkQMqK3pS2BYhkpjm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=XtwHGobO; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fedf6aaed2so2837307b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436485; x=1743041285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc6kiMgjZCCReYjE/YP6lEkO7MfvY9pzB7oZNf0Wsp4=;
        b=XtwHGobOuvOlDPuvVbfggTfM5tRs4E1TWHo0DKq4v7GIW9leCaUwWCdfFpMmM+z7QQ
         59oDIeksEvAxVHxTrXHPW1woF7FmT3oQn66FI4mDtBYR1noytlXfU4Hu2rcSAqThgMKH
         7SqXZ4RtxYn0t3lf4gePVK10nux2jHhBHaRTbs4qmbEpvBISnjBMx8+RGZSU7JAPVZ6l
         V1x3uTXz6s/hncdHbfKwFOPKYGRnW9RGvZ1StSkuubhE+DeFDJA8qB87XjeQGZ/KyidV
         OTov/dZZ/9P58dOzW4ZV8t0StlBHgaIblNkzGFSc++koK5ae2s4ijtC75AswXYTkV5tu
         g7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436485; x=1743041285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bc6kiMgjZCCReYjE/YP6lEkO7MfvY9pzB7oZNf0Wsp4=;
        b=rfgRAvpZG5cnNfIo8DzgptsSFYmFoPcwajNKHV5EaXb/roPU6o6qUJ9xWj5NePdKip
         XgOGppwEmfzyRvTaiy6NpdT1m0bhZ+wDUm9eFZbtmlu6/K138VQMmsRd93xLZSFVgtIL
         KpwmSfFC6j8gepPug16Pvs2L4QxIVGydbnAFk4esIAq1EwKmcuJF5BQZiIPlKcyB8rio
         KwGn7+SuUmiDp1J5hcEwuSGjLFTvheXx72xaj0ZB0IMIi12XfrkVz0uvXCSbEkBKYQLW
         TuptMukiEufJ0WKXVgpCfp8RUN9AzwyvyL1IPhztQV2UecKfeu8Qqr3Q0K/gN3+oreFP
         f7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUuAaprUH6d1Cb9/QKotkj99L84Fm+OB4Rss/JB+GtHimJnDmtVz5cXcQhOEYvdE9G3o2Qd3suxl1KqRb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUNup4WiUG4n5xfPqpxhCWzkmAtym1Za6/d9x55S2BzIi+Os97
	BtgCraAh3LWvBCtL8FhbXSjUAm5h/PEtX4tvYzH0a2A8l6qQOlLvwgyWbKA1YYg=
X-Gm-Gg: ASbGncucXFtSwf0Xm2/msqLjkFsxjGkA/HQ+Wz0gcz/aYVxbbrWBK8Cy/G8eCQaH5NV
	d3j9j3FDGIcX2XB7hJ35/cgisQk3vbBc3aLtsf+IsKx0VnImdp8n3gKeWjijibO+q1CZz/XbxJf
	CH6Q6pBUKww8zAFEVPrvUTrzwBzr0pbp5XDzXygQ2I0Tj1dWUJCnhgz9gSKJLQ1ivzqRODU9V17
	ym+aRclju0HhmtNgWECE438N5TNc675GGhVX8T1Tc2yP7ZlsSUM2vX64CSxPBe8hQIuMw6i4LhW
	Mi1bV5DymMQ99mnFZTdXqInwX0VQIBHfs2Auac6hcU4JecOThglwtpmAhqGT9DZlQ979I2KwWav
	rMTrGjFl7fquSOZs9qqVtTPj8iS2Y5cLQLWK5H0XU
X-Google-Smtp-Source: AGHT+IGxpoLsP2uWVbCe4opF/xV8ySkEoE5qrdUUC95SwDsqC6/Loa8GFB/JIWAVQQ5noXA0a7ovRA==
X-Received: by 2002:a05:690c:6c11:b0:6fd:a183:f6eb with SMTP id 00721157ae682-700ab2eabffmr26939607b3.15.1742436484665;
        Wed, 19 Mar 2025 19:08:04 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:08:04 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
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
Subject: [PATCH v5 02/17] rust: init: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:21 -0400
Message-ID: <20250320020740.1631171-3-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of_mut!(place)`
with `&raw mut place`.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw mut` is similar to `&mut`
making it fit more naturally with other existing code.

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


