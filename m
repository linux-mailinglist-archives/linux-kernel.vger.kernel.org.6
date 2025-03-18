Return-Path: <linux-kernel+bounces-565525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA0A66A25
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C93172936
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925461DE2D4;
	Tue, 18 Mar 2025 06:10:37 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737041A5B98
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278237; cv=none; b=VoC2FV2LLpekKXKZ8m8XrF00LEihVWDsZiQACxRRPIy8FcPRmMrlExiWj9DnA4kYpXZCbz0wAWTv3ky7XNLpKbi09/4DuJspTbZBYZqtpCHKbQUJDIaW2kImdVPiVYZMxS0dMJI8+zqizkZWxtVYvpLOWr7O2C06dcekNiaNJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278237; c=relaxed/simple;
	bh=QaZ8ojyWyVzoLJwRo0NCl6n42OFW5+5ek5WcDeAgOw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XJe1KOLFK2M4p3kcL0lajAJP9VbKLHwQSd0X/Vy9meQCu+PQsi5i38dVefc1eTEUM4wSLiEntvaMzEn+M3WmFuyhnykR0SNmDbJ2t8pWYIkFMOJ82w/ZzFzqqDvMY2zHhElQb20a3mkNlRikDrljLxrFboCEi/QDcMsZaLBfb6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH1fH0PThz4f3jtW
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 51F5B1A0CC7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgD3AGRVDtln65ErGw--.37695S7;
	Tue, 18 Mar 2025 14:10:32 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: tim.c.chen@linux.intel.com,
	ryncsn@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] mm: swap: drop last SWAP_MAP_SHMEM flag in batch in swap_entries_put_nr()
Date: Tue, 18 Mar 2025 23:06:11 +0800
Message-Id: <20250318150614.6415-6-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgD3AGRVDtln65ErGw--.37695S7
X-Coremail-Antispam: 1UD129KBjvJXoWrKF1Dtry5ur18tryxAw1kKrg_yoW8Jr18pF
	WFg34DKF48tr12yFWUA3Z8CryYgr4vkF1Yqr9rG34fA34Dtw45u34vyayrAF1Utrn5CFyY
	g3ZFgryxuFWqvrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
---
 mm/swapfile.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2a08d9e89f90..134b061ef1ae 100644
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


