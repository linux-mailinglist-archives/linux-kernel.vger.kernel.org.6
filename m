Return-Path: <linux-kernel+bounces-389521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C09B6E05
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2A7B22E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BF621745A;
	Wed, 30 Oct 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwh2f+iA"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3C2144D2;
	Wed, 30 Oct 2024 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321209; cv=none; b=GrxNBZPE5lRN8As2vuwiuqaSKA051G/ILzXZSToeX1yVR+z543jYIaGBfd2dnDDg3dwjmKvNq/zXdmjNLiZ61pDGRddT4dj5lqMtDJbS18HelkQ+bFWm3gbCnVUz05ZznZGCweEtDeLMCUxBXvc+oKA4NVTPigRcNYW6L2wiLGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321209; c=relaxed/simple;
	bh=hvuWPVRqVlPtD8nPkq5Vb1LUrXDT7nZ05O5Oxu7e2Rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHIR6BskeVmK1ZLXXSxtImMLGMi603S+QBgr4KP3Cr9zxGOQAedtNDKvXM5G/0pl4/aA5rsHP+hjAHf06NAyI1Az2FLVKJ5Q8GHh2rqzDTqdnWy03oEoWduitLRwhgeCC6gbTfbFCiFNW3zWoZVYLn2EB9tElwMFVyO79NdOxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gwh2f+iA; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e29327636f3so222877276.2;
        Wed, 30 Oct 2024 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321206; x=1730926006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLP3yKC2elkPQbresABA6wHHmwAcQqYBo0U0H5HudtA=;
        b=Gwh2f+iAVpXCwCdUQJzlF1bGYeS7T3gCuPOsAL3ZfkPtMvjTf7byz5Y1tjdRx6accG
         3kHutHeda/DS91ssY5QZewFFofWoADazOSgNpGbSsDKgIM0G6gY+DPCh+rsok0uClEmZ
         nL3per8V92wECPNawXTOTaIH4U5YHECC9/vA16cyTyIyZjxtVbXpidRHZUj/I72FNvf8
         pje+CHiTRb1FDqc+ZybAKJSwb42zs3NIKdRE17sXNyWbobAL72lrSMR3tDDcg6sysDSp
         JVUqRjnSwLY0e8c5Rcly0q//ZP9kcONNuGiBjrgIGPon5tHF55dDnEnlS2sj0jcH7ZaP
         nC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321206; x=1730926006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLP3yKC2elkPQbresABA6wHHmwAcQqYBo0U0H5HudtA=;
        b=KlF19RZrH5ChVwA7hWIUmUl99TTnbaP/5j4I/0dkq+wROL2h12hzAbtyCLF9maxIri
         iNRvsJUHtkTKIH5BRyTiZDFowg0Cs8H6mzQufoJ1n2y+Jp7SBMMevUReeJDK6pzpTjoG
         ZtzLIfq9ScWrJ8sxIMTu5gH2ew0/TMiHNApQbLzJB7xtJfB3JBAyDEJSpgev0sdnZP4a
         d7bhM9pyDN+Ip/rrPTf+ZrqflSUyh6T0THII0YbXG/ZxveZHuDwM0c5Dj27+tEYstA8L
         AB6x1AEdKBY7/t4m6HuVRds5e3Yd2lHh6p84KXWTU6u/ejCVkYjNo9AwBDYF7dfG+qOh
         by1g==
X-Forwarded-Encrypted: i=1; AJvYcCVFd3JodfdLO5gyQj6uRQvVaAl69U1l3ImIaTnRUOgJeDF/YC94mwHyE1yo+z6pVszjtLbaBrk4PUn3d+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZ2GJCMRNDvYh76tkjgYO39wxF1SGYPLHQWk3dsCQ64H6HenR
	AmGiuVzTnisZrR3igt79JKeYvf2UtbtNMZ0tJ6QqiiPn4gnDW9Ea
X-Google-Smtp-Source: AGHT+IGJvG3gvz7B9T41YC2jyrLqjDlrmL2TjvZXL4lEoS2RA0zIvcRJ3ohTHjxivn0FR4KyK6kbkw==
X-Received: by 2002:a05:6902:188c:b0:e30:df1f:8926 with SMTP id 3f1490d57ef6-e30df1f8ac1mr2407788276.12.1730321206083;
        Wed, 30 Oct 2024 13:46:46 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:89dc])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0c72efsm271271cf.50.2024.10.30.13.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:46:44 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 30 Oct 2024 16:46:40 -0400
Subject: [PATCH 3/5] rust: change `ForeignOwnable` pointer to mut
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-borrow-mut-v1-3-8f0ceaf78eaf@gmail.com>
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
In-Reply-To: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
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
---
 rust/kernel/alloc/kbox.rs | 22 ++++++++++------------
 rust/kernel/sync/arc.rs   | 12 ++++++------
 rust/kernel/types.rs      | 14 +++++++-------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 7a5fdf7b660fb91ca2a8e5023d69d629b0d66062..de7fadeb7fdf5cf6742c2e9749e959ac5f82359e 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -355,18 +355,18 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
 {
     type Borrowed<'a> = &'a T;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        Box::into_raw(self).cast_const().cast()
+    fn into_foreign(self) -> *mut core::ffi::c_void {
+        Box::into_raw(self).cast()
     }
 
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
-        let ptr = ptr.cast_mut().cast();
+    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self {
+        let ptr = ptr.cast();
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         unsafe { Box::from_raw(ptr) }
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> &'a T {
         let ptr = ptr.cast();
         // SAFETY: The safety requirements of this method ensure that the object remains alive and
         // immutable for the duration of 'a.
@@ -380,21 +380,19 @@ impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
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
-        let ptr = ptr.cast_mut().cast();
+    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self {
+        let ptr = ptr.cast();
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         unsafe { Pin::new_unchecked(Box::from_raw(ptr)) }
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> Pin<&'a T> {
         let ptr = ptr.cast();
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 88e5208369e40bdeebc6f758e89f836a97790d89..26b7272424aafdd4847d9642456cab837797ac33 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -335,12 +335,12 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
 
-    fn into_foreign(self) -> *const core::ffi::c_void {
-        ManuallyDrop::new(self).ptr.as_ptr().cast_const().cast()
+    fn into_foreign(self) -> *mut core::ffi::c_void {
+        ManuallyDrop::new(self).ptr.as_ptr().cast()
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
-        let ptr = ptr.cast_mut().cast();
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
+        let ptr = ptr.cast();
 
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
@@ -351,8 +351,8 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
         unsafe { ArcBorrow::new(inner) }
     }
 
-    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
-        let ptr = ptr.cast_mut().cast();
+    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self {
+        let ptr = ptr.cast();
 
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index e8b7ff1387381e50d7963978e57b1d567113b035..04358375794dc5ba7bfebbe3cfc5885cff531f15 100644
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


