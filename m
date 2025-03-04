Return-Path: <linux-kernel+bounces-544063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D78A4DD01
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490CB1896924
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F346202963;
	Tue,  4 Mar 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YNnWK9Vi"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05520101B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089104; cv=none; b=u/y8JeP/aOF9GsYA7m4puK3UElKk++bnX614npJHQ2lyepLykOitTOA/AHS1XOtbe6Ja09UQiP11sftMYoHzIo7lBM6Hwpj3KBACFTrwuSMJF6zpunSkAiDQaIsghhPed93AYif3ZiHquRligGbxercCvyy/KUOpu9RIbQQGhOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089104; c=relaxed/simple;
	bh=5g1f5dMZCyZ6+tFXqiaiFdfk/BOnjeMVoZy7cJs1yY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0Bve0LQoFpDDte5fLDmYPHzhAla3zOAvzftl2+beH10lDfs3tV17zNbxVJ9eVW6gb1r9ARaWZ7FJBfSrno54NXGPe0HROOtru514TxV3r8d4EfTFvYwQ8pLaO3VcohL1PXqxHMjF70tOTmqxEe4mATwDwNXjxT5ACab7Dwof7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YNnWK9Vi; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4399a5afc72so25469615e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741089101; x=1741693901; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtpRIxx42872somy5qq2iJF3BQOMcuJJhy/hljffTA4=;
        b=YNnWK9ViyqBJzhkNj01RFixUCSgyk3DrazmH2RIJfnKrL0jHCoW8P76fkCTmwaPFBL
         XqTa3aXmLtJAuf+UeJsvcAqRPemZ8sQiK/U8zFajBL5GsjTPz912Cyg7ZLU2YlD/NWKg
         sQlJbWCrHjKfuz5HZl6kOfO3bVQe1SdpqIdmTfwzuhQRmzl9CjhloB6lEZOQ2Q17mTvq
         ye1+vrnVB5s68jp1+8fg41X7h7bDkXUBiUtdmnWD6Dy7WhEpfleAOMHnL7Ad5IeTcdRN
         B/+V5SkRT5qwjSjIeT528OA2oFY80ob96vkEURAG/QXqZULmLZrm0eEJD44U5EQgJ1V3
         cQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741089101; x=1741693901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtpRIxx42872somy5qq2iJF3BQOMcuJJhy/hljffTA4=;
        b=tSIY4H40eecQ0LFBeI3u8H0xHr/kGajvzUZy92y3zccqw5W15X1a6PNCJimcGNZpCD
         L9wZoPTgj+5ThxxBvtK3rSijr1I7OQotk35ulUJfWEkWuTOSwlkewVupDFFZ1+9QPE5m
         wMa0kaoCkwZZ7pTsNZWfh/GLkHx2xze3oeG5sT/RVDEJv4fLLckP/9eV+4d8RFXYOIvV
         HTHjBRDMpJIpoSWJQseNDVvrNlcD5J9RtozaTpHw5lzsjtpUPETOxzufWC9TbSfe3DNn
         vFL/ysBrERnpzt/itVFsP6MF5OQWbO4MFu64IFxZGvgdlbVf9jila6o4+HdQuDCH1bQH
         UGpA==
X-Forwarded-Encrypted: i=1; AJvYcCXRtKHyZSj2N3/LvOHdrs+wXzhv3YSaiM2cryGv+O1qat952k2x+172Ty54pUip+7q8DORQ855Fd1tKKXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlAkHZpQlwQBCSdKysPyoXcNBRA+Xf97IWxrUYxtlOg7Q/RL3d
	CQ3ZmllvQLu94gdVquEmAYyj1dTr7cLIzrztjuewPXLlRBr0eC6/4zOqhO5sKX9D24VjacVmuJn
	hneJ9+gB+rnua2Q==
X-Google-Smtp-Source: AGHT+IHlUF2Y1FCXfZXQcZcMyFwY5URSZ23cxaBgnZhVnZxZTqV97wv1ql//rGPCHGKdrPhgQEJhXp8AASDto4k=
X-Received: from wmqd21.prod.google.com ([2002:a05:600c:34d5:b0:43b:be5c:fa60])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:2292:b0:43b:c0fa:f9ce with SMTP id 5b1f17b1804b1-43bc0fafff1mr60163805e9.14.1741089100845;
 Tue, 04 Mar 2025 03:51:40 -0800 (PST)
