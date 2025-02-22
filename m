Return-Path: <linux-kernel+bounces-526993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB22A40604
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD10070657E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0A4202F80;
	Sat, 22 Feb 2025 07:12:35 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A78F1F03C1
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208355; cv=none; b=qIl3x/mtH5AJtc1bY5ebheDZ1vyAAtL2cJU9EZLSP1/bs2Tofmexse0NXzta29p7qTZ8aObbXmeNZoEi26tFPaDs3cGaNP+rPneYGV56h6OMwEyYcEqV7MUGnsMynd9M38FbbCj2jxfFRXnWkT/4UNuI4MY7VvJhARDJ9p4mD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208355; c=relaxed/simple;
	bh=CAmkhd0nr7kiPjqOSP/WxIuE2J/HKvOW0Yu4KluxmmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWbCBFU/HSe0dFCBD259XRsW63k9k74tHIF2RNf6bLgEqb1SfjK102lJRV9JB7ku3jq+VoAwf6SQB1btEx9oehNkDP0Q5rpdkHzn4zOerp2P41TMbSQuXEDdzOTbPmN2i2rAGU2BY19AOyaa2N/8UVzsa+HTR3Y5+eC7szwhWV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z0J8r467dz4f3jtC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id ED8541A0EE1
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgBHBWjaeLlnrTsjEg--.26688S4;
	Sat, 22 Feb 2025 15:12:28 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm: swap: use correct step in loop to wait all clusters in wait_for_allocation()
Date: Sun, 23 Feb 2025 00:08:46 +0800
Message-Id: <20250222160850.505274-3-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHBWjaeLlnrTsjEg--.26688S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1DAFy3trW8tw4DtrWrKrg_yoW8GF4kpF
	n8t3ZYkFs3XrykJF4DA3ZYkry8Kw1vgFWxXFy5ur1fZwnxXrWakF1Dtr90qFyjkr1kJr90
	qFZ7K34xurn0yaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsmiiDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Use correct step in loop to wait all clusters in wait_for_allocation().
If we miss some cluster in wait_for_allocation(), use after free may
occurs as following:
shmem_writepage                  swapoff
 folio_alloc_swap
  get_swap_pages
   scan_swap_map_slots
    cluster_alloc_swap_entry
     alloc_swap_scan_cluster
      cluster_alloc_range
       /* SWP_WRITEOK is valid */
       if (!(si->flags & SWP_WRITEOK))

                                  ...
                                  del_from_avail_list(p, true);
                                  ...
                                  /* miss the cluster in shmem_writepage */
                                  wait_for_allocation()
                                  ...
                                  try_to_unuse()

       memset(si->swap_map + start, usage, nr_pages);
       swap_range_alloc(si, nr_pages);
       ci->count += nr_pages;
       /* return a valid entry */

                                  ...
                                  exit_swap_address_space(p->type);
                                  ...

 ...
 add_to_swap_cache
  /* dereference swap_address_space(entry) which is NULL */
  xas_lock_irq(&xas);

Fixes: e47bd46eab97e ("mm, swap: hold a reference during scan and cleanup flag usage")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e5f58ab86329..425126c0a07d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2627,7 +2627,6 @@ static void wait_for_allocation(struct swap_info_struct *si)
 	for (offset = 0; offset < end; offset += SWAPFILE_CLUSTER) {
 		ci = lock_cluster(si, offset);
 		unlock_cluster(ci);
-		offset += SWAPFILE_CLUSTER;
 	}
 }
 
-- 
2.30.0


