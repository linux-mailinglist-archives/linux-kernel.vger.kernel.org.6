Return-Path: <linux-kernel+bounces-523494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A51A3D785
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994EA17A1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A4A1F1921;
	Thu, 20 Feb 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KmSC6Rr3"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C11EFF9B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049022; cv=none; b=eDW6ImnSMWXJFauKCjnGkdUCdH6KLyZBOiby+mcDX4JxPgj/Lgo+xZKC4Z7EISUu9p1Qyvb1/1p+YYxPpKA0KDLF2+34/k7/afQ5v6rvclwsLacEftVHKwdnyqLuikCa0efP44a9QRzdL+p79ryjY5rWMhJMOdYMvjza0/9Li24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049022; c=relaxed/simple;
	bh=SZfmAmb2rQMuLecJdA141op3zsd5xJtkGc/NfORa9JQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=L/EeNd601aS77OQaLkVUfLOvXZDO0bTWbVN5u14vpMQyT8PqH4GMUkrgjf9M2sv3ru2jSv6fKEsLHimDN5N6XlhhkxBZWT2XwfwWvQhTy7XfoUmQQNqP72qyMvQgpsMhqyHSqrr8jkqI6GS16HqMkuQ2gPUVzLM4yzbs3cpyzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KmSC6Rr3; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740049006; bh=odwZp9Z8xIMju+pCsGHH8ZjGFNxI2nF5rOdnRbiIXro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KmSC6Rr3sA2U/vowrVP3F0SDYqRaxqCr/TM2fbrdLF4JW7Q2Q9MJVF/etv3QXgd0Z
	 vF4ooqYGwgK7OgQjPNilt9L3YG8zYaipbc2aRRtzYkLBV3tPLzbkr2hn8f8EmeTA9K
	 sNthHZrM1yKBD0vVtzczBZAGVySjdg3iF/wu/PMs=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id E2C0E25E; Thu, 20 Feb 2025 18:56:44 +0800
X-QQ-mid: xmsmtpt1740049004tuormpf61
Message-ID: <tencent_B2A58C0DE192505DFEDD889955CFD58DA207@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69kwZHI7Dzm5Kz+VynHXEGcfBu7ol1O+aJB+yjqEYqVTuiMARVBH
	 qXRS0yuyV9I1H5Nw2PLZ+UseJAEDOHYYA8w50WQjxhFJnKq7RFs9TBuhXUzfZNZeenGrKswb4NxG
	 mmCRdFvAHqnFU/RJuG/HSGIR8qyGbABWQHh+AWeNZ86PzkFlTNcvCsy824lxzaA7YWCfeHTXfyCv
	 ODBRnVgZUwr2p6DKciEskBBCcal0KC+Kyy5gayDYBQJeCMcfyh/and76ESnbToKfaNN80wzJg2hr
	 U/JNlNE+M1PU7UtB11cg8vHse3QnmfZZYT6jd2GsAdg7A2CQJt4o0HkWt7K1zOm51hm92+ebPTa5
	 2I8qZeUd5z3p4ErMyKqAWOP7QJBZLptxHBqrPWsangz76ObnMzx7N3hk5Guv/jKPnCbatSIcwwBu
	 oUfSJlPO+c1w0WmV5mdsHzkHr8EfWiIdXyAZksDrQSQoaCLjY6vGVS1f/h6+QBpBNVyhw7xecX6I
	 XLU97WSM6586zDMk79v1utkkH68kQ8VHRBf0Pju95+x3Tr8DSCEb2+PrsUy7VuU8cD8pLKfbPih0
	 VypribhaXvw/Ce8ajAEWzTWP0XarZL8f5uoBeIWjP/EBjqiXHAXhglCk/k2ZgrhoSi7fW3oqURPL
	 5Yu4ryLwSmThjY8hA1hGxpeQXIsLWjo8amkTv3QRWJMJUDNckNi7wQ70YBX5mqk7HmAohbFTxe7j
	 F7cLoxn4fHXEbWbB17QEK0LY6gB7HIVhH84hYHMD1e3LdCbJbCJsrifd6nTiWy01qEvv6PSHc2r5
	 uZbNWzLArVHKUszZTBhz3ytmCAPVa3to5ura1or8YU2ZFFUM+/VK8UMOElcbvjNtFUebujsxo8jw
	 lhNKPU+ADvJY7YI+VISeHVOT0BF/JMGVbFtJYBeNENZxpyfTM4FqI=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: dave.kleikamp@oracle.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] jfs: Initialized first 8 members of the dinomap when creating imap
