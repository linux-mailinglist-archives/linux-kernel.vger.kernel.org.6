Return-Path: <linux-kernel+bounces-571142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229B8A6B9B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC304821A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0458E225761;
	Fri, 21 Mar 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOaPoJJY"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CD22541C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742555753; cv=none; b=P0Nx88cFYmQdDh+Uxdw/8bwKVGYGelPJGpiv616wpJFU2E+5LbKsPq45yCV2mibjwM+jIk0b7Ucx5+Y1bPan53BQB6XDSCfiNBggoK7nXX0eTHSlGxpZP6fJQ4s8HdSNWpD8/miEwRS5U5QwVdysie8IPt8yj7B5M2EYFZln3DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742555753; c=relaxed/simple;
	bh=52XF71t94HX1b4PtkkHe4zcTM2sOl7sXef04LHQCB+I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WBsCgQe3v4O/iGu+lwl1tMjjnYvSCCzgi7U+80sjgnHj1yTziuuIFFZma+JNpZTxULyWB3kEccQfMnmuv/3qvrdDrXtl/z7B43GBePRhJAAkcxn8JsXNoSL/DCzz737HF2CG6AAdkphFG2P5dDdyISss1L1+pZCi8Hl+auAnkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOaPoJJY; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d51bd9b45so3122635e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742555749; x=1743160549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ANVuGu+YPWyyFIkyf4GgjdezK/DY1T5LrEUy7hOvR3s=;
        b=UOaPoJJYmB9MnWAGCW3f1WQ1LxUpoeBPixb0OtWy9NnU3aVa2mfO23JhYv6AWa12ya
         X9KHgBGPVL71eiWTI0uZaItkuePtxUnBsFjCPJVmIrNVGfci1zviVe+MflD898YQNdxp
         Lx8DJJw8myQVPMFDo/7yp4Z5dfBkKDoqpmVT98mrKXGyRAJ+UWot5A4YfZ2Rt/n96aJ7
         xr/fEG2IFx0KvXdaj+9OHoMKIo2fIHtQPO4tDuJlnAz2wYWKAqiwSYcytNOgT4b9Uneb
         TjCZxalTPKW80sxb41Mkz+Xk2vDolYJXWFpqRNpZK8uGCRoCEYn0lqvLlQjKg77tBJSp
         Pz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742555749; x=1743160549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANVuGu+YPWyyFIkyf4GgjdezK/DY1T5LrEUy7hOvR3s=;
        b=qGTULkNY8ukaZsmc3/SkWqNMZofRTzvm6TTA4+ppGhGr7m86ToM6seht9/zPHwZGyJ
         G677gLI8M2cWlH/k3RkB1ckrD3Q2uD6I6xZI0fevVh0ziDXwomMpkH3fHKxa9rzxRcDY
         041+HGUBPwX35Mj/Au9aGm6rOfUOUaXGPXrdtH3OS30nhltvdfHCZ8TCJ3w+FwoRmhQu
         tR5letJfNaPgKrVw3UVH4gWd8dd/kAuRdHzuu1Zpc2MVFD2K6Tf/s2y6QC7TG+j45ZMg
         4r14ciYpfBsWnlugY0RL3DMVrYNd2rxN1qWuEBClzN1A3TtrqOHSytXBy3krw2M25qfS
         1qSg==
X-Forwarded-Encrypted: i=1; AJvYcCXk2lLzh1QeMx/4SLYITNLowVoa2zohWLEzqkPZE/FfJfpRGVu6eCYVUhd5P2r3qm2YAYyK6RvotuJqQxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9yxWYj3SvJQEvxoRxh9fG9qcoBp+0HDk8KMRHA31M36/ka7V
	Lk/XOVEVb4xwp8/a34yktes8OIUBzLl3Dhut+H2DHSMbZZ8RrPGWx1a2SbjXOFUtRA==
X-Google-Smtp-Source: AGHT+IGHldlDK5V50RIK9rYOqi6rgF/aruNQmIsPMmlAt3jV17hV/sTWPTsW2h4gAykvCAWeBjM/Fp4=
X-Received: from wmbbd5.prod.google.com ([2002:a05:600c:1f05:b0:43c:f6c0:3375])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d8f:b0:43b:ca39:6c75
 with SMTP id 5b1f17b1804b1-43d509f44f2mr26979585e9.16.1742555749682; Fri, 21
 Mar 2025 04:15:49 -0700 (PDT)
