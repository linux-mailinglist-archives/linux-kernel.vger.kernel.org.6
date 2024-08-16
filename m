Return-Path: <linux-kernel+bounces-288759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7C953E37
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 02:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAFA288AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 00:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B661AC8B5;
	Fri, 16 Aug 2024 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKVfWubt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA638DF9;
	Fri, 16 Aug 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723767273; cv=none; b=sel3BR6vr99BNvwZ2n5Xo1waaYkk7mubBj0cnI4yy8D6HnHxpoWCECXGMpXy9SKUEDe8PioI4zwqQ+ZWGa5xyXOX9WHdb6CqgllVhqkiAcO9g1lbA9IMJ6/8tHTUFdaiqBRwMtDjzcc2bXujPEOvSLSNwVtXJ7OQemxx2Bl7rUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723767273; c=relaxed/simple;
	bh=hE66PL1XT1fcRs3UTiebGaIqq2XjEPx5BcyZuKDcUQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jt9KQEKaIK4T8u7q1S26Yt2DZ3XjL0p5izPw+QuialrUBwDRD3+cWth+J6wyYWNLtpTtQP7tat5+Mdqa+C7+y/HK9bL0gJvsISM+kBJuieIn9JW7NxV7CLL/LMxZizJeAg0lUWz3im9/FW1hiYGTv4+j8CMZNcaDHHJ+e/ZSFQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKVfWubt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCC3C4AF0C;
	Fri, 16 Aug 2024 00:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723767272;
	bh=hE66PL1XT1fcRs3UTiebGaIqq2XjEPx5BcyZuKDcUQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKVfWubth0bLERTXQ8mlKzdE11QkH/+igswwE1Rpmi8GRKX1TG1+vjUOjQ+yV00zc
	 9EqLsYhd+/0sTraI8cf+E8BM4We282bsHHxDL67KvIaM/fMJQV8mU0Q5ztlTYgE3tq
	 ip8Vj5g1BYRtCuK3uMaEHSrr4nEJh4Vaf6/MuZndaGMApNxf0EqYZIPM5R8mQtwoC+
	 8AOxynaWFSbl+JHXs6nNBQZDLvnipOgZ1Uvk6V3OdjjnDBy72Uve1NtL7xTP2P/5tv
	 Tzsd8Z8+LbdPZo2ni4bBcfdw7RAU2GTi8Z0QyMpcbEPbTy7Nocq/htxnntM6ti3Z6r
	 4stIQT6g9FnZw==
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
Subject: [PATCH v6 24/26] rust: alloc: update module comment of alloc.rs
Date: Fri, 16 Aug 2024 02:11:06 +0200
Message-ID: <20240816001216.26575-25-dakr@kernel.org>
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

Before we remove Rust's alloc crate, rewrite the module comment in
alloc.rs to avoid a rustdoc warning.

Besides that, the module comment in alloc.rs isn't correct anymore,
we're no longer extending Rust's alloc crate.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 5c66229a7542..282afd184957 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-//! Extensions to the [`alloc`] crate.
+//! Implementation of the kernel's memory allocation infrastructure.
 
 #[cfg(not(any(test, testlib)))]
 pub mod allocator;
-- 
2.46.0


