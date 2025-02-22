Return-Path: <linux-kernel+bounces-526828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD911A403F6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EB319C1E9E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2323BBC5;
	Sat, 22 Feb 2025 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="in+xjCzT"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F1C147
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183376; cv=none; b=JJnN0ifEUkvV5sF90YWdQcIPh9ZvXDU9RfyVdkkeEuYjyhR1TWBRPmR3D4xgdpsFybo9lsM+26ZKCOs50ftNXo1FlHQdnfn8i43Qp45ezQGmu9nhlmWueAIONMzAE3NthwHmMX8s3QU9aMBp4FkKBnNOh/LyQrtFQi1rx5keR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183376; c=relaxed/simple;
	bh=ljVLvAdY8jdLuWbNCFmTmQnXBH3dOR/jrDwS3WnXVek=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=g+kl6CnktupA8wdULX+953Gu54IJTTO1Jzm6cMM/PG7bZEoTVEfgYNe9ZQqyzQ4JxW7eqBqo44dU7xdUKrkZbsY75cJRJwIJ8eOrk6zgu+11Fq2pWymoQMNOLAqi9Kgfw6zpC1x5wHnk2F9b9vP78nJ2RZKnPG+VlYjKeR8DE/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=in+xjCzT; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740183368; bh=tqMJWLY2AJcG1vhotFh2tnfe3QF/WPOAV93LjSptfqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=in+xjCzTxW9tBaU+uyYuvZ0eNy/R2BdGKkw35YOXmxzfwiL46Ot+wA4jaC901IQ/N
	 yyNzjJyOw+KEy8U0SRgeLjCiC3eRSHSZ3h4YczMiH5UCAfEeG8TxfKBV4TovKOVK4Q
	 916sxLbJOz1qvLLeQEfFosJkymEY2CUG4bNhxj1I=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 4061A0EE; Sat, 22 Feb 2025 08:16:06 +0800
X-QQ-mid: xmsmtpt1740183366thlxdkpk8
Message-ID: <tencent_93C98D8F12295DADDDAC19654FE30DB6A507@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jkbSe83BGyeCjKig4IdtbxxGGCBS1vx8UozaaMrug00xgDZLXl7
	 ADKOVaTK4yzyVmNosx/5bzfaX3WyA6BXNFLwtbEK3dAIIKLiu/Cc/jWiL8f9I5JfUAzn5/Gp0Vt0
	 EYUZxMQErP3QUrOk0d0G6e3IWij21amL9jHZcM9zXMdTA0GrRO8/1E+laRDYWzMTtdY7rtAj+loL
	 dt5ymlPRQ0fD7hVS/7RsQdixPzZLo5/o4xnksYQa+DPY7kDejJ4ysu/qd+0icla1RN8elYNei+eU
	 16jIfALI5lHC/XZJf1gjLBFOKZ7cnZk07U7ag0J7uLt3Y/16+exZ2rnf6/aQBpB+uowaDYZBMB2o
	 WpZ2nS2j4kOON90xImeHh4+VS5CgLCERV6wSHqg1lJVJOGZy7nSNr1HsQ4XZYXcWev0vQ2s5FqfL
	 sFiiztI0YGDMsGHuYxsX39PJCmt9Ueyny7YYq9pGI8njxbR7zTh9h12yjynJR4QJlGFKSqcznZSp
	 MEv4pel0AKLdSOz3FlnT1RPgsotrBcb4vrCBKmVu+oc7bubgpEb5fCDovKKIEamIK3n6aNKFW2jj
	 QWeuQtde3R/eiYbZHqHs27q+wWbwASdZXwox4menftZY/pI0XbSP4ZznK8aFfsaiCsFjHGtJBdhQ
	 Cns7QROVGFn07134KHq0UmSoKR6zV2Ya6Wj8SCm2pNgFYlqKM9D+oHrqeskDcpvs0FgpfhqhFJfu
	 BrApMutH9Kp1JtkqaFDGlyLdqvLDV/oHMt186H4+9k4sz4Do3d165pPi2CVfCB9DjdfrGK5Cc/02
	 Si2Na+flPVZqVUbEg1pXvJXogXOEvVgbVR0DbTE52wR4/qDncYgO2/osycqnvNMhicq2gHqYltcI
	 wnlpxYB4/SSaH5QqXqzvv5BxF/U790qjCyxt9u0REqH8hDbjqKKl+66pjuMCRTy/4g5+2yYTrSEk
	 5ImfeEHccLs9+V9mOT3g==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: dave.kleikamp@oracle.com
