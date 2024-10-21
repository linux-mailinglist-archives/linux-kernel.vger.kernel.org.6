Return-Path: <linux-kernel+bounces-374417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C229A69E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD95C28188E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13F1F1311;
	Mon, 21 Oct 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U733GCvE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F312746A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516691; cv=none; b=Ev7QgMKHt3JjU+jpj7WO9oWXkR6mx1+SnzBF4b51vsaQAgg/zC504kkQeE8arzEX2yqo4TQwzhV3XthQgBobDxlfWO2Pj4V5pjR34qv4s8SefYK/PgBSab7V7SHlw03CMxFUjiwlULWOVMDAl+KTtbV3oEjMsxi+nXgN4iaWFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516691; c=relaxed/simple;
	bh=XaRMg+f7cflBfn5wPAG2tP25rkrQhgvqHCAjcE8xvp4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ly2bMXb6ixNQ7UV/UfSaeAgicjmn3F6NGx0F/3r99Gq7HOu3N+J3gUmoQBEjOWr9f+GhzLBVMEE1hKqGrdg+ImdMTegl3tCQhwTMaxgEeb6WLK8TdHd2Ek8cWdD0KEj9U8tAs+y7xvxU2L5BZDBNyK/TLMMVh00W+71t292Zfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U733GCvE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3497c8eb0so49853347b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729516688; x=1730121488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZBkjIHcG7OWC6gCwIlTzf2OKyASXwsEtH5zcLRwbP3o=;
        b=U733GCvE7V4mSZvdm5uxgCgOW7JRLzCNukCnyJU+vzdAqGT+lP+jc0iTul/MHLcE78
         IF2rHjdbWSbG9GilP/s6m+LIwxomtlxF2G98fVrUOH+oFpbxUR+4tTTobOIf8C1IuTKG
         mc8Ig67eF6yaYm9Ubn9HJ57tww6v4jzGWLQdRjIHK3+HujRIKydmGqM62jMApM+LyDZx
         teTxggtYN5d/11hsjLOAOl2E19cBfA+XduhPMw0l4ls8T5/lhB0apDRIdaTakHMR5BWC
         TYKK2533OjUfzFbxcwpltdR2qfGmJgtVAT84FTVBVwodNUVSDsj/ERg6zx7Ef4QpU4y1
         CmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729516688; x=1730121488;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBkjIHcG7OWC6gCwIlTzf2OKyASXwsEtH5zcLRwbP3o=;
        b=dauDI6d4fMLtpxGbiK9sqUZrKdscpCVTqcd9BJQ72gvIUA+SlIQiVZCTaJIZ6hyMjC
         Dtda4yaGHG0I/xnQtEae9YStJq1BZ2ANmDDF7fSivnmKskuk+hw2gl181uEKxb/RzOGj
         mSkXx/1w9vTX452EQM3ApkxX23hStBM0lJqLkbZ14CPGaMF9c4F2hijpwn6JhzMZNkT4
         nzztRLFXtu9jmJbCMvbSlqEZQbeoy0FbKjkikf9jlaSJORvQL4SEumvOFcx4aNHNtLYa
         sROoZ5O3zjvWbXMc9/FjrV5hhjWX1VA5smOxMHjGh87tF4RKBDrTx5hRfwit1PSJr+hq
         qkOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOcia/sP69aZgdTaxqdFxfXrF7dXVBvQR2AGjtuPw0WkuJj29pUdVMBr+M37WO7EmragD4uiiG4e2BLFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9Cc5LcTmE+hjeojtWisX9Q/+4gTbgzCXwE05j1fLx8di1t1Y
	1MTlC/Aq0hIoJ/+kWdp/6+VxbxioYWM8MyUIcNqBhMQ4y4gyt2iZRzqsudj+70gBixTSXeYBmbD
	b0wb6kBjgIkyadw==
X-Google-Smtp-Source: AGHT+IEz77/LgiLflf6rDHflHeUbyjxMBDMmGS9KBB0pyLptaezR9lCjX57ED8/E82i9VJ+oV1GNHLaMyentTIc=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:2d04:b0:6e2:c1c7:ec27 with SMTP
 id 00721157ae682-6e5a3d1cb28mr802287b3.1.1729516687767; Mon, 21 Oct 2024
 06:18:07 -0700 (PDT)
Date: Mon, 21 Oct 2024 13:17:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGJUFmcC/3XMQQ7CIBCF4asY1mKYGWjVlfcwLoBOK4mKKbXRm
 N5d2o1a4/K95PufInEbOInt4ila7kMK8ZKHWS6EP9pLwzJUeQtUqNUaC5k62wUvz7eO79Jqh7h
 mxYW1IpNry3W4T7n9Ie9jSF1sH1O9h/H9E+pBgrSgmUswBdS0a2JsTrzy8SzGUo+fupxpzBrK2 hM6VET4o+mtN6BmmrI2jl0F4Kqa3I/WH5rmWmftzcYYo4EAyy89DMMLYgAZVWMBAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=13994; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=XaRMg+f7cflBfn5wPAG2tP25rkrQhgvqHCAjcE8xvp4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnFlRvHmSBvZuTZqTJi5gj2TrqIHN6rd2MYN4z1
 Icy3IaHwi2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZxZUbwAKCRAEWL7uWMY5
 RjM0D/wMlfFYK81dKyh8ZIJykv0wj7O5hnlM8tZNe7s3nO8AZqlLmv5br2OeI3GLYuqxs5qkdjG
 G1KIHzzVfrkuQyNdAR98gzHkPjb1NTmD9Lpf1Fw9su34/hAKhz7/4nHJVg6MdjjhgGC85ijzXSX
 deiWKKiJGXJPyhjqE3VmRTaGBcVndzoaeeU/21uNyjHUb04tDX/Pz2zU56l78Ui+oZaVbPiV7g+
 0i6K8Fh7MBXHhhCKPAMnxhLS7RlcGDa6IJaud5N3MsNHtAgnfJvmVdYGqoGltqsecvEK/IXDsKv
 KJtcYBotG+7TqZX/lBGTstetc4WFBV5GrpE+v4T9GRzltPdMcnuLslOGx/VBWCQQtmQXQW9Q4+4
 Xu6gn9QmbS1hOUMnU/sNJ36U2ZXIZoRaYK3y+ASKpOJ8Pl5/EHKAA+OEWtTWd5TnJjJiI7j25mB
 CjIyMiHF44buK4l5KNamNFxn5DC6rUTkwvNClO09cEqthT8CWPH5vIPr/P9/gSnd284KB8Dgd1y
 DTGoBayvs31E/tQJxLrVeEJJgjbc1uEMROlBaRohVof5dFBcabchd8QBXrIfSmquJdVW0+lN1ov
 xDkDml+Ga6K7AMUySWAueArKimJ7MmZJ2OXqbqTS1zLt3OSjpIKD+HNWpECA6U9msj+Wt+w3BjW eae2gmPRJB4IV0w==
