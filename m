Return-Path: <linux-kernel+bounces-261666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6FF93BA82
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0181C21753
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319576FC6;
	Thu, 25 Jul 2024 02:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBdWxGzL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5B6AB9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721873329; cv=none; b=l4YkpK089xgdqYnaw9EkbrNcyJ0JLZBN1cWTC4K7YG2v2H+YJaDvuv4d7br61QbrjYMIgdccIEj1H0lxm+INJaP8t4+RAM37jVyhjnvWXE4g8ZHUUi1WF7G2GRCDiMU/1Kl6OvAWXX99Odu61tXkNiUPR4OGSOCxK6fM/xzxoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721873329; c=relaxed/simple;
	bh=hZLfXkRQOcL/yljHe3PrGXlzhVc26RzCNlLV2gPi8CA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=elNeyqyp4hFcCKBmhQIp+mih5FUbd7P7WQIk/lNXAtKLUdBpiK9Q+Y84kn2RdUurzc8B0W/axxA9X5draxXcrhgTfZMSYIyC7HpRv0edmGMEOHNEDiZabzQdKkksrvfAtnd6uIx6RHZ6DKNN/XzDcYA7yWMFQxVNMkkqLhie5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBdWxGzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B3DC32781;
	Thu, 25 Jul 2024 02:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721873329;
	bh=hZLfXkRQOcL/yljHe3PrGXlzhVc26RzCNlLV2gPi8CA=;
	h=From:To:Cc:Subject:Date:From;
	b=tBdWxGzL64Mr4pUx0gjhtN2hihht0CzcvZAbXYcmuyKIOmABqQtf8NHMmhsOBmEYL
	 O57J+vcsbbHfCjehLl1Nlx4GY9YFY5IrwtSDbu9eVS16NCZqOlfmFDi5dXMD7lB8i5
	 R8yfrC45eZ56RbhjuC+PT+EeYOqtc8KfUfu2mYFfKDeVUzzJ6hVAyKufcCvLlmCmmJ
	 hborJvsHX1RGNDK3Bze+VLFLyLGEAkb3Q/0vU8kxXzqy5P1VCwAwN4Wdp0p+PgfpUJ
	 3kusAWvIpvZJcHd2bxf5uKz3iwXg9+to6tMdzmJkf6PGDW6yERvYycazFnr/OwJR60
	 b6ApY+wjJeB3w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to avoid use-after-free in f2fs_stop_gc_thread()
Date: Thu, 25 Jul 2024 10:08:41 +0800
Message-Id: <20240725020841.894814-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a f2fs bug as below:

 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_report+0xe8/0x550 mm/kasan/report.c:491
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_add_relaxed include/linux/atomic/atomic-instrumented.h:252 [inline]
 __refcount_add include/linux/refcount.h:184 [inline]
 __refcount_inc include/linux/refcount.h:241 [inline]
 refcount_inc include/linux/refcount.h:258 [inline]
 get_task_struct include/linux/sched/task.h:118 [inline]
 kthread_stop+0xca/0x630 kernel/kthread.c:704
 f2fs_stop_gc_thread+0x65/0xb0 fs/f2fs/gc.c:210
 f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
 f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
 __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is below race condition, it may cause use-after-free
issue in sbi->gc_th pointer.

- remount
 - f2fs_remount
  - f2fs_stop_gc_thread
   - kfree(gc_th)
				- f2fs_ioc_shutdown
				 - f2fs_do_shutdown
				  - f2fs_stop_gc_thread
				   - kthread_stop(gc_th->f2fs_gc_task)

We will call f2fs_do_shutdown() in two paths:
- for f2fs_ioc_shutdown() path, we should grab sb->s_umount semaphore
for fixing.
- for f2fs_shutdown() path, it's safe since caller has already grabbed
sb->s_umount semaphore.

Reported-by: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/0000000000005c7ccb061e032b9b@google.com
Fixes: 7950e9ac638e ("f2fs: stop gc/discard thread after fs shutdown")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7a37f2b393b9..62d72da25754 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2388,7 +2388,10 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		}
 	}
 
+	/* grab sb->s_umount to avoid racing w/ remount() */
+	down_read(&sbi->sb->s_umount);
 	ret = f2fs_do_shutdown(sbi, in, readonly);
+	up_read(&sbi->sb->s_umount);
 
 	if (need_drop)
 		mnt_drop_write_file(filp);
-- 
2.40.1


