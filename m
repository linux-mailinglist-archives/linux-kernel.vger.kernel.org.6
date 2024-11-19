Return-Path: <linux-kernel+bounces-414210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D55E39D24BE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960EC2814C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDFB1C7612;
	Tue, 19 Nov 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6IgJbgM"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81DB1C68BD;
	Tue, 19 Nov 2024 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015483; cv=none; b=p7VZWTGnUEZg+RC/cZf2Ur44mlkHmBWbLFvz2uO4QVES3QMXz8xYYlpjuu+fDkzGdqaocrCr24yJXpLY/J+TvY7DT7kVHzRIDulDMostsvCaf1GexX59m0uocsCqtBInZyOnDUaL8MWcTPlFfoB+ph7pPUX2580+Gz4ezCIxa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015483; c=relaxed/simple;
	bh=snTqUG7s09jGXe3ajPlD0Twq9dDrU08jBXd87FsFqM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uO0uEUEHYJUC4qc9dehx8uHbrTJ+z9JcuN8BEad2qrsOVfN9jZr4qJfnayF6VKzz0clWML20n4k5jycU6vwce9G932jzS+2EZyjDlrJ7ISWaxaTFUIxJtZ54WbUPYVH41rJeIUhjOGHSJzPZDFcnrR3LorwSz46WVzcXAoZ/Yew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6IgJbgM; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53da4fd084dso5385867e87.0;
        Tue, 19 Nov 2024 03:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732015480; x=1732620280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5in6My0kdNSS1puRd/yLqubLQBCE2d2SsFq7ndctiY=;
        b=Y6IgJbgMAT/pt5vzlWqqJ1CmPw2dNfeozYPvmzF/CSZdZZhV/UfHpTXTE8rfEg5TOC
         EtvsiwYL2yE1gfYWpmXlFjDBEkk5jN6nmgwRgebv9Zu/wfIL73pNt1DREZVJI8HGgYFp
         MGl2WLzyDf9jaYqnp8qYQkaO/odRtc7Wwnjfs0vf+6Vj//K4rBRtxbZNjRaJBNFhzWlB
         +mHFEgMe1cM1gCy6+uuZcdtkDsY7+7uMiImqaGbqVMtdSEl1fUo+cMjLkMipoedQrbQw
         Hit+Smvz5Al5u1MZ1ph9RbmsWhVzKp15oiYiwgtgpcIWHVWQAhHK0hLbAHE3mx5Qk6nd
         XJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732015480; x=1732620280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5in6My0kdNSS1puRd/yLqubLQBCE2d2SsFq7ndctiY=;
        b=j6gvhpkje+N4qaRkODRXPVbU67JlkgHtmiyjTlZWrro9oAWhHZ078v0U493XoNb9Vt
         IjBKgF68ypF7acopgq3tfcC53O/ZGGNn0JBd2blFPeCbrrdObAqPWABlQxFzzOFIikB+
         lV4j2K8Zq5NWlLLqsGPiUZKbkK6SvKfYc2PQiVtk60hO6pT9MuvsShDX22iPplgi730V
         /T6aA5UO7QzDannQmgJLpuQIHP0YyB4i/fteN+VorXt41Jsg6qmALJyUrTznXWiWzNW7
         McRkR3GSGSK+6vNcuoIvGVbDyW791QHH37fKhiLpX+wWZqx5UhEX0ZcnRQ/XncP/5aFd
         k7UA==
X-Forwarded-Encrypted: i=1; AJvYcCV7iSEO83z2SqePPGlRxDV0gu3+sqmHq93qLmDa1IrXkjljqwdeqv/VkAZ+7HV10vKufezxhaNpw0RKn+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsvAqf/Iur7+ylAZ9R0Z0fM4aDzZdOLWYumta4sMauYDJFjfDf
	p2iqmJxQqNnfry8ZB/CpISHZ4PCF1jrdRUfHWN6udR1Ml8WlZibnFxClIQ==
X-Google-Smtp-Source: AGHT+IEKjqLZdyXdfGQjRw6AYYj6v+Q15TvM5GNLUQ+CaJiPip4JE/yx1g/kjPZdw+FLybza4MV/MQ==
X-Received: by 2002:a19:8c05:0:b0:53d:abc4:820f with SMTP id 2adb3069b0e04-53dbd47128bmr779557e87.6.1732015479658;
        Tue, 19 Nov 2024 03:24:39 -0800 (PST)
