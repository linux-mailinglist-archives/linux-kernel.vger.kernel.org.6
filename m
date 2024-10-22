Return-Path: <linux-kernel+bounces-377083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2199AB9A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3371C1C23B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06871CF29D;
	Tue, 22 Oct 2024 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzJQyGET"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683D1CEE88;
	Tue, 22 Oct 2024 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637358; cv=none; b=F9oYLdx/vTbYeMfP4S1QrtrkXnBY8kucjzy2YRsqnTclRFULk/7jwb5bq1AMjTd5EQ3Wm19yRkQKphZKCZrhM9Nm5QHPOEA4o1apceRdSSTmWt0JWgz2ZhwqMmY6zzoPc0vNIEM9vZ7ePZXe10S4xWjT3Ysk4kG5nHrJx8nZUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637358; c=relaxed/simple;
	bh=2blEUrbPphbcXN+vYkgtsyrUfkBWuzuL5fzuvWXdX+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHguCF1sRgF5d/bAGMo6nW7pn9xaciYZmvY+Ys5yO2KXtXZyg2Eq969NxU0lEl3S7SCITiyGOCX++YwBfYcEv//JteKxsxwWEisMv3P63sO4nDv0jzxU0f9fZG8kOJJ1nzoHKo1FaWYbqYkqove2tt4k6MWjCcKWt7gFn6gOWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzJQyGET; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f6e1f756so7185832e87.0;
        Tue, 22 Oct 2024 15:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729637355; x=1730242155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM4dLe8e61s60Agsxix4PCXEpP+oYP3bpG6M39q2Oxo=;
        b=FzJQyGETZyUJK2ISYuQ0eAdN51t9eBYK5ORWC8sExSAoRfQPUanj1LgHeYvGU9LI3I
         g6q69VQDR2QdX+mprg+wpW9V6sHDgR68TpyZXcBKyMLdxXoet4MZwohIByy4GMO256ae
         ir8kLg/QwXUlSNe83kNBqMQgYqEGWuaOg2Rvzh99paDm2rJ+Rs3pU7uvpLFDoyxupksT
         De+hCbuigcukv9h+LPwTzJDmaHgShhKloqxSQbY5wZY4xyWmdycsRrrI9QfWsIJRR5BN
         wRHAKZ3E6X3uVe/IB4wHCHn6SrLGHc7K+VZ9j//JbBlA5ncCDCPVzfWT5oYjdd1X+Ytb
         hlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729637355; x=1730242155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM4dLe8e61s60Agsxix4PCXEpP+oYP3bpG6M39q2Oxo=;
        b=mI+M8bIGozsKDdD69EJQBk6juZqiRjTAjJiauoT0ptde6Gheii39WpOOb2EXWyEgee
         qzl+n2WK0au0Z4oOCTkZeeKt01NZWZRtdBhnFLh2AQ5IDHWMk336P7GUA/MN0Y93hz6v
         2CG6E6je3Egcn6m8H28lu5hnM8eA0kC2PMO+IFCnTf+G8Gl/lAjzcLp5fYtg2xXuc9j6
         wvREnEu4W4BXrhWp9Vu9TLnR3qjcqm5q1TRZqtn7P/pQPaQ9WCTD4jFUBM8b0/gkbMDw
         36EbOCxqrvLcvKMWQIc7wOCS6iHsfjTpLwgxzCW3+mVj8a8rfyqD1Wz1IhjIw+acbX7P
         h1AA==
X-Forwarded-Encrypted: i=1; AJvYcCVtvRoiZrYd7yuXW0HKgkdNXb5vx5m5bseSpk4XzimytkQu1vm4Ir+fY8LMrTJzNZiuvU2cZwyKWJ4Msbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrlO72FWcM3D37rlOVKHBvOVPrPQBEjvRimeZPsvlF5al5iJaP
	TEvr1jsbMmtTVHc7+RYpC8Sz7plmcP01PUTjb+GYwcZaimX+72JxpqaX/w==
X-Google-Smtp-Source: AGHT+IHLvuf8jY8BmE3cg+RBqUo4+MvwviQpV5zot9y6cTI657ULmwLOcz+ypQk3AGCu9vZPjhQcTg==
X-Received: by 2002:a05:6512:334e:b0:539:f754:ae15 with SMTP id 2adb3069b0e04-53b1a34e1f5mr135931e87.41.1729637354632;
        Tue, 22 Oct 2024 15:49:14 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e595csm894881e87.14.2024.10.22.15.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:49:14 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	aliceryhl@google.com
Cc: dakr@redhat.com,
	linux-kernel@vger.kernel.org,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	boqun.feng@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v2 3/5] rust: page: Extend support to vmalloc_to_page
Date: Wed, 23 Oct 2024 01:44:47 +0300
Message-ID: <20241022224832.1505432-4-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend Page to support pages that are not allocated by the constructor, for
example, those returned by vmalloc_to_page(). Since we don't own those pages
we shouldn't Drop them either. Hence we take advantage of the switch to Opaque
so we can cast to a Page pointer from a struct page pointer and be able to
retrieve the reference on an existing struct page mapping. In this case
no destructor will be called since we are not instantiating a new Page instance.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/page.rs | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index a8288c15b860..465928986f4b 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -31,11 +31,12 @@ pub const fn page_align(addr: usize) -> usize {
     (addr + (PAGE_SIZE - 1)) & PAGE_MASK
 }
 
-/// A pointer to a page that owns the page allocation.
+/// A pointer to a page that may own the page allocation.
 ///
 /// # Invariants
 ///
-/// The pointer is valid, and has ownership over the page.
+/// The pointer is valid, and has ownership over the page if the page is allocated by this
+/// abstraction.
 #[repr(transparent)]
 pub struct Page {
     page: Opaque<bindings::page>,
@@ -88,6 +89,33 @@ pub fn alloc_page(flags: Flags) -> Result<Owned<Self>, AllocError> {
         Ok(unsafe { Owned::to_owned(ptr) })
     }
 
+    /// This is just a wrapper to vmalloc_to_page which returns an existing page mapping, hence
+    /// we don't take ownership of the page. Returns an error if the pointer is null or if it
+    /// is not returned by vmalloc().
+    pub fn vmalloc_to_page<'a>(
+        cpu_addr: *const core::ffi::c_void
+    ) -> Result<&'a Self, AllocError>
+    {
+        if cpu_addr.is_null() {
+            return Err(AllocError);
+        }
+        // SAFETY: We've checked that the pointer is not null, so it is safe to call this method.
+        if unsafe { !bindings::is_vmalloc_addr(cpu_addr) } {
+            return Err(AllocError);
+        }
+        // SAFETY: We've initially ensured the pointer argument to this function is not null and
+        // checked for the requirement the the buffer passed to it should be allocated by vmalloc,
+        // so it is safe to call this method.
+        let page = unsafe { bindings::vmalloc_to_page(cpu_addr) };
+        if page.is_null() {
+            return Err(AllocError);
+        }
+        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::page`.
+        // SAFETY: We just successfully allocated a page, therefore dereferencing
+        // the page pointer is valid.
+        Ok(unsafe { &*page.cast() })
+    }
+
     /// Returns a raw pointer to the page.
     pub fn as_ptr(&self) -> *mut bindings::page {
         self.page.get()
-- 
2.43.0


