Return-Path: <linux-kernel+bounces-569091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D85A69E71
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D648188BE90
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930221DE4E7;
	Thu, 20 Mar 2025 02:52:55 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90AB2AE6A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742439175; cv=none; b=Xtj4p2euW6265RZdCgiTPkbIIuLwCJmLpvM3NCZ8P8Pf3GANQcygMecXjs1AkX/MgS23Oycpxyz7Of2+fu6lX0FMahyVmwQ1hs63U9dA4MbSHP+3CsyWREcrVpMQgkUvdoIjEkWu1vAR84UNyR2+P9UHG/11HAOLzQV8EnqkT3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742439175; c=relaxed/simple;
	bh=UwZytSL0yAwPGn0QNOeHia0F0VwHgcO4ocO5gsJlb4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ug8owv9NZRKkt1ZtLoTxU+a9gAsmPhto45PTMv+iGYt687S7KbI5t/vP8oRLqgOSjeBa6PuyZGFZCydi8HeQOsCa9NxQmWp7Y1VTvEVGn+HyLrc35vI4IPOEev9VoYy7zcIa9HWNClqFxCrjsxW5Cf+k0coAfmlYJ8G42fZHB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZJ9965FJVz4f3jcp
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:52:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 6980F1A13D6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:52:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgAHW8X_gttnYGGmGw--.42197S3;
	Thu, 20 Mar 2025 10:52:49 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	tim.c.chen@linux.intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] mm: swap: rename __swap_[entry/entries]_free[_locked] to swap_[entry/entries]_put[_locked]
Date: Thu, 20 Mar 2025 19:48:22 +0800
Message-Id: <20250320114829.25751-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250320114829.25751-1-shikemeng@huaweicloud.com>
References: <20250320114829.25751-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHW8X_gttnYGGmGw--.42197S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWUKFW5Zw1DuF4rGF47CFg_yoWrKr45pF
	9Igrn8KFs7Jr1xGws7Xw48Zr4Fvw4xW3W8tFy7Gw12vasxJryFqFyDC3y7KFyUCr95CF90
	ya1Utry7GF4jqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
	0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUswZ2
	DUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

In __swap_entry_free[_locked] and __swap_entries_free, we decrease count
first and only free swap entry if count drops to zero. This behavior is
more akin to a put() operation rather than a free() operation. Therefore,
rename these functions with "put" instead of "free".
Additionally, add "_nr" suffix to swap_entries_put to indicate the input
range may span swap clusters.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/swapfile.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 628f67974a7c..5a775456e26c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1347,9 +1347,9 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 	return NULL;
 }
 
-static unsigned char __swap_entry_free_locked(struct swap_info_struct *si,
-					      unsigned long offset,
-					      unsigned char usage)
+static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
+					   unsigned long offset,
+					   unsigned char usage)
 {
 	unsigned char count;
 	unsigned char has_cache;
@@ -1453,15 +1453,15 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
-static unsigned char __swap_entry_free(struct swap_info_struct *si,
-				       swp_entry_t entry)
+static unsigned char swap_entry_put(struct swap_info_struct *si,
+				    swp_entry_t entry)
 {
 	struct swap_cluster_info *ci;
 	unsigned long offset = swp_offset(entry);
 	unsigned char usage;
 
 	ci = lock_cluster(si, offset);
-	usage = __swap_entry_free_locked(si, offset, 1);
+	usage = swap_entry_put_locked(si, offset, 1);
 	if (!usage)
 		swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
 	unlock_cluster(ci);
@@ -1469,8 +1469,8 @@ static unsigned char __swap_entry_free(struct swap_info_struct *si,
 	return usage;
 }
 
-static bool __swap_entries_free(struct swap_info_struct *si,
-		swp_entry_t entry, int nr)
+static bool swap_entries_put_nr(struct swap_info_struct *si,
+				swp_entry_t entry, int nr)
 {
 	unsigned long offset = swp_offset(entry);
 	unsigned int type = swp_type(entry);
@@ -1501,7 +1501,7 @@ static bool __swap_entries_free(struct swap_info_struct *si,
 fallback:
 	for (i = 0; i < nr; i++) {
 		if (data_race(si->swap_map[offset + i])) {
-			count = __swap_entry_free(si, swp_entry(type, offset + i));
+			count = swap_entry_put(si, swp_entry(type, offset + i));
 			if (count == SWAP_HAS_CACHE)
 				has_cache = true;
 		} else {
@@ -1552,7 +1552,7 @@ static void cluster_swap_free_nr(struct swap_info_struct *si,
 
 	ci = lock_cluster(si, offset);
 	do {
-		if (!__swap_entry_free_locked(si, offset, usage))
+		if (!swap_entry_put_locked(si, offset, usage))
 			swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
 	} while (++offset < end);
 	unlock_cluster(ci);
@@ -1599,7 +1599,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 		swap_entry_range_free(si, ci, entry, size);
 	else {
 		for (int i = 0; i < size; i++, entry.val++) {
-			if (!__swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE))
+			if (!swap_entry_put_locked(si, offset + i, SWAP_HAS_CACHE))
 				swap_entry_range_free(si, ci, entry, 1);
 		}
 	}
@@ -1798,7 +1798,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	/*
 	 * First free all entries in the range.
 	 */
-	any_only_cache = __swap_entries_free(si, entry, nr);
+	any_only_cache = swap_entries_put_nr(si, entry, nr);
 
 	/*
 	 * Short-circuit the below loop if none of the entries had their
@@ -1811,7 +1811,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	 * Now go back over the range trying to reclaim the swap cache. This is
 	 * more efficient for large folios because we will only try to reclaim
 	 * the swap once per folio in the common case. If we do
-	 * __swap_entry_free() and __try_to_reclaim_swap() in the same loop, the
+	 * swap_entry_put() and __try_to_reclaim_swap() in the same loop, the
 	 * latter will get a reference and lock the folio for every individual
 	 * page but will only succeed once the swap slot for every subpage is
 	 * zero.
@@ -3758,7 +3758,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
  * into, carry if so, or else fail until a new continuation page is allocated;
  * when the original swap_map count is decremented from 0 with continuation,
  * borrow from the continuation and report whether it still holds more.
- * Called while __swap_duplicate() or caller of __swap_entry_free_locked()
+ * Called while __swap_duplicate() or caller of swap_entry_put_locked()
  * holds cluster lock.
  */
 static bool swap_count_continued(struct swap_info_struct *si,
-- 
2.30.0


