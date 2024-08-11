Return-Path: <linux-kernel+bounces-282168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C9294E05D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 09:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D1A1F2161A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 07:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C71CAAF;
	Sun, 11 Aug 2024 07:12:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D331C2A3
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723360342; cv=none; b=LxzdweEGYBtMcyshOwcrkQzs76wh5whDdYEONWn0mvp3xYz5SA75ffLdzEjiu4yPlhjul3I98gdJEMzqfwXZ9VQZ401DHMwdIRyGGh8O5S9J9NbpeGLWIVJoa5/9s1aEpYxmpuNClby28APXFxDDNWPCgo61cYNjoYaDFA5KhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723360342; c=relaxed/simple;
	bh=6Oyl5bhdj19mRbaJNKqy3lBmwyHtN4VyZYuaVWhwJhc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TxOZg5ZNjq8rtcSbht9qirXaOQmvUW8JHgsSnQAcVSVdlJaGnefFWItLNtQm0O8SLdLXmzK1wfL/bwlruELxbRvxRRHHGIJGNv1wzYR2Nh6gqf20fVgFIsvMAzkyNxGtIEnbGFRnH4Kgzz+lsOH7wVWK+3w9/bE1WyCogE/52Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37642e69d7eso41459425ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 00:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723360340; x=1723965140;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dV4oE8bjBP9PkD5OCKTOdoVWr2ZW8+vUmy1pWvkX8cs=;
        b=dSKFv/ArQitiHJ6s6suABQ06o6WivDwwLBr77oXUhFLcVZNa+HqmXIIAYuLjByQcpV
         mjzMmonQDlE2Q2lnZxZ9jrmmBol7IXv7fbFf9PHDoXTzj1nsA8lOUpqE1KN8VQXnHeSU
         +p56bPNdkLrI1/vefHG7p7AoolGbquW8Rpos7k1Q3bPANZ+IypALkKInlnXUBzBvBjWx
         bSZjPMXtdNCAZnU+hI7QT8MssSfC3T9nHClGu3aEMAfTvx0hvv/4jkWL7CGCyu0Iu9jP
         nlQ1ta6nV+yjYZF7VetjYcITFhyQvbNZGYQ8D9tzbOzt3WAIa7HV1NN9VQXYhkbykggg
         X2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEVzqx3pOl/DYY3Ky8B2Hue1l3fRN8kYBIV3brSn+6/8bTar9A9YwuFC0lrbS5BRonYEZrEp5knZHNjXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5j0+8NS/+7H8kY00wTkkjE4B/YIx52QjB8NTYSU5dc8EUZWg3
	rpbfnuPGc/AXdrvIxpnGg6OY38qWIS3ZPjp1qMVg1BHD7ZAI3aOgOn0YnQITvQ+A9KV1JSLxahO
	K7Z4yP5rzescXPO9tmeC9B1GRKbdpfeV+OZ3nG/92TdrtuUaqKdwb4Vg=
X-Google-Smtp-Source: AGHT+IGAl2fqs0tgfhAMVxQ7kChOufN5ZhQ42o5iyxgZ6uSHWfYT6iiWhieQH/YtTqQX/3cM5Vx70TuijLiFaS2UVOEkltPbuTex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b49:b0:380:fd76:29e4 with SMTP id
 e9e14a558f8ab-39b86f7b6damr5593325ab.4.1723360339914; Sun, 11 Aug 2024
 00:12:19 -0700 (PDT)
Date: Sun, 11 Aug 2024 00:12:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e18788061f631819@google.com>
Subject: [syzbot] [mm?] INFO: rcu detected stall in vm_mmap_pgoff
From: syzbot <syzbot+890a1df7294175947697@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb5e56d14912 Merge tag 'platform-drivers-x86-v6.11-2' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102b4a5d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=890a1df7294175947697
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e2044b21f4b5/disk-eb5e56d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad2274fd812e/vmlinux-eb5e56d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd82f6220580/bzImage-eb5e56d1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+890a1df7294175947697@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P6528/2:b..l
rcu: 	(detected by 1, t=10502 jiffies, g=157649, q=508 ncpus=2)
task:syz.2.7467      state:R  running task     stack:23296 pid:6528  tgid:6524  ppid:22273  flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:6851
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:235 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x8/0x90 kernel/kcov.c:311
Code: 44 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 4c 8b 04 24 <65> 48 8b 0c 25 00 d7 03 00 65 8b 05 c0 5b 70 7e a9 00 01 ff 00 74
RSP: 0018:ffffc90004d3f240 EFLAGS: 00000246
RAX: ffffffff8ba8c664 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900168cc000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000001 R08: ffffffff8ba8c677 R09: ffffffff8ba8c2db
R10: 0000000000000002 R11: ffff888067083c00 R12: 1ffff920009a7e93
R13: ffffc90004d3f498 R14: dffffc0000000000 R15: 0000000000000000
 xa_is_internal include/linux/xarray.h:175 [inline]
 xa_is_node include/linux/xarray.h:1264 [inline]
 xas_find+0x497/0x960 lib/xarray.c:1284
 next_uptodate_folio+0x29/0xa40 mm/filemap.c:3464
 filemap_map_pages+0x302/0x1e70 mm/filemap.c:3616
 do_fault_around mm/memory.c:5019 [inline]
 do_read_fault mm/memory.c:5052 [inline]
 do_fault mm/memory.c:5191 [inline]
 do_pte_missing mm/memory.c:3947 [inline]
 handle_pte_fault+0x39aa/0x6eb0 mm/memory.c:5522
 __handle_mm_fault mm/memory.c:5665 [inline]
 handle_mm_fault+0xf70/0x1880 mm/memory.c:5833
 faultin_page mm/gup.c:1194 [inline]
 __get_user_pages+0x6ec/0x16a0 mm/gup.c:1493
 populate_vma_page_range+0x264/0x330 mm/gup.c:1932
 __mm_populate+0x27a/0x460 mm/gup.c:2035
 mm_populate include/linux/mm.h:3415 [inline]
 vm_mmap_pgoff+0x2c3/0x3d0 mm/util.c:593
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f05b9b779f9
RSP: 002b:00007f05ba90e048 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f05b9d06058 RCX: 00007f05b9b779f9
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007f05b9be58ee R08: ffffffffffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f05b9d06058 R15: 00007ffeeee41568
 </TASK>
rcu: rcu_preempt kthread starved for 10541 jiffies! g157649 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:24624 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_timeout+0x1be/0x310 kernel/time/timer.c:2581
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2034
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2236
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.11.0-rc2-syzkaller-00011-geb5e56d14912 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 00 d7 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d e5 cb 9b 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc900001a7d08 EFLAGS: 00000246
RAX: ffff888017af0000 RBX: ffff8880196ce864 RCX: 000000000ab344c9
RDX: 0000000000000001 RSI: ffff8880196ce800 RDI: ffff8880196ce864
RBP: 000000000003a678 R08: ffff8880b9337c7b R09: 1ffff11017266f8f
R10: dffffc0000000000 R11: ffffffff8bad6c90 R12: ffff88801bb1b800
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8eeca1a0
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f90f82d5b5e CR3: 0000000060604000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:702
 cpuidle_enter_state+0x112/0x480 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:230 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:326
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
 start_secondary+0x100/0x100 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x147
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

