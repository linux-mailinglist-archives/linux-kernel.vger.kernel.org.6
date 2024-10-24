Return-Path: <linux-kernel+bounces-379074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BDF9AD952
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05608B22378
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF161BDDF;
	Thu, 24 Oct 2024 01:33:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCED136A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733586; cv=none; b=bQgh8EMolNdbuQZ9VxERi0eDQesHtmIdZ0BPojCTmgAW03NH0EjDardHmcd4Y5CWNtGUwwcCu8/4ik7Fz4hKy14oe+986mJEFSlv14WJ2wOkB0XdpOLd56bzu+ldAxcEzpiyHqmF3sC7FJ/reuMDyvklGovajKXrEJ22fe7hWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733586; c=relaxed/simple;
	bh=k2cq9X8FcQ3DiSKMowaxFOUMbXDhyCTsmUQ82X2XlKQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ww5SaHhaCUke6vpX7e1QB12Ww4+IMTo4nY2QnDIl/ck9RAlDbw8wNxpHi7/fwB2AUd7xt3vaLcXPWlYBAU3EphKmegJMMnNZyyGMJwn8oECC3FwVCKWYUarGOpanv393jQ6Me40A3Bg75pLXng6POijymZIBwgVwzghDNFGU0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so5760895ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729733583; x=1730338383;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5++g5B98p56VASAziMCXZCIVSreW3nHFT1dGjA6o7Q0=;
        b=HmqbimJaMLCSBjnlpiRI0pUlv13J2VfgZSnl1WtthPIqsC+xfuXRZa2+G9Wby8L/ZT
         qPa2VpdN64cS+Qn6B/m6OQWnnFOl8Tg1MjDOvVCEZBYnsHBiRwa8+RSCPCt1yak+2Ktu
         LvYP/96IfXy/nMrrFt822jynfDfJ2coDBkUos219S6aOhcLGePE19AotnR8s7B+G3UhE
         J42uj5yT0zl2dPnlkUMNBsDZ6dwdFPD1TwMI9H79NUoHpfA5znQNB7XqEhmpj5q6IWMj
         sJzF0eHe/4acPQZ3zcVk90vufjP7KmuJ6fcxqDOakWvaX0DfHqOUHgCTrbdmpbfVZDt9
         v2tw==
X-Gm-Message-State: AOJu0YzLf8ntiVAfC5rBJJz5IGUExFGdqpUb+rg6psLPO6TRYm5nirm2
	wKcbT8w4YVIE8R+kuH2852jVkjamw3pBV4ozeM3rrW4FZjoOmlYxL+pKEVLGiomMB/wdg3Eclh8
	2CyJ1jPXP6uD7ouHReC2Ny6fZJfMG3k4BqUD2TRIRsXBpI4oL2PUtEdA=
X-Google-Smtp-Source: AGHT+IEz5/xnCeigehBV6mIieOx4ON4U+OXozxeZEbHMaSpjCBlLWcSkEjHBB55CD3hP77z7qA4K+TyhtgAHQyaUswo08gPZ83zo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188f:b0:3a0:9244:191d with SMTP id
 e9e14a558f8ab-3a4de8183d8mr3503295ab.16.1729733583118; Wed, 23 Oct 2024
 18:33:03 -0700 (PDT)
Date: Wed, 23 Oct 2024 18:33:03 -0700
In-Reply-To: <20241024011358.918019-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6719a3cf.050a0220.1e4b4d.0099.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_reconstruct_alloc
From: syzbot <syzbot+9fc4dac4775d07bcfe34@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in bch2_reconstruct_alloc

bcachefs (loop0): starting version 1.7: mi_btree_bitmap opts=metadata_checksum=none,data_checksum=xxhash,str_hash=crc32c,nojournal_transaction_names,reconstruct_alloc,version_upgrade=none
bcachefs (loop0): recovering from clean shutdown, journal seq 8
bcachefs (loop0): dropping and reconstructing all alloc info
==================================================================
BUG: KASAN: slab-use-after-free in bch2_reconstruct_alloc+0x2aa/0xab0 fs/bcachefs/recovery.c:99
Read of size 8 at addr ffff88802912cf58 by task syz.0.15/6007

