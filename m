Return-Path: <linux-kernel+bounces-176250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 015558C2C05
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51742B23796
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7C213CF87;
	Fri, 10 May 2024 21:43:30 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31C13CAB7
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 21:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715377410; cv=none; b=HU/z86Nwexl/vd8gA2WezatrYZ5BE5yFyts37HFp1LW7HdsJEM+KdCInSnUfTGqa+un4ozl1jHYMq0HnMkB/3MIfuZJFmQPwgJxT7Pm3Lwk1ZLCt+QR7gSZqfvV7WvrO3nBzEYJURM4X+sh62QQMEd9dLReoVFwIaRBtU0Dbs5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715377410; c=relaxed/simple;
	bh=M85Letwt954Xf//kwiqa7JW2z+81R4qJZDOFruokEyo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iocOScmvfZD7KODU4GyoV3vK1x2ldTcRzVelIrDcdm7d86INwUoOIkw0U8k1ULixunOYdpR/DTH5LYe+dtwQRke5gaS6rpU+dGlxBMrVIIJ2M7Kp3VlcABrXiBohIaIwONOda2dxRe2TYkJ6UySPk6SdqcbcM4GwjA6xhwklpl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1b97c1b19so116645139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715377407; x=1715982207;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x914XXq5+D8B0/okROsjTLspMjkKTvAOWzoDHqJaAiQ=;
        b=tvdxoOlg7Dqx7Tk2FWd0SfUBMGSKgVqwKJK0JxR4F4YWAZMG4DXeOfm2hosgGnc/8H
         1TiuSgKyRVIJ3AV8NpWLAdDuKiHbaC32MHfb6bJ+BMbwQLMpUlmByG132CKlbs4jvgUN
         zfEnnKnXqPNGEGDo/j/+rpcclJ7Z9iIoqWedUmR+c35HthmJItTLArtZG5/QRzgKsJXw
         r3ts+wH+UHdSYyYUBkA71+zOgzho0K5QlmBtYZFtUMZ7qfOKbR5X01xM64aYwzT+ghqg
         1RQB/iw5RgNP5ho/BGM3INIRauX8NkiQiDwy15uBbcMoBNSL0VzcbX5XgclJRp6t143K
         IijA==
X-Forwarded-Encrypted: i=1; AJvYcCWnLfid5rK5TTtjU7VwnRf7n9OWV097OyAzJEckORI4lCx7ZxQvAdEc+c4w61auUX48mHpVuS0UKonu1b8fzCqm0cKyIyndJ7GDbk+C
X-Gm-Message-State: AOJu0YxuOkwesy2jUFIzzD+Rw8be86nWd5xyOKB/1HPtM+uxPYjzGlvD
	8qnMDVEcxOc5j2hGlzCVJyxctuVKOXouDGyrwTRUfh8DmZAGeVR4cslSAbWAigMhwiB9Q4098W7
	Fhkm+wKSpmuCK5uf/btFm969Wjlg8rCWqhqsEixPY/6+O8umPKn9RZLk=
X-Google-Smtp-Source: AGHT+IHJTWGumJs6GBO1nke0CeSeQ3bmGfJ6hfKniM/gjTwjIQvxVSeaPbTBhTSxNzVxGkKmVDfgP0qn46+y0/teBRvxtZ2j8eXz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8625:b0:488:59cc:eb54 with SMTP id
 8926c6da1cb9f-48958c05b8emr292731173.3.1715377407265; Fri, 10 May 2024
 14:43:27 -0700 (PDT)
Date: Fri, 10 May 2024 14:43:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000041f960618206d7e@google.com>
Subject: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_client_destroy
From: syzbot <syzbot+1527696d41a634cc1819@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f4345f05c0df Merge tag 'block-6.9-20240510' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122bfdb8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=1527696d41a634cc1819
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1dc00463a49c/disk-f4345f05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/137d9071f058/vmlinux-f4345f05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/77a30b1a7a80/bzImage-f4345f05.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1527696d41a634cc1819@syzkaller.appspotmail.com

