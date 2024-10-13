Return-Path: <linux-kernel+bounces-362695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2997899B823
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 05:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789012827F3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C8E12C473;
	Sun, 13 Oct 2024 03:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Wm7vNpTZ"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87CD2F32
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728790224; cv=none; b=rDBBJoQeFd5aaxhUJDLQ/y8gmROx49s51qqdfIdCIC7JN9Za+C+0Az4x6R1BozaDzp6PbdFh2zcIjB/CkRYlc6Gy6FqBQf9YhJGJ2FsAGzUD1OSL0IiU3BDpmX893amud26xrX2l5W3Iriqo7r4UArA+TIokdar48kNL0ayDf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728790224; c=relaxed/simple;
	bh=kLkTAhIXMGoXSPT0LgUuy40+9NtpCYsl+EonRVLI5+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NidpF7sfYP8m+vyElIXVV8yP1yhh8laQHUdsmtsR0587a/EOGGLJzWoNdIxg62lr3RX70uCJw96DEq3LZ63lcXHj5EIebj5XOv8V31H9our6HBxORhroSMM5oSZcUdccGQxe3RIuQ/pI3BO8eyyc2YoQWaNGZgJETt5tFe9FFi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Wm7vNpTZ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=I8OS1SBHd3YpMYAsAyAIpNRebXq4unD8JNLpXRMmggY=;
	b=Wm7vNpTZLl9qKo8EetYRPEcoTy1rr+g2zZMbXHmcD0ku0ETV0bpnvvOmxHT5rV
	SEYJCkrmXwMS6WoyqlH4pXCw1p4HrCDLmozCySA7rswye58H7y7S4OVDvGQo3CkK
	o9RZ6C39alE4RIQl6MTOn29MkWoO2WArp0qBRKV46YQvw=
Received: from localhost (unknown [58.243.42.186])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n7uyPgtnaOU+Aw--.21893S2;
	Sun, 13 Oct 2024 11:29:54 +0800 (CST)
Date: Sun, 13 Oct 2024 11:29:54 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: syzbot <syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in jfs_lazycommit
Message-ID: <Zws-so-6TnY_FUFH@fedora>
References: <00000000000034ae0f05e9f94c79@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000034ae0f05e9f94c79@google.com>
X-CM-TRANSID:_____wD3n7uyPgtnaOU+Aw--.21893S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw13Cr47tw1kWrWUJw4kXrb_yoW5Zw17pa
	95AF47GayUJr4UWr97J3y8WayrKwnYka1Uury8twnxA3WDtrySkrsrt3W3Ar4UXr4vq34U
	XF90y34DXrs3CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRm-erUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYA52amcKw2wJNwABsP

#syz test

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
Best,
Qianqiang Liu


