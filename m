Return-Path: <linux-kernel+bounces-395567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ABB9BBFEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE6E1F214C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7C41FE11B;
	Mon,  4 Nov 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkE25CUJ"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A11FE0F9;
	Mon,  4 Nov 2024 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755246; cv=none; b=QLEAKlM5MwuckMfeOkX//LuOUHNm57OlbpD6RAv+zG4hzPA23AisMyRzAgOBreRGKyHTx8Adml6qkGOHqX3iBX1CI74KnyC6w0t9ncWSlzM9E1emm8H5drxnM+s7UzMBu4KrBNhITe8W7avztyOUyZaDD9dvhsgaROOgD1ufC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755246; c=relaxed/simple;
	bh=bQgx0aVr+dpdEM3aadIoXc3nVC7MElyiVaFf+CugMVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ip6AFfl6SgUP3ZbTAPZsRMzlXLxtODmmh+Ragf53Fe8D6DGc0TJyVXKObWKO1cAu0LrSgEaiRdSGK5yH0uVA7CuBYx6YAa1D3UNYSoUcrseAqk0+mO+AHQCXXaBWwWLmJR/ZXgSDCcZvIMLC2YcLyWG11MoozabzC4d4FWiX/a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkE25CUJ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ea1407e978so44601577b3.1;
        Mon, 04 Nov 2024 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755244; x=1731360044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8Tz/65EOGIRDKpwI97BrihSIW6jiaqoSXa7tScKwyA=;
        b=IkE25CUJLjLWGmxCP3uBukSPoyY2yDr/XPPi2HVCA2iFku+Of3kn/2rlAa3/tOTgwW
         I0g6ybXrVxRpK96YNNgijqhPm2tzAUm7pt/rqoXjrj8/izdmqbr5i7mZvL2gYbTbMpxg
         FMH+dTSyvL53wsvWY9PzUGW99qlZmNJhrgbd0D4oR/MtaZrxLdgrIDX5sONf9mdU6Up/
         nZnm3hcGi9IuwI/staFa1bnKV5CPeYfH+C5Nde/6UfId6AOBuD1/ubsrBamYoeQbsKPc
         vT9gtQGjXQArlsvZ8PjrMpioIEqs7JRYgCxhbUQn2hF+tvhle93fxDP/aCeBawh7uUqa
         AJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755244; x=1731360044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8Tz/65EOGIRDKpwI97BrihSIW6jiaqoSXa7tScKwyA=;
        b=bSkc2P8Mno2/2TcO30Kc9gku82UnWDDczmtXtFUjLvmfcXkUJ4FsMmWb6OPWfKt6An
         S4YikRbpJG4Orozp5nE4kp2i81KFIkZQn3x3VRGq2WzjomCygw2qWIIHT7z0cJLis7G4
         IoSUCT8NtQ4+Nf2nWH/G/7lbU8gj0ClW8QDRtNekJGBjMfPIMI971n+FjpnNF25VkX1O
         Sa2e19J29Bn4jCup8mwttnFdxl1QweVKTwgmoUlGAetoXTz7m82YV+F3+K3qrrQsPGk+
         /CDrhKt8IKDmuydwLWkGzljXTz5X4yFSZW9s2iE1+cBb4md0w9BEiGHCpJ8DOv/xcSDC
         P6ew==
X-Forwarded-Encrypted: i=1; AJvYcCXJZfYnSAlWeMlIuHjwLBCrCre2wfoc5i+x88UyewPTvawanaw7wfU/xiUjrLWou6ZT840a2iGq8v8KR/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2YbJTAuWKF4wTzc21r8R0i9wQcmzngXICg+eS8hnBoMgCt3f
	wifbJtDTJqueogJj/vdbX/dQy6P0XkJEXLpkuKsBY6iq9wiVt9Rl
