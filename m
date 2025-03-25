Return-Path: <linux-kernel+bounces-574823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD11A6EA84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D0318956E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913EB253F0D;
	Tue, 25 Mar 2025 07:30:02 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EE225410
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742887802; cv=none; b=YkX9mHaRxo5a8r5U7bS0LXpkChG3ZI3Z8TApC++wq780hDgJIVmQFM0OJxaGnaqs91jqpWW7tEzDSc+X2+68ElKxrRV7D6BU8Reu0DfzUP8bb5FGp0C+f5cJedh+R21R3tasIzxLiEHvbu9U5bXAEQiK/E4ARR0AP/fKZWMX0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742887802; c=relaxed/simple;
	bh=yMM6dHJ6eClHAq5oe/m8Me2vXlxmLysjU7YbCh6Q0S4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFcgkTQRbsJqd8rdsoE/7fInrzpxkvlkVJOpEz9RE/aiFOZMw8WU5HUbkqjgFd6kQuu2rcxOJ2YV/dUgxMPGGghldEkqnWC8yX1odIBnyQzvN7CjVT8ksHyBN3uoeOReS4UZYw3rOL1bfC0TV5SVcY9KUhP8AxBsKBeDl66XV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZMM4Z2wKYz4f3jYK
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:29:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4AE5F1A0E01
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:29:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgB3M2ZxW+JnZofaHQ--.14216S7;
	Tue, 25 Mar 2025 15:29:57 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	tim.c.chen@linux.intel.com,
	bhe@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] mm: swap: drop last SWAP_MAP_SHMEM flag in batch in swap_entries_put_nr()
Date: Wed, 26 Mar 2025 00:25:25 +0800
Message-Id: <20250325162528.68385-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgB3M2ZxW+JnZofaHQ--.14216S7
X-Coremail-Antispam: 1UD129KBjvJXoWrKF1Dtry5ur18tryxAw1kKrg_yoW8JrWDpF
	4Fq34DKF4xtr12yFW7A3Z8CFyYgr4vkFyYqr9rG34fA3s8tw45u3s2yayrA3WjqFnYyFyY
	g3ZF9ryxuFyvqrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The SWAP_MAP_SHMEM indicates last map from shmem. Therefore we can drop
SWAP_MAP_SHMEM in batch in similar way to drop last ref count in batch.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 mm/swapfile.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e83519fbd40e..6f11619665e8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -192,7 +192,7 @@ static bool swap_is_last_map(struct swap_info_struct *si,
 	unsigned char *map_end = map + nr_pages;
 	unsigned char count = *map;
 
-	if (swap_count(count) != 1)
+	if (swap_count(count) != 1 && swap_count(count) != SWAP_MAP_SHMEM)
 		return false;
 
 	while (++map < map_end) {
@@ -1479,7 +1479,10 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
 	unsigned char count;
 	int i;
 
-	if (nr <= 1 || swap_count(data_race(si->swap_map[offset])) != 1)
+	if (nr <= 1)
+		goto fallback;
+	count = swap_count(data_race(si->swap_map[offset]));
+	if (count != 1 && count != SWAP_MAP_SHMEM)
 		goto fallback;
 	/* cross into another cluster */
 	if (nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER)
-- 
2.30.0


