Return-Path: <linux-kernel+bounces-325718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5189975D79
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D641F2347C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7421BE249;
	Wed, 11 Sep 2024 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpmfrHai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C4C1BC9E9;
	Wed, 11 Sep 2024 22:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095365; cv=none; b=a5jS4u6aVAxpeB7Vgz9P55J7SQssLPvjvmAnrN/0Pjjnt1oxJmt2VhNNZ8AMRv/bRoMgs3QntyBi5gv54QxMMAA1KCDsR9ynTjUxZeFE4s0/8MTC6xRPO8C92JSztAm3hiKYhCMaZiqD2HjSMg9MA8qe5zShi9u6HEmV7yi4lIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095365; c=relaxed/simple;
	bh=cG7LgUDIz4/c/n6Pe+TTApJnhkzb0osvgtaCA8JUOxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqU2NKVRjQy/4ucwP2D+JPCNk1GxGe+sGIe0hHjbI815jw9YSjfc8AHLd8Bf+1MiO2K575pjL/zVCSK51VOneisVKAv19dd++ZRXdR8cr7J8XiOJDX+14ImWW6jfX5eebVVKfVJA462OFw+0jAF5TmQFWkMJS3xJC8HDmATJ0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpmfrHai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7454C4CEC0;
	Wed, 11 Sep 2024 22:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095364;
	bh=cG7LgUDIz4/c/n6Pe+TTApJnhkzb0osvgtaCA8JUOxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dpmfrHairLbF/WFnDc9mCRxFc4TWwJtNuuEBCQGTkA5kZgRbz9m1xhG6wVnWSHl7n
	 2uKwNsknq2qHLD42rJOMTTaEIAO4x4rTO5oyVA/GB0PKQA7f5Rsk7c0YVYOJaAIWkB
	 cNR2TzQoSm7yK/KzjDPPgoCJNab3xr7ixisMOEfwCP6E6Vm5IQV23FzTWf8u5R+xcR
	 BGxhGzckFXGnU/hNP/qIfREYZDRN9Nf0+LB12qJmQ8WZcQe+CpIbljlzgG+fB0x3W4
	 /ffi5ETohcuJd+MD8CdRhsRo4bjM0doJtGkEWioO5TnDqqf9r4piOpub9UcrlZofuH
	 pvuLLxS+bnJmg==
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
Subject: [PATCH v7 12/26] rust: alloc: add `Box` to prelude
Date: Thu, 12 Sep 2024 00:52:48 +0200
Message-ID: <20240911225449.152928-13-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911225449.152928-1-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we removed `BoxExt` and the corresponding includes in
prelude.rs, add the new kernel `Box` type instead.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/prelude.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index c1f8e5c832e2..d5f2fe42d093 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, vec_ext::VecExt, KBox, KVBox, VBox};
+pub use crate::alloc::{flags::*, vec_ext::VecExt, Box, KBox, KVBox, VBox};
 
 #[doc(no_inline)]
 pub use alloc::vec::Vec;
-- 
2.46.0


