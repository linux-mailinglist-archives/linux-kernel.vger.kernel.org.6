Return-Path: <linux-kernel+bounces-263224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CF493D2E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF1B1C224F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866917B424;
	Fri, 26 Jul 2024 12:17:25 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2E13A3F7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721996244; cv=none; b=aci19EdUK7Kfmr2IRjW9BoSORO0bzw757jrkeU+yxmu8qfyny8Y+q4sfE6meqb9M/zD3iwklzWMdqglLVAGUugsLqFVwTEDI/Wr5hUQpD26D72UCD1GA/DYjZ+i5BdtFh66xuCHQHFrP5vGD6TKwcY1e+aeloBDaQkRJ1WbLL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721996244; c=relaxed/simple;
	bh=q7Cf+E6fWBqXAXV+Ggn2QdmzstTOmtSckAQ5Q07SNFA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l9mpQ2xX2QyTFuhsm1BgTXRli6kfoyES/MOYe/5Fduf1OBmjxkM4AwIy7UTg/iiAzbJ07ahm3MJ91PNVVT4+ORR1pkvKokatmVZvCJwxH+qs1VTc40fDDEE878lTJFQZKQZllPhZZXtxxqBxNKAQULsUo74T+dZstzm/VzZ9oXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-397810ad718so22066465ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 05:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721996242; x=1722601042;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjkIkzOxJQyrhrSOzBpoWQ1g/lM5/MDIADDwMMu5VfM=;
        b=De8MvXPd2C9aH7WqZjkN40/A2dOSYD/5zBFC1AnznblrpESqcrHvX0PsN+aK2009nm
         rOQc8jOECazHxXW82v77ZDFLdb/IgH58jk14rt3cw2lHx4QB1JJCZn1Yq/GnbxDC+8bK
         893TFh23xRqNbBDcElC5rlPsr5xTBuj3L29fsfhUKC0KPnpyV+0KrVaM8c7zfWUFYY/v
         8O2tb7cfeSbwxE/LD/MeexgazgoZpg7dboGupBAX5siYEWDD6/F/A1aQSt4G7giODmuC
         GXhUuLTACPP9UiPMQhnI0io8EI/G/86oLzTMVhbbUTDao1LyII9tlXycJpnzn6bm057Q
         isrw==
X-Forwarded-Encrypted: i=1; AJvYcCW4rDc5B3uqp0DbOc9fjjlKNfQVTAE0q+l5T9RGrwE0l6OktDMQI449UT4wWg5Q5GyCAh2Vxvv89na2xfaxyMw7C1zbn8ZgC22/0lD/
X-Gm-Message-State: AOJu0Yyz5DNr1Na2enmMVaNshO0oIoQFShQySKckSDnURkc4bC+zF2z+
	Z0QgRQG12emggQG0yJ1IhKgTGlqlcll9B9vyHoxlLi28Vweyjj2xY+Nubl1SktRsF+qkNI0Y3Iv
	cu9K1dHsQYXFEjbvIWbkwj2WNzlT22AGvrOfSg0iCWC10Gg50sFwI7y0=
X-Google-Smtp-Source: AGHT+IGecfzpqb1585FbTHFhLLkbgqqNkvivNB5/eaexz8ca9jvAn+m2j/gxdh0pAkfEvql/M0u8QpKkB/azwgrtRABrp+Pvp3Zp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:39a:e900:7e3e with SMTP id
 e9e14a558f8ab-39ae9008001mr1337775ab.3.1721996241981; Fri, 26 Jul 2024
 05:17:21 -0700 (PDT)
Date: Fri, 26 Jul 2024 05:17:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ee343061e257ed5@google.com>
Subject: [syzbot] [bluetooth?] BUG: workqueue leaked atomic, lock or RCU: kworker/u33:NUM[NUM]
From: syzbot <syzbot+45ac74737e866894acb0@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    22f902dfc51e Merge tag 'i2c-for-6.10-rc7' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156bc135980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de2d4dc103148cd6
dashboard link: https://syzkaller.appspot.com/bug?extid=45ac74737e866894acb0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17243d76980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15832bc1980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-22f902df.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/52eba6820000/vmlinux-22f902df.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b9c5671dd5ff/bzImage-22f902df.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45ac74737e866894acb0@syzkaller.appspotmail.com

