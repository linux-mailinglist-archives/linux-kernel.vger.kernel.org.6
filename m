Return-Path: <linux-kernel+bounces-274881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5514947DEB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BBFAB247F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DDD15F3EC;
	Mon,  5 Aug 2024 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbMFBnAD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA29158DD2;
	Mon,  5 Aug 2024 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871280; cv=none; b=t/l0bFTD0Q2pVpYc1PcM2GYE9/CLThOrAGYLs15dYTXd+qE7qeT/BSNvwIwdslAA3dKjK/aWMWkWAOMCqIJJO2E3Jt90LC8s7R3279wPluum2tY9IcBK4+rOKsc9bCCVb5deLawYEn5NUUTZvfyiQfIdFp2YA3yTpfrNbi0TWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871280; c=relaxed/simple;
	bh=Z6ThON8OGnmMolEbvMDlA1wqJrU2Ykqt5/dZHEIEb08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTD17ah0X/bkgavZZfMCi0U7U7l4v3VdfhUeuEVuCw8pU05w+fpfzlXadoljcgLBbWPIRI3ZAH1SCppxOFCTCHs9ZHCRRu/n/vFDnEpEKtWwvSIgL9pcEiiklU3RqRHtkVimPWT3Jkiw0AJgoF1APiwmUG8Gotp6Fqz6srZAXak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbMFBnAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BAE4C4AF0E;
	Mon,  5 Aug 2024 15:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871280;
	bh=Z6ThON8OGnmMolEbvMDlA1wqJrU2Ykqt5/dZHEIEb08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FbMFBnAD+ONdyGOCxHDO68tIE5VH0ljFw7qk6sCE9LKSrEA9wwnt9OIhcQRVytJey
	 UkxpPeVw0PTJpMDao+P/27nZDKGuWL5G1UOMe1vxrWCZFO5GYBJLtb5Jb/IGJu0iP2
	 b6ROc0rutdvuGbgr3jbmz2vlcc1+Ast709UwwCvlgC2BCs1dNiaFTyVHl/v3ViRxfT
	 R7Wzps/B4vwrPUcspPvb1M3ze8H32abAV3r8+mHhsT2GuJ2MVXLrkcpXgEGIRZjKb2
	 f3b1nXbEbbNUpBurUduGALmQ/3efASeaPucqbUSzzSpWmBigo9rJ9fY5VCA2pvpoWJ
	 QQsKOCQ12WosQ==
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
Subject: [PATCH v4 12/28] rust: alloc: add `Box` to prelude
Date: Mon,  5 Aug 2024 17:19:31 +0200
Message-ID: <20240805152004.5039-13-dakr@kernel.org>
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

Now that we removed `BoxExt` and the corresponding includes in
prelude.rs, add the new kernel `Box` type instead.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
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


