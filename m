Return-Path: <linux-kernel+bounces-566885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5E6A67DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5C9D7AD836
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07A1213237;
	Tue, 18 Mar 2025 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC+mtRXN"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866902144CF;
	Tue, 18 Mar 2025 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328868; cv=none; b=UFnTUSi7jLiIDa7i1FpEw/PAyiAn1gXlC5UboSSHf34MFXjuE0U85XarsU3UApEJ8rTPmbMu41S3I3T1HpyUMuZ6rhj4v++NSbrr7XLDOEjRPvKwPDhtFgQB+UX6BzgdFjgxkXIHT5Hf7OJ9I/uyTBE5lbzyYE2JSNGCR2LpVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328868; c=relaxed/simple;
	bh=MRiEmw8syRgJRG/Ds75HKnk3JF4c0ISBvoTApwOqhZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZMtdGg7ty7puspPZoVW2sKmpEVVj1ERSt6KJIXCJyiQWVbggsdzUNb9Sd8DW9uzfue1UMVQWolSTLCn365GkfO/6mlwBrj/trE+aYEtbuXGhTXTbOA9gbWqw1O2a/va0vt5F21i9DS1uVKYfHn84RNtn/OmUhmNC4Zri5HV/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC+mtRXN; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so61169606d6.3;
        Tue, 18 Mar 2025 13:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328865; x=1742933665; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zt31eb5/eW+3di5uGkFBbBmKY9ayfpvlJ8VgZ2239PU=;
        b=lC+mtRXNgXv44z0HILoFNd9lrgorg1RnW9LM7/fq1pjSZwG4cefMR5tqzyT3XpLguq
         B+PHThJ0bz/0wT4wCFKUKKzKuwEejZSwIh8a1xfGi6Zd6E0tHh4c5dq1DtrcxzEWq37k
         b7kvHhYuxbSRjmlVQTm8gDd746/D/nMGEioc0rMz3MG3eKW+SVhtI0o/HAqlUuABhhYt
         emRjppxpyuexcCjd/eRjsNf1QzjfcdjKzDqBJ4InJDIo5bk24vFIiSyBWm2lgSwmMSrQ
         JedD+up0if5cI+jNiOBx4HRxGRTpSuFT5nwgMNYYscpNptGSMeKIIXamFFfVTR6k1PVn
         QJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328865; x=1742933665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt31eb5/eW+3di5uGkFBbBmKY9ayfpvlJ8VgZ2239PU=;
        b=hja985+AGLkIqOiXO9esKKTvi/iBz/LLrIjEZ8Tm5QhoOZvx5oaZrTw8GSgAqMfy/3
         krE4rDfnElKAigvDUbRSY498+EQsZ0MpKtP8Z4zI0Y3/SKnIS9hv1VpErtPpYYWUv3Qx
         eVyBlZmKtv9sLkC//4D9+NVP+BRJM/Ti4UNi9Pknw9lQULamxBrfQoKk4x5AOuNfWO9Z
         ghehPpQCTa0bMB1gSxf7dWNbWVRTUGa3Ixte6C33QdnHAmouG3FYeG+yEz5is20y2oAt
         oxK2WGqdXabpTvkEQi+OyFKdYtxX5wQT4Zwju6oiBlPtYxHXonkD4xhUa0dv6UpLnerm
         z+qA==
X-Forwarded-Encrypted: i=1; AJvYcCVib9Ue8KLsE0SLd49DhjbI0GoU9CLXFsGaAAJ4Qo6K3GgNxYcIBt0a/cEAl0vJ4JeF8qoY8WPU/GMr0Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Eidv0Ufs57CY2agAGhQ3PaF2oOG6v11A7y6m8XC4aEMdfQQG
	Ix3rpxdCEjBNYk92W7wamWq4wM++OvIhgR9krm4EdASJLFCAa+eDJbyB4KdzEco=
X-Gm-Gg: ASbGncsB20IftOzgcCtZV5vZkpLJNkKvRy84iNSvBw3N2DbZwfNyH61w8T0yWlWM01b
	BcLO9nnmpicGhJTnPc/gz++ln7w3o+yMe7wFNiNJfh1CJAhd1eNnMKqkdka1v0XKG4T8K1BEhj1
	XqPDHxgJSlC1+/0+T5bRJGhUBt2nBIj1HNCvmDeGraF7pvwOJKrQxDHEJTdzD8DikzaPmut/4OR
	zSqXHLNZTGs6Im/K2J2JQsO53VN346uBif5LibaVgqY9v1tHMXTwWnnD1cjWY0lyOkQ7jUzKLYY
	z3i0ork2oRNiPUl6Cxv8LywF4BkSBWUBWSnQjx4lbwpM8t1NR0KSuzxLLbXyLD3+Q3ws
