Return-Path: <linux-kernel+bounces-413235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3C9D156A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 853CDB2812C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2121C07FB;
	Mon, 18 Nov 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+jEVBZs"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8F1AA1E4;
	Mon, 18 Nov 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947625; cv=none; b=OL35xOXfSL+B0gtRnKVMpEHXuK9uaEblUEZDV4teRyklm462DZiU0lW4nzyMoy2PWLg2XcQUpPWDKCbufQXpU/zMurXbUjPsQwhNCaxYcDaEYQzfSCKMEsyWgFtRLy7dPE7RDBuc92NCcWTzUNqYU4omr7m5rFiS3Ab+NFcxQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947625; c=relaxed/simple;
	bh=ao3fE1v3Es8wbsK70pffnsyX6XbQejOAvUq6ZdKLwic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L65LFB29LdRyxbPZ7ZZKOzqn0RkmMSizG3zjhlHPyd2kxO+KJ9PkMR+5Hqqb0piiT5NOChsOdJ2IOOv5UcJaoF89szEZdnh4OVaEis7f4cimJx5o7/D+Ga5rMYCdEpmGcNQroC75gK7EhPU1JCFawDlupH1oDShU+jqnbxsuC4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+jEVBZs; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b155cca097so348773485a.1;
        Mon, 18 Nov 2024 08:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947623; x=1732552423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OI/Vbp8mSo4ofxLsmovxpUuq0DC2nV/n/PmaGgBezds=;
        b=b+jEVBZsX6rUFZV3MdDc2uc8TFHicUZJUJZmIqiBvW0dApWd7gI3P1HBVbjg7X9YqT
         eXe/ZGsmbiiM3g28hdruT69BsnLw/Xf7pHlTzBwG/1REqeQHFG+tDcK2TvvBQ2cFZkEn
         IQhlwW5Z44YPIp7Y4354Em57HvYoe5APRhRjxecyGxuEPaCVGkMOswmtBv2BPFGt4xxl
         mZHiFZi9wd2z0HJWKmt6S3ada0+Wnt/7IOBBaxqhtIPzxATJXQgDVux7+h2v++VzyyZE
         KdoHnrrwMYB7pzdbWH5/mCYYd4JjHLaboQ57QO1utFbbCjmGYFDRLOG49LPIOQyZ5xn6
         RVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947623; x=1732552423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OI/Vbp8mSo4ofxLsmovxpUuq0DC2nV/n/PmaGgBezds=;
        b=idrLIwF8Q/AsDbZar1DP5vV4qHY7vELGNerRjhsvJ/fvmPBN6WuW8q9t5YEuZzUjD5
         y7Zh7jxyWiJ1CWkJFi0/K3Zl+jSCChJJoaUfwwfgbJ0cXgdA4k3OPkRtpNWNbJ34Y7/D
         A0aKBXS3q5XC8o3HL3YgE4BWBp0+d/NtsqL5unZrqt593q73euZwgCsZp0FcZNLYd/t6
         vHzWp2myyhLa4zV1jghRwObX4Kyk4YdTXKWrYZfRlq66WWiXkKPzPrMo9kTPV7i2OqrA
         1uLg+bedYTdXhtWiLlLL+ahQkd35RuGDm+EuTKxrUIqKI0hvgu/89cLixWpBEYty4wU/
         jWzA==
X-Forwarded-Encrypted: i=1; AJvYcCUqqxLTpOhD1nLeg3fDQbPoGX2DfdNe3bhOTSDa3HE7zfDqTZLAKcM+OFWRnKHWE9j64L4QGQyykWcu/YA=@vger.kernel.org, AJvYcCX1I0oW3iFpLtDUz5GEDV2rrWbLUzwDYhXCyPcLBcj0xCyVAUqZ1SPUzB4R3vHWLmdm3oScGCAc2mJfm3+0t2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoea0a8FVBeIndtnWMi/iu7k1lD9Dx0DhGy5fEyR5A90Tp6OW
	ZGesaq/xZDySGJv7XodED/gl8ZvaPZfh4qHbp/WVT+GfRGOzEzKD
X-Google-Smtp-Source: AGHT+IF6UVZ+mIvzX3Q9RTNdRv24CPT7dF0GZ77iNzACqXduAfs2KhXhYMHsjQ8ELd1SVW5URIKB1w==
X-Received: by 2002:a05:620a:4087:b0:7a6:601c:c827 with SMTP id af79cd13be357-7b3620205ddmr2006803785a.27.1731947622510;
        Mon, 18 Nov 2024 08:33:42 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:35ca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a8a9fdesm1804185a.124.2024.11.18.08.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 08:33:42 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 18 Nov 2024 11:33:36 -0500
