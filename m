Return-Path: <linux-kernel+bounces-415679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBF9D39D6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270ED1F2361D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF771A76D5;
	Wed, 20 Nov 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nqddv/Y/"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DABC1A256E;
	Wed, 20 Nov 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103182; cv=none; b=MuIWDxSA0y0C9r+7nEHCMsH3SjS1egY0cxq5v0kdnNl68a5NbotMVgAJEE6Rq8Kd1txJlSJS/ubengSqnlVHtdI6pf34Ih83LpdknAt5Pfedo4ihaUykJSP8ABGZ3s3WG7RABDOGwkXRJPE1Vl8mqDDZHMwS1i0EIbLmjijCJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103182; c=relaxed/simple;
	bh=7mJvIeb2noE9wZ0A4dhqRLCY/zejQZMbM6X2lVHwQ10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWg/FVf3FJCf6IkRIJf7HkwV1PMFnkGLKYjWugGqTRGn+QfQVtPFfuQUGxf8p8t3j++KQVlQPnm8m7DynJJ6GslbIexgNgCQA2LqrDWIJQv+DqlNYNwKy7vYJ+SvzGEJUspe0hvVS5xsqJzPkJYepa/kTIBw2ABnTWeZwUjBI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nqddv/Y/; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d40e69577dso12560106d6.3;
        Wed, 20 Nov 2024 03:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103179; x=1732707979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Su+Qnr8zKK34gJVF+kBwkn9a8J+ydzKanTU7K+DUb6Y=;
        b=Nqddv/Y/f7SS/7m0HPisSTAo6OHfHY+zTl3MLTd0CLMvHz5WCI/jydcKM5GTHJ6xl0
         UlQO3a+oOJlMd2dzIKKZ7e+7C7Zs4gvQyPtxyKaioPcZnJk8afWCn5GKZ3QlRU+ueOU5
         bUe3EKjOGmEuNpA4UA0EzIx07f8zrT5/ub6vm7Zq0lQwdHI8ZDmwekrvUFqH+MVl8xQ+
         AbW1OdCHc5Ns+ZuxlHX3Lj3TGvS3bz8QdwhLB5wmEHvM3G087LOG9rbp5JrLM/LkZ6Ue
         LysQdeSKuJRMAZoOofi5ApSAoX/mmjfnXADE7ZqXMrrYq6rs4br+uq79CJHJL9JUw8BF
         03tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103179; x=1732707979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Su+Qnr8zKK34gJVF+kBwkn9a8J+ydzKanTU7K+DUb6Y=;
        b=E51sUhwf81q18yEvJ7BkmVUebQZktiUH2ulB6UbPNPpQ/MREXoXrqM6ONg7H/ZjL1u
         PWsX1+1LaK6oBMmrNLft8Fef8C1hag7bE+ikoETYF8E/dXLxao/uyqyuIB8jBOgmbCz8
         0pI689rnt2u2MvzugyPa5NQrLHa4XzZjb9NZA6203fy9clZNf59S1HUmgJDo1rHNdb57
         eCpmD9zr6U9Rvotc7ZMlcLLgYUz/nYimYuKLqoFWlesgMcvixPjHpXRqjXaH6yWPRfoO
         qCKyoPP4aH5BKFmaBPjNvHZ7NYNRAIXiH/XVEbbpbHs7OxycJfU8Zd6ty4k8GxdbAiQ/
         AlVA==
X-Forwarded-Encrypted: i=1; AJvYcCW5FGfSKoGpIn90YTQ1SMaL4ED/Vc8JChKFFZBvrR1qZ3CucGYQ/t0AkjeWe3RfRHTeYWb1Z2rjsKMXNXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg4FxpJRcr7fzKyqF51iVa43inLDxE6rxte4NLa5CQ5eJ3iJ7T
	WBtdWTpX2xRmeknBddfB9UT4SxYStzofrwNyYl2Kk0UJ0fM1dvkH
X-Google-Smtp-Source: AGHT+IEeDv4NJrNJU5Pvt8dmlRpsTDsrvAvd6gavsZ5P2bNhDwCDM/L6weIL6DR5hiIoYLxok+FoWA==
X-Received: by 2002:ad4:5761:0:b0:6d3:f51b:3ee4 with SMTP id 6a1803df08f44-6d4377b1f60mr30321746d6.7.1732103179314;
        Wed, 20 Nov 2024 03:46:19 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2600:4041:5be7:7c00:8dca:61d2:c8fb:a544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380b6390sm9705696d6.5.2024.11.20.03.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:46:18 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 20 Nov 2024 06:46:01 -0500
Subject: [PATCH v6 2/6] rust: types: avoid `as` casts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-borrow-mut-v6-2-80dbadd00951@gmail.com>
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

Replace `as` casts with `cast{,_mut}` calls which are a bit safer.

In one instance, remove an unnecessary `as` cast without replacement.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kbox.rs | 8 ++++----
 rust/kernel/sync/arc.rs   | 9 +++++----
 rust/kernel/types.rs      | 2 +-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 9ce414361c2c6dd8eea09b11041f6c307cbc7864..3f0b04609bd487e3f50247f9f1abd5394b749c7e 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -356,13 +356,13 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
     type Borrowed<'a> = &'a T;
 
     fn into_foreign(self) -> *const crate::ffi::c_void {
-        Box::into_raw(self) as _
+        Box::into_raw(self).cast()
     }
 
     unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr as _) }
+        unsafe { Box::from_raw(ptr.cast_mut().cast()) }
     }
 
     unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> &'a T {
@@ -380,13 +380,13 @@ impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 
     fn into_foreign(self) -> *const crate::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }).cast()
     }
 
     unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr as _)) }
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr.cast_mut().cast())) }
     }
 
     unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> Pin<&'a T> {
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index b4e492dd712137c7c39e3de3d39c0c833944828c..50645660a9c33cb121ee1b2469003b325000d840 100644
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
 
     fn into_foreign(self) -> *const crate::ffi::c_void {
-        ManuallyDrop::new(self).ptr.as_ptr() as _
+        ManuallyDrop::new(self).ptr.as_ptr().cast()
     }
 
     unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast_mut().cast::<ArcInner<T>>()) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
@@ -349,7 +350,7 @@ unsafe fn borrow<'a>(ptr: *const crate::ffi::c_void) -> ArcBorrow<'a, T> {
     unsafe fn from_foreign(ptr: *const crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast_mut().cast::<ArcInner<T>>()) };
 
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index ec6457bb3084ae327c38ba4ba79b1601aef38244..318d2140470a90568100f86fd8c6d8084031f556 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -434,7 +434,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
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


