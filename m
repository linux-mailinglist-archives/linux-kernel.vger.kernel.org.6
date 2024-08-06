Return-Path: <linux-kernel+bounces-276207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC000948FFB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982E7281760
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64D01C9EB4;
	Tue,  6 Aug 2024 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkmr/H9d"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E821BCA15
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949507; cv=none; b=vAxfZ3M1em4catqauyYudAga+sgdDIBrGzWMd1UGso5BUh6RaHv/QIzxnjATHYDQwrPThC6fm4FCJyE45paRbbN097wIK+GM8EkTcOoWlPTJnIloAdqOz2wxDWbGSGyMzCIqb+A/AK80mud/mnfZOV5QOkIgCrZdXpB/BzXlIdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949507; c=relaxed/simple;
	bh=jns9IMxg11Tazee26O/Bmfo22iIpr69I7uNXaUto3d0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZWO2WBaYH7Rqb2UaWDVrXc4R2iqdQhw2XiyS2G88JFWLwExB077ERJVdpvXmRQQ5+f9cRdabAZL6cqBvOY6D/SmyVWWAcUZaoj4Ki7lRjoUCNUoHBo7yUUIw4W0mqUrRMm2wVechqIvZswb7KJfz/rXoN61w5AXa81ODG1qqx7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkmr/H9d; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3687529b63fso373232f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722949503; x=1723554303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FYplj7CP267tlScl40jFUn9/gIkAKIPcngpUu1X9O5Q=;
        b=rkmr/H9dLjU/62myYTgrrU4L8mT0Nj+GyuAms828Uo/Rvs37oguJzoxwzYZCw/my5f
         UILWoyCuqiPPqJsWuqbWud4Tl///JhL2HvIE8NM18oQhERStWx5wyQEJjaBv7t3GeWrv
         qLc3k6p1gd2v3dhxFK1OLWbBKiMPcqAI/d5Nm8w+hykBncBQgMvnW04v7cqO9oUQ2QLL
         WTPY8W/GE6EHl3VPfdd46MW8+OGI2D3d6Dtb8CS83WrzrX3uDWsA/sQDEoGln9J6dAWm
         tTxFWUdTayudzZxBRs8IXDe9qBPEAVcO7wsCP4ag8TIsmhTa8JvFodYTJceAREnSW1eH
         YorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722949503; x=1723554303;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FYplj7CP267tlScl40jFUn9/gIkAKIPcngpUu1X9O5Q=;
        b=FSCSfsi/rlorgbj/90/SY/99NTrCJynxNcF0lpRnvPnusG0k6UfTuTTdPvg2DUf+3y
         S+nu+0Ms1cLT21XNWzw34d2qlr6iTzPx0j3sD3zo39iqVrPGJVUOkK/mYRO4tLayWNjd
         EP3mP6IZvN/B+5yfjekQUeaa0/9sGvLZwnp3wSmR5nTDTALUMm3NatWU/FzIhrDeuS43
         lQwzvMgV8c74ZO0i8kTFPrMpfA2VHIS8oMweeoWJI30hNwgmPidvlWR8iqcT8JRFB+HE
         D0jkxpOtoLe51RDKpMBSdLWixPXC2sXiNrxK6jj9YDc2duF6itl6AqP0LMJVEUvnPMeC
         m23g==
X-Forwarded-Encrypted: i=1; AJvYcCV/LooHQwwqCjOh0i3iW6fdLJu0xWwLzTX+zs/VgRLw+WjLUg1+Zr8KKk5Dypd1/r9h30PltiZeGyhZsbLL7pG5FKx1DnigXeL6H3ka
X-Gm-Message-State: AOJu0YwCGDJ9enbJBPiY0WirboAQ0z23fsewaI4+QIzM6dFR+Xx+jq/j
	No2wojk8gq7FRwA/d6QLImw2prhYOFma3wkbtAyK2XEp4UpAnGc+vbf9J6jAu4wcpLHZ613/AhH
	PDrDisLKM03RDTw==
X-Google-Smtp-Source: AGHT+IG82AfSHyj749k5YR7meyRVb/YZGwqt09V/Ddk/Ho7jd/ZOtMDujfFnNG1A+qFCNGqyG58210d1gnhA4ko=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:adf:cc84:0:b0:366:ea7c:bed1 with SMTP id
 ffacd0b85a97d-36bbc0c3777mr19778f8f.1.1722949502319; Tue, 06 Aug 2024
 06:05:02 -0700 (PDT)
