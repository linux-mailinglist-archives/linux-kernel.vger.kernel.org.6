Return-Path: <linux-kernel+bounces-264538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 314F693E4AF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A622B20E3A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AC38397;
	Sun, 28 Jul 2024 10:59:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F252374C3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722164366; cv=none; b=TOvs4jjeVSht2N4NsajbGfzRxQWCaGZ8hxMjp+5PFuGghFgdXlsaHgEdrKhWEDDmHdt+djfMgtA6KNbtrunn2Tsy8xe5rEzUH4c7LN+TwE1gnCEC18e6AnQT/ILJH0KKtWJT8zZpvlemlB/cakSnHpEVaJtW8gcFjnDXX1Mw6ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722164366; c=relaxed/simple;
	bh=L5n/teUly+VhlDIHgY8NFPwJerFVZTdMhj6Y+8ATqO0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fEFU7rwUnPdHmSzjO7z5mp4aCrhixClANpTj52cQ8Fcrw1LAUrwFEUVA5eJieSfhXOfS+bTBm75NcXG2JmfFINmKnXig1R4GiD6r+LHuQc2RKZrR5ea8Ql35Mh5R36hIEd/JjQEXU7928W6YWQ+ma7nOWj8+mx7kZ/QW2Rdssg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f8c78cc66so368821239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 03:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722164364; x=1722769164;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eO5R0suCgYtLIjc7tDRTV2e1d+A0wsuCRHJAT80Iy9k=;
        b=Px0j9TC4mPuw9o0NsL/1juevayR9NGN8TA0x7g6Z0Qqj9YzPzyduLWc2QEAZeHp3AM
         3TgPqcgAHQY4xo7Khg7lX4km0oNKV/BWjBNxpF5rdPTORTYc2QCvexInjM9VjgeOPA8G
         kbJKXsZrU7UhECieaAmd08qB3uzRZf6KxS9vaMGSPAM7u8JDSsR19G/1J+FQzAaBLDE5
         2vZY3wVqSzrw1HEL3UG0/7qOreMhvhgZRqdN+Dt7LFdXtChaZ217DZel7UK3PqfSrXsM
         SyJyLyGIBte2GKDciFrnp14pQfQ1V+LLGt9pODzG81fikWYDcWjt652wkjrTuDOz2NGn
         +r7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQwUWd4BMt1awWuxwBovXdn0nNOh57XSAimLn4PuGw3eEeavCx6hbd+PVqIwmLvMvu7VMbeo9oNksRR3A/6o9/K5W7C5cFvVPXzCm1
X-Gm-Message-State: AOJu0YwEzpLAubypeTux7UT2NWxgdJNSX8bQ27M8BI7F1hPkeWvGOwmB
	6Ga9E+uHG3igJH9ZzF0ea6C1NLgLNSF36VGUEolylKRxwDcquToLKarMm0ryKF2brKmkcvwhoCw
	ZYTciY1CGgF8jVyjWN5yJ3IqrWMFxGSoArsTdmWd8xr2iqdx4xaN9rFc=
X-Google-Smtp-Source: AGHT+IG0y/n1OBmMV/Drhh6iWdVJYOIiShAoLM//doOnvqeGCesvssXf3CpnV0ObDHEmUwJm2MfHqZcgS/pBgYGDdEVvHAi96RN4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a6:b0:4c0:a8a5:81f5 with SMTP id
 8926c6da1cb9f-4c64629a61cmr216886173.4.1722164364441; Sun, 28 Jul 2024
 03:59:24 -0700 (PDT)
Date: Sun, 28 Jul 2024 03:59:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000300fca061e4ca372@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in compact_zone / isolate_migratepages_block
 (4)
From: syzbot <syzbot+763baa6ce76de5853e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f8c4f506285 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b56f19980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7398409c79c30d03
dashboard link: https://syzkaller.appspot.com/bug?extid=763baa6ce76de5853e63
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6165da49b7f1/disk-2f8c4f50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74fed2ebd154/vmlinux-2f8c4f50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/32a1190d3a94/bzImage-2f8c4f50.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+763baa6ce76de5853e63@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in compact_zone / isolate_migratepages_block

read to 0xffff88823fffab98 of 8 bytes by task 32 on cpu 0:
 update_cached_migrate mm/compaction.c:506 [inline]
 isolate_migratepages_block+0x24e7/0x2740 mm/compaction.c:1358
 isolate_migratepages mm/compaction.c:2194 [inline]
 compact_zone+0x1e1e/0x2930 mm/compaction.c:2641
 kcompactd_do_work mm/compaction.c:3112 [inline]
 kcompactd+0x4e0/0xd40 mm/compaction.c:3211
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

write to 0xffff88823fffab98 of 8 bytes by task 15939 on cpu 1:
 compact_zone+0x23a6/0x2930 mm/compaction.c:2649
 compact_zone_order mm/compaction.c:2806 [inline]
 try_to_compact_pages+0x388/0x920 mm/compaction.c:2862
 __alloc_pages_direct_compact+0x6f/0x1e0 mm/page_alloc.c:3651
 __alloc_pages_slowpath+0x236/0xd70 mm/page_alloc.c:4246
 __alloc_pages_noprof+0x26d/0x360 mm/page_alloc.c:4709
 alloc_pages_mpol_noprof+0xb1/0x1e0 mm/mempolicy.c:2263
 alloc_pages_noprof+0xe1/0x100 mm/mempolicy.c:2343
 vm_area_alloc_pages mm/vmalloc.c:3584 [inline]
 __vmalloc_area_node mm/vmalloc.c:3660 [inline]
 __vmalloc_node_range_noprof+0x719/0xef0 mm/vmalloc.c:3841
 __kvmalloc_node_noprof+0x121/0x170 mm/util.c:675
 ip_set_alloc+0x1f/0x30 net/netfilter/ipset/ip_set_core.c:256
 hash_netiface_create+0x273/0x730 net/netfilter/ipset/ip_set_hash_gen.h:1568
 ip_set_create+0x359/0x8a0 net/netfilter/ipset/ip_set_core.c:1104
 nfnetlink_rcv_msg+0x4a9/0x570 net/netfilter/nfnetlink.c:302
 netlink_rcv_skb+0x12c/0x230 net/netlink/af_netlink.c:2550
 nfnetlink_rcv+0x16c/0x15b0 net/netfilter/nfnetlink.c:664
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x593/0x670 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x5cc/0x6e0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x140/0x180 net/socket.c:745
 ____sys_sendmsg+0x312/0x410 net/socket.c:2597
 ___sys_sendmsg net/socket.c:2651 [inline]
 __sys_sendmsg+0x1e9/0x280 net/socket.c:2680
 __do_sys_sendmsg net/socket.c:2689 [inline]
 __se_sys_sendmsg net/socket.c:2687 [inline]
 __x64_sys_sendmsg+0x46/0x50 net/socket.c:2687
 x64_sys_call+0x26f8/0x2e00 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000000001c0c00 -> 0x00000000001c1c00

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 15939 Comm: syz.1.2769 Not tainted 6.10.0-syzkaller-12708-g2f8c4f506285 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
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

