Return-Path: <linux-kernel+bounces-404067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BAB9C3EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E881C216AF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0119C56D;
	Mon, 11 Nov 2024 12:51:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC415687C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329464; cv=none; b=XIPGIyPSrxd3nGN59hEGiNMg+mFTiNb+C28dUtIOjKVU6GWD0SonqEUbujEH9DN2QKcWl6dkYRNKrf2Q+QPzjQQ/dnrUlwU3HarMxQAAVU87rc5TdzWMLdajM1FgQ8JoXU0ZkKQqu05bzMooWvPXShBvxZorg2n98cWCN92OAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329464; c=relaxed/simple;
	bh=8z7m3LzSr/U0F/HR3heeILfaVI4KOw3WuJzr90J7q4o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y74v3FqnZEQetYdN7Ec6XbmS7zXM0rx1GmWPcwrlH6HXLVDSfYoeZecy5nHOzq8Pyl8A5MqYMbfFEOw4XG2Ob0mtAGDR7ha34k/nHxn2n93v20WvKwQNskkYHfnzhe5Sh05YwQzEPat/biiNtos05CJMfobMKkjMutJOqundjmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83b567c78c3so486294539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731329462; x=1731934262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r8wYpLQ/dj1RHE5izmtUE9xQ0RgOkVsMeAM24Eycp1A=;
        b=tJqTZESqhugUg00+kyC1QXM8dHvFcV1S9KjRUgDCQaTf/J8vgh+J41HFcRB7e15mt1
         aN0us8ZzVhxCwqyL5Q40Pne3JiLh8cOr1JEdCOptmCcn9ZXSyRTHCm+dRaHraLGQ6R1k
         9pSABXtWm1FC3iPO0MfwweyUbsC/wmjM54C8lj5rmDNw1Z8Rx39gOFDUps3fgfd5zU75
         PMf6Rq29yDtuaI4wuaRYJXrwdcVyY6EYKdHk6sD2+Zf9l5xVcXkmHK5rp8t23gsNBhrW
         YHxecYaNZvoM4dNjt+xADCjtotXK0MzUilIFdV7MYX/jPSX7Z7HFzW7D/5nw3ow/1lkl
         WBJg==
X-Forwarded-Encrypted: i=1; AJvYcCVB1CrXpwtiYsSM8mT7YNFOvqbm9qgQAX4F2caMJ2UUzJQ/zL6tduDUSRObs1wtmYWfZ17VOVzkalkWgY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgF/LDNfRXBO/rqcQSVNkhDluxeyUDLo0IwvdYH38DKY95ud4p
	7bVdqdpM00nNrceRw5RAYvURpEdX6b+Oi2VjhgV7cOnK8CziEjrDW/w5CGoIccx2AvI/wCc5QXz
	LvTlo0yKqpqmEqcb0gNYvy6eOjdknoVvOkgrDxdxS+tqaZJ5Vl2dYQaE=
X-Google-Smtp-Source: AGHT+IEXDKxcd0VOK5C0sZLyo/zvz+BcNuSwfQ524Pd9kl1eGPxO7scxnYSaYurUeM09A/LXENxYG06ndT+Yzr9zZVN/mrX7eJZi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f94:b0:3a6:aade:5644 with SMTP id
 e9e14a558f8ab-3a6f11698a7mr109240095ab.4.1731329462148; Mon, 11 Nov 2024
 04:51:02 -0800 (PST)
Date: Mon, 11 Nov 2024 04:51:02 -0800
In-Reply-To: <tencent_046963B884499778B77A06CC9366036A0905@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6731fdb6.050a0220.138bd5.007e.GAE@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend (2)
From: syzbot <syzbot+4cba2fd444e9a16ae758@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hfsplus_bmap_reserve

loop0: detected capacity change from 0 to 1024
hfsplus: inconsistency in B*Tree (128,1,255,1,0)
============================================
WARNING: possible recursive locking detected
6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0 Not tainted
--------------------------------------------
syz.0.15/5813 is trying to acquire lock:
ffff888036820108 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_bmap_reserve+0x119/0x500 fs/hfsplus/btree.c:358

but task is already holding lock:
ffff888036820e88 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_bmap_reserve+0x119/0x500 fs/hfsplus/btree.c:358

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&HFSPLUS_I(inode)->extents_lock);
  lock(&HFSPLUS_I(inode)->extents_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

6 locks held by syz.0.15/5813:
 #0: ffff888056c0c420 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:515
 #1: ffff8880368224b8 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
 #1: ffff8880368224b8 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: vfs_setxattr+0x1e1/0x430 fs/xattr.c:320
 #2: ffff888034b200b0 (&tree->tree_lock){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28
 #3: ffff8880574a20b0 (&tree->tree_lock/2){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28
 #4: ffff888036820e88 (&HFSPLUS_I(inode)->extents_lock){+.+.}-{3:3}, at: hfsplus_bmap_reserve+0x119/0x500 fs/hfsplus/btree.c:358
 #5: ffff888038c7e0b0 (&tree->tree_lock/1){+.+.}-{3:3}, at: hfsplus_find_init+0x14a/0x1c0 fs/hfsplus/bfind.c:28

stack backtrace:
CPU: 0 UID: 0 PID: 5813 Comm: syz.0.15 Not tainted 6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0
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
 hfsplus_bmap_reserve+0x119/0x500 fs/hfsplus/btree.c:358
 __hfsplus_ext_write_extent+0x2a4/0x5c0 fs/hfsplus/extents.c:104
 __hfsplus_ext_cache_extent+0x84/0xe10 fs/hfsplus/extents.c:186
 hfsplus_ext_read_extent fs/hfsplus/extents.c:218 [inline]
 hfsplus_file_extend+0x43f/0x1ac0 fs/hfsplus/extents.c:463
 hfsplus_bmap_reserve+0x12c/0x500 fs/hfsplus/btree.c:359
 hfsplus_create_attr+0x1c8/0x640 fs/hfsplus/attributes.c:221
 __hfsplus_setxattr+0x702/0x22d0 fs/hfsplus/xattr.c:356
 hfsplus_setxattr+0xb0/0xe0 fs/hfsplus/xattr.c:434
 hfsplus_trusted_setxattr+0x40/0x60 fs/hfsplus/xattr_trusted.c:30
 __vfs_setxattr+0x468/0x4a0 fs/xattr.c:200
 __vfs_setxattr_noperm+0x12e/0x660 fs/xattr.c:234
 vfs_setxattr+0x221/0x430 fs/xattr.c:321
 do_setxattr fs/xattr.c:629 [inline]
 path_setxattr+0x37e/0x4d0 fs/xattr.c:658
 __do_sys_lsetxattr fs/xattr.c:683 [inline]
 __se_sys_lsetxattr fs/xattr.c:679 [inline]
 __x64_sys_lsetxattr+0xb8/0xd0 fs/xattr.c:679
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2ade37e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2adf11d038 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 00007f2ade535f80 RCX: 00007f2ade37e719
RDX: 0000000000000000 RSI: 0000000020000200 RDI: 0000000020000040
RBP: 00007f2ade3f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2ade535f80 R15: 00007ffd3661a948
 </TASK>


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127734e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=4cba2fd444e9a16ae758
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d9d8c0580000


