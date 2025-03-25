Return-Path: <linux-kernel+bounces-574824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3330AA6EA85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85EFC1895D81
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE0253F2D;
	Tue, 25 Mar 2025 07:30:02 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876008460
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887802; cv=none; b=RlIwM5QEvO6TneYNVT5ADoCBhryA19THdtKQIsysRrVvMkFU92wS5vGofVI7S72KJ/9cHcRPG6KzqadBahwSB0vzUTY0TO/UFtxPX7P68rW194Yo43TLkoAt+z6Mdcg777Flz+4Ol5/LKwcOkbbDpF9Pmh+DBJQ+RrBCoaPF1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887802; c=relaxed/simple;
	bh=Z75aPq0P8nppX6H++h8UDdOA4bj5HnoylTkS8+FLzGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSikO3gTdAfsLFlqLVZOmWXGDmhx4T3p8VT3ASPjcgSh2YOhyGKVf5kYVrwPiHUnqh7gDyAez4fehcaMTCZajxSzgg1X8pC58w7Jpmayp8iBveiWkCsuveI8TpskZYZ5N8HFhev3P7pk28rp9p4XAFSipO7cnM6age9Tf97aMWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZMM4Y5BP8z4f3jYH
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:29:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 967791A11E2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:29:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgB3M2ZxW+JnZofaHQ--.14216S5;
	Tue, 25 Mar 2025 15:29:56 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	tim.c.chen@linux.intel.com,
	bhe@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] mm: swap: use swap_entries_free() to free swap entry in swap_entry_put_locked()
Date: Wed, 26 Mar 2025 00:25:23 +0800
Message-Id: <20250325162528.68385-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250325162528.68385-1-shikemeng@huaweicloud.com>
References: <20250325162528.68385-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3M2ZxW+JnZofaHQ--.14216S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1DKr13Gr4xKr1ktrW3trb_yoW5Wr4xpF
	ZIgr4DtF48Ar17Kw45Aw45ZayFvw4xWw1jqF9rGw15ZasxJryFgFyDA3y2gFyUA3s8uas8
	A3WUtr17uF4jyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI
	0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUa75r
	DUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

In swap_entry_put_locked(), we will set slot to SWAP_HAS_CACHE before
using swap_entries_free() to do actual swap entry freeing. This
introduce an unnecessary intermediate state.
By using swap_entries_free() in swap_entry_put_locked(), we can
eliminate the need to set slot to SWAP_HAS_CACHE.
This change would make the behavior of swap_entry_put_locked() more
consistent with other put() operations which will do actual free work
after put last reference.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 mm/swapfile.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 76720ca76aae..d05b58e9c723 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1348,9 +1348,11 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
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
 
@@ -1382,7 +1384,7 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
 	if (usage)
 		WRITE_ONCE(si->swap_map[offset], usage);
 	else
-		WRITE_ONCE(si->swap_map[offset], SWAP_HAS_CACHE);
+		swap_entries_free(si, ci, entry, 1);
 
 	return usage;
 }
@@ -1461,9 +1463,7 @@ static unsigned char swap_entry_put(struct swap_info_struct *si,
 	unsigned char usage;
 
 	ci = lock_cluster(si, offset);
-	usage = swap_entry_put_locked(si, offset, 1);
-	if (!usage)
-		swap_entries_free(si, ci, swp_entry(si->type, offset), 1);
+	usage = swap_entry_put_locked(si, ci, entry, 1);
 	unlock_cluster(ci);
 
 	return usage;
@@ -1558,8 +1558,8 @@ static void cluster_swap_free_nr(struct swap_info_struct *si,
 
 	ci = lock_cluster(si, offset);
 	do {
-		if (!swap_entry_put_locked(si, offset, usage))
-			swap_entries_free(si, ci, swp_entry(si->type, offset), 1);
+		swap_entry_put_locked(si, ci, swp_entry(si->type, offset),
+				      usage);
 	} while (++offset < end);
 	unlock_cluster(ci);
 }
@@ -1604,10 +1604,8 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	if (swap_only_has_cache(si, offset, size))
 		swap_entries_free(si, ci, entry, size);
 	else {
-		for (int i = 0; i < size; i++, entry.val++) {
-			if (!swap_entry_put_locked(si, offset + i, SWAP_HAS_CACHE))
-				swap_entries_free(si, ci, entry, 1);
-		}
+		for (int i = 0; i < size; i++, entry.val++)
+			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
 	}
 	unlock_cluster(ci);
 }
-- 
2.30.0


