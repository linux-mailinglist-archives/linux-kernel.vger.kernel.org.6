Return-Path: <linux-kernel+bounces-565526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E732A66A26
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16A0172A11
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD91DE4DC;
	Tue, 18 Mar 2025 06:10:37 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8431A8F61
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278237; cv=none; b=f8eknoM2kpKrJLMhbJurSR5ZW0voSOaLiJdGptG2ZqDT2YDHtJ1bLowuoEkNN4t2LC2A/YdxpbWbwFScF9OSLf3/Y9mMCfOe2FgdnhR30MfyTA55qp4kT0H/zA+LEallK5VDsVNM01OYKKERKSbguiLJ6KeQowwCs28Ji4iNI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278237; c=relaxed/simple;
	bh=oqna5Rz45Q4X3GnawdekU8NIig5uLs/LkUqyBRC0S9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V0LHLfTgATizeTUmvYaiUUxBcgF7WRnW53MTCudDATJBW1Sxg6JMP6mSnQu+9QUP3B63m2h6LuVDJrz/oLD0Pc8PAv4hrIfmyjWm1+bIewZeOw2BjJCLj1gE1x0ussocsn9JSjJFkFvGM+WmgojCu2MgxPjVwc72dJF3cmHR1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH1f85Kd0z4f3m6S
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D37C31A1BCD
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgD3AGRVDtln65ErGw--.37695S9;
	Tue, 18 Mar 2025 14:10:32 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: tim.c.chen@linux.intel.com,
	ryncsn@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] mm: swap: factor out helper to drop cache of entries within a single cluster
Date: Tue, 18 Mar 2025 23:06:13 +0800
Message-Id: <20250318150614.6415-8-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgD3AGRVDtln65ErGw--.37695S9
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWkAFy8JF13WF4UXFy7Wrg_yoW8Zr43pF
	9Igwn8KF48Xr13Gw4xXw45JaySv3yxWw1UXFy7Gw13Z3Z3Jr10gFyqyrWavry5Crykur98
	Ca4ktry2gF1jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Factor out helper swap_entries_put_cache() from put_swap_folio() to server
as a general-purpose routine for dropping cache flag of entries within a
single cluster.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/swapfile.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 370509eb2f1f..919daaa3922a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1455,6 +1455,21 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
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
@@ -1588,8 +1603,6 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
  */
 void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
-	unsigned long offset = swp_offset(entry);
-	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
 	int size = 1 << swap_entry_order(folio_order(folio));
 
@@ -1597,13 +1610,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
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


