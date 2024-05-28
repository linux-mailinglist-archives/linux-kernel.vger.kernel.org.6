Return-Path: <linux-kernel+bounces-192580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364EC8D1F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4177A1C22ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8016FF5F;
	Tue, 28 May 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZyN2iFJ"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52217108A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908307; cv=none; b=ZPMpAwlYWRm1knq+o4eLm6RMSaeh+f9lcbf6CVUgRmkkxyTqjvKuEED/9x1nvow/V87CapcQ4xTQbUju5oJ1Wy9zjgi+vIdvV91vgRe9nCMoDrhAHwJWw5G4rk+dnZDf1BkPvVuPLWlyyuVzEvQnu9diPCGWk9JUScq2Gmp253M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908307; c=relaxed/simple;
	bh=yYu+EAbmrLlEDaJXxUlWd5cGuX40snAODQjVSX7+z6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pnanSwZK9isp+mjfDFbDk/JF7bmb41l1/HPso6h1SjSHml87I0R6jo3EoamEnQ1TQRi2XKn22F5hSSQnzqbiSlPTAi9Fv9uGU9siPJrDtMO1efpGciHeNyVX5aRS6kSiJUMogHF2988t2eFi6gr7u+FaLaPHf07eZ2h9OTCUo3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZZyN2iFJ; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2e95877b88fso7468421fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716908302; x=1717513102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9/4bIUoqG75SiXX4ggGIII0PXg7f1u44UaqTYS94zc=;
        b=ZZyN2iFJmXdUAUyRYkPfvGWewQPCfO/ZtSTs8gT5NkP3S4rLcPcFb9yYdnJFemG6jb
         fNxRpXPg0vMPA0k7dYmE8DXWzN73xu/ZN/1zbojL54cVs/u53RlKrp3yczClBH/wB1ic
         Vg71TrW4Jv4+qAvAo+I+0s5tsQPkDQE7YS8LnhzAoxkcqX25bvErBjeTHOm6/C7pSIR5
         li4g2PqVWkAyPGjGEUv5mih6N5Y4erboQgckIgQyJwYhKPKbRRqJcDN/M3sx4X9bZkt9
         WGJztpEjtHXwCEn/QH4pkELvZEKm5VSCRWI7VOIFV7KZxKRZy53K3+01DJh+UYkLwnQT
         bAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716908302; x=1717513102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9/4bIUoqG75SiXX4ggGIII0PXg7f1u44UaqTYS94zc=;
        b=DPii6r9pbE/VIedvlTvSDs0EfqrE0zarBv/wN/GhMdokV3CjM1apa9RPG++AS+SSmT
         M2eROOdu6jb+06Yc4apot/0ix5Dde5VtPM7CqIjt7qOq5QwG0L744Ej6EfuPWgKjI4WY
         xNpxot4NiCbGJ/dUyjncwLPhJZWBoiRdBJnUjBN9BQMP1SUvojpQnoMLGv17txzT5nY0
         +Ef4rXi3Gx7rD4XFRLlVLLCuEQcnwRUsIi68muSuuCT5NiDh2qTl8IO0rsm4HhDaCSgu
         j4YIGOaaVvAsuDXUDTQq5O8Pe6vgRNVOrs4zHnGAi4IL5MqUtm7J8b+z1Ji57lRwCqIS
         6ljQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJHYC60zuvo767VF8HvOphac9mKnEHJeUR5c0pMp5nlwEnG0KJry5/ES8I4dOY4cswK3KUeTHTq6lWyBgp9bWMOlktmwJUKVpdTEHk
X-Gm-Message-State: AOJu0YwI5U6Yd80CRAUI6D73LTdoVHvAoVBvdV/scWP/bcoGvNHLiVyb
	Bi7AEezW0UirtFYONXJqVOntZ99+gHVTPrxGPGEf7SQqVuCCpQwjidNaKPP131+tjgunEs+UuoP
	iYq1wj1duPCcggA==
X-Google-Smtp-Source: AGHT+IGI0oSXsScGynqqZZ2qwR5qKbUrUE71Co+pWa+5ECFU6Ac40a2IMZtYKbVJYyka3eZNWCz/z+D1TV0BmGo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:360a:0:b0:2e0:d8c9:990b with SMTP id
 38308e7fff4ca-2e95b27444fmr106591fa.6.1716908302093; Tue, 28 May 2024
 07:58:22 -0700 (PDT)
