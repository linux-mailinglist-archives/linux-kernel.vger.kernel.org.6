Return-Path: <linux-kernel+bounces-319830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230029702C4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 16:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37AA1B21859
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4933115D5DE;
	Sat,  7 Sep 2024 14:42:29 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC46C15C133
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 14:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725720148; cv=none; b=RH27iBnvLviJ1wrLvArNQGkfScQJiIy1iVtqhv1U0yuTpATebnEDq1ybVkAu2o7iOjZJivQST6b1rhmw4ssByv+7BuusTXO+FqchOcMdY/4muklX2uWjZ4UB3VIBtU3ABkq+NDSmR4njhYTIwS2XtTamZK+qlXCfnSynuF/anV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725720148; c=relaxed/simple;
	bh=s5xDla7pdSZ1xHnNL45RM5X6Rn2hSyqm+sZsZcrhDgA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bzhozSPEfGMI2AG9wfP84BNvi75ospwqJbmqJBBGCgMRDkSHKTx/GzQcCl4cCUw2tAD5nIfvY8FczPb6h9dpN1DKJJkR3K+T5JeDTOZkyAaHKBvjE3BqHBB8gkcbPypYjXR6R+rQrEG/p6Si/TPZPNBdeFiN5MiDA4woX2KSC7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa94d4683so43354039f.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 07:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725720146; x=1726324946;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ6npemtIGTdIEv4Bs4UZlqBv6+ejdI3Va3tXGYVtw8=;
        b=pll9p80HPX5GWqptrpa/NFKqFZr6e+DCHrO7Q0GVBuHjBKXMSdkcOPtdXagoUzBzBj
         DQ0BeNdzFV3rYRJK6LJI5KRetIROJjxslZODpO7vqn4fV+uxZ1olUQjmAT924gHTqGsf
         WFxCsBivAeL3rQXY9meY7axHbmfoubLWHNX02tDO1OmpT5yQdyIrmnSboPHyyflwF3O6
         0eEEbpHuivvGRSlL4mY4xgrFMJu2toSoizo+cyT0y35BimN8RDCHbxi6Krn9cl5DeYYl
         BNmCH9DoKaGWlzopwmlkiq7Fx7PyvBpdjXNLZQcjyJ7yhCP2QduemB+2RUmqxfT5XY0I
         GMYg==
X-Forwarded-Encrypted: i=1; AJvYcCVjvHWjzrEk6if67nc+vlK6CGOuDLfTkGSonT69xSPefz3RKjpH+isConR1Rwq8ODZFpJ2y+AWvF5VxkdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYv9knkQY9rb830anrzduqX+Ynqkrc8izTOIVDYyWjoVWxQeNq
	vwdss/zVTKK4qLQWPfSMl5NyDPw8Wp9du9iHYiVP+l2o1D67jjEeBxmVrrvCjh97nkFrvrBiOac
	v1dCt0wL7lQfvc52tmqtZCC3ILfspkPYFgPlNU9fF5ychNCBTKhfyenw=
X-Google-Smtp-Source: AGHT+IGeQln0bKRt+1kp5G1oYSUVFR3TiN1QEEi5r5kRcg6KjOZHBrIgN7ZsrLtclbPejvVJbezq/gTtX5ZnLkW8aV4QFDt6Wjed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6c8e:b0:4ce:8f9d:2c7d with SMTP id
 8926c6da1cb9f-4d084cc3422mr218277173.0.1725720146082; Sat, 07 Sep 2024
 07:42:26 -0700 (PDT)
Date: Sat, 07 Sep 2024 07:42:26 -0700
In-Reply-To: <000000000000d8f51a061ba88d22@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a130a0621888811@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    788220eee30d Merge tag 'pm-6.11-rc7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10502bc7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11da6f29980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1304189f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e618b7c8e5a2/disk-788220ee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/333bb524a2ba/vmlinux-788220ee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ad1779f24bb2/bzImage-788220ee.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_connect.constprop.0+0x10d8/0x1270 net/bluetooth/l2cap_core.c:3949
Read of size 8 at addr ffff8880241e9800 by task kworker/u9:0/54

CPU: 0 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc6-syzkaller-00268-g788220eee30d #0
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

Allocated by task 5253:
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

Freed by task 5245:
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
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
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

The buggy address belongs to the object at ffff8880241e9800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff8880241e9800, ffff8880241e9c00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x241e8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac41dc0 ffffea00007cac00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac41dc0 ffffea00007cac00 dead000000000002
head: 0000000000000000 0000000000100010 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea0000907a01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4642, tgid 4642 (init), ts 27796307015, free_ts 0
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
 __kmalloc_noprof+0x367/0x400 mm/slub.c:4174
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 tomoyo_init_log+0x13ca/0x2180 security/tomoyo/audit.c:275
 tomoyo_supervisor+0x30c/0xea0 security/tomoyo/common.c:2089
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x193/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0xef9/0x2020 security/tomoyo/domain.c:878
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:102 [inline]
 tomoyo_bprm_check_security+0x12e/0x1d0 security/tomoyo/tomoyo.c:92
 security_bprm_check+0x65/0xb0 security/security.c:1191
 search_binary_handler fs/exec.c:1815 [inline]
 exec_binprm fs/exec.c:1869 [inline]
 bprm_execve fs/exec.c:1920 [inline]
 bprm_execve+0x642/0x1960 fs/exec.c:1896
 do_execveat_common.isra.0+0x4f1/0x630 fs/exec.c:2027
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880241e9700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880241e9780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880241e9800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880241e9880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880241e9900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

