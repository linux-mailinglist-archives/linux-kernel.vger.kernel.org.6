Return-Path: <linux-kernel+bounces-346192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 149DD98C109
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10CFB25886
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A71CCECD;
	Tue,  1 Oct 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2MmSos8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0CA1CB50B;
	Tue,  1 Oct 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794898; cv=none; b=n6KmG91cVX93lpsQdWS9oRgpmObP8y137vEL1ChM2KG5a4/hMro0VkeKRA+9ox24Wy4miYiL6p6KAQbYt2pF8QgKn0AkCGFxE4+r58vo3+zJzPExO3lhRM5kijZM60+jFSW3IunwdQEY3SEkGN18w79CVdbrKf1lfkXCXQ01Ct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794898; c=relaxed/simple;
	bh=p24MKJcAJjQGLu5qkqjJ+M2DWuKlcDIgb3JoJfs9n3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueBpc+Aegc0JUaY86mWXaSOpVKQHmXMiQEhCAzfD9RRza2GWYLpcQERGUsPDt9KmJ/1CXeMahrTBFPkaonFJBS6foa5yzy40YUTERw+UYfX5wXg29MSNLlw2yJUJ7s8v39OsVTJBeLyek31gZlDtT43et2wsyGbOy4cOjLOUThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2MmSos8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0317CC4CED4;
	Tue,  1 Oct 2024 15:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794897;
	bh=p24MKJcAJjQGLu5qkqjJ+M2DWuKlcDIgb3JoJfs9n3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2MmSos8vj270iKzg1Gd1ajTMn1iamxKzb6p6Kq7NIGGkGp+bd2EQjmTp2iiwAU9M
	 OgfxOrLOq5lLJz2Eb6XY9YFUl9FNrYqBf7NsR2ebhpGoea959lfPbDAvA72PqerXBi
	 Urq54dnJmsLqzHcjYKaYwfxUJjSVoDkJ1wa+8EdrQ2WfVwQXsHmu02sHOsXHgs3lKl
	 tvKUCEzVWOvOK+MqTaU+J3GhmkBn3tP314jCa/8tmjJIT2k/IEF7k1UOG9vgzDhuwy
	 dt63f5s4DYvjact7iJYzeMReTeRQbjaUjC4g6KXXpDPooIACjc65RgkDG50OXuIz2V
	 9kXt0QYmCngCA==
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
Subject: [PATCH v8 15/29] rust: alloc: introduce `ArrayLayout`
Date: Tue,  1 Oct 2024 16:59:50 +0200
Message-ID: <20241001150008.183102-16-dakr@kernel.org>
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

From: Benno Lossin <benno.lossin@proton.me>

When allocating memory for arrays using allocators, the `Layout::array`
function is typically used. It returns a result, since the given size
might be too big. However, `Vec` and its iterators store their allocated
capacity and thus they already did check that the size is not too big.

The `ArrayLayout` type provides this exact behavior, as it can be
infallibly converted into a `Layout`. Instead of a `usize` capacity,
`Vec` and other similar array-storing types can use `ArrayLayout`
instead.

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
index 000000000000..a9c987aad8fb
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
+        match len.checked_mul(size_of::<T>()) {
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


