Return-Path: <linux-kernel+bounces-324819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25728975150
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5661C22B8C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002218FDB7;
	Wed, 11 Sep 2024 11:59:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F74188A1C
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055945; cv=none; b=KQwe1IAb15mMF+raEmIqjnx7ZkfMqzc7Jfkg2NWcJyQSRUon3/pyayXTdXnvGrwu10hMkHkl43aCO/CBfmGUoGv0J+zuXsyN/IKvv3/f4+9XN26kvCuw9t0QUeboTsWgPicPCXNKFcoI3vPTpKKIt3btVdlVall1WFe3IgaSKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055945; c=relaxed/simple;
	bh=NifjeCvlZVqg97uNGgboAvL1IA6oePHO7ESk0KwvNsQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fvutyETUlcmFcBKq+BvNg8fK3PvV0fw8ekPfmoX1JdVip2dXr+Gv7kGl4FlWC8AgjDfrNE4Bm565hITnN+girPKYSloUNEcz6dJ8/+wiTyHXWvG1W7u0LSHXqf4ptRm+7cxhQWE/mDjbNKJmdO0157R62/gVpSi7IQeVP3J2iao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cf28c74efso643745239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 04:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726055943; x=1726660743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5946hHtUqB/3tC2yS+C03djbz5yRP603bjVzmXcLlxQ=;
        b=gc6qZRYZHF8elVtSWlOgSi9MxJ+2AYGWuwl3+lyKsGrZ0cFx/ePRIyVlNp72KJtoju
         A4RXPkn4Uo7PMiTm0nuSdL+Pj+UQzVhCBrWa976a8l45t/eQZGEkqcnX/cmuDYCCs8jM
         XKaq8YToqOLGv2tv38K46Euj9nets0Lk2gw9qYI6o0k6nyJhJXogc4LpD633ium4lVAu
         ZsVJ1OxSx9SvANtEHWJwmt0Ozntej1vWflRmKuYYa4YaJD92fTRXxKx/GegBGoqN8KEg
         q4UK3894ayWUSUbCY3ZxSIjNleVuwxrllLb481HQv0r3iBmdPiFK/MjSWKCU74EQ6IUG
         IqQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwDJiHCNvb7GqsMa6capvrfghjpWD1AMv2Wt17cnIZQDPa62T4xn5rCfNbBxrlEIG1B+kp6qwFvVuvvEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDSQwG0Eutz0/DsYrDu5xZ9Vx8X4N1SSoD9zgAd19SVZt+BREc
	YewvRPBZHpro1Aum0mcyRv8apDUZsaW2XUodYxPU392L89bglbVC44zh8LqR7f0hyjg41vpcati
	kF3+Ku63pajeQZ8HjrTGM/O612BCnXM/QI3TJx3GmsD0RaMQveA2zgoA=
X-Google-Smtp-Source: AGHT+IGY9fIZvRNYtDPnsOBBolZJbEVa5WKclwkvY8HBMXT/lz6lWg12LWKA6msryGD0ye7JQdfaEDHu+gPVOuAgju4uOqH1LAui
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fce:b0:39d:300f:e8ff with SMTP id
 e9e14a558f8ab-3a052238407mr191678825ab.6.1726055943216; Wed, 11 Sep 2024
 04:59:03 -0700 (PDT)
Date: Wed, 11 Sep 2024 04:59:03 -0700
In-Reply-To: <20240911112958.2845-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bb3170621d6b746@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hci_send_acl

Bluetooth: Wrong link type (-22)
Bluetooth: Wrong link type (-71)
==================================================================
BUG: KASAN: slab-use-after-free in hci_send_acl+0xc03/0xd30 net/bluetooth/hci_core.c:3230
Read of size 8 at addr ffff8880252f2018 by task kworker/u9:5/6019

