Return-Path: <linux-kernel+bounces-441157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BF29ECA75
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D0C167064
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE60211A3C;
	Wed, 11 Dec 2024 10:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZW15SrV"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3A1FDE00
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913459; cv=none; b=Gd/csDCi2y5XjRFPIBXMkB0Y2r3n7mkVHP+p/KhgYkp3Xv8cZ2Up1SFY3CKL4bnjJa2wgStdF08GLjPhF9/zhf9itmDC7Hwb2uZ40yYvZY/PZR0BDevWe72vwwWAP4dCtjcYk+aDUHvRlikZnsp/QvyMs73ZGV0lBtPgzFvpb2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913459; c=relaxed/simple;
	bh=BP0rHFtdcn3zxhmWpCsC4fRZsGWpHTVijKhPN/V33Gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XXnEDtsTFIInamfZP5VXI+y9f2be4/n5azmQfz1htwmg0ou8Tw+0dFVv4eVM24YUwta/GfhENyRut1kjs4vu4513vzjOOqbKaCj5UixBaKgbBRiuDlueOROfIm5uK9ZnAqIBiYKv97KiP2YPNaMTUubIG0Fer+56YcZuB+yQc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZW15SrV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-434f852cb35so2245175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733913455; x=1734518255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eeSYOeE5pMMeyg7ZhXQAlvtxanJpaTuPefZQ5vxq80o=;
        b=iZW15SrVYYPwGFTx5SFpIb3pf7o6hZbq/I6RjyhZrK5e7rIrYpCaFbsV2SvIk3MsZr
         jhGVTZm8Ms+q9LtSCXViXc3VpToWphWe9YUTDWraDqaQgNWDntU2FDJoNhCBjqLhhlok
         ZkYpVgH4v/DeiaB4WjqRJFtFkthJoWNpE6wMvB+yWgpLQjK8DYAbAsNihuGJYGlTNZ4u
         8ITBAXZzpRsKAXFuamPnKLQcEcQ0WKe0Ug49OEhmvLs5C/yfepiqJnlH4gGp9Is+3L2v
         bd7OiCur6nKG/fSP6qmAOP73uuONvbEw/wFlW8siAXi1geYNBDke6QpVWecA9d+8d5kS
         1nZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913455; x=1734518255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eeSYOeE5pMMeyg7ZhXQAlvtxanJpaTuPefZQ5vxq80o=;
        b=C/UpC6muRUgRsKiyB1i0GePVBNSGeV5eE3mxprRg31GlYYmhdXWc9p0nLPRo2OpvQl
         m1sEV+hRxxaCwuAyjvrrLOkQ9wUijSU6if1h0YyWFuMkdW83fPETcxMmby9rfRRo3h1M
         W0Jtlf+mvMuwhNQnXIXnrhyzBMe/tue/a8JM/8TTw66HQQ5kLTq8RyuwAdgivYfZAhbv
         0lxnk+t2a+rJXSkLVvTlB9RUv7NwfRPbZxMGAuhydv+C5Ojzp2Wd0qWKrrMie6zR69SJ
         NDLBx1Fqzp1oKNdJhBTgKHsBCn+rmW8hujN2UaYw+nV5JpLNa1vTUXHFoWttT6+Qfede
         CxMA==
X-Forwarded-Encrypted: i=1; AJvYcCUQcdeV5B6Bc0HBd2551y/ZQotgTFphAYWPNObB5eEDYzb0zGp+Z6gp6y8NOFbWEexn8HKFZfHYTN8hP50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwLAhw4gjI84gjXb3qX5P5BTJUz1JkHL+HbQrdaKxbdJK4OAyh
	hw7eceUbIo13BP5ORxNXnpSv7I6IvMxTKl5eAA7soRvZeShypjHfCjpl9KEaRwzkjpQKgOASmFo
	jJhImoMcrEUWOTA==
