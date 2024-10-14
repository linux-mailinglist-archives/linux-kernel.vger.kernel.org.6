Return-Path: <linux-kernel+bounces-364399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B84899D423
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F274E1F25032
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B21AC447;
	Mon, 14 Oct 2024 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8icoYzR"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D214AA9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921655; cv=none; b=QAwcDmc9CXMYzEAuMVEOQgedODNN3efPd6E1Y7FZ+r3lwPxCUFr8+n7ahZ03XwQZy/p7stnYuZamEOwMB7ZYfJwnQqsjPdC/6/9aTptUXckCQXwYysYgGvJgrM4lO5ep2boUilY9fWkrecRYe98osZl1sIkfvjJwRmdgo+CPbUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921655; c=relaxed/simple;
	bh=kk1X9i84u1Iu7BNt/VNlbzR35kOrvNPxRSHSbE4ofbY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DUBuLR8g05K/dN0fgaEgFdynanwoDfj/DJxd9UHclILU23/Wfg0admPySS/00Un8fUIzEfYtV8e78Fcni0tSEgG/02UUnuTVFT/XINcPUD9wzeXVGsAo9zS1GaD7m5LZHDoeLxMsFA1attkxtk+s2H3Wfl6eH44WFOD920uqtVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8icoYzR; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e347b1e29dso37200967b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728921652; x=1729526452; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RKRYvQc5u4z80Pon/cd7Cmgo0D0IQWgEKKFqzih4+Zw=;
        b=p8icoYzRzr5x5HMIqFD4IZaGHJABey3DYzC8uzinLxCrpVFQr50yVtnXEeroo+Rvby
         2kRBLK1MwpHMVABbO1dqso8IKMKWbJKzRWlpea3gny0HejaUq1D3001wPysgRPd/vENy
         DS12uXqyHgv24Lc67EcqmZbE9MY761szlmEJ+zGDRM1DGgCmaP7RaH1ctJFV6/ZlqfVW
         AX8cbfQNLC9hfaudba4HSpm9e4PDtTmdELSw2saVTIr8gbWDrW5YS/LEtDimhNyKUQ0m
         xDFU2m322Zq22TkWikJdHNm/Me0Mcxwa7J5sbi7iSSFxCws2DjH6/TNNkVmy8Ex3U1Xc
         KlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921652; x=1729526452;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKRYvQc5u4z80Pon/cd7Cmgo0D0IQWgEKKFqzih4+Zw=;
        b=edsTRvSDHEluslknlKDQSEyW5PTud7upHF1VDQxsB/7Ww6Jajo//kQ5LDb5g4MdZhq
         bD/i7ETJTJ6dTjKXywrZwkDcnJZ9bVVQRUT+QMDdq+o7gVby5fd1cBXKf/4it0DQOJUW
         xZdPS0bu7VRzKSLq6M5ZSD5iXv/35sH6CbrkXstPVuXDL2lJGO8PUWohlAvSOflqvMzT
         QlYo6JXE7lLkGQO3a1kuHjEdNi2ZIpVEADeCZKFNkPwMwFhpdWVyRSiauw8r6gok9mSa
         O/myFGQJEcZQFMNU4UMiU+9OZsDBhf229H3GIKVd8m/vE2wEWyJeG4Yo1HRUwAFJZlvW
         zySQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsca9ydKsVUBiS9+46u/bW0FcpwS7iY/RKNk2T+EbaIFg/0SlfKWbuMzMjjejt9kqU8az9kGsNI2M3HTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPCDCBlZN9rjIyXeSMxTdiCYRDnKnaJPMWvoQKAcI8Lb4VDxR/
	2YUlf1+svi+ZsqDd3j5Gi/hd/IBcWTqryx+EV2cvnbKzoK9GjsbwVVScqkBDptP2lRWrVtPYxuj
	h12bE4m8X9q/jbQ==
X-Google-Smtp-Source: AGHT+IG5FwhCjh1GLIoAJhFPEeSSbvHOtmfOHQWD2Zr/YvqWPnbrIUZTRNTcz1wpS5hNI1L8NcC6FaZK79o5KOs=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5b:284:0:b0:e1a:9ed2:67f4 with SMTP id
 3f1490d57ef6-e2919c5ac92mr8791276.2.1728921652517; Mon, 14 Oct 2024 09:00:52
 -0700 (PDT)
