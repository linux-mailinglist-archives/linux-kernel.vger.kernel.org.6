Return-Path: <linux-kernel+bounces-405743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16569C5678
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E9328921F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB19218940;
	Tue, 12 Nov 2024 11:17:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBDD213159
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410225; cv=none; b=P2YyNEPiPeRRmXZ3PPeG1x2MesqL/gyySuX2BA5v+gmwS9k/98faqlDiAKChUMA7F3fz/2/iuDddA2Fztm06umyccVi78/YS4sWErqKjbkODBSE/PJH1PMKAaVwYCS3KoSkHTFmj345iuwxW+oc7P8/1m5LLY06MdqE30nh2HZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410225; c=relaxed/simple;
	bh=vgwYkQrvMCkjSOieB/f11V03B0E6PiCrcEMPeHve3UU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bpaXJDnXkIHGzb4rTDC8ZiNOYcUniwS64/1pzLU61sXXNEqkBRmtmj+blS0ZTNg2J3bepH7MGS/+Q1n+V5A6bSOOQ38M7C7kGhr2qNHhL5Enp2nPUpdMFPdzSyDSfHaoqcmzo4ox2QM3aIPYOiPdy7BBmCXYsJwYAgxo/O5qT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abf723da3so581086839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731410222; x=1732015022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+3CYtXKVfDRB3CibEkyeE2Tw3JqpzccmdaYctxaFj8=;
        b=AvTYw6um3RYMTcwOjpjnKxJFwfivtwWsm/hY0A+B6OxhSKIQ9cVNqO8gFXeoHFeWLv
         PBdBwqpVDBhz0gMMf8pF4nHV+CN6WdDfxgEBS+3O1KhXPJgY8Agy3bOiZhLg6rWd1rC0
         I9PofKXgZF2maQPV3CNc7pg3z1tCZgK3GfvszA5MSiGUchgSd+PIDOBybnL+brYMBrM1
         crZD4ZWIgVPWo/LXZpMyk20NfjpCyNydsu052FPuTz1FPvXwXGfKuH/EKKCgM5NuWJRC
         LDfEQmGpTY40fJeZ34mnqoDIM+DuhQEtEpXf5cmPVnXQA4Xf8GXBrWeKvYZ/AShAmscF
         7OHg==
X-Forwarded-Encrypted: i=1; AJvYcCWPcQ0WXE2BnkH7lvDHJTnJ2iz7UJowPjj0DALrOa+93kztBZvr5wdpB+EfekIusD1kgXgh3UyMKfceu2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqEbRZidmkSrqi18YqF7P3bULwggxBTI5/5xtQWpV6nbT0ogib
	T4Ua86yPy5Co0hrIYaD0VD1kct4RBHOR7lCJ7qDB+pDsFhtCNx+5YUHoQPaEFm4EHT+cFK3QBEf
	5+xhoQpzUp93eqThQTsDpFnwm+I4PeDHZlN45YOw2anHSSciln9C/lzY=
X-Google-Smtp-Source: AGHT+IFxkCYfZVGQwxuSsamMzzA+ORhTt0oUJnzFbGQ4hx6ttJ7mT7u111sYNomMBZ9SCYwZfCYOutzkvm7iHXxbvK+Iy1z3uscg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2165:b0:3a6:ad61:8006 with SMTP id
 e9e14a558f8ab-3a6f1a6ec5amr157739105ab.15.1731410222548; Tue, 12 Nov 2024
 03:17:02 -0800 (PST)
Date: Tue, 12 Nov 2024 03:17:02 -0800
In-Reply-To: <tencent_93E4C66AC993AEC56EFA0CBB27DBC6CFD206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6733392e.050a0220.5d845.0002.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-out-of-bounds Read in
 bitmap_ip_add (2)
From: syzbot <syzbot+58c872f7790a4d2ac951@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in bitmap_ip_add

mnm: 3758096445, firstip: 4294967294, hosts: 1, id: 63, bitmap_ip_uadt
mnm: 3758096446, firstip: 4294967294, hosts: 1, id: 64, bitmap_ip_uadt
==================================================================
BUG: KASAN: slab-out-of-bounds in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-out-of-bounds in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-out-of-bounds in bitmap_ip_do_add net/netfilter/ipset/ip_set_bitmap_ip.c:83 [inline]
BUG: KASAN: slab-out-of-bounds in bitmap_ip_add+0xdf/0x8d0 net/netfilter/ipset/ip_set_bitmap_gen.h:136
Read of size 8 at addr ffff88803af55ea8 by task syz.0.15/5831