Date: Fri, 21 Mar 2025 11:15:32 +0000
In-Reply-To: <20250321111535.3740332-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321111535.3740332-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321111535.3740332-5-bqe@google.com>
Subject: [PATCH v5 4/4] rust: add dynamic ID pool abstraction for bitmap
From: Burak Emir <bqe@google.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is a port of the Binder data structure introduced in commit
15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
Rust.

Like drivers/android/dbitmap.h, the ID pool abstraction lets
clients acquire and release IDs. The implementation uses a bitmap to
know what IDs are in use, and gives clients fine-grained control over
the time of allocation. This fine-grained control is needed in the
Android Binder. We provide an example that release a spinlock for
allocation and unit tests (rustdoc examples).

The implementation is not aware that the underlying Bitmap abstraction
handles lengths below BITS_PER_LONG without allocation.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS            |   1 +
 rust/kernel/id_pool.rs | 201 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 3 files changed, 203 insertions(+)
 create mode 100644 rust/kernel/id_pool.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index bc8f05431689..61ac5da0dfbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4120,6 +4120,7 @@ M:	Burak Emir <bqe@google.com>
 R:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
 F:	rust/kernel/bitmap.rs
+F:	rust/kernel/id_pool.rs
 
 BITOPS API
 M:	Yury Norov <yury.norov@gmail.com>
diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
new file mode 100644
index 000000000000..8f07526bb580
--- /dev/null
+++ b/rust/kernel/id_pool.rs
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2025 Google LLC.
+
+//! Rust API for an ID pool backed by a `Bitmap`.
+
+use crate::alloc::{AllocError, Flags};
+use crate::bitmap::Bitmap;
+
+/// Represents a dynamic ID pool backed by a `Bitmap`.
+///
+/// Clients acquire and release IDs from zero bits in a bitmap.
+///
+/// The ID pool can grow or shrink as needed. It has been designed
+/// to support the scenario where users need to control the time
+/// of allocation of a new backing bitmap, which may require release
+/// of locks.
+/// These operations then, are verified to determine if the grow or
+/// shrink is sill valid.
+///
+/// # Examples
+///
+/// Basic usage
+///
+/// ```
+/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+/// use kernel::id_pool::IdPool;
+///
+/// let mut pool = IdPool::new(64, GFP_KERNEL)?;
+/// for i in 0..64 {
+///   assert_eq!(i, pool.acquire_next_id(i).ok_or(ENOSPC)?);
+/// }
+///
+/// pool.release_id(23);
+/// assert_eq!(23, pool.acquire_next_id(0).ok_or(ENOSPC)?);
+///
+/// assert_eq!(None, pool.acquire_next_id(0));  // time to realloc.
+/// let resizer = pool.grow_alloc().alloc(GFP_KERNEL)?;
+/// pool.grow(resizer);
+///
+/// assert_eq!(pool.acquire_next_id(0), Some(64));
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// Releasing spinlock to grow the pool
+///
+/// ```no_run
+/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+/// use kernel::sync::{new_spinlock, SpinLock};
+/// use kernel::id_pool::IdPool;
+///
+/// fn get_id_maybe_alloc(guarded_pool: &SpinLock<IdPool>) -> Result<usize, AllocError> {
+///   let mut pool = guarded_pool.lock();
+///   loop {
+///     match pool.acquire_next_id(0) {
+///       Some(index) => return Ok(index),
+///       None => {
+///         let alloc_request = pool.grow_alloc();
+///         drop(pool);
+///         let resizer = alloc_request.alloc(GFP_KERNEL)?;
+///         pool = guarded_pool.lock();
+///         pool.grow(resizer)
+///       }
+///     }
+///   }
+/// }
+/// ```
+pub struct IdPool {
+    map: Bitmap,
+}
+
+/// Returned when the `IdPool` should change size.
+pub struct AllocRequest {
+    nbits: usize,
+}
+
+/// Contains an allocated `Bitmap` for resizing `IdPool`.
+pub struct PoolResizer {
+    new: Bitmap,
+}
+
+impl AllocRequest {
+    /// Allocates a new `Bitmap` for `IdPool`.
+    pub fn alloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
+        let new = Bitmap::new(self.nbits, flags)?;
+        Ok(PoolResizer { new })
+    }
+}
+
+impl IdPool {
+    /// Constructs a new `[IdPool]`.
+    #[inline]
+    pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
+        let map = Bitmap::new(nbits, flags)?;
+        Ok(Self { map })
+    }
+
+    /// Returns how many IDs this pool can currently have.
+    #[inline]
+    pub fn len(&self) -> usize {
+        self.map.len()
+    }
+
+    /// Returns an [`AllocRequest`] if the [`IdPool`] can be shrunk, [`None`] otherwise.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+    /// use kernel::id_pool::{AllocRequest, IdPool};
+    ///
+    /// let mut pool = IdPool::new(1024, GFP_KERNEL)?;
+    /// let alloc_request = pool.shrink_alloc().ok_or(AllocError)?;
+    /// let resizer = alloc_request.alloc(GFP_KERNEL)?;
+    /// pool.shrink(resizer);
+    /// assert_eq!(pool.len(), kernel::bindings::BITS_PER_LONG as usize);
+    /// # Ok::<(), AllocError>(())
+    /// ```
+    #[inline]
+    pub fn shrink_alloc(&self) -> Option<AllocRequest> {
+        let len = self.map.len();
+        if len <= bindings::BITS_PER_LONG as usize {
+            return None;
+        }
+        /*
+         * Determine if the bitmap can shrink based on the position of
+         * its last set bit. If the bit is within the first quarter of
+         * the bitmap then shrinking is possible. In this case, the
+         * bitmap should shrink to half its current size.
+         */
+        match self.map.last_bit() {
+            Some(bit) => {
+                if bit < (len >> 2) {
+                    Some(AllocRequest { nbits: len >> 1 })
+                } else {
+                    None
+                }
+            }
+            None => Some(AllocRequest {
+                nbits: bindings::BITS_PER_LONG as usize,
+            }),
+        }
+    }
+
+    /// Shrinks pool by using a new `Bitmap`, if still possible.
+    #[inline]
+    pub fn shrink(&mut self, mut resizer: PoolResizer) {
+        // Verify that shrinking is still possible. The `resizer`
+        // bitmap might have been allocated without locks, so this call
+        // could now be outdated. In this case, drop `resizer` and move on.
+        if let Some(AllocRequest { nbits }) = self.shrink_alloc() {
+            if nbits <= resizer.new.len() {
+                resizer.new.copy_and_extend(&self.map);
+                self.map = resizer.new;
+                return;
+            }
+        }
+    }
+
+    /// Returns an `AllocRequest` for growing this `IdPool`.
+    #[inline]
+    pub fn grow_alloc(&self) -> AllocRequest {
+        AllocRequest {
+            nbits: self.map.len() << 1,
+        }
+    }
+
+    /// Grows pool by using a new `Bitmap`, if still necessary.
+    #[inline]
+    pub fn grow(&mut self, mut resizer: PoolResizer) {
+        // `resizer` bitmap might have been allocated without locks,
+        // so this call could now be outdated. In this case, drop
+        // `resizer` and move on.
+        if resizer.new.len() <= self.map.len() {
+            return;
+        }
+
+        resizer.new.copy_and_extend(&self.map);
+        self.map = resizer.new;
+    }
+
+    /// Acquires a new ID by finding and setting the next zero bit in the
+    /// bitmap. Upon success, returns its index. Otherwise, returns `None`
+    /// to indicate that a `grow_alloc` is needed.
+    #[inline]
+    pub fn acquire_next_id(&mut self, offset: usize) -> Option<usize> {
+        match self.map.next_zero_bit(offset) {
+            res @ Some(nr) => {
+                self.map.set_bit(nr);
+                res
+            }
+            None => None,
+        }
+    }
+
+    /// Releases an ID.
+    #[inline]
+    pub fn release_id(&mut self, id: usize) {
+        self.map.clear_bit(id);
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9f675c0841e6..d77a27bee388 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -51,6 +51,7 @@
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
 pub mod fs;
+pub mod id_pool;
 pub mod init;
 pub mod io;
 pub mod ioctl;
-- 
2.49.0.395.g12beb8f557-goog