X-Google-Smtp-Source: AGHT+IGlVGDsXAS8QTt20ZhjhUvb4+iLhx6imu5M/qvMwlRkpVFZ0hN9qToGEpQgPFG5rFlBMfq0S5s6OEGbDoM=
X-Received: from wmbd2.prod.google.com ([2002:a05:600c:58c2:b0:434:f513:bb24])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:b86:b0:434:f623:9ff3 with SMTP id 5b1f17b1804b1-4361c382ce3mr18383385e9.15.1733913454954;
 Wed, 11 Dec 2024 02:37:34 -0800 (PST)
Date: Wed, 11 Dec 2024 10:37:05 +0000
In-Reply-To: <20241211-vma-v11-0-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211-vma-v11-0-466640428fc3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10055; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=BP0rHFtdcn3zxhmWpCsC4fRZsGWpHTVijKhPN/V33Gw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWWtmTO1N1K8DUC6NoDXf02ue/qobHQiKrkrWy
 Qgkt4oEYx2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1lrZgAKCRAEWL7uWMY5
 Rk37D/wKqutxvgqTXRQSIuDKk6I9CScFzIL8g8BqDE1KNEKiN6wrIWLFEcpw9BSH85DoRLdm0y2
 XGydQAJ5iIJzfHWTw4k5RvMDkr8JHrdMTYTNLo9w49UHdABMFkiSk2ZRQ4p97t2rcPk4DciGYtB
 LYzQdCJPLhvlnk4j125r3wgO+8a1PgVElFmYrZZG42nFk3Do3gamix8Db9R8M6/l5Zl9o2uObsA
 ONIlvWmIedb1NJ5V/LfYc/HhYoSZT3wYNQRjET2d0352qRxyipt4oXDJfEOnf4PUc9WElAfZaEo
 Itha4cyfEjOZjky9RLsKXWzEQFyadVxgjxdtYQwzOScECwI9iVKIvRhYYHdjLqmmjwW0rkktYVb
 DDUuSOD3u9KPp1UEtAxW/wWaPN3JUFL2Ng+nkc5V7nbSzlMXF22g5ytMA0rpK1QOC5NIhqVXDup
 SbLgi25Ot6vGwTcrGyxuBbQjXTVfV51yZpVQPW96b3IF30Pd8OHeMa2bCusmjZU+Po5vkEtOpoY
 8GLg8cf1on2Jt21bMRjq6S4gH4r9TLiZ5WgNBhTp1CAc443b92p/AVEzZshjGavyrKiMhSkBnbR
 j7QpB7Q3pSWCg1HJHzVSwr/MX9VStblyNEDSRZL9+R4YR7h3FeeWbC+qJWw7PscIJWVRRd+QSWf a+c0FhQRhWjjrTg==
X-Mailer: b4 0.13.0
Message-ID: <20241211-vma-v11-1-466640428fc3@google.com>
Subject: [PATCH v11 1/8] mm: rust: add abstraction for struct mm_struct
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

These abstractions allow you to reference a `struct mm_struct` using
both mmgrab and mmget refcounts. This is done using two Rust types:

* Mm - represents an mm_struct where you don't know anything about the
  value of mm_users.
* MmWithUser - represents an mm_struct where you know at compile time
  that mm_users is non-zero.

This allows us to encode in the type system whether a method requires
that mm_users is non-zero or not. For instance, you can always call
`mmget_not_zero` but you can only call `mmap_read_lock` when mm_users is
non-zero.

It's possible to access current->mm without a refcount increment, but
that is added in a later patch of this series.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/helpers.c |   1 +
 rust/helpers/mm.c      |  39 +++++++++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/mm.rs      | 219 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 260 insertions(+)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index dcf827a61b52..9d748ec845b3 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -16,6 +16,7 @@
 #include "fs.c"
 #include "jump_label.c"
 #include "kunit.c"
+#include "mm.c"
 #include "mutex.c"
 #include "page.c"
 #include "pid_namespace.c"
diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
new file mode 100644
index 000000000000..7201747a5d31
--- /dev/null
+++ b/rust/helpers/mm.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mm.h>
+#include <linux/sched/mm.h>
+
+void rust_helper_mmgrab(struct mm_struct *mm)
+{
+	mmgrab(mm);
+}
+
+void rust_helper_mmdrop(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+
+void rust_helper_mmget(struct mm_struct *mm)
+{
+	mmget(mm);
+}
+
+bool rust_helper_mmget_not_zero(struct mm_struct *mm)
+{
+	return mmget_not_zero(mm);
+}
+
+void rust_helper_mmap_read_lock(struct mm_struct *mm)
+{
+	mmap_read_lock(mm);
+}
+
+bool rust_helper_mmap_read_trylock(struct mm_struct *mm)
+{
+	return mmap_read_trylock(mm);
+}
+
+void rust_helper_mmap_read_unlock(struct mm_struct *mm)
+{
+	mmap_read_unlock(mm);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index e1065a7551a3..6555e0847192 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -46,6 +46,7 @@
 pub mod kunit;
 pub mod list;
 pub mod miscdevice;
+pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
new file mode 100644
index 000000000000..84cba581edaa
--- /dev/null
+++ b/rust/kernel/mm.rs
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Memory management.
+//!
+//! C header: [`include/linux/mm.h`](srctree/include/linux/mm.h)
+
+use crate::{
+    bindings,
+    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
+};
+use core::{ops::Deref, ptr::NonNull};
+
+/// A wrapper for the kernel's `struct mm_struct`.
+///
+/// Since `mm_users` may be zero, the associated address space may not exist anymore. You can use
+/// [`mmget_not_zero`] to be able to access the address space.
+///
+/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destructor may sleep.
+///
+/// # Invariants
+///
+/// Values of this type are always refcounted using `mmgrab`.
+///
+/// [`mmget_not_zero`]: Mm::mmget_not_zero
+#[repr(transparent)]
+pub struct Mm {
+    mm: Opaque<bindings::mm_struct>,
+}
+
+// SAFETY: It is safe to call `mmdrop` on another thread than where `mmgrab` was called.
+unsafe impl Send for Mm {}
+// SAFETY: All methods on `Mm` can be called in parallel from several threads.
+unsafe impl Sync for Mm {}
+
+// SAFETY: By the type invariants, this type is always refcounted.
+unsafe impl AlwaysRefCounted for Mm {
+    #[inline]
+    fn inc_ref(&self) {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmgrab(self.as_raw()) };
+    }
+
+    #[inline]
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The caller is giving up their refcount.
+        unsafe { bindings::mmdrop(obj.cast().as_ptr()) };
+    }
+}
+
+/// A wrapper for the kernel's `struct mm_struct`.
+///
+/// This type is like [`Mm`], but with non-zero `mm_users`. It can only be used when `mm_users` can
+/// be proven to be non-zero at compile-time, usually because the relevant code holds an `mmget`
+/// refcount. It can be used to access the associated address space.
+///
+/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. Its destructor may sleep.
+///
+/// # Invariants
+///
+/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
+#[repr(transparent)]
+pub struct MmWithUser {
+    mm: Mm,
+}
+
+// SAFETY: It is safe to call `mmput` on another thread than where `mmget` was called.
+unsafe impl Send for MmWithUser {}
+// SAFETY: All methods on `MmWithUser` can be called in parallel from several threads.
+unsafe impl Sync for MmWithUser {}
+
+// SAFETY: By the type invariants, this type is always refcounted.
+unsafe impl AlwaysRefCounted for MmWithUser {
+    #[inline]
+    fn inc_ref(&self) {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmget(self.as_raw()) };
+    }
+
+    #[inline]
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The caller is giving up their refcount.
+        unsafe { bindings::mmput(obj.cast().as_ptr()) };
+    }
+}
+
+// Make all `Mm` methods available on `MmWithUser`.
+impl Deref for MmWithUser {
+    type Target = Mm;
+
+    #[inline]
+    fn deref(&self) -> &Mm {
+        &self.mm
+    }
+}
+
+// These methods are safe to call even if `mm_users` is zero.
+impl Mm {
+    /// Call `mmgrab` on `current.mm`.
+    #[inline]
+    pub fn mmgrab_current() -> Option<ARef<Mm>> {
+        // SAFETY: It's safe to get the `mm` field from current.
+        let mm = unsafe {
+            let current = bindings::get_current();
+            (*current).mm
+        };
+
+        if mm.is_null() {
+            return None;
+        }
+
+        // SAFETY: The value of `current->mm` is guaranteed to be null or a valid `mm_struct`. We
+        // just checked that it's not null. Furthermore, the returned `&Mm` is valid only for the
+        // duration of this function, and `current->mm` will stay valid for that long.
+        let mm = unsafe { Mm::from_raw(mm) };
+
+        // This increments the refcount using `mmgrab`.
+        Some(ARef::from(mm))
+    }
+
+    /// Returns a raw pointer to the inner `mm_struct`.
+    #[inline]
+    pub fn as_raw(&self) -> *mut bindings::mm_struct {
+        self.mm.get()
+    }
+
+    /// Obtain a reference from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` points at an `mm_struct`, and that it is not deallocated
+    /// during the lifetime 'a.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a Mm {
+        // SAFETY: Caller promises that the pointer is valid for 'a. Layouts are compatible due to
+        // repr(transparent).
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Calls `mmget_not_zero` and returns a handle if it succeeds.
+    #[inline]
+    pub fn mmget_not_zero(&self) -> Option<ARef<MmWithUser>> {
+        // SAFETY: The pointer is valid since self is a reference.
+        let success = unsafe { bindings::mmget_not_zero(self.as_raw()) };
+
+        if success {
+            // SAFETY: We just created an `mmget` refcount.
+            Some(unsafe { ARef::from_raw(NonNull::new_unchecked(self.as_raw().cast())) })
+        } else {
+            None
+        }
+    }
+}
+
+// These methods require `mm_users` to be non-zero.
+impl MmWithUser {
+    /// Obtain a reference from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` points at an `mm_struct`, and that `mm_users` remains
+    /// non-zero for the duration of the lifetime 'a.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
+        // SAFETY: Caller promises that the pointer is valid for 'a. The layout is compatible due
+        // to repr(transparent).
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Lock the mmap read lock.
+    #[inline]
+    pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmap_read_lock(self.as_raw()) };
+
+        // INVARIANT: We just acquired the read lock.
+        MmapReadGuard {
+            mm: self,
+            _nts: NotThreadSafe,
+        }
+    }
+
+    /// Try to lock the mmap read lock.
+    #[inline]
+    pub fn mmap_read_trylock(&self) -> Option<MmapReadGuard<'_>> {
+        // SAFETY: The pointer is valid since self is a reference.
+        let success = unsafe { bindings::mmap_read_trylock(self.as_raw()) };
+
+        if success {
+            // INVARIANT: We just acquired the read lock.
+            Some(MmapReadGuard {
+                mm: self,
+                _nts: NotThreadSafe,
+            })
+        } else {
+            None
+        }
+    }
+}
+
+/// A guard for the mmap read lock.
+///
+/// # Invariants
+///
+/// This `MmapReadGuard` guard owns the mmap read lock.
+pub struct MmapReadGuard<'a> {
+    mm: &'a MmWithUser,
+    // `mmap_read_lock` and `mmap_read_unlock` must be called on the same thread
+    _nts: NotThreadSafe,
+}
+
+impl Drop for MmapReadGuard<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: We hold the read lock by the type invariants.
+        unsafe { bindings::mmap_read_unlock(self.mm.as_raw()) };
+    }
+}

-- 
2.47.1.613.gc27f4b7a9f-goog


