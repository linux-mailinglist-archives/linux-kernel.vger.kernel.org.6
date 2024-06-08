Return-Path: <linux-kernel+bounces-207128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E7D9012B0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 18:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D9D1F21828
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F67717995A;
	Sat,  8 Jun 2024 16:12:34 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1461DA5F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717863153; cv=none; b=UTINB3LPN6VuStFCSwWrGegTM57COLWQ3wYqvfZiYLgQ0f6sr4c+5/1u8tmQ7kqYATl47Klu2sd0RIT6pM9jwnMyDh0M513cAwlKogl3gNouHq0zFSfKxYw+wmIHjEWu3n+5N5nwAM4seAOh5StNOzznbqmSD/5bxg4711fVPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717863153; c=relaxed/simple;
	bh=ESjO9BCz6Qqt2T+vMXVXtCWaCLLgz+dfRZwslkC8UwU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GjnKZwf1BHJQAsMaLeFgQSn/XuyeBkCd9OYE34ut/pqTLCbt2Kx7x7WDhksR96OuLCIprM49MFSKFWrCYZVSQ1kX0BS4wR8uKbj7pfYnqtO/EX/imep8XuKJPH7/x4dTUn5SgERu27Q6Sfcz/0WmiBBkVdPOGwAkhBejIr7x7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3745fb76682so32324445ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2024 09:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717863151; x=1718467951;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tk5GbmyiMvxlYvX+q1VR0ktSf1neeTNiEoQUv7xtkW8=;
        b=PqH2SAzLFwHTp6Ijso8CvRb5Ik/Cowonx/nzH/sLrSmGWz5wMpBO2VAHHVNUVtfOqt
         1vga9zr4VzANJMJx8aWkru4JzXbgA3iynefWr8/RVvd9wz68kycxPfzYswIw/EO5vhFl
         1rVWRML7R9HbujRg/HzE3FVImkqWPMyrJaRRvp+8mO+Kmx69ByXENbhvSrEk44Zjip4W
         +HNuMMh/FBxAiVXP/ZaTVhHaE7XjeEvpAalNryWeUVlCX6lzOAB2pUNRBrrCpA7NKfaw
         LNcYHk8f42wu9eJukWmTWCgPnWOrraLBT3Y0x35Vl2zavClljQoCGMacKUMM0Z7Iem30
         4QHA==
X-Forwarded-Encrypted: i=1; AJvYcCVFvK+cexXzQXA1e1/FbtPvmRKdiqIkOngmotKdujAYzmQIGAz95CbfLuyJnZWKmVi6x7vc+sywn0IHQa6JGMbPmAGG17vfumRnuE4S
X-Gm-Message-State: AOJu0YzA1uAkFG/Or8hLqY5A1/LYzOAEgb2+mfsR8D2FCPWRw/h2Y7ez
	ohQkkq1Ni8wozwAZX3gz9ouy6ODQqC8M0TeM1a7HKgQBcGkoJjxhkFl04Ks6bFKjegERqq6f8Ds
	NRBuonSrYmIAKut7ivAbN1FSROuhYpQyfyVcrz0InsfkuDtY+c4/y4pQ=
X-Google-Smtp-Source: AGHT+IECGiuYtCZxZHm2Gqol8LeAkPTSNxzQCgmmp58SkPjFZtO3i+StuzUtB2H/j5kmiFOPtvVALzxDtlioWIVDWZCl8wX59Ezx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c70e:0:b0:375:9e28:49b with SMTP id
 e9e14a558f8ab-3759e280992mr6425ab.2.1717863151181; Sat, 08 Jun 2024 09:12:31
 -0700 (PDT)
Date: Sat, 08 Jun 2024 09:12:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e631fc061a632eae@google.com>
Subject: [syzbot] [kernel?] WARNING: locking bug in __schedule
From: syzbot <syzbot+46b40e354b532433eeef@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dc772f8237f9 Merge tag 'mm-hotfixes-stable-2024-06-07-15-2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1422da8c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=46b40e354b532433eeef
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3700030c3c13/disk-dc772f82.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e238e5fcc97d/vmlinux-dc772f82.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3ee78908acdd/bzImage-dc772f82.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46b40e354b532433eeef@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 11576 at kernel/locking/lockdep.c:232 hlock_class kernel/locking/lockdep.c:232 [inline]
WARNING: CPU: 1 PID: 11576 at kernel/locking/lockdep.c:232 check_wait_context kernel/locking/lockdep.c:4773 [inline]
WARNING: CPU: 1 PID: 11576 at kernel/locking/lockdep.c:232 __lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Modules linked in:
CPU: 1 PID: 11576 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syzkaller-00315-gdc772f8237f9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:232 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4773 [inline]
RIP: 0010:__lock_acquire+0x573/0x1fd0 kernel/locking/lockdep.c:5087
Code: 00 00 83 3d 6e 0c 3b 0e 00 75 23 90 48 c7 c7 20 ba ca 8b 48 c7 c6 c0 bc ca 8b e8 78 e4 e5 ff 48 ba 00 00 00 00 00 fc ff df 90 <0f> 0b 90 90 90 31 db 48 81 c3 c4 00 00 00 48 89 d8 48 c1 e8 03 0f
RSP: 0018:ffffc90015a375b0 EFLAGS: 00010046
RAX: 7003b597e2d67b00 RBX: 0000000000000e50 RCX: ffff888020a60000
RDX: dffffc0000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff815857a2 R09: fffffbfff1c39994
R10: dffffc0000000000 R11: fffffbfff1c39994 R12: 0000000000000001
R13: ffff888020a60000 R14: 0000000000000000 R15: ffff888020a60b00
FS:  0000555579285480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3022f000 CR3: 000000001cbf6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0xb0/0x140 kernel/sched/core.c:567
 raw_spin_rq_lock kernel/sched/sched.h:1406 [inline]
 rq_lock kernel/sched/sched.h:1702 [inline]
 __schedule+0x357/0x4a20 kernel/sched/core.c:6653
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6924
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6948
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
 hrtimer_start_expires include/linux/hrtimer.h:289 [inline]
 hrtimer_sleeper_start_expires kernel/time/hrtimer.c:1949 [inline]
 do_nanosleep+0x158/0x600 kernel/time/hrtimer.c:2025
 hrtimer_nanosleep+0x227/0x470 kernel/time/hrtimer.c:2081
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
 __se_sys_clock_nanosleep+0x32d/0x3c0 kernel/time/posix-timers.c:1373
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc521ca8375
Code: 24 0c 89 3c 24 48 89 4c 24 18 e8 f6 b9 ff ff 4c 8b 54 24 18 48 8b 54 24 10 41 89 c0 8b 74 24 0c 8b 3c 24 b8 e6 00 00 00 0f 05 <44> 89 c7 48 89 04 24 e8 4f ba ff ff 48 8b 04 24 48 83 c4 28 f7 d8
RSP: 002b:00007ffdb0499ff0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: ffffffffffffffda RBX: 0000000000000052 RCX: 00007fc521ca8375
RDX: 00007ffdb049a030 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffdb049a0ac R08: 0000000000000000 R09: 7fffffffffffffff
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000032
R13: 0000000000095a92 R14: 0000000000095a43 R15: 0000000000000001
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

