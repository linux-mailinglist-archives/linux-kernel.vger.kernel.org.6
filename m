Return-Path: <linux-kernel+bounces-313990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A469596AD5A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B30B242FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8181FA5;
	Wed,  4 Sep 2024 00:31:21 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0563D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725409881; cv=none; b=ObBXUcYxccUVM/1+wMyeHmKU0oOABsrOzkIPfqHZeigXu8UWO8wep7Pq8Si+/gYhSd0U+WvC/QMqNETmA8xB4aI8f0JuwNKiCSs1RkOu+bp8eEhRyOXvm/UcYIH3O3fn/PZ+WnvcvdyUtocNXaJeFzXC/DblvffUaghU77/RDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725409881; c=relaxed/simple;
	bh=ccBXDt6NYaawBBGtD40XA9t1Z0NG5l1z+dqjk6jm07Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JLUYS4/hc3Wzn+6/8f4At/lvv0+2oZUk8Pbr+x5bJJvS5NPI6SzaSgVsh3ZmtzArh/Alu16SCFkEARwPymFOYmSqygOspSeSTpCGc9wsXOWTmsYkteHrwPzliN0lu/1gpuedJfXR/GliRK2dl6Q3JOUnLf6/q+JPWfIsTr//0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a319f6520so529409139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 17:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725409879; x=1726014679;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1o6x1v0X+1E9lOvO+AYCFUPV933q7Ar9OwxaSXMRMfo=;
        b=bS9/1V3QMP0OsZ1TI67lw4Rid273a7RrPEfU8DheJDJAXLZeWI0EGR7IbfkhAhyXVt
         8yGUfPU1QyGtipoNDrAs5EK8SC5ha56NBfp9fZyIR4EMcQD7VDTY4H0FDO/jlb25LQTT
         tWv5XT8T1z2NW167x61NH4fkw3O4RS4tx3IZnNkH/tsunXSojhcfPxqDRzZ+qZLipplM
         /4RC143u6UxVr3kWTZLHE2/MTGN9E5QuTSfkzv2SaKMUNRATbO9ZzpgvQ7TfFpKt7WKR
         Zp1CkdmaQFL0WD2hfrA3mMcslH+xQ0klOmH5fmcA6AwS2/S1wmDJhfjyOqoknkRvOhp6
         ZE6w==
X-Forwarded-Encrypted: i=1; AJvYcCXu6tElx+KnCTzHbBwrurCtwOXn3aSRqXqVjjLKr37siCxCb+1gDlMDro0aoCh1rKjB82DpfHt34c3Zmek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXrMOrtY6Y9sdz+KP6150Afmg3duTHMpCWFC78/w5sTyOraga
	Krm5mUNDAISKI1Did0/agYFCp3Hu4Akb/83Rv3cB9yBWfSy38bFPzX1lj9XAhmy+K68S8JWHfYu
	nKyIIF3azIscA8sxWYL8UMhkzhlpzrT05NVO1tu4QQH4yJvK1jy2QcBs=
X-Google-Smtp-Source: AGHT+IF3h5faMd0UuR0Ztf2oOSj2Fk54Pv4Fx0dSWFEjmloQypqCeIYIwAfd0ocftorh0mSDdpgYPIR7cFtkV35x1OyHaeW2JR2O
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6413:b0:81f:8991:3efe with SMTP id
 ca18e2360f4ac-82a26107c4emr35584839f.0.1725409878762; Tue, 03 Sep 2024
 17:31:18 -0700 (PDT)
Date: Tue, 03 Sep 2024 17:31:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea79f70621404a85@google.com>
Subject: [syzbot] [mm?] kernel BUG in z3fold_page_migrate
From: syzbot <syzbot+63f9ce7427394b75d9a3@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linmiaohe@huawei.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vitaly.wool@konsulko.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    67784a74e258 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154608ab980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=63f9ce7427394b75d9a3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-67784a74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2f2583cf0b1/vmlinux-67784a74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0fedd864addd/bzImage-67784a74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+63f9ce7427394b75d9a3@syzkaller.appspotmail.com

