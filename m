Return-Path: <linux-kernel+bounces-288736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A91953E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479B11C2193C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB584C85;
	Fri, 16 Aug 2024 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHAELe33"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C096F2F43;
	Fri, 16 Aug 2024 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767150; cv=none; b=jM/qlb6pmFWRzPG/c374VKhren6hxUUoYRUhXMz0x0AEScLbu1OlXx2tm3/ZvxRNij58Dje751ybcwmeAd7GpEVunK8QXniQZ2sEwiknowfdo607M0Z4WZNMriieRL3fndlT2DiB4/gfYnwVBeghZuoSUgCJSBNz4Js1VUrd0/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767150; c=relaxed/simple;
	bh=q5RlNxfkOyLhc4BgL6waKEiGm6mWXft+//KdK2R27M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYSjvr5IuWANPCgCcvBAkpA8Cd+1vq4R7/HCBrzdVoaR4aiKDHn+Y5RzBjbWct3bcAd8qaoVTRyL9myEKxOBmt87m4SZoR7uKNivup6g8RU230UPQLWqepwDtss5UhiZ01E4a5L5fWuI69EfJkYnGA4UVZV6KajNrHaLXgm8UEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHAELe33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA4AC4AF09;
	Fri, 16 Aug 2024 00:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767150;
	bh=q5RlNxfkOyLhc4BgL6waKEiGm6mWXft+//KdK2R27M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHAELe33Ua3jRDxbSxhvloXmYD45gcH+zzoE+3wSpdYojUyPsqnnjpsXyLQkCnZmw
	 qGXEbtqFSDD21/hS1rLaCDCOuJw15Z6EmLmJYatnBupG26mWIPTi+IUQ9XGCHwsZhp
	 x74Y0Ztdeq95QwupMO+oJ5J1C39IeowFODY0W3se/2naWCjnnkwbtTWNpzH7etTewP
	 ihJTjiLb/YVxcXbbMegBv55uvc2wJ1RuxeA5ssNQbkZogN25k3YRe9xluyiSfM0rSg
	 jHhNCqJUc6HDriX5Ie9m21BpHGt2u1C1lC6lAQGGsiI5e2ZGRIHoiHVRAiDJ/12mC1
	 L+RaFrjKBhfgw==
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
Subject: [PATCH v6 01/26] rust: alloc: add `Allocator` trait
Date: Fri, 16 Aug 2024 02:10:43 +0200
Message-ID: <20240816001216.26575-2-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816001216.26575-1-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a kernel specific `Allocator` trait, that in contrast to the one in
Rust's core library doesn't require unstable features and supports GFP
flags.

Subsequent patches add the following trait implementors: `Kmalloc`,
`Vmalloc` and `KVmalloc`.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 102 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 1966bd407017..9932f21b0539 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -11,6 +11,7 @@
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
+use core::{alloc::Layout, ptr::NonNull};
 
 /// Flags to be used when allocating memory.
 ///
@@ -86,3 +87,104 @@ pub mod flags {
     /// small allocations.
     pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
 }
+
+/// The kernel's [`Allocator`] trait.
+///
+/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffer described
+/// via [`Layout`].
+///
+/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] functions do not operate on
+/// an object instance.
+///
+/// In order to be able to support `#[derive(SmartPointer)]` later on, we need to avoid a design
+/// that requires an `Allocator` to be instantiated, hence its functions must not contain any kind
+/// of `self` parameter.
+///
+/// # Safety
+///
+/// A memory allocation returned from an allocator must remain valid until it is explicitly freed.
+///
+/// Any pointer to a valid memory allocation must be valid to be passed to any other [`Allocator`]
+/// function of the same type.
+///
+/// Implementers must ensure that all trait functions abide by the guarantees documented in the
+/// `# Guarantees` sections.
+pub unsafe trait Allocator {
+    /// Allocate memory based on `layout` and `flags`.
+    ///
+    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
+    /// constraints (i.e. minimum size and alignment as specified by `layout`).
+    ///
+    /// This function is equivalent to `realloc` when called with `None`.
+    ///
+    /// # Guarantees
+    ///
+    /// When the return value is `Ok(ptr)`, then `ptr` is
+    /// - valid for reads and writes for `layout.size()` bytes, until it is passed to
+    ///   [`Allocator::free`] or [`Allocator::realloc`],
+    /// - aligned to `layout.align()`,
+    ///
+    /// Additionally, `Flags` are honored as documented in
+    /// <https://docs.kernel.org/core-api/mm-api.html#mm-api-gfp-flags>.
+    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: Passing `None` to `realloc` is valid by it's safety requirements and asks for a
+        // new memory allocation.
+        unsafe { Self::realloc(None, layout, flags) }
+    }
+
+    /// Re-allocate an existing memory allocation to satisfy the requested `layout`.
+    ///
+    /// If the requested size is zero, `realloc` behaves equivalent to `free`.
+    ///
+    /// If the requested size is larger than the size of the existing allocation, a successful call
+    /// to `realloc` guarantees that the new or grown buffer has at least `Layout::size` bytes, but
+    /// may also be larger.
+    ///
+    /// If the requested size is smaller than the size of the existing allocation, `realloc` may or
+    /// may not shrink the buffer; this is implementation specific to the allocator.
+    ///
+    /// On allocation failure, the existing buffer, if any, remains valid.
+    ///
+    /// The buffer is represented as `NonNull<[u8]>`.
+    ///
+    /// # Safety
+    ///
+    /// If `ptr == Some(p)`, then `p` must point to an existing and valid memory allocation created
+    /// by this allocator. The alignment encoded in `layout` must be smaller than or equal to the
+    /// alignment requested in the previous `alloc` or `realloc` call of the same allocation.
+    ///
+    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
+    /// created.
+    ///
+    /// # Guarantees
+    ///
+    /// This function has the same guarantees as [`Allocator::alloc`]. When `ptr == Some(p)`, then
+    /// it additionally guarantees that:
+    /// - the contents of the memory pointed to by `p` are preserved up to the lesser of the new
+    ///   and old size,
+    ///   and old size, i.e.
+    ///   `ret_ptr[0..min(layout.size(), old_size)] == p[0..min(layout.size(), old_size)]`, where
+    ///   `old_size` is the size of the allocation that `p` points at.
+
+    /// - when the return value is `Err(AllocError)`, then `p` is still valid.
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError>;
+
+    /// Free an existing memory allocation.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator` and
+    /// must not be a dangling pointer.
+    ///
+    /// The memory allocation at `ptr` must never again be read from or written to.
+    unsafe fn free(ptr: NonNull<u8>) {
+        // SAFETY: The caller guarantees that `ptr` points at a valid allocation created by this
+        // allocator. We are passing a `Layout` with the smallest possible alignment, so it is
+        // smaller than or equal to the alignment previously used with this allocation.
+        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
+    }
+}
-- 
2.46.0


