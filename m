Return-Path: <linux-kernel+bounces-270023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2481D943A2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE89528189B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91714286;
	Thu,  1 Aug 2024 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb5hc0kR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29213D510;
	Thu,  1 Aug 2024 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470900; cv=none; b=iGdvcmh6REdV8D/V5am30SmF8jM6p5Ohp1EOnJpEHY7VoeMUFdPwJd18VvelefBLkare7C0JHdgErgKapPXxpJW1WOB8LilcUeTV7dbgN5js0Pn/1YGCv7jYWJlST4bgWxQxsdvf4NIwY/kqNiTA3BMk/JW5aiQe7dB9lBXWLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470900; c=relaxed/simple;
	bh=jAbO/ocd+GDx9TX4LOAzMK63XGdOeFxsvuJ3d1oWSfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWChVQxXlxY4LBTVgFopCMfeslA20OEQ2XAA1+8bf/694A14IrDFyEUnMouUEodwSrwpwP8NhvTA0qqNy4mOj8L492wcGm/7wOT/lxxqM66JH3uierf67qskgrp+SuV5Y4xnhitfQkRA6CkUodnbetQWBACl5+GhGL/VlrWQhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb5hc0kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53364C4AF0E;
	Thu,  1 Aug 2024 00:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470900;
	bh=jAbO/ocd+GDx9TX4LOAzMK63XGdOeFxsvuJ3d1oWSfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fb5hc0kRBB53GlmIo7ISRm3ZFGGf2BIUq4w2KkggQ93QJruFcu0+zWcZlEknwxFpd
	 7gU/6/qKYBi/+KJFxQl6YAej/rg52M/yx/fWUky0taAaqdMr34zqTnsvl72EbQWQaJ
	 kg5d4W2Wjmp7ma17noKc0jvUUAcZGMCuKVBJI6vUPkr5Q9Ru26Utz+J8oLPYFeiLEC
	 lVatKFDoPzsDrZmWVb1qHzOwemrWt4xemw9F4jjjrhCx0T2b1t3soGoiJzZi5ICeow
	 hjJEPfZm8AkPv+DJsF/UXNOHw15IrZ9XHdysw8ds+T11sWKcwO9vR8oBJydXpTTi1A
	 d5IxqmDYCrh+w==
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
Subject: [PATCH v3 16/25] rust: alloc: implement `IntoIterator` for `Vec`
Date: Thu,  1 Aug 2024 02:02:15 +0200
Message-ID: <20240801000641.1882-17-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801000641.1882-1-dakr@kernel.org>
References: <20240801000641.1882-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement `IntoIterator` for `Vec`, `Vec`'s `IntoIter` type, as well as
`Iterator` for `IntoIter`.

`Vec::into_iter` disassembles the `Vec` into its raw parts; additionally,
`IntoIter` keeps track of a separate pointer, which is incremented
correspondingsly as the iterator advances, while the length, or the count
of elements, is decremented.

This also means that `IntoIter` takes the ownership of the backing
buffer and is responsible to drop the remaining elements and free the
backing buffer, if it's dropped.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs      |   1 +
 rust/kernel/alloc/kvec.rs | 186 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index bd93140f3094..f2998ad57456 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -19,6 +19,7 @@
 pub use self::kbox::KVBox;
 pub use self::kbox::VBox;
 
+pub use self::kvec::IntoIter;
 pub use self::kvec::KVVec;
 pub use self::kvec::KVec;
 pub use self::kvec::VVec;
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 04cc85f7d92c..50e7705e5686 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -12,6 +12,8 @@
     ops::DerefMut,
     ops::Index,
     ops::IndexMut,
+    ptr,
+    ptr::NonNull,
     slice,
     slice::SliceIndex,
 };
@@ -581,3 +583,187 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
 __impl_slice_eq! { [A: Allocator] [T], Vec<U, A> }
 __impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, [U; N] }
 __impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N] }
