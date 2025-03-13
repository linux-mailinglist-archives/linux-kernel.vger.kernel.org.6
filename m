Return-Path: <linux-kernel+bounces-558687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC63A5E96B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34B0189D49C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6A322612;
	Thu, 13 Mar 2025 01:27:40 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD48171C9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741829259; cv=none; b=ZzfM47ZRybXugfrm7QyJqrBNp8kPjq58P6FI7S18yqBcpUgFQbt+fpilPEsdCP4UDDoG7F/Dm7fUCN9pvHoNY5/MN6uJp6wmi+mTERU9lk2IsAZLfparEBZ3Mn8Tgb4bbtklFW43FG3yEh0UaREB1LdNGRbgUSyfDKVjljU4U9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741829259; c=relaxed/simple;
	bh=x+gg8idzfKggNQqug6Qgo8/z/n+kY8bUkk9P1yBPCiM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YqGLY+q/MPAQXO0mWGq/T9wjNMckuvaVdAX7Rgr8LrohMgMP3ptlnx0ocOZmWhxcxh91q/Gjqhwtv1nAcbQhEtjNi8tJayGfG4pU6ldapx+evckNM6ZMB/UNKCodrOVYFzYSFbpZKNLzIn5Rwc4QdpPFBNGfQBLgkDRuEdmxShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso9115255ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741829256; x=1742434056;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMlcA2wErFWPbBrp1KtabkznrcHqoObPY78uG7OyyXE=;
        b=QL9mcpWgLlIKgJ1FD+JLZ1NibEKjXAgj12U7FrqgHhumtHPxuZTx0ZctK5wgkLd9aQ
         gotcmwfiH1ud5mthT1vEMmW3mcNH3zQ4XIAzL2mdNEe1fzjKxq7NcCS24LEf5LXX9D7C
         x4otHejvATvyxR9v3AibAl+qhJTXRcb+RoP21NHONduTxUzz3wRGwykOnVQq8e2U66T1
         EmTedMHIbPGokvj3hTyN3sDbB8v9fTjYNb1VyOjWq31A7D7ujO9OPgCI9Wc5x54OHDwO
         aJt7ABdshh/3xf3bMZEoUgsZJ8hCNLrmdbEv7QKWjSfKNaR7XAy08ogPfFFMoVsRxsBp
         R4jA==
X-Forwarded-Encrypted: i=1; AJvYcCUDKT8+cYt6ZqTCFW1AeQ1RzKegSYJOTRyaZjR3iq4cY1jZeaZ8SxHKwZgHZohNnXIyw38Jsy1YWFdtOtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGz/jZzUmvo90x01Iiu5yw2+2/o3gCrM0qUfYIclIOQJh7EG5V
	Iuqj0NY4fhV7oTKmiXvSST57tgU7tcganhzkhlHgqSGej8BYKnSV5BDwO+Lte5yMp6KQzufSGRc
	jEvJO4LWzfWKAQZbMH+Mo+9YEvGmAp8DqcuJoezkKWhXs/PLMKuL1iVA=
X-Google-Smtp-Source: AGHT+IHh994Fvn9JOwXqFIVSmwZ4qezxHh0TjDpnEtNrcYYJRi2/9ULmWcH4ndN1Fy0KkiQnySatMid/8zCXEu7ZoNZIB4+5k88O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f88:b0:3d3:dfc2:912f with SMTP id
 e9e14a558f8ab-3d4418a5148mr301418165ab.7.1741829256487; Wed, 12 Mar 2025
 18:27:36 -0700 (PDT)
Date: Wed, 12 Mar 2025 18:27:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d23488.050a0220.14e108.002a.GAE@google.com>
Subject: [syzbot] [kernel?] upstream test error: KASAN: slab-use-after-free
 Write in binderfs_evict_inode
From: syzbot <syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com>
To: arve@android.com, brauner@kernel.org, cmllamas@google.com, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0fed89a961ea Merge tag 'hyperv-fixes-signed-20250311' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151e1874580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5498c9c3175e1fe
dashboard link: https://syzkaller.appspot.com/bug?extid=353d7b75658a95aa955a
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/29b86e707aa9/disk-0fed89a9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b58942c7cd28/vmlinux-0fed89a9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc389da41680/bzImage-0fed89a9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+353d7b75658a95aa955a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __hlist_del include/linux/list.h:982 [inline]
BUG: KASAN: slab-use-after-free in hlist_del_init include/linux/list.h:1008 [inline]
BUG: KASAN: slab-use-after-free in binderfs_evict_inode+0x335/0x340 drivers/android/binderfs.c:277
Write of size 8 at addr ffff8880290d5c08 by task syz.1.52/5889

