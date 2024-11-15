Return-Path: <linux-kernel+bounces-410964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A8B9CF0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 043E2287C68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531B1D8DE8;
	Fri, 15 Nov 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5zTv5L6"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDED11D63CF;
	Fri, 15 Nov 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686455; cv=none; b=hx1Sapb7qDx25qQCtpzRtKjd2mKIRdhEcnrVstfPgy6oHFSSGE0b3wmnLtpnt4F7gxlcDZfB2TrrTHTXI2uMtxyRuIxw+0hPQdBg2jCCFc/xMl9qv4Aol3xvoWgYMwFfeHsPxPT0R3e5SC9zjS0TckgKm38U+sjGRebCUBJoLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686455; c=relaxed/simple;
	bh=zqqeVLO2qNcpbmAl6URmXHfYvsjiUsA8EfKduPUx/w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApLFkz8vdkmU7OdJwfmHgyvl4WoH4VmAuIpIbFqLtHiDtc3enJSGmGnNYRypP4A/G/ecx43IOh0YPDsJgtxfdvfDdHR2x7x3v6D90I9eUyYmOyWxzAeDY5KZXGEDgtw3SI/lH9P3tRwc4cYAs4q7nZ2wf5AYfmZiXPHwkw32BSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5zTv5L6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b35b1ca0c2so206341185a.0;
        Fri, 15 Nov 2024 08:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686453; x=1732291253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgZJqR6zDxqZPtY0MpN8/3DWRajRDw9cKKhSk/KNZmI=;
        b=c5zTv5L6E2ejrajb2PNOTpahDm6czRoOeFlDhHS3KKiPLD5+7olm5eM6Ye4wkJg1I7
         PMrtv/o42fz846OiIClyR1IQHhlN32xBP8LeG/IoUgOO0UIRCWsCnKQ2W6AsW2SYquZq
         hM4OybDVEAA4HIPQEW33tAB92HXu3Sv8pA2qZtIZFnAnBc4vJzYr7LrU5/qKXZHLsvrX
         jHxAuI4pM2pG7DUu5k1QZ+vy1pgv2O58BRxLA7wo/YRPA+Q2xHK2yeAMOZUAF1PvRRmz
         BKtRc31U4KJ7zzQR0IyDDCFh0XNsY9GsOfSVnRypxpwYu9eWgFjjSCSDSmGmvbji6taj
         ItTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686453; x=1732291253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgZJqR6zDxqZPtY0MpN8/3DWRajRDw9cKKhSk/KNZmI=;
        b=PjkPuksAA6qmtwT+KrcO+kM3a5RrgA3/3lb1wpEeGlE6ZTVx+Dl279osSOk3sujq9b
         n+IJ4eHLLiCYQ9QOYXpOhnYgPNLNKE4FSnYqurzD5p7k+QauELciKFlZ0hVSDGCDpcT9
         A2uT3oru7Ykyc3qZlgTsCklaOtzzIqZ2HKXcqjL+L884IqoSrW6gzRXtfK5rDTKzoavu
         nSL/EOejg+52EoDYLyZz2hFuu+3umTsFvTfDz7eSvN6lT9dyjqhHL+mQiWJbNs2TAU/x
         RWLPYQXfmoI0k4HMnypxAYgGwnthI/XbySxdVcbpy2vk//omEqwbast8udP2lJun59uq
         GjHw==
X-Forwarded-Encrypted: i=1; AJvYcCXOLuul51C8JF1NtJY7shCrBGUET+w60MIQsZR5zoqbgrtJH55rBZBDsaQ5gl9ApuJGW0REfNtkKq3Bk+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfzxcwyDl+HMjxU4GjwquuApcJNeOE/ThgJnmbREFnZK8arjA
	cdCemBuroxKcxnxH3ei0Nyb3OM4ajAMu4Je40R83eFoZaCmpnMQ/
X-Google-Smtp-Source: AGHT+IFj8nJX3PEH0JvUZxiPEDPISwsk/z2HiCDUTWD20Ice8QWc6PiPAvSySlqvkc4AGHrPuHLJpQ==
X-Received: by 2002:a05:620a:280e:b0:7b1:1216:ef33 with SMTP id af79cd13be357-7b35a47ddc1mr1316516885a.7.1731686451084;
        Fri, 15 Nov 2024 08:00:51 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:edce:cf6f:2815:775e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984576sm171108785a.25.2024.11.15.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:00:50 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 15 Nov 2024 11:00:45 -0500
Subject: [PATCH v5 2/6] rust: types: avoid `as` casts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-borrow-mut-v5-2-86204b249667@gmail.com>
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
index a7eaa29f08a40a0f46d616c5b6aab8f9897a0f62..f51d965c54ced5d6653b7d3f8f29fb206a5ad2b6 100644
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


