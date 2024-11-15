Return-Path: <linux-kernel+bounces-410965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE0C9CF313
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35071B44768
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2D1E0B8A;
	Fri, 15 Nov 2024 16:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xw1HeUph"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AE1D63FC;
	Fri, 15 Nov 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686457; cv=none; b=hLeGLJd/4e5oSr45OYB4mAiyKMYOR77Ip3mi91msoyKcFg9xS6etOhBZLzDkSyqxPGtmx3+NB/i7eUJQbTA9ZDnvIhiM4jAU5SP6Zz3Xb/3nzlNiYJVd7qvk2StYg5cY/IGLiww48h5gKKyJbxVG0bYLOJQrASnweiYIoixwaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686457; c=relaxed/simple;
	bh=HNy+9nUqOcFliTBXO2gfEmlBwkeMaQCGKYGJHlnZAFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3N8EbvDCrZgTSJVcjoicVkFNzool1GCle6ux97DEWHSq67wJT3lPZokbCMczXvvARBOiYl8p9+pNkWrJhp3nat7vsyniGV6696WPqzVxjp78Yu/H/nI/dAbGRbFtDwHA6+PsfHFlyulLiim35THmmLh5+kROZ9vlA+EFKCIX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xw1HeUph; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d3e9e854b8so17740916d6.1;
        Fri, 15 Nov 2024 08:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686454; x=1732291254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8RL6IVuwbU3Nzq4s8WpDXT1DA1rRZrDISccJYcmcYQ=;
        b=Xw1HeUphOpVmfqhW2LlXBi+TdfI7fPdM0UURUEhGLERVFnqI+zj7DqoxE+UkdHJ/RH
         iNUH/IZDPVKBguGZ6CYft7aGZ3y5JbQ6J0TsrFdGEBDmci+HiC/Bwxb+SUksocwF31rE
         s67kA5NojDFmPORSnYx5DrQVGxOyUssaF/I9W+nm/LsSng0HM1oUbob4utnDMOb64TWB
         3cSPB4BRnVDEjMiyFrC3nxG6g8RK93mB8hAGfH8aogoJ1ptcd3PeIGQIN2N+SBvd59oN
         w/hxHq/js3Nax5vILAOlg3BRYd3qut1V4hG7CwX3Ua8vor14Xk4msvQ0m1WDZXBBSiRF
         zUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686454; x=1732291254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8RL6IVuwbU3Nzq4s8WpDXT1DA1rRZrDISccJYcmcYQ=;
        b=Baw4owioRKx+SYLvix9ocUQBfO93dZPZyrNm92ddBraOY5zFUZ/eLAvMLdf4bzhcEC
         GVG8u+GSxIfi5kaZhRhBm/MejYZmtau7cAcTLt0+gJ/1yxQb6tRZ8PS35AIXZ+zSEU6Z
         W+3VrSP2N4WG2d0iIi7EtqV0ZuOv9LQFXkgXFUSE0MJxlGpcv6liQ5ZKGWs4YcFsiPch
         NYKhfHGf/BtZG99zLlqdzScYgimjMCOghvVLIDGwDRs392mE5C7pU660acQutY8I9aMX
         b1vyAsr535CBKkunry8qa9PsxYYn+wjz24mE6iaPBY4md7O93rPQG03c8F7fDVn2ekCy
         ymZg==
X-Forwarded-Encrypted: i=1; AJvYcCW4kNcaloTofVZjkMfEUy5wjv1aMgeIN9EXdVItusUkVCQ/JCgd/tzSCpumkxZ3RujhDl+NuoV7iwob4TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRbiaEX+eOp8gUsLlkmCIgTmWo3lg6Fd7yvn2RPlIzPG83C/o
	glfePdQI2EkNab77NubjnWdKtJag+23o6jd/awpruB2XNfcWmhTL
X-Google-Smtp-Source: AGHT+IF9kEAzxcPhzWOt1ayU20i6D0IVqA/Wg13JazP8oSyHkVpsqyDZVwzmdCNXYq847983HlmHyw==
X-Received: by 2002:a05:6214:ac1:b0:6c3:6344:d4e1 with SMTP id 6a1803df08f44-6d3e9099ec9mr129398346d6.20.1731686454319;
        Fri, 15 Nov 2024 08:00:54 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:edce:cf6f:2815:775e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984576sm171108785a.25.2024.11.15.08.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:00:53 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 15 Nov 2024 11:00:47 -0500
Subject: [PATCH v5 4/6] rust: change `ForeignOwnable` pointer to mut
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-borrow-mut-v5-4-86204b249667@gmail.com>
References: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
In-Reply-To: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
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
 rust/kernel/sync/arc.rs   | 10 +++++-----
 rust/kernel/types.rs      | 14 +++++++-------
 3 files changed, 20 insertions(+), 20 deletions(-)

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
index f51d965c54ced5d6653b7d3f8f29fb206a5ad2b6..fd7685921c7c9866f963adef122dfe45a7afd87b 100644
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


