Return-Path: <linux-kernel+bounces-428690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F9B9E1228
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03F6160FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB72BD1D;
	Tue,  3 Dec 2024 04:02:25 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89451224F0
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198545; cv=none; b=t42jsBuQLwzt363dzmzQST7x+6Y8bqy60PjrD0TQH4weWcZJSgTg6l7JRme01PYFK9F7BnSRO9ZDKdXxROzDo7VoeavJ8NKkSfqQcLpqfVb3cW6YtJMqk/qAkENWbjWqq5cOhPL+eHnPzCLkFvCupYdcKmW6iOu9PcDlRKcdmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198545; c=relaxed/simple;
	bh=KAXLORfmjLfMqlxCDPgzPnmYYhq25m8ujJwiF/1d0JA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MRc9hOwhgDNKM3ckNxxGGF+hju8wMAPYI/yRrWWXVS5fCIqSv6hCs641ogPn7VUeY5BEbUegfbmeq2hRiDNRgKjAdmRHJH8974oXQbga+N8kkB3nI/JFQIWStxEmox2B7GxC72wu3ilvapeMTzIZbghzgPqFZfzZ6zrgAJpb/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-841a9ae0f26so848965339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 20:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733198542; x=1733803342;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwmeBxmUs1A9YhSIcqHuG1REkzy7JVBLgQ5Q7j2lhfY=;
        b=NKnzr3gK3mYOFGPXsXcSd+5JRq6Akwurg3Jj2tiIdKmtVXFTo/8RS6nD7eC6aQraD1
         qUcgTjd2FCCHfPpBFbqTGQd9wr83fXc5Rr8hN/N1+/0xhOVr1/EcXi59csIudCBHH0of
         osEv6rJJzvWwzZpoR8hMQTw923NfstOg6gV9RtUhFqAIFxGSTYh50Wx9aOn9B5KnnUdU
         vpxZOOU222FvrxkWDVEeFEVoZXo9yx45coo+Vfv5tbxOqJ88AeZ/kGLy2jq5CrNv5zq+
         r//RhA6PepB+HBv5FxaJwRhNflNRsAJUwwleautCWgXMOx+syvfdkFKcMmf28yJYdNN2
         1ScQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtSgvu3uGry3ZjPdKQ7DUwNIxg2EeQBcmjSWiDUBqGKjHiqNZ0kUmOtt5A5jMT2NBbmw4ap/3tVmh7Qxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUF3iFPXbKAxYrg1j5ftC6YNOQYSW5iysSGM1lgRRvfv2JSDS
	N2dspqez5Jnvgx/EcWKadx68GbRtBpNILspgpinV1GdITxeCOS4E8YH/7gmUXoiDkT3PQ0mXKAv
	TlgJxgAxMEBASGTsJ/WakCO2R7Pal+wwln08M2t4uaIJWG8+P7qmk3LU=
X-Google-Smtp-Source: AGHT+IEA0x+bCIv/RC6uJuSB/iE2uUcFvm08ZQ+65IZ+Rcl3K4QpsXfGe7f4tpuOjSJiG2csTp10ytzAa/JjjlkiITRhIpWUsySX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1949:b0:3a7:956c:61a4 with SMTP id
 e9e14a558f8ab-3a7f9a47622mr11852485ab.10.1733198542751; Mon, 02 Dec 2024
 20:02:22 -0800 (PST)
Date: Mon, 02 Dec 2024 20:02:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674e82ce.050a0220.17bd51.0040.GAE@google.com>
Subject: [syzbot] [jfs?] divide error in dbAllocAG
From: syzbot <syzbot+7c808908291a569281a9@syzkaller.appspotmail.com>
To: axboe@kernel.dk, jfs-discussion@lists.sourceforge.net, kristian@klausen.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7af08b57bcb9 Merge tag 'trace-v6.13-2' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15e03f5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29e5eaaea951b791
dashboard link: https://syzkaller.appspot.com/bug?extid=7c808908291a569281a9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=162573c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=156dcd30580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/815d3cc889bc/disk-7af08b57.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa365742e0ed/vmlinux-7af08b57.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea9d8aace8b7/bzImage-7af08b57.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/83512543e1fa/mount_0.gz

The issue was bisected to:

