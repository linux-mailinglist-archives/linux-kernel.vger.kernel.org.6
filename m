Return-Path: <linux-kernel+bounces-560669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BFAA607F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6026B3AB855
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806C613B2B8;
	Fri, 14 Mar 2025 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANMzNAVA"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1812A1BF;
	Fri, 14 Mar 2025 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741924160; cv=none; b=MZP22tTvwD8sSPKuoWrsMJmL4diC1NNhTofvJh0KcFXrjYvIfIqL90MnZz/WkxhMEFNjLSKD9tn0mspdB7e3d2CXX0GFKeTmfOcBg28lsl4ngmx5fASgSewE5cgJWmrBTUsKh+/ogXsINkXZ+oo44N8p8y3QR32WYD4utS+KsHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741924160; c=relaxed/simple;
	bh=6MHSVqZBX/1UkJClIYEhzK4ww5XncIm7fi+D554tqWk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rt5HZzw6ZpzNIAiUZ0g+nB8ZoUORbIypMK/o8gsuuoO24BhhiRh63kYaxyGsmM34SxTH02Byqjapb7S3nvUDBJn0ztgvjQIpYLrTfjHZE3tVI+e7bU4z/9eLbNBj+pu+BhmOpdVL5i2iKOJAp5sv8aooknx7LbMVxFB4mEC+OCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANMzNAVA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2217875d103so5154365ad.3;
        Thu, 13 Mar 2025 20:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741924158; x=1742528958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GyR5g/+t0etewZf3PfQfv6XD7WUS/wGrOxiRBRLJ4R0=;
        b=ANMzNAVAVSmtmljpabMo2mqcnKHWA8te0Q6A+nhH3slWCFyIjIA21CeCtnLzlAZdtd
         jzm34A7rV5rOtaC/kUqvMGZlvzfUU54D1rNyOnamVpO2keEaB8miraRnkYHlj0ko+AIn
         LaJnjpdSTs1K0lHHSt87X+M5ASGK+8t/4EMx/aA7+B/HPCS9Ui+W20PUOK2UwFEvnTac
         5fhGQWN6zC7CG0X+8ba08QSBDX9VfqksfSg7KVV5wrIEOACpMiWbOo8KfAV1Zy6abb2x
         WaBVsJDXWltG6BPrFdwweEBCr49J7o+rRY+4XG4XZvUN0fnDQgJSjyWQWStUUF39Rkco
         eLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741924158; x=1742528958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyR5g/+t0etewZf3PfQfv6XD7WUS/wGrOxiRBRLJ4R0=;
        b=nlJHTBPuRQFdMXyboxtNkD+sjqXMQQlT6sK6WSX63wRM10C4UAGy/JN3s48TEZp8Xo
         KjA5pMy7r9h8Ymeh+cHAmD7Yz5cMFThsvEpt+TPSfd3UfpRKhYVWXS4cJSv/6gNSMOws
         PLgwFyDIpGxYB5HYVQfFxYtIwq0bo7sM91fT463MPIX9mQ1CunKi3kWx4tIa9UGI46Yh
         L/6e6Zw6m7nGElsz5fyVQeLCefT6MYcZxtqbyInVBQMDxFOghGWq1IMeGONTCEE5sQnE
         1mC4M0pPyQjaXBCgds/ASgz1JHC1JbYsnWo7zOYZQEA7p1QXqpI+thKFXQI6ZFjzevnU
         c77A==
X-Forwarded-Encrypted: i=1; AJvYcCV98N2Mo2Av3JjVrci5Inzsbj/4PW+arXd2dnVEFwX9DSV5XQpX7gX2ocmBfEkGGAL0YShKO4+OWPAghKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHHF60RtNVgpr7S4roPubpP3+FjftKLgm34JY5BDH6QP8OzneT
	v7gVsd23rSFsfZNhRW3wwVgvyeMofQYMLcKAV+TPB06huwdOBkC/9mws7nx5
X-Gm-Gg: ASbGncurNjMCqjUsZaLkmPYUs255+aT3RhZ8DZQ2LbzxYEPqjtJW3UPNJYBorVBAZeJ
	BqpKSd8AwrGCZBtr/qOe7udb8VthJJGxThAd2AhKGY/rAUdV3tfamPPJP2DX5vDG1kFOA5rI9Vv
	l+faxkDF1HRq0IP3Cop+O2p6BG8tZcj/oyoR4LeI0azeLAkMWCQE+oLTfCH/MLsCpQzw5dYiH65
	CBi6oc2FZjn2hgG/5j6QlySij4JBgy87ioEP9J7A8SP8/f0rWG14+2ekiWwDVYTyxeoqZB1Uuj/
	qnxotX2HgXV3EPl1AycklbB70ix9EA52nQbGvKtmutQePPwl7/d7
X-Google-Smtp-Source: AGHT+IFudL966b1PN0CzGjZSQGWkRZpEPzupo6zFBXCHrUU99qo1VVRYbBd5DkMnmwrsk99ZMK0khg==
X-Received: by 2002:a17:902:d50b:b0:21f:519:6bc6 with SMTP id d9443c01a7336-225e0ac874dmr4989275ad.9.1741924158139;
        Thu, 13 Mar 2025 20:49:18 -0700 (PDT)