page: refcount:2 mapcount:0 mapping:0000000000000000 index:0xffff888011926000 pfn:0x11926
flags: 0xfff00000020001(locked|reclaim|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000020001 ffffc900004ef2d0 ffffc900004ef2d0 ffffffff8c183462
raw: ffff888011926000 0000000000000000 00000002ffffffff 0000000000000000
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12800(GFP_NOWAIT|__GFP_NORETRY), pid 78, tgid 78 (kswapd0), ts 84235425402, free_ts 84049906072
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3439
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4695
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 z3fold_alloc mm/z3fold.c:1036 [inline]
 z3fold_zpool_malloc+0x3d1/0xe70 mm/z3fold.c:1388
 zswap_compress+0x4ec/0x7c0 mm/zswap.c:936
 zswap_store+0xcd3/0x1620 mm/zswap.c:1459
 swap_writepage+0x79/0x1a0 mm/page_io.c:198
 pageout mm/vmscan.c:680 [inline]
 shrink_folio_list+0x35fe/0x8c90 mm/vmscan.c:1360
 evict_folios+0x54c7/0x7b60 mm/vmscan.c:4580
 try_to_shrink_lruvec+0x9ab/0xbb0 mm/vmscan.c:4775
 shrink_one+0x3b9/0x850 mm/vmscan.c:4813
 shrink_many mm/vmscan.c:4876 [inline]
 lru_gen_shrink_node mm/vmscan.c:4954 [inline]
 shrink_node+0x3799/0x3de0 mm/vmscan.c:5934
 kswapd_shrink_node mm/vmscan.c:6762 [inline]
 balance_pgdat mm/vmscan.c:6954 [inline]
 kswapd+0x1cbc/0x3720 mm/vmscan.c:7223
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
page last free pid 1037 tgid 1037 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 __slab_free+0x31b/0x3d0 mm/slub.c:4384
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4080
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:664
 alloc_skb include/linux/skbuff.h:1320 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6526
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2815
 sock_alloc_send_skb include/net/sock.h:1778 [inline]
 mld_newpack+0x1c3/0xa90 net/ipv6/mcast.c:1746
 add_grhead net/ipv6/mcast.c:1849 [inline]
 add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1987
 mld_send_initial_cr+0x228/0x4b0 net/ipv6/mcast.c:2233
 ipv6_mc_dad_complete+0x88/0x490 net/ipv6/mcast.c:2244
 addrconf_dad_completed+0x712/0xcd0 net/ipv6/addrconf.c:4340
 addrconf_dad_work+0xdc2/0x16f0
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
------------[ cut here ]------------
kernel BUG at mm/z3fold.c:1293!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 28 Comm: kcompactd0 Not tainted 6.11.0-rc6-syzkaller-00019-g67784a74e258 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:z3fold_page_migrate+0xafd/0xf50 mm/z3fold.c:1293
Code: ff 4c 89 f7 48 c7 c6 00 36 18 8c e8 4d 19 d7 ff 90 0f 0b e8 95 b7 8c ff 48 8b 7c 24 08 48 c7 c6 60 36 18 8c e8 34 19 d7 ff 90 <0f> 0b f3 0f 1e fa 48 89 ee 48 81 e6 ff 0f 00 00 31 ff e8 4c bc 8c
RSP: 0018:ffffc900004eed98 EFLAGS: 00010246
RAX: 8b9348a7cb8a3d00 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8c0ad560 RDI: 0000000000000001
RBP: ffffea00008c8440 R08: ffffffff90186f2f R09: 1ffffffff2030de5
R10: dffffc0000000000 R11: fffffbfff2030de6 R12: dffffc0000000000
R13: ffffffff8c183468 R14: ffffea0000464980 R15: 1ffffd400008c930
FS:  0000000000000000(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f892aeca5b0 CR3: 000000001a952000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 move_to_new_folio+0x99e/0x12e0 mm/migrate.c:999
 migrate_folio_move mm/migrate.c:1288 [inline]
 migrate_pages_batch+0x2527/0x3560 mm/migrate.c:1818
 migrate_pages_sync mm/migrate.c:1911 [inline]
 migrate_pages+0x262b/0x3460 mm/migrate.c:1993
 compact_zone+0x3404/0x4af0 mm/compaction.c:2671
 compact_node+0x2de/0x460 mm/compaction.c:2935
 kcompactd+0x788/0x1530 mm/compaction.c:3233
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:


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