commit 2b9ac22b12a266eb4fec246a07b504dd4983b16b
Author: Kristian Klausen <kristian@klausen.dk>
Date:   Fri Jun 18 11:51:57 2021 +0000

    loop: Fix missing discard support when using LOOP_CONFIGURE

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17166d30580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14966d30580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10966d30580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Fixes: 2b9ac22b12a2 ("loop: Fix missing discard support when using LOOP_CONFIGURE")

loop0: detected capacity change from 0 to 32768
Oops: divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5857 Comm: syz-executor194 Not tainted 6.12.0-syzkaller-10689-g7af08b57bcb9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:dbAllocAG+0x414/0xd30 fs/jfs/jfs_dmap.c:1399
Code: 03 0f b6 0c 11 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 a7 08 00 00 41 8b 4d 2c 49 8d 7d 30 99 48 89 fe 48 c1 ee 03 <f7> f9 48 ba 00 00 00 00 00 fc ff df 0f b6 14 16 84 d2 74 09 80 fa
RSP: 0018:ffffc9000450fbc8 EFLAGS: 00010216
RAX: 0000000000000400 RBX: 000000000000000a RCX: 0000000000000000
RDX: 0000000000000000 RSI: 1ffff11004cce406 RDI: ffff888026672030
RBP: 0000000000000000 R08: 0000000000000005 R09: 000000000000001f
R10: 000000000000000a R11: 0000000000000002 R12: ffff88807650f000
R13: ffff888026672000 R14: 0000000000000000 R15: 000000000000000c
FS:  000055558401d380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557f78216048 CR3: 00000000772e0000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 dbDiscardAG+0x249/0x7c0 fs/jfs/jfs_dmap.c:1613
 jfs_ioc_trim+0x3fb/0x5c0 fs/jfs/jfs_discard.c:105
 jfs_ioctl+0x335/0x430 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc4a885b679
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0fc54e38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffc0fc55008 RCX: 00007fc4a885b679
RDX: 0000000020000080 RSI: 00000000c0185879 RDI: 0000000000000004
RBP: 00007fc4a88d4610 R08: 0000000000000000 R09: 00007ffc0fc55008
R10: 0000000000005ea7 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffc0fc54ff8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dbAllocAG+0x414/0xd30 fs/jfs/jfs_dmap.c:1399
Code: 03 0f b6 0c 11 48 89 fa 83 e2 07 83 c2 03 38 ca 7c 08 84 c9 0f 85 a7 08 00 00 41 8b 4d 2c 49 8d 7d 30 99 48 89 fe 48 c1 ee 03 <f7> f9 48 ba 00 00 00 00 00 fc ff df 0f b6 14 16 84 d2 74 09 80 fa
RSP: 0018:ffffc9000450fbc8 EFLAGS: 00010216
RAX: 0000000000000400 RBX: 000000000000000a RCX: 0000000000000000
RDX: 0000000000000000 RSI: 1ffff11004cce406 RDI: ffff888026672030
RBP: 0000000000000000 R08: 0000000000000005 R09: 000000000000001f
R10: 000000000000000a R11: 0000000000000002 R12: ffff88807650f000
R13: ffff888026672000 R14: 0000000000000000 R15: 000000000000000c
FS:  000055558401d380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557f78216048 CR3: 00000000772e0000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	03 0f                	add    (%rdi),%ecx
   2:	b6 0c                	mov    $0xc,%dh
   4:	11 48 89             	adc    %ecx,-0x77(%rax)
   7:	fa                   	cli
   8:	83 e2 07             	and    $0x7,%edx
   b:	83 c2 03             	add    $0x3,%edx
   e:	38 ca                	cmp    %cl,%dl
  10:	7c 08                	jl     0x1a
  12:	84 c9                	test   %cl,%cl
  14:	0f 85 a7 08 00 00    	jne    0x8c1
  1a:	41 8b 4d 2c          	mov    0x2c(%r13),%ecx
  1e:	49 8d 7d 30          	lea    0x30(%r13),%rdi
  22:	99                   	cltd
  23:	48 89 fe             	mov    %rdi,%rsi
  26:	48 c1 ee 03          	shr    $0x3,%rsi
* 2a:	f7 f9                	idiv   %ecx <-- trapping instruction
  2c:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  33:	fc ff df
  36:	0f b6 14 16          	movzbl (%rsi,%rdx,1),%edx
  3a:	84 d2                	test   %dl,%dl
  3c:	74 09                	je     0x47
  3e:	80                   	.byte 0x80
  3f:	fa                   	cli


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

