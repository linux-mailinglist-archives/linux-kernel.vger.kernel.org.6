Return-Path: <linux-kernel+bounces-260285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8C893A55F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685101F231F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17209158DA3;
	Tue, 23 Jul 2024 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz+c3jib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B933158A00;
	Tue, 23 Jul 2024 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721758321; cv=none; b=pYNHgPD05vie9XJbUa3hXd9puc95CVdo4bUMxxQUnicy3zQPxT3OzfX2ZQhLavY6iYqvP7qtYNVHScvODCu+6tXhoAo9FAiu1I1Ddn45oqjHnp1ymJ7PoVS2G2UfkWsVLThdwTdoeJsOSGqDnDiQexVnTiRYuuy6rc4qI2rLoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721758321; c=relaxed/simple;
	bh=IsegupDL6dNouhj9LI4K0JPI4QQWWwWlwU04wMc/SwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXsy+OgvpeeKa/6Gy8o7T5sJ/CLy0eQyJqlfxOC3goDUd+6F/Y1FkdyipNS1ks5UlkXTSbJANcfyOg6xQSj/7oIHOmV8jPDbPuiKWA/ASJrC9752B20KKoDll8jKxbv4Iyk5wNtRzfmEDbrYPBo+DO6AHyAiEUK14tX+u0GI6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz+c3jib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81ECC4AF0A;
	Tue, 23 Jul 2024 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721758321;
	bh=IsegupDL6dNouhj9LI4K0JPI4QQWWwWlwU04wMc/SwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mz+c3jibuWgJwcKZM7aGqSADuz6ejR/ZC+t7GQrirU7NnutbHsXT+uJXKZb4R9isB
	 rHeWk5FliserG8OO84VXZRoBXyHeglwLW8dxd/RWCofCPQVFhOZ2t0qCXAXD0FRNuz
	 Hle+I8HjZ/w5RNPtbZTY0zZTnON2De2BWvXnbDZBFrZKuqwn7iJ+ZbTU+50uGLYEmi
	 Hr07A4LgDXLVHFapDWKC4BU+clELnUWbr7jFSqwK4IzENwCrlbHfypc6v9hOf2LeBg
	 yOnDFA5qpGPFY56bCw6G28x9cbkY+/MIFWO56Xh/+hOnZaMs7pLCyS9C6CxGMoa1in
	 rB73961xp9k5g==
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
Subject: [PATCH v2 12/23] rust: alloc: add `Box` to prelude
Date: Tue, 23 Jul 2024 20:10:01 +0200
Message-ID: <20240723181024.21168-13-dakr@kernel.org>
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


