Return-Path: <linux-kernel+bounces-512749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FC8A33D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F0C188D340
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589D221422F;
	Thu, 13 Feb 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PVMAj98W"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C940214201
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444683; cv=none; b=vF5Rf0diP8YPiQNrC1BlgP5fndBP+dt18exokkEECyE3CscaIwWcluAijCoo0NUElOoY0BS5523K864wHCPmFTkFDJ45OYjRMYnSqYZGbC/Z6I0UBBxnAikMyvlMIL1PPht275fNSd6rVotpXOJlL/aTNcQShJO39mef/5HJnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444683; c=relaxed/simple;
	bh=dLD6cHWVgf4Y0Wdnlt3dpV8a6zt+QppcLE+M4FISSKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ax+O30lePkfB5/l5MqI5vY2HR8ITtEt5wdmePZ3MfM371mz6y5t9ONR2ma0ZWCTDEXXF2GXZ4BYSv7QMeoElvegk+6jPDVGEsWWc+C9Aln+jdAssAc5d/oT03rosmmkx+z+1G2sRCF8CNZRy8GbnvVRhmrAeApE8P0GT4e11AwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PVMAj98W; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43961fb0bafso2749925e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739444679; x=1740049479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9c//+puMEPIu02W9GqdsmxdftBKhgzEpRqTvLiOh1g=;
        b=PVMAj98W6nWrFb39qsdLZLTw5mxkM9NOSa+Hnb12iT20lZnVyQcpszluhHrq7iCK77
         Qpqrvz+cmzNnr8gXWaUo0s3i5v3latcnxDECNWTdSXjv0GCBxjM9nKrgtTbdn9D0dyaC
         OfRvBpsFtX+udotCxg+lVNbpYz/9ZYhOL2gDEy79lqtAv6/UQCHR3v5h8BGotvSqcSrR
         d5CwIoeXV1mHehm/31ldkTWOQLxDUZtoholZnr9ZLbqKQNFYaCyT582zlqzZ445yzbcB
         SPCxtYlA3+a66ejJ40w1bUWsNPIsdYRFpgBcYamWTGBSE9sAXTzQH53LrJR0YQjKcFdX
         LWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444679; x=1740049479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9c//+puMEPIu02W9GqdsmxdftBKhgzEpRqTvLiOh1g=;
        b=MbA+1TF1mOD2i+Rade58FRiU9UoTdQQ26ucp9StDSveg6Cp5nvXf8oMqrMHZIo6pgK
         zqOO7oLcpx1VSSpiLzxtTZb0PS3NnEPxOKvxFeLpJhkgb7ATYhWQYD9LufibIXG2OaF5
         juProimOIk1qh3t07wT6Zgq9cE2MYSzsfiEn7o2t9DlqC28vElYjdHdV+RdkqBUODZcS
         hEchBBvdUr5eXMyqDyfdRSmhTjudDkytRJoo4jt7pIoEyOSTy+72lyT6oOa6t1WmSJtk
         VukWBr+pvnRWA8jvV5h2+gBFeRauCOeyYALkklalNyprABAA3/M4H9lfhbVyQ+Iin/pl
         Z64g==
X-Forwarded-Encrypted: i=1; AJvYcCXRdWmArsKnrRUCS3NRfaYN97nthpd4RxuniCZ7xOsk9D7yp4A4ZgXoopvuRCEz3UswXOUUo6ko47a9F0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUuxzguzQib/CzzKn/BG4ghAn5JYnm4ueyJqQkP+/0tveG8B2s
	PZTDPwCgK6LeSirXrhDFOoTM+k+K1KYG+ouMGqfQrYteNS31Vr7GdRm9zQegBbFiQCffrw9yGH4
	oveEhLNV4svX/Dg==
