Return-Path: <linux-kernel+bounces-559446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E24A5F3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BF43AA71A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2934126772A;
	Thu, 13 Mar 2025 12:09:32 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008F2266B5F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867770; cv=none; b=s1yaV3x0l23iFSswLSVVCel2EO30Z+bgxDBbT++vHEBP/vBIppoVWUATkhTJ0XBI/kGy3s7iSN5o5mkaEK8T+vHiCA+4RN1y4Bit85QELAfn+PzW1RPHjs7dmp3iklGEn/QOi/I/5+qekJBC/EqqS3QFnWcoFM2/GMMDBcsF3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867770; c=relaxed/simple;
	bh=phExd1IhDL3I3mCEX1pldEAIZl6Lf8yYKt4S94nEJiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OP2n66HwdIG72p/5qFTs5wZcsN71e/u5fRZ3rgbW7A8j4BhaF4CnOS7NcuS3yGtzwWKZVrWduXLkyfHSz+OINBlcJ8G6jnr2Fk/HO2jkIf/kKILpPvioL89pQClge8guQYnFYsP84txtIDW3qzG4LO7ZYo4KmJvi1TpSkC2Dlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZD5rZ360Fz4f3mHb
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 51D5E1A06DC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCnsGPyytJnTaZeGQ--.9643S10;
	Thu, 13 Mar 2025 20:09:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] mm: swap: factor out helper to drop cache of entries within a single cluster
Date: Fri, 14 Mar 2025 05:05:14 +0800
Message-Id: <20250313210515.9920-9-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgCnsGPyytJnTaZeGQ--.9643S10
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWkAF4DJr4rGryrJF13Arb_yoW8CFykpF
	9Igrn8KF48Xr13Gw4xJw45J3ySv3yIg3WUZFy7Gw13Z3Z3Jr10gFyqyrWa9ryYkr95ur98
	Ca48try2gF1jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Factor out helper swap_entries_put_cache() from put_swap_folio() to server
as a general-purpose routine for dropping cache flag of entries within a
single cluster.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ebac9ff74ba7..343b34eb2a81 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1473,6 +1473,21 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 }
 
+static void swap_entries_put_cache(struct swap_info_struct *si,
+				   swp_entry_t entry, int nr)
+{
+	unsigned long offset = swp_offset(entry);
+	struct swap_cluster_info *ci;
+
+	ci = lock_cluster(si, offset);
+	if (swap_only_has_cache(si, offset, nr))
+		swap_entries_free(si, ci, entry, nr);
+	else
+		for (int i = 0; i < nr; i++, entry.val++)
+			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
+	unlock_cluster(ci);
+}
+
 static bool swap_entries_put_map(struct swap_info_struct *si,
 				 swp_entry_t entry, int nr)
 {
@@ -1597,8 +1612,6 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
  */
 void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
-	unsigned long offset = swp_offset(entry);
-	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
 	int size = 1 << swap_entry_order(folio_order(folio));
 
@@ -1606,13 +1619,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	if (!si)
 		return;
 
-	ci = lock_cluster(si, offset);
-	if (swap_only_has_cache(si, offset, size))
-		swap_entries_free(si, ci, entry, size);
-	else
-		for (int i = 0; i < size; i++, entry.val++)
-			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
-	unlock_cluster(ci);
+	swap_entries_put_cache(si, entry, size);
 }
 
 int __swap_count(swp_entry_t entry)
-- 
2.30.0


