Return-Path: <linux-kernel+bounces-182725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77648C8EE0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 02:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896642832F2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A62653;
	Sat, 18 May 2024 00:20:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87D170
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991606; cv=none; b=JZh47DB7EjsyWW0x51fLJt+oISsJVoq7nQipW38h7nftDAD8rVnmDcJTk+2XeDd574Esj0XYNYdTiUepwyNxkjm/lz+OX/FZMnIsj9Dojz8Fsr1HC6Hl6oEqEuW7IypRtf4ba1nNBVSMaLO20Y0ntcaRXktWuGj9VQbk0adCT4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991606; c=relaxed/simple;
	bh=QWCAlY+8XvFmcG0C688vAby0rUw1mtCxwxaI0+uArCI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KOiGjzWEFswMrCRHTH7ZsA/ZwJKDk/ftNhi1s53wBfSCu85XWn8Ah4BJ8UmIbM2PSVVKIBQSRa4V2Qv5zsxYej1pEiHZb/E3y4G6iJELlhd8xIHpXBMQm0533m+ecTWAxAErdbtvtpxZpawYWIqQMriXDczcJkF4LBzp9wulSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7dabc125bddso1112980039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715991604; x=1716596404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/K0KEmNs3f+PvG7GTXJyIZhYJSj1fyyuxtdHSmjfYk=;
        b=KKOlQiuDi433LpTnmDcnC9XuwU2K2Uf4UPqTdjglsn9Wv7eEX2+CyL6eUm0be1dbuT
         ZWK4X84bH3aqlK2fFIgFp0Gx18g/Wg+Rb4Hn8Vuxn+F7jaxGkPLmZgjWTmujW+/OXjWN
         CnifEhX+cCRDB4k5FScVbDczlzKx8rcd/bEglrJIq2PliE6EJEbzjmRhNZZjibjGfKW0
         ziL8ajy9QmlnYPWFbN4YBpmcL9G7cmbc2YXYSCiq5ab4G3p5lCmAEZRvORBAy+IaluJK
         WolDivu0whVQGK2+8oZTaOr+2AnwytslhjqS4+krRxZmT0RIwiWAD9WiZjuWwEx4iBuP
         C+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWx39B/nlklmNGgQ9FSA/cFkDwZAC9lMgN3sIPVPK351RFWE3hqfHtkef5WwhcJnmpkkGXQJ+aV0m2ALh+Vkcauy6lB/pQEVW6J4wc4
X-Gm-Message-State: AOJu0YyT7Om0DOREI424le8gf4qG16zNo4KzFOr4b9viIwNx17JOEN3P
	fdTHjmZy6A2M75+s1MSMGVzQeslTXxXSfsYGA/cSLSfZodOrHOBS97OvxGvV1RRhspHY9QBrGUJ
	RqYQcdmwIRHrVEDM7MLtroWTV4B/P4osggqUNl9YKzhFJfsybc5E2sy4=
X-Google-Smtp-Source: AGHT+IHmv9nlouaa0u3iULM3eph9laKgE1/KdbD59mWRLhP2TzJLbWTINDeubaF8oyyI5/ao0+p6j5RYHF6CcC8vdQQIUXxcz2xU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8715:b0:48a:37e1:a552 with SMTP id
 8926c6da1cb9f-48a37e1a693mr682241173.6.1715991604184; Fri, 17 May 2024
 17:20:04 -0700 (PDT)
Date: Fri, 17 May 2024 17:20:04 -0700
In-Reply-To: <20240517235925.1584-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000015a110618af6ebb@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
From: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in p9_fid_destroy

==================================================================
BUG: KASAN: slab-use-after-free in p9_fid_destroy+0xb5/0xd0 net/9p/client.c:885
Read of size 8 at addr ffff88801d65ea80 by task kworker/u32:10/1148

