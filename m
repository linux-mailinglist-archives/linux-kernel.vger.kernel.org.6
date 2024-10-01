Return-Path: <linux-kernel+bounces-346201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B859E98C115
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2F81C20312
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF451CEE81;
	Tue,  1 Oct 2024 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGrDvkAu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B11CEAD7;
	Tue,  1 Oct 2024 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794946; cv=none; b=Ruj7H1lbvOWCyJ2XYP9tVIDktRjwJ7UyH9ktJbALEbPeKYtG5TD9C51DCBHGogrUEI969+l1CEXm7IXePzwpNUgmB4nT/11zeyg8WqNtun2LfjMzHeoH6UfWFoCkD/0EI+nGAhmzc8PfW3TcrazHSkqHCIQU3XhW+2K5BS5Wy38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794946; c=relaxed/simple;
	bh=ZDmHNLUIwFFHS+R3VBXXGD9KVgIi1Tkfsy4gCUrqKAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTrILAmdTBrtHFMB7x3xxM97Gln7oBTOK5FK8x56Vovv1rcmY7jdJfTglLhg9N84kqiQDwPiZK19biKbA6XEAecvGlfe30TGkDX6vQcBXbvFzTsq2YotEF81Uq3b9EnH1uQve0FJChKMWzN3jXJxGisbTN8Dmlx0YU3f69jBl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGrDvkAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6951AC4CED3;
	Tue,  1 Oct 2024 15:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794946;
	bh=ZDmHNLUIwFFHS+R3VBXXGD9KVgIi1Tkfsy4gCUrqKAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGrDvkAu7K7mNxFAaWK1ijXKGhH0O55fTL6tlWOoxx7u5L1OfHYlMSDQlcCwRNz+k
	 ZfFhTd9KDHWXs91qO5mF+JtxWNKdZ8HfZ2OODmexqa8PiZa5Vge98pHPs8N+YusiGC
	 j0W418/ImK15iFqWO/ljbxZ02FLdhJSWbxlF0ao15m7KngrJTcRpzeV30jPZKwBryb
	 3I649ueGfTvclLz2QjX5T0L0dIrCN8B2zh7DX6PQjSg6pHY1axCLT2MR/IUmpT/Xnx
	 EnGt8oLGcYhK0PX6UXV6hq6Ojfe1feUFvjHPV6Rfu+sLIWqe9FE5ToIRC3qH3vz98D
	 r9ucqKGDGPTfA==
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
Subject: [PATCH v8 24/29] rust: alloc: implement `contains` for `Flags`
Date: Tue,  1 Oct 2024 16:59:59 +0200
Message-ID: <20241001150008.183102-25-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001150008.183102-1-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a simple helper function to check whether given flags do
contain one or multiple other flags.

This is used by a subsequent patch implementing the Cmalloc `Allocator`
to check for __GFP_ZERO.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index e8955340fe62..8acaa24a8f1f 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -35,7 +35,7 @@
 /// They can be combined with the operators `|`, `&`, and `!`.
 ///
 /// Values can be used from the [`flags`] module.
-#[derive(Clone, Copy)]
+#[derive(Clone, Copy, PartialEq)]
 pub struct Flags(u32);
 
 impl Flags {
@@ -43,6 +43,11 @@ impl Flags {
     pub(crate) fn as_raw(self) -> u32 {
         self.0
     }
+
+    /// Check whether `flags` is contained in `self`.
+    pub fn contains(self, flags: Flags) -> bool {
+        (self & flags) == flags
+    }
 }
 
 impl core::ops::BitOr for Flags {
-- 
2.46.1


