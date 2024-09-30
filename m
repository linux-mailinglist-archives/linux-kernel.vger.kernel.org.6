Return-Path: <linux-kernel+bounces-344088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC3F98A465
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03791C20363
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9204A18E77D;
	Mon, 30 Sep 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzNfrpbX"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C2C2AE8E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701889; cv=none; b=DYR1BpWDl51LaEIaAaL/Kq+mrrDTQwgavvpnBNK6LjHdz1tyKbE2c/iMI6khFRRJ9LQHordGZi1DPGV7fltrNChErWNzUWRNLc3ryqlt3xZzyge6S4i2OSdHBaqrTZ3XhBHU6aHhHAlcsUSbueRMYj1wmrpRc9Ncba9D5UuLswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701889; c=relaxed/simple;
	bh=ZHEs22Daz4QvKz5oScRejcETNm8btjOQRhWZT7jRSlY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JNhSvlpUh2rv0LtQUkR0KV5V6X2H/iMDywuNJLAef9KRP8cYZDsZ+VKCQ6iqr04g3k8CMZvxM4oTdDPtGmuHxkV3M25iMvAxQHDFLhr140fYAsa+dHXdeqis0GiB6phqDphhlKTvMn+AzQcydR1ckTZiWcrY12+gM3m6cBqPI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzNfrpbX; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-37cd08d3678so1931411f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727701885; x=1728306685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iJE1fIvCFAihx4BGzM30cPoK2UT1O6xOWdZusSBd04A=;
        b=dzNfrpbXULdwlDscB7qJNGUoKjj7Tc0tIgINM6tJugF/poK/zqYTCaQqIRaiy1zhNN
         FQIVQ7wCazhu8ETDdxAzF54CSog9QKs+FcjLG98OT7g2Ekgqx2bHDRApE4H7VZ7obuLy
         Wy+BGDbLIiCQ0PxrRxbnP9WLJwWYQmT89ivf4aW7vytWZ55s0jJiKaC1mbxASmXEetO5
         OQS71pHQjMuoIJLNpHc9sX4p57MCVY7wplwTeAHItGuDo3/ZKphpA02wIq0K6l4UvMn9
         Qgow6g1THVcIq7yAxcmGCeY09oQgEK38ef7/IuEUVntWWwp9fRoEI5kg+NVcyUDypZTl
         wA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701885; x=1728306685;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJE1fIvCFAihx4BGzM30cPoK2UT1O6xOWdZusSBd04A=;
        b=tNwmR3WR5SuPjFDrUnyyJTRsOhXbhusv0lg0kkKbMzkpxu4SwQ1qmHsNmn70fd+LnD
         UCrJo8srmEge4s0RnPI7bdeWbNZzIbiiMZsFMFQRYVuOAQ4QLbonbknrUFfUs6JLmmE3
         hG8RW0B/0kyICt3hHpfU6Yf8dxSQgGBEyGCS1ZgAy/ghLVY1FxSjsR1pge9ybjNGHV5T
         FjTyDANfPLBVdBqcTVhIHG4GczS8LBp9Q1/rtB0EV4ZsyHqXf6nWFgBZRA7bB/Q9Swlb
         nsch2LUm1G94UCOMY1aarvw3Gb2f58GU6s0PknUI5XQkKEcx6RJSCmQvAyh3UBAht4Jy
         PhnA==
X-Forwarded-Encrypted: i=1; AJvYcCWr46QSU7FyO4N8pukhoUv43dEsRnUT7b4/aOpMTcWdD1h1xzDZhn4UMcK95dZbgCHlJvwke6fcY/p9lVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1MPRJgKH32rURDp2hMFPABjOi1//Ncx0flga9jE28J36hkQ/
	iadCvrsdwf2VsYAoATasVd5avmH1asx9fdT6VqwcR7ZEQDWktYUnFm21XPmjzYkhkfAQ8111+co
	Br+mQx5ZNR6Mvdw==
X-Google-Smtp-Source: AGHT+IHjjMTKvCoZXwfBrE3INjvVX6XxDkAdS1/OATBrDw5jPUNsj9e0q/g1CLyKjtVozzC40lXn30IvdDZcHHY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5d:456e:0:b0:374:c359:a7e8 with SMTP id
 ffacd0b85a97d-37cd56d0359mr19675f8f.4.1727701884851; Mon, 30 Sep 2024
 06:11:24 -0700 (PDT)
