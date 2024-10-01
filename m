Return-Path: <linux-kernel+bounces-346202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA3698C117
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F379D2821F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725251CEEA3;
	Tue,  1 Oct 2024 15:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXHOT/Rl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D11CEE94;
	Tue,  1 Oct 2024 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794951; cv=none; b=g0w76lwGlJqnHe6XpxNCKvN5lv00lj0rXO0xRzv909jpsMeLuDFkuwNo6Oq6ZYQSETUsYnSICQOaGeseJ/YU2AZwz9yFSvMuRVUbapLacPaQT08ijbZFHJpuJDLo0s3/2ZsaxDSOUqA7zyym6lj1Mu3PcfFDh6kZ3jKSFaOv1f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794951; c=relaxed/simple;
	bh=MnOa0U7RkKOR0+keHOw6H4AlceJPUYq3oyu7nzf0U7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwOaObkTqVJImD7P0q+dvJey50Vlx5+TlemeS1hv4sZH/Hbye80Cg6NIZ0DHMFFObh7/f9fd9OXVLHNzvO7MtMLBvPIKn1Uz4yWloiIeopYIHCL1fKse+M9QVmkXvF59fzrjD5CPP5veBoJY2lp9yfElktUYa1YEy/1xpufObxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXHOT/Rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10B0C4CED2;
	Tue,  1 Oct 2024 15:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794951;
	bh=MnOa0U7RkKOR0+keHOw6H4AlceJPUYq3oyu7nzf0U7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXHOT/Rl3F/gV5bzZmYoMj3Lj6bB+QWZ6CFnpagPAn4v3r5fesP9NRdvhyI+8c02G
	 A7Hodb3ILKzIyl9YxMN9XhaINWLBHyJSZMLuJe7cZyor3wU6X8G0XiIPJJKcM3hllg
	 5vyYjdWQ4IWw6JFP9SGBGgr3q0XUwwcBkBg1EgVi8BU0uNJusT02tHclobkE0WTLXI
	 30fSduTv7LTnmP4yCapuQQlkJmxjxZ+HQmSdztcNFGU08Nr/s+jK8TLoKKaGlp9y5F
	 6nXxVYZOI2pLAD4Kx5XyY0xppBDwA+jf1rWm/Qz6wjHkeSTWSuFMHWpq6ihUBbBYxH
	 vRBmarcEnJD2g==
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
Subject: [PATCH v8 25/29] rust: alloc: implement `Cmalloc` in module allocator_test
Date: Tue,  1 Oct 2024 17:00:00 +0200
Message-ID: <20241001150008.183102-26-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001150008.183102-1-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
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
 rust/kernel/alloc/allocator_test.rs | 88 ++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index 1b2642c547ec..47c2b509898e 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -1,21 +1,95 @@
 // SPDX-License-Identifier: GPL-2.0
 
+//! So far the kernel's `Box` and `Vec` types can't be used by userspace test cases, since all users
+//! of those types (e.g. `CString`) use kernel allocators for instantiation.
+//!
+//! In order to allow userspace test cases to make use of such types as well, implement the
+//! `Cmalloc` allocator within the allocator_test module and type alias all kernel allocators to
+//! `Cmalloc`. The `Cmalloc` allocator uses libc's realloc() function as allocator backend.
+
 #![allow(missing_docs)]
 
-use super::{AllocError, Allocator, Flags};
+use super::{flags::*, AllocError, Allocator, Flags};
 use core::alloc::Layout;
+use core::cmp;
+use core::ptr;
 use core::ptr::NonNull;
 
-pub struct Kmalloc;
+/// The userspace allocator based on libc.
+pub struct Cmalloc;
+
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
+}
+
+// SAFETY:
+// - memory remains valid until it is explicitly freed,
+// - passing a pointer to a valid memory allocation created by this `Allocator` is always OK,
+// - `realloc` provides the guarantees as provided in the `# Guarantees` section.
+unsafe impl Allocator for Cmalloc {
     unsafe fn realloc(
-        _ptr: Option<NonNull<u8>>,
-        _layout: Layout,
-        _flags: Flags,
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
+        flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
-        panic!();
+        let src = match ptr {
+            Some(src) => {
+                if old_layout.size() == 0 {
+                    ptr::null_mut()
+                } else {
+                    src.as_ptr()
+                }
+            }
+            None => ptr::null_mut(),
+        };
+
+        if layout.size() == 0 {
+            // SAFETY: `src` is either NULL or was previously allocated with this `Allocator`
+            unsafe { libc_free(src.cast()) };
+
+            return Ok(NonNull::slice_from_raw_parts(
+                crate::alloc::dangling_from_layout(layout),
+                0,
+            ));
+        }
+
+        // SAFETY: Returns either NULL or a pointer to a memory allocation that satisfies or
+        // exceeds the given size and alignment requirements.
+        let dst = unsafe { libc_aligned_alloc(layout.align(), layout.size()) } as *mut u8;
+        let dst = NonNull::new(dst).ok_or(AllocError)?;
+
+        if flags.contains(__GFP_ZERO) {
+            // SAFETY: The preceeding calls to `libc_aligned_alloc` and `NonNull::new`
+            // guarantee that `dst` points to memory of at least `layout.size()` bytes.
+            unsafe { dst.as_ptr().write_bytes(0, layout.size()) };
+        }
+
+        if !src.is_null() {
+            // SAFETY:
+            // - `src` has previously been allocated with this `Allocator`; `dst` has just been
+            //   newly allocated, hence the memory regions do not overlap.
+            // - both` src` and `dst` are properly aligned and valid for reads and writes
+            unsafe {
+                ptr::copy_nonoverlapping(
+                    src,
+                    dst.as_ptr(),
+                    cmp::min(layout.size(), old_layout.size()),
+                )
+            };
+        }
+
+        // SAFETY: `src` is either NULL or was previously allocated with this `Allocator`
+        unsafe { libc_free(src.cast()) };
+
+        Ok(NonNull::slice_from_raw_parts(dst, layout.size()))
     }
 }
-- 
2.46.1


