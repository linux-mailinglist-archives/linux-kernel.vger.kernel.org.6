Return-Path: <linux-kernel+bounces-350672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D7F9907FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA11F246A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8FD212EFC;
	Fri,  4 Oct 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhlqp3tx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99C1DF845;
	Fri,  4 Oct 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056552; cv=none; b=Ffu1UvGQH7Gq8qr34sEoTsVo52gHsdaxK670KO4Ont0WTvb16PUQvcuZapRwDjJO34W8SI+XIv03dNPX34bQlhu5m5Wdl5ymM2zKRcZFEd50ePFE3zT8aAKY/81MdxNcdRfhvJE1DZ1Tx05hloTe+NF9c7tn+N6Luyiqg/mKWCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056552; c=relaxed/simple;
	bh=sxl4tea78ipgv1w2ubiPdzaMlUQIlFJyy3VgFb/Bypk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT4oUq1/lARTWMlMvV3ldhtac5YZ6gIzn4SbIXWwSsFwCSVgVZWJfW1IwLdY0qxTFHiKFr2KwWPCaQylA2d4lOzwjiN5oBNH2/243el4CKDlDvt3o51Lh6Jr29yx4zkf/vDxPAs2Tj1q8846cH/zkB8DmQsYx2XU0wN+QKsge/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhlqp3tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BF7C4CECF;
	Fri,  4 Oct 2024 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728056552;
	bh=sxl4tea78ipgv1w2ubiPdzaMlUQIlFJyy3VgFb/Bypk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qhlqp3txx5UGYepN445qb5tXqTXeQZscm663Ynhm+Ohg5Gwb+YVM0+JFs4NeKJ7+e
	 YjiwFn7VhR7EHqC7Rba9eJU72m5sfpDiClPFKuEm+e09je3P9p4gWDRrGa9vJFbgWY
	 4JO9Syp6zwKtSI6lK//JJIlOkI9bX0GO2xSl3SyP8QORp4kG4SPToZatXFUjixyfiz
	 gbNXh9FypFs1rNE5Tii93wyf785+4u28rNKxnnLbYqF0858HQzd3VVzcRTg8eiZnmY
	 4BoNHc0U9uIVEI1K90JWeHeoSgUJIt8kC8liAXfbHmhM1ZUuPD2V80f/ZYse2X0Iiu
	 vFzgR5K95nw2g==
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
Subject: [PATCH v9 05/29] rust: alloc: make `allocator` module public
Date: Fri,  4 Oct 2024 17:41:09 +0200
Message-ID: <20241004154149.93856-6-dakr@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004154149.93856-1-dakr@kernel.org>
References: <20241004154149.93856-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subsequent patches implement allocators such as `Kmalloc`, `Vmalloc`,
`KVmalloc`; we need them to be available outside of the kernel crate as
well.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index da49c5306431..91b2a26faf3d 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -4,7 +4,7 @@
 
 #[cfg(not(test))]
 #[cfg(not(testlib))]
-mod allocator;
+pub mod allocator;
 pub mod box_ext;
 pub mod vec_ext;
 
-- 
2.46.1


