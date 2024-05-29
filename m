Return-Path: <linux-kernel+bounces-194670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D28D3FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E7E1C21855
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28401C8FCE;
	Wed, 29 May 2024 20:41:22 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFB1C68B7
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015281; cv=none; b=gIROi1/TNL4ggkdt/JRna7QPkWqutLfQaX02Vius+M5u+GaBklUR+X7OSW7tahXv+AxqPtX0LiFeIVXCX9/L9FhrNGL/3UwHGsfmI0R+g9Ge1KRfOALYcsQIESQQcTWdt6Hv4j8lF/byeXUVxaCFeLAELIk4ixUXaw4bzd9wI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015281; c=relaxed/simple;
	bh=4+novQF37gcbTEj8qZP9pHruWLCm8/mEuq9Lt/7MDOc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eALGb8HRDfNicUTIKvLQaQe+sFJQd5ClwLpru+nNUsE5NW3qDoDOT0sjLwW+9OJNpgwMv/mEji/hGpPWCMRW4GD5UE68gTdq0U/HZ/vvVzfjcw5mgsw0kTTMc2hDylgE6By5gf+r4Oqc7NyyKbRJbNqX3b4C5Lf+pM8lOAXjBO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7ead27b49d8so13341339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 13:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717015279; x=1717620079;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8apyPpt7h0guVWvcwjAlbhYY2PwlIv36IOiCtHycDww=;
        b=T8wq/TgDjGl3Qit8P7KwKXzxNyr3XFeWNd0zjEhx4dlpBwuzoJE5cf+33IXmmZ4Bv9
         gG9CZAq2qmUQUTDU1Tvr1BKef4RiK7CddplwzOglIbN1RHx5I5bX+ZFLiWkCCmujZVOU
         /U3REfzGHgeeDnr0ODw4wcV/cHb3FxUYGbtIfNlg7g2ooBzAlb4h3A/nRWVi2Y/udEJq
         5rCncOEkbWhu14VKZWPiIPothqOLw237j49P5p4rGTVP66+79R4V+gpweqBZGFgCqPFY
         7VUr05WfqqvJffN9P4JZHhUV4Tnei3EkSAiAUmBQyKdmVQ/4TafY5iLZTsW5pEYkFAbn
         n4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgdoJS+v9vfT1rwm5EI5tqZGVQ/ta+TgtAVAdNL94AuScamh/5yItKe6QQt9VfZlDJprI6wjQ93K0TAvKQTHpKlMeZO8tW9wZLKW5r
X-Gm-Message-State: AOJu0YzVu+TtdFivRUAJ3E3l9C+FDsauicjYCbDg3XIitjEcQDxWQSHG
	g1DbeeCqSmrsNMWtyPkdCQkEehJmKgk34E+2i0ZENWuiESasvsCV6wiZoHmBbmi4asv9c1DsZfD
	1uvic1pGPxsD/30pz8dKGUO+pAZftdpp3gXWUnjDcX/Z/U8NfF1ruVYU=
X-Google-Smtp-Source: AGHT+IGMHZSX+eBAf+MaqyK9XJRGToBvBPscRBJYcrwh/Pcxxvt+0dsXPYgPILMBIlLnnqDWuDjokKqbZRsSuSZos8327nxHwvOV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:9a0b:0:b0:4b0:7e11:8d19 with SMTP id
 8926c6da1cb9f-4b1ed158fd6mr1803173.5.1717015279510; Wed, 29 May 2024 13:41:19
 -0700 (PDT)
Date: Wed, 29 May 2024 13:41:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf30aa06199dc54a@google.com>
Subject: [syzbot] [udf?] possible deadlock in udf_file_write_iter
From: syzbot <syzbot+b8bf17b888663bcdee61@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    54f71b0369c9 Merge tag 'rtc-6.10' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b9197c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e70c03a304f3c3ef
dashboard link: https://syzkaller.appspot.com/bug?extid=b8bf17b888663bcdee61
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-54f71b03.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bc3c5654135/vmlinux-54f71b03.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d88013021348/bzImage-54f71b03.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b8bf17b888663bcdee61@syzkaller.appspotmail.com

WARNING: possible circular locking dependency detected
6.9.0-syzkaller-12333-g54f71b0369c9 #0 Not tainted
------------------------------------------------------
syz-executor.3/7881 is trying to acquire lock:
ffffffff8dd3a8a0 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:334 [inline]
ffffffff8dd3a8a0 (fs_reclaim){+.+.}-{0:0}, at: prepare_alloc_pages.constprop.0+0x155/0x560 mm/page_alloc.c:4431

