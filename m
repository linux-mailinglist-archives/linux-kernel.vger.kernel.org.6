Return-Path: <linux-kernel+bounces-171075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4028BDF83
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E787E1F22A99
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A614F104;
	Tue,  7 May 2024 10:15:25 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DE14E2F0
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076924; cv=none; b=ttvmDYI01WGwx4P1S4cMEmwTok45clWpb/KOzSMz7ZYdcMbavYzpcLR+02rVxrIP038vDVzpZ2W6VsNLKxZfUvB8RQJADomYymUvSU2ZicIW8JPDQEht63k065AjDl4oArHQ4JZqVrLKq29/c6vI8eS0pipGmXW138TdEBTFAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076924; c=relaxed/simple;
	bh=G3lhNLoSVzVwAYj4orpBtWCzukJvuGV3dda6v/anHrY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=nAp2Yepv3HpEfvIEsn/2pl4e+/F9y3k71qZbXy5dBvWwjYssoXKreOo+ZIvH+5k67hojPi0x6qpiET4jhu9VlPsmqQyi6wueT78Dyq5wzzxCjiG9Q36yARAQZawMlaeJ0A25JU7IJ7jC083mBUBvxgytoovEBTuwl5c46cMGru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36c886e1c82so33919145ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715076922; x=1715681722;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6+v8NHIB48he+Pi+SNSoHsPxi35G0HSK4pj5yhcJ1s=;
        b=CwMOp3SQwS45WbYNWAroaFOTxLB3VJy0Z4ZUJs6c3igovABMHpMpxpotJMuGuSnRcJ
         V4oaQ6IyMIe/myPMWos/5xdBRfsXG89fgMo5Yo7zuMwq2TOfHqE3XigH+LaRIv6Uy4MZ
         BE9u5EuFDjIxWtmhVxDurCW7xcUtjHm+JRKO9YdgIP6K7r2mXguu+YLhIrP6a6S7ZHvR
         CFmWwqZ/p2tXnOJVJVrB+PPszD4JwTsdFXv0hv1+lprZz/4+ourjWrdudM8hxFCwwOVU
         rt0J/Y/UeXd0xOETDJINRdpEyjUDh/koxph9wZXmsxZbSQ+5O2Rh4gXdaCGj+sB4ZMYf
         rL0g==
X-Forwarded-Encrypted: i=1; AJvYcCUERlysDpTRhoYlIIpv1AFYhm73LIvJWIZQRxnNfddFS+h1ivuAcCTrScBL0saiVYznZwAg08KAL69o9GTfh9ENFQRq9Atb0lMsacs0
X-Gm-Message-State: AOJu0YwgWKFDD4v7IQFqzlMkoNvt3x8g4t/EpsWSOEABuYtsZqntW2nK
	dUTTjJcd8WqpcSruI7Qva+3LIkbL8f3FGzFkVokxF5QwvGL1z1eoDf1DAyAhjZT4HXQQsj8wWd1
	8+NDY6shiZfalt+rdzla6GdJnLuLp5BsAXbb0nLK0PHrCTfvxaCXVOOw=
X-Google-Smtp-Source: AGHT+IHwsqkNaczCNpvvk8ZZqs4EcktZ4KyUYFOS+mtjoVm5/uo+RpW2rCvIiXUyPo7MubB/mmxuKmLg9yACrsrWttf+uhkr9J0Z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c3:b0:36b:140e:a4c with SMTP id
 i3-20020a056e0212c300b0036b140e0a4cmr463079ilm.3.1715076922615; Tue, 07 May
 2024 03:15:22 -0700 (PDT)
Date: Tue, 07 May 2024 03:15:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc3c710617da7605@google.com>
Subject: [syzbot] [bcachefs?] WARNING in bch2_fs_usage_read_one
From: syzbot <syzbot+b68fa126ff948672f1fd@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b84edefcad1 Add linux-next specific files for 20240506
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=121197df180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b499929e4aaba1af
dashboard link: https://syzkaller.appspot.com/bug?extid=b68fa126ff948672f1fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155c109f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136e52b8980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6a22cf95ee14/disk-2b84edef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5c45b515282/vmlinux-2b84edef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9bf98258a662/bzImage-2b84edef.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/a691ba218fae/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/b4b43602eca5/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b68fa126ff948672f1fd@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 35 at fs/bcachefs/buckets.c:108 bch2_fs_usage_read_one+0x638/0x6a0 fs/bcachefs/buckets.c:108
Modules linked in:
CPU: 0 PID: 35 Comm: kworker/u8:2 Not tainted 6.9.0-rc7-next-20240506-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: writeback wb_workfn (flush-bcachefs-1)
RIP: 0010:bch2_fs_usage_read_one+0x638/0x6a0 fs/bcachefs/buckets.c:108
Code: 24 38 49 01 c7 4d 01 fc 4d 01 e5 4c 89 e8 48 81 c4 a0 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 f9 9a 78 fd 90 <0f> 0b 90 e9 ba fa ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 32 fa
RSP: 0018:ffffc90000ab6308 EFLAGS: 00010293
RAX: ffffffff841d7e37 RBX: 0000000000000000 RCX: ffff88801b685a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000ab64f0 R08: ffffffff841d78e6 R09: 0000000000000000
R10: ffffc90000ab6440 R11: fffff52000156c8d R12: ffff888075cf8500
R13: dffffc0000000000 R14: ffff88806b180000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb172fff000 CR3: 0000000079a6e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_fs_alloc_debug_to_text+0x181/0x630 fs/bcachefs/alloc_foreground.c:1634
 bch2_print_allocator_stuck+0xc9/0x180 fs/bcachefs/alloc_foreground.c:1657
 __bch2_write+0x5471/0x5c40 fs/bcachefs/io_write.c:1493
 bch2_write+0x947/0x1670 fs/bcachefs/io_write.c:1622
 closure_queue include/linux/closure.h:269 [inline]
 closure_call include/linux/closure.h:402 [inline]
 bch2_writepage_do_io fs/bcachefs/fs-io-buffered.c:460 [inline]
 __bch2_writepage+0x1416/0x2b50 fs/bcachefs/fs-io-buffered.c:607
 write_cache_pages+0xd0/0x230 mm/page-writeback.c:2591
 bch2_writepages+0x14f/0x380 fs/bcachefs/fs-io-buffered.c:650
 do_writepages+0x359/0x870 mm/page-writeback.c:2634
 __writeback_single_inode+0x165/0x10b0 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x99c/0x1380 fs/fs-writeback.c:1947
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2018
 wb_writeback+0x495/0xd40 fs/fs-writeback.c:2129
 wb_check_background_flush fs/fs-writeback.c:2199 [inline]
 wb_do_writeback fs/fs-writeback.c:2287 [inline]
 wb_workfn+0xc58/0x1090 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
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

