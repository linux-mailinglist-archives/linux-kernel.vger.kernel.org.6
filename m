Return-Path: <linux-kernel+bounces-514868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B65A35CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7573A9EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB20263C69;
	Fri, 14 Feb 2025 11:42:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104625E44A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533324; cv=none; b=huj6qqh+zakA2/EZpt6Rb9KYvRE2hY//B/oPcU1+IQc3BiOOd/hKilLGiXDkRXjOf8ETznggvD2YgtbETAo5DNR5U01DWnFbspWm09+raWxZ+0mvT1cUU09c0vk+Qx2ciThUDpFF7iNDEwxTNk/WlCFB3Mo7UggMq4Cga1NdkRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533324; c=relaxed/simple;
	bh=MYQw7EsZRLya6JkNnwgGEHattSFP7c0q6VjDpHpclew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vAXnpUoUKPNiJwoyLnF3+CzwtQJ5kPx1KPENJ2rCrUsgYl4/sO46rGdEVzJqXmI7HoZY1IXMR9+cd+nhtcvwvDoxKxCJG5Rsd0Dogc5OVvgqlFogFePDDrEVTRr8O/pRseAElgDldI5JFnQf4CkseoA8WtNjytfCdvxOhtv9t3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d14950ac9fso32223025ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533322; x=1740138122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70L3Ew3hoezs7957juiJAvFUyzvdTWM+tIN1r5kTrLo=;
        b=tXBpZ8/dXUNyT3cczRywmzSMRnhmdZBOFo26jQNRA1Jv5zjNEndCAMkPQGitDKtmpv
         WIrMbzdNtSqw+oSDi5uOCjyM3QHoWp4Tr5EzdNI86B0eriNsekwPv4msVN+qQkKiL5Si
         CBk2udcpAXlhYm1YjNCRWvJAsEiGf0qMlLVWnVAn7V0t6zRz3BTiroo5DOSCt3JNtDeh
         wrM0nDJnjJwohJ4gTZzNftr90kxli/zZoDaYPavseDcPUGs5OKLFztXuhNKjS0jsnaKV
         xILUyg39u0ZBkVnavOhRxrtVE70cDVC9XVn7fZq3/lsFFYCWp7AMo55J497+ub0bMDFp
         aySg==
X-Forwarded-Encrypted: i=1; AJvYcCX6N3o4tPX8dm98h1gTqKCYTnshn5hX56nmCb1kSdOsH0N+ORV27vCIGGPSRVR0U/19/Dd74X8RhsIby5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMs82OIvVsIHxhAkS56oG61r5N4a5rdVy7FAvhGUBsoN1JRJ6+
	sdru3gZ5Gzx5836dtLhEyO80l3BLfjP78SHWv+xbroEQr8zyzu+R2d5uMFkkONi1ih+HWxKOn5v
	cOXMneY5CxSg0Li/psRqha0AbvzhM/rr9k8nKMtiyDVYelfkTdcGQyss=
X-Google-Smtp-Source: AGHT+IFxdZovbKmLf2fDHZzG73dk1DlsuJKjSxZvNbWu/5Xq/ftpoiKT7bTjJ0zwgJXil/gzle2PjT87fKJn45oVJIk7PNr296lm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3689:b0:3d0:11ff:a782 with SMTP id
 e9e14a558f8ab-3d18c231101mr59262605ab.9.1739533322237; Fri, 14 Feb 2025
 03:42:02 -0800 (PST)
Date: Fri, 14 Feb 2025 03:42:02 -0800
In-Reply-To: <20250214111926.2252-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67af2c0a.050a0220.21dd3.0043.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING: refcount bug in netfs_put_subrequest
From: syzbot <syzbot+d9890527385ab9767e03@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in io_submit_one

netfs: Couldn't get user pages (rc=-14)
==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: slab-use-after-free in __refcount_sub_and_test include/linux/refcount.h:264 [inline]
BUG: KASAN: slab-use-after-free in __refcount_dec_and_test include/linux/refcount.h:307 [inline]
BUG: KASAN: slab-use-after-free in refcount_dec_and_test include/linux/refcount.h:325 [inline]
BUG: KASAN: slab-use-after-free in iocb_put fs/aio.c:1208 [inline]
BUG: KASAN: slab-use-after-free in io_submit_one+0x4e5/0x1da0 fs/aio.c:2055
Write of size 4 at addr ffff88802e13ae88 by task syz.1.40/6596

