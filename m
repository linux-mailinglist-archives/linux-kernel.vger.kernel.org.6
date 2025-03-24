Return-Path: <linux-kernel+bounces-574218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8FAA6E221
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614C43A7599
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682DB264A62;
	Mon, 24 Mar 2025 18:18:32 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8E036124
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840312; cv=none; b=ShwCBYp2b2JAIY3GjAdIpDwlMdagnyk4Q0uvAWQhteyu147vuJLrGVHjTInfV8pYOMG+pbu5HtBVY578D0yCcC7RiDFhng2sevP2PnHoatySFAfBFzhwamz+cUApS9zOavdpDDJgcmmXmo+n5JcoL44msmgCpkXkF6mjrp5sdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840312; c=relaxed/simple;
	bh=btgeIGnIUoCIck9+wS+7c/hFv1g6wYgJLfeKG87NVzA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RMtMGczBLlOOPAGoCVlbdBdfPPsjd4r007yzm3fkHIhYYyf5FUocatTNrVzz0h3sEk907pcb7jnGAZHTuIYBTJhwWpe34MK0efOvCb4RUj6yaPDzvJgGVN9bQO6WyRqsE7h7ZESrEV+nL40cnciW2aGHXNaH5ykNYIefhEAaTus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d43d3338d7so93625935ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742840309; x=1743445109;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBNLf/d9pxK/fHTPY4JvsITkXOFpMyYfD4pamBhwHRA=;
        b=QgNwGDMrUi9ulGH4Vfr9QUecCYRwa1VIMMXJlCKWB0v8QfoH4eJbNZg7n6354oUkQl
         Gp0Q3x3DNdARjXZU7F4s31B9S60szB05sXGZdHHKhF1qQa2fUiT502HagqKJXn+bwarC
         B2qE0gA4vmmI+2+rNAoKm8S5uKgsAz+eAoDDm9syB/enq0KqoYQ2nWoLHrNJHWq6fDZ3
         ROA5mo5XaRy3vwOZ3Aj7mCOrGgTZc1tEk5zPFw6USKqzLkiD75NHV2CqevEqnQVI9nVS
         wiOnSs/K1mvzMlp3oZbT/i8MLVoYTepwWUNJzDmD9xZ2hHxJ95RCfz8aI6tZ4xnot4T4
         IpJw==
X-Forwarded-Encrypted: i=1; AJvYcCWdD6R9/084Tax4pRSv6cKW+hqJHu7FRMbqTRBXzB2TSd7csi2vKuKgiP3qkqrY0mVjdhdVopBCwOGMxyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/qxG2J0OB/f/+Fi1d54cZ2l1NTpRMjUe/wvj4RU1KhBgt5ii
	zwgK1RVXDBpT7AK3qNXq1NANMipaze0STLblV33UIN/lxHjVumUttfJpGiAxTRHVJmtN/QLwAwt
	Elr6faHOUQxBaMJ/rDgTPFdMnmf2XaAmWjzN2BlBnMiv+WbyMkzCJizc=
X-Google-Smtp-Source: AGHT+IHAO6nfo755uIRQ2cGgnPp5lBiB6CmROXZt0tvLmT1MEN9v/EwZsmiYxrgD2wI4hYDXTJjrhTrIXK4dSioxL/HqgQhiF2Fe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174c:b0:3d4:3aba:e5ce with SMTP id
 e9e14a558f8ab-3d5961bc1ffmr145580605ab.20.1742840309399; Mon, 24 Mar 2025
 11:18:29 -0700 (PDT)
Date: Mon, 24 Mar 2025 11:18:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e1a1f5.050a0220.a7ebc.0029.GAE@google.com>
Subject: [syzbot] [usb?] WARNING in dib0700_i2c_xfer/usb_submit_urb
From: syzbot <syzbot+c38e5e60d0041a99dbf5@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5fc319360819 Merge tag 'net-6.14-rc8' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15445e98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=27515cfdbafbb90d
dashboard link: https://syzkaller.appspot.com/bug?extid=c38e5e60d0041a99dbf5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ea4c4c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15435004580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1c90f739fd77/disk-5fc31936.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1949bfaaa2fe/vmlinux-5fc31936.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dc1e147ca5d4/bzImage-5fc31936.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c38e5e60d0041a99dbf5@syzkaller.appspotmail.com

------------[ cut here ]------------
usb 1-1: BOGUS control dir, pipe 80000f80 doesn't match bRequestType c0
WARNING: CPU: 1 PID: 5901 at drivers/usb/core/urb.c:413 usb_submit_urb+0x11d9/0x18c0 drivers/usb/core/urb.c:411
Modules linked in:
CPU: 1 UID: 0 PID: 5901 Comm: syz-executor773 Not tainted 6.14.0-rc7-syzkaller-00137-g5fc319360819 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:usb_submit_urb+0x11d9/0x18c0 drivers/usb/core/urb.c:411
Code: 48 8b 4c 24 08 0f b6 04 01 84 c0 0f 85 52 05 00 00 45 0f b6 07 48 c7 c7 e0 4b d1 8c 4c 89 f6 48 89 da 89 e9 e8 e8 9b 09 fa 90 <0f> 0b 90 90 e9 c9 f3 ff ff 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 57
RSP: 0018:ffffc900041cf808 EFLAGS: 00010246
RAX: fe52edbd68e0e800 RBX: ffff888021693020 RCX: ffff8880267d5a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000080000f80 R08: ffffffff81819e52 R09: 1ffff92000839e9c
R10: dffffc0000000000 R11: fffff52000839e9d R12: ffff88802a23f0a8
R13: ffff88801e6cfa00 R14: ffffffff8cd1b600 R15: ffff888033956e60
FS:  0000555580b9b380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa8c1abb0f0 CR3: 00000000282c0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 usb_start_wait_urb+0x113/0x520 drivers/usb/core/message.c:59
 usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
 usb_control_msg+0x2b1/0x4c0 drivers/usb/core/message.c:154
 dib0700_ctrl_rd drivers/media/usb/dvb-usb/dib0700_core.c:95 [inline]
 dib0700_i2c_xfer_legacy drivers/media/usb/dvb-usb/dib0700_core.c:315 [inline]
 dib0700_i2c_xfer+0xc53/0x1060 drivers/media/usb/dvb-usb/dib0700_core.c:361
 __i2c_transfer+0x866/0x2220
 i2c_transfer+0x271/0x3b0 drivers/i2c/i2c-core-base.c:2315
 i2cdev_ioctl_rdwr+0x452/0x710 drivers/i2c/i2c-dev.c:306
 i2cdev_ioctl+0x759/0x9f0 drivers/i2c/i2c-dev.c:467
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa8c1a448f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc66aa7058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa8c1a448f9
RDX: 00002000000004c0 RSI: 0000000000000707 RDI: 0000000000000004
RBP: 000000000002ca0e R08: 00232d6332692f76 R09: 0000000000000006
R10: 000000000000001f R11: 0000000000000246 R12: 00007ffc66aa706c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
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

