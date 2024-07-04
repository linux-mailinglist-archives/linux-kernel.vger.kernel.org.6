Return-Path: <linux-kernel+bounces-241461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A082927B9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0E21C23021
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E0A1B580A;
	Thu,  4 Jul 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faR4Ld11"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7962D1B3F06
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112911; cv=none; b=Bx4DQiOBOuEtgBcNbq3bCw2p5bd+4bmWWiFWACLi5XOkt/jl43uqg2WPfft+QsGWobAjafJKrwsnb3k8y3QLnKbpDj4GGmMpfcjIeWkQlSmAwFwrZESeOVa9JKKNtgSARQyrwAQcQZ9ZXroDmkmEMoh/5M7SMtI6qr4liHwcr9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112911; c=relaxed/simple;
	bh=dBkn8uWErKq0NfiBMQ9moE7lJwn+ZFUPDGAulmb98hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK03iyWK7i9nDc0c015l9m1pZa/B6yemV05okCNuSmKI4FIPaBeum/r37B5ka5ZRnFr/kcqcZlnICnzmW6wp7Xv0Nw1IOtz40kBHUzTq0XnK2Hoc0gscHhe2+LwtMzwdOb9OvCX+LMeSFJmP/9XWbKW0KMZQfnAuHEMC7nbimkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faR4Ld11; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xi1xjBHaOdM6NCOm6B2REEcdukdUD5LuLilmDyDwG4g=;
	b=faR4Ld11T81gZuLnjE19OgU95cXwzI3YJJOL8rUDPDEDn5b5WDbwAO6ULcveWwIyxsKMjX
	3wgPA17EMqk1rn9rzQgXlS2XB58FzunDghKTRONIrS1mtwrZk5tpz8jtLgWioYBH9xblm7
	89CocErhU6BDXk2k4COehazOqNFXwfE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-doAIwN3bOvGSNpLfYa0gVQ-1; Thu, 04 Jul 2024 13:08:27 -0400
X-MC-Unique: doAIwN3bOvGSNpLfYa0gVQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-367987cff30so601698f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112906; x=1720717706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xi1xjBHaOdM6NCOm6B2REEcdukdUD5LuLilmDyDwG4g=;
        b=aptP8F5lQzmbNdjwnBeOmZP7HTXFH4KqC5XcBARKXRew1lPaUKklibmnZ2fKQiHu2Y
         JPezZYrkwNPnYR1i3Cab66iFHdeO7NpdjWc680j+TEscMRg6BdozaXkUfHLxQYJ6Clgn
         ysS/eVowtVSFdtDgQLRgsmbsODW7mGR0L7qf/9UjPThcsY+8/AhhIp3kEFm2MXj6Fp/9
         I36eQmD1a4EiJnWlojdI1aPPIv/wWlhvvj0TWbLLUhzjEYEXQ1zGsOrpEYam4B8UaC4g
         KFIlQ6sojwLNjDLVWBzSOEasJpTU6o/UqdOMow1n0u03Ztk7VuASF3kfuUqA8J4WoeMz
         3BGg==
X-Forwarded-Encrypted: i=1; AJvYcCWfUlvQwfGFVlXn/Ivm/qGbOYZljbnb67f2qEZdxNMne6gjoT2vcYqbjtfIb9IiQxMJrUyjBjzCxtHnbXDNbGFXiQAfu5CLNcpPuyNg
X-Gm-Message-State: AOJu0Yx2hhqve32+yfHnpWM00Kn/sFTSHLlFDWsEofyTDy6QGkLRrHlC
	x5a8IbFCGF8Rbm2v7u9Pn0lpZ8t4s6M66p+JlzWtJKuojJlhVCb6kZ2ZZdkDKY6PeTyAvTeyB5s
	b+eLuD9tYNZ8+sWpvO0+yprKhlP8coqlP4HwE6oSRn481tkl4ZojopIQfiIGMCw==
X-Received: by 2002:adf:f548:0:b0:366:ec2c:8648 with SMTP id ffacd0b85a97d-3679dd66b0emr1473881f8f.43.1720112906043;
        Thu, 04 Jul 2024 10:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZE9lqxekh8vlvO7Znvqy+xmMypbyEYcSxQDzUKYJCWAgpo4YD19f2xbFzHmbfg5HdXDdSSQ==
X-Received: by 2002:adf:f548:0:b0:366:ec2c:8648 with SMTP id ffacd0b85a97d-3679dd66b0emr1473853f8f.43.1720112905720;
        Thu, 04 Jul 2024 10:08:25 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679983882csm2704593f8f.78.2024.07.04.10.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:08:25 -0700 (PDT)
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
Subject: [PATCH 03/20] rust: alloc: rename `KernelAllocator` to `Kmalloc`
Date: Thu,  4 Jul 2024 19:06:31 +0200
Message-ID: <20240704170738.3621-4-dakr@redhat.com>
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

Subsequent patches implement `Vmalloc` and `KVmalloc` allocators, hence
align `KernelAllocator` to this naming scheme.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/alloc/allocator.rs | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 49fb33cc18d9..e47ab8fe21ab 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -6,7 +6,7 @@
 use core::alloc::{GlobalAlloc, Layout};
 use core::ptr;
 
-struct KernelAllocator;
+struct Kmalloc;
 
 fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
@@ -48,7 +48,7 @@ pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: F
     }
 }
 
-unsafe impl GlobalAlloc for KernelAllocator {
+unsafe impl GlobalAlloc for Kmalloc {
     unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
         // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero size by the function safety
         // requirement.
@@ -84,7 +84,7 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
 }
 
 #[global_allocator]
-static ALLOCATOR: KernelAllocator = KernelAllocator;
+static ALLOCATOR: Kmalloc = Kmalloc;
 
 // See <https://github.com/rust-lang/rust/pull/86844>.
 #[no_mangle]
-- 
2.45.2


