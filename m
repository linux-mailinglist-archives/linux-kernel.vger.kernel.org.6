Return-Path: <linux-kernel+bounces-288740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34999953E22
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8987B26933
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B4335B5;
	Fri, 16 Aug 2024 00:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mptd4JKJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A12BB09;
	Fri, 16 Aug 2024 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767172; cv=none; b=FG+TjUARPXlpE+vEMvZA9dHDh8cigKdeIHgoRhZIRZW5l0jLb7meMZmdF2lvwNqiG7Y6D/3RxL4Oc03aWJ+lF0bBROd7OlpSAfuSpGRMEQM/bz/m0wWbMMk7iZ5xyilOUgUpVAZyLkMjD2PtVmHL8lCmNPWOte7YVbXcS2wPvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767172; c=relaxed/simple;
	bh=xS2F4hvF8mQiKszeCLTojdsU+ekVrYxlxLHbB2WYsV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqBkBDcZIHXhTp2RwZ2CeAGRPqg9NjMpFvm0I23q3URIKcn1kwjJZRn348fchsUdvnhf0IzwSDyaEFfb8v2Rv+lGlOQ3sP6mOdU5GteGJnB7jUBm1VJk8+PsmVi8McULTPluRR6Jg97yQ7OqxcFiP7UtIz7yLOLggbQqtIdxyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mptd4JKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F9EC4AF09;
	Fri, 16 Aug 2024 00:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767171;
	bh=xS2F4hvF8mQiKszeCLTojdsU+ekVrYxlxLHbB2WYsV8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mptd4JKJ0SXQrCoV8gnzgZkaEtUMDY/zq8KAdqLxmuHAr+VEXXfnxdn07L95hCM67
	 SWTm9DEjWk0wyzn0DbQqZl5Na9O0xmMlVfXgNkToVSCWEHS1EINnBk4LdgsAIKwa5q
	 BDVi5OFRjMsFLkqHYLpL+GSWXpkRTCtq0PtHFFmg8dIVl+VVwAJJ0abKIGiFzTSMN3
	 KGVHzEBANNSiKdAuP4Vpwj+rf6PycMC11jrBydPUox2Q77Fn2WNmU0ATOeSDqls5vr
	 DuFr1l/NjUXF4gUitfym1UN5IUlYiFYaU3JHjG0plvJYkIXzTV5K0roUB1hNS0/c3b
	 kgJza8BKjQlnQ==
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
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v6 05/26] rust: alloc: add module `allocator_test`
Date: Fri, 16 Aug 2024 02:10:47 +0200
Message-ID: <20240816001216.26575-6-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816001216.26575-1-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`Allocator`s, such as `Kmalloc`, will be used by e.g. `Box` and `Vec` in
subsequent patches, and hence this dependency propagates throughout the
whole kernel.

Add the `allocator_test` module that provides an empty implementation
for all `Allocator`s in the kernel, such that we don't break the
`rusttest` make target in subsequent patches.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs                |  9 +++++++--
 rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/alloc/allocator_test.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 477dbe3c5a2f..91a367a58f36 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -2,12 +2,17 @@
 
 //! Extensions to the [`alloc`] crate.
 
-#[cfg(not(test))]
-#[cfg(not(testlib))]
+#[cfg(not(any(test, testlib)))]
 pub mod allocator;
 pub mod box_ext;
 pub mod vec_ext;
 
+#[cfg(any(test, testlib))]
+pub mod allocator_test;
+
+#[cfg(any(test, testlib))]
+pub use self::allocator_test as allocator;
+
 /// Indicates an allocation error.
 #[derive(Copy, Clone, PartialEq, Eq, Debug)]
 pub struct AllocError;
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
new file mode 100644
index 000000000000..4785efc474a7
--- /dev/null
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#![allow(missing_docs)]
+
+use super::{AllocError, Allocator, Flags};
+use core::alloc::Layout;
+use core::ptr::NonNull;
+
+pub struct Kmalloc;
+
+unsafe impl Allocator for Kmalloc {
+    unsafe fn realloc(
+        _ptr: Option<NonNull<u8>>,
+        _layout: Layout,
+        _flags: Flags,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        panic!();
+    }
+}
-- 
2.46.0


