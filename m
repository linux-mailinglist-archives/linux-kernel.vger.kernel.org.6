Return-Path: <linux-kernel+bounces-248432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C1592DD19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82073283FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD73B14C583;
	Wed, 10 Jul 2024 23:45:22 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E2D63A5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655122; cv=none; b=eozb81IESGqw9lLYEFFOfuuMzmCJycGRlAoLtstLo2ioLD6QTXPbukFwm8pvhurs0I06nAqCDKmKvveX9r+pgl5e/jFQq2aqvDg77bHuN0ugFV+SJ/WvsIAWwCA0FoSZdKaQGs/0kfL6PdORRBPlkPflQ924ijoRNPoDniB/jU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655122; c=relaxed/simple;
	bh=ppd6gWks0aUEmhroV6/A0palDKJ5Nb1FUPca03Afuqg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rHYwMkmAQZDpiznEVzyIMPbkiM1j9022xM52UNWLO3ofrPVWL4Z+Jhgf1E94GlrD7za8vGWV+KBVBviNruXlpMwsuyni61SGV3b+UykNEYME0AuI7aYNXvr5o1ElqPyKs2gMxyJ8aNP0dr7nRStha4YvUWFXh8oRHTg+edgPuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8045e14c387so47961939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720655119; x=1721259919;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/dRzecO4TXDSgIVqu9c62mv7YdSRVfiDzRyV5wH5tw=;
        b=rE660ixbDZeglN37YwbhcY6WarYO7BoHcJnnDmHePNwJ/1vFQMUID0WUWUV3EbG8hd
         GsKhNYTNgifaattCoWh1Bf2C4zMrKFMLZleS+3L9Sq94wTVLDwEAFz2Rnxd4pxFHeCIm
         fwwnOr6rpI0PcgkMAvy73Uw5a4TpQWVsE4Kebt+L/RuA8YTdF60SO8zxH6quy39Qd3qU
         t+sYw8CndmHHO368uy9yTmdmwYSV99vfLVSxVXHqcGKCkIyd7dktzRnS8nnEamlg7yp9
         ALDnm8GAl988caHVl5ZuEyR7HSmMDPixl8lNOvN693XUqN8eAfVRcp7kZfjkV+AV1amY
         TH+A==
X-Forwarded-Encrypted: i=1; AJvYcCX5xX4x9SItETJBFOwjL8pH/p3iq+h1Q3CIN2TMi3iz+gu/zhufBeuKd3YFVmQqXM/aP2ciolLZJ1Y5OMT5yttRGd1ww8ukBDclSd1A
X-Gm-Message-State: AOJu0Ywv+VWVo12hTKjbS0pgxpOeKCwr+7AsrC9jinL4oaDHGhnPFZRl
	Ng+79sS8/Puhwq4hstf1eXW5BzI/tyyr3/c+GjAisWG6JGjkATT8kaLzED6aVjzX5HMuoi+C6jd
	CHqTDNmWbsXTxYLBSuEdUvzIigg89MtfwsGTmEtZNmkdShAn4rFNj7UI=
X-Google-Smtp-Source: AGHT+IGwWFUwyrJeI0U0jvO8sayv9TBTSx9h3lH4d/F2Orezba9DpEgW1Z6mlwU8xCdMCdR4euTEyZF8+jG6uuDiBK7HkyBN/0m8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1693:b0:4c0:9a3e:c259 with SMTP id
 8926c6da1cb9f-4c0b2b8f692mr504474173.5.1720655119626; Wed, 10 Jul 2024
 16:45:19 -0700 (PDT)
Date: Wed, 10 Jul 2024 16:45:19 -0700
In-Reply-To: <00000000000031fb62061cc4c118@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fcc8d061ced3d52@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: workqueue leaked atomic, lock or RCU: kworker/u9:NUM[NUM]
From: syzbot <syzbot+733a96463546d3026b60@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ef445d1539dd Merge remote-tracking branches 'origin/arm64-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1544df69980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79a49b0b9ffd6585
dashboard link: https://syzkaller.appspot.com/bug?extid=733a96463546d3026b60
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13768021980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176e2c7e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76e73f830dca/disk-ef445d15.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d54cbf6f6ee2/vmlinux-ef445d15.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9240e4c79dfc/Image-ef445d15.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+733a96463546d3026b60@syzkaller.appspotmail.com

