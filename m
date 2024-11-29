Return-Path: <linux-kernel+bounces-425793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24969DEB0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1303282FDB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1CA19F49F;
	Fri, 29 Nov 2024 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dql8t/Ma"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2119ADA6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897980; cv=none; b=dPSZbgd3ys9qQx3lZKsXxqfKv+U3gitWXC7GwrI61jiSIkFbbvm1RRmxMx2Oq5frygVEo1qDn8l3mZkclSkZW8yNDechN2KhkJcy0NFU33As5+aZ/KU8RZyfyd/6R/rt9qecdI/99Dg6fhU1JUEm7+1H+pYaNBZ/4y48wexr6ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897980; c=relaxed/simple;
	bh=qfqYB5CY+zrrWoF1p5PA1wE61kagKg3f8qMfUMwrH2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i3k7vZ9rsjn+0ojM6E+3jiSw83CGNYAXiY6Q+MDAIjkH8zp1K8tDQysHaESbp9iuDpi4H8avvfg6W+av0ssBGK/c9omC7kwSbkk3Ogh3I2ydldGfM9fLpD/U3Eszhbt6pSUL7riXqgeLOpLtFyJ+iRDZ/F28xRZmbHiu0UfpmJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dql8t/Ma; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-434a73651e2so14102585e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732897976; x=1733502776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5YzoZTIOzo/0986DnSppxfBI0p8rQsJVoOP2q6LCvk=;
        b=Dql8t/Ma5WmemoqP8zsSfv7xLdd6OWEpELWAx9/45cSK4bX2aEUCh/7mA/aMBsQVh9
         rXR4r/Qib2NjWY8ZZ6yC05ba6tfx+uczyYJ3rGKRmkxYUv++R2U90oFfNLxYKfwilcrx
         8cPlT8YqfuWuNFPumz9G1VVmiFsErxN7ZsWDpWR5vUD/80ei816BLdLSeFHfiE0xN5dt
         +aPJ29NLd2M0nV+dLU+mfGuGdb1x6GETNRTseadw8wU8A1fr8wd2vGvSUmtpeLEqwRo9
         m3OX5o0EVd/fcH/9HIW5fPB9kRyUmr8Rg+xBVT+tFA+qmFMTI/kAkS21lyoqtVs5yfPk
         lzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897976; x=1733502776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5YzoZTIOzo/0986DnSppxfBI0p8rQsJVoOP2q6LCvk=;
        b=PUMhViLOu1jQuN6NiKqQ1fS+RyaxDJJ5YsIYB+TuMLajj3I96Y4u/iLkXNyTIq30Yw
         y8KsrlwyC6oHluxfdunND1TJ7lP0uVnayeknun55pFrI6J9t21roIl0UU5weTDiHJjWT
         qkqGkcY0IHc41Slyag6Txpl4ToQ1LefabIBFOSV7xvGkbSewnxCr77/L+AJ0EbD/z8vL
         1MCAELR5PJo8ZIFmZMYnQVdFkvnfWK9/YX+Tn8Xiph5LzzLswEDKIdYO0S57CRF7ZmWA
         lAtYUEm5q+ixQ4yhYz42eGpj1eHoWmdk+VHs6KWNRMYAli314iBpA96juSG5VEBA8qb0
         vXug==
X-Forwarded-Encrypted: i=1; AJvYcCXJ9K3IxFVUfj10LI3enFgHsULvS25gfbeSXWTKUs7qs7TtZrDwDj5x8hOhnq7Ol4zvtJEGdC/7BsQJWCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUgiTupT/xvePW8BFKXBnVfnNVEPLlVEtPIkNUJEgnMzvAWsd
	Xrei0m5/xa8AQfc8axkqViivuPFkJiFcoEE+WUtBFaEIpOfYGs3HtYaep6y/WnXS+0PTt+oqML0
	3NX4+M5bp+N0mjA==
X-Google-Smtp-Source: AGHT+IHze4h565Aoh2DoHrp99j4LSl0kVAIFqSGJmgywq3dMrDmKMH3RGZw03PbIllpNmKnyBzK6/JzPDiaVmPE=
X-Received: from wmoq13.prod.google.com ([2002:a05:600c:46cd:b0:431:1260:2444])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3146:b0:434:a169:6ff8 with SMTP id 5b1f17b1804b1-434a9db8423mr128388385e9.3.1732897976603;
 Fri, 29 Nov 2024 08:32:56 -0800 (PST)
