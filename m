Return-Path: <linux-kernel+bounces-526991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B27A405FD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF4B426B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFD220127D;
	Sat, 22 Feb 2025 07:12:35 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7F51F3FD9
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208355; cv=none; b=k1MlJFESf1qD0bkNNcqleOwdPvUnAwp2ooyoKmKb0fuX7m4mfpDNerkMOr/JVyunVCqpbm/ZAr0d2yLizqm1cNLmlB9/mWApuWxkTSLbwFCFCHWu4YXB5Z2I2kqFrloVH29e/V95xYfa1sSuqmdAXqWlYFO6NQOjAOeW3/kFKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208355; c=relaxed/simple;
	bh=ehBW/ddWpfP0rTSUU9UzKJwjaKLEeMQ10NbELkliNE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BgWLuXld4HquPBmn4RVtJAchDFe4Q2+DxTujbA+6l4aYNPkdbVE2dpOkOaQEhd8oZOB4/ugYCvRdw7MxfQI5d61BMZPvl9/69YqB0tnowI6b52AAbJpzOH6qV9RlWuk8gKWxjsY5I2qGtYfp0EcPKFUf2JvjILagbZZTo2HVOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z0J8r2M4Jz4f3jt8
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B18C91A0359
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 15:12:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP2 (Coremail) with SMTP id Syh0CgBHBWjaeLlnrTsjEg--.26688S3;
	Sat, 22 Feb 2025 15:12:28 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org,
	kasong@tencent.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] mm: swap: avoid losting cluster in swap_reclaim_full_clusters()
Date: Sun, 23 Feb 2025 00:08:45 +0800
Message-Id: <20250222160850.505274-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBHBWjaeLlnrTsjEg--.26688S3
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy5Kr4fXF43Aw1fJF4xWFg_yoW3CFc_Aa
	4vy348GrZ5Jw1kGr12y3yrXrZ7Krs7ZFyjgry3tFWxA34fXFs7tan7Gay2gw1rJa1DCa4r
	J3Z8trn3X39FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r18M28IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0a0PDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

If no swap cache is reclaimed, cluster taken off from full_clusters list
will not be put in any list and may not be reused. Do relocate_cluster
for such cluster to fix the issue.

Fixes: 3b644773eefda ("mm, swap: reduce contention on device lock")
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
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