Date: Tue, 28 May 2024 14:58:04 +0000
In-Reply-To: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=9020; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=yYu+EAbmrLlEDaJXxUlWd5cGuX40snAODQjVSX7+z6k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmVfEB6oia3O2ePKqSvHFP2bMtfCznNnjJ6XHWK
 p+dntQJgACJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZlXxAQAKCRAEWL7uWMY5
 RuYID/0Zn/Ekx3yhhKl8ze+ZbQzTKxxhXSitWFq4evNnN7TxwgP5on/9bu3I4gtYDFe787qYSj9
 BOCif2gFbd/W7XnW2o0c4X44ErtiRtxHIxRN9v+BKfZCw5QQARt8Ajgsui4ZfRYwEWk44TPZI1Y
 ZQTmnG9HQ1sfgWJZDxSWzWPnFQ/y3r7fHtuFkKQ0eT5vm738ccBDWCX4XX19tH9Mr7CgaOoMQnu
 OquFHYfIDW84czELfZA/wxol/7ce8K8ryQibE6naSMDfDSInpHzGfx8/ip8PtM9Mi/jDby2llEO
 nT0Zl8jquE9Pe7raOb3reL8EWbRnIQpOF4/IIYqakQtDvI5fM4Z+TgS2S6kD1o83Hpg3ku22YvS
 syoIxmuGiZ8E4R1mMfy9mU/qoQGf6OTWSfNu+EycjF7B2+bWIRSXAiu8zEyfuXbJktrruMZFHWV
 fsvstUp7l71TeB77N1rF2vyk7xgkxGRylsQPfG/ED3UuJEO8Xx7FdHMuAtBIzqJX64qyC/lh+Mq
 1W7nAeH1p02ib0EQGuTuP20f5kPoK8dQqaILUGYUKSoVf8OJlZIcoZobaU+TMGjtE9ZFjaTEZHZ
 Kmcyjbt85Yq0OSAPNijN/SRH7zbXdnauNWXi3h+wi7DmKTGme5m2Rc26ifu9o9W9e8qOef1bzSQ q8YkdHOAa9SgfJA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240528-alice-mm-v7-3-78222c31b8f4@google.com>
Subject: [PATCH v7 3/4] rust: uaccess: add typed accessors for userspace pointers
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

Add safe methods for reading and writing Rust values to and from
userspace pointers.

The C methods for copying to/from userspace use a function called
`check_object_size` to verify that the kernel pointer is not dangling.
However, this check is skipped when the length is a compile-time
constant, with the assumption that such cases trivially have a correct
kernel pointer.

In this patch, we apply the same optimization to the typed accessors.
For both methods, the size of the operation is known at compile time to
be size_of of the type being read or written. Since the C side doesn't
provide a variant that skips only this check, we create custom helpers
for this purpose.

The majority of reads and writes to userspace pointers in the Rust
Binder driver uses these accessor methods. Benchmarking has found that
skipping the `check_object_size` check makes a big difference for the
cases being skipped here. (And that the check doesn't make a difference
for the cases that use the raw read/write methods.)

This code is based on something that was originally written by Wedson on
the old rust branch. It was modified by Alice to skip the
`check_object_size` check, and to update various comments, including the
notes about kernel pointers in `WritableToBytes`.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs   | 64 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/uaccess.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2e7c9008621f..bd189d646adb 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -409,3 +409,67 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
+
+/// Types for which any bit pattern is valid.
+///
+/// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
+/// reading arbitrary bytes into something that contains a `bool` is not okay.
+///
+/// It's okay for the type to have padding, as initializing those bytes has no effect.
+///
+/// # Safety
+///
+/// All bit-patterns must be valid for this type. This type must not have interior mutability.
+pub unsafe trait FromBytes {}
+
+// SAFETY: All bit patterns are acceptable values of the types below.
+unsafe impl FromBytes for u8 {}
+unsafe impl FromBytes for u16 {}
+unsafe impl FromBytes for u32 {}
+unsafe impl FromBytes for u64 {}
+unsafe impl FromBytes for usize {}
+unsafe impl FromBytes for i8 {}
+unsafe impl FromBytes for i16 {}
+unsafe impl FromBytes for i32 {}
+unsafe impl FromBytes for i64 {}
+unsafe impl FromBytes for isize {}
+// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
+// patterns are also acceptable for arrays of that type.
+unsafe impl<T: FromBytes> FromBytes for [T] {}
+unsafe impl<T: FromBytes, const N: usize> FromBytes for [T; N] {}
+
+/// Types that can be viewed as an immutable slice of initialized bytes.
+///
+/// If a struct implements this trait, then it is okay to copy it byte-for-byte to userspace. This
+/// means that it should not have any padding, as padding bytes are uninitialized. Reading
+/// uninitialized memory is not just undefined behavior, it may even lead to leaking sensitive
+/// information on the stack to userspace.
+///
+/// The struct should also not hold kernel pointers, as kernel pointer addresses are also considered
+/// sensitive. However, leaking kernel pointers is not considered undefined behavior by Rust, so
+/// this is a correctness requirement, but not a safety requirement.
+///
+/// # Safety
+///
+/// Values of this type may not contain any uninitialized bytes. This type must not have interior
+/// mutability.
+pub unsafe trait AsBytes {}
+
+// SAFETY: Instances of the following types have no uninitialized portions.
+unsafe impl AsBytes for u8 {}
+unsafe impl AsBytes for u16 {}
+unsafe impl AsBytes for u32 {}
+unsafe impl AsBytes for u64 {}
+unsafe impl AsBytes for usize {}
+unsafe impl AsBytes for i8 {}
+unsafe impl AsBytes for i16 {}
+unsafe impl AsBytes for i32 {}
+unsafe impl AsBytes for i64 {}
+unsafe impl AsBytes for isize {}
+unsafe impl AsBytes for bool {}
+unsafe impl AsBytes for char {}
+unsafe impl AsBytes for str {}
+// SAFETY: If individual values in an array have no uninitialized portions, then the array itself
+// does not have any uninitialized portions either.
+unsafe impl<T: AsBytes> AsBytes for [T] {}
+unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 77957d7ec011..80f7e7ca2f5e 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -4,10 +4,16 @@
 //!
 //! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess.h)
 
