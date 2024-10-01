Return-Path: <linux-kernel+bounces-346204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E77098C11B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4602817CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815081C9DD8;
	Tue,  1 Oct 2024 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiY4Oaov"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7C01CF2A4;
	Tue,  1 Oct 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794962; cv=none; b=D523jWj+SRBUO+2qWBaY87ITJWB2IoCSipZf80GnjFpiWKpdb5LTLzm5XUlG6UfV0vhAwdcTg3Crbhk356zmN0h7Qj90bJ0f5w6nt56pJUHJkU55Wc/MccvYxwyhVwcGMemua57hjDYp/Urtw4LR0zUw4o3D8GKMI4lMa9ingS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794962; c=relaxed/simple;
	bh=GR6bCjuYYHRgHCOsPDduyYPPq8CvkGfa1JPMMj7rInU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmwOsrnM5DxEy9Ym2KMUh82eIhRwU8J9LMNlwVyuPNwNFJ+yNNtPHkWenZ+IMBB/FwwUnR0TguNeWn4nfTuD2tH77X2ab5ObAjEo+HX8dzUpqYWg/IB/yxC1YaB+rZk5QjrLvFxfLuU9ADxl3JE5F6Lpvm4tDFE+6cw0/m3MTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiY4Oaov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797E0C4CED2;
	Tue,  1 Oct 2024 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794962;
	bh=GR6bCjuYYHRgHCOsPDduyYPPq8CvkGfa1JPMMj7rInU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiY4OaovolUIHId/CXZBG0mQjFVvQQSFisqfSuxUkQ+pN72OVWhKoCUGsyYc7eWjQ
	 fMjOsCDz64SUKC49XOzYlAlqlaq9i60haj+28VfMnRZFE3pLjRL//NlfzaO+QrnpE5
	 2JYP7EWnlBFn2jIJQ4PCXxFlGGFUIJT8zckMtKty5wH/Tcyk0LqzclUt4j1O7DRN3p
	 oGGPbiWCWdVFXIuo06u9dWeBTqlNeEjkfyzmGEtAZv/JFP6S0zufuKo/KAj7O85ZjL
	 j+j0srmtkCgDk/w+wE9D+/lP4XJN2dMBCqPF0lSjHZ9FEku65xjRhMeIatGqPuXP0r
	 6YQ5YuzdJwIvg==
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
Subject: [PATCH v8 27/29] rust: alloc: update module comment of alloc.rs
Date: Tue,  1 Oct 2024 17:00:02 +0200
Message-ID: <20241001150008.183102-28-dakr@kernel.org>
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


