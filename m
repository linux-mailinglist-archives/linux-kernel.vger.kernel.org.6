Return-Path: <linux-kernel+bounces-428849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 349319E1429
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1A05B2622F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D76D1D90A4;
	Tue,  3 Dec 2024 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KT81jjQl"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC0619DF45
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210917; cv=none; b=LrkmZQEM1KqbsUXgV65qAuBLwDJRG8DKqVAHfINMHXizLgnsDoC2g0MdPVosXTFTLkcehGXO9DAfWT4HpZLJyHAeLODUE2DockKB72k6gTfagldlCEP+4v4ZJblJj7X9F2BCvMFtAO+RazwLwZr5XnTalH6Y+Qw1tGaUzZdyUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210917; c=relaxed/simple;
	bh=bBmcMPIMrvWP8/w6Ho+hyiZUG00ncco65Hce9iOdt9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLoZQVO53FL6b0LVP2q1l7e94DhamVeIWiwblbIeUiogGYZnDt//JcFNCaBP7pyCDlWhlBMbVvWJl+C/TM9/vde96i/J2ZlkEd2fmt79M80HsxLJ2qGnt9sFdWcqqvlxYGHrcjF/jxp0oeP/S06RIddOjPmxOrAy6PDCAQVbWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KT81jjQl; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733210907; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ffVwQCplrSSi42sdO0aUOX+pWOHj43NN6iV37ZyGKPo=;
	b=KT81jjQlOxEj2D8ILyL/6T4Bn3GVkJJL4Fhozd959nvRHjZQ3fBc4jMSNb+iy5KL8xS5NpGQDvdrWx6yjDLg8A1rrJIQqJSAdpd3S0mGHpT4idVgKpj1RR1xTMmx/Zg54JH/2RtSGbbYEvhz104OmK2Vmoskd+vlQoZTngGW7dE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WKlm0CQ_1733210902 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Dec 2024 15:28:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+7ff87b095e7ca0c5ac39@syzkaller.appspotmail.com
Subject: [PATCH] erofs: fix rare pcluster memory leak after unmounting
Date: Tue,  3 Dec 2024 15:28:21 +0800
Message-ID: <20241203072821.1885740-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <674c1235.050a0220.ad585.0032.GAE@google.com>
References: <674c1235.050a0220.ad585.0032.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There may still exist some pcluster with valid reference counts
during unmounting.  Instead of introducing another synchronization
primitive, just try again as unmounting is relatively rare.  This
approach is similar to z_erofs_cache_invalidate_folio().

It was also reported by syzbot as a UAF due to commit f5ad9f9a603f
("erofs: free pclusters if no cached folio is attached"):

BUG: KASAN: slab-use-after-free in do_raw_spin_trylock+0x72/0x1f0 kernel/locking/spinlock_debug.c:123
..
 queued_spin_trylock include/asm-generic/qspinlock.h:92 [inline]
 do_raw_spin_trylock+0x72/0x1f0 kernel/locking/spinlock_debug.c:123
 __raw_spin_trylock include/linux/spinlock_api_smp.h:89 [inline]
 _raw_spin_trylock+0x20/0x80 kernel/locking/spinlock.c:138
 spin_trylock include/linux/spinlock.h:361 [inline]
 z_erofs_put_pcluster fs/erofs/zdata.c:959 [inline]
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1403 [inline]
 z_erofs_decompress_queue+0x3798/0x3ef0 fs/erofs/zdata.c:1425
 z_erofs_decompressqueue_work+0x99/0xe0 fs/erofs/zdata.c:1437
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa68/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

However, it seems a long outstanding memory leak.  Fix it now.

Fixes: f5ad9f9a603f ("erofs: free pclusters if no cached folio is attached")
Reported-by: syzbot+7ff87b095e7ca0c5ac39@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/674c1235.050a0220.ad585.0032.GAE@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zutil.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 75704f58ecfa..0dd65cefce33 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -230,9 +230,10 @@ void erofs_shrinker_unregister(struct super_block *sb)
 	struct erofs_sb_info *const sbi = EROFS_SB(sb);
 
 	mutex_lock(&sbi->umount_mutex);
-	/* clean up all remaining pclusters in memory */
-	z_erofs_shrink_scan(sbi, ~0UL);
-
+	while (!xa_empty(&sbi->managed_pslots)) {
+		z_erofs_shrink_scan(sbi, ~0UL);
+		cond_resched();
+	}
 	spin_lock(&erofs_sb_list_lock);
 	list_del(&sbi->list);
 	spin_unlock(&erofs_sb_list_lock);
-- 
2.43.5


