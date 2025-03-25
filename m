Return-Path: <linux-kernel+bounces-574829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4738A6EA8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37152189424C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFC3255E58;
	Tue, 25 Mar 2025 07:30:09 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A725484D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887809; cv=none; b=B+JQOhwlWlA6rfawwXJVu4fnefhOKjqLgMoVRUP24e2QPwj/FdvwXrjgmvNqN73RMDWDio5qR0GLMuOJErkOX85ua+kBCdHc0umuWMareaCcp54di+XhLUHo6cxyS6koQkCZKtjU1yxdjD6bwqNYnNlcnDG9LSfYhnT+MngPQu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887809; c=relaxed/simple;
	bh=SXqMQIyY/ZuhYBGSg4pINUoyw3r/VZuDx6vd7kwbGug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzkCGNaThNCix7uTkCiSmWR+P5u8tpow873mQajt3Ngw7RdWuQEtjXtdKI8rnmFH4CyfQzOZfrnftrhFpBSXDvRffTizT6jdeq/KPtmShEbpSnGzIbCmu6Jcq0TFnJ54BBtZ0P9mNrYulvlIX5ZaTfeJ/iS2qAqAZe7Ouvtc+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZMM4Y3gwQz4f3lgM
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:29:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DD6D61A1391
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:29:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgB3M2ZxW+JnZofaHQ--.14216S9;
	Tue, 25 Mar 2025 15:29:57 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	tim.c.chen@linux.intel.com,
	bhe@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/8] mm: swap: factor out helper to drop cache of entries within a single cluster
Date: Wed, 26 Mar 2025 00:25:27 +0800
Message-Id: <20250325162528.68385-8-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB3M2ZxW+JnZofaHQ--.14216S9
X-Coremail-Antispam: 1UD129KBjvJXoW7WryftFWUuFWrKw1xWF1kGrg_yoW8ZFy8pF
	yagwn8Kr48Xr13Gw4Sqw45JayFv3yxW3W2qFy7Gr1av3Z3Jr10gFyqyrWa9r98Cr95uF98
	Ca4DKry2gF4jyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Factor out helper swap_entries_put_cache() from put_swap_folio() to serve
as a general-purpose routine for dropping cache flag of entries within a
single cluster.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 mm/swapfile.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 646efccdd2ec..40a7d75c01e8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1455,6 +1455,22 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
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
+	else {
+		for (int i = 0; i < nr; i++, entry.val++)
+			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
+	}
+	unlock_cluster(ci);
+}
+
 static bool swap_entries_put_map(struct swap_info_struct *si,
 				 swp_entry_t entry, int nr)
 {
@@ -1595,8 +1611,6 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
  */
 void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
-	unsigned long offset = swp_offset(entry);
-	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
 	int size = 1 << swap_entry_order(folio_order(folio));
 
@@ -1604,14 +1618,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
 	if (!si)
 		return;
 
-	ci = lock_cluster(si, offset);
-	if (swap_only_has_cache(si, offset, size))
-		swap_entries_free(si, ci, entry, size);
-	else {
-		for (int i = 0; i < size; i++, entry.val++)
-			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
-	}
-	unlock_cluster(ci);
+	swap_entries_put_cache(si, entry, size);
 }
 
 int __swap_count(swp_entry_t entry)
-- 
2.30.0


