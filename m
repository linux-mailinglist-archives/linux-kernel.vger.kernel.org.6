Return-Path: <linux-kernel+bounces-261903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BA793BDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883011F2370D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EE3172BBA;
	Thu, 25 Jul 2024 08:04:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09921171678
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894645; cv=none; b=TgdV/Na9x1AbZTZiUZmgZT0YtcRNsbUZGZBDaV2GD/8X9mazrmXXs8rfTxufbiCt0GNkgoeJsa8DAfSBbXfnXgDqKx6DM5OB9oNHmF2OGqggdwqWbvn1CWTsAHW1DmlwR0WgREkP31QHXBTP4STo6Dx0eMWDlyu/ersZlVO6G/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894645; c=relaxed/simple;
	bh=avJ0HMlX2d6sR+xq1VaBBZdYzC3dd4RPs6+9uWCwTQ0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cpZvXwvzD2/zpW0uL0ol4zWpsSuMzw06kj5mcP+WafkDlFRMJRD/KpYKqX0rB97doiSIpFtdJw9Tb7R6U2keeywlY5cWG7kHDzKJHktsEA2nt7pMZcGWNeYlIj0HpR6y7999VgJbY86qLo8uARxWiD0n46Jc4/yItQrdNzyZYv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-397e0efded3so5706375ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894643; x=1722499443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nRYty1QtwKSdldCFJFsqzhUx+p+ct+QM2yeR6kwcmU=;
        b=XEwdtVEdaR8fhsCX+I/qAPGHaf7RRY1SqqPEpuDKhwvhiou/gTbd213kBz72IpkFj4
         nQ0/6KzxgSgrw9Zyoc1M/lKo4UhOG3hPY1ESFihIDRju5REczJBsDe0DyrMO0zIJ6rtd
         QwmNo7FrSY4CFbUItv8/Tz9+UJj3vkBx5YgTYU2sdpWi8fXZP9RrrSprKYaMENroLaE+
         zyh0rkIIV0BY/ZtUHpLnxzFpCHOqtgpehJUWl3QVGd1VsEU6LZBioiY/ntiqr90xkzL8
         uRlKsA0BBCyvcqHiuCvtwm4gfpIvHHRACNs6ZDxFWNmgCqFuvVIjU6QxrUstFqCB0xjR
         XUSw==
X-Gm-Message-State: AOJu0Yy5EDfqdA4AtivhCtlLxuT347lGmfNJfiLFc1PLv4Y97s7BOA7k
	v96/LyWpPSvsb91wcTdke0QK6OgzBgqreCam8MAV8fHnfJykzIC/T+i8BoviXa/34yrBCMRovDl
	nTZPU6ZVsuQyURC1pbAAlDPt5xZzlfQr3xQTN0tZ/biYEpfnAt2fqZ2I=
X-Google-Smtp-Source: AGHT+IHkeozuPVzOhLA+IQ1aR64brONeYNXiu+YXcW7IYw1w6LxZnFW7Vn9DDn3OqZ+9Dkxt3JA+iH0a8N/V4vZraN+tDJ54lupv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d94:b0:375:dad7:a664 with SMTP id
 e9e14a558f8ab-39a2403fd4cmr815495ab.6.1721894643145; Thu, 25 Jul 2024
 01:04:03 -0700 (PDT)
Date: Thu, 25 Jul 2024 01:04:03 -0700
In-Reply-To: <20240725072746.503703-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008bae8d061e0dd61a@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
From: syzbot <syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in f2fs_stop_gc_thread

F2FS-fs (loop3): Stopped filesystem due to reason: 0
==================================================================
BUG: KASAN: slab-use-after-free in f2fs_stop_gc_thread+0x6b/0xd0 fs/f2fs/gc.c:212
Read of size 8 at addr ffff888078ea1d00 by task syz.3.57/6875

CPU: 0 PID: 6875 Comm: syz.3.57 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 f2fs_stop_gc_thread+0x6b/0xd0 fs/f2fs/gc.c:212
 f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
 f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
 __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e51975b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e5270f048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f9e51b05f60 RCX: 00007f9e51975b59
