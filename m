Return-Path: <linux-kernel+bounces-403225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D554E9C32C0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F492810DC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498161369AA;
	Sun, 10 Nov 2024 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVfZIiAr"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07080132103;
	Sun, 10 Nov 2024 14:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248064; cv=none; b=qhgfQF6rzUCtGrBHj9BWszGvHiT6zIfG3l4c2Ovor94kuDpd2Jaiy3d3miKTRDWqth2Q73fQ3fOjzxFcOXwddmhch/9FjNbNZbZmM7o8kUqXsgjC6IJZ/v4eLjAKSJdIOolk2OY8aBbqOVIbpbb431e0W+0kLmau2qoYz/+NUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248064; c=relaxed/simple;
	bh=DscdtGEIP6lNbD3bNTf3ET8BAfmlcl7kfLImx6MSw68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=liLYlFnYqrvDDg+dncYVAf0LFHLHqqKJsyY356G2N/QoJ5rWrtIUJ+viZl8vB3dM8ywT/SwfhW/UzSIvZG3TBTp6zISy+J8OKS4wS3JbwPU87CpT1s0LE2R9riwPlal+W6AxgBJkxOICRSiFKOzAUjCJWsLRxatx43dqq5hPDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVfZIiAr; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbf347dc66so25300686d6.3;
        Sun, 10 Nov 2024 06:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731248062; x=1731852862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vei6IGay3rEvWDI111yr234z1idQdutVPTK6aMtpgJQ=;
        b=YVfZIiArl8MjqRfFOjW5OIBzDtp2uNhZCL6W6iOE85TrudiNOh9vuPuo9BBiArCn3Y
         wMgrW685f9RCRME0+LXw/XB6UzkN7dsq7qC590v1TJOPFYBb9/P9/VAf2p/uIUJZ0va4
         7zfGGa5hJUx8HMx8XFdNxbGQt4rb+Lu9HJID1YhX9Ny+usc8qmYJHz5DukJBu4DwCYT8
         oxnwnQ8FOp+nPFaG7VA1bfKYuZwj950qAseKxkKTx6VY+Zn7Xh57APvowie+7IqrIxZL
         wkQfO4TWlyyHr6lIsnXDn/uYIVBnkk8uLNNHCvK2IxJA8NEYY4AOHSnjWceaB6M9D12K
         7lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731248062; x=1731852862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vei6IGay3rEvWDI111yr234z1idQdutVPTK6aMtpgJQ=;
        b=JkHSsxCjveyIygziqA4MMRv1+4cy0ttK+Ue9Nz2R/58X9lK1znfaOO5NROVwt7tKO5
         5lLGa6f8rk2TBzORwMdJo8/88QZXesUe46MpSgEpExbGpHvdDDW06pljm0fSxhaXXuTq
         B57mlXtNrcZ7x25fQex9XiGWj0NNIpY1Xo3zX0C0Ae9psrUEesTp8Wtca89xUxHf+3Fd
         6AJrBIu5K9wPwaOy9DV307QuU6NRcN2MBC8sHst9UUVdtYxT9DOMwYYnpPOQxjmUn0S1
         kSt5RtngwAIguejeLeSzDLikna5O5FS9pc7SQf+4GZJlh50Dnq/QZ0jqgdYDijvDCXbD
         Z9bg==
X-Forwarded-Encrypted: i=1; AJvYcCXCRnMtZeKJQkWpu6t9IFlW0L8tHqbtpSxDKe7PYq7QzvLcOHfnJCiPPBfnadVIQa1TkGh96AKYb5nJtBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztATqqTliGZGCfP/FGWt2qQnqRv+ersSAZDyaM5xnBPPD41ZAf
	OsvqC+EoUo9nKboACLhZqvJ3eNTwPtQTYKUM5EHvD6OOTdn9Qk/T
X-Google-Smtp-Source: AGHT+IGMMTOjAbpcHcn7wEsGpOveAaSgymjujiD1RVgTNxz5EW1I9oezGzivWHpyvCIE1ucCcPfOoQ==
X-Received: by 2002:a05:6214:5886:b0:6cb:faee:76bd with SMTP id 6a1803df08f44-6d39e19d781mr126937976d6.37.1731248061925;
        Sun, 10 Nov 2024 06:14:21 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:3d4c:5fc2:8f61:bb43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961dfa0csm44570046d6.14.2024.11.10.06.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 06:14:20 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 10 Nov 2024 09:14:06 -0500
Subject: [PATCH v4 5/6] rust: reorder `ForeignOwnable` items
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241110-borrow-mut-v4-5-053976068215@gmail.com>
References: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
In-Reply-To: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
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


