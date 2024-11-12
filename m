Return-Path: <linux-kernel+bounces-405731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B429C5655
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DDB1F227ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2485C230998;
	Tue, 12 Nov 2024 11:07:23 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3855C230981
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409642; cv=none; b=XmIVRukeiDX7FkTJ3syHgzAslOiHYVptiT3nuy8YYASkCHDu1tEtDSae7Tp1RC0TVjAK4R2W9i25UZpKchK3t6qAnx6Cj6En3TgcBU8mzPR/5Xf9fofJH78C0cLNYx2XGSYi35oETbzxBpbyDjSmOmunMoOJRpuLqjx3QrXY+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409642; c=relaxed/simple;
	bh=5N3GaKSwUHeMGTL3n/ySVMERB1KPLXNmvcXpTMn7F9s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TqLAFYvrhT6Y/Tx0oKS6a0kL+brXsI6WFxfFVD3RVn4nFqXSb4aVWLLibbBKp80dlmSva8Qj7HdQlr+7/oRdnJwV24FMS8Xt7BjOEcxfWwfRg9qCkrDMmAp0sRsaO/oRygHHN6ytS2BVTwNIdDzJAWv7FHntek1TpZJhUwU1pmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4ACB6UaU098026;
	Tue, 12 Nov 2024 19:06:30 +0800 (+08)
	(envelope-from Xiuhong.Wang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xnk933qr1z2KfPZ3;
	Tue, 12 Nov 2024 19:05:27 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 12 Nov 2024 19:06:28 +0800
From: Xiuhong Wang <xiuhong.wang@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <xiuhong.wang.cn@gmail.com>,
        <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH] f2fs: Fix to avoid long time to shrink extent cache
Date: Tue, 12 Nov 2024 19:06:27 +0800
Message-ID: <20241112110627.1314632-1-xiuhong.wang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4ACB6UaU098026

We encountered a system hang problem based on the following 
experiment:
There are 17 processes, 8 of which do 4k data read, write and
compare tests, and 8 do 64k read, write and compare tests. Each
thread writes a 256M file, and another thread writes a large file
to 80% of the disk, and then keeps doing read operations, all of
which are direct operations. This will cause the large file to be
filled to 80% of the disk to be severely fragmented. On a 512GB
device, this large file may generate a huge zombie extent tree.

When system shutting down, the init process needs to wait for the
writeback process, and the writeback process may encounter the
situation where the READ_EXTENT_CACHE space is insufficient and
needs to free the zombie extent tree. The extent tree has a large
number of extent nodes, it will a long free time to free, which
triggers system hang.

The stack when the problem occurs is as follows:
crash_arm64> bt 1
PID: 1        TASK: ffffff80801a9200  CPU: 1    COMMAND: "init"
 #0 [ffffffc00806b9a0] __switch_to at ffffffc00810711c
 #1 [ffffffc00806ba00] __schedule at ffffffc0097c1c4c
 #2 [ffffffc00806ba60] schedule at ffffffc0097c2308
 #3 [ffffffc00806bab0] wb_wait_for_completion at ffffffc0086320d4
 #4 [ffffffc00806bb20] writeback_inodes_sb at ffffffc00863719c
 #5 [ffffffc00806bba0] sync_filesystem at ffffffc00863c98c
 #6 [ffffffc00806bbc0] f2fs_quota_off_umount at ffffffc00886fc60
 #7 [ffffffc00806bc20] f2fs_put_super at ffffffc0088715b4
 #8 [ffffffc00806bc60] generic_shutdown_super at ffffffc0085cd61c
 #9 [ffffffc00806bcd0] kill_f2fs_super at ffffffc00886b3dc

crash_arm64> bt 14997
PID: 14997    TASK: ffffff8119d82400  CPU: 3    COMMAND: "kworker/u16:0"
 #0 [ffffffc019f8b760] __detach_extent_node at ffffffc0088d5a58
 #1 [ffffffc019f8b790] __release_extent_node at ffffffc0088d5970
 #2 [ffffffc019f8b810] f2fs_shrink_extent_tree at ffffffc0088d5c7c
 #3 [ffffffc019f8b8a0] f2fs_balance_fs_bg at ffffffc0088c109c
 #4 [ffffffc019f8b910] f2fs_write_node_pages at ffffffc0088bd4d8
 #5 [ffffffc019f8b990] do_writepages at ffffffc0084a0b5c
 #6 [ffffffc019f8b9f0] __writeback_single_inode at ffffffc00862ee28
 #7 [ffffffc019f8bb30] writeback_sb_inodes at ffffffc0086358c0
 #8 [ffffffc019f8bc10] wb_writeback at ffffffc0086362dc
 #9 [ffffffc019f8bcc0] wb_do_writeback at ffffffc008634910

Process 14997 ran for too long and caused the system hang.

At this time, there are still 1086911 extent nodes in this zombie
extent tree that need to be cleaned up.

crash_arm64_sprd_v8.0.3++> extent_tree.node_cnt ffffff80896cc500
  node_cnt = {
    counter = 1086911
  },

The root cause of this problem is that when the f2fs_balance_fs
function is called in the write process, it will determine
whether to call f2fs_balance_fs_bg, but it is difficult to
meet the condition of excess_cached_nats. When the
f2fs_shrink_extent_tree function is called to free during 
f2fs_write_node_pages, there are too many extent nodes on the 
extent tree, which causes a loop and causes a system hang.

To solve this problem, when calling f2fs_balance_fs, check whether
the extent cache is sufficient. If not, release the zombie extent
tree.

Signed-off-by: Xiuhong Wang <xiuhong.wang@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
Test the problem with the temporary versions:
patch did not reproduce the problem, the patch is as follows:
@@ -415,7 +415,7 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
                f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAULT_INJECT);

        /* balance_fs_bg is able to be pending */
-       if (need && excess_cached_nats(sbi))
+       if (need)
                f2fs_balance_fs_bg(sbi, false);

---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1766254279d2..390bec177567 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -415,7 +415,9 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAULT_INJECT);
 
 	/* balance_fs_bg is able to be pending */
-	if (need && excess_cached_nats(sbi))
+	if (need && (excess_cached_nats(sbi) ||
+			!f2fs_available_free_memory(sbi, READ_EXTENT_CACHE) ||
+			!f2fs_available_free_memory(sbi, AGE_EXTENT_CACHE)))
 		f2fs_balance_fs_bg(sbi, false);
 
 	if (!f2fs_is_checkpoint_ready(sbi))
-- 
2.25.1


