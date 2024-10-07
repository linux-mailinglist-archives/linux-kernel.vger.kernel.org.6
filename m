Return-Path: <linux-kernel+bounces-354137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD3993839
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5401C22694
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113471DE89F;
	Mon,  7 Oct 2024 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do/rv40R"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96421DE4EE;
	Mon,  7 Oct 2024 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728332940; cv=none; b=I8gFvkwlIBL5wXfx0Zt0trFNJe52gGpEZIxIziTRd1vhOtK2lVaPJa9L6cAU0+xRzUe2D1Ncs5cNbve6Gx+CGB1EAGEQZhc4rKmVx8TBHAB1EfI+449cbtAJR/9m5dolCWDuaxCmky/BSoGqnbLymHfNKYoaNotGkSZmfAK+VYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728332940; c=relaxed/simple;
	bh=gJ2Qxjy1w9wuxyCpzZLUqrXhnTKbYH+/gphym/hbh88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DP59OS2wJ4vqt6RbbC+exk69T/E6+knSLL8LdR6qe4LxdXmnIkYJJM0rbhff8WE4RZt26Arc+ef3GMWauA0wY6HSNRJ2hE5TLuLvaOruBeHuGxzQ73Xi7FZMz7fSZpH12KJkXiMACdMhkwM+3TnHxh/WD6wilqyDniyzCBTZkLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do/rv40R; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad5024b8dso54878031fa.1;
        Mon, 07 Oct 2024 13:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728332937; x=1728937737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kdKhThPkvl5D7P4n2Yev3ZUX0T5s7hDFdgOCr//F4U=;
        b=Do/rv40ROUQDhze6XMBez3nBHtGkYyS6YqaPQ3SAquF0ccph+JanVjH3VZtvGFC2vM
         8z3XhogyDNFudwE1n+4IpGp23CGAuJJ3A2uevDKCoA2bYeDGRDFZqdE2mjzZYADIo9R+
         a7yJuJt967GlfvmLb3KKMoNCjv1t3LRCNj+GI7xCODtGm0aXdHQdnuB50PSH+8gFmdvS
         HljA0/lxr/DjiV6w6Gn4li1eklQg75CYALAJkAb5Yx280g3LepoBVipZOO6FqEPAqDHG
         aGzfHRvOW26R+CHL8VX4wOFAv29q0jZSN/cgqP1PFbET78tMtgoVcWPLcbuuU/qHh8GX
         qbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728332937; x=1728937737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kdKhThPkvl5D7P4n2Yev3ZUX0T5s7hDFdgOCr//F4U=;
        b=uLw/H7RXIqx3tqmPQ8zpjWV67O9o9GsTqFHRa20JCh6oa/AcAVuPkXVXFWajJDd0jt
         LFv5DkGV+LS47IwAyC3ZoAoBdUwEqvN5aibGCUBkwt6Ns+cecfR7SzA75Iqs6mpc754e
         suYV3FwxM7jeBKxNnBX9/ZUXhtWYJibWY0LcNZ4q2hC7X025fLAfxRTkUPPTT8zfstq5
         LFZkjO0GBOX+3lRruAZwN+jZUbDZNpRBHnJmPUFW1waQCAxAeUwQ7kqqjomUQ0Pkp8Ec
         UmK3HESTuWtcOVXokvem5J4R9dWJkVxhd6+HhbZcO+funcLbEJhk1kekl4jizll8LzoO
         YjdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVglnlEmSIlVTYdTXWLbsATvxWFVsOCU8AKTm+GYc01agrAEqAgSFvW4IkZIRA28jvAe9SwLreLtKsXMTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRK1AYOU87NjV4S6mJ6fkVDNnvg6VVJiKFwZsDfniruCbcWfHW
	1xFVTNvTHMWEhjPWRf6y292FkUJ+QMLOZ4l21s6xB/iAbCNBXhAd01b07dRr
X-Google-Smtp-Source: AGHT+IFZ53gz0q0anPI6DKX6GDiCmWDki69ah45yTFu3BaGMhT5zdbq29ZC3y9hVjVCcSSNBefsBxQ==
X-Received: by 2002:a05:6512:2203:b0:536:553f:3eed with SMTP id 2adb3069b0e04-539ab858939mr5735306e87.23.1728332936495;
        Mon, 07 Oct 2024 13:28:56 -0700 (PDT)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff23307sm926237e87.197.2024.10.07.13.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:28:55 -0700 (PDT)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org,
	aliceryhl@google.com
Cc: dakr@redhat.com,
	linux-kernel@vger.kernel.org,
	lyude@redhat.com,
	airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com,
	boqun.feng@gmail.com
Subject: [PATCH 1/3] rust: page: replace the page pointer wrapper with Opaque
Date: Mon,  7 Oct 2024 23:27:50 +0300
Message-Id: <20241007202752.3096472-2-abdiel.janulgue@gmail.com>
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

Replace NonNull with Opaque to make it possible to cast to a Page pointer
from a raw struct page pointer.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/kernel/page.rs | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 208a006d587c..08ff09a25223 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -8,8 +8,9 @@
     error::code::*,
     error::Result,
     uaccess::UserSliceReader,
+    types::Opaque,
 };
-use core::ptr::{self, NonNull};
+use core::ptr::{self};
 
 /// A bitwise shift for the page size.
 pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
@@ -25,8 +26,9 @@
 /// # Invariants
 ///
 /// The pointer is valid, and has ownership over the page.
+#[repr(transparent)]
 pub struct Page {
-    page: NonNull<bindings::page>,
+    page: Opaque<bindings::page>,
 }
 
 // SAFETY: Pages have no logic that relies on them staying on a given thread, so moving them across
@@ -65,15 +67,20 @@ pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
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
+        Ok(unsafe { ptr::read(ptr) })
     }
 
     /// Returns a raw pointer to the page.
     pub fn as_ptr(&self) -> *mut bindings::page {
-        self.page.as_ptr()
+        self.page.get()
     }
 
     /// Runs a piece of code with this page mapped to an address.
@@ -245,6 +252,6 @@ pub unsafe fn copy_from_user_slice_raw(
 impl Drop for Page {
     fn drop(&mut self) {
         // SAFETY: By the type invariants, we have ownership of the page and can free it.
-        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
+        unsafe { bindings::__free_pages(self.page.get(), 0) };
     }
 }
-- 
2.34.1


