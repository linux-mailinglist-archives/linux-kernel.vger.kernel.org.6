Return-Path: <linux-kernel+bounces-526989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559DFA405FF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9953B47CD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A89200BB4;
	Sat, 22 Feb 2025 07:12:34 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7C1FCFE2
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208354; cv=none; b=h84HEHyoO1uYx8dMJiNzvG/F34LaiQRbHMwSImpwDU0BDUJE3aM1YGwixvtgmTS53iWy2GiC0ssS+iB/y/vVNR3eYgWZ4PCn98HT4ReQ21NewhDE+3wZu/O2BjH0fAPjaz+4suKqwPSv1MFuTwaDx9OFK4sDoc0zFsf7M176a7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208354; c=relaxed/simple;
	bh=Mn60az/QQlpq+cUO4+lmKvt2lCoarwt3UUdR5XG1++k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwJOnyT/oCIJOI99D9e7xvIApoRetxmxPlYXe33xWLiuc256oBXHPYagXDco2ibYmPE+C2vkyO0HqLl04xXApEzSsWtnznbruY6A8fIw+h2cr8EliZgKQu3VQoV0VXUBs9NDIHCXFZIxoL3fexDn4yjTMlnuomftSfMh7WZwxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z0J8k0jxwz4f3lDc
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 365641A058E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgBHBWjaeLlnrTsjEg--.26688S5;
	Sat, 22 Feb 2025 15:12:29 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] mm, swap: avoid BUG_ON in relocate_cluster()
Date: Sun, 23 Feb 2025 00:08:47 +0800
Message-Id: <20250222160850.505274-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250222160850.505274-1-shikemeng@huaweicloud.com>
References: <20250222160850.505274-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHBWjaeLlnrTsjEg--.26688S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17GFW7JF45GrW5Cr1xZrb_yoW8XFW3pr
	1fKF98tF4xtr4kGw45A3Z3JayrGw40gry5Gay3Xr1fCasxZr4xKFyvyr9avr98GF4kCa4D
	ZF1DKa4xuFn8A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
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

If allocation is racy with swapoff, we may call free_cluster for cluster
already in free list and trigger bug on as following:
Allocation                        Swapoff
cluster_alloc_swap_entry
 ...
 /* may get a free cluster with offset */
 offset = xxx;
 if (offset)
  ci = lock_cluster(si, offset);

                                  ...
                                   del_from_avail_list(p, true);
                                    si->flags &= ~SWP_WRITEOK;

  alloc_swap_scan_cluster(si, ci, ...)
   ...
   /* failed to alloc entry from free entry */
   if (!cluster_alloc_range(...))
    break;
   ...
   /* add back a free cluster */
   relocate_cluster(si, ci);
    if (!ci->count)
     free_cluster(si, ci);
      VM_BUG_ON(ci->flags == CLUSTER_FLAG_FREE);

Despite bug_on could be triggered, call free_cluster() for free cluster
only move cluster to tail of list and should be fine.

Check cluster is not free before calling free_cluster() in
relocate_cluster() to avoid bug_on.

Fixes: 3b644773eefda ("mm, swap: reduce contention on device lock")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 425126c0a07d..fc45b9d56639 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -653,7 +653,8 @@ static void relocate_cluster(struct swap_info_struct *si,
 		return;
 
 	if (!ci->count) {
-		free_cluster(si, ci);
+		if (ci->flags != CLUSTER_FLAG_FREE)
+			free_cluster(si, ci);
 	} else if (ci->count != SWAPFILE_CLUSTER) {
 		if (ci->flags != CLUSTER_FLAG_FRAG)
 			move_cluster(si, ci, &si->frag_clusters[ci->order],
-- 
2.30.0


