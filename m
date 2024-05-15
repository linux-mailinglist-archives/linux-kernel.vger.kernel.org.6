Return-Path: <linux-kernel+bounces-180272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B38C6C46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F4181C21781
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C20158DD7;
	Wed, 15 May 2024 18:41:29 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973182E622
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715798489; cv=none; b=eKAk8j1G2dXB4XmqNsEpQSTSiHLUrw/cbtg5Oy0De0hL2+lnEuPEu30jbOhow5or98bR11SoDa1exo/YzdVT8dq+VL+OL8DQfLMljMwAcovqmpNMuT7mZ5hfRqhajiNhH+xBvWmWelu52ZHAP9ZKxl3JoR8S2mkIZgWdnZZdKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715798489; c=relaxed/simple;
	bh=8OhLvQwQwLI7Eff6M/XbtKRb/G+QPkaf5lcYwu/FQng=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y0l52nEdmfy3EZ6kyJaL8X+GbuEw1c5+CarUQkmDJX+DQAjjzfvvp5uMm38Amvv1Ebb5NJXeyg315C/D1Av6VFOEJeuANchKBUBJxv6JaeQvScpi1RzsEzzvQ2g8VHtpouRMiVA/j+1Ijbk/XpdYoiUWz2ZCpy2INRoPZVcyshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-36cc59a84bcso65777895ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 11:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715798487; x=1716403287;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WX5EZnFlrIpQAeCtrJHYpc8nSed7polYaoKaA2Ch3X0=;
        b=SxlZS09nM1uelWfOi8CR61kCPjFMDKSbZEU2dlXW2ue29x3hfqq8Tc+PCF7P03ugvm
         g2ao8wCSLRDFEXxYQkp715aJM5mypwOPXgT8dBVxkf5JusvX/K0VodsNTRPEDEDO/QPH
         4c6CYYYSkkvDEu/tiKcDF2npXHEMJhlWlrQjXsYjNlNmwKYMAQSqmtG+TwT4ai+Z/IvT
         P3Nm6VV7OUXqGfNAxRriUkx9+vpMDeJAvSJDs+VRFBvN6q8sZ5UWD6stfeUqf6e6ciY/
         XmQZSl8kc/yqve74L9+7Gh8l2KBkvey5NOsIGAQpkNNMGBWGKfZE467Lpq+vQOnsLoIl
         ZwSg==
X-Forwarded-Encrypted: i=1; AJvYcCWmkFTM45fVLCFeqpM2WtPZoPl+nZzQP+ApOQoeUSBwyiHYDX91Z0+0k9P7Qe9jw5R4IP4IG3VzIb23pWk5nmkgvPPbO2lGnO7G6CjI
X-Gm-Message-State: AOJu0YxxDJrJANtQpP/mA96KWQvkiojYW2nM47eIB+sXQbwylsC0vfU9
	ZxKTuYlJlAO3BRpWlZ4DSk4F2ekBWZUhHRKfBI75nyHI7FUehUwNQFJ6aV8l0dg7BgjhLgUW9fJ
	VgN5kfPOP+q9qXA3Q2zP33V2XcyZbGIDCGqBlJ4kjhSMRxKku7lG4ANU=
X-Google-Smtp-Source: AGHT+IEcIEPIbJ6ZCE6ljJ1uiqKnpkRKk9UKeXauhWWFn2J5kMeV81Q1oAaHclHggsG4WEDehTfASC3o8xniY0CDhbVUTo/9oCzU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d190:0:b0:36d:92b9:8f30 with SMTP id
 e9e14a558f8ab-36d92b98fe7mr1543295ab.1.1715798486898; Wed, 15 May 2024
 11:41:26 -0700 (PDT)
