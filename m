Return-Path: <linux-kernel+bounces-323227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE76F9739C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4C81F25F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F72B1946A1;
	Tue, 10 Sep 2024 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEljLz4k"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1775192B61
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978223; cv=none; b=fEkHW5mcmDbuf5bT/ol+naPTWFGt1Rps05L/5pQEZJkqZLen+P+TXv7/MHzFInX954GxkibUvvd+qIJ5rqv1MJLHRaqEmkkOMe1RzKucnmnWGPlkF/qzdOSXCopIK29kY9kucDn3+ltrfFFpJznHByYehl6SFf80hcewszoJZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978223; c=relaxed/simple;
	bh=+1YqaLbIO1CjRIJVaIUWgdhsDBcc9eaeXoXrcHJEiNI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qLxESWWLHsLdnoCbUdsnrdyMroZgqeTP7eRYq5tlltilfOUn4Z4FX/3sdnuviKTuR40AzCYvd6Ychom9+m7g206lfWcuGwQ7LXh6GCiVmw2GVxUnHF0ljYKeTthhrZqv1ZbvkXCe4bPg202xZNIZpXV0Pn9rh3YL/KOanOPN/r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEljLz4k; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a892d8438so12684254276.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725978220; x=1726583020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Olug6AQaTJGMOFMC9Y5gNODWVqmmf2I8DQqECAprRYI=;
        b=FEljLz4kZUtsumb2XDnLMrwN8NU4sSMIUX2N4pkWycB7oenQlkcLycL4Th2MsGQY5J
         suDc6ShBRyHtfduO8ywmtChehNlld4Lw3uHEii4SbOBTAxxHZI3dZRWszdX4BEhOQDMt
         3kXDCIfG7MPExbknrEislLl40i+8PtH5o0FxV6yeHrvC5MO7+4BUAfoXSh/oo9Z4ePZu
         BHKgOFdHCBIq42kW1M0CSLnJkjMw003Uv4QytgyKzm99/dJmPOMphPKRtQALUcrb+RJY
         I9f518088uknYYjZN2lgSZPHzNcx9BsSkQYH4WiF3osyUIzfX9FozlL24WunMWCHrLnp
         tlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725978220; x=1726583020;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Olug6AQaTJGMOFMC9Y5gNODWVqmmf2I8DQqECAprRYI=;
        b=FDB86HC+Cyg+AvRFpu2IvEJzZuxVuXafU+2BbFvrkip0zYlY1B7C5J7ZYt0MzB5coa
         y8N7t0jd50/FY3/IfTkPuti42GUGcQduJGdwc40qbgWiccB3XqgYIQN6AuZEai7dBEFM
         wRqbTQPLBG9hcseP4pgH7P2LHGDMqJ/t9dprms+BQYQRJbiROOUz2KbQXgl0/a8Ij8Ey
         ioOl3aO15/8YEGQAkkUkSH8KfPpk9IbkwhfNFa+MBNal/nZYo+VZndmZMV/oBt6BtHnz
         CJ2v7W2HoUr5JMN1BxLnCsO0hzhTrGTIW4aiv3gGtqPhrhWLT6NelWsOB9H/vIk0NQcC
         MIUg==
X-Forwarded-Encrypted: i=1; AJvYcCUNhVy9arx270wHEtA8xlO/+WN4o/ig7Lt8OSkPZdh7I3+oppQKjZNFCsCneIWvaB6AjbBxuLEEP5kbdmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPF3nzvAPy4GBrbMEcDKwBNYFVDL+QQGFXCuU7abs1mM4k7CEo
	CGTeRcmZC6edzLYw3zqNBLOj3MJb2b7CpvqAZTQ9Dd4qQpQlXxFoEA4WyWxdkkusPh6E453hYVw
	prqSPRaetJbv9Lw==
X-Google-Smtp-Source: AGHT+IG7QvC40hbkPA/X6AH0RBFhgbcVbClixvfL0T+gKW4X8da6e4P+cBWJXngYaFcbI1VPdvu+puiRaEQJpAQ=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:5f08:0:b0:e0b:f1fd:1375 with SMTP id
 3f1490d57ef6-e1d34a1fb19mr22364276.10.1725978219872; Tue, 10 Sep 2024
 07:23:39 -0700 (PDT)
