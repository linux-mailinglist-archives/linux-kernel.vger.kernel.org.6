Return-Path: <linux-kernel+bounces-274898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F5947E00
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9545284835
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1F16F0D8;
	Mon,  5 Aug 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZruvTTd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7A15B0E4;
	Mon,  5 Aug 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871352; cv=none; b=jBlyHqpojoI9ATD0E2gSrwuIZzpdObWy79NX0jg5vfDtxO6K3a1oTlK01NNHOsgRg7ndImZQVTkY2iu7p0F86czDBx858tzHo9RSzsYCeul1eLyWWdytzFSTrnhO7S4NB8Vln+q0vk5IwYucR5x2JrlsmamTjfed8cTMzUbSkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871352; c=relaxed/simple;
	bh=iMS9KiH08GatcQmOb0IQ1b8oJCGscNUEkjpp2MaItTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eC1bq7Rh/EjBSIpZQkVUUioO3B58gM4OPWFTYmQ1d88K7RJWY4d7a2PD8E0labWgi2nVdcOsN/nnZT3jywgU2vsbSnFGctRB4r/sRNIcyP8VHD/HMCJFj1AzpKBA+2K6tcGYgRoD4+i7Qf97yK8wmjQxhlGXA9DhE6kRJaxxzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZruvTTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6509BC4AF19;
	Mon,  5 Aug 2024 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871352;
	bh=iMS9KiH08GatcQmOb0IQ1b8oJCGscNUEkjpp2MaItTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZruvTTdj2MIMJkKEyIhRIp90mWSRe8963+FYjpGWG7TDpKeL61kjFpJq6XTHRRsR
	 eJ+XQFqJGJmV7k8G/0tlaqfID7YOd2M4FckoJbAm9lYxR8q2AapulfeMNA3ncLjQ2k
	 5olemvFRi749j1zdg6uxd6KavaIYdMpYze3FXFv1vsJ8vaKPX/KNZV+yL4qJFAnhlV
	 NnWSpoAORm9LM5eYLguKloPcUkXwkZsC7f52Oyu0NNzLc6HjUjgsfIsUqMIlQFIUOk
	 Qfr5K7Sl3G2P96mhhtgNIOu3QGl0TmfOI8HUNePueD1JH5f/4tRXiodHg4fwi0eNd9
	 rczgS8BGkBgxA==
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
Subject: [PATCH v4 25/28] rust: alloc: implement `Cmalloc` in module allocator_test
Date: Mon,  5 Aug 2024 17:19:44 +0200
Message-ID: <20240805152004.5039-26-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805152004.5039-1-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far the kernel's `Box` and `Vec` types can't be used by userspace
test cases, since all users of those types (e.g. `CString`) use kernel
allocators for instantiation.

In order to allow userspace test cases to make use of such types as
well, implement the `Cmalloc` allocator within the allocator_test module
and type alias all kernel allocators to `Cmalloc`. The `Cmalloc`
allocator uses libc's realloc() function as allocator backend.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
I know, having an `old_size` parameter would indeed help implementing `Cmalloc`.

However, I really don't want test infrastructure to influence the design of
kernel internal APIs.

Besides that, adding the `old_size` parameter would have the consequence that
we'd either need to honor it for kernel allocators too (which adds another
source of potential failure) or ignore it for all kernel allocators (which
potentially tricks people into taking wrong assumptions on how the API works).
---
 rust/kernel/alloc/allocator_test.rs | 91 ++++++++++++++++++++++++++---
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index 1b2642c547ec..05fd75b89238 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -2,20 +2,97 @@
 
 #![allow(missing_docs)]
 
-use super::{AllocError, Allocator, Flags};
+use super::{flags::*, AllocError, Allocator, Flags};
 use core::alloc::Layout;
+use core::ptr;
 use core::ptr::NonNull;
 
-pub struct Kmalloc;
+pub struct Cmalloc;
+pub type Kmalloc = Cmalloc;
 pub type Vmalloc = Kmalloc;
 pub type KVmalloc = Kmalloc;
 
-unsafe impl Allocator for Kmalloc {
+extern "C" {
+    #[link_name = "aligned_alloc"]
+    fn libc_aligned_alloc(align: usize, size: usize) -> *mut core::ffi::c_void;
+
+    #[link_name = "free"]
+    fn libc_free(ptr: *mut core::ffi::c_void);
+
+    // Do not use this function for production code! For test cases only it's
+    // probably fine if used with care.
+    #[link_name = "malloc_usable_size"]
+    fn libc_malloc_usable_size(ptr: *mut core::ffi::c_void) -> usize;
+}
+
+unsafe impl Allocator for Cmalloc {
+    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
+        let layout = layout.pad_to_align();
+
+        // SAFETY: Returns either NULL or a pointer to a memory allocation that satisfies or
+        // exceeds the given size and alignment requirements.
+        let raw_ptr = unsafe { libc_aligned_alloc(layout.align(), layout.size()) } as *mut u8;
+
+        if flags.contains(__GFP_ZERO) && !raw_ptr.is_null() {
+            // SAFETY: `raw_ptr` points to memory successfully allocated with `libc_aligned_alloc`.
+            let size = unsafe { libc_malloc_usable_size(raw_ptr.cast()) };
+
+            // SAFETY: `raw_ptr` points to memory successfully allocated with `libc_aligned_alloc`
+            // of at least `size` bytes.
+            unsafe { core::ptr::write_bytes(raw_ptr, 0, size) };
+        }
+
+        let ptr = if layout.size() == 0 {
+            NonNull::dangling()
+        } else {
+            NonNull::new(raw_ptr).ok_or(AllocError)?
+        };
+
+        Ok(NonNull::slice_from_raw_parts(ptr, layout.size()))
+    }
+
     unsafe fn realloc(
-        _ptr: Option<NonNull<u8>>,
-        _layout: Layout,
-        _flags: Flags,
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
-        panic!();
+        let layout = layout.pad_to_align();
+        let src: *mut u8 = if let Some(src) = ptr {
+            src.as_ptr().cast()
+        } else {
+            ptr::null_mut()
+        };
+
+        if layout.size() == 0 {
+            // SAFETY: `src` is either NULL or has previously been allocatored with this
+            // `Allocator`.
+            unsafe { libc_free(src.cast()) };
+
+            return Ok(NonNull::slice_from_raw_parts(NonNull::dangling(), 0));
+        }
+
+        let dst = Self::alloc(layout, flags)?;
+
+        if src.is_null() {
+            return Ok(dst);
+        }
+
+        // SAFETY: `src` is either NULL or has previously been allocatored with this `Allocator`.
+        let old_size = unsafe { libc_malloc_usable_size(src.cast()) };
+
+        // SAFETY: `src` has previously been allocated with this `Allocator`; `dst` has just been
+        // newly allocated. Taking the minimum of their sizes guarantees that we do not exceed
+        // either bounds.
+        unsafe {
+            // Always copy -- do not rely on potential spare memory reported by
+            // malloc_usable_size() which technically may still be sufficient.
+            ptr::copy_nonoverlapping(
+                src,
+                dst.as_ptr().cast(),
+                core::cmp::min(layout.size(), old_size),
+            )
+        };
+
+        Ok(dst)
     }
 }
-- 
2.45.2


