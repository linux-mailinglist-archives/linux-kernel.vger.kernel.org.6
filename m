Return-Path: <linux-kernel+bounces-401910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7529C20F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE29B1C2305B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B8D21A718;
	Fri,  8 Nov 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcD4wIph"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA89121F4B2;
	Fri,  8 Nov 2024 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080807; cv=none; b=VJjkwaP0KjGvlGzwBQRQ65hOIw8lvh5b/NqE8Qx/kmmEz+c664JGbPI7MZgehSqEgWjvhfyy9dLYAPaHypBH1uWvl+xtgiH/qwHxxnec5IStXHaxThxpGNr4CBY0n+IabKMvvkAGzI3qoR6jCCdm1Jzx9EhZCNcJht5xWD10gCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080807; c=relaxed/simple;
	bh=LxXmDYzf/qk0hlOYWjG5qw67ZQPOAMQ/ynasJJsw4aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i+YovTtGX9YjWjCK3IsG1menJVgF1OPMBTFo80NMRv9+FXyi651ikyFI5HwYEUpDyevb6lhepC2XyXORxo+wry+zI3+kvodUc7NR04YqNmXGDqucMYeSxMuRho+yrHexUSP6CqTMb2JQ9VcIVxKzPkc3UUV/IgE4gxothgQkKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcD4wIph; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cd7a2ed34bso13643686d6.2;
        Fri, 08 Nov 2024 07:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731080804; x=1731685604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ9+l+go52xGjktFzaIhj3DAnoLHb0WXUKoHJUC3hQc=;
        b=JcD4wIphJBy95KWSDSjDMW/zZVKA59R7AfJ9tyAK/zS+BICsrPzdvTexJ+mYGENakz
         H/H+ZF72dpWyaXO+KqXeFHMUm2mZZatkOjUgnTVUcadpvgTU+nNO/mg4GBCUa5JGHKPG
         Co9gu4sp557J/Llr59PNjc+hwouKeTjFFhgY83fX3fdJHgKXiWImIYptng5OZh12PRR5
         8ssmDW2OYSOc108Bm6/3kBthEQPn2yydgqqbayHQ83ADexaP2lMDWCIrf2zOa2g3b94o
         IwKKgYICV2gPbAiuFl1C+kO6zVQnzFnBvtw5jW3OjMcdZOSbfNPITQ6L7z0SNpH11+Di
         7qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080804; x=1731685604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQ9+l+go52xGjktFzaIhj3DAnoLHb0WXUKoHJUC3hQc=;
        b=El/BpeRVv2qrD2R7Q5AROXRS+aijITk3Z5DD7Yvq7GNKpyB2pmn+GKoxjteLKbLX23
         cbBmkpabBS0vEBQP0iEFe8DmRXEy96pJHLiVZ7FBFzy03CdCSeJXedaRGwz2qluKvgWA
         mU6WRBymHIYviDxe4VVD9pOvdmvpqTtJdykKvWQMLhNQSespmq+xbK++VbVz66Mfk9HE
         zOxVa9LHqFPc1OD5wjXlOV0IDuD4VJxvwZmO1ZxgWmSWTBT9zA0zF5MQdBpWJP9sbLnh
         yPxFZeK+S39UUwml/xMCHtucqwvR3EsxeDEKsnY8nKLlrQc25kbXSyJSzUtW8ZrOlCO8
         cJ1A==
X-Forwarded-Encrypted: i=1; AJvYcCWPGZZcZj5ksQ/mK0Ae5yASABm8ABxiZOervGBPDnTs2hPN8nVgK+bFTR8LwqlfbXu0EETXfqGWVYWgzNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/T3Y7FZAcjCnv746KDthnuPAyJ51QPpwOa1kW6EjgzD9pFKKY
	oXtDAFjTqlaU+lKaSXkNMIGhtmLupgvMgZ0ocFn67ThiJx5Yurcl
X-Google-Smtp-Source: AGHT+IGNVrmIfU/ItuqHWn5AIkcsKFEN4P6uKtarxXcvJOoYsAcj8tUgR68Q4AnseTHhKBZ2JLzSuA==
X-Received: by 2002:a05:6214:3198:b0:6cc:11cc:6f36 with SMTP id 6a1803df08f44-6d39e0f7560mr36220416d6.3.1731080804522;
        Fri, 08 Nov 2024 07:46:44 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:348d:4cbf:ba75:f557])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396631118sm20673676d6.110.2024.11.08.07.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:46:43 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 08 Nov 2024 10:46:19 -0500
Subject: [PATCH v3 4/6] rust: change `ForeignOwnable` pointer to mut
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-borrow-mut-v3-4-b7144945714e@gmail.com>
References: <20241108-borrow-mut-v3-0-b7144945714e@gmail.com>
In-Reply-To: <20241108-borrow-mut-v3-0-b7144945714e@gmail.com>
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
 rust/kernel/sync/arc.rs   | 12 ++++++------
 rust/kernel/types.rs      | 14 +++++++-------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 03b7107c60344d4f03d49c51230e114d3ab38027..99d0fc0148bb8779e5a769a6e74291ef8101bf77 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -355,17 +355,17 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
 {
     type Borrowed<'a> = &'a T;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
+    fn into_foreign(self) -> *mut core::ffi::c_void {
         Box::into_raw(self).cast()
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
@@ -378,18 +378,18 @@ impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 {
     type Borrowed<'a> = Pin<&'a T>;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
+    fn into_foreign(self) -> *mut core::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
         Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }).cast()
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


