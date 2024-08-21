Return-Path: <linux-kernel+bounces-295904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6F095A2C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E97281E20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2665615099B;
	Wed, 21 Aug 2024 16:27:28 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8D14F13A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257647; cv=none; b=RYe6FIsjLcEiCTW1xZ4QXRqf9iLnGi4FPIrkfZiIL2kUEfB7M0YJqfX2w3rZ9ZXXPwRHwspD2RRNyUNq4Qfe4wIP0lholaGNBVLO5u6Axfr8PJnfp35YR73muam/92quqaUET+rXv48ZKCB9cNSOsVK4M4GFOdJzEem/7s3kp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257647; c=relaxed/simple;
	bh=e33U+rTmnfQStgJSVto0c+JH3L8slpYhP0UMBv7T57k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=usxNz4/WeGeG42EtoTj6fgrOX/5VEbfczFu0LHb6sOITLsixcO2sUeJWKK68Ap3NZCG3Z0pWe0a4gVZ/hI/aGZfeEGS66UhI1IlQ3h1CMcQPgIKiB3nPZ/Nf9qVO2WkmbXD3MgrOEhhZrPmyg+eOyzlED9stGtddw4y6sjODvWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d27488930so53223075ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257644; x=1724862444;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2SWRppTTBX+ENTNwMwjikX5Z9iEvhX8AMGK5nhA6V+w=;
        b=Zs2PUSwfpEkefWQmFaPye1vKmVIJJiONkIOToMhpc9F0HcPGl9mkYop/yzN0L2E6Sl
         qEsa91G84+47uMkP48+aGAwlgUahox+g1s9/0AyefVkNy0mYoxvtd1SJ0FMcB2NHnDTX
         kJ5DMGN/l1KO0M2oe2uTwaohs7lDI6McoAcr43ajuDDyY/ea75/oWhC6y1dEG4ciJpkm
         ypGMovL7aeoOkj7qdwUZ5ajizulU9KIsyzZKIUG6KAjaeYSpFl74ZUZVwhZc9bkiKwqk
         dJXlnQ+t1UAGNLaIDsELYo6Ar//vVoL6W6q+wJTvIc77IK/GVEh+WG0ThbcYlJ1VSRyE
         APuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwsvar9G7ixBQm8+voQeJPhIjZGucP8bdyg0JmHRPmesP9kds6lpSgKJ4xBBTkN8kGzL8D9WFPjshjBz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oQqlBcciJeASt59rF0RvL6s60kUetTZhHcE5/ZIiXyRlR2/w
	xYandmg4W2TFCGm2PXb2TrySxE0Nzwvakrk2hW9BvBcMyDcCJOutAZIvtR3NWtHtPDWwTIqAkI7
	2+Z21mAgIsWt2PuJz4JPzaGVZtfBNTcW+Z3V5uyXke5hJPLhPAmeF+hA=
X-Google-Smtp-Source: AGHT+IF3kXSAYlVlqrzntQiUBF1JUHVaveVjloMQ2anYrNvJ3gTOgHd6kHaQR/HAHADgUj8zH90rYitr+pqoW8CXiqrrgUI1kmYq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d16:b0:39d:1ca5:3903 with SMTP id
 e9e14a558f8ab-39d6c353c38mr2207425ab.1.1724257644102; Wed, 21 Aug 2024
 09:27:24 -0700 (PDT)
Date: Wed, 21 Aug 2024 09:27:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060d4fa06203404a1@google.com>
Subject: [syzbot] [kernel?] WARNING in update_curr_dl_se
From: syzbot <syzbot+cdf91ee2261629ee3c6b@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    367b5c3d53e5 Add linux-next specific files for 20240816
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11e213c5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=cdf91ee2261629ee3c6b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0b1b4e3cad3c/disk-367b5c3d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5bb090f7813c/vmlinux-367b5c3d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6674cb0709b1/bzImage-367b5c3d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdf91ee2261629ee3c6b@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5401 at kernel/sched/sched.h:1476 lockdep_assert_rq_held kernel/sched/sched.h:1476 [inline]
WARNING: CPU: 1 PID: 5401 at kernel/sched/sched.h:1476 rq_clock kernel/sched/sched.h:1624 [inline]
WARNING: CPU: 1 PID: 5401 at kernel/sched/sched.h:1476 replenish_dl_new_period kernel/sched/deadline.c:777 [inline]
WARNING: CPU: 1 PID: 5401 at kernel/sched/sched.h:1476 update_curr_dl_se+0x66f/0x920 kernel/sched/deadline.c:1511
Modules linked in:
CPU: 1 UID: 0 PID: 5401 Comm: kworker/u8:10 Not tainted 6.11.0-rc3-next-20240816-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:lockdep_assert_rq_held kernel/sched/sched.h:1476 [inline]
RIP: 0010:rq_clock kernel/sched/sched.h:1624 [inline]
RIP: 0010:replenish_dl_new_period kernel/sched/deadline.c:777 [inline]
RIP: 0010:update_curr_dl_se+0x66f/0x920 kernel/sched/deadline.c:1511
Code: b5 50 fe ff ff 4c 89 ff ba 20 00 00 00 e8 e9 4f 00 00 e9 58 fe ff ff 4c 89 ef be 20 00 00 00 e8 b7 13 00 00 e9 46 fe ff ff 90 <0f> 0b 90 e9 be fb ff ff 89 f1 80 e1 07 38 c1 0f 8c b5 f9 ff ff 48
RSP: 0018:ffffc900047bf6c8 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8880b903ea40 RCX: 0000000000000003
RDX: dffffc0000000000 RSI: ffffffff8c0adfc0 RDI: ffffffff8c60a8c0
RBP: 0000000000000031 R08: ffff8880b902c883 R09: 1ffff11017205910
R10: dffffc0000000000 R11: ffffed1017205911 R12: ffff8880b903f468
R13: ffff8880b903f428 R14: 1ffff11017207e8f R15: ffff8880b903f858
FS:  0000000000000000(0000) GS:ffff8880b9100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000203f6030 CR3: 000000001f046000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 update_curr+0x575/0xb20 kernel/sched/fair.c:1176
 put_prev_entity+0x3d/0x210 kernel/sched/fair.c:5505
 put_prev_task_fair+0x4d/0x80 kernel/sched/fair.c:8686
 put_prev_task kernel/sched/sched.h:2423 [inline]
 put_prev_task_balance+0x11d/0x190 kernel/sched/core.c:5886
 __pick_next_task+0xc6/0x2f0 kernel/sched/core.c:5946
 pick_next_task kernel/sched/core.c:6012 [inline]
 __schedule+0x725/0x4ad0 kernel/sched/core.c:6594
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6818
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6842
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
 task_rq_unlock kernel/sched/sched.h:1759 [inline]
 __sched_setscheduler+0xf35/0x1ba0 kernel/sched/syscalls.c:858
 _sched_setscheduler kernel/sched/syscalls.c:880 [inline]
 sched_setscheduler_nocheck+0x190/0x2e0 kernel/sched/syscalls.c:927
 kthread+0x1aa/0x390 kernel/kthread.c:370
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

