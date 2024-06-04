Return-Path: <linux-kernel+bounces-200013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE618FA928
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9081F25F9B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC2413DDB8;
	Tue,  4 Jun 2024 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFtitKi7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19CA13DBA4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474918; cv=none; b=A+Pw+IZXtzCwVUtCYUU1Dmqyw656vSLli3WTjFqGCAecS2OoEE8ddpR5Ik6HB+tx0eopsg5oy6b9982GMBtdvK7TirGeGEScnGyJg3j/e1/rnwPzpipWj1iStG5L0m7lYIDjlHZbjJrvaRI2uZPyG9Ej645GDMazhvKtmmPXiMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474918; c=relaxed/simple;
	bh=oMozYVrFFGB9vcI3OPMo0SADR+/06RLvlkdM1E9kWqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8JB0Couy+diBn0T2ovFq8fy7NL9yoN4QeFqjuETp4lW31Ab3Cfai8bH4PpKTxrGanWCJf7jcnu0ibNUg3UIZPqXLe7TLxpzsaKgUJDIRokvBCgxdEgemsukvYrH/3Q5qkye7GGi2EkJE1wEfqh/AkW1ZFL6AcUC7jclblgSPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFtitKi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BB0C3277B;
	Tue,  4 Jun 2024 04:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474918;
	bh=oMozYVrFFGB9vcI3OPMo0SADR+/06RLvlkdM1E9kWqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFtitKi75VkslnGm5HM61imI+AbUmGKz0XcZjPDTUXd4NBl0VY8yLM7DCkeyfOfHa
	 xce4eXMDrC42qjTbB9rUkdRq2a8Mzr/gRE6n7jyJ5wrIijxuvx0EVz+2JWscYQ1eni
	 PXd30EC2VbtuS7mAYSInQcYOKXDWQzdtJKehTOrmpw7gchDRcLFb4IPiBkG7oRjrw/
	 QLBif67iTIrzHu50sls1bMYAS8pxVccQzenPPP2FPWCPsP2Yx06/yzy3ySpSkZbALD
	 tLysh0FKSJCUIYf7cfuUoZEVxngYOJc+k1Gn93FmkAzrAKJC1ycbvaV12i1sfA743L
	 dAD75MsvLbzcg==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	izik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	chrisw@sous-sol.org,
	hughd@google.com,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 09/10] mm/ksm: calc_checksum for folio
Date: Tue,  4 Jun 2024 12:24:51 +0800
Message-ID: <20240604042454.2012091-10-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604042454.2012091-1-alexs@kernel.org>
References: <20240604042454.2012091-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

Let's check the whole folio for contents change, don't count it if the
folio changed.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index b9c04ce677b9..dc2b5e6a9659 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1258,11 +1258,13 @@ static int unmerge_and_remove_all_rmap_items(void)
 }
 #endif /* CONFIG_SYSFS */
 
-static u32 calc_checksum(struct page *page)
+static u32 calc_checksum(struct folio *folio)
 {
 	u32 checksum;
-	void *addr = kmap_local_page(page);
-	checksum = xxhash(addr, PAGE_SIZE, 0);
+	int nr = folio_nr_pages(folio);
+	void *addr = kmap_local_page(folio_page(folio, 0));
+
+	checksum = xxhash(addr, nr * PAGE_SIZE, 0);
 	kunmap_local(addr);
 	return checksum;
 }
@@ -2369,7 +2371,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	 * don't want to insert it in the unstable tree, and we don't want
 	 * to waste our time searching for something identical to it there.
 	 */
-	checksum = calc_checksum(page);
+	checksum = calc_checksum(folio);
 	if (rmap_item->oldchecksum != checksum) {
 		rmap_item->oldchecksum = checksum;
 		return;
@@ -2385,7 +2387,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 		mmap_read_lock(mm);
 		vma = find_mergeable_vma(mm, rmap_item->address);
 		if (vma) {
-			err = try_to_merge_one_page(vma, page_folio(page), rmap_item,
+			err = try_to_merge_one_page(vma, folio, rmap_item,
 						    page_folio(ZERO_PAGE(rmap_item->address)));
 			trace_ksm_merge_one_page(
 				page_to_pfn(ZERO_PAGE(rmap_item->address)),
@@ -3916,7 +3918,7 @@ static int __init ksm_init(void)
 	int err;
 
 	/* The correct value depends on page size and endianness */
-	zero_checksum = calc_checksum(ZERO_PAGE(0));
+	zero_checksum = calc_checksum(page_folio(ZERO_PAGE(0)));
 	/* Default to false for backwards compatibility */
 	ksm_use_zero_pages = false;
 
-- 
2.43.0


