Return-Path: <linux-kernel+bounces-415660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989C9D3989
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CA01F21CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D085119C554;
	Wed, 20 Nov 2024 11:33:34 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B6155CA5
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102414; cv=none; b=WFumQIy4yhRrkRK9XclnrquEEeR4WNTjJ5iSsDSP6S7pY5QJff5y1Ex5JCKg/TWp41FpCOYDdO5I6QcMRS96VKgv404w4faeYh2AQ1YI98dU/28ajxezWCJXRxSIpbwpbemt+FD1bRHNvJjUTulz5GbU3hTTL+Ew+UWibnXamaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102414; c=relaxed/simple;
	bh=ucySt0FEwZUSkXs9TbVuPCqASjB4suy/nzsIXnmhvPQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HJYVEVCNpW6/JXbWzNAL6X40cFPQYI/DKcA7N6/nxQWRzgUo6yjP2wacXmU3vzDwhhyeGr/CQqIL7QM1fgvxIQnWhlx6uEY0dLQ6NtMv/pKfeQASFHzN2yjCTm5AQq1mmqWcmcyhcpUbIbvlh7AdtVkpKWegusqE99rXHWYJl2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7191aa79cso58930175ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732102411; x=1732707211;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxaOxrS0Mw86h89ycKNPqA+oezsKe1WwpApk2l+ROGg=;
        b=qIkKjUOfG8H/ivs/Emq+IeJdFVIRJsoP1dOYVZDRYlC78EQZIpr+jX2zkrtChH6DO2
         tkqn9yhmZfaTXfm9MSFBxPvzbdiZpph9P4CjtD1+xaHxLwAWrskQsSLkXbDvPTcT2+ac
         gG2xk5U5hqWJKkt7E/sguyb29XgheA6OIOkN9XossyYMdkiTQAuQ/y+tcyYwWT0mnHCg
         JG8WtBsIlnwJrGyvyYDW/xi00NfGh9Q/c6CBMSVFkKOcZ96rkpb7Ttfbk88AmB7kUfP4
         +8dYxHzv0gnlfXNTtSsSjE4ME9wGVh5vfp78MIKGGKY03H1ecPykzN6WD7TuvGk+1p5a
         6HZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbKEgrD10sBppAt72U1QJm5WRI7rvdHZBc0Zi5i+72L8vGbhEXSsIis3kqjHgFlvkaAfhNYoxKB4oxS4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5K8KMA+FY4O1UX+TRFd6KKHI7vZFxUjo/StyEEXdx/gRJVqH0
	0LP5X7Tw2EfK3lnAaXlf394Mu7we3mN5zYqpyWr/HuYR/VOGq6ZvirMRnbdiag43Lt+p/8eOl4d
	ZieZBbihKSiv2BZi7y9fzoe4jZfM9miHUBCUtNzJYEeB1DLX5zwi21mI=
X-Google-Smtp-Source: AGHT+IFQs1cD0I6gNQ54Zyq6GTqCsU5yynJU3XBZ664uI9rHFCxz0A/iEtqh25lRRWPkzvx6u/USJ049uR0Kh0FVTfENnA4WRcfS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d12:b0:3a7:635e:d365 with SMTP id
 e9e14a558f8ab-3a78643534dmr30682585ab.6.1732102410954; Wed, 20 Nov 2024
 03:33:30 -0800 (PST)
Date: Wed, 20 Nov 2024 03:33:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673dc90a.050a0220.363a1b.000e.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in _xfs_buf_alloc
From: syzbot <syzbot+c39db87bae940bc2459a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f868cd251776 Merge tag 'drm-fixes-2024-11-16' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b63130580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=c39db87bae940bc2459a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f868cd25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b5c59c5802c4/vmlinux-f868cd25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f0ca6449a50/bzImage-f868cd25.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c39db87bae940bc2459a@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 75 at mm/page_alloc.c:4238 __alloc_pages_slowpath+0xfc1/0x1020 mm/page_alloc.c:4238
Modules linked in:
CPU: 0 UID: 0 PID: 75 Comm: kswapd0 Not tainted 6.12.0-rc7-syzkaller-00187-gf868cd251776 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__alloc_pages_slowpath+0xfc1/0x1020 mm/page_alloc.c:4238
Code: 25 c0 d7 03 00 49 83 c7 2c 4c 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0 75 53 41 f6 47 01 08 44 8b 7c 24 2c 0f 84 3a f1 ff ff 90 <0f> 0b 90 e9 31 f1 ff ff 48 8d 8c 24 10 01 00 00 80 e1 07 80 c1 03
RSP: 0018:ffffc90000e3e640 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000001048cd0 RCX: ffffc90000e3e703
RDX: ffffc90000e3e840 RSI: 0000000000000000 RDI: ffffc90000e3e720
RBP: ffffc90000e3e7d0 R08: ffff88805ffd7357 R09: 1ffff1100bffae6a
R10: dffffc0000000000 R11: ffffed100bffae6b R12: 1ffff920001c7ce0
R13: 0000000001048cd0 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555587ae95f8 CR3: 000000003f0fa000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_noprof+0x493/0x710 mm/page_alloc.c:4763
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
 alloc_slab_page+0x6a/0x140 mm/slub.c:2412
 allocate_slab+0x1c0/0x2f0 mm/slub.c:2586
 new_slab mm/slub.c:2631 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
 __slab_alloc+0x58/0xa0 mm/slub.c:3908
 __slab_alloc_node mm/slub.c:3961 [inline]
 slab_alloc_node mm/slub.c:4122 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4141
 _xfs_buf_alloc+0x5d/0xd80 fs/xfs/xfs_buf.c:231
 xfs_buf_find_insert+0xe9/0x1540 fs/xfs/xfs_buf.c:639
 xfs_buf_get_map+0x149c/0x1ae0 fs/xfs/xfs_buf.c:758
 xfs_buf_read_map+0x111/0xa60 fs/xfs/xfs_buf.c:863
 xfs_trans_read_buf_map+0x260/0xad0 fs/xfs/xfs_trans_buf.c:289
 xfs_trans_read_buf fs/xfs/xfs_trans.h:212 [inline]
 xfs_qm_dqflush+0x2ed/0x15e0 fs/xfs/xfs_dquot.c:1267
 xfs_qm_dquot_isolate+0xa89/0x13f0 fs/xfs/xfs_qm.c:465
 __list_lru_walk_one+0x236/0x660 mm/list_lru.c:234
 list_lru_walk_one+0xa6/0xe0 mm/list_lru.c:282
 list_lru_shrink_walk include/linux/list_lru.h:228 [inline]
 xfs_qm_shrink_scan+0x1e1/0x400 fs/xfs/xfs_qm.c:519
 do_shrink_slab+0x701/0x1160 mm/shrinker.c:437
 shrink_slab+0x1093/0x14d0 mm/shrinker.c:664
 shrink_one+0x43b/0x850 mm/vmscan.c:4824
 shrink_many mm/vmscan.c:4885 [inline]
 lru_gen_shrink_node mm/vmscan.c:4963 [inline]
 shrink_node+0x3791/0x3e20 mm/vmscan.c:5943
 kswapd_shrink_node mm/vmscan.c:6771 [inline]
 balance_pgdat mm/vmscan.c:6963 [inline]
 kswapd+0x1ca9/0x3700 mm/vmscan.c:7232
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

