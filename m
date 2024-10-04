Return-Path: <linux-kernel+bounces-350688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BCF990892
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C470B2DDD9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F6A1E283E;
	Fri,  4 Oct 2024 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naxFRuUs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6F2216BF;
	Fri,  4 Oct 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056640; cv=none; b=YkgZoQbH5r1rJpI8TTdibbuEtTaFpc/cNBZMQ96V6+omz8rT90GUKfuhD5qu+zCCtk/93VmbD+0tv/zphRhY2ax7JBY1UKFF3hoAq/sGO/yIVl9hViCDtc7f1jlSl0vHSooSxR8kDy3Db/t1KCSSjgHg2vKBr27XRHgjVqGezjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056640; c=relaxed/simple;
	bh=ZNs0Dj/ExXP/FTdJ3MujwXiT4/A3eVE5pzPxpi0CaOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TX7jmIRKr/5mnrFrchdhkLXnxqG5TSBTSpYCRCLDN/MI8TCIHzbfVK/GU6fkEOvQzfx30dubUhnXRB/JlaLGaMbDuftpOOxLmkAeYAscZgRxuk0GpaLc32aJ5NV327Z27dX/nF+sc+pz2HbpqKHfeBLYwfAOr1tYegkM9t04A1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naxFRuUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12092C4CED4;
	Fri,  4 Oct 2024 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056640;
	bh=ZNs0Dj/ExXP/FTdJ3MujwXiT4/A3eVE5pzPxpi0CaOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naxFRuUsVrevYd57QkeZy71i1FomL2fbRGU99i6Eh4OdJhiBcD++cCd7C4lZZ6t6l
	 J13m9IC9seV1XcxefMzLNy6XnqX5JtRiasb1Lxflmkb359reiUagWZUxFke+M9Jhag
	 rITOiBJu/rhFJ+UBXkRFf4Jy900Sw2dU/yYly44Pgh1bm1fJ0h/fmvBTYHcIg69vA7
	 oCDZqjN6iNov7iYvNUiLF3rgYhcXkRdzrVLT3i0o2jI3oyohGXhXO5VzVo/Ggq+eCU
	 jdOl5SBpFNmasg7O04LxeChbme/vLh8PcoLmClEUB6EZwAvt1gI1+VeBQFe4prdEn/
	 GtHC+mUKMSV1A==
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
Subject: [PATCH v9 21/29] rust: alloc: add `Vec` to prelude
Date: Fri,  4 Oct 2024 17:41:25 +0200
Message-ID: <20241004154149.93856-22-dakr@kernel.org>
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

Now that we removed `VecExt` and the corresponding includes in
prelude.rs, add the new kernel `Vec` type instead.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/prelude.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index 07daccf6ca8e..8bdab9aa0d16 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec};
+pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
 
 #[doc(no_inline)]
 pub use macros::{module, pin_data, pinned_drop, vtable, Zeroable};
-- 
2.46.1


