Return-Path: <linux-kernel+bounces-559443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C73D0A5F3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7995177FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F8E266F18;
	Thu, 13 Mar 2025 12:09:30 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF992571BF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867770; cv=none; b=R5hToQmJqtAnnSWt1Q4DVsHyHZgS8FBBxftyJoRUVMb+OJnTSsSok/R0rQyn7H1KqF3epaaGDC75Lcf3Gg4LYxctMFzc3FL4K1P63EN1XiaXst5xUfEnFIjApH2nn5vrsgRYf/VMtgIcYCPlhbeKcCX36r/+4bSNi6lRDgIIkqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867770; c=relaxed/simple;
	bh=cN23TyK3IT0ra4A3paPBKtVBA96DRWb+pv6+Ty39nd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nFS4fMTv2OJqnjyC5TKferUcb2J6YBxbNuZY/Aom4eJbe4iJfJ/r1TdDfHU4Dy1WrOZ3KzJz/1JUJzI9kLYfMAhqBHRe+aX5o9a/gHGGqH5WUW02xbgTkRKSpVCSw+L21RNZDcm+5GYssNbyDVTCe/Df6P+bjCdXPu/gS2QTi9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZD5rh3DNNz4f3jLh
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 845421A11AD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:09:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgCnsGPyytJnTaZeGQ--.9643S7;
	Thu, 13 Mar 2025 20:09:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] mm: swap: use swap_entries_free() drop last 1 flag in swap_entries_put_nr()
Date: Fri, 14 Mar 2025 05:05:11 +0800
Message-Id: <20250313210515.9920-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250313210515.9920-1-shikemeng@huaweicloud.com>
References: <20250313210515.9920-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnsGPyytJnTaZeGQ--.9643S7
X-Coremail-Antispam: 1UD129KBjvdXoWrZw1rAF4DAw1kuF13Ar1DKFg_yoW3urb_ua
	9Ykw1kJw43XF1DuF17tFyjvr9Yg395AF13ZF4ftFWayFZ8GF95Zw4qgr98C34vvw1Ivwn3
	Aanavr1kArnrGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jyYLPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Use swap_entries_free() to drop last 1 flag to eliminate the need to set
slot to the intermediate SWAP_HAS_CACHE state.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 mm/swapfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 14b7b37996ff..0ce0ca08594e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1508,10 +1508,11 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
 		unlock_cluster(ci);
 		goto fallback;
 	}
-	for (i = 0; i < nr; i++)
-		WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
 	if (!has_cache)
 		swap_entries_free(si, ci, entry, nr);
+	else
+		for (i = 0; i < nr; i++)
+			WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
 	unlock_cluster(ci);
 
 	return has_cache;
-- 
2.30.0


