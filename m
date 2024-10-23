Return-Path: <linux-kernel+bounces-378072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29399ACAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B79B23410
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617C12B71;
	Wed, 23 Oct 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zwJ7KvCR"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4698914D2AC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689473; cv=none; b=E3gCw2LMDxH5FE0mguo4kPxvklwDmqbhNPu/ODXZI9k5r/4QqwkS2Z2u2MSNmzHXTf0BFAt57WEOmna6N/yZ8HOOIar60eHZoGK8rV7LLwxJyY9KTX0yhGJFjpipMko5OYpEJbucirUvhi5VOwjLsKAHG2PkmjBGkoJAibGnfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689473; c=relaxed/simple;
	bh=+5W/rIuRxpoyM7WbROLtkvhTXg9ErqI9SC1VaXjOg8Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=P6LEs876p+i1NC+IbjPg8DeseMtP7z2wSfLB1KlIqbZT8EDbJQ9JjtLZwy+tvSa/pmQj+NLfgzSd5E3CAwp9F5KMYsf3TZVioWeqZNq9N3OX8PHRSTmF3mkIbhrXio0qRYCyOvHozwLzIbEGP9rGVYQ8XbLPmOZOVgn8YPbviQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zwJ7KvCR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so11341401276.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729689470; x=1730294270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Kd7hoTU8K1DkQEOJO1IJg+T3iT04B3HGoJQ3VaPlwI=;
        b=zwJ7KvCRH/XwIEFdbjNa1nLsS8CH7s13zyGATK9EYCclQOlV9nKv+u0w4fnjk/RX2j
         RF9WqcPPlyVTlaex6+BFf5yBmXjvmV3KhSI+kvEFx0aQxQ7RZ9Ryt/dZYlY87frJ5viK
         f5OxC+B/KH6poUii+hZFZQtR0xwQv4m0cqW4v8n1LK1DDDhWi0C1ghMa4Py/NcAPMLYx
         dbRdhG+52tdA0WcgAEKBEPWV6eG8SFMkvmGPIOlUG2b/XFLnnI+/QQC2iOMG266cxvsL
         UiKa16zCYwjl7qT63+1tlKwIm04XGKZ1TUibab3FBhHWMMjtaMAtPPf8qmuWMQfi0/Pr
         ejSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729689470; x=1730294270;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Kd7hoTU8K1DkQEOJO1IJg+T3iT04B3HGoJQ3VaPlwI=;
        b=NReFKh0UBYUTkqFmAKke7KJq5ZcSye+zC4+lY0tKVGXXwqyTrSNGdJi0USZX/1YfoP
         PM1oItydsEKq7/Jm80eToCOoPv0aOBruldoUFsux2EMGDu0zwk2YglxEq5gs8AluEAK2
         GbABbZWJnKWrXXzuB7y0FsQt9p2rGPViBAHCtFd3sZgIbz0GwlyIXXIr+IwY32DGD04E
         s+o8UibVD2xYNxwHdjc5bl1RrktwKhcOJQRqQ3wtbGBVPTlw1en1k8qYInZc7OzRjeo9
         7q46yHtwPtzGvdI9nofrnnt//SETSLOEH0LqqyDKDjPc9dyWXJXRJxRpbnCKSJ5bWxbI
         r95A==
X-Forwarded-Encrypted: i=1; AJvYcCW0BDzolxmhSNLdgYHZGKdCFsidkuDW63ssCRjap2zjYdtkQKSe4SKvF6rlWUUVNLh9xOBqEqtsW6CxCOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywegb7YlguoS1m7SVhKiIXIginxM788KJiz4ym1ReKfU3HH7h1V
	La8GleEVymBdyYa5rZtodTgDwegoz4oGcE1g99bYPspkgrKYDqaXcvgmTWYJLv17IDwZfKOUUc/
	0HY8VFszGIF5jkQ==