Date: Tue, 06 Aug 2024 13:04:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGMfsmYC/2XOTQ6CMBCG4auQrq3pDxXqynsYF0M7xSZKDZhGY
 7i7AyyUsPwmfd70wwbsIw7sWHxYjzkOMXU0zK5g7gpdizx62kwJVYpKaZ7vwEMtpLTBhkYbRi8
 fPYb4mivnC+1rHJ6pf8/RLKfr2mfJJdcKvAEK1YinNqX2hnuX7mwKZPWPqgUpQtBoNFZV3mnYI P1D9MEFaUK+OTjpBAQPdoPKf6QWVBISVkJdCVNDqVdoHMcvIjo33DYBAAA=
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=24233; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=jns9IMxg11Tazee26O/Bmfo22iIpr69I7uNXaUto3d0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmsh9nYz4fJpQP8MO15CtEb4/VUAzRiHWgBsb7j
 bfZ3ZuUi1aJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrIfZwAKCRAEWL7uWMY5
 Rr42D/0SwPh8nsO0lpdXa0fdlaLRh8ps26btpHfdxw7HLKrhNF8y3Z8zhJizNIakYfZvUqUdi6b
 7V/3649xN8Cl6y+3nz9aPbIQJw2o3PPT+T21jXS3lhukx/AUXJCFzGogmwdd0RUBz0BAyWYLrAT
 hcbPRTV4qLwy4NXejjLc2bfEMinwMQrP/fC/en9y4SlCdhxHWMzTFO+2JqVC/z2aahomjj2LrYV
 KfFyQYKQPSPhVJe3yO8xK7Atf8mucZxNFHsOehTKUrQ+YegwP9Kgpjc1l9iy8QIAo9gRKhx7bO7
 v+esgW2qFwgl0r/ZWL2UQ37LBVHZkl5+9oC+akFtUWEbD0PMdtN3wSpBbL/NDyG+j3mKuFxxb5V
 uDc/Tb3VmygL2zKPK7xB9VfB0k7YMDGafgRFVR96xwqkO3udSGSEfhk3FHmazdnsN62i9aI8wB6
 rLwIPacylGfwVbymJVEwjILLHqubbA7CMKmhvH0COyaIPDcNgB3UgFRq+btidw4IxKFUdZQiUVp
 TuNbz0ntxGX6A6lI36WR8A2w5vt61V4K+QSf0sSt9KuwKIEDMOdPHI+dUx9XKrs0qI3nX4+pk0B
 YblkitoxqfJNQx9TMyCx1PJxnCj4qLjhEMfJR5puS1WJQWAPYrSgUaG3fIxW8E3Qlh6IzqRbS29 9yi80/gdP07mQcQ==
X-Mailer: b4 0.13.0
Message-ID: <20240806-vma-v5-1-04018f05de2b@google.com>
Subject: [PATCH v5] rust: mm: add abstractions for mm_struct and vm_area_struct
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="utf-8"

This is a follow-up to the page abstractions [1] that were recently
merged in 6.11. Rust Binder will need these abstractions to manipulate
the vma in its implementation of the mmap fop on the Binder file.

This patch is based on Wedson's implementation on the old rust branch,
but has been changed significantly. All mistakes are Alice's.

Link: https://lore.kernel.org/r/20240528-alice-mm-v7-4-78222c31b8f4@google.com [1]
Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This change depends on:
https://lore.kernel.org/all/20240801-aref-into-raw-v1-1-33401e2fbac8@google.com/
---
Changes in v5:
- Rename VmArea::from_raw_vma to from_raw.
- Use Pin for mutable VmArea references.
- Go through `ARef::from` in `mmgrab_current`.
- Link to v4: https://lore.kernel.org/r/20240802-vma-v4-1-091a87058a43@google.com

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
 rust/kernel/mm.rs      | 347 +++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/mm/virt.rs | 206 +++++++++++++++++++++++++++++
 4 files changed, 615 insertions(+)

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
index 000000000000..b04ee5435400
--- /dev/null
+++ b/rust/kernel/mm.rs
@@ -0,0 +1,347 @@
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
+    pin::Pin,
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
+            unsafe { Some(virt::VmArea::from_raw(vma)) }
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
+    pub fn vma_lookup(&mut self, vma_addr: usize) -> Option<Pin<&mut virt::VmArea>> {
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
+            unsafe { Some(virt::VmArea::from_raw_mut(vma)) }
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
index 000000000000..842b2b337bf9
--- /dev/null
+++ b/rust/kernel/mm/virt.rs
@@ -0,0 +1,206 @@
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
+use core::pin::Pin;
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
+    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
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
+    pub unsafe fn from_raw_mut<'a>(vma: *mut bindings::vm_area_struct) -> Pin<&'a mut Self> {
+        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
+        unsafe { Pin::new_unchecked(&mut *vma.cast()) }
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
+    pub fn set_flags(self: Pin<&mut Self>, flags: usize) {
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
+    pub fn set_anonymous(self: Pin<&mut Self>) {
+        // SAFETY: By the type invariants, the caller holds the mmap write lock, so this access is
+        // not a data race.
+        unsafe { (*self.as_ptr()).vm_ops = core::ptr::null() };
+    }
+
+    /// Maps a single page at the given address within the virtual memory area.
+    ///
+    /// This operation does not take ownership of the page.
+    #[inline]
+    pub fn vm_insert_page(self: Pin<&mut Self>, address: usize, page: &Page) -> Result {
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


