Return-Path: <linux-kernel+bounces-350695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CB99081F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3E21F22607
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2403DAC12;
	Fri,  4 Oct 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HInwzaMg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371AF1E32B7;
	Fri,  4 Oct 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056674; cv=none; b=UacwhYrNNp+hroKcLwKLnNGtxq0APf8eE5U8Ac6Q8WZcouB227Eee1LOaHBSwNMbK6xekf845ANYlfdqW1hJbvVIRd7cSlXcg556Cko/RyK6kRqnVjS/U/GCdIv7T2Oul1qy4a7sbZYTSq65IalhKz7ladxGPglAQP1f61aHU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056674; c=relaxed/simple;
	bh=GR6bCjuYYHRgHCOsPDduyYPPq8CvkGfa1JPMMj7rInU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geWfZM0MtmNKj0AMbyO4nIF+cSLN6xSFF4norRdZXnKEEzokBiY6EKcTzlhJyNpaCiKCO1fyhDbbOkARx4F9Ciz3KbjgeZSwfb35krAIXtQLlpx16lsOYLtHy5UO7gey/NdU5alJWG32TL5qtlrK3Z1AdUsUZJ6590mSskKf/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HInwzaMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2632AC4CEC6;
	Fri,  4 Oct 2024 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056674;
	bh=GR6bCjuYYHRgHCOsPDduyYPPq8CvkGfa1JPMMj7rInU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HInwzaMg4J2W7s1jrkgNdeeywo/XEmyb9ionzx1z7DF543TSyLE5cmftSnOF4QSj+
	 6r9x5wDRez306psxF3BKCgCH96wCu1MU5YU4GygFh36+FmUef6U8xv+b9V0tcKM7Eu
	 OUpq6xZDzJz63Jili2hXOHV1eiGiWCy/G/aL4dTfnTmhn+Dcjx0ERts9kBPhDSQhNK
	 pOC1l7WQ3f1YFq6tblCtZQi82nJa3DCrdQDfXLlgx3MwcwdIbtfOJbyNYnGoNXnyKp
	 MGU5BspVs3/hpEf7o65ljYnzndSi7AIqY86E00RcksQQPufiCG9hhsJPdrbelIAMOA
	 EWy2hs58e3Cyg==
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
Subject: [PATCH v9 27/29] rust: alloc: update module comment of alloc.rs
Date: Fri,  4 Oct 2024 17:41:31 +0200
Message-ID: <20241004154149.93856-28-dakr@kernel.org>
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

Before we remove Rust's alloc crate, rewrite the module comment in
alloc.rs to avoid a rustdoc warning.

Besides that, the module comment in alloc.rs isn't correct anymore,
we're no longer extending Rust's alloc crate.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 8acaa24a8f1f..b4e65454e695 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! Extensions to the [`alloc`] crate.
+//! Implementation of the kernel's memory allocation infrastructure.
 
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
-- 
2.46.1


