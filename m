Return-Path: <linux-kernel+bounces-524896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A704DA3E87D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A3177299
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AB326561A;
	Thu, 20 Feb 2025 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="v5gnufXI"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04F6267384
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094191; cv=none; b=YgLExhQ+GzKHm6ysxYJmi3HVs17nAXCJgTYiU0G2uniBS1PXUeRU2vYn00O7/EgMmPkmXJ45NYxFdAGG5dV0skmNjrGo3wRtotLTK42RGzs+c/Rcy/tcGnPj5sXrBsprZcCIJ/H+Un1IHfPMb6QPrFVTbeyqIGxTZX9p056pLHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094191; c=relaxed/simple;
	bh=Te8Sn2i1mhO8p77HsI0a9er5W+pSPjekSKfc8nXrCOc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=A5lps635PsBIgOokaKavMvxhxbEIm+cNPu4KcsmHXIs62UJsKEA7aiJMLwLDLEgoyh8iCFdnMxz9mH77j5FaNiOB6WHXkP86YsoimeJxDfVH22icSkC5a89906heHlX7SAffwrw2chggkprl0BuQNofMUWkhmrTeM4DCsOu5aGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=v5gnufXI; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740094178; bh=ZiYtMMsDkezB8qL0XwW0nKDIgPIiqn3cuvRtGPQ7sTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=v5gnufXIuBw65Vec/8b/XdZknTtnUSVY8vjH+Cu3BZdkgDLT6BDJf9qHIYrTD5RI2
	 fnJzX6g7GgD4yILUEqDHREnW42gG/K+mx2bkXOoefGMOnRvkduhOyzFHWg2KIJ9qx/
	 Oak68wdIRPoIDr4zapAGfUIS2QyX7lhVMu7ArVMs=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 5B8AE4C3; Fri, 21 Feb 2025 07:22:56 +0800
X-QQ-mid: xmsmtpt1740093776tw6zhpnl0
Message-ID: <tencent_AB576D46C3736DE3606961C3B7844CF76A05@qq.com>
X-QQ-XMAILINFO: N5RaH4rPr235hWl+rSGVn654xCQrHCr+Coo8788dmRSriLiakbAPpH8CkPB2/O
	 jnHv9A0eD7HHIr0yR3fEojDzoTarhptc0eMtuEnet+F0uWQxIhAcAk3V1K19z93nLz/1ayVwPPOS
	 ytczA0SQXvK2c6eiQlnkFxJANayEsxX7FffQ07X7ryMgmlBCCZ48VTjn4WrR31pOgNpwamEpInpb
	 Pgdw/npUxonQNTjBftWqEmUiEzsUYOhJnL6n/cm3cmvIE1TK9FixKoj8R3KFv30H8Ne6XJUZ975y
	 IV++yDW57RZ20HUanP3djCkbochPouCdgWQx3DqTFXYgknKvEXDOoad0z3MFtMqDQQnCcjM5yPUo
	 Cuvona+GZ9jPgp7lxzTRdRbfVn1B5HhM2fuecmgbShkVJJKICWa4pjJhN/j/XlwjJsyRRWCTWol4
	 MRBR1dXLNCrE/XjXl3P9LPn1skmo2TBzGDH79McNP9G7q3RSaeloaPj2vUEONJ1QisZLwtfzDp2M
	 ZbiXDFhPw17aVADH+wIhYObIazsp1zARSryGi/FnS3Wu7AYd8QXc35nNc4bXvG58qkVdphq8x+bx
	 vmMXEQ0U6nOXvW4Suxr0wpDS+fS8BK9dhq5SPXmcxb9j5sSAGcxmZ8Ynk+u/gKxkBnuTk/R/mUqu
	 8SZpYbTQF3OSYYyXrp7F4gbCOtM7c0AKLme+Ur6WkaR+D7ajHhB2ADZSGSM4ayt8iggBpS+oWgtV
	 rfdsj99/qixJ22FC8mkRYiWoX1LxZh/mykpU6yvDErb9cU9AoYk2DC9Z49QKhe7s8FOL+JYlRItA
	 qqlLQc3GULaB9VBtRnSCItOGGhXEFLlCp3qQQArwpY9opUbTcG7zJAbdC8IYP2enDRRhn5YPvDMJ
	 iOXIUWjB4hN1Mno47uw52zzSB0VsNpMZgggKajJOmGo1PPfsWTzO2iXEJzPy14sBYceS9zf2jXZz
	 4RAmBVuCxpP0mXlMY1HQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: dave.kleikamp@oracle.com
