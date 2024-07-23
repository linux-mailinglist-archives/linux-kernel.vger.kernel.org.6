Return-Path: <linux-kernel+bounces-260276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E857693A54B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD231F23580
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9040158DCC;
	Tue, 23 Jul 2024 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDOuFQ8+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0764157E9F;
	Tue, 23 Jul 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758276; cv=none; b=MWV+Ogp2OyYhvdwwyVzKXjb4klMb57C0JtGX1kPKqM2HAnHeLqIv1gweAnCdEQonr5dUdFjhipi1OF2soRKLMLVphGP26O+lKn/7y4hXNthu4eEEkxCa4t1/YLX7VpD/HlapCA1a+cvE45vLLw//mAcgoKJaiOkqqhrxOGCnt1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758276; c=relaxed/simple;
	bh=LIUBeLsNsDjs5xTYqpQj2wzu9Kf9qHfPrPDSatbqKYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZfWLo3IeW4kTJcliHaxaEyAAy0pOdkBquwIcHRp0laTWzBi4nokz3v6175Pqv4FvTdCeaDMQLw5rk/Eez5xvVB+OOi7bxtAek9zooGxqnPAiJY7hym/3d4LEVErAfgvBowfZ1U10derpO14hd+xTHzqQInzfEcIaxLJr/Pu+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDOuFQ8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4CEC4AF13;
	Tue, 23 Jul 2024 18:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758275;
	bh=LIUBeLsNsDjs5xTYqpQj2wzu9Kf9qHfPrPDSatbqKYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDOuFQ8+8bKHj3kQ5nWdYX5MCjfcmldiMQGhEIFnZxm/KBri2pLNVpBER8FMKqVci
	 ZT92rVWWPBz+aDCzyZdSSlXazYnHOxRhSrZAF5QtXKwt6Yx/roa7uuwiT5e3gl2AS4
	 ntdGyFz4xLeHT1Odjc3gkiTPeQmqzUy5JSfBib2nOqbOmIBArs/cI3wHr+/Tcngfhh
	 VY34vof/Bv2HOLTCI3+ufH6FwSU5SErRmZtq+aKhDsI7/BuNAW3/1MYF+7slArtDav
	 LDp3Q+xY6tp5G2K70K4w2N47olFreJnlgve7+Lg6ah1OJeGemb78FuuGuCsBvXn0d4
	 T4QqZnGPBIRQg==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 04/23] rust: alloc: implement `Allocator` for `Kmalloc`
Date: Tue, 23 Jul 2024 20:09:53 +0200
Message-ID: <20240723181024.21168-5-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723181024.21168-1-dakr@kernel.org>
References: <20240723181024.21168-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
typically used for objects smaller than page size.

All memory allocations made with `Kmalloc` end up in `krealloc()`.

It serves as allocator for the subsequently introduced types `KBox` and
`KVec`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs           |  2 +-
 rust/kernel/alloc/allocator.rs | 66 ++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 11d12264c194..bf739ce65387 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -4,7 +4,7 @@
 
 #[cfg(not(test))]
 #[cfg(not(testlib))]
-mod allocator;
+pub mod allocator;
 pub mod box_ext;
 pub mod vec_ext;
 
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 10774c51ae26..397ae5bcc043 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -5,9 +5,18 @@
 use super::{flags::*, Flags};
 use core::alloc::{GlobalAlloc, Layout};
 use core::ptr;
+use core::ptr::NonNull;
 
-struct Kmalloc;
+use crate::alloc::{AllocError, Allocator};
+use crate::bindings;
 
+/// The contiguous kernel allocator.
+///
+/// The contiguous kernel allocator only ever allocates physically contiguous memory through
+/// `bindings::krealloc`.
+pub struct Kmalloc;
+
+/// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
     let layout = new_layout.pad_to_align();
@@ -18,7 +27,7 @@ fn aligned_size(new_layout: Layout) -> usize {
     layout.size()
 }
 
-/// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
+/// Calls `krealloc` with a proper size to alloc a new object.
 ///
 /// # Safety
 ///
@@ -39,6 +48,59 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
     }
 }
 
+struct ReallocFunc(
+    // INVARIANT: One of the following `krealloc`, `vrealloc`, `kvrealloc`.
+    unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
+);
+
+impl ReallocFunc {
+    fn krealloc() -> Self {
+        Self(bindings::krealloc)
+    }
+
+    // SAFETY: `call` has the exact same safety requirements as `Allocator::realloc`.
+    unsafe fn call(
+        &self,
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let size = aligned_size(layout);
+        let ptr = match ptr {
+            Some(ptr) => ptr.as_ptr(),
+            None => ptr::null(),
+        };
+
+        // SAFETY: `ptr` is valid by the safety requirements of this function.
+        let raw_ptr = unsafe {
+            // If `size == 0` and `ptr != NULL` the memory behind the pointer is freed.
+            self.0(ptr.cast(), size, flags.0).cast()
+        };
+
+        let ptr = if size == 0 {
+            NonNull::dangling()
+        } else {
+            NonNull::new(raw_ptr).ok_or(AllocError)?
+        };
+
+        Ok(NonNull::slice_from_raw_parts(ptr, size))
+    }
+}
+
+unsafe impl Allocator for Kmalloc {
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let realloc = ReallocFunc::krealloc();
+
+        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
+        // allocated with this `Allocator`.
+        unsafe { realloc.call(ptr, layout, flags) }
+    }
+}
+
 unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
-- 
2.45.2


