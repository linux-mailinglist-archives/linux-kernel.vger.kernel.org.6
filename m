Return-Path: <linux-kernel+bounces-362717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6692C99B86C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 08:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256B72816D5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 06:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9517A724;
	Sun, 13 Oct 2024 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KLfr8CEL"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B252E406
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728799586; cv=none; b=syMdsiZ+Uv/6a7ZX9eB0WbXxwd51B3x6srX0PB35N4+lChGU/5cEgZyaICjdQ7oFgG1bZEeq8/Xpy84KEoJw74/vfcaVlbds9RSEEQ/V7uDWSckzTPW72AZL1zAN++BF8J+ClImQ3RXczAgUYiDMcLr/fBKujotJkSD6jIzU8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728799586; c=relaxed/simple;
	bh=kLUTpLY7HcsktQRCzg7Rw2vIAvPwaquZtXvOVjaaNO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+97AqncUoO/QotCnwCY93vLrhKLOuvMIVVNhShdz3Ki1qgSLCf9Z70AvsK7A+W2RiZa4jxQu7jBQ+WkkH2VVm2AOlk3B2K3TLaqYQy2BuXX9pQ6pYNzVZTkhm8tQ/MPsWoPre7g32h5Jv6kx5cZQt3GR9Aaj0zZW6Lc+A2uKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KLfr8CEL; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=wkk6DJRhizZPLhSQxX5dUpPZTlU/n6LDIhPssTWtIR4=;
	b=KLfr8CELtuA9jQPn08TLcTH2vaxhCskVuJsljmtsLvfr3REaxRj4OO2KGPq42U
	tMq+sKUFcnXub8pu62nw289SXIVZ4h0sL8bfjQw+6JUYYKBadC0uyn7OBwVg52gP
	NbAg1JoZvPU7PGhea1wT6D3rzm5OCIDJVeS25bBkHYess=
Received: from localhost (unknown [58.243.42.186])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBX3441YwtnuRtYAw--.22898S2;
	Sun, 13 Oct 2024 14:05:42 +0800 (CST)
Date: Sun, 13 Oct 2024 14:05:41 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: dave.kleikamp@oracle.com
Cc: shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: Fix use-after-free read issue in jfs_lazycommit
Message-ID: <ZwtjNd_koDuU_MT_@fedora>
References: <Zws-so-6TnY_FUFH@fedora>
 <670b513e.050a0220.3e960.0033.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <670b513e.050a0220.3e960.0033.GAE@google.com>
X-CM-TRANSID:_____wBX3441YwtnuRtYAw--.22898S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFy7GF1DAr1UXF45XFyfCrg_yoWrXrW7pa
	95AF47G3yDJr1UWF97J3y8Wa4rK3sYkayUWrW8tw1av3Wqqr1fCrsrt3WSyr1UXrZ2q34U
	XF90y34DXr4Ik3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwzVbUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRRx3amcLUmTmQgAAs6

The jfsCommit kernel thread uses the sbi->commit_state flag,
and sbi may be freed in jfs_put_super() by another thread.

To prevent this, move commit_state to struct tblock,
eliminating the need to access the sbi variable.

Reported-by: syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=885a4f3281b8d99c48d8
Tested-by: syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com
Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 fs/jfs/jfs_incore.h |  8 --------
 fs/jfs/jfs_txnmgr.c | 10 ++++------
 fs/jfs/jfs_txnmgr.h |  8 ++++++++
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 10934f9a11be..7b75c801b239 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -177,11 +177,6 @@ struct jfs_sb_info {
 	pxd_t		ait2;		/* pxd describing AIT copy	*/
 	uuid_t		uuid;		/* 128-bit uuid for volume	*/
 	uuid_t		loguuid;	/* 128-bit uuid for log	*/
-	/*
-	 * commit_state is used for synchronization of the jfs_commit
-	 * threads.  It is protected by LAZY_LOCK().
-	 */
-	int		commit_state;	/* commit state */
 	/* Formerly in ipimap */
 	uint		gengen;		/* inode generation generator*/
 	uint		inostamp;	/* shows inode belongs to fileset*/
@@ -199,9 +194,6 @@ struct jfs_sb_info {
 	uint		minblks_trim;	/* minimum blocks, for online trim */
 };
 
-/* jfs_sb_info commit_state */
-#define IN_LAZYCOMMIT 1
-
 static inline struct jfs_inode_info *JFS_IP(struct inode *inode)
 {
 	return container_of(inode, struct jfs_inode_info, vfs_inode);
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index be17e3c43582..a4817229d573 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2700,7 +2700,6 @@ int jfs_lazycommit(void *arg)
 	int WorkDone;
 	struct tblock *tblk;
 	unsigned long flags;
-	struct jfs_sb_info *sbi;
 
 	set_freezable();
 	do {
@@ -2711,17 +2710,16 @@ int jfs_lazycommit(void *arg)
 			list_for_each_entry(tblk, &TxAnchor.unlock_queue,
 					    cqueue) {
 
-				sbi = JFS_SBI(tblk->sb);
 				/*
 				 * For each volume, the transactions must be
 				 * handled in order.  If another commit thread
 				 * is handling a tblk for this superblock,
 				 * skip it
 				 */
-				if (sbi->commit_state & IN_LAZYCOMMIT)
+				if (tblk->commit_state & IN_LAZYCOMMIT)
 					continue;
 
-				sbi->commit_state |= IN_LAZYCOMMIT;
+				tblk->commit_state |= IN_LAZYCOMMIT;
 				WorkDone = 1;
 
 				/*
@@ -2733,7 +2731,7 @@ int jfs_lazycommit(void *arg)
 				txLazyCommit(tblk);
 				LAZY_LOCK(flags);
 
-				sbi->commit_state &= ~IN_LAZYCOMMIT;
+				tblk->commit_state &= ~IN_LAZYCOMMIT;
 				/*
 				 * Don't continue in the for loop.  (We can't
 				 * anyway, it's unsafe!)  We want to go back to
@@ -2781,7 +2779,7 @@ void txLazyUnlock(struct tblock * tblk)
 	 * Don't wake up a commit thread if there is already one servicing
 	 * this superblock, or if the last one we woke up hasn't started yet.
 	 */
-	if (!(JFS_SBI(tblk->sb)->commit_state & IN_LAZYCOMMIT) &&
+	if (!(tblk->commit_state & IN_LAZYCOMMIT) &&
 	    !jfs_commit_thread_waking) {
 		jfs_commit_thread_waking = 1;
 		wake_up(&jfs_commit_thread_wait);
diff --git a/fs/jfs/jfs_txnmgr.h b/fs/jfs/jfs_txnmgr.h
index ba71eb5ced56..3a0ee53f17cb 100644
--- a/fs/jfs/jfs_txnmgr.h
+++ b/fs/jfs/jfs_txnmgr.h
@@ -32,6 +32,11 @@ struct tblock {
 
 	/* lock management */
 	struct super_block *sb;	/* super block */
+	/*
+	 * commit_state is used for synchronization of the jfs_commit
+	 * threads.  It is protected by LAZY_LOCK().
+	 */
+	int commit_state;	/* commit state */
 	lid_t next;		/* index of first tlock of tid */
 	lid_t last;		/* index of last tlock of tid */
 	wait_queue_head_t waitor;	/* tids waiting on this tid */
@@ -56,6 +61,9 @@ struct tblock {
 	u32 ino;		/* inode number being created */
 };
 
+/* tblock commit_state */
+#define IN_LAZYCOMMIT 1
+
 extern struct tblock *TxBlock;	/* transaction block table */
 
 /* commit flags: tblk->xflag */
-- 
2.47.0


