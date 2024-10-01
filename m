Return-Path: <linux-kernel+bounces-346198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEB898C112
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A661F22BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528C51CDFD0;
	Tue,  1 Oct 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCAwFDG+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B71CDFCA;
	Tue,  1 Oct 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794930; cv=none; b=RyeNXzr4gV8oSqsmP8S5ZapdKL8iISZipbzQlEi6o3f8qM5M8rZ3rRs5BCerY4tYEt5LryykxcXzMiFi/UJsfSCBPqoIlG5RhVH+xJ+bnizz725cpXcgaoEbQRQDx/euy+sqChqlfx3cw2vVXLIS1KNUL/hyY0XvGhrWkMq8LCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794930; c=relaxed/simple;
	bh=ZNs0Dj/ExXP/FTdJ3MujwXiT4/A3eVE5pzPxpi0CaOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFfRx+ZLzXxnqIpchpls4ZZUc+mL6iR1KUSWd9yH2ReLEIDojZcOxQ+BEnOKovxI/0GR+w4+y7BN2hAzR18VcLpQd0w7BYQKqe76okM2dxZ1dYwrxo6Cv8r5RQg5YV65/6x9uLhQDDmJ3gs2hspngFFjUwZj6ANJ+olVK3FjwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCAwFDG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD63C4CECF;
	Tue,  1 Oct 2024 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794930;
	bh=ZNs0Dj/ExXP/FTdJ3MujwXiT4/A3eVE5pzPxpi0CaOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCAwFDG+HwF0qdWHedel5sJSUl1FWW7tqFalfSm0hqMw2bBfmu3u+6V3cH4/C4WZL
	 JErQKf4WUj+jDTKVznqwb+sqjnLwkieuky9Rn4ch1aRuadZcapj2Hg22Z70bLeP7Tx
	 YnKWItxw5aNY4RPBSmXkPdzqjjylTr1uiedInV6Ef5uNg16UU2/Et3REwUtK4L+nuo
	 wonyGbDahi8ZM+7wfIviQsGi1EraXFl6u5Y8izDxYSXfyywjf4tfLqv7kNlnZnMeZI
	 NsfyJxEGNT0PmS0sXODuurgMvJ2lujEqDKrkeUyCW/F9lh/nP4wa+UTGtpaFX26aeC
	 aD/Edjh/yuAWA==
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
Subject: [PATCH v8 21/29] rust: alloc: add `Vec` to prelude
Date: Tue,  1 Oct 2024 16:59:56 +0200
Message-ID: <20241001150008.183102-22-dakr@kernel.org>
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


