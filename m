Return-Path: <linux-kernel+bounces-415682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DA69D39DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02997281DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717CA1A7265;
	Wed, 20 Nov 2024 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J47pkn74"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41711AA1C8;
	Wed, 20 Nov 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103185; cv=none; b=ccG31tSvO7TYLQ0CAjp4J5Ql3IkN5Oee1vKId5YYK+s5NV7JA/UrTqJToe5ISjpq0DTgsjGH4omz/eVTZxLKvWSefsA19I+ZSB/65WE884rUlW1TDzlIWPAwqfUxvA3CyWeT3w7JE7pHgsfeJyUllpZ+IR/W8hJ5qR64iqm1mG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103185; c=relaxed/simple;
	bh=q2eREYf/gb5j6ID/Z4keUIY9t2Rhfyb/VmEbsUUDvvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhqn4N9oNOhIUGuPrbwwijTZqVmYxlEJchwlyfwhWNwzRtDJbY2ORLN/7pGlR4hWp+JxxCKospalREIoO5CHGv2rSwUBmcsVO3gebRtomQ31FIabsapOrzj8daFeNWG2uS72fw+gsXp8YJcjBZmcwmJd2YsEOB3xJVVdcuaZsXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J47pkn74; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d410b5a94eso13281706d6.2;
        Wed, 20 Nov 2024 03:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103183; x=1732707983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq5NQqKxw72RrjJpmlLapu+Z3rZyKaWgokca6MUC0p8=;
        b=J47pkn74FJQ4l+F8DlZ15pe4QMnjOy1i1T+yQoz20wqqp7ocAicWAQhMn1vdXyDDw3
         HYEkvevFg4j1lqxEC/uwJk/0fa6OLhIek8JsCXqp4s9FjU5Oy4i1jM0M/yVvwze7PD/f
         rqYjmkNNznl0HK96yMIt+vr4H+rK9tIU1OUDYZz7iwtE2Lrnk4edxKonGmzSnsg5NZDm
         jd5nELKJpfhQ8Hn4f2orP+r89WJw8fp6Gqh9JiK8qoaMgfzlST2dZOX2094KCcz43Rxz
         a2hnzVskA0/uTfRryisLuNRlAu7+NipYs6HB/QKYRF8mcymf8eMkQ4NdqErYvL98oIxJ
         3xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103183; x=1732707983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wq5NQqKxw72RrjJpmlLapu+Z3rZyKaWgokca6MUC0p8=;
        b=UHfzkCuxgteGlSy6zIikjXyJzGqHIWIGa3cU1rOCwImFEQfTotR1GU7QhWl5+d5gHR
         V+v0hvAKNhqwKWfdTvmyVACvQ5rAMojeejA04dyA5KYup9rRaRsuBHBEWHd6okDts5Ma
         TsioXGqrH2cPO0S7OebKJGiiomlVkNZgZDysvvyuetMruyvVzL3OxG3XQoDz2t3gu3cE
         uTiJR1nYle01asLnecUm8Kgio/25QsZKgNtoSnUuey8jiEcCyqncH5K0lsWWO8hXPUwh
         FlgdRcNBwLq78BDtHJLwbNfoO7vUnZ4gtNo96kod44rxgQso5xZor4xrR2TDEVVcDhVT
         yGxA==
X-Forwarded-Encrypted: i=1; AJvYcCVXafRs5/zDM5ocw/XOh1c+OLYGlivl4yYuYlSB+EtOTgZgFGY09e/rjDv2NIpTb9aAnQthD9DWzibxk50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNma6crAikcgQ4swuD5Fi2gYC9gAKW50GSKPDyK9DXakfGgF7D
	3Hm3lPW/2fBPToKBd/jdYxhqt5gJMNiNa/fga9XZa3l3SmLWYXf9
X-Gm-Gg: ASbGncuB+YbCCVT8+PoEQym6rtzIgPS2EMH8VwL6zULxxN/Vi82H6+MzlMNlkjKuv4+
	4Dm7g8lnfFmSZqNGXiJU7Ld1pCQ7PLsSDi9yveLrNdk17nSZQ9mWXYJmUCryLC8zw9cMpwzomCv
	sfHoFfNhT0mDHy1DaKTYssUjr/kmnH6cYUyO2fb4jGzezp7KKF7b+F1AXkVT0TfXdRa1fbDN6yP
	vkb5ONI9bSNYXukfDz7M3kleRO9u5hMsMDnUou28KQfGtuWoBNcW3Wh9U6MGT7aUIlQUspFS+j5
	joX6Si8E
X-Google-Smtp-Source: AGHT+IEjjsmM1uiB1Z6LTzvR7A9UmA4w4nJjVtAFo1iIz3eK9xF+Himibgegb7HZA2AYtfsELtpphg==
X-Received: by 2002:a05:6214:c86:b0:6d4:257a:99 with SMTP id 6a1803df08f44-6d4378638edmr32306276d6.44.1732103182621;
        Wed, 20 Nov 2024 03:46:22 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2600:4041:5be7:7c00:8dca:61d2:c8fb:a544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380b6390sm9705696d6.5.2024.11.20.03.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:46:21 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 20 Nov 2024 06:46:03 -0500
