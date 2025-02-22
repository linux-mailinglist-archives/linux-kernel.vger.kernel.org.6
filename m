Return-Path: <linux-kernel+bounces-526994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF51A405FE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922BA19C7AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B542045B9;
	Sat, 22 Feb 2025 07:12:36 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C191FBE80
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208355; cv=none; b=d93u7trIa+MvHmGOvxf0tzZ45NDyU7hPQteBmoXNvdGkcSjQ68ajJMtMgKJofiv+Tg+4D6+1iVuJYbIBWXbhZJzovh645YuE7a+7nFSUqDS/RkqpIuCHkz1+0vSAzAg+8HIJ7gGs+ftN/LcuoaxaCDjIlO2++IqS8amS2LC5wN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208355; c=relaxed/simple;
	bh=M/qi547sbYwVzGNEFb6kPaPNCMKTQxSid3NaA8xXMZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snY87WKvSCva2D9y1nUUj/OiluVMAinVW9XxoD1+jNpCHl0Md8bnJTYtriAUDlIHCK0P3NQQgNenRzIJrZszN1vrdkxVqQH2lKDhz0kksqxe6xsU4hjr0Zn2ZLuVHnbeaHovTer5o2A8wEvSBi531IJAUQXUEsS40K6E8yzjVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z0J8s0dfkz4f3jqM
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 76D851A0EE1
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgBHBWjaeLlnrTsjEg--.26688S6;
	Sat, 22 Feb 2025 15:12:29 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mm, swap: remove setting SWAP_MAP_BAD for discard cluster
Date: Sun, 23 Feb 2025 00:08:48 +0800
Message-Id: <20250222160850.505274-5-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHBWjaeLlnrTsjEg--.26688S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4ktr4rZr4kJrW5Wr47twb_yoW8XF43pF
	y2q3Z8KF4UJF1q9F4UZws0yry3KrW8Kr9rXa1Sqw1fC3Z8tr1fJr90ya9ayrW5GrZ5Cr9r
	uw4jg3y7u398tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3XTQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Before alloc from a cluster, we will aqcuire cluster's lock and make
sure it is usable by cluster_is_usable(), so there is no need to
set SWAP_MAP_BAD for cluster to be discarded.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index fc45b9d56639..c640f77a464a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -479,15 +479,6 @@ static void move_cluster(struct swap_info_struct *si,
 static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 		struct swap_cluster_info *ci)
 {
-	unsigned int idx = cluster_index(si, ci);
-	/*
-	 * If scan_swap_map_slots() can't find a free cluster, it will check
-	 * si->swap_map directly. To make sure the discarding cluster isn't
-	 * taken by scan_swap_map_slots(), mark the swap entries bad (occupied).
-	 * It will be cleared after discard
-	 */
-	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
-			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
 	VM_BUG_ON(ci->flags == CLUSTER_FLAG_FREE);
 	move_cluster(si, ci, &si->discard_clusters, CLUSTER_FLAG_DISCARD);
 	schedule_work(&si->discard_work);
@@ -571,8 +562,6 @@ static bool swap_do_scheduled_discard(struct swap_info_struct *si)
 		 * return the cluster to allocation list.
 		 */
 		ci->flags = CLUSTER_FLAG_NONE;
-		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
-				0, SWAPFILE_CLUSTER);
 		__free_cluster(si, ci);
 		spin_unlock(&ci->lock);
 		ret = true;
-- 
2.30.0


