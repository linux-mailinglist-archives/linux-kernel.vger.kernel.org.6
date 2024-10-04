Return-Path: <linux-kernel+bounces-350689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DB990811
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2451C20AD5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D84221E29;
	Fri,  4 Oct 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtrLQqOW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A741E2849;
	Fri,  4 Oct 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056646; cv=none; b=ghJcxqL25ypktUFFnnp3jKV8jfUTbIqHW4PMe/TZbFB0FRniP9PswHdxiaMdp04wd7SlxfgGlWZIYgI9VAV1TNpJJ6fjr+ALsop+kDv7Ot8BfQJZDIWMPf6MmmerHE43zFlzzr2GM25Mrsmq1kg4vF2amlk1XY1wYt/hAMmRSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056646; c=relaxed/simple;
	bh=qja4/b6sVnAwfQIKsU5lFy64XWyVYKZfs5Hg8rSPng8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gW3dM2FjQxvNczA/sVeITDAxNIdxNGsyuVOjYLLBwjwTUW45t/VF0YBd8TPkyJw9QPgJqM3Ix755VmWGrM4CDk/DISQ4qljVCpz4BXt41AakeGo2/VsYZg84IIFJi1U3sgxtqJyt2b1pj6XwqPA6/0A/5HK2638mSO2vL7riSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtrLQqOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD494C4CEC6;
	Fri,  4 Oct 2024 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056646;
	bh=qja4/b6sVnAwfQIKsU5lFy64XWyVYKZfs5Hg8rSPng8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtrLQqOWPhsua2MiiwHzfBRPtDZBUM4nukUln7OZcH+uO8VGfzl9qTUcUMQ8O8sHx
	 /ZQ5pQgnEhXA9wmaNudiiSJoWSZOzdV/+hTQzbtIStWz7jbFltFtR+/T8VpzqtMh4Z
	 7QdhrRnqgG6sQDDwPVnGcLPxpGi3oDjR3OJ7ZYZIt13f6QS5wu2uMEWRqKhPucUtZn
	 tRGYA0j1FyATkN+gUk6kfxXg9ZfLOHlGinUq2UQGUNDm6zqb9P5qFkgTvECWlClxXK
	 6Us3ipus/DIagEIP8Gb5Lx2uB2nRZSnjTNhIBJmwB/LNx8kmOFSUz7C5ONTyktziYJ
	 bX6v3bR1AVziA==
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
Subject: [PATCH v9 22/29] rust: error: use `core::alloc::LayoutError`
Date: Fri,  4 Oct 2024 17:41:26 +0200
Message-ID: <20241004154149.93856-23-dakr@kernel.org>
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

Use `core::alloc::LayoutError` instead of `alloc::alloc::LayoutError` in
preparation to get rid of Rust's alloc crate.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 2f1e4b783bfb..ca957bd262df 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -6,7 +6,7 @@
 
 use crate::{alloc::AllocError, str::CStr};
 
-use alloc::alloc::LayoutError;
+use core::alloc::LayoutError;
 
 use core::fmt;
 use core::num::TryFromIntError;
-- 
2.46.1


