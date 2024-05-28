Return-Path: <linux-kernel+bounces-192581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE58D1F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0721F2311C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C76171E48;
	Tue, 28 May 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qgc3zJ3G"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C30171662
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716908309; cv=none; b=CL1LHQIW3olEtIVwfILTUBrldGNGyyKckSQcc2I50v9eFR8dkc+DERG1PXKAk4JUoNiMJqcIa39J5Mb1JACZmDKXjc8pYZ0jrwMOKEn3Fq/Oz8hshZzBL3bzjR2Y4+A/T1bYgoXOp/3K6QzvxDQQEqoT8/VYoi6WlL92jA/bXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716908309; c=relaxed/simple;
	bh=/HE8lkngIqgSFXOtkqfoTmQKkoPIxutv/DByz3hii1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c1pgyUFxBDop2RzhV13hiOwHKMtYmJN2FQtg7CRSDhgPCzGlu9y4f6ENyO/Q4pGjA0Pii/v9fmMPLJ4JabDLKlEJAqe7ga0sb6kIpXM46olL+SLV0UY5stwdZTv/ATI6Q9Rm/GECb/j0M67dAZFp2wlE/fE1TsGuA0gvqw1UPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qgc3zJ3G; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2e95ad43e9fso6392861fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716908305; x=1717513105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eO05l42JzpfeTNPK2MRvp86M9FhFhNRtSy4S1tjVhus=;
        b=Qgc3zJ3GYsnur+WEgkbHZGn8z61m9aXvhvxXSRQKEtKmbf1eod9PQpwYSX7CcMuXzK
         Vik7nn7qNvJ7REJbs4vb/iAW/fQFRkZWccyLfdVd4cywGZgXD27ZEVEZDCyCJPvbWGRj
         H6VRYmJpYgfO3go/xsAufLiWyGyLKkZ+wzf6/uKsbL9azbbLwED74spI3aXqb7SL5pa2
         fO0kPB4PojyJ6dS4/VYQaryCfB6bjrpWTAbSULkDCAnDJhM2aPp7IELfYCT1djtRjX1Q
         WG/qcCW6/kXRFGrqCmrVGdEZqedjvTtS2jLUhB8V+B+7+NP1PaMe/4TbhXNI31l3xN6t
         H7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716908305; x=1717513105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eO05l42JzpfeTNPK2MRvp86M9FhFhNRtSy4S1tjVhus=;
        b=X5cb5k2J2lGVufqFwlbTJcQj7nLzP0dvO7M8pc+0eWKZFZiEl4c0+sQ064lUHlKMaK
         JY6+8v58QjkRIAnYY1s+gQsf02fwKf5zmR9CHNpQSwLB59AYcnOF5REGhF61GkdAgD9R
         0Tc8ngONsziBMKSLrNEbkM8bK2Oi0waSVX+IydujZ0+JU+4+nrVjT7o6dr7VVwT5o2Pb
         NpHP5skTLNNPHpbpswh0qIQ98hv5x3JCaWDSxKwWGs/9SkPbdG3FUN8BYjLYRZ/LVmvi
         7RynBHiShZKTmgg1r5Kirgxg8XxUoxGO513XsgT4dpL1a6R4sefTnB37tXhScL8z5t1J
         xMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+nqu3w5npKN9ZbeiS8UGc6EkKRuY9TpfZ46zlyzHyRx8YEynFA2nRAE3egGLmXztr2rGqBazWf/Fw74qisT9q0vyiaPZAK1/zUjwC
X-Gm-Message-State: AOJu0YxITF8uKiAOWLygRtExl+bs8bbyhDeQebgDsU2sXAQ407N3hItB
	TKqg2HVVcm04bn6+szQGJW3Z207zNyxMQd7sfTGBBHDFe1CG5vvWB6d03v40O1qgigEZreptoTn
	YAl7fGwRH0cBepg==
X-Google-Smtp-Source: AGHT+IEOF4n7i+XUKYEBH94ipp8W/G8bUc6RNmidal0r91mtpuFIe9xOXChYEoPu4AGoMAK43jNu8IHHgNDq/Yo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:32d3:b0:51d:5f9c:50ad with SMTP
 id 2adb3069b0e04-529666c4680mr10952e87.12.1716908305169; Tue, 28 May 2024
 07:58:25 -0700 (PDT)
