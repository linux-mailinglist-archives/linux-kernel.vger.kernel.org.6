Return-Path: <linux-kernel+bounces-403960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813259C3D28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4283B280F19
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB475192D6E;
	Mon, 11 Nov 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="M50NHpqO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BeYPy6ud"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7318C00A;
	Mon, 11 Nov 2024 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324395; cv=none; b=pT6feSsdcH3efyAstk3Hp/8eP0eN9RBOFsJkRQnV/vH/D6JZ/c1j3WOBs5aSGHExOKbnJJXOTWBGo1LKsgllQNVc9u9cz7GlHKMluFsj7Tf1VZ85QqizoLJB0FTwZCKlmSD959x5bnQtpy6uSUvwbASODBzYoXoTgWpsk87o01U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324395; c=relaxed/simple;
	bh=wQZFZgq8it/5ClhvvagLCd/QLHwbkRUFQF5cxWEyhns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okryGT2oLlSabvsYhUWULH6KIFDKf+0IzneYujnNMAVKkP2vyoH4NEJkZJsJScnPyibYd559X0Ehl6DfDH0rnZsUcHniY0mIfpEaparB2NrNi8wvpDcNXF7XudRG4YdpQD9PP/lyWgUn4rhUUTlElsS+HHiBhkXCJcf0Vbl+h74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=M50NHpqO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BeYPy6ud; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 86C7513805A1;
	Mon, 11 Nov 2024 06:26:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 06:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1731324392; x=
	1731410792; bh=cfBlT8kONCC2xuKO1y00pYcl1lydxefqG+nfeJG8XPU=; b=M
	50NHpqOZ6SEo2PQDloR3eZnoOuJEjXn2BU9+vM/dXZ4AmXK6vpT0fk2G9yrOqXn/
	hA07+1jO8Z1LyRmFHVUooyZOXE6ZQnmaRWrjfHOUXTiEBKIFDCvI1XNHWJOCF2Wj
	GPeFjGxSZ0qjQsTdrysZ4kEq5T6LRuebHEepdCPQZJPBcvdI/uVHC1OnQ8fEVzjQ
	gIhB1RiUp7hJtaRUsEkq35t2hVi3c6sQfQJX7rite+s5+QjbXnMp6fkWxG0ctXKC
	YN0mlXEv8ZA04kpTwOldf+k0I/VcRX29t47loSyhVaXK4LKu+TvZQFd9EgtFtmPE
	gR9esZMUYANyuYxy6VJgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731324392; x=1731410792; bh=c
	fBlT8kONCC2xuKO1y00pYcl1lydxefqG+nfeJG8XPU=; b=BeYPy6udAvpAVwNMi
	Ziv6fCl+qYB+KRVV6/taWkUTTC337lAZ6r7IBkIFf018Nrb8xdClHCbnxSAWr8EQ
	c/IzC20rSlBUOdcOvdbq3ftWUyxkdLOVRht2VpWh4zNZUhIhuar/YhSlMbJcoQQ7
	e2o0nKtI6H7txpbtTQOqIAS3NbwrHX4T2mXZYQhICwTaJyJig8G+Pdpphr9mpp++
	lHseXSfBGRURUVGx9ErtzkPF2pLIVLyMqVcjNXak06ViYmx+A/3/6mlFCFxWhq7U
	5snNJyBsDkIgZMRGLAaNbEUefWFZi2YOdmHE4B08ebm95fbJnv1k3szsWWZwr1xy
	+I/Zw==
X-ME-Sender: <xms:6OkxZ0vtiW0vDQw25zGhF-Cgq7k4-94NWiLrrnbC-XE86lYaLn9xsg>
    <xme:6OkxZxeHBaLt261L6qbOQ7HfZqUZWVaQRYfdHPzY6DUC4pTYTPD-ibOb77FT_M_d4
    XsVOhmWknwtAnykQZI>
X-ME-Received: <xmr:6OkxZ_yGTWawQOdBkKTemvP8M53oqh-xy32SPGKCuXYRMJUN4YmxKIRd4DeA1Qqf0RG3QhEudbk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhgggfestdekredtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgt
    ihhsuceorghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtth
    gvrhhnpeeitdefkeetledvleevveeuueejffeugfeuvdetkeevjeejueetudeftefhgfeh
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlh
    hishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepudehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegsvghnnhhordhl
    ohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehtmhhgrhhoshhssehumhhitg
    hhrdgvughupdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6OkxZ3NNfHPU2j44Uoyv_qKw6yAqkDeOn6Ij_9PbYXMyPF9htMCqZQ>
    <xmx:6OkxZ08QyjWJR3wW0NIMJQg-wU0-sP1vJJHL5mYZ7vn8QPQ831NC4g>
    <xmx:6OkxZ_WHan1maLrHuze7iNZYkeGySiZuKl7H-MAgbKoqVAzr3PSZzw>
    <xmx:6OkxZ9eS-1rVs0fHViMoMZmuqFY5LGp8d-ynVNLk6uO-TjXveuQEog>
    <xmx:6OkxZ3eAbwmzqTJd4d-6qO6tDsrLdQy-5YOJUjGiS3ZmXW6CXaDiZ7OQ>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:26:27 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	aliceryhl@google.com,
	gary@garyguo.net,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	alex.gaynor@gmail.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 02/11] rust: helpers: Remove blk helper
Date: Mon, 11 Nov 2024 21:26:06 +1000
Message-ID: <20241111112615.179133-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111112615.179133-1-alistair@alistair23.me>
References: <20241111112615.179133-1-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helper.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 rust/bindgen_static_functions |  1 +
 rust/helpers/blk.c            | 14 --------------
 rust/helpers/helpers.c        |  1 -
 3 files changed, 1 insertion(+), 15 deletions(-)
 delete mode 100644 rust/helpers/blk.c

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index 1f24360daeb3..42e45ce34221 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -4,3 +4,4 @@
 --blocklist-type '.*'
 
 --allowlist-function blk_mq_rq_to_pdu
+--allowlist-function blk_mq_rq_from_pdu
diff --git a/rust/helpers/blk.c b/rust/helpers/blk.c
deleted file mode 100644
index cc9f4e6a2d23..000000000000
--- a/rust/helpers/blk.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/blk-mq.h>
-#include <linux/blkdev.h>
-
-void *rust_helper_blk_mq_rq_to_pdu(struct request *rq)
-{
-	return blk_mq_rq_to_pdu(rq);
-}
-
-struct request *rust_helper_blk_mq_rq_from_pdu(void *pdu)
-{
-	return blk_mq_rq_from_pdu(pdu);
-}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 20a0c69d5cc7..426b0d7f6587 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -7,7 +7,6 @@
  * Sorted alphabetically.
  */
 
-#include "blk.c"
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
-- 
2.47.0


