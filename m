Return-Path: <linux-kernel+bounces-274870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E908947DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952B61C21C6B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1A215AD95;
	Mon,  5 Aug 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAqcutSL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4A2D7B8;
	Mon,  5 Aug 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871219; cv=none; b=iTksfi4iTqtWpg6WdPE/Ov9ncW3nzMWJD5/a7pIymxe0upjDdHN/2WBpeUVfchdXq5kb4/WYmfPUp+cnStdmPwhGC+RBwozzTySeGJ090qgwIQA5r5PZ/bDhLP/P50N5AjCa6dxrismYXROL/M7Ohk/YmbEf8eqwqhJ8zmytQL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871219; c=relaxed/simple;
	bh=bj2UZpRhWMoc+XVgxuPd+wiqHp6BzB0ewgAdFDBiTYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KofUgaucSd5JVO1PdIS/OXa4dpHS2Wgpy1QjHmk4EHtN50zZ7a4jsj0+PyjlUJLQlzXMQN/j3I+S4sBiQgqG2pc0TfG7aARpHipgUH/4JaZVqvDyVKJvDMlpvx7kXdvs4gpv3reln1pE12jTR7NIKGfG7TRD6+gPm/x4PLzeCLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAqcutSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6339C4AF0B;
	Mon,  5 Aug 2024 15:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871218;
	bh=bj2UZpRhWMoc+XVgxuPd+wiqHp6BzB0ewgAdFDBiTYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VAqcutSL+jtXhIoRiTSkMmZPCI/bBw3pmkzBP8y2/RKxoqqrgTmBCuv07L8Iry7FG
	 NT2oRfpAarApvL7iwz1AChRLNislMw1SRumZx0OJN2RUOInTDpwna/9AudOBqeXaas
	 NtiHLp1V7RyLar9j3jOLHHQY1wCFnYmRj7XndwW+QkisRNcEYP2hodWSAE4U4lkJ/k
	 QF/m40DR9nXme8xAsCTSNfMtGHmYASh0XxAyI+bL9DFk9aqL1aVsr7+7xGl/GL/qN/
	 mTObrcHiOO3uxo9FZ5CEIXnOXpJLv4ANJ4VS8ESiTb/M3LMiILxa7UllD0tlUkS/Pc
	 577mQVpjXuo9w==
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
Subject: [PATCH v4 01/28] rust: alloc: add `Allocator` trait
Date: Mon,  5 Aug 2024 17:19:20 +0200
Message-ID: <20240805152004.5039-2-dakr@kernel.org>
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

Add a kernel specific `Allocator` trait, that in contrast to the one in
Rust's core library doesn't require unstable features and supports GFP
flags.

Subsequent patches add the following trait implementors: `Kmalloc`,
`Vmalloc` and `KVmalloc`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 1966bd407017..8a71a589469d 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -11,6 +11,7 @@
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
+use core::{alloc::Layout, ptr::NonNull};
 
 /// Flags to be used when allocating memory.
 ///
@@ -86,3 +87,81 @@ pub mod flags {
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
+/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
+/// it is explicitly freed.
+///
+/// Any pointer to a memory buffer which is currently allocated must be valid to be passed to any
+/// other [`Allocator`] function of the same type. The same applies for a NULL pointer.
+///
+/// If `realloc` is called with:
+///   - a size of zero, the given memory allocation, if any, must be freed
+///   - a NULL pointer, a new memory allocation must be created
+pub unsafe trait Allocator {
+    /// Allocate memory based on `layout` and `flags`.
+    ///
+    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
+    /// constraints (i.e. minimum size and alignment as specified by `layout`).
+    ///
+    /// This function is equivalent to `realloc` when called with a NULL pointer.
+    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's safety requirements and asks
+        // for a new memory allocation.
+        unsafe { Self::realloc(None, layout, flags) }
+    }
+
+    /// Re-allocate an existing memory allocation to satisfy the requested `layout`. If the
+    /// requested size is zero, `realloc` behaves equivalent to `free`.
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
+    /// `Some(ptr)` must point to an existing and valid memory allocation created by this allocator
+    /// instance. The alignment encoded in `layout` must be smaller than or equal to the alignment
+    /// requested in the previous `alloc` or `realloc` call of the same allocation.
+    ///
+    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
+    /// created.
+    ///
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
+    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
+    /// instance.
+    unsafe fn free(ptr: NonNull<u8>) {
+        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
+        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
+        let _ = unsafe { Self::realloc(Some(ptr), Layout::new::<()>(), Flags(0)) };
+    }
+}
-- 
2.45.2


