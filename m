Return-Path: <linux-kernel+bounces-559444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC3CA5F3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9278E189A4FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82A3266EF4;
	Thu, 13 Mar 2025 12:09:30 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30E1FAC51
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867770; cv=none; b=jhRT3ANIdOYwdpmT9SFTM+Jo9ATcR5sjDKMERh1WW0yCYW+043ngIEhHybRNiTru3Rt/pUpaTI6fJ/EY3n9xo/ZBrlfA00n7Hv93UOfjD4o8mwDwuoebYQDnG9xUtV0FtQ9+PZMzey63KWzouiBlK4XTuaic4dSprnR55tm4AGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867770; c=relaxed/simple;
	bh=h4Mxghdi5fRQZt+NzNnL6Ag/UNAtkzSc8WHhzBml3Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9igKf1D9BWHdkgBmKBJU5vHzWtJ5CY19643BVqrbkKnHHzjkapOM3aGzTGDbI1x47V8NSipag/3aIkTHsagir+QevyCd/R0zVZkN11YqUMgX9zFXyfBqTu/cnH3eIZOsj1GpF/4jSoSIlwtMF9pRwU8QJi7iia2oP/xnXMy9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZD5rZ4FpSz4f3jrh
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 06E2C1A1693
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCnsGPyytJnTaZeGQ--.9643S5;
	Thu, 13 Mar 2025 20:09:24 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] mm: swap: use __swap_entry_free() to free swap entry in swap_entry_put_locked()
Date: Fri, 14 Mar 2025 05:05:09 +0800
Message-Id: <20250313210515.9920-4-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCnsGPyytJnTaZeGQ--.9643S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZF13AF1UArW3Jw4xXFyxXwb_yoW5WrW8pF
	9Igrs8tF4xZr17K3yrJw45ZayFvw4xWw10qFnrGw13ZasxXryFgFyDC3y2gFyUA3s5uF98
	Z3WUtr17ur42vFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3G-eDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

In swap_entry_put_locked(), we will set slot to SWAP_HAS_CACHE before
using swap_entry_range_free to do actual swap entry freeing. This
introduce an unnecessary intermediate state.
By using __swap_entry_free() in swap_entry_put_locked(), we can eliminate
the need to set slot to SWAP_HAS_CACHE.
This change would make the behavior of swap_entry_put_locked() more
consistent with other put() operations which will do actual free work
after put last reference.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7c886f9dd6f9..ba37b9bff586 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1367,9 +1367,11 @@ static inline void __swap_entries_free(struct swap_info_struct *si,
 }
 
 static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
-					   unsigned long offset,
+					   struct swap_cluster_info *ci,
+					   swp_entry_t entry,
 					   unsigned char usage)
 {
+	unsigned long offset = swp_offset(entry);
 	unsigned char count;
 	unsigned char has_cache;
 
@@ -1398,10 +1400,9 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
 	}
 
 	usage = count | has_cache;
-	if (usage)
-		WRITE_ONCE(si->swap_map[offset], usage);
-	else
-		WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
+	WRITE_ONCE(si->swap_map[offset], usage);
+	if (!usage)
+		__swap_entries_free(si, ci, entry, 1);
 
 	return usage;
 }
@@ -1480,9 +1481,7 @@ static unsigned char swap_entry_put(struct swap_info_struct *si,
 	unsigned char usage;
 
 	ci = lock_cluster(si, offset);
-	usage = swap_entry_put_locked(si, offset, 1);
-	if (!usage)
-		swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
+	usage = swap_entry_put_locked(si, ci, entry, 1);
 	unlock_cluster(ci);
 
 	return usage;
@@ -1562,8 +1561,8 @@ static void cluster_swap_free_nr(struct swap_info_struct *si,
 
 	ci = lock_cluster(si, offset);
 	do {
-		if (!swap_entry_put_locked(si, offset, usage))
-			swap_entry_range_free(si, ci, swp_entry(si->type, offset), 1);
+		swap_entry_put_locked(si, ci, swp_entry(si->type, offset),
+				      usage);
 	} while (++offset < end);
 	unlock_cluster(ci);
 }
@@ -1607,12 +1606,9 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	ci = lock_cluster(si, offset);
 	if (swap_only_has_cache(si, offset, size))
 		swap_entry_range_free(si, ci, entry, size);
-	else {
-		for (int i = 0; i < size; i++, entry.val++) {
-			if (!swap_entry_put_locked(si, offset + i, SWAP_HAS_CACHE))
-				swap_entry_range_free(si, ci, entry, 1);
-		}
-	}
+	else
+		for (int i = 0; i < size; i++, entry.val++)
+			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
 	unlock_cluster(ci);
 }
 
-- 
2.30.0


