Return-Path: <linux-kernel+bounces-358531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1956998075
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 10:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CD41F26E83
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3E1CF5D2;
	Thu, 10 Oct 2024 08:26:34 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AA41CDFD1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548794; cv=none; b=Mbt6vey9r1hStMboR5mOdousQMoSDPvk+e2BIxSog7b+ePReoTlfDRgawUE1wunKluM8umLPe4hsDr8ZHhvC1D2I5ZUwu8wmQtxbP/wjGgaDk5ORcfhk0cX2AWjIDEwyjtr8Bv0qx2JDjZCe6DUF57KV0BrXUI9phc5FM2OLXVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548794; c=relaxed/simple;
	bh=8ul9mbMp6VYpfBPxQhl2RAVm9UNDDfvewQcqAjKsErg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tOVzFxtR3BCjmc9lw3ofpSyre2P5D8EftadymGhH8gQWutGUmB8yYVHw5oNPR+i5PkkrhOtOJGgf1PFyl9RkNXtoc2iLk5kewMHnTPhBeeuvuYARKJ43jvyCAh1KpJmzuPIaWQaZHz26VOa4ujo5Je0cGsq5sywFti15Ih35GFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XPNBT5Nmlz4f3pHv
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:26:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6058B1A0A22
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:26:27 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgCn0i6ijwdnT0BYDg--.31676S2;
	Thu, 10 Oct 2024 16:26:27 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH v3] mm/vmscan: stop the loop if enough pages have been page_out
Date: Thu, 10 Oct 2024 08:18:02 +0000
Message-Id: <20241010081802.290893-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCn0i6ijwdnT0BYDg--.31676S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4UZw1UCw48JrWkKr4xCrg_yoW7Jr1UpF
	W5WayDtw4kJrnIgr13AFn5CF1IyFy8XFW8JFWa9rWayFnrWw42gF9rA3y8XF45Jrn7ZFWx
	ZFsrGrn5Wa15AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

An issue was found with the following testing step:
1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=y
2. Mount memcg v1, and create memcg named test_memcg and set
   usage_in_bytes=2.1G, memsw.usage_in_bytes=3G.
3. Create a 1G swap file, and allocate 2.2G anon memory in test_memcg.

It was found that:

cat memory.usage_in_bytes
2144940032
cat memory.memsw.usage_in_bytes
2255056896

free -h
              total        used        free
Mem:           31Gi       2.1Gi        27Gi
Swap:         1.0Gi       618Mi       405Mi

As shown above, the test_memcg used about 100M swap, but 600M+ swap memory
was used, which means that 500M may be wasted because other memcgs can not
use these swap memory.

It can be explained as follows:
1. When entering shrink_inactive_list, it isolates folios from lru from
   tail to head. If it just takes folioN from lru(make it simple).

   inactive lru: folio1<->folio2<->folio3...<->folioN-1
   isolated list: folioN

2. In shrink_page_list function, if folioN is THP, it may be splited and
   added to swap cache folio by folio. After adding to swap cache, it will
   submit io to writeback folio to swap, which is asynchronous.
   When shrink_page_list is finished, the isolated folios list will be
   moved back to the head of inactive lru. The inactive lru may just look
   like this, with 512 filioes have been move to the head of inactive lru.

   folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1

3. When folio writeback io is completed, the folio may be rotated to tail
   of lru. The following lru list is expected, with those filioes that have
   been added to swap cache are rotated to tail of lru. So those folios
   can be reclaimed as soon as possible.

   folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512

4. However, shrink_page_list and folio writeback are asynchronous. If THP
   is splited, shrink_page_list loops at least 512 times, which means that
   shrink_page_list is not completed but some folios writeback have been
   completed, and this may lead to failure to rotate these folios to the
   tail of lru. The lru may look likes as below:

   folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
   folioN51<->folioN52<->...folioN511<->folioN512

   Although those folios (N1-N50) have been finished writing back, they
   are still at the head of lru. When isolating folios from lru, it scans
   from tail to head, so it is difficult to scan those folios again.

What mentioned above may lead to a large number of folios have been added
to swap cache but can not be reclaimed in time, which may reduce reclaim
efficiency and prevent other memcgs from using this swap memory even if
they trigger OOM.

To fix this issue, it's better to stop looping if THP has been splited and
nr_pageout is greater than nr_to_reclaim.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 749cdc110c74..fd8ad251eda2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1047,7 +1047,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	LIST_HEAD(demote_folios);
 	unsigned int nr_reclaimed = 0;
 	unsigned int pgactivate = 0;
-	bool do_demote_pass;
+	bool do_demote_pass, splited = false;
 	struct swap_iocb *plug = NULL;
 
 	folio_batch_init(&free_folios);
@@ -1065,6 +1065,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 
 		cond_resched();
 
+		/*
+		 * If a large folio has been split, many folios are added
+		 * to folio_list. Looping through the entire list takes
+		 * too much time, which may prevent folios that have completed
+		 * writeback from rotateing to the tail of the lru. Just
+		 * stop looping if nr_pageout is greater than nr_to_reclaim.
+		 */
+		if (unlikely(splited && stat->nr_pageout > sc->nr_to_reclaim))
+			break;
+
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
 
@@ -1273,6 +1283,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if ((nr_pages > 1) && !folio_test_large(folio)) {
 			sc->nr_scanned -= (nr_pages - 1);
 			nr_pages = 1;
+			splited = true;
 		}
 
 		/*
@@ -1375,12 +1386,14 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				if (nr_pages > 1 && !folio_test_large(folio)) {
 					sc->nr_scanned -= (nr_pages - 1);
 					nr_pages = 1;
+					splited = true;
 				}
 				goto activate_locked;
 			case PAGE_SUCCESS:
 				if (nr_pages > 1 && !folio_test_large(folio)) {
 					sc->nr_scanned -= (nr_pages - 1);
 					nr_pages = 1;
+					splited = true;
 				}
 				stat->nr_pageout += nr_pages;
 
@@ -1491,6 +1504,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		if (nr_pages > 1) {
 			sc->nr_scanned -= (nr_pages - 1);
 			nr_pages = 1;
+			splited = true;
 		}
 activate_locked:
 		/* Not a candidate for swapping, so reclaim swap space. */
-- 
2.34.1