-use crate::{alloc::Flags, bindings, error::Result, prelude::*};
+use crate::{
+    alloc::Flags,
+    bindings,
+    error::Result,
+    prelude::*,
+    types::{AsBytes, FromBytes},
+};
 use alloc::vec::Vec;
 use core::ffi::{c_ulong, c_void};
-use core::mem::MaybeUninit;
+use core::mem::{size_of, MaybeUninit};
 
 /// The type used for userspace addresses.
 pub type UserPtr = usize;
@@ -247,6 +253,41 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
         self.read_raw(out)
     }
 
+    /// Reads a value of the specified type.
+    ///
+    /// Fails with `EFAULT` if the read happens on a bad address, or if the read goes out of bounds
+    /// of this [`UserSliceReader`].
+    pub fn read<T: FromBytes>(&mut self) -> Result<T> {
+        let len = size_of::<T>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        let mut out: MaybeUninit<T> = MaybeUninit::uninit();
+        // SAFETY: The local variable `out` is valid for writing `size_of::<T>()` bytes.
+        //
+        // By using the _copy_from_user variant, we skip the check_object_size check that verifies
+        // the kernel pointer. This mirrors the logic on the C side that skips the check when the
+        // length is a compile-time constant.
+        let res = unsafe {
+            bindings::_copy_from_user(
+                out.as_mut_ptr().cast::<c_void>(),
+                self.ptr as *const c_void,
+                len_ulong,
+            )
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        self.ptr = self.ptr.wrapping_add(len);
+        self.length -= len;
+        // SAFETY: The read above has initialized all bytes in `out`, and since `T` implements
+        // `FromBytes`, any bit-pattern is a valid value for this type.
+        Ok(unsafe { out.assume_init() })
+    }
+
     /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
     ///
     /// Fails with `EFAULT` if the read happens on a bad address.
@@ -310,4 +351,38 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         self.length -= len;
         Ok(())
     }
+
+    /// Writes the provided Rust value to this userspace pointer.
+    ///
+    /// Fails with `EFAULT` if the write happens on a bad address, or if the write goes out of bounds
+    /// of this [`UserSliceWriter`]. This call may modify the associated userspace slice even if it
+    /// returns an error.
+    pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
+        let len = size_of::<T>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        // SAFETY: The reference points to a value of type `T`, so it is valid for reading
+        // `size_of::<T>()` bytes.
+        //
+        // By using the _copy_to_user variant, we skip the check_object_size check that verifies the
+        // kernel pointer. This mirrors the logic on the C side that skips the check when the length
+        // is a compile-time constant.
+        let res = unsafe {
+            bindings::_copy_to_user(
+                self.ptr as *mut c_void,
+                (value as *const T).cast::<c_void>(),
+                len_ulong,
+            )
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        self.ptr = self.ptr.wrapping_add(len);
+        self.length -= len;
+        Ok(())
+    }
 }

-- 
2.45.1.288.g0e0cd299f1-goog


