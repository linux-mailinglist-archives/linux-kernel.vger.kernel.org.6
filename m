Return-Path: <linux-kernel+bounces-441158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AF19ECA76
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6693A287E5A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9847F2210F2;
	Wed, 11 Dec 2024 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUyquE6S"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D7211A11
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913460; cv=none; b=kLm3Soxiy9uvInvpWY2iHddVBZtjblo44/csHsvXVx1LlAKKXzUcDHryFIZrsGWpZpIVuh/rk4Cr6IQIjHxBEWAXqLGlPUkeHMGKlZUozUfgv+M8jGGQvwp3zwQxGmNiixNKvtWVnQEB/cG0DEF49w3AmNQ1v/5HrT0yrhJ+OSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913460; c=relaxed/simple;
	bh=UELtGY1YbfyD3E/jKfzFIZ073fFyrrrn2baNLFYoZH8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=snAG7NMtnNcFkaWcrvMSUG3F6BAZDQPFyT+yeyF7YVbIbKfrvu+hoHbsdPXQZubVm/GGf/37DpNKhhZ8EuDNsp5/dFE+kqaOOnhpjOb8e/hQyARzqGF9iVjuTiT0FI1cdpGQS+eewOIhVxXTVhKHmVW/q3MQ1cTi02sSpngT4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUyquE6S; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43582d49dacso15104155e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733913457; x=1734518257; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptCVgSajmLGd+33xQ7/1wwSdfyjzIQ8tWfofuzm1Y9U=;
        b=iUyquE6SWHsM3bA2/CyG4Stj9uT9IUUiiANDavdiOIsOsZi3okwo/dFn01A1pYnf9d
         A94ACTRWGfS0pZRL4H8KRcZWYoOdksd/TerPAC5P/iSJ+sxG1MU0cKq9DV/JRJY/Guhz
         sgKWXcr+N53T3LxWAOoeE3hP04gZVcsTtAVs4b11RXnawRmCqvoFLXh6FCQoeUejeVDv
         fUnzr/k2LMCx+oY5sLRezLfrvvJVO+4L8zvQ7bPRCMyUYmdt49W+M1laPg1i2QumGtBj
         7ZTRlV+UJVpmGdwo5FWL1yQ2RAgdxQpiE84Z/tps4TVlZiq0xNN0kTrOmxFw43dsL6MI
         Bubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733913457; x=1734518257;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptCVgSajmLGd+33xQ7/1wwSdfyjzIQ8tWfofuzm1Y9U=;
        b=VEqka7rNQhLFV632Nn0EpiWuCxbFweSFloQphtcVEyIC7N5mDNWqUApZ4WaCzBBQLy
         oXs91xRZH9p0ftUsbb9t6vxoCx5Yb9ha/qNU/2uWZakjdxii1rv/TDd2floDY3+AsUxi
         GWaQ20QY24K6Ir1Z8Fz0Bw8nJgfJJg/pTdzkKQ8qgUMZ7uvnK0wFmmcLUmR8rcjCgW80
         tKAlaz+Es+yx4eJEpgzeC5aM4BwJ3OI9O1cNPp7aAXhpjioaoJK+42UesLqmoejqJ7Y0
         SpeZdtV/OOgk286hkSjsoiI6jdvjNwOuCtvchFYk3ueqLm0g5hrVJXqzY02mxUqLurGR
         2t7g==
X-Forwarded-Encrypted: i=1; AJvYcCX1EkTYOTHt70A+OBmiX6mvn4JAN7dwoZ2DUGJX0AMIVTQcWQb5H2U+OiDfQmQWS6r9N3SVF+z8YaRap10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJQROg2g7FamUUZD9f4w2c09mzwuag/L51xalGz49QUUvguxm
	7uWXvIg1h3au+5gf9fhlxwtuNJYIjgS4NO05tb2KHZ3N2dbZn+O77GExmG5TQ+Dmsszt30sw0xv
	EmYGGtfBanuKxMg==
X-Google-Smtp-Source: AGHT+IF2oHVYbWX6H19GjEN2XS8y+OVVbBpLGUljSwx1ScMsBgY3j4qEcrJlD9I/H+Lzexp4LvuOcuGlpE8PUZM=
X-Received: from wmpd23.prod.google.com ([2002:a05:600c:4c17:b0:436:16c6:831])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d20:b0:434:f218:e1a8 with SMTP id 5b1f17b1804b1-4361c3c70eamr16834795e9.19.1733913457042;
 Wed, 11 Dec 2024 02:37:37 -0800 (PST)
Date: Wed, 11 Dec 2024 10:37:06 +0000
In-Reply-To: <20241211-vma-v11-0-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211-vma-v11-0-466640428fc3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10059; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=UELtGY1YbfyD3E/jKfzFIZ073fFyrrrn2baNLFYoZH8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnWWtmJY7Ptcy7pNZrWwIGonxUXNeWa5B1NRzbo
 /1Y1X00++WJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ1lrZgAKCRAEWL7uWMY5
 RisoD/9s1GclB/tPV2RQgJj7Nws8WY0RQiMF3+XoqpaXLo7CBWgXqFtqDRnmEDtnPSRjPNjZDUw
 vn76Q3hqvoFexzTpBLEIXNpq+0aW62Rs4WYTSB9EK4l03q8OIXaLWOuNzNlIFnkk5FWJQnnVctY
 4WaWo/DVhnFu3CckEwyhSjyZaC6tPRmjhEOV0MV9Zbc8e1VQXzd6gIuukpFAHK46aLIKXZwmPa7
 J9pTslBugUwDx0t/QdX6IDb8rto2Ux9i/12Ph2fwYr/mmAY0XkIqc3MavawP8NkoK9IqXgWDVfH
 OAk1I8Nd9M4GaTxeIr8Wqn3+VcYuY2axQuPSdU+N+/CI/5kSIxDN++PqFJG1ohgzX3zgVUHioTH
 5ZwPVM+FGEGb2b6Lv4iIn2uoVLcgsE3qxZetWkS/wYejQJ8GS0tvdtyuY0zkLLM5uQqH6ZBqFMR
 VHC+va0R5zAofKnL4ktwO3H/+1SBj2euS1cjsFFE2EIDCz3ENNd32tgOwboechRxR0AXiyPxyuE
 Iw12dKxpN9KICnBsQaXZZMbK3xJQ5wsZ74pST127xzw0893fVbw2sKL5BfGFNVccPJv/QWbMq41
 de5sNMp11t7DLip+VQnwMBl5Qlb/GCogJOR7gtVxW7AA1y9Eaqfqjj38Lo9unyrdcERTCEq0e+I leQBcaYv82zdrBw==
X-Mailer: b4 0.13.0
Message-ID: <20241211-vma-v11-2-466640428fc3@google.com>
Subject: [PATCH v11 2/8] mm: rust: add vm_area_struct methods that require
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
 rust/kernel/mm/virt.rs | 191 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 218 insertions(+)

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
index 000000000000..68c763169cf0
--- /dev/null
+++ b/rust/kernel/mm/virt.rs
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Virtual memory.
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
2.47.1.613.gc27f4b7a9f-goog


