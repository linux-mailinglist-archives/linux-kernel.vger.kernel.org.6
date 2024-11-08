Return-Path: <linux-kernel+bounces-401908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6739C20ED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A38228523B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0B21C199;
	Fri,  8 Nov 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/P3DRV1"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608421B454;
	Fri,  8 Nov 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080803; cv=none; b=bDeigoDYfOzswyaXLlrOKMcz+aESbUir1zzptzeE09ejkzJg5v4bn90E68mEVXBW2TpHG5rNjdUT/7y8zb/JMH9fhLWbM4q0s+OM3z5KowG1VvK+Jmo2gOEkIiZeeRNLWzScMAnGOeob6oRHztJTknjrRgU/z2tIRx+EsGe6PG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080803; c=relaxed/simple;
	bh=6lKGTEiWHqnjjUScqoKiXzOQ/By7UnBTXRZwWpY38YA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWm1jqaDS7ef0SSlkJPU6ZbciSMXpB7h9LSZNBe33H+Q0wbD7rI/hUNYPps/s1p2i4sN+r0oHMv/ao70kXcHj9EPSMluKSnTyT7Ec5W7guoa16z9nPvmU8w9urQRT2ynVUyb2YaZh0Z2pNDrdd5ABfFJ0Q49xcbCdAJHNJa6BDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/P3DRV1; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbe53a68b5so14509886d6.1;
        Fri, 08 Nov 2024 07:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731080801; x=1731685601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAw1WzI8iPuU5lh1Dp3vfnx7DLOVmd7TGCi0165fBLo=;
        b=G/P3DRV1FaKDXTvHbMY+25ED5HztR/PR0cxCqSCdL46TJ5i2eqcIu+kpHzV2D26EDA
         lTFdlEICUa2YnNnd1SF+Ey+2JlCdkDZh91/iazKv9HwHTVLMDgG/Ekz0hmVz86653z+J
         +UFDy+MVzGrFUJyZUgFQfd+YdjRJAnshMWCYXs52C2iVaMPBIBq/wozJVI9mSW8jrdNG
         j8EsIEqz5ulaa0R6LcbiRTNpD2BGgKpEzW4yX8hqA8c+zc1SanCeUzGWlm2tDVGYciaT
         oTVsfPVp/Es9un1/FzbwHaFMIhGAAAUFR+GIXsdpLCYgbGbQrmmmxxOqIK+RvZvkfynO
         U+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080801; x=1731685601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAw1WzI8iPuU5lh1Dp3vfnx7DLOVmd7TGCi0165fBLo=;
        b=WiYX0d585+CqU4hXO062w9eO9Vp9ADEuE1VbIok5ZCgremP10IOWX4i4vpiaTHw/2Z
         qk0dQrvoSuNHhPubtp7ghBF8iL6UQ88FyDxWiJB8FqmDTRGPaGwO2RhUct4Te/nJbgs4
         hQvkd7yq1usnjh914wUgHIi2RMfh8fnaJ5XtezCzaZlnNWGK+xsJFCT3Z4o5ezhZly1W
         ipZC/Bd0uFjYWhqo7YJkSXOrvBjuiS/7og8uYURkTk0FTpmgbHHrqZTMm/SCsm/H5mu6
         UBLGxe4kQxvlwsmSJFR7Wko0Rgo/9nOzCMJlAEcdBylSdh2nmbtsls3V073K2EUDmXoi
         Tvzw==
X-Forwarded-Encrypted: i=1; AJvYcCU1nOgRcdGFQthsgkpPGeslx6r8GZgoAJrnjrb2N3njMDFlq13+0NGafwTDVsMyGrurZc811lxB/eYRCwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysO/u44hixaXk3btmbcbeS+P8T/8nGvhIyEnhS+H/K8HTw22pt
	zdH80aLsKTrdyaxQMku814jElnxaCs3VRVRW6pAukQkH2l3EqH07
X-Google-Smtp-Source: AGHT+IE3g2oYBF7USCJyql+6ZFCUdNvfvo5ZVD+rGTQtScXGyeFL1bZfs0OfzaEbb6IFMWsqvtjmeQ==
X-Received: by 2002:a05:6214:5789:b0:6cb:9c55:4215 with SMTP id 6a1803df08f44-6d39e19ff73mr38427126d6.33.1731080800881;
        Fri, 08 Nov 2024 07:46:40 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:348d:4cbf:ba75:f557])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396631118sm20673676d6.110.2024.11.08.07.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:46:40 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 08 Nov 2024 10:46:17 -0500
Subject: [PATCH v3 2/6] rust: types: avoid `as` casts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-borrow-mut-v3-2-b7144945714e@gmail.com>
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

Replace `as` casts with `cast{,_mut}` calls which are a bit safer.

In one instance, remove an unnecessary `as` cast without replacement.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kbox.rs | 8 ++++----
 rust/kernel/sync/arc.rs   | 9 +++++----
 rust/kernel/types.rs      | 2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index d69c32496b86a2315f81cafc8e6771ebb0cf10d1..03b7107c60344d4f03d49c51230e114d3ab38027 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -356,13 +356,13 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
     type Borrowed<'a> = &'a T;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
-        Box::into_raw(self) as _
+        Box::into_raw(self).cast()
     }
 
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr as _) }
+        unsafe { Box::from_raw(ptr.cast_mut().cast()) }
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
@@ -380,13 +380,13 @@ impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }).cast()
     }
 
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr.cast_mut().cast())) }
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Pin<&'a T> {
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 2c9b7d4a2554278ce8608f4f4c7f9cfe87b21492..af383bcd003e1122ebe1b62a49fe40279458e379 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -201,10 +201,11 @@ pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
         };
 
         let inner = KBox::new(value, flags)?;
+        let inner = KBox::leak(inner).into();
 
         // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
         // `Arc` object.
-        Ok(unsafe { Self::from_inner(KBox::leak(inner).into()) })
+        Ok(unsafe { Self::from_inner(inner) })
     }
 }
 
@@ -333,13 +334,13 @@ impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
-        ManuallyDrop::new(self).ptr.as_ptr() as _
+        ManuallyDrop::new(self).ptr.as_ptr().cast_const().cast()
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast_mut().cast::<ArcInner<T>>()) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
@@ -349,7 +350,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast_mut().cast::<ArcInner<T>>()) };
 
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index fae80814fa1c5e0f11933f2f15e173f0e3a10fe0..364dd2dc438eb7d1c4d0a4525bf2305a42297b2b 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -418,7 +418,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     /// }
     ///
     /// let mut data = Empty {};
-    /// let ptr = NonNull::<Empty>::new(&mut data as *mut _).unwrap();
+    /// let ptr = NonNull::<Empty>::new(&mut data).unwrap();
     /// # // SAFETY: TODO.
     /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);

-- 
2.47.0


