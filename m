Return-Path: <linux-kernel+bounces-559448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ADEA5F3E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BEB417B95F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463F6267734;
	Thu, 13 Mar 2025 12:09:32 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9FA54654
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867770; cv=none; b=eKsA1aeW1K0vNTn0lDWcdtwFmABIYRxRPd5KoO7gnvsi/CCSiFt+FsQPys+eQt8MO5u1qk5ZckV8GKthZxF/dhGGxgtTJ0aJiXLsV3nAt3DAf8e0dmJ97HiObNGAyrVfy/kwtaWniBdLxzKKHGOpvLLbMuJOIwXsr/C4oEA+tVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867770; c=relaxed/simple;
	bh=K+C6Thnd1fMiMEXaduaPw+rWEgDJbOdEG0FCKmBb8/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GwL9ru2hUHvShx6SSr3etmQVMbb4mmy6NNcDJfWlurotFCs6S2wCbA/jWUItBEQS8xeGWbiJPXySZejmDkrzc0thd7arF9pmS8W4vHohRy03LmeULJos8HBFWya8fKq83OPFUK8udCXn6gOGi8+KN2FQfyFlWbapeyYHYh1B4yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZD5rX4FnBz4f3m7J
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7BC901A1199
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCnsGPyytJnTaZeGQ--.9643S3;
	Thu, 13 Mar 2025 20:09:24 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] mm: swap: rename __swap_[entry/entries]_free[_locked] to swap_[entry/entries]_put[_locked]
Date: Fri, 14 Mar 2025 05:05:07 +0800
Message-Id: <20250313210515.9920-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCnsGPyytJnTaZeGQ--.9643S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWUKFW5Zw1DuF4rGF47CFg_yoWrtFyxpF
	9Igrn8KFs7Xr1fGw4xXw48ZrWFvw4xWw18tFy7Gw1avasxJryFqFyDC3y7KFyUCr95Cr90
	ya1Utry7GF4jvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07js2-5UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

In __swap_entry_free[_locked] and __swap_entries_free, we decrease count
first and only free swap entry if count drops to zero. This behavior is
more akin to a put() operation rather than a free() operation. Therefore,
rename these functions with "put" instead of "free".
Additionally, add "_nr" suffix to swap_entries_put to indicate the input
range may span swap clusters.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
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


