Return-Path: <linux-kernel+bounces-241458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85318927B9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117901F25F07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526DE1B29C2;
	Thu,  4 Jul 2024 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGTjUIa1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4731B3F2C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112903; cv=none; b=gRQBlWuYY4hFfAUn3tzewJHFuzgKvHZj6s2kRPRXSK4kxmqT4tofDUWGu4th+RZoZSKnMaVDoqu+XbYbjUeHX6hiQhd7lfJM93EcweUY+pC4G7pUOVG/tKB+FqambUno3FhqiO41VKjvIfEkUQZ+OT1ySe33wuQzv7rPqBqF3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112903; c=relaxed/simple;
	bh=3XWf+tqZEw33+PZlZUtYxgrm0fV1xVHRbQpdrge2Weo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLWYF5BEClOkF3U5/d7ek/abZdDQW7dVGifkP65z66rSmdiyhN+3HdHfaaMdU4gFXgchLYvFWjA9C1YNt5y56yCqn1U8V3i3HX31w3ffmyPlFsMbwJut4nF4GBid2Sizz/XwaINPepHNS/E7qzWcv7Cy8SQLqoejPDfmYf4X/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGTjUIa1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vphM9iJmRWkBamFnV9XKqsHbOU4Zx/cdWYFfn2wn3+4=;
	b=cGTjUIa1Tk+lPwkozfYXakMmBEaNzxaeN3ZrYbNHbUUIMXphsDmFLhUzXdYQV+cE5HC/8k
	FAbrKUGp1Phnad7BN0r70f8NnOSN87B+0K1nakolDXX81LG4JUH5aouezWlcAZZ3rpKlcd
	MHetQt5+9AVW09O6uAI4EX0KW3VizfM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-XXd29k67O9SlSXLNSMqoFQ-1; Thu, 04 Jul 2024 13:08:19 -0400
X-MC-Unique: XXd29k67O9SlSXLNSMqoFQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367879e8395so457425f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112898; x=1720717698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vphM9iJmRWkBamFnV9XKqsHbOU4Zx/cdWYFfn2wn3+4=;
        b=SeF4ln4xrq2kHzFqT24BOZDdivVfMxsCycZPAT5pY62iQurz3yc3b84dCW6IyVhomw
         Dl0X+dBSUgtY6lzU1vrCD6fKBrZHbJud29FJXSNfNsFxjZIlmSS1qrwFGBWqcbYYBFCx
         ilmIlwawtG0ER3b6vRih5sqqnG2bBIxPO4jcRm+fOy3C8LJAbs2e9gyFLVoWDO5ed50X
         0YKzHqY9Tsj9U/tSu15ajmFcs7JxkvLTWqXzePEXG+WOSoqU87Vg6ebnOVIAcp3Pt8OL
         Uas0rEUtrQ9ySY2byO5d0x3iLxCFp1n0PfhFasmujoVcAyVCQ6jgVzKJedLaQMFicy1u
         h7tw==
X-Forwarded-Encrypted: i=1; AJvYcCWg6mWOkdnIViCCAOKmnB+UyqZixvsEn5Ljxut+f24eJGtgA7VI4x1jZOMn/w0lXudlqaTz32mOw1qI6CqJH+7ONXbtg78R1Yi6G1DV
X-Gm-Message-State: AOJu0YybIzpuip1Nzo4Z0wLvHo3ym3fS7GF/aBFf3zgqz4MtT4zdABi8
	ET9q2pmznnElLuMxg7/M0P3yWZod3HZj2W/CEPAbZPP+z1yV98YJASwxNVeivagfNGzTEH7+DA0
	O8J/8IGQEwH6DWkvy1tqHVYKjUoLMtLBSgXx+LXLYjyEiMqwvlAbJDSdLPh5yKQ==
X-Received: by 2002:adf:facf:0:b0:367:8fc3:a25b with SMTP id ffacd0b85a97d-3679dd31215mr1461496f8f.42.1720112898280;
        Thu, 04 Jul 2024 10:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOQrlOgzUp2s25TyvjFOYtHEEXKGFugmXIqiA5JDYJbXkI5jgBcotLg9FeuRNMnsJcDHO7fA==
