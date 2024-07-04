Return-Path: <linux-kernel+bounces-241475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0534927BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746351F27B25
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189031CE0B9;
	Thu,  4 Jul 2024 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnIq5kX6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2191C8FA3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112960; cv=none; b=Ad2Nl+7rCMRALPJl1OLiHWPf4jpE0kXkxygx2ZYVxBgrFm8csxT/AfYvvDG1Ke+hlt1TcNtoBCSUepKlbYYcsJUpYPfSNZMSo02G7ynS/68t//YP/+7SGPtlIckTV8CJiBWwYimMZEelFOT+hmPnW7ZvPzQ2rNGQXRgPxK1QTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112960; c=relaxed/simple;
	bh=XUc7v1nO5kUdQAl7vZK4cJjjtrbiSJ6BexnC7Evs9nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5QWG70NugSwmXewmZrl7gcbO9nnva8U+OjV+zs23jN4i4of1E2V5GvhD35VCxwXbnTMKByZVym+vxAFgvjWwxWD22ayM6jX6r5lQbkDB8zp1TpLRpXMIwf+ND8ntcehsVP0ViZ88ReseM9Nt2knzcYPaYoUCocZXr0rv8hwaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnIq5kX6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZPhE3XC9UV6OvChFdMEzQxeZVNAagRt/GzQJe2dQ8k=;
	b=DnIq5kX63T3JiwmnPN6FRw02Jk3B4JI5Sj9h2qDMcjjcz3NLBVBD6g4V8kabljRR4N+OVm
	o8AxumMl69aPMHxRi70aQVyWuWTS9MtYN1W+7fqodBsl98Hrigaadrr81z6C4bO7uRaJiy
	v6WeRb0X7FMGgVDHWRn9L9C2V+1jMYk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-kFlJSzhePBWapK3svjrUlw-1; Thu, 04 Jul 2024 13:09:16 -0400
X-MC-Unique: kFlJSzhePBWapK3svjrUlw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4246cf4c87dso5503785e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112955; x=1720717755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZPhE3XC9UV6OvChFdMEzQxeZVNAagRt/GzQJe2dQ8k=;
        b=AWzE3mnUDLZgAAu0itKCYUk00PI/7oreSmWCtUaZHOQKs/F0jaABLMS+NooB9ThncZ
         AAYtRlJE6MssmHPVs260/W/7WCn5j9l0nndSHZde7x6WcB87//yea5+DrasJ4UL3JHJf
         PfZXsTxbhyoohXb53HpqpP5f0gqjrWprzQrjYeF6dfDMhbNPlYAF209e4Op+0tzZG1MC
         sPUnAmowwFd3QmvOsYENwRi+sJUXpIsBGLbAKybX7PUhmGaALGf4rXpw2qqNIJHYWAQZ
         skKxzQEELHvE1r6/QZxhHCsNVFdntUYz4TK3U2Y/LJB2XX4thBlc2FOUzSXvnSB9ukIC
         jaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUnmIyY4NdQFQPFuaI259QDmg3ESm7JX4WCXjfrBGcr4ylWgR9D1DEaWDkDLikHPclva4PDLiBFmJVHCAZ6ZZ/ptG3jGAoLGWTWRjX
X-Gm-Message-State: AOJu0YxkwjlpIQl9R2JKn2rGkfmPjSFv14LhtaVbzAgJk19t3dTq1vVQ
	x6WjBOUUhpf3ydvz49+QCbhDgOTrPmgJNFRDz1s4uluJJZPEDR4dlfh9gcf+hZNUNtiXr8wjVDU
	C5nOE1Uenme5eGue/VkHSC4CX6OM1CU8UhNXGNUwd9xqhgTu7TDWpYYx0S2nitw==
X-Received: by 2002:a7b:c8d4:0:b0:423:6b7:55eb with SMTP id 5b1f17b1804b1-4264a3e1d00mr19233055e9.14.1720112954932;
        Thu, 04 Jul 2024 10:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm7N1rZxpiePn941cG0nEN6av+LSSyouCyLUvG8v66AJo5NSOJhREMWyUxMtjj/QKi8dkOYQ==
X-Received: by 2002:a7b:c8d4:0:b0:423:6b7:55eb with SMTP id 5b1f17b1804b1-4264a3e1d00mr19232875e9.14.1720112954604;
        Thu, 04 Jul 2024 10:09:14 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d510bsm31761725e9.3.2024.07.04.10.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:09:14 -0700 (PDT)
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
Subject: [PATCH 15/20] rust: alloc: implement `collect` for `IntoIter`
Date: Thu,  4 Jul 2024 19:06:43 +0200
Message-ID: <20240704170738.3621-16-dakr@redhat.com>
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

