Return-Path: <linux-kernel+bounces-544064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0854DA4DD02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C70B1897079
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01702200BBE;
	Tue,  4 Mar 2025 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W64O7l6w"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2A201261
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089106; cv=none; b=krVYDR9hWvrgQl6GmB3U/laADz0zVRO9E5tjW8/PfkTXz4eRqYUNHBrU7TgiF/Ru9zYnR5YqqxgJslelxaRrN4JFQSBbE0//znhpXHwDjLjgEiFwCYdYCC+RFW3A2RsBO2eBbBF2MK99RDVSV8tM0pInEDNlcNWJfS7g4WZDwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089106; c=relaxed/simple;
	bh=u2kwrwGBiExjsxacyqk+/8Snd0wRDSSXvlEJXA2mYG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JnhszDmb4+H6RkzmG3nQX0lwSQGa5IkxM3gMs+eSrCSJ8ubFt87O5zfqUUD01ta90OOQDE2ZLKwYH2ZyYauK9m+To1k/ZYuf8cL+XQ3YJL5fRVrmSZzeFGgtRvNq+MUJEVYOTpmWqniQ9xjmYmrS+0LCLj8C7r9nVR1ry/0xJ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W64O7l6w; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3910876fce0so1426608f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741089103; x=1741693903; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FY6dwgEh85CdnI1YBamGI2B15sLhic/cMYMUHEd5H6Q=;
        b=W64O7l6wq2euUX/PTsgBa9rkWDo5iAgx6nQydiR+eMymKs31Ria6kSkYZn7yYlDbsa
         bc8xfDfaq1Ic8Ect/VQGIR3fnzd3UH7uR+hb3KBDEg6ZSr4eCV3DweODVYchX5RNgBUk
         xIIjJSAQ9QVjJ7L70XSoh+wybYnmqziTDu2AwfPpgQq1GwSV/8TdzW5CKFbK6KSd43+3
         OjDpVB8oY6rtV51DNW/xhCr74xDt+gSobL6LLt8G50U9XPjSecZfMmn3xcT/JcGi1t/S
         DdBD81wBXOnR619e7586jOlvIbDEjzTo0n3wiMpQWA/q+51OncJ4UfU9Zd67o9DdN+pH
         Ap+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089103; x=1741693903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FY6dwgEh85CdnI1YBamGI2B15sLhic/cMYMUHEd5H6Q=;
        b=iAjk1am4XcLtrDDuWoXHPn3kNiEbF4MszywHigzUhtsTS00gdOHHaq3zFqowNwJ8Rx
         21TgbqANzVtvGDFjd3WbMNgBHDF88cQGXsMUI0WDMqZwRBqu/IjkvM17xoDf1TdZgbxq
         phy7lSHrmQ+4nR0CAwJdt+Ny4G5I9f7JVmZGd4zKbU72YM6rOyBiAfUpIJmlPcN0ojr+
         1u3cemD4vRkV96FsPL5BDjiJVtlwGxSgovvUNR5F0uPpFCKxOHctLph2hOK/sXnuVglL
         keKsiAbPiIYSZwr2oALM3NdP7LzjDWVTxSeaMJSvD/8zc77jh7zi2BnNHcCNobJoE6CP
         u4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVUGeKfu45Eqe97wz3IglCfJ/ISwpXxwPi/iJr2/m7BZOgw3+4FIgF+J++MyxW33sSfkiigHBksvq0jUyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEPeeZNb2hkBH80a0/XgjnYtvaQhYxwFGqC6vIaZhvK/75GaE
	4S3/RULAh9lT3yO8WKF4arRF1u+CQPjsVX3/UUWdvkuluFFa9UboYn7ipopVH1pLgtAtXBOMI9o
	fBXcKy3ilDKNwkw==
X-Google-Smtp-Source: AGHT+IGm4nsZI/vYEgQt5jpoUiaQIcNh1YiFhqOzco/4v+8jRzEEZHszMeemsSLPWzO/9Vac4NsOy9qvX2yOtyc=
X-Received: from wmqa21.prod.google.com ([2002:a05:600c:3495:b0:43b:c06d:f4fa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:184e:b0:38a:8ec6:f46f with SMTP id ffacd0b85a97d-390eca81635mr15577155f8f.53.1741089103169;
 Tue, 04 Mar 2025 03:51:43 -0800 (PST)
Date: Tue, 04 Mar 2025 11:49:53 +0000
In-Reply-To: <20250304-vma-v15-0-5c641b31980a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304-vma-v15-0-5c641b31980a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=12083; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=u2kwrwGBiExjsxacyqk+/8Snd0wRDSSXvlEJXA2mYG0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxulDCLWNnUWnExjUMAWI035TCrmIg+2oXJ8f/
 j8huaQA7amJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bpQwAKCRAEWL7uWMY5
 RitcD/0fz8xL1+bTMmo3biPjK2JiMAugHxX6jq5r8JZmw8XhrrR7XgO1piCNk/AsWoZPCcjRlwD
 zDIseuBT+zEE5mWFsJzl/ZwUAVoJVeaU0LzOOeYnYhRn8TWNGwHC1F/VRwbLlgV7r5nGvGgawGZ
 cP7745ra1sROXxgYq4oY4DTgx/ipUgYrf0HJlA9s+XTXhcMJ9q3plpnmzSRtfyEylU78lttzAeO
 gqFYvE9bEvAhSDK3/wB95WsPq88Ty2OQg08y/SHglxJ11k6y4Zlkhx0+QRHplvESxLDUSRvJNDM
 AqfUeLagr99GzYioUTa/H0brhzx/Gx2cK7U3yrauPBfB+I58bhjzTeQO3mhPKMAvHBywOqSckYo
 s9PBmQFM+dPn1tNsnsGXcfRyiSlPWyY9otL9yFLhG4h7ehr7VMuP5Xej9+C9z7ktMbERvBZNoUq
 f1CGNr2nDr5+YjdjYgFSWWy5FZ1IKW/rQ0qu7iQpf+uVMb0rfvcYzKUKEUyP3Fb9IZ+GF9TwKfX
 GbVqJM/Pcf1bsHw7qHkLhandM2JfwgA8K9tgN7U9koxX60phDRmpMsxxVJMQ2EmfNaJxNWIEgr5
 XW336KDymEGsetScgZyqIYZ08/lGq9wrG7Zi3qg7+uBbAMh8TN6g4aq3mIQTWVnLKfuXCkunWWQ hQbuUBTEPpLvKPw==
X-Mailer: b4 0.14.2
Message-ID: <20250304-vma-v15-2-5c641b31980a@google.com>
Subject: [PATCH v15 2/9] mm: rust: add vm_area_struct methods that require
 read access
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@Oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
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
Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/mm.c      |   6 ++
 rust/kernel/mm.rs      |  23 ++++++
 rust/kernel/mm/virt.rs | 210 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)

diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
index 7201747a5d314b2b120b30c0b906715c04ca77a5..7b72eb065a3e1173c920f02a440053cf6e93814e 100644
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
index 2fb5f440af602cc9a89a040edaee60d88d54168b..8b19dde249789b65d7b92159d131cbf38ba08149 100644
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
index 0000000000000000000000000000000000000000..a66be649f0b8d3dfae8ce2d18b70cb2b283fb7fe
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
2.48.1.711.g2feabab25a-goog


