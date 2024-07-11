Return-Path: <linux-kernel+bounces-249748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C94592EF4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3692028301D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5116EB71;
	Thu, 11 Jul 2024 19:02:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2C16E894
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724541; cv=none; b=GUrVQIw7PzhNxlhRYcv+HBnFkD+w8RToI4mKIgaZ46bMkQhqzc/nVljOz6WwSpyQp8XrWddeReyYzhm4GB4Cw2vJFpjz5ZX7Kf7rSV2eoNHH0Dw6hnKjizfQJp+osMBnZr0j2qzEVliypoTiJv7Y4VYhecv+bX8Utov0COCKTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724541; c=relaxed/simple;
	bh=8O2lhik+RaPcqtIWAhMSauylBH462U8KMroyaWs8X0c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=C72mDvyNBNXB0C7RCPdShwLvQ23QYx4JojyFxzUfYc6IVfhbXlsROGVL1BAe5XE3eGYxtQ4f2C109qqWDV6hZMVGkHRvW9bgWOcZ/oAINiYlB/JW1MhsjVLw0nOtMfj4dxoO9ArF+qzFTjnCjqvM5rUL0EAMv2muOZWIoqtrL2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ebd11f77d8so129630239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720724539; x=1721329339;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d037FVlUZZHShFhcJ++mtIw9wfJ3lcVVhTJ+azuHIKg=;
        b=iosuUUk2nSqWhZ/esF7Z4517G4iPI2Urr2G8T9A072z9LRiIlANcb98iwREdl2odfv
         ORnqmRxUjVP3udoUa6n+nJD7u5rRd3dYO2zT5ZaoN16/d/twbuAC2kkqjTNdN9vw4Sth
         SKLGd/DkUBulamg77Mvzc424LHtYHjJ1t63wVll/UwUezG5TT/1oy33mH6gwVls2cWIU
         G4F8qYnzggFrmQmC2pq/mvmUXkGsDmyp2IOV1h5G8y/Xc8C0u24K3PtkFyARrlFUfWxH
         MRDjznUPyZHc+JaBotT7FffZ4ZwplDs41sVS97kUNFNv7HSzkflJmZdMHUeIPBttqwvN
         QErg==
X-Forwarded-Encrypted: i=1; AJvYcCU0RXDyV9VT6ziinnytJoHf/xkft4GQkON9JgdlSRK5yzzf5goEeGJb2iPQMz2X1fOq8m+w6TyDDBZ0bMn37XHcAdagKxSPSM3Kuzcg
X-Gm-Message-State: AOJu0YwTimj2G3KRJk4kb0MnSSCGSyIMyNTP9R7m/hA7SP4Wivib99MK
	6gnWV1a64dCiZN/dY+69DY6N5opBBJGZpbkLzDQCoZZhhuXHzLV9qfqymt3tlE657Dd28R3HdFw
	W02QT57yqXbOPeJWgh9iPslOz7LO8aVOGBxsSp5cWFxeOqlZhYo/KKKs=
X-Google-Smtp-Source: AGHT+IF1i0KFrn2leuF98OozVJPuXfwcwkKiFY3mUPi/rW4DO/GWGbP7SrixW/uZmbEpTnsw/WfVOeExC/l3aFOxjS2Rjxso2jcV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1315:b0:4c0:9380:a261 with SMTP id
 8926c6da1cb9f-4c0b29a6e21mr342097173.2.1720724539259; Thu, 11 Jul 2024
 12:02:19 -0700 (PDT)
Date: Thu, 11 Jul 2024 12:02:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb54bf061cfd666a@google.com>
Subject: [syzbot] [net?] BUG: sleeping function called from invalid context in synchronize_net
From: syzbot <syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    523b23f0bee3 Add linux-next specific files for 20240710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10d88fb9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=9b277e2c2076e2661f61
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/345bcd25ed2f/disk-523b23f0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a4508962d345/vmlinux-523b23f0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ba5eb555639/bzImage-523b23f0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b277e2c2076e2661f61@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at net/core/dev.c:11239
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 12, name: kworker/u8:1
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.10.0-rc7-next-20240710-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8526
 synchronize_net+0x1b/0x50 net/core/dev.c:11239
 dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1371
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
 linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3228 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3309
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3387
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
------------[ cut here ]------------
Voluntary context switch within RCU read-side critical section!
WARNING: CPU: 1 PID: 12 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0xcf4/0xff0 kernel/rcu/tree_plugin.h:330
Modules linked in:
CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:1 Tainted: G        W          6.10.0-rc7-next-20240710-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
RIP: 0010:rcu_note_context_switch+0xcf4/0xff0 kernel/rcu/tree_plugin.h:330
Code: 00 ba 02 00 00 00 e8 bb 02 fe ff 4c 8b b4 24 80 00 00 00 eb 91 c6 05 a4 4f 1f 0e 01 90 48 c7 c7 e0 2d cc 8b e8 ad c5 da ff 90 <0f> 0b 90 90 e9 3b f4 ff ff 90 0f 0b 90 45 84 ed 0f 84 00 f4 ff ff
RSP: 0018:ffffc90000116f00 EFLAGS: 00010046
RAX: b02efd3a29e78a00 RBX: ffff8880172cde44 RCX: ffff8880172cda00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000117050 R08: ffffffff815583f2 R09: fffffbfff1c39f8c
R10: dffffc0000000000 R11: fffffbfff1c39f8c R12: ffff8880172cda00
R13: 0000000000000000 R14: 1ffff92000022df8 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c444d58 CR3: 000000006ca0e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __schedule+0x348/0x4a60 kernel/sched/core.c:6491
 __schedule_loop kernel/sched/core.c:6680 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6695
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6752
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:967
 synchronize_rcu+0x11b/0x360 kernel/rcu/tree.c:4020
 dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1371
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
 linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3228 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3309
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3387
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

