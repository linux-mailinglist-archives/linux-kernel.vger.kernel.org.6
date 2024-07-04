Return-Path: <linux-kernel+bounces-241465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F91927BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA371F273B6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6781BBBF8;
	Thu,  4 Jul 2024 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jj4QXqQY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F01BB6A2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112922; cv=none; b=DyFMDpF3gBg1pWZ2lQTVJhFLe6nbNvh5Mrc6IvdNYgG+YJcRlCZs9S5X/JqZaAHGolp0cXhNoPLOHS804yJSrzHUGyaqYXo8fUQFHeVGsNnjNJRHkTix3I1eNopZ8nEC5i5SJ4xHoEG2oDkS3wB/2WS3kDAupDW4Y2uWLU+Rd40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112922; c=relaxed/simple;
	bh=YcnAH3SHZXROeNoMHnipvFfals1BnUzQ96nTlnvMQFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MszTlQbOoA7Ivx9pX7VOUhbfqwskhu1F0bOAIGYstnJo3CcxSCayZ75nqc7ohB25Va9UlEL1qE631jbOpZpHE+wc9ZLX6WMI4EUIDQAU4TdHVibbJRMxuM7yfjpTIUYKkYxl6hip0AZ1z2xageD5XZ1EF0hGT4lSrcK3sqpFzWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jj4QXqQY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0UMICwsMRzMsfA9s19JVB8HcVWOB39iLX8GByK/zHc=;
	b=Jj4QXqQYg9Db1teo87LBqhfTfKnhttYn7Mim+T+cFOcMIASjJ5UbvyQ96jkn92GWF/Znrg
	iq+bmKjX9Tl+pEz1UdMroOoDgpub8bcAB8P/Us5H36+wmffcZuwMjiVYEd9AaStyw7cTEB
	tSmdR0uOgya5hxxkkoMRYivPgHX8nWY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-BAUgnQgJPLmzE_HnGCcwMw-1; Thu, 04 Jul 2024 13:08:39 -0400
X-MC-Unique: BAUgnQgJPLmzE_HnGCcwMw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36792df120fso658730f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112918; x=1720717718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0UMICwsMRzMsfA9s19JVB8HcVWOB39iLX8GByK/zHc=;
        b=LDhQEdc+XUbsNw6BIN9LU7XHy6CSusn6+Msklt/xekLepj8ymRZGecX/gn0DN7vbEF
         ulvfleGkXAQ0KuOGnSeFfIC1mQZ9Zgkufj62yuq4K5f4pDZaLyrciThtXgAwAkk3y0yz
         CvcC2s3gb82xK7AuohO5j4AnbYJP61oK7sfORlH+DIIxQOEEOERJPYjiALmNO2wHVLoB
         2Lv1hOQ4btIFjhxVIklnl3qqPq8Ej6KNiCvRz3MWSt4Jn1EZG61/chQffYmnaNXIz39w
         ItcDzqKEjmzbHxJuOk/DR9PJ7H6jnMozAmZUzqPcCEUooG/ONEpwk1UqM3nJBXe+a8tO
         LFPw==
X-Forwarded-Encrypted: i=1; AJvYcCVym65xGZhhiOmzhmugj5we18DjztCP4VllcL2ebcO6R2tLtRB/SfAdGbIaojh34xWgf8BQEhRG27RaUtoRUQSiuEVtNpuvtT/TrTby
X-Gm-Message-State: AOJu0YyBX7ffoSayD5TZC1FA/oTavqA24h1wK11PEJRTAzqM13ntGX6Q
	rqPiKyTMCfzfbrHm+BXi1nxOeg8K8xMEpM2Zi1Z2tcOTVNsJ/uznJTSojF6UOQTrr8rOfURULcj
	nv9FXcb93rmnY2GzjfYo2tVSttXVcp+CjJsu+1ndpEmNRmWiXqmoX3IPBKKun9A==
X-Received: by 2002:a05:6000:12c6:b0:367:91cf:e890 with SMTP id ffacd0b85a97d-3679dd10283mr1823258f8f.6.1720112917799;
        Thu, 04 Jul 2024 10:08:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/XJEdVUhXEyatK6ngjqfp7NJ4Le1ciarBr+9Y1EF175deeq20/plyxZJPo3uVQ0XayyddFQ==
X-Received: by 2002:a05:6000:12c6:b0:367:91cf:e890 with SMTP id ffacd0b85a97d-3679dd10283mr1823239f8f.6.1720112917535;
        Thu, 04 Jul 2024 10:08:37 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a3016f8bsm877280f8f.46.2024.07.04.10.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:08:36 -0700 (PDT)
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
Subject: [PATCH 06/20] rust: alloc: remove `krealloc_aligned`
Date: Thu,  4 Jul 2024 19:06:34 +0200
Message-ID: <20240704170738.3621-7-dakr@redhat.com>
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

