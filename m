Return-Path: <linux-kernel+bounces-574830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDD1A6EA8D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1736F189565E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF942561A3;
	Tue, 25 Mar 2025 07:30:09 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81107254B12
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887809; cv=none; b=CZxyAy2z08YKmO3cMOCbDPPr0k9l3umBF7DoYPmhX+m57BqWKvA7Rud7xO0dXsAo+Y3YA4H6ARE86/I+2gTgrlyO57xPQvzA2070okL6iLdVrYejhYmQu0GXKZDbF7x6Ya7qxDEPrQr0p9+jW7W3MSEanLieU8eBudeCUDUreAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887809; c=relaxed/simple;
	bh=kg2008o8v9Ytw+Eu2Cj8ewqnuTpD/zcWnBku8HIJQCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g05yIsRZxtCOy5IuzONMixKgQzDnZyCWjccHJttvwaGewJXoAOCAT4P75GjWLqyPeD1O1y+WmUZCyUwai6lkWqNWXisMK4e40hGDn7IaeKQXf+g6iynEWbpCGCV6TknKHFhCTR5N63LsKJAMQeDeVpjvO4MlMsn81DVUrJnwgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZMM4Y66fhz4f3m6Z
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:29:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3C6A21A1395
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:29:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgB3M2ZxW+JnZofaHQ--.14216S10;
	Tue, 25 Mar 2025 15:29:58 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	tim.c.chen@linux.intel.com,
	bhe@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] mm: swap: replace cluster_swap_free_nr() with swap_entries_put_[map/cache]()
Date: Wed, 26 Mar 2025 00:25:28 +0800
Message-Id: <20250325162528.68385-9-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB3M2ZxW+JnZofaHQ--.14216S10
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1DJr1rCFWUGryxXF4rGrg_yoW5Xw43pF
	93Wwn8Kr4xJr1xGr4fXw4DZFya93yxW3WUXFy7Ww1rZasFkryIqF1vyrZ7Cry5G34kuFZI
	k3W7tr9xuF4Yyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U09YFtUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Replace cluster_swap_free_nr() with swap_entries_put_[map/cache]() to
remove repeat code and leverage batch-remove for entries with last flag.
After removing cluster_swap_free_nr, only functions with "_nr" suffix
could free entries spanning cross clusters. Add corresponding description
in comment of swap_entries_put_map_nr() as is first function with "_nr"
suffix and have a non-suffix variant function swap_entries_put_map().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 mm/swapfile.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 40a7d75c01e8..c46b56d636af 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1512,6 +1512,11 @@ static bool swap_entries_put_map(struct swap_info_struct *si,
 
 }
 
+/*
+ * Only functions with "_nr" suffix are able to free entries spanning
+ * cross multi clusters, so ensure the range is within a single cluster
+ * when freeing entries with functions without "_nr" suffix.
+ */
 static bool swap_entries_put_map_nr(struct swap_info_struct *si,
 				    swp_entry_t entry, int nr)
 {
@@ -1569,21 +1574,6 @@ static void swap_entries_free(struct swap_info_struct *si,
 		partial_free_cluster(si, ci);
 }
 
-static void cluster_swap_free_nr(struct swap_info_struct *si,
-		unsigned long offset, int nr_pages,
-		unsigned char usage)
-{
-	struct swap_cluster_info *ci;
-	unsigned long end = offset + nr_pages;
-
-	ci = lock_cluster(si, offset);
-	do {
-		swap_entry_put_locked(si, ci, swp_entry(si->type, offset),
-				      usage);
-	} while (++offset < end);
-	unlock_cluster(ci);
-}
-
 /*
  * Caller has made sure that the swap device corresponding to entry
  * is still around or has not been recycled.
@@ -1600,7 +1590,7 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 
 	while (nr_pages) {
 		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-		cluster_swap_free_nr(sis, offset, nr, 1);
+		swap_entries_put_map(sis, swp_entry(sis->type, offset), nr);
 		offset += nr;
 		nr_pages -= nr;
 	}
@@ -3623,11 +3613,13 @@ int swapcache_prepare(swp_entry_t entry, int nr)
 	return __swap_duplicate(entry, SWAP_HAS_CACHE, nr);
 }
 
+/*
+ * Caller should ensure entries belong to the same folio so
+ * the entries won't span cross cluster boundary.
+ */
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
 {
-	unsigned long offset = swp_offset(entry);
-
-	cluster_swap_free_nr(si, offset, nr, SWAP_HAS_CACHE);
+	swap_entries_put_cache(si, entry, nr);
 }
 
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
-- 
2.30.0


