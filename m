Return-Path: <linux-kernel+bounces-260085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55E93A2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF64B21B98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CC71552FE;
	Tue, 23 Jul 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3NXB///R"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EEB1514DA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721745168; cv=none; b=XqXp8xrB2F0Bbh9GpqUO5gdvuf7CAH+gLdipQ8uImZvl9/mm6OeR62M1MV+JMACvhuueLtfTos16vSy5EqhXl8gAhb5BWmMoaeCUt2wj5kNoFsAj9PrpBRtM8lh62P3WFAbphr7cSpN5+Zy0cM8/xG9LUiwaUXMnPSwqjKcKvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721745168; c=relaxed/simple;
	bh=rhM49Jf+oB5vxe3ACPm1NzxU5oSsMrb4XkUjMRZ49vw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Wn4AtrVqPH95MkWQ5UK+zueWnP89LWm9G0p3IdA3wIZYiwB3x8s7Sc+s1Y9kXq1SP3xG0eXACt18J78260k/75ugEQCMtQRyor7UZ9tPo1sz2/tap4iBMcyNh5UDq6A0zytXGNxE/BJZY5YQHY+pSUTLH3rTrV7zxcJY2A3ozeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3NXB///R; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-665a6dd38c8so170630027b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721745165; x=1722349965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ne+E73cZIzdvC8HBsh9ZATcEqVNqX+vKMAYiS15qNLM=;
        b=3NXB///ReUIzxHsDoB3FdXAigt0RphwooOyeEuPJHLJ4z/Ovg6oOpveKWnavJyz0Da
         L9BY4CYgcshR7/b6jCCGZzEDZt7+9gv7vdralY2XuBShPkdMrin8lJJ5yOmsji2PuMIH
         nlvj3KrzbNLIrz6jm1etBQlftdYS4YMcI4O94A4Bay+TnsUIfOMEX+5CeCNmj7BUGCb4
         CqMtbiruNzFlIsB76CFD5JLUFr8ocu/CjUepMBZmHSNWOi7gYy4PHlwMcrJ8q+Q4SOhQ
         bXcRyAmVAA8QqSlGg+T0vwAa1d2DDOew4yEl01nm7Wv9umXaKkCoLQQlJymxYljnSgrP
         uLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721745165; x=1722349965;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ne+E73cZIzdvC8HBsh9ZATcEqVNqX+vKMAYiS15qNLM=;
        b=XBtzCM3BE8lKupwj3M7LCCDxX8h6+gVPoVQjr29veZ5C3Bu/nNt/3Qi9xEOytbYFFS
         MCvcBF1REIePjCvI6vAsnC4zmO1mULtnsBMrE2ud1ihL8/W9wLaHLpj9eIJgu7EPwnIa
         qLMliMChVIszLLiUv4imvFd9yqSHObjmLwpOgCS5lBCFH8NAnMnm5zcdw0HbKgmIT2Ls
         8fr5vwTdDqE00RGPBcrzyVt4OvRam5sFUnhQ5V1Cs13zE2p44KcEmGN0D2D44q5Y7WIz
         7MKBoZbvQaqzxQOg34JDUlBGiTN/XnN7td/KxuRMixXzTEqjwQ/qDLhYM+CjCFJY7ncC
         W5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUZJtFKojjU5XXg4CvB3wlCRBytAwp3ofupgp+9ZLzsdAI39WkXo/cLZSNJ4DIPy4CX76WI5XiY4hqoaorAvkrUJ3aCk+OfBfMETztU
X-Gm-Message-State: AOJu0Yxt1I1p/4mg+t9O7FxmPQJtIhPk6uHbOWQjZM9xHXfg5d+emftO
	MKsTtbDcsIdQB46YEd8+u9p0/pj5QzSif+aAxRr0yIlVUZtgPrqWmoPB+4Wt2g7/IxEcuLbw3qt
	QD8WcNdyJEdr8Xw==
X-Google-Smtp-Source: AGHT+IHF5oVe92DsOypN0Y3BRqaU4NL6Eq3k2j9G0cH/aBV5sEtuLVZdC2lflxuxzsrHysGc+yG3LOwnKp1BVkY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:17:b0:62c:de05:5a78 with SMTP
 id 00721157ae682-66e4daea1fbmr1425317b3.6.1721745165115; Tue, 23 Jul 2024
 07:32:45 -0700 (PDT)
