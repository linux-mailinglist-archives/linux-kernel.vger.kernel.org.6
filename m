Return-Path: <linux-kernel+bounces-439361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D979EAE15
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6171728415D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92BD210F41;
	Tue, 10 Dec 2024 10:35:25 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4019DF61
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826925; cv=none; b=VWIk30MTKxlAzq28P9dTUNwyh4NbFMQvcaxf6NoxBd+eQsJpi/t3+fTCW8HSBc8BBPx1W4AjEqb/48rhLZ6jsvYxXfA+bflIZIXzxFz8By/5VE5KevSNm/+9kDqv2G4SXS5KDSJ1IAKlQEAv9594mbzzpxG0RfueylE6EA78a0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826925; c=relaxed/simple;
	bh=c98+4VObXDkPphu8+re7H7VwO/905+emURViu9IgIzA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DsbUHeAv0Dg6fZrgmVt1OdWrmX4qyMmN/DcnupCGe++rCX4gPyx9ny8q+0CZhYtQV2x8zhFRMiaJCxNwtu2JUFsr5G+OYdLtt+kWlh1/YYl4SZ2g6D/aYsvQa9n7EDHIMmj41tFlwGgeaYU3NmhdXho9Q3gFyeSv6uI72o/XvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a811c188aeso42486165ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733826922; x=1734431722;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BRs4zfSZcnDABG7R8kmGOCzV211j1fJGjc2tesVESA=;
        b=kvxYvG6cEeUw1RYTH5/Wtg5nh+wxArRSE1B2TYQDnHxprRR7xMU7/1FvuDHZxsKUvs
         t+PV+U77+HijputjxLMcSG8+cA87Gp6XvciEfyKnghdaJ7WFOocIuOlQ8bp9bFWGKufn
         8s4z9TibdV3SggMVUqalr5V6wYxPK/5wWUiO0pGhIbRSuT2wZ0CJexitnKaSid9R4m7u
         p8omc20DAf3o0dmJffTBVUWoGO7S6Sl9RH8PWxeYn/3tJpJyfuQBdU6NYaGxToMoow5Y
         yPLh/BipIlDAnDvHA0u1QwSeZ/oQEE5RsDuVQasHXTJyNCPAgOObg5XIvs2+wGsCFF6t
         XlAg==
X-Forwarded-Encrypted: i=1; AJvYcCW17T3oK0Mh86rSZseeleYqOp3NbgUkFTnLFCZy9vEXhJQJvHOHqWIuDZcWCe1W3YOBdcRWsoPg8SSuupw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuymjsPujH/YWYJVrhp0LqVuVdNkNep5HBPHb7tIDS3XQDJC9Q
	4HcJnXN+i8JIsJUnbvlLq23XDJF2pK/tYm6ka/bNExBm1/EVOt44K//54HXFEpostROFCXYPkvU
	D3kpEfAkKzaAmMlOEvZEtY+no9sW9j5cjvAoS00Lm7p9eaSeRPTNv0DA=
X-Google-Smtp-Source: AGHT+IGyl/+suSooF+AOUYbIy6DTAQP/FXeXTYGo+6Ci2xxMHUdnDTUqBrmZ7plG7FBVbAeqhnU+Q0qruKVFJLaBjSPkPxWK/HVn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:3a7:98c4:86a9 with SMTP id
 e9e14a558f8ab-3a811e226b8mr189328075ab.20.1733826922592; Tue, 10 Dec 2024
 02:35:22 -0800 (PST)
