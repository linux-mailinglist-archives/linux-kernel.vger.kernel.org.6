Return-Path: <linux-kernel+bounces-363693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF2899C5B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7F41C224AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7EF15B119;
	Mon, 14 Oct 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eEq3Y4kY"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A74145B2D
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898218; cv=none; b=Fk0OjBJ1Htter2Kmq5Sgbs5ft4B5IsQ/E8R7/GUpofX1WGK90LNju5+brt0qRx1DKo3GNZOyf4dVrmGHEIt1KN/ZQgx8Td/tmet9b4fR7weovgHrW6DTrVwS+lWZlGMUPLMgs6Nra+GqY0bYpu2KL7NWLNazt3t0e/8g4MTTpRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898218; c=relaxed/simple;
	bh=Z8bzMjaVsSMqPWHSmOvumICaLsyxOJYUPF2LOz8HHmY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XZdIQK3/RyzI1BHTDX/0OlL9mS5mF7PsnSRXpDv28aFydpmmzEQ5K861uvmNCNxgq6+Rf9Cm1KHXN6qyM6aMWzEnCmc7QGYRdsEajKkzeyPZ1q0aYPE/VF0B2hlylojsmLRAPbyiz7z8TBnXnyOytlPJswkjk+GpZloEp1ppu1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eEq3Y4kY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e36cfed818so14868437b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 02:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728898214; x=1729503014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ18iLuyZBTTVH+ETMD2B1rswqkjZKIT0HDvEYBeRoQ=;
        b=eEq3Y4kYrOLXJDSFUUG1P08y+zOa8luVkudXaXWtTSN4g9pJFeFXGOWDIYIevoVo1i
         xhCuXXM25yYbsOcpN9Ghd3QU/rXY+ELb/UJbEeLBjUxde1ZGZnHqCHxUCAoNx1yL4C0q
         Jk9dLbIXqf26gpAEWpoQ7FENoPnX5b7s5vSd3zylQMqYqiLwrJlT+qgJik+pNshJp1Vx
         q5d3uW8D5CDlqFXXHsaJo74NMajIoiKHfz1pUIePhfmah4b0wmLx+EmnSzG0jO8XeaZ9
         rXJzKK5Q1//JGmcQHUkuLEwWH0zD+NDd3XXhK3fgadJt2t6tE1uab4aEihScIwfG7Rxq
         C+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728898214; x=1729503014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ18iLuyZBTTVH+ETMD2B1rswqkjZKIT0HDvEYBeRoQ=;
        b=ixJuKTheJEZ2BMlU4ZEvX+nWAwJO9giDAjoFrgBhoX4oEei4UZgytvUepblJEtx+2e
         8fS+858sC73ZoaLXsPtbT04NU0SpEbyt6h8SwOvgLkFERjsrVHot9eapGHZSF6sPgmKU
         +OR/Qg1/K4t6uvphJHFIUVyxoef6/V84BKsVE9Rah8VQvT89MMHgJ+DMcUTXCmCxS2aq
         8Dnghrmsum2PeSYTfuETHx7JGBMsPi5+9mx7R9R9kDzasvUkvHcmTyc8sspjgrJsj5tY
         H0rGoOCZ8PlXZg9U18tM0xBXMYewBGbrkHtTOwM4nfFx2EcYzu/mJRSpnyC6vKrL4EcQ
         7PdA==
X-Forwarded-Encrypted: i=1; AJvYcCXfAS1V66891aDTZBSWcXdtpbq85WDlZLODB6du7nzvy5VxQLZcjovHsEWzRdKUly05fElwA+EEjSYAnas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcIU0yj/exByAl1+zTtaH6Wb78dwY73VTeN25D0CDMbJ+CnBoz
	RlfIaN6u44R87rbfXEwa00jd6LLsbmoKD0qtiv2IXcQHoCpSA3jOwU7sO1FcRw3OrdQqN2F03rl
	q857Q8dKa9/bZcg==
