Return-Path: <linux-kernel+bounces-260272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508FC93A546
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038DD283A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244EB158A18;
	Tue, 23 Jul 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjrbMJLC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BACF13B5B4;
	Tue, 23 Jul 2024 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758259; cv=none; b=ZuWrXi5mBKArw1I4eKYp9W7dXm5fxbMRAH/BDzHQez/awFguV3aWWEUyHzTX7G+mv5rDvRXEkgUkZrE+SOntJMaNBhB8yjx4OL9nEC52EIBits67FAubRKA2i/TFKnEfBG9uTCOo36rWeNiDEmpcVzS723SCAhsA32/7RIg99LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758259; c=relaxed/simple;
	bh=U0O51DFRkgND42OAvkxZ2VxyksXXw+gcqA7TuTA2fv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9hsIKlgtynP8zqJMeDPXtdgCSa4jkTT0hY+RuHsR/VIrgvvEZHFgJEfMKrFi0ZHdVW1FvHff/2gcGhV4Js9a/SK6VkxP/J8nptDa8LBpqGfHbANaVAGjZYQrLjnUXo3/MHuvToWSzvzQQL8Z5BHn/373Hewni8gP/PvNg2AK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjrbMJLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFE7C4AF0E;
	Tue, 23 Jul 2024 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758258;
	bh=U0O51DFRkgND42OAvkxZ2VxyksXXw+gcqA7TuTA2fv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjrbMJLCrzNPfee1nrhopoa1trofVE4tsz7J1F3oNIona4S90KwXUIalrPc8F6Au1
	 46nGN4ic64WLD5fDUuucmc/HhC1cOY4syzUfFChpzeE4AM7ckrJeojfV8VwRDpRv0Z
	 +/qyz4B/fZZirH7/DC0AhSHsYbcha0LPevAR7/vXcfTV358pu6PsnbaGR0olFKOvTH
	 bz09bgRNONd+ULZe8XXTjlHDJjO4TgZCW7tmStTGIIUI/XbdiTIpIzsQ75GyEj9uLP
	 4WDgR1Dyd00ajlYfCKX0wINAWgV0usrCz2mK8CrH4RwG5Oo2heQxPXsUnejR22ymwV
	 C5JRoF7PkYGxg==
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
Subject: [PATCH v2 01/23] rust: alloc: add `Allocator` trait
Date: Tue, 23 Jul 2024 20:09:50 +0200
Message-ID: <20240723181024.21168-2-dakr@kernel.org>
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

Add a kernel specific `Allocator` trait, that in contrast to the one in
Rust's core library doesn't require unstable features and supports GFP
flags.

Subsequent patches add the following trait implementors: `Kmalloc`,
`Vmalloc` and `KVmalloc`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 531b5e471cb1..11d12264c194 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -11,6 +11,7 @@
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
+use core::{alloc::Layout, ptr::NonNull};
 
 /// Flags to be used when allocating memory.
 ///
@@ -71,3 +72,75 @@ pub mod flags {
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
+/// # Safety
+///
+/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
+/// it is explicitly freed.
+///
+/// Any pointer to a memory buffer which is currently allocated must be valid to be passed to any
+/// other [`Allocator`] function. The same applies for a NULL pointer.
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
+    /// `ptr` must point to an existing and valid memory allocation created by this allocator
+    /// instance.
+    ///
+    /// Additionally, `ptr` is allowed to be a NULL pointer; in this case a new memory allocation is
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


