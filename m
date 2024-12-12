Return-Path: <linux-kernel+bounces-443917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD7D9EFD7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7EC289E18
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8A41BBBDC;
	Thu, 12 Dec 2024 20:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9H4p4uJ"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9FE1B4154;
	Thu, 12 Dec 2024 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734035511; cv=none; b=Ozx9EwHPbVwqbftqHBg6MYcE89ORiBDVpNyCb0FJFYEl1OQ2eSBQ5UV5o3z3WcSkljFvorvuKrO7VCpHgaEDh/2hg8A6bEh54Piqz9vFuTNmNjJ9wRD3KzuIQ6hd1BlTQMQotndYCiXygDGlSm64wHhokwTAEIq5Gmu4/SzlfFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734035511; c=relaxed/simple;
	bh=emWnRxv6Ok494VbHSy0uuia6zquehlprpwu+SdBFS7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HhTq/kJZiy+NWEoagmaPjenJvC3WWMoE25tcEAelH7uTKzk82wdIkDPYnt+vj3fnw53lvl1Sm5CVJNZBkC3/G9eH/o+s6ONraRcxifFB+Ws1yK7fdUuGWrf1hxH9lAAvJILW6ADpsZ/kQdW3WoS6AawC/m+ZDFzAkxhGd9tBWeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9H4p4uJ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b15467f383so97136685a.3;
        Thu, 12 Dec 2024 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734035508; x=1734640308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPztbWHmriQ8XPesq0oWsgCySmgU6UcnUSFfe76LgSk=;
        b=e9H4p4uJKQvBUsnvmQHc4ViLykDsVUYsRpGCj4uGHsdRCLUFkKbczMih+TPgwmQaV3
         Z7dLF3MmZqqjcpBGiloHm9DEI7Ou4DUutOGepPDwSEldgrwp1HgBPZ7VAMIdTq0Po2Vz
         jNDNMhiZ6UeUW+ybB+uDOrH0rrmMJcb22W321SEC7ozPVCQXqrIunlmV+PCd+GmPH8kc
         79vVX2hBtsIFEVpNdrUjhprSMSfUF5YEcGboUTVvPvwl1QFldwG8Oyq8AjiF1JJaGZ59
         u+uu1VK16g5iu9CncyiB+BNDSgwyj+fY3nNI6iMgLrzyZzhZgt3tK/KvNFN93MuDO7sL
         rKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734035508; x=1734640308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPztbWHmriQ8XPesq0oWsgCySmgU6UcnUSFfe76LgSk=;
        b=Y5kCMa3yTv8ekUTnX+xh6BxX999sps14qpBgaxvFJpMBo37zGEkr9XRWnKP8ySjXTI
         3Pc202NvtO6u/ZY+w3Een45a7IZmGQhhb5T7XA5SNKjITm4R5Wp0QpCDwM691bMPSJSH
         lMPFnxETZlvJOSpw7wkLOSEZFVTwffV4Y/biLXKYjr0IplSgCImUG4KIZ8POhQA2CHGC
         Lrc9fWuIVi6305wm5ZCKdCVRGuR6R17uCTX88KJ6Ug/JDj7j6HfUQ7V2T1gu90I0UX6I
         p9oJAulXHpo4QV1O3YkiyYsfehEqMsKmFWzBSU1gmpQYCnaMz5mz6cFFkLDSgfc6Hy83
         OlIg==
X-Forwarded-Encrypted: i=1; AJvYcCVz+0/I7Ma6O287brFw/ZBiL1YUzig4pbijAbJSe0BKSzYdmXhoAx3eASlWs7GjxtQb95sra3DOUwbsf+tLE/c=@vger.kernel.org, AJvYcCW2DVFdr3Xh0NKRFo8LI+xtFoWuUWEveEsdbh6VdmxbpBH/+3KYj2m6HfQW8hcj1hklVFhD9CiB2vIvsuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa7XA9MUbUXGALTm7QrcbwdveduNlrWFvQPmj5A66xsrFOWtQY
	BqRYl9GhyJ3FdTSDnEmYVPWY2vaeBk7vraFDYnHUDLRddPWHV8jJ
X-Gm-Gg: ASbGncuMyS3gUGa86E6++rTac+eeo166JUbGrgEmYPXgMoBwjquYlq/qNqUWbj7IQgq
	gJXnFl0d340Yp2aZZBWdNGk2VK2KoBhpjo1PaSSHgDI1U3GuWRmhTzu133Y+EtFp11VEIUSswm0
	lwpbCj3r0iY1NlhzJFeUYLss8zrcBj3jh++dbgjolghw1vEXqMD2T6Jv6octsm+s19ORyUp6OEx
	PkEmktYMHSWnJ1smww9qZ5rZBzYdUq9Y8M+E83z17jbWaxKo1I80eEG/hk30EXK/nPF7khQequq
	DMvvJx8drgbrWq75pyQbICf09oS2Dy1mo3f+YOqPovkq0wCkfe5aY+RinVDV