Date: Mon, 14 Oct 2024 16:00:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABNADWcC/0XMTQrCMBCG4auUWRvJj7HRlfeQLto6SQY1kUSCU
 nJ3Y0FkVu/w8SyQMRFmOHYLJCyUKYYWctPB7MfgkNGlNUgud/wgBMs+UbhiYtaoXoyW82lvoM0 fCS29Vuo8tPaUnzG9V7mI7/eHyD9SBGtnpt4KqZXW6uRidDfczvEOQ631A8u/NUmhAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=16804; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=kk1X9i84u1Iu7BNt/VNlbzR35kOrvNPxRSHSbE4ofbY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnDUAVAyU7uKSyj8He8g4rJDHEvi6UaJ9gi0S82
 JkB+tnT6JGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZw1AFQAKCRAEWL7uWMY5
 RohcD/4vri9xp+vINrOeHveWZnfVKP92H7DZKk6AWsojrBpBaoZ+QdjWP5zq7c1hUOyhomlgm/b
 85cWTJy7fmZQAM3t/4I7d1e7X/ig89tznLsZNpYv5RQKsmAbIsERnlaYM0tF6t+Gm+NbgnBEgiA
 Y1ybl40JF1ESckWI2D122OuG+r9CO0u4TtyHrarSsqSBTdD3/taPmGf+eUJTyTXY8sSwhpzSdsn
 yKZB5egd7ZFnA4krLCrmyv7E0lQBAM9xbfnPJ3TvF43qc7herNQFEjQ6QDBOpbez0SNWyNH/Dcc
 BDBWFaM55XBZp4YIFwupmE21+erNvGnNAtfbNjSXzmxX6NTzx6nTt5HwXBt2mRtqEkVfG2DEt+H
 jaWm0w6vttv3vlIF2hnse910qfx29CLMXtMw2OafjCg7I+AoR8bOJQXYntKlcGXNv4dAddgaerP
 pW6Ffjbnb9SGk1asazfxFnIOKTlw/i71MXuXNCxrAzllx6oIGMcyYuhNh+KDOWE90RD4OUSj0FT
 IkLdPOGp09HyP8LPpZ6HmwUUejgt0zBe2DIBFzu8XCa4OkUaCVcIdO88J+lAnsIGy8R4oumxQiL
 TRHfWd54YTzA13nTXZS4fDcC1112zQudCU4DjYM5ql21pjqHBmMMCeK5bSwwicTYnSm+HVgia26 Ya2SaMApsN7AXlA==
X-Mailer: b4 0.13.0
Message-ID: <20241014-shrinker-v2-1-04719efd2342@google.com>
Subject: [PATCH v2] rust: shrinker: add shrinker abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Rust Binder holds incoming transactions in a read-only mmap'd region
where it manually manages the pages. These pages are only in use until
the incoming transaction is consumed by userspace, but the kernel will
keep the pages around for future transactions. Rust Binder registers a
shrinker with the kernel so that it can give back these pages if the
system comes under memory pressure.

Creating a shrinker is done via the ShrinkerBuilder type. Using a
builder means that some options (seeks, batch) can be optional, while
other options (name, private data) can be mandatory. Unlike seeks/batch,
the private data is not set using a `set_private_data` method, as this
makes it mandatory to provide a private data pointer.

The user specifies the callbacks in use by implementing the Shrinker
trait for the type used for the private data. This requires specifying
three things: implementations for count_objects and scan_objects, and
the pointer type that the private data will be wrapped in.

The return values of count_objects and scan_objects are provided using
newtypes called CountObjects and ScanObjects respectively. These types
prevent the user from e.g. returning SHRINK_STOP from count_objects or
returning SHRINK_EMPTY from scan_objects.

The CountObjects newtype treats CountObjects::new(0) as "the count is
unknown" instead of "the count is zero" for consistency with the way
that the C code works today.

ShrinkControl is not using Opaque because we need mutable access.

Support for numa/memcg aware shrinkers is not included here, as they
cannot usefully be used without having list_lru bindings. Support for
that will happen as a follow-up.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Dave, I still had a few outstanding questions in the thread on the last
version. Most prominently the question on what to do with the builder
instead. I didn't change it in this version as I'm not sure which
alternative you prefer.
---
Changes in v2:
- Rename to ShrinkerBuilder / ShrinkerRegistration.
- Rename `alloc` to `new`.
- Update CountOjects to match the way C does it.
- Change ScanObjects::MAX to SHRINK_STOP-1.
- Rename gfp_fs to reclaim_fs_allowed, and add reclaim_io_allowed.
- Remove max check in set_nr_scanned.
- Comment that numa/memcg aware shrinkers aren't supported yet.
- Link to v1: https://lore.kernel.org/r/20240912-shrinker-v1-1-18b7f1253553@google.com
---
 rust/bindings/bindings_helper.h |   3 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/shrinker.rs         | 335 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941af..fd6d15f5dde1 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -18,6 +18,7 @@
 #include <linux/phy.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
