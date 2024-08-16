Return-Path: <linux-kernel+bounces-288750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A05953E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8563F1C21651
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E46F077;
	Fri, 16 Aug 2024 00:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN169jcj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373C51AC8A6;
	Fri, 16 Aug 2024 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767225; cv=none; b=CrrSkvzil9whnAA6/zjl5jTupNltcNhG8uPlXsAynHsEqqxUvCTUwlVN8d0AznKJoodBKvyaU+SrF+fwa49xgjt2d9ey8jCioYk0s3jxh6ldDZQ/huVXU8EXL1JwlXRYA2/EQcUw1N2qKbCZpuksOqPw6DwL3NOw5BLjUBcyHyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767225; c=relaxed/simple;
	bh=I6cUolcDKGiOxN2jlE3/L4Zfc5m68bEHs0e/qmkx1fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddZKTcDYZ8y24IZCjM1f47m0VE40hokIy4JnTQHemD30incO4R09pthFfRiZD/PAe2z8qOfNL6Re92SRtMbPWgl37OKVfuPepE/icOaKhYOXaLAn3SlxDf/b/prXJQ3OB8/wLSbNEXoFkXEjjBaqAX7hFq6OTQ+pVPpD5aPJC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN169jcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C35C4AF09;
	Fri, 16 Aug 2024 00:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767224;
	bh=I6cUolcDKGiOxN2jlE3/L4Zfc5m68bEHs0e/qmkx1fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YN169jcjN81Cmi6OKpdlT7HPyJDRt6/wiY2aKNkcvQL4eo/KLCVl8/ZBlAuASgG7W
	 5igkBN3w9Dr1JcrgOrglgcb7FhUOPrn6KPAkgLoMT8Mf+m6qWrvzEkdxOfRrsg5x6D
	 HlpqJH2geyzU4Rb7k4tkg8op+ExRtO4eqi8Yh9DXUs+RGy9kVnGHqUq5N0m8t67CkK
	 YAPnH/iKSYdpk59cNGm5lAZR2tSRqRL7PEaReigmEtyCOuvmiwHE30XEgEebteZkII
	 1GZXiOyJNWR0VwcgYig+oFSYY6nYQjsRvnXw7d4Kn4Bwv11UFuTLqooJbqLsK61760
	 3ymAtnrv26/0g==
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
Subject: [PATCH v6 15/26] rust: alloc: implement `collect` for `IntoIter`
Date: Fri, 16 Aug 2024 02:10:57 +0200
Message-ID: <20240816001216.26575-16-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816001216.26575-1-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we can't implement `FromIterator`. There are a couple of
issues with this trait in the kernel, namely:

  - Rust's specialization feature is unstable. This prevents us to
    optimze for the special case where `I::IntoIter` equals `Vec`'s
    `IntoIter` type.
  - We also can't use `I::IntoIter`'s type ID either to work around this,
    since `FromIterator` doesn't require this type to be `'static`.
  - `FromIterator::from_iter` does return `Self` instead of
    `Result<Self, AllocError>`, hence we can't properly handle allocation
    failures.
  - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle
    additional allocation flags.

Instead, provide `IntoIter::collect`, such that we can at least convert
`IntoIter` into a `Vec` again.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/kvec.rs | 78 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 3b79f977b65e..ad96f4c3af9e 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -681,6 +681,84 @@ impl<T, A> IntoIter<T, A>
     fn as_raw_mut_slice(&mut self) -> *mut [T] {
         ptr::slice_from_raw_parts_mut(self.ptr, self.len)
     }
+
+    fn into_raw_parts(self) -> (*mut T, NonNull<T>, usize, usize) {
+        let me = ManuallyDrop::new(self);
+        let ptr = me.ptr;
+        let buf = me.buf;
+        let len = me.len;
+        let cap = me.cap;
+        (ptr, buf, len, cap)
+    }
+
+    /// Same as `Iterator::collect` but specialized for `Vec`'s `IntoIter`.
+    ///
+    /// Currently, we can't implement `FromIterator`. There are a couple of issues with this trait
+    /// in the kernel, namely:
+    ///
+    /// - Rust's specialization feature is unstable. This prevents us to optimze for the special
+    ///   case where `I::IntoIter` equals `Vec`'s `IntoIter` type.
+    /// - We also can't use `I::IntoIter`'s type ID either to work around this, since `FromIterator`
+    ///   doesn't require this type to be `'static`.
+    /// - `FromIterator::from_iter` does return `Self` instead of `Result<Self, AllocError>`, hence
+    ///   we can't properly handle allocation failures.
+    /// - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle additional allocation
+    ///   flags.
+    ///
+    /// Instead, provide `IntoIter::collect`, such that we can at least convert a `IntoIter` into a
+    /// `Vec` again.
+    ///
+    /// Note that `IntoIter::collect` doesn't require `Flags`, since it re-uses the existing backing
+    /// buffer. However, this backing buffer may be shrunk to the actual count of elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = kernel::kvec![1, 2, 3]?;
+    /// let mut it = v.into_iter();
+    ///
+    /// assert_eq!(it.next(), Some(1));
+    ///
+    /// let v = it.collect(GFP_KERNEL);
+    /// assert_eq!(v, [2, 3]);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn collect(self, flags: Flags) -> Vec<T, A> {
+        let (mut ptr, buf, len, mut cap) = self.into_raw_parts();
+        let has_advanced = ptr != buf.as_ptr();
+
+        if has_advanced {
+            // SAFETY: Copy the contents we have advanced to at the beginning of the buffer.
+            // `ptr` is guaranteed to be between `buf` and `buf.add(cap)` and `ptr.add(len)` is
+            // guaranteed to be smaller than `buf.add(cap)`.
+            unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
+            ptr = buf.as_ptr();
+        }
+
+        // This can never fail, `len` is guaranteed to be smaller than `cap`.
+        let layout = core::alloc::Layout::array::<T>(len).unwrap();
+
+        // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
+        // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
+        // it as it is.
+        ptr = match unsafe { A::realloc(Some(buf.cast()), layout, flags) } {
+            // If we fail to shrink, which likely can't even happen, continue with the existing
+            // buffer.
+            Err(_) => ptr,
+            Ok(ptr) => {
+                cap = len;
+                ptr.as_ptr().cast()
+            }
+        };
+
+        // SAFETY: If the iterator has been advanced, the advanced elements have been copied to
+        // the beginning of the buffer and `len` has been adjusted accordingly. `ptr` is guaranteed
+        // to point to the start of the backing buffer. `cap` is either the original capacity or,
+        // after shrinking the buffer, equal to `len`. `alloc` is guaranteed to be unchanged since
+        // `into_iter` has been called on the original `Vec`.
+        unsafe { Vec::from_raw_parts(ptr, len, cap) }
+    }
 }
 
 impl<T, A> Iterator for IntoIter<T, A>
-- 
2.46.0