CPU: 1 UID: 0 PID: 6007 Comm: syz.0.15 Not tainted 6.12.0-rc4-syzkaller-gc2ee9f594da8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 bch2_reconstruct_alloc+0x2aa/0xab0 fs/bcachefs/recovery.c:99
 bch2_fs_recovery+0x12dd/0x39c0 fs/bcachefs/recovery.c:812
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2174
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8421f7f79a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8422d09e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f8422d09ef0 RCX: 00007f8421f7f79a
RDX: 0000000020005b00 RSI: 0000000020005b40 RDI: 00007f8422d09eb0
RBP: 0000000020005b00 R08: 00007f8422d09ef0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020005b40
R13: 00007f8422d09eb0 R14: 0000000000005b2d R15: 00000000200003c0
 </TASK>

Allocated by task 6007:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_node_track_caller_noprof+0x225/0x440 mm/slub.c:4283
 __do_krealloc mm/slab_common.c:1220 [inline]
 krealloc_noprof+0x88/0x120 mm/slab_common.c:1269
 bch2_sb_realloc+0x2d2/0x660 fs/bcachefs/super-io.c:189
 __copy_super+0x5dc/0xe70 fs/bcachefs/super-io.c:586
 bch2_sb_to_fs+0xab/0x150 fs/bcachefs/super-io.c:613
 bch2_fs_alloc fs/bcachefs/super.c:827 [inline]
 bch2_fs_open+0x1693/0x2f80 fs/bcachefs/super.c:2064
 bch2_fs_get_tree+0x738/0x1710 fs/bcachefs/fs.c:2161
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6007:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x1a0/0x440 mm/slub.c:4727
 krealloc_noprof+0xec/0x120
 bch2_sb_realloc+0x2d2/0x660 fs/bcachefs/super-io.c:189
 bch2_sb_field_resize_id+0x140/0x7c0 fs/bcachefs/super-io.c:221
 bch2_sb_counters_from_cpu+0xac/0x300 fs/bcachefs/sb-counters.c:67
 bch2_write_super+0xe80/0x3c50 fs/bcachefs/super-io.c:976
 bch2_reconstruct_alloc+0x291/0xab0 fs/bcachefs/recovery.c:97
 bch2_fs_recovery+0x12dd/0x39c0 fs/bcachefs/recovery.c:812
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2174
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802912c000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 3928 bytes inside of
 freed 4096-byte region [ffff88802912c000, ffff88802912d000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29128
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac42140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac42140 dead000000000100 dead000000000122
head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000a44a01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4894, tgid 4894 (sh), ts 27374338740, free_ts 27344707881
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1545 [inline]
 get_page_from_freelist+0x3045/0x3190 mm/page_alloc.c:3457
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4733
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x120 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_realpath_nofollow+0xba/0x100 security/tomoyo/realpath.c:304
 tomoyo_find_next_domain+0x27c/0x1d40 security/tomoyo/domain.c:726
 tomoyo_bprm_check_security+0x114/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x86/0x250 security/security.c:1297
 search_binary_handler fs/exec.c:1740 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0xa56/0x1770 fs/exec.c:1845
 do_execveat_common+0x55f/0x6f0 fs/exec.c:1952
page last free pid 4893 tgid 4893 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1108 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x1a6/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 tomoyo_init_log+0x1b3d/0x2050 security/tomoyo/audit.c:275
 tomoyo_supervisor+0x38a/0x11f0 security/tomoyo/common.c:2089
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x178/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x146e/0x1d40 security/tomoyo/domain.c:881
 tomoyo_bprm_check_security+0x114/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x86/0x250 security/security.c:1297
 search_binary_handler fs/exec.c:1740 [inline]
 exec_binprm fs/exec.c:1794 [inline]
 bprm_execve+0xa56/0x1770 fs/exec.c:1845
 do_execveat_common+0x55f/0x6f0 fs/exec.c:1952

Memory state around the buggy address:
 ffff88802912ce00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802912ce80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802912cf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88802912cf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802912d000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=160dcc30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=9fc4dac4775d07bcfe34
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e5cc30580000


