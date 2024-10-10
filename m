Return-Path: <linux-kernel+bounces-359055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113FB9986DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8E4B210BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A085F1C8FC0;
	Thu, 10 Oct 2024 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ZsvoRyg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD031C8FBF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565036; cv=none; b=Xxm0PELoFlM1GQ42ONZD7OSJfsAg2HQ40EcYOFbMbhSCg9o3rtOencOMh+mH21cC3McM2Cyz7w78FQPnk3JKXsfqPtXe4oYr7PjIA9+/8w7SBmbj6iDlOkeLjhX6Tk7hdFk6murKoF06kwDzJyHRN8nLL0bZZhP51/sjy1l/twk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565036; c=relaxed/simple;
	bh=Pku27YwuXm2j1rDbiMh5cMtYJ6eJYKBpSYm4k8LPr+M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tLthdv1LWpWSiNhYYrIVpPHPKIhUvrTqewGOY6MxTyt7ftFgDXY5dsw2r4Zj5mrC5+nOl+04bQU9zX4xCV7fQylwMqD9MO4j7P5jt86ldIwu6NA/pWciO9jO85YB5Mgy4pDdYtPD8G8cBNpswhWTjOujNgsDCUggc6yi6xwy5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ZsvoRyg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6886cd07673so20857787b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728565033; x=1729169833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MmWVfi2+jb15UkB9G2ciZscfxbiqLOksHLt4pyPQzx4=;
        b=0ZsvoRyg0fr+Ry4mksNPxmZ6lu7hznasXc1AwJqeFp4wHp85jafMswAqahSEqxZJh2
         7hjMHppdDG8unZGMrILZU7/kqRDLsAPDpTSjZRwzUZnfdqglxCxS+eVRmtRT4twDDZBX
         e6aVo9/G+v9uTiB6N7cTGl/x0EjkBLceaNFeHsHS32Mu5j7cJZLUgxzLSQgrtuBG7QEu
         0RkkIxenoKUliTCTdZqckkZJSEoHIhyQuSSEjrATC6UxHr4qPTCKhEhhQCw5E+NahU8V
         dBLQ0kSPi+1eRrgx77S4tqnJds2mOMSFqkDzLx5IJRYLLyUVYDaco3r/dTXYJW7KXODQ
         Porw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565033; x=1729169833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MmWVfi2+jb15UkB9G2ciZscfxbiqLOksHLt4pyPQzx4=;
        b=F+NLpD/qL6WpHuDhljlJhUtI7H5UxfnaaZxIlMH4IFAn/n8GlK0NoAJnPoA64f9Xap
         Wbvfd/93Y0pPmXnr7gJppYyHfPUDo4S+wT2q0pcu3fvyd7uj03vvudGI+lZ5SmZbFtt+
         Vph38oPO3GKUwfNreEB6Zn5ntZe3YMcQ1qLcpAI7TBmkYx0JBf4RI95xqlIaF+BfiYY5
         TyVc9yWZAA5NP3t6dAJmnW3wnD/H1dd07Dwnd6iFtaq6AyYaxZ76y4qRA3UtFPpexfnu
         pg6RryAG6Ia6A/DW2mcvCgJM4ejsjGf9jebsjz8QaFh1sunP/NIsccOZvJhw6Cd//J7Z
         9Eag==
X-Forwarded-Encrypted: i=1; AJvYcCXIW4sEyZRECxNGZUGbY9ZzhdHaE9j49EvJcvxVIEhGApKX3FK2sHJ73DSaKhn5bRqVACOy/tC7VN757Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDMo8Scr5we0MqnO5XvvB4RiDOkRRbiq1hyB23X62A8HIoivvF
	aTv72fTseTZ01GBqgdu6oCByKzLcz+cm4It7dItjoczIIn6Wt9/27+g1VNGhi4mms+K5II3wsKk
	BK0ME63mea2D8DA==
