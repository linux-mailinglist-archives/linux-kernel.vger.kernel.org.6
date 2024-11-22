Return-Path: <linux-kernel+bounces-418423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB849D6173
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30022825D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB5D1DEFDC;
	Fri, 22 Nov 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lt0cnq9R"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905BB1DEFD4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290067; cv=none; b=gfodf1Sszb28UuHudA/Noh7mYd3cuN35t8eI1baWMDcF1XiYCXQlk/MX8vVY4bCg10J3U0YlWu+ZB0PLvnIpo9r7DwMRWJ6kW9znpdO1s4Hhx9QXW7Af638G207IdVQwS0aSndXRTz4IehI4sEUaHfcXwPLEWHZ11MhJyHZTN5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290067; c=relaxed/simple;
	bh=ZPc1KRKfoIOZWtqnzIede0sGQwVP3YDeDd6Hc6TOsWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mi7X5riRiO74q14jPhbHiL+UmG3DEmp5IJI6z+872MNVuWG1gjD7LNQnhnshEvuUoAYk2VXA6KYMf150fltY85I3CbcWt9z/MrmKme2EqGI3nU03W9iD518CzUnm/5Dd2jFYYhhU1o8lq/Uv30tbn+c9ATi9Go1a4bRMBSTI1VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lt0cnq9R; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8794f354so38156757b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732290064; x=1732894864; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJFWlPcRbAWY+HnVngOyCc1o+97QXNSOMi5+R+xDQr4=;
        b=Lt0cnq9R6iq3maHztCDfQZsHPt3233C3ixwgL7BF8I5ny9y5A1VRKGMRn0848mHRd2
         FogXvSH+dCZuPa/KQZlz/jClcCnVdx4CKfxrM8AUcr+1tvkdjk46B2CS8xkXcF4h/VNt
         UZW5z1NqrpVJ+e9Gv43BX0sp94RhAih0fRFCwEpMFMNrDXbEsorOfi7p1gvuxR5zIoYL
         y4lmBc/G42GG4UI5thkBUrHdjheHgYxtMTFAucYKoDQ9CLEmQHjw8wSGcPJN5YLGralW
         Vzw3MmndGIlBehceYO5ppYoQYwGYsSFLM34dlUC7z5vYET2VqZX+j4E0AW+dHMytAjUL
         64bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290064; x=1732894864;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJFWlPcRbAWY+HnVngOyCc1o+97QXNSOMi5+R+xDQr4=;
        b=KcoTcTi5UFh0WU1IQCRdDQmkKaomEiNjFcTy5wGHUZ7fOsNv+d/N1dZL/wtEw106cb
         MirQlCOQR73xQdiJQShLrDTK0tfYAn4h3jVOH1lQzDXlIBCpvcjLeYs6/tJR7/Zidcgc
         /+d/M1LhM2dZ/7P+DrKQufgPm1eKvXDeB58OQyJH9yPvyn8B88TN9NyKuZwrhfvg0X1P
         EaskcGsvYYKwpgxnx8xGozrviIR+esutJsenO7U23g3nnpGThuJdV5rKPIy6pLcHkXMG
         2ONRM9w517Pb7CMiRApauBYH7xgNsYVmAo4Egs9YVtHZShMQNd14s9X9hJeGa911Be10
         oxyw==
X-Forwarded-Encrypted: i=1; AJvYcCVpKpY7g7axQPH1YDw3LxfX9xQWsQ/WJsNiD+LYN/KhdKcuc+lD8bXHSLJO9HmZVp3OIC1sNhBSrMZycZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6pTSogEhpLLqefA+sFhAnuZorZeLeaKqi8Sb3EpXjIePxX/x
	NKQn6DnY7lAzHJGY6rB93YwYvRuRq19ybv/5fzyTc0S048H4MPcdTksDHHyAatKoxP6YT/nEx+G
	qjPT0SsivPi72Cg==
X-Google-Smtp-Source: AGHT+IFkONJC35kmfVY70U61nS/i2+8qUNS80u+/hoQsPbcnJf4FyJ3hfmZEVlFS1n5cWkqU0f6+UfL+LNXTVJs=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f29e])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:680d:b0:6ee:b693:f752 with SMTP
 id 00721157ae682-6eee0777adfmr474527b3.0.1732290064561; Fri, 22 Nov 2024
 07:41:04 -0800 (PST)
Date: Fri, 22 Nov 2024 15:40:26 +0000
In-Reply-To: <20241122-vma-v9-0-7127bfcdd54e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=9971; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ZPc1KRKfoIOZWtqnzIede0sGQwVP3YDeDd6Hc6TOsWM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnQKYHu02lowltad/mpq8VFaO/SbmENjK7ouQqb
 BP+7GBjeceJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0CmBwAKCRAEWL7uWMY5
 RtBIEACzoJXZvz8inFVeNuo4OnCxriwsgPHZvem8VJonDGvKOqY3hV8gdgEW0K8ZCRVi3FxkX6Q
 rhi2LU17e0tNyuNS/fPXzgTVtlQ+uePX+T16VcOwD6Tok3wwoFlgJFYP9rkgdXCwPbTP1RDxVZI
 O0KP5gnzotaIObWIAXjiInjRdZzTbu3YtmSadyCpxmsvplUP30jlZPPQEtB8IdO9lXBfN+aoekT
 8ol3fX/5me6J/ORV/A9ejQWpWz3GgcyhCfe7Z+y/+7cvWVFPxs3arcjCc0HMHPLabcK0RClafYY
 JiNexDK8yqS0gGZ+aYr+2c7FhCwv+6Klck+F9LsSSLgiXKK3VxKaFYAqAt/H5ketvAtoyPYcwIf
 Jjv6yuP4SQ9Js1cuTPVfq+ecqT60ApH2hc8GZnQ4Kd9UjBnMePsRewrTf5Osa1l9sfU4RCT8Wtx
 V6epoDSENmIwUkovL8UmHv18xLKpQCWU7aWYAxZuyjsBx8wxUpBAh+sDxz1MHYXLAiYqfNPDeyZ
 GoQ0KMDpW3H2jq+9YhKTCXVo+6Q85RXhvMNZcA5+oj1eki94TSGdEl13UC6kuaNaME/ROr2jR0N
 ljH+qZ+PVCKuKW6ETcGvkIkZ3tCYAlCN4p1AtzRwK5nz1lGdMpgjtgc77S7WlWJXRLmw0AIzo2M B1pjqpbr9pI51IQ==
X-Mailer: b4 0.13.0
Message-ID: <20241122-vma-v9-1-7127bfcdd54e@google.com>
Subject: [PATCH v9 1/8] mm: rust: add abstraction for struct mm_struct
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
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
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

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/helpers.c |   1 +
 rust/helpers/mm.c      |  39 +++++++++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/mm.rs      | 219 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 260 insertions(+)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 6d90afd38c40..2ee3af594633 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -15,6 +15,7 @@
 #include "err.c"
 #include "fs.c"
 #include "kunit.c"
+#include "mm.c"
 #include "mutex.c"
 #include "page.c"
 #include "rbtree.c"
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
index bf98caa6d6a5..104e619f5dbd 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -45,6 +45,7 @@
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
2.47.0.371.ga323438b13-goog


