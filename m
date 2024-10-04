Return-Path: <linux-kernel+bounces-350685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A599080F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E182E1C209EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA722080B;
	Fri,  4 Oct 2024 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHqXPqqt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3A1E2822;
	Fri,  4 Oct 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056623; cv=none; b=cyZ2th8jEKsIHO0hmwCFZxFmGnQLsAuRs4K0y01zfWj9mDFLkmX+laS1eq/mI4f+/xuZdXdjwZyMQonrqbkWyBfp3zE7kUi5hTtkFv9L6VWVuPFjd7RYxf6i+vcwXjTxksf1O+huy+ZOJQ2bTG3c1h1iYcyMeDr8dS3yBGcs2kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056623; c=relaxed/simple;
	bh=AaRhWJzhXeNmb7koJrUIhcIZp+NJ7YnTtkDq/65dn0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ro18ycqsCb7TDc8qfUzhrapxfp6a6DyZt6dsiHKcGK8nQNJNGVX86B7Ez153aJ4bOQgDsgN9BKLdrKFOmXqz4eRBGWXLBXdwuzbD3ZN9EMUuEI1H6GkV/8ZIK+Kmh+arBvOIiNP/Vm7QhWXgHAia/0P6JeRyzlKiyOAECD4+8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHqXPqqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56752C4CECE;
	Fri,  4 Oct 2024 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056623;
	bh=AaRhWJzhXeNmb7koJrUIhcIZp+NJ7YnTtkDq/65dn0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHqXPqqtK505FnU3TTT6/Ji6dpr2PBjGmIlIN7KTNr7b/n8nmzyALSiHSoiLUQoNb
	 KtUvqcut7lfST4w7g9rLwKr9uH386s/XGHuPMY2lMezaoM/i4dPAolBGABBTcYq/hk
	 uDdhPGfUf8SR858gmtd9UZlfuO3ndAZchUHfRPwFdZwQk5LoRnsBB1xcrrGre3MkD8
	 gaYPhS97lcGwbRYMOC6v+jXUJ5WydyEO/G0w69lm2Xx9WcRshRlUVHLnRS8moapyaA
	 YnuBVVZiJT+mwr1eLbJM/5tuGkT/xjhcDrKa38LRZxLVzsEouk1asvDeB6WXKelqZ2
	 brqZEsq6FxgXw==
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
Subject: [PATCH v9 18/29] rust: alloc: implement `collect` for `IntoIter`
Date: Fri,  4 Oct 2024 17:41:22 +0200
Message-ID: <20241004154149.93856-19-dakr@kernel.org>
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/kvec.rs | 94 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 86382827f576..119b5a4dbf77 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -694,6 +694,100 @@ pub struct IntoIter<T, A: Allocator> {
     _p: PhantomData<A>,
 }
 
+impl<T, A> IntoIter<T, A>
+where
+    A: Allocator,
+{
+    fn into_raw_parts(self) -> (*mut T, NonNull<T>, usize, usize) {
+        let me = ManuallyDrop::new(self);
+        let ptr = me.ptr;
+        let buf = me.buf;
+        let len = me.len;
+        let cap = me.layout.len();
+        (ptr, buf, len, cap)
+    }
+
+    /// Same as `Iterator::collect` but specialized for `Vec`'s `IntoIter`.
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
+    /// # Implementation Details
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
+    pub fn collect(self, flags: Flags) -> Vec<T, A> {
+        let old_layout = self.layout;
+        let (mut ptr, buf, len, mut cap) = self.into_raw_parts();
+        let has_advanced = ptr != buf.as_ptr();
+
+        if has_advanced {
+            // Copy the contents we have advanced to at the beginning of the buffer.
+            //
+            // SAFETY:
+            // - `ptr` is valid for reads of `len * size_of::<T>()` bytes,
+            // - `buf.as_ptr()` is valid for writes of `len * size_of::<T>()` bytes,
+            // - `ptr` and `buf.as_ptr()` are not be subject to aliasing restrictions relative to
+            //   each other,
+            // - both `ptr` and `buf.ptr()` are properly aligned.
+            unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
+            ptr = buf.as_ptr();
+
+            // SAFETY: `len` is guaranteed to be smaller than `self.layout.len()`.
+            let layout = unsafe { ArrayLayout::<T>::new_unchecked(len) };
+
+            // SAFETY: `buf` points to the start of the backing buffer and `len` is guaranteed to be
+            // smaller than `cap`. Depending on `alloc` this operation may shrink the buffer or leaves
+            // it as it is.
+            ptr = match unsafe {
+                A::realloc(Some(buf.cast()), layout.into(), old_layout.into(), flags)
+            } {
+                // If we fail to shrink, which likely can't even happen, continue with the existing
+                // buffer.
+                Err(_) => ptr,
+                Ok(ptr) => {
+                    cap = len;
+                    ptr.as_ptr().cast()
+                }
+            };
+        }
+
+        // SAFETY: If the iterator has been advanced, the advanced elements have been copied to
+        // the beginning of the buffer and `len` has been adjusted accordingly.
+        //
+        // - `ptr` is guaranteed to point to the start of the backing buffer.
+        // - `cap` is either the original capacity or, after shrinking the buffer, equal to `len`.
+        // - `alloc` is guaranteed to be unchanged since `into_iter` has been called on the original
+        //   `Vec`.
+        unsafe { Vec::from_raw_parts(ptr, len, cap) }
+    }
+}
+
 impl<T, A> Iterator for IntoIter<T, A>
 where
     A: Allocator,
-- 
2.46.1