X-Google-Smtp-Source: AGHT+IF5KCyzko67R7iXNaEYOunY6fQkyjLZ3wiupTzT85+WZ+fIRr8fem+kxgLc0B0QKwId48EaLuHZPrMEjnM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a25:9105:0:b0:e20:25f5:a889 with SMTP id
 3f1490d57ef6-e28fe4a5550mr4026276.5.1728565032146; Thu, 10 Oct 2024 05:57:12
 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:56:35 +0000
In-Reply-To: <20241010-vma-v6-0-d89039b6f573@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010-vma-v6-0-d89039b6f573@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=25185; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Pku27YwuXm2j1rDbiMh5cMtYJ6eJYKBpSYm4k8LPr+M=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnB88h0HfMQ9LKUkFEmmT/MZOuLOtFCeyWctHvM
 XBTI4xRIQOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZwfPIQAKCRAEWL7uWMY5
 RjqhEACgAEgxmuU7gQkEAoro5XgPsEc0Xf8IxBcMJWstrd3IvKUc7p/mC3FgWtYSc3/lpJn667a
 8zgiZHXt2w0VIJUgg8JsrxZ/cnGhNUWc9XrcdWJiaEz/mI5CWaRoMti4rMEimvnNEkwGrHBbDU+
 LNEXqrgSpntgyb5BM9+heIVqxXhgUtsdJ2eLS5XjuRr6RR7eX4om7y2HjiRIS3nOQfvhAPWbIqM
 SOdH3ZgfsxEKHJEKkdPFOuk5Fggb6OVwYuMEV8pCu1xA+x96KC/Ln4QlpFz5AZ0oQfsStnBvM5m
 ro1WfN48Ws4J7g1KJtYUGBEOwQLaJjj1ylE4dmTSKItvbyhuOqhiNt2oW0d9mh4pNEcXi8lq16J
 KNwaXm28iZCtS+A2GMxUU8n8TdQ/DSiZlhLbdl6/KGpa46MWWGWRvddhyvDKn74uHaGJayyas42
 V6E5/qj+BEwxOgg38ZaSDM5TZRNvNxQhprR5pJxegK7FFX1LhMNTIYoLH08y0nUmhtO0WbO7H4+
 NTX1u2FewCvJuF/DcyHn1BuInZqM13HJPb5s+U19Hqpa6STpRSSHqyb7BhejwUvkXpBFslX6S8E
 rg7z5CUYS5ds3YCJZ6sBL/4hDStEx2UERNOvOEcrPZo2OcUe7kSs0GAWrvCxI43irjZB/GHI99/ 7IaUZCJuk3kSv6Q==
X-Mailer: b4 0.13.0
Message-ID: <20241010-vma-v6-1-d89039b6f573@google.com>
Subject: [PATCH v6 1/2] rust: mm: add abstractions for mm_struct and vm_area_struct
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="utf-8"

These abstractions allow you to manipulate vmas. Rust Binder will uses
these in a few different ways.

In the mmap implementation, a VmAreaNew will be provided to the mmap
call which allows it to modify the vma in ways that are only okay during
initial setup. This is the case where the most methods are available.

However, Rust Binder needs to insert and remove pages from the vma as
time passes. When incoming messages arrive, pages may need to be
inserted if space is missing, and in this case that is done by using a
stashed ARef<Mm> and calling mmget_not_zero followed by mmap_write_lock
followed by vma_lookup followed by vm_insert_page. In this case, since
mmap_write_lock is used, the VmAreaMut type will be in use.

Another use-case is the shrinker, where the mmap read lock is taken
instead, and zap_page_range_single is used to remove pages from the vma.
In this case, only the read lock is taken, so the VmAreaRef type will be
in use.

Future extensions could involve a VmAreaRcuRef for accessing vma methods
that are okay to use when holding just the rcu read lock. However, these
methods are not needed from Rust yet.

This uses shared references even for VmAreaMut. This is preferable to
using pinned mutable references because those are pretty inconvenient
due to the lack of reborrowing. However, this means that VmAreaMut
cannot be Sync. I think it is an acceptable trade-off.