X-Google-Smtp-Source: AGHT+IHss+F+dBJLJtvJS+4Rg7xFoyKfnrZe78WsJfeyqQ60loQG4T2Dq9z2REU6Umiq3hmgV5OIcxnckqcv328=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:dd47:0:b0:e2e:2940:9b43 with SMTP id
 3f1490d57ef6-e2e3a5f36d2mr1452276.1.1729689469489; Wed, 23 Oct 2024 06:17:49
 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:17:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAF73GGcC/3XMQQ7CIBCF4asY1mKYGWjVlfcwLoBOK4mKKbXRm
 N5d2o1a4/K95PufInEbOInt4ila7kMK8ZKHWS6EP9pLwzJUeQtUqNUaC5k62wUvz7eO79Jqh7h
 mxYW1IpNry3W4T7n9Ie9jSF1sH1O9h/H9E+pBgrSgmUswBdS0a2JsTrzy8SzGUo+fupxpzBrK2 hM6VET4o+mtN6BmmrI2jl0F4Kqa3I/WH5rmWmftzcYYo4EAyy89DMMLYgAZVWMBAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=12842; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=+5W/rIuRxpoyM7WbROLtkvhTXg9ErqI9SC1VaXjOg8Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnGPdhR4JHQIMIVH3GjyH+MEvAVUib9CArtxv6Q
 n7/+2o4k0eJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZxj3YQAKCRAEWL7uWMY5
 RjrXEACQUXdZCbvGpH9qvTfJ5LZzlxRzbzhq2DVa4cJXGU//RlaMmAQ5mEqnlPKyLNrgM+U5K1R
 lgieyCI6PwhJegJGojq6t/7hEIty4Mq68rFviRUWrO+rIzvdqHVNttuiAYKNCfbAwkISdczMfIG
 ZWSwh0l8/HG8L5bu9BgIayPHczkLTpzgtsnuB7d4zXH90ys4r7WiUPuEu1qHZTqOnmB+Ge6TYkw
 q8Tugce87qmzzbRXESL7gCNulZxA7nTMv7XfA0sZdNi29VAgd0YRFhUpjAcxpDrZH32RIp+myn2
 HgyKtPhGv+GNQ8U72UBTNYPdrljpzbCy0ULMIFszCiJwo8Mrc27/wLWh/O5MpdPnhHsURjupQYX
 9cd3mmFJHjG199LeNwTa5XqrOgUFG95W4h38hMwfATozdaZY1LlOXEDLxFzv5PaNy9G6jWuYjWw
 eyOyodJqjFFDIMb57Xu9Vb/qUIP7bST96Z2Z8MZi359tbC7SDG9kcV4VE/9kbeZMa4q5mxuGCFp
 s6cLTljxcT9AavirjMuY2qoVVSSKvZcGFIIy9Yww19/Ou5FatVpsevX+xaKRhxEKR++hAvhfg5U
 NyhhK+skDwXzb5NhoL6QiDUY/Op8S9szopq+NzXyFfFrfBbthrBabGvGDMRVZrY/ij/oUrzzvW4 b1IPn7IHf1Tuidg==
X-Mailer: b4 0.13.0
Message-ID: <20241023-static-mutex-v5-1-f96b1a425c40@google.com>
Subject: [PATCH v5] rust: add global lock support
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add support for creating global variables that are wrapped in a mutex or
spinlock.

The implementation here is intended to replace the global mutex
workaround found in the Rust Binder RFC [1]. In both cases, the global
lock must be initialized before first use. The macro is unsafe to use
for the same reason.

The separate initialization step is required because it is tricky to
access the value of __ARCH_SPIN_LOCK_UNLOCKED from Rust. Doing so will
require changes to the C side. That change will happen as a follow-up to
this patch.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08ba9197f637@google.com/#Z31drivers:android:context.rs [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This patch is based on top of rust-next as it depends on:
https://lore.kernel.org/r/BL0PR02MB4914579914884B5D7473B3D6E96A2@BL0PR02MB4914.namprd02.prod.outlook.com
---
Changes in v5:
- Completely rewrote the implementation to move almost everything
  outside the macro.
- Link to v4: https://lore.kernel.org/r/20240930-static-mutex-v4-1-c59555413127@google.com

