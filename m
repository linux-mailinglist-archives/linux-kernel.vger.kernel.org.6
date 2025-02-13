Return-Path: <linux-kernel+bounces-512750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00916A33D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37411642CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF6A214206;
	Thu, 13 Feb 2025 11:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHzhgZ4s"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A46E2144A0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444685; cv=none; b=krXG3VFuQA2sOHqpkTuwaPb2UYis0xOGmR5teaidk2jbroO76dFPSNztqo2RPnS8pif3Z7BbqAzpevgEJQNkof/IjB1u34JntL5BS96n4HtOrXh0TUapoiNkSuC7iNFGG1nbAuZZH7xyy5aGXK0wWJdlOBvhX+zofbcoelVfBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444685; c=relaxed/simple;
	bh=Q0RIStyPwKILnX2Vrxa7XEF9eaYk5DS6vlU3U+wI2SI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SMSfJDvVnB1GNGrFov1OatauvbidWeVM7O/i3o/2el1c8w3fO81CKDUDc6evN0n9XEtbRoqAvD+f4CPnCZcat6XoZMuCHfebCsRAshxjsO5OSsqsT4cX/plkN58X3hQyewQ+BbEgJRdfHhIeq9bQUpA/eU/H7l8ywsD6bMOOvNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHzhgZ4s; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43935e09897so5399745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739444681; x=1740049481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=za3474x0ZF8AMlWXSEpyVL59vkrxbiA4YbQOJZDWTjE=;
        b=xHzhgZ4slyL4IiMwPNyHdkuTs6geuUXsF127YGxxJXOPc0nwkEpVpL07Jmaedwnaay
         QKKLp28qNkZfqpmJ8ywqzwDQs6toJbESJgBzW5lwYCO1LWwTISaQzk2uR7ObEWba6eXu
         gquNlCBy2geTKrSaycxjoWVlx2KE4KSujXeIjo6LtsZRsr1yFgpW60jHZe461DKWPsXA
         BrnpHWR8v4CEd0tAgAYn3wa/66jmn1hSsxgQHSttup0sLBP39TIzCZdxDZ3aMP8sBhH1
         XEOSwqkHFZDj2zBqA7Zow6iRMmhsp126PE3n47AxdABc1OAuhORiVVxzLD/kPuI+ot1x
         tH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739444681; x=1740049481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=za3474x0ZF8AMlWXSEpyVL59vkrxbiA4YbQOJZDWTjE=;
        b=GH/IY/sIwnH+uoODEyu79ujuuQ5RUAsC1qOxio3dytcU65OegTw/ZTIpT8lk+J1CGS
         p8492Z+Jz2lE1CSeOfWxTZz15Dele9mi441Jsv8ivj0ftHL4I9hVUlLHkHaN3HX8f+Wc
         Q+zEjSjjXOTlKh3Vf4DwTtHHZ47AUFKXhvFvUSPILc3+cft3s8FL2/nwcDolhbY/LX79
         G6LWKIVJX7evO7RnbXqb7fl/Rh3vxAocTm/k0M1Fj/viFnus9VwXB4nHljKCnJC3vpvm
         qObxcLLpdcwKau+vXM97DlGu7A2KK4tPxS2TQxFnI0areie/SWN4bL/i/5IiU6JXTUId
         HXBw==
X-Forwarded-Encrypted: i=1; AJvYcCXG7rTmvXZHNarjGqBrjmT9KQF9bBpl5lIYMWJ4jGRiMOyAbfxqKl5UrjJVVUKF3EF/Ze0pZ0zPc0VkY8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXQH+C9l3nV8Sr92yESbJ6yjLqmQGg+sdHExZBSU8GpQoCHqg
	a08Niian4KcTPvdcUcjb6a7kxlwQzR8JtvDiQlaADU5CANhuIkKLdNjYPGh3uJ25mr99sR4gcYp
	xpV09zQJ6I2twJQ==
