Return-Path: <linux-kernel+bounces-421052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A285E9D8624
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AE216A57C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567641ABED8;
	Mon, 25 Nov 2024 13:16:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19217D378
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540583; cv=none; b=oBvLmVe4jvHycOrBitCrEwFArtkxTbfCkLYsvatrHdETGdxNCMsQlri2rV56flgs2PhLNM1Sesp83LG6XeoosaThDfrICYvnPOgO1Nl2mt5MVS6h3kq9NES5R0+oIl4yqI+nKCrecfDl4hNQAKMFkoPOE3ulltORu1G0LwDvWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540583; c=relaxed/simple;
	bh=kavIXEzJWN3qSz/hndy86H+X+t69Vo5JVaoK0T5JFHQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RiQbw+fxBxmUL36TOg9H3kDhnn6806KWo+uz0HpnEub3CIAHP1Pmi7Yl+hjxX4zQ6UiXVWV4GXv/Wr40am8F1+hE2RKQW8iqGAw3ZfEFZOm23KwYZt09CO20hgTr/Zv2vEMSPIrInK9QeMDTKUr8/YDS5VXWL57dmvnN4bMgytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7ace5dd02so21116505ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732540581; x=1733145381;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wNDQAV8xQIUCDicmJ8kWu95G4znNJEWeqCR59wPFfsE=;
        b=lUgCu6FrBtkJM8OktxckJcUTeDc4nsNqGN8ULjOTwwNZ2GM+ld7uGss+X5MAI6X4rE
         0N3H3fWXoDQC5I/0yGYTC91HNApv6ZM2rO68L/lUpn3npq1l+hjmSiUL2753/sU2mvQ7
         WMaN0QI3D5TxjpPOWQfouGmnJyqqKV50YhirsHCF0EWPHoETGrGEVP0C7b4DFxGcbKYb
         TEmRgXquDyHalirW4KSxJgdqPlbQ5CMiqrfm1mCTRtCMw20PYbyXkl8I0BhxQOwPPxS/
         ffxoT0ENdKqcNVbh1W/ckGwE7D/VqQZW2ofuEeLYpeGbMJ2MtL7Bki3h0mWJQHx3wojD
         4oGA==
X-Forwarded-Encrypted: i=1; AJvYcCX3S/AgKvJU7Mv3V6YGFDonWvo9Qsc/VozV9EZGHtXmgwqi3lLz5b3NeQacdCqbgo24mQxmAnLPOh2mLuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/M1ZeWBs3lJ4R5tA45FwDfWjYUpfSVfnjbFc3aPoJE/JwG8w
	jctv4QxlZYPLUhcZKxnUvCjmbAL6/HN4Jvtxbn9ay2m4pROUIrQIqtpAOLQbvTLOySAK0p76vsH
	Z105S98LvTvC/xtZvxBLxksenWSoGEnvtEHNH8Aw7m4uqGTUbysxx5gA=
X-Google-Smtp-Source: AGHT+IEI/mmtZLarB0hw0sSiT5VKM/p/rF6QXYmnnKiZsY2qPda61fWlU3WJyMNSM0F+LKDZCZxgSRTil0TK0m0jQxfW5xIsvbqo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174b:b0:3a7:ab48:3373 with SMTP id
 e9e14a558f8ab-3a7ab483430mr68394845ab.2.1732540581149; Mon, 25 Nov 2024
 05:16:21 -0800 (PST)
Date: Mon, 25 Nov 2024 05:16:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674478a5.050a0220.1cc393.0080.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sco_sock_connect
From: syzbot <syzbot+489f78df4709ac2bfdd3@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173469c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2406be795e8a5f4
dashboard link: https://syzkaller.appspot.com/bug?extid=489f78df4709ac2bfdd3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=179db6e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/02a2c8cad502/disk-228a1157.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad0cba81ae3f/vmlinux-228a1157.xz
kernel image: https://storage.googleapis.com/syzbot-assets/325bd791039e/bzImage-228a1157.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+489f78df4709ac2bfdd3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __lock_acquire+0x2d90/0x3c40 kernel/locking/lockdep.c:5089
Read of size 8 at addr ffff88802e36fc20 by task syz.4.5353/17208

