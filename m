Return-Path: <linux-kernel+bounces-202143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 510888FC84C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6171F27024
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95B18FDBD;
	Wed,  5 Jun 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6yWcPbZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCA190062
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580901; cv=none; b=BC8ibJ9kHLx2tgEPkXAAnwtZ0ZSOmcQC0abLjnjO0gFEp5GpzGd3NToEkz3fxTQOkRueFVcu5pbMJr8Mgblf0R7750Gb669hrY/hBsFp6AlBv0b/uiwmZ9ShHKSV+BilynO8NM1l8giaOOFRFvCKpP8l+jSV8Qql46FxtqRgUf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580901; c=relaxed/simple;
	bh=TkZmn0j6P9PP99V7b1wYr7sy8xz+wQfdtM61tMGn0RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj/s1uvFEbeWT6y0wANz6zdS/dapbgbNcHVo+F/+xiHB18ZFZAJ9saa6000vwMJ8anR1e9u52RSLlZ3c7dckitIXQN7CPnJzUoKU1hQYs4foD3P0Z32qqvxLS7cNFoD8JDx8f4DOMswVMjbRQSbNSNts3e21k/MhRvn2Tt/ZawU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6yWcPbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD8CC3277B;
	Wed,  5 Jun 2024 09:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717580901;
	bh=TkZmn0j6P9PP99V7b1wYr7sy8xz+wQfdtM61tMGn0RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l6yWcPbZMQQ1acDAPHB8r8Cmps0DD+OQjsvrBnG0oE8R0y8IEJlBI1jMS1sENnl1P
	 +0iJCsd9CJ7/BP2JJ5URZQJi315OeYQiKE6Jz83wZBfr/WSnpfeWxXa8ggtkyUw9Ht
	 UeWwLYTufxMArxQ1sK5zNMJO9gkbXUOpSsYmLLTLVQ/TdcUlBwx70gHsrgd7c42eH1
	 7sjpuM6MkabNXGuN/4SIBSd+ghANbJ58oZK2LOyOAS8cuQX25OWrn8JYGaT4l44dnT
	 qVN8bHcR8PVx8oRkhF1KxqSYcCJDtvFtOYHMH63XyodCb/DoKGMwKvZmV+4KZYqS3s
	 KiouR0RMK7GZA==
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
Subject: [RFC 2/3] mm/ksm: jump out early if vma out of date in cmp_and_merge_page
Date: Wed,  5 Jun 2024 17:53:02 +0800
Message-ID: <20240605095304.66389-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605095304.66389-1-alexs@kernel.org>
References: <20240605095304.66389-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

If we get a page which in a disappearing vma, the page should be useless
soon, so don't bother to add it into ksm.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 088bce39cd33..ef335ee508d3 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2315,6 +2315,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	unsigned int checksum;
 	int err;
 	bool max_page_sharing_bypass = false;
+	struct vm_area_struct *vma;
 
 	stable_node = page_stable_node(page);
 	if (stable_node) {
@@ -2370,9 +2371,17 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	 * don't want to insert it in the unstable tree, and we don't want
 	 * to waste our time searching for something identical to it there.
 	 */
+	mmap_read_lock(mm);
+	vma = find_mergeable_vma(mm, rmap_item->address);
+	if (!vma) {
+		/* If the vma is out of date, we do not need to  continue.*/
+		mmap_read_unlock(mm);
+		return;
+	}
 	checksum = calc_checksum(page);
 	if (rmap_item->oldchecksum != checksum) {
 		rmap_item->oldchecksum = checksum;
+		mmap_read_unlock(mm);
 		return;
 	}
 
@@ -2381,31 +2390,20 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	 * appropriate zero page if the user enabled this via sysfs.
 	 */
 	if (ksm_use_zero_pages && (checksum == zero_checksum)) {
-		struct vm_area_struct *vma;
-
-		mmap_read_lock(mm);
-		vma = find_mergeable_vma(mm, rmap_item->address);
-		if (vma) {
-			err = try_to_merge_one_page(vma, page,
-					ZERO_PAGE(rmap_item->address));
-			trace_ksm_merge_one_page(
-				page_to_pfn(ZERO_PAGE(rmap_item->address)),
-				rmap_item, mm, err);
-		} else {
-			/*
-			 * If the vma is out of date, we do not need to
-			 * continue.
-			 */
-			err = 0;
-		}
-		mmap_read_unlock(mm);
+		err = try_to_merge_one_page(vma, page, ZERO_PAGE(rmap_item->address));
+		trace_ksm_merge_one_page(page_to_pfn(ZERO_PAGE(rmap_item->address)),
+					 rmap_item, mm, err);
 		/*
 		 * In case of failure, the page was not really empty, so we
 		 * need to continue. Otherwise we're done.
 		 */
-		if (!err)
+		if (!err) {
+			mmap_read_unlock(mm);
 			return;
+		}
 	}
+	mmap_read_unlock(mm);
+
 	tree_rmap_item =
 		unstable_tree_search_insert(rmap_item, page, &tree_page);
 	if (tree_rmap_item) {
-- 
2.43.0