CPU: 1 PID: 1148 Comm: kworker/u32:10 Not tainted 6.9.0-syzkaller-08284-gea5f6ad9ad96-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events_unbound netfs_write_collection_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 p9_fid_destroy+0xb5/0xd0 net/9p/client.c:885
 p9_client_clunk+0x175/0x190 net/9p/client.c:1461
 p9_fid_put include/net/9p/client.h:282 [inline]
 v9fs_free_request+0xdc/0x110 fs/9p/vfs_addr.c:138
 netfs_free_request+0x22c/0x690 fs/netfs/objects.c:133
 netfs_put_request+0x19b/0x1f0 fs/netfs/objects.c:165
 netfs_write_collection_worker+0x19d0/0x59e0 fs/netfs/write_collect.c:701
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 10976:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 p9_fid_create+0x45/0x470 net/9p/client.c:854
 p9_client_walk+0xc6/0x550 net/9p/client.c:1158
 clone_fid fs/9p/fid.h:23 [inline]
 v9fs_fid_clone fs/9p/fid.h:33 [inline]
 v9fs_file_open+0x5b5/0xae0 fs/9p/vfs_file.c:56
 do_dentry_open+0x8da/0x18c0 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x1dfb/0x2990 fs/namei.c:3807
 do_filp_open+0x1dc/0x430 fs/namei.c:3834
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_creat fs/open.c:1497 [inline]
 __se_sys_creat fs/open.c:1491 [inline]
 __x64_sys_creat+0xcd/0x120 fs/open.c:1491
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5340:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4353 [inline]
 kfree+0x129/0x3a0 mm/slub.c:4463
 p9_client_destroy+0x160/0x4a0 net/9p/client.c:1073
 v9fs_session_close+0x49/0x2d0 fs/9p/v9fs.c:506
 v9fs_kill_super+0x4d/0xa0 fs/9p/vfs_super.c:196
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801d65ea80
 which belongs to the cache kmalloc-96 of size 96
The buggy address is located 0 bytes inside of
 freed 96-byte region [ffff88801d65ea80, ffff88801d65eae0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801d65ef00 pfn:0x1d65e
flags: 0xfff00000000a00(workingset|slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000a00 ffff888015442280 ffffea0000b5d350 ffffea0000890c50
raw: ffff88801d65ef00 000000000020001d 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 5340, tgid 5340 (syz-executor.2), ts 92315884435, free_ts 92313381805
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2353 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2406
 ___slab_alloc+0xd28/0x1810 mm/slub.c:3592
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3682
 __slab_alloc_node mm/slub.c:3735 [inline]
 slab_alloc_node mm/slub.c:3908 [inline]
 __do_kmalloc_node mm/slub.c:4038 [inline]
 __kmalloc+0x3bf/0x440 mm/slub.c:4052
 kmalloc include/linux/slab.h:632 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 tomoyo_encode2+0x100/0x3e0 security/tomoyo/realpath.c:45
 tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x19d/0x720 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x273/0x450 security/tomoyo/file.c:822
 tomoyo_path_unlink+0x92/0xe0 security/tomoyo/tomoyo.c:162
 security_path_unlink+0x100/0x170 security/security.c:1857
 do_unlinkat+0x55b/0x750 fs/namei.c:4404
 __do_sys_unlink fs/namei.c:4455 [inline]
 __se_sys_unlink fs/namei.c:4453 [inline]
 __x64_sys_unlink+0xc7/0x110 fs/namei.c:4453
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
page last free pid 5494 tgid 5493 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:468
 exit_mmap+0x3da/0xb90 mm/mmap.c:3282
 __mmput+0x12a/0x4d0 kernel/fork.c:1346
 mmput+0x62/0x70 kernel/fork.c:1368
 exit_mm kernel/exit.c:569 [inline]
 do_exit+0x999/0x2c10 kernel/exit.c:865
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 get_signal+0x2616/0x2710 kernel/signal.c:2911
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x14a/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801d65e980: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
 ffff88801d65ea00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88801d65ea80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                   ^
 ffff88801d65eb00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88801d65eb80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
==================================================================


Tested on:

commit:         ea5f6ad9 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17d86268980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1cd4092753f97c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c7a495a5e466c031b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15216e04980000


