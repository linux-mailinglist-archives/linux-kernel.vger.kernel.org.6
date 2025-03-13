Return-Path: <linux-kernel+bounces-559450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87998A5F3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA613AF516
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BBA267AE1;
	Thu, 13 Mar 2025 12:09:32 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F81266B67
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867771; cv=none; b=UbqtY/TcjydMiMkKeJbtNzajQx3Cxwz2yOrF76EDhrkUgVtB/FTv1IoCiyEdmyfU8New2doA48FpOeoHuKmkGuMSc1zoxbZApLvXQ5ur5d+nZDiqM2Xbi78QQ+rI7yfabeF1tzaP3CIpxGZsQ7hPT+XTPdn+5tGh4YiO67E5Jvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867771; c=relaxed/simple;
	bh=+RFdnEFAFri2hpkX/ZUNN4h/qboM5E7p1+9yls2oJg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gyqQSIAv0VGFtDsM/HSJK6qPNbPYdCxWNXbxv2WfgKcWYUoERHMMot29TAeJCnt8Pbh81XtKuQePZ5lRsTc4egHNgZKqxXugpdT+E/H2Odt98YNM7NdjrfQNuCIJybmMKRZM/lPFeSxQdvMQBR6WFgFYUdLZMg4a5N5la855acI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZD5rc10f1z4f3jrd
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8EF9E1A1697
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCnsGPyytJnTaZeGQ--.9643S11;
	Thu, 13 Mar 2025 20:09:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] mm: swap: replace cluster_swap_free_nr() with swap_entries_put_[map/cache]()
Date: Fri, 14 Mar 2025 05:05:15 +0800
Message-Id: <20250313210515.9920-10-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCnsGPyytJnTaZeGQ--.9643S11
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy7Wr47tryrJryDJr1rtFb_yoW8Aw18pF
	93Wr1DKr4fJr1fKw4Ivw4DZrWav3ykGw1UJF9rWr1Fy3Z7tryIgF1vkrWxu345Gr95urZI
	kanrt3srWrs8tr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Replace cluster_swap_free_nr() with swap_entries_put_[map/cache]() to
remove repeat code and leverage batch-remove for entries with last flag.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 343b34eb2a81..c27cf09d84a6 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1570,21 +1570,6 @@ static void swap_entries_free(struct swap_info_struct *si,
 	__swap_entries_free(si, ci, entry, nr_pages);
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
@@ -1601,7 +1586,7 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
 
 	while (nr_pages) {
 		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-		cluster_swap_free_nr(sis, offset, nr, 1);
+		swap_entries_put_map(sis, swp_entry(sis->type, offset), nr);
 		offset += nr;
 		nr_pages -= nr;
 	}
@@ -3632,9 +3617,7 @@ int swapcache_prepare(swp_entry_t entry, int nr)
 
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


