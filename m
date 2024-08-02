Return-Path: <linux-kernel+bounces-272237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA6D94590A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E636C1F23385
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F3A335C0;
	Fri,  2 Aug 2024 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TqqHaZYQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D02482CA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584318; cv=none; b=BficuCIwD33046Gs0iK01tOdZ3jO30t+e3y8FlLHxO91v+wGWLBqw867602MaO+iTqF5kzGTJBPdJUSREONW/m3lg65HlenKsJfX8bBI4JgUsTm13d2Po/XaxNwLsJ/UVOwlUeYS+tCPH+aCYyyFmtxDDmRCBvIyQm/IWpJJ/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584318; c=relaxed/simple;
	bh=zYH2kSQSTgaZHywSUZy3Y0UUzcswVLX10m+2ESyG5Dc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VXxAMlGs0A+Zrs6vouox9qd6Al/au+ilOOK0V/C0JetaYZIxujWXU96f9COUil6OE4bILCqlgZTkLNwj/ikoe3brmRYs7kfgahR9Pjmq6sWqPsF6qxwQrE+ZEXqCWhcSKOoreGnSV/kV0rBdfIvMywPj9SJ2Aj+HjEKdUdXvlgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TqqHaZYQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65194ea3d4dso152516987b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722584315; x=1723189115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+UaMOCMWzIgLP4bM5jo8PyEmV4QCkV9smWm6IjHal00=;
        b=TqqHaZYQDJGUDGMBdDzxAXJJ2xKiExZz5d7DypjMLnrsTzU0+NRYk2IKAqeavEOIfY
         VuzzgI8lsbhcSAy7rKnXf5JW3LJuXbXUqDL05rviDpkFApkebVQdbQME5ezy5fqeOxCz
         ksSdh4DzT4uwJ0CID7ZTsxBLArWZ8IFQjvkBYXHvEjVcFSDxOOlQitfytxjrUCFkL2Xc
         T5vyal5enJ4F5p/edM9fR4Je868fvJUDBdi4ta0Q/t4QKARHZzYjUzTX5BeKW/4o70DJ
         btmY7ELveSQSlm926seqGXBYK8/+cDFhXKGMrXHWz0ozd3FBxFhWpwq/2HCF9XYRFEiQ
         5WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722584315; x=1723189115;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+UaMOCMWzIgLP4bM5jo8PyEmV4QCkV9smWm6IjHal00=;
        b=NYKGJGhZHpZsmpO6PG59JSLEJ5nOQkKuapqPqGlAIyW+0eBCy1b211tHYekqgQp8YH
         rZ7GCPnX5RCpB1FS7CS+2lQMTMFL0Fd+xVQfqoaP0ZaBCrYFZgGWyZS5y3kITMFuTKkg
         BwnRBCVSRcKFrtTNsQF3RR4FXfo6R6PGAZLBGXqgYuOQGt6ZzKPz7/BJ+HJl5t1douW4
         PvbJjGzGP3Us8j45sEr7aTagd2YCBENP1udeqsS8qwgsR/6PWXgB19z1QapXeRaOn4nt
         ewbA/HH8SgVt1ZknMWffd0msjRgICKCxsqhwvSgOmjWQ2egbXicRtdCGdJwjQG+nfQGl
         XWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoMsT6BGf+Eni7cPzlJuMRu5L8Wlyp/dxME39KHT7Tvlfue/HheugpvlXWsrcJMwdYpzzYV1fFOTnf+PbeAuGy1/W7vsZbORZucq+4
X-Gm-Message-State: AOJu0Yx1zu1PiCyYRT3M5FtlyGX5h62AYqvQZyxDsfbC2g2b9iOpFj8A
	GFPCC+X8U91bIrrP6/N/fZs4kH43heHJiYtBRKuwRVtMWfooh9w7QF2iSrwu1F5T2KHVkCH9jCh
	GJOXeEg6tP/yHCg==
X-Google-Smtp-Source: AGHT+IH1Q2uc7kXYMgsq1T6gmRRIcMs5nFk0klPBqAMl640rd8TT0t1B9sGrJQ/4+gdVJxekT5Z8mOgjQcqY69s=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:10:b0:64a:8aec:617c with SMTP
 id 00721157ae682-68959efadcfmr1720137b3.0.1722584315089; Fri, 02 Aug 2024
 00:38:35 -0700 (PDT)
