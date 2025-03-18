Return-Path: <linux-kernel+bounces-566696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D0CA67B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24366421280
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E36212D95;
	Tue, 18 Mar 2025 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPbhFtPA"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6449613D52F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320495; cv=none; b=DCsS86WWwYiXjLu0irXxiICOyqvWwZ7bOC4M6jZ/WqqTBhtSUJzEH+et1RN4sFSyIeU1lZDfb8vRQNbI40AyMskYDt8+DmqpawWKP77WUe+v8q8w9ZURAduWZat7FsA3V7QU0Uf74Sdy3FJe+hbpCDOXO6GWW/jYBate3CBrS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320495; c=relaxed/simple;
	bh=FK69DBDbx15AGsjLQn4hzKCgIPn8W+7OJ5VoUogYe68=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fNxd0Ktz2BFBO0UcHh14qiLM+Emg766ybKojNd9vuw/8xqYi037rNxSmW6pUYCJQ+uBe+fkYZzn5ktYkcfM/DJa/DXVj6yN2iyI4GTwoS1OhcliCWBAsc1qNzXa8wVZ7yTCmz8yFkhX2omEF2xT9pMTVulW5k2Zi5W8mwxMy/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rPbhFtPA; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bqe.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so18569895e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742320491; x=1742925291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucaWlpvQ0hnSoOA7AlIgnz0cgmqZKnUxsdJt8CvjyU8=;
        b=rPbhFtPA4b0vTDeYJQn4MIrBMR2JXxD2NOBS2g/5Blj10LoIJaTD7vPFtxGaBy+tbv
         vC5HC+1+s1RZUal3pbYjPwMcQc5xC+lXJYDOEZPi2WoS67P0zpaDK8g9lOqelacDWLrJ
         7yhO6On1zA8VTQ0U9bCa6HaWRmMx0XildTqhr6e0EAfKROY8IdIMVt44WZZ8nnKIqme+
         0CI3P4aDF8dP1xYEW+b3iFGhOU6TuL5VGOOycIVRWtOeZPREnEgyt8fO2eaY+qdClPKV
         cvbK5fV0InEJwhiZTVyR/lTbm5cOcow7BPEl/nYYm4oWWZN1Lzw8wwW0rPbtleYtRYzA
         AAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742320491; x=1742925291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucaWlpvQ0hnSoOA7AlIgnz0cgmqZKnUxsdJt8CvjyU8=;
        b=tbccCk/FfeKjSf9nLd2kyb0m5G1bqRX7Md2Tg+onDZmnpesd+AECJMUQxgqy0XujfM
         dtzdOImUt4NoP+KNfe9q3Jwpp1SkB6+PEW4GH85vIVIRPFKjEH5nEDx9Awadl7BDwaDM
         Z1a6L3ERl7K8IFjgIM5dzNJUIov59zhdt1hu5fBrgiL88D//fkYuJH9lnYu8FJCBbxWO
         TX0cl8zKQJM5fzI/K7n+ns+vgd1s68lQgtDlffqc7fZujrMgMQZDUcwT6YDR/7w2aOBE
         yOREE1SEhzD0NlZM+6evsPjfWsSEX4uwHgnt5NK+7NOOfsaqFArcpUj7aJXEn1sU8Yzq
         dRSg==
X-Forwarded-Encrypted: i=1; AJvYcCWDhDLp7j7xJ9Qjx8MpITpMMnttBSp1peoPKfe90A+qhWGy2XTqO7oQAVhiYAZ74GV9TFEXp9BxtJftYcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8DlKc7CkcW0zvl6tCw6B7Lqek2sfntBWNF3gzBsmMD9Erw8LJ
	E9bgRLtEb3qdrNhpYG8wTdg4I+XdN+i82xl1YVj5MRvjYsKpBwDU/YjuhLxQQSkY7w==