CPU: 0 UID: 0 PID: 17208 Comm: syz.4.5353 Not tainted 6.12.0-syzkaller-08446-g228a1157fb9f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 __lock_acquire+0x2d90/0x3c40 kernel/locking/lockdep.c:5089
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 sco_chan_add net/bluetooth/sco.c:292 [inline]
 sco_connect net/bluetooth/sco.c:345 [inline]
 sco_sock_connect+0x351/0xbd0 net/bluetooth/sco.c:645
 __sys_connect_file+0x13e/0x1a0 net/socket.c:2055
 __sys_connect+0x14f/0x170 net/socket.c:2074
 __do_sys_connect net/socket.c:2080 [inline]
 __se_sys_connect net/socket.c:2077 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0ec497e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ec5705038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f0ec4b35fa0 RCX: 00007f0ec497e819
RDX: 0000000000000008 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007f0ec49f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0ec4b35fa0 R15: 00007fffedcfae08
 </TASK>

Allocated by task 17048:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:879 [inline]
 kzalloc_noprof include/linux/slab.h:1015 [inline]
 sco_conn_add net/bluetooth/sco.c:199 [inline]
 sco_conn_add+0xc8/0x410 net/bluetooth/sco.c:184
 sco_connect net/bluetooth/sco.c:336 [inline]
 sco_sock_connect+0x325/0xbd0 net/bluetooth/sco.c:645
 __sys_connect_file+0x13e/0x1a0 net/socket.c:2055
 __sys_connect+0x14f/0x170 net/socket.c:2074
 __do_sys_connect net/socket.c:2080 [inline]
 __se_sys_connect net/socket.c:2077 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 17208:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x51/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2342 [inline]
 slab_free mm/slub.c:4579 [inline]
 kfree+0x14f/0x4b0 mm/slub.c:4727
 sco_conn_free net/bluetooth/sco.c:97 [inline]
 kref_put include/linux/kref.h:65 [inline]
 sco_conn_put+0x2cd/0x4c0 net/bluetooth/sco.c:107
 sco_conn_add+0x7b/0x410 net/bluetooth/sco.c:195
 sco_connect net/bluetooth/sco.c:336 [inline]
 sco_sock_connect+0x325/0xbd0 net/bluetooth/sco.c:645
 __sys_connect_file+0x13e/0x1a0 net/socket.c:2055
 __sys_connect+0x14f/0x170 net/socket.c:2074
 __do_sys_connect net/socket.c:2080 [inline]
 __se_sys_connect net/socket.c:2077 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2077
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802e36fc00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 32 bytes inside of
 freed 256-byte region [ffff88802e36fc00, ffff88802e36fd00)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2e36e
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801b041b40 ffffea0001f05700 dead000000000003
raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801b041b40 ffffea0001f05700 dead000000000003
head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
head: 00fff00000000001 ffffea0000b8db81 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 8168075657, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0xfce/0x2f80 mm/page_alloc.c:3474
 __alloc_pages_noprof+0x223/0x25a0 mm/page_alloc.c:4751
 alloc_pages_mpol_noprof+0x2c9/0x610 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:2412 [inline]
 allocate_slab mm/slub.c:2578 [inline]
 new_slab+0x2c9/0x410 mm/slub.c:2631
 ___slab_alloc+0xdac/0x1880 mm/slub.c:3818
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_node_noprof+0x357/0x430 mm/slub.c:4270
 __kvmalloc_node_noprof+0xad/0x1a0 mm/util.c:658
 v4l2_ctrl_new+0x99a/0x2090 drivers/media/v4l2-core/v4l2-ctrls-core.c:1931
 v4l2_ctrl_new_std+0x1b3/0x280 drivers/media/v4l2-core/v4l2-ctrls-core.c:2068
 handler_new_ref+0x828/0xc60 drivers/media/v4l2-core/v4l2-ctrls-core.c:1689
 v4l2_ctrl_add_handler drivers/media/v4l2-core/v4l2-ctrls-core.c:2212 [inline]
 v4l2_ctrl_add_handler+0x22a/0x310 drivers/media/v4l2-core/v4l2-ctrls-core.c:2186
 vivid_create_controls+0x2eaf/0x3e00 drivers/media/test-drivers/vivid/vivid-ctrls.c:1993
 vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1931 [inline]
 vivid_probe drivers/media/test-drivers/vivid/vivid-core.c:2093 [inline]
 vivid_probe+0x47df/0xae90 drivers/media/test-drivers/vivid/vivid-core.c:2078
 platform_probe+0xff/0x1f0 drivers/base/platform.c:1404
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802e36fb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802e36fb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802e36fc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88802e36fc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802e36fd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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

