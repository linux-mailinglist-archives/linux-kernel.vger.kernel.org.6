Return-Path: <linux-kernel+bounces-270012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D229439F2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A630B227A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F331132103;
	Thu,  1 Aug 2024 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4TjSZqx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1D321A0B;
	Thu,  1 Aug 2024 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470845; cv=none; b=h7ccuN9dlibDWMqobKHrfH5IElQ6RitgrzKa0KopVxTOplf6QeGhdyuo1FFsL8U4SkNSmGwuhrltI4tj3cw2MMaYS4yhzdlpKM9C3aiqgxvtW9WzfuinRf7C/E/fmmVWqH993mhBeMe+Hy8M/fNuy7tBeqJyQZkfLldQKdcEL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470845; c=relaxed/simple;
	bh=GDa7Qic2Pqt1tK9CmgQPCpMbrxajNVkM/PqJ2bN2JNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiOpRxcV88umSm8xKlRWJjHu+JIrbw5LmlqBTRjoGB1+lB0gNZdpiMouWVteQ1P4xsNeZEB344DRM0nkyhFK7Wx4VFhvosPj0NtVHw3q7l04mEM2Nt0Rp6tbs1xHBwd2j6nUYV1XwKsyizaR92cVZ+Sj+tdYpjIX64K76jQ3cKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4TjSZqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EF5C116B1;
	Thu,  1 Aug 2024 00:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470845;
	bh=GDa7Qic2Pqt1tK9CmgQPCpMbrxajNVkM/PqJ2bN2JNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4TjSZqxqVmzLQvxNTJHLNg7/RlW2OXK4+0dwEJakt3RGW5505QubVI6Z6tVK46Uz
	 IdScThKwTlfahGAF8bxd2o8GA+NrGumvAObrRPSmouCsa+n3vJ87K0RceE6zbnWf1Y
	 jBHcbMPp906rAIQo4+rx0ETiriTvp3abqAFUTqoHz6W9yfIDSiB8wZ2Bcw9jrADOso
	 efQKlU64f3dnheWV1I4rIAf2eKyf/lJxXHMm+g+P2ojV8VqXKx9fB45uTohEkzHerF
	 WDfyIy7gid4U22Aif7zDvnDgluYy+G336U18jsq99ynxVJzxh4tt6QD82N/TQg0yJt
	 acLK8EXntm38w==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
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
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 06/25] rust: alloc: implement `Vmalloc` allocator
Date: Thu,  1 Aug 2024 02:02:05 +0200
Message-ID: <20240801000641.1882-7-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801000641.1882-1-dakr@kernel.org>
References: <20240801000641.1882-1-dakr@kernel.org>
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

All memory allocations made with `Vmalloc` end up in `vrealloc()`.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/helpers.c                      |  8 ++++++++
 rust/kernel/alloc/allocator.rs      | 24 ++++++++++++++++++++++++
 rust/kernel/alloc/allocator_test.rs |  1 +
 3 files changed, 33 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 92d3c03ae1bd..4c628986f0c9 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -33,6 +33,7 @@
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/vmalloc.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
@@ -200,6 +201,13 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_krealloc);
 
+void * __must_check __realloc_size(2)
+rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
+{
+	return vrealloc(p, size, flags);
+}
+EXPORT_SYMBOL_GPL(rust_helper_vrealloc);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 397ae5bcc043..e9a3d0694f41 100644
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
@@ -58,6 +64,10 @@ fn krealloc() -> Self {
         Self(bindings::krealloc)
     }
 
+    fn vrealloc() -> Self {
+        Self(bindings::vrealloc)
+    }
+
     // SAFETY: `call` has the exact same safety requirements as `Allocator::realloc`.
     unsafe fn call(
         &self,
@@ -136,6 +146,20 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
     }
 }
 
+unsafe impl Allocator for Vmalloc {
+    unsafe fn realloc(
+        ptr: Option<NonNull<u8>>,
+        layout: Layout,
+        flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        let realloc = ReallocFunc::vrealloc();
+
+        // SAFETY: If not `None`, `ptr` is guaranteed to point to valid memory, which was previously
+        // allocated with this `Allocator`.
+        unsafe { realloc.call(ptr, layout, flags) }
+    }
+}
+
 #[global_allocator]
 static ALLOCATOR: Kmalloc = Kmalloc;
 
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index 4785efc474a7..e7bf2982f68f 100644
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


