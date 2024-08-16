Return-Path: <linux-kernel+bounces-288743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1E2953E25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF821F22256
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5114653363;
	Fri, 16 Aug 2024 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEO7hcjA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA74AED1;
	Fri, 16 Aug 2024 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767187; cv=none; b=T+1cs3bwoggDOxPhGSH64mjrPyQJJaAiqgHCxNRFrhEOVbuS/0x+uEzCSCdN14gQNovLlLaouI+0y7iNosfwrL3SBwXuIfMBNhkui+WIsQ0QJQdldJdXioMfrnoCbGa0uDKiiAWaNtfeEhIvJfS96dAQWMm9E7BLHX+c2zi4Xmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767187; c=relaxed/simple;
	bh=+Q2tfhai1Eb3pcjdgIQSFOSo90TRqwwdVLlFVhO/a9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npkIikhi3a059IgD09kIJ7b58/fUco912bZPNdcNnEyneiRfikcnbSnJeVm59SMSFxkPV0d6X1sNwW5OiDu7CFND6gRnaC5pzCVJ+p0jQ5fDJ2t25Nd37G5qR4WWRJwB7ZdzbsLgPfjYKBmuDRGVP8SgjM9IvPPnbqaq4Nfq24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEO7hcjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983CDC32786;
	Fri, 16 Aug 2024 00:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767187;
	bh=+Q2tfhai1Eb3pcjdgIQSFOSo90TRqwwdVLlFVhO/a9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEO7hcjAZYf/irob5D8Xw7gx/QKeDkU6wXpp9wkrJJsPCfb9CjhnaFsZ5HNsBgSDE
	 irKx2T7ipVZQrSJqixDZslXSvkuJz0aXVX7zN/9ex7LjN3/siJjE0uNCThMuBNPlLg
	 BcKzkZBkEM20+7krNm2Vg4Befyih+8/cnV1r0nT/+bIfvzyiPA6hAjeK9jHds0Qxq4
	 KZOvf7wrDkmxjBx1HjqZd9GTUKy72/AiJzmuGJogJjUvUQQF+Tap3uTQDP0sfCNJKv
	 K6jmZhLMqiHZv2JTAz6oo3AxoE70dkyO7U9B/32lJJJz2WAIZNGlnuIsLNOecf2QO2
	 o8IKcWJdImKlw==
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
Subject: [PATCH v6 08/26] rust: alloc: add __GFP_NOWARN to `Flags`
Date: Fri, 16 Aug 2024 02:10:50 +0200
Message-ID: <20240816001216.26575-9-dakr@kernel.org>
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

Some test cases in subsequent patches provoke allocation failures. Add
`__GFP_NOWARN` to enable test cases to silence unpleasant warnings.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/bindings/bindings_helper.h | 1 +
 rust/kernel/alloc.rs            | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index b5793142904d..90493123bdf1 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -37,4 +37,5 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
 const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
+const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 91a367a58f36..53a93617a9f6 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -91,6 +91,11 @@ pub mod flags {
     /// use any filesystem callback.  It is very likely to fail to allocate memory, even for very
     /// small allocations.
     pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
+
+    /// Suppresses allocation failure reports.
+    ///
+    /// This is normally or'd with other flags.
+    pub const __GFP_NOWARN: Flags = Flags(bindings::__GFP_NOWARN);
 }
 
 /// The kernel's [`Allocator`] trait.
-- 
2.46.0


