Return-Path: <linux-kernel+bounces-565523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C0A66A23
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575E31897A03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368481DC05F;
	Tue, 18 Mar 2025 06:10:37 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8661537CB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278236; cv=none; b=Kt4WVIBPypQCVFTw/l35GsGwqQFFD4UnYwTN9+jL3ECqzqSyuQW2voafKMsbW6uhBqt5mwEzDTUlJAi0G8UKshCvZsx4esbQaUQq0xE6TME7B9kmoT20N1WIHCglY6IcfzQK9BLYRh9fvnyNrPXLCyMvayE5vpDYpBR2bEctGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278236; c=relaxed/simple;
	bh=GUb99Lj/OwfZW0EwweWP6qWw+RN3IGEAx9Posv6ktC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r/SS0Dnqo7OYRJ138QwShX3hdfcju1ycU+/0WGyS7fOAgL5HijnCDNIbmSsD13x719KPlcKMUlJKBJ7cQpj2lY6H0KmmdBhHXYSg2yXdMlmktT1+/6x27BMowMeqWWnpKBFw9pz3RtK6bzaH7+wxGHdJsjEU0Yig6JSx69Wsrg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH1f72R9gz4f3m6n
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6FAA51A01A1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:31 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgD3AGRVDtln65ErGw--.37695S4;
	Tue, 18 Mar 2025 14:10:31 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: tim.c.chen@linux.intel.com,
	ryncsn@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] mm: swap: remove unneeded VM_BUG_ON(*map != SWAP_HAS_CACHE) in swap_entry_range_free()
Date: Tue, 18 Mar 2025 23:06:08 +0800
Message-Id: <20250318150614.6415-3-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250318150614.6415-1-shikemeng@huaweicloud.com>
References: <20250318150614.6415-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgD3AGRVDtln65ErGw--.37695S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45tF15GrW8Gw1UJrW5Jrb_yoWrXFy5pF
	9Igrn8Kr4xAF13K3y3Jw45tw4Sv3yxWw10gF9rGw1av3ZxJry0qFyDA3yjkFy5A3s5uasI
	k3WDtr17WF4jvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
	0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUVveH
	DUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

As all callers of swap_entry_range_free() have already ensured slots to
be freed are marked as SWAP_HAS_CACHE while holding the cluster lock,
the BUG_ON check can be safely removed. After this, the function
swap_entry_range_free() could drop any kind of last flag, rename it to
swap_entries_free() and update it's comment accordingly.

This is a preparation to use swap_entries_free() to drop last ref count
and SWAP_MAP_SHMEM flag.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/swapfile.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5a775456e26c..0aa7ce82c013 100644
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
@@ -1463,7 +1463,7 @@ static unsigned char swap_entry_put(struct swap_info_struct *si,
 	ci = lock_cluster(si, offset);
 	usage = swap_entry_put_locked(si, offset, 1);
 	if (!usage)
-		swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
+		swap_entries_free(si, ci, swp_entry(si->type, offset), 1);
 	unlock_cluster(ci);
 
 	return usage;
@@ -1493,7 +1493,7 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
 	for (i = 0; i < nr; i++)
 		WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
 	if (!has_cache)
-		swap_entry_range_free(si, ci, entry, nr);
+		swap_entries_free(si, ci, entry, nr);
 	unlock_cluster(ci);
 
 	return has_cache;
@@ -1512,12 +1512,12 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
 }
 
 /*
- * Drop the last HAS_CACHE flag of swap entries, caller have to
- * ensure all entries belong to the same cgroup.
+ * Drop the last flag(1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM) of swap entries,
+ * caller have to ensure all entries belong to the same cgroup and cluster.
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
@@ -1530,7 +1530,6 @@ static void swap_entry_range_free(struct swap_info_struct *si,
 
 	ci->count -= nr_pages;
 	do {
-		VM_BUG_ON(*map != SWAP_HAS_CACHE);
 		*map = 0;
 	} while (++map < map_end);
 
@@ -1553,7 +1552,7 @@ static void cluster_swap_free_nr(struct swap_info_struct *si,
 	ci = lock_cluster(si, offset);
 	do {
 		if (!swap_entry_put_locked(si, offset, usage))
-			swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
+			swap_entries_free(si, ci, swp_entry(si->type, offset), 1);
 	} while (++offset < end);
 	unlock_cluster(ci);
 }
@@ -1596,11 +1595,11 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 
 	ci = lock_cluster(si, offset);
 	if (swap_only_has_cache(si, offset, size))
-		swap_entry_range_free(si, ci, entry, size);
+		swap_entries_free(si, ci, entry, size);
 	else {
 		for (int i = 0; i < size; i++, entry.val++) {
 			if (!swap_entry_put_locked(si, offset + i, SWAP_HAS_CACHE))
-				swap_entry_range_free(si, ci, entry, 1);
+				swap_entries_free(si, ci, entry, 1);
 		}
 	}
 	unlock_cluster(ci);
-- 
2.30.0


