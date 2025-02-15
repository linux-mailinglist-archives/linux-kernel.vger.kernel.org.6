Return-Path: <linux-kernel+bounces-515952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C172A36AD0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB623B1080
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9054433AB;
	Sat, 15 Feb 2025 01:23:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1810D2FF
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582585; cv=none; b=XeWc4XRsrXo6EPxflZa52LQsgtgT78o3lkE4J9SnGQcl6ODG+RZouirzMrw9I+A3U3R/itOuiALlfurUuUrAFfS9mR9E2vQc6M/WvcQfph+L5uUmSmEUGwvMTEVJna9DJJc3/aHo6WZVn4UCqY7liswwuY2T7VIUrM+uN76+AUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582585; c=relaxed/simple;
	bh=ZwqYAG29EQWJCms99p2fYrw2E3hVSFc3fpAQ9rMEqzE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PHiYwctl+CBKJK+Dj3xNjnwhwzF/G7tGj2n7fe00wez7Xau2piuBg1EfJ5MohTP6QvITC4OqbvircRJkKcDw8SA2kX73JLTK0FxspjWQ7I+8hsa6JRR7YxhICCyvQG61EPiHxC4rQky0EYFy/Kr37het0HFZ9xXRePm+Dl+AIbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so46087215ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739582583; x=1740187383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeuZJ+VEPQQPxv/wsYHwtHxXFZC3ve27Djnw4obPSbM=;
        b=Con7EXmgrwB4nrgYwLvQetWmhcmjc2hI5hC+P3WG5wg4riBGa1AmR+nttLZbKicVDa
         bdWJPvU2Sh0ITMFeh9d11A6xmNJ5zdl3mV0LQYjv5/CTa8vQTBJ2ZBGi+8SLw5y7rma9
         C3EoTQ5sj4Bfg8sPfhhgsWdQ8j904ZAJbjIXTWTONyqOhJGZOTvSjpMVgNbA6TZUJwR+
         s3hivhuIJi/OCcXH9mvsY5CCPt+l3pAizUPJJxRbHclpS8NRv0rENrEEMx2/Ew7m2nBh
         c4WRg2ZQ9Bu4kioIemFQSO61M/+7fQHQHaPRGmMAbHLRKRVW0LQLiKE37iD5zK3BE6JP
         NAGw==
X-Forwarded-Encrypted: i=1; AJvYcCVGTghv7v7n+9LEOJsaFhhO7BqI8zpfRpzCCjBhdJFtwMz8dxKiWIc6iK8GX3rUzePI72LXOzvsuSlnMxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCLPGK4SdQY9D/qiMN6q1go9J7XFE0fGeMvdgrquElkgLS2Wb
	SjDbB9Kz/yiaV2BrDD2oPpSyMMJfI42ytXP32cP2lK0JWMuljPoF0zgU+TiH8rJ6O+mdUWpYF4B
	vEnoNwUpu7pWQvDch1ig+a4XcLS/GwQ/yjYjkNaAXYuos4AMPQLAJlNI=
X-Google-Smtp-Source: AGHT+IFx1e+3nQyCJrdWe8VaColkfh0c0WiXmd1ZfG8vnjkkX+t+OD35Jct05ZAKiWDnEocVo5aoF6auq8FVlRIH+M3Dbu2QMjrJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1689:b0:3d0:21f0:98f3 with SMTP id
 e9e14a558f8ab-3d2809a9d26mr12690555ab.21.1739582582805; Fri, 14 Feb 2025
 17:23:02 -0800 (PST)
Date: Fri, 14 Feb 2025 17:23:02 -0800
In-Reply-To: <tencent_6EC0D361236A496543ABC44E176E577EA605@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67afec76.050a0220.21dd3.0060.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in io_submit_one
From: syzbot <syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in netfs_read_collection

==================================================================
BUG: KASAN: slab-use-after-free in netfs_rreq_assess_dio fs/netfs/read_collect.c:377 [inline]
BUG: KASAN: slab-use-after-free in netfs_read_collection+0x3baa/0x3d10 fs/netfs/read_collect.c:440
Write of size 8 at addr ffff8880310c6650 by task kworker/u32:2/45

CPU: 0 UID: 0 PID: 45 Comm: kworker/u32:2 Not tainted 6.14.0-rc2-syzkaller-g78a632a2086c-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound netfs_read_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 netfs_rreq_assess_dio fs/netfs/read_collect.c:377 [inline]
 netfs_read_collection+0x3baa/0x3d10 fs/netfs/read_collect.c:440
 netfs_read_collection_worker+0x285/0x350 fs/netfs/read_collect.c:466
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 6706:
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

Freed by task 45:
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
 netfs_rreq_assess_dio fs/netfs/read_collect.c:375 [inline]
 netfs_read_collection+0x30b3/0x3d10 fs/netfs/read_collect.c:440
 netfs_read_collection_worker+0x285/0x350 fs/netfs/read_collect.c:466
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff8880310c6640
 which belongs to the cache aio_kiocb of size 216
The buggy address is located 16 bytes inside of
 freed 216-byte region [ffff8880310c6640, ffff8880310c6718)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880310c7e00 pfn:0x310c6
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801bb3bcc0 0000000000000000 0000000000000001
raw: ffff8880310c7e00 0000000080190015 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801bb3bcc0 0000000000000000 0000000000000001
head: ffff8880310c7e00 0000000080190015 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffea0000c43181 ffffffffffffffff 0000000000000000
head: ffff888000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 6549, tgid 6548 (syz.0.17), ts 88470255044, free_ts 87864364394
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
page last free pid 6535 tgid 6535 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_frozen_pages+0x6db/0xfb0 mm/page_alloc.c:2660
 mm_free_pgd kernel/fork.c:815 [inline]
 __mmdrop+0xd5/0x460 kernel/fork.c:931
 mmdrop include/linux/sched/mm.h:55 [inline]
 __mmput+0x36c/0x410 kernel/fork.c:1367
 mmput+0x62/0x70 kernel/fork.c:1378
 exec_mmap fs/exec.c:1011 [inline]
 begin_new_exec+0x152b/0x3800 fs/exec.c:1267
 load_elf_binary+0x886/0x4fc0 fs/binfmt_elf.c:1002
 search_binary_handler fs/exec.c:1775 [inline]
 exec_binprm fs/exec.c:1807 [inline]
 bprm_execve fs/exec.c:1859 [inline]
 bprm_execve+0x8dd/0x16d0 fs/exec.c:1835
 do_execveat_common.isra.0+0x4a2/0x610 fs/exec.c:1966
 do_execve fs/exec.c:2040 [inline]
 __do_sys_execve fs/exec.c:2116 [inline]
 __se_sys_execve fs/exec.c:2111 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2111
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880310c6500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880310c6580: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
>ffff8880310c6600: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                 ^
 ffff8880310c6680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880310c6700: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         78a632a2 Merge tag 'pci-v6.14-fixes-3' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=159267df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c09dc55ba7f798e3
dashboard link: https://syzkaller.appspot.com/bug?extid=e1dc29a4daf3f8051130
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10178bf8580000


