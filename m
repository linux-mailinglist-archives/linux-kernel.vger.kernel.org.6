Return-Path: <linux-kernel+bounces-244751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB1892A8EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D421F21DFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A24279FD;
	Mon,  8 Jul 2024 18:22:29 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05291494A9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462948; cv=none; b=DIE4HlTrUiDDW5fzu9eMxZ+yhgMvQwDytTPlQbHkCovtiuSRWN9eVNPKLZsLWIQGQWQBA72CAAkZqODLhnt3eYl9+VsTG89bBZVNiAYFwIWDjfOk8+EOH3UHkISSiqAohobUITw3R3IlHCfLxOq5nQdVAS2xfqDch5fuugGXdb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462948; c=relaxed/simple;
	bh=aRGDC6gmTgQfGpcwiYAT3srhL18Ir47s2Glp7oGqeFA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RV8iAeV6AP/yANAkMBYZ5rkp2vA7ViJ8++RSqdEXHCQwjd9dp/19UrJLaKH4GO1z03hTcZ11NcX/ivDgfSkItMuiyDXQdsEQmuSKp5hbbbv21sJCXBsQTewqZ9rKaJbAsc7mpHmmtxgWQQwjTnW8FQccxC/41Z0eiObRFAKtW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ebd11f77d8so560526139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 11:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462945; x=1721067745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVplHr4x3Pa02WuXA0IeXUifs8VKkHRpgLGdCbMIJPU=;
        b=s5jyUTOmlgwELUieInq0MYojl82WWZ6dSgD3WeG5WXMcQZAHyxVhXRoCk5ZDBEFZa+
         QUrwrGd6JGhhbBN9DgEA9tBPxhhp2slEOud0AlrdecqKVzjZIOlqdeNy1LPZrcSf+aJn
         tiwApsQWobiXuL2byEFhy9t95Zw8x6fP4+Usar4YDr04rHmdsGLp+poVGwi0NVwe6gzR
         xTRLTphvOKKZEoln4RxgNUmYlPxUupjtQ72uUZPf33vWPdKYcHmgh8MNFwokuo8bIq+q
         OezjHa5IkxL3yj+sii0SUozwuWe3KyHl+Gha9FHghtfOnTfFUXHEBk+6mCfpQ2KAo29w
         pNYw==
X-Forwarded-Encrypted: i=1; AJvYcCU3DeZugUWhybQ3eLEKInDP2lscQBJD0utvCsfBCO9X+H8oeIOa2B6q55ADHtx744Kusy0IJ7K9Vq9adWOi3GeSzswQ7VHoMsBp+6xL
X-Gm-Message-State: AOJu0YzEsnonnupgdpn3T4iAumA5empdgPTvxug1sv/iG/0Uc3h9Ek1W
	9B4QyNhQcUVhTZVb1n5M9koj4BpyMGVqdB2uMVTfsaurk7jDfdu9drNDbHpSAjphJLQjQ+KkESO
	4ljlCtRjbV8SrUVtx3kjIgS8rq7tTzl8DZTzGULTVeTn4Hq5cQZUgBVU=
X-Google-Smtp-Source: AGHT+IF39g0hBFHd7X+jwRYDyZL6ruwP3QAzOIRZhd7W/PuSIMV1ZtlecqyqLtPEmN2SCAQtp/CzJNqBeKOqiYLwyPsJAcZAZJA9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:6a11:0:b0:375:da97:f21a with SMTP id
 e9e14a558f8ab-38a5901530dmr63835ab.3.1720462944940; Mon, 08 Jul 2024 11:22:24
 -0700 (PDT)
Date: Mon, 08 Jul 2024 11:22:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aecb64061cc07e9b@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in sco_connect_cfm
From: syzbot <syzbot+0068c4f72ae17f8a1605@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d270dd21bee0 Merge tag 'pci-v6.10-fixes-2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1009bb81980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=0068c4f72ae17f8a1605
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/119d89656b6c/disk-d270dd21.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a5dce1ccbf0/vmlinux-d270dd21.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7b7e333da4e/bzImage-d270dd21.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0068c4f72ae17f8a1605@syzkaller.appspotmail.com

Bluetooth: hci6: unexpected cc 0x0c03 length: 249 > 1
Bluetooth: hci6: unexpected cc 0x1003 length: 249 > 9
======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-syzkaller-00210-gd270dd21bee0 #0 Not tainted
------------------------------------------------------
kworker/u9:2/5087 is trying to acquire lock:
ffff88807ad7a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1602 [inline]
ffff88807ad7a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_conn_ready net/bluetooth/sco.c:1290 [inline]
ffff88807ad7a258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x461/0xb40 net/bluetooth/sco.c:1362