This patch is based on Wedson's implementation on the old rust branch,
but has been changed significantly. All mistakes are Alice's.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/helpers.c |   1 +
 rust/helpers/mm.c      |  55 ++++++++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/mm.rs      | 344 +++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs | 264 +++++++++++++++++++++++++++++++++++++
 5 files changed, 665 insertions(+)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 30f40149f3a9..907ee77b3bb9 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -13,6 +13,7 @@
 #include "build_bug.c"
 #include "err.c"
 #include "kunit.c"
+#include "mm.c"
 #include "mutex.c"
 #include "page.c"
 #include "rbtree.c"
diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
new file mode 100644
index 000000000000..0a2c2cc1903f
--- /dev/null
+++ b/rust/helpers/mm.c
@@ -0,0 +1,55 @@
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
+
+void rust_helper_mmap_write_lock(struct mm_struct *mm)
+{
+	mmap_write_lock(mm);
+}
+
+void rust_helper_mmap_write_unlock(struct mm_struct *mm)
+{
+	mmap_write_unlock(mm);
+}
+
+struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
+					      unsigned long addr)
+{
+	return vma_lookup(mm, addr);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 8a228bcbbe85..6fa97e8866a9 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@
 pub mod kunit;
 pub mod list;
 pub mod miscdevice;
+pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
new file mode 100644
index 000000000000..b5d29ce0c6ef
--- /dev/null
+++ b/rust/kernel/mm.rs
@@ -0,0 +1,344 @@
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
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+
+use core::{
+    ops::Deref,
+    ptr::{self, NonNull},
+};
+
+pub mod virt;
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
+    fn inc_ref(&self) {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmgrab(self.as_raw()) };
+    }
+
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
+/// #[repr(transparent)]
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
+    fn inc_ref(&self) {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmget(self.as_raw()) };
+    }
+
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
+/// A wrapper for the kernel's `struct mm_struct`.
+///
+/// This type is identical to `MmWithUser` except that it uses `mmput_async` when dropping a
+/// refcount. This means that the destructor of `ARef<MmWithUserAsync>` is safe to call in atomic
+/// context.
+///
+/// # Invariants
+///
+/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
+/// #[repr(transparent)]
+#[repr(transparent)]
+pub struct MmWithUserAsync {
+    mm: MmWithUser,
+}
+
+// SAFETY: It is safe to call `mmput_async` on another thread than where `mmget` was called.
+unsafe impl Send for MmWithUserAsync {}
+// SAFETY: All methods on `MmWithUserAsync` can be called in parallel from several threads.
+unsafe impl Sync for MmWithUserAsync {}
+
+// SAFETY: By the type invariants, this type is always refcounted.
+unsafe impl AlwaysRefCounted for MmWithUserAsync {
+    fn inc_ref(&self) {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmget(self.as_raw()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The caller is giving up their refcount.
+        unsafe { bindings::mmput_async(obj.cast().as_ptr()) };
+    }
+}
+
+// Make all `MmWithUser` methods available on `MmWithUserAsync`.
+impl Deref for MmWithUserAsync {
+    type Target = MmWithUser;
+
+    #[inline]
+    fn deref(&self) -> &MmWithUser {
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
+    /// Check whether this vma is associated with this mm.
+    #[inline]
+    pub fn is_same_mm(&self, area: &virt::VmAreaRef) -> bool {
+        // SAFETY: The `vm_mm` field of the area is immutable, so we can read it without
+        // synchronization.
+        let vm_mm = unsafe { (*area.as_ptr()).vm_mm };
+
+        ptr::eq(vm_mm, self.as_raw())
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
+    /// Use `mmput_async` when dropping this refcount.
+    pub fn use_mmput_async(me: ARef<MmWithUser>) -> ARef<MmWithUserAsync> {
+        // SAFETY: The layouts and invariants are compatible.
+        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
+    }
+
+    /// Lock the mmap write lock.
+    #[inline]
+    pub fn mmap_write_lock(&self) -> MmapWriteLock<'_> {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmap_write_lock(self.as_raw()) };
+
+        // INVARIANT: We just acquired the write lock.
+        MmapWriteLock { mm: self }
+    }
+
+    /// Lock the mmap read lock.
+    #[inline]
+    pub fn mmap_read_lock(&self) -> MmapReadLock<'_> {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmap_read_lock(self.as_raw()) };
+
+        // INVARIANT: We just acquired the read lock.
+        MmapReadLock { mm: self }
+    }
+
+    /// Try to lock the mmap read lock.
+    #[inline]
+    pub fn mmap_read_trylock(&self) -> Option<MmapReadLock<'_>> {
+        // SAFETY: The pointer is valid since self is a reference.
+        let success = unsafe { bindings::mmap_read_trylock(self.as_raw()) };
+
+        if success {
+            // INVARIANT: We just acquired the read lock.
+            Some(MmapReadLock { mm: self })
+        } else {
+            None
+        }
+    }
+}
+
+impl MmWithUserAsync {
+    /// Use `mmput` when dropping this refcount.
+    pub fn use_mmput(me: ARef<MmWithUserAsync>) -> ARef<MmWithUser> {
+        // SAFETY: The layouts and invariants are compatible.
+        unsafe { ARef::from_raw(ARef::into_raw(me).cast()) }
+    }
+}
+
+/// A guard for the mmap read lock.
+///
+/// # Invariants
+///
+/// This `MmapReadLock` guard owns the mmap read lock.
+pub struct MmapReadLock<'a> {
+    mm: &'a MmWithUser,
+}
+
+impl<'a> MmapReadLock<'a> {
+    /// Look up a vma at the given address.
+    #[inline]
+    pub fn vma_lookup(&self, vma_addr: usize) -> Option<&virt::VmAreaRef> {
+        // SAFETY: We hold a reference to the mm, so the pointer must be valid. Any value is okay
+        // for `vma_addr`.
+        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr as _) };
+
+        if vma.is_null() {
+            None
+        } else {
+            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
+            // the returned area will borrow from this read lock guard, so it can only be used
+            // while the read lock is still held.
+            unsafe { Some(virt::VmAreaRef::from_raw(vma)) }
+        }
+    }
+}
+
+impl Drop for MmapReadLock<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: We hold the read lock by the type invariants.
+        unsafe { bindings::mmap_read_unlock(self.mm.as_raw()) };
+    }
+}
+
+/// A guard for the mmap write lock.
+///
+/// # Invariants
+///
+/// This `MmapReadLock` guard owns the mmap write lock.
+pub struct MmapWriteLock<'a> {
+    mm: &'a MmWithUser,
+}
+
+impl<'a> MmapWriteLock<'a> {
+    /// Look up a vma at the given address.
+    #[inline]
+    pub fn vma_lookup(&mut self, vma_addr: usize) -> Option<&virt::VmAreaMut> {
+        // SAFETY: We hold a reference to the mm, so the pointer must be valid. Any value is okay
+        // for `vma_addr`.
+        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr as _) };
+
+        if vma.is_null() {
+            None
+        } else {
+            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
+            // the returned area will borrow from this write lock guard, so it can only be used
+            // while the write lock is still held.
+            unsafe { Some(virt::VmAreaMut::from_raw(vma)) }
+        }
+    }
+}
+
+impl Drop for MmapWriteLock<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: We hold the write lock by the type invariants.
+        unsafe { bindings::mmap_write_unlock(self.mm.as_raw()) };
+    }
+}
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
new file mode 100644
index 000000000000..7c09813e22f9
--- /dev/null
+++ b/rust/kernel/mm/virt.rs
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Virtual memory.
+
+use crate::{
+    bindings,
+    error::{to_result, Result},
+    page::Page,
+    types::Opaque,
+};
+
+use core::ops::Deref;
+
+/// A wrapper for the kernel's `struct vm_area_struct` with read access.
+///
+/// It represents an area of virtual memory.
+///
+/// # Invariants
+///
+/// The caller must at least hold the mmap read lock.
+#[repr(transparent)]
+pub struct VmAreaRef {
+    vma: Opaque<bindings::vm_area_struct>,
+}
+
+/// A wrapper for the kernel's `struct vm_area_struct` with write access.
+///
+/// It represents an area of virtual memory.
+///
+/// # Invariants
+///
+/// The caller must at least hold the mmap write lock.
+#[repr(transparent)]
+pub struct VmAreaMut {
+    vma: Opaque<bindings::vm_area_struct>,
+}
+
+/// A wrapper for the kernel's `struct vm_area_struct` during initial VMA setup.
+///
+/// It represents an area of virtual memory.
+///
+/// # Invariants
+///
+/// The caller must have mutable access and the vma must not have been shared yet.
+#[repr(transparent)]
+pub struct VmAreaNew {
+    vma: Opaque<bindings::vm_area_struct>,
+}
+
+// Make all VmAreaRef methods available on VmAreaMut.
+impl Deref for VmAreaMut {
+    type Target = VmAreaRef;
+    #[inline]
+    fn deref(&self) -> &VmAreaRef {
+        // SAFETY: We hold at least the write lock, so we have read access.
+        unsafe { VmAreaRef::from_raw(self.vma.get()) }
+    }
+}
+
+// Make all VmAreaMut methods available on VmAreaNew.
+impl Deref for VmAreaNew {
+    type Target = VmAreaMut;
+    #[inline]
+    fn deref(&self) -> &VmAreaMut {
+        // SAFETY: The vma is not yet shared, so we have write access.
+        unsafe { VmAreaMut::from_raw(self.vma.get()) }
+    }
+}
+
+impl VmAreaRef {
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
+    /// (or stronger) is held for at least the duration of 'a.
+    #[inline]
+    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
+        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
+        unsafe { &*vma.cast() }
+    }
+
+    /// Returns a raw pointer to this area.
+    #[inline]
+    pub fn as_ptr(&self) -> *mut bindings::vm_area_struct {
+        self.vma.get()
+    }
+
+    /// Returns the flags associated with the virtual memory area.
+    ///
+    /// The possible flags are a combination of the constants in [`flags`].
+    #[inline]
+    pub fn flags(&self) -> usize {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags as _ }
+    }
+
+    /// Returns the start address of the virtual memory area.
+    #[inline]
+    pub fn start(&self) -> usize {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_start as _ }
+    }
+
+    /// Returns the end address of the virtual memory area.
+    #[inline]
+    pub fn end(&self) -> usize {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_end as _ }
+    }
+
+    /// Unmap pages in the given page range.
+    #[inline]
+    pub fn zap_page_range_single(&self, address: usize, size: usize) {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is okay. Any value of `address` and `size` is allowed.
+        unsafe {
+            bindings::zap_page_range_single(
+                self.as_ptr(),
+                address as _,
+                size as _,
+                core::ptr::null_mut(),
+            )
+        };
+    }
+}
+
+impl VmAreaMut {
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap write lock
+    /// (or stronger) is held for at least the duration of 'a.
+    #[inline]
+    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
+        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
+        unsafe { &*vma.cast() }
+    }
+
+    /// Sets the flags associated with the virtual memory area.
+    ///
+    /// The possible flags are a combination of the constants in [`flags`].
+    #[inline]
+    pub fn set_flags(&self, flags: usize) {
+        // SAFETY: By the type invariants, the caller holds the mmap write lock, so this access is
+        // not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags as _ };
+    }
+
+    /// Maps a single page at the given address within the virtual memory area.
+    ///
+    /// This operation does not take ownership of the page.
+    #[inline]
+    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
+        // SAFETY: By the type invariants, the caller holds the mmap write lock, so this access is
+        // not a data race. The page is guaranteed to be valid and of order 0. The range of
+        // `address` is already checked by `vm_insert_page`.
+        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address as _, page.as_ptr()) })
+    }
+}
+
+impl VmAreaNew {
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the vma is
+    /// currently undergoing initial VMA setup.
+    #[inline]
+    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
+        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
+        unsafe { &*vma.cast() }
+    }
+
+    /// Make this vma anonymous.
+    #[inline]
+    pub fn set_anonymous(&self) {
+        // SAFETY: The vma is not yet shared.
+        unsafe { (*self.as_ptr()).vm_ops = core::ptr::null() };
+    }
+}
+
+/// Container for [`VmArea`] flags.
+pub mod flags {
+    use crate::bindings;
+
+    /// No flags are set.
+    pub const NONE: usize = bindings::VM_NONE as _;
+
+    /// Mapping allows reads.
+    pub const READ: usize = bindings::VM_READ as _;
+
+    /// Mapping allows writes.
+    pub const WRITE: usize = bindings::VM_WRITE as _;
+
+    /// Mapping allows execution.
+    pub const EXEC: usize = bindings::VM_EXEC as _;
+
+    /// Mapping is shared.
+    pub const SHARED: usize = bindings::VM_SHARED as _;
+
+    /// Mapping may be updated to allow reads.
+    pub const MAYREAD: usize = bindings::VM_MAYREAD as _;
+
+    /// Mapping may be updated to allow writes.
+    pub const MAYWRITE: usize = bindings::VM_MAYWRITE as _;
+
+    /// Mapping may be updated to allow execution.
+    pub const MAYEXEC: usize = bindings::VM_MAYEXEC as _;
+
+    /// Mapping may be updated to be shared.
+    pub const MAYSHARE: usize = bindings::VM_MAYSHARE as _;
+
+    /// Do not copy this vma on fork.
+    pub const DONTCOPY: usize = bindings::VM_DONTCOPY as _;
+
+    /// Cannot expand with mremap().
+    pub const DONTEXPAND: usize = bindings::VM_DONTEXPAND as _;
+
+    /// Lock the pages covered when they are faulted in.
+    pub const LOCKONFAULT: usize = bindings::VM_LOCKONFAULT as _;
+
+    /// Is a VM accounted object.
+    pub const ACCOUNT: usize = bindings::VM_ACCOUNT as _;
+
+    /// should the VM suppress accounting.
+    pub const NORESERVE: usize = bindings::VM_NORESERVE as _;
+
+    /// Huge TLB Page VM.
+    pub const HUGETLB: usize = bindings::VM_HUGETLB as _;
+
+    /// Synchronous page faults.
+    pub const SYNC: usize = bindings::VM_SYNC as _;
+
+    /// Architecture-specific flag.
+    pub const ARCH_1: usize = bindings::VM_ARCH_1 as _;
+
+    /// Wipe VMA contents in child..
+    pub const WIPEONFORK: usize = bindings::VM_WIPEONFORK as _;
+
+    /// Do not include in the core dump.
+    pub const DONTDUMP: usize = bindings::VM_DONTDUMP as _;
+
+    /// Not soft dirty clean area.
+    pub const SOFTDIRTY: usize = bindings::VM_SOFTDIRTY as _;
+
+    /// Can contain "struct page" and pure PFN pages.
+    pub const MIXEDMAP: usize = bindings::VM_MIXEDMAP as _;
+
+    /// MADV_HUGEPAGE marked this vma.
+    pub const HUGEPAGE: usize = bindings::VM_HUGEPAGE as _;
+
+    /// MADV_NOHUGEPAGE marked this vma.
+    pub const NOHUGEPAGE: usize = bindings::VM_NOHUGEPAGE as _;
+
+    /// KSM may merge identical pages.
+    pub const MERGEABLE: usize = bindings::VM_MERGEABLE as _;
+}

-- 
2.47.0.rc0.187.ge670bccf7e-goog