X-Google-Smtp-Source: AGHT+IHbYFtzmogXBg9MKVnhQ13dP/0PgnaMmx1EqoIKBkmnDNwv9gD8FAc5s4pngUmvqFUXCOowllHdgVlDphw=
X-Received: from wmbay19.prod.google.com ([2002:a05:600c:1e13:b0:439:5636:735f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46cc:b0:439:54d3:d076 with SMTP id 5b1f17b1804b1-439601694e7mr26033985e9.1.1739444679495;
 Thu, 13 Feb 2025 03:04:39 -0800 (PST)
Date: Thu, 13 Feb 2025 11:04:00 +0000
In-Reply-To: <20250213-vma-v14-0-b29c47ab21f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10247; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=dLD6cHWVgf4Y0Wdnlt3dpV8a6zt+QppcLE+M4FISSKQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnrdG+XF/CRGicj29lFaft2zXQGBxQrOuGoT+gX
 gCTVXTMW2yJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ63RvgAKCRAEWL7uWMY5
 RowED/9wPP/m0yVmu3CtDvLxBZkr/NFB0Ykbc1trzp07J536Dy+CvTd4+mxPHKf7fjYyQ5yOM67
 420cGv5bXr9WLCKJAlouRfe5bWz3QrQeT0kRtlomkO4/viLZkkLwSfsmaocEtLFgAIrfZ3nDgFU
 sYPUKgV3lbeNpk4vVKgea0YwsSOKvH1Kx7sC0p/Yv0TfAbpFAn4MKggcxL0KCP28+zgYn9Bw3hX
 qFZlZwxn3XNw5lbYN0B1GQWH+vmFl3AJapms3E2pO0ekZkB1PiM56H6PWgvRuc8OkEmVqeWDfpe
 AQbUuB2ydzSyVu7Xjh+yUCRDp+VxH580NVduHrptwMC1jKjkHrKQB8aaISG5c74kxzOocK5QlRL
 9cDzGyIwxfpwczktY7Ks5MnuM2b9F5FfqbnscuSsIqSuciGngIbCDaLTTMRlyuMMini0aQ20PIf
 vTi7zYUQ6sRQcbiWLiOZakX7PUOAc9ZkdMcc0HegaWwMuyrr62twXCl5ScjEZC1UcRi+AKuV9i9
 sUx0YkYqewiFtH8vl5Ti+MDgN/+R70XAxjlNPy4ri51cde1yYBM+QKU0YZgvkN+y1g5g9TPevK6
 1vZwENcZYQN87Fxomcqn+JTXGIcpA/B2+47TeuwP4LcOmTzuJqK9C136EQdqGpBJsL3lf0OWQV/ VxK2B9Fk9lXYRFQ==
X-Mailer: b4 0.13.0
Message-ID: <20250213-vma-v14-1-b29c47ab21f5@google.com>
Subject: [PATCH v14 1/8] mm: rust: add abstraction for struct mm_struct
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Balbir Singh <balbirs@nvidia.com>
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

The struct is called Mm to keep consistency with the C side.

The ability to obtain `current->mm` is added later in this series.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/helpers.c |   1 +
 rust/helpers/mm.c      |  39 +++++++++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/mm.rs      | 209 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 250 insertions(+)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be..97cfc2d29f5e 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -18,6 +18,7 @@
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
+#include "mm.c"
 #include "mutex.c"
 #include "page.c"
 #include "platform.c"
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
index 496ed32b0911..9cf35fbff356 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -57,6 +57,7 @@
 pub mod kunit;
 pub mod list;
 pub mod miscdevice;
+pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod of;
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
new file mode 100644
index 000000000000..2fb5f440af60
--- /dev/null
+++ b/rust/kernel/mm.rs
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Memory management.
+//!
+//! This module deals with managing the address space of userspace processes. Each process has an
+//! instance of [`Mm`], which keeps track of multiple VMAs (virtual memory areas). Each VMA
+//! corresponds to a region of memory that the userspace process can access, and the VMA lets you
+//! control what happens when userspace reads or writes to that region of memory.
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
+/// This represents the address space of a userspace process, so each process has one `Mm`
+/// instance. It may hold many VMAs internally.
+///
+/// There is a counter called `mm_users` that counts the users of the address space; this includes
+/// the userspace process itself, but can also include kernel threads accessing the address space.
+/// Once `mm_users` reaches zero, this indicates that the address space can be destroyed. To access
+/// the address space, you must prevent `mm_users` from reaching zero while you are accessing it.
+/// The [`MmWithUser`] type represents an address space where this is guaranteed, and you can
+/// create one using [`mmget_not_zero`].
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
2.48.1.502.g6dc24dfdaf-goog


