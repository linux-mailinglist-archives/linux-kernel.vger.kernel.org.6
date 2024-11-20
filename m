Return-Path: <linux-kernel+bounces-415683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0199D39DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0CB2810EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F361AB6C3;
	Wed, 20 Nov 2024 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WclUGSCO"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95281AA7B1;
	Wed, 20 Nov 2024 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103186; cv=none; b=hc/NBEBorReH/K3gP2bm6Tx1l1RdvnCbc7aFE9Cb272ho6luBngUXTqelF2M4MTaPa09+KajF2JVXdKGf9FmeQc7MT4L6rBJroOd7wFglbipdg4ofcmlkgliy/VGz1vzAEUReBsKLspbK5SohaC424sU4YzNYarUOhtFPmPw+bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103186; c=relaxed/simple;
	bh=QyDSZQBjHFvzc3jqrmkvwyqKXSdwBmye0UohP/XlAzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hphGpuxkXpQVY1xez71SBUix4Y5kafaGrrGMOsSGVftIRRmMBKZWp8CDP+0CQrxcDyBLDffDocxGBdkaSC6E4eLHy+mWHolE1kjl1KQNbfPlATIoH0N8203XD43RONFZTuvJBWnTK046rep5e/pXHwTyMb1zY+rFAXie9+bwncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WclUGSCO; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5101c718439so760300e0c.1;
        Wed, 20 Nov 2024 03:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103184; x=1732707984; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmuQvct1rZEhDqASgfImNoAGyNp06jovTOXwI5ij+5Q=;
        b=WclUGSCOJ/rR4Kbj1WZlv6mQg1DzmhL9BdOFb4dyka2aWn8y1stCXKHhdv9J+X1TYx
         3xOorXNOPErmn72uadwJivLrd1rDzBvoIB3T2eW/bbnIfhFBmyRHv6jOFefam/V3M+wh
         16VpusVZB6SmnyXleTRnu6LkphiYvfSx5BMXI/PRgMh3DaIAbuWmPScgJx/JDH1CECor
         xU6G7BDlHunHNevLCHbB4qwu3KXbXOGZHnsqnPUVzXri0Be5mRS/xoESWPFb1qA9XRc2
         MJ0HMmvpZ+2YwoqEeUjySaKLQ5Z7ZV9UAhB63rwocQF613bX9hSIKmDwPRYPRUoUGxpo
         OyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103184; x=1732707984;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmuQvct1rZEhDqASgfImNoAGyNp06jovTOXwI5ij+5Q=;
        b=BkbdyuSQmjgjWHojipWJDOXX0Zj51sDAgoFicr2OgZLx6VJi5OIgJwbf3Vgbzp4sfj
         UrG0B/VG85sIBLJGmyRFWWyWIbOmH/MdPq4Voyuxa04MaurzRU4DgGQgRsYEKzd3P3aQ
         +WYq5C5fRpjA9W44/B0cUlfWrVS/vqEAsZWYGiOLlewAoMayyoRhNuft0et3YidybzKp
         nyupfTCf50SzDPFbh1sXI2MHJDXuXUHMz2Hgr2+GbfF6+WWxiIgpiS8fYIrxb6PIFc52
         FfVqJ4cCrjK4gRM7GZLURwWES8ReUJjIFYJIZ/6bW5A4m7/P2ZOw99vGIVc5mJGMk5dA
         E8xg==
X-Forwarded-Encrypted: i=1; AJvYcCXKewExSI8DMCnGB1FBG8TzhWij3xFdTvZ9qfm1oVM9/jIW9+BAJ/xzZN0JfEHVjfgjuN3sfSZRdvkifVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTF1TbvLgp8wlqbBAcMF3vvmKC+a6TQzl5bYTWjfWHf2hP6F62
	ESUjI+utMJxmzafm/wlIBtdpLJtSA/rZymSjV2j/u2dYryAuXqM6
X-Google-Smtp-Source: AGHT+IHQckk6WHTvkZoxgSxKIwuZ1Zwe69cv69+2Z+2HnojVP8umQtmApqzijhUdOqsTt2ZudBxrIA==
X-Received: by 2002:a05:6122:513:b0:510:3a9:c3f0 with SMTP id 71dfb90a1353d-514cf894dc1mr2327015e0c.1.1732103183613;
        Wed, 20 Nov 2024 03:46:23 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2600:4041:5be7:7c00:8dca:61d2:c8fb:a544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380b6390sm9705696d6.5.2024.11.20.03.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:46:23 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 20 Nov 2024 06:46:04 -0500
Subject: [PATCH v6 5/6] rust: reorder `ForeignOwnable` items
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-borrow-mut-v6-5-80dbadd00951@gmail.com>
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

`{into,from}_foreign` before `borrow` is slightly more logical.

This removes an inconsistency with `kbox.rs` which already uses this
ordering.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 18 +++++++++---------
 rust/kernel/types.rs    | 20 ++++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 01d85da799d77127fc99a9b270b8a7b1ef435b6f..1d26c309d21db53f1fc769562c2afb4e881c3b5b 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -337,25 +337,25 @@ fn into_foreign(self) -> *mut crate::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr().cast()
     }
 
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
-        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
-        // for the lifetime of the returned value.
-        unsafe { ArcBorrow::new(inner) }
+        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
+        // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
+        // holds a reference count increment that is transferrable to us.
+        unsafe { Self::from_inner(inner) }
     }
 
-    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
         let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
-        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
-        // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
-        // holds a reference count increment that is transferrable to us.
-        unsafe { Self::from_inner(inner) }
+        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
+        // for the lifetime of the returned value.
+        unsafe { ArcBorrow::new(inner) }
     }
 }
 
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index f9b398ee31fd5303f0224995f51d314a0c4ecbf2..af316e291908123407f08c665c91113a666fc593 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -31,14 +31,6 @@ pub trait ForeignOwnable: Sized {
     /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
     fn into_foreign(self) -> *mut crate::ffi::c_void;
 
-    /// Borrows a foreign-owned object.
-    ///
-    /// # Safety
-    ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Self::Borrowed<'a>;
-
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
     /// # Safety
@@ -67,6 +59,14 @@ unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
             unsafe { Some(Self::from_foreign(ptr)) }
         }
     }
+
+    /// Borrows a foreign-owned object.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
+    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Self::Borrowed<'a>;
 }
 
 impl ForeignOwnable for () {
@@ -76,9 +76,9 @@ fn into_foreign(self) -> *mut crate::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn borrow<'a>(_: *mut crate::ffi::c_void) -> Self::Borrowed<'a> {}
-
     unsafe fn from_foreign(_: *mut crate::ffi::c_void) -> Self {}
+
+    unsafe fn borrow<'a>(_: *mut crate::ffi::c_void) -> Self::Borrowed<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.

-- 
2.47.0


