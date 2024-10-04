Return-Path: <linux-kernel+bounces-350673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A3990800
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8477D281846
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C9B216A2B;
	Fri,  4 Oct 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgIP+fTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93E1DF845;
	Fri,  4 Oct 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056558; cv=none; b=RuqD1LuITCN7/5WNedezeVprt5HM/Jt2wmE58pMn7ltHu0bWqwVJppuebXfnzBhCvmgQFa8Xbpca11SY/Lg8Xo7BOCy8ATL4zVhWNwOJvShvdgN1LR3Wtfv2wvXDBJoycj5MbNmHD0F99HfbetEMc7T9IgR0o/goqrH50IPBDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056558; c=relaxed/simple;
	bh=WMfOs4LG4FcoFF7HvER0kneu0SsNLoPkbGbTFCvgLjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGoeQtFz8vmT418sbyPtUpmxk33+K8T1wtko05ikqLybI8bdjSJMEabZ28Tt0hwcdjLLlOlig7XtbQZZ7PI7/5BlH+ToFLjUuhrj0obFWRbjuAWvCjJyLuGdkLotNAUhcNiNL1sz/8+18ROhNIwDEOae9CXuGfL/sZ4dFqlCmZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgIP+fTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D46EC4CEC6;
	Fri,  4 Oct 2024 15:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056558;
	bh=WMfOs4LG4FcoFF7HvER0kneu0SsNLoPkbGbTFCvgLjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgIP+fTyX7lwjVlnpmUyGjOJZynK9iiYrJ1weIGyEyn4HIs0F5TN1pp1cwK2jj/oJ
	 41Rd3fxoq7eW1KKElQYZRH6QXoHEfGl8QtcapXpTVKm4+FaSiP5QIg2njJwHir2YsH
	 jfTO1eTd6sZUn+4rporGAsUPmMVD75txon7Bk5OBZ5mTQDBCx9jfdeQ7pR/a5ED45e
	 Q3GTVUw0R/LGjBm/hUASbRIBRsypT3vGThTkUmrnuwfbPMU5p+qV/hAc496btDURlO
	 i5zN3rdjaPsfxoOGzu0yjs7POkDsibjNx9eySUuTBaPSC2bWajwdVUKDyosIU+4Wov
	 ci7cEGqNZPRDA==
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
Subject: [PATCH v9 06/29] rust: alloc: implement `Allocator` for `Kmalloc`
Date: Fri,  4 Oct 2024 17:41:10 +0200
Message-ID: <20241004154149.93856-7-dakr@kernel.org>
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

Implement `Allocator` for `Kmalloc`, the kernel's default allocator,
typically used for objects smaller than page size.

All memory allocations made with `Kmalloc` end up in `krealloc()`.

It serves as allocator for the subsequently introduced types `KBox` and
`KVec`.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/allocator.rs | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index e5bac90046a4..b1894c800448 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -13,10 +13,16 @@
 use core::ptr;
 use core::ptr::NonNull;
 
-use crate::alloc::AllocError;
+use crate::alloc::{AllocError, Allocator};
 use crate::bindings;
 
-struct Kmalloc;
+/// The contiguous kernel allocator.
+///
+/// `Kmalloc` is typically used for physically contiguous allocations up to page size, but also
+/// supports larger allocations up to `bindings::KMALLOC_MAX_SIZE`, which is hardware specific.
+///
+/// For more details see [self].
+pub struct Kmalloc;
 
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
@@ -53,8 +59,10 @@ struct ReallocFunc(
     unsafe extern "C" fn(*const core::ffi::c_void, usize, u32) -> *mut core::ffi::c_void,
 );
 
-#[expect(dead_code)]
 impl ReallocFunc {
+    // INVARIANT: `krealloc` satisfies the type invariants.
+    const KREALLOC: Self = Self(bindings::krealloc);
+
     /// # Safety
     ///
     /// This method has the same safety requirements as [`Allocator::realloc`].
@@ -106,6 +114,23 @@ unsafe fn call(
     }
 }
 
+// SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
+// - memory remains valid until it is explicitly freed,
+// - passing a pointer to a valid memory allocation is OK,
+// - `realloc` satisfies the guarantees, since `ReallocFunc::call` has the same.
+unsafe impl Allocator for Kmalloc {
+    #[inline]
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        old_layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
+        unsafe { ReallocFunc::KREALLOC.call(ptr, layout, old_layout, flags) }
+    }
+}
+
 // SAFETY: TODO.
 unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
-- 
2.46.1


