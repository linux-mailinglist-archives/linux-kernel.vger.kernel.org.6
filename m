Return-Path: <linux-kernel+bounces-241473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F56927BB1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7FE1F27AFF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BE91C8FB7;
	Thu,  4 Jul 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsTd4oqT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C01B47DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112957; cv=none; b=Y+dBjqIlVN1bEY5/sSDSJG3iBHKCn9mu8ktktA5HQ5nTxL2hzGvhhrouaGggbB8QezSeYsIszJ3t5krQQRnKXdsDjvAOoHO14pa4QXSHK7o2TcbXrVlKAEmqEDcmcRMYVHvNQ7QzGV+O9eRjn3/gQUUjR/kT+jl/DPjmTQviYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112957; c=relaxed/simple;
	bh=CPyHMERj1twQjcjGyBr1Olj39ha/kHj+F1ifWXerf6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbgxAu+l1nsdC7hX51AtwQ+i8RjcGgJko/3PlM3822YN2rSqYYM49wKgYMXcm53ZLlmojlvlGujgMrEjgZ77yGkvstjLcja1Y7WwdenUwZiQE5Yvh2xoU5faBRUl93aHQnpwirNAdhWm6JToOM4ahKEfn9m4vImp59NWbq44nO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsTd4oqT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fpg1faBr5ekWLp/A+ticofxlpAUVrowaMF9N+c1VH5Y=;
	b=YsTd4oqTOnYC9SqdO7d7/E75/fRsIAcA2CLlUl204rEki/9syQdRMjtru6+YSCf7sS1Txg
	v+Su+VwZtgIE0V+s+mT0pKSi5Fk9qDPcxp2jftcFvJ0OeVFCx1yWBUtgTTVTZYQnGcvvaA
	3vempKubMlCLI/d+A1FkuEUATxRqv58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-QlrzO6nRMFegnWNM5i7t6Q-1; Thu, 04 Jul 2024 13:09:11 -0400
X-MC-Unique: QlrzO6nRMFegnWNM5i7t6Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4256569a4faso10627395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112951; x=1720717751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpg1faBr5ekWLp/A+ticofxlpAUVrowaMF9N+c1VH5Y=;
        b=ohDu6aXLQVFQzsBQT/6oobyjw011rSFb/nKq4WSjwJtExEsZLPCsVUjuHpaT9behez
         DGnZz7a+xZ2yDyeCjHC5qlkOXNBNnkJ91Eekj6/kBGjorb171LgOvPAz15Ub40G/2jcP
         ax/0diegvJIAyQzbh7jVAcJ4gO15F2186GR+yEEEHAmEVwM0x4mdpMThpCDxvdQKk+xx
         ol45h8CpeAiPpvsafdoWb6j2AJbAaIeO2coy/E9z5MCBVB6Ls7dGsAEw4Gxx/Ex64tU0
         nwHTGmKfizToXhvS1JBmUCtSuzam6ixhg/wferJ8u7CfeKAoKjeisVhr2BLV15dM3yxV
         c5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZgVvR0mugixT42+KkcRJAPyRcibRy1O2sqwxGcnqErwSy3RpUgrhvrZwiWpt4m/EpAFK+O6DlbVxjfP76icrSVDmQZd+yaUaMN1xJ
X-Gm-Message-State: AOJu0YwgOZLTlkz/vwtvK+oi3JYxYyFtiNqETOxxh+k3YKWFhQ/1vQ9z
	ojVGCIhMuR399ArS/tmjOiI4C0POBWtvQgo+Nuc/BC5MNBOrQnrltiGyceeX27vFbSMZgKx0ZJD
	m4DZd0Q8vynw6RagouPRS0ZgOG+1RpNC5TdUBskeN9dRD6D+qNECukrd5DnEyew==
