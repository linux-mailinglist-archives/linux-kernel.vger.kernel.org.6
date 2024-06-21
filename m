Return-Path: <linux-kernel+bounces-223920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32030911A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630BA1C21FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD06616B390;
	Fri, 21 Jun 2024 05:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0DztK0m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E117169AD5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948540; cv=none; b=YYBhqeC7876xv0Dpu/CNkNMbn2u1nt9zhvwh0Nu8YFCZIpitY4/mrwML2BroIQ9YI1aMSLzVqgHeaIWJ1LXypb1I+E2rJdJXUS6fsK1SsO7nICtKd3St1xqOBcJ+j85Df5v+JqVRnv6720FKvh7uX8vq+hmj2SICWePFOdEPjuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948540; c=relaxed/simple;
	bh=7oNANOKMLtbJmXb9loH6eu8JvLufwYd8JIWVLHAnqL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCNGK1jzYW59TAYmdfoGFNOvLuLh+gVtVriCiJGQBMC8VJ/5Vhpmb/0zciXRBGTotMkhgcq3U+7RRAJkf645kb9iUz17YqVynUcFuOGP6bSvkZvAKj4zJEjKqu2bAgL5k2zYBQ/MLi1BVPdpZybQX2Pcbx/2/YDw68FHcAFF21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0DztK0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E17C4AF0C;
	Fri, 21 Jun 2024 05:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948539;
	bh=7oNANOKMLtbJmXb9loH6eu8JvLufwYd8JIWVLHAnqL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W0DztK0mpdQ9nkPkrX3G1oWV0jN9zXYYkkUwaQaFTDd67I4LtFfWlibpmLHOlupgI
	 fhD0/PVR2FYJypn+aJNV4ow0mh2vjIkqlRg422SSynLyEIcXd0OlZaduQT3rZspgXd
	 3E1i0RdBtY85TaTN9qr53ckrhhhujmCzCJl1xwVpx8oSDk2TjMhMOUT2c/X6Q3eB8S
	 mlEJ0J7m5GK2sYQysRObCsWJ9mVN4J9eOmtHjMliJCIAxwyjjZpyo8sdQmxwapATuH
	 8ZJe6SmS/Ggk9WqVdazQppwtz7I8E37R//PDGAQjg8ANUSTaA88AaDMcKKB/cz01b0
	 /QVqN8dKtEuRA==
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
Subject: [PATCH 05/15] mm/z3fold: use zpdesc in init_z3fold_page
Date: Fri, 21 Jun 2024 13:46:45 +0800
Message-ID: <20240621054658.1220796-6-alexs@kernel.org>
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

The func only uses page.private member, now use zpdesc.zppage_flag to
replace it.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index bfbc9f9fdfd4..cd1332243c62 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -320,15 +320,16 @@ static inline void free_handle(unsigned long handle, struct z3fold_header *zhdr)
 static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 					struct z3fold_pool *pool, gfp_t gfp)
 {
-	struct z3fold_header *zhdr = page_address(page);
+	struct zpdesc *zpdesc = page_zpdesc(page);
+	struct z3fold_header *zhdr = zpdesc_address(zpdesc);
 	struct z3fold_buddy_slots *slots;
 
-	clear_bit(PAGE_HEADLESS, &page->private);
-	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
-	clear_bit(NEEDS_COMPACTING, &page->private);
-	clear_bit(PAGE_STALE, &page->private);
-	clear_bit(PAGE_CLAIMED, &page->private);
-	clear_bit(PAGE_MIGRATED, &page->private);
+	clear_bit(PAGE_HEADLESS, &zpdesc->zppage_flag);
+	clear_bit(MIDDLE_CHUNK_MAPPED, &zpdesc->zppage_flag);
+	clear_bit(NEEDS_COMPACTING, &zpdesc->zppage_flag);
+	clear_bit(PAGE_STALE, &zpdesc->zppage_flag);
+	clear_bit(PAGE_CLAIMED, &zpdesc->zppage_flag);
+	clear_bit(PAGE_MIGRATED, &zpdesc->zppage_flag);
 	if (headless)
 		return zhdr;
 
-- 
2.43.0


