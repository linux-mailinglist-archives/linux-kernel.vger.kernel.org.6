Return-Path: <linux-kernel+bounces-346194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F184A98C10B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABFC1F2369A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86FD1CCEF8;
	Tue,  1 Oct 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+4rDUfw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F91CCEED;
	Tue,  1 Oct 2024 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794909; cv=none; b=f2zTrI5jTSJlsaQkCfW2cXeYb3OcTIGnQwTquIG277D6viSKBfa+MfJBvqIzoX1y/Fmj4si/woL3LIoGKHybXgAqDfvUEn2rvbCpnjR6u2qASH+ZmEUCWMPnGYcKj0EKLeBvIlbmHrdlKyl2+3/+cD6II8gnckkGCvFLTHEAgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794909; c=relaxed/simple;
	bh=WU3ilb+F7s6b0hCQthPkZjMBffv2TQREL2Wt+coFn1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovK9UMODq1IJnJqo2AoS54vsBNOBNpAFVrDQDz0I/XvjUQ3vAbc94nvfDW04EhZabs7ItcQLtEVM5LTKN3AIkp+XSe4nlQpklW5A749AQfLypX5daGe82un36iHFRrVTTdN2JBmi9OUc09Q8YTkxFU3mjuxSoD5QWWgMTRY3MbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+4rDUfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD97FC4CED2;
	Tue,  1 Oct 2024 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794908;
	bh=WU3ilb+F7s6b0hCQthPkZjMBffv2TQREL2Wt+coFn1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+4rDUfwl31k9vhU3jqNUMnH4fBOcloRkW7bgFCmZteeG1L7uc8Onk3lICt6F2g7+
	 LPnLqF6Gnx6shQhayZZV8xFbO7RbPBVcfB3Zc3aigG0yeGTs8z6WVJ0zLwzlAfpX7Z
	 UUDGoOQY6GGxPO8RzrxBJsyacERIK386bw4pVODb33U0ExScCmvhFzNC1OE6fhfuji
	 j3RB4zmU7ne40f5en49QARsqgPATsXh0dlniG0PKwZoOk4iRITv2V2nUPmbue2Zkz9
	 AC4RjZtjgb0zVt7med1hZfU9dG5GUDo675PpSipEdmGHY37AjT0DYIryY7p2QuOvTC
	 YcmG6MBUkUUKg==
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
Subject: [PATCH v8 17/29] rust: alloc: implement `IntoIterator` for `Vec`
Date: Tue,  1 Oct 2024 16:59:52 +0200
Message-ID: <20241001150008.183102-18-dakr@kernel.org>
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
index 44aade0a653b..ff1c152d3423 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -635,3 +635,173 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
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


