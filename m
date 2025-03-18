Return-Path: <linux-kernel+bounces-566695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C576FA67B68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3B37A4F8A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257E7212B2B;
	Tue, 18 Mar 2025 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xfwW1Xpt"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A421019E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320443; cv=none; b=R0C1YBaIn91iRook+Ryf0POc6ZY7IN+G2obdVmmf1K1p2juuYTE599yMUEgjys+nin/4gNYRCr+IOxmWTxfO2ymM1K3pW7lcdvrdUmvaK6OC9RIU6jyPTA0TWoT9S5Y2K4NSr+PeLVPf7JdR6nJWpyP7eU4Vp68J4fs6uMjtllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320443; c=relaxed/simple;
	bh=RwSUxJCEIuMsb7Jqi8oaa0p9OZd3rsArgVJSEyzwtm8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IpxBNXTh+qCWIRtdObEbL+W0IUyh3uwg58wnVhk+YqqbVtfcJnhmft0EU3dMDuVvDcS8XDGyJ7x5TVy6HAE3PwKCpTXPdMXRJAse4tpJU426B4NXinOawj4r+iZkiVLtDBtpeuL7sJk0SMbuvZUmk/BOxuOzWhkB83rkxIRpWwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xfwW1Xpt; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so22971265e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742320439; x=1742925239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JtRRUpBmdbrhDkJPpcQ9zxxSGQP77/v+ZvbBB0uFPno=;
        b=xfwW1XptNybX8bgU8/kD6ETH851p9fQv/1zH7qG2swuOkiMZwBLUND69l6Y8GgDLbM
         HpcTPTUwxbpnDBxdvSMtHSva3G10d+/KSdyDi+zYkU/d59XxyD2U+o6gf8sdaSpSCh44
         4HvDbb9mE4HR7+jtp2euMWMgvaJNsuJcdH9cdL3HLNdZXI8BGdjUcHXC6/XRf4xErVms
         VYgVHqAV9X+d/ks4gOE6swyLAU6kISymYDaj3V9RKHybVze6rdZZe9MvEQpFfC+X3eye
         7VSy85doFVBlgmTR5TaJqRCPExb0xqRRjHNIa0P0u8jFM3hPecK1CFWsH6FU1haiDWcD
         D09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320439; x=1742925239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtRRUpBmdbrhDkJPpcQ9zxxSGQP77/v+ZvbBB0uFPno=;
        b=CHtosu4CI73XszFjlz8aV63peb8TRmbrmMKq6S8RvC4Rw1jlpMzssca5KYEhBVbBfy
         EGzpPw8hLLCPYJKqI3r8QUQ2CjYV45+eGFjdPpTD795uzZI4BdN38MzkB1UDbSST5f5y
         qVtQomqTl4zyQ+hqDlmAllaE+PKrEV5A+NpZEA18CnaEtoAR7kRt7W672Dcv4uttsxbq
         WpBNgngfM8fYRP2VziTWeNspKCe4iK7gOK3xG+/rv6j8A302TOfbyud8aqcA+9xxx2sA
         F234vzDoFsL9R59++J449n30f4S6BR8Zto1HcJlHSZw+c3Siqtxt0TK2HiqMF0UW+zer
         6guw==
X-Forwarded-Encrypted: i=1; AJvYcCVIGVGw2i3/Q/xUwISfsJUzg8UOR0th9MereWxvzO18QB/rDeKTCZ8mrxeo/7ppee6qTOR/NVHXs3ojr50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHaMM8His1d42qYez5IrWLnZW4U6gPaQsPiNo+3GNYEqExJVOa
	rRtBWt4i6FftgwkBUeTfVVheUfb0lYNFGi3UsT/I5veSKMcJbCTDoKmCQ7VnUzkj6A==
X-Google-Smtp-Source: AGHT+IEow0KUsXork9VOcbrrv1ftSkiGbKuFjzVfSZqoviK0i8inh8tCQQYcQe8VZNOsFlLNOQg7Hys=
X-Received: from wmcn9.prod.google.com ([2002:a05:600c:c0c9:b0:43c:e69c:d4e6])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5106:b0:43c:fe90:1279
 with SMTP id 5b1f17b1804b1-43d3b9bceaemr30467085e9.21.1742320439795; Tue, 18
 Mar 2025 10:53:59 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:51:53 +0000
