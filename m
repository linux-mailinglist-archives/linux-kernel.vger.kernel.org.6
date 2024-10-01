Return-Path: <linux-kernel+bounces-346180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8990C98C0FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23120286DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984DD1CB517;
	Tue,  1 Oct 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6HrTB7k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000701C9B99;
	Tue,  1 Oct 2024 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794844; cv=none; b=dmue4iBx24bLbFCWxdR1bhgCLUamhJ5mKfQGt1z0i54WhGjnj2Xyyg/HGqtWmBolZs/DbvZLfyIDpdWIpR1HCuZOm39FWpRNdvghqastaG6zRYPp/rcx0dIErWpkgb1vE8URRIksOq7EbHgVQ7gKINE7eqbLUbRuGOluFx/DGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794844; c=relaxed/simple;
	bh=Q8k1CNJBRt+py+dbCiPnncTCxkP76JA0XnMHDcdIPww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcapJpB8khjr5hOX9nvZNAj8qNWBUvzYOywMOiReJVDtXe15jMMPj9ukgyOjaPwmGoKvl1+5PlQcemLtX3UvLvolccI5lVv8rguiTuVUJyBt9t2yw566edhp/LwGZKvGYp1u0QVBaGqrNpnFrNdR/26TLcH6AyEmCtExRrBjt0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6HrTB7k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A251FC4CED5;
	Tue,  1 Oct 2024 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727794843;
	bh=Q8k1CNJBRt+py+dbCiPnncTCxkP76JA0XnMHDcdIPww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k6HrTB7kXzr7UXNi/oqSSMVdSvQbzfQ2Hm1qoZEOXD1oExN1ccaOqbAue+hMgqwlG
	 aFuaTfrxYlEDY1OsaerO20MVWs+GrHT93LlBRHbNM3oWblgJzg2DIULKyJbvqQKHMM
	 uRUFIu5Uvno/CWEOQEboF+pHcqnLzvQrGoJNSVp6TUomfHRf2Y/F8eo03ZTQNRYiXc
	 7Zj4zUSlObmvhv5Fjaq4wKqXQKAUL4P7Bp4k76qq56v7MB2xHZUAnZUwfemwdeXfRt
	 hVhXC0aAcrna0GqlbxFIa+jc3xp2yTJlzmqQd+peDun2KTOyoIfnvIgVnCq51XYigd
	 1HKYsOhwyklkw==
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
Subject: [PATCH v8 05/29] rust: alloc: make `allocator` module public
Date: Tue,  1 Oct 2024 16:59:40 +0200
Message-ID: <20241001150008.183102-6-dakr@kernel.org>
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

Subsequent patches implement allocators such as `Kmalloc`, `Vmalloc`,
`KVmalloc`; we need them to be available outside of the kernel crate as
well.

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