Date: Fri, 02 Aug 2024 07:38:32 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPeMrGYC/2XOTQ6CMBCG4auQrq3pDwh15T2Mi6GdQhOhpjWNh
 nB3CyyUuPwmfd50IhGDw0jOxUQCJhedH/MoDwXRPYwdUmfyJoKJktVC0jQAtQ3jXFllW1mR/PI
 R0LrXWrne8u5dfPrwXqOJL9e9T5xyKgWYCnKoQbx03nd3PGo/kCWQxC+qNyQyglZipURttIQ/J L8of3BDMiPTnjTXDKwBtUPzPH8Am02sSwEBAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=23640; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=zYH2kSQSTgaZHywSUZy3Y0UUzcswVLX10m+2ESyG5Dc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmrIz4IB0m/xiqb7+/Ivny8+Cb1D2iA/9iISF8w
 i4e2cauxxmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqyM+AAKCRAEWL7uWMY5
 RtBHD/9i8sFBYwHK5o+AZ4ZSID5y+G1z6qn9lMoNxRgOnFvm45XAzbVk9RTh7uzab8zIgdREeAk
 nycMj9Qpe1qe23ciOhAMLRYUjXcvyU60GNHLk3gT7cMEkAlJnthOA4Y22MylJmhP9wuTaVvTvG5
 sCtPRj+NJx/jiHDR1r+4u9mPzh9RqrMbwUlKWscIXUPJ5yjIB+mOPT5Q73Q3t5+jOzcERhCT2q/
 tv+th4gRZ8ZmJur/zFhDLJQ3AtSHmJOnKK5o/p0qv1Wpuyq38Ui/C861xNKUdMKRVE/5t8d8Pc6
 WC2Fri6I/tfm/9Mb5mztZBKhK01RARyCBBP9Qgq9tkeQZLi4VVhQC19xsK4eVr0ufnjvaD3XJ3q
 VngUTXfYhJK1l5QaUzvbz+nDiwlzYVKjnME4z2hF0vAni98Su3pYusxUg37zbv5DhU3W3y0GE4a
 sN549SRqx28IHL5NMh5Wg623ooiAoWRVoSEGw5bh2QsZnR0cuy5VjvsGvPktinLQV4nw1be1/6g
 jlgvPNKfqN0n0VI9OVZNr03XITdc4LxX0LuhrtCm3eCEZvEKJBg5oMENVXs2oXcMtlSKzUB8J7R
 bsjS9YmQyVfVheyPQyawa/TKW+aCLawtwP9NnZ/Z718ZV+QfXZWGP6DUODW9QRB4VpIdPyGHLeu unT0eMvoQKoM4Gg==
X-Mailer: b4 0.13.0
Message-ID: <20240802-vma-v4-1-091a87058a43@google.com>
Subject: [PATCH v4] rust: mm: add abstractions for mm_struct and vm_area_struct
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This is a follow-up to the page abstractions [1] that were recently
merged in 6.11. Rust Binder will need these abstractions to manipulate
the vma in its implementation of the mmap fop on the Binder file.

This patch is based on Wedson's implementation on the old rust branch,
but has been changed significantly. All mistakes are Alice's.

Link: https://lore.kernel.org/r/20240528-alice-mm-v7-4-78222c31b8f4@google.com [1]
Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This change depends on:
https://lore.kernel.org/all/20240801-aref-into-raw-v1-1-33401e2fbac8@google.com/
---
Changes in v4:
- Pull out ARef::into_raw into a separate patch.
- Update invariants and struct documentation.
- Rename from_raw_mm to from_raw.
- Link to v3: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@google.com

Changes in v3:
- Reorder entries in mm.rs.
- Use ARef for mmput_async helper.
- Clarify that VmArea requires you to hold the mmap read or write lock.
- Link to v2: https://lore.kernel.org/r/20240727-vma-v2-1-ab3e5927dc3a@google.com

Changes in v2:
- mm.rs is redesigned from scratch making use of AsRef
- Add notes about whether destructors may sleep
- Rename Area to VmArea
- Link to v1: https://lore.kernel.org/r/20240723-vma-v1-1-32ad5a0118ee@google.com
---
 rust/helpers.c         |  61 +++++++++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/mm.rs      | 343 +++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs | 204 +++++++++++++++++++++++++++++
 4 files changed, 609 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 92d3c03ae1bd..97300f34505f 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -200,6 +200,67 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_krealloc);
 
