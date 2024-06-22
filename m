Return-Path: <linux-kernel+bounces-225754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945039134D7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 17:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48BF1C20CBF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9F716F270;
	Sat, 22 Jun 2024 15:30:24 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05C52566
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719070224; cv=none; b=pC9RJ8J/a6T6jsmbQHIpBfDy6NQSYYwQpOtn3UhfGbyJWQpzo7sf5qrnRDdDDJbVeXj14G6vu1g97+mEU/WCFJow09P2Bmo52+2quTQ6wxf8ekBBuOmg6GRWMHTizcb2N7OFp75Y7fn/CYO0QwbEVJAyTxb0zWhbQVt+YsNiz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719070224; c=relaxed/simple;
	bh=j+/n13l83r3s/4Ja1RsVvOkkoYJ8azAlghTtB1Mux10=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tL1exL/W1Ve0DHXQVVzwBs4UncdZKIjo3lhdVips2uApCsejvZz5R9GuHB4pb4MowxPkP57Le8qIqDMhWUWdedVh6Ng+h5a95OEHfpKIgx4AnGgysLr7jSXWTh+Wl8Xzm1mn4wMehDM3dFj9sg6O/OgD90pOEms9DzW5O0/Qnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3745fb76682so32544065ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 08:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719070222; x=1719675022;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KpEGAHLB+8jFjyGGstwW/RZcwRs9r2dzcOSAttjx/oA=;
        b=BmbbcS8MriyGRBU3CZX3pHqF3Y4QHZTjyVOsv3JReQeLTp7BrhOX++e752LmyQ3uqh
         bEA85yiAOMvOO30HKjQSP1Hii5/8iuwYfeHRhgoIp8DkRl9GqQOZpCNIUmeDvJZZGYJ6
         jvLuQcVpV5woD271fSpEXlM0O0talDXzFCGYVaKgXKHAc/dpTvPzWnM1M45NGvxlGvyk
         vEWHrmDZYB2r03W+ALGOhghXlXIsGa65VkUtAPfPB1PdxGYMAz79KJ7fEaeLRQ8qhOqz
         WRRGIORO2TDmzxTVKg6zGGlNWp1Tb6suTeFdrE93KNrJCqU25oILCLXU+tV7Vb47GP2W
         Kztw==
X-Forwarded-Encrypted: i=1; AJvYcCWI6AxdgV+pnE/rg6EwMJTCr3O8sG3Yr9IrkwKAH6fLssUXXIuG7gSWzZdC73ffxu16tX8PKora9mMIVhone5J4Ehqc+e0vsrIy1unb
X-Gm-Message-State: AOJu0YyUOWU41l6hOfnhM3smgaVBbPfzUwg0ma6ebTbVGFL83CQKq8MY
	6wyZsyQYnfScuMHaoVDIPWbgRG+7WZyGoMx7Q4jVTuVxMKbjmZgrSmU8SZ70iQQS0RdWbyl4Ntk
	yqyBAvjU1iZMd7bLHDJahUiZ05LqoyfOKv6gcXv2TgOxs6yQFt37EvZM=
X-Google-Smtp-Source: AGHT+IFeCF/+AiqgAk/3T9ec4f3Lqzt9TcDVB4ib33pINGk0U7M6oqDH0Ci9tGMRkKCun+sXdI6H+1O6dhGy+NyluuteIAJh8tMm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c05:b0:36c:5c1b:2051 with SMTP id
 e9e14a558f8ab-3763f73e127mr155715ab.6.1719070221787; Sat, 22 Jun 2024
 08:30:21 -0700 (PDT)
Date: Sat, 22 Jun 2024 08:30:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e9f492061b7c395d@google.com>
Subject: [syzbot] [jfs?] INFO: task hung in release_metapage
From: syzbot <syzbot+da0d64d32c4c7c260241@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50736169ecc8 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d6542a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f7b9f99610e0e87
dashboard link: https://syzkaller.appspot.com/bug?extid=da0d64d32c4c7c260241
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e84bbefe6d05/disk-50736169.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf683a0b0373/vmlinux-50736169.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7d4bbef078b/bzImage-50736169.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da0d64d32c4c7c260241@syzkaller.appspotmail.com

INFO: task syz-executor.5:18905 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:24824 pid:18905 tgid:18889 ppid:16728  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x17e8/0x4a20 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6837
 io_schedule+0x8d/0x110 kernel/sched/core.c:9043
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1307
 release_metapage+0x8c/0x870 fs/jfs/jfs_metapage.c:764
 discard_metapage fs/jfs/jfs_metapage.h:88 [inline]
 __get_metapage+0xb1d/0x1050 fs/jfs/jfs_metapage.c:644
 jfs_readdir+0x2945/0x4660 fs/jfs/jfs_dtree.c:3018
 wrap_directory_iterator+0x96/0xe0 fs/readdir.c:67
 iterate_dir+0x660/0x820 fs/readdir.c:110
 __do_sys_getdents fs/readdir.c:326 [inline]
 __se_sys_getdents+0x1ef/0x4d0 fs/readdir.c:311
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe47c07cf29
RSP: 002b:00007fe47bbff0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007fe47c1b4050 RCX: 00007fe47c07cf29
RDX: 00000000000000b8 RSI: 0000000020001fc0 RDI: 0000000000000007
RBP: 00007fe47c0ec074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fe47c1b4050 R15: 00007ffeaf0ba1c8
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:0/11:
 #0: ffff888015081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015081148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90000107d00 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90000107d00 ((work_completion)(&map->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
1 lock held by khungtaskd/30:
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
4 locks held by kworker/u8:7/1063:
2 locks held by getty/4852:
 #0: ffff88802b1770a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
3 locks held by syz-executor.4/10317:
3 locks held by syz-executor.1/15396:
3 locks held by kworker/1:8/16877:
 #0: ffff888015078948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015078948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009697d00 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009697d00 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff88805ca9e240 (&data->fib_lock){+.+.}-{3:3}, at: nsim_fib_event_work+0x2d1/0x4130 drivers/net/netdevsim/fib.c:1489
2 locks held by syz-executor.5/18905:
 #0: ffff88807ea5b748 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x310 fs/file.c:1191


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