Changes in v4:
- Evaluate `$value` in the surrounding scope.
- Make types `pub(crate)` to avoid "private type in public interface"
  errors when using the macro.
- Add trylock method.
  - using https://lore.kernel.org/r/BL0PR02MB4914579914884B5D7473B3D6E96A2@BL0PR02MB4914.namprd02.prod.outlook.com
- Add Send/Sync implementations of LockedBy.
- Fix examples so they compile.
- Link to v3: https://lore.kernel.org/r/20240910-static-mutex-v3-1-5bebd11bdf3b@google.com

Changes in v3:
- Rewrite to provide a macro instead.
- Link to v2: https://lore.kernel.org/r/20240827-static-mutex-v2-1-17fc32b20332@google.com

Changes in v2:
- Require `self: Pin<&Self>` and recommend `Pin::static_ref`.
- Other doc improvements including new example.
- Link to v1: https://lore.kernel.org/r/20240826-static-mutex-v1-1-a14ee71561f3@google.com
---
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |   3 +
 rust/kernel/sync/lock/global.rs | 303 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 307 insertions(+)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..2bdd1cffcdab 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -14,6 +14,7 @@
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
+pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
 pub use lock::mutex::{new_mutex, Mutex};
 pub use lock::spinlock::{new_spinlock, SpinLock};
 pub use locked_by::LockedBy;
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 90cc5416529b..a5d89cebf106 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -13,6 +13,9 @@
 pub mod mutex;
 pub mod spinlock;
 
