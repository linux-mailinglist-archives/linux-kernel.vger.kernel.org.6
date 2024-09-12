Return-Path: <linux-kernel+bounces-326291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C918A976612
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834E6284F53
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550CA19E96A;
	Thu, 12 Sep 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p4mphdZ2"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212519CC15
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134853; cv=none; b=pBaNGOoc+oLQLCBC+lg3AGwW+9Z03NV7hj/nA6Etjk7hj09RjiJoUbqGSzPUDS8BxUjaLUJts5WVjRdEerEwNOSBZpl4W0MUbq3O56I4cHZ/zn23KOl2il/jofY0MSnLOHYkvlSrmJov5wzY+K2zj/xYime2FG8/sIaaWig3M1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134853; c=relaxed/simple;
	bh=Sw3I7jVln0A10IDphpPtCZCNDXDiNpNryEccSG2RrhI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sUpqxK8pm8SFf1uAmUG9nLsEGunc6SAYtlS1+0UKzOaXA2UMbdPlmR+vT/+cW+eNGPWIWHKQlUB/8YruISSuMWV8gZWZCRZaZSbFxhbqXw7n+D6+M9dVz4QGmhgZ1nQF+6YXPY/6Uvus5l7CIL00F5/g5raG/7owd+i8X4b6mes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p4mphdZ2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1aa529e30eso1381046276.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726134850; x=1726739650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y47+knSopch6MhZlM7gRYsV4lTxYgglb2/fdjTOFy0s=;
        b=p4mphdZ25x9ALUyDKp+/t61CdWDeAaM5Zw2ZIf/78a5lnJ9mo2A4Fxoy9CPD+sELaZ
         6HV0ZKF1gOwvKp4eVysJ6SGoJzdg+fAxMs9aQ1BZjptq+bgvx/UTC6PrnEuuENjxS8/n
         n8ZZEngJg68b/lT7BpgcBLPSqjf+HINHajLoTiIKa12buuWLUMoExuon1Neh6OlrBTg+
         jamD4yLPj91sApZHyUt38t2xqum4CFZCcc6fZ0MZGDdes9c5ALoimw8sD7PAjBWhIOZQ
         iG15sNQ/Q62Aq40J1A7GheGcWKw9cSU2P+TQDvavDTXJWKoyRUkHXP26KX66CcNI9Qx9
         Q2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726134850; x=1726739650;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y47+knSopch6MhZlM7gRYsV4lTxYgglb2/fdjTOFy0s=;
        b=gMg/gnb7vulyWQlcU4fyAy7mOvUrStuKyzkf98CRnx53bXQgocMdmQZ2JtcspheWPG
         elWQ63Julfm1C3aO4OIuiD/ijiAKoTRTgvw4fZ88MOQk06ti0h0Ez10hDhfUCKrrlc1f
         cX+nyPBlwEGpfZ8oy5K9WocnfvmCTdnDb2lVVIgSUdSa//fpElxiEORE6DRXbjxg0p2N
         M3BFUxEfqc+Z5Mw6pzGNCHbPPFtHbxSlUKdSjKZEzv939r/UrwsmXqAP/38oc+NQcWZH
         XNO9OARClC0XVguXN/ea+pLGisH0CVleFE3V1kIMjfttmcfCf49VhtqJ0pVHMneqcXL6
         6Smg==
X-Forwarded-Encrypted: i=1; AJvYcCUTN7VOuTLzYSfyy6ih/79hLfveJ0uJGtfYqN0Ln1YZQ1kQX945ipNXIHdB1w4f2Z3BwVZnKUWh62lLOi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywB6OV2CxlB7/oSWaijimK71aGn9I7NAqs5TwEn2veM5d64FaU
	UGJ5OyFoZX2+9wrTzl3KxItRW9GjSMUte5SQdexWUflsPWSmuc7gUPoKkOOeOuMPok6810d0rWg
	8m/dvgcf4UKPzSw==
X-Google-Smtp-Source: AGHT+IGxBUYW4WXIt0Du7NN6h0AQoZ+X885KZUKy7wn0+ZIqugsb7M3Aqv1IehsgFHQqs5OS06P051LdlbXBlgY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:d60d:0:b0:e16:4d66:982e with SMTP id
 3f1490d57ef6-e1d9dbd061amr4020276.5.1726134850269; Thu, 12 Sep 2024 02:54:10
 -0700 (PDT)
