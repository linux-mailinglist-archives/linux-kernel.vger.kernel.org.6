Return-Path: <linux-kernel+bounces-523521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265AAA3D7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867AF3AD3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969061EF096;
	Thu, 20 Feb 2025 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IJTR6M+X"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20861B0F19
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050011; cv=none; b=LAdw08BlF4M+QnScCft7vgrSuCluGTWhBdIg1KVpp+LcqFe4Qk2Vo64FnXgef7eVHVQbVOp9se6RhxuvX78v0JrkdFiDlY/Kj2Q3DbJ30dZ1sxoDXac0TV1kPfwP70hjtGAISqzj1q9tpLw730gox3ljTk/CfVrAqgP6veCCZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050011; c=relaxed/simple;
	bh=E5BHwTCE4e8h2G6UeFk88GJE2q/0S3+An7iBunPIN/c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pNfv9WYYGHnjfNxEub+/JPl83KMvMn7h2pfUTJZTT2O6KQKDMmXUpnjRYyFGRT/5zAEu6fLR1awazM4f6k1Bh3LSIQ0ckv3196F7crEdS8aQDtxb1GAv2TbmUK24eQR/zAQAYUz7XjGacLIY1R73oPjldCGSwQQtihKS2Yq1MP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IJTR6M+X; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740050003; bh=KF6uDAiNEy/NxbwADJhvETXLyW36Mj39HsyXIpVucTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJTR6M+Xvh5ShHOowqTOh30D4hkT0Z9bZvZZSl6K/J6D1BB43vvI0Kk7UaKrGO/ZO
	 5veDOr1uuE4JKpAMDW2GSzvR4Fm2GwXuYpH9Yq4yp2+iaAgLWy2W0UyD/+pEsKIFRY
	 NCu7suEA+yLxxogoAqdxJcQkCLQ5H5zhtClJmYk0=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 355052BA; Thu, 20 Feb 2025 19:13:21 +0800
X-QQ-mid: xmsmtpt1740050001tkyzp4wjv
Message-ID: <tencent_8C6B26DD7364836B096F23B1244E177F3705@qq.com>
X-QQ-XMAILINFO: OCYbvBDBNb9rKu1+SRd4LswjY1FvIowzqv9NhJI/sLepwMJKoeuwiLO/cFk10X
	 CljWmON6jDDOSOHPj/qp75FfZ5Mtih8fgLt4mwhmMnK0qik6RkGF5MRJZHg3xl1Ao2bQdsDuRe7u
	 +dRNxT9asOXBvq6hctYUQOcma90k2zKa9WdsPkQY3i4xKsgRKemu/Gr7a/G8uK0/HClO23BRyNpK
	 JsogImOh0+j9UMqyryTvcwewRob3UDlPm28nXjB3wYTHJjSPEqdIqwvPAkOtdSO15PQTQOd2TEYv
	 84O4RVUcWTLhYhkrADw1BHmFNDSa38sKWdjUqXe2jtAUiXVbkpRMr2dkt3K9Xvvudza9rbYhuaZu
	 aA59lSnKu8zCWkYh14Z8dlXGzEh14R1Cl0aEEEgw8Sm2Nkv8ZCzWXGm6WAYRaIjKgCpdD7Z9sQGU
	 QzRQ4k7vCnouvVLUzoEMbIVsnyafgHxGjEscZT62+3d161niUcHmgHcwUJMEVR/uzJ9QwZo3N0wi
	 vISBFJtpGHRj/zOdKz8mQr5UaEMcwP2k5oqWGfjWW05BVDuGPUn64HSLlcfMNvrc4cDISYVtMnmn
	 OntezZm/grgML5uZL4Lc9dzUKgiQyH0FVh8hwLZgiJIbCvV1Gzlv6XkfMYyS12s/eSZlBDsoSzK3
	 AmAKdchz6ZcDoio2THbvWkM8g6MMYo9GmVqHcVhYLN5IijnHH8f4iGohQMDxsixS6k87bonS1CXb
	 Qme0ll8/krCYwzQiFqJOCKNAgy5M6MPFMH546j+OlDlQHEb4sCG641By/+fvvbTaQi+dlRb3G/5w
	 aPMt9Vn9NZKgQ6b+/ZFL7AgIF0qrChV3CPtRyukNSB/4wFVqXlUxw80kvJcJlnDT/JoF4KS4eCjz
	 Z6L9gOoT3+41AnOntLzdBNBEETYGGGU7TqZJ0aMvjtefz2ReyRoVae8rPQ4w2N3g==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: dave.kleikamp@oracle.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzbot+355da3b3a74881008e8f@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V3] jfs: Prevent copying of nlink with value 0 from disk inode
