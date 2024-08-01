Return-Path: <linux-kernel+bounces-270037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1643943A7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCF11C21639
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560B914A60F;
	Thu,  1 Aug 2024 00:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc/eNROH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0A132139;
	Thu,  1 Aug 2024 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470944; cv=none; b=Xm1O3k8O0iTkb1mzsdYS5DDJznoCguQ7IJyuRxKx6kW7bIRJ2mM+5zd8ZG2W8StUt9yNOv8zoWyzkCSQ9iYFdYzlHxgwnXirAzHq8dtbrYsMUJLBMwODHe0Mp5qC+JGkqgBDgCeGU/UeXn7+hRLusO7mRhLUigiOOyBqkE5e0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470944; c=relaxed/simple;
	bh=ObSjAHQUm342t0TjAyXk2qDLNAOI/PmmwgaYCp3gBdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+UYf2uzcBXdTCkZbiJCZUaHvg5TqMsTtL7xA3FC9crDVvYmNMP53MMh/U2D8zAGQbSl/4S56PhkytxkZTXfBsYODvbu/RPv5DgJnAq3jaDecP//NvhPUug3XfdIS/PfTzrRsVNMPcCbcPnKcRxWdrOyhYucQqx8jFQ2X0Elhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc/eNROH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B979C4AF10;
	Thu,  1 Aug 2024 00:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470944;
	bh=ObSjAHQUm342t0TjAyXk2qDLNAOI/PmmwgaYCp3gBdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bc/eNROHFgcs4k7xegrUX2OWcpX/2DX3vk7FyysAzBfTl9dfX8ivWOFAve1/cjUra
	 oRImN5g1Yomayw/YQa+oYym8NBsywCwCNYuVIbpDLNrYrWbnHPLR7yBLYJP/g77vRH
	 E6fzi9GyzScU6dukXdLhtwwmLkmUbfQM062rfD0eDW8fMcVt2b/Sy5bX7q0YzBak79
	 Qm3xza4QFHUrUVxe28y87Th9cPmumEGN3fX+a8Fq2yLST/M5oJQP2CodML8uPSRHUY
	 HwNJ4AjfIVHyV0YI07wta8qyCJK9oHqeeXgCNYujyMGxwq1mhQ+dskrR8rNYuQqMU6
	 PazWlmANGc+OA==
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
Subject: [PATCH v3 24/25] rust: alloc: update module comment of alloc.rs
Date: Thu,  1 Aug 2024 02:02:23 +0200
Message-ID: <20240801000641.1882-25-dakr@kernel.org>
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

Before we remove Rust's alloc crate, rewrite the module comment in
alloc.rs to avoid a rustdoc warning.

Besides that, the module comment in alloc.rs isn't correct anymore,
we're no longer extending Rust's alloc crate.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index fac9d3976657..903e2ba33491 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! Extensions to the [`alloc`] crate.
+//! Implementation of the kernel's memory allocation infrastructure.
 
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
-- 
2.45.2


