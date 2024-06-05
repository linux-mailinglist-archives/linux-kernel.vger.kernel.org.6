Return-Path: <linux-kernel+bounces-201916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B49AC8FC53E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EDB1F27A26
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1D18F2CE;
	Wed,  5 Jun 2024 07:57:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A259218C35B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574227; cv=none; b=Ysvl3n8QV2L42mwaiV8PiNtH3JfX6CPgLsCREnfTf7ER8cSciGHH8wafjb0RTVKze/SgZvjHwaT8yveTYo7zfo8IODA65YtWswCBc78mOlpaXjkA4qKnp+agfQlfazTEbPg+efO/slJD/qGsIXv70dQ9eiML1In2mHRgmadT7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574227; c=relaxed/simple;
	bh=NDuhSmdrJPQpqFCWMfv4uHcRAhuGGMvytDPFRRWIf6w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mv6SSn8g0F+3XHDO1DZ5kDAMopzCXCLPytKnC9X6zPoH/2h2G9Ea9IOT6ygL7qE7D+I1cYqxMv50ZCCtuEfEEH7XWOs3FP9zGv5B352wjii4ETXlx6X8oQstWUJT5kgLXBuVcdWIJSsKIZiEVNzSzKD4eu0qz972g/AuaQYRvUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e94cac3ee5so768675439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717574225; x=1718179025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zc4yOcmClv40Ff0c1qiaaG3W/76OVsEUoHwQ+0jgLE=;
        b=LDYt8C3kHOzV8WpWFk2//CtbepLhMlyUhmBmoskuIx6I6Qgq0+v0eXyigC/Z8Ut5Pd
         yxf0UupnaHTjW5QVhKf6P80+YVB7lh6S00ak14oPCA30APIaairBgQkAJxIEt+w6qydn
         rJjZ+GQ7UiFQ6vXFHG0w2wADWNyJCSy0TkDA2jVnv8qwknPCFLSsaLxgYe6kY6vvZ0nw
         Ld+UjRQO01YPkOV8hGgLz/QD+XUG8QSSUbmTh2ekJa2/D9WOTFcTYambsxsYiIwnfarX
         5xNyOcFKzH39NPlUBtj8eOtac5I5ic1XPjqcd79IGeNOp6GZiPSfXzOd8pGAoQNdEUkK
         /xmA==
X-Gm-Message-State: AOJu0YwKyk0o6w7yMA3iFXOX/hOGl7OqGM7vkSoPsOu2oUo3j0aQaJJM
	hPOOJJPf2cVOwUCV8z2tMjeUypmYb33ZWKFGxm6U1Bz7BtV2cvMAGTzmT5/SC7x00w4AJizmlWV
	xCf6sRHDTLQr7AsDjUmUeKPNuvN1DiZiPqbuN7Wh05WQ18jCwrxvqL5w=
X-Google-Smtp-Source: AGHT+IFhty13hKVcPMSsW4U5B5uVWpy3Ml9lgHCRZrRZUsxh1MOXzfL8EhrEbLrTrNOt8OCp0RmsjbpvWWFQhEuOcLhKYaI4QdAQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cc55:0:b0:488:d9fb:b418 with SMTP id
 8926c6da1cb9f-4b63be91addmr27031173.6.1717574224910; Wed, 05 Jun 2024
 00:57:04 -0700 (PDT)
Date: Wed, 05 Jun 2024 00:57:04 -0700
In-Reply-To: <PN2PR01MB4891734D357ACCDDD106F360FCF92@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008d2734061a1fe9b3@google.com>
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
6.10.0-rc2-syzkaller-00001-ge377d803b65e #0 Not tainted
--------------------------------------------
syz-executor.0/6233 is trying to acquire lock:
ffff88802e83a1f8 (&trie->lock){-.-.}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462

but task is already holding lock:
ffff8880696e91f8 (&trie->lock){-.-.}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&trie->lock);
  lock(&trie->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz-executor.0/6233:
 #0: ffffffff8e3809a8 (tracepoints_mutex){+.+.}-{3:3}, at: tracepoint_probe_unregister+0x32/0x990 kernel/tracepoint.c:548
 #1: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #1: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2409 [inline]
 #1: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x21f/0x570 kernel/trace/bpf_trace.c:2451
 #2: ffff8880696e91f8 (&trie->lock){-.-.}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2409 [inline]
 #3: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x21f/0x570 kernel/trace/bpf_trace.c:2451

stack backtrace:
CPU: 0 PID: 6233 Comm: syz-executor.0 Not tainted 6.10.0-rc2-syzkaller-00001-ge377d803b65e #0
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
 __bpf_trace_run kernel/trace/bpf_trace.c:2410 [inline]
 bpf_trace_run2+0x30d/0x570 kernel/trace/bpf_trace.c:2451
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
 __bpf_trace_run kernel/trace/bpf_trace.c:2410 [inline]
 bpf_trace_run2+0x30d/0x570 kernel/trace/bpf_trace.c:2451
 __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
 trace_contention_end+0xf5/0x120 include/trace/events/lock.h:122
 __mutex_lock_common kernel/locking/mutex.c:617 [inline]
 __mutex_lock+0x2e5/0xd70 kernel/locking/mutex.c:752
 tracepoint_probe_unregister+0x32/0x990 kernel/tracepoint.c:548
 bpf_raw_tp_link_release+0x45/0x70 kernel/bpf/syscall.c:3519
 bpf_link_free+0x10e/0x2d0 kernel/bpf/syscall.c:3065
 bpf_link_put_direct kernel/bpf/syscall.c:3106 [inline]
 bpf_link_release+0x7b/0x90 kernel/bpf/syscall.c:3113
 __fput+0x406/0x8b0 fs/file_table.c:422
 __do_sys_close fs/open.c:1555 [inline]
 __se_sys_close fs/open.c:1540 [inline]
 __x64_sys_close+0x7f/0x110 fs/open.c:1540
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7ed1e7cb9a
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007ffead8b0970 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 00007f7ed1e7cb9a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000006
RBP: 00007ffead8b0a48 R08: 00007f7ed1e00000 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000293 R12: 000000000001abb1
R13: 00007f7ed1fabf8c R14: 00007f7ed1fabf80 R15: 0000000000000226
 </TASK>


Tested on:

commit:         e377d803 kernel/trace: fix possible deadlock in trie_d..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=12178036980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb72437243175f22
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