RDX: 0000000020000140 RSI: 000000008004587d RDI: 0000000000000005
RBP: 00007f9e519e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9e51b05f60 R15: 00007ffdd9ccdb78
 </TASK>

Allocated by task 6875:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4180
 kmalloc_noprof include/linux/slab.h:681 [inline]
 f2fs_kmalloc fs/f2fs/f2fs.h:3389 [inline]
 f2fs_start_gc_thread+0x1ab/0x570 fs/f2fs/gc.c:177
 f2fs_fill_super+0x7326/0x7be0 fs/f2fs/super.c:4756
 mount_bdev+0x20a/0x2d0 fs/super.c:1668
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1789
 do_new_mount+0x2be/0xb40 fs/namespace.c:3472
 do_mount fs/namespace.c:3812 [inline]
 __do_sys_mount fs/namespace.c:4020 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6918:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2235 [inline]
 slab_free mm/slub.c:4464 [inline]
 kfree+0x149/0x360 mm/slub.c:4585
 f2fs_stop_gc_thread+0xa3/0xd0 fs/f2fs/gc.c:215
 f2fs_do_shutdown+0x192/0x540 fs/f2fs/file.c:2283
 f2fs_ioc_shutdown fs/f2fs/file.c:2325 [inline]
 __f2fs_ioctl+0x443a/0xbe60 fs/f2fs/file.c:4325
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888078ea1d00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 freed 192-byte region [ffff888078ea1d00, ffff888078ea1dc0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x78ea1
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000000 ffff8880150413c0 ffffea00007ed440 dead000000000005
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5198, tgid 5198 (syz-executor), ts 77801127248, free_ts 77710043750
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2304
 allocate_slab+0x5a/0x2f0 mm/slub.c:2467
 new_slab mm/slub.c:2520 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3706
 __slab_alloc+0x58/0xa0 mm/slub.c:3796
 __slab_alloc_node mm/slub.c:3849 [inline]
 slab_alloc_node mm/slub.c:4016 [inline]
 __do_kmalloc_node mm/slub.c:4148 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4161
 kmalloc_noprof include/linux/slab.h:685 [inline]
 kzalloc_noprof include/linux/slab.h:807 [inline]
 new_dir fs/proc/proc_sysctl.c:951 [inline]
 get_subdir fs/proc/proc_sysctl.c:995 [inline]
 sysctl_mkdir_p fs/proc/proc_sysctl.c:1304 [inline]
 __register_sysctl_table+0xca1/0x1550 fs/proc/proc_sysctl.c:1379
 __addrconf_sysctl_register+0x234/0x3a0 net/ipv6/addrconf.c:7216
 addrconf_sysctl_register+0x167/0x1c0 net/ipv6/addrconf.c:7264
 ipv6_add_dev+0xcf6/0x1220 net/ipv6/addrconf.c:456
 addrconf_notify+0x6a7/0x1020 net/ipv6/addrconf.c:3653
 notifier_call_chain+0x19f/0x3e0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 register_netdevice+0x167f/0x1b00 net/core/dev.c:10468
 cfg80211_register_netdevice+0x149/0x2f0 net/wireless/core.c:1442
page last free pid 5198 tgid 5198 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0xd19/0xea0 mm/page_alloc.c:2588
 discard_slab mm/slub.c:2566 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3034
 put_cpu_partial+0x17c/0x250 mm/slub.c:3109
 __slab_free+0x2ea/0x3d0 mm/slub.c:4334
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3979 [inline]
 slab_alloc_node mm/slub.c:4028 [inline]
 kmem_cache_alloc_node_noprof+0x16b/0x320 mm/slub.c:4071
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:664
 netlink_sendmsg+0x638/0xcb0 net/netlink/af_netlink.c:1876
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888078ea1c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888078ea1c80: 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888078ea1d00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888078ea1d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888078ea1e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16c7609d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1545b33d980000