Received: from ana.. ([138.94.103.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015351a054sm199275a91.20.2025.03.13.20.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 20:49:17 -0700 (PDT)
From: christian <christiansantoslima21@gmail.com>
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
Subject: [PATCH v4] Add methods for FromBytes trait.
Date: Fri, 14 Mar 2025 00:49:10 -0300
Message-ID: <20250314034910.134463-1-christiansantoslima21@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Methods receive a slice and perform size check to add
a valid way to make conversion safe.
In the invalid case return the EINVAL error.

The conversion between slices ([T])
is separated from others, because I couldn't implement it
in the same way as the other conversions.

Link: https://github.com/Rust-for-Linux/linux/issues/1119
Signed-off-by: christian <christiansantoslima21@gmail.com>
---
 rust/kernel/transmute.rs | 67 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 1c7d43771a37..5924c0daccfc 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -2,6 +2,8 @@
 
 //! Traits for transmuting types.
 
+use crate::prelude::{Error, EINVAL};
+
 /// Types for which any bit pattern is valid.
 ///
 /// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
@@ -12,26 +14,85 @@
 /// # Safety
 ///
 /// All bit-patterns must be valid for this type. This type must not have interior mutability.
-pub unsafe trait FromBytes {}
+///
+/// # Example
+///
+/// ```
+/// let foo = &[1, 2, 3, 4];
+///
+/// let result = u8::from_bytes(foo);
+///
+/// assert_eq!(*result, 0x40300201);
+/// ```
+pub trait FromBytes {
+    /// Receives a slice of bytes and converts to a valid reference of Self when it's possible.
+    fn from_bytes(slice_of_bytes: &[u8]) -> Result<&Self, Error>;
+
+    /// Receives a mutable slice of bytes and converts to a valid reference of Self when it's possible.
+    fn from_bytes_mut(mut_slice_of_bytes: &mut [u8]) -> Result<&mut Self, Error>;
+}
 
 macro_rules! impl_frombytes {
     ($($({$($generics:tt)*})? $t:ty, )*) => {
         // SAFETY: Safety comments written in the macro invocation.
-        $(unsafe impl$($($generics)*)? FromBytes for $t {})*
+        $(impl$($($generics)*)? FromBytes for $t {
+            fn from_bytes(slice_of_bytes: &[u8]) -> Result<&$t, Error> {
+                if slice_of_bytes.len() == core::mem::size_of::<$t>() {
+                    let slice_ptr = slice_of_bytes.as_ptr() as *const $t;
+                    unsafe { Ok(&*slice_ptr) }
+                } else {
+                    Err(EINVAL)
+                }
+            }
+
+            fn from_bytes_mut(mut_slice_of_bytes: &mut [u8]) -> Result<&mut $t, Error> {
+                if mut_slice_of_bytes.len() == core::mem::size_of::<$t>() {
+                    let slice_ptr = mut_slice_of_bytes.as_mut_ptr() as *mut $t;
+                    unsafe { Ok(&mut *slice_ptr) }
+                } else {
+                    Err(EINVAL)
+                }
+            }
+        })*
     };
 }
 
 impl_frombytes! {
     // SAFETY: All bit patterns are acceptable values of the types below.
+    // SAFETY: Dereferencing the pointer is safe because slice has the same size of Self.
     u8, u16, u32, u64, usize,
     i8, i16, i32, i64, isize,
 
     // SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
     // patterns are also acceptable for arrays of that type.
-    {<T: FromBytes>} [T],
+    // SAFETY: Dereferencing the pointer is safe because slice has the same size of Self.
     {<T: FromBytes, const N: usize>} [T; N],
 }
 
+impl<T: FromBytes> FromBytes for [T] {
+    fn from_bytes(slice_of_bytes: &[u8]) -> Result<&Self, Error> {
+        let slice_ptr = slice_of_bytes.as_ptr() as *const T;
+        if slice_of_bytes.len() % core::mem::size_of::<T>() == 0 {
+            let slice_len = slice_of_bytes.len() / core::mem::size_of::<T>();
+            // SAFETY: Creating a slice is safe because the slice can be divided into T sized blocks.
+            unsafe { Ok(core::slice::from_raw_parts(slice_ptr, slice_len)) }
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    fn from_bytes_mut(mut_slice_of_bytes: &mut [u8]) -> Result<&mut Self, Error> {
+        let slice_ptr = mut_slice_of_bytes.as_mut_ptr() as *mut T;
+        if mut_slice_of_bytes.len() % core::mem::size_of::<T>() == 0 {
+            let slice_len = mut_slice_of_bytes.len() / core::mem::size_of::<T>();
+            // SAFETY: Creating a slice is safe because the slice can be divided into T sized blocks.
+            unsafe { Ok(core::slice::from_raw_parts_mut(slice_ptr, slice_len)) }
+        } else {
+            Err(EINVAL)
+        }
+    }
+}
+
 /// Types that can be viewed as an immutable slice of initialized bytes.
 ///
 /// If a struct implements this trait, then it is okay to copy it byte-for-byte to userspace. This
-- 
2.48.1


