Return-Path: <linux-kernel+bounces-224957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCBA912915
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBBB28830F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D06655E73;
	Fri, 21 Jun 2024 15:11:31 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353382491
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982691; cv=none; b=pfoEOpGfjIy5OOzvjuVAVsPYL0ImohbqDsaXNSjrROopc0e0+i54ZkmPCKRxD2jdfzy7rD6vl0wmBFWquXj8wXy/dEeniuIh9Y7YWm4yJjZeltkhlXJmPvPufRD+uszU6g07/Mwg+5dY6HR05h6C1uUuwo+bZDVccEBV6xEB0l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982691; c=relaxed/simple;
	bh=ME4mpnP79ZGqEWyQcWQXccoE9ssfeuJdF9iZpqJ9uNQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ptNDQYfBVwvlzPUjqRJEDo7mk80UK7mFiaoCxwxsVAcezR5V8NTwXeaR+jabgvzKw3eHfE+c6ey9QtlAvF5in9fq3PfHdxccImI1KhyoU7jL/ayW767zSnke33H+F7YhUCZqLnDnOzaXsLN19G6B/L9qwrwFo0QigTsKESWIiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3762317d6a0so19093075ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982689; x=1719587489;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bkl6yEW6ODEztSFg+ZbwWXo7SxIFnRfXOWW0SpRgGzE=;
        b=t6vbaRmW1C6vAsmve0dvIIJu+Y6oTk1izEGt8mX0UkDbIn/5jhxjh70tD2enSpXzuK
         hdg1FpsNfMADiUq9/KmUxaRM/Cp3fi/VSrA0MtFM686VY0iOeYiZdU+/SZ4YVkiozoaU
         2aw9FP4idR9XRhPVzUXOtXvmpzwo8QKGiV0tZ8mCE7JQsmj78761zHg1YA6MPpPa2Xgr
         VD8MTEWaBtUjy/Cpg0I4mtc8o3gMJrvejk3nvZwQ04OK353X68W4Hmyfv1ZGQnVCUaXU
         hv4oC5wJjnUTgHC2O6yt0VhhyxbHaUSOVKd6qK6/9OSMWPgyFZG2xI5R1AqRjdLzmi6t
         hSVw==
X-Forwarded-Encrypted: i=1; AJvYcCXYW146rJjBFW3mp/Qv6jF8C6T+Z51knFkatzjatAwKbIDk0BmchgjfFwjsn74MGdRmV86XyH/lBxSrYQ8mjxg7ZFO02NgvGaOOHG9R
X-Gm-Message-State: AOJu0Yy+nJljX8qmxHiLbKruDIJmXV3dz0exRbqARg/fKJFjP7S1H7Q/
	6oPOpsZyr7DOD1KUhKdwmyoEP7ppitjkrAn/f2dJCM0sOFKyGHe4GmhCjBcJkFDK4MeKSAKXMPL
	BH2iuTfKZxF9l8KPvj5npCt544T4vR7y7ZTODDKcypefDI5x5vOwWUXg=
X-Google-Smtp-Source: AGHT+IEAM94hrAMJKPjcqypl3alStYAXevjCG1n84tiK9EYApJprlhh8Gja32E74D0bIFW+bwp+kLfyPwKmanuJyGQ1nXmDwkPl2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a68:b0:375:a202:252f with SMTP id
 e9e14a558f8ab-3761d712a87mr5744195ab.4.1718982688927; Fri, 21 Jun 2024
 08:11:28 -0700 (PDT)
Date: Fri, 21 Jun 2024 08:11:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c85d9061b67d833@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbDiscardAG
From: syzbot <syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1210cd46980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79815c08cc14227
dashboard link: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1712af56980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10454882980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/35e32e9073a7/disk-2ccbdf43.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6c6e34658d16/vmlinux-2ccbdf43.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4417e7ef76ed/bzImage-2ccbdf43.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a60a47be0fb5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1629:18
shift exponent -1 is negative
CPU: 0 PID: 5086 Comm: syz-executor290 Not tainted 6.10.0-rc3-syzkaller-00044-g2ccbdf43d5e7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 dbDiscardAG+0x5a7/0xa10 fs/jfs/jfs_dmap.c:1629
 jfs_ioc_trim+0x433/0x670 fs/jfs/jfs_discard.c:100
 jfs_ioctl+0x2d0/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e9952bad9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9232dc18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6e9952bad9
RDX: 0000000020000080 RSI: 00000000c0185879 RDI: 0000000000000004
RBP: 00007f6e995a45f0 R08: 000055556d87a4c0 R09: 000055556d87a4c0
R10: 0000000000005ea4 R11: 0000000000000246 R12: 00007fff9232dc40
R13: 00007fff9232de68 R14: 431bde82d7b634db R15: 00007f6e9957403b
 </TASK>
---[ end trace ]---


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

