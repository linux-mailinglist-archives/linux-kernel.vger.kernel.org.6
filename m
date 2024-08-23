Return-Path: <linux-kernel+bounces-299168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E7995D12C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3896BB2DD37
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165A0188A26;
	Fri, 23 Aug 2024 15:14:23 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F42B9A2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426062; cv=none; b=Xh/UXybKZivm0dbQRN8bLPCshKTN3gtaAS5abRboKL7S6XWeQImkJw5SoCprLBsYiIqre9QLipiVxaDobiX8EnOT2VUEW1M1XeiWccEPYR4CV+cd4DByTns8P+JvF953sLQdnt/0PxzN9HV+X1QQRiYDyDxgulAgeU+NiZomfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426062; c=relaxed/simple;
	bh=QmDgndZsSwDr05KcTcj6d0p2J99iJcViqheVZsfarEU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L0A2LFdLUpxF+szLgf2SvgA41GMYcIi8uXRNjGQdQjQu2Jl+C0bHbUbN7Rt0phKL1SHF+8IbXncabEoionljXhkcrEA/YrfXxMT0+vNgWvJ37y/4w96BC5Sqy/1yNJQF2HdPbGRdMzfF32W1MunCAu15Mj8vW91jkRVBpjl8TXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8489097eso191436639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426060; x=1725030860;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rxKzXkxemOgRPdCLb9iY1tuRwynQ478jzdwT+unlzoM=;
        b=qvJUGcvz6vkpz7V8Eg8Em9NBmlHxEMT5EzVTUv/wqRxu262ObpQRp2pGZdZyzEOcdm
         bOa5R0KiviA34BDON80y/xXYu5+e5X6GlrUi01klBVQLZBIkqzOt5iGPymB3UmbhA36B
         lOR9gsI9AUoR/Wytec8MlsPdpY/jQfLwNP8jYEE37Q1oODXVkTZAhusqIN//gmlCrAID
         0GdNyliRCxsqWUv1SAfFzRzvAMQtc8BOlpsHwg5zUp2cSDGkb2+RydDamnXIflqJPQLk
         aQidbHF+1YeK2+/xWD9jyFxlLe4FxOGqDlp/AZIA5uohMQh7zWX9PbT7PZrwXCrsmxlv
         QxKA==
X-Forwarded-Encrypted: i=1; AJvYcCXoNYPoqO2VptuIrsodigwctAFYKF3ToBuJipbyo/d55nOxtXEoRnJHH9DOE51CC4vjnr1YP6FWCrm2ZmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaP96zPVCGi5AnGUPbX3QaT2rsYLV4lBpWTO3TaaVpRM+gNce
	YCqDvPx5bRBR7lua8yhM/tcomp0pX091jHCgu0no/DKYowYaYzre4js8v6phCenOwLYevxxHyNe
	cM5J3TphjxcuE+fqFl7BKSVXbD3+t40HKqtmaoBECeYL/daIIIOsrKkE=
X-Google-Smtp-Source: AGHT+IERYQdjrZJ6M0TQuGakEfN/hgwcTwKMH46KbuAWxRSD02Tv/MZadryK+abOTnPb24rgP2hktm85qnoFTArjwDkBLep5b2J0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda8:0:b0:39a:ea86:12f2 with SMTP id
 e9e14a558f8ab-39e3ca2029amr1701735ab.6.1724426059610; Fri, 23 Aug 2024
 08:14:19 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:14:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b98b6a06205b3ade@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in __list_lru_walk_one
From: syzbot <syzbot+f8b084bfed6c751c82e6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb5e56d14912 Merge tag 'platform-drivers-x86-v6.11-2' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=127730f5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=f8b084bfed6c751c82e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4865c2edc74a/disk-eb5e56d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc6cf6281089/vmlinux-eb5e56d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f916447e618/bzImage-eb5e56d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8b084bfed6c751c82e6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __list_lru_walk_one+0x1b7/0x660
Read of size 8 at addr ffff888051336078 by task syz.1.120/6419

