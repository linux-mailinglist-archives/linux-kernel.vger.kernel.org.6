Return-Path: <linux-kernel+bounces-248859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863A592E2D0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6023B219DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE95153581;
	Thu, 11 Jul 2024 08:55:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB08F78283
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688123; cv=none; b=juKinWzrGmxT10KBPkhslzgHns3QwUuJ8Ni1vgabRcZMzl5AYf4TculwiSrGwJDDqr61aOzwr/+HkzJY9XmJrnUi0jQhN11k7/5ObDPm/LiQMv4TTz4OUYNcsPiL3EbLNfN3+PsN5RACWvq6RW86hjqkklGcNTBzKDIoqqXcqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688123; c=relaxed/simple;
	bh=Ieeo12Y9Zk6Da7peJZoY0SL3N0/6PNtoVpZrhj5NoPI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k/kCjgFCv3jYFTi2MhKa5xckSpeuQtkKPlPlZliyIwFgynrQLduo7540ZqzjCgxxqkzXlVDbdaFNvGPGmJmErh8cV1L6z/aqs6fwzM1DSoymF7Z/ixEsiihVktw3mT+XAKfvCUX8Y/c1dWdPHRc2tIfw3L4y4StDn3UBIBe55CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ebd11f77d8so71919839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720688121; x=1721292921;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzd+X9QEqYjrbi3EtMzlUg+nanjs6nVilWOmryRstKI=;
        b=ttSnNxVTaVJ5rQKSitjGqeZ0bjReYHQTTQ+3x724mNMInpSn38holDNqf4pYraBGRt
         r5LjyLhUu3yGb27xr9Pxdxu6kFk8EkvYgk88S7e+7Kyd5V2UxLAGBbVR2UrxXRTFviGb
         eQ/fG3bMxtgEienAYtOWw85dfrMGZrP8ij77anZdGBwHEIifidIF9wbxXjeYVJRHJB78
         2Tfh/WWLw1AqOxq8YT7e5DnNxr14zejwzAk+H1Pne5RBT7cgVLwTzEgtUTY7BuWq+UzY
         snHnQFBVVxhzVJfiDHD8TYgFN484bF3iKUD/Gn3m27OFc4+Db3RLzU4SG+R5neu6MBMJ
         reZg==
X-Forwarded-Encrypted: i=1; AJvYcCUw4L4o5LlBIjedTDC39vR9LOroaqQOkyTW4yZqoz/tUN3OxYPj+Q32I7IIWGKAXE03xZfncahQy5tqXxKDE5jEEZUVTGwGBqAWIo5o
X-Gm-Message-State: AOJu0YzI3dRqGurGP7CTRbLorFngsgWPDiJW4ogrFrKdtX5q/RxRq5Mg
	K1DfWGRmqA7l6ueqGdBXKKAjkddPrIToNte9mfOK9abnO/aDVQfhhMsYwqULATMbBAM8gKpTh2e
	ABWDfCfNrgr904qa5BOHgYg02bNSL37FmbknTSqRX86DbCk9xfKzyy8w=
X-Google-Smtp-Source: AGHT+IG1SIDhJo7vyIuMCc8FKw7+wkpapX5tIBaR9j40ZmSxf3UCJ4Kz4sy+k2ML1km1bnO175WCfYQB/gDLWF/+WaZVMRz2oXTQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2192:b0:4b9:ad96:2adc with SMTP id
 8926c6da1cb9f-4c0b2b39704mr481726173.4.1720688120892; Thu, 11 Jul 2024
 01:55:20 -0700 (PDT)
Date: Thu, 11 Jul 2024 01:55:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000372171061cf4ecb5@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbNextAG (2)
From: syzbot <syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22f902dfc51e Merge tag 'i2c-for-6.10-rc7' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=175c1059980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=808f3f84407f08a93022
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17eb06e1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e6f6e1980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da00a62c06a3/disk-22f902df.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e090db7ab1fa/vmlinux-22f902df.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5332f53497de/bzImage-22f902df.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ec0f0006ae2c/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d45c9e980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17d45c9e980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13d45c9e980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:661:7
index 128 is out of range for type 's64[128]' (aka 'long long[128]')
CPU: 0 PID: 5083 Comm: syz-executor157 Not tainted 6.10.0-rc6-syzkaller-00215-g22f902dfc51e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 dbNextAG+0x3f3/0x630 fs/jfs/jfs_dmap.c:661
 diAlloc+0x6c6/0x1760 fs/jfs/jfs_imap.c:1369
 ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
 jfs_create+0x1be/0xb90 fs/jfs/namei.c:92
 lookup_open fs/namei.c:3505 [inline]
 open_last_lookups fs/namei.c:3574 [inline]
 path_openat+0x1a84/0x35f0 fs/namei.c:3810
 do_filp_open+0x235/0x490 fs/namei.c:3840
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1413
 do_sys_open fs/open.c:1428 [inline]
 __do_sys_openat fs/open.c:1444 [inline]
 __se_sys_openat fs/open.c:1439 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1439
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdb9c0a0a99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffecc111738 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fdb9c0a0a99
RDX: 000000000000275a RSI: 00000000200005c0 RDI: 00000000ffffff9c
RBP: 00007fdb9c11a5f0 R08: 000055555c2c14c0 R09: 000055555c2c14c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffecc111760
R13: 00007ffecc111988 R14: 431bde82d7b634db R15: 00007fdb9c0e903b
 </TASK>
---[ end trace ]---


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

