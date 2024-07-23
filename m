Return-Path: <linux-kernel+bounces-260292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0562A93A566
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378581C21F44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB0715E5BD;
	Tue, 23 Jul 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dF0TMqoc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095E91586CD;
	Tue, 23 Jul 2024 18:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758361; cv=none; b=A1Kwmw8NwfGg6qqvIB2/34uFq5Fut/50B1auHMkOQtlVm290PaTn/h7yaDRQ5BtwOHSMrfYr9r23pb7Nugo7NZdT/PNHxOPJM7Bu12Qu3oIO5hX83G5W420Xhu+XiovbyFbeZ0MUgF08QCUYjRFg+Hd8fdHXrqF9eRyU9AICbbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758361; c=relaxed/simple;
	bh=x0JvvRfi87BBCBI94b39MtnQOfc5sS9njBcl08nLwWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2ZID7nNN+qw4cEbOPTOJaSyvXEqjODrJ0Ont4eJpwdmW4kSjrzOxmc1aw8KdQErtJRDUvWxnbXcWjlM27lrBftnhWHwq/bTpE1tL0EnnfRyLTY0CeP3U3b+zvZ+rXM+I35SwVgzKBBCu/+uzS8mossIYf9YXp8g902Ac4j2b88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dF0TMqoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B0AC4AF09;
	Tue, 23 Jul 2024 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758360;
	bh=x0JvvRfi87BBCBI94b39MtnQOfc5sS9njBcl08nLwWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dF0TMqocS5E0+WZ7U2tM4lCRj0VbkcHUh59kSwlafs/iP9FjkjwpShpZM0QwzVErE
	 wr9urpHSVBr6lLNiqiL2kb+LUULbHpammoO8zdEmAkI2EesoB13TN0O+lOdaZIltvk
	 KJ+wmaDX91QSC7JkZdJfG0MpyOCY01MofbIG5bu0mMKN7UY/2jghk5Nl4RtORfL4p0
	 sYyIl54YuE2r13obYVbDCfxyfLSB0xtNbK8bItOcY2BglI5tbcYd8Au8ax6Zg2Nt9K
	 2HS0o1kAJuKwdrf4nVZ9vviO/dhPbGQjYYDxMzpgfHytCXlSjj6+YPqD6foRlzNRhv
	 zhkVkTY6S7ilw==
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
Subject: [PATCH v2 19/23] rust: alloc: add `Vec` to prelude
Date: Tue, 23 Jul 2024 20:10:08 +0200
Message-ID: <20240723181024.21168-20-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723181024.21168-1-dakr@kernel.org>
References: <20240723181024.21168-1-dakr@kernel.org>
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