X-Received: by 2002:adf:facf:0:b0:367:8fc3:a25b with SMTP id ffacd0b85a97d-3679dd31215mr1461481f8f.42.1720112897828;
        Thu, 04 Jul 2024 10:08:17 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a1805e53sm1391438f8f.22.2024.07.04.10.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:08:17 -0700 (PDT)
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
Subject: [PATCH 01/20] rust: alloc: add `Allocator` trait
Date: Thu,  4 Jul 2024 19:06:29 +0200
Message-ID: <20240704170738.3621-2-dakr@redhat.com>
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

Add a kernel specific `Allocator` trait, that in contrast to the one in
Rust's core library doesn't require unstable features and supports GFP
flags.

Subsequent patches add the following trait implementors: `Kmalloc`,
`Vmalloc` and `KVmalloc`.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc.rs | 73 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 531b5e471cb1..462e00982510 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -11,6 +11,7 @@
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
+use core::{alloc::Layout, ptr, ptr::NonNull};
 
 /// Flags to be used when allocating memory.
 ///
@@ -71,3 +72,75 @@ pub mod flags {
     /// small allocations.
     pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
 }
+
+/// The kernel's [`Allocator`] trait.
+///
+/// An implementation of [`Allocator`] can allocate, re-allocate and free memory buffer described
+/// via [`Layout`].
+///
+/// [`Allocator`] is designed to be implemented on ZSTs; its safety requirements to not allow for
+/// keeping a state throughout an instance.
+///
+/// # Safety
+///
+/// Memory returned from an allocator must point to a valid memory buffer and remain valid until
+/// its explicitly freed.
+///
+/// Copying, cloning, or moving the allocator must not invalidate memory blocks returned from this
+/// allocator. A copied, cloned or even new allocator of the same type must behave like the same
+/// allocator, and any pointer to a memory buffer which is currently allocated may be passed to any
+/// other method of the allocator.
+pub unsafe trait Allocator {
+    /// Allocate memory based on `layout` and `flags`.
+    ///
+    /// On success, returns a buffer represented as `NonNull<[u8]>` that satisfies the size an
+    /// alignment requirements of layout, but may exceed the requested size.
+    ///
+    /// This function is equivalent to `realloc` when called with a NULL pointer and an `old_size`
+    /// of `0`.
+    fn alloc(&self, layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's safety requirements and asks
+        // for a new memory allocation.
+        unsafe { self.realloc(ptr::null_mut(), 0, layout, flags) }
+    }
+
+    /// Re-allocate an existing memory allocation to satisfy the requested `layout`. If the
+    /// requested size is zero, `realloc` behaves equivalent to `free`.
+    ///
+    /// If the requested size is larger than `old_size`, a successful call to `realloc` guarantees
+    /// that the new or grown buffer has at least `Layout::size` bytes, but may also be larger.
+    ///
+    /// If the requested size is smaller than `old_size`, `realloc` may or may not shrink the
+    /// buffer; this is implementation specific to the allocator.
+    ///
+    /// On allocation failure, the existing buffer, if any, remains valid.
+    ///
+    /// The buffer is represented as `NonNull<[u8]>`.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to an existing and valid memory allocation created by this allocator
+    /// instance of a size of at least `old_size`.
+    ///
+    /// Additionally, `ptr` is allowed to be a NULL pointer; in this case a new memory allocation is
+    /// created.
+    unsafe fn realloc(
+        &self,
+        ptr: *mut u8,
+        old_size: usize,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError>;
+
+    /// Free an existing memory allocation.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must point to an existing and valid memory allocation created by this `Allocator`
+    /// instance.
+    unsafe fn free(&self, ptr: *mut u8) {
+        // SAFETY: `ptr` is guaranteed to be previously allocated with this `Allocator` or NULL.
+        // Calling `realloc` with a buffer size of zero, frees the buffer `ptr` points to.
+        let _ = unsafe { self.realloc(ptr, 0, Layout::new::<()>(), Flags(0)) };
+    }
+}
-- 
2.45.2


