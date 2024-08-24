Return-Path: <linux-kernel+bounces-299847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24A395DAC1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C3F283BFB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060591EB44;
	Sat, 24 Aug 2024 02:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VyKKQLTQ"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0143EEB5
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724468157; cv=none; b=Q3eRngysAa3xj757SROlWJDyKzya8My7o7nLqktnrQ9MfaPiln3hdONLo33cAu1x6LZiKPM6dWkmtXc+OUSVdL7E1OPRrJKAWpMcFXB73oeF7eLxDvtUpiGtxtkkamIQ4gxfcT2Z8PaGoS6dv1ZCnj2DGHPu37daumhdY1SJWl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724468157; c=relaxed/simple;
	bh=ghWsXp4H+5r3EYHYkU0eQzIH+F7K8mMa/1B6z7Q/Pps=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=GhDiZCyBuYzNoROly3PefQ6waCgrUwyPbzdcAPRjZaRjywyZnfUeSoa4H9heDcxF7RDPSC/45qZC1NOvgxhtbTvIXuwW9P7pPSK4XiNneu/u1SptDBcw/TRc9HXKDRrSZ3LfFwSAUD4klw0fvQ4plz/J5PDimAsI0K0k/PRzTg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VyKKQLTQ; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724467849; bh=kVJHPNhzwxRX6yfF0ca1NTAcedwk3l+orSURj7G3l7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VyKKQLTQWEQNFqP4v0bF3hcclOXfl0m6OLFfjiWfiwPgu8rDtvWNS5qn7TXZn80l2
	 IlTK1wk6IxotTv74Ol2z8ml5+V/E6V8ijpMiqiZf6vARRQbputZd48GVu57YS053bX
	 ixS0qsXQtaaRZ7c74HLLGUxHwkcswuaDj7WL79H0=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id CAFA2E41; Sat, 24 Aug 2024 10:50:47 +0800
X-QQ-mid: xmsmtpt1724467847tikegh6qp
Message-ID: <tencent_E4D346450985EEC5AECDCC84A7FF06D01206@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9yYttMuwSPYJxwNr9uj5QzLy/nAMj3DsiK5Gp8cK9PbgxB6Yb6g
	 WjRumFbv7teZ2vJvkAELrzF0gCAU7Ua5sA8QaPOkYEmu4w3nJ7fs+E3dsEzKHthJgar9kN1gH7TN
	 M/OPafBUTGVWTEu9cD6H4JYFVJSNBJFt1D5LyZMLlE7DpPcAs+NioqcqXLUf3c2elkimqGjZoE0V
	 BjQ/UAgSF6suCu0aEypSOrBokM1tzoBq4BdTlIndLKX69I+cyKchsVfSLSeVFxR1ajyCSkGzyput
	 O1b+EaTPASawdIcPjg81r4UFVspT3J45xVL/EaQukb/fKKbT4BsBI/IM2jnJrflZHMHaEQbnb022
	 r6ks6WRAzAEw/t7Mfwsgp4/jUOijc5QZoPn7wjXLkycBhBmBb6Mm/6dFcHPTvCn6ZZe/HjKqKXBf
	 H5ZYcsLq3QO/AmpNHJnIs9xLBPPfFQTLloe17ag6BPrdODSHuHaA/px2ZPfPzhcwcwe28ukK96pf
	 tYZzpk13w+JOopIhN0cg+w4MQU+QZnZV8K4CGR/+iy0p+9djt1iQ92IxE3txVbMRmzDoxMAZ6A9U
	 XZiFFUH5PMBWNoyP4dW3ef5n02rWLTIyb7/5qjHBZuJ4QeTp9F3aasOjmaOtrmmXPeEqc4yXc21g
	 YQ8DatVYupXVfu68d0a3t9pjdQwRpJ2krBqGaZNSkpvHn70ZY3f2wSrlg2Wfcm86+eQNWhF8Wh67
	 pS+2dMXbNocOZC1/PRyRjkZufSyXUIEJnZwmynXylNEQer+X3F17ijGfJ7BwihHEq4VZ/iqHNJ27
	 uxdmDHlnQZJQQA3NtVA7oFQ+SL45t0h7HBhaYDzq/Wb50vhYtG2hIGBP19mnQptj3VC2A8DidxR+
	 IF4TkYiJQAqYs7IRSqcLO/hBeMaaW/9zBbL5BX7fhy6JgVLKLlTQzuNrz3X3zQub9T7G1gk9FI7l
	 wV2eiaACe82vC034r1e9Rwtq5RDArldad6GQi805d8UDnM9kZCJFtoiKBgQ/mvS57IbFXGsSizP/
	 8qg2h0Nw==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: dave.kleikamp@oracle.com
Cc: eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] jfs: Fix uaf in dbFreeBits
Date: Sat, 24 Aug 2024 10:50:48 +0800
X-OQ-MSGID: <20240824025047.1258030-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <1ea4fe05-c6e0-472a-a01b-ab6a0c4c9f76@oracle.com>
References: <1ea4fe05-c6e0-472a-a01b-ab6a0c4c9f76@oracle.com>
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
There are two paths (dbUnmount and jfs_ioc_trim) that generate race
condition when accessing bmap, which leads to the occurrence of uaf.

Use the lock s_umount to synchronize them, in order to avoid uaf caused
by race condition.

Reported-and-tested-by: syzbot+3c010e21296f33a5dc16@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V2: serialize jfs_ioc_trim()

 fs/jfs/jfs_discard.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
index 575cb2ba74fc..5f4b305030ad 100644
--- a/fs/jfs/jfs_discard.c
+++ b/fs/jfs/jfs_discard.c
@@ -65,7 +65,7 @@ void jfs_issue_discard(struct inode *ip, u64 blkno, u64 nblocks)
 int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 {
 	struct inode *ipbmap = JFS_SBI(ip->i_sb)->ipbmap;
-	struct bmap *bmp = JFS_SBI(ip->i_sb)->bmap;
+	struct bmap *bmp;
 	struct super_block *sb = ipbmap->i_sb;
 	int agno, agno_end;
 	u64 start, end, minlen;
@@ -83,10 +83,15 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 	if (minlen == 0)
 		minlen = 1;
 
+	down_read(&sb->s_umount);
+	bmp = JFS_SBI(ip->i_sb)->bmap;
+
 	if (minlen > bmp->db_agsize ||
 	    start >= bmp->db_mapsize ||
-	    range->len < sb->s_blocksize)
+	    range->len < sb->s_blocksize) {
+		up_read(&sb->s_umount);
 		return -EINVAL;
+	}
 
 	if (end >= bmp->db_mapsize)
 		end = bmp->db_mapsize - 1;
@@ -100,6 +105,8 @@ int jfs_ioc_trim(struct inode *ip, struct fstrim_range *range)
 		trimmed += dbDiscardAG(ip, agno, minlen);
 		agno++;
 	}
+
+	up_read(&sb->s_umount);
 	range->len = trimmed << sb->s_blocksize_bits;
 
 	return 0;
-- 
2.43.0


