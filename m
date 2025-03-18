Return-Path: <linux-kernel+bounces-565528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E84AA66A27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203803BBB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2251A5B98;
	Tue, 18 Mar 2025 06:10:39 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A81A316D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278238; cv=none; b=KZtOw5HlReWjNMS4t2VmU53ooJnqYHzkg2MsiTm8aJzie60bjl+P701jktpfWTJ18I3h/bjTOAFWBaAROofVhekQYjowjBD3gbh/cMmZfNP83OM184FDLioxnius5eDw1+t+rZ08KMV7oAYgmLWyyaoNbLYh5tQTVW1KXalQuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278238; c=relaxed/simple;
	bh=oN4/gIUYRrJ0tAMjk4oEuWB/HAh/Xcy6TWD5Z2oTMUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Udwh/iClzL2jlcRXS/PFS2Zj7lZMv8v61fiy3LA1NwWn32ElgWgDFzz3zdsBopNyl51LwMr62r2owksxun9CrW20BFz+zGDeKKpLZ9drCtYlE+n4GydzbJAC1JMDSDQ4FS0YUGi0OmBB6PsyI67wxpwpy49PekEO/gAZyd+qdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH1fH2LcXz4f3jkw
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9468B1A125B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgD3AGRVDtln65ErGw--.37695S8;
	Tue, 18 Mar 2025 14:10:32 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: tim.c.chen@linux.intel.com,
	ryncsn@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] mm: swap: free each cluster individually in swap_entries_put_map_nr()
Date: Tue, 18 Mar 2025 23:06:12 +0800
Message-Id: <20250318150614.6415-7-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgD3AGRVDtln65ErGw--.37695S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5Jw13Kr4xGr48CF17Wrg_yoWruFyrpF
	yagrn8Krs7Xr43Jr4xJw4DZrWrZ3yvgF1Uta47Gr1SywnxJr1rWFyvy3ySgFyUC34kur90
	y3W7K347uFs0qr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2
	AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
	1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
	s3kuDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

1. Factor out general swap_entries_put_map() helper to drop entries belong
to one cluster. If entries are last map, free entries in batch, otherwise
put entries with cluster lock acquired and released only once.
2. Iterate and call swap_entries_put_map() for each cluster in
swap_entries_put_nr() to leverage batch-remove for last map belong to one
cluster and reduce lock acquire/release in fallback case.
3. As swap_entries_put_nr() won't handle SWAP_HSA_CACHE drop, rename it to
swap_entries_put_map_nr().
4. As we won't drop each entry invidually with swap_entry_put() now, do
reclaim in free_swap_and_cache_nr() is because swap_entries_put_map_nr()
is general routine to drop reference and the relcaim work should only be
done in free_swap_and_cache_nr(). Remove stale comment accordingly.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 70 +++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 134b061ef1ae..370509eb2f1f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1455,25 +1455,10 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
-static unsigned char swap_entry_put(struct swap_info_struct *si,
-				    swp_entry_t entry)
-{
-	struct swap_cluster_info *ci;
-	unsigned long offset = swp_offset(entry);
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
+static bool swap_entries_put_map(struct swap_info_struct *si,
+				 swp_entry_t entry, int nr)
 {
 	unsigned long offset = swp_offset(entry);
-	unsigned int type = swp_type(entry);
 	struct swap_cluster_info *ci;
 	bool has_cache = false;
 	unsigned char count;
@@ -1484,14 +1469,10 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
 	count = swap_count(data_race(si->swap_map[offset]));
 	if (count != 1 && count != SWAP_MAP_SHMEM)
 		goto fallback;
-	/* cross into another cluster */
-	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
-		goto fallback;
 
 	ci = lock_cluster(si, offset);
 	if (!swap_is_last_map(si, offset, nr, &has_cache)) {
-		unlock_cluster(ci);
-		goto fallback;
+		goto locked_fallback;
 	}
 	if (!has_cache)
 		swap_entries_free(si, ci, entry, nr);
@@ -1503,15 +1484,34 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
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
+locked_fallback:
+	for (i = 0; i < nr; i++, entry.val++) {
+		count = swap_entry_put_locked(si, ci, entry, 1);
+		if (count == SWAP_HAS_CACHE)
+			has_cache = true;
+	}
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
 	}
+
 	return has_cache;
 }
 
@@ -1798,7 +1798,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	/*
 	 * First free all entries in the range.
 	 */
-	any_only_cache = swap_entries_put_nr(si, entry, nr);
+	any_only_cache = swap_entries_put_map_nr(si, entry, nr);
 
 	/*
 	 * Short-circuit the below loop if none of the entries had their
@@ -1808,13 +1808,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 		goto out;
 
 	/*
-	 * Now go back over the range trying to reclaim the swap cache. This is
-	 * more efficient for large folios because we will only try to reclaim
-	 * the swap once per folio in the common case. If we do
-	 * swap_entry_put() and __try_to_reclaim_swap() in the same loop, the
-	 * latter will get a reference and lock the folio for every individual
-	 * page but will only succeed once the swap slot for every subpage is
-	 * zero.
+	 * Now go back over the range trying to reclaim the swap cache.
 	 */
 	for (offset = start_offset; offset < end_offset; offset += nr) {
 		nr = 1;
-- 
2.30.0