Date: Wed, 15 May 2024 11:41:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000516ace0618827799@google.com>
Subject: [syzbot] [wireguard?] WARNING: locking bug in try_to_wake_up
From: syzbot <syzbot+8aaf2df2ef0164ffe1fb@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    cf87f46fd34d Merge tag 'drm-fixes-2024-05-11' of https://g.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D16b04970980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=3D8aaf2df2ef0164ffe=
1fb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debia=
n) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1aa5ad92dfce/disk-=
cf87f46f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/67c336f7c1c7/vmlinux-=
cf87f46f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bb5b717bd2b8/bzI=
mage-cf87f46f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+8aaf2df2ef0164ffe1fb@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
[ BUG: Invalid wait context ]
6.9.0-rc7-syzkaller-00183-gcf87f46fd34d #0 Not tainted
-----------------------------
kworker/0:5/10404 is trying to lock:
ffff8880b953e698 (iattr_mutex){+.+.}-{3:3}, at: raw_spin_rq_lock_nested+0x2=
a/0x140 kernel/sched/core.c:559
other info that might help us debug this:
context-{4:4}
5 locks held by kworker/0:5/10404:
 #0: ffff888069fd5d48 ((wq_completion)wg-crypt-wg0#12){+.+.}-{0:0}, at: pro=
cess_one_work kernel/workqueue.c:3242 [inline]
 #0: ffff888069fd5d48 ((wq_completion)wg-crypt-wg0#12){+.+.}-{0:0}, at: pro=
cess_scheduled_works+0x8e0/0x17c0 kernel/workqueue.c:3348
 #1: ffffc9000a4b7d00 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ =
unsigned long __ptr; __ptr =3D (unsigned long) ((typeof(*((worker))) *)((wo=
rker))); (typeof((typeof(*((worker))) *)((worker)))) (__ptr + (((__per_cpu_=
offset[(cpu)])))); }); })->work)){+.+.}-{0:0}, at: process_one_work kernel/=
workqueue.c:3243 [inline]
 #1: ffffc9000a4b7d00 ((work_completion)(&({ do { const void *__vpp_verify =
=3D (typeof((worker) + 0))((void *)0); (void)__vpp_verify; } while (0); ({ =
unsigned long __ptr; __ptr =3D (unsigned long) ((typeof(*((worker))) *)((wo=
rker))); (typeof((typeof(*((worker))) *)((worker)))) (__ptr + (((__per_cpu_=
offset[(cpu)])))); }); })->work)){+.+.}-{0:0}, at: process_scheduled_works+=
0x91b/0x17c0 kernel/workqueue.c:3348
 #2: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire inc=
lude/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock includ=
e/linux/rcupdate.h:781 [inline]
 #2: ffffffff8e334da0 (rcu_read_lock){....}-{1:2}, at: __queue_work+0x198/0=
xef0 kernel/workqueue.c:2337
 #3: ffff8880b953de18 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x6ec/0xe=
f0
 #4: ffff8880206b6410 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irq=
save_constructor include/linux/spinlock.h:553 [inline]
 #4: ffff8880206b6410 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x=
1470 kernel/sched/core.c:4262
stack backtrace:
CPU: 0 PID: 10404 Comm: kworker/0:5 Not tainted 6.9.0-rc7-syzkaller-00183-g=
cf87f46fd34d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 04/02/2024
Workqueue: wg-crypt-wg0 wg_packet_encrypt_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4751 [inline]
 check_wait_context kernel/locking/lockdep.c:4821 [inline]
 __lock_acquire+0x1507/0x1fd0 kernel/locking/lockdep.c:5087
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 raw_spin_rq_lock kernel/sched/sched.h:1387 [inline]
 rq_lock kernel/sched/sched.h:1701 [inline]
 ttwu_queue kernel/sched/core.c:4055 [inline]
 try_to_wake_up+0x7d3/0x1470 kernel/sched/core.c:4378
 kick_pool+0x45c/0x620 kernel/workqueue.c:1288
 __queue_work+0xc30/0xef0 kernel/workqueue.c:2414
 queue_work_on+0x14f/0x250 kernel/workqueue.c:2448
 wg_queue_enqueue_per_peer_tx+0x21f/0x4b0 drivers/net/wireguard/queueing.h:=
188
 wg_packet_encrypt_worker+0x1240/0x1610 drivers/net/wireguard/send.c:305
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa12/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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