Date: Thu, 20 Feb 2025 19:13:21 +0800
X-OQ-MSGID: <20250220111321.2299005-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <b72fbe46-f910-4181-8d5b-fdc66d46700a@oracle.com>
References: <b72fbe46-f910-4181-8d5b-fdc66d46700a@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot report a deadlock in diFree. [1]

When calling "ioctl$LOOP_SET_STATUS64", the offset value passed in is 4,
which does not match the mounted loop device, causing the mapping of the
mounted loop device to be invalidated.

When creating the directory and creating the inode of iag in diReadSpecial(),
read the page of fixed disk inode (AIT) in raw mode in read_metapage(), the
metapage data it returns is corrupted, which causes the nlink value of 0 to be
assigned to the iag inode when executing copy_from_dinode(), which ultimately
causes a deadlock when entering diFree().

To avoid this, first check the nlink value of dinode before setting iag inode.

[1]
WARNING: possible recursive locking detected
6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0 Not tainted
--------------------------------------------
syz-executor301/5309 is trying to acquire lock:
ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diFree+0x37c/0x2fb0 fs/jfs/jfs_imap.c:889

but task is already holding lock:
ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diAlloc+0x1b6/0x1630

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&(imap->im_aglock[index]));
  lock(&(imap->im_aglock[index]));

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz-executor301/5309:
 #0: ffff8880422a4420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff88804755b390 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
 #1: ffff88804755b390 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: filename_create+0x260/0x540 fs/namei.c:4026
 #2: ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diAlloc+0x1b6/0x1630
 #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diNewIAG fs/jfs/jfs_imap.c:2460 [inline]
 #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diAllocAG+0x4b7/0x1e50 fs/jfs/jfs_imap.c:1669
 #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diNewIAG fs/jfs/jfs_imap.c:2477 [inline]
 #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diAllocAG+0x869/0x1e50 fs/jfs/jfs_imap.c:1669

stack backtrace:
CPU: 0 UID: 0 PID: 5309 Comm: syz-executor301 Not tainted 6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
 check_deadlock kernel/locking/lockdep.c:3089 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 diFree+0x37c/0x2fb0 fs/jfs/jfs_imap.c:889
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x4e8/0x9b0 fs/inode.c:725
 diFreeSpecial fs/jfs/jfs_imap.c:552 [inline]
 duplicateIXtree+0x3c6/0x550 fs/jfs/jfs_imap.c:3022
 diNewIAG fs/jfs/jfs_imap.c:2597 [inline]
 diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
 diAllocAG+0x17dc/0x1e50 fs/jfs/jfs_imap.c:1669
 diAlloc+0x1d2/0x1630 fs/jfs/jfs_imap.c:1590
 ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1c5/0xba0 fs/jfs/namei.c:225
 vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
 do_mkdirat+0x264/0x3a0 fs/namei.c:4280
 __do_sys_mkdirat fs/namei.c:4295 [inline]
 __se_sys_mkdirat fs/namei.c:4293 [inline]
 __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported-by: syzbot+355da3b3a74881008e8f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=355da3b3a74881008e8f
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: if the nlink of disk inode is 0 return -EIO
V2 -> V3: move the checking to diReadSpecial

---
 fs/jfs/jfs_imap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 0cedaccb7218..25bb3485da3b 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -460,7 +460,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
 	dp += inum % 8;		/* 8 inodes per 4K page */
 
 	/* copy on-disk inode to in-memory inode */
-	if ((copy_from_dinode(dp, ip)) != 0) {
+	if (!le32_to_cpu(dp->di_nlink) || (copy_from_dinode(dp, ip)) != 0) {
 		/* handle bad return by returning NULL for ip */
 		set_nlink(ip, 1);	/* Don't want iput() deleting it */
 		iput(ip);
-- 
2.43.0


