Return-Path: <linux-kernel+bounces-559442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1039A5F3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB8F1768FE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F75C266EFD;
	Thu, 13 Mar 2025 12:09:30 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CB1EF084
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867769; cv=none; b=Yv/PMz70nTDwnPflq9AMuq3tJgtFscOf79xJ6X7NVNzWye884WpvEE+dWUmw61xOdZJdtnMWd+3QMmXfakF3YiM2mltsecbWqZRouiOwXjWbFWDfB/5BV1slcivuyO+WrxAif5jhvs0anCb+5crUGxhzgzh0gUi1lv24K/dJjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867769; c=relaxed/simple;
	bh=Watlu32mQEUr0EHeSbFRfUzpvuA9/fTueq606bQNYaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3KZLPXWTSr1G2d8xQbgSUc+85hzWvOPwh76+SXIrk7RLOwPK4WTD578h74HGoNu6i210jTsRN7YuA2I8sBHW4B/zA/hqr8ni4UI/t1bJkdnOz42DbS7HzF2isFCXKsN4DyVzUv0tSaExx1tFIuN9Fu5rtjHM2RaX+dJo7nam/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZD5rX677Tz4f3mHb
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BA97D1A1614
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCnsGPyytJnTaZeGQ--.9643S4;
	Thu, 13 Mar 2025 20:09:24 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] mm: swap: factor out the actual swap entry freeing logic to new helper
Date: Fri, 14 Mar 2025 05:05:08 +0800
Message-Id: <20250313210515.9920-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCnsGPyytJnTaZeGQ--.9643S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF13JF4UXrykCF4DJF17GFg_yoW8Zry5pF
	nIgrn8Ga1xJr93GFZxAFn8Z34akw4Fg3W8WF9rGwnayas3JryIqFnrArWYkry5Ja4ku34a
	9Fs8Kr17uF4YyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsmiiDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Factor out the actual swap entry freeing logic to new helper
__swap_entries_free().
This allow us to futher simplify other swap entry freeing code by
leveraging __swap_entries_free() helper function.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5a775456e26c..7c886f9dd6f9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1347,6 +1347,25 @@ static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 	return NULL;
 }
 
+static inline void __swap_entries_free(struct swap_info_struct *si,
+				       struct swap_cluster_info *ci,
+				       swp_entry_t entry, unsigned int nr_pages)
+{
+	unsigned long offset = swp_offset(entry);
+
+	VM_BUG_ON(cluster_is_empty(ci));
+	VM_BUG_ON(ci->count < nr_pages);
+
+	ci->count -= nr_pages;
+	mem_cgroup_uncharge_swap(entry, nr_pages);
+	swap_range_free(si, offset, nr_pages);
+
+	if (!ci->count)
+		free_cluster(si, ci);
+	else
+		partial_free_cluster(si, ci);
+}
+
 static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
 					   unsigned long offset,
 					   unsigned char usage)
@@ -1525,22 +1544,13 @@ static void swap_entry_range_free(struct swap_info_struct *si,
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != offset_to_cluster(si, offset + nr_pages - 1));
-	VM_BUG_ON(cluster_is_empty(ci));
-	VM_BUG_ON(ci->count < nr_pages);
 
-	ci->count -= nr_pages;
 	do {
 		VM_BUG_ON(*map != SWAP_HAS_CACHE);
 		*map = 0;
 	} while (++map < map_end);
 
-	mem_cgroup_uncharge_swap(entry, nr_pages);
-	swap_range_free(si, offset, nr_pages);
-
-	if (!ci->count)
-		free_cluster(si, ci);
-	else
-		partial_free_cluster(si, ci);
+	__swap_entries_free(si, ci, entry, nr_pages);
 }
 
 static void cluster_swap_free_nr(struct swap_info_struct *si,
-- 
2.30.0