CPU: 0 UID: 0 PID: 6419 Comm: syz.1.120 Not tainted 6.11.0-rc2-syzkaller-00011-geb5e56d14912 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __list_lru_walk_one+0x1b7/0x660
 list_lru_walk_one+0xa6/0xe0 mm/list_lru.c:266
 list_lru_shrink_walk include/linux/list_lru.h:228 [inline]
 gfs2_qd_shrink_scan+0x16b/0x360 fs/gfs2/quota.c:182
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:435
 shrink_slab+0x1090/0x14c0 mm/shrinker.c:662
 drop_slab_node mm/vmscan.c:413 [inline]
 drop_slab+0x142/0x280 mm/vmscan.c:431
 drop_caches_sysctl_handler+0xbc/0x160 fs/drop_caches.c:68
 proc_sys_call_handler+0x551/0x8b0 fs/proc/proc_sysctl.c:590
 iter_file_splice_write+0xbd7/0x14e0 fs/splice.c:743
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x11e/0x220 fs/splice.c:1164
 splice_direct_to_actor+0x58e/0xc90 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x28c/0x3e0 fs/splice.c:1233
 do_sendfile+0x56d/0xe20 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1356 [inline]
 __se_sys_sendfile64+0x100/0x1e0 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8ae6f779f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8ae7d43038 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f8ae7105f80 RCX: 00007f8ae6f779f9
RDX: 0000000020002080 RSI: 0000000000000004 RDI: 0000000000000005
RBP: 00007f8ae6fe58ee R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000023b R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8ae7105f80 R15: 00007ffc4aa43f88
 </TASK>

Allocated by task 5305:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4044
 qd_alloc+0x51/0x260 fs/gfs2/quota.c:234
 gfs2_quota_init+0x828/0x1440 fs/gfs2/quota.c:1450
 gfs2_make_fs_rw+0x43f/0x5e0 fs/gfs2/super.c:159
 gfs2_fill_super+0x22d8/0x2500 fs/gfs2/ops_fstype.c:1274
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1329
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5361:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4548
 gfs2_qd_dealloc+0x72/0xf0 fs/gfs2/quota.c:111
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2843
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3106 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3210
 gfs2_quota_sync+0x41b/0x4a0 fs/gfs2/quota.c:1363
 gfs2_sync_fs+0x4d/0xc0 fs/gfs2/super.c:670
 iterate_supers+0xc6/0x190 fs/super.c:934
 ksys_sync+0xdb/0x1c0 fs/sync.c:104
 __do_sys_sync+0xe/0x20 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888051336000
 which belongs to the cache gfs2_quotad of size 272
The buggy address is located 120 bytes inside of
 freed 272-byte region [ffff888051336000, ffff888051336110)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888051336000 pfn:0x51336
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff88801bf563c0 dead000000000122 0000000000000000
raw: ffff888051336000 00000000800c000b 00000001fdffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x152c50(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL|__GFP_RECLAIMABLE), pid 5305, tgid 5304 (syz.1.7), ts 65296754591, free_ts 14043255001
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3442
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4700
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4044
 qd_alloc+0x51/0x260 fs/gfs2/quota.c:234
 gfs2_quota_init+0x828/0x1440 fs/gfs2/quota.c:1450
 gfs2_make_fs_rw+0x43f/0x5e0 fs/gfs2/super.c:159
 gfs2_fill_super+0x22d8/0x2500 fs/gfs2/ops_fstype.c:1274
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1329
 vfs_get_tree+0x90/0x2a0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2612
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6673
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x248/0x880 init/main.c:1267
 do_initcall_level+0x157/0x210 init/main.c:1329
 do_initcalls+0x3f/0x80 init/main.c:1345
 kernel_init_freeable+0x435/0x5d0 init/main.c:1578
 kernel_init+0x1d/0x2b0 init/main.c:1467
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Memory state around the buggy address:
 ffff888051335f00: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
 ffff888051335f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888051336000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                ^
 ffff888051336080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888051336100: fb fb fc fc fc fc fc fc fc fc 00 00 00 00 00 00
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

