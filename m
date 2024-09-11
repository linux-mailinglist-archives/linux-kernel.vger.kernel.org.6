Return-Path: <linux-kernel+bounces-325728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3195D975D86
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC26282912
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A6E1C0DE0;
	Wed, 11 Sep 2024 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnKBHrnc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1B1B6551;
	Wed, 11 Sep 2024 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095412; cv=none; b=ae7SBfQNZuxQjwd7RwDwJqBajaojz775+Q/1scvDbDs7skXjgec1CqriZPxyNYzNEmWHBJC4DlMYnXg909ADsdbjhkJ9Lm+JauceSOMi6YV2QgpYLRxidp4AxJLQHvbQZetS+0C+z2t+HZURaU/GI5P0A5P5onvZElKHldbd0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095412; c=relaxed/simple;
	bh=BuRbAjKmy40vmT3N1pF21OHcKiAzSp8OEnKFLe420pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvF7iRUM6QCeKri6x5sNHV2DTTyhPVoUwp1qYi5Ll/PdGaU4C6NqHrVNtvb+f1MEdNHMFIiEL4E9eL07T+FwuBEbpYNfw7kt/CjVYdpwDHbaqI+R39xGvgwWLVMM5o5tAbz3itpAyJ+ouKAVL+hjm1XJ6Kmmvr+hLJGER+0PW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnKBHrnc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4980C4CEC5;
	Wed, 11 Sep 2024 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095412;
	bh=BuRbAjKmy40vmT3N1pF21OHcKiAzSp8OEnKFLe420pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnKBHrncLFslJd6q/nHuhtzqz1+1TBPq4XFiNkHyvx2teZQ09/rGvMq0rkZmjaUBQ
	 Lbl4cpf4vZTYynneRL3vdFi1Bfzk//roOP+ergED0hIoIvTi45n+mq3kqjXJBmtOIE
	 2TUOfgMT/w6x7qTIrzC8BUSB0AsHIbayljpcYeLVt29Kz+Z5MdCntUZpOmeys+BJf/
	 +U0AYlUBKLQjbjODoG/ESll0BCXm0zsGtMDWqGWYJ0vhDiGDgL7bZP03DwWiqctj4+
	 qO7e62LiIaAdh3IGXN1jfezc0FpgcGxB/ZoBVQ43AZLRbGXi/3TLRnAl1HraDUiSRM
	 p61kKYP/nDxBg==
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
Subject: [PATCH v7 21/26] rust: alloc: implement `contains` for `Flags`
Date: Thu, 12 Sep 2024 00:52:57 +0200
Message-ID: <20240911225449.152928-22-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911225449.152928-1-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
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
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index aabdf80e4f7b..caa0b9dfac87 100644
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


