Return-Path: <linux-kernel+bounces-260278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1137893A54D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48BB28187B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A09C159583;
	Tue, 23 Jul 2024 18:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baOAej1A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8F157E9F;
	Tue, 23 Jul 2024 18:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758287; cv=none; b=Y1etNrG7AstOkH8GOsfLuTPwZUJBHvWC6HNkcHTWOfAuV4xBQfVH9kBJoO9IXopn+1WfapOV+/tl/s85zlsPVXU7M6qHapGaReJN4UP+Izihfxczj5eYdHi5zQNcRBKZj1gv+McJKi97s/0otdzZfa6KB01Hiv56nx1Ho0a3AIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758287; c=relaxed/simple;
	bh=YaemE3GyNUw6k5SxqCko0qV/GMMCyuitkbWwSJz9u6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMqygJIOQ+EQVA5CvaMQklxPIAm+SeDxPotAAd/79PPomoMoj5tYTNEyigw1vNDGngGmHmljj+xlCZczsCYtAokNJO/lxrZfJrc61H7xJjTN2dtA+SnMs1wa6YiyacXuPXW9eWTjxSbOQfIXbnXhtXsZL7OvHTFTJIMVghRzSJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baOAej1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEB5C4AF11;
	Tue, 23 Jul 2024 18:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758287;
	bh=YaemE3GyNUw6k5SxqCko0qV/GMMCyuitkbWwSJz9u6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=baOAej1Au7/hHblUtzSZcJOHCZz7qZr12SRUNNlEDYgjYE8epT7uQ6Ol6uKD0vVle
	 7KTQvroSucEVwHrGu82BmmATVO34yILswc2nfJqeTGChptNBIA2IaOeaev9rzZjGsg
	 5meeIrkW+uA5ZeBIitR9pR/a4Y8ngqdWbvCYEcf4QU18vwY3kKTPbK8bMyNMke3u0Z
	 4h8SOfuWi3fpJrF8AO46vqQI0DbAHLPLmlZdTIpdjq4+hDc6KtS4WMcxrWRSzvknT3
	 S8FSd0onOAXFkJCFP9n4LqJ67ES+ojOTTatk9WwKYHOAzbWDV9DJzwkMfmXPBErcuD
	 b2mfW9M/rKnEQ==
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
Subject: [PATCH v2 06/23] rust: alloc: implement `Vmalloc` allocator
Date: Tue, 23 Jul 2024 20:09:55 +0200
Message-ID: <20240723181024.21168-7-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723181024.21168-1-dakr@kernel.org>
References: <20240723181024.21168-1-dakr@kernel.org>
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
index 3df5217fb2ff..5ca7e4872ee8 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -30,6 +30,7 @@
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/vmalloc.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
@@ -165,6 +166,13 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
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
index 3a0abe65491d..b2d7db492ba6 100644
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