X-Google-Smtp-Source: AGHT+IGvz3w80mhRc+SXtPvwt2CoPGHdlfJxU6T2WlCIPJ7SOhOHSchs+L/JbN2sWaV+nT16UOBVgw==
X-Received: by 2002:a05:690c:9a03:b0:6d3:e798:a1e1 with SMTP id 00721157ae682-6ea64be6345mr141234617b3.40.1730755243924;
        Mon, 04 Nov 2024 13:20:43 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([102.129.152.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b1ed29sm19555817b3.53.2024.11.04.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:20:42 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 04 Nov 2024 17:20:30 -0400
Subject: [PATCH v2 4/6] rust: change `ForeignOwnable` pointer to mut
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-borrow-mut-v2-4-de650678648d@gmail.com>
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
In-Reply-To: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
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

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/alloc/kbox.rs | 22 ++++++++++------------
 rust/kernel/sync/arc.rs   | 12 ++++++------
 rust/kernel/types.rs      | 14 +++++++-------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index b6b6723098b6b30743bf38c97aab0e701a5a1be4..99d0fc0148bb8779e5a769a6e74291ef8101bf77 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -355,17 +355,17 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
 {
     type Borrowed<'a> = &'a T;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        Box::into_raw(self).cast_const().cast()
+    fn into_foreign(self) -> *mut core::ffi::c_void {
+        Box::into_raw(self).cast()
     }
 
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr.cast_mut().cast()) }
+        unsafe { Box::from_raw(ptr.cast()) }
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> &'a T {
         // SAFETY: The safety requirements of this method ensure that the object remains alive and
         // immutable for the duration of 'a.
         unsafe { &*ptr.cast() }
@@ -378,20 +378,18 @@ impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 {
     type Borrowed<'a> = Pin<&'a T>;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
+    fn into_foreign(self) -> *mut core::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) })
-            .cast_const()
-            .cast()
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }).cast()
     }
 
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr.cast_mut().cast())) }
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr.cast())) }
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> Pin<&'a T> {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 9adea755a5ad1a7b03f7fc30a7abc76c1f966c6c..10819dc28b64038b9abc55b01c069826d1e5befa 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -333,24 +333,24 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        ManuallyDrop::new(self).ptr.as_ptr().cast_const().cast()
+    fn into_foreign(self) -> *mut core::ffi::c_void {
+        ManuallyDrop::new(self).ptr.as_ptr().cast()
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr.cast_mut().cast::<ArcInner<T>>()) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
         unsafe { ArcBorrow::new(inner) }
     }
 
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
+    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr.cast_mut().cast::<ArcInner<T>>()) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 364dd2dc438eb7d1c4d0a4525bf2305a42297b2b..59e71bd158713bb8e12cac95e134f57a277c1b49 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -29,7 +29,7 @@ pub trait ForeignOwnable: Sized {
     /// For example, it might be invalid, dangling or pointing to uninitialized memory. Using it in
     /// any way except for [`ForeignOwnable::from_foreign`], [`ForeignOwnable::borrow`],
     /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
-    fn into_foreign(self) -> *const core::ffi::c_void;
+    fn into_foreign(self) -> *mut core::ffi::c_void;
 
     /// Borrows a foreign-owned object.
     ///
@@ -37,7 +37,7 @@ pub trait ForeignOwnable: Sized {
     ///
     /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
     /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> Self::Borrowed<'a>;
 
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
@@ -47,7 +47,7 @@ pub trait ForeignOwnable: Sized {
     /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
     /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] for
     /// this object must have been dropped.
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
+    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self;
 
     /// Tries to convert a foreign-owned object back to a Rust-owned one.
     ///
@@ -58,7 +58,7 @@ pub trait ForeignOwnable: Sized {
     ///
     /// `ptr` must either be null or satisfy the safety requirements for
     /// [`ForeignOwnable::from_foreign`].
-    unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
+    unsafe fn try_from_foreign(ptr: *mut core::ffi::c_void) -> Option<Self> {
         if ptr.is_null() {
             None
         } else {
@@ -72,13 +72,13 @@ unsafe fn try_from_foreign(ptr: *const core::ffi::c_void) -> Option<Self> {
 impl ForeignOwnable for () {
     type Borrowed<'a> = ();
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
+    fn into_foreign(self) -> *mut core::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
+    unsafe fn borrow<'a>(_: *mut core::ffi::c_void) -> Self::Borrowed<'a> {}
 
-    unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
+    unsafe fn from_foreign(_: *mut core::ffi::c_void) -> Self {}
 }
 
 /// Runs a cleanup function/closure when dropped.

-- 
2.47.0