BUG: workqueue leaked atomic, lock or RCU: kworker/u33:2[5195]
     preempt=0x00000000 lock=0->1 RCU=0->0 workfn=hci_rx_work
1 lock held by kworker/u33:2/5195:
 #0: ffff88801ac26518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
 #0: ffff88801ac26518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_conless_channel net/bluetooth/l2cap_core.c:6764 [inline]
 #0: ffff88801ac26518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_recv_frame+0x14f2/0x8ea0 net/bluetooth/l2cap_core.c:6830
CPU: 3 PID: 5195 Comm: kworker/u33:2 Not tainted 6.10.0-rc6-syzkaller-00215-g22f902dfc51e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 process_one_work+0x11ea/0x1b40 kernel/workqueue.c:3269
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x6c8/0xf30 kernel/workqueue.c:3409
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

======================================================
WARNING: possible circular locking dependency detected
6.10.0-rc6-syzkaller-00215-g22f902dfc51e #0 Not tainted
------------------------------------------------------
kworker/u33:2/5195 is trying to acquire lock:
ffff88801ef0a948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3223

but task is already holding lock:
ffff88801ac26518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
ffff88801ac26518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_conless_channel net/bluetooth/l2cap_core.c:6764 [inline]
ffff88801ac26518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_recv_frame+0x14f2/0x8ea0 net/bluetooth/l2cap_core.c:6830

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&chan->lock/1){+.+.}-{3:3}:
       __lock_release kernel/locking/lockdep.c:5468 [inline]
       lock_release+0x33e/0x6c0 kernel/locking/lockdep.c:5774
       process_one_work+0xa96/0x1b40 kernel/workqueue.c:3255
       process_scheduled_works kernel/workqueue.c:3329 [inline]
       worker_thread+0x6c8/0xf30 kernel/workqueue.c:3409
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((wq_completion)hci0#2){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
       process_one_work+0x12a6/0x1b40 kernel/workqueue.c:3223
       process_scheduled_works kernel/workqueue.c:3329 [inline]
       worker_thread+0x6c8/0xf30 kernel/workqueue.c:3409
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&chan->lock/1);
                               lock((wq_completion)hci0#2);
                               lock(&chan->lock/1);
  lock((wq_completion)hci0#2);

 *** DEADLOCK ***

1 lock held by kworker/u33:2/5195:
 #0: ffff88801ac26518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_chan_lock include/net/bluetooth/l2cap.h:827 [inline]
 #0: ffff88801ac26518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_conless_channel net/bluetooth/l2cap_core.c:6764 [inline]
 #0: ffff88801ac26518 (&chan->lock/1){+.+.}-{3:3}, at: l2cap_recv_frame+0x14f2/0x8ea0 net/bluetooth/l2cap_core.c:6830

stack backtrace:
CPU: 2 PID: 5195 Comm: kworker/u33:2 Not tainted 6.10.0-rc6-syzkaller-00215-g22f902dfc51e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_cmd_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 process_one_work+0x12a6/0x1b40 kernel/workqueue.c:3223
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x6c8/0xf30 kernel/workqueue.c:3409
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Bluetooth: hci0: command tx timeout
BUG: workqueue leaked atomic, lock or RCU: kworker/u33:2[5195]
     preempt=0x00000000 lock=1->0 RCU=0->0 workfn=hci_cmd_timeout
INFO: lockdep is turned off.
CPU: 2 PID: 5195 Comm: kworker/u33:2 Not tainted 6.10.0-rc6-syzkaller-00215-g22f902dfc51e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: hci0 hci_cmd_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 process_one_work+0x11ea/0x1b40 kernel/workqueue.c:3269
 process_scheduled_works kernel/workqueue.c:3329 [inline]
 worker_thread+0x6c8/0xf30 kernel/workqueue.c:3409
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Bluetooth: hci0: command tx timeout
Bluetooth: hci0: command tx timeout
Bluetooth: hci0: command tx timeout


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

