Return-Path: <linux-kernel+bounces-196209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C2F8D58D6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1CE81F258E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A5378C6C;
	Fri, 31 May 2024 03:05:49 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2A36134
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717124748; cv=none; b=FTDSwvB/YjsSPXWDXkpFP37/HO5l3D8HEb4av/kRd7bxEbmFZmasjltcPsQAZ+hVAcFv8SScloN17uFwD0gVkiGoZI8/syfdd69JxRJUsu6eMiwoUxAKtIq/aaGUB+33D3tDB/O5ad8cdC2/M41zolt9T210Day445w/Xxz7ORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717124748; c=relaxed/simple;
	bh=PcOaiwMIy0o3e+ZmFIWOayujeWmn4r2cX5BRChXf8t4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IKMzW2JnHzGFo8ENW3h58+bM4H4wY13S8T6+UhBXSh+4v72nKvyONU94XAutQGqVl7PCMPXsz4PFLlXMzLAQQ1c/9p+UOp06CppZRSVIXk9MU8kdwMDwCeLqTCmlU3a7/G4JAV4Bhm7JQoElsJOkPNCAoZpV/VQpOowBZq7Qsb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44V35RmE064534;
	Fri, 31 May 2024 11:05:27 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Vr7Dw3fpPz2QLg51;
	Fri, 31 May 2024 11:01:36 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 31 May 2024 11:05:24 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki
	<urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes
	<lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        hailong liu <hailong.liu@oppo.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCHv3] mm: fix incorrect vbq reference in purge_fragmented_block
Date: Fri, 31 May 2024 11:05:20 +0800
Message-ID: <20240531030520.1615833-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 44V35RmE064534

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

vmalloc area runs out in our ARM64 system during an erofs test as
vm_map_ram failed[1]. By following the debug log, we find that
vm_map_ram()->vb_alloc() will allocate new vb->va which corresponding
to 4MB vmalloc area as list_for_each_entry_rcu returns immediately
when vbq->free->next points to vbq->free. That is to say, 65536 times
of page fault after the list's broken will run out of the whole
vmalloc area. This should be introduced by one vbq->free->next point to
vbq->free which makes list_for_each_entry_rcu can not iterate the list
and find the BUG.

[1]
PID: 1        TASK: ffffff80802b4e00  CPU: 6    COMMAND: "init"
 #0 [ffffffc08006afe0] __switch_to at ffffffc08111d5cc
 #1 [ffffffc08006b040] __schedule at ffffffc08111dde0
 #2 [ffffffc08006b0a0] schedule at ffffffc08111e294
 #3 [ffffffc08006b0d0] schedule_preempt_disabled at ffffffc08111e3f0
 #4 [ffffffc08006b140] __mutex_lock at ffffffc08112068c
 #5 [ffffffc08006b180] __mutex_lock_slowpath at ffffffc08111f8f8
 #6 [ffffffc08006b1a0] mutex_lock at ffffffc08111f834
 #7 [ffffffc08006b1d0] reclaim_and_purge_vmap_areas at ffffffc0803ebc3c
 #8 [ffffffc08006b290] alloc_vmap_area at ffffffc0803e83fc
 #9 [ffffffc08006b300] vm_map_ram at ffffffc0803e78c0

Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")

Suggested-by: Hailong.Liu <hailong.liu@oppo.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
v2: introduce cpu in vmap_block to record the right CPU number
v3: use get_cpu/put_cpu to prevent schedule between core
---
---
 mm/vmalloc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 22aa63f4ef63..ecdb75d10949 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2458,6 +2458,7 @@ struct vmap_block {
 	struct list_head free_list;
 	struct rcu_head rcu_head;
 	struct list_head purge;
+	unsigned int cpu;
 };
 
 /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
@@ -2586,10 +2587,12 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 		return ERR_PTR(err);
 	}
 
+	vb->cpu = get_cpu();
 	vbq = raw_cpu_ptr(&vmap_block_queue);
 	spin_lock(&vbq->lock);
 	list_add_tail_rcu(&vb->free_list, &vbq->free);
 	spin_unlock(&vbq->lock);
+	put_cpu();
 
 	return vaddr;
 }
@@ -2614,9 +2617,10 @@ static void free_vmap_block(struct vmap_block *vb)
 }
 
 static bool purge_fragmented_block(struct vmap_block *vb,
-		struct vmap_block_queue *vbq, struct list_head *purge_list,
-		bool force_purge)
+		struct list_head *purge_list, bool force_purge)
 {
+	struct vmap_block_queue *vbq = &per_cpu(vmap_block_queue, vb->cpu);
+
 	if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
 	    vb->dirty == VMAP_BBMAP_BITS)
 		return false;
@@ -2664,7 +2668,7 @@ static void purge_fragmented_blocks(int cpu)
 			continue;
 
 		spin_lock(&vb->lock);
-		purge_fragmented_block(vb, vbq, &purge, true);
+		purge_fragmented_block(vb, &purge, true);
 		spin_unlock(&vb->lock);
 	}
 	rcu_read_unlock();
@@ -2801,7 +2805,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
 			 * not purgeable, check whether there is dirty
 			 * space to be flushed.
 			 */
-			if (!purge_fragmented_block(vb, vbq, &purge_list, false) &&
+			if (!purge_fragmented_block(vb, &purge_list, false) &&
 			    vb->dirty_max && vb->dirty != VMAP_BBMAP_BITS) {
 				unsigned long va_start = vb->va->va_start;
 				unsigned long s, e;
-- 
2.25.1


