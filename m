Return-Path: <linux-kernel+bounces-274890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67F5947DF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A252F28297C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864A115E5D0;
	Mon,  5 Aug 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiluqMtX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C798D15E5CB;
	Mon,  5 Aug 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871324; cv=none; b=qa8+miU1bmin9gAWy1MpJx0NywsIeZ75bj7kcGSUssZxtMufqbT8ndv2qFge3OZ3PMaKmanDmx8FvxD+oILcw1FPO6nOj0Wc92So0IhVzpGWnE7JVc6yjrQkgDFenaov+Fku3yTBKsi301BIj/IqH+gNB82wBehIFGTBmLvU1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871324; c=relaxed/simple;
	bh=x0JvvRfi87BBCBI94b39MtnQOfc5sS9njBcl08nLwWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tw0Rdyx4cSrQOlNl4F6v8W6TMj8sTIbfZEkMYd+UE90vMIpij3eCZ3s8AUzHiXm+YYI03I0JERl+TR17oCGkXX2xEU5GbQ60TQ+jPAgt8aUtyT42bGovQYx+QhZtFlSEKIfTfoNmCwPSOBhIDogt6hDrQ9A257VWfzW7kcqn5G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiluqMtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88645C4AF0C;
	Mon,  5 Aug 2024 15:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871324;
	bh=x0JvvRfi87BBCBI94b39MtnQOfc5sS9njBcl08nLwWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GiluqMtXdZRrGxd8njXJGzh/Cnf1XJFc2iZ23I6ziKDaiDjT0f3p1u4HPaC1G4uah
	 l/YEiiIvjf0b4ltjN1ueSK3zylXBNT+K5g3kxc5BVTvZikzngFX62UcXk2YpAXbB0K
	 MI7i5QKXgq/K8AEsUY4PueIhpjWMF69MREMH628K7zjwnNn0tHp+bGVhN1o/5K1edB
	 XPtQDYlm69lFVM1TWny+/5dfby4rl7p6JyoEqgxH35gdvfGTk1MZNfQ5elSVOtDc1P
	 +YkOJ0aKYgxQjOzrh5iu1d4rfGViA3aD/ymffHIe5ZVsmU6RqHWOj631lcpYfb/NEd
	 ua2KgmEVCJ1gA==
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
Subject: [PATCH v4 20/28] rust: alloc: add `Vec` to prelude
Date: Mon,  5 Aug 2024 17:19:39 +0200
Message-ID: <20240805152004.5039-21-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805152004.5039-1-dakr@kernel.org>
References: <20240805152004.5039-1-dakr@kernel.org>
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


