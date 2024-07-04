Return-Path: <linux-kernel+bounces-241459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA6927B9B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4501A1F261E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D31B3F00;
	Thu,  4 Jul 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajTSJzYX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC731B47B6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112907; cv=none; b=HxavxbywyrRUSRCfjLH8xdQqJCb1gNSjjmXyFwl3SrhaueJrMjIP4mZAI9f1aGFRp38R9mTGDD/JC1wrDKk0xVe0yzXm6+fKhV+AEqQFXLhG7qwZxIwlwz0N1MHiYH3R3IgM5Q+0LsGQY5k77CW4vNjTnadiLrxHUMfF75z+aoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112907; c=relaxed/simple;
	bh=QrynI0HoPy4Hny/wycemLcIhmp9fTzHnwd0bnDI3BXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGONQ9v77JDz5o0Ciz9k4nkxgs2GitgS1ftrPWQ2jKmEUwuF7a5Me51sjZCn0TNwQ7b2u2/gAVYTNh9JhIJRfmJzTeElSnntp9YtVNXwR94rT4SE2Zd57revv2QP6XfaOKxeZeECFdemiPDXimtf1VbwgPj63tl/gOdPPCvileU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajTSJzYX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gkm1HsuIC/IJIdfFvL0dQb/JQUMIA7HW6TqPIuzm1+Y=;
	b=ajTSJzYXzvA/Md+u8p8ku6nYvSsWHpDFMx9TlFj7Kehhbe35bRqVOZzqBvI6sb5+MZi08R
	fx9k2mMHN1BPyGFwpa96BBv3z10A/QjnGP9ijZKV9Q7ntEzQnZMXM/SNrfL30cP0nD3EDO
	d2kywdeD0aeLzJ30OT8VwVvBnB4b9nA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-w5O_m417POGJpg1mSheQmw-1; Thu, 04 Jul 2024 13:08:23 -0400
X-MC-Unique: w5O_m417POGJpg1mSheQmw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee8f22ef7cso8481301fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112902; x=1720717702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkm1HsuIC/IJIdfFvL0dQb/JQUMIA7HW6TqPIuzm1+Y=;
        b=JBI78uWwgiXODIzkNH8jxO3RM2t/BcTWwpxxvCH/uN0k1fO3kRHD0Y4Ynh56zllMxq
         Zj3MSgSwgYslFtF/dJ3h7zTjYiVzWfFvrLLh4gudn/4czNWJd0tIM1neHV/Rp3Gy2PsS
         SBWr5Zhj59HjYL2zEQeQQG4pOreBOmYXBV8PhqzPh8lOZslra4YBmJXBY37JCQD5qPKB
         dGQNg0qrzMs4pOErPAVZbJ7AJjra6pZxRZKEeJlHt84MdUDh/+2AmE+DAFZxDqE0hNc+
         orGkhmyoHbQ6NMUppp+GmBNdlTrPkpkhAl+fJXKEd5Z8BuqrQ1wE0lmNNqxHZG5hMRZW
         PfBA==
X-Forwarded-Encrypted: i=1; AJvYcCVtXdTmqF3ZEeova8WIoNh+iNunuCDN9IWf+0Eb6+M9qlJGtIngxGiAVFZPF11WEXdefmdBLD4jOpVHZhN9dKsF80Szq2v61d+Axq20
X-Gm-Message-State: AOJu0YzSTx0/rIerB88K5vrFMA+u8spOxieBqcgucDDMh2DK4jJu296E
	Pmvv6JczeoBD08knJ8CvjeXcVqqVhvLDVFtL917gKASgvkxKv9bbTfKApT8HR0NdzMSCpG+0OOC
	24Nh6ssgUvUjN8Riz83u39qRI+TbLuCuaVjS6EDTOLAo9eEiihovB0LVfj+mY9w==
X-Received: by 2002:a05:6512:3aa:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-52ea061f61emr1482808e87.11.1720112902213;
        Thu, 04 Jul 2024 10:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC1w3veRR7ifL3/ieyNufl0zLqc3/LfgsQPz+jstYWmTdKHKy92qb6tBJMl0hm5NEL7o5XSA==
X-Received: by 2002:a05:6512:3aa:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-52ea061f61emr1482784e87.11.1720112901793;
        Thu, 04 Jul 2024 10:08:21 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d0b24sm31308165e9.3.2024.07.04.10.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:08:21 -0700 (PDT)
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
Subject: [PATCH 02/20] rust: alloc: separate `aligned_size` from `krealloc_aligned`
Date: Thu,  4 Jul 2024 19:06:30 +0200
Message-ID: <20240704170738.3621-3-dakr@redhat.com>
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

Separate `aligned_size` from `krealloc_aligned`.

Subsequent patches implement `Allocator` derivates, such as `Kmalloc`,
that require `aligned_size` and replace the original `krealloc_aligned`.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc/allocator.rs | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 229642960cd1..49fb33cc18d9 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -8,13 +8,7 @@
 
 struct KernelAllocator;
 
-/// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
-///
-/// # Safety
-///
-/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
-/// - `new_layout` must have a non-zero size.
-pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
+fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
     let layout = new_layout.pad_to_align();
 
@@ -30,12 +24,28 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
         size = size.next_power_of_two();
     }
 
+    size
+}
+
+/// Calls `krealloc` with a proper size to alloc a new object aligned to `new_layout`'s alignment.
+///
+/// # Safety
+///
+/// - `ptr` can be either null or a pointer which has been allocated by this allocator.
+/// - `new_layout` must have a non-zero size.
+pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
     // SAFETY:
     // - `ptr` is either null or a pointer returned from a previous `k{re}alloc()` by the
     //   function safety requirement.
     // - `size` is greater than 0 since it's either a `layout.size()` (which cannot be zero
     //   according to the function safety requirement) or a result from `next_power_of_two()`.
-    unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, size, flags.0) as *mut u8 }
+    unsafe {
+        bindings::krealloc(
+            ptr as *const core::ffi::c_void,
+            aligned_size(new_layout),
+            flags.0,
+        ) as *mut u8
+    }
 }
 
 unsafe impl GlobalAlloc for KernelAllocator {
-- 
2.45.2