+
+impl<'a, T, A> IntoIterator for &'a Vec<T, A>
+where
+    A: Allocator,
+{
+    type Item = &'a T;
+    type IntoIter = slice::Iter<'a, T>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+impl<'a, T, A: Allocator> IntoIterator for &'a mut Vec<T, A>
+where
+    A: Allocator,
+{
+    type Item = &'a mut T;
+    type IntoIter = slice::IterMut<'a, T>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+/// An iterator that moves out of a vector.
+///
+/// This `struct` is created by the `into_iter` method on [`Vec`] (provided by the [`IntoIterator`]
+/// trait).
+///
+/// # Examples
+///
+/// ```
+/// let v = kernel::kvec![0, 1, 2]?;
+/// let iter = v.into_iter();
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub struct IntoIter<T, A: Allocator> {
+    ptr: *mut T,
+    buf: NonNull<T>,
+    len: usize,
+    cap: usize,
+    _p: PhantomData<A>,
+}
+
+impl<T, A> IntoIter<T, A>
+where
+    A: Allocator,
+{
+    fn as_raw_mut_slice(&mut self) -> *mut [T] {
+        ptr::slice_from_raw_parts_mut(self.ptr, self.len)
+    }
+}
+
+impl<T, A> Iterator for IntoIter<T, A>
+where
+    A: Allocator,
+{
+    type Item = T;
+
+    /// # Examples
+    ///
+    /// ```
+    /// let v = kernel::kvec![1, 2, 3]?;
+    /// let mut it = v.into_iter();
+    ///
+    /// assert_eq!(it.next(), Some(1));
+    /// assert_eq!(it.next(), Some(2));
+    /// assert_eq!(it.next(), Some(3));
+    /// assert_eq!(it.next(), None);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    fn next(&mut self) -> Option<T> {
+        if self.len == 0 {
+            return None;
+        }
+
+        let ptr = self.ptr;
+        if !Vec::<T, A>::is_zst() {
+            // SAFETY: We can't overflow; `end` is guaranteed to mark the end of the buffer.
+            unsafe { self.ptr = self.ptr.add(1) };
+        } else {
+            // For ZST `ptr` has to stay where it is to remain aligned, so we just reduce `self.len`
+            // by 1.
+        }
+        self.len -= 1;
+
+        // SAFETY: `ptr` is guaranteed to point at a valid element within the buffer.
+        Some(unsafe { ptr.read() })
+    }
+
+    /// # Examples
+    ///
+    /// ```
+    /// let v: KVec<u32> = kernel::kvec![1, 2, 3]?;
+    /// let mut iter = v.into_iter();
+    /// let size = iter.size_hint().0;
+    ///
+    /// iter.next();
+    /// assert_eq!(iter.size_hint().0, size - 1);
+    ///
+    /// iter.next();
+    /// assert_eq!(iter.size_hint().0, size - 2);
+    ///
+    /// iter.next();
+    /// assert_eq!(iter.size_hint().0, size - 3);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        (self.len, Some(self.len))
+    }
+}
+
+impl<T, A> Drop for IntoIter<T, A>
+where
+    A: Allocator,
+{
+    fn drop(&mut self) {
+        // SAFETY: Drop the remaining vector's elements in place, before we free the backing
+        // memory.
+        unsafe { ptr::drop_in_place(self.as_raw_mut_slice()) };
+
+        // If `cap == 0` we never allocated any memory in the first place.
+        if self.cap != 0 {
+            // SAFETY: `self.buf` was previously allocated with `A`.
+            unsafe { A::free(self.buf.cast()) };
+        }
+    }
+}
+
+impl<T, A> IntoIterator for Vec<T, A>
+where
+    A: Allocator,
+{
+    type Item = T;
+    type IntoIter = IntoIter<T, A>;
+
+    /// Creates a consuming iterator, that is, one that moves each value out of
+    /// the vector (from start to end). The vector cannot be used after calling
+    /// this.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = kernel::kvec![1, 2]?;
+    /// let mut v_iter = v.into_iter();
+    ///
+    /// let first_element: Option<u32> = v_iter.next();
+    ///
+    /// assert_eq!(first_element, Some(1));
+    /// assert_eq!(v_iter.next(), Some(2));
+    /// assert_eq!(v_iter.next(), None);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    ///
+    /// ```
+    /// let v = kernel::kvec![];
+    /// let mut v_iter = v.into_iter();
+    ///
+    /// let first_element: Option<u32> = v_iter.next();
+    ///
+    /// assert_eq!(first_element, None);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    #[inline]
+    fn into_iter(self) -> Self::IntoIter {
+        let (ptr, len, cap) = self.into_raw_parts();
+
+        IntoIter {
+            ptr,
+            // SAFETY: `ptr` is either a dangling pointer or a pointer to a valid memory
+            // allocation, allocated with `A`.
+            buf: unsafe { NonNull::new_unchecked(ptr) },
+            len,
+            cap,
+            _p: PhantomData::<A>,
+        }
+    }
+}
-- 
2.45.2