+void rust_helper_mmgrab(struct mm_struct *mm)
+{
+	mmgrab(mm);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mmgrab);
+
+void rust_helper_mmdrop(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mmdrop);
+
+void rust_helper_mmget(struct mm_struct *mm)
+{
+	mmget(mm);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mmget);
+
+bool rust_helper_mmget_not_zero(struct mm_struct *mm)
+{
+	return mmget_not_zero(mm);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mmget_not_zero);
+
+void rust_helper_mmap_read_lock(struct mm_struct *mm)
+{
+	mmap_read_lock(mm);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mmap_read_lock);
+
+bool rust_helper_mmap_read_trylock(struct mm_struct *mm)
+{
+	return mmap_read_trylock(mm);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mmap_read_trylock);
+
+void rust_helper_mmap_read_unlock(struct mm_struct *mm)
+{
+	mmap_read_unlock(mm);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mmap_read_unlock);
+
+void rust_helper_mmap_write_lock(struct mm_struct *mm)
+{
+	mmap_write_lock(mm);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mmap_write_lock);
+
+void rust_helper_mmap_write_unlock(struct mm_struct *mm)
+{
+	mmap_write_unlock(mm);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mmap_write_unlock);
+
+struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
+					      unsigned long addr)
+{
+	return vma_lookup(mm, addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_vma_lookup);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 274bdc1b0a82..6c8bac65845e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
new file mode 100644
index 000000000000..ee497da73ae7
--- /dev/null
+++ b/rust/kernel/mm.rs
@@ -0,0 +1,343 @@
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
+        let mm = NonNull::new(mm)?;
+
+        // SAFETY: We just checked that `mm` is not null.
+        unsafe { bindings::mmgrab(mm.as_ptr()) };
+
+        // SAFETY: We just created an `mmgrab` refcount. Layouts are compatible due to
+        // repr(transparent).
+        Some(unsafe { ARef::from_raw(mm.cast()) })
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
+    pub fn is_same_mm(&self, area: &virt::VmArea) -> bool {
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
+    pub fn vma_lookup(&self, vma_addr: usize) -> Option<&virt::VmArea> {
+        // SAFETY: We hold a reference to the mm, so the pointer must be valid. Any value is okay
+        // for `vma_addr`.
+        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr as _) };
+
+        if vma.is_null() {
+            None
+        } else {
+            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
+            // the returned area will borrow from this read lock guard, so it can only be used
+            // while the read lock is still held. The returned reference is immutable, so the
+            // reference cannot be used to modify the area.
+            unsafe { Some(virt::VmArea::from_raw_vma(vma)) }
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
+    pub fn vma_lookup(&mut self, vma_addr: usize) -> Option<&mut virt::VmArea> {
+        // SAFETY: We hold a reference to the mm, so the pointer must be valid. Any value is okay
+        // for `vma_addr`.
+        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr as _) };
+
+        if vma.is_null() {
+            None
+        } else {
+            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
+            // the returned area will borrow from this write lock guard, so it can only be used
+            // while the write lock is still held. We hold the write lock, so mutable operations on
+            // the area are okay.
+            unsafe { Some(virt::VmArea::from_raw_vma_mut(vma)) }
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
index 000000000000..ec8cadb09626
--- /dev/null
+++ b/rust/kernel/mm/virt.rs
@@ -0,0 +1,204 @@
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
+/// A wrapper for the kernel's `struct vm_area_struct`.
+///
+/// It represents an area of virtual memory.
+///
+/// # Invariants
+///
+/// * If the caller has shared access to this type, then they must hold the mmap read lock.
+/// * If the caller has exclusive access to this type, then they must hold the mmap write lock.
+#[repr(transparent)]
+pub struct VmArea {
+    vma: Opaque<bindings::vm_area_struct>,
+}
+
+impl VmArea {
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
+    /// (or write lock) is held for at least the duration of 'a.
+    #[inline]
+    pub unsafe fn from_raw_vma<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
+        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
+        unsafe { &*vma.cast() }
+    }
+
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap write
+    /// lock is held for at least the duration of 'a.
+    #[inline]
+    pub unsafe fn from_raw_vma_mut<'a>(vma: *mut bindings::vm_area_struct) -> &'a mut Self {
+        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
+        unsafe { &mut *vma.cast() }
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
+    /// Sets the flags associated with the virtual memory area.
+    ///
+    /// The possible flags are a combination of the constants in [`flags`].
+    #[inline]
+    pub fn set_flags(&mut self, flags: usize) {
+        // SAFETY: By the type invariants, the caller holds the mmap write lock, so this access is
+        // not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags as _ };
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
+    /// Make this vma anonymous.
+    #[inline]
+    pub fn set_anonymous(&mut self) {
+        // SAFETY: By the type invariants, the caller holds the mmap write lock, so this access is
+        // not a data race.
+        unsafe { (*self.as_ptr()).vm_ops = core::ptr::null() };
+    }
+
+    /// Maps a single page at the given address within the virtual memory area.
+    ///
+    /// This operation does not take ownership of the page.
+    #[inline]
+    pub fn vm_insert_page(&mut self, address: usize, page: &Page) -> Result {
+        // SAFETY: By the type invariants, the caller holds the mmap write lock, so this access is
+        // not a data race. The page is guaranteed to be valid and of order 0. The range of
+        // `address` is already checked by `vm_insert_page`.
+        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address as _, page.as_ptr()) })
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

---
base-commit: ef0f6dbf36d56c3a72264b316e120e58e4805da6
change-id: 20240723-vma-f80119f9fb35

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


