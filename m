Return-Path: <linux-kernel+bounces-332806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAEE97BF17
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E701C2142A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6A51C9858;
	Wed, 18 Sep 2024 16:26:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C92B1BC062
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676789; cv=none; b=FM71WunEf2lBCCFHlIqfut/dfE0Ija4hHuHjwofMK2WeU6Law34heQD1dglgi34H/68/sBBvz1Ez/6hXG8462wsPFk6YiimNxpsdwherJMcrJay00dcNePtKrO/sldwy5X3cSVOS5H7coyfKSvSbQts2oIut5gKY6HKSI3QVD20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676789; c=relaxed/simple;
	bh=+7PkQJ950l5QLiFngG9fnptOYMXKUVo6Y/a2+nHdPuw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YPEd0yLLl1EKYq9pVoRUKI55kMoV23Q0b2vz/MMBU/Dp/CC7omPTx8b/I7MUY0BXiMX1DsB5Ru+WSgGymWmAUT5/Pks+UN6cUSIfeBgE/ce0X0RzdWMG9JhltpBfLLqIcE8VBcjNZg0MmhEfjCKfTveY9NCe5IKvjnbb5COMq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a08c7d4273so128943355ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726676787; x=1727281587;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=50Via4lDs7hgSe3eWefHgXEndW/SPYbDjscVk9lyg/Q=;
        b=FhA+fwOPK+aXsf0QqU3DJlJ+8oAXcgL+g4mnnsNpxZ5wNYhuFyvkhVFjpF+2KdS+Fj
         r/sYx6VU5wvj2H2893nKJvweuswKLcIUilcXQmoTH+48KVY/z7eDBpsYrvRVEvGyWMmO
         0M8Y6U+kuP6oDbnKkm/DA24E1mdT/AxAff/w1nCrEMbJDc94XvlBpaKqf+ecTehC2Wzx
         lznoCUMjd/s1bKqb87zr06r8VrK0yBvFyovbTKMLPy3PKQIsZSc2ANJjoBfyMCK6ga5M
         HDYS5M3aoqCtz547Ha8BCiEGaVWXL7OgGatrx2JIev1Wv1f8QPplEp3kRhiPHTIUg8Xp
         2u+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIfVzY2QmNwBs4HJ7KgNoA1yBn2kH5p6iHyeCB7gxbPi5xdaM45oT3QZoDrgYLvGrXzhRQ2+rCRk2qylY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+C7NoSwWSYBLlLKbJdCM/VWHaPKq1bE/qPlmq1qHU/CZcC5z
	a7OlFtO/RpxMzTv98eABb+85l/AhaG5aHmgp3nRLfw+4I4XkHqUXT0pVxvs21/Q4ZUp+V4SGB2M
	b4/7noXAYMMWmJsNhHUq4hrdTO6K6MupntgAcLevJ1UY/IcNBNmVuhG4=
X-Google-Smtp-Source: AGHT+IFNJxhfAllkn3eld26n/5UqBGiUEpSyRnb5Hl5fm6nuV4N571yixac/ttacEgZ1NfctaoI8tTxbUIQK6IkXIoRb+0khrB99
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdab:0:b0:3a0:bed3:80c8 with SMTP id
 e9e14a558f8ab-3a0bed3839bmr2960815ab.22.1726676787108; Wed, 18 Sep 2024
 09:26:27 -0700 (PDT)
Date: Wed, 18 Sep 2024 09:26:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089afe20622674444@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in shrinker_free
From: syzbot <syzbot+6926ab9f6f7d7b50002e@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@fromorbit.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, syzkaller-bugs@googlegroups.com, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    57719771a244 Merge tag 'sound-6.11' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122c17c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=96be9a618e50f19f
dashboard link: https://syzkaller.appspot.com/bug?extid=6926ab9f6f7d7b50002e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1559749f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1359749f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87498efcab61/disk-57719771.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5703d19e746c/vmlinux-57719771.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3744ba66862a/bzImage-57719771.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6926ab9f6f7d7b50002e@syzkaller.appspotmail.com

