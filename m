Return-Path: <linux-kernel+bounces-418304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA939D6027
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3641F22577
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDB3BBD8;
	Fri, 22 Nov 2024 14:09:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0B79C0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732284564; cv=none; b=QnWkUAOqpgP8ty4DNGoJzfqNnxF3oVoWiw76Rp/lQ9NcaMuQBY7fRJNUrdDZrTLxSRxYbUwgyzTn/phttr1dW0z+D5XkC+7c0JJfMa8AqaM1gzFtI6P/nARp9M6x9MqF57xcpgyeQ6Ip0/Mj6oZSvtIGt/INmWEefeSilflhEGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732284564; c=relaxed/simple;
	bh=KvZjR1XvBhYwh3VAV9HcRk7FJlapHWZRxjmVY2hhE+A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nDoFYGoAK50hI+6S8UouX9yC8NbPRHcjyCoLmD7JlTFWAg3JG+WwHVYFkuUKVFz8gCV0296vP9BEVFTcJZpWuNwYHXaICWTpm2Hnkh/sRQt/Vb3zhGxd/JcoSWfGnpeeeYfiGR6GYqihvLGT4e8D9yLK3rfAItK1DgICxhowZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83acaa1f819so230590539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732284561; x=1732889361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=82hPOnxkeV/pe0+M+cpP3NfthNXjNKOuRlbMZ6KVs0w=;
        b=uiBEqz8rKrWOp9ESGXdhrJPAtlC8gFlkH0kszdBMtasTp34oa+6iEQafwN9YesIPy+
         g/jRCmX5wR1I6+Xv7TdaEPTLPxV5lbMhxdUw5b1cceRSqdxc6Q22z9pDLefOgyLkZ4cV
         APXbE4GmaJnPhp9rSdK7croTkjKYVk4eSdmM4PnguGsZ4MdfuSxEGyFP8RPsZDEyq88Y
         D+AUap2KkIck38avPbXSjF2yORt3/B5ucfamHOcUsrciCNQqMUyhEy6MKkPke1BZXllE
         8rPAm52iWpllRGRvzJO/+cCfVHK5+1R9mr/SoPFwmotQAzAIfHo8XbwioG0DHnPo5HMF
         /GUw==
X-Gm-Message-State: AOJu0Yw2iNepw/cRlXAz72oE082ublqe/9or4BKDoSr2WgIPrYt2I2IY
	5ybJotYH9zxv7mt99jOtQlNcrVvhrxEi6mnZctFI3xLyXsvyDX7lr4SBFA731ZEgl71f6VqG759
	GN8qzCdWIoCIJzm2N96YVgtjAY18mIo9wfXGQ8fX/dIBQQfr1zKgmgdU=
X-Google-Smtp-Source: AGHT+IGqOsYuF7R5voN27/hcipQwWz87AUm1RCAONc4/chMkePq01ZToEGNOl+WRh7ekUHZvj5ae+w5x+P4PTf/P7zHAyrqr3dN4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:3a7:a553:730 with SMTP id
 e9e14a558f8ab-3a7a5530e9amr13810365ab.1.1732284561533; Fri, 22 Nov 2024
 06:09:21 -0800 (PST)
Date: Fri, 22 Nov 2024 06:09:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67409091.050a0220.363a1b.013d.GAE@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in notifier_chain_register
From: syzbot <syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ae58226b89ac Add linux-next specific files for 20241118
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e2f2e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=0988a383ae7c57b99dd9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bac930580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12881ac0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd3d650cd6b6/disk-ae58226b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/89a0fb674130/vmlinux-ae58226b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92120e1c6775/bzImage-ae58226b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0988a383ae7c57b99dd9@syzkaller.appspotmail.com

ubi0: attaching mtd0
ubi0: scanning is finished
==================================================================
BUG: KASAN: slab-use-after-free in notifier_chain_register+0x141/0x3f0 kernel/notifier.c:27
Read of size 4 at addr ffff8880118d18d8 by task syz-executor310/5845

