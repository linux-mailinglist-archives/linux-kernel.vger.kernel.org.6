Return-Path: <linux-kernel+bounces-563177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB44AA637D4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FBB73AD7A4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5E61A0BDB;
	Sun, 16 Mar 2025 22:51:30 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13D13C9A3
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 22:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742165490; cv=none; b=c5GcEXGU26s0qBfdFMwAr90Vvu6Af4HAxEHMgK6JPqLUrTieCVT6OxOmDGmz9yP07wCkor/7JlnNSR7HhDk+kYuqX8r+OMUfQZfwkdEo9nSaU+mOJyObUwzKG+XbKNwmDGU7GzxQnAakf17A6yUxqRwkBSg+wahd5dEcpGoO03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742165490; c=relaxed/simple;
	bh=Ib7cuHF04bYzM1fM1c9pNtOnTDTzUtyAZwKk7B4dh1M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QxjJPS3oYgFJ4Vf2WknzTZNnXR0zMOacEsQYTDVkQXuafS8+kcoSxNuEBDHP+YnQVxfV8XrAd0vuQpQioMhs4Hdr4BGOE63EJrEYQLGEO/8gLvxsxSrwqetKiFsB/y3p5MU0qxdMfhzw925mhMIqs2osfLkjDsBhzGb/Gf9MsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cf64584097so44920845ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 15:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742165487; x=1742770287;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M/OUAntBXWBVqtnydriSCZ+qF8zWAE6HRPoneBf8Mhs=;
        b=F9uWMKPTLG4ZxXqAEeE4nKHZNm4FB3APFJSVS4qR+QOHlEyrXK1lvhvHiuUO2qKe38
         NTVJovRvo8u8aq5G/YQO8pnoQaufT0+f7oSZZGwGVg7rndd4jCx4cuj20zP2hFQAZ71C
         RVu8v5sBv6+FjKQ2btIWAuti9CQH3LpNzCXWXmn/NKn0PbAmKA4hKUPq3t/5uzxChRfC
         c00Dl6vknQv1O6FiP9YTWQc5T2ZCcGHY/nMio5rr2jaECK9jXcEJjSlNo9VLtbka/BaD
         WLD9ExkgutrthcRMsNpLpl2JZOlHeBcELPBYswJCY5WMFBu56Yu6xR238o46xI4J8G1N
         c8Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUGADZH/0E6svMfoVqc5vSlf4YughpLX0dMpMuvX5J9Uc6ZtqNJX4w80BgbedlErOKCXAW8FuSvynFiN4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Wp/slOtPBfn/OOZfQXJQVqcAo3SDycyz8S8r+PHcJpFaEkjX
	MLt1iGy7LqxIgVMq1sqYhPb9NpiTckMOdXEsz9Egy8PT/C9Ua52mP/+lGdpKhmfAgNUT3CQd2xo
	YqBBxxuQPXXcrkMfo1GRT4rvtCl7kQz3HBGWxqDz5rNAofsMMxyosElI=
X-Google-Smtp-Source: AGHT+IHccLaLVCz6LgoTtpmBosu7fOYAq5JN3BKcZ9DDvW5ezztpaKQBskR0gf+WESIOV8bVekKfRMz0VWatvbFawbXzdyd49EXk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d04:b0:3d4:6f37:3724 with SMTP id
 e9e14a558f8ab-3d483a61c22mr106811805ab.18.1742165487469; Sun, 16 Mar 2025
 15:51:27 -0700 (PDT)
Date: Sun, 16 Mar 2025 15:51:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d755ef.050a0220.2ca2c6.0004.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Write in binder_add_device
From: syzbot <syzbot+810b8555076779a07399@syzkaller.appspotmail.com>
To: arve@android.com, brauner@kernel.org, cmllamas@google.com, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b7f94fcf5546 Merge tag 'sched_ext-for-6.14-rc6-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134f303f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc24cb631dc9bc4
dashboard link: https://syzkaller.appspot.com/bug?extid=810b8555076779a07399
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/532c57952c57/disk-b7f94fcf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/38b172b182bb/vmlinux-b7f94fcf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/516117ec1173/bzImage-b7f94fcf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+810b8555076779a07399@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hlist_add_head include/linux/list.h:1026 [inline]
BUG: KASAN: slab-use-after-free in binder_add_device+0xa4/0xb0 drivers/android/binder.c:6932
Write of size 8 at addr ffff88805b2f1408 by task syz-executor/20732

