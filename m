Return-Path: <linux-kernel+bounces-274893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868D1947DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69081C203BC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23C916C6A6;
	Mon,  5 Aug 2024 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLVr7YbN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A415ECE1;
	Mon,  5 Aug 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871336; cv=none; b=mopOtEZLZ88armdKAkEdX0WyRaUBpAjONzPjoqD08P7+JlFv+7dZuv5WN5nRlTwMCuoXN73E219C2LvBeFthyFOcodlNaVXPXPGRfr1K46NLf9X4mVzak4VQxjsJPdmH+seQE8zGTA3z5WPEnBC5LU/S3K2M5/2m+BgTUt6NiN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871336; c=relaxed/simple;
	bh=ifLa6ui520OxD4tx6GpOL1mZtUOCjuqJJxFCxi3qo5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8BlABCq4YwEzyIXiJDOyLgQZzJyQlNE9mbAqhFXJpnQFCQuinR4r3SjOIZf7TsYVu8OyghPU+i2nP/jvvBtronXKEVxYPHPbKJJ9n8RdKzTLGXQUr7gZUKIYmlThLzfYYk2EuyVvXv2IfPXma3J45Rr402ilNSDTvZzFbWe4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLVr7YbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8DDCC32782;
	Mon,  5 Aug 2024 15:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871335;
	bh=ifLa6ui520OxD4tx6GpOL1mZtUOCjuqJJxFCxi3qo5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLVr7YbN264rVMq6UBxDkj9mLkDKu+lSnJRLG7ZDHjikHSZtClMvS0zahZgkPnYnC
	 8g//sl6JDeyuCBMEHtPPyasEONse+pNBUhjzv+LJcoYMBSaH/8Dz2uwMj08S1/d687
	 gpXy+kODqrOIBDERW7L+MmgNouc+BgymUOc1ddUgOKnaNmndK6eQWQCy5IrEvrpGOf
	 MAzoF3+bKOWT4uc1/CUC04cf119BepvY7K7jvxanIMQeDHIXUYk/iG+0TVUqUCE4mP
	 fXvjpu/uQPXoBJeF6GCTy4zLnn3y7+EvbMgnsFG8kA4WfqgKwTg1ujG6yKE4SKvFZw
	 kwgaUYAhHVjuw==
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
Subject: [PATCH v4 22/28] rust: error: use `core::alloc::LayoutError`
Date: Mon,  5 Aug 2024 17:19:41 +0200
Message-ID: <20240805152004.5039-23-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805152004.5039-1-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `core::alloc::LayoutError` instead of `alloc::alloc::LayoutError` in
preparation to get rid of Rust's alloc crate.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 145f5c397009..2d012cc3881a 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -6,7 +6,7 @@
 
 use crate::{alloc::AllocError, str::CStr};
 
-use alloc::alloc::LayoutError;
+use core::alloc::LayoutError;
 
 use core::fmt;
 use core::num::TryFromIntError;
-- 
2.45.2


