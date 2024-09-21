Return-Path: <linux-kernel+bounces-334868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B5697DDA6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4651E281C2B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 15:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF93175D2F;
	Sat, 21 Sep 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWH+XVg7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B921EA91;
	Sat, 21 Sep 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726932814; cv=none; b=BnVzCo6415sT2g360b+ElT4TBuLS+shzyCcMlwKXxluW0HPxXI5W77cAnTe+U+GTSMQpZOxxl8pUQM6nduiiTsn3OSlxYm31Hm2SxU3aMT8WxizCQXTeHF2DJ8x2kSkMgcKPMBCyGt68LXKH5AspyqpTMWrHrdStwESkxok0SbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726932814; c=relaxed/simple;
	bh=u6SkMDARmiJpubJd+bhVyKAuAzfP2dIXTmGflsC+2IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTTcQWtbq8VXfcLORDim8sk2puS6t10rMDVpHyfTTNq5j9gxVQJOlxAoHmXKT9pYpC2HzlHfIF+at4mV2Rm3Jh8BBa4hXvCUsePXYoPjtTJBJIf/Ikv4nYvsJDS6kP28+FdI5Vrk+9BaRyFzI6SoZQ4uniGVvEEhc23s4Sg7SQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWH+XVg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28443C4CEC2;
	Sat, 21 Sep 2024 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726932814;
	bh=u6SkMDARmiJpubJd+bhVyKAuAzfP2dIXTmGflsC+2IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWH+XVg7nDKLhIgvleuHSahCfA+asylLR9Zt71HpOfLhRlUcTcUlvIp6VvXbI2tm6
	 qDCJPwb3vcVgWZKDkRq5NJhbogiP02zgXBWBMCGk3stpdn1OeM7z3heXgMZs7aW+Hs
	 eyDqlWevxv/3FaT9HlNGB3ZRjesckEknNAJWckjuETs9eYA+7wH3qwAa1qIXjel+eX
	 aOPMB3sFckQo2wJSy4jw7Mkt90vZJopAWvMGlZkm83Lj56D3HTnU7gpOOW5Mhga8b0
	 avGDtR2xK+g72hcnFN+B4PSv0ftu18BFQQZDomU1yKluoBe6Uh+YTBQH+kSewe8dAy
	 WusEkD7ACd2zQ==
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
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [RFC PATCH] rust: alloc: pass `old_layout` to `Allocator`
Date: Sat, 21 Sep 2024 17:32:46 +0200
Message-ID: <20240921153315.70860-1-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240911225449.152928-2-dakr@kernel.org>
References: <20240911225449.152928-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since this came up a few times, this patch shows how the implementation
looks like with an `old_layout` argument.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs           | 32 ++++++++++++--------------
 rust/kernel/alloc/allocator.rs | 28 +++++++++++++++++++----
 rust/kernel/alloc/kbox.rs      | 13 ++++++-----
 rust/kernel/alloc/kvec.rs      | 42 +++++++++++++++++++++++++++-------
 4 files changed, 78 insertions(+), 37 deletions(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 2170b53acd0c..78564eeb987d 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -166,7 +166,7 @@ pub unsafe trait Allocator {
     fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
         // SAFETY: Passing `None` to `realloc` is valid by it's safety requirements and asks for a
         // new memory allocation.
-        unsafe { Self::realloc(None, layout, flags) }
+        unsafe { Self::realloc(None, layout, Layout::new::<()>(), flags) }
     }
 
     /// Re-allocate an existing memory allocation to satisfy the requested `layout`.
@@ -186,26 +186,23 @@ fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
     ///
     /// # Safety
     ///
-    /// If `ptr == Some(p)`, then `p` must point to an existing and valid memory allocation created
-    /// by this allocator. The alignment encoded in `layout` must be smaller than or equal to the
-    /// alignment requested in the previous `alloc` or `realloc` call of the same allocation.
-    ///
-    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
-    /// created.
+    /// - If `ptr == Some(p)`, then `p` must point to an existing and valid memory allocation
+    ///   created by this allocator.
+    /// - `ptr` is allowed to be `None`; in this case a new memory allocation is created.
+    /// - `old_layout` must match the `Layout` the allocation has been created with.
     ///
     /// # Guarantees
     ///
     /// This function has the same guarantees as [`Allocator::alloc`]. When `ptr == Some(p)`, then
     /// it additionally guarantees that:
     /// - the contents of the memory pointed to by `p` are preserved up to the lesser of the new
-    ///   and old size,
-    ///   and old size, i.e.
-    ///   `ret_ptr[0..min(layout.size(), old_size)] == p[0..min(layout.size(), old_size)]`, where
-    ///   `old_size` is the size of the allocation that `p` points at.
-    /// - when the return value is `Err(AllocError)`, then `p` is still valid.
+    ///   and old size, i.e. `ret_ptr[0..min(layout.size(), old_layout.size())] ==
+    ///   p[0..min(layout.size(), old_layout.size())]`.
+    /// - when the return value is `Err(AllocError)`, then `ptr` is still valid.
     unsafe fn realloc(
         ptr: Option<NonNull<u8>>,
         layout: Layout,
+        old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError>;
 
@@ -213,14 +210,13 @@ unsafe fn realloc(
     ///
     /// # Safety
     ///
-    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator` and
-    /// must not be a dangling pointer.
-    ///
-    /// The memory allocation at `ptr` must never again be read from or written to.
-    unsafe fn free(ptr: NonNull<u8>) {
+    /// - `ptr` must point to an existing and valid memory allocation created by this `Allocator`.
+    /// - `layout` must match the `Layout` the allocation has been created with.
+    /// - The memory allocation at `ptr` must never again be read from or written to.
+    unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
         // SAFETY: The caller guarantees that `ptr` points at a valid allocation created by this
         // allocator. We are passing a `Layout` with the smallest possible alignment, so it is
         // smaller than or equal to the alignment previously used with this allocation.
-        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
+        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), layout, Flags(0)) };
     }
 }
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 0b586c0361f4..07820c8c4e17 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -54,6 +54,14 @@ fn aligned_size(new_layout: Layout) -> usize {
     layout.size()
 }
 
+/// Returns a properly aligned dangling pointer from the given `layout`.
+fn zst_realloc(layout: Layout) -> NonNull<u8> {
+    let ptr = layout.align() as *mut u8;
+
+    // SAFETY: `layout.align()` (and hence `ptr`) is guaranteed to be non-zero.
+    unsafe { NonNull::new_unchecked(ptr) }
+}
+
 /// # Invariants
 ///
 /// One of the following `krealloc`, `vrealloc`, `kvrealloc`.
@@ -84,11 +92,18 @@ unsafe fn call(
         &self,
         ptr: Option<NonNull<u8>>,
         layout: Layout,
+        old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
         let size = aligned_size(layout);
         let ptr = match ptr {
-            Some(ptr) => ptr.as_ptr(),
+            Some(ptr) => {
+                if old_layout.size() == 0 {
+                    ptr::null()
+                } else {
+                    ptr.as_ptr()
+                }
+            }
             None => ptr::null(),
         };
 
@@ -106,7 +121,7 @@ unsafe fn call(
         };
 
         let ptr = if size == 0 {
-            NonNull::dangling()
+            zst_realloc(layout)
         } else {
             NonNull::new(raw_ptr).ok_or(AllocError)?
         };
@@ -124,10 +139,11 @@ unsafe impl Allocator for Kmalloc {
     unsafe fn realloc(
         ptr: Option<NonNull<u8>>,
         layout: Layout,
+        old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
         // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
-        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, flags) }
+        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, old_layout, flags) }
     }
 }
 
@@ -140,6 +156,7 @@ unsafe impl Allocator for Vmalloc {
     unsafe fn realloc(
         ptr: Option<NonNull<u8>>,
         layout: Layout,
+        old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
         // TODO: Support alignments larger than PAGE_SIZE.
@@ -150,7 +167,7 @@ unsafe fn realloc(
 
         // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
         // allocated with this `Allocator`.
-        unsafe { ReallocFunc::VREALLOC.call(ptr, layout, flags) }
+        unsafe { ReallocFunc::VREALLOC.call(ptr, layout, old_layout, flags) }
     }
 }
 
@@ -163,6 +180,7 @@ unsafe impl Allocator for KVmalloc {
     unsafe fn realloc(
         ptr: Option<NonNull<u8>>,
         layout: Layout,
+        old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
         // TODO: Support alignments larger than PAGE_SIZE.
@@ -173,6 +191,6 @@ unsafe fn realloc(
 
         // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
         // allocated with this `Allocator`.
-        unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, flags) }
+        unsafe { ReallocFunc::KVREALLOC.call(ptr, layout, old_layout, flags) }
     }
 }
diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index 6188494f040d..e9e2e94430ef 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -5,6 +5,7 @@
 #[allow(unused_imports)] // Used in doc comments.
 use super::allocator::{KVmalloc, Kmalloc, Vmalloc};
 use super::{AllocError, Allocator, Flags};
+use core::alloc::Layout;
 use core::fmt;
 use core::marker::PhantomData;
 use core::mem::ManuallyDrop;
@@ -233,7 +234,7 @@ pub fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>, A>, AllocError> {
         let ptr = if Self::is_zst() {
             NonNull::dangling()
         } else {
-            let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
+            let layout = Layout::new::<MaybeUninit<T>>();
             let ptr = A::alloc(layout, flags)?;
 
             ptr.cast()
@@ -452,14 +453,14 @@ impl<T, A> Drop for Box<T, A>
     A: Allocator,
 {
     fn drop(&mut self) {
-        let size = core::mem::size_of_val::<T>(self);
+        let layout = Layout::for_value::<T>(self);
 
         // SAFETY: The pointer in `self.0` is guaranteed to be valid by the type invariant.
         unsafe { core::ptr::drop_in_place::<T>(self.deref_mut()) };
 
-        if size != 0 {
-            // SAFETY: As `size` is not zero, `self.0` was previously allocated with `A`.
-            unsafe { A::free(self.0.cast()) };
-        }
+        // SAFETY:
+        // - `self.0` was previously allocated with `A`.
+        // - `layout` is equal to the `Layout´ `self.0` was allocated with.
+        unsafe { A::free(self.0.cast(), layout) };
     }
 }
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 686e969463f8..fb979013562c 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -7,6 +7,7 @@
     AllocError, Allocator, Box, Flags,
 };
 use core::{
+    alloc::Layout,
     fmt,
     marker::PhantomData,
     mem::{ManuallyDrop, MaybeUninit},
@@ -452,21 +453,28 @@ pub fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocEr
         // We know `cap` is <= `isize::MAX` because of the type invariants of `Self`. So the
         // multiplication by two won't overflow.
         let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
-        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
+        let layout = Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
+
+        let old_layout = Layout::array::<T>(self.cap).map_err(|_| AllocError)?;
 
         // We need to make sure that `ptr` is either NULL or comes from a previous call to
         // `realloc_flags`. A `Vec<T, A>`'s `ptr` value is not guaranteed to be NULL and might be
         // dangling after being created with `Vec::new`. Instead, we can rely on `Vec<T, A>`'s
         // capacity to be zero if no memory has been allocated yet.
+        //
+        // Still required? In `Vec::new` we use `NonNull::dangling`, which effectively would be
+        // valid to pass to `A::realloc`, but was never created by one the `Allocator`'s functions.
         let ptr = if cap == 0 {
             None
         } else {
             Some(self.ptr.cast())
         };
 
-        // SAFETY: `ptr` is valid because it's either `None` or comes from a previous call to
-        // `A::realloc`. We also verified that the type is not a ZST.
-        let ptr = unsafe { A::realloc(ptr, layout, flags)? };
+        // SAFETY:
+        // - `ptr` is valid because it's either `None` or comes from a previous call to
+        //   `A::realloc`.
+        // - `old_layout` matches the `Layout` of the preceeding allocation, if any.
+        let ptr = unsafe { A::realloc(ptr, layout, old_layout, flags)? };
 
         self.ptr = ptr.cast();
 
@@ -528,9 +536,16 @@ fn drop(&mut self) {
         };
 
         // If `cap == 0` we never allocated any memory in the first place.
+        //
+        // Same here, theoretically, we know that `NonNull::dangling` from `Vec::new` is valid for
+        // `A::free`, but it was never created by any of the `Allocator` functions.
         if self.cap != 0 {
+            // This can never fail; since this `Layout` is equivalent to the one of the original
+            // allocation.
+            let layout = Layout::array::<T>(self.cap).unwrap();
+
             // SAFETY: `self.ptr` was previously allocated with `A`.
-            unsafe { A::free(self.ptr.cast()) };
+            unsafe { A::free(self.ptr.cast(), layout) };
         }
     }
 }