Date: Thu, 12 Sep 2024 09:54:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADi64mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0ND3eKMosy87NQi3TQLY3PDxDQDgyQzCyWg8oKi1LTMCrBR0bG1tQB Vk15xWgAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=15141; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Sw3I7jVln0A10IDphpPtCZCNDXDiNpNryEccSG2RrhI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm4ro/vmRiz/L5vsjbUOEYo+TO7O6YDluc2sJoG
 UOa8DQFWFOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZuK6PwAKCRAEWL7uWMY5
 RkjKD/4/nihXrQGnwhRzALuu1P3Vyxcu/Wm7qvc6fC2a4t1Z5WQh8Hnwn6KVvMbLThptMGm5Doy
 GaH/i7ov1+IxYVMTZEMqTHa7OD6lOPZQ4o6RQ/pLco5uK8kdQxZkGGO7J72buL74jRqRcZC0Yc3
 M+UgrQJ+2uWqskXnhOMwH0trwmTJfVoNHMMwZ+1avuNvTBi/ZVdFd6yKljOFiv8T0BpClBds9HD
 IAK05W/hwKHWt75Pyuk9d4bs9vig4h/UdtSynkBehclgs6AoLK9QO5pFisCfVRL7YpnkW3CjhrJ
 L24Qw097Icl1scop1FuMDjGk77VeQJmBCwTW5+tKfBg9VGS0ttiDNU9AviLkTYrMWjtlr9obfFT
 CMPXPemyLM1v7I6feIIDZWmCG3SSiO3sPpW3cwmGCu9gCj7C37Xt7j9Mw8q2WgrkE7Ob63Xu4g8
 0AjyJ5NQLoU4aOHdf80u0rFslNhu9HHgYEdl9nRNjBEgIOnmxcqjj7FNYBNI2TAyirnvMXP4mmK
 7wG5N9n6OlArlG0IqKDtoKJBiIazhQbRtq/I8NNfGrk+GGWXD48xjm4tmjaqXA7ZOkjhjIvvYu3
 J5xIxj5B8ZS8DLtGQLWr2YW0dPTwdSl48TGmM5tbREHgA3CdioHB+53Beibsl0knlLilS4X2KTQ LHBe/uR/vxLPPvg==
X-Mailer: b4 0.13.0
Message-ID: <20240912-shrinker-v1-1-18b7f1253553@google.com>
Subject: [PATCH] rust: shrinker: add shrinker abstraction
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Rust Binder holds incoming transactions in a read-only mmap'd region
where it manually manages the pages. These pages are only in use until
the incoming transaction is consumed by userspace, but the kernel will
keep the pages around for future transactions. Rust Binder registers a
shrinker with the kernel so that it can give back these pages if the
system comes under memory pressure.

Separate types are provided for registered and unregistered shrinkers.
The unregistered shrinker type can be used to configure the shrinker
before registering it. Separating it into two types also enables the
user to construct the private data between the calls to `shrinker_alloc`
and `shrinker_register` and avoid constructing the private data if
allocating the shrinker fails.

The user specifies the callbacks in use by implementing the Shrinker
trait for the type used for the private data. This requires specifying
three things: implementations for count_objects and scan_objects, and
the pointer type that the private data will be wrapped in.

The return values of count_objects and scan_objects are provided using
new types called CountObjects and ScanObjects respectively. These types
prevent the user from e.g. returning SHRINK_STOP from count_objects or
returning SHRINK_EMPTY from scan_objects.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/shrinker.rs         | 324 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 327 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae82e9c941af..7fc958e05dc5 100644
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
@@ -31,4 +32,5 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
 const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
