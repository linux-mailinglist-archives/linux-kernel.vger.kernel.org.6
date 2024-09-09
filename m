Return-Path: <linux-kernel+bounces-320613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F42970CC6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 06:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655A21F22614
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 04:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28E11741C3;
	Mon,  9 Sep 2024 04:46:24 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A90136A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 04:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725857184; cv=none; b=PHyKLtD8G9DAnx/eJl4rAkPYZBuuzsIwkb4afOWQ1BkFzYMp5iavHzwr+IBYO8P1nT3E6q1iTxd84m2821F7q0jOq9Ue85aSyiF80TtF7RNvQC02MsYoFb6lJQwDswtE36v9PmiuQiDd+rIlBdYvxBn+Qi5zFQZKgrJ6C8IWi40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725857184; c=relaxed/simple;
	bh=92C2E5+9o6pmaZg/TdPwa/dtJXW16NKZZxoKAoW4Zas=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kDO0iGu3vtGR/zfuThrhDwRU/0BFJYQx01dDGjeR8ou4/fpDCckq7cnaC5v/87X7+AzyAFBdmRnQtjUAu0zYIfbWEqgPSiVY4h893w4jFTzYyl9AZiDJMO3v8qobp9ln96/YSJfLIguX1zGMWL2Va3cPX4VMUQO9kbMhxcEsCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-82aa9477f54so156352439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 21:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725857182; x=1726461982;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z44KlGI5geWB9wIOkTd4vLrshaHctXSZa0ihdr+NXLk=;
        b=G0Ii/50oAqQyRsbJwaAYDqUgwW2yEHDqpHZLZzd72JWNWIK5cw5fV1u28HLvFpWr2w
         i9E1giwago2xdmewnujlN4dk1Sfp42KtYS5JpUy9rdMWIxAUm8qy0kroNYdTjpeOiGCG
         JXS6fqsxKv5u6sOtoEvzEzyvdLB5KfKHI5jQw6tZx8l5HuytVwNX2T38qvlEjQtWnFB6
         4/6JDaq+voV/qI1h4bExdViQgC+J1fMrjyNrGsCuWbqiog0gjC0KoiyTZ2YQhWex6Z4K
         B3X0aoxslCmDVJUvbZeP7OiAHcaYUfIfM/Kz3bliPnTYumBf7WS19s+VqNYi1zhNcT9B
         /VuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpw3r0dkA9rmnbIp5c9iy9VZ2YDHrB3z94aKIbZQA+8dFY47OyLRaeYsCG9N8zPy4NsblgYCs9DmIlyNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGtn5R8A1H60QOzxCjb0BZSgsn3B7c+DOC+nJTgWXrHojrYnY
	ifNlkPfjXPwohCnSE9l4/vR5dcdD7Tela8gv0l4wJ3Z+sAvmpTgPPUuXzD+aWJ4H96+jq51rCRL
	OPGIo8xrZw/OElTsyMZv8QkP0YqKQAPWtTCVdehcZUjeOxwfgOXannXA=
X-Google-Smtp-Source: AGHT+IHVSIESyHlx93WnWnpOTBieriWYl9zQarQywTMa9tC1K6xR1qqu1QgHr8gCaeyctytDGQY5k0zPnvM2ZwYz84O3Pu4hOzqG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:f10:b0:82c:da1e:4ae7 with SMTP id
 ca18e2360f4ac-82cda1e4b2emr274715039f.2.1725857181865; Sun, 08 Sep 2024
 21:46:21 -0700 (PDT)
