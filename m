Return-Path: <linux-kernel+bounces-283589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172BA94F6A0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 779B7B226FF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B801946CC;
	Mon, 12 Aug 2024 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5lNQLNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF31D194122;
	Mon, 12 Aug 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487075; cv=none; b=h8VvPWD3PncVkU8+e1JY3iPqevxCW/0IKxq/nrGBGRdvNUhtlAAXrZiwk33DJgNIw2dNYxYlm2X6QYNwMmSqgnqGBU6kkdlL/eAE63wv7spV8NiNqJJgdy2+sRSymrGSYbn+VW5mz6tx1dR+p/GJybnFbOp002Qn71DI6d90VGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487075; c=relaxed/simple;
	bh=qBBwndXchuTUBdgsnYPoDfZNxNBpxLvVcMvZVRMmc6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8eppr5zpFaR3tFjKecWtpLxzbf2aJHHxEsbE1+XF9NmlphjIWL0FoJogUPGzJg3RZUz+WzESl6hYLeQEztT5xzPCjvsU63Be8eELrnF4a7UZaIQEQAvfAl8pCa3sQGGh6+lyJNzh9rzCpmerDV8JW5lSoJYaK093qDdoRJI8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5lNQLNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370A7C4AF12;
	Mon, 12 Aug 2024 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487075;
	bh=qBBwndXchuTUBdgsnYPoDfZNxNBpxLvVcMvZVRMmc6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5lNQLNQYt0Ppd0yuQfm7lGeTmotnrWGIWreHjtdouOP5zlDu/8/lEW1TJFBFN/hs
	 62DOmFEz4VvqDZ+mYVc/8des9VGhvZBbhKuMl9lUNT76ZKWEHKiG+QfD7Zb0j6ea/e
	 aIa3mtkwEY/YoNKIxouC4NSrLYhRpyXdj2kZHOotMcS4y/TKI7JRKiEuUcmX5+0j8J
	 8ANlNtS+jIWN1IOkNw5Ajw4S3wij2VvAWr8CVuGFfiA3ueyEFcNhiiLgAHdeF4jhJW
	 CH3DBtylU1WYpSPJL2kmykV28Pue4pqbsXKFAoXIK0AjVfw6pC2Dk4KaVLd3FhTPlm
	 Ynb7j8zyApx7A==
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
Subject: [PATCH v5 05/26] rust: alloc: add module `allocator_test`
Date: Mon, 12 Aug 2024 20:22:51 +0200
Message-ID: <20240812182355.11641-6-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812182355.11641-1-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org>
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
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs                |  9 +++++++--
 rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/alloc/allocator_test.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index b732720cfb95..f0c80ab78602 100644
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
2.45.2