+const gfp_t RUST_CONST_HELPER___GFP_FS = ___GFP_FS;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f10b06a78b9d..f35eb290f2e0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -45,6 +45,7 @@
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
+pub mod shrinker;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/shrinker.rs b/rust/kernel/shrinker.rs
new file mode 100644
index 000000000000..9af726bfe0b1
--- /dev/null
+++ b/rust/kernel/shrinker.rs
@@ -0,0 +1,324 @@
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
+    ffi::{c_int, c_ulong, c_void},
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
+pub struct UnregisteredShrinker {
+    shrinker: NonNull<bindings::shrinker>,
+}
+
+// SAFETY: Moving an unregistered shrinker between threads is okay.
+unsafe impl Send for UnregisteredShrinker {}
+// SAFETY: An unregistered shrinker is thread safe.
+unsafe impl Sync for UnregisteredShrinker {}
+
+impl UnregisteredShrinker {
+    /// Create a new shrinker.
+    pub fn alloc(name: &CStr) -> Result<Self, AllocError> {
+        // SAFETY: Passing `0` as flags is okay. Using `%s` as the format string is okay when we
+        // pass a nul-terminated string as the string for `%s` to print.
+        let ptr =
+            unsafe { bindings::shrinker_alloc(0, c_str!("%s").as_char_ptr(), name.as_char_ptr()) };
+
+        let shrinker = NonNull::new(ptr).ok_or(AllocError)?;
+
+        // INVARIANT: The creation of the shrinker was successful.
+        Ok(Self { shrinker })
+    }
+
+    /// Create a new shrinker using format arguments for the name.
+    pub fn alloc_fmt(name: core::fmt::Arguments<'_>) -> Result<Self, AllocError> {
+        // SAFETY: Passing `0` as flags is okay. Using `%pA` as the format string is okay when we
+        // pass a `fmt::Arguments` as the value to print.
+        let ptr = unsafe {
+            bindings::shrinker_alloc(
+                0,
+                c_str!("%pA").as_char_ptr(),
+                &name as *const _ as *const c_void,
+            )
+        };
+
+        let shrinker = NonNull::new(ptr).ok_or(AllocError)?;
+
+        // INVARIANT: The creation of the shrinker was successful.
+        Ok(Self { shrinker })
+    }
+
+    /// Set the number of seeks needed to recreate an object.
+    pub fn set_seeks(&mut self, seeks: u32) {
+        unsafe { (*self.shrinker.as_ptr()).seeks = seeks as c_int };
+    }
+
+    /// Register the shrinker.
+    ///
+    /// The provided pointer is used as the private data, and the type `T` determines the callbacks
+    /// that the shrinker will use.
+    pub fn register<T: Shrinker>(self, private_data: T::Ptr) -> RegisteredShrinker<T> {
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
+        RegisteredShrinker {
+            shrinker,
+            _phantom: PhantomData,
+        }
+    }
+}
+
+impl Drop for UnregisteredShrinker {
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
+pub struct RegisteredShrinker<T: Shrinker> {
+    shrinker: NonNull<bindings::shrinker>,
+    _phantom: PhantomData<T::Ptr>,
+}
+
+// SAFETY: This allows you to deregister the shrinker from a different thread, which means that
+// private data could be dropped from any thread.
+unsafe impl<T: Shrinker> Send for RegisteredShrinker<T> where T::Ptr: Send {}
+// SAFETY: The only thing you can do with an immutable reference is access the private data, which
+// is okay to access in parallel as the `Shrinker` trait requires the private data to be `Sync`.
+unsafe impl<T: Shrinker> Sync for RegisteredShrinker<T> {}
+
+impl<T: Shrinker> RegisteredShrinker<T> {
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
+impl<T: Shrinker> Drop for RegisteredShrinker<T> {
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
+    ///
+    /// May be called from atomic context.
+    fn count_objects(
+        me: <Self::Ptr as ForeignOwnable>::Borrowed<'_>,
+        sc: ShrinkControl<'_>,
+    ) -> CountObjects;
+
+    /// Count the number of freeable items in the cache.
+    ///
+    /// May be called from atomic context.
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
+    /// Indicates that the number of objects is unknown.
+    pub const UNKNOWN: Self = Self { inner: 0 };
+
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
+    pub fn from_count(count: usize) -> Self {
+        if count == 0 {
+            return Self::EMPTY;
+        }
+
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
+        // The shrinker code assumes that it can multiply this value by two without overflow.
+        inner: c_ulong::MAX / 2,
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
+    /// Determines whether it is safe to recurse into filesystem code.
+    pub fn gfp_fs(&self) -> bool {
+        // SAFETY: Okay by type invariants.
+        let mask = unsafe { (*self.ptr.as_ptr()).gfp_mask };
+
+        (mask & bindings::__GFP_FS) != 0
+    }
+
+    /// Returns the number of objects that `scan_objects` should try to reclaim.
+    pub fn nr_to_scan(&self) -> usize {
+        // SAFETY: Okay by type invariants.
+        unsafe { (*self.ptr.as_ptr()).nr_to_scan as usize }
+    }
+
+    /// The callback should set this value to the number of objects processed.
+    pub fn set_nr_scanned(&mut self, val: usize) {
+        let mut val = val as c_ulong;
+        // SAFETY: Okay by type invariants.
+        let max = unsafe { (*self.ptr.as_ptr()).nr_to_scan };
+        if val > max {
+            val = max;
+        }
+
+        // SAFETY: Okay by type invariants.
+        unsafe { (*self.ptr.as_ptr()).nr_scanned = val };
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
base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
change-id: 20240911-shrinker-f8371af00b68

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


