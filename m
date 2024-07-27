Return-Path: <linux-kernel+bounces-264017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632D693DDEA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9ED1C21615
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16824433DC;
	Sat, 27 Jul 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R92biUoN"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7064A381D4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722070989; cv=none; b=aMVMHLVmxVMJvw8Tgfh+C02kjcZV6R3hjIhj57IojDXKoCXpBZ8Ulo/1Kk88wC8tgL0aWuhCXytvcVjgYXTae6M1gNliQMo2ySlZK0nvfXjTiYR0xNwaZkf6rOvTxq+tB2aeHYEreX2J9CLQ+eescICDkI2msYGkpORlPQExP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722070989; c=relaxed/simple;
	bh=2jAnQ+Mj54soanof2b2IodM75IcnBD3IoxW3HnpSVMQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rid8d5s2JK0QsUxbUKG2UU36J9S49EYreLVyEQM8X+aA6XH0w0ok4uup8TS0jk1Zrvth1aRcyvPYxojb7jaSOLLPyvIGicGwb1N5k8KY0iQ86WqLM0sc123LJN5xrZ7gErJlgt9L1TLWvAyiUtbB/Ek/pbkO4uZMFWHA0HPeGT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R92biUoN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664aa55c690so13935627b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722070985; x=1722675785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=amnmit01xBmRSFGd7PIgnlHscQiD3s0tRRVe9bRcPf8=;
        b=R92biUoN8SoPDvQ9eZGy2IhxpexQOTVji4dEBfDnJjhoxQZV6m1T5wASRwtCwq+zCF
         x4oXZDC1bB38OakMj7nBGmNOLgFSjV4D5YfbZZYFpp6uxgHvLHgGYgdD6Wpp6cYqsmGS
         jp4NfrwHuSXrrglEr8y9rPk6Go8zqp/U7oF5nxFFXvsL98dirADLaJvRntyaoS8JTUb3
         UzKhT4J29E6GbFYO6/dmmOanx5KReaEWR0su3J0M7PsF3yxkXkyqUpBtGcTBoVJ02a1c
         Og1TMpt96+w/CCxlRD2foZeLm7CjWeK5qWOFHMVyde1C0XFh8PWoamnHOjr3R1fvmGJ0
         Rl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722070985; x=1722675785;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=amnmit01xBmRSFGd7PIgnlHscQiD3s0tRRVe9bRcPf8=;
        b=cGGD46VBp9EGFCtraXz43RN8vO3ALfo8AQTwDC6/LzsdS/IHD0jWHUL6fN+V70qZrj
         saUI/ZPc2qsAyuF9AiZ/9qJv1yS1CKBv6nMt6eb0KWJwA0UVATktPnfUdYbovYcyFh0L
         D4hpWVyzPAbfPAAx1AHOjTgQKbfO03DKcaSLePlfTwgopwjeplLD1iPi9Eyd5U1s4Xda
         rO/Zy5gQ88ro+7jcona+r8fijpFPaninfJHEZwEIkQj3HmSG1V4uE2Zvbo7uc40GhdVf
         HXuEILViSapFR0xtajimvBd2QsCujA3p8fQ7BLFkf1Nxao08LroigllQK/gKHi5FAMSE
         McGg==
X-Forwarded-Encrypted: i=1; AJvYcCXOQj/qooZWQW3fM1lr+7/UvzWZQFAohuXDqTbo1QH8PIUinPcJoCB6pJEgab6bSV9q8vA9devBF6WF/V4QNBR0SktUEhwLgspnj/Nc
X-Gm-Message-State: AOJu0YzqeGHnqeR7ypJUVojLHl49pSHP5J9SrcJeHGi8g1PzTFw0A9Zm
	ZT1K2nlBpQ6SmQ7QPpLW218rRjALnPzgvnw+mhW0Ttib5iqTvoVItppraMKlnMrx3QFsGe8hHXJ
	/EVNLqRmBEX/e8w==
X-Google-Smtp-Source: AGHT+IGJZbkSTgSNzuICE4FkNF0bC5DXtVy19tevln3MpQ+dr32zBBtTwFoTxQ0D879MfEKPIBTGeWyjq9AZXhE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:2b81:b0:62c:67f4:4f5 with SMTP
 id 00721157ae682-67a0a7fdf7emr293227b3.9.1722070985337; Sat, 27 Jul 2024
 02:03:05 -0700 (PDT)
