Return-Path: <linux-kernel+bounces-526919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE86A4052A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 03:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FD1423B39
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 02:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45081FCFE2;
	Sat, 22 Feb 2025 02:56:07 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D431E3DED
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740192967; cv=none; b=tYyDrVN1PxQ95Pvi0Xvwcs/shGVHBTGQv67DOG7XB4zqVEeU2nqbsTJwUxh7njshtsH8aDU5v91FiZ7I1YnEaC30Bzz+Bme7dr3ylBt1deiBTdmfl9CLC+Ov1DeM/Vj/vKZY9bHsv4OoKJE5ygkm2bB6GoaW03jbcjZ2b7Lys+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740192967; c=relaxed/simple;
	bh=o1UeAH8rphWnQoSLtNILzpujqiTvjfWuVuFnhUsFbR0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=emvdE9QjivkZm1ioeGVioY0mKV76AhiZ9t59qMxu/CQRFqtv7VHkAaAquoyK7aC15DyXFf9zmdq3NQV0MhnhNTl8uejHphEL4nUo1MNGGm/t6H1SMmyFwg6ibvTKsOJacrITjfVP8pwHOs0N59yKBUhkpWw/Eft9iu6rqesskbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z0BRL1vgyzWvFM;
	Sat, 22 Feb 2025 10:54:22 +0800 (CST)
Received: from kwepemg100017.china.huawei.com (unknown [7.202.181.58])
	by mail.maildlp.com (Postfix) with ESMTPS id 249D21400FD;
	Sat, 22 Feb 2025 10:55:55 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemg100017.china.huawei.com
 (7.202.181.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 22 Feb
 2025 10:55:54 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>
CC: <david@redhat.com>, <kasong@tencent.com>, <ryan.roberts@arm.com>,
	<chrisl@kernel.org>, <huang.ying.caritas@gmail.com>,
	<schatzberg.dan@gmail.com>, <baohua@kernel.org>, <hanchuanhua@oppo.com>,
	<willy@infradead.org>, <mawupeng1@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] mm: swap: Avoid infinite loop if no valid swap entry found during do_swap_page
Date: Sat, 22 Feb 2025 10:46:17 +0800
Message-ID: <20250222024617.2790609-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg100017.china.huawei.com (7.202.181.58)

From: Ma Wupeng <mawupeng1@huawei.com>

During our test, infinite loop is produced during #PF will lead to infinite
error log as follow:

   get_swap_device: Bad swap file entry 114000000

Digging into the source, we found that the swap entry is invalid due to
unknown reason, and this lead to invalid swap_info_struct. Excessive log
printing can fill up the prioritized log space, leading to the purging of
originally valid logs and hindering problem troubleshooting. To make this
more robust, kill this task.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 include/linux/swap.h | 1 +
 mm/memory.c          | 9 ++++++++-
 mm/swapfile.c        | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b13b72645db3..0fa39cf66bc4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -508,6 +508,7 @@ struct backing_dev_info;
 extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
 extern void exit_swap_address_space(unsigned int type);
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
+struct swap_info_struct *_swap_info_get(swp_entry_t entry);
 sector_t swap_folio_sector(struct folio *folio);
 
 static inline void put_swap_device(struct swap_info_struct *si)
diff --git a/mm/memory.c b/mm/memory.c
index b4d3d4893267..2d36e5a644d1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4365,8 +4365,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	/* Prevent swapoff from happening to us. */
 	si = get_swap_device(entry);
-	if (unlikely(!si))
+	if (unlikely(!si)) {
+		if (unlikely(!_swap_info_get(entry)))
+			/*
+			 * return VM_FAULT_SIGBUS for invalid swap entry to
+			 * avoid infinite #PF.
+			 */
+			ret = VM_FAULT_SIGBUS;
 		goto out;
+	}
 
 	folio = swap_cache_get_folio(entry, vma, vmf->address);
 	if (folio)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ba19430dd4ea..8f580eff0ecb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1287,7 +1287,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
 	return n_ret;
 }
 
-static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
+struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 {
 	struct swap_info_struct *si;
 	unsigned long offset;
-- 
2.43.0


