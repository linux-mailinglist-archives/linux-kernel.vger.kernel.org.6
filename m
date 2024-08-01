Return-Path: <linux-kernel+bounces-270019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0DA943A23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 375F7B23085
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317F3A8F9;
	Thu,  1 Aug 2024 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRYFZy1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43CD2E634;
	Thu,  1 Aug 2024 00:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470879; cv=none; b=bQVgd03BqPjXi4GKZU1WWX8bSXn7mgorOUIFhpqRQMxjxnV2skH5a6YaIcWTOWuIlkQg+xvS/CYi0rgtYWO2+lCDbtu3eiUW8dbKH1c/Ma9RoE7XQF6P2AoU9YC5BHRaQ9t8FpWamt3FFoUROR3i15pd69CLrseQFOYZeGwW0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470879; c=relaxed/simple;
	bh=IsegupDL6dNouhj9LI4K0JPI4QQWWwWlwU04wMc/SwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyuevJhi5az1uypynZ6GcXb9M0FENocOQU5cl2BwacIfR0ftb8B8bUKKNR7Mn9DIPODG2uP9qZY2/vNC8p8YTsQ2t9UQCW4j/xyCqF3j3uaix0cpCZGviM9aCKPHk4I/AdYL0CtW6+v4uy7QOs04cGAuF4fVNeXtl0i2V5bfl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRYFZy1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54438C116B1;
	Thu,  1 Aug 2024 00:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470878;
	bh=IsegupDL6dNouhj9LI4K0JPI4QQWWwWlwU04wMc/SwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IRYFZy1hq3Z3+PX8qgT+MsS8OA/+Rxv4P/v6eqnDklPF9QlxvTVw0QxCzrF60YK+t
	 ySR1ELEfYvaH39ogVK5IQdBjcFG+z9sefH6R5KwlG1JH4XYUXn67HpuYSN+vxGVn8W
	 uAX/A0jAJkhjzp8cC/km6NDyVe3iG3db4GQt6IOEUH4ZyNXS/bqFJh0hSCOwYWZh0M
	 l6KlEaCB3/4qJnnD6h7cRsQ48FvJcxnODhWrnwxpJWj6fgo5Br7lDc9KlElgVC4oGv
	 zFLiG84rkDETV9+CFCjwCLxY7isa79gI/y9Nf+hADVfGhRT5TJWblFWc67BVMx+7gv
	 eE4FT6aWXJmHQ==
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
Subject: [PATCH v3 12/25] rust: alloc: add `Box` to prelude
Date: Thu,  1 Aug 2024 02:02:11 +0200
Message-ID: <20240801000641.1882-13-dakr@kernel.org>
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

Now that we removed `BoxExt` and the corresponding includes in
prelude.rs, add the new kernel `Box` type instead.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/prelude.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index a8018ef2e691..6bf77577eae7 100644
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
2.45.2