Date: Tue, 04 Mar 2025 11:49:52 +0000
In-Reply-To: <20250304-vma-v15-0-5c641b31980a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304-vma-v15-0-5c641b31980a@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10566; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=5g1f5dMZCyZ6+tFXqiaiFdfk/BOnjeMVoZy7cJs1yY4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxulCVzX3HsDZPl7M5T70FyzmQ2tx0HLT9aAtg
 e19ypLVE4mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8bpQgAKCRAEWL7uWMY5
 Rm8VD/9tH5QNHgdGrbVG2V3uDy0kANpOyxihVNhtOmvDHngryy9HuUJFTng9Z2BkA6E+NChBY2s
 53lkwzW7kfsuQWQ0oMerGsObvacknou1rcCpHLLIsly36iRs25U3Vz84fBd+U+StUuhg8Uk6+h5
 1h/EZ6/sSF1eG0m0w2yiax2yj/HTINsEC25+TuBhRDMkZHmKtS7SO5yut+x5ZzI6M5zZgtT47Wf
 VOUDxz+L5terinAvPshZjyz1kMs/zfN5b3iFLGQFYFLqwzZmU3RP4CuMIu+ZSyTTszoChwxpUcX
 MY8VSh+wGZ2Uer6PIiD4ONDNo1DEGBQyO0vfKpm4ontRarGl+GTbd+mrOLD7xTr8GyLppbYtSfE
 pnqJxNQUJUuFPz/8amz4qBZeiDdYWpAjTp4X8mEte3TACM+EbMMjmdltvEsx/13fspJnQO0g7kl
 P9Xv8AgHft/YyL5EBWP8wYaW8Eaz0QE/Rdj8AeNhcJ+85IJu2CGXH8EhZG6kvnO9rVKxknmmDbU
 KYyYTcGHF0skUIscUs2Y7LLczzoWmKJ+dq04JGDzErOW/xzN/EwOpH8In6N9MAP0QBVOwdk3wuk
 XobJIiA4tfsuqwNpEY9KLYikZMw1Av6FccBk4FrXRiEJXUX4HAU3xqllzbE96TKvncjNAljfmd4 CQf93I0YNg5Zjzw==
X-Mailer: b4 0.14.2
Message-ID: <20250304-vma-v15-1-5c641b31980a@google.com>
Subject: [PATCH v15 1/9] mm: rust: add abstraction for struct mm_struct
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
	Alice Ryhl <aliceryhl@google.com>, Balbir Singh <balbirs@nvidia.com>
Content-Type: text/plain; charset="utf-8"

These abstractions allow you to reference a `struct mm_struct` using
both mmgrab and mmget refcounts. This is done using two Rust types:

* Mm - represents an mm_struct where you don't know anything about the
  value of mm_users.
* MmWithUser - represents an mm_struct where you know at compile time
  that mm_users is non-zero.

This allows us to encode in the type system whether a method requires
that mm_users is non-zero or not. For instance, you can always call
`mmget_not_zero` but you can only call `mmap_read_lock` when mm_users is
non-zero.

The struct is called Mm to keep consistency with the C side.

The ability to obtain `current->mm` is added later in this series.

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers/helpers.c |   1 +
 rust/helpers/mm.c      |  39 +++++++++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/mm.rs      | 209 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 250 insertions(+)

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be1553549312dcfdf842bcae3bde1b..97cfc2d29f5ee0441a5938eb6b39c51dfa337cb4 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -18,6 +18,7 @@
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
+#include "mm.c"
 #include "mutex.c"
 #include "page.c"
 #include "platform.c"
diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
new file mode 100644
index 0000000000000000000000000000000000000000..7201747a5d314b2b120b30c0b906715c04ca77a5
--- /dev/null
+++ b/rust/helpers/mm.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mm.h>
+#include <linux/sched/mm.h>
+
+void rust_helper_mmgrab(struct mm_struct *mm)
+{
+	mmgrab(mm);
+}
+
+void rust_helper_mmdrop(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+
+void rust_helper_mmget(struct mm_struct *mm)
+{
+	mmget(mm);
+}
+
+bool rust_helper_mmget_not_zero(struct mm_struct *mm)
+{
+	return mmget_not_zero(mm);
+}
+
+void rust_helper_mmap_read_lock(struct mm_struct *mm)
+{
+	mmap_read_lock(mm);
+}
+
+bool rust_helper_mmap_read_trylock(struct mm_struct *mm)
+{
+	return mmap_read_trylock(mm);
+}
+
+void rust_helper_mmap_read_unlock(struct mm_struct *mm)
+{
+	mmap_read_unlock(mm);
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 496ed32b0911a9fdbce5d26738b9cf7ef910b269..9cf35fbff356d2b12a104dbf0ecda96c168b185f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -57,6 +57,7 @@
 pub mod kunit;
 pub mod list;
 pub mod miscdevice;
+pub mod mm;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod of;
diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
new file mode 100644
index 0000000000000000000000000000000000000000..2fb5f440af602cc9a89a040edaee60d88d54168b
--- /dev/null
+++ b/rust/kernel/mm.rs
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Memory management.
+//!
+//! This module deals with managing the address space of userspace processes. Each process has an
+//! instance of [`Mm`], which keeps track of multiple VMAs (virtual memory areas). Each VMA
+//! corresponds to a region of memory that the userspace process can access, and the VMA lets you
+//! control what happens when userspace reads or writes to that region of memory.
+//!
+//! C header: [`include/linux/mm.h`](srctree/include/linux/mm.h)
+
+use crate::{
+    bindings,
+    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
+};
+use core::{ops::Deref, ptr::NonNull};
+
+/// A wrapper for the kernel's `struct mm_struct`.
+///
+/// This represents the address space of a userspace process, so each process has one `Mm`
+/// instance. It may hold many VMAs internally.
+///
+/// There is a counter called `mm_users` that counts the users of the address space; this includes
+/// the userspace process itself, but can also include kernel threads accessing the address space.
+/// Once `mm_users` reaches zero, this indicates that the address space can be destroyed. To access
+/// the address space, you must prevent `mm_users` from reaching zero while you are accessing it.
+/// The [`MmWithUser`] type represents an address space where this is guaranteed, and you can
+/// create one using [`mmget_not_zero`].
+///
+/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destructor may sleep.
+///
+/// # Invariants
+///
+/// Values of this type are always refcounted using `mmgrab`.
+///
+/// [`mmget_not_zero`]: Mm::mmget_not_zero
+#[repr(transparent)]
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
+    #[inline]
+    fn inc_ref(&self) {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmgrab(self.as_raw()) };
+    }
+
+    #[inline]
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
+#[repr(transparent)]
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
+    #[inline]
+    fn inc_ref(&self) {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmget(self.as_raw()) };
+    }
+
+    #[inline]
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
+// These methods are safe to call even if `mm_users` is zero.
+impl Mm {
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
+    /// Lock the mmap read lock.
+    #[inline]
+    pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
+        // SAFETY: The pointer is valid since self is a reference.
+        unsafe { bindings::mmap_read_lock(self.as_raw()) };
+
+        // INVARIANT: We just acquired the read lock.
+        MmapReadGuard {
+            mm: self,
+            _nts: NotThreadSafe,
+        }
+    }
+
+    /// Try to lock the mmap read lock.
+    #[inline]
+    pub fn mmap_read_trylock(&self) -> Option<MmapReadGuard<'_>> {
+        // SAFETY: The pointer is valid since self is a reference.
+        let success = unsafe { bindings::mmap_read_trylock(self.as_raw()) };
+
+        if success {
+            // INVARIANT: We just acquired the read lock.
+            Some(MmapReadGuard {
+                mm: self,
+                _nts: NotThreadSafe,
+            })
+        } else {
+            None
+        }
+    }
+}
+
+/// A guard for the mmap read lock.
+///
+/// # Invariants
+///
+/// This `MmapReadGuard` guard owns the mmap read lock.
+pub struct MmapReadGuard<'a> {
+    mm: &'a MmWithUser,
+    // `mmap_read_lock` and `mmap_read_unlock` must be called on the same thread
+    _nts: NotThreadSafe,
+}
+
+impl Drop for MmapReadGuard<'_> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: We hold the read lock by the type invariants.
+        unsafe { bindings::mmap_read_unlock(self.mm.as_raw()) };
+    }
+}

-- 
2.48.1.711.g2feabab25a-goog