X-Google-Smtp-Source: AGHT+IFby4bqa3fvNM7Y8GFcAHvfPiSjgomnWSuPGo/mj7wUqwfMDiwO1UlkAooUyG3l1JSV4kxQ/8jakuEpOGc=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:4d8a:b0:6b2:6cd4:7f9a with SMTP
 id 00721157ae682-6e347c9a830mr4742357b3.8.1728898213821; Mon, 14 Oct 2024
 02:30:13 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:29:51 +0000
In-Reply-To: <20241014-vma-v7-0-01e32f861195@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241014-vma-v7-0-01e32f861195@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=25627; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Z8bzMjaVsSMqPWHSmOvumICaLsyxOJYUPF2LOz8HHmY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnDOSfT8H4ZxpfsYOr5npH0oD63eUmqxZVOFKBt
 j4omWKc0Z6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZwzknwAKCRAEWL7uWMY5
 Rs+7D/9SKyeYdudqaoQqqCCFH/WnYxj5Zkcy7iJW1OL8DJAV98RwVxwdms3HFZvtsjlu9DU0q0T
 uEJE/0ALzlxyQ6538cMD4lSeU4e+dnG956pCKL2uUIU+nsTKx/QIPdM9ThHe8v2SJrbKPbs6Pvr
 kPcrd1aMlBv7qLllCOzNKpgU9THlv95cYKGj9UFapP6pXeotXKKtesOu5fqYQ0rcaZVpf5bgTvR
 x1VDXZy1xcc/e7x4w7mF9FTmmRQ1bduZJ0/+47fdStEBRQLFl0wCHktI78xmGVu+60rrv8oRG9S
 PVKgEE0+jaBPIP8YqBGfZmWdGuN+UBfWO02Ekc2wh7h68bTys8+HQmvqz/Xhx8JwdjVPmNoQn92
 EyAaNI4gorACkdmP09n4OygX5EyKb6WcKgWipvz5jSG+YmmEGHJu+bFVA2VsCzF4OG4SQkZiBeG
 4W62fYITETlaANo/+bnDXAzJPk6h7OhDI0/RgMF4YtnmIleaLTSkPjyrTPSukQjTKB1ZyWU548S
 RB3Q6h7v0T5Txtwv5f2z7ju7ySgWT7RJL0k7mUTKM+fTSD9XL/IReVZcD+GBLMdxox1VZoPmtXH
 pYwwVKe063kbX1L5yjgYxyv57oEQwvaFvgiKJ2XAuBl3JIe1y+lsisECejB/w55ZidJsTI/G9MQ VoY7s4BCwDbxRYQ==
X-Mailer: b4 0.13.0
Message-ID: <20241014-vma-v7-1-01e32f861195@google.com>
Subject: [PATCH v7 1/2] rust: mm: add abstractions for mm_struct and vm_area_struct
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
 rust/kernel/mm.rs      | 357 +++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs | 264 ++++++++++++++++++++++++++++++++++++
 5 files changed, 678 insertions(+)

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
index 000000000000..818ff2fd5265
--- /dev/null
+++ b/rust/kernel/mm.rs
@@ -0,0 +1,357 @@
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
+    pub fn mmap_write_lock(&self) -> MmapWriteGuard<'_> {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmap_write_lock(self.as_raw()) };
+
+        // INVARIANT: We just acquired the write lock.
+        MmapWriteGuard {
+            mm: self,
+            _nts: NotThreadSafe,
+        }
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
+/// This `MmapReadGuard` guard owns the mmap read lock.
+pub struct MmapReadGuard<'a> {
+    mm: &'a MmWithUser,
+    // `mmap_read_lock` and `mmap_read_unlock` must be called on the same thread
+    _nts: NotThreadSafe,
+}
+
+impl<'a> MmapReadGuard<'a> {
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
+impl Drop for MmapReadGuard<'_> {
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
+/// This `MmapReadGuard` guard owns the mmap write lock.
+pub struct MmapWriteGuard<'a> {
+    mm: &'a MmWithUser,
+    // `mmap_write_lock` and `mmap_write_unlock` must be called on the same thread
+    _nts: NotThreadSafe,
+}
+
+impl<'a> MmapWriteGuard<'a> {
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
+impl Drop for MmapWriteGuard<'_> {
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
2.47.0.rc1.288.g06298d1525-goog