+pub(super) mod global;
+pub use global::{GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
+
 /// The "backend" of a lock.
 ///
 /// It is the actual implementation of the lock, without the need to repeat patterns used in all
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
new file mode 100644
index 000000000000..5ba90b7f4074
--- /dev/null
+++ b/rust/kernel/sync/lock/global.rs
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Support for defining statics containing locks.
+
+use crate::{
+    str::CStr,
+    sync::lock::{Backend, Guard, Lock},
+    sync::{LockClassKey, LockedBy},
+    types::Opaque,
+};
+use core::{
+    cell::UnsafeCell,
+    marker::{PhantomData, PhantomPinned},
+};
+
+/// Trait implemented for marker types for global locks.
+///
+/// See [`global_lock!`](crate::sync::global_lock) for examples.
+pub trait GlobalLockBackend {
+    /// The name for this global lock.
+    const NAME: &'static CStr;
+    /// Item type stored in this global lock.
+    type Item: 'static;
+    /// The backend used for this global lock.
+    type Backend: Backend + 'static;
+    /// The class for this global lock.
+    fn get_lock_class() -> &'static LockClassKey;
+}
+
+/// Type used for global locks.
+///
+/// See [`global_lock!`](crate::sync::global_lock) for examples.
+pub struct GlobalLock<B: GlobalLockBackend> {
+    inner: Lock<B::Item, B::Backend>,
+}
+
+impl<B: GlobalLockBackend> GlobalLock<B> {
+    /// Creates a global lock.
+    ///
+    /// # Safety
+    ///
+    /// * Before any other method on this lock is called, [`init`] must be called.
+    /// * The type `B` must not be used with any other lock.
+    ///
+    /// [`init`]: Self::init
+    pub const unsafe fn new(data: B::Item) -> Self {
+        Self {
+            inner: Lock {
+                state: Opaque::uninit(),
+                data: UnsafeCell::new(data),
+                _pin: PhantomPinned,
+            },
+        }
+    }
+
+    /// Initializes a global lock.
+    ///
+    /// # Safety
+    ///
+    /// Must not be called more than once on a given lock.
+    pub unsafe fn init(&'static self) {
+        // SAFETY: The pointer to `state` is valid for the duration of this call, and both `name`
+        // and `key` are valid indefinitely. The `state` is pinned since we have a `'static`
+        // reference to `self`.
+        //
+        // We have exclusive access to the `state` since the caller of `new` promised to call
+        // `init` before using any other methods. As `init` can only be called once, all other
+        // uses of this lock must happen after this call.
+        unsafe {
+            B::Backend::init(
+                self.inner.state.get(),
+                B::NAME.as_char_ptr(),
+                B::get_lock_class().as_ptr(),
+            )
+        }
+    }
+
+    /// Lock this global lock.
+    pub fn lock(&'static self) -> GlobalGuard<B> {
+        GlobalGuard {
+            inner: self.inner.lock(),
+        }
+    }
+
+    /// Try to lock this global lock.
+    pub fn try_lock(&'static self) -> Option<GlobalGuard<B>> {
+        Some(GlobalGuard {
+            inner: self.inner.try_lock()?,
+        })
+    }
+}
+
+/// A guard for a [`GlobalLock`].
+///
+/// See [`global_lock!`](crate::sync::global_lock) for examples.
+pub struct GlobalGuard<B: GlobalLockBackend> {
+    inner: Guard<'static, B::Item, B::Backend>,
+}
+
+impl<B: GlobalLockBackend> core::ops::Deref for GlobalGuard<B> {
+    type Target = B::Item;
+
+    fn deref(&self) -> &Self::Target {
+        &self.inner
+    }
+}
+
+impl<B: GlobalLockBackend> core::ops::DerefMut for GlobalGuard<B> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.inner
+    }
+}
+
+/// A version of [`LockedBy`] for a [`GlobalLock`].
+///
+/// See [`global_lock!`](crate::sync::global_lock) for examples.
+pub struct GlobalLockedBy<T: ?Sized, B: GlobalLockBackend> {
+    _backend: PhantomData<B>,
+    value: UnsafeCell<T>,
+}
+
+// SAFETY: The same thread-safety rules as `LockedBy` apply to `GlobalLockedBy`.
+unsafe impl<T, B> Send for GlobalLockedBy<T, B>
+where
+    T: ?Sized,
+    B: GlobalLockBackend,
+    LockedBy<T, B::Item>: Send,
+{
+}
+
+// SAFETY: The same thread-safety rules as `LockedBy` apply to `GlobalLockedBy`.
+unsafe impl<T, B> Sync for GlobalLockedBy<T, B>
+where
+    T: ?Sized,
+    B: GlobalLockBackend,
+    LockedBy<T, B::Item>: Sync,
+{
+}
+
+impl<T, B: GlobalLockBackend> GlobalLockedBy<T, B> {
+    /// Create a new [`GlobalLockedBy`].
+    ///
+    /// The provided value will be protected by the global lock indicated by `B`.
+    pub fn new(val: T) -> Self {
+        Self {
+            value: UnsafeCell::new(val),
+            _backend: PhantomData,
+        }
+    }
+}
+
+impl<T: ?Sized, B: GlobalLockBackend> GlobalLockedBy<T, B> {
+    /// Access the value immutably.
+    ///
+    /// The caller must prove shared access to the lock.
+    pub fn as_ref<'a>(&'a self, _guard: &'a GlobalGuard<B>) -> &'a T {
+        // SAFETY: The lock is globally unique, so there can only be one guard.
+        unsafe { &*self.value.get() }
+    }
+
+    /// Access the value mutably.
+    ///
+    /// The caller must prove shared exclusive to the lock.
+    pub fn as_mut<'a>(&'a self, _guard: &'a mut GlobalGuard<B>) -> &'a mut T {
+        // SAFETY: The lock is globally unique, so there can only be one guard.
+        unsafe { &mut *self.value.get() }
+    }
+
+    /// Access the value mutably directly.
+    ///
+    /// The caller has exclusive access to this `GlobalLockedBy`, so they do not need to hold the
+    /// lock.
+    pub fn get_mut(&mut self) -> &mut T {
+        self.value.get_mut()
+    }
+}
+
+/// Defines a global lock.
+///
+/// The global mutex must be initialized before first use. Usually this is done by calling
+/// [`init`](GlobalLock::init) in the module initializer.
+///
+/// # Examples
+///
+/// A global counter.
+///
+/// ```
+/// # mod ex {
+/// # use kernel::prelude::*;
+/// kernel::sync::global_lock! {
+///     // SAFETY: Initialized in module initializer before first use.
+///     unsafe(uninit) static MY_COUNTER: Mutex<u32> = 0;
+/// }
+///
+/// fn increment_counter() -> u32 {
+///     let mut guard = MY_COUNTER.lock();
+///     *guard += 1;
+///     *guard
+/// }
+///
+/// impl kernel::Module for MyModule {
+///     fn init(_module: &'static ThisModule) -> Result<Self> {
+///         // SAFETY: called exactly once
+///         unsafe { MY_COUNTER.init() };
+///
+///         Ok(MyModule {})
+///     }
+/// }
+/// # struct MyModule {}
+/// # }
+/// ```
+///
+/// A global mutex used to protect all instances of a given struct.
+///
+/// ```
+/// # mod ex {
+/// # use kernel::prelude::*;
+/// use kernel::sync::{GlobalGuard, GlobalLockedBy};
+///
+/// kernel::sync::global_lock! {
+///     // SAFETY: Initialized in module initializer before first use.
+///     unsafe(uninit) static MY_MUTEX: Mutex<()> = ();
+/// }
+///
+/// /// All instances of this struct are protected by `MY_MUTEX`.
+/// struct MyStruct {
+///     my_counter: GlobalLockedBy<u32, MY_MUTEX>,
+/// }
+///
+/// impl MyStruct {
+///     /// Increment the counter in this instance.
+///     ///
+///     /// The caller must hold the `MY_MUTEX` mutex.
+///     fn increment(&self, guard: &mut GlobalGuard<MY_MUTEX>) -> u32 {
+///         let my_counter = self.my_counter.as_mut(guard);
+///         *my_counter += 1;
+///         *my_counter
+///     }
+/// }
+///
+/// impl kernel::Module for MyModule {
+///     fn init(_module: &'static ThisModule) -> Result<Self> {
+///         // SAFETY: called exactly once
+///         unsafe { MY_MUTEX.init() };
+///
+///         Ok(MyModule {})
+///     }
+/// }
+/// # struct MyModule {}
+/// # }
+/// ```
+#[macro_export]
+macro_rules! global_lock {
+    {
+        $(#[$meta:meta])* $pub:vis
+        unsafe(uninit) static $name:ident: $kind:ident<$valuety:ty> = $value:expr;
+    } => {
+        #[doc = ::core::concat!(
+            "Backend type used by [`",
+            ::core::stringify!($name),
+            "`](static@",
+            ::core::stringify!($name),
+            ")."
+        )]
+        #[allow(non_camel_case_types, unreachable_pub)]
+        $pub enum $name {}
+
+        impl $crate::sync::lock::GlobalLockBackend for $name {
+            const NAME: &'static $crate::str::CStr = $crate::c_str!(::core::stringify!($name));
+            type Item = $valuety;
+            type Backend = $crate::global_lock_inner!(backend $kind);
+
+            fn get_lock_class() -> &'static $crate::sync::LockClassKey {
+                $crate::static_lock_class!()
+            }
+        }
+
+        $(#[$meta])*
+        $pub static $name: $crate::sync::lock::GlobalLock<$name> = {
+            // Defined here to be outside the unsafe scope.
+            let init: $valuety = $value;
+
+            // SAFETY:
+            // * The user of this macro promises to initialize the macro before use.
+            // * We are only generating one static with this backend type.
+            unsafe { $crate::sync::lock::GlobalLock::new(init) }
+        };
+    };
+}
+pub use global_lock;
+
+#[doc(hidden)]
+#[macro_export]
+macro_rules! global_lock_inner {
+    (backend Mutex) => {
+        $crate::sync::lock::mutex::MutexBackend
+    };
+    (backend SpinLock) => {
+        $crate::sync::lock::spinlock::SpinLockBackend
+    };
+}

---
base-commit: 6ce162a002657910104c7a07fb50017681bc476c
change-id: 20240826-static-mutex-a4b228e0e6aa

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


