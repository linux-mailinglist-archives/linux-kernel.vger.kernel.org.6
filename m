Return-Path: <linux-kernel+bounces-320002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC8B9704F3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 05:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8700A1F21E18
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD763200A0;
	Sun,  8 Sep 2024 03:06:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCD139B
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725764765; cv=none; b=e4oy5zZ64l+rZXSZOLapUC9exqsRBTP8oNFMhVs6OHt9k9LwGTDlUfy/KxCImX/NfOqSrl1xdjIdrn8UQCsYA7NVjOV7ixpyESR1L2t7S5bBlR7utH/uW9S4EmqL1YNGrv3WhIt+4rLo3B44jVb3jRgfWAeBHqjRZW0Rwnpq+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725764765; c=relaxed/simple;
	bh=nJHFsTy9taJoYbFqVzhbpnTiQCFFKncELSgoc2Ykang=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J9wVYOn9HbQATg1M+7skLB/xD8C5DzONHIEKezc9FrgEQCa61ChmkhurATYLmSWzYJEBtjTJDDAGRYNSeX6db5w0slSzPaYPM5JPyUPFG98e7Wx3xDSOwRxNwtgVsG/UDrY9G7dinYPaAn0VI4LL922i8gPdGBk4jBfCsbHRtos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f6f16ed00so76783445ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 20:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725764762; x=1726369562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQrVOk7nVI7x/AZadaAbmdrUwOCIyblXQujd7+xT3z0=;
        b=qdxR+CXNrzpEZYcqHsuMNrMAabAFGMgPfmCGtITeNil58YT1LGWwn9g2xM8O32NUSB
         gUDkzC6C5AFLPLRTJF8VTO2pRLnA+K2t1ACFH/RPCxa9bbab6/7+Ha4jTjCriqvzT3sQ
         0N8Nmu081/HAEgfpnXSOmrEyPyRSPl3xz68NgEIqELfaN7l9oBDIV0zbfdTOs+bxKu7o
         fZMRVRWGEqxCTYlN2LunwdpslzEbhPy5iezZJbdp+g5D4Iog+kdcptKYLWEddKaRpEQk
         t0YAXXuOZcAKU0hiPmgDhCoknRfH0PL/X2dKftoTezRer3WEl8pXpdtmtEURePJlgQnJ
         P+UA==
X-Forwarded-Encrypted: i=1; AJvYcCU+myfn0qLgpjGPslhf9vbbXFqkxVQa2GRVxLn53CNDsWCZCoFvwJAKO6MmShMfmgVOuxFcNC/kY9rlTRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNC0M/3n/6HEw6Z5maZazjXfsA887Bzw4QqD36w3t090Xcpj6y
	t6370MrbTGEFbZnnhYPcSiGJNiWE/cY56FKafTXHOknbKVgFuoIvsDR2q5ev5sxkO0bf2viJ+0z
	NTSfuBIfVYi5IdAvajSxPchE3XRgJdzehP4vvHpd+ZOCP1fd3J6se760=
X-Google-Smtp-Source: AGHT+IFIPJzuZ6DgQflfi7epKF6Bkio2jYhFOvA9B8FcGdlRHyRGaKXt3KXiO9aV/Bxstr3lAcfUEfNwxg0aWP1EAK5Krgs8bQl1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:376:1cf6:6be4 with SMTP id
 e9e14a558f8ab-3a04f08ba31mr94346465ab.14.1725764762420; Sat, 07 Sep 2024
 20:06:02 -0700 (PDT)
Date: Sat, 07 Sep 2024 20:06:02 -0700
In-Reply-To: <tencent_891763176DE6D7D3632361C96023BBE44F05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a15905062192ebcf@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in l2cap_connect

Bluetooth: Unknown BR/EDR signaling command 0x11
Bluetooth: Wrong link type (-22)
==================================================================
BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
Read of size 8 at addr ffff88807a217000 by task kworker/u9:0/54

