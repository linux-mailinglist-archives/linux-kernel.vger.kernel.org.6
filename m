Return-Path: <linux-kernel+bounces-283599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8C94F6AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B341F2118A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD37199392;
	Mon, 12 Aug 2024 18:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzWbtvOL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BE199253;
	Mon, 12 Aug 2024 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487124; cv=none; b=J4rsfIczHC8OhQXBTwgaeF6n112LLtQkfgWnv5GeZAWKJPJ5fddlBgDbi4hxhz9ayPRT3MCvJ8PUZtgzLnAd+WLrpjnS1qWUJZOP+0GY9fv34VXAbj4O69hzVNMUmXssWNqvwQLdPlDBkNw6xrqMonqDQDVs7ZszuXFz/ZZM8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487124; c=relaxed/simple;
	bh=0DSeKEWLXJuqwaFBkmO+F7vBvNPyAyPpY0O8t3RwT4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIQoCege+pbTAY6EsrV/QkkHljNwLaevmDSVcjbji6MqMNOmOeZ1DB5DA1h9phqJOu9fs3dQa9h6biK1nBPqq4UgV97cwI6eIFSU7U9NO/qGvyewILyQCiqfIWNEFefEq/6dMGOItrslWCU4zN2jBUia/k2PNZTbKF3VafmOT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzWbtvOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7CDC4AF0D;
	Mon, 12 Aug 2024 18:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487124;
	bh=0DSeKEWLXJuqwaFBkmO+F7vBvNPyAyPpY0O8t3RwT4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzWbtvOLiWrMOUXG/qelU1xQ8qo72M+ErF8g+N9WKMUpaKdzkCMw3Pcp+65+lpkdg
	 nHiF7XNu6z9JZ7HHR/o8Vwh3Ksbdz8jmxdZCPUvGSNMrW1AYnlbSBk4UQcg1zrWj5W
	 jzqXjT9F51KHwg0Q7rYyPT02u0/Bkz1egaE5BYR8x7klRCsoyEwqcO3LUoLOEI4SYK
	 KPnLvbJmMYz9zUV/mgmU287ki/YZ4UTEkuslHHNnKpO6E/eui1r52+B0Z1OVddG5e1
	 BCr2KdFXi2WiN4UW7x2CBq700z3FF5Nhj6dprjns6t66FeWibt+ir93XSqxqRKfZJy
	 2fSASsmLBWMNQ==
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
Subject: [PATCH v5 14/26] rust: alloc: implement `IntoIterator` for `Vec`
Date: Mon, 12 Aug 2024 20:23:00 +0200
Message-ID: <20240812182355.11641-15-dakr@kernel.org>
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
 rust/kernel/alloc/kvec.rs | 184 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 185 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 4d7190594076..4035644b5dca 100644
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
index 351c4f1702db..cc8f3c555d1e 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -11,6 +11,7 @@
     ops::DerefMut,
     ops::Index,
     ops::IndexMut,
+    ptr,
     ptr::NonNull,
     slice,
     slice::SliceIndex,
@@ -611,3 +612,186 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
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
+/// An `Iterator` implementation for `Vec<T,A>` that moves elements out of a vector.
+///
+/// This structure is created by the `Vec::into_iter` method on [`Vec`] (provided by the
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
2.45.2


