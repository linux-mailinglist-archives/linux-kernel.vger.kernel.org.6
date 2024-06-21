Return-Path: <linux-kernel+bounces-223922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69044911A81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA084B242CF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184B813D53A;
	Fri, 21 Jun 2024 05:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMsgGw2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB2152500
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948546; cv=none; b=Aorms2TjSN+R5uygxdo1A1FbKdRoboihE63AWYRTTtefrlg+12XaXXzqpnhASAF6Y/LIV3S5ZRvYG+Dop/sNXs1zJLSR8RYbMKONox2xSMBLuKS27b00ZPPfYceHs89pGWY9C20DTLrmVYKhLBjJJvspDE9EkFx1Q2YCfCC1mKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948546; c=relaxed/simple;
	bh=HH8XUbwE54a8Ffun41cCB2IdbyAXONYKrrqycjR2+TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQzvwTcqPw3VOt+Yp5ukp/jaNtbri8CL2V8M+cg2nZbKUcAtNmjLJ94WRcS7u0FS7yQNUbhT1abuFDIjyCndxSPkQBiUbo5frwB8/oJp1BTxtIWgcW+OD6FWmvQdUOEy6hAWpkiuHliYnUOLILhDonZNcn1cDYE1YPnLdeAA10Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMsgGw2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3E8C4AF09;
	Fri, 21 Jun 2024 05:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948545;
	bh=HH8XUbwE54a8Ffun41cCB2IdbyAXONYKrrqycjR2+TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMsgGw2faeC2vry7ZfObRdqPniifc1PywteXa6fKyQZYs70YWl/TsVQxmuZoesIEw
	 TaQze64JKDMRSAWcfynF7PkpSTcd/3wsLqNQTQhm2t1EJ5Vd2V0qb3z9oXhnvIGpUn
	 5QCBfWdYoIGz7WXdJ58DpOID9+bOjQ6yL+C84N7J6ri+uSjnhEwxGAgZCh0n0PyOw+
	 zT8S+Xy5If/MnxW9+63qKKT6ypsQe+hmbyJgImhAjzy4nrmUrjCUUjodTol/lVTA6i
	 cZupBvuMYNV6/g/N+p4Nhd2AkuPrgu2adPHto/Tma6Up2WQS+tMICgF44Z+INGUrEE
	 15rT8lv4wMCBQ==
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
Subject: [PATCH 07/15] mm/z3fold: convert page to zpdesc in __release_z3fold_page
Date: Fri, 21 Jun 2024 13:46:47 +0800
Message-ID: <20240621054658.1220796-8-alexs@kernel.org>
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
 mm/z3fold.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index c3c740b42052..afdf21024f83 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -441,12 +441,12 @@ static inline struct z3fold_pool *zhdr_to_pool(struct z3fold_header *zhdr)
 
 static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 {
-	struct page *page = virt_to_page(zhdr);
+	struct zpdesc *zpdesc = page_zpdesc(virt_to_page(zhdr));
 	struct z3fold_pool *pool = zhdr_to_pool(zhdr);
 
 	WARN_ON(!list_empty(&zhdr->buddy));
-	set_bit(PAGE_STALE, &page->private);
-	clear_bit(NEEDS_COMPACTING, &page->private);
+	set_bit(PAGE_STALE, &zpdesc->zppage_flag);
+	clear_bit(NEEDS_COMPACTING, &zpdesc->zppage_flag);
 	spin_lock(&pool->lock);
 	spin_unlock(&pool->lock);
 
-- 
2.43.0