CPU: 0 UID: 0 PID: 20732 Comm: syz-executor Not tainted 6.14.0-rc6-syzkaller-00022-gb7f94fcf5546 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xd9/0x110 mm/kasan/report.c:634
 hlist_add_head include/linux/list.h:1026 [inline]
 binder_add_device+0xa4/0xb0 drivers/android/binder.c:6932
 binderfs_binder_device_create.isra.0+0x95f/0xb70 drivers/android/binderfs.c:210
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
RIP: 0033:0x7f102658e90a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8e459a48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f102660e663 RCX: 00007f102658e90a
RDX: 00007f102661dda7 RSI: 00007f102660e663 RDI: 00007f102661dda7
RBP: 00007f102660e8ac R08: 0000000000000000 R09: 00007f10267a6738
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f10265eb1a8
R13: 00007f10265eb180 R14: 0000000000000009 R15: 0000000000000000
 </TASK>

Allocated by task 6747:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:901 [inline]
 batadv_forw_packet_alloc+0x3ac/0x4e0 net/batman-adv/send.c:519
 batadv_iv_ogm_aggregate_new+0x132/0x4a0 net/batman-adv/bat_iv_ogm.c:562
 batadv_iv_ogm_queue_add net/batman-adv/bat_iv_ogm.c:670 [inline]
 batadv_iv_ogm_schedule_buff+0xe6d/0x14d0 net/batman-adv/bat_iv_ogm.c:849
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:868 [inline]
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:861 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x31e/0x8d0 net/batman-adv/bat_iv_ogm.c:1712
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3400
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 10272:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kfree+0x2c4/0x4d0 mm/slub.c:4757
 batadv_iv_send_outstanding_bat_ogm_packet+0x262/0x8d0 net/batman-adv/bat_iv_ogm.c:1718
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3400
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xb8/0xd0 mm/kasan/generic.c:548
 insert_work+0x36/0x230 kernel/workqueue.c:2183
 __queue_work+0x3f8/0x10f0 kernel/workqueue.c:2345
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1835 [inline]
 __run_timers+0x56a/0x930 kernel/time/timer.c:2414
 __run_timer_base kernel/time/timer.c:2426 [inline]
 __run_timer_base kernel/time/timer.c:2418 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2435
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2445
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

The buggy address belongs to the object at ffff88805b2f1400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 8 bytes inside of
 freed 512-byte region [ffff88805b2f1400, ffff88805b2f1600)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88805b2f1000 pfn:0x5b2f0
head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000240(workingset|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000240 ffff88801b041c80 ffffea0000c12c10 ffffea000093fd10
raw: ffff88805b2f1000 000000000010000a 00000000f5000000 0000000000000000
head: 00fff00000000240 ffff88801b041c80 ffffea0000c12c10 ffffea000093fd10
head: ffff88805b2f1000 000000000010000a 00000000f5000000 0000000000000000
head: 00fff00000000002 ffffea00016cbc01 ffffffffffffffff 0000000000000000
head: 0000000000000004 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 12181, tgid 12181 (syz-executor), ts 725842820442, free_ts 725318767702
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
 __do_kmalloc_node mm/slub.c:4293 [inline]
 __kmalloc_noprof+0x2ec/0x510 mm/slub.c:4306
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 fib6_info_alloc+0x40/0x160 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x337/0x1910 net/ipv6/route.c:3766
 ip6_route_add+0x26/0x1c0 net/ipv6/route.c:3858
 addrconf_prefix_route+0x2fe/0x510 net/ipv6/addrconf.c:2485
 addrconf_add_linklocal+0x32a/0x620 net/ipv6/addrconf.c:3310
 addrconf_addr_gen+0x36f/0x3c0 net/ipv6/addrconf.c:3439
 addrconf_dev_config net/ipv6/addrconf.c:3485 [inline]
 addrconf_init_auto_addrs+0x446/0x820 net/ipv6/addrconf.c:3563
 addrconf_notify+0xe91/0x19c0 net/ipv6/addrconf.c:3736
page last free pid 12513 tgid 12513 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
 vfree+0x174/0x950 mm/vmalloc.c:3383
 vb2_vmalloc_put drivers/media/common/videobuf2/videobuf2-vmalloc.c:68 [inline]
 vb2_vmalloc_put+0x7b/0xc0 drivers/media/common/videobuf2/videobuf2-vmalloc.c:63
 __vb2_buf_mem_free+0x14d/0x2b0 drivers/media/common/videobuf2/videobuf2-core.c:275
 __vb2_free_mem drivers/media/common/videobuf2/videobuf2-core.c:571 [inline]
 __vb2_queue_free+0x7dc/0xa20 drivers/media/common/videobuf2/videobuf2-core.c:599
 vb2_core_queue_release+0x70/0x190 drivers/media/common/videobuf2/videobuf2-core.c:2695
 v4l2_m2m_ctx_release+0x2a/0x40 drivers/media/v4l2-core/v4l2-mem2mem.c:1277
 vim2m_release+0xe2/0x170 drivers/media/test-drivers/vim2m.c:1243
 v4l2_release+0x232/0x460 drivers/media/v4l2-core/v4l2-dev.c:458
 __fput+0x3ff/0xb70 fs/file_table.c:464
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88805b2f1300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805b2f1380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805b2f1400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88805b2f1480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88805b2f1500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

