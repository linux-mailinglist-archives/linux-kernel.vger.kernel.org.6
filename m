Return-Path: <linux-kernel+bounces-415691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0469D39EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09134B29D41
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DCE1AB512;
	Wed, 20 Nov 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fal/AOzj"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD21A2C0E;
	Wed, 20 Nov 2024 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103306; cv=none; b=u6Ok5baCvS7o90b5GL6g+i6Wxga2imTNJNfZ8hDFmgvmjxQp/oB38A0uz52Y6gtfWSWBUlDXIN7u4bk7HngcTrg9hpshesGKOtWJ2NUeFVLeL5n3N54/UN+x23XUyzwR3ZSmQv9hNudNSjLu2usKU7cO+DEBtWZIhSVrNAzn1L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103306; c=relaxed/simple;
	bh=k0hWV6S9VV5ItwA9j1d+Sc4EUf5RLbdYOWfq/0sNAI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UEC/srdvEWary4u8KvdqsRLKKhsfe2BdaaZz1mmuw67fsdPJLY+mSt456hzX7HULRU31ZUc1SvZiBawCxhximDEP5rDhob/d7VkuAQdfgR2wrI81VmhEiazdHnmZD2HFU57hrnMcoX3TZLRI10gHxwul4Fl1+NigOk4IRyOT82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fal/AOzj; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b13ff3141aso432035885a.1;
        Wed, 20 Nov 2024 03:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103303; x=1732708103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ymy+PnTjcAKXJVO48YP5fGXzjUSaR1W9jpd/XF6yMgw=;
        b=fal/AOzjTsb+0obYMZ0RwpgOlF5lpprbiNC6sV5L42yM7kpG991Q+VqUviWOXSuvh8
         z52wItspQ6IoxhWnqT0E9vwKHHjZc/uJKHPRzDGdjuzRFKkftY41Ri/1zRW2RBIV/72k
         N0GfR0Tv7qiz3307CStrC8WTOqo6k5ABBM4bRYOHyhxIyJk7whJNWvBoJB8z8+7WGvHc
         VNx7CkmHZIEdNRhuxen5KOLQ1Hl82UJpP6cV2vzkYMqbVwkiS5sY2nNb3AZ4KP+IevxH
         u/rIDoSeHjorWlooTcvCV3V004t9N0G7v80TdRti/8s+eqBAZzPngvnfxWtkR5iT9Jwg
         C4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103303; x=1732708103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ymy+PnTjcAKXJVO48YP5fGXzjUSaR1W9jpd/XF6yMgw=;
        b=sHPUaCTXMit1dahhpSUhuOEiXY7LO65ULxIsYQUq9wyqv5DLEqp9DVN12tvs8YE7MM
         kSx1XRjIuEZHXeH1eGDpp1X+IUXdx7+HdXUn1XHV8NS5bsXvx0X8Qe+5pLtOK/XAAK6V
         MULhaqsiuCP7OxWUsw2nKJxbkI8qKw1F2iWAx+Vb21vKKQv/Sh7uNuY1RdJhhMQ2w6r+
         ITHoqZ8prQtJjfc5JYzMQzBPP2WjgNRnR/872euHBjOvZWopGOpAmuZE77I+Swb4gu+N
         b8+fmT2tIfEtzU49ldKI1AmudAq3ugb/heBc4lnz5n+Wdta6Dxo7ybD5iNOwmUrEBAkF
         +Z1g==
X-Forwarded-Encrypted: i=1; AJvYcCVXtWMgxALW6XSVrYj1aLDwMyumc68Q5Aum5+MxoOvdKhO0b4/KNCfjgtk99DDMGsLv6Pi0ssXM60BOmT7ym3E=@vger.kernel.org, AJvYcCVoez9CKH2XWiJUx6qQ2RDDKUtdDuFNfFmZbbMrPoWRMBFcoeMiwMCM488CQWs/EORP2wTCFR3lIkZqoNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqYgyyhkSe+L01N511ww/6Vo44U93FMYeEnLJ2PuBumTZR0sM
	NDOhn0l06kfNzULmTGXc50cwnyClWCqz7imw2RKiBUAFZOuS7evj
