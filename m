Return-Path: <linux-kernel+bounces-241466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8BA927BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFBB1F27A59
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9A81B3F3C;
	Thu,  4 Jul 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XN2pfmFg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2867D1BC089
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112926; cv=none; b=OdHyt2/t/hE6zNTNGietjHsilvFxJNfSX8jc9xj3aFN4ruKUbG17SBqKAsKggwx1P1R58hV5WrQoLL7SLMbilCJPNoydkJlavGAatKV+flwXbsWwaeYjMu/ILj3x4oFsTjW2U8VhZNX832jpimE/weoeIjTYYTYrsxCikRd7sWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112926; c=relaxed/simple;
	bh=MmT2mTIg7lD3LQpVQ6BofZ6b0wOersBEjYOE2yVnphM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKCsCQ/bVHgQ3TRpEU5VAlA78zrbsl3bsjMCTg5hIXFf9fr8Qqe/yaHdGWi6SLVe0Rgi2BhLC1EsEr9hxWtXOg/wnMlxX85CoiiRTNz/w+uERJM4TmpYjd/FzZFEc1ou+SCYooMwgx+6UEJK0Jp5Zem+WRukeUbXbLV6Gh7uDdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XN2pfmFg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxr2ZwkBcEiYjaLoRj6Vm8ZHty9ueyrSMs+jrT+4p3E=;
	b=XN2pfmFgC4NFpae5hNlbK4BSLSNoZN2JPNfu5Dcl8qu/7hwxyiJxSk4hQizJ79Us36+eld
	bSjC0V/JEIiK3iXeRwHMbInztRINkn/yi1rDRhrNZQwtPiERuwH2nDfxty/Ol+VNMwdbHZ
	4LcjZS5dBIHbGQtBusmnBeShTpNJIGo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-8SljsF9ZN9aiTyLE0zzwXg-1; Thu, 04 Jul 2024 13:08:42 -0400
X-MC-Unique: 8SljsF9ZN9aiTyLE0zzwXg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4257a75193aso6150205e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112922; x=1720717722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kxr2ZwkBcEiYjaLoRj6Vm8ZHty9ueyrSMs+jrT+4p3E=;
        b=U/Zjx9G6r2qqDy8hj99U6NeT1AepC74l5lig7ZJgHVC50/W/mVGfwv+dGfRvyJ3YJB
         +iG/fw/4lWCz7m1MvQI1DGXnF12dNpWpE/NK5imY9dKQFNj6CK2FiIOE/Xf4H0dqqKke
         ziVLCnafPV4thT/E/2FO2BNYV+PWHh9PDq+8kDoDSNm/t+sznIG4qh5WbBPb3bvJ7M8q
         qVILBiq61QhDFfeb6wCuXqRZ8zl61p+ZeKGd01XS2BnblgM22egF3pa1Y0Nijj4jJiBc
         6G/BWW9auRLhTe+cLppCpoSqYwMTPYMmrjVRqhyK6L7ou2SuUjiML0yD/n88CuTe6Tea
         5wXA==
X-Forwarded-Encrypted: i=1; AJvYcCXqyBLKMmFUTl57N9ru4dWgcH3BuzewiGJ5vMXu8KshrSVJ9FFtrKqie6dKk0pTmLl1iez7kvVRQCVJCMVnEfa65hzXm1A0OWzdXk7l
X-Gm-Message-State: AOJu0Yy1cxQlExXz1ZKvp657fxVjFCqtlIpaqjBu+h+60iPznOEZept/
	rqe2POGyouAuyhM+jql7hTyIT4j+uls2s8c3/I89TSBoHKe4TnKFVBzrIQhzjKmYtlkMQ8xhkoS
	aFS0ga7JoFRksRdafuh+d3EhPt1SCvi0nRDJ5x6Kvk79HwmtqH7P84Mn4/+CLyg==
X-Received: by 2002:a05:600c:4f88:b0:424:ad14:6b79 with SMTP id 5b1f17b1804b1-4264a3cc8bdmr13990895e9.8.1720112921744;
        Thu, 04 Jul 2024 10:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1VJwx5uKuQN/O8iZw/4yKAqhZVwMwMz3EKnS+JDkXDZHxAy/WJXVoREQUOWvD5/92MPuUDA==
X-Received: by 2002:a05:600c:4f88:b0:424:ad14:6b79 with SMTP id 5b1f17b1804b1-4264a3cc8bdmr13990825e9.8.1720112921452;
        Thu, 04 Jul 2024 10:08:41 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d5101ffsm17492075e9.16.2024.07.04.10.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:08:41 -0700 (PDT)
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
Subject: [PATCH 07/20] rust: alloc: implement `Vmalloc` allocator
Date: Thu,  4 Jul 2024 19:06:35 +0200
Message-ID: <20240704170738.3621-8-dakr@redhat.com>
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

Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
allocator, typically used for larger objects, (much) larger than page
size.

All memory allocations made with `Vmalloc` end up in
`__vmalloc_noprof()`; all frees in `vfree()`.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/bindings/bindings_helper.h     |  1 +
 rust/kernel/alloc/allocator.rs      | 55 +++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 57 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..f10518045c16 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 1860cb79b875..0a4f27c5c3a6 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -16,6 +16,12 @@
 /// `bindings::krealloc`.
 pub struct Kmalloc;
 
+/// The virtually contiguous kernel allocator.
+///
+/// The vmalloc allocator allocates pages from the page level allocator and maps them into the
+/// contiguous kernel virtual space.
+pub struct Vmalloc;
+
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
@@ -112,6 +118,55 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
     }
 }
 
+unsafe impl Allocator for Vmalloc {
+    unsafe fn realloc(
+        &self,
+        src: *mut u8,
+        old_size: usize,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let mut size = aligned_size(layout);
+
+        let dst = if size == 0 {
+            // SAFETY: `src` is guaranteed to be previously allocated with this `Allocator` or NULL.
+            unsafe { bindings::vfree(src.cast()) };
+            NonNull::dangling()
+        } else if size <= old_size {
+            size = old_size;
+            NonNull::new(src).ok_or(AllocError)?
+        } else {
+            // SAFETY: `src` is guaranteed to point to valid memory with a size of at least
+            // `old_size`, which was previously allocated with this `Allocator` or NULL.
+            let dst = unsafe { bindings::__vmalloc_noprof(size as u64, flags.0) };
+
+            // Validate that we actually allocated the requested memory.
+            let dst = NonNull::new(dst.cast()).ok_or(AllocError)?;
+
+            if !src.is_null() {
+                // SAFETY: `src` is guaranteed to point to valid memory with a size of at least
+                // `old_size`; `dst` is guaranteed to point to valid memory with a size of at least
+                // `size`.
+                unsafe {
+                    core::ptr::copy_nonoverlapping(
+                        src,
+                        dst.as_ptr(),
+                        core::cmp::min(old_size, size),
+                    )
+                };
+
+                // SAFETY: `src` is guaranteed to be previously allocated with this `Allocator` or
+                // NULL.
+                unsafe { bindings::vfree(src.cast()) }
+            }
+
+            dst
+        };
+
+        Ok(NonNull::slice_from_raw_parts(dst, size))
+    }
+}
+
 #[global_allocator]
 static ALLOCATOR: Kmalloc = Kmalloc;
 
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index 3a0abe65491d..b2d7db492ba6 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -7,6 +7,7 @@
 use core::ptr::NonNull;
 
 pub struct Kmalloc;
+pub type Vmalloc = Kmalloc;
 
 unsafe impl Allocator for Kmalloc {
     unsafe fn realloc(
-- 
2.45.2


