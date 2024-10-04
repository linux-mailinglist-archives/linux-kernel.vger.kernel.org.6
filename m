Return-Path: <linux-kernel+bounces-350674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D8A990801
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F461F2535F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7496D21BAFB;
	Fri,  4 Oct 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT8MltSI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20AB1C75EA;
	Fri,  4 Oct 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056563; cv=none; b=Vv12z4BfxbujBrTBMR7lW16L8W1vQLHlCgijW6em5scLrD8qXdwnjBROb5mof8/D7TWBUIrDhdfjPF1vBT6W12oiHVTqI+qwLySh7GH2NWRbaHZTjzXg9CXcpjKPOZzaDITGukV3rOWIEL8EMTCUEqrUuy5Pzp7nx5nK6jIHUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056563; c=relaxed/simple;
	bh=qlNC8elt2DUs+OwvKv1BnkmPQ4QqoPQad7Orfyq3Sws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiMUIKSvoDoi7KcSDB/dAl1J0xgHpz8VhcwMlmBGZ0P58lXzCzEj/lTCLoOJsvX3pOu6oalzX/Dw6M3bqVtCjoJPIwx0ckL62brSnXcfzKbMgVAdjOzrdaV9afqW6YWMCQDzfsvTDdovBO4U4yEAPce7AqItZGyKQNE80U/BWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT8MltSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCE4C4CEC7;
	Fri,  4 Oct 2024 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056563;
	bh=qlNC8elt2DUs+OwvKv1BnkmPQ4QqoPQad7Orfyq3Sws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RT8MltSIAOaKHQso1eT6Z3mUjfi5RIvInL1mxMQG2SL1evErcWA4qcx+604Orhc0L
	 KUqXykgrTTXpuWLEQAxwd3FKpElA8xCNwM/1ZapjJMEWlLcNT9oPJvY89Xk1XMyPky
	 Fak8WyV30MuRnMLZyWdMaMh9ivSoAujvNZ1VyuDQm40yXjm2BM6dAPJAryWCYSjc7o
	 D+OV1bXzZJm27Yox5GFTb45b2DsjWT/U64k4XrJvC4ATcbKOZKLfnY1H9RP8Fd5BVL
	 KQ4swMp90bxNA+VGWSmMkRnrqZG8QzStP40GSzB2CILS6gTbVkSnXcQPKjiYwpl9mk
	 b/VuM9UUxUjaw==
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
Subject: [PATCH v9 07/29] rust: alloc: add module `allocator_test`
Date: Fri,  4 Oct 2024 17:41:11 +0200
Message-ID: <20241004154149.93856-8-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004154149.93856-1-dakr@kernel.org>
References: <20241004154149.93856-1-dakr@kernel.org>
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
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs                |  9 +++++++--
 rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/alloc/allocator_test.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 91b2a26faf3d..f8ddc8d96da9 100644
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
2.46.1