CPU: 1 UID: 0 PID: 5845 Comm: syz-executor310 Not tainted 6.12.0-next-20241118-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:489
 kasan_report+0x143/0x180 mm/kasan/report.c:602
 notifier_chain_register+0x141/0x3f0 kernel/notifier.c:27
 __blocking_notifier_chain_register kernel/notifier.c:264 [inline]
 blocking_notifier_chain_register+0x61/0xc0 kernel/notifier.c:282
 ubi_wl_init+0x3396/0x3720 drivers/mtd/ubi/wl.c:1960
 ubi_attach+0x3e01/0x5b80 drivers/mtd/ubi/attach.c:1605
 ubi_attach_mtd_dev+0x1a3a/0x3540 drivers/mtd/ubi/build.c:1004
 ctrl_cdev_ioctl+0x346/0x570 drivers/mtd/ubi/cdev.c:1043
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7cda2e13b9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7cda26e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7cda362418 RCX: 00007f7cda2e13b9
RDX: 0000000020000502 RSI: 0000000040186f40 RDI: 0000000000000006
RBP: 00007f7cda362410 R08: 00007f7cda26e6c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7cda36241c
R13: 000000000000006e R14: 00007ffcd4486af0 R15: 00007ffcd4486bd8
 </TASK>

Allocated by task 5844:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4314
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 ubi_attach_mtd_dev+0x552/0x3540 drivers/mtd/ubi/build.c:933
 ctrl_cdev_ioctl+0x346/0x570 drivers/mtd/ubi/cdev.c:1043
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5844:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2338 [inline]
 slab_free mm/slub.c:4598 [inline]
 kfree+0x196/0x420 mm/slub.c:4746
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 ubi_attach_mtd_dev+0x8f5/0x3540 drivers/mtd/ubi/build.c:1076
 ctrl_cdev_ioctl+0x346/0x570 drivers/mtd/ubi/cdev.c:1043
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880118d0000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 6360 bytes inside of
 freed 8192-byte region [ffff8880118d0000, ffff8880118d2000)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x118d0
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801ac42280 ffffea0001f5de00 0000000000000006
raw: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
head: 00fff00000000040 ffff88801ac42280 ffffea0001f5de00 0000000000000006
head: 0000000000000000 0000000000020002 00000001f5000000 0000000000000000
head: 00fff00000000003 ffffea0000463401 ffffffffffffffff 0000000000000000
head: ffff888000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5498, tgid 5498 (dhcpcd), ts 46223654103, free_ts 46136578410
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
 prep_new_page mm/page_alloc.c:1564 [inline]
 get_page_from_freelist+0x3725/0x3870 mm/page_alloc.c:3510
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4787
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2408
 allocate_slab+0x5a/0x2f0 mm/slub.c:2574
 new_slab mm/slub.c:2627 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3815
 __slab_alloc+0x58/0xa0 mm/slub.c:3905
 __slab_alloc_node mm/slub.c:3980 [inline]
 slab_alloc_node mm/slub.c:4141 [inline]
 __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4309
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
 tomoyo_init_log+0x11cd/0x2050 security/tomoyo/audit.c:264
 tomoyo_supervisor+0x38a/0x11f0 security/tomoyo/common.c:2089
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x178/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x146e/0x1d40 security/tomoyo/domain.c:881
 tomoyo_bprm_check_security+0x117/0x180 security/tomoyo/tomoyo.c:102
 security_bprm_check+0x86/0x250 security/security.c:1296
 search_binary_handler fs/exec.c:1760 [inline]
 exec_binprm fs/exec.c:1802 [inline]
 bprm_execve+0x894/0x1360 fs/exec.c:1853
page last free pid 5494 tgid 5494 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2693
 discard_slab mm/slub.c:2673 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3142
 put_cpu_partial+0x17c/0x250 mm/slub.c:3217
 __slab_free+0x2ea/0x3d0 mm/slub.c:4468
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4205
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
 netlink_sendmsg+0x638/0xcb0 net/netlink/af_netlink.c:1866
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880118d1780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880118d1800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880118d1880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff8880118d1900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880118d1980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

