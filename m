Return-Path: <linux-kernel+bounces-346199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1242198C113
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3DA2855E8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8631CEAAB;
	Tue,  1 Oct 2024 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymj6w+1U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98771C5782;
	Tue,  1 Oct 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794935; cv=none; b=eLpOj/vVN1e8C2/q0gm+XLHqzKDO9Xlm5uCuV0y6GJQWJDG3t3iaSfFw15SX7jLQsgfbfBluVRUarfJWxXtr4iTIxeubXnpz2DZ3/seu74Xzj/ys47FsYosLAJzn4ZSKcac9hQrwlfFiGN/JXWfA9Jjbhbmn7pfEhvAcecT99u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794935; c=relaxed/simple;
	bh=gQa83BvihiTDUGMuUjx+C5N2mcc2ulb0bOkT9bwH31w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7e44eKEkJkmFbwiG6Di5EspcWaNRwRWtAiOo769eRTUD/+2NlTuIg0O8NsyviknnwGAf5LcvuIq6V32qLW5CoMZUfoTaWSIVX2WCmuVRqDJ0Lccqcr8b6ULdgbrswUJG69rFhJn4qYCdAq5BbG3HQMA4SyzHeAOi8NWLWvaknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymj6w+1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55CAC4CED2;
	Tue,  1 Oct 2024 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794935;
	bh=gQa83BvihiTDUGMuUjx+C5N2mcc2ulb0bOkT9bwH31w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ymj6w+1UKRHEv1C2NLx2yMSp7QG95ZSroFgy9ebKi+fVSFbKEOWP7fSIjsCn7efsm
	 xg8Px8wG55oXjnANugoRRHfj3g5G09YA8KvaLpEaP7ZDsM5e+aG+D59j92HK2cfzrq
	 tJ8EZRLegFxti8OwTOwHwSQvdYTodPZB/29XMXL8uuBeV5ao4ssrepqlg63pFVOqLl
	 4bbq8haqOilgKc+I+p/e0OS/KJ27SEkMXBT9akOFYzi6nNmYLn16+Vb7LNQkhATvpw
	 5kNIdK5fqOhURPgyhs49XBFzZYh9eI1vJ6MgKBTyRK5l/jZsrEc6yDqcHGMw+pDOHJ
	 UVDj2MdqOT+kQ==
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
Subject: [PATCH v8 22/29] rust: error: use `core::alloc::LayoutError`
Date: Tue,  1 Oct 2024 16:59:57 +0200
Message-ID: <20241001150008.183102-23-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001150008.183102-1-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use `core::alloc::LayoutError` instead of `alloc::alloc::LayoutError` in
preparation to get rid of Rust's alloc crate.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/error.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 6f1587a2524e..81b4fc5cf21e 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -6,7 +6,7 @@
 
 use crate::{alloc::AllocError, str::CStr};
 
-use alloc::alloc::LayoutError;
+use core::alloc::LayoutError;
 
 use core::fmt;
 use core::num::TryFromIntError;
-- 
2.46.1


