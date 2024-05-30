Return-Path: <linux-kernel+bounces-194898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E05658D43E0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 04:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC6D1C231C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB181CD3B;
	Thu, 30 May 2024 02:52:08 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315C51B299
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 02:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037528; cv=none; b=I5iujMbCV8Y21/Gdk+SAtJ/Yv5serxV5zWoL78vNEKR1vqiJ2ZJPmHF343kb/KKEdeb7xjjuYA/+aIAAQIjCLpDxMemSbbevUC/CsLNFcUJCQUZ748zM1j9X5LReG9KTusxZ94tNhpttuvPakDRUYl312L6ywob1d3Y5+VIjNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037528; c=relaxed/simple;
	bh=L+VwcrUtOg3D0hw2Yq3XaVTSIIofg97YslyP9RS1e+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WXzbnbs6O28pLHwB6GgyhfJAnXAv7cz0JGBqgo222qODcMUY7tMduHujlHQTxbgi9bPYpCmKsoeZw2iB8sWwJLuOvZkJrwiC7PPuylvgveTCbokCNDQl2Gxz69JwgD9eiQSNP5qQZZ2rid4WHQBecVGd/eRUeqTYakP4GmSyPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 44U2poF8033765;
	Thu, 30 May 2024 10:51:50 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VqVzk0NfKz2Mx64M;
	Thu, 30 May 2024 10:48:02 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 30 May 2024 10:51:48 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki
	<urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes
	<lstoakes@gmail.com>, Baoquan He <bhe@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] mm: fix incorrect vbq reference in purge_fragmented_block
Date: Thu, 30 May 2024 10:51:44 +0800
Message-ID: <20240530025144.1570865-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 44U2poF8033765

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Broken vbq->free reported on a v6.6 based system which is caused
by invalid vbq->lock protect over vbq->free in purge_fragmented_block.
This should be introduced by the Fixes below which ignored vbq->lock
matter.

Fixes: fc1e0d980037 ("mm/vmalloc: prevent stale TLBs in fully utilized blocks")

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/vmalloc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 22aa63f4ef63..112b50431725 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2614,9 +2614,10 @@ static void free_vmap_block(struct vmap_block *vb)
 }
 
 static bool purge_fragmented_block(struct vmap_block *vb,
-		struct vmap_block_queue *vbq, struct list_head *purge_list,
-		bool force_purge)
+		struct list_head *purge_list, bool force_purge)
 {
+	struct vmap_block_queue *vbq;
+
 	if (vb->free + vb->dirty != VMAP_BBMAP_BITS ||
 	    vb->dirty == VMAP_BBMAP_BITS)
 		return false;
@@ -2625,6 +2626,8 @@ static bool purge_fragmented_block(struct vmap_block *vb,
 	if (!(force_purge || vb->free < VMAP_PURGE_THRESHOLD))
 		return false;
 
+	vbq = container_of(addr_to_vb_xa(vb->va->va_start),
+		struct vmap_block_queue, vmap_blocks);
 	/* prevent further allocs after releasing lock */
 	WRITE_ONCE(vb->free, 0);
 	/* prevent purging it again */
@@ -2664,7 +2667,7 @@ static void purge_fragmented_blocks(int cpu)
 			continue;
 
 		spin_lock(&vb->lock);
-		purge_fragmented_block(vb, vbq, &purge, true);
+		purge_fragmented_block(vb, &purge, true);
 		spin_unlock(&vb->lock);
 	}
 	rcu_read_unlock();
@@ -2801,7 +2804,7 @@ static void _vm_unmap_aliases(unsigned long start, unsigned long end, int flush)
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