svc: failed to register nfsdv3 RPC service (errno 512).
svc: failed to register nfsaclv3 RPC service (errno 512).
==================================================================
BUG: KASAN: slab-use-after-free in shrinker_free+0x3b7/0x430 mm/shrinker.c:775
Read of size 4 at addr ffff8880206cbb1c by task syz-executor313/5320

CPU: 0 UID: 0 PID: 5320 Comm: syz-executor313 Not tainted 6.11.0-rc7-syzkaller-00145-g57719771a244 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 shrinker_free+0x3b7/0x430 mm/shrinker.c:775
 nfsd_file_cache_shutdown+0xbc/0x480 fs/nfsd/filecache.c:891
 nfsd_shutdown_generic fs/nfsd/nfssvc.c:329 [inline]
 nfsd_shutdown_generic fs/nfsd/nfssvc.c:323 [inline]
 nfsd_startup_net fs/nfsd/nfssvc.c:444 [inline]
 nfsd_svc+0x6d4/0x970 fs/nfsd/nfssvc.c:817
 nfsd_nl_threads_set_doit+0x52c/0xbc0 fs/nfsd/nfsctl.c:1714
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9b4/0xb50 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f51ae6e5ab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f51ae634158 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f51ae768438 RCX: 00007f51ae6e5ab9
RDX: 0000000000000004 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007f51ae768430 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007f51ae76843c
R13: 000000000000006e R14: 00007ffc1415e4a0 R15: 00007ffc1415e588
 </TASK>

Allocated by task 5309:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 shrinker_alloc+0xf8/0xb00 mm/shrinker.c:683
 nfsd_file_cache_init+0x152/0x450 fs/nfsd/filecache.c:743
 nfsd_startup_generic fs/nfsd/nfssvc.c:307 [inline]
 nfsd_startup_net fs/nfsd/nfssvc.c:402 [inline]
 nfsd_svc+0x542/0x970 fs/nfsd/nfssvc.c:817
 nfsd_nl_threads_set_doit+0x52c/0xbc0 fs/nfsd/nfsctl.c:1714
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9b4/0xb50 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 0:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2843
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:3106
 shrinker_free+0xfe/0x430 mm/shrinker.c:807
 nfsd_file_cache_shutdown+0xbc/0x480 fs/nfsd/filecache.c:891
 nfsd_shutdown_generic fs/nfsd/nfssvc.c:329 [inline]
 nfsd_shutdown_generic fs/nfsd/nfssvc.c:323 [inline]
 nfsd_startup_net fs/nfsd/nfssvc.c:444 [inline]
 nfsd_svc+0x6d4/0x970 fs/nfsd/nfssvc.c:817
 nfsd_nl_threads_set_doit+0x52c/0xbc0 fs/nfsd/nfsctl.c:1714
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9b4/0xb50 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880206cbb00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 28 bytes inside of
 freed 192-byte region [ffff8880206cbb00, ffff8880206cbbc0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x206cb
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801ac413c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 4560085887, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x4e/0xf0 mm/slub.c:2325
 allocate_slab mm/slub.c:2488 [inline]
 new_slab+0x84/0x260 mm/slub.c:2541
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3727
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3817
 __slab_alloc_node mm/slub.c:3870 [inline]
 slab_alloc_node mm/slub.c:4029 [inline]
 __kmalloc_cache_noprof+0x2c5/0x310 mm/slub.c:4188
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 call_usermodehelper_setup+0x9a/0x340 kernel/umh.c:363
 kobject_uevent_env+0xde3/0x1670 lib/kobject_uevent.c:628
 kset_register+0x1b6/0x2b0 lib/kobject.c:877
 class_register+0x22e/0x340 drivers/base/class.c:203
 typec_init+0x63/0x110 drivers/usb/typec/class.c:2518
 do_one_initcall+0x128/0x630 init/main.c:1267
 do_initcall_level init/main.c:1329 [inline]
 do_initcalls init/main.c:1345 [inline]
 do_basic_setup init/main.c:1364 [inline]
 kernel_init_freeable+0x660/0xc50 init/main.c:1578
 kernel_init+0x1c/0x2b0 init/main.c:1467
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880206cba00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880206cba80: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880206cbb00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880206cbb80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880206cbc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

