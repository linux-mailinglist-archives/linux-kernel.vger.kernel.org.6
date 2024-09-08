Return-Path: <linux-kernel+bounces-320216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978979707B0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1397B1F2199F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99DC166311;
	Sun,  8 Sep 2024 13:10:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C918E06
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725801006; cv=none; b=RpBJdNtnXJss+3vzOqWzKDEYnAny8HWPlyouYu8j4xDqHgUe6Exbf36mxmFwaDvZLcnLSqjsMkeU3XisuuKRjyPPJWKeXzfwGdblgMp4/VN1H0qR1v2vbot5KGetR9OhibuPnNZ1AsGWFnYPXeTXdu6gyebv0xIaySResjcbyVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725801006; c=relaxed/simple;
	bh=yguvx5JOTGNUM4EwhUimda0Kyq+QxEvXNrZNJbuzdWg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aKl4DI+q2xilyrhdmtnud1DqjNzXeUl09dxZuWxPVWM1XwmNcUwHhmtsRqLEsZTnynHsWwjw5r8bovjqKQ40xV+bWofZ07ZhRSqcUxVBZYsMeUhuUnkY9PcIRkCDv1kxUyXvRvtZjtA42Iju3UjufiQuIiRH0udWFfLE/Irv6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a045bf5779so60192215ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 06:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725801003; x=1726405803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eko2yEGTX3J1RIGqzFnndlZx1/6Zj2B1nCWLdw6SfM4=;
        b=ngKmfSREE5tt+Ikn53OcOUFAxFGrnjWCWBz1UYiXMSsRIvB0ugAA7DGee1dHTJwEX4
         5DZM9HA5Y3Pw5vZSr8bkIfa2khO/g6dOtzkIGiL2QUZ2I70Msz180wCyVNYUnDbX/+v2
         NGgxw+tND5kVvhaL0BaqgJrluJl0Bi608lR/itbW57eZkFQk4AN4sD1sZf2BncgBYLR+
         6VZCgs+09ekcCDHWOQUalsKe1oE0IV+ul15iZ7vAvA+Kcw+ufrcgXmsZbfDKECCzAy4C
         Ux+zQAhKVPbZW+L7fNJBw3wb0lf0XF9lF6jJ/SyvuzAMHElhk0dTEJqySnZPX+IzGDae
         6x2w==
X-Forwarded-Encrypted: i=1; AJvYcCVMiAzP3YlL83kTUuJUGi9MT7fS7tM5RVfpniSNO/d+A+oZwD1vLlxf4IVd1s2VSDbRazOLdlPYYbr8Vhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddOTzLSVpNW1gDwgqDVNvee/kFvLFMLDezdoAH2hlFPAKTMj0
	pYJjrW9hwFXISmxKJsfXcxLHhsVWo0h9EWW5K1Lnu11eOQOAFozK5/IvmMe4XGHuu13j02MrU7K
	D1/fixPxAT828Hirdf77JI1pgJZkqd8SttG2brY5s6OvUIoJpxfZ/M6U=
X-Google-Smtp-Source: AGHT+IGfc+JZrTcHsjvvZJSwm/H1LilOqs1WGzW2MlqV395Fz+DcwN+JGCUnD37D6Mnc3hxKfS/KX7TuaB6k6DFZ+MT6EiiNF19H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1846:b0:39d:2ced:e3ee with SMTP id
 e9e14a558f8ab-3a04f070e0emr98421355ab.8.1725801003228; Sun, 08 Sep 2024
 06:10:03 -0700 (PDT)
Date: Sun, 08 Sep 2024 06:10:03 -0700
In-Reply-To: <20240908125017.2529-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0339406219b5b0d@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in l2cap_recv_acldata

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_recv_acldata+0xa0b/0xb70 net/bluetooth/l2cap_core.c:7480
Read of size 8 at addr ffff888031b08fe8 by task kworker/u9:8/7223