X-Google-Smtp-Source: AGHT+IE9HCWFwX0V1dhe93zc5NW/AaGRcwmRfIgKOL0NRLkOirF6/Xjn0gSPZ7HpqYNpucDNRmXSVn0=
X-Received: from wmbdl18.prod.google.com ([2002:a05:600c:6692:b0:43c:f256:f4b3])
 (user=bqe job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b97:b0:43c:e467:d6ce
 with SMTP id 5b1f17b1804b1-43d3b9504a6mr34302145e9.4.1742320490880; Tue, 18
 Mar 2025 10:54:50 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:54:09 +0000
In-Reply-To: <20250318164221.1533590-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318164221.1533590-1-bqe@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250318175423.1627715-2-bqe@google.com>
Subject: [PATCH v4 3/3] Add DynamicIdPool Rust API.
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

This is a port of the Binder data structure introded in commit
15d9da3f818c ("binder: use bitmap for faster descriptor lookup") to
Rust.

The file drivers/android/dbitmap.h uses bitmaps for allocating and
releasing IDs. We provide an equivalent Rust API that gives clients
fine-grained control over when to allocate a new bitmap.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Burak Emir <bqe@google.com>
---
 MAINTAINERS                    |   3 +-
 rust/kernel/dynamic_id_pool.rs | 191 +++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs             |   1 +
 3 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/dynamic_id_pool.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index b3bbce9274f0..d429ede24d3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4036,12 +4036,13 @@ F:	rust/helpers/bitmap.c
 F:	rust/helpers/cpumask.c
 
 BITMAP API [RUST]
-M:	Alice Ryhl <aliceryhl@google.com> (bitmap)
+M:	Alice Ryhl <aliceryhl@google.com> (bitmap,dynamic_id_pool)
 M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
 R:	Yury Norov <yury.norov@gmail.com>
 S:	Maintained
 F:	rust/kernel/bitmap.rs
 F:	rust/kernel/cpumask.rs
+F:	rust/kernel/dynamic_id_pool.rs
 
 BITOPS API
 M:	Yury Norov <yury.norov@gmail.com>
diff --git a/rust/kernel/dynamic_id_pool.rs b/rust/kernel/dynamic_id_pool.rs
new file mode 100644
index 000000000000..3e243358cd6b
--- /dev/null
+++ b/rust/kernel/dynamic_id_pool.rs
@@ -0,0 +1,191 @@
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
+/// use kernel::dynamic_id_pool::DynamicIdPool;
+///
+/// let mut pool = DynamicIdPool::new(64, GFP_KERNEL)?;
+/// for i in 0..64 {
+///   pool.acquire_next_id(i).ok_or(ENOSPC)?;
+/// }
+/// assert_eq!(pool.acquire_next_id(63), None);
+/// let resizer = pool.grow_alloc().alloc(GFP_KERNEL)?;
+/// pool.grow(resizer);
+/// assert_eq!(pool.acquire_next_id(63), Some(64));
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// Releasing spinlock to grow the pool
+///
+/// ```
+/// use kernel::alloc::{AllocError, flags::GFP_KERNEL};
+/// use kernel::sync::{new_spinlock, SpinLock};
+/// use kernel::dynamic_id_pool::DynamicIdPool;
+///
+/// struct Example {
+///   pool: DynamicIdPool
+/// }
+///
+/// fn get_id_maybe_alloc(s: &SpinLock<Example>) -> Result<usize, AllocError> {
+///   let mut guard = s.lock();
+///   let mut resizer = None;
+///   loop {
+///     match guard.pool.acquire_next_id(0) {
+///       index @ Some(_) => return Ok(index),
+///       None => {
+///         let alloc_request = guard.pool.grow_alloc();
+///         drop(guard);
+///         let resizer = alloc_request.alloc(GFP_KERNEL)?;
+///         guard = s.lock();
+///         guard.pool.grow(resizer)
+///       }
+///     }
+///   }
+/// }
+/// ```
+pub struct DynamicIdPool {
+    map: Bitmap,
+}
+
+/// Returned when the `DynamicIdPool` should change size.
+pub struct AllocRequest {
+    nbits: usize,
+}
+
+/// Contains an allocated `Bitmap` for resizing `DynamicIdPool`.
+pub struct PoolResizer {
+    new: Bitmap,
+}
+
+impl AllocRequest {
+    /// Allocates a new `Bitmap` for `DynamicIdPool`.
+    pub fn alloc(&self, flags: Flags) -> Result<PoolResizer, AllocError> {
+        let new = Bitmap::new(self.nbits, flags)?;
+        Ok(PoolResizer { new })
+    }
+}
+
+/// Minimum size we want to use for our backing `Bitmap`.
+const NBITS_MIN: usize = bindings::BITS_PER_LONG as usize;
+
+impl DynamicIdPool {
+    ///
+    #[inline]
+    pub fn new(mut nbits: usize, flags: Flags) -> Result<Self, AllocError> {
+        if nbits < NBITS_MIN {
+            nbits = NBITS_MIN
+        }
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
+    /// Returns an `AllocRequest` if the can be shrunk, or None if not possible.
+    #[inline]
+    pub fn shrink_alloc(&self) -> Option<AllocRequest> {
+        let len = self.map.len();
+        if len == NBITS_MIN {
+            return None
+        }
+        /*
+         * Determine if the bitmap can shrink based on the position of
+         * its last set bit. If the bit is within the first quarter of
+         * the bitmap then shrinking is possible. In this case, the
+         * bitmap should shrink to half its current size.
+         */
+        match self.map.find_last_bit() {
+            Some(bit) => {
+                if bit < (len >> 2) {
+                    Some(AllocRequest { nbits: len >> 1 })
+                } else {
+                    None
+                }
+            }
+            None => Some(AllocRequest { nbits: NBITS_MIN }),
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
+                resizer.new.copy_prefix_from_bitmap(&self.map);
+                self.map = resizer.new;
+                return;
+            }
+        }
+    }
+
+    /// Returns an `AllocRequest` for growing this `DynamicIdPool`.
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
+        resizer.new.copy_from_bitmap_and_extend(&self.map);
+        self.map = resizer.new;
+    }
+
+    /// Acquires a new ID by finding and setting the next zero bit in the
+    /// bitmap. Upon success, returns its index. Otherwise, returns `None`
+    /// to indicate that a `grow_alloc` is needed.
+    #[inline]
+    pub fn acquire_next_id(&mut self, offset: usize) -> Option<usize> {
+        match self.map.find_next_zero_bit(offset) {
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
index be06ffc47473..4789e707dacc 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -47,6 +47,7 @@
 pub mod device_id;
 pub mod devres;
 pub mod driver;
+pub mod dynamic_id_pool;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
 pub mod firmware;
-- 
2.49.0.rc1.451.g8f38331e32-goog


