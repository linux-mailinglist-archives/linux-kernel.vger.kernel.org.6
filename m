Return-Path: <linux-kernel+bounces-424700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B979DB83F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86DA1630F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269071A0B04;
	Thu, 28 Nov 2024 13:07:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB719EEB4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799243; cv=none; b=HeaP/fpd07k+wCUuwvIIApWqKSmIKRcfFXLLL6aWnVKrmLNgbMHzKTIpc/bVTkEjLMfPmNh/aBEifHj4bCMH+XPwG0kyZ4SDxYz94UYSBMJgDZtExD7o8Ok1/PSL7AyDgrdZtEqNOEWJ07H5XJEuiWVEDKzwbCN++jgz3lpR5Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799243; c=relaxed/simple;
	bh=Z+0gHjvzJ3dl2ea6C2iegoeEOUv/a9CQDviIEh+O+X0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OZr1bPJQyGwN4yQHBmKtkxhy/4BiS3XFsjvDBVxmStFi3yPpOMjyp2ydLa8U/v/Fy/irPpR/jk5v4Rvcp0HBqF8t+jiSc0RU6NpqpM/euztjDugFh3TXUILUWCCR9CH/nvUz0cKtk2hUlwi4KOXSzyWm+F68uiSPof7pcsnDJN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a76ba215b2so7062375ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799241; x=1733404041;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vq2tEXQ5ienCGL9iI0S9D6d7ede264gKxSALu6sMAe8=;
        b=t/t/Rp7vUirb6Zc9wdp+8I4qiZInZmilO9e57Z32Z2jaq+gYS7QzO5MDTZVWizixmY
         AyY4s5wPc3GU6E4VSCEeyuZ6b9PRi9hMdGSmQHxuDeXzr8KHIfywok6S2esY7W00JFuC
         UBxlfHAXt0dg4AQ3fgtW8b78FMcOpQ1d30lx8vfddq9uW16qkr7iTBFGtfO2GZtSikXf
         1JrGqzMUfrw8ufiq2TwRymr+3ncmhnGuPPqfvlhlzVwzvb676/YPy3Le6iJIIlnaZ0j4
         FVPZ6eUOnpNP843MIudQfiQcWDn4iNk2eVfXnVQP5lQ3T5B2nroDqRsMTLhnvYIdqiFf
         EI/w==
X-Forwarded-Encrypted: i=1; AJvYcCXPSF0LK7PDA3tou7526lyMjbND6rQKt70GhtQ5cr6xNdBEOJyuXUIipI0/gF6p+bfmzdkeOHh1hohKA3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKAATIJ01+0jx6/yT+VGfOQZm1dAGdixqY1tPxAnUY3H63Gfol
	pT8qhxRppRjSlippSUSJtF8OwUhmNQTgDgFRiGBb2g+Y7vFOZmQ1C/VqO4myfdcNk57Eso4mNb8
	i9sRqAjRmLVi1pHZXgRRlVzfBK4ZVyynHqAoVzbgKsz0a7EIs/UuMmgM=
X-Google-Smtp-Source: AGHT+IH/nKALHn2UUI6EUY6gTueQeLXHdM0CIIDPH4WSpGAome3DjsFyrqDaXUTD1n6w+TdOK7o00MG72BADVlTGmcnsnsF7zR8Q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:221e:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3a7c555ec8amr65272785ab.9.1732799241418; Thu, 28 Nov 2024
 05:07:21 -0800 (PST)
Date: Thu, 28 Nov 2024 05:07:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67486b09.050a0220.253251.0084.GAE@google.com>
Subject: [syzbot] [bpf?] [trace?] WARNING: locking bug in __lock_task_sighand
From: syzbot <syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c22dc1ee3a1 Merge tag 'mailbox-v6.13' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f2bee8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8df9bf3383f5970
dashboard link: https://syzkaller.appspot.com/bug?extid=97da3d7e0112d59971de
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9137c3e19e21/disk-2c22dc1e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1aad80837d89/vmlinux-2c22dc1e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d7979d71d6d2/bzImage-2c22dc1e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.12.0-syzkaller-09435-g2c22dc1ee3a1 #0 Not tainted
-----------------------------
iou-wrk-9958/9967 is trying to lock:
ffff88802744ae58 (&sighand->siglock){-.-.}-{3:3}, at: __lock_task_sighand+0x149/0x2d0 kernel/signal.c:1379
other info that might help us debug this:
context-{5:5}
3 locks held by iou-wrk-9958/9967:
 #0: ffff88814d2870c0 (&acct->lock){+.+.}-{2:2}, at: io_acct_run_queue io_uring/io-wq.c:260 [inline]
 #0: ffff88814d2870c0 (&acct->lock){+.+.}-{2:2}, at: io_wq_worker+0x44b/0xed0 io_uring/io-wq.c:654
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2350 [inline]
 #1: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: bpf_trace_run2+0x1fc/0x540 kernel/trace/bpf_trace.c:2392
 #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8e93c520 (rcu_read_lock){....}-{1:3}, at: __lock_task_sighand+0x29/0x2d0 kernel/signal.c:1362
stack backtrace:
CPU: 1 UID: 0 PID: 9967 Comm: iou-wrk-9958 Not tainted 6.12.0-syzkaller-09435-g2c22dc1ee3a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5176
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __lock_task_sighand+0x149/0x2d0 kernel/signal.c:1379
 lock_task_sighand include/linux/sched/signal.h:743 [inline]
 do_send_sig_info kernel/signal.c:1267 [inline]
 group_send_sig_info+0x274/0x310 kernel/signal.c:1418
 bpf_send_signal_common+0x3c4/0x630 kernel/trace/bpf_trace.c:881
 ____bpf_send_signal kernel/trace/bpf_trace.c:886 [inline]
 bpf_send_signal+0x1d/0x30 kernel/trace/bpf_trace.c:884
 bpf_prog_631417f49dd64198+0x25/0x48
 bpf_dispatcher_nop_func include/linux/bpf.h:1290 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2351 [inline]
 bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2392
 trace_contention_end+0x114/0x140 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0xb7e/0xdb0 kernel/locking/qspinlock.c:557
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
 io_acct_run_queue io_uring/io-wq.c:260 [inline]
 io_wq_worker+0x44b/0xed0 io_uring/io-wq.c:654
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