@@ -751,13 +766,17 @@ pub fn collect(self, flags: Flags) -> Vec<T, A> {
             ptr = buf.as_ptr();
         }
 
+        // This can never fail; since this `Layout` is equivalent to the one of the original
+        // allocation.
+        let old_layout = Layout::array::<T>(cap).unwrap();
+
         // This can never fail, `len` is guaranteed to be smaller than `cap`.
-        let layout = core::alloc::Layout::array::<T>(len).unwrap();
+        let layout = Layout::array::<T>(len).unwrap();
 
         // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
         // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
         // it as it is.
-        ptr = match unsafe { A::realloc(Some(buf.cast()), layout, flags) } {
+        ptr = match unsafe { A::realloc(Some(buf.cast()), layout, old_layout, flags) } {
             // If we fail to shrink, which likely can't even happen, continue with the existing
             // buffer.
             Err(_) => ptr,
@@ -846,9 +865,16 @@ fn drop(&mut self) {
         unsafe { ptr::drop_in_place(self.as_raw_mut_slice()) };
 
         // If `cap == 0` we never allocated any memory in the first place.
+        //
+        // Same here, theoretically, we know that `NonNull::dangling` from `Vec::new` is valid for
+        // `A::free`, but it was never created by any of the `Allocator` functions.
         if self.cap != 0 {
+            // This can never fail; since this `Layout` is equivalent to the one of the original
+            // allocation.
+            let layout = Layout::array::<T>(self.cap).unwrap();
+
             // SAFETY: `self.buf` was previously allocated with `A`.
-            unsafe { A::free(self.buf.cast()) };
+            unsafe { A::free(self.buf.cast(), layout) };
         }
     }
 }
-- 
2.46.1


