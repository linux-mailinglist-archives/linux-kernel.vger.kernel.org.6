Return-Path: <linux-kernel+bounces-288747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C688953E29
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58199287B68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE048C06;
	Fri, 16 Aug 2024 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJiLt7dE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90B801;
	Fri, 16 Aug 2024 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767209; cv=none; b=HfloxQGTKhr7pU9gGxGALTp386ITY7cPaGON3fmyvZkcdRXhFmbnh2iVef562ftj60RvXfQH6bcKnU0C2Y9QM/xDq/07RZdK2i0it6SUaS6W39LHR/pF4P8B4Bq9Ax6gTGKUzbM6u1XV45mp2oqZaliqmIKPeJVFzz1OdsuOgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767209; c=relaxed/simple;
	bh=cG7LgUDIz4/c/n6Pe+TTApJnhkzb0osvgtaCA8JUOxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tR9tcqr/7sJqCwLONjhzIn7+8i3AQ69iz/zIdB2gz3ezkCx4hR508Aw2hTk3hz2Vuo2AItI6gSAQJTuByX91DhKy4fLzavP35lq4GuktCPdARGiLHHEb7g0B1v1z/q/6aPuhv/LQpTzQNDls1EUoqyMELnhWKa2HRF8JF1wDDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJiLt7dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0601CC4AF09;
	Fri, 16 Aug 2024 00:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767208;
	bh=cG7LgUDIz4/c/n6Pe+TTApJnhkzb0osvgtaCA8JUOxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OJiLt7dERCz22f4JtlRQcB/H9J5mN0JO85RbA3rhZIza2Lmp8w4El9tLHSQB0NMP6
	 Ly9+X1x5lh3SlkBGvlcMnOxFEdMqua/rSiMyPMp/Nx4/VI0UqX0I8AsvKVK4FLeXth
	 MBIMk5wiOcdgMw3vm2G4MH6XIiqIibuT/D4FznJEbCaUlHYlaXLE1mwpuQ/hay7t1H
	 AAYgykhh7yB8bHpgIGh83Ei0YvFdnKwzPk9yJeXl/g1xDanIWoHSIfT1ZWVizaTUDg
	 l4TiH4tbN6oXq016jkOQh59xBl5p67lhsu8rNfN9uh8Om59rI8XZFUVnPi9Dlfm+bz
	 oUpRZSLXp7L4g==
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
Subject: [PATCH v6 12/26] rust: alloc: add `Box` to prelude
Date: Fri, 16 Aug 2024 02:10:54 +0200
Message-ID: <20240816001216.26575-13-dakr@kernel.org>
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


