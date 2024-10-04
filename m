Return-Path: <linux-kernel+bounces-350682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298A699080C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B2B1C2178F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9A021F41E;
	Fri,  4 Oct 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM3Uexz0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E41C7260;
	Fri,  4 Oct 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056607; cv=none; b=QcoPQ6lTDhNO7Aw4/a9jjuEQL7dsdcSNrK4s2DCzOJ+znjezlKLw9u6dJ3z8T7Rg/JWGRchKzUK5wnjT9hgzOutKDTiIqTWTBKK5fxssSpLbp7f5lz/5F2jW1WKo/NScZHhue5JI/wP1OPt4iCdjVVRKOBZo1DAqIkreW76EcBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056607; c=relaxed/simple;
	bh=Q+ML1ibWYAYZGeFhUyhzJzIY+ZOBQOky3D240qlJo4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzF9NYW+uO5d9LNMxMmZnRb1vipIYLe6rlrnxkJXvQuF/9wky9dZ0M4ooF9LDrQiSqrpsdxoAuTDwgoDNqqaIKuvYmhMPEgMZa2HsHjDFvJPmvkALEnMmhXabqAIB+AOgZ3i4tlRY74UIPPaYj5A/1fce6ugama1kaNHPe7ZmSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM3Uexz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E9FC4CEC6;
	Fri,  4 Oct 2024 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056607;
	bh=Q+ML1ibWYAYZGeFhUyhzJzIY+ZOBQOky3D240qlJo4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mM3Uexz0BDtA61JTp90r4hhfmffR8zBUbDJS9Gck2GzwPkQJWdqGF2kXRaGcmrWMN
	 4Y8NSqhOW8sicnvOmy7Ak7+p+pdc6kyeteR2Cbv7utjnJkv7Gyl0gCgA3FSJbUhGz9
	 kORuqJ0DrEuV9XfjA6LDLbtV/iZ1GKQO4h4zfXR4goB+P+w/rg5I0gqUDQAoVLsLnw
	 cercRS/hZcyU4baHwPeYm3rhtRMVvDUZZrXbG1O8+gULiTC2ecYEGj18pizpQ1g7qQ
	 kSFtD72R8ROVqH7OsEpN3dXlKW13qg6430qMwWMIZ+nEeZEQvAcEz4dylkb/jGbzWs
	 5j4auh5MnXLQA==
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
Subject: [PATCH v9 15/29] rust: alloc: introduce `ArrayLayout`
Date: Fri,  4 Oct 2024 17:41:19 +0200
Message-ID: <20241004154149.93856-16-dakr@kernel.org>
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

From: Benno Lossin <benno.lossin@proton.me>

When allocating memory for arrays using allocators, the `Layout::array`
function is typically used. It returns a result, since the given size
might be too big. However, `Vec` and its iterators store their allocated
capacity and thus they already did check that the size is not too big.

The `ArrayLayout` type provides this exact behavior, as it can be
infallibly converted into a `Layout`. Instead of a `usize` capacity,
`Vec` and other similar array-storing types can use `ArrayLayout`
instead.

Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs        |  1 +
 rust/kernel/alloc/layout.rs | 91 +++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)
 create mode 100644 rust/kernel/alloc/layout.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index ebe58247504f..bf143a71d53d 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,6 +5,7 @@
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
 pub mod kbox;
+pub mod layout;
 pub mod vec_ext;
 
 #[cfg(any(test, testlib))]
diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
new file mode 100644
index 000000000000..7f0427a4d3d8
--- /dev/null
+++ b/rust/kernel/alloc/layout.rs
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Memory layout.
+//!
+//! Custom layout types extending or improving [`Layout`].
+
+use core::{alloc::Layout, marker::PhantomData};
+
+/// Error when constructing an [`ArrayLayout`].
+pub struct LayoutError;
+
+/// A layout for an array `[T; n]`.
+///
+/// # Invariants
+///
+/// - `len * size_of::<T>() <= isize::MAX`
+pub struct ArrayLayout<T> {
+    len: usize,
+    _phantom: PhantomData<fn() -> T>,
+}
+
+impl<T> Clone for ArrayLayout<T> {
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+impl<T> Copy for ArrayLayout<T> {}
+
+const ISIZE_MAX: usize = isize::MAX as usize;
+
+impl<T> ArrayLayout<T> {
+    /// Creates a new layout for `[T; 0]`.
+    pub const fn empty() -> Self {
+        // INVARIANT: `0 * size_of::<T>() <= isize::MAX`
+        Self {
+            len: 0,
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Creates a new layout for `[T; len]`.
+    ///
+    /// # Errors
+    ///
+    /// When `len * size_of::<T>()` overflows or when `len * size_of::<T>() > isize::MAX`.
+    pub const fn new(len: usize) -> Result<Self, LayoutError> {
+        match len.checked_mul(core::mem::size_of::<T>()) {
+            Some(len) if len <= ISIZE_MAX => {
+                // INVARIANT: we checked above that `len * size_of::<T>() <= isize::MAX`
+                Ok(Self {
+                    len,
+                    _phantom: PhantomData,
+                })
+            }
+            _ => Err(LayoutError),
+        }
+    }
+
+    /// Creates a new layout for `[T; len]`.
+    ///
+    /// # Safety
+    ///
+    /// `len` must be a value, for which `len * size_of::<T>() <= isize::MAX` is true.
+    pub unsafe fn new_unchecked(len: usize) -> Self {
+        // INVARIANT: By the safety requirements of this function
+        // `len * size_of::<T>() <= isize::MAX`.
+        Self {
+            len,
+            _phantom: PhantomData,
+        }
+    }
+
+    /// Returns the number of array elements represented by this layout.
+    pub const fn len(&self) -> usize {
+        self.len
+    }
+
+    /// Returns `true` when no array elements are represented by this layout.
+    pub const fn is_empty(&self) -> bool {
+        self.len == 0
+    }
+}
+
+impl<T> From<ArrayLayout<T>> for Layout {
+    fn from(value: ArrayLayout<T>) -> Self {
+        let res = Layout::array::<T>(value.len);
+        // SAFETY: by the type invariant of `ArrayLayout` we have
+        // `len * size_of::<T>() <= isize::MAX` and thus the result must be `Ok`.
+        unsafe { res.unwrap_unchecked() }
+    }
+}
-- 
2.46.1