Cc: eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+355da3b3a74881008e8f@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] jfs: Prevent copying of nlink with value 0 from disk inode
Date: Sat, 22 Feb 2025 08:16:06 +0800
X-OQ-MSGID: <20250222001605.3397199-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <47c49424-e24b-498a-9115-ace3fa4880e3@oracle.com>
References: <47c49424-e24b-498a-9115-ace3fa4880e3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Feb 2025 17:28:49 -0600, Dave Kleikamp wrote:
>On 2/20/25 5:22PM, Edward Adam Davis wrote:
>> On Thu, 20 Feb 2025 10:15:04 -0600, Dave Kleikamp wrote:
>>>> syzbot report a deadlock in diFree. [1]
>>>>
>>>> When calling "ioctl$LOOP_SET_STATUS64", the offset value passed in is 4,
>>>> which does not match the mounted loop device, causing the mapping of the
>>>> mounted loop device to be invalidated.
>>>>
>>>> When creating the directory and creating the inode of iag in diReadSpecial(),
>>>> read the page of fixed disk inode (AIT) in raw mode in read_metapage(), the
>>>> metapage data it returns is corrupted, which causes the nlink value of 0 to be
>>>> assigned to the iag inode when executing copy_from_dinode(), which ultimately
>>>> causes a deadlock when entering diFree().
>>>>
>>>> To avoid this, first check the nlink value of dinode before setting iag inode.
>>>>
>>>> [1]
>>>> WARNING: possible recursive locking detected
>>>> 6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0 Not tainted
>>>> --------------------------------------------
>>>> syz-executor301/5309 is trying to acquire lock:
>>>> ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diFree+0x37c/0x2fb0 fs/jfs/jfs_imap.c:889
>>>>
>>>> but task is already holding lock:
>>>> ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diAlloc+0x1b6/0x1630
>>>>
>>>> other info that might help us debug this:
>>>>    Possible unsafe locking scenario:
>>>>
>>>>          CPU0
>>>>          ----
>>>>     lock(&(imap->im_aglock[index]));
>>>>     lock(&(imap->im_aglock[index]));
>>>>
>>>>    *** DEADLOCK ***
>>>>
>>>>    May be due to missing lock nesting notation
>>>>
>>>> 5 locks held by syz-executor301/5309:
>>>>    #0: ffff8880422a4420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
>>>>    #1: ffff88804755b390 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:850 [inline]
>>>>    #1: ffff88804755b390 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: filename_create+0x260/0x540 fs/namei.c:4026
>>>>    #2: ffff888044548920 (&(imap->im_aglock[index])){+.+.}-{3:3}, at: diAlloc+0x1b6/0x1630
>>>>    #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diNewIAG fs/jfs/jfs_imap.c:2460 [inline]
>>>>    #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
>>>>    #3: ffff888044548890 (&imap->im_freelock){+.+.}-{3:3}, at: diAllocAG+0x4b7/0x1e50 fs/jfs/jfs_imap.c:1669
>>>>    #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diNewIAG fs/jfs/jfs_imap.c:2477 [inline]
>>>>    #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
>>>>    #4: ffff88804755a618 (&jfs_ip->rdwrlock/1){++++}-{3:3}, at: diAllocAG+0x869/0x1e50 fs/jfs/jfs_imap.c:1669
>>>>
>>>> stack backtrace:
>>>> CPU: 0 UID: 0 PID: 5309 Comm: syz-executor301 Not tainted 6.12.0-rc7-syzkaller-00212-g4a5df3796467 #0
>>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>>>> Call Trace:
>>>>    <TASK>
>>>>    __dump_stack lib/dump_stack.c:94 [inline]
>>>>    dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>>>>    print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3037
>>>>    check_deadlock kernel/locking/lockdep.c:3089 [inline]
>>>>    validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3891
>>>>    __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5202
>>>>    lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>>>>    __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>>>>    __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>>>>    diFree+0x37c/0x2fb0 fs/jfs/jfs_imap.c:889
>>>>    jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
>>>>    evict+0x4e8/0x9b0 fs/inode.c:725
>>>>    diFreeSpecial fs/jfs/jfs_imap.c:552 [inline]
>>>>    duplicateIXtree+0x3c6/0x550 fs/jfs/jfs_imap.c:3022
>>>>    diNewIAG fs/jfs/jfs_imap.c:2597 [inline]
>>>>    diAllocExt fs/jfs/jfs_imap.c:1905 [inline]
>>>>    diAllocAG+0x17dc/0x1e50 fs/jfs/jfs_imap.c:1669
>>>>    diAlloc+0x1d2/0x1630 fs/jfs/jfs_imap.c:1590
>>>>    ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
>>>>    jfs_mkdir+0x1c5/0xba0 fs/jfs/namei.c:225
>>>>    vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
>>>>    do_mkdirat+0x264/0x3a0 fs/namei.c:4280
>>>>    __do_sys_mkdirat fs/namei.c:4295 [inline]
>>>>    __se_sys_mkdirat fs/namei.c:4293 [inline]
>>>>    __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
>>>>    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>>>    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>>>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>
>>> I'm taking this patch, but making a change. It's a little cleaner to check ip->i_nlink after calling copy_from_dinode.
>>>
>>>>
>>>> Reported-by: syzbot+355da3b3a74881008e8f@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=355da3b3a74881008e8f
>>>> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
>>>> ---
>>>> V1 -> V2: if the nlink of disk inode is 0 return -EIO
>>>> V2 -> V3: move the checking to diReadSpecial
>>>>
>>>> ---
>>>>    fs/jfs/jfs_imap.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
>>>> index 0cedaccb7218..25bb3485da3b 100644
>>>> --- a/fs/jfs/jfs_imap.c
>>>> +++ b/fs/jfs/jfs_imap.c
>>>> @@ -460,7 +460,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
>>>>    	dp += inum % 8;		/* 8 inodes per 4K page */
>>>>    
>>>>    	/* copy on-disk inode to in-memory inode */
>>>> -	if ((copy_from_dinode(dp, ip)) != 0) {
>>>> +	if (!le32_to_cpu(dp->di_nlink) || (copy_from_dinode(dp, ip)) != 0) {
>>>>    		/* handle bad return by returning NULL for ip */
>>>>    		set_nlink(ip, 1);	/* Don't want iput() deleting it */
>>>>    		iput(ip);
>>>
>>> My change:
>>>
>>> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
>>> index 298445f6d3d4..ecb8e05b8b84 100644
>>> --- a/fs/jfs/jfs_imap.c
>>> +++ b/fs/jfs/jfs_imap.c
>>> @@ -456,7 +456,7 @@ struct inode *diReadSpecial(struct super_block *sb, ino_t inum, int secondary)
>>>    	dp += inum % 8;		/* 8 inodes per 4K page */
>>>    
>>>    	/* copy on-disk inode to in-memory inode */
>>> -	if ((copy_from_dinode(dp, ip)) != 0) {
>>> +	if ((copy_from_dinode(dp, ip) != 0) || (ip->i_nlink == 0)) {
>> This is incorrect. The purpose of adding this check is to prevent copy_from_dinode()
>> from using dip->i_nlink with a value of 0 to assign to ip.
>>>    		/* handle bad return by returning NULL for ip */
>>>    		set_nlink(ip, 1);	/* Don't want iput() deleting it */
>
>It will get set  to 1 right here ^^^
Things that can be determined by "di_nlink" before executing copy_from_dinode(),
Why let the CPU run copy_from_dinode() for an extra time before checking?
Isn't this a waste of CPU?

BR,
Edward