Date: Sat, 27 Jul 2024 09:03:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMW3pGYC/1WMyw6CMBBFf4XM2jF9SARX/odhUWFaJhHGtKbRk
 P67lZ3Lc3PP2SBRZEpwaTaIlDmxrBXMoYFxdmsg5KkyGGVO6mws5sWh75TWve/93bZQn89Int9 75TZUnjm9JH72aNa/9d/PGjVa46bW1VBHdA0i4UHHURYYSilffFp6JpcAAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=22908; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2jAnQ+Mj54soanof2b2IodM75IcnBD3IoxW3HnpSVMQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmpLfGvIh2/eiJwCrumvRcagFiw1Fi9eFyjMDvL
 gRBoTqru2uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqS3xgAKCRAEWL7uWMY5
 RkNIEACq6pN5nrt3pMOKJpsPn0K/paIqZS/xw0CEfPxso6dFnWgnt2LdEWnD+Ul7N/27OXwsmmL
 emwOXvgyUwHFzw0auz+xT5ylk5b2VMw7ciYu6c7tlJaZcX+MdfVNaxjXFzuAkjw93LV3dPa3uCo
 pwFBDLvvyUh6O7+WHt9iI82gPNZrD+yr6IgnpZDNhZd5sS4ztRf4WgHP7HlF7gxw+k7jQtzUER5
 TrdNQKkYWzMpHHaw8mGOk4+FQgbG7qketxaCqKrbGVKLESkevIDWOBhw30Q3RqVPK/3B6B81csn
 s5G0aq1TuuW82KcwLKAvKa8N4VWOS0kYmsHOs1xXl6xNpUNt05n3LD3L0x0Zk+0bQl5KJ0PHYQi
 6UJ2hvmrxRgf73xD17pQnhzLgDBBcR3eMAUKiCY5jdG6Xve8FX/Z8Qt1OmjBiN03XLeldAwej9+
 hddaEPsl/QiUWlWmubq5VkZO09ya4sqxaAjt6iwRRn4ks4D1DwckywCSTl7uEH3bPaA8rvUylMU
 2e9VreMPE8/139Z7ARzHEooiwQtLgZ05AC2pbtS48WCAOew7F0hzlGx+JH/N8eaMdMP8qVxh32h
 tgCGURd9gaWkKIIgRh3Z/Ee6fAnloT1wg5JwK7iKH3ERB/fPzd29/rIaBoGhZMvEXoaerGT7ckd 2NKGFuDc5/vqUvA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240727-vma-v2-1-ab3e5927dc3a@google.com>
