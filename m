Return-Path: <linux-kernel+bounces-356159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED21995D65
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76222823C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A774A41A84;
	Wed,  9 Oct 2024 01:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6tBizck"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E733D9E;
	Wed,  9 Oct 2024 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438498; cv=none; b=kAWRzUP9iqHOlgGSKb94Z/Qf9W2zV+pGr9i04f1irWozPJGBSgeXTqpbeGMP28uBfMXPMx65Rqxsnc21Kkx934ClHwBYVCmbVRnJGWFE+gGj5PMoOd0LJAQd25wzLpkJvQZPNHbFKtR4DjfMszx0IcKnw5qjSDMyONRye27YaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438498; c=relaxed/simple;
	bh=QB5NCT+C5/RxLUryQmgEXrHDz+jvjJf41PoQ6PO9Ono=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HJQrKIJfLHumqMX3M7UKFVgotTXM5iS266k/rVMwaUcyrj5cBXpNEiptU4OrZkXQvZuukSedu4o+ZZYi0QvUEvFppwSSRP/k4whxp2I+nmf6sggAry00CLnBhSCj5bgDONrPnphJtOw5R4+NIDkJyH1Kjc23zwIrBQNyDCsuOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6tBizck; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e018dfb5fso238552b3a.2;
        Tue, 08 Oct 2024 18:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728438496; x=1729043296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JDSsl/cewZa/jFNzlIPSVBXNAxNEgjHI3CQK3ciJS1I=;
        b=O6tBizck2xSoEqQDnhNvlHTPpf88Iup1rh3q/HOeqoMt9OqKNNgHCftcm4++WgVC3l
         Z6NSa7NEpRa38fLBw2Id0YzCzwjwTxPZrU3owtv9j6IEf1uo8Y2qz7GMPmVF7b+NnjOf
         tM54rCY+sdgjStpD2kRWDXEPpzGGZWm8pLuraf+hbXShMchGR0SVkhgzpiYnuT0PfzBN
         gGLmz//DFiLsslRkUxUTxK7vx/F1921VJypabvvGwItCEukqA31EFrfH2oRvmnvx0Tb2
         XPPFlq449V8frIaU1PIpkW/FFkkrnnLsZ3nDfL/DDPVhTJOHtBeFbA5nS0qmAVb0Xzom
         FwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728438496; x=1729043296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDSsl/cewZa/jFNzlIPSVBXNAxNEgjHI3CQK3ciJS1I=;
        b=XDtcEt26bxAcakSoxHkXVE6k7ol/UDs6wOAoDBfzykEQUJETdCa0Vfgdin3IUboFyV
         hbBdjYH/ZJATTLcdEM2BalCnsGeR8vo9NVvKG8cAo6QikbxHVBxQTTbk2S60A+oMPvgZ
         KNyBtYVJ7cevyeYj5FkZJocCzYi+bIg0YdaMH6hnU91Lp26eDW4BjQCAuA81ep57IxBy
         z9bHVei6Oic2HrnYRtmZCt5//q3Wse68dgPdLzKvnfW2WCFBe2jyW97r3eOO00AMg4SN
         wI4DZLX3vj0wLSfnRdaamIK+AELVlXtweUz0ribdVghgRhDroB9kfkMq5QM4xOOapoxA
         LDJA==
X-Forwarded-Encrypted: i=1; AJvYcCWq8jyqepb4B8soJt3/RQy0gfQ8pbPzc8mXyP1jEk7EAzKrupMKfZHmZsL8LnIUncCH2PJQqyKsf/Sv7yA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vDO4ohkcXT4PYUGbZuljX78l/IkIDDr2KLodSKqRCKGLMljt
	+Wt0MAbOfEkQIVSfOPQPzv+RoTgJ6tiFINl7VDbFdDaq88el7dh0YcCHi/r5
X-Google-Smtp-Source: AGHT+IHJWk1/Xlu1M6LtsuGfH/TT2Je+u28M9Dr6MCIjmMG+qZy0ZvZ3vpLCMPkUVKft/RWb5+RWjw==
X-Received: by 2002:a05:6a20:1582:b0:1cf:4903:7f66 with SMTP id adf61e73a8af0-1d8a3be2fc1mr673018637.2.1728438496328;
        Tue, 08 Oct 2024 18:48:16 -0700 (PDT)
