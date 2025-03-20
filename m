Return-Path: <linux-kernel+bounces-569024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C23A69DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02673BCC05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A121D5CDD;
	Thu, 20 Mar 2025 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkFDN4B+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D442372;
	Thu, 20 Mar 2025 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742434850; cv=none; b=rD7rN/Rm242IuLMPLL7q0o/9Bn3aymVC80jPz5eGlodvuqSyTfPbUNm2KGbDDVyxu6irWy7MRG4GGokZu1cz2ll8MiiIMAeIi/368F89C7d5raRqB9CA00tdS6kf3kx+uNg96RRF/rsyrf8tpduABobalY8YujXAZBbu4wsAbgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742434850; c=relaxed/simple;
	bh=HGmiF3HS4vBLGxfE+Tk5FDvNHWfEqXj33fBrePu3Jiw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HuBu5P/2uwNI7/MrRMP47AqGUWx10R0v0xsw5lsuDrGlCe8xOLA6VJBRibANDPctsT0d5YmegEQD4IlnyTXcPZ/RiVGZaAyhidOh3+9aEBCCM6BhAm1dh3vGZ1ECZkUANzdP7JihVS7SrlqYYa8K65pjnCppTP/3Zk/77oTR/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkFDN4B+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224104a9230so503625ad.1;
        Wed, 19 Mar 2025 18:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742434848; x=1743039648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOjUd27nufztLF2S6KVSqoGMZpiaZqdZp9+YAnPXvP0=;
        b=ZkFDN4B+RNHLtzFURMFbpwMUEt2A0bHO5ejfx/M2+jtN/GuggEeSRdoLLLhoCFrybD
         hQT3NFdmpG9T+29wmwklq95N/NE2zvu/G5PJyjdvWBoTtpwTEhaZpEtwCHKrb1T2kEFI
         tdMBhZa/7y40uj7I2akWL6KGnj4b1RdR9Sjhmqmt0JP4vM4Sg+P58NUJqhL3BhyVVOnq
         7r/30OwBGuMXkKsnp2IjyY0E7oyHpyWSgSXmLXjDmjS7ez9LrCD43fX9WDGYIwpcaQ5w
         4l2f/m2xp7sOcocpXco3fYJH7WRLeO7qeRZVgupuc9sGz5nH56TCE5pbQluunG5Efie4
         aNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742434848; x=1743039648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOjUd27nufztLF2S6KVSqoGMZpiaZqdZp9+YAnPXvP0=;
        b=T5KYEd9OO26pvxF2NOjDeViGRlrLcPTzq9NCv+T6rAphMismFT0N55l75dYlwVfCDA
         VPTNPNzsUyvh+1I0HGiFMrKE9Uv9yySnMn03BI6qDIEHlezTOJV7qRtLPfO/E+dRd+dK
         jWd5laHY0gNrTzc69DrcbNRquO7oDpa+usYx308A+XX9yxsu6XyGp3UXmItWtjrdc2Cc
         6o/8f39VUe8Ihyo/9sTjqbsL6V9sGYmx2div0DQGp6AhFuRa7w4drLhPd7kv3A4E8dGy
         /a0wFfktLX70gahAZebyb7AMM7nHIXGSkYxdM2sZdv7nEJ1GiMOpdcJQTBPuivKa/Pma
         rupg==
X-Forwarded-Encrypted: i=1; AJvYcCWZlESmP4aI0bW7XxFePcpAfdf2g+NNlcOKUuFsTTKACPKq8ug8F3QQfw8ZLIRn2tn+XEslkqj6J5fKz2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGkCgzUstI/Donk5LXOnVMNIguG9sML7VtZMS1Z8NITkEw+zom
	ocLvrq/xGjMSKP9sLH6pvrAwOHmZUDj7pBU0YRiA7lwvXGpPfzrweOgfPbYM44Y=
X-Gm-Gg: ASbGnctgSb6zeFMT6U2yLVDZdXHADRGP/6zCiJJ2ah1HYitT07e0SMEyD+YuQsoMQvB
	k+zdstgT1A6clTqNMCANO3RstP9n3YsVHnYXGGZ3eFImzai2US5u66HYdr82tk/aOqoLhHXhCXh
	KtRRGwjKQGXu/AAMfsF5WquzZ1Os638+1Wi3stDqK70kgGZRRmwwrHnNgcj++mZ7DrUVY+ksxai
	yeOLBL6E1ZEz71vfA2Z4B6UCr9yQS1QUOLK7VtSsuKUDC/xBdRR9yEjm/Oycfd/at+oENpZPuJK
	nv5cXNNkY0pL9sQCWGJC//S5kOW986tPwVpgx45L32flbRLdLkOdIRqjhz3rU3u7+6BIh0e9IQ=
	=
X-Google-Smtp-Source: AGHT+IGnN6FZ7JH7eIbqHIfnVzzCo8VIr/3epLGLHo5i4eRABYj70aPsNYSWDgH9z/8CmL1tYSzthQ==
X-Received: by 2002:a17:902:e542:b0:224:252c:eae1 with SMTP id d9443c01a7336-2264c5f7c3dmr25621925ad.6.1742434847815;
        Wed, 19 Mar 2025 18:40:47 -0700 (PDT)