Subject: [PATCH v2] rust: mm: add abstractions for mm_struct and vm_area_struct
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
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
Changes in v2:
- mm.rs is redesigned from scratch making use of AsRef
- Add notes about whether destructors may sleep
- Rename Area to VmArea
- Link to v1: https://lore.kernel.org/r/20240723-vma-v1-1-32ad5a0118ee@google.com
---
 rust/helpers.c         |  61 +++++++++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/mm.rs      | 335 +++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs | 199 +++++++++++++++++++++++++++++
 rust/kernel/types.rs   |   9 ++
 5 files changed, 605 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 305f0577fae9..d2205f980112 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -199,6 +199,67 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
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
index 5d310e79485f..3cbc4cf847a2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -33,6 +33,7 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
new file mode 100644
index 000000000000..ffa778384b6b
--- /dev/null
+++ b/rust/kernel/mm.rs
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Memory management.
+//!
+//! C header: [`include/linux/mm.h`](../../../../include/linux/mm.h)
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
+/// Since `mm_users` may be zero, the associated address space may not exist anymore. You must use
+/// [`mmget_not_zero`] before accessing the address space.
+///
+/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destructor may sleep.
+///
+/// # Invariants
+///
+/// Values of this type are always refcounted.
+///
+/// [`mmget_not_zero`]: Mm::mmget_not_zero
+pub struct Mm {
+    mm: Opaque<bindings::mm_struct>,
+}
+
+/// A wrapper for the kernel's `struct mm_struct`.
+///
+/// This type is used only when `mm_users` is known to be non-zero at compile-time. It can be used
+/// to access the associated address space.
+///
+/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. Its destructor may sleep.
+///
+/// # Invariants
+///
+/// Values of this type are always refcounted. The value of `mm_users` is non-zero.
+#[repr(transparent)]
+pub struct MmWithUser {
+    mm: Mm,
+}
+
+/// Equivalent to `ARef<MmWithUser>` but uses `mmput_async` in destructor.
+///
+/// The destructor of this type will never sleep.
+///
+/// # Invariants
+///
+/// `inner` points to a valid `mm_struct` and the `ARefMmWithUserAsync` owns an `mmget` refcount.
+pub struct ARefMmWithUserAsync {
+    inner: NonNull<bindings::mm_struct>,
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
+    pub unsafe fn from_raw_mm<'a>(ptr: *const bindings::mm_struct) -> &'a Mm {
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
+    pub unsafe fn from_raw_mm<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
+        // SAFETY: Caller promises that the pointer is valid for 'a. The layout is compatible due
+        // to repr(transparent).
+        unsafe { &*ptr.cast() }
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
+// SAFETY: It is safe to call `mmdrop` on another thread than where `mmgrab` was called.
+unsafe impl Send for Mm {}
+// SAFETY: All methods on `Mm` can be called in parallel from several threads.
+unsafe impl Sync for Mm {}
+
+// SAFETY: It is safe to call `mmput` on another thread than where `mmget` was called.
+unsafe impl Send for MmWithUser {}
+// SAFETY: All methods on `MmWithUser` can be called in parallel from several threads.
+unsafe impl Sync for MmWithUser {}
+
+impl From<ARef<MmWithUser>> for ARefMmWithUserAsync {
+    fn from(mm: ARef<MmWithUser>) -> ARefMmWithUserAsync {
+        ARefMmWithUserAsync {
+            inner: ARef::into_raw(mm).cast(),
+        }
+    }
+}
+
+impl From<ARefMmWithUserAsync> for ARef<MmWithUser> {
+    fn from(mm: ARefMmWithUserAsync) -> ARef<MmWithUser> {
+        let ptr = mm.inner;
+        // Skip the destructor.
+        core::mem::forget(mm);
+
+        // SAFETY: We skipped the destructor, so we can transfer ownership of the refcount to the
+        // `ARef`.
+        unsafe { ARef::from_raw(ptr.cast()) }
+    }
+}
+
+// Make MmWithUser methods available on ARefMmWithUserAsync values.
+impl Deref for ARefMmWithUserAsync {
+    type Target = MmWithUser;
+
+    fn deref(&self) -> &MmWithUser {
+        // SAFETY: The signature of this method ensures that `self` outlives the returned
+        // reference. Since `self` owns an `mmget` refcount, `m_users` will remain non-zero for the
+        // duration of the returned reference.
+        unsafe { MmWithUser::from_raw_mm(self.inner.as_ptr()) }
+    }
+}
+
+impl Drop for ARefMmWithUserAsync {
+    fn drop(&mut self) {
+        // SAFETY: Values of this type own an `mmget` refcount by the type invariants.
+        unsafe { bindings::mmput_async(self.as_raw()) };
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
index 000000000000..2e97ef1eac58
--- /dev/null
+++ b/rust/kernel/mm/virt.rs
@@ -0,0 +1,199 @@
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
+    /// Callers must ensure that `vma` is valid for the duration of 'a, with shared access. The
+    /// caller must ensure that using the pointer for immutable operations is okay.
+    #[inline]
+    pub unsafe fn from_raw_vma<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
+        // SAFETY: The caller ensures that the pointer is valid.
+        unsafe { &*vma.cast() }
+    }
+
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is valid for the duration of 'a, with exclusive access. The
+    /// caller must ensure that using the pointer for immutable and mutable operations is okay.
+    #[inline]
+    pub unsafe fn from_raw_vma_mut<'a>(vma: *mut bindings::vm_area_struct) -> &'a mut Self {
+        // SAFETY: The caller ensures that the pointer is valid.
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
+        // SAFETY: The pointer is valid since self is a reference. The field is valid for reading
+        // given a shared reference.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags as _ }
+    }
+
+    /// Sets the flags associated with the virtual memory area.
+    ///
+    /// The possible flags are a combination of the constants in [`flags`].
+    #[inline]
+    pub fn set_flags(&mut self, flags: usize) {
+        // SAFETY: The pointer is valid since self is a reference. The field is valid for writing
+        // given an exclusive reference.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags as _ };
+    }
+
+    /// Returns the start address of the virtual memory area.
+    #[inline]
+    pub fn start(&self) -> usize {
+        // SAFETY: The pointer is valid since self is a reference. The field is valid for reading
+        // given a shared reference.
+        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_start as _ }
+    }
+
+    /// Returns the end address of the virtual memory area.
+    #[inline]
+    pub fn end(&self) -> usize {
+        // SAFETY: The pointer is valid since self is a reference. The field is valid for reading
+        // given a shared reference.
+        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_end as _ }
+    }
+
+    /// Make this vma anonymous.
+    #[inline]
+    pub fn set_anonymous(&mut self) {
+        // SAFETY: The pointer is valid since self is a reference. The field is valid for writing
+        // given an exclusive reference.
+        unsafe { (*self.as_ptr()).vm_ops = core::ptr::null() };
+    }
+
+    /// Maps a single page at the given address within the virtual memory area.
+    ///
+    /// This operation does not take ownership of the page.
+    #[inline]
+    pub fn vm_insert_page(&mut self, address: usize, page: &Page) -> Result {
+        // SAFETY: The page is guaranteed to be order 0. The range of `address` is already checked
+        // by `vm_insert_page`. `self.vma` and `page.as_ptr()` are guaranteed by their respective
+        // type invariants to be valid.
+        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address as _, page.as_ptr()) })
+    }
+
+    /// Unmap pages in the given page range.
+    #[inline]
+    pub fn zap_page_range_single(&self, address: usize, size: usize) {
+        // SAFETY: The pointer is valid since self is a reference. Any value of `address` and
+        // `size` is allowed.
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
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index bd189d646adb..143a2bf06941 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -366,6 +366,15 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
             _p: PhantomData,
         }
     }
+
+    /// Pass ownership of the refcount to a raw pointer.
+    pub fn into_raw(self) -> NonNull<T> {
+        let ptr = self.ptr;
+        // Skip the destructor.
+        core::mem::forget(self);
+
+        ptr
+    }
 }
 
 impl<T: AlwaysRefCounted> Clone for ARef<T> {

---
base-commit: b1263411112305acf2af728728591465becb45b0
change-id: 20240723-vma-f80119f9fb35

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


