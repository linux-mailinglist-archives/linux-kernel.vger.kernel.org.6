Return-Path: <linux-kernel+bounces-438789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4DD9EA5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62ACC2886BF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277431AAA36;
	Tue, 10 Dec 2024 02:48:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0220719DFB5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798884; cv=none; b=a5I8EJRtbiBy1a8t6U/KijqPtcTZXwv2vQDCFfIYRqfiXgXQ7pL2WDN+DNkrIMzZ7KXLPMITlwpI8fZKCuG6ruRzMNOi+ae0E++0hMgV/a6iQWtMa96Wwi5LVakR8n3ms69g5ray4QtUormPbMCJc5StQt34y5ZpQ4TSoBts3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798884; c=relaxed/simple;
	bh=I1Dj0RCG+Don+T68wEWCdnxtaMEuGdO1exmQEkWPfS4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Gve1BR5KYmqNyDq/XXC11VfgJmM1XYWllakeo3d/jFXdCo5SDXM0IPtCFXa6kBHONGf+ivr3nLelWDvMWCHBKzdORisyRhXH3oJyEw/P2H9u1s0HDS1u3diVN2UvguYQMgl28E4nnUjUC0McIEWelMR6NX9EZEzDs9e+FvdzAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-841a54a66a2so535313339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 18:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798882; x=1734403682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AT0Kkq4Hh3FibR+Xb0rirE0LNC6cFvKaqli+khFd8GU=;
        b=qkNyKA57Nedh2n1VrVF3Mng0KxrU/DzUQ8IrIQ4Ccxd5lNZq3xr1RdOr65x2tXv/MS
         dd/cErbXhi/SgHh2dozXCxYR+KlfM4B0DkhtisoH6NoDtNcIKynDGA4K+oyegVaQP9p7
         LKqEQE9/NEsJ2Iy2bVXl+tHS/TN6wz2TvH5xoNtKwsZFq9ijG+m5bs64sADYPYIvxe4D
         sRR6wm7ok14E9H9QYcaclB9/8MEcw/8VeKOHNmgwvtBNeX/A8O/RtHcH/BswNmOzzpsz
         dIdCGULM51XmlcmwikFxOFKTqkgbwWYnLqYtKcAb1WLLAaLNTT/gqUmxMCTPFx4geXC3
         oIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0EvkBGqK85VnLJaWufiWKb7oA8qNzWvhqO3saz6KyUD7w86eQRozESupb4lnc1Lr1Qxdcvon9AhtE0Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtK/HcY+hHXhJhtoGiZoTBIRbjdv/9ebxwHPHxTu6p1xbZ1SK
	XBJqgxAhRwUtJyLhRdc5eLA1jv9xzbTu0/xzXjwFHR7UsaG8WMTnuEzoT3EjK2PTLOUKNUzUMGa
	e+KRDn8TQUFN4/q5IQcmtBNanTD/k7TCNLnVT5fKsRllVDuT7YMmMsVA=
X-Google-Smtp-Source: AGHT+IGQr+ymmoOo3Dm58nk04Sp9nFGffYqUo83yzDUiEbBTZDZ3ALlv9/0O0MXcw/aw8nvYVLEuDbQpcCijMXi9xCBrX5Kz+RTb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c563:0:b0:3a7:6792:60f with SMTP id
 e9e14a558f8ab-3a811c799a7mr158556505ab.4.1733798882168; Mon, 09 Dec 2024
 18:48:02 -0800 (PST)
Date: Mon, 09 Dec 2024 18:48:02 -0800
In-Reply-To: <wx7x2qzdmadbdjy363jqz6nsfcnr3tougzlvb3oeomlqxjf6fl@dygmglqiqyx6>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6757abe2.050a0220.2477f.005d.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in mas_preallocate (2)
From: syzbot <syzbot+882589c97d51a9de68eb@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=12997 jiffies, g=15009, q=2022 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 12997 (4294963490-4294950493), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 12997 jiffies! g15009 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:25624 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 6541 Comm: syz-executor Not tainted 6.13.0-rc1-syzkaller-00172-g6e165f544379 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5853
Code: 2b 00 74 08 4c 89 f7 e8 8a 0a 8b 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc900042ff080 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200085fe1c RCX: ffff888025bf8ad8
RDX: dffffc0000000000 RSI: ffffffff8c0aa9a0 RDI: ffffffff8c5f98c0
RBP: ffffc900042ff1d8 R08: ffffffff942a0887 R09: 1ffffffff2854110
R10: dffffc0000000000 R11: fffffbfff2854111 R12: 1ffff9200085fe18
R13: dffffc0000000000 R14: ffffc900042ff0e0 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe0e0053440 CR3: 000000002d710000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 rcu_read_lock include/linux/rcupdate.h:849 [inline]
 page_ext_get+0x3d/0x2a0 mm/page_ext.c:525
 page_table_check_clear+0x4b/0x550 mm/page_table_check.c:74
 get_and_clear_full_ptes include/linux/pgtable.h:712 [inline]
 zap_present_folio_ptes mm/memory.c:1510 [inline]
 zap_present_ptes mm/memory.c:1595 [inline]
 do_zap_pte_range mm/memory.c:1697 [inline]
 zap_pte_range mm/memory.c:1739 [inline]
 zap_pmd_range mm/memory.c:1822 [inline]
 zap_pud_range mm/memory.c:1851 [inline]
 zap_p4d_range mm/memory.c:1872 [inline]
 unmap_page_range+0x376a/0x48d0 mm/memory.c:1893
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1983
 exit_mmap+0x288/0xd50 mm/mmap.c:1263
 __mmput+0x115/0x3c0 kernel/fork.c:1406
 exit_mm+0x220/0x310 kernel/exit.c:570
 do_exit+0x9b2/0x28e0 kernel/exit.c:925
 do_group_exit+0x207/0x2c0 kernel/exit.c:1087
 get_signal+0x16b2/0x1750 kernel/signal.c:3017
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f479f176197
Code: Unable to access opcode bytes at 0x7f479f17616d.
RSP: 002b:00007fffa52fadc0 EFLAGS: 00000293 ORIG_RAX: 000000000000003d
RAX: fffffffffffffe00 RBX: 000000000000199b RCX: 00007f479f176197
RDX: 0000000040000000 RSI: 00007fffa52fadfc RDI: 00000000ffffffff
RBP: 00007fffa52fadfc R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 00007fffa52fae80
R13: 00007fffa52fae88 R14: 0000000000000009 R15: 0000000000000000
 </TASK>


Tested on:

commit:         6e165f54 mm/page_isolation: fixup isolate_single_pageb..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=1571d4df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6da4e19788a025a7
dashboard link: https://syzkaller.appspot.com/bug?extid=882589c97d51a9de68eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