Date: Tue, 28 May 2024 14:58:05 +0000
In-Reply-To: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=16077; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/HE8lkngIqgSFXOtkqfoTmQKkoPIxutv/DByz3hii1k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmVfECAVuTTj15038Ew2DTzS3KESwLDvumYApMa
 eZb1p+NiP+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZlXxAgAKCRAEWL7uWMY5
 Rs9lD/wLFlIa+NMQSL+XMbCYpTDJQVbp+7DZpIvygiwW1JH34lbNywTpBNp3IjSEx7IgKIZUwoF
 kMBSbh+5TLnO+MIt7RBsY7Yn6V3Lvkhchd8wVGOtzIvmj1kpcvvqVCqvttpFMSR1QAeDnLfZjX/
 uo07YYKK7D+J6grc/ZIv12/HP4CtFBTE0dPyW2h0FgbrVItek7+rZ8f7bB8HpKaF6+NEM+QP9JM
 qZjIl6j0deYWCQWDWo/wFsab9voyLxhzZ/E9YdE1tKjzw0/GSoaU/PmJ5a/eI8I1eCMmUMMCPFO
 CBTheF4vo8iwkb5e1YeCot0wTD+nGkmNaGx69RensXoGwEjKsfHa1lt3717UMZ44CWyeAWO5y52
 8BWzcbqDjf93IDGHHUUVYNVzge4NJ1X2nPjtNwNniUow8yX6DmL3ZS9m46Pv+GWM9gzbZySJ82n
 umQAWuDZnhs0gmNxNfjb3v5Hu7KdbtbhBfBMFmMPtFnfhMLCcDptTiwbOLCWQ4E4km7PfVvvcB9
 VDq5ao+YdwiAcPS0LZe7Pw56pHdFynJWMwXQ4/6xfy2JwbbKY38O21FOAQh52cVxRfgRd1woFBT
 pYGjdKWyrYxNnCZe1Gec4b2THgA6zK3Qd7kfvLGNaxMQxusI2VYvkn9dSmKF1Oa+fw+FAZ7mzJ0 Wqjz3DW/CXKlOJw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240528-alice-mm-v7-4-78222c31b8f4@google.com>
Subject: [PATCH v7 4/4] rust: add abstraction for `struct page`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

Adds a new struct called `Page` that wraps a pointer to `struct page`.
This struct is assumed to hold ownership over the page, so that Rust
code can allocate and manage pages directly.

The page type has various methods for reading and writing into the page.
These methods will temporarily map the page to allow the operation. All
of these methods use a helper that takes an offset and length, performs
bounds checks, and returns a pointer to the given offset in the page.

This patch only adds support for pages of order zero, as that is all
Rust Binder needs. However, it is written to make it easy to add support
for higher-order pages in the future. To do that, you would add a const
generic parameter to `Page` that specifies the order. Most of the
methods do not need to be adjusted, as the logic for dealing with
mapping multiple pages at once can be isolated to just the
`with_pointer_into_page` method.

Rust Binder needs to manage pages directly as that is how transactions
are delivered: Each process has an mmap'd region for incoming
transactions. When an incoming transaction arrives, the Binder driver
will choose a region in the mmap, allocate and map the relevant pages
manually, and copy the incoming transaction directly into the page. This
architecture allows the driver to copy transactions directly from the
address space of one process to another, without an intermediate copy
to a kernel buffer.

This code is based on Wedson's page abstractions from the old rust
branch, but it has been modified by Alice by removing the incomplete
support for higher-order pages, by introducing the `with_*` helpers
to consolidate the bounds checking logic into a single place, and
various other changes.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  20 ++++
 rust/kernel/alloc.rs            |   7 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/page.rs             | 250 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 279 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..0862261cfbed 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
