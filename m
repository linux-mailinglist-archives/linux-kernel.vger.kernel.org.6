Return-Path: <linux-kernel+bounces-241467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8729A927BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131391F27A40
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B3D1C092B;
	Thu,  4 Jul 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZQmoSB5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90271BF31E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112930; cv=none; b=j+izp/VhzaMCvpxv+nmbdF3aj+TsT9siajSzzh2tar8ZVkLMbO8cIzVkG8nyPJf1yQfx19WXJSUZtmFpbtlqh7eSNRt7N8I9r9PDpggMloThCUkzT7LMRZdTgwYlYtURUrk/fm37DlbiXVTAmYgMN9REJqNUXl0UZBYz6UfJLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112930; c=relaxed/simple;
	bh=E7ojxsq33F6ZnnbOXdj2GEcN3gFVpL3aaByghHTyjMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TO/KzFLxRpdmweCivuyaFT+GKBuTmM8RlZjX7c+wiy7DGmuMVpRnLmA7NjvdRP0zMCVDm5k3vX33UPSTXIGM2VFtygNCmzQddLDO0UvCxxT5/kgDz0TMzgo/Nhpbaok6auRBpaXruzYn5FUGi90WNeCjU5HJTCwtBlZiuXJby4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VZQmoSB5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VyIj9wqWP+H3az8I4qjKuL0QiLtMtnLk/T2lFXWq4Zg=;
	b=VZQmoSB5Zd60W/LFf5YyxdeWnKRqtL7d+u5+w0GcHt5Bc5y2wyH/VJP07q0UlZV0XjbFXk
	pXRskIay9Z4kJ4Y5azc5OOpJ0lUbb8WqG43mfX4KGfJfD35+T/Wsni9SwTqlXj4GKwkoqW
	t5BjcymIELe41um5+bsK0WbxtP795w4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-Ibxbz3qnObeEXgLhtKGBfw-1; Thu, 04 Jul 2024 13:08:46 -0400
X-MC-Unique: Ibxbz3qnObeEXgLhtKGBfw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4257f95fe85so6079305e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112925; x=1720717725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyIj9wqWP+H3az8I4qjKuL0QiLtMtnLk/T2lFXWq4Zg=;
        b=fSryI6qxMxqV6/UQGgW0Qqqu8BRA0exQ0O0j1Lh1KqwQR5DkbCqQEKkstutKJrxqhC
         GX9qJHZm1pNHfuFOobgC3+QnroYTxG/24rO8lkR5W+ZWGHSBCB1XY1HnoBzB/rRNlPa+
         mLXmJT+FT6HzhX3q6wrIFF6dJ8wkL4R404ifTvTxYbvT/RQlXOio1jFOKRNGmqxskk6d
         L2psSK+fMRofIg8a0lzar0F9Xpr63Hb+dIPyyq5NQi5xL2R3l2ZDVY6GyWDmGrUm7Kd3
         XARzVrkMzihJgyrnzwSOVPymdtcM0BH9uO69PhzS2FwN5ClsnH6xHN+jMvYXouqD/DcT
         HL+w==
X-Forwarded-Encrypted: i=1; AJvYcCWRuYeQsQt3CYOGu9GtWHDJ31Rpkz9cSkcbv+sfDxZktwbzHVXa724fGv0lbsr78jfw4gPnEJ5KYovZKCwabksJLakKSHdYFrxXwLXl
X-Gm-Message-State: AOJu0YwFKg37QyXgkU14QKEdqlsDr/6FLqC6MtfaKkvRiKaxIAVxcCAV
	J9hVscXh8iYimcZAGIIA6gJfmC1xeTwMWsGySjiSNENfcplTOAycb+vaBqYIPr3bMG0k8y30yi0
	bxJxGTZkwd63OUTDsg56pHH0gWJ7hVevXgm8e4S8/SLCaUvBdnsRCDgUIyiI+tg==
X-Received: by 2002:a05:600c:4205:b0:424:e04b:88f9 with SMTP id 5b1f17b1804b1-4264a3d882emr19468255e9.3.1720112925504;
        Thu, 04 Jul 2024 10:08:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfI/OG2k4CkgNKhoBfG0TFM/3DwBzLEJDiB1KuYfjIallxq+of5uFapJbWq2WqSV8EV+r/zg==
X-Received: by 2002:a05:600c:4205:b0:424:e04b:88f9 with SMTP id 5b1f17b1804b1-4264a3d882emr19468185e9.3.1720112925222;
        Thu, 04 Jul 2024 10:08:45 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d16b0sm30529065e9.7.2024.07.04.10.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:08:44 -0700 (PDT)
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
Subject: [PATCH 08/20] rust: alloc: implement `KVmalloc` allocator
Date: Thu,  4 Jul 2024 19:06:36 +0200
Message-ID: <20240704170738.3621-9-dakr@redhat.com>
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

Implement `Allocator` for `KVmalloc`, an `Allocator` that tries to
allocate memory wth `kmalloc` first and, on failure, falls back to
`vmalloc`.

All memory allocations made with `KVmalloc` end up in
`kvrealloc_noprof()`; all frees in `kvfree()`.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc/allocator.rs      | 35 +++++++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 2 files changed, 36 insertions(+)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 0a4f27c5c3a6..d561c594cc7f 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -22,6 +22,12 @@
 /// contiguous kernel virtual space.
 pub struct Vmalloc;
 
+/// The kvmalloc kernel allocator.
+///
+/// Attempt to allocate physically contiguous memory, but upon failure, fall back to non-contiguous
+/// (vmalloc) allocation.
+pub struct KVmalloc;
+
 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
 fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
@@ -167,6 +173,35 @@ unsafe fn realloc(
     }
 }
 
+unsafe impl Allocator for KVmalloc {
+    unsafe fn realloc(
+        &self,
+        old_ptr: *mut u8,
+        old_size: usize,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let size = aligned_size(layout);
+
+        let ptr = if size == 0 {
+            // SAFETY: `old_ptr` is guaranteed to be previously allocated with this `Allocator` or
+            // NULL.
+            unsafe { bindings::kvfree(old_ptr.cast()) };
+            NonNull::dangling()
+        } else {
+            // SAFETY: `old_ptr` is guaranteed to point to valid memory with a size of at least
+            // `old_size`, which was previously allocated with this `Allocator` or NULL.
+            let raw_ptr = unsafe {
+                bindings::kvrealloc_noprof(old_ptr.cast(), old_size, size, flags.0).cast()
+            };
+
+            NonNull::new(raw_ptr).ok_or(AllocError)?
+        };
+
+        Ok(NonNull::slice_from_raw_parts(ptr, size))
+    }
+}
+
 #[global_allocator]
 static ALLOCATOR: Kmalloc = Kmalloc;
 
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index b2d7db492ba6..f0e96016b196 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -8,6 +8,7 @@
 
 pub struct Kmalloc;
 pub type Vmalloc = Kmalloc;
+pub type KVmalloc = Kmalloc;
 
 unsafe impl Allocator for Kmalloc {
     unsafe fn realloc(
-- 
2.45.2


