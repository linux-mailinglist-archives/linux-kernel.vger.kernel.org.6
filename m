Return-Path: <linux-kernel+bounces-177595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465968C413E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1360281B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A871509A3;
	Mon, 13 May 2024 12:58:23 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2D14C5A9
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605103; cv=none; b=KqsyFjYzw7KY4KcZMqe2XNCvLmWeOCEldZwhtqsV64R5vO4eOiUzWbyW7R8DZDhBgb7SGpY2tT9aR2X3g9i+xtRnxUBVfnr/yl9ND/uBduV/oBSctBln3l7azDI0tpE06vvwkULHmA3mg5IrCc5jc6gtLjRBbo7d1P+5iqgf+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605103; c=relaxed/simple;
	bh=IE8DaxbjJRoYOg4AYdOkTSTG3CQ2skc41p2xm2nUpsI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U8nV1dldUQ/AXrYP5WfHJHByi5z+kuxGA7hMy8Le81cKbT7Jex5qIji9WL6FK2cLfoVDXmu4G7ljG0nathjdK+ExlyY8S40gSj2B8LCDoeNwts6GhH1jhHINgk+f8lnRMqaM8DM7asqlFhqzQ63/mC9LgKsZHr6CaSNKRm2K1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e1d56d36b9so225006439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 05:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715605101; x=1716209901;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jUh8gBztzWJvC/HyizR2vWoX3TSaVXHf22Bh1kUGI/k=;
        b=Ny+n/2vXlvwNvPuvBA/XjfbyfgKwqTH4A+8REV2+JpBnNu0sunuEy/RCIlbhooCzxw
         WGXZkAzq7XL8tGbiq+ItPYkXq+7WUe1enwHIjRdNey/22g6cI1DKpdxqncHp9hmWS4GD
         E/o6Dh9j1mvc9cGGf9P5jiLldyxzaojBuj1zjzXvEmvXlOvprwVnbaR1REmDeG5I7650
         dRvZfSL2O0ioUMsiVwvyF5f+aYwxY2TLYhkDlth8vXoTDMJuxqeDbyCE/R5HqW0GNn7r
         GlNrOB5vd35w2t3/Yonr5Mv/GRRMhb7Sfd0MiQCDhWUD13YJ8sxdiEQ9JspQYPi1LIQX
         DCDg==
X-Forwarded-Encrypted: i=1; AJvYcCVZLOG8tIj1nHavsgVfHsmAYuzIPjQeY0AKluq06gi4lwvhlp3tmBD6wQS73s5XPOJI1asB38gV+lK/FOKviv0PldJ/iQL4+31hIBY1
X-Gm-Message-State: AOJu0Yw6b1p2pYMJWPGdH0bwYMkVTrsBIys2KCH603UtTZlaKOfRp9Eb
	c70qQDZSdJrQ4KOXn1mosxMd0ylU8QLUGxtdfNYFFVHcSkbmOcX+UnsWLLlm847jeHBy4oVeaMR
	OHOrDJmHk8gi1wEElulyRURqHmk5meZdiF2kI6vNwbtwQtVsyjVyyl9I=
X-Google-Smtp-Source: AGHT+IFGhHQy8qWVYLOzFy9GtxVqEnahe0TRCxrZDiwQqCoYgw+Qx5tP6fQE68QDfaLEEUpMvdfMdJX/NvF2g6KZ08hQXF25zDH6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b08:b0:7de:8cc5:fd1 with SMTP id
 ca18e2360f4ac-7e1b521bcacmr48672139f.3.1715605101025; Mon, 13 May 2024
 05:58:21 -0700 (PDT)
Date: Mon, 13 May 2024 05:58:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f2fe006185570d8@google.com>
Subject: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in lock_sock_nested (3)
From: syzbot <syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1c9135d29e9e Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10df1ea8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d2d53e64c7e6a4f
dashboard link: https://syzkaller.appspot.com/bug?extid=55cd5225f71c5cff7f6f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/52dd1b4921ab/disk-1c9135d2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a4f1788dc25/vmlinux-1c9135d2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b8d8ebd42a80/Image-1c9135d2.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at net/core/sock.c:3537
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6274, name: kworker/u9:3
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
6 locks held by kworker/u9:3/6274:
 #0: ffff0000d8c79948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x668/0x15d4 kernel/workqueue.c:3241
 #1: ffff8000a9cb7c20 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0x6b4/0x15d4 kernel/workqueue.c:3241
 #2: ffff0000e8294078 (&hdev->lock){+.+.}-{3:3}, at: hci_sync_conn_complete_evt+0xa4/0x870 net/bluetooth/hci_event.c:5061
 #3: ffff800091d51708 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:2010 [inline]
 #3: ffff800091d51708 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_sync_conn_complete_evt+0x3d4/0x870 net/bluetooth/hci_event.c:5144
 #4: ffff0000d0bf4420 (&conn->lock#2){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #4: ffff0000d0bf4420 (&conn->lock#2){+.+.}-{2:2}, at: sco_conn_ready net/bluetooth/sco.c:1273 [inline]
 #4: ffff0000d0bf4420 (&conn->lock#2){+.+.}-{2:2}, at: sco_connect_cfm+0x260/0x94c net/bluetooth/sco.c:1358
 #5: ffff0000cd046258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1673 [inline]
 #5: ffff0000cd046258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_conn_ready net/bluetooth/sco.c:1286 [inline]
 #5: ffff0000cd046258 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x3e8/0x94c net/bluetooth/sco.c:1358
Preemption disabled at:
[<ffff80008a0d70d4>] spin_lock include/linux/spinlock.h:351 [inline]
[<ffff80008a0d70d4>] sco_conn_ready net/bluetooth/sco.c:1273 [inline]
[<ffff80008a0d70d4>] sco_connect_cfm+0x260/0x94c net/bluetooth/sco.c:1358
CPU: 0 PID: 6274 Comm: kworker/u9:3 Not tainted 6.9.0-rc7-syzkaller-g1c9135d29e9e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: hci0 hci_rx_work
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 __might_resched+0x374/0x4d0 kernel/sched/core.c:10197
 __might_sleep+0x90/0xe4 kernel/sched/core.c:10126
 lock_sock_nested+0x6c/0x11c net/core/sock.c:3537
 lock_sock include/net/sock.h:1673 [inline]
 sco_conn_ready net/bluetooth/sco.c:1286 [inline]
 sco_connect_cfm+0x3e8/0x94c net/bluetooth/sco.c:1358
 hci_connect_cfm include/net/bluetooth/hci_core.h:2013 [inline]
 hci_sync_conn_complete_evt+0x438/0x870 net/bluetooth/hci_event.c:5144
 hci_event_func net/bluetooth/hci_event.c:7545 [inline]
 hci_event_packet+0x740/0x1098 net/bluetooth/hci_event.c:7597
 hci_rx_work+0x318/0xa78 net/bluetooth/hci_core.c:4171
 process_one_work+0x7b8/0x15d4 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3348 [inline]
 worker_thread+0x938/0xef4 kernel/workqueue.c:3429
 kthread+0x288/0x310 kernel/kthread.c:388
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Bluetooth: hci0: command tx timeout


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

