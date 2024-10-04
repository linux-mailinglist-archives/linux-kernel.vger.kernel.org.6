Return-Path: <linux-kernel+bounces-350684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3F599080E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D09288982
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44472207EE;
	Fri,  4 Oct 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRSbsK68"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041072207E0;
	Fri,  4 Oct 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056618; cv=none; b=djcEiTjzhywTAtHK/MR8FTThOeUddDKasPCE5FryDhmudopbH48PEd5HajO7o6A/9qsQuQjMYEeYEgG0y1pfGRpoZL555o8DuN6tSxjfFwxk0172zj2oJGmnO0E2X/aEB4sGAawGj21grmSOr5ANtBlwOJ6kE9rluLH9KBN+Rd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056618; c=relaxed/simple;
	bh=2sSsIzdACzoPnqvUhervrAOknVeczgrx1816hyZSkw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qzs1SI92zu+SmqzwA0xwHvty6GNraYrBuz1BF1UH7CxE5PDR5iEgIlNegwXdNZRA7Jery84FvEl+leyIX8IVeM9OKfihBIOgAoKHNlG0s+nV/0jsiyXkz1sl0vfh4FFiJknp9ksaCr51y82Nnp4wNj2zopLQ4WbgBH8YxI4cAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRSbsK68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DECC4CEC6;
	Fri,  4 Oct 2024 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056617;
	bh=2sSsIzdACzoPnqvUhervrAOknVeczgrx1816hyZSkw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fRSbsK68TywYDweAzJmxnLHP52gywwuHTd3U0HBB6jz5L0XkmeuGK4tHtivRhzfHJ
	 jA/tut0+mI3ZgS9I32hAcnIeJrDvWZXp5isJ+RWfbfvPkN32+uBawoWrYL5nou+Blx
	 zdERRBRrfBllOMd5yv5grsEB8zrKexPjR5CqqIyHs7l2pwgJoe+dj7z+IHiIckZ4B7
	 3qmwiwXJ/Wztcs0M/fjlblqz/vkLqkD+leaiAjL8U625qPXa6hk8QJWo+9ZwzMPSuj
	 CGPuU/nWAZqCth6223YP+dYTee+RT/rQb7ZPVKcaijxzCLHRAkVEolLhArocmgLuTg
	 Fc9D2RN9mHdVA==
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
Subject: [PATCH v9 17/29] rust: alloc: implement `IntoIterator` for `Vec`
Date: Fri,  4 Oct 2024 17:41:21 +0200
Message-ID: <20241004154149.93856-18-dakr@kernel.org>
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

Implement `IntoIterator` for `Vec`, `Vec`'s `IntoIter` type, as well as
`Iterator` for `IntoIter`.

`Vec::into_iter` disassembles the `Vec` into its raw parts; additionally,
`IntoIter` keeps track of a separate pointer, which is incremented
correspondingsly as the iterator advances, while the length, or the count
of elements, is decremented.

This also means that `IntoIter` takes the ownership of the backing
buffer and is responsible to drop the remaining elements and free the
backing buffer, if it's dropped.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs      |   1 +
 rust/kernel/alloc/kvec.rs | 170 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 961070daf6db..1d57bfe2acb1 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -20,6 +20,7 @@
 pub use self::kbox::KVBox;
 pub use self::kbox::VBox;
 
+pub use self::kvec::IntoIter;
 pub use self::kvec::KVVec;
 pub use self::kvec::KVec;
 pub use self::kvec::VVec;
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index d41353b7653d..86382827f576 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -648,3 +648,173 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
     [A: Allocator, const N: usize] Vec<T, A>, [U; N],
     [A: Allocator, const N: usize] Vec<T, A>, &[U; N],
 }
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
+/// An [`Iterator`] implementation for [`Vec`] that moves elements out of a vector.
+///
+/// This structure is created by the [`Vec::into_iter`] method on [`Vec`] (provided by the
+/// [`IntoIterator`] trait).
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
+    layout: ArrayLayout<T>,
+    _p: PhantomData<A>,
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
+        let current = self.ptr;
+
+        // SAFETY: We can't overflow; decreasing `self.len` by one every time we advance `self.ptr`
+        // by one guarantees that.
+        unsafe { self.ptr = self.ptr.add(1) };
+
+        self.len -= 1;
+
+        // SAFETY: `current` is guaranteed to point at a valid element within the buffer.
+        Some(unsafe { current.read() })
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
+        // SAFETY: `self.ptr` is guaranteed to be valid by the type invariant.
+        unsafe { ptr::drop_in_place(ptr::slice_from_raw_parts_mut(self.ptr, self.len)) };
+
+        // SAFETY:
+        // - `self.buf` was previously allocated with `A`.
+        // - `self.layout` matches the `ArrayLayout` of the preceeding allocation.
+        unsafe { A::free(self.buf.cast(), self.layout.into()) };
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
+    /// Consumes the `Vec<T, A>` and creates an `Iterator`, which moves each value out of the
+    /// vector (from start to end).
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
+        let buf = self.ptr;
+        let layout = self.layout;
+        let (ptr, len, _) = self.into_raw_parts();
+
+        IntoIter {
+            ptr,
+            buf,
+            len,
+            layout,
+            _p: PhantomData::<A>,
+        }
+    }
+}
-- 
2.46.1