Date: Tue, 10 Sep 2024 14:23:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGVW4GYC/3XMQQ6CMBCF4auQWVvTThGIK+9hXJQ6wCRiTVsbD
 OHuFlZq4vK95PtnCOSZAhyLGTwlDuzueehdAXYw954EX/MGlFjKBisRoolsxfiMNAlTtogNSaq
 MgUwenjqettz5kvfAITr/2upJre+fUFJCCaNKolodKtXpU+9cf6O9dSOspYSfuv7RmLWqO6uxR ak1fullWd4H66rw5wAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=13002; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=+1YqaLbIO1CjRIJVaIUWgdhsDBcc9eaeXoXrcHJEiNI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm4FZoStRz0LGMrtqo3i9tpXUHFYZ1DC31hn9oN
 dMTlFyPZpKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZuBWaAAKCRAEWL7uWMY5
 Rkr5D/9mFGkOY2c0itwL8zHPQwJ3I1vHmtwOvY7D1zzrOojkq0zQVWwjBkQ4KsEX3IQeWyZR3H/
 Jp3OIIxXnO2XE0cLVzGuOqbPxkBRFq5h7FG8s7DCGRQLVOb6/NCucFG2LE3pzJNLbt1FSKxj/4k
 YqVWWhPAzaRjiDLN2KjRLyyUPsGbxOdGoVEzKFFgkr0L+ADhOuhCWgWIptJL4uhTALoHjDqlWue
 ViNkayabbL8oTv/uK6u1SfGSn81Cl+aWX03klSGzQiVR+cv67kkfdA+8OZmsHshz8OmerNqy2mT
 Ty/OyNosuWdEM9sgS3lcWF+9+m9FPrDxW44MumCYoLSjpUdTZ+0B4CU0ayZl3r6QN10h1bR6ihC
 87BmiiPSdjZTdL5OtZma6jRvmGPkE1PxKby7Nj/eZHxc6IRzTiCLy0zEG0R4TvyUGYsLXMlqjxL
 evvwae3kOKXp7LvpuchKOzqlKqHcMEYJHkaV+F+uQ1mYt+vQonMgS/ijdpy9oG/XWCkBjhatL89
 tt+sgIYwX6D7eezjy0K95BN5ddLJbt5eNopmB3B/69nijPGRhasGo6bp7fNW2lRSBZ0gFTgznA1
 rfQXro+COF4HocuSSe9hVt/pfKPYJesBXqM9jVE6B96TLq0WENm/5xsbzWez8x3AP3YuYVdtAHV LmoUxsLsW4Z/BCw==
X-Mailer: b4 0.13.0
Message-ID: <20240910-static-mutex-v3-1-5bebd11bdf3b@google.com>
Subject: [PATCH v3] rust: add global lock support
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Add support for creating global variables that are wrapped in a mutex or
spinlock. Optionally, the macro can generate a special LockedBy type
that does not require a runtime check.

The implementation here is intended to replace the global mutex
workaround found in the Rust Binder RFC [1]. In both cases, the global
lock must be initialized before first use. The macro is unsafe to use
for the same reason.

The separate initialization step is required because bindgen refuses to
expose __ARCH_SPIN_LOCK_UNLOCKED to Rust as a compile-time constant. It
just generates an `extern "C"` global reference instead. In the future,
we could expose the value of __ARCH_SPIN_LOCK_UNLOCKED to Rust in a way
that Rust can understand. This would remove the need for a separate
initialization step.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08ba9197f637@google.com/#Z31drivers:android:context.rs [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
I've been having some trouble with the kunit tests. The import of
__static_lock_ty_$name fails when I try with kunit, but copying the same
code into a sample does not reproduce the error. Suggestions would be
appreciated.
---
Changes in v3:
- Rewrite to provide a macro instead.
- Link to v2: https://lore.kernel.org/r/20240827-static-mutex-v2-1-17fc32b20332@google.com

Changes in v2:
- Require `self: Pin<&Self>` and recommend `Pin::static_ref`.
- Other doc improvements including new example.
- Link to v1: https://lore.kernel.org/r/20240826-static-mutex-v1-1-a14ee71561f3@google.com
---
 rust/kernel/sync.rs             |   1 +
 rust/kernel/sync/lock.rs        |  31 +++++-
 rust/kernel/sync/lock/global.rs | 237 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..2e97e22715db 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -14,6 +14,7 @@
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
+pub use lock::global::global_lock;
 pub use lock::mutex::{new_mutex, Mutex};
 pub use lock::spinlock::{new_spinlock, SpinLock};
 pub use locked_by::LockedBy;
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..3ae7a278016d 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -7,12 +7,14 @@
 
 use super::LockClassKey;
 use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned, pin::Pin};
 use macros::pin_data;
 
 pub mod mutex;
 pub mod spinlock;
 
