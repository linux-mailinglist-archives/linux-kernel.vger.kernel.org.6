Return-Path: <linux-kernel+bounces-569093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F07A69E72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA3A4651AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7911EB9E3;
	Thu, 20 Mar 2025 02:52:55 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED83597B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742439175; cv=none; b=IuuOSVZO7ljQAc6at1r0qBVi9yiLIXoihoRqMXAg1WcMgnNd4gdg4vQhtd6PfBesMn9GIanmnoXRh8+W6dTKiuHUD8icXEpt74LAmF07l7vgz1DZt3JETUV6xICokw/qm0qHhF/KBKcJQhnJWLlwBC5mBwkfMVqjQALNjhv4cOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742439175; c=relaxed/simple;
	bh=Zf6R2oAO0V18qRG+f+KesWO8ZzZr+bGNQQI5d3gs9Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NHQUg6SqLy9woBQLLFpyLHmS9mzc/dBlfAhnRcJUSEL1JSL5NHUfOjx75yggNr75jARaeFYmtS8z4QVuwTDv22b8600WHPGGyLpvZalEODykCmihapkFUluyErd8p9+u7Gwog36vdEWH+DdWZ/7GhQsiZE9S1TUhX53+vqjSTvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZJ9974XTpz4f3jcv
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:52:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4F5EB1A17F7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:52:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP3 (Coremail) with SMTP id _Ch0CgAHW8X_gttnYGGmGw--.42197S6;
	Thu, 20 Mar 2025 10:52:50 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: akpm@linux-foundation.org
Cc: kasong@tencent.com,
	tim.c.chen@linux.intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] mm: swap: use swap_entries_free() drop last ref count in swap_entries_put_nr()
Date: Thu, 20 Mar 2025 19:48:25 +0800
Message-Id: <20250320114829.25751-5-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250320114829.25751-1-shikemeng@huaweicloud.com>
References: <20250320114829.25751-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHW8X_gttnYGGmGw--.42197S6
X-Coremail-Antispam: 1UD129KBjvdXoWrKrWUWrWrAr4fuw4Utw43ZFb_yoWfuFb_ua
	9Yy34kCw4UJF1DGw17tr1jvr9Ygw4qyF1rZr1ftFWayF1rJF95ZwsFgr98Aw10yw40vrn3
	Aanaqrn5Ar1DujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbqkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7
	AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jv
	Wl9UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Use swap_entries_free() to directly free swap entries when the swap
entries are not cached and referenced, without needing to set swap
entries to set intermediate SWAP_HAS_CACHE state.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 mm/swapfile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d05b58e9c723..e83519fbd40e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1490,10 +1490,11 @@ static bool swap_entries_put_nr(struct swap_info_struct *si,
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


