Return-Path: <linux-kernel+bounces-395568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD56E9BBFEB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCAD1F22668
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBAF1FE115;
	Mon,  4 Nov 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3HB7RZ4"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516B81FCC72;
	Mon,  4 Nov 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755248; cv=none; b=IV9C0oM65BIe96UMKm63wQZXtBrEDGZ+aUG4dE77D/7Oyg3m2TXaEgSA8iPs5vGd/SNEJ6HApUtvk3QMiVl9AhfGLnj9LOBu51BP0Q5fxBHrnZALwAqVnEtFXc0jlYld99Ec5DFbmmjNLVXF5O7IfxzYg6p7u6t9+OIK5JXBS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755248; c=relaxed/simple;
	bh=RaKFmRq+awv356mjVRWSMFiriafNjmgH4ivFZVqWZyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=glOyoDaJVD4PABAP9wMwoTyGLa4RKEHKUC4c8f65xw1IG8sMNfoUjiohhmNOblq5Ago8hr5RWL3NgPSHANEgRLHdumnLC8wv22csJNUhBb5Kk6/pt6ur32TIM2O/2JO1JCCxnzGnJUFj/lYSum/SwfmznclrLR36SF6CIm+syUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3HB7RZ4; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e604425aa0so2553737b6e.0;
        Mon, 04 Nov 2024 13:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755246; x=1731360046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=153KKk/APZ+Bybt5b00w+99Kvlnzp0lTrs+B9/03GTo=;
        b=m3HB7RZ4zgjbey20l/v6F/IeEAftf0lPD04bd9u2HadfsIqHqGjrUGKWemY2ZKLqow
         UIWbEvnQlaaqunEg8W5aniX113OQEZNRuc9wavhe11tIjPQ7aNTQDrvveDkmLzgNu5XK
         gfFVVpZkHCwdVVd+7jp5Bzms2ZMBI/qW1V9SqbN/fqWMOChHKLYeQkIWX/Wu092VCM3p
         gQc3mwESsoBAo+WqTKqecO0KsfIR2Lx6YHbXl321EU2R3RBvNgbBJbYZgR8SU9vJNi3i
         CU4tMRR5hgsBgRxDoqWh9tK/irbXrtyJuGfImnb1slRGcybRjA4wEYKnzHmyqWK1RpcO
         ql3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755246; x=1731360046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=153KKk/APZ+Bybt5b00w+99Kvlnzp0lTrs+B9/03GTo=;
        b=Elqx/XUqe+YggUtXkxs+Ymt4LHLPDiF3zk95B7/gWCrKevVvjy5QKwFDFaSLv5xwBW
         2stQ+Vx/kLvw/s4zKWNS9WSaNIKHWll5Zv2CXMVMevk401d+Nw80BMmdCmAC3K3nH4xZ
         O9XdAI2yan7T/JtIHbxB8RmPJCje8bcsdFMS/Zi96n6cPsiOjatDTmsx7lcBJOLQIzQS
         rn8XK6Vsdw8xbI7qFNFvbUOXb+sA3Zgbaj2m9hlaO1L2qMOsIMPvZczKaV1BZEG3ju23
         64iwcQI7QN/bTrC+nKXAkP9wk/x7UWU5H3vha+VKE/hyO8rChZURb10/gHkuEmcL/O7Z
         5x3w==
X-Forwarded-Encrypted: i=1; AJvYcCVnjeOPjDiyIotGUzSgmfBBicJ//54qpMEXAS6QDuKCGUeCZagCbwnH/NliPU0xbK9iqXtw5YB/XrWRDNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkEdJ+2BeqZW4K96rLaxLPtLC3DO+OctkJsi914k1tD3jpE8l1
	cFEcRKwHV4i/CYuqRJufVzvHPs2iRiNubAat6GmaThsXImlyhY7I
X-Google-Smtp-Source: AGHT+IGFXUtgQpZKfrslV/XuqZLhk8XxfKrtAW7p+/Kosri28Bc5901Q5KpTZ6Q77X89v+L9p9Oq+w==
X-Received: by 2002:a05:6358:7e01:b0:1bc:57ce:9992 with SMTP id e5c5f4694b2df-1c3f9edb224mr1702754355d.15.1730755246030;
        Mon, 04 Nov 2024 13:20:46 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([102.129.152.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b1ed29sm19555817b3.53.2024.11.04.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:20:45 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 04 Nov 2024 17:20:31 -0400
Subject: [PATCH v2 5/6] rust: reorder `ForeignOwnable` items
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-borrow-mut-v2-5-de650678648d@gmail.com>
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

`{into,from}_foreign` before `borrow` is slightly more logical.

This removes an inconsistency with `kbox.rs` which already uses this
ordering.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 18 +++++++++---------
 rust/kernel/types.rs    | 20 ++++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 10819dc28b64038b9abc55b01c069826d1e5befa..3c779b343aa8c396d2d4b7efdbc0f1ef524a0f1c 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -337,25 +337,25 @@ fn into_foreign(self) -> *mut core::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr().cast()
     }
 
-    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self {
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
 
-    unsafe fn from_foreign(ptr: *mut core::ffi::c_void) -> Self {
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> ArcBorrow<'a, T> {
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
index 59e71bd158713bb8e12cac95e134f57a277c1b49..b8f3594737401a3df841f30a20c4bd85743853ef 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -31,14 +31,6 @@ pub trait ForeignOwnable: Sized {
     /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
     fn into_foreign(self) -> *mut core::ffi::c_void;
 
-    /// Borrows a foreign-owned object.
-    ///
-    /// # Safety
-    ///
-    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
-    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
-    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> Self::Borrowed<'a>;
-
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
     /// # Safety
@@ -67,6 +59,14 @@ unsafe fn try_from_foreign(ptr: *mut core::ffi::c_void) -> Option<Self> {
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
+    unsafe fn borrow<'a>(ptr: *mut core::ffi::c_void) -> Self::Borrowed<'a>;
 }
 
 impl ForeignOwnable for () {
@@ -76,9 +76,9 @@ fn into_foreign(self) -> *mut core::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn borrow<'a>(_: *mut core::ffi::c_void) -> Self::Borrowed<'a> {}
-
     unsafe fn from_foreign(_: *mut core::ffi::c_void) -> Self {}
+
+    unsafe fn borrow<'a>(_: *mut core::ffi::c_void) -> Self::Borrowed<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.

-- 
2.47.0