+#include <linux/shrinker.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -31,4 +32,6 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
 const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
+const gfp_t RUST_CONST_HELPER___GFP_FS = ___GFP_FS;
+const gfp_t RUST_CONST_HELPER___GFP_IO = ___GFP_IO;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b5f4b3ce6b48..2e9ca7d413c4 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -45,6 +45,7 @@
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
+pub mod shrinker;
 pub mod sizes;
 mod static_assert;
 #[doc(hidden)]
diff --git a/rust/kernel/shrinker.rs b/rust/kernel/shrinker.rs
new file mode 100644
index 000000000000..d87ad08e917c
--- /dev/null
+++ b/rust/kernel/shrinker.rs
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Shrinker for handling memory pressure.
+//!
+//! C header: [`include/linux/shrinker.h`](srctree/include/linux/shrinker.h)
+
+use crate::{alloc::AllocError, bindings, c_str, str::CStr, types::ForeignOwnable};
+
+use core::{
+    ffi::{c_int, c_long, c_ulong, c_void},
+    marker::PhantomData,
+    ptr::NonNull,
+};
+
+const SHRINK_STOP: c_ulong = bindings::SHRINK_STOP as c_ulong;
+const SHRINK_EMPTY: c_ulong = bindings::SHRINK_EMPTY as c_ulong;
+
+/// The default value for the number of seeks needed to recreate an object.
+pub const DEFAULT_SEEKS: u32 = bindings::DEFAULT_SEEKS;
+
+/// An unregistered shrinker.
+///
+/// This type can be used to modify the settings of the shrinker before it is registered.
+///
+/// # Invariants
+///
+/// The `shrinker` pointer references an unregistered shrinker.
+pub struct ShrinkerBuilder {
+    shrinker: NonNull<bindings::shrinker>,
+}
+
+// SAFETY: Moving an unregistered shrinker between threads is okay.
+unsafe impl Send for ShrinkerBuilder {}
+// SAFETY: An unregistered shrinker is thread safe.
+unsafe impl Sync for ShrinkerBuilder {}
+
+impl ShrinkerBuilder {
+    /// Create a new shrinker.
+    pub fn new(name: &CStr) -> Result<Self, AllocError> {
+        // TODO: Support numa/memcg aware shrinkers once list_lru is available.
+        let flags = 0;
+
+        // SAFETY: Passing `0` as flags is okay. Using `%s` as the format string is okay when we
+        // pass a nul-terminated string as the string for `%s` to print.
+        let ptr = unsafe {
+            bindings::shrinker_alloc(flags, c_str!("%s").as_char_ptr(), name.as_char_ptr())
+        };
+
+        let shrinker = NonNull::new(ptr).ok_or(AllocError)?;
+
+        // INVARIANT: The allocated shrinker is unregistered.
+        Ok(Self { shrinker })
+    }
+
+    /// Create a new shrinker using format arguments for the name.
+    pub fn new_fmt(name: core::fmt::Arguments<'_>) -> Result<Self, AllocError> {
+        // TODO: Support numa/memcg aware shrinkers once list_lru is available.
+        let flags = 0;
+
+        // SAFETY: Passing `0` as flags is okay. Using `%pA` as the format string is okay when we
+        // pass a `fmt::Arguments` as the value to print.
+        let ptr = unsafe {
+            bindings::shrinker_alloc(
+                flags,
+                c_str!("%pA").as_char_ptr(),
+                &name as *const _ as *const c_void,
+            )
+        };
+
+        let shrinker = NonNull::new(ptr).ok_or(AllocError)?;
+
+        // INVARIANT: The allocated shrinker is unregistered.
+        Ok(Self { shrinker })
+    }
+
+    /// Set the number of seeks needed to recreate an object.
+    pub fn set_seeks(&mut self, seeks: u32) {
+        unsafe { (*self.shrinker.as_ptr()).seeks = seeks as c_int };
+    }
+
+    /// Set the batch size for reclaiming on this shrinker.
+    pub fn set_batch(&mut self, batch: usize) {
+        unsafe { (*self.shrinker.as_ptr()).batch = batch as c_long };
+    }
+
+    /// Register the shrinker.
+    ///
+    /// The provided pointer is used as the private data, and the type `T` determines the callbacks
+    /// that the shrinker will use.
+    pub fn register<T: Shrinker>(self, private_data: T::Ptr) -> ShrinkerRegistration<T> {
+        let shrinker = self.shrinker;
+        let ptr = shrinker.as_ptr();
+
+        // The destructor of `self` calls `shrinker_free`, so skip the destructor.
+        core::mem::forget(self);
+
+        let private_data_ptr = <T::Ptr as ForeignOwnable>::into_foreign(private_data);
+
+        // SAFETY: We own the private data, so we can assign to it.
+        unsafe { (*ptr).private_data = private_data_ptr.cast_mut() };
+        // SAFETY: The shrinker is not yet registered, so we can update this field.
+        unsafe { (*ptr).count_objects = Some(rust_count_objects::<T>) };
+        // SAFETY: The shrinker is not yet registered, so we can update this field.
+        unsafe { (*ptr).scan_objects = Some(rust_scan_objects::<T>) };
+
+        // SAFETY: The shrinker is unregistered, so it's safe to register it.
+        unsafe { bindings::shrinker_register(ptr) };
+
+        ShrinkerRegistration {
+            shrinker,
+            _phantom: PhantomData,
+        }
+    }
+}
+
+impl Drop for ShrinkerBuilder {
+    fn drop(&mut self) {
+        // SAFETY: The shrinker is a valid but unregistered shrinker, and we will not use it
+        // anymore.
+        unsafe { bindings::shrinker_free(self.shrinker.as_ptr()) };
+    }
+}
+
+/// A shrinker that is registered with the kernel.
+///
+/// # Invariants
+///
+/// The `shrinker` pointer refers to a registered shrinker using `T` as the private data.
+pub struct ShrinkerRegistration<T: Shrinker> {
+    shrinker: NonNull<bindings::shrinker>,
+    _phantom: PhantomData<T::Ptr>,
+}
+
+// SAFETY: This allows you to deregister the shrinker from a different thread, which means that
+// private data could be dropped from any thread.
+unsafe impl<T: Shrinker> Send for ShrinkerRegistration<T> where T::Ptr: Send {}
+// SAFETY: The only thing you can do with an immutable reference is access the private data, which
+// is okay to access in parallel as the `Shrinker` trait requires the private data to be `Sync`.
+unsafe impl<T: Shrinker> Sync for ShrinkerRegistration<T> {}
+
+impl<T: Shrinker> ShrinkerRegistration<T> {
+    /// Access the private data in this shrinker.
+    pub fn private_data(&self) -> <T::Ptr as ForeignOwnable>::Borrowed<'_> {
+        // SAFETY: We own the private data, so we can access it.
+        let private = unsafe { (*self.shrinker.as_ptr()).private_data };
+        // SAFETY: By the type invariants, the private data is `T`. This access could happen in
+        // parallel with a shrinker callback, but that's okay as the `Shrinker` trait ensures that
+        // `T::Ptr` is `Sync`.
+        unsafe { <T::Ptr as ForeignOwnable>::borrow(private) }
+    }
+}
+
+impl<T: Shrinker> Drop for ShrinkerRegistration<T> {
+    fn drop(&mut self) {
+        // SAFETY: We own the private data, so we can access it.
+        let private = unsafe { (*self.shrinker.as_ptr()).private_data };
+        // SAFETY: We will not access the shrinker after this call.
+        unsafe { bindings::shrinker_free(self.shrinker.as_ptr()) };
+        // SAFETY: The above call blocked until the completion of any shrinker callbacks, so there
+        // are no longer any users of the private data.
+        drop(unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) });
+    }
+}
+
+/// Callbacks for a shrinker.
+pub trait Shrinker {
+    /// The pointer type used to store the private data of the shrinker.
+    ///
+    /// Needs to be `Sync` because the shrinker callback could access this value immutably from
+    /// several thread in parallel.
+    type Ptr: ForeignOwnable + Sync;
+
+    /// Count the number of freeable items in the cache.
+    fn count_objects(
+        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        sc: ShrinkControl<'_>,
+    ) -> CountObjects;
+
+    /// Free some objects in this cache.
+    fn scan_objects(
+        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        sc: ShrinkControl<'_>,
+    ) -> ScanObjects;
+}
+
+/// How many objects are there in the cache?
+///
+/// This is used as the return value of [`Shrinker::count_objects`].
+pub struct CountObjects {
+    inner: c_ulong,
+}
+
+impl CountObjects {
+    /// Indicates that the number of objects is zero.
+    pub const EMPTY: Self = Self {
+        inner: SHRINK_EMPTY,
+    };
+
+    /// The maximum possible number of freeable objects.
+    pub const MAX: Self = Self {
+        // The shrinker code assumes that it can multiply this value by two without overflow.
+        inner: c_ulong::MAX / 2,
+    };
+
+    /// Creates a new `CountObjects` with the given value.
+    ///
+    /// This should be the number of objects that were actually freed. Objects that were scanned
+    /// but not freed should be counted in `nr_scanned` but not here.
+    ///
+    /// If `count` is zero, then this indicates that the real count is unknown. Use
+    /// `CountObjects::EMPTY` to indicate that the shrinker is empty.
+    pub fn new(count: usize) -> Self {
+        if count > Self::MAX.inner as usize {
+            return Self::MAX;
+        }
+
+        Self {
+            inner: count as c_ulong,
+        }
+    }
+}
+
+/// How many objects were freed?
+///
+/// This is used as the return value of [`Shrinker::scan_objects`].
+pub struct ScanObjects {
+    inner: c_ulong,
+}
+
+impl ScanObjects {
+    /// Indicates that the shrinker should stop trying to free objects from this cache due to
+    /// potential deadlocks.
+    pub const STOP: Self = Self { inner: SHRINK_STOP };
+
+    /// The maximum possible number of freeable objects.
+    pub const MAX: Self = Self {
+        inner: SHRINK_STOP - 1,
+    };
+
+    /// Creates a new `CountObjects` with the given value.
+    pub fn from_count(count: usize) -> Self {
+        if count > Self::MAX.inner as usize {
+            return Self::MAX;
+        }
+
+        Self {
+            inner: count as c_ulong,
+        }
+    }
+}
+
+/// This struct is used to pass information from page reclaim to the shrinkers.
+///
+/// # Invariants
+///
+/// `ptr` has exclusive access to a valid `struct shrink_control`.
+pub struct ShrinkControl<'a> {
+    ptr: NonNull<bindings::shrink_control>,
+    _phantom: PhantomData<&'a bindings::shrink_control>,
+}
+
+impl<'a> ShrinkControl<'a> {
+    /// Create a `ShrinkControl` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer should point at a valid `shrink_control` for the duration of 'a.
+    pub unsafe fn from_raw(ptr: *mut bindings::shrink_control) -> Self {
+        Self {
+            // SAFETY: Caller promises that this pointer is valid.
+            ptr: unsafe { NonNull::new_unchecked(ptr) },
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Determines whether it is safe to call into filesystem code.
+    pub fn reclaim_fs_allowed(&self) -> bool {
+        // SAFETY: Okay by type invariants.
+        let mask = unsafe { (*self.ptr.as_ptr()).gfp_mask };
+
+        (mask & bindings::__GFP_FS) != 0
+    }
+
+    /// Determines whether it is safe to call into IO code.
+    pub fn reclaim_io_allowed(&self) -> bool {
+        // SAFETY: Okay by type invariants.
+        let mask = unsafe { (*self.ptr.as_ptr()).gfp_mask };
+
+        (mask & bindings::__GFP_IO) != 0
+    }
+
+    /// Returns the number of objects that `scan_objects` should try to reclaim.
+    pub fn nr_to_scan(&self) -> usize {
+        // SAFETY: Okay by type invariants.
+        unsafe { (*self.ptr.as_ptr()).nr_to_scan as usize }
+    }
+
+    /// The callback should set this value to the number of objects inspected by the shrinker.
+    pub fn set_nr_scanned(&mut self, val: usize) {
+        // SAFETY: Okay by type invariants.
+        unsafe { (*self.ptr.as_ptr()).nr_scanned = val as c_ulong };
+    }
+}
+
+unsafe extern "C" fn rust_count_objects<T: Shrinker>(
+    shrink: *mut bindings::shrinker,
+    sc: *mut bindings::shrink_control,
+) -> c_ulong {
+    // SAFETY: We own the private data, so we can access it.
+    let private = unsafe { (*shrink).private_data };
+    // SAFETY: This function is only used with shrinkers where `T` is the type of the private data.
+    let private = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    // SAFETY: The caller passes a valid `sc` pointer.
+    let sc = unsafe { ShrinkControl::from_raw(sc) };
+
+    let ret = T::count_objects(private, sc);
+    ret.inner
+}
+
+unsafe extern "C" fn rust_scan_objects<T: Shrinker>(
+    shrink: *mut bindings::shrinker,
+    sc: *mut bindings::shrink_control,
+) -> c_ulong {
+    // SAFETY: We own the private data, so we can access it.
+    let private = unsafe { (*shrink).private_data };
+    // SAFETY: This function is only used with shrinkers where `T` is the type of the private data.
+    let private = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
+    // SAFETY: The caller passes a valid `sc` pointer.
+    let sc = unsafe { ShrinkControl::from_raw(sc) };
+
+    let ret = T::scan_objects(private, sc);
+    ret.inner
+}

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20240911-shrinker-f8371af00b68

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


