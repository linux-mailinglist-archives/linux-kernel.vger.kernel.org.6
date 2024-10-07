Return-Path: <linux-kernel+bounces-354138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC299383B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA3F1F2111A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325041DED4A;
	Mon,  7 Oct 2024 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU2fenqg"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2D1DE896;
	Mon,  7 Oct 2024 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332942; cv=none; b=QIzJ8dlqkuNDi5ABahUmt41m7vCDCb3bjrGlWarXwnpdqf70HK6JoYvMv4tVZ3UXYUK0UvBBKyQxzNs+PkMgbLy4dwM3XE2otOwFUhJrHbKz3jktT4I1gwTrWp7nuBTlSBh23DvbEiK1PdQ0aCYFaBZEaN9ZPYucGMZF+jgv0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332942; c=relaxed/simple;
	bh=auYG/VDe1mWcZywKxhlRxxpphlZSFR2i8lAg5LXWimM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PEuyvtucGMuagU8xQpcZuOZuOhfg6WzQ6gbFbbkBFU3cPJ40szFXf/OWKviFr16Cwlt5vnz4C/G6qK73Tna30dnq55pT1upcz6CFrNuyFGcolPi6i5HuOFGgExiZxuUUOvSf7dWhG4hA/JpK00DguaAhuhp4MqiitfE2jksq+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QU2fenqg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5398996acbeso5388654e87.1;
        Mon, 07 Oct 2024 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728332939; x=1728937739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msZp1U/yeM9yfycaUvMnIVxvTQHjReul2JGaR4PEqMg=;
        b=QU2fenqgKPs2uHBa6KIna9OX3QrHkRAFvg3NOmLu48ynSQeX4KK/mp9e5dcfUHz593
         2vchgWKKflh/FdPqbKdIz465KMw0+D/aDR9wQINuCG1MxU9X6tVbyAwhx/U7BztbnZ8f
         dTDFdNFzKNG/EWi/yU9BfdQieQOsOwt514Rf2weW8K0WChjM57aatCtIV+3N8uRkC/ls
         kHazfZnAZuW6mXFvYRL3yqdLJdZJvKQEV4sIOzhUzOGD7H0DUKlAuCUC4oWyetaNXYoP
         nLYRczJ+fP5yaIPJpGR6HkqQiLkijChxgZ7N2rCUapapxYJS+KcTIY5Lu3coLD+rsEqb
         Rtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332939; x=1728937739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msZp1U/yeM9yfycaUvMnIVxvTQHjReul2JGaR4PEqMg=;
        b=OefOy5Qj+8Y5s0PfeHlDV0KTb3m36ahHV3XnltwXtd03d8Kl53RdciVbVCssQiVASz
         7XGMbG3T9PdhsUpvgvwr2xCtlogIVwoK/8dSCXsy6qPI/TtWCW4s2ka6n7J9kAGKJYD0
         HMjXg7AGMHE4OKPS/t3c3buDCimxMEIc9rOlE+ouF7QrEYGuJrZ/I2y6nvoO1TjuPa86
         emnXpsR5IKKRlfMeLo2uadr1U8wQI+0SE3HtOvKEHKmvSjMhjdPGWH/w9ucFqXhxTpoK
         ZkrsJRn/liylSswMy9sWx+Pu/7A/GCY6FBlZnanLFUG4dWRE8JXjRspFyr63Yj0wKGPj
         UKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8rNmzAXmLUAj7jDWdxfwKPTaPNduuSTO/234Umd2ioRpw9CESRM8kr0G7jz4nR2dBoMtSsSBBg/V+v6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHdUyHtkn+weO+eWUsWM0y49C60rwC9G04s4WjIYzDFfh4M3A
	H1/KGrwTpo1AIxXww0KrYfNW3RjT6dLD5ZgFt8NfaxUxZaIjwpD4xwRLEQmy
X-Google-Smtp-Source: AGHT+IHxmsQfBky80JzEOOirmt50YAwdo6UwCi4jxdRq7XW81nvEUNzxfXMhRwgxra84A8OPzSjzHA==
X-Received: by 2002:a05:6512:e97:b0:536:568f:c5ed with SMTP id 2adb3069b0e04-539ab84e0f6mr6556549e87.1.1728332938508;
        Mon, 07 Oct 2024 13:28:58 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff23307sm926237e87.197.2024.10.07.13.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:28:57 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	aliceryhl@google.com
Cc: dakr@redhat.com,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	boqun.feng@gmail.com
Subject: [PATCH 2/3] rust: page: Extend support to vmalloc_to_page
Date: Mon,  7 Oct 2024 23:27:51 +0300
Message-Id: <20241007202752.3096472-3-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
References: <20241007202752.3096472-1-abdiel.janulgue@gmail.com>
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
Drop will not be called since we are not instantiating a new Page instance.

Note that we maintain ownership semantics for self-allocated pages (e.g. Drop
still works as usual in this case).

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/page.rs | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 08ff09a25223..a84f382daf5c 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -21,11 +21,12 @@
 /// A bitmask that gives the page containing a given address.
 pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
 
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
@@ -78,6 +79,33 @@ pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
         Ok(unsafe { ptr::read(ptr) })
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
+        // checked for the requirement that the buffer passed to it should be allocated by vmalloc,
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
2.34.1