9pnet: Found fid 1 not clunked
==================================================================
BUG: KASAN: slab-use-after-free in p9_fid_destroy net/9p/client.c:884 [inline]
BUG: KASAN: slab-use-after-free in p9_client_destroy+0x183/0x660 net/9p/client.c:1070
Read of size 8 at addr ffff88801e478d00 by task syz-executor.2/14884

CPU: 1 PID: 14884 Comm: syz-executor.2 Not tainted 6.9.0-rc7-syzkaller-00136-gf4345f05c0df #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 p9_fid_destroy net/9p/client.c:884 [inline]
 p9_client_destroy+0x183/0x660 net/9p/client.c:1070
 v9fs_session_close+0x51/0x210 fs/9p/v9fs.c:506
 v9fs_kill_super+0x5c/0x90 fs/9p/vfs_super.c:196
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x102/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9b3347f097
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff26a7f1a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9b3347f097
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff26a7f260
RBP: 00007fff26a7f260 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff26a80320
R13: 00007f9b334c9336 R14: 00000000000a0428 R15: 000000000000000b
 </TASK>

Allocated by task 16717:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x370 mm/slub.c:4003
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 p9_fid_create+0x4f/0x230 net/9p/client.c:853
 p9_client_walk+0x103/0x690 net/9p/client.c:1154
 clone_fid fs/9p/fid.h:23 [inline]
 v9fs_fid_clone fs/9p/fid.h:33 [inline]
 v9fs_file_open+0x285/0xa60 fs/9p/vfs_file.c:56
 do_dentry_open+0x907/0x15a0 fs/open.c:955
 do_open fs/namei.c:3642 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3799
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_creat fs/open.c:1497 [inline]
 __se_sys_creat fs/open.c:1491 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1491
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 140:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2111 [inline]
 slab_free mm/slub.c:4286 [inline]
 kfree+0x153/0x3b0 mm/slub.c:4396
 p9_fid_destroy net/9p/client.c:889 [inline]
 p9_client_clunk+0x1ce/0x260 net/9p/client.c:1456
 netfs_free_request+0x244/0x600 fs/netfs/objects.c:97
 v9fs_upload_to_server fs/9p/vfs_addr.c:36 [inline]
 v9fs_upload_to_server_worker+0x200/0x3e0 fs/9p/vfs_addr.c:44
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88801e478d00
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 freed 96-byte region [ffff88801e478d00, ffff88801e478d60)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e478
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888015041780 ffffea0000b68440 dead000000000002
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5148, tgid 2075898714 (kworker/0:5), ts 5148, free_ts 79305822594
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2180
 allocate_slab mm/slub.c:2343 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2396
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3530
 __slab_alloc mm/slub.c:3615 [inline]
 __slab_alloc_node mm/slub.c:3668 [inline]
 slab_alloc_node mm/slub.c:3841 [inline]
 kmalloc_trace+0x269/0x370 mm/slub.c:3998
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 nsim_fib6_rt_create drivers/net/netdevsim/fib.c:547 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:752 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x19c2/0x4130 drivers/net/netdevsim/fib.c:1492
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 927 tgid 927 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x97b/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 discard_slab mm/slub.c:2442 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2911
 put_cpu_partial+0x17c/0x250 mm/slub.c:2986
 __slab_free+0x2ea/0x3d0 mm/slub.c:4157
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3804 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 kmem_cache_alloc+0x174/0x350 mm/slub.c:3858
 kmem_cache_zalloc include/linux/slab.h:739 [inline]
 xfs_trans_alloc+0x81/0x830 fs/xfs/xfs_trans.c:262
 xfs_setfilesize+0xd7/0x4e0 fs/xfs/xfs_aops.c:58
 xfs_end_ioend+0x317/0x470 fs/xfs/xfs_aops.c:134
 xfs_end_io+0x2e5/0x380 fs/xfs/xfs_aops.c:173
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f0/0x390 kernel/kthread.c:388

Memory state around the buggy address:
 ffff88801e478c00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88801e478c80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88801e478d00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                   ^
 ffff88801e478d80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88801e478e00: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
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

