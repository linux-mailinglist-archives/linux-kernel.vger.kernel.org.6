Return-Path: <linux-kernel+bounces-395565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CC29BBFE8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47A81F2258A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B126F1FE0E1;
	Mon,  4 Nov 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR1ghJ62"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CBD1FDFA0;
	Mon,  4 Nov 2024 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755241; cv=none; b=BjDh6GecvPQwB0PnfynzfeQBbzI1asrnqTCENZ8DXrHKuXC4XdkfmlFf+vY7muaU2BvGWY0cQLJ/c1Ed+F/wiEAbAJPLO6TCUSLEEk7SNQtEBf/2qGj4brYh9ifz/GzeeYFjpBg9azEmiUjPi1U3j/GmIGAqaOofVWABnAlybLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755241; c=relaxed/simple;
	bh=NBPpIjCfCBzFzTqVitvlZTNxC1N977x8lAE5YiMeWig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HuZJK98Fy0AYNKN+uvdbxr2CunBHyYKiZFvLFuw9uKXmoeVP/XwFRfAuYzTpRO1j2735hP70iiMo6ECyJ5U7j3uxzLV1rFUX8pSW0YZ1qDh5IVuOZE3a/KHGabITWtUacN73kHfVmsqi/TJVWTjMhI6oDxh/3Ze7o9QZ7xIqWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR1ghJ62; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e5e5c43497so37588467b3.3;
        Mon, 04 Nov 2024 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755239; x=1731360039; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DkzMNh/JmDESgjanxg0KNSdGmmyOpzh6cmcoyZX928=;
        b=WR1ghJ62C2HM4vi41WctM+w1SI1G9hXm5efyQFDV5hEAd3gwrLag1Q0bAG08pOCAMH
         OCy62eUEyGqqUY4WosXRIRQ3XkXrTNW/aIxUNnBeVrou6J7pn2gs/Rppx0d5SExiS4S6
         F9tAUtppK/VeZh9P/8DVEuuK6gTtcDOfIQ0TyFlAgF65aoBeCd0C8WXpZCFjx03hny4F
         EvoMGujvGMTkeF+Ta5ePD0BeEexdcPJn1bEyCyCGZHrWxodAtxsUCW7BrSaZ7sJ2mquL
         QiaXG7WMP1W6npo2w0McVEYMw955IRbp+Q+6ptFXK5/WkIWjyeoMIiBCkB4mS/wu5NaY
         R1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755239; x=1731360039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DkzMNh/JmDESgjanxg0KNSdGmmyOpzh6cmcoyZX928=;
        b=MwtE49s/8Dr4IhryheTVfhsB6nQZgLx7NOFK3wtmN0idghbgRKbrOvDq3Nhn31d5ew
         cOYzkZk1PEo/h3wjxOy9Otu35TcVsr3NAVrDUtZXgjbWTD8D1ZxqGR2Mi2d+Y/Xm6sLw
         TXTgqrkceSznOAgJjkoch3ABltLCoaU0BxKowMVbpG6BCN9wondT2MfcWqtSrHHMWZ3w
         Sx7Rcc1h/A+C4s3BsEQJ04F/k92rEmYDpqqahZ5f2bLvUv642wFNC1CsTRa0eMpGA//Y
         KfIytoerKYzgiV+T8bxxnELgpVT/M8Qt4x83NGWrbA1MwMIHQnXeuKM/x2nHPVK4Ms4r
         z/0g==
X-Forwarded-Encrypted: i=1; AJvYcCWRFuyULzsdtF1NZYPbCxtWNVWUtUZTahGcsDb8pg8fRML3BcvFKWxxpzFQ9UwpW2YHTQjqTz2vlo9nZVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkEvRyVuSh1xKCUiQlu9YOMbYjuzqukwkhOlRPrvMq+WsOzO9R
	zPrrJyFMvMbFJLDkM6DJwu41u7fBLxUJa/c0hm1PBukvhdWfCXRD
X-Google-Smtp-Source: AGHT+IHuI/ppzNLVFJvU7dEErxKjuD+rFC6iqbqk2sB3RSCpFoloekkcinx3gYx4DNbp3qnj3yNTjA==
X-Received: by 2002:a05:690c:6f02:b0:6ea:1f5b:1f64 with SMTP id 00721157ae682-6ea521cb7edmr188939137b3.0.1730755239016;
        Mon, 04 Nov 2024 13:20:39 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([102.129.152.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b1ed29sm19555817b3.53.2024.11.04.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:20:38 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 04 Nov 2024 17:20:28 -0400
Subject: [PATCH v2 2/6] rust: types: avoid `as` casts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-borrow-mut-v2-2-de650678648d@gmail.com>
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

Replace `as` casts with `cast{,_const,_mut}` which are a bit safer.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kbox.rs | 10 ++++++----
 rust/kernel/sync/arc.rs   |  9 +++++----
 rust/kernel/types.rs      |  2 +-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index d69c32496b86a2315f81cafc8e6771ebb0cf10d1..b6b6723098b6b30743bf38c97aab0e701a5a1be4 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -356,13 +356,13 @@ impl<T: 'static, A> ForeignOwnable for Box<T, A>
     type Borrowed<'a> = &'a T;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
-        Box::into_raw(self) as _
+        Box::into_raw(self).cast_const().cast()
     }
 
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr as _) }
+        unsafe { Box::from_raw(ptr.cast_mut().cast()) }
     }
 
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
@@ -380,13 +380,15 @@ impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }) as _
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) })
+            .cast_const()
+            .cast()
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