Subject: [PATCH v6 4/6] rust: change `ForeignOwnable` pointer to mut
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-borrow-mut-v6-4-80dbadd00951@gmail.com>
References: <20241120-borrow-mut-v6-0-80dbadd00951@gmail.com>
In-Reply-To: <20241120-borrow-mut-v6-0-80dbadd00951@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

It is slightly more convenient to operate on mut pointers, and this also
properly conveys the desired ownership semantics of the trait.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kbox.rs | 16 ++++++++--------
 rust/kernel/miscdevice.rs |  2 +-
 rust/kernel/sync/arc.rs   | 10 +++++-----
 rust/kernel/types.rs      | 14 +++++++-------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 3f0b04609bd487e3f50247f9f1abd5394b749c7e..e00c14053efbfb08d053e0f0b11247fa25d9d516 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -355,17 +355,17 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
 {
     type Borrowed<'a> = &'a T;
 
-    fn into_foreign(self) -> *const crate::ffi::c_void {
+    fn into_foreign(self) -> *mut crate::ffi::c_void {
         Box::into_raw(self).cast()
     }
 
-    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr.cast_mut().cast()) }
+        unsafe { Box::from_raw(ptr.cast()) }
     }
 
-    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> &'a T {
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> &'a T {
         // SAFETY: The safety requirements of this method ensure that the object remains alive and
         // immutable for the duration of 'a.
         unsafe { &*ptr.cast() }
@@ -378,18 +378,18 @@ impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 {
     type Borrowed<'a> = Pin<&'a T>;
 
-    fn into_foreign(self) -> *const crate::ffi::c_void {
+    fn into_foreign(self) -> *mut crate::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
         Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }).cast()
     }
 
-    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr.cast_mut().cast())) }
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr.cast())) }
     }
 
-    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> Pin<&'a T> {
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Pin<&'a T> {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index 7e2a79b3ae263659b7e0781c05cb130d10c8accb..e58807ad28dc644fa384e9c1fb41fd6e53abea7a 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -193,7 +193,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     };
 
     // SAFETY: The open call of a file owns the private data.
-    unsafe { (*file).private_data = ptr.into_foreign().cast_mut() };
+    unsafe { (*file).private_data = ptr.into_foreign() };
 
     0
 }
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index a11f267ce5d40b987f1f3c459271e5317ea0bae8..01d85da799d77127fc99a9b270b8a7b1ef435b6f 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -333,24 +333,24 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
 
-    fn into_foreign(self) -> *const crate::ffi::c_void {
+    fn into_foreign(self) -> *mut crate::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr().cast()
     }
 
-    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr.cast_mut().cast::<ArcInner<T>>()) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
         unsafe { ArcBorrow::new(inner) }
     }
 
-    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr.cast_mut().cast::<ArcInner<T>>()) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 318d2140470a90568100f86fd8c6d8084031f556..f9b398ee31fd5303f0224995f51d314a0c4ecbf2 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -29,7 +29,7 @@ pub trait ForeignOwnable: Sized {
     /// For example, it might be invalid, dangling or pointing to uninitialized memory. Using it in
     /// any way except for [`ForeignOwnable::from_foreign`], [`ForeignOwnable::borrow`],
     /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
-    fn into_foreign(self) -> *const crate::ffi::c_void;
+    fn into_foreign(self) -> *mut crate::ffi::c_void;
 
     /// Borrows a foreign-owned object.
     ///
@@ -37,7 +37,7 @@ pub trait ForeignOwnable: Sized {
     ///
     /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
     /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> Self::Borrowed<'a>;
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Self::Borrowed<'a>;
 
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
@@ -47,7 +47,7 @@ pub trait ForeignOwnable: Sized {
     /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
     /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] for
     /// this object must have been dropped.
-    unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self;
+    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self;
 
     /// Tries to convert a foreign-owned object back to a Rust-owned one.
     ///
@@ -58,7 +58,7 @@ pub trait ForeignOwnable: Sized {
     ///
     /// `ptr` must either be null or satisfy the safety requirements for
     /// [`ForeignOwnable::from_foreign`].
-    unsafe fn try_from_foreign(ptr: *const crate::ffi::c_void) -> Option<Self> {
+    unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
         if ptr.is_null() {
             None
         } else {
@@ -72,13 +72,13 @@ unsafe fn try_from_foreign(ptr: *const crate::ffi::c_void) -> Option<Self> {
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
-    fn into_foreign(self) -> *const crate::ffi::c_void {
+    fn into_foreign(self) -> *mut crate::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn borrow<'a>(_: *const crate::ffi::c_void) -> Self::Borrowed<'a> {}
+    unsafe fn borrow<'a>(_: *mut crate::ffi::c_void) -> Self::Borrowed<'a> {}
 
-    unsafe fn from_foreign(_: *const crate::ffi::c_void) -> Self {}
+    unsafe fn from_foreign(_: *mut crate::ffi::c_void) -> Self {}
 }
 
 /// Runs a cleanup function/closure when dropped.

-- 
2.47.0


