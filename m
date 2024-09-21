Return-Path: <linux-kernel+bounces-334786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F99E97DC1C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 10:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12EC2829A7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C922B155316;
	Sat, 21 Sep 2024 08:17:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358B61FCF
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726906643; cv=none; b=nVs4pxUFFtJ1ficWWi2L9AMEGZnb7cbz//JKpYZWJLMsKHfTGcznvTacJjFN2y9EioBvVjv4GWRo+xvQUwyzh0mSihSBot+n4HP5ScUdx4WQVXlmtoBdE4+Ya9B42CWhT9FZQ4btw0pgtBJR2r/1Iy9DZfGaGRaQkwGvSKNNn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726906643; c=relaxed/simple;
	bh=Ij2+LaTsz9HWVZ8d1H+S9Rle+GKyj2smX5eUySMtAFc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DVuSxKvsbwn5zQOJ/Qua0LghvyPBXORRnP4kgaEAOborjRglwIjLlsyynlw1GSppCVUNwEyZHQyMs6Tpx6t0wT4SBBI5Yc3SB3gwj4yoGIEO9afljfSW20WNQeghTUmxI+H9aljR3tQ07xUEDsqRKOoCNRlr48RHEJ9piqrCF58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a045e7ed57so33928855ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 01:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726906640; x=1727511440;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tT7kSHVRwqsMzFv9bXOxppPOKWM1BaAGVrS6kGPpMUs=;
        b=xR3VzRSEDZp/s9SvLXQwt9LziiKQTSvYG79yPmMP/gRjQQlCL9efB0m6lfK1tul4oc
         PMaDDQ+GIpWIj2UcRPbPTWPbjcJ9LStZVjrkdpD+o94OfptrxYlm4W/8SV4/dlKxODwk
         UWbWy6IOg09Dz3Oib0dCzLf/K7WPgoDjlQg2Pfl3sC6g3YYZjri2/JXvpE8OcLc/E9dz
         9bkGj+ESQhLwMWiVTMOCJfLj05JswfRRv4RZeGc5P+3OzJVZXhJ/4ekuJaDWwS7qRdT4
         5GLau/9DGzACHXazEQvFDogo/dsKSPloh474/Tn8+x0fJLMUD1Jnyn3W4SLNfBclXP7e
         FAag==
X-Forwarded-Encrypted: i=1; AJvYcCVZx1Qi3CVTPZwQbN73gPDz0ejzbVtJDjL2XxHuaoVpK1ahfo8vJR550x7JpV7USVYFAHV0EKFutULUdww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zz6K1dc7Q7ifmPUb7Btq2IyhjCc88y7T0KZfPT4NwXUWtdiF
	NqJy3oUJFPzOgB4yQJ4AaEFsXS/PMtD7yRbixoCRu+/biinyrszKVWE8JLG8Pp9sad7RJ/GEhmO
	idOyTReP0wPG5WuVZjnUwePo+b+GyFepkK/C1eUf/QSeYZwM1V5GjwNI=
X-Google-Smtp-Source: AGHT+IErh5nelqRRpC9dgeCBHa6fppNyLQgvaWFrSFV+VQMHPwRH0I29JG+0I/xHiug5RCVyDpSh5wEYV4fMu/7b2Kv9BkyRoM5Y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2f:b0:3a0:5642:c78 with SMTP id
 e9e14a558f8ab-3a0c8cdad80mr56339945ab.15.1726906640426; Sat, 21 Sep 2024
 01:17:20 -0700 (PDT)
Date: Sat, 21 Sep 2024 01:17:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee8110.050a0220.3195df.003e.GAE@google.com>
Subject: [syzbot] [v9fs?] KASAN: use-after-free Read in p9pdu_vwritef
From: syzbot <syzbot+9e324cf5c0846336fefd@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b1d500580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44d46e514184cd24
dashboard link: https://syzkaller.appspot.com/bug?extid=9e324cf5c0846336fefd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-a430d95c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f078f2836d28/vmlinux-a430d95c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/931c08dbcbf4/bzImage-a430d95c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e324cf5c0846336fefd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memcpy_from_iter lib/iov_iter.c:73 [inline]
BUG: KASAN: use-after-free in iterate_folioq include/linux/iov_iter.h:173 [inline]
BUG: KASAN: use-after-free in iterate_and_advance2 include/linux/iov_iter.h:308 [inline]
BUG: KASAN: use-after-free in iterate_and_advance include/linux/iov_iter.h:328 [inline]
BUG: KASAN: use-after-free in __copy_from_iter lib/iov_iter.c:249 [inline]
BUG: KASAN: use-after-free in _copy_from_iter+0xd44/0x1550 lib/iov_iter.c:260
Read of size 16 at addr ffff88801a808000 by task syz.3.1516/11855

