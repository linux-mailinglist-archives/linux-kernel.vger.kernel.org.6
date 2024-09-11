Return-Path: <linux-kernel+bounces-325720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF7975D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7F91C21BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE8C1BE865;
	Wed, 11 Sep 2024 22:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRpiFgQp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA641BCA0A;
	Wed, 11 Sep 2024 22:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095375; cv=none; b=FA9A9v5bpZWxo7ZRlgmHDOnYQfpLQ/hMBTuHVexDD30Eii/74RDvzZHYfcI34AXy9S/3I9YrALqZPErkupt4Y2b/FNlwiLKOiPHJfX/SI1HVYyhQsOeW5I6c8MwV3OoU69C6lbGzxmEDYfq6AdaNatvMVeeA8lyInc9jFJnx0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095375; c=relaxed/simple;
	bh=aLDdES0o6RDAOJEjGLFT1eKKbvsH9kq1wWFmHyySuYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLySTBhyVBLISxGEyHnnn3CsEXQsH42wmAss19HiRuhWrqjJl+yLcPxd7YIQAvJVHdZLAmqg4LROCmmJRgtu+y2KjxqERFJ3shva98HhSry/AeSDBrTxySRVZ90kydTLAJfqvm0+FMgawKtmIeyMLqyTtFngm0lOVKuX+YQXXPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRpiFgQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB19C4CECC;
	Wed, 11 Sep 2024 22:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095375;
	bh=aLDdES0o6RDAOJEjGLFT1eKKbvsH9kq1wWFmHyySuYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRpiFgQp9WwC2xCKc1aDcSeNN12nD+GShRbakKlDuGMWhi3GjwI+uXBKLL1jQIdbm
	 QE2NbWO/lOI8KRM7Svf2gz/Z9mvaNRDH8/eEyVNvsinjSYS4k3cA2ac8ABB8Tnimfw
	 w3XYcJeORuRs+NrHWD3UBYZhdYf7VAVg53hUr9bv1R82NYriI8OPKmq5gQfTpzEceL
	 iVdQ85KiWl+VZHVWaMll71MQ32Zlv+nn1Khu6+jrIAURDNl/RDzgtlk3vzubC/Njk7
	 m4fr+jhaMvgefyfbBM/wKub+78OgiSGAEwLdN4jf6pM9TQPMbINCd0VluGuv6xQYZK
	 MKwer9LnsErWA==
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
Subject: [PATCH v7 14/26] rust: alloc: implement `IntoIterator` for `Vec`
Date: Thu, 12 Sep 2024 00:52:50 +0200
Message-ID: <20240911225449.152928-15-dakr@kernel.org>
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
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs      |   1 +
 rust/kernel/alloc/kvec.rs | 181 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 4fb983b63d46..e8fbae2adadb 100644
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
index 631a44e19f35..e91761c5c52d 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -14,6 +14,7 @@
     ops::DerefMut,
     ops::Index,
     ops::IndexMut,
+    ptr,
     ptr::NonNull,
     slice,
     slice::SliceIndex,
@@ -636,3 +637,183 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
 impl_slice_eq! { [A: Allocator] [T], Vec<U, A> }
 impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, [U; N] }
 impl_slice_eq! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N] }
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
+        // SAFETY: The pointer in `self.0` is guaranteed to be valid by the type invariant.
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
2.46.0


