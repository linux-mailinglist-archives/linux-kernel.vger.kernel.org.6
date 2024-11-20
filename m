Return-Path: <linux-kernel+bounces-415960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BE29D3F57
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB700B33EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819601D6DB5;
	Wed, 20 Nov 2024 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0rJ7HrJL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742671D460B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114584; cv=none; b=Z2WKjr8Tc7Nwr5LbUCUodPYLEkPW9xO4YMEEOqXzxSs4AHXhhr09VBqxfXs+z8HKx753bKal+wex1MsT4hv0VlVZHHDuSLSfxTLslad2zO/Tv+rWcmkK+oJWh8FpWpZKpkRaSj2RXAw1+hfvxkevhcE/J5RoMyOqNP94c7bNo4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114584; c=relaxed/simple;
	bh=Xqhb993p62ucfXpgqmTAzwF8zVU/iTXacAc64i+hvXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YXZBRNxo6Z0dSO13X7dXS2Cl7K+uFnsp9jyCiZ3hbjkuyRpVGU1c33vVxS+zWl5Xe6hE25VIw8dZgNPkZaxJuzlub+iIWLtFUFIuzB4wdwQemSpfzOxmIXco/f+GvuWclQSFVk/tVOrexkohi0pPnpOOFNRCD3kpzb0ask222nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0rJ7HrJL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ee484ec18aso42867947b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732114580; x=1732719380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hUP5pKIRXgXTZOS13MJMWQ9DFpxOfGZ7r+UgNJvVuSI=;
        b=0rJ7HrJLBN3h3gCT51daqKjsnmC0ebM0JccG86UFWwtUG/Y+RBcPonIYVf87eA7w5z
         IJ1D745TImrQwdEX1cpuUIX4ABW98J5A9FXiFd5rOgt3YzRSOirmZXXtr/B9E1SuNQfL
         3xk1nhUHP77TTvQBT9EzBAOvv4sj1PZcaFge7CaGcmy/6wf96djPIkdTr5onjuPqG5jb
         5swAlYphJV5wAC4E3jTZck7yzRUl92unpcj4HKAakQEn6+21vb6MBoi9CaR1v/ffbeym
         7GwrGCXEWi6gKlSL9QCkVmcSgQ4SJAqBnNGOzpQEUOluHjY3zPI8zz+Td5sU+IWP9ZvJ
         upuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114580; x=1732719380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUP5pKIRXgXTZOS13MJMWQ9DFpxOfGZ7r+UgNJvVuSI=;
        b=lBkiipdEhjR6reFXIg2nx1/xYku4NkSmqyp5bIO32YJ89per+WU9+QwAmC+jyuqiHc
         /iri0qk+n2muovUfihYzzopR6F23J9CicV8C/Pl3njsomqu61qvjsesf3JLmABEWeaMS
         yB1qyLN0GhS0AD+fR+cwgSGUoggqx8xHJDI5PYM/pTPD/SNp4PkOdB5kY+l9sN08e9lt
         3fgIVFH7lWdLEfdsx0gn7JEmfInPPwjkzD3WUQEIDsmseWQD6MaZnke1GcyjSyIlwRrN
         dkhUF9zzAY++x2rP4j528neOr6s/9FOpWk5BrOqLzuNWL54Ed+Ph4JrwmmoF4pVwfOKe
         o4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6Gb665BhXDVpXVLBY5UtQOfWLD53Hbw6MM5VyHmgh8fcjy2hqVtzxeV/7pLKF4WV7ncueL+/G3clK52c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz88JQ4NYxS/xm2JG5mGhAUVF70hSTOHFkxMJE3VxWtOTp3tMiP
	GyoErz0GiwUYDhVwEX9aWX71s0iMw5aYEs9exSfMCy4rDDUq6Mh0TMbF3lgFPXOOZtUCOu2ZkX3
	Nx3yXVyDxyM9g3Q==
X-Google-Smtp-Source: AGHT+IEG9WEVO32XNJycTeJbJu48vAwd8yZZDgjUr+05hjT6U66t/ondGMQmQEA/GIQ+PsqbB1I6Xqu/GnabS+U=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f29e])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:5781:b0:6e2:ad08:4924 with SMTP
 id 00721157ae682-6eebd296195mr14787b3.4.1732114580372; Wed, 20 Nov 2024
 06:56:20 -0800 (PST)
Date: Wed, 20 Nov 2024 14:49:56 +0000
In-Reply-To: <20241120-vma-v8-0-eb31425da66b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8694; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Xqhb993p62ucfXpgqmTAzwF8zVU/iTXacAc64i+hvXs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnPfiJtZ8e3RVRA+k2lDQWtngvEf9QEVRA3KEln
 +zY498BKQmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZz34iQAKCRAEWL7uWMY5
 RpOaD/4yxq12q8wgIfSEmCve+/+Os+hqeA6WaIrFWW5ionzJ0gIAJ9cftQLGZTKFI8+rvupF8Lp
 dR1pbVHaU8sw+3jpSLHyp0jNLFTOL5gbGW1yFUHsGIjzxw9ZghQPcX+3vola7oY+NRtH0UmDDSf
 8SHI4Dgs+ykt3Kxa09hTFwnho5mhAtnRKj2ngOcwoqWbTMeGi7vSEbENMrrIyTRmnN4JMfdtNSM
 w/yYL/NWvnBcoEgwTBvK3Nb1UOFaXc0Qbqs3Bjv0y9q/0WFl6Pflj7UA/Fnoy7ic1VZsxQUDmvs
 TqskcSB6vHZBhIne4/8r2NYal0rmG9qtI0u1O51X9qF+udqdWZtRJBrFDnWI9oEIWUaNE+THgG0
 5/kSBR40GPZYjpwSdwM4HiyBlgxx74DpP9La+cyScGLvbsTOqG/8VkQLtlSus1MsYrElbH1Owqh
 fFYUr9RuGgxgFZVRxAnc0bIBTam6l6qUBZkUWO/Oa9wbwgq9laxBOwXXDAjr18IFTGblGKLyeCW
 1YOxkDN0nbIADD4637WxbTL4l2wYEaDiGA1W5ZMdFdJugTmNZodJxoye7vDLMjEOx5d+dvf2/t7
 gFm838Bm4GUkNA1Dm/Pjvht0d8hg0e9hRZx3uqJnRZIXU2Lt6DznOKYGva8smnLR0ySkWip8guU k0h7uXIHYMJyYWA==
X-Mailer: b4 0.13.0
Message-ID: <20241120-vma-v8-2-eb31425da66b@google.com>
Subject: [PATCH v8 2/7] mm: rust: add vm_area_struct methods that require read access
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>
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

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/mm.c      |   6 ++
 rust/kernel/mm.rs      |  21 ++++++
 rust/kernel/mm/virt.rs | 171 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)

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
index 000000000000..1e755dca46dd
--- /dev/null
+++ b/rust/kernel/mm/virt.rs
@@ -0,0 +1,171 @@
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
+    pub fn flags(&self) -> vm_flags_t {
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
+    /// should the VM suppress accounting.
+    pub const NORESERVE: vm_flags_t = bindings::VM_NORESERVE as _;
+
+    /// Huge TLB Page VM.
+    pub const HUGETLB: vm_flags_t = bindings::VM_HUGETLB as _;
+
+    /// Synchronous page faults.
+    pub const SYNC: vm_flags_t = bindings::VM_SYNC as _;
+
+    /// Architecture-specific flag.
+    pub const ARCH_1: vm_flags_t = bindings::VM_ARCH_1 as _;
+
+    /// Wipe VMA contents in child..
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