Date: Fri, 29 Nov 2024 16:32:35 +0000
In-Reply-To: <20241129-vma-v10-0-4dfff05ba927@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241129-vma-v10-0-4dfff05ba927@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=9643; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qfqYB5CY+zrrWoF1p5PA1wE61kagKg3f8qMfUMwrH2s=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnSeyunSmy45C3+dwg4sTBb0910JzVks9XKF/WA
 HFj/FmBAwyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0nsrgAKCRAEWL7uWMY5
 Ro6+D/0eS03pE3ZODh9XPuyPKCvsQdzzedfXMU5VED+gXAd+veD/s0mctxSF5+dCrZH/WzcSeG0
 E0wvbKQGYvTYjDOrABcB4VUKPw13cEX5BB5FFhslBKJaVfKdQjRib4r2lFNk8nm2hDydoigQEf5
 Necf6GOJbCrOgVx9Rkn6E2leJwlSrSiobggvnXvvPuJjEcyVX02iG/xj9eaQBwg8R9x2cozehqe
 5AZsxJl9JZqNPPCvnMquL3HhnS51Tx9OzpfikrhsWXxOYqQMbaSYCsq3JREbXVut+Wyf8plCNvF
 8sUwhycV5tQES/p36rGUFikzr7Z4qUmQbkCF8XX/gOJshCUGnlnMOfXLf3cZQAUn7/FZWVwIVe2
 07m+UyPyzz2M5AMMEaGHizR1WiL1I09EhEDgdNrnAqTA+LPowkPYhRE+urCovOVmwG2KEVjlu+B
 6sNpFxFnHDbpUAMnIR+WBFeG6+ZeDfSrrC46g59620JfvBYSBcS17v0TvqAIsHsPC8w41FLcPPD
 O/6dcaOE9l5QO27XYeCm2uOSGn8Mn4SemMv9PK7a7V4ECtf9kuFUJ7CBD0KjnZwz94CrvGAxwPq
 dkZ21D6ljWsx+KrHr5XkZ4KglFbqxP/ZE6f8FCSkOH/53QWrOW//QlkjLpp08wULZs6JDDB43rw bJ2rL11wZz/I6WQ==
X-Mailer: b4 0.13.0
Message-ID: <20241129-vma-v10-2-4dfff05ba927@google.com>
Subject: [PATCH v10 2/8] mm: rust: add vm_area_struct methods that require
 read access
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

This adds a type called VmAreaRef which is used when referencing a vma
that you have read access to. Here, read access means that you hold
either the mmap read lock or the vma read lock (or stronger).

Additionally, a vma_lookup method is added to the mmap read guard, which
enables you to obtain a &VmAreaRef in safe Rust code.

This patch only provides a way to lock the mmap read lock, but a
follow-up patch also provides a way to just lock the vma read lock.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
Reviewed-by: Jann Horn <jannh@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/mm.c      |   6 ++
 rust/kernel/mm.rs      |  21 ++++++
 rust/kernel/mm/virt.rs | 182 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)

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
index 84cba581edaa..ace8e7d57afe 100644
--- a/rust/kernel/mm.rs
+++ b/rust/kernel/mm.rs
@@ -12,6 +12,8 @@
 };
 use core::{ops::Deref, ptr::NonNull};
 
+pub mod virt;
+
 /// A wrapper for the kernel's `struct mm_struct`.
 ///
 /// Since `mm_users` may be zero, the associated address space may not exist anymore. You can use
@@ -210,6 +212,25 @@ pub struct MmapReadGuard<'a> {
     _nts: NotThreadSafe,
 }
 
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
+            // while the mmap read lock is still held.
+            unsafe { Some(virt::VmAreaRef::from_raw(vma)) }
+        }
+    }
+}
+
 impl Drop for MmapReadGuard<'_> {
     #[inline]
     fn drop(&mut self) {
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
new file mode 100644
index 000000000000..032eea4d4690
--- /dev/null
+++ b/rust/kernel/mm/virt.rs
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Virtual memory.
+
+use crate::{bindings, types::Opaque};
+
+/// A wrapper for the kernel's `struct vm_area_struct` with read access.
+///
+/// It represents an area of virtual memory.
+///
+/// # Invariants
+///
+/// The caller must hold the mmap read lock or the vma read lock.
+#[repr(transparent)]
+pub struct VmAreaRef {
+    vma: Opaque<bindings::vm_area_struct>,
+}
+
+// Methods you can call when holding the mmap or vma read lock (or strong). They must be usable no
+// matter what the vma flags are.
+impl VmAreaRef {
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
+    /// Returns the flags associated with the virtual memory area.
+    ///
+    /// The possible flags are a combination of the constants in [`flags`].
+    #[inline]
+    pub fn flags(&self) -> vm_flags_t {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags as _ }
+    }
+
+    /// Returns the (inclusive) start address of the virtual memory area.
+    #[inline]
+    pub fn start(&self) -> usize {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_start as _ }
+    }
+
+    /// Returns the (exclusive) end address of the virtual memory area.
+    #[inline]
+    pub fn end(&self) -> usize {
+        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
+        // access is not a data race.
+        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_end as _ }
+    }
+
+    /// Zap pages in the given page range.
+    ///
+    /// This clears page table mappings for the range at the leaf level, leaving all other page
+    /// tables intact, and freeing any memory referenced by the VMA in this range. That is,
+    /// anonymous memory is completely freed, file-backed memory has its reference count on page
+    /// cache folio's dropped, any dirty data will still be written back to disk as usual.
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
+/// The integer type used for vma flags.
+#[doc(inline)]
+pub use bindings::vm_flags_t;
+
+/// All possible flags for [`VmAreaRef`].
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
2.47.0.338.g60cca15819-goog