CPU: 0 UID: 0 PID: 5831 Comm: syz.0.15 Not tainted 6.12.0-rc7-syzkaller-g2d5404caa8c7-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 bitmap_ip_do_add net/netfilter/ipset/ip_set_bitmap_ip.c:83 [inline]
 bitmap_ip_add+0xdf/0x8d0 net/netfilter/ipset/ip_set_bitmap_gen.h:136
 bitmap_ip_uadt+0x822/0xcd0 net/netfilter/ipset/ip_set_bitmap_ip.c:190
 call_ad+0x279/0xa70 net/netfilter/ipset/ip_set_core.c:1746
 ip_set_ad+0x7e0/0x990 net/netfilter/ipset/ip_set_core.c:1836
 nfnetlink_rcv_msg+0xbec/0x1180 net/netfilter/nfnetlink.c:302
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 nfnetlink_rcv+0x297/0x2ab0 net/netfilter/nfnetlink.c:667
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f788537e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f78860c5038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7885535f80 RCX: 00007f788537e719
RDX: 0000000004000050 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f78853f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f7885535f80 R15: 00007ffed81733b8
 </TASK>

Allocated by task 5831:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:257 [inline]
 __do_kmalloc_node mm/slub.c:4264 [inline]
 __kmalloc_noprof+0x1fc/0x400 mm/slub.c:4276
 init_map_ip net/netfilter/ipset/ip_set_bitmap_ip.c:227 [inline]
 bitmap_ip_create+0x565/0xc00 net/netfilter/ipset/ip_set_bitmap_ip.c:331
 ip_set_create+0xa5c/0x1900 net/netfilter/ipset/ip_set_core.c:1104
 nfnetlink_rcv_msg+0xbec/0x1180 net/netfilter/nfnetlink.c:302
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 nfnetlink_rcv+0x297/0x2ab0 net/netfilter/nfnetlink.c:667
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803af55ea0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 8-byte region [ffff88803af55ea0, ffff88803af55ea8)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3af55
flags: 0x4fff00000000000(node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000000 ffff88801ac41500 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080800080 00000001f5000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5629, tgid 5629 (syz-executor), ts 115225398503, free_ts 115224439532
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1541
 prep_new_page mm/page_alloc.c:1549 [inline]
 get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3459
 __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4735
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x5a/0x2f0 mm/slub.c:2578
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 __do_kmalloc_node mm/slub.c:4263 [inline]
 __kmalloc_noprof+0x25a/0x400 mm/slub.c:4276
 kmalloc_noprof include/linux/slab.h:882 [inline]
 kzalloc_noprof include/linux/slab.h:1014 [inline]
 lsm_blob_alloc security/security.c:685 [inline]
 lsm_superblock_alloc security/security.c:863 [inline]
 security_sb_alloc+0x45/0x320 security/security.c:1404
 alloc_super+0x229/0x9d0 fs/super.c:346
 sget_fc+0x34c/0x9c0 fs/super.c:760
 vfs_get_super fs/super.c:1275 [inline]
 get_tree_nodev+0x2a/0x140 fs/super.c:1299
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
page last free pid 5629 tgid 5629 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1112 [inline]
 free_unref_page+0xcfb/0xf20 mm/page_alloc.c:2642
 __slab_free+0x31b/0x3d0 mm/slub.c:4490
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 getname_flags+0xb7/0x540 fs/namei.c:139
 user_path_at+0x24/0x60 fs/namei.c:3015
 __do_sys_chdir fs/open.c:561 [inline]
 __se_sys_chdir+0xbc/0x220 fs/open.c:555
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803af55d80: 00 fc fc fc 00 fc fc fc fa fc fc fc fa fc fc fc
 ffff88803af55e00: fa fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
>ffff88803af55e80: fa fc fc fc 00 fc fc fc 00 fc fc fc fa fc fc fc
                                  ^
 ffff88803af55f00: fa fc fc fc 00 fc fc fc fa fc fc fc 00 fc fc fc
 ffff88803af55f80: fa fc fc fc fa fc fc fc 05 fc fc fc 00 fc fc fc
==================================================================


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14740ce8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=58c872f7790a4d2ac951
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112378c0580000