CPU: 0 UID: 0 PID: 6019 Comm: kworker/u9:5 Not tainted 6.11.0-rc7-syzkaller-00020-g8d8d276ba2fb-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci2 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 hci_send_acl+0xc03/0xd30 net/bluetooth/hci_core.c:3230
 l2cap_send_cmd+0x6e5/0x920 net/bluetooth/l2cap_core.c:973
 l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5512 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5548 [inline]
 l2cap_recv_frame+0x21db/0x8f20 net/bluetooth/l2cap_core.c:6827
 l2cap_recv_acldata+0xc03/0xf00 net/bluetooth/l2cap_core.c:7524
 hci_acldata_packet net/bluetooth/hci_core.c:3793 [inline]
 hci_rx_work+0xabe/0x1630 net/bluetooth/hci_core.c:4031
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6020:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc_noprof include/linux/slab.h:681 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 hci_chan_create+0xa6/0x3d0 net/bluetooth/hci_conn.c:2732
 l2cap_conn_add.part.0+0x1a/0xa60 net/bluetooth/l2cap_core.c:6866
 l2cap_conn_add net/bluetooth/l2cap_core.c:69 [inline]
 l2cap_connect_cfm+0x428/0xf80 net/bluetooth/l2cap_core.c:7247
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_remote_features_evt+0x548/0x9e0 net/bluetooth/hci_event.c:3721
 hci_event_func net/bluetooth/hci_event.c:7446 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7498
 hci_rx_work+0x2c6/0x1630 net/bluetooth/hci_core.c:4026
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5281:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2256 [inline]
 slab_free mm/slub.c:4477 [inline]
 kfree+0x12a/0x3b0 mm/slub.c:4598
 hci_chan_list_flush+0x81/0xf0 net/bluetooth/hci_conn.c:2772
 hci_conn_cleanup net/bluetooth/hci_conn.c:150 [inline]
 hci_conn_del+0x1cc/0xdb0 net/bluetooth/hci_conn.c:1162
 hci_abort_conn_sync+0x75a/0xb50 net/bluetooth/hci_sync.c:5583
 abort_conn_sync+0x197/0x360 net/bluetooth/hci_conn.c:2917
 hci_cmd_sync_work+0x1a4/0x410 net/bluetooth/hci_sync.c:328
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880252f2000
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff8880252f2000, ffff8880252f2080)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880252f2900 pfn:0x252f2
flags: 0xfff00000000200(workingset|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000200 ffff88801ac41a00 ffffea00007ba290 ffffea00008abdd0
raw: ffff8880252f2900 000000000010000c 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 6020, tgid 6020 (kworker/u9:6), ts 135162004436, free_ts 135147554210
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
 hci_chan_create+0xa6/0x3d0 net/bluetooth/hci_conn.c:2732
 l2cap_conn_add.part.0+0x1a/0xa60 net/bluetooth/l2cap_core.c:6866
 l2cap_conn_add net/bluetooth/l2cap_core.c:69 [inline]
 l2cap_connect_cfm+0x428/0xf80 net/bluetooth/l2cap_core.c:7247
 hci_connect_cfm include/net/bluetooth/hci_core.h:1960 [inline]
 hci_remote_features_evt+0x548/0x9e0 net/bluetooth/hci_event.c:3721
 hci_event_func net/bluetooth/hci_event.c:7446 [inline]
 hci_event_packet+0x9eb/0x1180 net/bluetooth/hci_event.c:7498
 hci_rx_work+0x2c6/0x1630 net/bluetooth/hci_core.c:4026
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
page last free pid 5597 tgid 5597 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_folios+0x9e9/0x1390 mm/page_alloc.c:2667
 folios_put_refs+0x560/0x760 mm/swap.c:1039
 free_pages_and_swap_cache+0x36d/0x510 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages+0xf9/0x290 mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu mm/mmu_gather.c:373 [inline]
 tlb_finish_mmu+0x168/0x7b0 mm/mmu_gather.c:465
 exit_mmap+0x3d1/0xb20 mm/mmap.c:3425
 __mmput+0x12a/0x480 kernel/fork.c:1345
 mmput+0x62/0x70 kernel/fork.c:1367
 exit_mm kernel/exit.c:571 [inline]
 do_exit+0x9bf/0x2bb0 kernel/exit.c:869
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1040
 x64_sys_call+0x14a9/0x16a0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880252f1f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880252f1f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880252f2000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880252f2080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880252f2100: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
==================================================================


Tested on:

commit:         8d8d276b Merge tag 'trace-v6.11-rc6' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11556100580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28869f34c32848cf
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=162a07c7980000


