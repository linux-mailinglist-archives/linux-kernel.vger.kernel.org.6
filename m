Return-Path: <linux-kernel+bounces-543325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7EDA4D449
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619651890332
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F122A1F63FE;
	Tue,  4 Mar 2025 07:08:34 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD81F5825
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 07:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072114; cv=none; b=R2TqTxpbQxjxDViG062tuwG1km33He6qqUoPlnlmptBetpKfSk4GzwOz7GvNsbXYiVS9JdSS8jRiKSzHs5TUcv2/5uU9BKsbkqFH3SfGGL4gwjQwuS6U5hf3kqoyIHEiKQq3d+9Rm/SHNXTb3xi1KTd83r/JXUHoOQuB3LD8Uro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072114; c=relaxed/simple;
	bh=4DGOATDKzfnDduyJ+tfAGO956m+iDyBukE4kgWbV86I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Bl3ZIpX3w4S25ABHXc+jFhkPvdHDl6Ws/nAbN2PuccP5pZI/lmzjETtft/IKXtGvic6qOzY0lL+IF0ztDj8QLY68dRKbD3WhmgqVm6OHmoe/C9D1ymG34953dXV6NHbj2sS/So+ZVGcwmwdFDtJLXvO8ammXs9tNEkavc4MnA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d3d88a355bso50218405ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 23:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741072112; x=1741676912;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqiVtzwBgU1lDf2SDTYlwWX7sEeYdDO0Db14SV4FSWw=;
        b=tiCWEqEJh/vISudMNBlY/lcdKRQQB2bKNGLOJEXqojTFEeAQ+W5vqumRZdDW6L4MGC
         EaEyXVpQtVDbLQ5BcEHEfD/usx/ep49IxQgOwEy1qMgP+LxGGIMr9AO194KpqfHMobSz
         EiSimaK2VWa5Xk3Lhub1/3FYh7ZCe2BnC0QXu5HDfBq8MXwR3UPy/IurXA9umZfBBkem
         PCfQxYSC27J0qMWD5YdQBTjvINHcA1vnQ+XtZkoKgBuh2OwHEjuC8Q2Xww8XT7i1+rHQ
         WpazlPfCkSpYizEk8pYL55SwsLMU5fIy+Bo/lRB04uDYJrPyDgUmRXXRyuL43ZkMBMbP
         2Ppg==
X-Forwarded-Encrypted: i=1; AJvYcCWMBf5flXwUFcFcusvkMe/E/QVcAvv8Z1NVwFgNlGW6r01Qs4IZR0nbBbz68jtMG8Pd5D8A/hnZ8Lyyx34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+WJge2PqaycJSCyJDDXQeSzWjeaN9V1+h9B2UsYTk/Ye+pOJk
	rra6iLqTDZDzHM4Ncp3p94yCVeJtJZlBByRhbbdqK/zOrf1PVe66O31/4/LAf8AR07zIlmYK1GD
	QWHs+W3tQKoC5W74Bmi7ehqCtXO7BPaePaC6Dss8/urgHi/893BoD+ds=
X-Google-Smtp-Source: AGHT+IH3n9eNKq3gHBYv2WmSy2sJizk2wralwXrNwx0ttRzVWb4+4vdSnOCJHssmZqxBWyl5JanXDyQSnKwynD/Dm29Hug3WxJ3F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ea:b0:3d3:dfb6:2203 with SMTP id
 e9e14a558f8ab-3d3e6f4a094mr143335255ab.19.1741072112032; Mon, 03 Mar 2025
 23:08:32 -0800 (PST)
Date: Mon, 03 Mar 2025 23:08:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c6a6f0.050a0220.38b91b.0001.GAE@google.com>
Subject: [syzbot] [scsi?] BUG: sleeping function called from invalid context
 in __bio_release_pages
From: syzbot <syzbot+4b11b8d3d29d2ced1786@syzkaller.appspotmail.com>
To: James.Bottomley@HansenPartnership.com, dgilbert@interlog.com, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	martin.petersen@oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1e15510b71c9 Merge tag 'net-6.14-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134eca97980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1635bf4c5557b92
dashboard link: https://syzkaller.appspot.com/bug?extid=4b11b8d3d29d2ced1786
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d3d285b4524/disk-1e15510b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5aa6409ccccc/vmlinux-1e15510b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c869f7ce522a/bzImage-1e15510b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4b11b8d3d29d2ced1786@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at ./include/linux/pagemap.h:1161
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 15472, name: kworker/0:1
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by kworker/0:1/15472:
 #0: ffff88801b080d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3213
 #1: ffffc90004b7fd18 ((work_completion)(&sfp->ew.work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3214
 #2: ffff88803d188080 (&sfp->rq_list_lock){..-.}-{3:3}, at: sg_remove_sfp_usercontext+0x86/0x580 drivers/scsi/sg.c:2210
irq event stamp: 177768
hardirqs last  enabled at (177767): [<ffffffff8b57a523>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (177767): [<ffffffff8b57a523>] _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
hardirqs last disabled at (177768): [<ffffffff8b57a9c2>] __raw_write_lock_irqsave include/linux/rwlock_api_smp.h:184 [inline]
hardirqs last disabled at (177768): [<ffffffff8b57a9c2>] _raw_write_lock_irqsave+0x52/0x60 kernel/locking/spinlock.c:318
softirqs last  enabled at (177736): [<ffffffff817c131b>] softirq_handle_end kernel/softirq.c:407 [inline]
softirqs last  enabled at (177736): [<ffffffff817c131b>] handle_softirqs+0x5bb/0x8f0 kernel/softirq.c:589
softirqs last disabled at (177731): [<ffffffff817c17e9>] __do_softirq kernel/softirq.c:595 [inline]
softirqs last disabled at (177731): [<ffffffff817c17e9>] invoke_softirq kernel/softirq.c:435 [inline]
softirqs last disabled at (177731): [<ffffffff817c17e9>] __irq_exit_rcu+0x109/0x170 kernel/softirq.c:662
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 15472 Comm: kworker/0:1 Not tainted 6.14.0-rc4-syzkaller-00169-g1e15510b71c9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events sg_remove_sfp_usercontext
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 __might_resched+0x3c0/0x5e0 kernel/sched/core.c:8767
 folio_lock include/linux/pagemap.h:1161 [inline]
 __bio_release_pages+0x310/0x3b0 block/bio.c:1066
 bio_release_pages include/linux/bio.h:441 [inline]
 blk_rq_unmap_user+0x3c0/0x990 block/blk-map.c:675
 sg_finish_rem_req+0xde/0x590 drivers/scsi/sg.c:1837
 sg_remove_sfp_usercontext+0x102/0x580 drivers/scsi/sg.c:2213
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3400
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
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