Received: from localhost.localdomain ([138.94.103.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf61a44csm2463494a91.37.2025.03.19.18.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 18:40:47 -0700 (PDT)
From: "Christian S. Lima" <christiansantoslima21@gmail.com>
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
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	~lkcamp/patches@lists.sr.ht,
	richard120310@gmail.com
Subject: [PATCH v5] rust: transmute: Add methods for FromBytes trait
Date: Wed, 19 Mar 2025 22:40:41 -0300
Message-ID: <20250320014041.101470-1-christiansantoslima21@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Methods receive a slice and perform size check to add
a valid way to make conversion safe.
In this patch, I use an Option, in error case just
return `None` instead of an Error and
removed some commentaries.

The conversion between slices `[T]`
is separated from others, because I couldn't implement it
in the same way as the other conversions.

Link: https://github.com/Rust-for-Linux/linux/issues/1119
Signed-off-by: Christian S. Lima <christiansantoslima21@gmail.com>
---
Changes in v2:
- Rollback the implementation for the macro in the repository
and implement methods in trai
- Link to v2: https://lore.kernel.org/rust-for-linux/20241012193657.290cc79c@eugeo/T/#t

Changes in v3:
- Fix grammar errors
- Remove repeated tests
- Fix alignment errors
- Fix tests not building
- Link to v3: https://lore.kernel.org/rust-for-linux/20241109055442.85190-1-christiansantoslima21@gmail.com/

Changes in v4:
- Removed core::simd::ToBytes
- Changed trait and methods to safe
- Add Result<&Self, Error> in order to make safe methods
- Link to v4: https://lore.kernel.org/rust-for-linux/20250314034910.134463-1-christiansantoslima21@gmail.com/

- Link to v1: https://lore.kernel.org/rust-for-linux/20241009014810.23279-1-christiansantoslima21@gmail.com/
---
 rust/kernel/transmute.rs | 74 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37..5f2cf66187ad 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -9,15 +9,53 @@
 ///
 /// It's okay for the type to have padding, as initializing those bytes has no effect.
 ///
+/// # Example
+/// ```
+/// let foo = &[1, 2, 3, 4];
+///
+/// let result = u8::from_bytes(foo);
+///
+/// assert_eq!(*result, 0x40300201);
+/// ```
+///
 /// # Safety
 ///
 /// All bit-patterns must be valid for this type. This type must not have interior mutability.
-pub unsafe trait FromBytes {}
+pub unsafe trait FromBytes {
+    /// Receives a slice of bytes and converts to a valid reference of Self when it's possible.
+    fn from_bytes(bytes: &[u8]) -> Option<&Self>;
+
+    /// Receives a mutable slice of bytes and converts to a valid reference of Self when it's possible.
+    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
+    where
+        Self: AsBytes;
+}
 
 macro_rules! impl_frombytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
         // SAFETY: Safety comments written in the macro invocation.
-        $(unsafe impl$($($generics)*)? FromBytes for $t {})*
+        $(unsafe impl$($($generics)*)? FromBytes for $t {
+            fn from_bytes(bytes: &[u8]) -> Option<&$t> {
+                if bytes.len() == core::mem::size_of::<$t>() {
+                    let slice_ptr = bytes.as_ptr() as *const $t;
+                    unsafe { Some(&*slice_ptr) }
+                } else {
+                    None
+                }
+            }
+
+            fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut $t>
+            where
+                Self: AsBytes,
+            {
+                if bytes.len() == core::mem::size_of::<$t>() {
+                    let slice_ptr = bytes.as_mut_ptr() as *mut $t;
+                    unsafe { Some(&mut *slice_ptr) }
+                } else {
+                    None
+                }
+            }
+        })*
     };
 }
 
@@ -26,12 +64,38 @@ macro_rules! impl_frombytes {
     u8, u16, u32, u64, usize,
     i8, i16, i32, i64, isize,
 
-    // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
-    // patterns are also acceptable for arrays of that type.
-    {<T: FromBytes>} [T],
     {<T: FromBytes, const N: usize>} [T; N],
 }
 
+unsafe impl<T: FromBytes> FromBytes for [T] {
+    fn from_bytes(bytes: &[u8]) -> Option<&Self> {
+        let slice_ptr = bytes.as_ptr() as *const T;
+        if bytes.len() % core::mem::size_of::<T>() == 0 {
+            let slice_len = bytes.len() / core::mem::size_of::<T>();
+            // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
+            // patterns are also acceptable for arrays of that type.
+            unsafe { Some(core::slice::from_raw_parts(slice_ptr, slice_len)) }
+        } else {
+            None
+        }
+    }
+
+    fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
+    where
+        Self: AsBytes,
+    {
+        let slice_ptr = bytes.as_mut_ptr() as *mut T;
+        if bytes.len() % core::mem::size_of::<T>() == 0 {
+            let slice_len = bytes.len() / core::mem::size_of::<T>();
+            // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
+            // patterns are also acceptable for arrays of that type.
+            unsafe { Some(core::slice::from_raw_parts_mut(slice_ptr, slice_len)) }
+        } else {
+            None
+        }
+    }
+}
+
 /// Types that can be viewed as an immutable slice of initialized bytes.
 ///
 /// If a struct implements this trait, then it is okay to copy it byte-for-byte to userspace. This
-- 
2.49.0