X-Mailer: b4 0.13.0
Message-ID: <20241021-static-mutex-v5-1-8d118a6a99b7@google.com>
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
spinlock. Optionally, the macro can generate a special LockedBy type
that does not require a runtime check.

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
- Adjust syntax as discussed in the last meeting.
- Fix various warnings.
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
 rust/kernel/sync/lock.rs        |  31 +++++-
 rust/kernel/sync/lock/global.rs | 234 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 265 insertions(+), 1 deletion(-)

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
index 90cc5416529b..9b3b401f3fcc 100644
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
@@ -124,6 +126,33 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
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
index 000000000000..803f19db4545
--- /dev/null
+++ b/rust/kernel/sync/lock/global.rs
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Support for defining statics containing locks.
+
+/// Defines a global lock.
+///
+/// The global mutex must be initialized before first use. Usually this is done by calling `init`
+/// in the module initializer.
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
+/// kernel::sync::global_lock! {
+///     // SAFETY: Initialized in module initializer before first use.
+///     unsafe(uninit) static MY_MUTEX: Mutex<(), Guard = MyGuard, LockedBy = LockedByMyMutex> = ();
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
+/// # }
+/// ```
+#[macro_export]
+macro_rules! global_lock {
+    {
+        $(#[$meta:meta])* $pub:vis
+        unsafe(uninit) static $name:ident: $kind:ident<$valuety:ty
+            $(, Guard = $guard:ident $(, LockedBy = $locked_by:ident)?)?
+        > = $value:expr;
+    } => {
+        $crate::macros::paste! {
+            #[allow(non_camel_case_types)]
+            type [< __static_lock_ty_ $name >] = $valuety;
+            #[allow(non_upper_case_globals)]
+            const [< __static_lock_init_ $name >]: [< __static_lock_ty_ $name >] = $value;
+
+            #[allow(dead_code, non_camel_case_types, non_snake_case, unreachable_pub)]
+            mod [< __static_lock_mod_ $name >] {
+                use super::[< __static_lock_ty_ $name >] as Val;
+                use super::[< __static_lock_init_ $name >] as INIT;
+                type Backend = $crate::global_lock_inner!(backend $kind);
+                type GuardTyp = $crate::global_lock_inner!(guard $kind, Val $(, $guard)?);
+
+                /// Wrapper type for a global lock.
+                pub struct [< __static_lock_wrapper_ $name >] {
+                    inner: $crate::sync::lock::Lock<Val, Backend>,
+                }
+
+                impl [< __static_lock_wrapper_ $name >] {
+                    /// # Safety
+                    ///
+                    /// Must be used to initialize `super::$name`.
+                    pub(super) const unsafe fn new() -> Self {
+                        let state = $crate::types::Opaque::uninit();
+                        Self {
+                            // SAFETY: The user of this macro promises to call `init` before calling
+                            // `lock`.
+                            inner: unsafe {
+                                $crate::sync::lock::Lock::global_lock_helper_new(state, INIT)
+                            }
+                        }
+                    }
+
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
+                                $crate::c_str!(::core::stringify!($name)),
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
+
+                    /// Lock this global lock.
+                    #[allow(clippy::needless_question_mark)]
+                    pub fn try_lock(&'static self) -> Option<GuardTyp> {
+                        Some($crate::global_lock_inner!(new_guard $($guard)? {
+                            self.inner.try_lock()?
+                        }))
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
+                $(
+                pub struct $locked_by<T: ?Sized>(::core::cell::UnsafeCell<T>);
+
+                // SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it
+                // protects can.
+                unsafe impl<T: ?Sized + Send> Send for $locked_by<T> {}
+
+                // SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
+                // data it protects is `Send`.
+                unsafe impl<T: ?Sized + Send> Sync for $locked_by<T> {}
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
+                )?)?
+            }
+
+            use [< __static_lock_mod_ $name >]::[< __static_lock_wrapper_ $name >];
+            $( $pub use [< __static_lock_mod_ $name >]::$guard;
+            $( $pub use [< __static_lock_mod_ $name >]::$locked_by; )?)?
+
+            $(#[$meta])*
+            #[allow(private_interfaces)]
+            $pub static $name: [< __static_lock_wrapper_ $name >] = {
+                // SAFETY: We are using this to initialize $name.
+                unsafe { [< __static_lock_wrapper_ $name >]::new() }
+            };
+        }
+    };
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
base-commit: 6ce162a002657910104c7a07fb50017681bc476c
change-id: 20240826-static-mutex-a4b228e0e6aa

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