Subject: [PATCH v9 2/2] rust: xarray: Add an abstraction for XArray
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-rust-xarray-bindings-v9-2-3219cdb53685@gmail.com>
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
In-Reply-To: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

`XArray` is an efficient sparse array of pointers. Add a Rust
abstraction for this type.

This implementation bounds the element type on `ForeignOwnable` and
requires explicit locking for all operations. Future work may leverage
RCU to enable lockless operation.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/xarray.c           |  28 +++++
 rust/kernel/alloc.rs            |   5 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/xarray.rs           | 259 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 300 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a80783fcbe042a28124620ce4710ed5bdc2d0790..131ed24629c7411419c99ebd01727fd17ee4f802 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
@@ -33,3 +34,8 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
 const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
+
+const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
+
+const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
+const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 20a0c69d5cc7b8775f505f94d06d06379a4583b0..22c3c9fb6298b0a3b59b1290976e927ef0bc9b8e 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -25,3 +25,4 @@
 #include "vmalloc.c"
 #include "wait.c"
 #include "workqueue.c"
+#include "xarray.c"
diff --git a/rust/helpers/xarray.c b/rust/helpers/xarray.c
new file mode 100644
index 0000000000000000000000000000000000000000..60b299f11451d2c4a75e50e25dec4dac13f143f4
--- /dev/null
+++ b/rust/helpers/xarray.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/xarray.h>
+
+int rust_helper_xa_err(void *entry)
+{
+	return xa_err(entry);
+}
+
+void rust_helper_xa_init_flags(struct xarray *xa, gfp_t flags)
+{
+	return xa_init_flags(xa, flags);
+}
+
+int rust_helper_xa_trylock(struct xarray *xa)
+{
+	return xa_trylock(xa);
+}
+
+void rust_helper_xa_lock(struct xarray *xa)
+{
+	return xa_lock(xa);
+}
+
+void rust_helper_xa_unlock(struct xarray *xa)
+{
+	return xa_unlock(xa);
+}
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index f2f7f3a53d298cf899e062346202ba3285ce3676..be9f164ece2e0fe71143e0201247d2b70c193c51 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -39,6 +39,11 @@
 pub struct Flags(u32);
 
 impl Flags {
+    /// Get a flags value with all bits unset.
+    pub fn empty() -> Self {
+        Self(0)
+    }
+
     /// Get the raw representation of this flag.
     pub(crate) fn as_raw(self) -> u32 {
         self.0
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index bf8d7f841f9425d19a24f3910929839cfe705c7f..6f301ad7f6fbc57b09dcd6a6e90bd87f29df948f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -60,6 +60,7 @@
 pub mod types;
 pub mod uaccess;
 pub mod workqueue;
+pub mod xarray;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
new file mode 100644
index 0000000000000000000000000000000000000000..57dbdb0a82623e3de779e26525e7dd27ce4db712
--- /dev/null
+++ b/rust/kernel/xarray.rs
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! XArray abstraction.
+//!
+//! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
+
+use core::pin::Pin;
+
+use crate::{
+    alloc, bindings, build_assert, build_error,
+    error::{Error, Result},
+    init::PinInit,
+    pin_init,
+    types::{ForeignOwnable, Opaque},
+};
+use core::{iter, marker::PhantomData, mem};
+use macros::{pin_data, pinned_drop};
+
+/// An array which efficiently maps sparse integer indices to owned objects.
+///
+/// This is similar to a [`crate::alloc::kvec::Vec<Option<T>>`], but more efficient when there are
+/// holes in the index space, and can be efficiently grown.
+///
+/// # Invariants
+///
+/// `self.xa` is always an initialized and valid [`bindings::xarray`] whose entries are either
+/// `XA_ZERO_ENTRY` or came from `T::into_foreign`.
+///
+/// # Examples
+///
+/// ```rust
+/// use kernel::alloc::KBox;
+/// use kernel::xarray::{AllocKind, XArray};
+///
+/// let xa = KBox::pin_init(XArray::new(AllocKind::Alloc1), GFP_KERNEL)?;
+///
+/// let dead = KBox::new(0xdead, GFP_KERNEL)?;
+/// let beef = KBox::new(0xbeef, GFP_KERNEL)?;
+///
+/// let mut guard = xa.lock();
+///
+/// assert_eq!(guard.get(0), None);
+///
+/// assert_eq!(guard.store(0, dead, GFP_KERNEL).unwrap().as_deref(), None);
+/// assert_eq!(guard.get(0).copied(), Some(0xdead));
+///
+/// *guard.get_mut(0).unwrap() = 0xffff;
+/// assert_eq!(guard.get(0).copied(), Some(0xffff));
+///
+/// assert_eq!(guard.store(0, beef, GFP_KERNEL).unwrap().as_deref().copied(), Some(0xffff));
+/// assert_eq!(guard.get(0).copied(), Some(0xbeef));
+///
+/// guard.remove(0);
+/// assert_eq!(guard.get(0), None);
+///
+/// # Ok::<(), Error>(())
+/// ```
+#[pin_data(PinnedDrop)]
+pub struct XArray<T: ForeignOwnable> {
+    #[pin]
+    xa: Opaque<bindings::xarray>,
+    _p: PhantomData<T>,
+}
+
+#[pinned_drop]
+impl<T: ForeignOwnable> PinnedDrop for XArray<T> {
+    fn drop(self: Pin<&mut Self>) {
+        self.iter().for_each(|ptr| {
+            let ptr = ptr.as_ptr();
+            // SAFETY: `ptr` came from `T::into_foreign`.
+            //
+            // INVARIANT: we own the only reference to the array which is being dropped so the
+            // broken invariant is not observable on function exit.
+            drop(unsafe { T::from_foreign(ptr) })
+        });
+
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        unsafe { bindings::xa_destroy(self.xa.get()) };
+    }
+}
+
+/// Flags passed to [`XArray::new`] to configure the array's allocation tracking behavior.
+pub enum AllocKind {
+    /// Consider the first element to be at index 0.
+    Alloc,
+    /// Consider the first element to be at index 1.
+    Alloc1,
+}
+
+impl<T: ForeignOwnable> XArray<T> {
+    /// Creates a new [`XArray`].
+    pub fn new(kind: AllocKind) -> impl PinInit<Self> {
+        let flags = match kind {
+            AllocKind::Alloc => bindings::XA_FLAGS_ALLOC,
+            AllocKind::Alloc1 => bindings::XA_FLAGS_ALLOC1,
+        };
+        pin_init!(Self {
+            // SAFETY: `xa` is valid while the closure is called.
+            xa <- Opaque::ffi_init(|xa| unsafe {
+                bindings::xa_init_flags(xa, flags)
+            }),
+            _p: PhantomData,
+        })
+    }
+
+    fn iter(&self) -> impl Iterator<Item = core::ptr::NonNull<T::PointedTo>> + '_ {
+        // TODO: Remove when https://lore.kernel.org/all/20240913213041.395655-5-gary@garyguo.net/ is applied.
+        const MIN: core::ffi::c_ulong = core::ffi::c_ulong::MIN;
+        const MAX: core::ffi::c_ulong = core::ffi::c_ulong::MAX;
+
+        let mut index = MIN;
+
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        iter::once(unsafe {
+            bindings::xa_find(self.xa.get(), &mut index, MAX, bindings::XA_PRESENT)
+        })
+        .chain(iter::from_fn(move || {
+            // SAFETY: `self.xa` is always valid by the type invariant.
+            Some(unsafe {
+                bindings::xa_find_after(self.xa.get(), &mut index, MAX, bindings::XA_PRESENT)
+            })
+        }))
+        .map_while(|ptr| core::ptr::NonNull::new(ptr.cast()))
+    }
+
+    /// Attempts to lock the [`XArray`] for exclusive access.
+    pub fn try_lock(&self) -> Option<Guard<'_, T>> {
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        (unsafe { bindings::xa_trylock(self.xa.get()) } != 0).then(|| Guard { xa: self })
+    }
+
+    /// Locks the [`XArray`] for exclusive access.
+    pub fn lock(&self) -> Guard<'_, T> {
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        unsafe { bindings::xa_lock(self.xa.get()) };
+
+        Guard { xa: self }
+    }
+}
+
+/// A lock guard.
+///
+/// The lock is unlocked when the guard goes out of scope.
+#[must_use = "the lock unlocks immediately when the guard is unused"]
+pub struct Guard<'a, T: ForeignOwnable> {
+    xa: &'a XArray<T>,
+}
+
+impl<T: ForeignOwnable> Drop for Guard<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY: `self.xa.xa` is always valid by the type invariant.
+        //
+        // SAFETY: The caller holds the lock, so it is safe to unlock it.
+        unsafe { bindings::xa_unlock(self.xa.xa.get()) };
+    }
+}
+
+// TODO: Remove when https://lore.kernel.org/all/20240913213041.395655-5-gary@garyguo.net/ is applied.
+fn to_index(i: usize) -> core::ffi::c_ulong {
+    i.try_into()
+        .unwrap_or_else(|_| build_error!("cannot convert usize to c_ulong"))
+}
+
+impl<'a, T: ForeignOwnable> Guard<'a, T> {
+    fn load<F, U>(&mut self, index: usize, f: F) -> Option<U>
+    where
+        F: FnOnce(core::ptr::NonNull<T::PointedTo>) -> U,
+    {
+        // SAFETY: `self.xa.xa` is always valid by the type invariant.
+        let ptr = unsafe { bindings::xa_load(self.xa.xa.get(), to_index(index)) };
+        let ptr = core::ptr::NonNull::new(ptr.cast())?;
+        Some(f(ptr))
+    }
+
+    /// Loads an entry from the array.
+    ///
+    /// Returns the entry at the given index.
+    pub fn get(&mut self, index: usize) -> Option<T::Borrowed<'_>> {
+        self.load(index, |ptr| {
+            // SAFETY: `ptr` came from `T::into_foreign`.
+            unsafe { T::borrow(ptr.as_ptr()) }
+        })
+    }
+
+    /// Loads an entry from the array.
+    ///
+    /// Returns the entry at the given index.
+    pub fn get_mut(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
+        self.load(index, |ptr| {
+            // SAFETY: `ptr` came from `T::into_foreign`.
+            unsafe { T::borrow_mut(ptr.as_ptr()) }
+        })
+    }
+
+    /// Erases an entry from the array.
+    ///
+    /// Returns the entry which was previously at the given index.
+    pub fn remove(&mut self, index: usize) -> Option<T> {
+        // SAFETY: `self.xa.xa` is always valid by the type invariant.
+        //
+        // SAFETY: The caller holds the lock.
+        let ptr = unsafe { bindings::__xa_erase(self.xa.xa.get(), to_index(index)) }.cast();
+        // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.
+        unsafe { T::try_from_foreign(ptr) }
+    }
+
+    /// Stores an entry in the array.
+    ///
+    /// On success, returns the entry which was previously at the given index.
+    ///
+    /// On failure, returns the entry which was attempted to be stored.
+    pub fn store(
+        &mut self,
+        index: usize,
+        value: T,
+        gfp: alloc::Flags,
+    ) -> Result<Option<T>, (T, Error)> {
+        build_assert!(
+            mem::align_of::<T::PointedTo>() >= 4,
+            "pointers stored in XArray must be 4-byte aligned"
+        );
+        let new = value.into_foreign();
+
+        let old = {
+            let new = new.cast();
+            // SAFETY: `self.xa.xa` is always valid by the type invariant.
+            //
+            // SAFETY: The caller holds the lock.
+            //
+            // INVARIANT: `new` came from `T::into_foreign`.
+            unsafe { bindings::__xa_store(self.xa.xa.get(), to_index(index), new, gfp.as_raw()) }
+        };
+
+        // SAFETY: `__xa_store` returns the old entry at this index on success or `xa_err` if an
+        // error happened.
+        match unsafe { bindings::xa_err(old) } {
+            0 => {
+                let old = old.cast();
+                // SAFETY: `ptr` is either NULL or came from `T::into_foreign`.
+                Ok(unsafe { T::try_from_foreign(old) })
+            }
+            errno => {
+                // SAFETY: `new` came from `T::into_foreign` and `__xa_store` does not take
+                // ownership of the value on error.
+                let value = unsafe { T::from_foreign(new) };
+                Err((value, Error::from_errno(errno)))
+            }
+        }
+    }
+}
+
+// SAFETY: It is safe to send `XArray<T>` to another thread when the underlying `T` is `Send`
+// because XArray is thread-safe and all mutation operations are synchronized.
+unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
+
+// SAFETY: It is safe to send `&XArray<T>` to another thread when the underlying `T` is `Sync`
+// because it effectively means sharing `&T` (which is safe because `T` is `Sync`). Additionally,
+// `T` is `Send` because XArray is thread-safe and all mutation operations are internally locked.
+unsafe impl<T: ForeignOwnable + Send + Sync> Sync for XArray<T> {}

-- 
2.47.0