+pub(super) mod global;
+
 /// The "backend" of a lock.
 ///
 /// It is the actual implementation of the lock, without the need to repeat patterns used in all
@@ -117,6 +119,33 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
             }),
         })
     }
+
+    /// # Safety
+    ///
+    /// Before any other method on this lock is called, `global_lock_helper_init` must be called.
+    #[doc(hidden)]
+    pub const unsafe fn global_lock_helper_new(state: Opaque<B::State>, data: T) -> Self {
+        Self {
+            state,
+            data: UnsafeCell::new(data),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// # Safety
+    ///
+    /// * This lock must have been created using `global_lock_helper_new`.
+    /// * Must only be called once for each lock.
+    #[doc(hidden)]
+    pub unsafe fn global_lock_helper_init(
+        self: Pin<&Self>,
+        name: &'static CStr,
+        key: &'static LockClassKey,
+    ) {
+        // SAFETY: The pointer to `state` is valid for the duration of this call, and both `name`
+        // and `key` are valid indefinitely.
+        unsafe { B::init(self.state.get(), name.as_char_ptr(), key.as_ptr()) }
+    }
 }
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
new file mode 100644
index 000000000000..c1eb25d37abd
--- /dev/null
+++ b/rust/kernel/sync/lock/global.rs
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Support for defining statics containing locks.
+
+/// Defines a global lock.
+///
+/// Supports the following options:
+///
+/// * `value` specifies the initial value in the global lock.
+/// * `wrapper` specifies the name of the wrapper struct.
+/// * `guard` specifies the name of the guard type.
+/// * `locked_by` specifies the name of the `LockedBy` type.
+///
+/// # Examples
+///
+/// A global counter.
+///
+/// ```
+/// kernel::sync::global_lock! {
+///     // SAFETY: Initialized in module initializer before first use.
+///     static MY_COUNTER: Mutex<u32> = unsafe { uninit };
+///     value: 0;
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
+/// ```
+///
+/// A global mutex used to protect all instances of a given struct.
+///
+/// ```
+/// kernel::sync::global_lock! {
+///     // SAFETY: Initialized in module initializer before first use.
+///     static MY_MUTEX: Mutex<()> = unsafe { uninit };
+///     value: ();
+///     guard: MyGuard;
+///     locked_by: LockedByMyMutex;
+/// }
+///
+/// /// All instances of this struct are protected by `MY_MUTEX`.
+/// struct MyStruct {
+///     my_counter: LockedByMyMutex<u32>,
+/// }
+///
+/// impl MyStruct {
+///     /// Increment the counter in this instance.
+///     ///
+///     /// The caller must hold the `MY_MUTEX` mutex.
+///     fn increment(&self, guard: &mut MyGuard) -> u32 {
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
+/// ```
+#[macro_export]
+macro_rules! global_lock {
+    {
+        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$valuety:ty> = unsafe { uninit };
+        value: $value:expr;
+        wrapper: $wrapper:ident;
+        $( name: $lname:literal; )?
+        $(
+            guard: $guard:ident;
+            locked_by: $locked_by:ident;
+        )?
+    } => {
+        $crate::macros::paste! {
+            type [< __static_lock_ty_ $name >] = $valuety;
+
+            #[allow(unused_pub)]
+            mod [< __static_lock_mod_ $name >] {
+                use super::[< __static_lock_ty_ $name >] as Val;
+                type Backend = $crate::global_lock_inner!(backend $kind);
+                type GuardTyp = $crate::global_lock_inner!(guard $kind, Val $(, $guard)?);
+
+                /// # Safety
+                ///
+                /// Must be used to initialize `super::$name`.
+                pub(super) const unsafe fn new() -> $wrapper {
+                    let state = $crate::types::Opaque::uninit();
+                    $wrapper {
+                        // SAFETY: The user of this macro promises to call `init` before calling
+                        // `lock`.
+                        inner: unsafe {
+                            $crate::sync::lock::Lock::global_lock_helper_new(state, $value)
+                        }
+                    }
+                }
+
+                /// Wrapper type for a global lock.
+                pub struct $wrapper {
+                    inner: $crate::sync::lock::Lock<Val, Backend>,
+                }
+
+                impl $wrapper {
+                    /// Initialize the global lock.
+                    ///
+                    /// # Safety
+                    ///
+                    /// This method must not be called more than once.
+                    pub unsafe fn init(&'static self) {
+                        // SAFETY:
+                        // * This type can only be created by `new`.
+                        // * Caller promises to not call this method more than once.
+                        unsafe {
+                            $crate::sync::lock::Lock::global_lock_helper_init(
+                                ::core::pin::Pin::static_ref(&self.inner),
+                                $crate::optional_name!($($lname)?),
+                                $crate::static_lock_class!(),
+                            );
+                        }
+                    }
+
+                    /// Lock this global lock.
+                    pub fn lock(&'static self) -> GuardTyp {
+                        $crate::global_lock_inner!(new_guard $($guard)? {
+                            self.inner.lock()
+                        })
+                    }
+                }
+
+                $(
+                pub struct $guard($crate::sync::lock::Guard<'static, Val, Backend>);
+
+                impl ::core::ops::Deref for $guard {
+                    type Target = Val;
+                    fn deref(&self) -> &Val {
+                        &self.0
+                    }
+                }
+
+                impl ::core::ops::DerefMut for $guard {
+                    fn deref_mut(&mut self) -> &mut Val {
+                        &mut self.0
+                    }
+                }
+
+                pub struct $locked_by<T: ?Sized>(::core::cell::UnsafeCell<T>);
+
+                impl<T> $locked_by<T> {
+                    pub fn new(val: T) -> Self {
+                        Self(::core::cell::UnsafeCell::new(val))
+                    }
+                }
+
+                impl<T: ?Sized> $locked_by<T> {
+                    pub fn as_ref<'a>(&'a self, _guard: &'a $guard) -> &'a T {
+                        // SAFETY: The lock is globally unique, so there can only be one guard.
+                        unsafe { &*self.0.get() }
+                    }
+
+                    pub fn as_mut<'a>(&'a self, _guard: &'a mut $guard) -> &'a mut T {
+                        // SAFETY: The lock is globally unique, so there can only be one guard.
+                        unsafe { &mut *self.0.get() }
+                    }
+
+                    pub fn get_mut(&mut self) -> &mut T {
+                        self.0.get_mut()
+                    }
+                }
+                )?
+            }
+
+            use [< __static_lock_mod_ $name >]::$wrapper;
+            $( use [< __static_lock_mod_ $name >]::{$guard, $locked_by}; )?
+
+            $(#[$meta])*
+            $pub static $name: $wrapper = {
+                // SAFETY: We are using this to initialize $name.
+                unsafe { [< __static_lock_mod_ $name >]::new() }
+            };
+        }
+    };
+
+    {
+        $(#[$meta:meta])* $pub:vis static $name:ident: $kind:ident<$valuety:ty> = unsafe { uninit };
+        value: $value:expr;
+        $( name: $lname:literal; )?
+        $(
+            guard: $guard:ident;
+            locked_by: $locked_by:ident;
+        )?
+    } => {
+        $crate::macros::paste! {
+            $crate::global_lock! {
+                $(#[$meta])* $pub static $name: $kind<$valuety> = unsafe { uninit };
+                value: $value;
+                wrapper: [< __static_lock_wrapper_ $name >];
+                $( name: $lname; )?
+                $( guard: $guard; locked_by: $locked_by; )?
+            }
+        }
+    }
+}
+pub use global_lock;
+
+#[doc(hidden)]
+#[macro_export]
+macro_rules! global_lock_inner {
+    (backend Mutex) => { $crate::sync::lock::mutex::MutexBackend };
+    (backend SpinLock) => { $crate::sync::lock::spinlock::SpinLockBackend };
+    (guard Mutex, $val:ty) => {
+        $crate::sync::lock::Guard<'static, $val, $crate::sync::lock::mutex::MutexBackend>
+    };
+    (guard SpinLock, $val:ty) => {
+        $crate::sync::lock::Guard<'static, $val, $crate::sync::lock::spinlock::SpinLockBackend>
+    };
+    (guard $kind:ident, $val:ty, $name:ident) => { $name };
+    (new_guard { $val:expr }) => { $val };
+    (new_guard $name:ident { $val:expr }) => { $name($val) };
+}

---
base-commit: 93dc3be19450447a3a7090bd1dfb9f3daac3e8d2
change-id: 20240826-static-mutex-a4b228e0e6aa

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