Received: from abj-NUC9VXQNX.. (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd478279sm271899e87.232.2024.11.19.03.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:24:38 -0800 (PST)
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	linux-kernel@vger.kernel.org (open list),
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
	airlied@redhat.com,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>
Subject: [PATCH v3 1/2] rust: page: use the page's reference count to decide when to free the allocation
Date: Tue, 19 Nov 2024 13:24:02 +0200
Message-ID: <20241119112408.779243-2-abdiel.janulgue@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure pages returned by the constructor are always reference counted.
This requires that we replace the page pointer wrapper with Opaque instead
of NonNull to make it possible to cast to a Page pointer from a raw struct
page pointer which is needed to create an ARef instance.

Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/page.c             | 10 +++++++++
 rust/kernel/page.rs             | 38 ++++++++++++++++++++++-----------
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index a80783fcbe04..daa3225a185f 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/firmware.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
+#include <linux/mm.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
diff --git a/rust/helpers/page.c b/rust/helpers/page.c
index b3f2b8fbf87f..48d4481c1e33 100644
--- a/rust/helpers/page.c
+++ b/rust/helpers/page.c
@@ -17,3 +17,13 @@ void rust_helper_kunmap_local(const void *addr)
 {
 	kunmap_local(addr);
 }
+
+void rust_helper_put_page(struct page *page)
+{
+	put_page(page);
+}
+
+void rust_helper_get_page(struct page *page)
+{
+	get_page(page);
+}
diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index fdac6c375fe4..fdf7ee203597 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -8,6 +8,7 @@
     error::code::*,
     error::Result,
     uaccess::UserSliceReader,
+    types::{Opaque, ARef},
 };
 use core::ptr::{self, NonNull};
 
@@ -30,13 +31,14 @@ pub const fn page_align(addr: usize) -> usize {
     (addr + (PAGE_SIZE - 1)) & PAGE_MASK
 }
 
-/// A pointer to a page that owns the page allocation.
+/// A pointer to a reference-counted page.
 ///
 /// # Invariants
 ///
-/// The pointer is valid, and has ownership over the page.
+/// The pointer is valid.
+#[repr(transparent)]
 pub struct Page {
-    page: NonNull<bindings::page>,
+    page: Opaque<bindings::page>,
 }
 
 // SAFETY: Pages have no logic that relies on them staying on a given thread, so moving them across
@@ -71,19 +73,23 @@ impl Page {
     /// let page = Page::alloc_page(GFP_KERNEL | __GFP_ZERO)?;
     /// # Ok(()) }
     /// ```
-    pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
+    pub fn alloc_page(flags: Flags) -> Result<ARef<Self>, AllocError> {
         // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
         // is always safe to call this method.
         let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
-        let page = NonNull::new(page).ok_or(AllocError)?;
-        // INVARIANT: We just successfully allocated a page, so we now have ownership of the newly
-        // allocated page. We transfer that ownership to the new `Page` object.
-        Ok(Self { page })
+        if page.is_null() {
+            return Err(AllocError);
+        }
+        // CAST: Self` is a `repr(transparent)` wrapper around `bindings::page`.
+        let ptr = page.cast::<Self>();
+        // INVARIANT: We just successfully allocated a page, ptr points to the new `Page` object.
+        // SAFETY: According to invariant above ptr is valid.
+        Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(ptr)) })
     }
 
     /// Returns a raw pointer to the page.
     pub fn as_ptr(&self) -> *mut bindings::page {
-        self.page.as_ptr()
+        self.page.get()
     }
 
     /// Runs a piece of code with this page mapped to an address.
@@ -252,9 +258,15 @@ pub unsafe fn copy_from_user_slice_raw(
     }
 }
 
-impl Drop for Page {
-    fn drop(&mut self) {
-        // SAFETY: By the type invariants, we have ownership of the page and can free it.
-        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
+// SAFETY: Instances of `Page` are always reference-counted.
+unsafe impl crate::types::AlwaysRefCounted for Page {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
+        unsafe { bindings::get_page(self.as_ptr()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::put_page(obj.cast().as_ptr()) }
     }
 }
-- 
2.43.0


