Return-Path: <linux-kernel+bounces-418424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E1A9D6174
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBDC160609
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4C81DF754;
	Fri, 22 Nov 2024 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlaQhNFO"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71904138490
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290070; cv=none; b=vDdnEknamHcRun+k0Y4TN9a2gPWbgfV/E2sH9aGrW5bSZ9l/rtfV1pWKVuAjL4YHPsxgoX7v4QSA42Q2Cw7kpTplsrqxNi7j18xVMiSl1temW8RlteBEyVAIE6eM7W2YUj+VG0OEwppUunAVLaJg5oEUsev4pfOD3QjoSJt16Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290070; c=relaxed/simple;
	bh=r818IxuzXbN9g3c4yrMD7Y71e/4bceEXKMyljx6a6J0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZvYOR+aWlEshDv8pmM3PsCvaijxbLvW3IacUlilJEnzqlM1GTGWZNceOkSQPhZGib/atDG0voQY3pqKxApmADzxfEwiwJzozT7PKrkdGZBt900sIMq9zBxcpRh/b1Uihr7BfSCpNa1z0llbC1NeOcHFKgV2dYL41M+RMcspIY2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlaQhNFO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso19710025e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732290067; x=1732894867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpRgqzz82sEijd8ek2p3HLExnZlmTISx521fYTMYg7A=;
        b=mlaQhNFO+vrhYmlDCOi/LjUxjDeKols9SiJGVNb2gJ9XSsV7PXR4GSGbD/nS0g7GVi
         pgAgFRy1/vmOpQG0Ng2d4gOJJdhDeq8KeE9ONahjlSqKEiEggynsCC9lPuuacXhqt5ew
         0ai15AOcQSFTHP+gc7NIsvO3H5SaJWY4w3a7sH4a5HnH1E/avZxsloDSQgcNHeiWUWOO
         R1nmZH8i0mn6KadzSsAoJW7AbSLCSAbXBKgJg5iA8rqOEZWSdBvlos2KlDxEoBcSVNJN
         SiybGSfvhM6xrEn2cyEOMhvE9/UVysdoeBI7jRa2p2Q0ymbc88QzZkU0uOj4vhSt26Ae
         aJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732290067; x=1732894867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpRgqzz82sEijd8ek2p3HLExnZlmTISx521fYTMYg7A=;
        b=mgF/q6faRUsBoq+DAZBp2JDqPtDqdr7IfMdqvjwI306pQjTcAo+INOFidjvUyWJdZc
         T14KmNj3Mr3U3WGqP/rBDvls0MxuLtT1E7yUqTCNdSAUeLrKPejIf9wsrhakCD0YhovH
         40MrhZm2eFXcE15BJt+H6hrDoRIUc+0Zmn/izNP1/vShJiskdkPc2fUq77rjZFIu7NLh
         mNrazsBSAzM/lpNfhU9itAWcbIHpxSMhvP50zizYdyNNVslsH+/smdT0j8wgjQEQFVLQ
         E12UGmbWVpNDHKdEMgF9prgpjS/orEfRtluDRob8P/eRLKMQOVFFGuEB0f6eTr26VBUV
         2Tcw==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/oVs1UIJ4ETEb6U/tisdzIzWO+ZkpPk8ZufuCqwvCa+ufYlXE98UjGQ/6aJGbnPhXWeRMu/a40+n1Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbOwCsdXVpUWfqir7dXFqdwPAVrP66ldDt3X8kN7TNuD6DHdB3
	nWsoFXKlcPAp+KIfmf6JduOoMhzTQVfAELOte2qJ5hlww+eI0QT1/njzSciv7+XxjDKJ4KMFEmp
	tPkZhCFhz0xqR9w==
X-Google-Smtp-Source: AGHT+IESpHOo7osW11QO7Begd6/hgV+HnuolBUZ1nG+UDTyG0tnysPZ8TSCOWeW0XPKFP+U93HN/frQCkrDDEt4=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f29e])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:1d0f:b0:42e:e66c:2a8e with SMTP
 id 5b1f17b1804b1-433ce4fa122mr290465e9.7.1732290066790; Fri, 22 Nov 2024
 07:41:06 -0800 (PST)
Date: Fri, 22 Nov 2024 15:40:27 +0000
In-Reply-To: <20241122-vma-v9-0-7127bfcdd54e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=9346; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=r818IxuzXbN9g3c4yrMD7Y71e/4bceEXKMyljx6a6J0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnQKYH5R8PxJfDPHVIRhFqASmlS4/vOqLyQrhYP
 00O1+uub3yJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ0CmBwAKCRAEWL7uWMY5
 RthAD/4+eTK7BgZe7rEzEuKSggCjNmJFDiXSil0wpt6Mtne5FMxrKaoPhFbPYUG7/eQKsmKd229
 R+9N4RwgUgUz9BDTGtPkfqyzHqDWGgcDvh2HBj182rXM5D8w74KVjyOaD6qLk6K4zdAZxXKjbfQ
 2vVRpOmJfMVsNxsv86dNQ+D98nJ0LmV2m6gqctO1QAIsXh38mtiOMuvFDh4NlHe0qyLeQp/aoD/
 t8PsiCifW8wxZl5nfaOS1E4RuxMvOM2dxx0zrqWIfLMAE2RlhCrZpMYwnwVifnlvhRljlRmkbPX
 XFFk49kIp7UkagsYcfTJLpdeEIJlv/scIG8ko6s2WuT8XvSQOL14tgt8d2W1Z88SQD6++dY432o
 POxTp6FvrQbGURx2KiscUqumI4RiGASEFAjaBLWjk8j1qDcBDUp0nz1E1sOuukO9ibjVE61txXK
 PnGgib++npZ5+cYCldHT/A22ixyl9VwI3s0+iUGGJlJo1Tu7sqjaLd42Az9hG6a0PTW4Q5kXVcE
 Hsh7yvtZqWvj2o5XbjW9n2WGPZnQFv07376GF34phwW9EqaYwjLbjjHEGwiBQ2PpaL/Z4CgHc52
 I48IUA9YXGDW+Vbed1yYkq9UwLdrLtszSN3Nvb9VOK6rEHAtc/liw2mXu9jYxYry7ThWaXmPpnx c1Ug0Ul61WNzz6A==
X-Mailer: b4 0.13.0
Message-ID: <20241122-vma-v9-2-7127bfcdd54e@google.com>
Subject: [PATCH v9 2/8] mm: rust: add vm_area_struct methods that require read access
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

This adds a type called VmAreaRef which is used when referencing a vma
that you have read access to. Here, read access means that you hold
either the mmap read lock or the vma read lock (or stronger).

Additionally, a vma_lookup method is added to the mmap read guard, which
enables you to obtain a &VmAreaRef in safe Rust code.

This patch only provides a way to lock the mmap read lock, but a
follow-up patch also provides a way to just lock the vma read lock.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/mm.c      |   6 ++
 rust/kernel/mm.rs      |  21 ++++++
 rust/kernel/mm/virt.rs | 176 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)

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
index 000000000000..6df145fea128
--- /dev/null
+++ b/rust/kernel/mm/virt.rs
@@ -0,0 +1,176 @@
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
+        // SAFETY: By the type invariants, the caller has read access to this VMA, which is
+        // sufficient for this method call. This method has no requirements on the vma flags. Any
+        // value of `address` and `size` is allowed.
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
2.47.0.371.ga323438b13-goog


