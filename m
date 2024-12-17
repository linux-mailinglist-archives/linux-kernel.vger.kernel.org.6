Return-Path: <linux-kernel+bounces-449720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742CC9F553B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977F317796C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AA91FA173;
	Tue, 17 Dec 2024 17:47:24 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5A1F9F50
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457643; cv=none; b=EcxpFWeP5Pda0QVbn/nRHTc2SNR/3htrfgJWUNBkq2GFjddYFEq5pBOBL6qDifvpmOZYVIDP5oX00XEGLBZ/kMxYZ+0kUMNg3O+N0SmXsPdyOOdua2Dhwx/xsrLPVfcfuLuINrAL/EppsWzzBgDWRLK/mqxFTsStahn6ZifajMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457643; c=relaxed/simple;
	bh=DuEwT+pqeT48urlVZ93OsEUCZqyVHNL03kd7Y3vjeEc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=skvXgEvVSK2mqGm8BTK8eHENKW9WbY1wbU1Acf2z6D+mPgSHnrGJxfuQkmPkMWPENdCuxfm88wG0k2B7wGtFl8fV2Tg8YdWAkaCGDvYd3VoeU37PYWAiuUueD+prGfmDtDiF1mx9s7orf8eeIczogfxRuxdubDhHwn2jLseOXN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-847500c9b9aso85039539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734457641; x=1735062441;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtOc5d+1cwQNV3R2DrOwuq1gW1hcDvxES9V+07QLwUE=;
        b=u/9CPgBDydIpLY+zN0fTC8lkSE3pPAafYsXs5bWrSKr8wwUCmRbmZ0tpKkb1o7scRX
         18ROHW6fNgaEl61bpVkmfFon3O8AMq9Vbs6fZng21N4dSZTcdoEFk8n7+Pcz26C7SaSL
         pD2mfyPciURt3vFPT423wSQhQ9KxNwT/cdYx9qmrmbc4yPnZvn6dYYU0OlS1BLblloGa
         VjQTcXq/UG4VWKkX4BbVqlIz+B6v0sHieT/utA5wne+ehcnRTRLR8wTXAWZ5QpKg+IdZ
         phQto5SJdf+4DUhLFG559RTNuFJ4UhrJY48THqrocB1NphpaEf/AUD95K+DM+vWDAXpY
         9uyg==
X-Forwarded-Encrypted: i=1; AJvYcCU+siEPCjwJp/Ac3SAK+U/G7fLmNQTdMVEpE92Szl5r82YiQUgLM5oNP2OSCtg626wOUtdUyqzYYfPaP6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLoIYWUVaCk9Y/YBx1toaevlfPdhe3jMRIHpJfX5h1GFV5jvEE
	COG3CmDns2Buy9oa2oezwgE816DdEm0Hj6Vc11WcWsC6l0ULyikZmU3mE3wNMjeG600deUfxYYd
	A6OpytTydEOzZ8KjAePDHw8Q+n8dX+/EuqMOzhE1g9KjMQVlBwn9nQe8=
X-Google-Smtp-Source: AGHT+IFVU5Gx1UFqoGHtiUWKPOarBNCw9y7bXYuL5uEVYdaf2K2so40P6YVbrXHvyfNms8QcwdYWeuIsYSxyi/ygd+V17pyNXhYM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f0f:b0:3a7:6e72:fbb3 with SMTP id
 e9e14a558f8ab-3bad27e731fmr46325585ab.4.1734457641112; Tue, 17 Dec 2024
 09:47:21 -0800 (PST)
