Return-Path: <linux-kernel+bounces-403222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B989C32BD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1707F1C209CA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7CA76034;
	Sun, 10 Nov 2024 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOTGfsq2"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11BE45C1C;
	Sun, 10 Nov 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248056; cv=none; b=t6GL9mqosd/hYVSYlb1AXRiuzx2AAmSfCzcZUd+pCxs3Li6M/3GFXkVwgoi4hgohv/415gEksGB3XqLFJQbdB7qhZiMsMapehL/et7DnzxNFdHbr2IS9acP5I1suyKc9Ye63mHnSk004dw8WHwMsWFRujV1HR+nvLbrbgXNvG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248056; c=relaxed/simple;
	bh=yzIxA9Yc3SV2h9u+uX5+lLn+hZyCb87b80nRs5uFvn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MBUE9W/Xg0E26w1DZQfWtqWxGvoUqViiFb2iPJT+X5mFM6LnnLkl13QAsWdMjGRJQz7Dx8Y4hiM3/1GaQA/y5hGCIx+yOFXR9JY6ps3GFQnxkZiQ7GAlUPJbM0L6PBBP9e2kRIrpr81cQhr7cLpchJ+3WBZ/5nyNd3+nvJawjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOTGfsq2; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1539faa0bso237761785a.1;
        Sun, 10 Nov 2024 06:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731248054; x=1731852854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reYyPGTg6eKoJotuL98ojk5akNG5NxkowlB57z4VXg4=;
        b=MOTGfsq2qeKCx8Rrdd5OXJlDNNfm4ll+EZ+SC10IcUKd+DrtQOMcJKzd+32oMDR7q2
         NR1qwnmI13NuVSuqzG8VjKItvVmjHfPatCqgbMnwC7RW+MiFL1xjO91ozSDCiKTROsXd
         F3Odhj4OP2yiA11XqocdNCf642kGyh+tIAdJ62ODl1kFT8bqwvBXOCok5OGl1bbfixvX
         FYfELOYz3O9Ux4JM/QI076EDNk6eKjUao1Kbaym0/gQBPTSv3oOMhYuFHdQsL6LQnOI9
         ovqWebn8r/VYiq6pvJHbwwSgUDjwKbZdMZ+imKjt1gyM2J3jpzFXuRxWvDSiMKnqE68+
         J4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731248054; x=1731852854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reYyPGTg6eKoJotuL98ojk5akNG5NxkowlB57z4VXg4=;
        b=lRwfkANJddUJwfQZmbybmSC7QHWNVBlcP+apED6t1ZlIiIuzwhkuIRb+zwscTwJ43g
         JjKwcY4KtZR9BF9N3B1HS4MJhUgCopijMQzlz/rrgLmgAVb+4Iex6KwR4Wb4Na9SH7nj
         r96nppkcc/Y7zb7N0vflaP7pPPXIspZQSQhTizPFdsm1OHwCNQDUg8EcN5cdsJpYRB93
         122OC4kxLJVIPUkiqz5FngXxwtXHvmjpgH0ogbH2uja0L50QUV1/QP+ujFZ9WOiLlcVh
         ObCHlrLf8gS4A5QRYOtIEL9h8hia/9YwEVvR0li2q4Kbu+Wq8H1nsofvfliWGXtPDI2b
         0yXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX92It5BUVG5qoTHaeUos8LXAsigJSWs5gtj28iQBkpWXyNziw7ufz+0zOOKDkPUas2d/MtyI2YJRZc9RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsVBTIpRAnu0PV2k5MA2OOzamglsFCS7v92IbPBokUIG+y4nYU
	pdJk5VktKn7XNzXU3SRTx59sg/6ztl0wmaQHr5Lpe8Sk98W71etW
X-Google-Smtp-Source: AGHT+IGmQYOGNMS2bDxjMyIWZPm9NcM9ErEgj67eoRXksArXIibQ2FBLb4LHaesksaMkugBHwb4IgQ==
X-Received: by 2002:a05:6214:449c:b0:6cb:ee7b:7abd with SMTP id 6a1803df08f44-6d39e165b28mr141114156d6.27.1731248053581;
        Sun, 10 Nov 2024 06:14:13 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:3d4c:5fc2:8f61:bb43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961dfa0csm44570046d6.14.2024.11.10.06.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 06:14:12 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 10 Nov 2024 09:14:03 -0500
Subject: [PATCH v4 2/6] rust: types: avoid `as` casts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241110-borrow-mut-v4-2-053976068215@gmail.com>
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

Replace `as` casts with `cast{,_mut}` calls which are a bit safer.

In one instance, remove an unnecessary `as` cast without replacement.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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
index 2c9b7d4a2554278ce8608f4f4c7f9cfe87b21492..bbb6ca8ff7d0e079c7f0efa7702a91622759cbd7 100644
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
+        ManuallyDrop::new(self).ptr.as_ptr().cast()
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


