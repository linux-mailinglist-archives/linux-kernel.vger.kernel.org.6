Return-Path: <linux-kernel+bounces-174605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF48C1176
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE271F22941
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69CB535DC;
	Thu,  9 May 2024 14:45:38 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C152C683
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715265938; cv=none; b=VudUPDFMp/r5N0mOL+bP4U/83lfMtrWocIjZUvmYxDztlC9P9hGvKpAJd2YFMrapNt6ShjrvWPcuhbBvMsXBV6L+ZylKptsYAB1XGtgnE3PA3hEZIOTTjIzyi+mBY2V/VBggu0dnmnpxSBJ4QPw6mNjBUSe5W8lILMJawI2ourY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715265938; c=relaxed/simple;
	bh=JwhMMWRxv2ICRacN18crwKf3kkNpdyiF4gIrLKIilNA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kUVebJIuvTt0jvOgeeTQOHY3A2AbIAKm6EjdIL7b+CAmDXHyFHLRiiVeZx1yriMX/f4JqV9Ywh3RRTLaCnbHw3nlyoIasOrL1LbB3UIWlsEz9aKpI3BApUJzlKCVDOY9rNveZqi1oJTrFzjxOo1452qJVIOLH5SNp73F44Oug30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-36c7533ed44so9923685ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 07:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715265936; x=1715870736;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kep4hL9N+kSuqGmJp/04bkNPAaAllEMZIj+lrFOrqGA=;
        b=TJkDdw2S7nYNiRJoDCZtirigzWb7T22CAuFIQA077BreGnIDss3CkJ7MG6z2b5VHH4
         NH9fvVvZdpaOMv0ZA7LnoUgrea/nAz8E796wPY3Sc5g4ZZgb6txQgA97es+/T0KB1WMA
         jURWjznTSDlkZ5dCfkfNY3uDb4YIolkLlWQfA3lNKhvbeozf/sxGILosAXElHAaxn6GA
         QN3o4t4xb8emKAxC5ppJ83ue56Qz3AksAgNT22y2U/rFOzjXslx8k7T1OmIGnN1vENPI
         KxRXuRX0L+X5oVkCrbVSy45xeQOka+ctg24gyLb9RC//hr4OR/KMi229AalDQbhB0FdB
         ZtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWzpIBI7CRvi6UnjUXTFZPCe4p6keMKgvMPhzmiyXrLAxR+hxQlB6YChJblpCa0oxS3HnrnRzB2+Jwb1NW57C8qtsp2KaDtZoIVe5D
X-Gm-Message-State: AOJu0YyRG5PjB3z/CbOD6Q4BYshLVtzQepnvmssDiviLlm+MI7uIZQGH
	kGqWjx6FCdVAD2pRlsMdhgnWPnvLkqxFl+F9KHzCaD8Vs7LauoRAwc//Ivk+Ke/tP/PczqKrh8p
	rfHEeWoSeYXqW/OjieyewLwZSvBJXcimbSm+5Lzq/Pk3Ti3LxSxVrxeU=
X-Google-Smtp-Source: AGHT+IHBBZ4HyuPUFBlL+gekmVeXRC25/ShLzRhrA1RfzNlQ3VHy/3HddBzzI1Px6HwtsfmTszOeHnGAenbCzUJ9xt9D4Z2Ggb/h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:36c:307b:7f08 with SMTP id
 e9e14a558f8ab-36caeb4e817mr1985295ab.0.1715265931063; Thu, 09 May 2024
 07:45:31 -0700 (PDT)
Date: Thu, 09 May 2024 07:45:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008441d006180678ad@google.com>
Subject: [syzbot] [gfs2?] WARNING in gfs2_ri_update (2)
From: syzbot <syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b9158815de52 Merge tag 'char-misc-6.9-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12a4c440980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14834e4b180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1059c0a8980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/23a6adc6f595/disk-b9158815.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2b325947833/vmlinux-b9158815.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd750d88d728/bzImage-b9158815.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4b403095e3ca/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13b2a774980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1072a774980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17b2a774980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com

gfs2: fsid=.: Now mounting FS (format 1801)...
gfs2: fsid=..0: journal 0 mapped with 18 extents in 0ms
gfs2: fsid=..0: first mount done, others may mount
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5074 at mm/page_alloc.c:4551 __alloc_pages+0x36a/0x6c0 mm/page_alloc.c:4551
Modules linked in:
CPU: 1 PID: 5074 Comm: syz-executor409 Not tainted 6.9.0-rc6-syzkaller-00290-gb9158815de52 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__alloc_pages+0x36a/0x6c0 mm/page_alloc.c:4551
Code: a9 00 00 08 00 0f 85 12 01 00 00 44 89 e9 81 e1 7f ff ff ff a9 00 00 04 00 44 0f 45 e9 e9 02 01 00 00 c6 05 28 e5 a7 0d 01 90 <0f> 0b 90 83 fb 0a 0f 86 6c fd ff ff 45 31 ed 48 c7 44 24 20 0e 36
RSP: 0018:ffffc900035f7420 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 000000000000000b RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc900035f74a8
RBP: ffffc900035f7530 R08: ffffc900035f74a7 R09: 0000000000000000
R10: ffffc900035f7480 R11: fffff520006bee95 R12: 1ffff920006bee8c
R13: 0000000000040d40 R14: dffffc0000000000 R15: 1ffff920006bee88
FS:  000055557175d380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffacbd3000 CR3: 000000007a07a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __kmalloc_large_node+0x91/0x1f0 mm/slub.c:3911
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc+0x320/0x4a0 mm/slub.c:3979
 kmalloc_array include/linux/slab.h:665 [inline]
 kcalloc include/linux/slab.h:696 [inline]
 compute_bitstructs fs/gfs2/rgrp.c:766 [inline]
 read_rindex_entry fs/gfs2/rgrp.c:931 [inline]
 gfs2_ri_update+0x549/0x1830 fs/gfs2/rgrp.c:1001
 gfs2_rindex_update+0x304/0x3d0 fs/gfs2/rgrp.c:1051
 init_inodes+0x24d/0x320 fs/gfs2/ops_fstype.c:912
 gfs2_fill_super+0x1edb/0x26c0 fs/gfs2/ops_fstype.c:1263
 get_tree_bdev+0x3f7/0x570 fs/super.c:1614
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1341
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd426e0c93a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffacbd27d8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fffacbd27e0 RCX: 00007fd426e0c93a
RDX: 0000000020000040 RSI: 0000000020000100 RDI: 00007fffacbd27e0
RBP: 0000000000000004 R08: 00007fffacbd2820 R09: 00000000000127be
R10: 0000000000008cd3 R11: 0000000000000282 R12: 00007fffacbd2820
R13: 0000000000000003 R14: 0000000001000000 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