Date: Tue, 17 Dec 2024 09:47:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6761b929.050a0220.29fcd0.006f.GAE@google.com>
Subject: [syzbot] [afs?] KASAN: slab-out-of-bounds Read in afs_proc_addr_prefs_write
From: syzbot <syzbot+7741f872f3c53385a2e2@syzkaller.appspotmail.com>
To: dhowells@redhat.com, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    243f750a2df0 Merge tag 'gpio-fixes-for-v6.13-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13cddbe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=7741f872f3c53385a2e2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17cddbe8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e79cdf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/939c742e99e7/disk-243f750a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76db565b11d6/vmlinux-243f750a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/822230eb0753/bzImage-243f750a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7741f872f3c53385a2e2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in afs_split_string fs/afs/addr_prefs.c:51 [inline]
BUG: KASAN: slab-out-of-bounds in afs_proc_addr_prefs_write+0x123b/0x14e0 fs/afs/addr_prefs.c:415
Read of size 1 at addr ffff888076ea53dd by task syz-executor402/5834

CPU: 1 UID: 0 PID: 5834 Comm: syz-executor402 Not tainted 6.13.0-rc2-syzkaller-00192-g243f750a2df0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:489
 kasan_report+0xd9/0x110 mm/kasan/report.c:602
 afs_split_string fs/afs/addr_prefs.c:51 [inline]
 afs_proc_addr_prefs_write+0x123b/0x14e0 fs/afs/addr_prefs.c:415
 proc_simple_write+0x114/0x1b0 fs/proc/generic.c:815
 pde_write fs/proc/inode.c:330 [inline]
 proc_reg_write+0x23d/0x330 fs/proc/inode.c:342
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe5403c4a39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc2605a0b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe5403c4a39
RDX: 000000000000001c RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007fe5404375f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5834:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4298 [inline]
 __kmalloc_node_track_caller_noprof+0x21d/0x520 mm/slub.c:4317
 memdup_user_nul+0x2b/0x110 mm/util.c:305
 proc_simple_write+0xc7/0x1b0 fs/proc/generic.c:812
 pde_write fs/proc/inode.c:330 [inline]
 proc_reg_write+0x23d/0x330 fs/proc/inode.c:342
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888076ea53c0
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
 allocated 29-byte region [ffff888076ea53c0, ffff888076ea53dd)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x76ea5
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000000 ffff88801ac41780 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080400040 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5831, tgid 5831 (sshd), ts 85902168535, free_ts 79970460650
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25b0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2269
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab mm/slub.c:2589 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2642
 ___slab_alloc+0xce2/0x1650 mm/slub.c:3830
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3920
 __slab_alloc_node mm/slub.c:3995 [inline]
 slab_alloc_node mm/slub.c:4156 [inline]
 __do_kmalloc_node mm/slub.c:4297 [inline]
 __kmalloc_noprof+0x2de/0x4f0 mm/slub.c:4310
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 tomoyo_encode2+0x100/0x3e0 security/tomoyo/realpath.c:45
 tomoyo_encode security/tomoyo/realpath.c:80 [inline]
 tomoyo_realpath_from_path+0x1a7/0x710 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x276/0x480 security/tomoyo/file.c:822
 security_inode_getattr+0x116/0x290 security/security.c:2372
 vfs_getattr fs/stat.c:243 [inline]
 vfs_fstat+0x4b/0xd0 fs/stat.c:265
 vfs_fstatat+0xbc/0xf0 fs/stat.c:364
 __do_sys_newfstatat+0xa2/0x130 fs/stat.c:530
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
page last free pid 5830 tgid 5830 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
 __folio_put+0x32a/0x450 mm/swap.c:112
 folio_put include/linux/mm.h:1488 [inline]
 put_page+0x21e/0x280 include/linux/mm.h:1560
 anon_pipe_buf_release+0x11a/0x240 fs/pipe.c:128
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x641/0x13f0 fs/pipe.c:344
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0xa4c/0xbe0 fs/read_write.c:565
 ksys_read+0x207/0x250 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888076ea5280: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
 ffff888076ea5300: fa fb fb fb fc fc fc fc 00 00 00 fc fc fc fc fc
>ffff888076ea5380: 00 00 00 fc fc fc fc fc 00 00 00 05 fc fc fc fc
                                                    ^
 ffff888076ea5400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888076ea5480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

