Return-Path: <linux-kernel+bounces-325724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD919975D82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684FA281046
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DF71BF819;
	Wed, 11 Sep 2024 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1fzmL5S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6E1BB6BE;
	Wed, 11 Sep 2024 22:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095391; cv=none; b=cyGHvJmEhia7UYvzDxOv4Gd9bVFZt2zGaIf7GeuVTD6jmLv/GfaGo2c4BGhTvUmX3/nel9XhCKZcr1mWgpQGUfujjQAqPkuTnQjnOgznkJ+Q3JHsUk2lOoohT2vb7vLOD+iTIJbymDWn84pacwS3NhJS8ZZ3ddBO6dMvnOV1fA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095391; c=relaxed/simple;
	bh=yPcuj3XtLEYkObWgOAn3jFjUUb0DA9DkDjwxMGFkw5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBNu6LGueKPYsxAxmTlPX0vL8tJao3W0a6t5+jMNn4sLyymjJZqVO1PTiOe5MhagM7IGvP7AbQp2Vtd0B0jOtWYpClcwX8uUqB29dso+LLIOGerQqE2Ez8NZjcBasB6Of7IyB4OWlINA/gLap0KNInyWhhXiLX4DNwRksQdk+6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1fzmL5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BECCC4CEC0;
	Wed, 11 Sep 2024 22:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095391;
	bh=yPcuj3XtLEYkObWgOAn3jFjUUb0DA9DkDjwxMGFkw5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1fzmL5S6iQ1G+qZ/fN386/6hhCpMJfzoO9SOlVZn5KWJLa2HfFxIt/w+Egnv8h3h
	 HT9v6Q4SB7R+/+VZxqKo+/mJUS8O5xSciW0sg0UDKyqsRAG95oE8dVfrI651/vMT3R
	 0CTJ8r8yu3xWu87nlJqaryIV/oHJw8vbFyAtw8jtF96eULb3Ayho627G0dEbAmbv9t
	 4FhTcE4hv82Bg/AFGixyp5i9hY2KTtp817gsJ2zWDNEwj2GMR5yboGekSAbBRoTIHd
	 m6sscVy1W6eWekGQhiBraXqn9lrX4GELtYvqB4lcb/36In7HZgYYidyW7dQRKLE/lC
	 v1nbUA14OqFgw==
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
Subject: [PATCH v7 17/26] rust: alloc: remove `VecExt` extension
Date: Thu, 12 Sep 2024 00:52:53 +0200
Message-ID: <20240911225449.152928-18-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911225449.152928-1-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all existing `Vec` users were moved to the kernel `Vec` type,
remove the `VecExt` extension.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs         |   1 -
 rust/kernel/alloc/vec_ext.rs | 185 -----------------------------------
 rust/kernel/prelude.rs       |   5 +-
 3 files changed, 1 insertion(+), 190 deletions(-)
 delete mode 100644 rust/kernel/alloc/vec_ext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index e8fbae2adadb..aabdf80e4f7b 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -6,7 +6,6 @@
 pub mod allocator;
 pub mod kbox;
 pub mod kvec;
-pub mod vec_ext;
 
 #[cfg(any(test, testlib))]
 pub mod allocator_test;
diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
deleted file mode 100644
index 1297a4be32e8..000000000000
--- a/rust/kernel/alloc/vec_ext.rs
+++ /dev/null
@@ -1,185 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-//! Extensions to [`Vec`] for fallible allocations.
-
-use super::{AllocError, Flags};
-use alloc::vec::Vec;
-
-/// Extensions to [`Vec`].
-pub trait VecExt<T>: Sized {
-    /// Creates a new [`Vec`] instance with at least the given capacity.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let v = Vec::<u32>::with_capacity(20, GFP_KERNEL)?;
-    ///
-    /// assert!(v.capacity() >= 20);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError>;
-
-    /// Appends an element to the back of the [`Vec`] instance.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let mut v = Vec::new();
-    /// v.push(1, GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1]);
-    ///
-    /// v.push(2, GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1, 2]);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>;
-
-    /// Pushes clones of the elements of slice into the [`Vec`] instance.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let mut v = Vec::new();
-    /// v.push(1, GFP_KERNEL)?;
-    ///
-    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1, 20, 30, 40]);
-    ///
-    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
-    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
-    where
-        T: Clone;
-
-    /// Ensures that the capacity exceeds the length by at least `additional` elements.
-    ///
-    /// # Examples
-    ///
-    /// ```
-    /// let mut v = Vec::new();
-    /// v.push(1, GFP_KERNEL)?;
-    ///
-    /// v.reserve(10, GFP_KERNEL)?;
-    /// let cap = v.capacity();
-    /// assert!(cap >= 10);
-    ///
-    /// v.reserve(10, GFP_KERNEL)?;
-    /// let new_cap = v.capacity();
-    /// assert_eq!(new_cap, cap);
-    ///
-    /// # Ok::<(), Error>(())
-    /// ```
-    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError>;
-}
-
-impl<T> VecExt<T> for Vec<T> {
-    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
-        let mut v = Vec::new();
-        <Self as VecExt<_>>::reserve(&mut v, capacity, flags)?;
-        Ok(v)
-    }
-
-    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
-        <Self as VecExt<_>>::reserve(self, 1, flags)?;
-        let s = self.spare_capacity_mut();
-        s[0].write(v);
-
-        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
-        // by 1. We also know that the new length is <= capacity because of the previous call to
-        // `reserve` above.
-        unsafe { self.set_len(self.len() + 1) };
-        Ok(())
-    }
-
-    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
-    where
-        T: Clone,
-    {
-        <Self as VecExt<_>>::reserve(self, other.len(), flags)?;
-        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
-            slot.write(item.clone());
-        }
-
-        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
-        // the length by the same amount. We also know that the new length is <= capacity because
-        // of the previous call to `reserve` above.
-        unsafe { self.set_len(self.len() + other.len()) };
-        Ok(())
-    }
-
-    #[cfg(any(test, testlib))]
-    fn reserve(&mut self, additional: usize, _flags: Flags) -> Result<(), AllocError> {
-        Vec::reserve(self, additional);
-        Ok(())
-    }
-
-    #[cfg(not(any(test, testlib)))]
-    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
-        let len = self.len();
-        let cap = self.capacity();
-
-        if cap - len >= additional {
-            return Ok(());
-        }
-
-        if core::mem::size_of::<T>() == 0 {
-            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
-            return Err(AllocError);
-        }
-
-        // We know cap is <= `isize::MAX` because `Layout::array` fails if the resulting byte size
-        // is greater than `isize::MAX`. So the multiplication by two won't overflow.
-        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
-        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
-
-        let (old_ptr, len, cap) = destructure(self);
-
-        // We need to make sure that `ptr` is either NULL or comes from a previous call to
-        // `krealloc_aligned`. A `Vec<T>`'s `ptr` value is not guaranteed to be NULL and might be
-        // dangling after being created with `Vec::new`. Instead, we can rely on `Vec<T>`'s capacity
-        // to be zero if no memory has been allocated yet.
-        let ptr = if cap == 0 {
-            core::ptr::null_mut()
-        } else {
-            old_ptr
-        };
-
-        // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
-        // `krealloc_aligned`. We also verified that the type is not a ZST.
-        let new_ptr = unsafe { super::allocator::krealloc_aligned(ptr.cast(), layout, flags) };
-        if new_ptr.is_null() {
-            // SAFETY: We are just rebuilding the existing `Vec` with no changes.
-            unsafe { rebuild(self, old_ptr, len, cap) };
-            Err(AllocError)
-        } else {
-            // SAFETY: `ptr` has been reallocated with the layout for `new_cap` elements. New cap
-            // is greater than `cap`, so it continues to be >= `len`.
-            unsafe { rebuild(self, new_ptr.cast::<T>(), len, new_cap) };
-            Ok(())
-        }
-    }
-}
-
-#[cfg(not(any(test, testlib)))]
-fn destructure<T>(v: &mut Vec<T>) -> (*mut T, usize, usize) {
-    let mut tmp = Vec::new();
-    core::mem::swap(&mut tmp, v);
-    let mut tmp = core::mem::ManuallyDrop::new(tmp);
-    let len = tmp.len();
-    let cap = tmp.capacity();
-    (tmp.as_mut_ptr(), len, cap)
-}
-
-/// Rebuilds a `Vec` from a pointer, length, and capacity.
-///
-/// # Safety
-///
-/// The same as [`Vec::from_raw_parts`].
-#[cfg(not(any(test, testlib)))]
-unsafe fn rebuild<T>(v: &mut Vec<T>, ptr: *mut T, len: usize, cap: usize) {
-    // SAFETY: The safety requirements from this function satisfy those of `from_raw_parts`.
-    let mut tmp = unsafe { Vec::from_raw_parts(ptr, len, cap) };
-    core::mem::swap(&mut tmp, v);
-}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 80223cdaa485..07daccf6ca8e 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,10 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, KVVec, KVec, VBox, VVec};
-
-#[doc(no_inline)]
-pub use alloc::vec::Vec;
+pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec};
 
 #[doc(no_inline)]
 pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
-- 
2.46.0