In-Reply-To: <20250318164221.1533590-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318164221.1533590-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250318175322.1627073-2-bqe@google.com>
Subject: [PATCH v4 2/3] Adds Rust Bitmap API.
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Provides an abstraction for C bitmap API and bitops operations.
This includes enough functionality to reimplementing a Binder
data structure (drivers/android/dbitmap.h). More methods can be
added later. We offer a safe API through bounds checks which
panic if violated.

We use the `usize` type for sizes and indices into the bitmap,
because Rust generally always uses that type for indices and lengths
and it will be more convenient if the API accepts that type. This means
that we need to perform some casts to/from u32 and usize, since the C
headers use unsigned int instead of size_t/unsigned long for these
numbers in some places.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS           |   2 +
 rust/kernel/bitmap.rs | 234 ++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs    |   1 +
 3 files changed, 237 insertions(+)
 create mode 100644 rust/kernel/bitmap.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 50f44d7e5c6e..b3bbce9274f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4036,9 +4036,11 @@ F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
 BITMAP API [RUST]
+M:	Alice Ryhl <aliceryhl@google.com> (bitmap)
 M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
 R:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
+F:	rust/kernel/bitmap.rs
 F:	rust/kernel/cpumask.rs
 
 BITOPS API
diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
new file mode 100644
index 000000000000..e8117e0dbe05
--- /dev/null
+++ b/rust/kernel/bitmap.rs
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Rust API for bitmap.
+//!
+//! C headers: [`include/linux/bitmap.h`](srctree/include/linux/bitmap.h).
+
+use crate::alloc::{AllocError, Flags};
+use crate::bindings;
+use core::ptr::NonNull;
+
+/// Represents a bitmap.
+///
+/// Wraps underlying C bitmap API.
+///
+/// # Examples
+///
+/// Basic usage
+/// ```
+/// use kernel::alloc::flags::GFP_KERNEL;
+/// use kernel::bitmap::Bitmap;
+///
+/// let mut b = Bitmap::new(16, GFP_KERNEL)?;
+/// assert_eq!(16, b.len());
+/// for i in 0..16 {
+///   if i % 4 == 0 {
+///     b.set_bit(i);
+///   }
+/// }
+/// assert_eq!(Some(1), b.find_next_zero_bit(0));
+/// assert_eq!(Some(5), b.find_next_zero_bit(5));
+/// assert_eq!(Some(12), b.find_last_bit());
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// # Invariants
+///
+/// `ptr` is obtained from a successful call to `bitmap_zalloc` and
+/// holds the address of an initialized array of `unsigned long`
+/// that is large enough to hold `nbits` bits.
+/// `nbits` is `<= u32::MAX` and never changes.
+pub struct Bitmap {
+    /// Pointer to an array of `unsigned long`.
+    ptr: NonNull<usize>,
+    /// How many bits this bitmap stores. Must be `<= u32::MAX`.
+    nbits: usize,
+}
+
+impl Drop for Bitmap {
+    fn drop(&mut self) {
+        // SAFETY: `self.ptr` was returned by the C `bitmap_zalloc`.
+        //
+        // INVARIANT: there is no other use of the `self.ptr` after this
+        // call and the value is being dropped so the broken invariant is
+        // not observable on function exit.
+        unsafe { bindings::bitmap_free(self.as_mut_ptr()) };
+    }
+}
+
+impl Bitmap {
+    /// Constructs a new [`Bitmap`].
+    ///
+    /// Fails with [`AllocError`] when the [`Bitmap`] could not be
+    /// allocated. This includes the case when `nbits` is greater
+    /// than `u32::MAX`.
+    #[inline]
+    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
+        if let Ok(nbits_u32) = u32::try_from(nbits) {
+            // SAFETY: `nbits == 0` is permitted and `nbits <= u32::MAX`.
+            let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
+            // Zero-size allocation is ok and yields a dangling pointer.
+            let ptr = NonNull::new(ptr).ok_or(AllocError)?;
+            // INVARIANT: ptr returned by C `bitmap_zalloc` and nbits checked.
+            Ok(Bitmap { ptr, nbits })
+        } else {
+            Err(AllocError)
+        }
+    }
+
+    /// Returns how many bits this [`Bitmap`] holds.
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.nbits
+    }
+
+    /// Returns true if this [`Bitmap`] has length `0`.
+    #[inline]
+    pub fn is_empty(&self) -> bool {
+        self.nbits == 0
+    }
+
+    /// Returns a mutable raw pointer to the backing [`Bitmap`].
+    #[inline]
+    fn as_mut_ptr(&mut self) -> *mut usize {
+        self.ptr.as_ptr()
+    }
+
+    /// Returns a raw pointer to the backing [`Bitmap`].
+    #[inline]
+    fn as_ptr(&self) -> *const usize {
+        self.ptr.as_ptr()
+    }
+
+    /// Sets bit with index `index`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index` is greater than or equal to `self.nbits`.
+    #[inline]
+    pub fn set_bit(&mut self, index: usize) {
+        assert!(
+            index < self.nbits,
+            "Bit `index` must be < {}, was {}",
+            self.nbits,
+            index
+        );
+        // SAFETY: Bit `index` is within bounds.
+        unsafe { bindings::__set_bit(index as u32, self.as_mut_ptr()) };
+    }
+
+    /// Clears bit with index `index`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index` is greater than or equal to `self.nbits`.
+    #[inline]
+    pub fn clear_bit(&mut self, index: usize) {
+        assert!(
+            index < self.nbits,
+            "Bit `index` must be < {}, was {}",
+            self.nbits,
+            index
+        );
+        // SAFETY: Bit `index` is within bounds.
+        unsafe { bindings::__clear_bit(index as u32, self.as_mut_ptr()) };
+    }
+
+    /// Replaces this [`Bitmap`] with `src` and sets any remaining bits to zero.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `src` is longer than this [`Bitmap`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::bitmap::Bitmap;
+    ///
+    /// let mut long_bitmap = Bitmap::new(256, GFP_KERNEL)?;
+    /// let short_bitmap = Bitmap::new(16, GFP_KERNEL)?;
+    /// long_bitmap.copy_from_bitmap_and_extend(&short_bitmap);
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn copy_from_bitmap_and_extend(&mut self, src: &Bitmap) {
+        assert!(
+            src.nbits <= self.nbits,
+            "Length of `src` must be <= {}, was {}",
+            self.nbits,
+            src.nbits
+        );
+        // SAFETY: `nbits == 0` is supported and access to `self` and `src` is within bounds.
+        unsafe {
+            bindings::bitmap_copy_and_extend(
+                self.as_mut_ptr(),
+                src.as_ptr(),
+                src.nbits as u32,
+                self.nbits as u32,
+            )
+        };
+    }
+
+    /// Replaces this bitmap with a prefix of `src` that fits into this [`Bitmap`].
+    ///
+    /// # Panics
+    ///
+    /// Panics if `src` is shorter than this [`Bitmap`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::bitmap::Bitmap;
+    ///
+    /// let mut short_bitmap = Bitmap::new(16, GFP_KERNEL)?;
+    /// let long_bitmap = Bitmap::new(256, GFP_KERNEL)?;
+    /// short_bitmap.copy_prefix_from_bitmap(&long_bitmap);
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn copy_prefix_from_bitmap(&mut self, src: &Bitmap) {
+        assert!(
+            self.nbits <= src.nbits,
+            "Length of `src` must be >= {}, was {}",
+            self.nbits,
+            src.nbits
+        );
+        // SAFETY: `nbits == 0` is supported and access to `self` and `src` is within bounds.
+        unsafe {
+            bindings::bitmap_copy_and_extend(
+                self.as_mut_ptr(),
+                src.as_ptr(),
+                self.nbits as u32,
+                self.nbits as u32,
+            )
+        };
+    }
+
+    /// Finds the last bit that is set.
+    #[inline]
+    pub fn find_last_bit(&self) -> Option<usize> {
+        // SAFETY: `nbits == 0` is supported and access is within bounds.
+        let index = unsafe { bindings::_find_last_bit(self.as_ptr(), self.nbits) };
+        if index == self.nbits {
+            None
+        } else {
+            Some(index)
+        }
+    }
+
+    /// Finds the next zero bit, starting from `offset`.
+    #[inline]
+    pub fn find_next_zero_bit(&self, offset: usize) -> Option<usize> {
+        // SAFETY: `nbits == 0` and out-of-bounds offset is supported.
+        let index = unsafe { bindings::_find_next_zero_bit(self.as_ptr(), self.nbits, offset) };
+        if index == self.nbits {
+            None
+        } else {
+            Some(index)
+        }
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index efbd7be98dab..be06ffc47473 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub use ffi;
 
 pub mod alloc;
+pub mod bitmap;
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 #[doc(hidden)]
-- 
2.49.0.rc1.451.g8f38331e32-goog


