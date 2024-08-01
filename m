Return-Path: <linux-kernel+bounces-270029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEEF943A54
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDF0281ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7271422D0;
	Thu,  1 Aug 2024 00:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwGLMjQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6683728373;
	Thu,  1 Aug 2024 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470922; cv=none; b=sEStxAiMOZnJkJb/HX1n5saKXFUygMGy5jdl1K8+crgXDKBCAYw+n5AwQMZtxsmjV5rsJ0rCLO1hht4uMD1A05M4J+MQNg9v46tOq2/WItEyWUb4elV2lR0XkR2yuRcsy/mThvVCTDkzjNQfUaiFI/nr++Kqf+iLeDipOrtqJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470922; c=relaxed/simple;
	bh=x0JvvRfi87BBCBI94b39MtnQOfc5sS9njBcl08nLwWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX37J3hL5a/Cmc2AWLU3JxMAdvP/YYTiuDyvHHdtQqxLdZTjoyiFjFrLKLAEwxKH4ECrM9GBm8Q3k2p8VlP8DormpET84xImmF3+ouEpNuRxxL4xV/uZ4rarS+31yKASOatNU4Ivlo7lEmB/cnWJskn3ZWjXE3qktn3sFO5LZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwGLMjQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE73C4AF0C;
	Thu,  1 Aug 2024 00:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470922;
	bh=x0JvvRfi87BBCBI94b39MtnQOfc5sS9njBcl08nLwWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwGLMjQ5O1RqCMU95r74D1I+1i4C2i/6B4l3UPVvQRz/2DEFPmAhuDzrdF1g4mbXC
	 IX4i4Cz1YT7NLKQ5R8xfrwTssfFtC+w0hi0LhTtf+IrUromujAPVnw1USOJeyPZ9Tg
	 6RhiksAY77LVOu5xR4LWDNL7eVQxbbbBeyD5vIA6h4xRjKkcIFkIUyOEQJf33PGUvu
	 XZjNCF9isBwE2ZQ9c/bkdKTK0CNCsZUin43wkg7Twglu7+Pt1V2IzrWwJAwSxeRQSk
	 rHAu9H10VJkPqd1VGowv3LuZPHigi9QyXCcMfZA8I3qcLVNHakZEWXiHPWuUnjqVNI
	 mPdaApxLLfZSg==
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
Subject: [PATCH v3 20/25] rust: alloc: add `Vec` to prelude
Date: Thu,  1 Aug 2024 02:02:19 +0200
Message-ID: <20240801000641.1882-21-dakr@kernel.org>
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

Now that we removed `VecExt` and the corresponding includes in
prelude.rs, add the new kernel `Vec` type instead.

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


