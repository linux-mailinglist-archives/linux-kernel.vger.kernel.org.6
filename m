Return-Path: <linux-kernel+bounces-426108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5C9DEF08
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 06:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4131639E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 05:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443C413C807;
	Sat, 30 Nov 2024 05:19:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278E029A0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732943945; cv=none; b=aMgB7TjzIC9mm7J1hANighHTA0gQnYNF/pNtwWAgzVSa2oAvDXr+qcRcvQ3bgSdAY1lQ0eGlzUZg2MVaiXak/6YU9S7DZG1NtB8Dmik/y77e9vQlH9boHzjzo2hXyWBPSPdMo+BB4PLDnIQz9I6i31WZqN5mw1UxPY6m0Qlfcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732943945; c=relaxed/simple;
	bh=+m6bBM05dT0Iw8mGd35MyHgf7WJwEHORZT7SlsY35Bc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qD3gqqjsacCvo5iAYFXiSSNBsrvB8KoudSy59M1dATLs0Q8xzf6H9JS2jA5hCo7gXCzmC26duzMBtyISVF8dLWDwH060SRCrhcUctG9F6pi2TJMpIRTa8xcnvU3t6aYuV6cOV+na+HFBNwN6Ajb5wN/cM9Ym7PvuIK1EdAQZ2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e1e6d83fso11300225ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732943943; x=1733548743;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qne5fczYs3bqjKOJMqz4M25AiWY7gQNkEN1rZ2qfOo=;
        b=UfoLF2WWP8I/GHqwsAMjOdg9Os9Ls0yEzfguv4kkyovGzzyRn/PviUy0h4GVhjQWMi
         A9+9kaIx1ult2mXi70kgS4d/aa5WZXQSO5Lmhsancy/N/Xx0t94vD2B11VFqaH2aHh3y
         YAsyuEUtv6ecLtDRwcDjR77ikSMguPJcsHUHuaxGBLTXnuYnc7C1yDkkYCIsOYAU1qYq
         7EdDI81KKwPt6sY8FeOL7wozOcSAmCWSceL6pUIJv9x4PwjF57ZH4fdao0fg/A4inrJv
         F1kj8rpA8Gum396IkIxPBXpii7Agd/GzUMVnNGhpnPV7hF6KRDNVNgIDSSw+pAYzbRWm
         aHgw==
X-Forwarded-Encrypted: i=1; AJvYcCUlmrEM2mDRovyBXmnmJ0IGqJVo0CnpQ/9pohkA5cKT1O1lSmis4kPYjdIqDReAUFc5t+o1/aD1yCl9G7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHafxEkvXDEGO7hyBiyVi4h2/rnZYwR68W+g+oWowIvCen2JEP
	ZKl1579Oh74nzd88evUg0W1mAUf5W9qdkEZmTEtkNyTvzgyiIdlvMkH2rp5qw4Ubz/QOq4JTPZV
	yB0tGmGbla6Roe1dzJtwKKUEoUGKjRfAdAmdg29x8lml4Qxko4EvTs/g=
X-Google-Smtp-Source: AGHT+IEOW6PJn/uKH3OtoTQpXsCAYDfY9+wtipEG71327CHpABAGZ2mExbzs31BXq3ktrkba2mzP8PPxqIJE6CkmuUK2N7y0TrnT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1705:b0:3a7:e0c0:5f27 with SMTP id
 e9e14a558f8ab-3a7e0cfa3bbmr26385565ab.2.1732943943307; Fri, 29 Nov 2024
 21:19:03 -0800 (PST)
Date: Fri, 29 Nov 2024 21:19:03 -0800
In-Reply-To: <tencent_7B89671C3C9D36B6964636904B60744F7709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674aa047.050a0220.253251.00d6.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in ntfs_printk
From: syzbot <syzbot+41821903c04037f57f20@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: stack-out-of-bounds Read in shmem_undo_range

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Inode r=a is not in use!
ntfs3(loop0): Failed to load $UpCase (-116).
==================================================================
BUG: KASAN: stack-out-of-bounds in find_lock_entries+0x97d/0xef0 mm/filemap.c:2128
Read of size 1 at addr ffffc9000e56773f by task syz.0.617/7088