Date: Thu, 20 Feb 2025 18:56:45 +0800
X-OQ-MSGID: <20250220105644.2282263-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <046f91fc-dc84-48de-b2e0-9f072283facd@oracle.com>
References: <046f91fc-dc84-48de-b2e0-9f072283facd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a uninit-value in diFree. [1]

When print_hex_dump() is called to print the first 32 bytes of imap, the
first 8 members in struct dinomap are the first 32 bytes of imap, because
in_numinos, in_numfree, in_diskblock and in_maxag are not initialized when
imap is created.

When creating imap, set in_numinos, in_numfree, in_diskblock and in_maxag
to 0 to prevent this issue from happening.

[1]
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0x888/0x1100 lib/hexdump.c:171
 hex_dump_to_buffer+0x888/0x1100 lib/hexdump.c:171
 print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
 diFree+0x5ba/0x4350 fs/jfs/jfs_imap.c:876
 jfs_evict_inode+0x510/0x550 fs/jfs/inode.c:156
 evict+0x723/0xd10 fs/inode.c:796
 iput_final fs/inode.c:1946 [inline]
 iput+0x97b/0xdb0 fs/inode.c:1972
 txUpdateMap+0xf3e/0x1150 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x627/0x11d0 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x6b9/0xef0 kernel/kthread.c:464
 ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4121 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 __kmalloc_cache_noprof+0x8e3/0xdf0 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 diMount+0x61/0x7f0 fs/jfs/jfs_imap.c:105
 jfs_mount+0xa8e/0x11d0 fs/jfs/jfs_mount.c:176
 jfs_fill_super+0xa47/0x17c0 fs/jfs/super.c:523
 get_tree_bdev_flags+0x6ec/0x910 fs/super.c:1636
 get_tree_bdev+0x37/0x50 fs/super.c:1659
 jfs_get_tree+0x34/0x40 fs/jfs/super.c:635
 vfs_get_tree+0xb1/0x5a0 fs/super.c:1814
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3560
 path_mount+0x742/0x1f10 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x71f/0x800 fs/namespace.c:4088
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4088
 x64_sys_call+0x39bf/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83

Reported-by: syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=df6cdcb35904203d2b6d
Tested-by: syzbot+df6cdcb35904203d2b6d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: add missing others two fields of dinomap

 fs/jfs/jfs_imap.c | 4 ++++
 fs/jfs/jfs_imap.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index a360b24ed320..0cedaccb7218 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -134,6 +134,10 @@ int diMount(struct inode *ipimap)
 		imap->im_agctl[index].numfree =
 		    le32_to_cpu(dinom_le->in_agctl[index].numfree);
 	}
+	imap->im_diskblock = 0;
+	imap->im_maxag = 0;
+	imap->im_enuminos = 0;
+	imap->im_enumfree = 0;
 
 	/* release the buffer. */
 	release_metapage(mp);
diff --git a/fs/jfs/jfs_imap.h b/fs/jfs/jfs_imap.h
index dd7409febe28..9af1da2e4591 100644
--- a/fs/jfs/jfs_imap.h
+++ b/fs/jfs/jfs_imap.h
@@ -144,6 +144,8 @@ struct inomap {
  */
 #define	im_diskblock	im_imap.in_diskblock
 #define	im_maxag	im_imap.in_maxag
+#define	im_enuminos	im_imap.in_numinos
+#define	im_enumfree	im_imap.in_numfree
 
 extern int diFree(struct inode *);
 extern int diAlloc(struct inode *, bool, struct inode *);
-- 
2.43.0


