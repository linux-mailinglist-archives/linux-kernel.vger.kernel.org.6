Return-Path: <linux-kernel+bounces-350691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3274C990812
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33341F2494A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9801221E5C;
	Fri,  4 Oct 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/1oasy2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE41C729E;
	Fri,  4 Oct 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056659; cv=none; b=VX50kEfdkJJjhLO2atS9sXruNbtM1h7JR4XHu+/VGNBaNzmsv3DN44ROdsP4HI+7ZM9bZ3UrQedMZt8db2gauWlUJPrZyHMG2ZWpt5f2jkt9osxVi+ehndhASBxs95fNpGft3LlBTmr4TaOvLIFNp5YbCfICifDLjnggRdyMd3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056659; c=relaxed/simple;
	bh=ZDmHNLUIwFFHS+R3VBXXGD9KVgIi1Tkfsy4gCUrqKAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8E+2HdLSekv29pWFTSDfL48hUc3u09n/zdvhwqB/L9XZ4FleW2AoomdXecgGBpqyS1ZmLthF7kB+tOwaGbMl+0XffZM5S3VBuAY0Cy9L2ezyQE3DOowRxB+JJ/9QfSk6JfzypivFFHFoQQsRZFVc5unmpU1fSTKukWCgMd3Sps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/1oasy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F94C4CED0;
	Fri,  4 Oct 2024 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056657;
	bh=ZDmHNLUIwFFHS+R3VBXXGD9KVgIi1Tkfsy4gCUrqKAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/1oasy24Cg4tn73r5ay0ehOqtkvBqrOSpcYKK3cBYeqKnDuemnNCxap5ZpiTC1ky
	 8yY41UMuGwH4SHMAt8L9/bkl2mU0Ldiq36xAcZn9oRXdGrODP0ctZdz2E9s9RzL/As
	 ffZt9RiMcsOvJtoIM59/Dxhh3g2xGB37pDSiyRQnGsBXXL8ov+s4SBV8+gpxYUo0aE
	 I8sshYOkrsW+17NczK26zO1xu4nFjgyWR4HzbZCOm8vIG8kdCPsYnJ90J1n1p94kte
	 OAwnDbfF9i/+9HC+bSZBHW12/Tlw88mUSlnfcwluRSpKXQYq2sSEFyJke/ZCPEY6ra
	 1PuZUwr/XS+1w==
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
Subject: [PATCH v9 24/29] rust: alloc: implement `contains` for `Flags`
Date: Fri,  4 Oct 2024 17:41:28 +0200
Message-ID: <20241004154149.93856-25-dakr@kernel.org>
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


