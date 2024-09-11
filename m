Return-Path: <linux-kernel+bounces-325731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14978975D89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94B21F21473
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B51BC068;
	Wed, 11 Sep 2024 22:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeYNstig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DB21BD4F7;
	Wed, 11 Sep 2024 22:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095428; cv=none; b=Cp+IxKK6K9V5FEwJLQiufRE7Rcsi8h4qne/RhS5uWaAf4RjxM2GEm0UEJ2h/oqO10Q6Qs1UxtQVwduPEpIMzE7RJyvf6ya4azsuHermtY4OUKsUuDJ28gYPQvqgTp7pdHLjolR+utoViMF3pRJtQxd2lZy1wKbOb4JZ+A/KqC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095428; c=relaxed/simple;
	bh=CaTZ4LeQw3BXMae2HQHHYLspjHXmuSZPBFyX74iAlrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7IN5aT3BDUWDmfZ9KYC4lBfRWUTaZ2b7N26DoFMmYgafYDNmSTWTitnQ6b+Q0q+Ni8mm6f50HlVaSCdtJOE/35K/jedrg/ApmGmQTGs5f0hHPXNOIyWOc0GU1bSlBG0ywvfea8DxKuv+2jiKatdbQ16XlBoFjG5vG+JXFx9F2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeYNstig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB78BC4CED1;
	Wed, 11 Sep 2024 22:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095428;
	bh=CaTZ4LeQw3BXMae2HQHHYLspjHXmuSZPBFyX74iAlrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DeYNstigf7BHHg9d++A50T0ZQ9zMFq1waReAFW0v/ZrnJ+90tBwoD7PgbeF4thuof
	 i3XNPIjRBtijEIA0nxiwycvxCAugZs86jOqN5t4jRtqK45uk1x1PkYuBSAEQohW7cw
	 yVwCoOX1R2K7Iq435/pWkB1kT/wD12FV3Izg7eXiJj1rvy/enbnx8E+1YUlFUtt0xM
	 EIEP9Oa9Pn4YFtFrSgX6cYyzz9Z5MD8Un7y3ZU6BJFW/LHNOOezUSQle2eKhPka9sA
	 lgKCc9KYkGHqije8Fd5etGJJqlTEBy27G0XMcb1v9IGLRvgIA7uTazvfc5oDujnfWA
	 EBJlCGcUZC3BQ==
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
Subject: [PATCH v7 24/26] rust: alloc: update module comment of alloc.rs
Date: Thu, 12 Sep 2024 00:53:00 +0200
Message-ID: <20240911225449.152928-25-dakr@kernel.org>
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

Before we remove Rust's alloc crate, rewrite the module comment in
alloc.rs to avoid a rustdoc warning.

Besides that, the module comment in alloc.rs isn't correct anymore,
we're no longer extending Rust's alloc crate.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index caa0b9dfac87..2170b53acd0c 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! Extensions to the [`alloc`] crate.
+//! Implementation of the kernel's memory allocation infrastructure.
 
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
-- 
2.46.0