CPU: 3 UID: 0 PID: 11855 Comm: syz.3.1516 Not tainted 6.11.0-syzkaller-02574-ga430d95c5efa #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_folioq include/linux/iov_iter.h:173 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:308 [inline]
 iterate_and_advance include/linux/iov_iter.h:328 [inline]
 __copy_from_iter lib/iov_iter.c:249 [inline]
 _copy_from_iter+0xd44/0x1550 lib/iov_iter.c:260
 copy_from_iter include/linux/uio.h:219 [inline]
 copy_from_iter_full include/linux/uio.h:236 [inline]
 pdu_write_u net/9p/protocol.c:234 [inline]
 p9pdu_vwritef+0x2d0/0x1cf0 net/9p/protocol.c:614
 p9_client_prepare_req+0x244/0x4d0 net/9p/client.c:651
 p9_client_rpc+0x1c3/0xc10 net/9p/client.c:691
 p9_client_write+0x31f/0x680 net/9p/client.c:1635
 v9fs_issue_write+0xe2/0x180 fs/9p/vfs_addr.c:59
 netfs_do_issue_write+0x92/0x110 fs/netfs/write_issue.c:223
 netfs_issue_write fs/netfs/write_issue.c:250 [inline]
 netfs_advance_write fs/netfs/write_issue.c:291 [inline]
 netfs_advance_write+0x384/0xbd0 fs/netfs/write_issue.c:259
 netfs_write_folio+0xc44/0x18f0 fs/netfs/write_issue.c:469
 netfs_writepages+0x2ba/0xb90 fs/netfs/write_issue.c:541
 do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
 filemap_fdatawrite_wbc mm/filemap.c:397 [inline]
 filemap_fdatawrite_wbc+0x148/0x1c0 mm/filemap.c:387
 __filemap_fdatawrite_range+0xba/0x100 mm/filemap.c:430
 v9fs_dir_release+0x429/0x590 fs/9p/vfs_dir.c:219
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 get_signal+0x1ca/0x2770 kernel/signal.c:2689
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2cda57def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcf58e21c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 000000000008dda3 RCX: 00007f2cda57def9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f2cda737a80 R08: 0000000000000001 R09: 00007ffcf58e24bf
R10: 00007f2cda400000 R11: 0000000000000246 R12: 000000000008e355
R13: 00007ffcf58e22d0 R14: 0000000000000032 R15: ffffffffffffffff
 </TASK>

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x203ef pfn:0x1a808
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xbfffffff(buddy)
raw: 00fff00000000000 ffffea0000de3e08 ffffea0000df7208 0000000000000000
raw: 00000000000203ef 0000000000000003 00000000bfffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask 0x140dca(GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO), pid 11857, tgid 11853 (syz.0.1515), ts 582079166989, free_ts 582139576036
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4702
 alloc_pages_mpol_noprof+0x275/0x610 mm/mempolicy.c:2263
 folio_alloc_mpol_noprof+0x36/0xd0 mm/mempolicy.c:2281
 vma_alloc_folio_noprof+0xee/0x1b0 mm/mempolicy.c:2312
 folio_prealloc mm/memory.c:1060 [inline]
 wp_page_copy mm/memory.c:3352 [inline]
 do_wp_page+0xfd7/0x3430 mm/memory.c:3744
 handle_pte_fault mm/memory.c:5554 [inline]
 __handle_mm_fault+0x2474/0x5650 mm/memory.c:5681
 handle_mm_fault+0x498/0xa60 mm/memory.c:5849
 do_user_addr_fault+0x7a3/0x13f0 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
page last free pid 11857 tgid 11853 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1101 [inline]
 free_unref_folios+0x9e9/0x1390 mm/page_alloc.c:2667
 folios_put_refs+0x560/0x760 mm/swap.c:1039
 free_pages_and_swap_cache+0x36d/0x510 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages+0xf9/0x290 mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0xe9/0x590 mm/mmu_gather.c:373
 zap_pte_range mm/memory.c:1697 [inline]
 zap_pmd_range mm/memory.c:1736 [inline]
 zap_pud_range mm/memory.c:1765 [inline]
 zap_p4d_range mm/memory.c:1786 [inline]
 unmap_page_range+0x1d20/0x3d30 mm/memory.c:1807
 unmap_single_vma+0x194/0x2b0 mm/memory.c:1853
 unmap_vmas+0x22f/0x490 mm/memory.c:1897
 exit_mmap+0x1b8/0xb20 mm/mmap.c:3412
 __mmput+0x12a/0x480 kernel/fork.c:1345
 mmput+0x62/0x70 kernel/fork.c:1367
 exit_mm kernel/exit.c:571 [inline]
 do_exit+0x9bf/0x2bb0 kernel/exit.c:869
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218

Memory state around the buggy address:
 ffff88801a807f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801a807f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88801a808000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff88801a808080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88801a808100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

