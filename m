Return-Path: <linux-kernel+bounces-274887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B6947DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC531C21EC6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCA415C14D;
	Mon,  5 Aug 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID+VTQPg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DF15C131;
	Mon,  5 Aug 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871308; cv=none; b=orAI72nRLiEXfFttbAGos/RD38C0sN/U9naGVjDNiVzqlQDr7QHC1OY4aXqNkx3AUCM+7QNplbja6pHhpPOPs9C/RgVaqAg4jKf9A1MTA63iyuUYHMTFZ2CVjy8YjqaTWRI9aCFGDlG7QfMDXRoKrgcbBpVrNugPnetDIdxffNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871308; c=relaxed/simple;
	bh=XOcjCrkdVgWqenxc2S4POpPouyHf3iALRM/oI15aNRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXZjqv8NHAv0Igw4sIYqWkj9t7ZHSIefqFTGuzZqk+3DdHuoFhLB6Y1cyzjyg65I3fYHMcFtGqvG51BTmuTD69jlmuhRUxIICGMJbmk9lUe2FlRbRniXudM/fl/NcfBNO5QwOCDBMezi3/gmvjH9S3NgX4rULL+mc9Xjcj6OtLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID+VTQPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1739C32782;
	Mon,  5 Aug 2024 15:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871308;
	bh=XOcjCrkdVgWqenxc2S4POpPouyHf3iALRM/oI15aNRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ID+VTQPgxM4/fo/86PhXM8wRLmUNRAGD0AtIR9PtyYSxsVsHuIDvWngmOC+r+/vdl
	 cIN5C0KpCslxLORbqND66Zfvihy6aQlgFRHQSOk+wpPpD6no4Yud3FS3rT5/CDIs+Q
	 BXWO+4zgoIp3+nxfgwueV/3Up8duKjAUksUMzqgF9+qdt+ovvcXwaop8+MVbGixguk
	 J37SZmf69xbVFHxg4sKet5BDZPN8wgDPz2zaed4SF2pBsXmPcOIYsKi3/lRW5i0dhD
	 GYikD+tDejphoiiin0o0ZiQI8f3sVZyMcYBKWRWvI1mrEHnXAvU4qMpi8FZ/YZw/ab
	 ZS9nCCDnFf1ig==
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
Subject: [PATCH v4 17/28] rust: alloc: implement `collect` for `IntoIter`
Date: Mon,  5 Aug 2024 17:19:36 +0200
Message-ID: <20240805152004.5039-18-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805152004.5039-1-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
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
index 51426e0b28e0..160c6b3868fe 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -644,6 +644,84 @@ impl<T, A> IntoIter<T, A>
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
2.45.2


