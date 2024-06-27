Return-Path: <linux-kernel+bounces-232417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A969591A894
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6E5B25C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D405195801;
	Thu, 27 Jun 2024 14:03:24 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96913C90A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497003; cv=none; b=kZzqxvsn9nWBN4Gcf+g3mvHiu3ghfsSwiUNN8Z9Qlae4KkhA2z+okd8hTn49CjbPExldAlrJ/XwFMbNKc2gAGUIGgFes9upQdMMEJG2zr6eYACKQIA2b4Qb5E9WZ/ErJn1f/I8IppAUay6itZTkZykHEs1kpYvEGn7ohqZsYq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497003; c=relaxed/simple;
	bh=+8bJoWn136z+IHIcQ3q1VJ8I6TyRzK2DK1qBw0Mo1OE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=F+8fDTUy8zBeQKPcRcgwJtLFvgVRi3D6HSBKam+Tb9315WSVivq2ITLBsEij1s9BCNdu74ElYmmXCsmIXEAHCc5Z7NhQ6ALsMrzSo+LU/9ZQrk4mWZbFC0VtRyztWBBfqn8p1tyy7qzYamcPnoZ6lkuAvcnRIT3BDE2Udsql2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7f3caa9e180so141431439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719497001; x=1720101801;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M05+xEF/hUwPM/FvKNbnTKjCCqU+v6CqTylBaQQbiJQ=;
        b=LelpGnA9H4ELL4SnKBi0yvTzajwUXHY63zmuFZ8PH2zBLkodjrQDsWV7C/XJ4yvitR
         sJEgs6gu2lxEavm2Px9vIRyU+tTwrTYiuAWAyjwntK59JEoVb5c1jfSY7xMa83xrqziY
         OM01hlT4dRkcFxpxah4opKTlbpJYn+kDQodGsc4Tq0yyG186eAMj2mqnBho9retBrA7u
         lS+u/lq8BVez4NKV+ElofNcjyJtnbiHcY47Kukae/WLU1hTALDGlD3qkPTy5Jtw4lnRt
         a/0pz+4Z/MEB8v63Me1eL0GJSVsDT8frA7Wdu+r4cC4pdxB9jYKPBML01lGptc2U4VVu
         VTIA==
X-Forwarded-Encrypted: i=1; AJvYcCU3pULdpomqe2r9IlhkDXSdFAeC/TT+JP9OijgWHTufUR46M/hJs82FMjtIId2RSTxGvYx4/AjTKM8kKaVNEz2lU5XZHfCcRFjERiu/
X-Gm-Message-State: AOJu0YwVnUJMV9dtFvmJmaoBF/TJQVVkKGgV3Dg+AaJcfnQdLI7bYWAS
	tm0/KkRrnCKacHuUB5dzxo5PgRQgjY3ebOq19q2H0XhYMb+bY7eSmj4Ua4vO6jJqeyEBZvZLZIe
	nB7zE96/TXn7fSI0S7DifZ9+GZewCS+xsvvvwxDb+luubEW4LbbaI+dM=
X-Google-Smtp-Source: AGHT+IHvB6qSs+asZzsL79/83FCoRCk9eZ0GQ0LKUrN+h07oj3ZvZKtBPerOEyBE/mJYFQBGC5EMmXN21p2GyT8HiDol54RyURuZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:db0c:0:b0:7f3:ce24:6aca with SMTP id
 ca18e2360f4ac-7f3d8dc0cf5mr3019139f.2.1719497001466; Thu, 27 Jun 2024
 07:03:21 -0700 (PDT)
Date: Thu, 27 Jun 2024 07:03:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f71227061bdf97e0@google.com>
Subject: [syzbot] [cgroups?] BUG: sleeping function called from invalid
 context in cgroup_rstat_flush
From: syzbot <syzbot+b7f13b2d0cc156edf61a@syzkaller.appspotmail.com>
To: cgroups@vger.kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	lizefan.x@bytedance.com, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c16f0a4ed1c Merge tag 'i2c-for-6.10-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1511528e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12f98862a3c0c799
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f13b2d0cc156edf61a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/50560e9024e5/disk-7c16f0a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/080c27daee72/vmlinux-7c16f0a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c528e0da4544/bzImage-7c16f0a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7f13b2d0cc156edf61a@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/cgroup/rstat.c:351
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 17332, name: syz-executor.4
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
1 lock held by syz-executor.4/17332:
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: filemap_cachestat mm/filemap.c:4251 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: __do_sys_cachestat mm/filemap.c:4407 [inline]
 #0: ffffffff8e333fa0 (rcu_read_lock){....}-{1:2}, at: __se_sys_cachestat+0x3ee/0xbb0 mm/filemap.c:4372
CPU: 1 PID: 17332 Comm: syz-executor.4 Not tainted 6.10.0-rc4-syzkaller-00330-g7c16f0a4ed1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 __might_resched+0x5d4/0x780 kernel/sched/core.c:10196
 cgroup_rstat_flush+0x1e/0x50 kernel/cgroup/rstat.c:351
 workingset_test_recent+0x48a/0xa90 mm/workingset.c:473
 filemap_cachestat mm/filemap.c:4314 [inline]
 __do_sys_cachestat mm/filemap.c:4407 [inline]
 __se_sys_cachestat+0x795/0xbb0 mm/filemap.c:4372
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff329e7d0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff32ac600c8 EFLAGS: 00000246 ORIG_RAX: 00000000000001c3
RAX: ffffffffffffffda RBX: 00007ff329fb4120 RCX: 00007ff329e7d0a9
RDX: 0000000020000080 RSI: 0000000020000040 RDI: 0000000000000005
RBP: 00007ff329eec074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007ff329fb4120 R15: 00007ffd3e0ff4a8
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

