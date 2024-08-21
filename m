Return-Path: <linux-kernel+bounces-295490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73C6959BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0CEEB24424
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA6816BE03;
	Wed, 21 Aug 2024 12:25:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744BD1E507
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243125; cv=none; b=M/bxQGRJidAf1OBU4sqMnKGjYiDeE4rFSF8B8M7ypC30k0eO3JCsnBqgGeBOE3dlON9IDsS1/qUw357arSWdodcrOZw/mA9ezBttpgPtLs+AX87TOu7cKi9HySO0wRYoXuPqgLHRBqYpyCVfr45fOwZzR9v+cfA3QMq5JyiRSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243125; c=relaxed/simple;
	bh=62NE2uBvg8gB703XCW00PTCAmETfio0UWb2EDl1uY+A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qCU4wZIH81TtQWpiF3eNsIVktyHpesVmYoXwQ1TYinFLHDzwRdeBcf7dh7o+heDuFn7IGfJuWeYq5A3dmLn/yHMAGmKqzbirazfXpTPD3xab+2Z7XuAEZWWECAA+SDJM3N828tuYGkiuZtMORBgo4pQNsN+l+E41R5EJmqHh1AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8c78cc66so638686439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724243122; x=1724847922;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLbYKtFkV4oeZHYwIrXpId+XVEQ2sVfzQoHUctwBh7Q=;
        b=oMze5Hx3pXM9GgZj4UoWGnTcQQhBfBcgxtpi6xazfoh9/2rRevLLyu5LSav/hopmp3
         2KFsZC8FCV7I+ltO4ZlMaMyqtynIPZJ69taiqWbv6ZQNc2+vuoHspyESfwJsUqWCmVOz
         GBVr/s4u6tIXGS5IRDLWtgHwGR7VLX4gbQ9c55AnNb+yWMFoN5F22SbOeh04JzEUrYvw
         8WxJf9M0JEDveI6EvHmF6YPT06JUngdH1eP/ORTqUU65efgkOlcn/o2w8O4uSZ/B8hA8
         QJfZFty/4HR3URv6XldV/8Xe0ra3V/4AD0bYwy++c5+1bh1q6VW/qj/5y4Uof6zZyRVq
         2Zvw==
X-Forwarded-Encrypted: i=1; AJvYcCU7i+dFWsTxubDfgU67vNAMo77aOn0ns4DaxehuUOahS4QO8v2nCQitjUsauVAjIdVUvKJHZC9N+XhwDyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60Be+THqa4hH5gEC9FVCSyke7VgCB2CpaPYsGSWIrIp/ANYKc
	aIEE6XBQci6EwsYEUaX27VVnsl2NQ2x75euoLl89e7b4/t9Ruk7aPUjxeWlAP5URcg/EfTYTMr4
	0OS7fcyptD+v1yIPANggdR7kDlbG+chh0+Tu+gJfT27k2RXGJmPpxRW0=
X-Google-Smtp-Source: AGHT+IGLNa0D9ZET1dX6ycc/azDFIEZTeNt086GQxFnvZYexA/XCt5T/fs7cH59rlOP6GVV6mnsoci4SgDFaR9IGgl/Lds33a45U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24c4:b0:4b7:ca39:5869 with SMTP id
 8926c6da1cb9f-4ce630e4befmr75593173.6.1724243122481; Wed, 21 Aug 2024
 05:25:22 -0700 (PDT)
Date: Wed, 21 Aug 2024 05:25:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d27fe1062030a2b5@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in __reset_isolation_suitable /
 compact_zone (2)
From: syzbot <syzbot+6e54fc669e2c440731fd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b311c1b497e5 Merge tag '6.11-rc4-server-fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140ca7c5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3aa0f597417bf8c7
dashboard link: https://syzkaller.appspot.com/bug?extid=6e54fc669e2c440731fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/806c87e93e26/disk-b311c1b4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/73951ff34e6d/vmlinux-b311c1b4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f4b7546a486d/bzImage-b311c1b4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e54fc669e2c440731fd@syzkaller.appspotmail.com

EXT4-fs (loop2): stripe (7) is not aligned with cluster size (16), stripe is disabled
EXT4-fs (loop2): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: none.
==================================================================
BUG: KCSAN: data-race in __reset_isolation_suitable / compact_zone

write to 0xffff88823fffab90 of 8 bytes by task 77 on cpu 0:
 __reset_isolation_suitable+0x149/0x2b0 mm/compaction.c:438
 reset_isolation_suitable+0xb2/0x100 mm/compaction.c:469
 kswapd_try_to_sleep mm/vmscan.c:7084 [inline]
 kswapd+0x296/0x1820 mm/vmscan.c:7193
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

write to 0xffff88823fffab90 of 8 bytes by task 28833 on cpu 1:
 update_cached_migrate mm/compaction.c:504 [inline]
 isolate_migratepages mm/compaction.c:2189 [inline]
 compact_zone+0x1293/0x2930 mm/compaction.c:2641
 compact_zone_order mm/compaction.c:2806 [inline]
 try_to_compact_pages+0x388/0x920 mm/compaction.c:2862
 __alloc_pages_direct_compact+0x6f/0x1e0 mm/page_alloc.c:3650
 __alloc_pages_slowpath+0x236/0xd70 mm/page_alloc.c:4245
 __alloc_pages_noprof+0x26d/0x360 mm/page_alloc.c:4708
 alloc_pages_preferred_many mm/mempolicy.c:2204 [inline]
 alloc_pages_mpol_noprof+0xec/0x1e0 mm/mempolicy.c:2228
 alloc_pages_noprof+0xe1/0x100 mm/mempolicy.c:2343
 vm_area_alloc_pages mm/vmalloc.c:3584 [inline]
 __vmalloc_area_node mm/vmalloc.c:3653 [inline]
 __vmalloc_node_range_noprof+0x736/0xec0 mm/vmalloc.c:3834
 __kvmalloc_node_noprof+0x121/0x170 mm/util.c:675
 ip_set_alloc+0x1f/0x30 net/netfilter/ipset/ip_set_core.c:256
 hash_netiface_create+0x273/0x730 net/netfilter/ipset/ip_set_hash_gen.h:1568
 ip_set_create+0x359/0x8a0 net/netfilter/ipset/ip_set_core.c:1104
 nfnetlink_rcv_msg+0x4a9/0x570 net/netfilter/nfnetlink.c:302
 netlink_rcv_skb+0x12c/0x230 net/netlink/af_netlink.c:2550
 nfnetlink_rcv+0x16c/0x15e0 net/netfilter/nfnetlink.c:667
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x599/0x670 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x5cc/0x6e0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x140/0x180 net/socket.c:745
 ____sys_sendmsg+0x312/0x410 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x1e9/0x280 net/socket.c:2680
 __do_sys_sendmsg net/socket.c:2689 [inline]
 __se_sys_sendmsg net/socket.c:2687 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2687
 x64_sys_call+0x2689/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000196e00 -> 0x0000000000105a00

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 28833 Comm: syz.2.8522 Not tainted 6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================
EXT4-fs (loop2): unmounting filesystem 00000000-0000-0000-0000-000000000000.


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

