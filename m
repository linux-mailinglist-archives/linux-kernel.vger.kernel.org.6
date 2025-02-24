Return-Path: <linux-kernel+bounces-528109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD2A413A5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B464A3A2328
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343419C54E;
	Mon, 24 Feb 2025 02:42:58 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537AB70824
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 02:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740364978; cv=none; b=KPJGmUkoDHWWtf1l+zjGRgdRRfTJSqUDWVF1IpIeCjVsK9MYk/jwsvc/qNE+jEo2HpG5zrkyxoR529S+GzxZN0fp2wOVbdxWx9Dvm8y3gi+ElPCpDfoIpQWp8jI4wR4bwm/wxCgOD5Ram5w2pan8pwOuxtLuevEq7n5WxLInSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740364978; c=relaxed/simple;
	bh=Ih2vmHXajFO/sfOB+dozRyHrCrkHKSPIZ0+H5Pr/4AY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cUfY18skaCcy+M10B9aR+wBceqrM01FaLy8njguDhXiV7JiHO9tLBxbGxrBWip8x8wFbn0fyErEjg1euiw/W9/ad9zMnAQDvI85uhLl7TfM6kV6TZiOYjmN7OL7IcqRVkPkSCPfkF6ziPQo/lcLVXALMJ1KwvVAUdQmtY4IBA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z1Q4p4Pk4z4f3jqM
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:42:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1199D1A0F5B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:42:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgCX+1+p3LtnhuPnEg--.32591S2;
	Mon, 24 Feb 2025 10:42:50 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: swap: add back full cluster when no entry is reclaimed
Date: Mon, 24 Feb 2025 19:39:10 +0800
Message-Id: <20250224113910.522439-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCX+1+p3LtnhuPnEg--.32591S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy5Kr4fXF4rKFWftr15XFb_yoWfXwc_Ca
	4vy348CrW5Jw1kCr12y3yrXrWkKrs3ZFyj9ry3tFWxA34fGFZ7tan7GFW2gw1fJa1DCa4S
	ywnYyrn3J39F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8c
	AvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWD
	JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oV
	Cq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG
	8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2js
	IE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

If no swap cache is reclaimed, cluster taken off from full_clusters list
will not be put in any list and we can't reclaime HAS_CACHE slots
efficiently. Do relocate_cluster for such cluster to avoid inefficiency.

Fixes: 3b644773eefda ("mm, swap: reduce contention on device lock")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 34baefb000b5..e5f58ab86329 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -861,6 +861,10 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 			offset++;
 		}
 
+		/* in case no swap cache is reclaimed */
+		if (ci->flags == CLUSTER_FLAG_NONE)
+			relocate_cluster(si, ci);
+
 		unlock_cluster(ci);
 		if (to_scan <= 0)
 			break;
-- 
2.30.0


