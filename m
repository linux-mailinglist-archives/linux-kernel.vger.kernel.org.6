Return-Path: <linux-kernel+bounces-260288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD58693A562
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05FC1C2223B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048A515B995;
	Tue, 23 Jul 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASoYC5Ro"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A515B972;
	Tue, 23 Jul 2024 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758338; cv=none; b=pJ9/jvb5w/lIz1csLm8zz2u6WtaykGa8GrA1tsN7cUOTQrjUmZrYf5ylXlere3yIZili4Cf+tKDcAy2cUCIJitLSJ2kCzHl9H1t+vZWF+9cNNGPDZDbXpeK4aaUGCTJojVN0REMyc67eFUxdFgH4hzRtapH15GRZF3ZA+Oj5N8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758338; c=relaxed/simple;
	bh=c3QAEBZXl3M1WsOmfNh19vNXUNzyZvBix2UsBjiGOtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJkUM7Dnl5P5wgf+pTGC44ASK2D69rGeOHcLjnRa61hAQZUKZGSr4yedRGdhdoDfe0EguTNla5l7NMQhifEVxdftE4hWxuYXdN1S8RLYXAbXJ5Xft775+1eWVgWDCTyvkoX02ccG8r0qUiYA8fYYiB7LsF+zPF5mS5icjt7XfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASoYC5Ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70FCC4AF0A;
	Tue, 23 Jul 2024 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758337;
	bh=c3QAEBZXl3M1WsOmfNh19vNXUNzyZvBix2UsBjiGOtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASoYC5RoyFxVt1qORsF7cKfWeydOo+meew08vpzJjAAxJiB8eIifrdSo9n0K9QN88
	 IoR3tEeo+y4EqksYwvQz/OPsRDe2OKxBfrdZqgY2g15Rto6/wMtHsHnQVuqZjxJpE3
	 KH20JQVp77kvTCJtWlrgxNSVDtLNhAbGePPbfNAXZ4ymEhnejSzwc4/FbCVWCKCSTX
	 AyFoOjfoq4hoZtQf4lMM7MoYvUN5hxC3Y8SPnyYCC9yZKsJw+pp5CvjJf9r7+H5ps6
	 7JHpY+kwXX6Fo9b6XB4J/ZSkQoczgRAQ1O1ijBoprzvvG0tXCxOlUxbM6IfGA8tU2n
	 W4T0bgS7ldmbQ==
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
Subject: [PATCH v2 15/23] rust: alloc: implement `IntoIterator` for `Vec`
Date: Tue, 23 Jul 2024 20:10:04 +0200
Message-ID: <20240723181024.21168-16-dakr@kernel.org>
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
 rust/kernel/alloc/kvec.rs | 175 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 827922e1f1d1..19e0ad0bf98b 100644
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
index 58b3f679ad83..fbfb755b252d 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -12,7 +12,9 @@
     ops::DerefMut,
     ops::Index,
     ops::IndexMut,
-    ptr, slice,
+    ptr,
+    ptr::NonNull,
+    slice,
     slice::SliceIndex,
 };
 
@@ -578,3 +580,174 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
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
+    #[inline]
+    fn into_iter(self) -> Self::IntoIter {
+        let (ptr, len, cap) = self.into_raw_parts();
+
+        IntoIter {
+            ptr,
+            buf: unsafe { NonNull::new_unchecked(ptr) },
+            len,
+            cap,
+            _p: PhantomData::<A>,
+        }
+    }
+}
-- 
2.45.2