Date: Tue, 23 Jul 2024 14:32:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOK+n2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNj3bLcRN00CwNDQ8s0y7QkY1MloMqCotS0zAqwKdGxtbUAvnBzolU AAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=18847; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=rhM49Jf+oB5vxe3ACPm1NzxU5oSsMrb4XkUjMRZ49vw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmn78AR514CAFu5Ug3SzeBT7oIWrTQrvnIYbSzQ
 05ve0hfyiyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZp+/AAAKCRAEWL7uWMY5
 RvFFD/9URR1d0jocH929Qz/s5PjMGT14Hsl2k6nBxN+j8FatdCF5c3CKsWEaVbpLjiXBrY5c6jd
 HLlLOgG1kXYVPn6FVCML1hYWvuiYtJL7fMBhtMnIoG34QC3H93VM8/jLptPJbSx8HHDyj+uA01n
 Y+omgVEGTUktfukyNVbb6tQKFyGjlzECDCHp/vLhjBmTZatjzAgHMkl20nZlVyoihZYJXFNGaRH
 oqMVutd/lCIxaYWsx/6uytfvVyyy32Qo0mxr/MCpI+WB+FTZiCMoB/llyoDu+1UX2rlYgYG3+UA
 CdzSnI3aZsbKmIBHdcqxvc91zOHEuLJrO0LKdpsRFPXdlmtM0tvuJ3IBRfFu6kawORLM/tQ2ypR
 9Bp1RjeUhUlTZLYdDlYE1lQPVvd/Y+mJdUQxwr8+yvXmzY1U9guzSXfv4jNF8GLGCKH/wpBLvVN
 Icxz4/laHtZ23BoXATjku5ItBBy9hIf+Ogjp7WXstQU1F6IEp39SPcpR85iit/UV4ISycNZTJre
 OPEA3BtlO//TWX3zRBLNgddwvySBScnqs5UhEgj796bUtVN6/do29WN4pZfUEK8b6LYA2hH4+Ia
 IqOy9H6Xy7pBUAn3ktq2jOIx0GVyuk+0pa+7/WY61IQXEF5LhmarPdRqt/9yZYluVpESVralmNk QTGAaErcvYtwspA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240723-vma-v1-1-32ad5a0118ee@google.com>
Subject: [PATCH] rust: mm: add abstractions for mm_struct and vm_area_struct
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This is a follow-up to the page abstractions [1] that were recently
merged in 6.11. Rust Binder will need these abstractions to manipulate
the vma in its implementation of the mmap fop on the Binder file.

The ARef wrapper is not used for mm_struct because there are several
different types of refcounts.

This patch is based on Wedson's implementation on the old rust branch,
but has been changed significantly. All mistakes are Alice's.