Date: Sun, 08 Sep 2024 21:46:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004228140621a87013@google.com>
Subject: [syzbot] [serial?] possible deadlock in tty_buffer_flush (3)
From: syzbot <syzbot+52cf91760dcb1dac6376@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c7fb1692dc01 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17ba5f33980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8524e833fed2d47b
dashboard link: https://syzkaller.appspot.com/bug?extid=52cf91760dcb1dac6376
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-c7fb1692.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c786784c3a2b/vmlinux-c7fb1692.xz
kernel image: https://storage.googleapis.com/syzbot-assets/21174af2f4f3/bzImage-c7fb1692.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52cf91760dcb1dac6376@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller-00048-gc7fb1692dc01 #0 Not tainted
------------------------------------------------------
kworker/1:2/1884 is trying to acquire lock:
ffff88801acb10b8 (&buf->lock){+.+.}-{3:3}, at: tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:229

but task is already holding lock:
ffffffff8dda7160 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x13/0x310 drivers/tty/vt/vt_ioctl.c:983

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (console_lock){+.+.}-{0:0}:
       console_lock+0x7a/0xa0 kernel/printk/printk.c:2735
       con_flush_chars+0x5e/0x80 drivers/tty/vt/vt.c:3503
       n_tty_write+0xe27/0x1150 drivers/tty/n_tty.c:2405
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write.constprop.0+0x518/0x9b0 drivers/tty/tty_io.c:1096
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0x6b6/0x1140 fs/read_write.c:590
       ksys_write+0x12f/0x260 fs/read_write.c:643
       do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
       __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
       do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (&tty->termios_rwsem){++++}-{3:3}:
       down_write+0x93/0x200 kernel/locking/rwsem.c:1579
       tty_unthrottle+0x1f/0x110 drivers/tty/tty_ioctl.c:103
       hci_uart_tty_receive+0x394/0x780 drivers/bluetooth/hci_ldisc.c:625
       tty_ldisc_receive_buf+0x153/0x190 drivers/tty/tty_buffer.c:391
       tty_port_default_receive_buf+0x70/0xb0 drivers/tty/tty_port.c:37
       receive_buf drivers/tty/tty_buffer.c:445 [inline]
       flush_to_ldisc+0x264/0x780 drivers/tty/tty_buffer.c:495
       process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&buf->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
       tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:229
       tty_ldisc_flush+0x64/0xe0 drivers/tty/tty_ldisc.c:388
       __do_SAK+0x6a1/0x800 drivers/tty/tty_io.c:3038
       vc_SAK+0x7f/0x310 drivers/tty/vt/vt_ioctl.c:993
       process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
       process_scheduled_works kernel/workqueue.c:3312 [inline]
       worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &buf->lock --> &tty->termios_rwsem --> console_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(console_lock);
                               lock(&tty->termios_rwsem);
                               lock(console_lock);
  lock(&buf->lock);

 *** DEADLOCK ***

4 locks held by kworker/1:2/1884:
 #0: ffff88801ac88948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x11f0/0x1ad0 kernel/workqueue.c:3206
 #1: ffffc9000ca8fd80 ((work_completion)(&vc_cons[currcons].SAK_work)){+.+.}-{0:0}, at: process_one_work+0x8bb/0x1ad0 kernel/workqueue.c:3207
 #2: ffffffff8dda7160 (console_lock){+.+.}-{0:0}, at: vc_SAK+0x13/0x310 drivers/tty/vt/vt_ioctl.c:983
 #3: ffff88801281e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref drivers/tty/tty_ldisc.c:263 [inline]
 #3: ffff88801281e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_flush+0x1c/0xe0 drivers/tty/tty_ldisc.c:386

stack backtrace:
CPU: 1 UID: 0 PID: 1884 Comm: kworker/1:2 Not tainted 6.11.0-rc6-syzkaller-00048-gc7fb1692dc01 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events vc_SAK
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x24ed/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 tty_buffer_flush+0x72/0x310 drivers/tty/tty_buffer.c:229
 tty_ldisc_flush+0x64/0xe0 drivers/tty/tty_ldisc.c:388
 __do_SAK+0x6a1/0x800 drivers/tty/tty_io.c:3038
 vc_SAK+0x7f/0x310 drivers/tty/vt/vt_ioctl.c:993
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
tty tty1: SAK: killed process 11375 (syz.3.1667): by fd#10


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

