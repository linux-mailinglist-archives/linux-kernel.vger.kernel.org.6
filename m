Return-Path: <linux-kernel+bounces-270011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B159439EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FCAB21FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086811E4AE;
	Thu,  1 Aug 2024 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnbk/8bq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E861311A7;
	Thu,  1 Aug 2024 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470840; cv=none; b=fdAFLpb+0fKS80jXXTjmJ+QZtOHbg8ynfzvhgrx0nUjt9NSgyFl8aL0EVTM9evLO2A9WCG9PDKKoqL+idmAMU8emxFzFONmzZAAFJ3N3jyyrbYwE3hhB+qiAUvs7DbV/dgXCNbi8Mu+m7tnFlueahflEXxxH00RgtBoHN2CFVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470840; c=relaxed/simple;
	bh=NhoXQc/3NsMmnAPcZ6sxE5qBH2rG1UwJKGQPjBzD4UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YyGtTA4FiUFNxsxSreWoUxc/9337uV4dvXfZ/h1d48cwDXT3SmISq9E6GOGB0SQOeCrsWtnAPFhLT7B2PXYw0qSuQZukIvZ+ZS3vTSVsMXAGNn07XxVLjvq6SUo7/Jc5L7GQ8+M/y0hG/EF1oCKE/3FOETKy1q1Bm/BtfLA3iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qnbk/8bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8539C4AF0F;
	Thu,  1 Aug 2024 00:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470839;
	bh=NhoXQc/3NsMmnAPcZ6sxE5qBH2rG1UwJKGQPjBzD4UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qnbk/8bqEz+f7vIQkgZF3ii1t/44Pt0IyVAeduPEsyw15aUBIunIRCTOcLkj/4tFg
	 UioDGgVy1iZi90grH4zYgsok1EQjaBYAXqmCCK9fo83geupijgvjO384a+8MtpK4B0
	 gWUo5nulw0azUB6RH4NohTHVjRW+jR/6peGuZQUJM2+JCvHGfY8MR481XpDvXig6IZ
	 Bm1J547kzWyUWiGfNhfol3gYMjEEcEdIe1qajTqXxvZcKwigeC3EDtuuawQYo1g29M
	 E1p6il6mkzvIMyqZ9qRtLlAhB8SkvbsxdpfK1nUo8WEtoY8NkbXIEM9y8C8guyxzhY
	 rPB3gdike6Apw==
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
Subject: [PATCH v3 05/25] rust: alloc: add module `allocator_test`
Date: Thu,  1 Aug 2024 02:02:04 +0200
Message-ID: <20240801000641.1882-6-dakr@kernel.org>
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

`Allocator`s, such as `Kmalloc`, will be used by e.g. `Box` and `Vec` in
subsequent patches, and hence this dependency propagates throughout the
whole kernel.

Add the `allocator_test` module that provides an empty implementation
for all `Allocator`s in the kernel, such that we don't break the
`rusttest` make target in subsequent patches.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs                |  9 +++++++--
 rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/alloc/allocator_test.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 8cabc888393b..90f4452b146a 100644
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


