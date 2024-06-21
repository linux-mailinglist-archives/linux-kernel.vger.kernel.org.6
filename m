Return-Path: <linux-kernel+bounces-223925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D011911A84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EE728149F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F716C6AC;
	Fri, 21 Jun 2024 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsjvEN5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FDF16C6A6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948555; cv=none; b=Zzgy/1sjvRLLB48AsNJReWTXtoC8k7i02DbnMde4hBWHfT2nIZMHdJEDu1jWekfu0IbECkn4rr8koOTCHqZ+vU9wUmgfYoxCkG13tS3xzQosN1evU2b6nVWmBZCge7mroIC+Nx8WSZyffYAFPUdEj/PydlVm89Y5TSzJnlx+JVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948555; c=relaxed/simple;
	bh=Sd2Phg+JvwLSFmEURLUSKjCDab85FD2bJliNqmZmxJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b4DP9M5TdhxsUGGeeUmyNyxgQKuvfaKl9CcYs4w1mahtdRGtar3ZED/1stasGdTWfPm2Nq9YoxriKcI1NIg3BIRRh/8S//xPEtJE9uL2h+10NICsjZh3VfjeIHgp589CQWLFmtu5/tqopVToLlWmHR3hPKrdNdA09cNiO4tdfFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsjvEN5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89007C2BBFC;
	Fri, 21 Jun 2024 05:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948555;
	bh=Sd2Phg+JvwLSFmEURLUSKjCDab85FD2bJliNqmZmxJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IsjvEN5G5UtwH5nf6m44K+yulQm1RsG8bHkIVkguFk1JvLe7qVG7hIdWTy4Kjs6Pe
	 VAiFIQIHfPdS+46prNFdVC42cOugMQXDmwTViUO66+hLNc28yBDx172D/Esdp9mqyB
	 tQ1rxcUrko5b+IiC101fBhNBvOcgzADOF/MTa6NS7Rq1aJXjNLgi6RyfKTiNUEPIzd
	 ItWxesPk2knISOhVPZf1M8Z5+JvBXQG1WaNJki8upVSP04V1DDxv5DypiOBa1t7nE9
	 XTTxK9Nqj8U8AH8xM38UDDCQ6j1EQihjMZ6aEueUdq74JdFqt5WsYVwfBssqvfzOKK
	 2igffWYGHyERg==
From: alexs@kernel.org
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	willy@infradead.org,
	senozhatsky@chromium.org,
	david@redhat.com,
	42.hyeyoo@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 10/15] mm/z3fold: use zpdesc in __z3fold_alloc
Date: Fri, 21 Jun 2024 13:46:50 +0800
Message-ID: <20240621054658.1220796-11-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621054658.1220796-1-alexs@kernel.org>
References: <20240621054658.1220796-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

The main purpose is converting page->private to zpdesc->zppage_flag.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 3d36448885c9..f164eb4e1139 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -790,7 +790,7 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 						size_t size, bool can_sleep)
 {
 	struct z3fold_header *zhdr = NULL;
-	struct page *page;
+	struct zpdesc *zpdesc;
 	struct list_head *unbuddied;
 	int chunks = size_to_chunks(size), i;
 
@@ -823,9 +823,9 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 		zhdr->cpu = -1;
 		spin_unlock(&pool->lock);
 
-		page = virt_to_page(zhdr);
-		if (test_bit(NEEDS_COMPACTING, &page->private) ||
-		    test_bit(PAGE_CLAIMED, &page->private)) {
+		zpdesc = page_zpdesc(virt_to_page(zhdr));
+		if (test_bit(NEEDS_COMPACTING, &zpdesc->zppage_flag) ||
+		    test_bit(PAGE_CLAIMED, &zpdesc->zppage_flag)) {
 			z3fold_page_unlock(zhdr);
 			zhdr = NULL;
 			migrate_enable();
@@ -868,9 +868,9 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
 			zhdr->cpu = -1;
 			spin_unlock(&pool->lock);
 
-			page = virt_to_page(zhdr);
-			if (test_bit(NEEDS_COMPACTING, &page->private) ||
-			    test_bit(PAGE_CLAIMED, &page->private)) {
+			zpdesc = page_zpdesc(virt_to_page(zhdr));
+			if (test_bit(NEEDS_COMPACTING, &zpdesc->zppage_flag) ||
+			    test_bit(PAGE_CLAIMED, &zpdesc->zppage_flag)) {
 				z3fold_page_unlock(zhdr);
 				zhdr = NULL;
 				if (can_sleep)
-- 
2.43.0