CPU: 0 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci2 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
 l2cap_connect_req net/bluetooth/l2cap_core.c:4080 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4772 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5543 [inline]
 l2cap_recv_frame+0xf0b/0x8eb0 net/bluetooth/l2cap_core.c:6825
 l2cap_recv_acldata+0x9b4/0xb70 net/bluetooth/l2cap_core.c:7514
 hci_acldata_packet net/bluetooth/hci_core.c:3791 [inline]
 hci_rx_work+0xaab/0x1610 net/bluetooth/hci_core.c:4028
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6033:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 l2cap_conn_add.part.0+0x60/0xa60 net/bluetooth/l2cap_core.c:6868
 l2cap_conn_add net/bluetooth/l2cap_core.c:69 [inline]
 l2cap_connect_cfm+0x428/0xf80 net/bluetooth/l2cap_core.c:7245
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_remote_features_evt+0x548/0x9e0 net/bluetooth/hci_event.c:3721
 hci_event_func net/bluetooth/hci_event.c:7446 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7498
 hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4023
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 7242:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 l2cap_conn_free net/bluetooth/l2cap_core.c:1810 [inline]
 kref_put include/linux/kref.h:65 [inline]
 l2cap_conn_put net/bluetooth/l2cap_core.c:1822 [inline]
 l2cap_conn_del+0x59d/0x730 net/bluetooth/l2cap_core.c:1802
 l2cap_connect_cfm+0x9e6/0xf80 net/bluetooth/l2cap_core.c:7241
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_conn_failed+0x1c3/0x370 net/bluetooth/hci_conn.c:1265
 hci_abort_conn_sync+0x5df/0xb90 net/bluetooth/hci_sync.c:5583
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 insert_work+0x36/0x230 kernel/workqueue.c:2185
 __queue_work+0x97e/0x1070 kernel/workqueue.c:2341
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1838 [inline]
 __run_timers+0x567/0xaf0 kernel/time/timer.c:2417
 __run_timer_base kernel/time/timer.c:2428 [inline]
 __run_timer_base kernel/time/timer.c:2421 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2437
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2447
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xba/0xd0 mm/kasan/generic.c:541
 insert_work+0x36/0x230 kernel/workqueue.c:2185
 __queue_work+0x3f8/0x1070 kernel/workqueue.c:2345
 queue_work_on+0x11a/0x140 kernel/workqueue.c:2392
 queue_work include/linux/workqueue.h:621 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1640 [inline]
 l2cap_connect_cfm+0x9c9/0xf80 net/bluetooth/l2cap_core.c:7286
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_remote_features_evt+0x548/0x9e0 net/bluetooth/hci_event.c:3721
 hci_event_func net/bluetooth/hci_event.c:7446 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7498
 hci_rx_work+0x2c6/0x1610 net/bluetooth/hci_core.c:4023
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88807a217000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff88807a217000, ffff88807a217400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a210
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac41dc0 ffffea0001813a00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 ffffea0001813a00 dead000000000002
head: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea0001e88401 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 6025, tgid 6025 (syz-executor), ts 135418734548, free_ts 135276394069
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
 __do_kmalloc_node mm/slub.c:4161 [inline]
 __kmalloc_node_track_caller_noprof+0x355/0x430 mm/slub.c:4181
 kmemdup_noprof+0x29/0x60 mm/util.c:133
 kmemdup_noprof include/linux/fortify-string.h:753 [inline]
 setup_ipc_sysctls+0x5e/0x300 ipc/ipc_sysctl.c:251
 create_ipc_ns ipc/namespace.c:81 [inline]
 copy_ipcs+0x498/0x600 ipc/namespace.c:112
 create_new_namespaces+0x20a/0xad0 kernel/nsproxy.c:90
 unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
 ksys_unshare+0x419/0x970 kernel/fork.c:3309
 __do_sys_unshare kernel/fork.c:3380 [inline]
 __se_sys_unshare kernel/fork.c:3378 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3378
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
page last free pid 5878 tgid 5878 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2619
 __put_partials+0x14c/0x170 mm/slub.c:3055
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3992 [inline]
 slab_alloc_node mm/slub.c:4041 [inline]
 __do_kmalloc_node mm/slub.c:4161 [inline]
 __kmalloc_node_noprof+0x1c3/0x430 mm/slub.c:4168
 kmalloc_node_noprof include/linux/slab.h:708 [inline]
 __vmalloc_area_node mm/vmalloc.c:3642 [inline]
 __vmalloc_node_range_noprof+0x3de/0x14e0 mm/vmalloc.c:3837
 alloc_thread_stack_node kernel/fork.c:313 [inline]
 dup_task_struct kernel/fork.c:1113 [inline]
 copy_process+0x2f3b/0x8de0 kernel/fork.c:2204
 kernel_clone+0xfd/0x960 kernel/fork.c:2781
 __do_sys_clone3+0x1f5/0x270 kernel/fork.c:3085
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807a216f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807a216f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807a217000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807a217080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807a217100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116def29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133feffb980000