but task is already holding lock:
ffff888012624ac0 (mapping.invalidate_lock#8){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:836 [inline]
ffff888012624ac0 (mapping.invalidate_lock#8){++++}-{3:3}, at: udf_file_write_iter+0x5c2/0x740 fs/udf/file.c:104

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (mapping.invalidate_lock#8){++++}-{3:3}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       filemap_invalidate_lock include/linux/fs.h:836 [inline]
       udf_setsize+0x256/0x1180 fs/udf/inode.c:1253
       udf_evict_inode+0x361/0x590 fs/udf/inode.c:144
       evict+0x2ed/0x6c0 fs/inode.c:667
       iput_final fs/inode.c:1741 [inline]
       iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
       iput+0x5c/0x80 fs/inode.c:1757
       dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
       __dentry_kill+0x1d0/0x600 fs/dcache.c:603
       shrink_kill fs/dcache.c:1048 [inline]
       shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
       prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
       super_cache_scan+0x32a/0x550 fs/super.c:221
       do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
       shrink_slab_memcg mm/shrinker.c:548 [inline]
       shrink_slab+0xa87/0x1310 mm/shrinker.c:626
       shrink_one+0x493/0x7c0 mm/vmscan.c:4790
       shrink_many mm/vmscan.c:4851 [inline]
       lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
       shrink_node mm/vmscan.c:5910 [inline]
       kswapd_shrink_node mm/vmscan.c:6720 [inline]
       balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
       kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       __fs_reclaim_acquire mm/page_alloc.c:3783 [inline]
       fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3797
       might_alloc include/linux/sched/mm.h:334 [inline]
       prepare_alloc_pages.constprop.0+0x155/0x560 mm/page_alloc.c:4431
       __alloc_pages_noprof+0x194/0x2460 mm/page_alloc.c:4649
       alloc_pages_mpol_noprof+0x275/0x610 mm/mempolicy.c:2265
       folio_alloc_noprof+0x1e/0xc0 mm/mempolicy.c:2343
       filemap_alloc_folio_noprof+0x3ba/0x490 mm/filemap.c:1008
       __filemap_get_folio+0x51e/0xa80 mm/filemap.c:1950
       udf_expand_file_adinicb+0xe9/0x940 fs/udf/inode.c:358
       udf_file_write_iter+0x5ca/0x740 fs/udf/file.c:105
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x6b6/0x1140 fs/read_write.c:590
       ksys_write+0x12f/0x260 fs/read_write.c:643
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(mapping.invalidate_lock#8);
                               lock(fs_reclaim);
                               lock(mapping.invalidate_lock#8);
  lock(fs_reclaim);

 *** DEADLOCK ***

4 locks held by syz-executor.3/7881:
 #0: ffff88801d50fcc8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xeb/0x180 fs/file.c:1191
 #1: ffff88801b398420 (sb_writers#19){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:643
 #2: ffff888012624920 (&sb->s_type->i_mutex_key#26){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #2: ffff888012624920 (&sb->s_type->i_mutex_key#26){+.+.}-{3:3}, at: udf_file_write_iter+0x73/0x740 fs/udf/file.c:95
 #3: ffff888012624ac0 (mapping.invalidate_lock#8){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:836 [inline]
 #3: ffff888012624ac0 (mapping.invalidate_lock#8){++++}-{3:3}, at: udf_file_write_iter+0x5c2/0x740 fs/udf/file.c:104

stack backtrace:
CPU: 3 PID: 7881 Comm: syz-executor.3 Not tainted 6.9.0-syzkaller-12333-g54f71b0369c9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __fs_reclaim_acquire mm/page_alloc.c:3783 [inline]
 fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3797
 might_alloc include/linux/sched/mm.h:334 [inline]
 prepare_alloc_pages.constprop.0+0x155/0x560 mm/page_alloc.c:4431
 __alloc_pages_noprof+0x194/0x2460 mm/page_alloc.c:4649
 alloc_pages_mpol_noprof+0x275/0x610 mm/mempolicy.c:2265
 folio_alloc_noprof+0x1e/0xc0 mm/mempolicy.c:2343
 filemap_alloc_folio_noprof+0x3ba/0x490 mm/filemap.c:1008
 __filemap_get_folio+0x51e/0xa80 mm/filemap.c:1950
 udf_expand_file_adinicb+0xe9/0x940 fs/udf/inode.c:358
 udf_file_write_iter+0x5ca/0x740 fs/udf/file.c:105
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1140 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7313579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f5f055ac EFLAGS: 00000292 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000020000a80
RDX: 0000000000000173 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

