Return-Path: <linux-kernel+bounces-201995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0063E8FC64A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264C11C22BEB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482418FC74;
	Wed,  5 Jun 2024 08:24:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693A18FC6B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575844; cv=none; b=d4+fp5RJU/XA4vmE162BPJqPZSlnD8nWKLIimPLcvhOPg4etfluNqOi/l4Ti9WDNB5JVlLkU190DHp2zYpqyNGeciESFq4iXnjGKT9KlvYTtTXhCfB7exj2Lf4pjs0wzmUfjRmutbgpRbr4EZmj+rxpczZxBfjxNDQ02wLg7GAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575844; c=relaxed/simple;
	bh=oOpU5g+E7jeteb1mcO4RWt2+yZZsLkRgSALxxGRWy+k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UOoJzSBGKce96hHXN0lqesZ6CVJVmWKWTOFpGMzcgSw+GOuFfVmweFXmDwxHArFb/0qVAbUobuBolAhbp996OrBzjeADwF0Iwsc6KYLiL7oXk6Qbik4B9Q5VCeq9cfBvdajS9qXKH7iuT3LjgEPhCBwSjVVSO54DOR/VuiBFr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3748623a318so57897175ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575842; x=1718180642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rcl1cju2BjJSblGnl7YAvHHfgDUCg0DLeWpf6DKs3n4=;
        b=Kq0V1d7igBDzHovlsJCb0yMDIMY+aaGQ3bVc+oqfJ7/SA9Kcs+1I8JLzWEDEsLa5PQ
         jERI7jHcJrqKGrGow+dMiXQDm1/FH+2Z89ztHXf8QPKHsFKfAyTGj/lqrdj0vYeC1Cvv
         ihJnNdSDJqBXNNfY1VpfnzrbJwDMI4/Cmo9dmeB8ZEMfhEeJLwEiE7uZnUb+sBw/v86/
         2d5hu+WicZNyCc0wXkqxfj4SHSG8ftQ3HwFEDg3EGlr4njRrSgW8gKhfKNlUJ4VOZ+oS
         CZxmUOcHmPD61E10sgKtbG9e+XdGqY42T7Pn5Tcd8ALD9wLVTKEcNYCUIrTim0Jcd17k
         fG4g==
X-Gm-Message-State: AOJu0Yy0a9hgt6QbitmDXU4LfbPYkg9IFzdIAYT0kRKGCqFWKNIk8IBc
	JH8xEF+Q0i034vNgr9HST81h9zl8jksnmo8P7It9p0XPeC4nu+NAVc2HFmjfrXmQhvqLBq5ytNU
	3hM6VJFyuH5KLLsIl49msK45qvTar0YqVY6yYSUNGfVZhZ44A87F1evo=
X-Google-Smtp-Source: AGHT+IH/QUZ4YgNItyPcrgMtaey12CHMD2KNZi5ZW3vlhYw2fl4lS5ZzhJ6DKUteZHgc8zI38LMVxu9D7mm8BvensRLrNQwsj+mp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56a:0:b0:373:fed2:d92b with SMTP id
 e9e14a558f8ab-374b1ef5912mr1149035ab.2.1717575842635; Wed, 05 Jun 2024
 01:24:02 -0700 (PDT)
Date: Wed, 05 Jun 2024 01:24:02 -0700
In-Reply-To: <PN2PR01MB4891BF795360AE31E349CFECFCF92@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9b3ac061a204910@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in trie_delete_elem

============================================
WARNING: possible recursive locking detected
6.10.0-rc2-syzkaller-00022-g32f88d65f01b #0 Not tainted
--------------------------------------------
syz-executor.1/6309 is trying to acquire lock:
ffff88802e40e1f8 (&trie->lock){-.-.}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462

but task is already holding lock:
ffff88802e40c1f8 (&trie->lock){-.-.}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&trie->lock);
  lock(&trie->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor.1/6309:
 #0: ffff88807ada5090 (&child->perf_event_mutex){+.+.}-{3:3}, at: perf_event_exit_task+0x9b/0xaa0 kernel/events/core.c:13184
 #1: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2402 [inline]
 #1: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1fc/0x540 kernel/trace/bpf_trace.c:2444
 #2: ffff88802e40c1f8 (&trie->lock){-.-.}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2402 [inline]
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1fc/0x540 kernel/trace/bpf_trace.c:2444

stack backtrace:
CPU: 1 PID: 6309 Comm: syz-executor.1 Not tainted 6.10.0-rc2-syzkaller-00022-g32f88d65f01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15d3/0x5900 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
 bpf_prog_1db1603a7cfa36fb+0x45/0x49
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
 bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2444
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0x114/0x140 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0xb81/0xdc0 kernel/locking/qspinlock.c:557
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x272/0x370 kernel/locking/spinlock_debug.c:116
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
 _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
 trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
 bpf_prog_1db1603a7cfa36fb+0x45/0x49
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
 bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2444
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0xf5/0x120 include/trace/events/lock.h:122
 __mutex_lock_common kernel/locking/mutex.c:617 [inline]
 __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
 perf_event_exit_task+0x9b/0xaa0 kernel/events/core.c:13184
 do_exit+0xa37/0x27e0 kernel/exit.c:883
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 __do_sys_exit_group kernel/exit.c:1034 [inline]
 __se_sys_exit_group kernel/exit.c:1032 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7af347dca9
Code: Unable to access opcode bytes at 0x7f7af347dc7f.
RSP: 002b:00007ffc344b9708 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 000000000000001e RCX: 00007f7af347dca9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 00007f7af3400000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 </TASK>


Tested on:

commit:         32f88d65 Merge tag 'linux_kselftest-fixes-6.10-rc3' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162ace06980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb72437243175f22
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