Date: Mon, 30 Sep 2024 13:11:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHSj+mYC/3XMSw6CMBSF4a2Qjq3pvS0PHbkP46CFW2gi1lAkG
 MLeLUxUjMNzku+fWKDOUWDHZGIdDS44f4tD7RJWNvpWE3dV3AwFKlFgxkOve1fy9tHTyLUyiAU
 JyrRmkdw7sm5cc+dL3I0Lve+ea32A5f0TGoAD16CIckgzsPJUe19faV/6li2lAT91vtEYNeS2l GhQSIk/Wr71AcRGy6hTQ6YCMJWV5kvP8/wCM5bMICUBAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=14375; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ZHEs22Daz4QvKz5oScRejcETNm8btjOQRhWZT7jRSlY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm+qN1KbmW2M8KUzULnPkNmwD+8Sv1ikc3B1HrA
 ploDH1lk5SJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZvqjdQAKCRAEWL7uWMY5
 RkwNEACrldThw09M6MSHAwNcGk/JFDzIQ44FunY9DwaqxgWhzfXtUKC3pmnDh2W4e8mB0+HGsiw
 nPjQjkER/TN2Trb42ni8ASGCfvjoYc7ymMH6Bb5Zij+Yip6/A/mfg/kRq4+zSJ1J/+IG+ldW+89
 adBGwFVd8ggFu/od0aSd07fJaNmbriKVwqiXx5Ipu5nut5U+WSbgGBXpnXQm12sEb/oyb3yThm2
 a6JSut17X9m4r33QPyPkLgKCvP4O40RRjnzviKT7++Zcxpar5ZfvksoEwWJZOHOP3P/AxGssQUJ
 J8Gh+nAs/PV0UaXZSpivWEMgmNWdvkwfUiTtnhlHWqJjC+vonbJqGeIcciF0hVp3Rl8aFfKQBei
 I0IfnpOk/Z+tyoGf7+gjkKrZ0Unj+88Rs+7EHbL06w9wBzTbP3ho1NolhvkwTTbnbZxDXtJ3VHv
 ChzuJuwrvEI+yWo3pJgsBpmowhoryLitQjBiZBxEEH7Yf/WmWGe7bcV/iN2WmLbxWA9ddJaugXJ
 nulblZURj1CAiDfcqFOSqJArLiRxh4ufstpoL7xiudfJhjwkiGXsTTWDH2pfz1npIHdFBPwRgp9
 d8+5Lnrav7HZXBDEm2bulkMc+3O/CjiMJWwVg/I3xvyX8lU9ucSyYDpllSv/pngcgQ8a0bV5iTN upyfhfcH6YoFjvg==
X-Mailer: b4 0.13.0
Message-ID: <20240930-static-mutex-v4-1-c59555413127@google.com>
Subject: [PATCH v4] rust: add global lock support
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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
This patch is based on top of v6.12-rc1 with:
* https://lore.kernel.org/r/BL0PR02MB4914579914884B5D7473B3D6E96A2@BL0PR02MB4914.namprd02.prod.outlook.com
---
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
 rust/kernel/sync/lock.rs        |  31 ++++-
 rust/kernel/sync/lock/global.rs | 260 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 291 insertions(+), 1 deletion(-)

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
index 360d06e9c57a..528e885ee535 100644
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
index 000000000000..fc02fac864f6
--- /dev/null
+++ b/rust/kernel/sync/lock/global.rs
@@ -0,0 +1,260 @@
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
+/// # mod ex {
+/// # use kernel::prelude::*;
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
+/// # }
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
+            const [< __static_lock_init_ $name >]: [< __static_lock_ty_ $name >] = $value;
+
+            #[allow(unused_pub)]
+            mod [< __static_lock_mod_ $name >] {
+                use super::[< __static_lock_ty_ $name >] as Val;
+                use super::[< __static_lock_init_ $name >] as INIT;
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
+                            $crate::sync::lock::Lock::global_lock_helper_new(state, INIT)
+                        }
+                    }
+                }
+
+                /// Wrapper type for a global lock.
+                pub(crate) struct $wrapper {
+                    inner: $crate::sync::lock::Lock<Val, Backend>,
+                }
+
+                impl $wrapper {
+                    /// Initialize the global lock.
+                    ///
+                    /// # Safety
+                    ///
+                    /// This method must not be called more than once.
+                    pub(crate) unsafe fn init(&'static self) {
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
+                    pub(crate) fn lock(&'static self) -> GuardTyp {
+                        $crate::global_lock_inner!(new_guard $($guard)? {
+                            self.inner.lock()
+                        })
+                    }
+
+                    /// Lock this global lock.
+                    pub(crate) fn try_lock(&'static self) -> Option<GuardTyp> {
+                        Some($crate::global_lock_inner!(new_guard $($guard)? {
+                            self.inner.try_lock()?
+                        }))
+                    }
+                }
+
+                $(
+                pub(crate) struct $guard($crate::sync::lock::Guard<'static, Val, Backend>);
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
+                pub(crate) struct $locked_by<T: ?Sized>(::core::cell::UnsafeCell<T>);
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
+                    pub(crate) fn new(val: T) -> Self {
+                        Self(::core::cell::UnsafeCell::new(val))
+                    }
+                }
+
+                impl<T: ?Sized> $locked_by<T> {
+                    pub(crate) fn as_ref<'a>(&'a self, _guard: &'a $guard) -> &'a T {
+                        // SAFETY: The lock is globally unique, so there can only be one guard.
+                        unsafe { &*self.0.get() }
+                    }
+
+                    pub(crate) fn as_mut<'a>(&'a self, _guard: &'a mut $guard) -> &'a mut T {
+                        // SAFETY: The lock is globally unique, so there can only be one guard.
+                        unsafe { &mut *self.0.get() }
+                    }
+
+                    pub(crate) fn get_mut(&mut self) -> &mut T {
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
base-commit: e2bde5e2cb2e5b8dca87adce3a9eb605133518ea
change-id: 20240826-static-mutex-a4b228e0e6aa

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


