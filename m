Return-Path: <linux-kernel+bounces-401911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 766B59C20F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA76BB244BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BA921FD9B;
	Fri,  8 Nov 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4CtaAfb"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B77421F4D1;
	Fri,  8 Nov 2024 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080809; cv=none; b=Fy7WcbyM/9gJ+D94c2sJSuClWPc5FxarP1XTyVtaFZF6iaGT54C9rPo1HA4Z/cBZqC8NNdi1bcD6Ysw2YRidP9JVrCpj8Mh3o/SLtKCpx3SPQC+Y+V5l4IkD/pxasn2fw9BmuYw7nQfhNQBDXrmeofmxVg/SMPZFwQnubrA2lFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080809; c=relaxed/simple;
	bh=DscdtGEIP6lNbD3bNTf3ET8BAfmlcl7kfLImx6MSw68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZlFPhKCkhcI/mzXCBQirqjIqRlry6rProObhLP39SX2HmtKXtIgx4ZnjMysqjTuho+4F14fGS8Ki43+BEZ+AmNIffxYq5m8A54MFUKSITKrY3z85fwYOTBxI1cSY0DtgK34C/HcDbc0JKUJWoJgq7AbNh+xGpYnmgKB+Mcr6jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4CtaAfb; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbe700dcc3so13757976d6.3;
        Fri, 08 Nov 2024 07:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731080806; x=1731685606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vei6IGay3rEvWDI111yr234z1idQdutVPTK6aMtpgJQ=;
        b=E4CtaAfbQGzkZ3YSZDInmc2xWZbiD4UsGvD4MzNDuQsty8W5ymKY9ET67HXjxGjiY+
         zf94oNx+b9YUEy4sfvygokUEtbFs37lNMWY2jZl4ky+VG8DJV2rNH9+C7B/H3BJNvdce
         01PUwgSy0SPNwOgidBZBC8YlXYoYLV/vPjelmuCmatnVpbw1vD6Z4NqxakBS7rQ2Tpmq
         QQVx00b9VBy2AgD+ly450O6YpzG+/uKr4n6VZoi+Zwk92tNVs/N5ww542lDejsSgatNO
         J5y5Y6nNI2PauH0eYijf3NLUmpEC+jDfQGUFg7InvLolfOp23i9+cJXrXMQ19jVZL+/R
         Gn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080806; x=1731685606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vei6IGay3rEvWDI111yr234z1idQdutVPTK6aMtpgJQ=;
        b=Udd+886REsyPBQWttNPxG3CvyPNwD8CDLss9J5Ssaz971xWM30txfzImZzNW+iTOih
         h5HklHb/L2PCGM/nyjPbBEuJxQWJp3uSw6V1PEtkcuulFPMvku38yL3vA47SlzmqEgeS
         wGAdZIyOhFU+EnD6R8w0F0j1Jj2VBTpib9bC4ESr4d7hLwAgIt7gEP4d7NJyKUYQKv1/
         R2Rd8Fyo5bCzA8W5gm6JQu3YnhhPklbqEBeH5i+uBGEIgQJmZzDvVvIcvMrNGKqt21l6
         TdHmuhD44LuZR0yG2/uWhsm1d2nO2TFS59E0hrGJP2PCVX/fxBPAEhWyhILFH88+ndk8
         5QnA==
X-Forwarded-Encrypted: i=1; AJvYcCXZqOXqWWxkFwRnDf6htfK32cvnXa+qian93FdGuDr1EU3xnHusqzsc6brV26HmrU4iJWTHLiE1WKvwitw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyynPUo9n8ssf6vqYhEa3wErEpxWFUkvhq9Xzr74YP/Ayi9NS4T
	u9a3lvB3OobhmOzai6IiiVaIov96PcAKFrcGpLeYIplRBYD+SR3x
X-Google-Smtp-Source: AGHT+IHgECdzsK7mTZqpJGJP/F0dEYOfmrr9wDoV2NmEBtcxMonvVMsiUFsgAtNCxbxIRmKVnELOMQ==
X-Received: by 2002:a05:6214:5501:b0:6d1:9f63:6d5e with SMTP id 6a1803df08f44-6d39e1554dbmr42499476d6.10.1731080806391;
        Fri, 08 Nov 2024 07:46:46 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:348d:4cbf:ba75:f557])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396631118sm20673676d6.110.2024.11.08.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:46:45 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 08 Nov 2024 10:46:20 -0500
Subject: [PATCH v3 5/6] rust: reorder `ForeignOwnable` items
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-borrow-mut-v3-5-b7144945714e@gmail.com>
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

`{into,from}_foreign` before `borrow` is slightly more logical.

This removes an inconsistency with `kbox.rs` which already uses this
ordering.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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


