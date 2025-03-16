Return-Path: <linux-kernel+bounces-563167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF24A637B7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A04816D324
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2991EDA0C;
	Sun, 16 Mar 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6mSvbhq"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521821DACB8;
	Sun, 16 Mar 2025 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742164327; cv=none; b=ageVw+HxOThz4RnUvva8A3sXxPdDyT+lWQ/S4qEVtdsPHxET8AFZel00D4RGGc5MeRRJ6QCFvxerGnzwhhQVJAVSr0RlXkW9wEf+nlz9mIo0ksgDY4xcEtvCx9dH1ESUfUK9StaQnQmoC9ZMhCv0XE1KNhKaXgEopfk7Af2IEbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742164327; c=relaxed/simple;
	bh=mmrKCOTP0QlHyNzH1bZH6zcPL2ywROdp+K21VV9cQL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RLOXmza9A3T0LOyEy2aWHgHOsQv02UrjGdKDTcNfJ9YvzAY4zGIAdHmgqc4dgMgpR1jVtFYGBGV1kdhgYM+o5TnYb+muuco8qMZeyOniW2FrxcwiKYgFxgIhqygQEy1qdQU5JxCQz6Nh6flKVK3r7NuVLWjKdLpY+MEX1ogauJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6mSvbhq; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6eafac1f047so8017846d6.2;
        Sun, 16 Mar 2025 15:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742164324; x=1742769124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6rkapsl1dsMuoCULlqyhf3BuA8jB33Df/+hoVs9skc=;
        b=h6mSvbhqR/kili2Lr/z7tjc6M/bZ8r5iuMGo5UVejgMonIV3O57EazHRKQnY8DcO5Z
         DC86PwKZDq9V0Gk3tuIuw2aTm8xQtvLSR9K3UyKOFdZBuPIQDg4LYcbXjvLulIERhWwA
         QKu9p8lJGqmK9o5LYrulO0EzjEgiXXJSon3MRufb0UZA06xAIllGwzwjulVN60hol7j+
         ArRp5RuHIOyoGspPt49DxATpnfVcFSVMpaxMOdVxomVaMwKgOCeOkmiMOcxVapELLr7X
         qufO/qHdGSjloxr+YIw8DtXMzAkeZ8R34xUcNjfkTOPxUh81RqtZc4MyihM815DCxdg6
         yVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742164324; x=1742769124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6rkapsl1dsMuoCULlqyhf3BuA8jB33Df/+hoVs9skc=;
        b=oJvogwiPjs2UhxjYfD+z9gE8YROv6/EHKcuTeRQYF6ASKpZ5mPTFfi3uy20RZTEX3G
         BsGY7OHWBriYRTZu9M1wzS0Ml9heOdZNojM7R8JjkqnWG/BhEtMecPfYGynvyw3Q0pXd
         lsNEtDgwhmLKa1+82W+s7ST4yuugPd/Wwj/spQwLmdM5ejLQnmTU931b8vQauRRhLnhb
         RELQHP5fu6Njn1cUCdo4viu8mN+Sc9V5iWO6zCnt6UNVgMNpM8dWpJDCGIiXmEak/YZk
         zUu9XwprOiMl7a7t4zvyhGAgHF0EZqA0WEdfN3J1rzJgZ0eXtRSeKeLO71A71Sifft0/
         sF/w==
X-Forwarded-Encrypted: i=1; AJvYcCVwcQpeN0vLJYv1RNS4Y7xQLlND6ZDK7389oNb7GvvK+k8pqbSkFiGmN679T3jeMi52ELyMoCGCvWAj88c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfJI63S15+9WCNIqiGNSFeKwG22M9zvMVjognG/J5vMsUMpzu
	eI3yyqQrHPtOMsQtkC+G8L4OsTeuZ70N1vepM4tAvIkeHALKZ4oSUqcpYkuPPTo=
X-Gm-Gg: ASbGncvfe4zyD+hyKopMGVQPeeyulZg5wOvN3NwHpgNjqHn+1ITRvAjiIq9VEymzAHJ
	V18OJhiBiPI0BWReOlIc80zfH3KtzTjs1tykNdKYPegDGWU1MwebYBYVaYCVIOz22vZRlW8Bv1g
	z9q+ECmE10atPYY5vNP8n0cVs2gKDWXk8wNOql4+36NvHabViRV1tiJhctg7M/eWoI4glnC4O4/
	qvVzB6xd4B84UJas/TJLTKdeyMTKG0cuU+eF5jXjCSNo5FVi1CxMXFrm8LrMcAVXJLt2nDrmaS+
	k13h+iu3kd+LSvi+MifpacASQQqNK907tMJbnpOfhSdWEYDTE4mdit6T2/V6k+Sbq/L+
X-Google-Smtp-Source: AGHT+IGnZJYVSuOawBG3HnXGtfS1/dTnspEKlDB34ubWSJduIX+N/JeJmvhz8cOwyT/5P0E6Bcva2w==
X-Received: by 2002:ad4:5ccd:0:b0:6ea:d629:f492 with SMTP id 6a1803df08f44-6eaeaacd846mr157384816d6.29.1742164324316;
        Sun, 16 Mar 2025 15:32:04 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:ac75:40f2:fdb1:31e5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade3343b8sm48262146d6.69.2025.03.16.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 15:32:03 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Mar 2025 18:32:00 -0400
Subject: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com>
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
In-Reply-To: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
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
---
 rust/kernel/alloc/kvec.rs | 19 +++++++++----------
 rust/kernel/str.rs        |  2 +-
 rust/kernel/uaccess.rs    |  2 +-
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ae9d072741ce..d43a1d609434 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -183,17 +183,16 @@ pub fn len(&self) -> usize {
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
+    /// - `self.len + additional` must be less than or equal to [`Self::capacity`].
+    /// - All elements within the interval [`self.len`,`self.len + additional`) must be initialized.
     #[inline]
-    pub unsafe fn set_len(&mut self, new_len: usize) {
-        debug_assert!(new_len <= self.capacity());
-        self.len = new_len;
+    pub unsafe fn inc_len(&mut self, additional: usize) {
+        debug_assert!(self.len() + additional <= self.capacity());
+        self.len += additional;
     }
 
     /// Returns a slice of the entire vector.
@@ -298,7 +297,7 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
         // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
         // by 1. We also know that the new length is <= capacity because of the previous call to
         // `reserve` above.
-        unsafe { self.set_len(self.len() + 1) };
+        unsafe { self.inc_len(1) };
         Ok(())
     }
 
@@ -475,7 +474,7 @@ pub fn extend_with(&mut self, n: usize, value: T, flags: Flags) -> Result<(), Al
         // SAFETY:
         // - `self.len() + n < self.capacity()` due to the call to reserve above,
         // - the loop and the line above initialized the next `n` elements.
-        unsafe { self.set_len(self.len() + n) };
+        unsafe { self.inc_len(n) };
 
         Ok(())
     }
@@ -506,7 +505,7 @@ pub fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), All
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