Date: Tue, 10 Dec 2024 02:35:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6758196a.050a0220.a30f1.01c9.GAE@google.com>
Subject: [syzbot] [net?] BUG: soft lockup in ser_release (4)
From: syzbot <syzbot+635b76a41cfd2daa1d90@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b1d1d4cfac0 Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=153bc020580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9bc44a6de1ceb5d6
dashboard link: https://syzkaller.appspot.com/bug?extid=635b76a41cfd2daa1d90
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4d4a0162c7c3/disk-7b1d1d4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8c47a4be472/vmlinux-7b1d1d4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e173b91f83e/Image-7b1d1d4c.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+635b76a41cfd2daa1d90@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [kworker/0:0:8]
Modules linked in:
irq event stamp: 48533
hardirqs last  enabled at (48532): [<ffff80008b545ee4>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (48532): [<ffff80008b545ee4>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (48533): [<ffff80008b54395c>] __el1_irq arch/arm64/kernel/entry-common.c:557 [inline]
hardirqs last disabled at (48533): [<ffff80008b54395c>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:575
softirqs last  enabled at (41020): [<ffff8000860049d0>] pppoe_flush_dev drivers/net/ppp/pppoe.c:327 [inline]
softirqs last  enabled at (41020): [<ffff8000860049d0>] pppoe_device_event+0x464/0x4a0 drivers/net/ppp/pppoe.c:346
softirqs last disabled at (41024): [<ffff80008987a614>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.12.0-syzkaller-g7b1d1d4cfac0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events ser_release
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x15c/0xd00 kernel/locking/qspinlock.c:380
lr : queued_spin_lock_slowpath+0x168/0xd00 kernel/locking/qspinlock.c:380
sp : ffff800097977520
x29: ffff8000979775c0 x28: 1fffe0001ad2c420 x27: 1ffff00012f2eeb0
x26: dfff800000000000 x25: 1fffe0001833ab5a x24: ffff800097977540
x23: ffff800097977580 x22: ffff700012f2eea8 x21: 0000000000000001
x20: 0000000000000001 x19: ffff0000d6962100 x18: ffff800097977400
x17: 000000000002b14e x16: ffff800080aca118 x15: 0000000000000001
x14: 1fffe0001ad2c420 x13: 0000000000000000 x12: 0000000000000000
x11: ffff60001ad2c421 x10: 1fffe0001ad2c420 x9 : 0000000000000000
x8 : 0000000000000001 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff800093604598 x4 : 0000000000000008 x3 : ffff80008b63a244
x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000001
Call trace:
 __cmpwait_case_8 arch/arm64/include/asm/cmpxchg.h:229 [inline] (P)
 __cmpwait arch/arm64/include/asm/cmpxchg.h:257 [inline] (P)
 queued_spin_lock_slowpath+0x15c/0xd00 kernel/locking/qspinlock.c:380 (P)
 queued_spin_lock_slowpath+0x168/0xd00 kernel/locking/qspinlock.c:380 (L)
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x2ec/0x334 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x50/0x60 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 __netif_tx_lock include/linux/netdevice.h:4371 [inline]
 netif_freeze_queues net/sched/sch_generic.c:460 [inline]
 netif_tx_lock+0x9c/0x1d8 net/sched/sch_generic.c:469
 netif_tx_lock_bh include/linux/netdevice.h:4455 [inline]
 dev_watchdog_down net/sched/sch_generic.c:574 [inline]
 dev_deactivate_many+0x274/0xa8c net/sched/sch_generic.c:1369
 __dev_close_many+0x270/0x3c8 net/core/dev.c:1547
 dev_close_many+0x1e0/0x474 net/core/dev.c:1585
 dev_close+0x174/0x250 net/core/dev.c:1611
 ser_release+0x188/0x238 drivers/net/caif/caif_serial.c:309
 process_one_work+0x7bc/0x1600 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x97c/0xeec kernel/workqueue.c:3391
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 2346 Comm: aoe_tx0 Not tainted 6.12.0-syzkaller-g7b1d1d4cfac0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
pc : _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:194
lr : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
lr : _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
sp : ffff8000a1ac7730
x29: ffff8000a1ac7730 x28: ffff0000cdc8b0b0 x27: dfff800000000000
x26: 0000000000000000 x25: ffff800091292c00 x24: ffff0000c9228f48
x23: 0000000000000003 x22: 0000000000000000 x21: ffff800091292c00
x20: ffff80009776cde0 x19: 0000000000000000 x18: ffff8000a1ac73e0
x17: 000000000002b0e8 x16: ffff800080355c58 x15: 0000000000000001
x14: 1ffff00012eed9bc x13: ffff8000a1ac8000 x12: 0000000000000003
x11: 0000000000000202 x10: 0000000000000003 x9 : 0000000000000000
x8 : 00000000000000c0 x7 : ffff800083ec1ff0 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : ffff80008b6c4000 x0 : ffff800123e21000
Call trace:
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:175 [inline] (P)
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline] (P)
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:194 (P)
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline] (L)
 _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194 (L)
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 uart_port_unlock_irqrestore include/linux/serial_core.h:782 [inline]
 uart_write+0x4b0/0x9b4 drivers/tty/serial/serial_core.c:628
 handle_tx+0x200/0x604 drivers/net/caif/caif_serial.c:236
 caif_xmit+0x108/0x150 drivers/net/caif/caif_serial.c:282
 __netdev_start_xmit include/linux/netdevice.h:4928 [inline]
 netdev_start_xmit include/linux/netdevice.h:4937 [inline]
 xmit_one net/core/dev.c:3588 [inline]
 dev_hard_start_xmit+0x260/0x904 net/core/dev.c:3604
 __dev_queue_xmit+0x1638/0x3548 net/core/dev.c:4432
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]
 tx+0x9c/0x1cc drivers/block/aoe/aoenet.c:62
 kthread+0x1ac/0x374 drivers/block/aoe/aoecmd.c:1237
 kthread+0x288/0x310 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862


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

