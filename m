Return-Path: <linux-kernel+bounces-290527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0E8955547
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E0E1F23271
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 03:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6E78274;
	Sat, 17 Aug 2024 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EJF5RcuZ"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637831C32
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 03:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723867022; cv=none; b=opKMz6VooaXcxpRcXetGByrTKqqp/EeWLFXKQ1LlaUdSRTBJNcdTm3iXUolNRUpWkkAYq8JehLmwaViqGCMkY1bQiXwsO7MbXQWakkWjxt1ssn0FsaSTk+9kfWTmHMaiGL9xjnyxusok2b76X0ynYECXiKaiSa/4W6mGY7gGZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723867022; c=relaxed/simple;
	bh=mW+edLXneHKNaDh8WVW0Ej4dmT+sMZjtwb8g+tsoevs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JL4SDWm6fSt5pE62JuxxtMt2Il7PzgYHhaM7JKQaOZki9rbG+XyIXnSvIj9qw4T4qw/E6EWPB2sI5pKyUAHu5D4ntofzKzNRs3+Yq7C154dql63J/bTTagq65bIwuk6D+GJQ0tYNlqr57gWhQq7argvXFfgwtGneIBqjy9aDf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EJF5RcuZ; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723867015; bh=7wOUZF/BCD945GOv9YpvSpZ0D3vTmc0qCyK3wiLG2uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJF5RcuZEw8eu7fun1X/N0aUmoU3j8kwkqpyREREjGsj7+rkLELwI/YrZk2YdiMM0
	 Yhy3ewgfYdUDpjHCnAy/U96vHWH9+XglHNHOHeerYX6cJBh9djR3uiPqTyCPUzqpjw
	 oBU7fDXQw9c7ucCruTPNz7sANJP//s7DAHnIodwA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id DDEAEEEF; Sat, 17 Aug 2024 11:55:30 +0800
X-QQ-mid: xmsmtpt1723866930trq3amui7
Message-ID: <tencent_964B0C7439761367DC3D5337CA968C369E09@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70peDTgidQYKpSJdPj3sqEH/CBcm6p5m0d+YnztFj4J+RskCxKOL
	 bguKQAyuNtfySQmreMY4fSDS/I7uRFjkFwTdbz5rK2HuDwCKJVka8jQtIGS00x/N2MSixzUXwbdF
	 qSEHbP26hHbeJgvEMw8E9xB4PISYAmOvFEicw2SRN7zjrdBmCZeFxVvnBd6gpuUnjslZASYaUcpw
	 47HB8i06CjEhg1OVsY9s52Q5+L76yaB2z1V5oJkY0QPM4oKTwTnF84ZJoKhgK5GLICpL7fVw4FwL
	 WeRU7gfVkBLpO/13ftuf7jHmDGQqgny8sL1cSbYOz9LMN+dYjrX76883lOzhSc8fmViBEW3CVFq0
	 cMp9YTG81YzclPhleTpDxd9ayK+t7ahbvzaXgxNnshIfUVGfOQupadlpo7PkS481O50h3QERoxqK
	 A/nCT5zqo0ON5QQI8jYgftXRD5jO0muLN3E+pO8VoQmM26UeCkppYNX05ALAKmnNdWtnrht6JX2r
	 6s4LtodVy8y/HlvTaaMPMdH0PRhaqUQPrjed0bzpX3NTstxpJhM2zDYCg9mYAG4KU5e12/grhv1N
	 +aqz6a/kr4544Vw5GuU/3oePSzuwnd4opn7m3pgGHOgTPhVd31+N/vZztouxT9fJQ5y9zWFIgeCT
	 v+ZbhZ7Y3wE0SR3tq0gjMve2VHhxtVUyh1HMUxSLcUnyRU/s45kF+Huz6GEN4DC7WUUqjoFD16HQ
	 iTxg/TDR8jVkbVwAgCU0Ss3Ot6mA445W8XlZt34rFVNkWs/Ak7I5F/741aCjt0TzZXkLa+3aHX8R
	 8dU8/49Xy4HztbVqWQVN/Ds7U51CNCM6C4/Jzw5pXz6ogOJMGj614tvpbtT/1h2C2M/UEttAmT+9
	 bSpO3EaU0j4OHN4gNWhwnOoPv+8jAI7B3d+Pc8AcZh6foRI0Ctu6+ld0Zm5QKTAPXT+bnjV2JcBv
	 MX5hIvjcU=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: Fix uaf in dbFreeBits
Date: Sat, 17 Aug 2024 11:55:31 +0800
X-OQ-MSGID: <20240817035530.1724646-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000012a63d061fccab65@google.com>
References: <00000000000012a63d061fccab65@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syzbot reported]
==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/mutex.c:587 [inline]
BUG: KASAN: slab-use-after-free in __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
Read of size 8 at addr ffff8880229254b0 by task syz-executor357/5216

CPU: 0 UID: 0 PID: 5216 Comm: syz-executor357 Not tainted 6.11.0-rc3-syzkaller-00156-gd7a5aa4b3c00 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
 __mutex_lock+0xfe/0xd70 kernel/locking/mutex.c:752
 dbFreeBits+0x7ea/0xd90 fs/jfs/jfs_dmap.c:2390
 dbFreeDmap fs/jfs/jfs_dmap.c:2089 [inline]
 dbFree+0x35b/0x680 fs/jfs/jfs_dmap.c:409
 dbDiscardAG+0x8a9/0xa20 fs/jfs/jfs_dmap.c:1650
 jfs_ioc_trim+0x433/0x670 fs/jfs/jfs_discard.c:100
 jfs_ioctl+0x2d0/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83

Freed by task 5218:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kfree+0x149/0x360 mm/slub.c:4594
 dbUnmount+0x11d/0x190 fs/jfs/jfs_dmap.c:278
 jfs_mount_rw+0x4ac/0x6a0 fs/jfs/jfs_mount.c:247
 jfs_remount+0x3d1/0x6b0 fs/jfs/super.c:454
 reconfigure_super+0x445/0x880 fs/super.c:1083
 vfs_cmd_reconfigure fs/fsopen.c:263 [inline]
 vfs_fsconfig_locked fs/fsopen.c:292 [inline]
 __do_sys_fsconfig fs/fsopen.c:473 [inline]
 __se_sys_fsconfig+0xb6e/0xf80 fs/fsopen.c:345
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f 

[Analysis] 
There are two paths (dbUnmount and dbDiscardAG) that generate race
condition when accessing bmap, which leads to the occurrence of uaf.

Use the lock s_umount to synchronize them, in order to avoid uaf caused
by race condition.

Reported-and-tested-by: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3c010e21296f33a5dc16
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_dmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..a409ae18454a 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1645,7 +1645,9 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		 * call jfs_issue_discard() itself */
 		if (!(JFS_SBI(sb)->flag & JFS_DISCARD))
 			jfs_issue_discard(ip, tt->blkno, tt->nblocks);
+		down_read(&sb->s_umount);
 		dbFree(ip, tt->blkno, tt->nblocks);
+		up_read(&sb->s_umount);
 		trimmed += tt->nblocks;
 	}
 	kfree(totrim);
-- 
2.43.0