diff --git a/rust/helpers.c b/rust/helpers.c
index d6abe4bd45d9..305f0577fae9 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -25,6 +25,8 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/gfp.h>
+#include <linux/highmem.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
@@ -94,6 +96,24 @@ int rust_helper_signal_pending(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
 
+struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
+{
+	return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
+
+void *rust_helper_kmap_local_page(struct page *page)
+{
+	return kmap_local_page(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap_local_page);
+
+void rust_helper_kunmap_local(const void *addr)
+{
+	kunmap_local(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
+
 refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 531b5e471cb1..72f475e44144 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -20,6 +20,13 @@
 #[derive(Clone, Copy)]
 pub struct Flags(u32);
 
+impl Flags {
+    /// Get the raw representation of this flag.
+    pub(crate) fn as_raw(self) -> u32 {
+        self.0
+    }
+}
+
 impl core::ops::BitOr for Flags {
     type Output = Self;
     fn bitor(self, rhs: Self) -> Self::Output {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 767026db068e..5d310e79485f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -35,6 +35,7 @@
 pub mod kunit;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod page;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
new file mode 100644
index 000000000000..121d20066645
--- /dev/null
+++ b/rust/kernel/page.rs
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel page allocation and management.
+
+use crate::{
+    alloc::{AllocError, Flags},
+    bindings,
+    error::code::*,
+    error::Result,
+    uaccess::UserSliceReader,
+};
+use core::ptr::{self, NonNull};
+
+/// A bitwise shift for the page size.
+pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
+
+/// The number of bytes in a page.
+pub const PAGE_SIZE: usize = bindings::PAGE_SIZE;
+
+/// A bitmask that gives the page containing a given address.
+pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
+
+/// A pointer to a page that owns the page allocation.
+///
+/// # Invariants
+///
+/// The pointer is valid, and has ownership over the page.
+pub struct Page {
+    page: NonNull<bindings::page>,
+}
+
+// SAFETY: Pages have no logic that relies on them staying on a given thread, so moving them across
+// threads is safe.
+unsafe impl Send for Page {}
+
+// SAFETY: Pages have no logic that relies on them not being accessed concurrently, so accessing
+// them concurrently is safe.
+unsafe impl Sync for Page {}
+
+impl Page {
+    /// Allocates a new page.
+    ///
+    /// # Examples
+    ///
+    /// Allocate memory for a page.
+    ///
+    /// ```
+    /// use kernel::page::Page;
+    ///
+    /// # fn dox() -> Result<(), kernel::alloc::AllocError> {
+    /// let page = Page::alloc_page(GFP_KERNEL)?;
+    /// # Ok(()) }
+    /// ```
+    ///
+    /// Allocate memory for a page and zero its contents.
+    ///
+    /// ```
+    /// use kernel::page::Page;
+    ///
+    /// # fn dox() -> Result<(), kernel::alloc::AllocError> {
+    /// let page = Page::alloc_page(GFP_KERNEL | __GFP_ZERO)?;
+    /// # Ok(()) }
+    /// ```
+    pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
+        // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
+        // is always safe to call this method.
+        let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
+        let page = NonNull::new(page).ok_or(AllocError)?;
+        // INVARIANT: We just successfully allocated a page, so we now have ownership of the newly
+        // allocated page. We transfer that ownership to the new `Page` object.
+        Ok(Self { page })
+    }
+
+    /// Returns a raw pointer to the page.
+    pub fn as_ptr(&self) -> *mut bindings::page {
+        self.page.as_ptr()
+    }
+
+    /// Runs a piece of code with this page mapped to an address.
+    ///
+    /// The page is unmapped when this call returns.
+    ///
+    /// # Using the raw pointer
+    ///
+    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
+    /// `PAGE_SIZE` bytes and for the duration in which the closure is called. The pointer might
+    /// only be mapped on the current thread, and when that is the case, dereferencing it on other
+    /// threads is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't
+    /// cause data races, the memory may be uninitialized, and so on.
+    ///
+    /// If multiple threads map the same page at the same time, then they may reference with
+    /// different addresses. However, even if the addresses are different, the underlying memory is
+    /// still the same for these purposes (e.g., it's still a data race if they both write to the
+    /// same underlying byte at the same time).
+    fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) -> T {
+        // SAFETY: `page` is valid due to the type invariants on `Page`.
+        let mapped_addr = unsafe { bindings::kmap_local_page(self.as_ptr()) };
+
+        let res = f(mapped_addr.cast());
+
+        // This unmaps the page mapped above.
+        //
+        // SAFETY: Since this API takes the user code as a closure, it can only be used in a manner
+        // where the pages are unmapped in reverse order. This is as required by `kunmap_local`.
+        //
+        // In other words, if this call to `kunmap_local` happens when a different page should be
+        // unmapped first, then there must necessarily be a call to `kmap_local_page` other than the
+        // call just above in `with_page_mapped` that made that possible. In this case, it is the
+        // unsafe block that wraps that other call that is incorrect.
+        unsafe { bindings::kunmap_local(mapped_addr) };
+
+        res
+    }
+
+    /// Runs a piece of code with a raw pointer to a slice of this page, with bounds checking.
+    ///
+    /// If `f` is called, then it will be called with a pointer that points at `off` bytes into the
+    /// page, and the pointer will be valid for at least `len` bytes. The pointer is only valid on
+    /// this task, as this method uses a local mapping.
+    ///
+    /// If `off` and `len` refers to a region outside of this page, then this method returns
+    /// `EINVAL` and does not call `f`.
+    ///
+    /// # Using the raw pointer
+    ///
+    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
+    /// `len` bytes and for the duration in which the closure is called. The pointer might only be
+    /// mapped on the current thread, and when that is the case, dereferencing it on other threads
+    /// is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't cause
+    /// data races, the memory may be uninitialized, and so on.
+    ///
+    /// If multiple threads map the same page at the same time, then they may reference with
+    /// different addresses. However, even if the addresses are different, the underlying memory is
+    /// still the same for these purposes (e.g., it's still a data race if they both write to the
+    /// same underlying byte at the same time).
+    fn with_pointer_into_page<T>(
+        &self,
+        off: usize,
+        len: usize,
+        f: impl FnOnce(*mut u8) -> Result<T>,
+    ) -> Result<T> {
+        let bounds_ok = off <= PAGE_SIZE && len <= PAGE_SIZE && (off + len) <= PAGE_SIZE;
+
+        if bounds_ok {
+            self.with_page_mapped(move |page_addr| {
+                // SAFETY: The `off` integer is at most `PAGE_SIZE`, so this pointer offset will
+                // result in a pointer that is in bounds or one off the end of the page.
+                f(unsafe { page_addr.add(off) })
+            })
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    /// Maps the page and reads from it into the given buffer.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that `dst` is valid for writing `len` bytes.
+    /// * Callers must ensure that this call does not race with a write to the same page that
+    ///   overlaps with this read.
+    pub unsafe fn read_raw(&self, dst: *mut u8, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |src| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then
+            // it has performed a bounds check and guarantees that `src` is
+            // valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::copy_nonoverlapping(src, dst, len) };
+            Ok(())
+        })
+    }
+
+    /// Maps the page and writes into it from the given buffer.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that `src` is valid for reading `len` bytes.
+    /// * Callers must ensure that this call does not race with a read or write to the same page
+    ///   that overlaps with this write.
+    pub unsafe fn write_raw(&self, src: *const u8, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
+            // bounds check and guarantees that `dst` is valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::copy_nonoverlapping(src, dst, len) };
+            Ok(())
+        })
+    }
+
+    /// Maps the page and zeroes the given slice.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that this call does not race with a read or write to the same page that
+    /// overlaps with this write.
+    pub unsafe fn fill_zero_raw(&self, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
+            // bounds check and guarantees that `dst` is valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::write_bytes(dst, 0u8, len) };
+            Ok(())
+        })
+    }
+
+    /// Copies data from userspace into this page.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// Like the other `UserSliceReader` methods, data races are allowed on the userspace address.
+    /// However, they are not allowed on the page you are copying into.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that this call does not race with a read or write to the same page that
+    /// overlaps with this write.
+    pub unsafe fn copy_from_user_slice_raw(
+        &self,
+        reader: &mut UserSliceReader,
+        offset: usize,
+        len: usize,
+    ) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
+            // bounds check and guarantees that `dst` is valid for `len` bytes. Furthermore, we have
+            // exclusive access to the slice since the caller guarantees that there are no races.
+            reader.read_raw(unsafe { core::slice::from_raw_parts_mut(dst.cast(), len) })
+        })
+    }
+}
+
+impl Drop for Page {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we have ownership of the page and can free it.
+        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
+    }
+}

-- 
2.45.1.288.g0e0cd299f1-goog