Cc: eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+355da3b3a74881008e8f@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] jfs: Prevent copying of nlink with value 0 from disk inode
Date: Fri, 21 Feb 2025 07:22:56 +0800
X-OQ-MSGID: <20250220232255.2480254-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <53b75296-d73e-40fe-88dd-9103f3edd3c1@oracle.com>
References: <53b75296-d73e-40fe-88dd-9103f3edd3c1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 10:15:04 -0600, Dave Kleikamp wrote:
> > syzbot report a deadlock in diFree. [1]
> > 
> > When calling "ioctl$LOOP_SET_STATUS64", the offset value passed in is 4,
> > which does not match the mounted loop device, causing the mapping of the
> > mounted loop device to be invalidated.
> > 
> > When creating the directory and creating the inode of iag in diReadSpecial(),
> > read the page of fixed disk inode (AIT) in raw mode in read_metapage(), the
> > metapage data it returns is corrupted, which causes the nlink value of 0 to be
> > assigned to the iag inode when executing copy_from_dinode(), which ultimately
> > causes a deadlock when entering diFree().
> > 
> > To avoid this, first check the nlink value of dinode before setting iag inode.
> > 
> > [1]
> > WARNING: possible recursive locking detected
> > 6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0 Not tainted
> > --------------------------------------------
> > syz-executor301/5309 is trying to acquire lock:
> > ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diFree+0x37c/0x2fb0 fs/jfs/jfs_imap.c:889
> > 
> > but task is already holding lock:
> > ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diAlloc+0x1b6/0x1630
> > 
> > other info that might help us debug this:
> >   Possible unsafe locking scenario:
> > 
> >         CPU0
> >         ----
> >    lock(&(imap->im_aglock[index]));
> >    lock(&(imap->im_aglock[index]));
> > 
> >   *** DEADLOCK ***
> > 
> >   May be due to missing lock nesting notation
> > 
> > 5 locks held by syz-executor301/5309:
> >   #0: ffff8880422a4420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
> >   #1: ffff88804755b390 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
> >   #1: ffff88804755b390 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: filename_create+0x260/0x540 fs/namei.c:4026
> >   #2: ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diAlloc+0x1b6/0x1630
> >   #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diNewIAG fs/jfs/jfs_imap.c:2460 [inline]
> >   #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
> >   #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diAllocAG+0x4b7/0x1e50 fs/jfs/jfs_imap.c:1669
> >   #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diNewIAG fs/jfs/jfs_imap.c:2477 [inline]
> >   #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
> >   #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diAllocAG+0x869/0x1e50 fs/jfs/jfs_imap.c:1669
> > 
> > stack backtrace:
> > CPU: 0 UID: 0 PID: 5309 Comm: syz-executor301 Not tainted 6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:94 [inline]
> >   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >   print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
> >   check_deadlock kernel/locking/lockdep.c:3089 [inline]
> >   validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
> >   __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
> >   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
> >   __mutex_lock_common kernel/locking/mutex.c:608 [inline]
> >   __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
> >   diFree+0x37c/0x2fb0 fs/jfs/jfs_imap.c:889
> >   jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
> >   evict+0x4e8/0x9b0 fs/inode.c:725
> >   diFreeSpecial fs/jfs/jfs_imap.c:552 [inline]
> >   duplicateIXtree+0x3c6/0x550 fs/jfs/jfs_imap.c:3022
> >   diNewIAG fs/jfs/jfs_imap.c:2597 [inline]
> >   diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
> >   diAllocAG+0x17dc/0x1e50 fs/jfs/jfs_imap.c:1669
> >   diAlloc+0x1d2/0x1630 fs/jfs/jfs_imap.c:1590
> >   ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
> >   jfs_mkdir+0x1c5/0xba0 fs/jfs/namei.c:225
> >   vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
> >   do_mkdirat+0x264/0x3a0 fs/namei.c:4280
> >   __do_sys_mkdirat fs/namei.c:4295 [inline]
> >   __se_sys_mkdirat fs/namei.c:4293 [inline]
> >   __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> I'm taking this patch, but making a change. It's a little cleaner to check ip->i_nlink after calling copy_from_dinode.
> 
> > 
> > Reported-by: syzbot+355da3b3a74881008e8f@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=355da3b3a74881008e8f
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> > V1 -> V2: if the nlink of disk inode is 0 return -EIO
> > V2 -> V3: move the checking to diReadSpecial
> > 
> > ---
> >   fs/jfs/jfs_imap.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> > index 0cedaccb7218..25bb3485da3b 100644
> > --- a/fs/jfs/jfs_imap.c
> > +++ b/fs/jfs/jfs_imap.c
> > @@ -460,7 +460,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
> >   	dp += inum % 8;		/* 8 inodes per 4K page */
> >   
> >   	/* copy on-disk inode to in-memory inode */
> > -	if ((copy_from_dinode(dp, ip)) != 0) {
> > +	if (!le32_to_cpu(dp->di_nlink) || (copy_from_dinode(dp, ip)) != 0) {
> >   		/* handle bad return by returning NULL for ip */
> >   		set_nlink(ip, 1);	/* Don't want iput() deleting it */
> >   		iput(ip);
> 
> My change:
> 
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 298445f6d3d4..ecb8e05b8b84 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -456,7 +456,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
>   	dp += inum % 8;		/* 8 inodes per 4K page */
>   
>   	/* copy on-disk inode to in-memory inode */
> -	if ((copy_from_dinode(dp, ip)) != 0) {
> +	if ((copy_from_dinode(dp, ip) != 0) || (ip->i_nlink == 0)) {
This is incorrect. The purpose of adding this check is to prevent copy_from_dinode()
from using dip->i_nlink with a value of 0 to assign to ip.
>   		/* handle bad return by returning NULL for ip */
>   		set_nlink(ip, 1);	/* Don't want iput() deleting it */
>   		iput(ip);
BR,
Edward