CPU: 0 UID: 0 PID: 5889 Comm: syz.1.52 Not tainted 6.14.0-rc6-syzkaller-00016-g0fed89a961ea #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xd9/0x110 mm/kasan/report.c:634
 __hlist_del include/linux/list.h:982 [inline]
 hlist_del_init include/linux/list.h:1008 [inline]
 binderfs_evict_inode+0x335/0x340 drivers/android/binderfs.c:277
 evict+0x409/0x960 fs/inode.c:796
 iput_final fs/inode.c:1946 [inline]
 iput fs/inode.c:1972 [inline]
 iput+0x52a/0x890 fs/inode.c:1958
 dentry_unlink_inode+0x29c/0x480 fs/dcache.c:440
 __dentry_kill+0x1d0/0x600 fs/dcache.c:643
 shrink_kill fs/dcache.c:1088 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1115
 shrink_dcache_parent+0xe2/0x530 fs/dcache.c:1549
 do_one_tree fs/dcache.c:1578 [inline]
 shrink_dcache_for_umount+0xa1/0x3e0 fs/dcache.c:1595
 generic_shutdown_super+0x6c/0x390 fs/super.c:620
 kill_anon_super fs/super.c:1237 [inline]
 kill_litter_super+0x70/0xa0 fs/super.c:1247
 binderfs_kill_super+0x3b/0xa0 drivers/android/binderfs.c:792
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1413
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xad8/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 get_signal+0x24ed/0x26c0 kernel/signal.c:3036
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 irqentry_exit_to_user_mode+0x13f/0x280 kernel/entry/common.c:231
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 002b:0000400000000008 EFLAGS: 00010217
RAX: 0000000000000000 RBX: 00007f566aba5fa0 RCX: 00007f566a98d169
RDX: 0000400000000000 RSI: 0000400000000000 RDI: 0000000000000000
RBP: 00007f566aa0e2a0 R08: 0000400000000000 R09: 0000000000000000
R10: 0000400000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f566aba5fa0 R14: 00007f566aba5fa0 R15: 0000000000000005
 </TASK>

Allocated by task 5829:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 binderfs_binder_device_create.isra.0+0x17a/0xb70 drivers/android/binderfs.c:147
 binderfs_fill_super+0x8d6/0x1360 drivers/android/binderfs.c:730
 vfs_get_super fs/super.c:1280 [inline]
 get_tree_nodev+0xda/0x190 fs/super.c:1299
 vfs_get_tree+0x8b/0x340 fs/super.c:1814
 do_new_mount fs/namespace.c:3560 [inline]
 path_mount+0x14e6/0x1f10 fs/namespace.c:3887
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount fs/namespace.c:4088 [inline]
 __x64_sys_mount+0x28f/0x310 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5829:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x2c4/0x4d0 mm/slub.c:4757
 binderfs_evict_inode+0x29f/0x340 drivers/android/binderfs.c:279
 evict+0x409/0x960 fs/inode.c:796
 iput_final fs/inode.c:1946 [inline]
 iput fs/inode.c:1972 [inline]
 iput+0x52a/0x890 fs/inode.c:1958
 dentry_unlink_inode+0x29c/0x480 fs/dcache.c:440
 __dentry_kill+0x1d0/0x600 fs/dcache.c:643
 shrink_kill fs/dcache.c:1088 [inline]
 shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1115
 shrink_dcache_parent+0xe2/0x530 fs/dcache.c:1549
 do_one_tree fs/dcache.c:1578 [inline]
 shrink_dcache_for_umount+0xa1/0x3e0 fs/dcache.c:1595
 generic_shutdown_super+0x6c/0x390 fs/super.c:620
 kill_anon_super fs/super.c:1237 [inline]
 kill_litter_super+0x70/0xa0 fs/super.c:1247
 binderfs_kill_super+0x3b/0xa0 drivers/android/binderfs.c:792
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1413
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xad8/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 get_signal+0x24ed/0x26c0 kernel/signal.c:3036
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880290d5c00
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
 freed 512-byte region [ffff8880290d5c00, ffff8880290d5e00)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880290d5800 pfn:0x290d4
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b041c80 0000000000000000 dead000000000001
raw: ffff8880290d5800 000000000010000f 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801b041c80 0000000000000000 dead000000000001
head: ffff8880290d5800 000000000010000f 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea0000a43501 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5222, tgid 5222 (udevadm), ts 30673243450, free_ts 30319293045
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4740
 alloc_pages_mpol+0x1fc/0x540 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2587 [inline]
 new_slab+0x23d/0x330 mm/slub.c:2640
 ___slab_alloc+0xc5d/0x1720 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __kmalloc_cache_noprof+0xfa/0x410 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 kernfs_fop_open+0x28b/0xdb0 fs/kernfs/file.c:623
 do_dentry_open+0x735/0x1c40 fs/open.c:956
 vfs_open+0x82/0x3f0 fs/open.c:1086
 do_open fs/namei.c:3830 [inline]
 path_openat+0x1e88/0x2d80 fs/namei.c:3989
 do_filp_open+0x20c/0x470 fs/namei.c:4016
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
page last free pid 25 tgid 25 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
 rcu_do_batch kernel/rcu/tree.c:2546 [inline]
 rcu_core+0x79d/0x14d0 kernel/rcu/tree.c:2802
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 run_ksoftirqd kernel/softirq.c:950 [inline]
 run_ksoftirqd+0x3a/0x60 kernel/softirq.c:942
 smpboot_thread_fn+0x661/0xa30 kernel/smpboot.c:164
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff8880290d5b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880290d5b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880290d5c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff8880290d5c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880290d5d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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

