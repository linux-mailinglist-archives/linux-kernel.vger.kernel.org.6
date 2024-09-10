Return-Path: <linux-kernel+bounces-322338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D0A97277F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 05:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 668D11C23EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE3A1514DA;
	Tue, 10 Sep 2024 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPHp4gQD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5381514E4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725937648; cv=none; b=lFC5l+MW7frtRa2N+HgnO6Cpz8Q3hIAPO9rJlj3bSuieNMqwxgFFXmRGvwVm3qsWvmesCB9P90upPT5GhbZUl2bBhmHDaeFVM3llD0oSszfiNO/j8rfYMT9SeSrzPRUD3T41c0cpZfeFt60eXjq5JBxy4RictHD8h9p471Ae1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725937648; c=relaxed/simple;
	bh=BGcgohLjLuZmmBluZnoPhK7PAf91cjVeYnh47tUQo30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xn6RcgSOeadgAIvh0RRcPlRP7Thul/UB1nGLIWHPPX2N/qFG+/bsgh+ibPOgJb62qof67GnUa8H9zZZ8g1rh065qXhB5vaw+kKz8+7+6toy9FxXnlvCQ8lAtY7Pn4zDlZjRffFu3n8o3LreG+9MoN4jiHkPX8+y6vLRPPj8fWk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPHp4gQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D07C4CEC6;
	Tue, 10 Sep 2024 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725937647;
	bh=BGcgohLjLuZmmBluZnoPhK7PAf91cjVeYnh47tUQo30=;
	h=From:To:Cc:Subject:Date:From;
	b=OPHp4gQDpEU4HHh2lgL8dNF2qkRGXRAat+q9dZFDJAfnXL2yrmw3NhUSjNg6xPkVn
	 rDbK8RkHcCVdNE457CuXfYcy7TtWknJKd0gTiPeBKNsYDgt81yQ5v+DVYeChXXgL5k
	 FTibT04T25uK8S6+EF8XpTOTJ9QYY9sMgti/wHbeAnGBBflvpEr9nScDaKHEFotEjX
	 FHnlVidC1MSQhOpaZqJZgu8MKHZN+qCswhy4wtmsm82VW/rzaanTo/KHdGIKRdF0Pe
	 cBWLJmOZrsy6hqW70wRXbl9wMzz+yNnT2mqW2iaUrZwxNa1y2SxRmlXHSgBuBDNwSI
	 1CVIlWvy1agiw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] f2fs: fix to don't set SB_RDONLY in f2fs_handle_critical_error()
Date: Tue, 10 Sep 2024 11:07:13 +0800
Message-Id: <20240910030713.3716318-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a f2fs bug as below:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 58 at kernel/rcu/sync.c:177 rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
CPU: 1 UID: 0 PID: 58 Comm: kworker/1:2 Not tainted 6.10.0-syzkaller-12562-g1722389b0d86 #0
Workqueue: events destroy_super_work
RIP: 0010:rcu_sync_dtor+0xcd/0x180 kernel/rcu/sync.c:177
Call Trace:
 percpu_free_rwsem+0x41/0x80 kernel/locking/percpu-rwsem.c:42
 destroy_super_work+0xec/0x130 fs/super.c:282
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

As Christian Brauner pointed out [1]: the root cause is f2fs sets
SB_RDONLY flag in internal function, rather than setting the flag
covered w/ sb->s_umount semaphore via remount procedure, then below
race condition causes this bug:

- freeze_super()
 - sb_wait_write(sb, SB_FREEZE_WRITE)
 - sb_wait_write(sb, SB_FREEZE_PAGEFAULT)
 - sb_wait_write(sb, SB_FREEZE_FS)
					- f2fs_handle_critical_error
					 - sb->s_flags |= SB_RDONLY
- thaw_super
 - thaw_super_locked
  - sb_rdonly() is true, so it skips
    sb_freeze_unlock(sb, SB_FREEZE_FS)
  - deactivate_locked_super

Since f2fs has almost the same logic as ext4 [2] when handling critical
error in filesystem if it mounts w/ errors=remount-ro option:
- set CP_ERROR_FLAG flag which indicates filesystem is stopped
- record errors to superblock
- set SB_RDONLY falg
Once we set CP_ERROR_FLAG flag, all writable interfaces can detect the
flag and stop any further updates on filesystem. So, it is safe to not
set SB_RDONLY flag, let's remove the logic and keep in line w/ ext4 [3].

[1] https://lore.kernel.org/all/20240729-himbeeren-funknetz-96e62f9c7aee@brauner
[2] https://lore.kernel.org/all/20240729132721.hxih6ehigadqf7wx@quack3
[3] https://lore.kernel.org/linux-ext4/20240805201241.27286-1-jack@suse.cz

Fixes: b62e71be2110 ("f2fs: support errors=remount-ro|continue|panic mountoption")
Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com/
Cc: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e774bdf875b2..acfd000c6bb0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4207,12 +4207,14 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	}
 
 	f2fs_warn(sbi, "Remounting filesystem read-only");
+
 	/*
-	 * Make sure updated value of ->s_mount_flags will be visible before
-	 * ->s_flags update
+	 * We have already set CP_ERROR_FLAG flag to stop all updates
+	 * to filesystem, so it doesn't need to set SB_RDONLY flag here
+	 * because the flag should be set covered w/ sb->s_umount semaphore
+	 * via remount procedure, otherwise, it will confuse code like
+	 * freeze_super() which will lead to deadlocks and other problems.
 	 */
-	smp_wmb();
-	sb->s_flags |= SB_RDONLY;
 }
 
 static void f2fs_record_error_work(struct work_struct *work)
-- 
2.40.1


