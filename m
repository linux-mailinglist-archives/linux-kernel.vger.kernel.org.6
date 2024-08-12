Return-Path: <linux-kernel+bounces-283585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5222F94F69B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B1D1F2310E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD90018E741;
	Mon, 12 Aug 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0S8qU3y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5151891D6;
	Mon, 12 Aug 2024 18:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487054; cv=none; b=Y/DcIAegMtxyXJwoUv6wRKsz9i/uTXYphY4cW16jOU0NRWnTJnrIQZ2ZHTIyz6goU3Vr8wxgXC0jsb9ygUjOedxZr9GB9CO/2LzEKMcc6VSRnv/IzG1rv/zempoORwzti9cb9fTXt9yNFuPBXfbQDJgMKbFTxm6fQhN5orus3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487054; c=relaxed/simple;
	bh=M1Wwvc1PMQiy2tSYLyMdNK6lKzi7oyHYDv/dPN7vzzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmnlSzur+yyKkurrz1hWI51wUpzbz1sWn1mBYAZzz9TYc4wIer/Po4lebWB8DtitmXi0R5ITxYUt0Qty20BYRf1gTe9lsJqhgDFIqYe83dwg2cxRMp1eu/ZicxZAAR07H14N9wwXdAul7j+geWCOCEcDS3AZ26TQ56mXfuMDi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0S8qU3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F796C4AF0C;
	Mon, 12 Aug 2024 18:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487053;
	bh=M1Wwvc1PMQiy2tSYLyMdNK6lKzi7oyHYDv/dPN7vzzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y0S8qU3yW9xyw0FV2WFxe5tJ6xfV6A4RAetYAlao35rcuYSGc3kxSqYYOSIyvSGlg
	 K8gPFxuu8eGEvuDuHp3ZV3P0n7swgSZjhvDt9zUqOVkjrhDqRVAi1HStM8lFhN5MNr
	 nNuR0gbj94xcaN4MVpSpjulAxr4U5pGB7IsCuEUSxTatJDviLEojsaGJv6I80fmkEM
	 wkossGl3of7NM3pu7JsEEQ7ht8amVK9+dr2vIUWHKOBt8uGBn/HHv21Z4IbjnTqNGD
	 +AEzlU/2/bQ5SghHXgTa+OqtHrdSQbt2bzs4J9GWPWPGrO5IvTd9rPEFopHNBoBKWX
	 5l+1AxcAqop7Q==
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
Subject: [PATCH v5 01/26] rust: alloc: add `Allocator` trait
Date: Mon, 12 Aug 2024 20:22:47 +0200
Message-ID: <20240812182355.11641-2-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812182355.11641-1-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org>
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
 rust/kernel/alloc.rs | 81 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 1966bd407017..194745498a75 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -11,6 +11,7 @@
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
+use core::{alloc::Layout, ptr::NonNull};
 
 /// Flags to be used when allocating memory.
 ///
@@ -86,3 +87,83 @@ pub mod flags {
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
+/// other [`Allocator`] function of the same type.
+///
+/// If `realloc` is called with:
+///   - a size of zero, the given memory allocation, if any, must be freed
+///   - `None`, a new memory allocation must be created
+pub unsafe trait Allocator {
+    /// Allocate memory based on `layout` and `flags`.
+    ///
+    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the layout
+    /// constraints (i.e. minimum size and alignment as specified by `layout`).
+    ///
+    /// This function is equivalent to `realloc` when called with `None`.
+    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: Passing `None` to `realloc` is valid by it's safety requirements and asks for a
+        // new memory allocation.
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
+    /// If `ptr = Some(p)`, then `p` must point to an existing and valid memory allocation created
+    /// by this allocator. The alignment encoded in `layout` must be smaller than or equal to the
+    /// alignment requested in the previous `alloc` or `realloc` call of the same allocation.
+    ///
+    /// Additionally, `ptr` is allowed to be `None`; in this case a new memory allocation is
+    /// created.
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
2.45.2


