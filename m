Return-Path: <linux-kernel+bounces-281931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7ED94DD1F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 15:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE721F218FA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2515A853;
	Sat, 10 Aug 2024 13:50:20 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE4B4502F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723297820; cv=none; b=b4SZ0RpWwv7KhDqzPl/cpvJ7YDWNjjU/hK/bKlf0HyfYFs+Hqk9tCInJ07C7sd0sWvqCApgAeh0PqRaZ5ciXQFr6ahPCQl9TmJL7CLrXsTn5tBzbepU4cj73+wJ8eNtDR/OgvgdLufuZUWo87vv8Ep4zAzOFLpZHzWGetDRBLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723297820; c=relaxed/simple;
	bh=lwb3aTcQtfFKv0UJt74kSXVIVWnGVAvk1pk+N2J4+kg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AVD8uYEzao6HEuxUZ1M763qetoGs+y4FtPdQxLwQfY56F5jgru9dczEtuFoi0bC27Fg3teL6kQo8EKgLLt/LF0/NapO/naDSxR4d6KMs71JVDuennGrJt4XYwUw3XBzOph9qk7Y5zfSadyCAEZKNyRZCJ70v/F0tERKE99vUEt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f968e53b0so360422239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 06:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723297818; x=1723902618;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6D3jhuhNYD4UqfJJiAUES3eK1Zy6ubaESxPy0rW0eG4=;
        b=BtL5EEyuFwmlVadLm1GVzTi+Xalcs5Q7W6ifIYU8P7Kwh/w4FvjWovk9oxrmx3K85d
         1Udlc0lNFdNptpxmsqLWZQBPBUi2KlBcoa4FuGa72BzgdG1Y7K5f1n9+m3BUNKiN1XjY
         DeEvCZF22gT4T4hjfCl1cXrsPckHBOcNVygN9kcScI8Ruz66oVldC6GlCpFeC9N9prxC
         GZzGkJNU5sIXuSy8UBSunrklLZsAV8hXREjSbDnFXS1+xNertQirLYy2knVW49UVloWH
         guu7DM03IfyLnJFgWz09p26blNnlzTHeuiliBNErFmW8WGEINB5gA0dSz7V1Fvu7W4ap
         eYqg==
X-Forwarded-Encrypted: i=1; AJvYcCV+FJyZz3utmF5sqTZiboHGZ0Hv95pmZs7gZnYKYrS7by846rw3AJ7dLLbTwZF6+WmgotdxeN/avzwlLFm1BgK6aqpgtqFP56u4fD5A
X-Gm-Message-State: AOJu0YwbxxeB7LNxJRb/D7yEHD7Dha6KUibW3mnfIiih3P3dYoItCFj7
	FY3rEaxN4XnqLd6MZg9+psslWSYLMBOGURoJPZn3WRDv2yaX1y381nys9lO+Pw0pioQGQpBaJb8
	r7zXWxVyiBheff55i9V8n3CCO8YIP7ns0Y7krzzt1+sWRU7ORgCeSZ3A=
X-Google-Smtp-Source: AGHT+IFHQYLjt/fcJ+3dxYIAUaSzylPUjgfgrICf1obOnTyXBeTS5Lmum47SC0EaVIvCUdp+qIcMgxR4/0gGaMBcUXdGllsqLd6H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2726:b0:4c0:9a3e:c259 with SMTP id
 8926c6da1cb9f-4ca6edc901cmr223439173.5.1723297817714; Sat, 10 Aug 2024
 06:50:17 -0700 (PDT)
Date: Sat, 10 Aug 2024 06:50:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004475f6061f548a43@google.com>
Subject: [syzbot] [usb?] possible deadlock in __flush_workqueue (2)
From: syzbot <syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com>
To: arnd@arndb.de, eli.billauer@gmail.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b446a2dae984 Merge tag 'linux_kselftest-fixes-6.11-rc3' of..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1253e123980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=e528c9aad0fb5383ec83
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a6bd23980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b175e3980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dfb1bb3422ba/disk-b446a2da.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/af839611c6d9/vmlinux-b446a2da.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b99bed56482e/bzImage-b446a2da.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.11.0-rc2-syzkaller-00004-gb446a2dae984 #0 Not tainted
--------------------------------------------
kworker/0:1H/58 is trying to acquire lock:
ffff88802c60a148 ((wq_completion)xillyusb){+.+.}-{0:0}, at: touch_wq_lockdep_map kernel/workqueue.c:3876 [inline]
ffff88802c60a148 ((wq_completion)xillyusb){+.+.}-{0:0}, at: __flush_workqueue+0x1b0/0x1710 kernel/workqueue.c:3918

but task is already holding lock:
ffff88802c60a148 ((wq_completion)xillyusb){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
ffff88802c60a148 ((wq_completion)xillyusb){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((wq_completion)xillyusb);
  lock((wq_completion)xillyusb);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by kworker/0:1H/58:
 #0: ffff88802c60a148 ((wq_completion)xillyusb){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802c60a148 ((wq_completion)xillyusb){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000133fd00 ((work_completion)(&xdev->wakeup_workitem)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000133fd00 ((work_completion)(&xdev->wakeup_workitem)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312

stack backtrace:
CPU: 0 UID: 0 PID: 58 Comm: kworker/0:1H Not tainted 6.11.0-rc2-syzkaller-00004-gb446a2dae984 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Workqueue: xillyusb wakeup_all
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3855
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 touch_wq_lockdep_map kernel/workqueue.c:3876 [inline]
 __flush_workqueue+0x1c9/0x1710 kernel/workqueue.c:3918
 drain_workqueue+0xc9/0x3a0 kernel/workqueue.c:4082
 destroy_workqueue+0xba/0xc40 kernel/workqueue.c:5781
 cleanup_dev drivers/char/xillybus/xillyusb.c:558 [inline]
 kref_put+0x104/0x180 include/linux/kref.h:65
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
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