X-Google-Smtp-Source: AGHT+IFqQez3BgoQ7uNF4wdhzNnxr+PJ45L8RFg6wDi/c48ndpBoPVBo6FJ8W7vBko0MJMPWmUUseOsLeSI1Ix8=
X-Received: from wmbhg21.prod.google.com ([2002:a05:600c:5395:b0:438:e219:3af5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6d02:0:b0:38d:e092:3d18 with SMTP id ffacd0b85a97d-38dea2fa0bemr6387327f8f.50.1739444681571;
 Thu, 13 Feb 2025 03:04:41 -0800 (PST)
Date: Thu, 13 Feb 2025 11:04:01 +0000
In-Reply-To: <20250213-vma-v14-0-b29c47ab21f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11820; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Q0RIStyPwKILnX2Vrxa7XEF9eaYk5DS6vlU3U+wI2SI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnrdG+2HO72aNkovdBvp3nh2Z3b2jBiNHTe+tqw
 Gxn7dLgjsyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ63RvgAKCRAEWL7uWMY5
 RhIKD/4whgGT2Jm8XqQ/u4jOaeumFx8NScl5ogOyGNK8zZE+jXjy8Oz+TgqxjHe7H+HRKfu8i28
 aWz7Dyts7C3Lv2/bxafa2+6D5UZXQJ9cCjCp+iv0sExbz481iaIgCOQRrv+avMXzxfg+UYOo6ze
 WukLXyjJP6Xmj1kCLPJL9g95WYH/mAR3r36vfW5RmHGX5m5hjfXglA5NE1sguHGUat+pOZxv8qM
 VMDq3nbd4/O7WNNJVmc613d2m4I6FotyyRKP0PN2N/7IVeQoZ6vyZkHR6CjI6eYaXRSTsYy2XzY
 LybS//m56IDMY2S2M0Z3yhwdGQG41gk7xTPOP2ELlCnUE0nKaaKaWV2y1tcV7dBNVOj4ZTNaspE
 5i0UBvdaGyalGeYgXIPuTZJZXNR/oN+PHQgl1Dw6gPlyUqo3tP7gvH8Ce2fm0ai4wLD86dSSwp/
 X3T1BTVLHbciDkzEUIiifAQrcKGJrdrh3f06rdAia4sozXdSuy4dyC5Bvl/qKhpGCQGKHCzycSO
 xEulzrYlQ3LLIOlIZDm7FlBg5gCj3zvHr00N8MoPCHaRqVsZUCwIkIEunqQVmQHMtyoYK6GZVcA
 8Y6w0K0NXKvzaAEnSiIDTYMm2Euiwq2Otr7WgG1rPyYYp6zpPNAH8meEf2gXp/zC2VMziO3GutN eonf2T4A+n0jtbw==
X-Mailer: b4 0.13.0
Message-ID: <20250213-vma-v14-2-b29c47ab21f5@google.com>
Subject: [PATCH v14 2/8] mm: rust: add vm_area_struct methods that require
 read access
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
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This adds a type called VmaRef which is used when referencing a vma that
you have read access to. Here, read access means that you hold either
the mmap read lock or the vma read lock (or stronger).

Additionally, a vma_lookup method is added to the mmap read guard, which
enables you to obtain a &VmaRef in safe Rust code.

This patch only provides a way to lock the mmap read lock, but a
follow-up patch also provides a way to just lock the vma read lock.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/mm.c      |   6 ++
 rust/kernel/mm.rs      |  23 ++++++
 rust/kernel/mm/virt.rs | 210 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)

diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
index 7201747a5d31..7b72eb065a3e 100644
--- a/rust/helpers/mm.c
+++ b/rust/helpers/mm.c
@@ -37,3 +37,9 @@ void rust_helper_mmap_read_unlock(struct mm_struct *mm)
 {
 	mmap_read_unlock(mm);
 }
+
+struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
+					      unsigned long addr)
+{
+	return vma_lookup(mm, addr);
+}
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
index 2fb5f440af60..8b19dde24978 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -17,6 +17,8 @@
 };
 use core::{ops::Deref, ptr::NonNull};
 
+pub mod virt;
+
 /// A wrapper for the kernel's `struct mm_struct`.
 ///
 /// This represents the address space of a userspace process, so each process has one `Mm`
@@ -200,6 +202,27 @@ pub struct MmapReadGuard<'a> {
     _nts: NotThreadSafe,
 }
 
