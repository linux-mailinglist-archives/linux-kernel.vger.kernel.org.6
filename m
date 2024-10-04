Return-Path: <linux-kernel+bounces-350692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B56990815
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1066D28CBDB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A852225B7;
	Fri,  4 Oct 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isdAQEK+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1472225A0;
	Fri,  4 Oct 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056663; cv=none; b=IGMFVDOvSLjfoPlyTHCcYEt0OdALTKFp/0ygDxacw4O3pnfcOCkwp2kQqoWAmSeU0Oyfsbnaz1N4zN+hajH7IFBNuYkbO0BW7cBUEGnrN4wzN6UHbbTkQMoAakdvJyhN3nMrEc7vbrwjPyQHUOWRcbytOq7ZwbrJEnAh0ClXei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056663; c=relaxed/simple;
	bh=co+B+qJ8g94Julx8Nci+IYL+QVSNE672qLhlTjw/JNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTWnWzZga8k9n3rL2XPPDTwiKu+4sK+XlpZoDY1aKrzYx6/SFH7lRY2aXdQXDW5Aw/nnUvhV5gRenJEhxXbd7nRoUMV0bi/UNs23IzCEOVvy5EO7F0uGFRp/dV7UDi4ayXfcgPvhVeofkWQAcxpRj6HX0LGA+4n6uB8EfVppFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isdAQEK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5594AC4CEC6;
	Fri,  4 Oct 2024 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056663;
	bh=co+B+qJ8g94Julx8Nci+IYL+QVSNE672qLhlTjw/JNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=isdAQEK+fyU9LQiPmikCYp+he+tsGnTfNWAcIIkeyh6V5XNcGEHFQYit/ZlRDcAa2
	 IOa1mMRJ6iOotZftnaTIpKf1+8I1A3Hg/20Da19AY13ysIGSwD2d6wdd9//ouP18cz
	 y0vK4k+8CyjavjrnlM+d4IT9RtcikiE1zAT01ZjYBvp2LjtiMNLnYUBi+tMpu9okhH
	 5o0W0NG6ln3yvuNyu4svUcpGRnWXsdthSUKYBLl5LxTgriaBcAVdVYh1O90kT6E8zM
	 5+MyZjCtVE8HQAt0w4vXmUNmEaGCrcmgt79gmeSW+lbC0PhJyxa1jKO7Uuym76dtZO
	 rkkHlrWKeoMAg==
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
Subject: [PATCH v9 25/29] rust: alloc: implement `Cmalloc` in module allocator_test
Date: Fri,  4 Oct 2024 17:41:29 +0200
Message-ID: <20241004154149.93856-26-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004154149.93856-1-dakr@kernel.org>
References: <20241004154149.93856-1-dakr@kernel.org>
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

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
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


