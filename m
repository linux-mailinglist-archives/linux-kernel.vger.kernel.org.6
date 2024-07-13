Return-Path: <linux-kernel+bounces-251460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F014930523
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344351C212FD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982A647F64;
	Sat, 13 Jul 2024 10:25:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943023BBCC
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720866323; cv=none; b=g7E1dFbhKSXPg7Gst9O1BbrE9f0TblAEVfdBBv54kx8aGZtdNKEVpsFh75oLMc0gMFYL/fS37XCOms5kIOwR8mUosdI8FWNDbntJwPlWtDDyFoL6YWWOf4vS1Ecv0WOfe2njq/5uZtiAKV5ZRGp3LXv74BnD3gCPzki1bq+r9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720866323; c=relaxed/simple;
	bh=ZBNUzYhY0XyCLJEvMrVXx0hDlxVsefPmd6MFa7SLejI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E4Khh31UQgFOkHgEFa9D1vvfyBEB1t3lCAnu9+jhuK/PofUcx2J9PRwNMhIOzuAN3yW8Cf/eJ4JsPmMsRknhYmXhQ7lFCiXYWWPpu6BqShP4Nna/0lRJus/4rwSFYXPW10aVNAmrnlU6uyjwXq/R08cmP8kFcOWPepk5ygtYemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f6827f1acbso297873439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 03:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720866321; x=1721471121;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZ4FVtwD6Md8at7qAAzb/NnvYsEcHBzv+ZdXzcub+xc=;
        b=spOYspxsk+inv1i47+G/IrKQ3VrCSPJjORoCSq3IMeDTKe6rldCXzn5+arheOGAa3N
         tpWKXnJgdIWZDTa1p0kuW1PZwFMn5914PHuFCLwSjjpZ57gWTa2nYBQq5LrNAKKeS84W
         UE24z3TRXVa3nYI3XjBJmzKlj3pqf6TRDcgCvIrbnkjcf+xcNt27BdmMhoZfj14T6lyK
         Zy40j6+KBYtZNTliC1cEa3C8lApugjdlFpsOw6XT9/OAfaERJNcAluveIldVwCAdusEU
         b/aimyTmTUv5bWOao8eb83xQIF5ylAaViyk6uCjV46Y7Osh1iZctSpXPwJLEZ0hGx8Ph
         i95Q==
X-Forwarded-Encrypted: i=1; AJvYcCXf3G06/j2ZoQ/+SqP9+aFW2rOa9d9ExBj7oANHGSPzq2w0ZOVQNZkcCBNGsq324zNJZ2WNufzqhryCdlQhMYBJGDQyjYgW6z+qhPV+
X-Gm-Message-State: AOJu0YxkwlnfKpEHHUZHmu2zG9BDVvC1AAkaN5nUIGrShVMhjUiPXUBy
	fpyBo3igmnECAR0BJf+hzYDQoAhr+oQ/SsA3uh8/4iJhE7LTmhaqcDDNdHM8bLj+bW5G4Zdp2qJ
	AZ0tSTx92fwWgihFMPTy+bNR40mrYk7T/wPT0qY0zOsVNMv2suMGgh3U=
X-Google-Smtp-Source: AGHT+IGIa1b8Rpe7LpguR+rPPNOwgGqCbNVhVz1fWtaPaX/bSYmumq9gwWzmiGNMeHHNoeZdn8sJyX1uExjHLzmqqJhBvWNl3CTs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152f:b0:38b:462b:8dd with SMTP id
 e9e14a558f8ab-38e62268c4bmr4384865ab.3.1720866320786; Sat, 13 Jul 2024
 03:25:20 -0700 (PDT)
Date: Sat, 13 Jul 2024 03:25:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1c0a0061d1e6979@google.com>
Subject: [syzbot] [kernel?] kernel BUG in binder_inc_ref_for_node
From: syzbot <syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com>
To: arve@android.com, brauner@kernel.org, cmllamas@google.com, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    82d01fe6ee52 Add linux-next specific files for 20240709
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=106472a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95a20e7acf357998
dashboard link: https://syzkaller.appspot.com/bug?extid=3dae065ca76952a67257
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f2e87e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a4869e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/12dcacb06142/disk-82d01fe6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ef954821378/vmlinux-82d01fe6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9ebf01d42887/bzImage-82d01fe6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at drivers/android/binder.c:1175!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5100 Comm: syz-executor841 Not tainted 6.10.0-rc7-next-20240709-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:binder_get_ref_for_node_olocked drivers/android/binder.c:1175 [inline]
RIP: 0010:binder_inc_ref_for_node+0xdf7/0xe00 drivers/android/binder.c:1478
Code: e8 f8 e9 4e fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 59 fd ff ff 48 89 df e8 24 e9 e8 f8 e9 4c fd ff ff e8 0a 15 82 f8 90 <0f> 0b 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900038f75e8 EFLAGS: 00010293
RAX: ffffffff891176d6 RBX: 0000000000000000 RCX: ffff888077030000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888021c2e820 R08: ffffffff8911720b R09: 0000000000000000
R10: ffff88802f1b0330 R11: ffffed1005e36068 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88802f1b0428 R15: ffff88802f1b0410
FS:  000055557b30a380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa59eb210e0 CR3: 000000001fee6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 binder_thread_write drivers/android/binder.c:3946 [inline]
 binder_ioctl_write_read+0xc7b/0x8d60 drivers/android/binder.c:5163
 binder_ioctl+0x43d/0x1c70 drivers/android/binder.c:5449
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa59eaaa1e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffea9c908d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa59eaaa1e9
RDX: 00000000200003c0 RSI: 00000000c0306201 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 000055557b30b610 R09: 000055557b30b610
R10: 000055557b30b610 R11: 0000000000000246 R12: 00007fa59eaf80dc
R13: 00007fa59eaf30a3 R14: 00007ffea9c90900 R15: 00007ffea9c908f0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:binder_get_ref_for_node_olocked drivers/android/binder.c:1175 [inline]
RIP: 0010:binder_inc_ref_for_node+0xdf7/0xe00 drivers/android/binder.c:1478
Code: e8 f8 e9 4e fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 59 fd ff ff 48 89 df e8 24 e9 e8 f8 e9 4c fd ff ff e8 0a 15 82 f8 90 <0f> 0b 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900038f75e8 EFLAGS: 00010293
RAX: ffffffff891176d6 RBX: 0000000000000000 RCX: ffff888077030000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888021c2e820 R08: ffffffff8911720b R09: 0000000000000000
R10: ffff88802f1b0330 R11: ffffed1005e36068 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88802f1b0428 R15: ffff88802f1b0410
FS:  000055557b30a380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa59eb210e0 CR3: 000000001fee6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

