Return-Path: <linux-kernel+bounces-197941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 774428D70FF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 17:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8D46B20E96
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734F6152783;
	Sat,  1 Jun 2024 15:52:37 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0A13ACC
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717257156; cv=none; b=fVQZpf5rxlpXt5tzGDdme1nx6wGz/61tmCxOqniTwCk04W/hBIs0WXlIA9cRYjgEwDHLKH4zB+DMGax1Z9CXHXoQLlTPkJkJ1dYvQUTnoPab1sncbtQZ+8uYwSWJ4EjNUbOghcfE05idW1XoU8UFnhbsEQpV4VRJwenpQ5vQ51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717257156; c=relaxed/simple;
	bh=ie3sZm5lVU66uTI+B+ZSVwGdkRVUh5qDdG/i/oQxgPQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Kh82I9GFYdtJs2W1mSRSJIHDG1PFuqMRBFKezJi4ghvq3rOaBDPDRa6jeE1wQXB04FC9pygIaWOCRn4tHEGjwx94Tc38TkjLy1EYQjRxIOVeIRxA+w7Y6XUq2R5zrXcRUgcakLHZEaOy+kD79QpPk0HK/NkiWcn79Y8nPiDgRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-37497fe0362so1057555ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 08:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717257154; x=1717861954;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pN+fUcuaKpwJIWUe4QCfqLtFU3A4jfoaaT0isEH1Mkc=;
        b=Zt8pqbv1HZ+OjckY0YrB4ar2xx1LHjbnVsoC6PJqaY00noefEEDaWK0Q4aNdqnPHkj
         io0vY8Ik0aZjFVFhBaanP1ntGkM8lHVAsQLKHNX78RLi2SPIPpTkoTagOwYHYEGl19iC
         wc7xhCZBptC1LJ8Go3DQRokhDnJ7sCohyD3VbG4QHhSPj1m8PR2sjlHN2a1C7+Lo6Rxg
         03zmiZEAECSzMQHFyZaj0AhA4nzkCUMU3XFSd712QZDqi2t49G0yGv5ltoAtLBDiup76
         iWXX8qLYaiktSNibAOfgniFlLya1ge9lr+nmD9ykSRc6JzCmOAKCKro76vkrlVqhyQbk
         2SEg==
X-Forwarded-Encrypted: i=1; AJvYcCVXJVpig8pi83RRyBYvWoH3DdOP/Y2yL3vLdNbYJD58p17qo7tMJet8KrRJqVnrFYbSguUZ9aamOxCE1IdwVC7peuASJExcBgoRjDwt
X-Gm-Message-State: AOJu0YxBV04YyhibM8RFeua4V/ZfqQHGwwQKETexax34nj+1BtUwmtcR
	mrDYoqwRSaM6STSrM2jF8WYpLKQ0EInqkCjLmBLzuIYIzTweT8qAEebHndkki4W+DKSjhDJppHd
	CEDaQ728VZHnP1123p2Q8z8baC08DmsootJ/x15N/3ezH8D34FZtbUwA=
X-Google-Smtp-Source: AGHT+IGWjLJmbFIgD3YBp85wyK0E8RraVmKp7B9T3BCac577/MDwOYpWmB8Ezn2xT0ULJ7Xp7ymw2NM3r5Bj6HjMVs0B1+Fq/ojx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:374:598b:3fec with SMTP id
 e9e14a558f8ab-3748ba4c0ecmr1837395ab.5.1717257154610; Sat, 01 Jun 2024
 08:52:34 -0700 (PDT)
Date: Sat, 01 Jun 2024 08:52:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0562f0619d6165a@google.com>
Subject: [syzbot] [bcachefs?] WARNING: locking bug in __timer_delete_sync
From: syzbot <syzbot+0ece6edfd05ed20e32d9@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2bfcfd584ff5 Merge tag 'pmdomain-v6.10-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145cf71a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=733cc7a95171d8e7
dashboard link: https://syzkaller.appspot.com/bug?extid=0ece6edfd05ed20e32d9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2bfcfd58.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7ed3bb80bed/vmlinux-2bfcfd58.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93acc5bfbaef/bzImage-2bfcfd58.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ece6edfd05ed20e32d9@syzkaller.appspotmail.com

bcachefs (loop1): shutdown complete
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 6195 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 6195 at kernel/locking/lockdep.c:232 hlock_class+0xfa/0x130 kernel/locking/lockdep.c:221
Modules linked in:
CPU: 1 PID: 6195 Comm: syz-executor.1 Not tainted 6.10.0-rc1-syzkaller-00013-g2bfcfd584ff5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:hlock_class+0xfa/0x130 kernel/locking/lockdep.c:221
Code: b6 14 11 38 d0 7c 04 84 d2 75 43 8b 05 f3 33 77 0e 85 c0 75 19 90 48 c7 c6 00 bd 2c 8b 48 c7 c7 a0 b7 2c 8b e8 97 47 e5 ff 90 <0f> 0b 90 90 90 31 c0 eb 9e e8 f8 f8 7f 00 e9 1c ff ff ff 48 c7 c7
RSP: 0018:ffffc900074cf9f8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000ec4 RCX: ffffffff81510229
RDX: ffff88802bda8000 RSI: ffffffff81510236 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 000000002d2d2d2d R12: 0000000000000000
R13: 0000000000000000 R14: ffff88802bda8ae0 R15: 0000000000000ec4
FS:  0000000000000000(0000) GS:ffff88802c100000(0063) knlGS:0000000058106400
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f7446000 CR3: 000000005442c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 check_wait_context kernel/locking/lockdep.c:4773 [inline]
 __lock_acquire+0x3f2/0x3b30 kernel/locking/lockdep.c:5087
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __timer_delete_sync+0x152/0x1b0 kernel/time/timer.c:1647
 del_timer_sync include/linux/timer.h:185 [inline]
 cleanup_srcu_struct+0x124/0x520 kernel/rcu/srcutree.c:659
 bch2_fs_btree_iter_exit+0x46e/0x630 fs/bcachefs/btree_iter.c:3410
 __bch2_fs_free fs/bcachefs/super.c:556 [inline]
 bch2_fs_release+0x11b/0x810 fs/bcachefs/super.c:603
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1fa/0x5b0 lib/kobject.c:737
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:473
 deactivate_super+0xde/0x100 fs/super.c:506
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 __do_fast_syscall_32+0x80/0x120 arch/x86/entry/common.c:389
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf726d579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffc3bdf8 EFLAGS: 00000292 ORIG_RAX: 0000000000000034
RAX: 0000000000000000 RBX: 00000000ffc3bea0 RCX: 0000000000000009
RDX: 00000000f73c3ff4 RSI: 00000000f7314361 RDI: 00000000ffc3cf44
RBP: 00000000ffc3bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


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