Link: https://lore.kernel.org/r/20240528-alice-mm-v7-4-78222c31b8f4@google.com [1]
Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers.c         |  49 ++++++++++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/mm.rs      | 259 +++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs | 193 ++++++++++++++++++++++++++++++++++++
 4 files changed, 502 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 305f0577fae9..9aa5150ebe26 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -199,6 +199,55 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
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
+bool rust_helper_mmget_not_zero(struct mm_struct *mm)
+{
+	return mmget_not_zero(mm);
+}
+EXPORT_SYMBOL_GPL(rust_helper_mmget_not_zero);
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
index 000000000000..7fa1e2431944
--- /dev/null
+++ b/rust/kernel/mm.rs
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Memory management.
+//!
+//! C header: [`include/linux/mm.h`](../../../../include/linux/mm.h)
+
+use crate::bindings;
+
+use core::{marker::PhantomData, mem::ManuallyDrop, ptr::NonNull};
+
+pub mod virt;
+
+/// A smart pointer that references a `struct mm` and owns an `mmgrab` refcount.
+///
+/// # Invariants
+///
+/// An `MmGrab` owns an `mmgrab` refcount to the inner `struct mm_struct`.
+pub struct MmGrab {
+    mm: NonNull<bindings::mm_struct>,
+}
+
+impl MmGrab {
+    /// Call `mmgrab` on `current.mm`.
+    #[inline]
+    pub fn mmgrab_current() -> Option<Self> {
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
+        // INVARIANT: We just created an `mmgrab` refcount.
+        Some(Self { mm })
+    }
+
+    /// Check whether this vma is associated with this mm.
+    #[inline]
+    pub fn is_same_mm(&self, area: &virt::Area) -> bool {
+        // SAFETY: The `vm_mm` field of the area is immutable, so we can read it without
+        // synchronization.
+        let vm_mm = unsafe { (*area.as_ptr()).vm_mm };
+
+        vm_mm == self.mm.as_ptr()
+    }
+
+    /// Calls `mmget_not_zero` and returns a handle if it succeeds.
+    #[inline]
+    pub fn mmget_not_zero(&self) -> Option<MmGet> {
+        // SAFETY: We know that `mm` is still valid since we hold an `mmgrab` refcount.
+        let success = unsafe { bindings::mmget_not_zero(self.mm.as_ptr()) };
+
+        if success {
+            Some(MmGet { mm: self.mm })
+        } else {
+            None
+        }
+    }
+}
+
+// SAFETY: It is safe to call `mmdrop` on another thread than where `mmgrab` was called.
+unsafe impl Send for MmGrab {}
+// SAFETY: All methods on this struct are safe to call in parallel from several threads.
+unsafe impl Sync for MmGrab {}
+
+impl Drop for MmGrab {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: This gives up an `mmgrab` refcount to a valid `struct mm_struct`.
+        // INVARIANT: We own an `mmgrab` refcount, so we can give it up.
+        unsafe { bindings::mmdrop(self.mm.as_ptr()) };
+    }
+}
+
+/// A smart pointer that references a `struct mm` and owns an `mmget` refcount.
+///
+/// Values of this type are created using [`MmGrab::mmget_not_zero`].
+///
+/// # Invariants
+///
+/// An `MmGet` owns an `mmget` refcount to the inner `struct mm_struct`.
+pub struct MmGet {
+    mm: NonNull<bindings::mm_struct>,
+}
+
+impl MmGet {
+    /// Lock the mmap read lock.
+    #[inline]
+    pub fn mmap_write_lock(&self) -> MmapWriteLock<'_> {
+        // SAFETY: The pointer is valid since we hold a refcount.
+        unsafe { bindings::mmap_write_lock(self.mm.as_ptr()) };
+
+        // INVARIANT: We just acquired the write lock, so we can transfer to this guard.
+        //
+        // The signature of this function ensures that the `MmapWriteLock` will not outlive this
+        // `mmget` refcount.
+        MmapWriteLock {
+            mm: self.mm,
+            _lifetime: PhantomData,
+        }
+    }
+
+    /// When dropping this refcount, use `mmput_async` instead of `mmput`.
+    #[inline]
+    pub fn use_async_put(self) -> MmGetAsync {
+        // Disable destructor of `self`.
+        let me = ManuallyDrop::new(self);
+
+        MmGetAsync { mm: me.mm }
+    }
+}
+
+impl Drop for MmGet {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: We acquired a refcount when creating this object.
+        unsafe { bindings::mmput(self.mm.as_ptr()) };
+    }
+}
+
+/// A smart pointer that references a `struct mm` and owns an `mmget` refcount, that will be
+/// dropped using `mmput_async`.
+///
+/// Values of this type are created using [`MmGet::use_async_put`].
+///
+/// # Invariants
+///
+/// An `MmGetAsync` owns an `mmget` refcount to the inner `struct mm_struct`.
+pub struct MmGetAsync {
+    mm: NonNull<bindings::mm_struct>,
+}
+
+impl MmGetAsync {
+    /// Lock the mmap write lock.
+    #[inline]
+    pub fn mmap_write_lock(&self) -> MmapWriteLock<'_> {
+        // SAFETY: The pointer is valid since we hold a refcount.
+        unsafe { bindings::mmap_write_lock(self.mm.as_ptr()) };
+
+        // INVARIANT: We just acquired the write lock, so we can transfer to this guard.
+        //
+        // The signature of this function ensures that the `MmapWriteLock` will not outlive this
+        // `mmget` refcount.
+        MmapWriteLock {
+            mm: self.mm,
+            _lifetime: PhantomData,
+        }
+    }
+
+    /// Try to lock the mmap read lock.
+    #[inline]
+    pub fn mmap_read_trylock(&self) -> Option<MmapReadLock<'_>> {
+        // SAFETY: The pointer is valid since we hold a refcount.
+        let success = unsafe { bindings::mmap_read_trylock(self.mm.as_ptr()) };
+
+        if success {
+            // INVARIANT: We just acquired the read lock, so we can transfer to this guard.
+            //
+            // The signature of this function ensures that the `MmapReadLock` will not outlive this
+            // `mmget` refcount.
+            Some(MmapReadLock {
+                mm: self.mm,
+                _lifetime: PhantomData,
+            })
+        } else {
+            None
+        }
+    }
+}
+
+impl Drop for MmGetAsync {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: We acquired a refcount when creating this object.
+        unsafe { bindings::mmput_async(self.mm.as_ptr()) };
+    }
+}
+
+/// A guard for the mmap read lock.
+///
+/// # Invariants
+///
+/// This `MmapReadLock` guard owns the mmap read lock. For the duration of 'a, the `mmget` refcount
+/// will remain positive.
+pub struct MmapReadLock<'a> {
+    mm: NonNull<bindings::mm_struct>,
+    _lifetime: PhantomData<&'a bindings::mm_struct>,
+}
+
+impl<'a> MmapReadLock<'a> {
+    /// Look up a vma at the given address.
+    #[inline]
+    pub fn vma_lookup(&self, vma_addr: usize) -> Option<&virt::Area> {
+        // SAFETY: The `mm` pointer is known to be valid while this read lock is held.
+        let vma = unsafe { bindings::vma_lookup(self.mm.as_ptr(), vma_addr as u64) };
+
+        if vma.is_null() {
+            None
+        } else {
+            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
+            // the returned area will borrow from this read lock guard, so it can only be used
+            // while the read lock is still held. The returned reference is immutable, so the
+            // reference cannot be used to modify the area.
+            unsafe { Some(virt::Area::from_ptr(vma)) }
+        }
+    }
+}
+
+impl Drop for MmapReadLock<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: We acquired the lock when creating this object.
+        unsafe { bindings::mmap_read_unlock(self.mm.as_ptr()) };
+    }
+}
+
+/// A guard for the mmap write lock.
+///
+/// # Invariants
+///
+/// This `MmapReadLock` guard owns the mmap write lock. For the duration of 'a, the `mmget` refcount
+/// will remain positive.
+pub struct MmapWriteLock<'a> {
+    mm: NonNull<bindings::mm_struct>,
+    _lifetime: PhantomData<&'a mut bindings::mm_struct>,
+}
+
+impl<'a> MmapWriteLock<'a> {
+    /// Look up a vma at the given address.
+    #[inline]
+    pub fn vma_lookup(&mut self, vma_addr: usize) -> Option<&mut virt::Area> {
+        // SAFETY: The `mm` pointer is known to be valid while this read lock is held.
+        let vma = unsafe { bindings::vma_lookup(self.mm.as_ptr(), vma_addr as u64) };
+
+        if vma.is_null() {
+            None
+        } else {
+            // SAFETY: We just checked that a vma was found, so the pointer is valid. Furthermore,
+            // the returned area will borrow from this write lock guard, so it can only be used
+            // while the write lock is still held. We hold the write lock, so mutable operations on
+            // the area are okay.
+            unsafe { Some(virt::Area::from_ptr_mut(vma)) }
+        }
+    }
+}
+
+impl Drop for MmapWriteLock<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: We acquired the lock when creating this object.
+        unsafe { bindings::mmap_write_unlock(self.mm.as_ptr()) };
+    }
+}
diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
new file mode 100644
index 000000000000..f004a366445a
--- /dev/null
+++ b/rust/kernel/mm/virt.rs
@@ -0,0 +1,193 @@
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
+pub struct Area {
+    vma: Opaque<bindings::vm_area_struct>,
+}
+
+impl Area {
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is non-null and valid for the duration of the new area's
+    /// lifetime, with shared access. The caller must ensure that using the pointer for immutable
+    /// operations is okay.
+    #[inline]
+    pub unsafe fn from_ptr<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
+        // SAFETY: The caller ensures that the pointer is valid.
+        unsafe { &*vma.cast() }
+    }
+
+    /// Access a virtual memory area given a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `vma` is non-null and valid for the duration of the new area's
+    /// lifetime, with exclusive access. The caller must ensure that using the pointer for
+    /// immutable and mutable operations is okay.
+    #[inline]
+    pub unsafe fn from_ptr_mut<'a>(vma: *mut bindings::vm_area_struct) -> &'a mut Self {
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
+        // SAFETY: `self.vma` is valid by the type invariants.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags as _ }
+    }
+
+    /// Sets the flags associated with the virtual memory area.
+    ///
+    /// The possible flags are a combination of the constants in [`flags`].
+    #[inline]
+    pub fn set_flags(&mut self, flags: usize) {
+        // SAFETY: `self.vma` is valid by the type invariants.
+        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags = flags as _ };
+    }
+
+    /// Returns the start address of the virtual memory area.
+    #[inline]
+    pub fn start(&self) -> usize {
+        // SAFETY: `self.vma` is valid by the type invariants.
+        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_start as _ }
+    }
+
+    /// Returns the end address of the virtual memory area.
+    #[inline]
+    pub fn end(&self) -> usize {
+        // SAFETY: `self.vma` is valid by the type invariants.
+        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_end as _ }
+    }
+
+    /// Make this vma anonymous.
+    #[inline]
+    pub fn set_anonymous(&mut self) {
+        // SAFETY: `self.vma` is valid by the type invariants.
+        unsafe { (*self.as_ptr()).vm_ops = core::ptr::null() };
+    }
+
+    /// Maps a single page at the given address within the virtual memory area.
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
+        // SAFETY: The `vma` pointer is valid.
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
+/// Container for [`Area`] flags.
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
base-commit: b1263411112305acf2af728728591465becb45b0
change-id: 20240723-vma-f80119f9fb35

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


