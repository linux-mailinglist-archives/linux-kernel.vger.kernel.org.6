Return-Path: <linux-kernel+bounces-559449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A92A1A5F3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9307C1899CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703F26772F;
	Thu, 13 Mar 2025 12:09:32 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552F1F152C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867770; cv=none; b=c3KubpvAbh3YRgyC8FCd5F7dyC+DG/1Wqp+cY48Z2c3+ZA8ajvzIFWxkEzcO08A0vb2O8wO5wfsCaiod+Q1gmQwOvink/5fYEYJM7FCEh3uutIAt0RKbLl4sKcjzttgVD7Ub8XI3dzU4ZY85Mxxa3aKwJFSWAZofxat0FdA+CEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867770; c=relaxed/simple;
	bh=+EFcCF5/6cYZkeBIbHkUNAr7o0ldpzhKTtdz7azgZPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rMT2TVEpAYyOV2vnALPf1mdU6Uhbw3h7YZe0HTIg56WSzCI7RpeHE9bury9MO0mdfiTV0IR7Q0OamUdRyrEn9FBLbIfMJJYlQnDEGM6gplPaVIRZyTODpvBRVG8gUxI+7J9o6MsQs0UCfsCeoy9DYQcBcSSsA4Ab1BfTh3FXv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZD5rh1DlHz4f3jkn
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3E5EF1A1695
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCnsGPyytJnTaZeGQ--.9643S6;
	Thu, 13 Mar 2025 20:09:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] mm: swap: remove unneeded VM_BUG_ON(*map != SWAP_HAS_CACHE) in swap_entry_range_free()
Date: Fri, 14 Mar 2025 05:05:10 +0800
Message-Id: <20250313210515.9920-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCnsGPyytJnTaZeGQ--.9643S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45tF15GrW8Gw1UJry7Wrg_yoW5CryrpF
	9agwn8KFs7Jr13KrW7Jw4qka1S9397WF18ZF9rGw1av3Z3Jry0qFyDArWjkFyUAFykuasI
	y3WDtr17Ga1jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3XTQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

As all callers of swap_entry_range_free() have already ensured slots to
be freed are marked as SWAP_HAS_CACHE while holding the cluster lock,
the BUG_ON check can be safely removed. After this, the function
swap_entry_range_free() could drop any kind of last flag, rename it to
swap_entries_free() and update it's comment accordingly.

This is a preparation to use swap_entries_free() to drop last 1 and
SWAP_MAP_SHMEM flag.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ba37b9bff586..14b7b37996ff 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -52,9 +52,9 @@
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
 static void free_swap_count_continuations(struct swap_info_struct *);
-static void swap_entry_range_free(struct swap_info_struct *si,
-				  struct swap_cluster_info *ci,
-				  swp_entry_t entry, unsigned int nr_pages);
+static void swap_entries_free(struct swap_info_struct *si,
+			      struct swap_cluster_info *ci,
+			      swp_entry_t entry, unsigned int nr_pages);
 static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries);
 static bool folio_swapcache_freeable(struct folio *folio);
@@ -1511,7 +1511,7 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
 	for (i = 0; i < nr; i++)
 		WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
 	if (!has_cache)
-		swap_entry_range_free(si, ci, entry, nr);
+		swap_entries_free(si, ci, entry, nr);
 	unlock_cluster(ci);
 
 	return has_cache;
@@ -1530,12 +1530,12 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
 }
 
 /*
- * Drop the last HAS_CACHE flag of swap entries, caller have to
- * ensure all entries belong to the same cgroup.
+ * Drop the last flag(1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM) of swap entries,
+ * caller have to ensure all entries belong to the same cgroup.
  */
-static void swap_entry_range_free(struct swap_info_struct *si,
-				  struct swap_cluster_info *ci,
-				  swp_entry_t entry, unsigned int nr_pages)
+static void swap_entries_free(struct swap_info_struct *si,
+			      struct swap_cluster_info *ci,
+			      swp_entry_t entry, unsigned int nr_pages)
 {
 	unsigned long offset = swp_offset(entry);
 	unsigned char *map = si->swap_map + offset;
@@ -1545,7 +1545,6 @@ static void swap_entry_range_free(struct swap_info_struct *si,
 	VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
 
 	do {
-		VM_BUG_ON(*map != SWAP_HAS_CACHE);
 		*map = 0;
 	} while (++map < map_end);
 
@@ -1605,7 +1604,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 
 	ci = lock_cluster(si, offset);
 	if (swap_only_has_cache(si, offset, size))
-		swap_entry_range_free(si, ci, entry, size);
+		swap_entries_free(si, ci, entry, size);
 	else
 		for (int i = 0; i < size; i++, entry.val++)
 			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
-- 
2.30.0