Currently, we can't implement `FromIterator`. There are a couple of
issues with this trait in the kernel, namely:

  - Rust's specialization feature is unstable. This prevents us to
    optimze for the special case where `I::IntoIter` equals `KVec`'s
    `IntoIter` type.
  - We also can't use `I::IntoIter`'s type ID either to work around this,
    since `FromIterator` doesn't require this type to be `'static`.
  - `FromIterator::from_iter` does return `Self` instead of
    `Result<Self, AllocError>`, hence we can't properly handle allocation
    failures.
  - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle
    additional allocation flags.

Instead, provide `IntoIter::collect`, such that we can at least convert
`IntoIter` into a `KVec` again.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc/kvec.rs | 83 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
index ece48930966e..463c8910c23c 100644
--- a/rust/kernel/alloc/kvec.rs
+++ b/rust/kernel/alloc/kvec.rs
@@ -2,7 +2,7 @@
 
 //! Implementation of [`KVec`].
 
-use super::{allocator::Kmalloc, AllocError, Allocator, Flags};
+use super::{allocator::Kmalloc, flags::*, AllocError, Allocator, Flags};
 use crate::types::Unique;
 use core::{
     fmt,
@@ -658,6 +658,87 @@ impl<T, A> IntoIter<T, A>
     fn as_raw_mut_slice(&mut self) -> *mut [T] {
         ptr::slice_from_raw_parts_mut(self.ptr, self.len)
     }
+
+    fn allocator(&self) -> &A {
+        &self.alloc
+    }
+
+    fn into_raw_parts(self) -> (*mut T, NonNull<T>, usize, usize, A) {
+        let me = ManuallyDrop::new(self);
+        let ptr = me.ptr;
+        let buf = me.buf;
+        let len = me.len;
+        let cap = me.cap;
+        let alloc = unsafe { ptr::read(me.allocator()) };
+        (ptr, buf, len, cap, alloc)
+    }
+
+    /// Same as `Iterator::collect` but specialized for `KVec`'s `IntoIter`.
+    ///
+    /// Currently, we can't implement `FromIterator`. There are a couple of issues with this trait
+    /// in the kernel, namely:
+    ///
+    /// - Rust's specialization feature is unstable. This prevents us to optimze for the special
+    ///   case where `I::IntoIter` equals `KVec`'s `IntoIter` type.
+    /// - We also can't use `I::IntoIter`'s type ID either to work around this, since `FromIterator`
+    ///   doesn't require this type to be `'static`.
+    /// - `FromIterator::from_iter` does return `Self` instead of `Result<Self, AllocError>`, hence
+    ///   we can't properly handle allocation failures.
+    /// - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle additional allocation
+    ///   flags.
+    ///
+    /// Instead, provide `IntoIter::collect`, such that we can at least convert a `IntoIter` into a
+    /// `KVec` again.
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
+    /// let v = it.collect()?;
+    /// assert_eq!(v, [2, 3]);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn collect(self) -> Result<KVec<T, A>, AllocError> {
+        let (mut ptr, buf, len, mut cap, alloc) = self.into_raw_parts();
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
+        // Do not allow for too much spare capacity.
+        if len < cap / 2 {
+            let layout = core::alloc::Layout::array::<T>(len).map_err(|_| AllocError)?;
+            // SAFETY: `ptr` points to the start of the backing buffer, `cap` is the capacity of
+            // the original `KVec` and `len` is guaranteed to be smaller than `cap`. Depending on
+            // `alloc` this operation may shrink the buffer or leaves it as it is.
+            ptr = unsafe {
+                alloc.realloc(ptr.cast(), KVec::<T>::buffer_size(cap)?, layout, GFP_KERNEL)
+            }?
+            .as_ptr()
+            .cast();
+            cap = len;
+        }
+
+        // SAFETY: If the iterator has been advanced, the advanced elements have been copied to
+        // the beginning of the buffer and `len` has been adjusted accordingly. `ptr` is guaranteed
+        // to point to the start of the backing buffer. `cap` is either the original capacity or,
+        // after shrinking the buffer, equal to `len`. `alloc` is guaranteed to be unchanged since
+        // `into_iter` has been called on the original `KVec`.
+        Ok(unsafe { KVec::from_raw_parts_alloc(ptr, len, cap, alloc) })
+    }
 }
 
 impl<T, A> Iterator for IntoIter<T, A>
-- 
2.45.2