X-Google-Smtp-Source: AGHT+IG/kSKnYQ3x/n8X7Pm6ZNt57XPtTAx+HBS769AvRa8UXSeZEMNhNmoQVwo+dpYoQ71hCGC19Q==
X-Received: by 2002:a05:620a:1929:b0:7b6:73de:f340 with SMTP id af79cd13be357-7b6f88d5f63mr266561885a.12.1734035508234;
        Thu, 12 Dec 2024 12:31:48 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:77da])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6db04175bsm359894485a.52.2024.12.12.12.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 12:31:47 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 12 Dec 2024 15:31:37 -0500
Subject: [PATCH v12 2/2] rust: xarray: Add an abstraction for XArray
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241212-rust-xarray-bindings-v12-2-59ab9b1f4d2e@gmail.com>
References: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
In-Reply-To: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
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
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/xarray.c           |  28 ++++
 rust/kernel/alloc.rs            |   5 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/xarray.rs           | 287 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 328 insertions(+)

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
index 0000000000000000000000000000000000000000..d21b5221f772d16c225cad0ed3cc9aa25d34fd90
--- /dev/null
+++ b/rust/kernel/xarray.rs
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! XArray abstraction.
+//!
+//! C header: [`include/linux/xarray.h`](srctree/include/linux/xarray.h)
+
+use crate::{
+    alloc, bindings, build_assert, build_error,
+    error::{Error, Result},
+    init::PinInit,
+    pin_init,
+    types::{ForeignOwnable, NotThreadSafe, Opaque},
+};
+use core::{iter, marker::PhantomData, mem, pin::Pin, ptr::NonNull};
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
+/// assert_eq!(guard.store(0, dead, GFP_KERNEL)?.as_deref(), None);
+/// assert_eq!(guard.get(0).copied(), Some(0xdead));
+///
+/// *guard.get_mut(0).unwrap() = 0xffff;
+/// assert_eq!(guard.get(0).copied(), Some(0xffff));
+///
+/// assert_eq!(guard.store(0, beef, GFP_KERNEL)?.as_deref().copied(), Some(0xffff));
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
+    fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
+        // TODO: Remove and use usize::MAX when
+        // https://lore.kernel.org/all/20240913213041.395655-5-gary@garyguo.net/ is applied.
+        const MAX: crate::ffi::c_ulong = crate::ffi::c_ulong::MAX;
+
+        let mut index = 0;
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
+        .map_while(|ptr| NonNull::new(ptr.cast()))
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
+        // SAFETY:
+        // - `self.xa.xa` is always valid by the type invariant.
+        // - The caller holds the lock, so it is safe to unlock it.
+        unsafe { bindings::xa_unlock(self.xa.xa.get()) };
+    }
+}
+
+// TODO: Remove when https://lore.kernel.org/all/20240913213041.395655-5-gary@garyguo.net/ is applied.
+fn to_index(i: usize) -> crate::ffi::c_ulong {
+    i.try_into()
+        .unwrap_or_else(|_| build_error!("cannot convert usize to c_ulong"))
+}
+
+/// The error returned by [`store`](Guard::store).
+///
+/// Contains the underlying error and the value that was not stored.
+pub struct StoreError<T> {
+    /// The error that occurred.
+    pub error: Error,
+    /// The value that was not stored.
+    pub value: T,
+}
+
+impl<T> From<StoreError<T>> for Error {
+    fn from(value: StoreError<T>) -> Self {
+        let StoreError { error, value: _ } = value;
+        error
+    }
+}
+
+impl<'a, T: ForeignOwnable> Guard<'a, T> {
+    fn load<F, U>(&self, index: usize, f: F) -> Option<U>
+    where
+        F: FnOnce(NonNull<T::PointedTo>) -> U,
+    {
+        // SAFETY: `self.xa.xa` is always valid by the type invariant.
+        let ptr = unsafe { bindings::xa_load(self.xa.xa.get(), to_index(index)) };
+        let ptr = NonNull::new(ptr.cast())?;
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
+    /// May drop the lock if needed to allocate memory, and then reacquire it afterwards.
+    ///
+    /// On success, returns the entry which was previously at the given index.
+    ///
+    /// On failure, returns the entry which was attempted to be stored.
+    pub fn store(
+        &mut self,
+        index: usize,
+        value: T,
+        gfp: alloc::Flags,
+    ) -> Result<Option<T>, StoreError<T>> {
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
+                //
+                // NB: `XA_ZERO_ENTRY` is never returned by functions belonging to the Normal XArray
+                // API; such entries present as `NULL`.
+                Ok(unsafe { T::try_from_foreign(old) })
+            }
+            errno => {
+                // SAFETY: `new` came from `T::into_foreign` and `__xa_store` does not take
+                // ownership of the value on error.
+                let value = unsafe { T::from_foreign(new) };
+                Err(StoreError {
+                    value,
+                    error: Error::from_errno(errno),
+                })
+            }
+        }
+    }
+}
+
+// SAFETY: `XArray<T>` has no shared mutable state so it is `Send` iff `T` is `Send`.
+unsafe impl<T: ForeignOwnable + Send> Send for XArray<T> {}
+
+// SAFETY: `XArray<T>` serialises the interior mutability it provides so it is `Sync` iff `T` is
+// `Send`.
+unsafe impl<T: ForeignOwnable + Send> Sync for XArray<T> {}

-- 
2.47.1