Now that we have `Allocator` for `Kmalloc` in place, remove explicit
calls to `krealloc_aligned` and get rid of `krealloc_aligned` itself.

`bindings::krealloc` should only be called from `Kmalloc::realloc`.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc/allocator.rs | 21 ---------------------
 rust/kernel/alloc/box_ext.rs   | 13 ++++---------
 rust/kernel/alloc/vec_ext.rs   | 23 +++++++++++++----------
 3 files changed, 17 insertions(+), 40 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index b7c0490f6415..1860cb79b875 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -36,27 +36,6 @@ fn aligned_size(new_layout: Layout) -> usize {
     size
 }
 
-/// Calls `krealloc` with a proper size to alloc a new object.
-///
-/// # Safety
-///
-/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
-/// - `new_layout` must have a non-zero size.
-pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
-    // SAFETY:
-    // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
-    //   function safety requirement.
-    // - `size` is greater than 0 since it's either a `layout.size()` (which cannot be zero
-    //   according to the function safety requirement) or a result from `next_power_of_two()`.
-    unsafe {
-        bindings::krealloc(
-            ptr as *const core::ffi::c_void,
-            aligned_size(new_layout),
-            flags.0,
-        ) as *mut u8
-    }
-}
-
 unsafe impl Allocator for Kmalloc {
     unsafe fn realloc(
         &self,
diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
index 829cb1c1cf9e..1aeae02c147e 100644
--- a/rust/kernel/alloc/box_ext.rs
+++ b/rust/kernel/alloc/box_ext.rs
@@ -33,24 +33,19 @@ fn new_uninit(_flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
     #[cfg(not(any(test, testlib)))]
     fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
         let ptr = if core::mem::size_of::<MaybeUninit<T>>() == 0 {
-            core::ptr::NonNull::<_>::dangling().as_ptr()
+            core::ptr::NonNull::dangling()
         } else {
+            let alloc: &dyn super::Allocator = &super::allocator::Kmalloc;
             let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
 
             // SAFETY: Memory is being allocated (first arg is null). The only other source of
             // safety issues is sleeping on atomic context, which is addressed by klint. Lastly,
             // the type is not a SZT (checked above).
-            let ptr =
-                unsafe { super::allocator::krealloc_aligned(core::ptr::null_mut(), layout, flags) };
-            if ptr.is_null() {
-                return Err(AllocError);
-            }
-
-            ptr.cast::<MaybeUninit<T>>()
+            alloc.alloc(layout, flags)?.cast()
         };
 
         // SAFETY: For non-zero-sized types, we allocate above using the global allocator. For
         // zero-sized types, we use `NonNull::dangling`.
-        Ok(unsafe { Box::from_raw(ptr) })
+        Ok(unsafe { Box::from_raw(ptr.as_ptr()) })
     }
 }
diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
index e9a81052728a..bf277976ed38 100644
--- a/rust/kernel/alloc/vec_ext.rs
+++ b/rust/kernel/alloc/vec_ext.rs
@@ -118,6 +118,7 @@ fn reserve(&mut self, additional: usize, _flags: Flags) -> Result<(), AllocError
 
     #[cfg(not(any(test, testlib)))]
     fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
+        let alloc: &dyn super::Allocator = &super::allocator::Kmalloc;
         let len = self.len();
         let cap = self.capacity();
 
@@ -145,16 +146,18 @@ fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError>
 
         // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
         // `krealloc_aligned`. We also verified that the type is not a ZST.
-        let new_ptr = unsafe { super::allocator::krealloc_aligned(ptr.cast(), layout, flags) };
-        if new_ptr.is_null() {
-            // SAFETY: We are just rebuilding the existing `Vec` with no changes.
-            unsafe { rebuild(self, old_ptr, len, cap) };
-            Err(AllocError)
-        } else {
-            // SAFETY: `ptr` has been reallocated with the layout for `new_cap` elements. New cap
-            // is greater than `cap`, so it continues to be >= `len`.
-            unsafe { rebuild(self, new_ptr.cast::<T>(), len, new_cap) };
-            Ok(())
+        match unsafe { alloc.realloc(ptr.cast(), cap, layout, flags) } {
+            Ok(ptr) => {
+                // SAFETY: `ptr` has been reallocated with the layout for `new_cap` elements.
+                // `new_cap` is greater than `cap`, so it continues to be >= `len`.
+                unsafe { rebuild(self, ptr.as_ptr().cast(), len, new_cap) };
+                Ok(())
+            }
+            Err(err) => {
+                // SAFETY: We are just rebuilding the existing `Vec` with no changes.
+                unsafe { rebuild(self, old_ptr, len, cap) };
+                Err(err)
+            }
         }
     }
 }
-- 
2.45.2