BUG: workqueue leaked atomic, lock or RCU: kworker/u9:0[52]
     preempt=0x00000000 lock=0->1 RCU=0->0 workfn=hci_rx_work
1 lock held by kworker/u9:0/52:
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_conless_channel net/bluetooth/l2cap_core.c:6764 [inline]
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_recv_frame+0x610/0xc934 net/bluetooth/l2cap_core.c:6830
CPU: 1 PID: 52 Comm: kworker/u9:0 Not tainted 6.10.0-rc7-syzkaller-gef445d1539dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci0 hci_rx_work
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 process_one_work+0xdc0/0x15b8 kernel/workqueue.c:3269
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x938/0xecc kernel/workqueue.c:3409
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc7-syzkaller-gef445d1539dd #0 Not tainted
------------------------------------------------------
kworker/u9:0/52 is trying to acquire lock:
ffff0000d385e948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x624/0x15b8 kernel/workqueue.c:3222

but task is already holding lock:
ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_conless_channel net/bluetooth/l2cap_core.c:6764 [inline]
ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_recv_frame+0x610/0xc934 net/bluetooth/l2cap_core.c:6830

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&chan->lock/1){+.+.}-{3:3}:
       __lock_release kernel/locking/lockdep.c:5468 [inline]
       lock_release+0x334/0x9b8 kernel/locking/lockdep.c:5774
       process_one_work+0x8a0/0x15b8 kernel/workqueue.c:3255
       process_scheduled_works kernel/workqueue.c:3329 [inline]
       worker_thread+0x938/0xecc kernel/workqueue.c:3409
       kthread+0x288/0x310 kernel/kthread.c:389
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

-> #0 ((wq_completion)hci0#2){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
       lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5754
       process_one_work+0x668/0x15b8 kernel/workqueue.c:3223
       process_scheduled_works kernel/workqueue.c:3329 [inline]
       worker_thread+0x938/0xecc kernel/workqueue.c:3409
       kthread+0x288/0x310 kernel/kthread.c:389
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&chan->lock/1);
                               lock((wq_completion)hci0#2);
                               lock(&chan->lock/1);
  lock((wq_completion)hci0#2);

 *** DEADLOCK ***

1 lock held by kworker/u9:0/52:
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_conless_channel net/bluetooth/l2cap_core.c:6764 [inline]
 #0: ffff0000d9876518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_recv_frame+0x610/0xc934 net/bluetooth/l2cap_core.c:6830

stack backtrace:
CPU: 1 PID: 52 Comm: kworker/u9:0 Not tainted 6.10.0-rc7-syzkaller-gef445d1539dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci0 hci_cmd_timeout
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 print_circular_bug+0x150/0x1b8 kernel/locking/lockdep.c:2060
 check_noncircular+0x310/0x404 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x3384/0x763c kernel/locking/lockdep.c:5137
 lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5754
 process_one_work+0x668/0x15b8 kernel/workqueue.c:3223
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x938/0xecc kernel/workqueue.c:3409
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Bluetooth: hci0: command tx timeout
BUG: workqueue leaked atomic, lock or RCU: kworker/u9:0[52]
     preempt=0x00000000 lock=1->0 RCU=0->0 workfn=hci_cmd_timeout
INFO: lockdep is turned off.
CPU: 1 PID: 52 Comm: kworker/u9:0 Not tainted 6.10.0-rc7-syzkaller-gef445d1539dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: hci0 hci_cmd_timeout
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:317
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:114
 dump_stack+0x1c/0x28 lib/dump_stack.c:123
 process_one_work+0xdc0/0x15b8 kernel/workqueue.c:3269
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x938/0xecc kernel/workqueue.c:3409
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Bluetooth: hci0: command tx timeout
Bluetooth: hci0: command tx timeout
Bluetooth: hci0: command tx timeout


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