CPU: 3 UID: 0 PID: 6596 Comm: syz.1.40 Not tainted 6.14.0-rc2-syzkaller-g128c8f96eb86-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:264 [inline]
 __refcount_dec_and_test include/linux/refcount.h:307 [inline]
 refcount_dec_and_test include/linux/refcount.h:325 [inline]
 iocb_put fs/aio.c:1208 [inline]
 io_submit_one+0x4e5/0x1da0 fs/aio.c:2055
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8f53d8cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8f54b7f038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f8f53fa5fa0 RCX: 00007f8f53d8cde9
RDX: 00004000000002c0 RSI: 0000000000000001 RDI: 00007f8f54b5e000
RBP: 00007f8f53e0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8f53fa5fa0 R15: 00007ffeeb0594c8
 </TASK>

Allocated by task 6596:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4115 [inline]
 slab_alloc_node mm/slub.c:4164 [inline]
 kmem_cache_alloc_noprof+0x226/0x3d0 mm/slub.c:4171
 aio_get_req fs/aio.c:1058 [inline]
 io_submit_one+0x123/0x1da0 fs/aio.c:2048
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6596:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2353 [inline]
 slab_free mm/slub.c:4609 [inline]
 kmem_cache_free+0x2e2/0x4d0 mm/slub.c:4711
 iocb_destroy fs/aio.c:1110 [inline]
 iocb_put fs/aio.c:1210 [inline]
 iocb_put fs/aio.c:1206 [inline]
 aio_complete_rw+0x3ec/0x7b0 fs/aio.c:1507
 netfs_rreq_assess_dio fs/netfs/read_collect.c:379 [inline]
 netfs_read_collection+0x30fa/0x3cf0 fs/netfs/read_collect.c:442
 netfs_wait_for_pause+0x31c/0x3e0 fs/netfs/read_collect.c:693
 netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:106 [inline]
 netfs_unbuffered_read fs/netfs/direct_read.c:144 [inline]
 netfs_unbuffered_read_iter_locked+0xb50/0x1610 fs/netfs/direct_read.c:229
 netfs_unbuffered_read_iter+0xc5/0x100 fs/netfs/direct_read.c:264
 v9fs_file_read_iter+0xbf/0x100 fs/9p/vfs_file.c:361
 aio_read+0x313/0x4e0 fs/aio.c:1602
 __io_submit_one fs/aio.c:2003 [inline]
 io_submit_one+0x1580/0x1da0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802e13adc0
 which belongs to the cache aio_kiocb of size 216
The buggy address is located 200 bytes inside of
 freed 216-byte region [ffff88802e13adc0, ffff88802e13ae98)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88802e13af00 pfn:0x2e13a
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff888020025cc0 dead000000000122 0000000000000000
raw: ffff88802e13af00 0000000080190010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff888020025cc0 dead000000000122 0000000000000000
head: ffff88802e13af00 0000000080190010 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffea0000b84e81 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6485, tgid 6484 (syz.1.20), ts 73097474485, free_ts 73096375881
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x181/0x1b0 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x221/0x2470 mm/page_alloc.c:4739
 alloc_pages_mpol+0x1fc/0x540 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2587 [inline]
 new_slab+0x23d/0x330 mm/slub.c:2640
 ___slab_alloc+0xc5d/0x1720 mm/slub.c:3826
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 kmem_cache_alloc_noprof+0xfa/0x3d0 mm/slub.c:4171
 aio_get_req fs/aio.c:1058 [inline]
 io_submit_one+0x123/0x1da0 fs/aio.c:2048
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit fs/aio.c:2081 [inline]
 __x64_sys_io_submit+0x1b2/0x340 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 34 tgid 34 stack trace:
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
 ffff88802e13ad80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88802e13ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802e13ae80: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
                      ^
 ffff88802e13af00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802e13af80: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
==================================================================


Tested on:

commit:         128c8f96 Merge tag 'drm-fixes-2025-02-14' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c659b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c09dc55ba7f798e3
dashboard link: https://syzkaller.appspot.com/bug?extid=d9890527385ab9767e03
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102087df980000


