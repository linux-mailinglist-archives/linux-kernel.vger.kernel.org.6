Return-Path: <linux-kernel+bounces-283597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D6E94F6AA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955E3282850
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713431991CE;
	Mon, 12 Aug 2024 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv5GuWoQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A31991AF;
	Mon, 12 Aug 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723487113; cv=none; b=uJfF5auXjh4raNJKcY9TAl6Gjh5e+BBF9G4Xsx/PsP9BsO6baCStIToK+QBjYf2fDIfZi0MCK0FSaGkRWgt/iLfvzSTRIbvw82QUk7xkPFV/z0BRRqdflej1uQUFObM9hDYA6m2RPUaVsfhfjh/egJE1YrIwhXos6uescmS/Lfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723487113; c=relaxed/simple;
	bh=T1FuSmy3wKKtte/FIc8FwS4B4+fz3kPLj/bCRcKqMJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj4G9qC1ciW+SPbuZs5Ufv+vtR85QY/nk+bIV/iV1Db+H4ewo0Wb4hkAZ7b11afs4z4JS8R/N7q+cQ5TKtxLIhRr6mFvgw93NECWlMQ6AblZWj6vD9eYtngAEEgfEoyv0mGSzzYOi1L1mX2Dxi/RqPT6bgJ4GjrJhIDgS6GqT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tv5GuWoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32487C4AF0C;
	Mon, 12 Aug 2024 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723487113;
	bh=T1FuSmy3wKKtte/FIc8FwS4B4+fz3kPLj/bCRcKqMJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tv5GuWoQlwKbMwwjnKoMTrb4grtNMZEHotZjBmBsuaqEFBKhwQNv9xRogc3nnqQRs
	 UFvpo+qQd+H4kCiuXK/SFpJtltvWgWCrflqvvBmrHvwYPjQ5YbEESlchJbh5dm++Ra
	 oUNwdkg/bK+xdupv706WHrQJ6X3GGbjgYMpoziDIO++aRAmCgDc2CLPZTscx0oP1Ik
	 gPZ1Fs+Jkeof0ff6yyBebVf2aBekQ6Huvdx47F1yRvBr5FsMp2snsObG9loYWAnZw6
	 dNu8ugaSnnz4153ZUOesYJJ0F0WzRxPBqY4q/l+YODCVZJjjwG2mXaCAbomuWVgj+E
	 MPJ+ew6WAqoxw==
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
Subject: [PATCH v5 12/26] rust: alloc: add `Box` to prelude
Date: Mon, 12 Aug 2024 20:22:58 +0200
Message-ID: <20240812182355.11641-13-dakr@kernel.org>
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

Now that we removed `BoxExt` and the corresponding includes in
prelude.rs, add the new kernel `Box` type instead.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
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