+impl<'a> MmapReadGuard<'a> {
+    /// Look up a vma at the given address.
+    #[inline]
+    pub fn vma_lookup(&self, vma_addr: usize) -> Option<&virt::VmaRef> {
+        // SAFETY: By the type invariants we hold the mmap read guard, so we can safely call this
+        // method. Any value is okay for `vma_addr`.
+        let vma = unsafe { bindings::vma_lookup(self.mm.as_raw(), vma_addr) };
+
+        if vma.is_null() {
+            None
+        } else {
+            // SAFETY: We just checked that a vma was found, so the pointer references a valid vma.
+            //
+            // Furthermore, the returned vma is still under the protection of the read lock guard
+            // and can be used while the mmap read lock is still held. That the vma is not used
+            // after the MmapReadGuard gets dropped is enforced by the borrow-checker.
+            unsafe { Some(virt::VmaRef::from_raw(vma)) }
+        }
+    }
+}
+
 impl Drop for MmapReadGuard<'_> {
     #[inline]
     fn drop(&mut self) {
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
new file mode 100644
index 000000000000..a66be649f0b8
--- /dev/null
+++ b/rust/kernel/mm/virt.rs
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Virtual memory.
+//!
+//! This module deals with managing a single VMA in the address space of a userspace process. Each
+//! VMA corresponds to a region of memory that the userspace process can access, and the VMA lets
+//! you control what happens when userspace reads or writes to that region of memory.
+//!
+//! The module has several different Rust types that all correspond to the C type called
+//! `vm_area_struct`. The different structs represent what kind of access you have to the VMA, e.g.
+//! [`VmaRef`] is used when you hold the mmap or vma read lock. Using the appropriate struct
+//! ensures that you can't, for example, accidentally call a function that requires holding the
+//! write lock when you only hold the read lock.
+
+use crate::{bindings, mm::MmWithUser, types::Opaque};
+
+/// A wrapper for the kernel's `struct vm_area_struct` with read access.
+///
+/// It represents an area of virtual memory.
+///
+/// # Invariants
+///
+/// The caller must hold the mmap read lock or the vma read lock.
+#[repr(transparent)]
+pub struct VmaRef {
+    vma: Opaque<bindings::vm_area_struct>,
+}
+
+// Methods you can call when holding the mmap or vma read lock (or stronger). They must be usable
+// no matter what the vma flags are.
+impl VmaRef {
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap or vma
+    /// read lock (or stronger) is held for at least the duration of 'a.
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
+    /// Access the underlying `mm_struct`.
+    #[inline]
+    pub fn mm(&self) -> &MmWithUser {
+        // SAFETY: By the type invariants, this `vm_area_struct` is valid and we hold the mmap/vma
+        // read lock or stronger. This implies that the underlying mm has a non-zero value of
+        // `mm_users`.
+        unsafe { MmWithUser::from_raw((*self.as_ptr()).vm_mm) }
+    }
+
+    /// Returns the flags associated with the virtual memory area.
+    ///
+    /// The possible flags are a combination of the constants in [`flags`].
+    #[inline]
+    pub fn flags(&self) -> vm_flags_t {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags }
+    }
+
+    /// Returns the (inclusive) start address of the virtual memory area.
+    #[inline]
+    pub fn start(&self) -> usize {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_start }
+    }
+
+    /// Returns the (exclusive) end address of the virtual memory area.
+    #[inline]
+    pub fn end(&self) -> usize {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_end }
+    }
+
+    /// Zap pages in the given page range.
+    ///
+    /// This clears page table mappings for the range at the leaf level, leaving all other page
+    /// tables intact, and freeing any memory referenced by the VMA in this range. That is,
+    /// anonymous memory is completely freed, file-backed memory has its reference count on page
+    /// cache folio's dropped, any dirty data will still be written back to disk as usual.
+    ///
+    /// It may seem odd that we clear at the leaf level, this is however a product of the page
+    /// table structure used to map physical memory into a virtual address space - each virtual
+    /// address actually consists of a bitmap of array indices into page tables, which form a
+    /// hierarchical page table level structure.
+    ///
+    /// As a result, each page table level maps a multiple of page table levels below, and thus
+    /// span ever increasing ranges of pages. At the leaf or PTE level, we map the actual physical
+    /// memory.
+    ///
+    /// It is here where a zap operates, as it the only place we can be certain of clearing without
+    /// impacting any other virtual mappings. It is an implementation detail as to whether the
+    /// kernel goes further in freeing unused page tables, but for the purposes of this operation
+    /// we must only assume that the leaf level is cleared.
+    #[inline]
+    pub fn zap_page_range_single(&self, address: usize, size: usize) {
+        let (end, did_overflow) = address.overflowing_add(size);
+        if did_overflow || address < self.start() || self.end() < end {
+            // TODO: call WARN_ONCE once Rust version of it is added
+            return;
+        }
+
+        // SAFETY: By the type invariants, the caller has read access to this VMA, which is
+        // sufficient for this method call. This method has no requirements on the vma flags. The
+        // address range is checked to be within the vma.
+        unsafe {
+            bindings::zap_page_range_single(self.as_ptr(), address, size, core::ptr::null_mut())
+        };
+    }
+}
+
+/// The integer type used for vma flags.
+#[doc(inline)]
+pub use bindings::vm_flags_t;
+
+/// All possible flags for [`VmaRef`].
+pub mod flags {
+    use super::vm_flags_t;
+    use crate::bindings;
+
+    /// No flags are set.
+    pub const NONE: vm_flags_t = bindings::VM_NONE as _;
+
+    /// Mapping allows reads.
+    pub const READ: vm_flags_t = bindings::VM_READ as _;
+
+    /// Mapping allows writes.
+    pub const WRITE: vm_flags_t = bindings::VM_WRITE as _;
+
+    /// Mapping allows execution.
+    pub const EXEC: vm_flags_t = bindings::VM_EXEC as _;
+
+    /// Mapping is shared.
+    pub const SHARED: vm_flags_t = bindings::VM_SHARED as _;
+
+    /// Mapping may be updated to allow reads.
+    pub const MAYREAD: vm_flags_t = bindings::VM_MAYREAD as _;
+
+    /// Mapping may be updated to allow writes.
+    pub const MAYWRITE: vm_flags_t = bindings::VM_MAYWRITE as _;
+
+    /// Mapping may be updated to allow execution.
+    pub const MAYEXEC: vm_flags_t = bindings::VM_MAYEXEC as _;
+
+    /// Mapping may be updated to be shared.
+    pub const MAYSHARE: vm_flags_t = bindings::VM_MAYSHARE as _;
+
+    /// Page-ranges managed without `struct page`, just pure PFN.
+    pub const PFNMAP: vm_flags_t = bindings::VM_PFNMAP as _;
+
+    /// Memory mapped I/O or similar.
+    pub const IO: vm_flags_t = bindings::VM_IO as _;
+
+    /// Do not copy this vma on fork.
+    pub const DONTCOPY: vm_flags_t = bindings::VM_DONTCOPY as _;
+
+    /// Cannot expand with mremap().
+    pub const DONTEXPAND: vm_flags_t = bindings::VM_DONTEXPAND as _;
+
+    /// Lock the pages covered when they are faulted in.
+    pub const LOCKONFAULT: vm_flags_t = bindings::VM_LOCKONFAULT as _;
+
+    /// Is a VM accounted object.
+    pub const ACCOUNT: vm_flags_t = bindings::VM_ACCOUNT as _;
+
+    /// Should the VM suppress accounting.
+    pub const NORESERVE: vm_flags_t = bindings::VM_NORESERVE as _;
+
+    /// Huge TLB Page VM.
+    pub const HUGETLB: vm_flags_t = bindings::VM_HUGETLB as _;
+
+    /// Synchronous page faults. (DAX-specific)
+    pub const SYNC: vm_flags_t = bindings::VM_SYNC as _;
+
+    /// Architecture-specific flag.
+    pub const ARCH_1: vm_flags_t = bindings::VM_ARCH_1 as _;
+
+    /// Wipe VMA contents in child on fork.
+    pub const WIPEONFORK: vm_flags_t = bindings::VM_WIPEONFORK as _;
+
+    /// Do not include in the core dump.
+    pub const DONTDUMP: vm_flags_t = bindings::VM_DONTDUMP as _;
+
+    /// Not soft dirty clean area.
+    pub const SOFTDIRTY: vm_flags_t = bindings::VM_SOFTDIRTY as _;
+
+    /// Can contain `struct page` and pure PFN pages.
+    pub const MIXEDMAP: vm_flags_t = bindings::VM_MIXEDMAP as _;
+
+    /// MADV_HUGEPAGE marked this vma.
+    pub const HUGEPAGE: vm_flags_t = bindings::VM_HUGEPAGE as _;
+
+    /// MADV_NOHUGEPAGE marked this vma.
+    pub const NOHUGEPAGE: vm_flags_t = bindings::VM_NOHUGEPAGE as _;
+
+    /// KSM may merge identical pages.
+    pub const MERGEABLE: vm_flags_t = bindings::VM_MERGEABLE as _;
+}

-- 
2.48.1.502.g6dc24dfdaf-goog


