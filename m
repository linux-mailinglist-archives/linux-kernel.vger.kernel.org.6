Return-Path: <linux-kernel+bounces-390032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78199B74B4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532651F24D88
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C771487ED;
	Thu, 31 Oct 2024 06:49:18 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A69282F0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730357358; cv=none; b=X5JFNc1IvcJvved6mvgeJbokQgpmIMLwtdcyNPmlcTH5qGc2q99pYT26cEHzEvZ3HdnNI1ublI0S2+nHbHvlXOT7H7gaoI44ePSMoXIhR456HWLsC0yz4EfpuVBuKXgwS/hzM0I+xNLyPTETWFL98fAMAzjsUQTRHhZgA/YNekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730357358; c=relaxed/simple;
	bh=eP+GfaNuNxv3czDT/aoym443jNKjcj5rIsqWkXJS7QA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nf0mgY+nR1JCFwtNtgzC6ngejiT8ruiydhwCv7eZzoGaLmxk3b8kf7FxOg7dIU7d+Kzo2Jfo1sjdIR6jKagq3m0OwGRb+kXr8ef3Jcb9/5EGqbaBMy4R9kOypX/ge+NVEfo65p1c4fQ1VTtoq/jVLQ3/5mzNqVUqUtBPhEtRsE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XfF1f2Qvyz20rCh;
	Thu, 31 Oct 2024 14:48:06 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 94531140156;
	Thu, 31 Oct 2024 14:49:06 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 31 Oct
 2024 14:49:06 +0800
From: Long Li <leo.lilong@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <leo.lilong@huawei.com>, <yangerkun@huawei.com>,
	<lonuxli.64@gmail.com>
Subject: [PATCH 1/2] f2fs: fix race in concurrent f2fs_stop_gc_thread
Date: Thu, 31 Oct 2024 14:45:52 +0800
Message-ID: <20241031064553.55283-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500017.china.huawei.com (7.185.36.126)

In my test case, concurrent calls to f2fs shutdown report the following
stack trace:

 Oops: general protection fault, probably for non-canonical address 0xc6cfff63bb5513fc: 0000 [#1] PREEMPT SMP PTI
 CPU: 0 UID: 0 PID: 678 Comm: f2fs_rep_shutdo Not tainted 6.12.0-rc5-next-20241029-g6fb2fa9805c5-dirty #85
 Call Trace:
  <TASK>
  ? show_regs+0x8b/0xa0
  ? __die_body+0x26/0xa0
  ? die_addr+0x54/0x90
  ? exc_general_protection+0x24b/0x5c0
  ? asm_exc_general_protection+0x26/0x30
  ? kthread_stop+0x46/0x390
  f2fs_stop_gc_thread+0x6c/0x110
  f2fs_do_shutdown+0x309/0x3a0
  f2fs_ioc_shutdown+0x150/0x1c0
  __f2fs_ioctl+0xffd/0x2ac0
  f2fs_ioctl+0x76/0xe0
  vfs_ioctl+0x23/0x60
  __x64_sys_ioctl+0xce/0xf0
  x64_sys_call+0x2b1b/0x4540
  do_syscall_64+0xa7/0x240
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

The root cause is a race condition in f2fs_stop_gc_thread() called from
different f2fs shutdown paths:

  [CPU0]                       [CPU1]
  ----------------------       -----------------------
  f2fs_stop_gc_thread          f2fs_stop_gc_thread
                                 gc_th = sbi->gc_thread
    gc_th = sbi->gc_thread
    kfree(gc_th)
    sbi->gc_thread = NULL
                                 < gc_th != NULL >
                                 kthread_stop(gc_th->f2fs_gc_task) //UAF

The commit c7f114d864ac ("f2fs: fix to avoid use-after-free in
f2fs_stop_gc_thread()") attempted to fix this issue by using a read
semaphore to prevent races between shutdown and remount threads, but
itfails to prevent all race conditions.

While upgrading to s_umount write lock in f2fs_do_shutdown() would fix
the current issue, however, using s_umount lock requires extreme caution
to avoid lock recursion. A better solution is to introduce a semaphore
to prevent races between concurrent f2fs_stop_gc_thread calls.

Fixes: 7950e9ac638e ("f2fs: stop gc/discard thread after fs shutdown")
Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/gc.c    | 9 +++++++--
 fs/f2fs/super.c | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3c6f3cce5779..7ae1e2a4789f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1679,6 +1679,7 @@ struct f2fs_sb_info {
 						 * race between GC and GC or CP
 						 */
 	struct f2fs_gc_kthread	*gc_thread;	/* GC thread */
+	struct semaphore gc_clean_lock;		/* semaphore for clean GC thread */
 	struct atgc_management am;		/* atgc management */
 	unsigned int cur_victim_sec;		/* current victim section num */
 	unsigned int gc_mode;			/* current GC state */
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e40bdd12e36d..e1b8bf98b5fa 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -232,14 +232,19 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th;
 
-	if (!gc_th)
+	down(&sbi->gc_clean_lock);
+	gc_th = sbi->gc_thread;
+	if (!gc_th) {
+		up(&sbi->gc_clean_lock);
 		return;
+	}
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
 	kfree(gc_th);
 	sbi->gc_thread = NULL;
+	up(&sbi->gc_clean_lock);
 }
 
 static int select_gc_type(struct f2fs_sb_info *sbi, int gc_type)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 80a53dbf1c38..47a15050ea9c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4419,6 +4419,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	/* initialize locks within allocated memory */
 	init_f2fs_rwsem(&sbi->gc_lock);
+	sema_init(&sbi->gc_clean_lock, 1);
 	mutex_init(&sbi->writepages);
 	init_f2fs_rwsem(&sbi->cp_global_sem);
 	init_f2fs_rwsem(&sbi->node_write);
-- 
2.39.2