but task is already holding lock:
ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: sco_conn_ready net/bluetooth/sco.c:1277 [inline]
ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: sco_connect_cfm+0x28a/0xb40 net/bluetooth/sco.c:1362

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&conn->lock#2){+.+.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       sco_chan_add net/bluetooth/sco.c:234 [inline]
       sco_connect net/bluetooth/sco.c:287 [inline]
       sco_sock_connect+0x347/0x990 net/bluetooth/sco.c:596
       io_connect+0xa4/0x4f0 io_uring/net.c:1687
       io_issue_sqe+0x3cf/0x14f0 io_uring/io_uring.c:1751
       io_queue_sqe io_uring/io_uring.c:1965 [inline]
       io_submit_sqe io_uring/io_uring.c:2221 [inline]
       io_submit_sqes+0xaff/0x1bf0 io_uring/io_uring.c:2336
       __do_sys_io_uring_enter io_uring/io_uring.c:3245 [inline]
       __se_sys_io_uring_enter+0x2d4/0x2670 io_uring/io_uring.c:3182
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       lock_sock_nested+0x48/0x100 net/core/sock.c:3534
       lock_sock include/net/sock.h:1602 [inline]
       sco_conn_ready net/bluetooth/sco.c:1290 [inline]
       sco_connect_cfm+0x461/0xb40 net/bluetooth/sco.c:1362
       hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
       hci_sync_conn_complete_evt+0x5ab/0xaa0 net/bluetooth/hci_event.c:5009
       hci_event_func net/bluetooth/hci_event.c:7444 [inline]
       hci_event_packet+0xac0/0x1540 net/bluetooth/hci_event.c:7496
       hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4042
       process_one_work kernel/workqueue.c:3248 [inline]
       process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
       worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&conn->lock#2);
                               lock(sk_lock-AF_BLUETOOTH-BTPROTO_SCO);
                               lock(&conn->lock#2);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_SCO);

 *** DEADLOCK ***

5 locks held by kworker/u9:2/5087:
 #0: ffff8880764d1948 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3223 [inline]
 #0: ffff8880764d1948 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3329
 #1: ffffc9000377fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3224 [inline]
 #1: ffffc9000377fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3329
 #2: ffff88802d30c078 (&hdev->lock){+.+.}-{3:3}, at: hci_sync_conn_complete_evt+0xb1/0xaa0 net/bluetooth/hci_event.c:4926
 #3: ffffffff8f73f008 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1967 [inline]
 #3: ffffffff8f73f008 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_sync_conn_complete_evt+0x532/0xaa0 net/bluetooth/hci_event.c:5009
 #4: ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #4: ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: sco_conn_ready net/bluetooth/sco.c:1277 [inline]
 #4: ffff8880274ab820 (&conn->lock#2){+.+.}-{2:2}, at: sco_connect_cfm+0x28a/0xb40 net/bluetooth/sco.c:1362

stack backtrace:
CPU: 1 PID: 5087 Comm: kworker/u9:2 Not tainted 6.10.0-rc6-syzkaller-00210-gd270dd21bee0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 lock_sock_nested+0x48/0x100 net/core/sock.c:3534
 lock_sock include/net/sock.h:1602 [inline]
 sco_conn_ready net/bluetooth/sco.c:1290 [inline]
 sco_connect_cfm+0x461/0xb40 net/bluetooth/sco.c:1362
 hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
 hci_sync_conn_complete_evt+0x5ab/0xaa0 net/bluetooth/hci_event.c:5009
 hci_event_func net/bluetooth/hci_event.c:7444 [inline]
 hci_event_packet+0xac0/0x1540 net/bluetooth/hci_event.c:7496
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4042
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
BUG: sleeping function called from invalid context at net/core/sock.c:3536
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5087, name: kworker/u9:2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 5087 Comm: kworker/u9:2 Not tainted 6.10.0-rc6-syzkaller-00210-gd270dd21bee0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 __might_resched+0x5d4/0x780 kernel/sched/core.c:10196
 lock_sock_nested+0x5d/0x100 net/core/sock.c:3536
 lock_sock include/net/sock.h:1602 [inline]
 sco_conn_ready net/bluetooth/sco.c:1290 [inline]
 sco_connect_cfm+0x461/0xb40 net/bluetooth/sco.c:1362
 hci_connect_cfm include/net/bluetooth/hci_core.h:1970 [inline]
 hci_sync_conn_complete_evt+0x5ab/0xaa0 net/bluetooth/hci_event.c:5009
 hci_event_func net/bluetooth/hci_event.c:7444 [inline]
 hci_event_packet+0xac0/0x1540 net/bluetooth/hci_event.c:7496
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4042
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3329
 worker_thread+0x86d/0xd50 kernel/workqueue.c:3409
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Bluetooth: hci6: unexpected cc 0x0c23 length: 249 > 4


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