Received: from archlinux.. ([138.94.103.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7e619sm6705918b3a.219.2024.10.08.18.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 18:48:16 -0700 (PDT)
From: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>
Subject: [PATCH] rust: transmute: Add implementation for FromBytes trait
Date: Tue,  8 Oct 2024 22:47:50 -0300
Message-ID: <20241009014810.23279-1-christiansantoslima21@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add implementation and documentation for FromBytes trait.

Add new feature block in order to allow using ToBytes
and bound to from_bytes_mut function.

Link: https://github.com/Rust-for-Linux/linux/issues/1119
Signed-off-by: Christian dos Santos de Lima <christiansantoslima21@gmail.com>
---
 rust/kernel/lib.rs       |   2 +
 rust/kernel/transmute.rs | 302 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 290 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index dc37aef6a008..5215f5744e12 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -18,6 +18,8 @@
 #![feature(lint_reasons)]
 #![feature(new_uninit)]
 #![feature(unsize)]
+#![feature(portable_simd)]
+#![feature(trivial_bounds)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37..f2d99c136017 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -12,24 +12,298 @@
 /// # Safety
 ///
 /// All bit-patterns must be valid for this type. This type must not have interior mutability.
-pub unsafe trait FromBytes {}
+pub unsafe trait FromBytes {
+    ///Converts a slice of Bytes into a Reference to Self
+    ///
+    /// # Examples
+    /// ```
+    ///    pub unsafe trait FromBytes {
+    ///        unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self;
+    ///        unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    ///        where
+    ///            Self: ToBytes;
+    ///    }
+    ///
+    ///unsafe impl FromBytes for u32 {
+    ///    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+    ///        let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+    ///        &*slice_ptr
+    ///    }
+    ///
+    ///    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    ///    where
+    ///        Self: ToBytes,
+    ///    {
+    ///        let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+    ///        &mut *slice_ptr
+    ///    }
+    ///}
+    ///
+    ///let slice_of_bytes : &[u8] = &[1, 2, 3, 4];
+    ///let result = u32::from_bytes(slice_of_bytes);
+    ///assert_eq!(*result, 0x4030201);
+    ///```
+    ///# Safety
+    ///
+    ///Guarantee that all values are initiliazed
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self;
+    ///Converts a mutabble slice of Bytes into a mutable Reference to Self
+    /// # Safety
+    ///
+    /// ToBytes in order to allow only types that implements ToBytes
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes;
+}
 
-macro_rules! impl_frombytes {
-    ($($({$($generics:tt)*})? $t:ty, )*) => {
-        // SAFETY: Safety comments written in the macro invocation.
-        $(unsafe impl$($($generics)*)? FromBytes for $t {})*
-    };
+// SAFETY: All bit patterns are acceptable values of the types below.
+unsafe impl FromBytes for u8 {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+            &*slice_ptr
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+            &mut *slice_ptr
+        }
+    }
 }
 
-impl_frombytes! {
-    // SAFETY: All bit patterns are acceptable values of the types below.
-    u8, u16, u32, u64, usize,
-    i8, i16, i32, i64, isize,
+unsafe impl FromBytes for u16 {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+            &*slice_ptr
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+            &mut *slice_ptr
+        }
+    }
+}
+
+unsafe impl FromBytes for u32 {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+            &*slice_ptr
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+            &mut *slice_ptr
+        }
+    }
+}
+
+unsafe impl FromBytes for u64 {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+            &*slice_ptr
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+            &mut *slice_ptr
+        }
+    }
+}
+
+unsafe impl FromBytes for usize {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+            &*slice_ptr
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+            &mut *slice_ptr
+        }
+    }
+}
+
+unsafe impl FromBytes for i8 {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+            &*slice_ptr
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+            &mut *slice_ptr
+        }
+    }
+}
+
+unsafe impl FromBytes for i16 {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+            &*slice_ptr
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+            &mut *slice_ptr
+        }
+    }
+}
+
+unsafe impl FromBytes for i32 {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+            &*slice_ptr
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+            &mut *slice_ptr
+        }
+    }
+}
+
+unsafe impl FromBytes for i64 {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+            &*slice_ptr
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+            &mut *slice_ptr
+        }
+    }
+}
+
+unsafe impl FromBytes for isize {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const Self;
+            &*slice_ptr
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut Self;
+            &mut *slice_ptr
+        }
+    }
+}
+// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
+// patterns are also acceptable for arrays of that type.
+unsafe impl<T: FromBytes> FromBytes for [T] {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const T;
+            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
+            core::slice::from_raw_parts(slice_ptr, slice_len)
+        }
+    }
+
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_mut_ptr() as *mut T;
+            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
+            core::slice::from_raw_parts_mut(slice_ptr, slice_len)
+        }
+    }
+}
+
+/// # Examples
+///```
+///let slice_of_bytes: &[u8] = &[
+///    1, 0, 0, 0,
+///    2, 0, 0, 0,
+///    3, 0, 0, 0,
+///    4, 0, 0, 0,
+///    5, 0, 0, 0,
+///    6, 0, 0, 0,
+///    7, 0, 0, 0,
+///    8, 0, 0, 0,
+///];
+///
+///let foo = <[u32; 8]>::from_bytes(slice_of_bytes);
+///let expected: [u32; 8] = [1, 2, 3, 4, 5, 6, 7, 8];
+///
+///assert_eq!(*foo, expected);
+///```
+unsafe impl<T: FromBytes, const N: usize> FromBytes for [T; N] {
+    unsafe fn from_bytes(slice_of_bytes: &[u8]) -> &Self {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *const T;
+            &*(slice_ptr as *const [T; N])
+        }
+    }
 
-    // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
-    // patterns are also acceptable for arrays of that type.
-    {<T: FromBytes>} [T],
-    {<T: FromBytes, const N: usize>} [T; N],
+    unsafe fn from_bytes_mut(slice_of_bytes: &mut [u8]) -> &mut Self
+    where
+        Self: ToBytes,
+    {
+        unsafe {
+            let slice_ptr = slice_of_bytes.as_ptr() as *mut T;
+            &mut *(slice_ptr as *mut [T; N])
+        }
+    }
 }
 
 /// Types that can be viewed as an immutable slice of initialized bytes.
-- 
2.46.2