X-Received: by 2002:a05:600c:3547:b0:425:7aa7:e490 with SMTP id 5b1f17b1804b1-4264b0c50ecmr19778775e9.3.1720112950780;
        Thu, 04 Jul 2024 10:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKM4G6SCFeJEZtSOhy82Z2Ed8yGmNU3aqSb//nIUjwTmhfzTkmvAH30VJp4ZwrSb2S0rxzfA==
X-Received: by 2002:a05:600c:3547:b0:425:7aa7:e490 with SMTP id 5b1f17b1804b1-4264b0c50ecmr19778665e9.3.1720112950454;
        Thu, 04 Jul 2024 10:09:10 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d165bsm31228875e9.4.2024.07.04.10.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:09:09 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
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
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 14/20] rust: alloc: implement `IntoIterator` for `KVec`
Date: Thu,  4 Jul 2024 19:06:42 +0200
Message-ID: <20240704170738.3621-15-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704170738.3621-1-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement `IntoIterator` for `KVec`, `KVec`'s `IntoIter` type, as well
as `Iterator` for `IntoIter`.

`KVec::into_iter` disassembles the `KVec` into its raw parts;
additionally, `IntoIter` keeps track of a separate pointer, which is
incremented correspondingsly as the iterator advances, while the length,
or the count of elements, is decremented.

This also means that `IntoIter` takes the ownership of the backing
buffer and is responsible to drop the remaining elements and free the
backing buffer, if it's dropped.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc.rs      |   1 +
 rust/kernel/alloc/kvec.rs | 177 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 3a0195d23bb4..e6a5d65e0c48 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -15,6 +15,7 @@
 pub use self::allocator_test as allocator;
 
 pub use self::kbox::KBox;
+pub use self::kvec::IntoIter;
 pub use self::kvec::KVec;
 
 /// Indicates an allocation error.
diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index 7ec898657832..ece48930966e 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -11,7 +11,9 @@
     ops::DerefMut,
     ops::Index,
     ops::IndexMut,
-    ptr, slice,
+    ptr,
+    ptr::NonNull,
+    slice,
     slice::SliceIndex,
 };
 
@@ -603,3 +605,176 @@ fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
 __impl_slice_eq! { [A: Allocator] [T], KVec<U, A> }
 __impl_slice_eq! { [A: Allocator, const N: usize] KVec<T, A>, [U; N] }
 __impl_slice_eq! { [A: Allocator, const N: usize] KVec<T, A>, &[U; N] }
+
+impl<'a, T, A> IntoIterator for &'a KVec<T, A>
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
+impl<'a, T, A: Allocator> IntoIterator for &'a mut KVec<T, A>
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
+/// This `struct` is created by the `into_iter` method on [`KVec`] (provided by the [`IntoIterator`]
+/// trait).
+///
+/// # Examples
+///
+/// ```
+/// let v = kernel::kvec![0, 1, 2]?;
+/// let iter: kernel::alloc::IntoIter<_> = v.into_iter();
+///
+/// # Ok::<(), Error>(())
+/// ```
+pub struct IntoIter<T, A: Allocator = Kmalloc> {
+    ptr: *mut T,
+    buf: NonNull<T>,
+    len: usize,
+    cap: usize,
+    alloc: A,
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
+        if !KVec::<T>::is_zst() {
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
+    /// use kernel::alloc::KVec;
+    ///
+    /// let v: KVec<u32, _> = kernel::kvec![1, 2, 3]?;
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
+            // SAFETY: `self.buf` was previously allocated with `self.alloc`.
+            unsafe { self.alloc.free(self.buf.as_ptr().cast()) };
+        }
+    }
+}
+
+impl<T, A> IntoIterator for KVec<T, A>
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
+        let (ptr, len, cap, alloc) = self.into_raw_parts_alloc();
+
+        IntoIter {
+            ptr,
+            buf: unsafe { NonNull::new_unchecked(ptr) },
+            len,
+            cap,
+            alloc,
+        }
+    }
+}
-- 
2.45.2


