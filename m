Return-Path: <linux-kernel+bounces-223923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577C4911A82
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8844A1C20B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECB616B748;
	Fri, 21 Jun 2024 05:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czXMYM0b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B316B72E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948549; cv=none; b=gqIbArw4N88xL2mgxYVZiyWKDSXdYXmxSzEB4CcJjhQGA1AxNOZ1PjakWbQw8cBSO6akUstlHbAyBg4VRvTJn4JDVQ4jUtwez+iNmBgHoPDEkllG7dJdxj7JPqsiS/yVMw2Uz5otpzDxQ9n2FeorDlS4bpIv36K+8Cibur4zIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948549; c=relaxed/simple;
	bh=i+6jvijEvKznYbydl9yTcQyvtnhbHNyQpu93+PKwok0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjVzylb5P+GI7B1xj5Ir3FTcviedtNsiZ+UAdxA1RRBKdqvoJ74pkEpzKk1NO3lzozanI19NEdzlw6oW0cHAHZl782k/kgQsF9cs25LGQ1XWNdCBO4us8cvKlaEUjO4ApysJRjdMb4zn5zzpFx2e09F0jzlMaDMaiN+j6bVljtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czXMYM0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745EDC2BBFC;
	Fri, 21 Jun 2024 05:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948548;
	bh=i+6jvijEvKznYbydl9yTcQyvtnhbHNyQpu93+PKwok0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=czXMYM0bXh8jZ8xftE+0j1b7rkSL/jCrtw8ckNbHOZmFLB7ysjWJPl9eILFV6RiCa
	 ajtcXwIb12ZQn7bD+gnfFGeceJkDl10HMKqJzwtZZL4O8OMOIaeY3jdEaHqwbtjUpr
	 SvQrsXs6MAxl0on05DNGeHGaIr8bj2CwOHFmZC1A18rOD/+mipzobyJ6T5Bdccpi8S
	 5NpmdOV4Lmf8teIpRLA9Siiu/VXDGNVCUsFKEx3ZokuJIq6o+P4FuuRn/6ZtdGwHgs
	 VgaY11vZfsiMnM9acjeemBSsxFoFDT9cd1v+/atG/tK28kDz64lYZmxxdlFoHXY+Es
	 vb6yS7x9hDVdw==
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
Subject: [PATCH 08/15] mm/z3fold: use zpdesc free_pages_work
Date: Fri, 21 Jun 2024 13:46:48 +0800
Message-ID: <20240621054658.1220796-9-alexs@kernel.org>
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
index afdf21024f83..97580e2224c2 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -501,14 +501,14 @@ static void free_pages_work(struct work_struct *w)
 	while (!list_empty(&pool->stale)) {
 		struct z3fold_header *zhdr = list_first_entry(&pool->stale,
 						struct z3fold_header, buddy);
-		struct page *page = virt_to_page(zhdr);
+		struct zpdesc *zpdesc = page_zpdesc(virt_to_page(zhdr));
 
 		list_del(&zhdr->buddy);
-		if (WARN_ON(!test_bit(PAGE_STALE, &page->private)))
+		if (WARN_ON(!test_bit(PAGE_STALE, &zpdesc->zppage_flag)))
 			continue;
 		spin_unlock(&pool->stale_lock);
 		cancel_work_sync(&zhdr->work);
-		free_z3fold_page(page, false);
+		free_z3fold_page(zpdesc_page(zpdesc), false);
 		cond_resched();
 		spin_lock(&pool->stale_lock);
 	}
-- 
2.43.0


