Return-Path: <linux-kernel+bounces-288756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59DC953E34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85993B2609B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE5E129A74;
	Fri, 16 Aug 2024 00:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqXor/E+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE5F86131;
	Fri, 16 Aug 2024 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767256; cv=none; b=P2OsB1mzkABMEcGLtWjbXm6TMiHMPWZeX3IX7deuGdeDEcsHgVtpor1FBLaSFWvotMGbFxUafDoo08KwR18eZz4lZ4E+3KsR2/DNFaV6QTdfI1BGP3e+TBA2ayhRLcdcjzw8YpkRy0MpDjvrGknXw2t3deGh2hRBX6Jq1rkQ2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767256; c=relaxed/simple;
	bh=rW6cn/nXJ3kgyxI1gVJEu/DxMLK8/5Ne1MREjzDSSjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgOeAL5qi+Bj/FQh3PX/egzIyCk2RodsxiAK0SI+2ufIDEV3yrahAc7KAdChYx+GYrg0IoGTEqGW/ntUH83TmNs9TLjvAvI0SMydrWVLuGZ+48coLaTfupA5YiNp3m8b9Fkhdeqlf3Pf6yYObqlqZIRdddO+2EKQ2xcM3hMmTuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqXor/E+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4286C4AF11;
	Fri, 16 Aug 2024 00:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767256;
	bh=rW6cn/nXJ3kgyxI1gVJEu/DxMLK8/5Ne1MREjzDSSjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WqXor/E+3OtKDVZYS3a96f+AYYecETGqzOUglOaueHa5Vlw+FyhTOgesTNX8DXyYQ
	 feTxEQGGOMjBQtufSDQVIyINAeEt1RX7pEbrHHnkiO8RiwEe8dbS6mnGdfNWQ7XN2G
	 IUb7quUg4sTLPb4vtiLBghpLWRzbWoQhcmHtNF4CoCn8R9OYFU6PyF7Ik1E2/QCVWF
	 nql9dgriy61q8p4Xf3HT6uLmU+s5Xb+pXLQvqrUnRdrVqOBfcp43OqlXmD78rN08JS
	 Svgry7HwrJQxFFW/sX1tgfhx42X71TYl2tFL5OQE67jkSJdsODEa5ddF8COQrbcfg6
	 4xK7yVyVUgmsQ==
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
Subject: [PATCH v6 21/26] rust: alloc: implement `contains` for `Flags`
Date: Fri, 16 Aug 2024 02:11:03 +0200
Message-ID: <20240816001216.26575-22-dakr@kernel.org>
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

Provide a simple helper function to check whether given flags do
contain one or multiple other flags.

This is used by a subsequent patch implementing the Cmalloc `Allocator`
to check for __GFP_ZERO.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 1feabc817d00..5c66229a7542 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -34,7 +34,7 @@
 /// They can be combined with the operators `|`, `&`, and `!`.
 ///
 /// Values can be used from the [`flags`] module.
-#[derive(Clone, Copy)]
+#[derive(Clone, Copy, PartialEq)]
 pub struct Flags(u32);
 
 impl Flags {
@@ -42,6 +42,11 @@ impl Flags {
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
2.46.0


