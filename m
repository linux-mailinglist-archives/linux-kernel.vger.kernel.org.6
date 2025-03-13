Return-Path: <linux-kernel+bounces-559447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC65A5F3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA381899EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9FB267731;
	Thu, 13 Mar 2025 12:09:32 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7294262D38
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867770; cv=none; b=PHJoIUoXepY1VAesLtiGaEYrho8Dwmcx7rMMY5CAZo3Fq/q9paVx+13pXXG0QLR1etE6LvY/heyjgbSVI45DlXW5xtoggZP/Fle7rIU+BtjfbfnFxX8s9kJHLtQDY1tfZTfbJoq3o/XAJJL5CDEJGLqzSuDghJFrR4MdCILZ4GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867770; c=relaxed/simple;
	bh=jsDW7j7a6aZwVM9zgmMLLPc159swEv+yzr9HX/fNnzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HZyW7mo1HHQY2n8T74kWfuv3lfUgUb6H6M64zetPtBBLydEoIdS4QYBke7iWhTAZtv6eKiXl+0Ed9tLEjqn6KTl0lENtO1kHG5RXyAF9Tt99GZi2hdgfaEXJxfNq7Fpz4Ycn1auFLPUBSwJjkNiCC+Xzn6OK+oAS+hPHEBhSI7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZD5rb4XG5z4f3jrl
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1466F1A1697
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCnsGPyytJnTaZeGQ--.9643S9;
	Thu, 13 Mar 2025 20:09:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] mm: swap: free each cluster individually in swap_entries_put_map_nr()
Date: Fri, 14 Mar 2025 05:05:13 +0800
Message-Id: <20250313210515.9920-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250313210515.9920-1-shikemeng@huaweicloud.com>
References: <20250313210515.9920-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnsGPyytJnTaZeGQ--.9643S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGry8CF4rtFy3uryUAw1rtFb_yoW5tFy8pF
	yagrn8tr4xZr17Jr4xAws8ArWru3y0gF1jqF9rGr1Sy3srAr18WFyvy3yYvFyUC34kur98
	t3W7K347uFs8tr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIL05UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

1. Factor out general swap_entries_put_map() helper to drop entries belong
to one cluster. If entries are last map, free entries in batch, otherwise
put entries with cluster lock acquired and released only once.
2. Iterate and call swap_entries_put_map() for each cluster in
swap_entries_put_nr() to leverage batch-remove for last map belong to one
cluster and reduce lock acquire/release in fallback case.
3. As swap_entries_put_nr() won't handle SWAP_HSA_CACHE drop, rename it to
swap_entries_put_map_nr().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2d0f5d630211..ebac9ff74ba7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1473,25 +1473,10 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
-static unsigned char swap_entry_put(struct swap_info_struct *si,
-				    swp_entry_t entry)
+static bool swap_entries_put_map(struct swap_info_struct *si,
+				 swp_entry_t entry, int nr)
 {
-	struct swap_cluster_info *ci;
 	unsigned long offset = swp_offset(entry);
-	unsigned char usage;
-
-	ci = lock_cluster(si, offset);
-	usage = swap_entry_put_locked(si, ci, entry, 1);
-	unlock_cluster(ci);
-
-	return usage;
-}
-
-static bool swap_entries_put_nr(struct swap_info_struct *si,
-				swp_entry_t entry, int nr)
-{
-	unsigned long offset = swp_offset(entry);
-	unsigned int type = swp_type(entry);
 	struct swap_cluster_info *ci;
 	bool has_cache = false;
 	unsigned char count;
@@ -1502,9 +1487,6 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
 	count = swap_count(data_race(si->swap_map[offset]));
 	if (count != 1 && count != SWAP_MAP_SHMEM)
 		goto fallback;
-	/* cross into another cluster */
-	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
-		goto fallback;
 
 	ci = lock_cluster(si, offset);
 	if (!swap_is_last_map(si, offset, nr, &has_cache)) {
@@ -1521,15 +1503,33 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
 	return has_cache;
 
 fallback:
-	for (i = 0; i < nr; i++) {
-		if (data_race(si->swap_map[offset + i])) {
-			count = swap_entry_put(si, swp_entry(type, offset + i));
-			if (count == SWAP_HAS_CACHE)
-				has_cache = true;
-		} else {
-			WARN_ON_ONCE(1);
-		}
+	ci = lock_cluster(si, offset);
+	for (i = 0; i < nr; i++, entry.val++) {
+		count = swap_entry_put_locked(si, ci, entry, 1);
+		if (count == SWAP_HAS_CACHE)
+			has_cache = true;
 	}
+	unlock_cluster(ci);
+	return has_cache;
+
+}
+
+static bool swap_entries_put_map_nr(struct swap_info_struct *si,
+				    swp_entry_t entry, int nr)
+{
+	int cluster_nr, cluster_rest;
+	unsigned long offset = swp_offset(entry);
+	bool has_cache = false;
+
+	cluster_rest = SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER;
+	while (nr) {
+		cluster_nr = min(nr, cluster_rest);
+		has_cache |= swap_entries_put_map(si, entry, cluster_nr);
+		cluster_rest = SWAPFILE_CLUSTER;
+		nr -= cluster_nr;
+		entry.val += cluster_nr;
+	}
+
 	return has_cache;
 }
 
@@ -1807,7 +1807,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	/*
 	 * First free all entries in the range.
 	 */
-	any_only_cache = swap_entries_put_nr(si, entry, nr);
+	any_only_cache = swap_entries_put_map_nr(si, entry, nr);
 
 	/*
 	 * Short-circuit the below loop if none of the entries had their
-- 
2.30.0