X-Google-Smtp-Source: AGHT+IEFVr+H4BqSEz6nAdfcWvKGKQWv8IjR3NqxQIf4XDtCbUUlTc1Euv+KVJst2zT/rT2ofKpVKw==
X-Received: by 2002:a05:6214:2587:b0:6e8:fa7a:14ab with SMTP id 6a1803df08f44-6eb29284340mr2666136d6.6.1742328865309;
        Tue, 18 Mar 2025 13:14:25 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([2620:10d:c091:600::1:e903])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade209335sm71301046d6.22.2025.03.18.13.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 13:14:24 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 16:13:56 -0400
Subject: [PATCH v2 4/4] rust: alloc: replace `Vec::set_len` with `inc_len`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-vec-set-len-v2-4-293d55f82d18@gmail.com>
References: <20250318-vec-set-len-v2-0-293d55f82d18@gmail.com>
In-Reply-To: <20250318-vec-set-len-v2-0-293d55f82d18@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Andrew Ballance <andrewjballance@gmail.com>, 
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Rename `set_len` to `inc_len` and simplify its safety contract.

Note that the usage in `CString::try_from_fmt` remains correct as the
receiver is known to have `len == 0`.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/alloc/kvec.rs | 20 ++++++++++----------
 rust/kernel/str.rs        |  2 +-
 rust/kernel/uaccess.rs    |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 6f4dc89ef7f8..977f6b2e899f 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -185,17 +185,17 @@ pub fn len(&self) -> usize {
         self.len
     }
 
-    /// Forcefully sets `self.len` to `new_len`.
+    /// Increments `self.len` by `additional`.
     ///
     /// # Safety
     ///
-    /// - `new_len` must be less than or equal to [`Self::capacity`].
-    /// - If `new_len` is greater than `self.len`, all elements within the interval
-    ///   [`self.len`,`new_len`) must be initialized.
+    /// - `additional` must be less than or equal to `self.capacity - self.len`.
+    /// - All elements within the interval [`self.len`,`self.len + additional`) must be initialized.
     #[inline]
-    pub unsafe fn set_len(&mut self, new_len: usize) {
-        debug_assert!(new_len <= self.capacity());
-        self.len = new_len;
+    pub unsafe fn inc_len(&mut self, additional: usize) {
+        // Guaranteed by the type invariant to never underflow.
+        debug_assert!(additional <= self.capacity() - self.len());
+        self.len += additional;
     }
 
     /// Decreases `self.len` by `count`.
@@ -319,7 +319,7 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
         // by 1. We also know that the new length is <= capacity because of the previous call to
         // `reserve` above.
-        unsafe { self.set_len(self.len() + 1) };
+        unsafe { self.inc_len(1) };
         Ok(())
     }
 
@@ -525,7 +525,7 @@ pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> Result<(), Al
         // SAFETY:
         // - `self.len() + n < self.capacity()` due to the call to reserve above,
         // - the loop and the line above initialized the next `n` elements.
-        unsafe { self.set_len(self.len() + n) };
+        unsafe { self.inc_len(n) };
 
         Ok(())
     }
@@ -556,7 +556,7 @@ pub fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), All
         //   the length by the same number.
         // - `self.len() + other.len() <= self.capacity()` is guaranteed by the preceding `reserve`
         //   call.
-        unsafe { self.set_len(self.len() + other.len()) };
+        unsafe { self.inc_len(other.len()) };
         Ok(())
     }
 
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 28e2201604d6..005713839e9e 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -840,7 +840,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
 
         // SAFETY: The number of bytes that can be written to `f` is bounded by `size`, which is
         // `buf`'s capacity. The contents of the buffer have been initialised by writes to `f`.
-        unsafe { buf.set_len(f.bytes_written()) };
+        unsafe { buf.inc_len(f.bytes_written()) };
 
         // Check that there are no `NUL` bytes before the end.
         // SAFETY: The buffer is valid for read because `f.bytes_written()` is bounded by `size`
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 719b0a48ff55..0aa5455a18be 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -291,7 +291,7 @@ pub fn read_all<A: Allocator>(mut self, buf: &mut Vec<u8, A>, flags: Flags) -> R
 
         // SAFETY: Since the call to `read_raw` was successful, so the next `len` bytes of the
         // vector have been initialized.
-        unsafe { buf.set_len(buf.len() + len) };
+        unsafe { buf.inc_len(len) };
         Ok(())
     }
 }

-- 
2.48.1