CPU: 0 UID: 0 PID: 7088 Comm: syz.0.617 Not tainted 6.12.0-syzkaller-10299-g4752c39c68ba #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 find_lock_entries+0x97d/0xef0 mm/filemap.c:2128
 shmem_undo_range+0x2c2/0x1cf0 mm/shmem.c:1022
 shmem_truncate_range mm/shmem.c:1152 [inline]
 shmem_evict_inode+0x29b/0xa80 mm/shmem.c:1280
 evict+0x4e8/0x9a0 fs/inode.c:796
 __dentry_kill+0x20d/0x630 fs/dcache.c:625
 dput+0x19f/0x2b0 fs/dcache.c:867
 __fput+0x5ba/0xa50 fs/file_table.c:458
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f93fcd7d4aa
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 13 8c 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 73 8c 02 00 8b 44 24
RSP: 002b:00007f93fdb55e50 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: ffffffffffffffff RCX: 00007f93fcd7d4aa
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000200001
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000074
R13: 00007f93fdb55eb0 R14: 000000000001f74c R15: 000000002001fac0
 </TASK>

The buggy address belongs to stack of task syz.0.617/7088
 and is located at offset 31 in frame:
 shmem_undo_range+0x0/0x1cf0

This frame has 3 objects:
 [32, 288) 'fbatch'
 [352, 600) 'indices'
 [672, 680) 'index'

The buggy address belongs to the virtual mapping at
 [ffffc9000e560000, ffffc9000e569000) created by:
 copy_process+0x5d1/0x3d50 kernel/fork.c:2205

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888040f761e0 pfn:0x40f76
memcg:ffff888038b85182
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff888040f761e0 0000000000000000 00000001ffffffff ffff888038b85182
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 12, tgid 12 (kworker/u4:1), ts 194172788438, free_ts 194171794470
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 vm_area_alloc_pages mm/vmalloc.c:3589 [inline]
 __vmalloc_area_node mm/vmalloc.c:3667 [inline]
 __vmalloc_node_range_noprof+0x9c9/0x1380 mm/vmalloc.c:3844
 alloc_thread_stack_node kernel/fork.c:314 [inline]
 dup_task_struct+0x444/0x8c0 kernel/fork.c:1115
 copy_process+0x5d1/0x3d50 kernel/fork.c:2205
 kernel_clone+0x226/0x8f0 kernel/fork.c:2787
 user_mode_thread+0x132/0x1a0 kernel/fork.c:2865
 call_usermodehelper_exec_sync kernel/umh.c:132 [inline]
 call_usermodehelper_exec_work+0x9b/0x230 kernel/umh.c:163
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page last free pid 7064 tgid 7064 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_folios+0xf37/0x1a20 mm/page_alloc.c:2704
 folios_put_refs+0x76c/0x860 mm/swap.c:962
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x496/0xc40 mm/mmap.c:1680
 __mmput+0x115/0x390 kernel/fork.c:1347
 exit_mm+0x220/0x310 kernel/exit.c:570
 do_exit+0x9b2/0x28e0 kernel/exit.c:925
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 __do_sys_exit_group kernel/exit.c:1098 [inline]
 __se_sys_exit_group kernel/exit.c:1096 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1096
 x64_sys_call+0x26a8/0x26b0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc9000e567600: f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000e567680: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000e567700: 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 00 00 00
                                        ^
 ffffc9000e567780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000e567800: 00 00 00 00 00 00 00 00 f2 f2 f2 f2 f2 f2 f2 f2
==================================================================


Tested on:

commit:         4752c39c ntfs3: debug directly use printk
git tree:       https://github.com/ea1davis/linux ntfs/syz
console output: https://syzkaller.appspot.com/x/log.txt?x=16946d30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f69a9165bb0a019
dashboard link: https://syzkaller.appspot.com/bug?extid=41821903c04037f57f20
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

