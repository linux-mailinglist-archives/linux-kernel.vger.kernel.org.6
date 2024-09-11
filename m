Return-Path: <linux-kernel+bounces-325726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4EF975D84
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87530B22541
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207271BFDFC;
	Wed, 11 Sep 2024 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjxA++Nc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E11BBBD5;
	Wed, 11 Sep 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726095402; cv=none; b=u5cZNBVw+463oj0Qg/9iUBJpg6rtLDb1+Nwqv01vnFxept63BbZ3FZade1vi+6O8ilVwNoLMt9nUE5nQAwJMM2amoFV1ZTBqVvdWdh7Q3T4A6dXSxvwfpgXwEVVjuHLHEEiMIYhv7LBuTnzWwFmaCvL956q96arhQPa3+nYl6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726095402; c=relaxed/simple;
	bh=XnmkIRl7JMA721xzQ642zkLKaoztfCsGi1LdCRFqGKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSozeMr3VF9guvUtGCB2vg2dN10eVo7yEOs2kvKe0F1KIfXUKjxpJfQ7y82UUQVepDZztaDHIq7N+01lwAPS15HCwx3iCG0FA6RXDSJdhO4qtPYWaswzeKVeYbjtv4X8Ou0QKZy4c1h67Hp67IEt2PT8aCQrcqd1DCtJE6Srcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjxA++Nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E5DC4CEC5;
	Wed, 11 Sep 2024 22:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726095402;
	bh=XnmkIRl7JMA721xzQ642zkLKaoztfCsGi1LdCRFqGKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bjxA++Nc5MWL3sYzSRC3CUdU6XlAZO+gTMbQlko/UFgVcABHnYcNL7X9oc9V8vXF1
	 16vDpXQcwuoVs8tLa8s8vS5OnpYaMML3OIuqzKOEHWtEL1G+Sz/KLpUwi3ga5c6bmP
	 KtLlbSLmlGTCIRqd59l9O1xupERtI+YcthuBihC53gXR8dbNDUv5PKxeWeLvwGbsi5
	 NBtqMO8aZ0bWn9mVwCQYdiD5bjMTxIOGB6vsIdodaNMTVcFActNXTjqsEkDvO/i6Ls
	 LsfPi8WwdizJlorAXL6qfea+gIBx1mk024CrhBQrnqxq9bADxq4Rqg7nSdlkMUtbkh
	 0bhjMNs4vhduQ==
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
Subject: [PATCH v7 19/26] rust: error: use `core::alloc::LayoutError`
Date: Thu, 12 Sep 2024 00:52:55 +0200
Message-ID: <20240911225449.152928-20-dakr@kernel.org>
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

Use `core::alloc::LayoutError` instead of `alloc::alloc::LayoutError` in
preparation to get rid of Rust's alloc crate.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
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
2.46.0


