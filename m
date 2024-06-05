Return-Path: <linux-kernel+bounces-201889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585448FC4BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBC41C20F20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651D18F2C2;
	Wed,  5 Jun 2024 07:39:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0564918C351
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573146; cv=none; b=tIE+osk8ZU95wWH8Rk2HJwHVpq2lXLmJaEmYkSk24+ZUvt4ZoMlR76DfcHgaaEB87IVLZQ7Yi0tvt0SZvWurR4jn24G5DQvJOp6IrRlbicNWeUDfoTJUsH6v+Yc54J4ZcFgUHDzSqhRPVV9W1Rz7XCtUbBQr7/Kdm2zfU5Z0b04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573146; c=relaxed/simple;
	bh=XtsjbUm4apPzSablpogz7OxUa48UxNDvHjH0zCd5vkI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RO90ifewPwb5aZlhJjNa69DsO24W8pLd3Tsa+W7wSfBkUc9MWI6/VqNfcXkwghOosptXklNcTwEEIiuK5C1NynAGPKqHXCJRy4IqchqpFJoWOS+6NIeYqF4kphTMUGYwn18Rp6FEtiUyYNk6lf6q1mgnOxVA4ZD/6SPcsry/SG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb3d17daebso85517239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573144; x=1718177944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGgNSTGGpqeGrC6lZCXVqKNCG4AlR2z6EZDHs3ebEVs=;
        b=wZTml8Dew/KOA6mUwU2aXYY8FWPfJbVJyy0DI3KC4k+e1TMFnMSPXHBZdP4u+w01LR
         EsK5Y93z8izajCQ1+pGlkSX4WQz490tlvFpMxsk78JudFBDoTRDyepwb99yU9mc0i1be
         zLobBTlLp9DetfeSb97A2AGpoO527As+NulcauaNX9X0FQOMV0ZTHVMG3EeEvY879wgE
         p1xmRbBEb3Tkby29NtsHeGn/mug1l1PoY0IJT3CGTGwumX/KP0cr+udoGcp9uWOmg1ii
         OaLX1cgmGeUnR3SK7w3kgUY20z/3UQ3GONvdhBPE/6XU4COqdTOShcVEu7wncHfeVxQj
         5KMA==
X-Gm-Message-State: AOJu0Yym0CAEfY7qgIVdkZLhCYhxfBaMyUxr+FwUT/ELFjX0a6fqjza6
	2LythcjsKGRoB/9/8QNr/jKH7iZRYDa5GNkonM2s/ZZ1YC1UcEPKW/kWI4LLqRMtqJHiqZM4Qkl
	sceOqh30ChM8dcktMSqjDMWyF/V6UhGx0CYEIza66D68FP8iQfWk4K0E=
X-Google-Smtp-Source: AGHT+IHMR7mKFbeWX9Asu0Q+OJg8XD6dS5z/CoBz/Y4PlDoaFumO1CnvVXo0gDxytrIKKGGa67kuup/+DBQbSdQ1e5wwn/2j2zRI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8412:b0:487:100b:9212 with SMTP id
 8926c6da1cb9f-4b63a95ca73mr49230173.3.1717573144243; Wed, 05 Jun 2024
 00:39:04 -0700 (PDT)
Date: Wed, 05 Jun 2024 00:39:04 -0700
In-Reply-To: <PN2PR01MB489119119088A1E7091BB6B9FCF92@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023808a061a1fa99a@google.com>
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
udevd/5414 is trying to acquire lock:
ffff88807eff51f8 (&trie->lock){-.-.}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462

but task is already holding lock:
ffff88807eff59f8 (&trie->lock){-.-.}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&trie->lock);
  lock(&trie->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by udevd/5414:
 #0: ffff88801f3e8f08 (kn->active#5){.+.+}-{0:0}, at: kernfs_fop_open+0x93/0xd10 fs/kernfs/file.c:601
 #1: ffff8880162ecc38 (&kernfs_locks->open_file_mutex[count]){+.+.}-{3:3}, at: kernfs_open_file_mutex_lock fs/kernfs/file.c:56 [inline]
 #1: ffff8880162ecc38 (&kernfs_locks->open_file_mutex[count]){+.+.}-{3:3}, at: kernfs_get_open_node fs/kernfs/file.c:520 [inline]
 #1: ffff8880162ecc38 (&kernfs_locks->open_file_mutex[count]){+.+.}-{3:3}, at: kernfs_fop_open+0x74d/0xd10 fs/kernfs/file.c:700
 #2: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #2: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #2: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2409 [inline]
 #2: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x21f/0x570 kernel/trace/bpf_trace.c:2451
 #3: ffff88807eff59f8 (&trie->lock){-.-.}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:462
 #4: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #4: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
 #4: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2409 [inline]
 #4: ffffffff8e333f60 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x21f/0x570 kernel/trace/bpf_trace.c:2451

stack backtrace:
CPU: 1 PID: 5414 Comm: udevd Not tainted 6.10.0-rc2-syzkaller-00001-ge377d803b65e #0
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
 kernfs_open_file_mutex_lock fs/kernfs/file.c:56 [inline]
 kernfs_get_open_node fs/kernfs/file.c:520 [inline]
 kernfs_fop_open+0x74d/0xd10 fs/kernfs/file.c:700
 do_dentry_open+0x95a/0x1720 fs/open.c:955
 do_open fs/namei.c:3650 [inline]
 path_openat+0x289f/0x3280 fs/namei.c:3807
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_openat fs/open.c:1436 [inline]
 __se_sys_openat fs/open.c:1431 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1431
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f17b169a4
Code: 24 20 48 8d 44 24 30 48 89 44 24 28 64 8b 04 25 18 00 00 00 85 c0 75 2c 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 76 60 48 8b 15 55 a4 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffdf6fcc1a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f7f17b169a4
RDX: 0000000000080000 RSI: 00007ffdf6fcc2d8 RDI: 00000000ffffff9c
RBP: 00007ffdf6fcc2d8 R08: 0000000000000008 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
R13: 000056111e750b42 R14: 0000000000000001 R15: 000056111e76c160
 </TASK>


Tested on:

commit:         e377d803 kernel/trace: fix possible deadlock in trie_d..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=111a49bc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb72437243175f22
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

