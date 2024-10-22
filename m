Return-Path: <linux-kernel+bounces-377082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F909AB9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D421F212AA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB961CEE9F;
	Tue, 22 Oct 2024 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNx9q/lD"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B31CEAB9;
	Tue, 22 Oct 2024 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637356; cv=none; b=VdpxprsIIZ3tfqD5oAUgcQUFRcgDT6j5g1xkT1yZa4sOndg4V6060INGT4zzOpdXeAf83X3n2+ZVQ8YW5uHFJfIvzqZgzKzySdNxJuTg7hCs53aC/GTCjkUZAB1uE62x5g7PdWRjlN4isLUs0z68z72X/1IHLQ8UR8WuEpWEAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637356; c=relaxed/simple;
	bh=GOdt4Fg8zcndsF4gcmOqq0KsfCak3FAOgAZuxoiRUSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lCuo2aHnArcKUyDv1PwDxCnRTHSZerv39TTqscPBXFWhqLSIjw7G8d8fnGWPcOnd6cbIvXROuJ9SGT+RKKkVPtCQ2kGcxHZWRNmi2FRHiJSkIhAVHENeAqsbr4laTg2HFbnUr9+ZmNfVZlOxKZQXx/2omL9B7JLfV79hRoKMxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZNx9q/lD; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fe76e802so7065597e87.1;
        Tue, 22 Oct 2024 15:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729637353; x=1730242153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3xO+3hoV0kRMGQidVKysI0G/pl1l+DTd2rDU2KKnok=;
        b=ZNx9q/lDzCrLrPQCko8k6KLV3Ysigvm8FXMbHAEFUmiF6JwBWSSEl3huqW163HH66f
         5lUISgojgGAhI3wiWT4Q2EEeTv0PcSrN/ZKaS6jxjM/M4U/T/B9VLVvUQ2Zl1JjWxyFT
         /lL9KI43tws5ObGA6JXzI3oSuWZwVnN0Twut2mdTlaO8LxVpF0Embf96EyOikpDfHuLi
         unN23YzUi4lrFrk2lwquzI6ps3w7Y7e0jOUZHypfSnYNuUkAClGKieKY0KiNo/KUJThn
         2zjTAoj0nwI+/xIDcvGrQ6jdLE+elhvNkRZlo4gpUMZgEDpPsG8Z4oYaNDR647NARQ64
         MQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729637353; x=1730242153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3xO+3hoV0kRMGQidVKysI0G/pl1l+DTd2rDU2KKnok=;
        b=RPfnqq1+wauYZ16I/mPjmIw4xMdlghKZ9AmoaLLHjkGwBo5AGX/lVVV/fq6f27c4Sl
         T4L4PSuy+kHKmZtnYGeNJU4HBb9ej+XKufGtkkwqK797Vo3qAHTfTHqICMwBnvfxJxw2
         +g0mRBu2/Mw3bRm7odEAqBhf0tt0THisXBr/K1VOu+Q/8KffbbEGnXmKJsfenKCn31dF
         b7i/FcrXCnieanrxQOAqgR8kQmpStkGmPrKUgUiw1aWxSXZw8nXvcnG8J5Hq7LU3LPgr
         1OiBYBTjV9U9bgScp4aL501FXqk5H4tT0cmf0dnST3i7R6TRW8jmNatgUJG7Ji2XQE63
         Yi8w==
X-Forwarded-Encrypted: i=1; AJvYcCUe4LefRGfmjKpEvyxEWpg3HqpELba8Z+du7xhqPYpXqGckbt8/V+zz8MBLRS7tju09D9nHHHAZ11FaBu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXIT5YhP+4jypmqWQ0Wj00eEuNXvrdsRVMO+XiEWlCuIp44A6
	eIDczbJnmkbw4qlT543r+Hp71dAaDfQwgFJ96M5s0SUxEDtGzzOlt422zQ==
X-Google-Smtp-Source: AGHT+IHipWqUs+P0StAmp65210yOtWYX9k5POWHdCFQbE7HLuZ5tIR/rV6i066dI5Ef/2FGJXjyq4w==
X-Received: by 2002:a05:6512:ea2:b0:539:8fcd:510 with SMTP id 2adb3069b0e04-53b1a31115amr185048e87.20.1729637352760;
        Tue, 22 Oct 2024 15:49:12 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e595csm894881e87.14.2024.10.22.15.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 15:49:11 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	aliceryhl@google.com
Cc: dakr@redhat.com,
	linux-kernel@vger.kernel.org,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	boqun.feng@gmail.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v2 2/5] rust: page: Make ownership of the page pointer explicit.
Date: Wed, 23 Oct 2024 01:44:46 +0300
Message-ID: <20241022224832.1505432-3-abdiel.janulgue@gmail.com>
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

Ensure only `Page::alloc_page` return pages that own the page allocation.
This requires that we replace the page pointer wrapper with Opaque instead
of NonNull to make it possible to cast to a Page pointer from a raw struct
page pointer.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/page.rs | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index fdac6c375fe4..a8288c15b860 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -8,8 +8,9 @@
     error::code::*,
     error::Result,
     uaccess::UserSliceReader,
+    types::{Opaque, Owned, Ownable},
 };
-use core::ptr::{self, NonNull};
+use core::ptr::{self};
 
 /// A bitwise shift for the page size.
 pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
@@ -35,8 +36,9 @@ pub const fn page_align(addr: usize) -> usize {
 /// # Invariants
 ///
 /// The pointer is valid, and has ownership over the page.
+#[repr(transparent)]
 pub struct Page {
-    page: NonNull<bindings::page>,
+    page: Opaque<bindings::page>,
 }
 
 // SAFETY: Pages have no logic that relies on them staying on a given thread, so moving them across
@@ -71,19 +73,24 @@ impl Page {
     /// let page = Page::alloc_page(GFP_KERNEL | __GFP_ZERO)?;
     /// # Ok(()) }
     /// ```
-    pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
+    pub fn alloc_page(flags: Flags) -> Result<Owned<Self>, AllocError> {
         // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
         // is always safe to call this method.
         let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
-        let page = NonNull::new(page).ok_or(AllocError)?;
+        if page.is_null() {
+            return Err(AllocError);
+        }
+        // CAST: Self` is a `repr(transparent)` wrapper around `bindings::page`.
+        let ptr = page.cast::<Self>();
         // INVARIANT: We just successfully allocated a page, so we now have ownership of the newly
         // allocated page. We transfer that ownership to the new `Page` object.
-        Ok(Self { page })
+        // SAFETY: According to invariant above ptr is valid.
+        Ok(unsafe { Owned::to_owned(ptr) })
     }
 
     /// Returns a raw pointer to the page.
     pub fn as_ptr(&self) -> *mut bindings::page {
-        self.page.as_ptr()
+        self.page.get()
     }
 
     /// Runs a piece of code with this page mapped to an address.
@@ -252,9 +259,9 @@ pub unsafe fn copy_from_user_slice_raw(
     }
 }
 
-impl Drop for Page {
-    fn drop(&mut self) {
+unsafe impl Ownable for Page {
+    unsafe fn ptr_drop(ptr: *mut Self) {
         // SAFETY: By the type invariants, we have ownership of the page and can free it.
-        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
+        unsafe { bindings::__free_pages(ptr.cast(), 0) };
     }
 }
-- 
2.43.0


