Return-Path: <linux-kernel+bounces-283603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B0194F6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9C51F214F0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81352199E9E;
	Mon, 12 Aug 2024 18:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Auu0ERRR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440019412F;
	Mon, 12 Aug 2024 18:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487145; cv=none; b=KgV/QXcWyNQV8pS8q/z1u/ID0pl4ZqoFZ6FuDzcxPBXGCVNv+/lfTaw3xSUamIhJOJ0aCKsRfvfxH0OP0q8rMpSyacPRifacJWvbQ5NE6jjN8DEl1LGu9XuFsqi0A5qmercN8Dvkxwg5UkM0OFkmLF5qi5MXNvsrBAWkUOBMNVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487145; c=relaxed/simple;
	bh=vy8jMGyAXJW8mhTpujuxbveXx/4kmHcgFJLvoNpXzVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHZswqxPCz5r/UBSLvn+3M9qk71ClByFWUYxTaF5bT1bEkpHZJyz55qm2zkboPXqkeoyb+DSpE01gmdcmVnUp2W5iGGE0+FpRMX6Ima3ZcBRwlg+TuB11Stoi0bA2xkShvmYMmOCkRFrVgccY5vKGIKnowYKqsBbbII+GsNVpg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Auu0ERRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AB1C4AF14;
	Mon, 12 Aug 2024 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487145;
	bh=vy8jMGyAXJW8mhTpujuxbveXx/4kmHcgFJLvoNpXzVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Auu0ERRRl9iKXCUlp+SoDSPzRZnO6/enifkp7q/lRVDC359BYyHjhZIp3yRatrfYF
	 S3ccNm4tHObneYmnWQKVsryy2upOOW8E8rI+fkP9NEOVwlxld6DMJnxx8AOeygcl7V
	 +Q082Cm/kttOPG40J20BMGYsBqeouZsvblgAsois/QIOy/WXveFj3AhYFQAUHHobT3
	 r0SLJX91V7pQno0s86X7/UzrtBDTnvD9NZulQ9yqyVGlD2zoeGMT0kdTG8n6jaAgSd
	 tUHgiQ3e1KWZAAPB7UbIyMgBTSCmkGb4iyYgxsFJDcR663RNTI3JqDxrNYQ4EznMO+
	 b5v0rZ4k+hpOg==
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
Subject: [PATCH v5 18/26] rust: alloc: add `Vec` to prelude
Date: Mon, 12 Aug 2024 20:23:04 +0200
Message-ID: <20240812182355.11641-19-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812182355.11641-1-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org>
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
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/prelude.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index fcc8656fdb51..b049ab96202e 100644
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
2.45.2