CPU: 0 UID: 0 PID: 7223 Comm: kworker/u9:8 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 l2cap_recv_acldata+0xa0b/0xb70 net/bluetooth/l2cap_core.c:7480
 hci_acldata_packet net/bluetooth/hci_core.c:3792 [inline]
 hci_rx_work+0xac0/0x1630 net/bluetooth/hci_core.c:4030
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6015:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 __hci_conn_add+0x131/0x1a50 net/bluetooth/hci_conn.c:934
 hci_conn_add_unset+0x6d/0x100 net/bluetooth/hci_conn.c:1043
 hci_conn_request_evt+0x8c4/0xb40 net/bluetooth/hci_event.c:3288
 hci_event_func net/bluetooth/hci_event.c:7446 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7498
 hci_rx_work+0x2c6/0x1630 net/bluetooth/hci_core.c:4025
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 6017:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 device_release+0xa1/0x240 drivers/base/core.c:2582
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 put_device drivers/base/core.c:3790 [inline]
 device_unregister+0x2f/0xc0 drivers/base/core.c:3913
 hci_conn_del_sysfs+0xb4/0x180 net/bluetooth/hci_sysfs.c:86
 hci_conn_cleanup net/bluetooth/hci_conn.c:175 [inline]
 hci_conn_del+0x54e/0xdb0 net/bluetooth/hci_conn.c:1162
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888031b08000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4072 bytes inside of
 freed 8192-byte region [ffff888031b08000, ffff888031b0a000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888031b0c000 pfn:0x31b08
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000040 ffff88801ac42280 ffffea0001f09000 0000000000000003
raw: ffff888031b0c000 0000000000020001 00000001fdffffff 0000000000000000
head: 00fff00000000040 ffff88801ac42280 ffffea0001f09000 0000000000000003
head: ffff888031b0c000 0000000000020001 00000001fdffffff 0000000000000000
head: 00fff00000000003 ffffea0000c6c201 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 6015, tgid 6015 (kworker/u9:6), ts 133220298161, free_ts 131544899649
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
 __kmalloc_cache_noprof+0x2b4/0x300 mm/slub.c:4188
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 __hci_conn_add+0x131/0x1a50 net/bluetooth/hci_conn.c:934
 hci_conn_add_unset+0x6d/0x100 net/bluetooth/hci_conn.c:1043
 hci_conn_request_evt+0x8c4/0xb40 net/bluetooth/hci_event.c:3288
 hci_event_func net/bluetooth/hci_event.c:7446 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7498
 hci_rx_work+0x2c6/0x1630 net/bluetooth/hci_core.c:4025
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
page last free pid 5957 tgid 5957 stack trace:
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
 kmem_cache_alloc_noprof+0x121/0x2f0 mm/slub.c:4048
 ptlock_alloc mm/memory.c:6589 [inline]
 ptlock_init include/linux/mm.h:2944 [inline]
 pmd_ptlock_init include/linux/mm.h:3048 [inline]
 pagetable_pmd_ctor include/linux/mm.h:3086 [inline]
 pmd_alloc_one_noprof include/asm-generic/pgalloc.h:141 [inline]
 __pmd_alloc+0xc3/0x820 mm/memory.c:6079
 pmd_alloc include/linux/mm.h:2835 [inline]
 alloc_new_pmd mm/mremap.c:96 [inline]
 move_page_tables+0x2218/0x3780 mm/mremap.c:608
 shift_arg_pages+0x1eb/0x410 fs/exec.c:758
 setup_arg_pages+0x516/0xc70 fs/exec.c:880
 load_elf_binary+0xa66/0x4d90 fs/binfmt_elf.c:1014
 search_binary_handler fs/exec.c:1827 [inline]
 exec_binprm fs/exec.c:1869 [inline]
 bprm_execve fs/exec.c:1920 [inline]
 bprm_execve+0x703/0x1960 fs/exec.c:1896
 do_execveat_common.isra.0+0x4f1/0x630 fs/exec.c:2027
 do_execve fs/exec.c:2101 [inline]
 __do_sys_execve fs/exec.c:2177 [inline]
 __se_sys_execve fs/exec.c:2172 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2172
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888031b08e80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888031b08f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888031b08f80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888031b09000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888031b09080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         d1f2d51b Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14151f29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15449ffb980000


