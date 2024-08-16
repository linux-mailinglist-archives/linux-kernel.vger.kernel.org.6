Return-Path: <linux-kernel+bounces-288753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD5E953E30
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07268B26138
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9CB823D1;
	Fri, 16 Aug 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBDdyls+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD7B2B9A5;
	Fri, 16 Aug 2024 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767240; cv=none; b=S+3vcvPp85FNkB4R4QiHtAbAHQ8HdyOQ24eEmazZ884bY1sS0A906d2LffX7WkILBgpdqw2xWVcW6zPs8zc6j7iEGmH9AKoq/vzCVrL2bXk41Dk8t+uCJpQxf072R0+LoviDgv56HX748TunymrB75kL5H8xAQYTcQGgM3CPJEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767240; c=relaxed/simple;
	bh=LpXBgctNj+tjXHis1qyn9ZWQx0pllgQA+Wvf8FmkV/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEEMu+5WFmE7to6Am25c7VqA0lop5QmJSZY6oDtV7SUhgwiOH71ZRrz0KLrV0KD0tX6PaIkuB6lWlCLAx1mXP6QLkaRGvNlyn+kzs+MpBGwE594K7lpp8urfSr9abGrVeWXQU5UEv+qhz4VIrJ9ZMj2/YDuXvvLMNtLs3O8Um0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBDdyls+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66C5C4AF09;
	Fri, 16 Aug 2024 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767240;
	bh=LpXBgctNj+tjXHis1qyn9ZWQx0pllgQA+Wvf8FmkV/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBDdyls+Jd6wNrwqtFAQcJe7OWuWdRUR96D1OaBuBLszf+b8nx5uFxqZCC7OHJ6S0
	 K5OF5QRMmIHCzD5MO3IZWfIfCnuBkCn/kvF3Xgwb5pPC33irhCPNQsYMZdfYvR7j5q
	 CdiQTBsJyfR3D20Ck/lN7opv7mZ3Y6xlcAR6izoua4HN6xkQMdpDoFFNARJ2iy1UdY
	 pLSOJM1qqSk52E/4NJ4+9xTEafjOidA3suCELiyV2uX7INt8MueM6Xgqx2QcYIEGH6
	 icUps7nSIKG/MiYfHKGFCwZsbHxjmFkSQbBaRctQzxgUTKCvV/Lt21vXa1JdD/hpHd
	 DtEcWeKOOACjQ==
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
Subject: [PATCH v6 18/26] rust: alloc: add `Vec` to prelude
Date: Fri, 16 Aug 2024 02:11:00 +0200
Message-ID: <20240816001216.26575-19-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816001216.26575-1-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org>
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
2.46.0


