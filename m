Return-Path: <linux-kernel+bounces-430545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922259E3296
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 05:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530E728441D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 04:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8817D354;
	Wed,  4 Dec 2024 04:11:41 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31A21684AE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733285501; cv=none; b=e6aMPGmhScllxGP5mRnttjb+4kTUSURSLGdgp1cpPq8N61WuVmC1ZtBwqxmhaMx6pNLFGzWjmmVLgyKVys5G2YoQ9IJ/AzSTWJxfsk9O/E69lfj4DG2j5Y2cxNW+FAxO/IZfPmDdzBu+5g6vulh8P+4j93fL0/6aCzHQAJbeDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733285501; c=relaxed/simple;
	bh=DnvxCW0uQgGc63ke0HSvipOoeq/+vHSA2+7Jepqthwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnTtivPIIl2orMNRJYPXEQrShD/tr5cuednzNAQtZO2jJpaPJtKSZvvAWDxTYuZiocnutU6h7ZqkC7NrBThBMRXbEo6UUsDc+OcyyN38ZHuTNYF6VNZhab630Ro2DT/bAVV89b3Y4HINRcdU2MXv9ALXnkNb6YdtDSBV8NvZf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y33x52kzDz4f3jqb
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:11:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 594461A058E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:11:35 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgBnQ8Bt1k9nusICDg--.38617S4;
	Wed, 04 Dec 2024 12:11:35 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	mhocko@suse.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	david@redhat.com,
	willy@infradead.org,
	ryan.roberts@arm.com,
	baohua@kernel.org,
	21cnbao@gmail.com,
	wangkefeng.wang@huawei.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com,
	xieym_ict@hotmail.com
Subject: [RFC PATCH v3 2/2] mm: vmscan: retry folios written back while isolated
Date: Wed,  4 Dec 2024 04:01:58 +0000
Message-Id: <20241204040158.2768519-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204040158.2768519-1-chenridong@huaweicloud.com>
References: <20241204040158.2768519-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBnQ8Bt1k9nusICDg--.38617S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyfKrWxGrWftr13tw47Jwb_yoW7tw45pF
	W3Wasrtw48Jr13tr43CF1DWFyFkrW8Xry8JFya9FW2y3W3Wr429FyDC34Yqr4UJrykAFyx
	JFZrAr95Wa1DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWbyZU
	UUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

An issue was found with the following testing step:
1. Compile with CONFIG_TRANSPARENT_HUGEPAGE=y, CONFIG_LRU_GEN_ENABLED=n.
2. Mount memcg v1, and create memcg named test_memcg and set
   usage_in_bytes=2.1G, memsw.usage_in_bytes=3G.
3. Use file as swap, and create a 1G swap.
4. Allocate 2.2G anon memory in test_memcg.

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

2. In shrink_page_list function, if folioN is THP(2M), it may be splited
   and added to swap cache folio by folio. After adding to swap cache,
   it will submit io to writeback folio to swap, which is asynchronous.
   When shrink_page_list is finished, the isolated folios list will be
   moved back to the head of inactive lru. The inactive lru may just look
   like this, with 512 filioes have been move to the head of inactive lru.

   folioN512<->folioN511<->...filioN1<->folio1<->folio2...<->folioN-1

   It committed io from folioN1 to folioN512, the later folios committed
   was added to head of the 'ret_folios' in the shrink_page_list function.
   As a result, the order was shown as folioN512->folioN511->...->folioN1.

3. When folio writeback io is completed, the folio may be rotated to tail
   of the lru one by one. It's assumed that filioN1,filioN2, ...,filioN512
   are completed in order(commit io in this order), and they are rotated to
   the tail of the LRU in order (filioN1<->...folioN511<->folioN512).
   Therefore, those folios that are tail of the lru will be reclaimed as
   soon as possible.

   folio1<->folio2<->...<->folioN-1<->filioN1<->...folioN511<->folioN512

4. However, shrink_page_list and folio writeback are asynchronous. If THP
   is splited, shrink_page_list loops at least 512 times, which means that
   shrink_page_list is not completed but some folios writeback have been
   completed, and this may lead to failure to rotate these folios to the
   tail of lru. The lru may look likes as below:

   folioN50<->folioN49<->...filioN1<->folio1<->folio2...<->folioN-1<->
   folioN51<->folioN52<->...folioN511<->folioN512

   Although those folios (N1-N50) have been finished writing back, they
   are still at the head of the lru. This is because their writeback_end
   occurred while it were still looping in shrink_folio_list(), causing
   folio_end_writeback()'s folio_rotate_reclaimable() to fail in moving
   these folios, which are not in the LRU but still in the 'folio_list',
   to the tail of the LRU.
   When isolating folios from lru, it scans from tail to head, so it is
   difficult to scan those folios again.

This issue is fixed when CONFIG_LRU_GEN_ENABLED is enabled with the
commit 359a5e1416ca ("mm: multi-gen LRU: retry folios written back while
isolated"). This issue should be fixed for active/inactive lru in the
same way.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index af1ff76f83e7..1f0d194f8b2f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1949,6 +1949,25 @@ static int current_may_throttle(void)
 	return !(current->flags & PF_LOCAL_THROTTLE);
 }
 
+static inline void acc_reclaimed_stat(struct reclaim_stat *stat,
+		struct reclaim_stat *curr)
+{
+	int i;
+
+	stat->nr_dirty += curr->nr_dirty;
+	stat->nr_unqueued_dirty += curr->nr_unqueued_dirty;
+	stat->nr_congested += curr->nr_congested;
+	stat->nr_writeback += curr->nr_writeback;
+	stat->nr_immediate += curr->nr_immediate;
+	stat->nr_pageout += curr->nr_pageout;
+	stat->nr_ref_keep += curr->nr_ref_keep;
+	stat->nr_unmap_fail += curr->nr_unmap_fail;
+	stat->nr_lazyfree_fail += curr->nr_lazyfree_fail;
+	stat->nr_demoted += curr->nr_demoted;
+	for (i = 0; i < ANON_AND_FILE; i++)
+		stat->nr_activate[i] = curr->nr_activate[i];
+}
+
 /*
  * shrink_inactive_list() is a helper for shrink_node().  It returns the number
  * of reclaimed pages
@@ -1958,14 +1977,16 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 		enum lru_list lru)
 {
 	LIST_HEAD(folio_list);
+	LIST_HEAD(clean_list);
 	unsigned long nr_scanned;
 	unsigned int nr_reclaimed = 0;
 	unsigned long nr_taken;
-	struct reclaim_stat stat;
+	struct reclaim_stat stat, curr;
 	bool file = is_file_lru(lru);
 	enum vm_event_item item;
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	bool stalled = false;
+	bool skip_retry = false;
 
 	while (unlikely(too_many_isolated(pgdat, file, sc))) {
 		if (stalled)
@@ -1999,10 +2020,20 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	if (nr_taken == 0)
 		return 0;
 
-	nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false);
+	memset(&stat, 0, sizeof(stat));
+retry:
+	nr_reclaimed += shrink_folio_list(&folio_list, pgdat, sc, &curr, false);
+	find_folios_written_back(&folio_list, &clean_list, skip_retry);
+	acc_reclaimed_stat(&stat, &curr);
 
 	spin_lock_irq(&lruvec->lru_lock);
 	move_folios_to_lru(lruvec, &folio_list);
+	if (!list_empty(&clean_list)) {
+		list_splice_init(&clean_list, &folio_list);
+		skip_retry = true;
+		spin_unlock_irq(&lruvec->lru_lock);
+		goto retry;
+	}
 
 	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
 					stat.nr_demoted);
-- 
2.34.1


