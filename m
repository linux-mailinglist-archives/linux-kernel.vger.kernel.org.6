Return-Path: <linux-kernel+bounces-227495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C464915236
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3671C220A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC62A19CD00;
	Mon, 24 Jun 2024 15:26:23 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611FE143743
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242783; cv=none; b=Rp8c3AzOS3p1cCON68D/IUFFonMm/z989WtOw8cEsFGe81LKy7D/pRhk7PUHVy2w5uZGyQNN3Yr++eRg/bQEzArHADMgJxr/o773AlQ7Sco/IRGH8yn7mXkfcv1cK4DLlvjLwDCIUj3wlkRl+84qQ6taRVBsNEdpBHulMwMymg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242783; c=relaxed/simple;
	bh=iQ0UuuGHEPJjr3ehYPkR3XeKuF6oD8PjrJe/BCpHm44=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HkQtifl0M+ZWeD4JXgtuqRo1fbvX7Lvq9CIseffQXAAmKiCl9Q3bI72F+8NQ0U0iq0lXjO4kh+MkrR0I3f3x4wd3VYTrjqV9Gu3H1ehEfaXpS6QNpBSMhtoFdSR9gkBxQxadopp1s0a04FuRO0iInvCLKJOc8vqjmvvdUh2zcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e94cac3c71so587512739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242780; x=1719847580;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFFdHIOZp39OVQExOAEe9wgQYKr9eDnp1rLTkp8H9KQ=;
        b=jJlKc8KXYLhkUP0RIOIA6Yz2iaSDQTBvFm/q9zWn6cCFgVmB7XR7+hjpN+tZzaOsps
         +w2RKd7lH/BBZPUJIrFvUa/U2Zv2IcReZbUfbXMcfs9XRYWWGzxYJ2hynhNweWFOWDXB
         StNX5y+zA0aKN5BqCyTH2aCuv4yWB2eAuNrXdpzn/gnAN5HKZoKRsj00FWFZbm7YF3d4
         SObs+y10siMiFLeLMLGp9BKX9MUUdYD780/YtzP32BqtDK9K8GuKVobnK6bHu/W+t9kJ
         Jg1+x0w8t4Zvs6fVgtRMq6zv/kBFGzm5g5gc8LSJbQK/l45jNqyMJKiJ1TftyQltBNQe
         Kfrg==
X-Forwarded-Encrypted: i=1; AJvYcCXWzpLqu4Slg8ezbQEbc94pea/kK2RL2Pz5ISmyGm0DOOHRi0o7xkvtLoLT7LzCq/EhVYxzngWptSyyxLPEt9IkevnngNZxrakgjJSH
X-Gm-Message-State: AOJu0YwI1NFjOO49hly3VoNHKTIrB1fJgZI0smaNSU13czn5OES/ayNa
	SmhlKCDKwXENeEEbFbYnR3pN2FoOVurSxv6Tsa8L6202/j8BObFk8bA763o0PPDND5ubUUIAcCP
	LvpBuRCIS1y1PQCF0e7IVWqfI7Djnm/UDi0Sshd6C8DJ77gJlscn8uh4=
X-Google-Smtp-Source: AGHT+IHzIQdaSRtqDhNc0EzvGsFhp5xf3njTT9lHaWhofrU0vPIC8gn4Yd9/oRQ9vWY79KV5Pj7cTWGILW7PAXNMyNLo6oefIdeY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9611:b0:4b9:bdfd:f15b with SMTP id
 8926c6da1cb9f-4b9ece1ba70mr651223173.4.1719242780597; Mon, 24 Jun 2024
 08:26:20 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:26:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000387998061ba467ac@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sk_skb_reason_drop
From: syzbot <syzbot+f115fcf7e49b2ebc902d@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    84562f9953ec Merge branch '100GbE' of git://git.kernel.org..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10e1c2d6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=f115fcf7e49b2ebc902d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1075608e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e1edb6a0d5b1/disk-84562f99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7df8d6218d93/vmlinux-84562f99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/151998fb709d/bzImage-84562f99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f115fcf7e49b2ebc902d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in refcount_read include/linux/refcount.h:136 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1228 [inline]
BUG: KASAN: slab-use-after-free in __sk_skb_reason_drop net/core/skbuff.c:1196 [inline]
BUG: KASAN: slab-use-after-free in sk_skb_reason_drop+0x44/0x3d0 net/core/skbuff.c:1224
Read of size 4 at addr ffff8880659b7c24 by task syz-executor.0/5174

CPU: 0 PID: 5174 Comm: syz-executor.0 Not tainted 6.10.0-rc4-syzkaller-00874-g84562f9953ec #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 refcount_read include/linux/refcount.h:136 [inline]
 skb_unref include/linux/skbuff.h:1228 [inline]
 __sk_skb_reason_drop net/core/skbuff.c:1196 [inline]
 sk_skb_reason_drop+0x44/0x3d0 net/core/skbuff.c:1224
 kfree_skb_reason include/linux/skbuff.h:1260 [inline]
 kfree_skb include/linux/skbuff.h:1269 [inline]
 __hci_req_sync+0x631/0x950 net/bluetooth/hci_request.c:184
 hci_req_sync+0xa9/0xd0 net/bluetooth/hci_request.c:206
 hci_dev_cmd+0x4c5/0xa50 net/bluetooth/hci_core.c:787
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f933f27ce0b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffe546c6fc0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f933f27ce0b
RDX: 00007ffe546c7038 RSI: 00000000400448dd RDI: 0000000000000003
RBP: 000055558c4c3430 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 4493:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3941 [inline]
 slab_alloc_node mm/slub.c:4001 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4008
 skb_clone+0x20c/0x390 net/core/skbuff.c:2054
 hci_send_cmd_sync net/bluetooth/hci_core.c:4123 [inline]
 hci_cmd_work+0x2a2/0x670 net/bluetooth/hci_core.c:4143
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 4493:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2196 [inline]
 slab_free mm/slub.c:4437 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4512
 kfree_skb_reason include/linux/skbuff.h:1260 [inline]
 kfree_skb include/linux/skbuff.h:1269 [inline]
 hci_req_sync_complete+0xe8/0x290 net/bluetooth/hci_request.c:109
 hci_event_packet+0xc75/0x1540 net/bluetooth/hci_event.c:7479
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4074
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880659b7b40
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 228 bytes inside of
 freed 240-byte region [ffff8880659b7b40, ffff8880659b7c30)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x659b7
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000000 ffff888018e98780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000000c000c 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5175, tgid 5175 (kworker/u9:2), ts 61702947833, free_ts 61656603903
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2e43/0x2f00 mm/page_alloc.c:3420
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4678
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2265
 allocate_slab+0x5a/0x2f0 mm/slub.c:2428
 new_slab mm/slub.c:2481 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3667
 __slab_alloc+0x58/0xa0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3989 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4008
 skb_clone+0x20c/0x390 net/core/skbuff.c:2054
 hci_send_cmd_sync net/bluetooth/hci_core.c:4123 [inline]
 hci_cmd_work+0x2a2/0x670 net/bluetooth/hci_core.c:4143
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 5167 tgid 5167 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2583
 vfree+0x186/0x2e0 mm/vmalloc.c:3346
 kcov_put kernel/kcov.c:429 [inline]
 kcov_close+0x2b/0x50 kernel/kcov.c:525
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa27/0x27e0 kernel/exit.c:874
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 get_signal+0x16a1/0x1740 kernel/signal.c:2909
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880659b7b00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff8880659b7b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880659b7c00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff8880659b7c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880659b7d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
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

