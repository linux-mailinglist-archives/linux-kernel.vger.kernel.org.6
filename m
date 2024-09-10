Return-Path: <linux-kernel+bounces-322272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1865B97268B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 03:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4672F1C236B9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 01:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E887345B;
	Tue, 10 Sep 2024 01:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhlnPAa3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BB1859
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725930987; cv=none; b=DbJYhVJhip8W6z+qSaS6VkRVydyTlcCql2ZjbWKQoZALBxYvtfB+R+YhJHtcP5BUHIrqrLUK57o63KpYzO6aUPkDUXsEzeD/csuvuA/Y2DIkjWEF+R+C38SuZ1/oEhIfZQ2MboG0gAiz0FTt29Azln6Wz4f8xOlhHo8eHWcGzSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725930987; c=relaxed/simple;
	bh=MGe+BNv8B4iO9+CV0hsGc6mktkx0QtjV/qWP+6ZV+L8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fE80RSp05suSPN4filcC90mjfVFCWMqLYsAda3Ykhh2zo9ZoZqLbpZTITduinrbUIGl2Qn8BeXESlmxqvDvJRnPdpWIbBgD6mGH4MwvmHyNUyQ4GqEFELYIDhpfYEHRFn6azjOkKi9VUZFEnyqCsrNcDVqUd9OUT/9GXBZL5iX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhlnPAa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDDCC4CEC5;
	Tue, 10 Sep 2024 01:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725930986;
	bh=MGe+BNv8B4iO9+CV0hsGc6mktkx0QtjV/qWP+6ZV+L8=;
	h=From:To:Cc:Subject:Date:From;
	b=XhlnPAa3MBcEKdNAPW9QT62dvF2zPiaV2D+9pOvA1ko9fwvJcglmLN97hhxZ2bB81
	 kbfc4l+egYDTvfHb3dRryEHlFelVA1DR6xW5vC3ENnYdo6Wu6yysdPgGq+TzpQio+D
	 2E8hwUPwUgUBR37tlQJqQ8A3Pi6Ldcdfau34jxRdj/PDJ/nAfJnlCZRvuUppjalLmC
	 WLSWhSLZRkarrEHA/w7S3z6mV3FyDEYQitNljkNjTksWohPeGTh56YZ3yL1/Q33+j3
	 Y6FCWisX4Xpo8CjE1/GL5Ipaiutg70Vuc/RMaP/V5EemOHDXzhae1i0SbE27PwrUO6
	 RgV4MNlzES/ag==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+341e5f32ebafbb46b81c@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to don't panic system for no free segment fault injection
Date: Tue, 10 Sep 2024 09:16:19 +0800
Message-Id: <20240910011619.3582861-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs: fix to don't panic system for no free segment fault injection

syzbot reports a f2fs bug as below:

F2FS-fs (loop0): inject no free segment in get_new_segment of __allocate_new_segment+0x1ce/0x940 fs/f2fs/segment.c:3167
F2FS-fs (loop0): Stopped filesystem due to reason: 7
------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2748!
CPU: 0 UID: 0 PID: 5109 Comm: syz-executor304 Not tainted 6.11.0-rc6-syzkaller-00363-g89f5e14d05b4 #0
RIP: 0010:get_new_segment fs/f2fs/segment.c:2748 [inline]
RIP: 0010:new_curseg+0x1f61/0x1f70 fs/f2fs/segment.c:2836
Call Trace:
 __allocate_new_segment+0x1ce/0x940 fs/f2fs/segment.c:3167
 f2fs_allocate_new_section fs/f2fs/segment.c:3181 [inline]
 f2fs_allocate_pinning_section+0xfa/0x4e0 fs/f2fs/segment.c:3195
 f2fs_expand_inode_data+0x5d6/0xbb0 fs/f2fs/file.c:1799
 f2fs_fallocate+0x448/0x960 fs/f2fs/file.c:1903
 vfs_fallocate+0x553/0x6c0 fs/open.c:334
 do_vfs_ioctl+0x2592/0x2e50 fs/ioctl.c:886
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0010:get_new_segment fs/f2fs/segment.c:2748 [inline]
RIP: 0010:new_curseg+0x1f61/0x1f70 fs/f2fs/segment.c:2836

The root cause is when we inject no free segment fault into f2fs,
we should not panic system, fix it.

Fixes: 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT")
Reported-by: syzbot+341e5f32ebafbb46b81c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000f0ee5b0621ab694b@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 112d58d566d4..b7c1ca51ea32 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2730,6 +2730,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 								MAIN_SECS(sbi));
 		if (secno >= MAIN_SECS(sbi)) {
 			ret = -ENOSPC;
+			f2fs_bug_on(sbi, 1);
 			goto out_unlock;
 		}
 	}
@@ -2740,6 +2741,7 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 							MAIN_SECS(sbi));
 		if (secno >= MAIN_SECS(sbi)) {
 			ret = -ENOSPC;
+			f2fs_bug_on(sbi, 1);
 			goto out_unlock;
 		}
 	}
@@ -2781,10 +2783,8 @@ static int get_new_segment(struct f2fs_sb_info *sbi,
 out_unlock:
 	spin_unlock(&free_i->segmap_lock);
 
-	if (ret == -ENOSPC) {
+	if (ret == -ENOSPC)
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
-		f2fs_bug_on(sbi, 1);
-	}
 	return ret;
 }
 
-- 
2.40.1


