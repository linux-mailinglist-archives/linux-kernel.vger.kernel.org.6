Return-Path: <linux-kernel+bounces-325713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE04A975D73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF2B22288
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8761BD4F8;
	Wed, 11 Sep 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPvCMXFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A9B1BC065;
	Wed, 11 Sep 2024 22:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095344; cv=none; b=SfdjO01GTlz5wHcxSPn3qS2tYDgZiacishBlayb1Nz0H2PTvMCRL+iFEvMfcMOjd0ErDpluOkRgdgVJBvulNividuLcWDlqY0665umyqd+bpD12CBPofnjRy9Q5OqVdM6JiRbBC2l0m1cahmQq1zOGDHJKyzgtY2X8GwTBUhoNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095344; c=relaxed/simple;
	bh=cw4d7ozoaPZp9ThW0IiXPabVi14FeEz+TkCXge43sLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBN1WfpRBljlzE5tVyWqXs6G2gmB0mSKXfY2CWwy1vsyZzYBM9TY9tu0ohqVnRoxPx1ADE8ZVsPahmAHTOOlePA9p0NBzMTSlR6PV2jN1a6awrFs0CTVAZQJNizo3kB2Vbnk2scy3qpvjYxMs0p6kEQhXLuBbahJo35HJ/4cNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPvCMXFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63D1C4CEC0;
	Wed, 11 Sep 2024 22:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095343;
	bh=cw4d7ozoaPZp9ThW0IiXPabVi14FeEz+TkCXge43sLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPvCMXFpIwzfoZbpxM2gjuVdmtZUL2+Yc6GhKLt//9t7CDDcaB8AgbIiSKcHmTb0C
	 x3EGE9ZzTqaLvqTvzVZYjvTAg13F3eEJnh3cJJEWio3yD+JN8s3DsYCmcMLD9Yc97W
	 A/GUrN62DQFaaEosXHom6aUqb6ujSOgzzIhn+XhM/km6w65C3We22AI9nBIBuXuu/5
	 L4MD9j0pviw9fbRrP/07HmRhI3G5Zllhkjf4P9q9vlqmXaWmXUuzLzM1PyTb8m68c9
	 3xPHmt7Mu/gEjvkGoVc4YPmFE+GRhsiPEmyJRhGJ6rKl7lsXMWukOy0DuYZ/aXCFf6
	 o5h4yzR932z0Q==
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
Subject: [PATCH v7 08/26] rust: alloc: add __GFP_NOWARN to `Flags`
Date: Thu, 12 Sep 2024 00:52:44 +0200
Message-ID: <20240911225449.152928-9-dakr@kernel.org>
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
index ae82e9c941af..a80783fcbe04 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -31,4 +31,5 @@ const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
 const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
 const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
+const gfp_t RUST_CONST_HELPER___GFP_NOWARN = ___GFP_NOWARN;
 const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL = BLK_FEAT_ROTATIONAL;
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index da025faf07f8..7a405d6f3034 100644
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