X-Google-Smtp-Source: AGHT+IEXWURCfzTr7f2pMRarVxO3+n7aE2dTfbjRwLY/JeXcUDJRWOb3a7XLvuMjgmLsiSvrYNXDYw==
X-Received: by 2002:a05:620a:720d:b0:7b1:1d91:5cf1 with SMTP id af79cd13be357-7b42edad2e1mr286650285a.1.1732103303414;
        Wed, 20 Nov 2024 03:48:23 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2600:4041:5be7:7c00:8dca:61d2:c8fb:a544])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b479d46e3esm85640885a.29.2024.11.20.03.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:48:22 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 20 Nov 2024 06:48:18 -0500
Subject: [PATCH v10 2/2] rust: xarray: Add an abstraction for XArray
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-rust-xarray-bindings-v10-2-a25b2b0bf582@gmail.com>
References: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
In-Reply-To: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
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

Inspired-by: Maíra Canal <mcanal@igalia.com>
Inspired-by: Asahi Lina <lina@asahilina.net>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/xarray.c           |  28 +++++
 rust/kernel/alloc.rs            |   5 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/xarray.rs           | 266 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 307 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5c4dfe22f41a5a106330e8c43ffbd342c69c4e0b..9f39d673b240281aed2759b5bd076aa43fb54951 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -30,6 +30,7 @@
 #include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 #include <trace/events/rust_sample.h>
 
 /* `bindgen` gets confused at certain things. */
@@ -43,3 +44,8 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
 const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
+
+const xa_mark_t RUST_CONST_HELPER_XA_PRESENT = XA_PRESENT;
+
+const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC = XA_FLAGS_ALLOC;
+const gfp_t RUST_CONST_HELPER_XA_FLAGS_ALLOC1 = XA_FLAGS_ALLOC1;
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index dcf827a61b52e71e46fd5378878602eef5e538b6..ff28340e78c53c79baf18e2927cc90350d8ab513 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -30,3 +30,4 @@
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
index e1065a7551a39e68d6379031d80d4be336e652a3..9ca524b15920c525c7db419e60dec4c43522751d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -68,6 +68,7 @@
 pub mod types;
 pub mod uaccess;
 pub mod workqueue;
+pub mod xarray;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
new file mode 100644
index 0000000000000000000000000000000000000000..acbac787dc9a38684538697d53f590880fa9903a
--- /dev/null
+++ b/rust/kernel/xarray.rs
@@ -0,0 +1,266 @@
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
+    types::{ForeignOwnable, NotThreadSafe, Opaque},
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
+        (unsafe { bindings::xa_trylock(self.xa.get()) } != 0).then(|| Guard {
+            xa: self,
+            _not_send: NotThreadSafe,
+        })
+    }
+
+    /// Locks the [`XArray`] for exclusive access.
+    pub fn lock(&self) -> Guard<'_, T> {
+        // SAFETY: `self.xa` is always valid by the type invariant.
+        unsafe { bindings::xa_lock(self.xa.get()) };
+
+        Guard {
+            xa: self,
+            _not_send: NotThreadSafe,
+        }
+    }
+}
+
+/// A lock guard.
+///
+/// The lock is unlocked when the guard goes out of scope.
+#[must_use = "the lock unlocks immediately when the guard is unused"]
+pub struct Guard<'a, T: ForeignOwnable> {
+    xa: &'a XArray<T>,
+    _not_send: NotThreadSafe,
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
+    fn load<F, U>(&self, index: usize, f: F) -> Option<U>
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
+    pub fn get(&self, index: usize) -> Option<T::Borrowed<'_>> {
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


