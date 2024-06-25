Return-Path: <linux-kernel+bounces-228158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146F915B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B3B1F22243
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D7D179A8;
	Tue, 25 Jun 2024 01:23:44 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE217591
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278623; cv=none; b=NgASb5V5iaxeseUmIc/EztmgLURvt6G6isktOSfYPQK5W2zP3B/QAEKQbiBkjoSztb0mF7teXZcJfdFZ3TItuXuqcTa7V0+dynvnuVmlri+U3Ls5UVyJhPloQxpjRpb01+hY7qpcMYME+tTUH/pZAfSibw6VPf0ZLRwsp4fvDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278623; c=relaxed/simple;
	bh=FqezfserucLvYhMC1eAJtKWnTqVcERQgbNUsHT1uKWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SWyS03On+6WOgoJ8h3t6oB5UpLc2yzsxFsBkwJY+UXMNSH7dufce/xD7CFm52bV9sohrB4+VQkHwEJkoHnEY/cgoET05RwJWGIlzjcOp1pEHb60ncEI+sadBv6Cd+tfPyuM381qh8VBzwrOwWLUWk9Qd9FhjoiM1RFWVNiZ+4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45P1MqpW068712;
	Tue, 25 Jun 2024 10:22:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Tue, 25 Jun 2024 10:22:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45P1MqUc068709
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 25 Jun 2024 10:22:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <82cf2f25-fd3b-40a2-8d2b-a6385a585601@I-love.SAKURA.ne.jp>
Date: Tue, 25 Jun 2024 10:22:50 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in __show_regs
 (2)
To: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>
References: <000000000000a8c856061ae85e20@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000a8c856061ae85e20@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello.

This report is triggered by my debug printk() patch at
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/net/core/rtnetlink.c?id=5210cbe9a47fc5c1f43ba16d481e6335f3e2f345
but I can't find where the bug is (x86 bug or mm bug or kasan bug or my bug).

On 2024/06/15 16:06, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a957267fa7e9 Add linux-next specific files for 20240611
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=171e6e56980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9a880e96898e79f8
> dashboard link: https://syzkaller.appspot.com/bug?extid=e9be5674af5e3a0b9ecc
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Quoting from https://syzkaller.appspot.com/text?tag=CrashReport&x=17786fb1980000
and https://syzkaller.appspot.com/text?tag=CrashLog&x=15e0202a980000 :

----------------------------------------
BUG: KASAN: stack-out-of-bounds in __show_regs+0xa6/0x610 arch/x86/kernel/process_64.c:83
Read of size 8 at addr ffffc90008807618 by task syz.0.1430/9588

CPU: 0 UID: 0 PID: 9588 Comm: syz.0.1430 Not tainted 6.10.0-rc5-next-20240624-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __show_regs+0xa6/0x610 arch/x86/kernel/process_64.c:83
 show_trace_log_lvl+0x3d4/0x520 arch/x86/kernel/dumpstack.c:301
 sched_show_task+0x578/0x740 kernel/sched/core.c:7506
 report_rtnl_holders+0x1ba/0x2d0 net/core/rtnetlink.c:104
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 0e 94 61 f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> c3 10 ca f5 65 8b 05 b4 54 6b 74 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc9000407f600 EFLAGS: 00000206
RAX: 13958dc9d919f000 RBX: 1ffff9200080fec4 RCX: ffffffff816fd2da
RDX: dffffc0000000000 RSI: ffffffff8bcac820 RDI: 0000000000000001
RBP: ffffc9000407f690 R08: ffffffff92fe47ef R09: 1ffffffff25fc8fd
R10: dffffc0000000000 R11: fffffbfff25fc8fe R12: dffffc0000000000
R13: 1ffff9200080fec0 R14: ffffc9000407f620 R15: 0000000000000246
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 __wake_up_common_lock+0x18c/0x1e0 kernel/sched/wait.c:108
 __unix_dgram_recvmsg+0x5f4/0x12f0 net/unix/af_unix.c:2415
 sock_recvmsg_nosec+0x18e/0x1d0 net/socket.c:1046
 ____sys_recvmsg+0x3c0/0x470 net/socket.c:2814
 ___sys_recvmsg net/socket.c:2858 [inline]
 do_recvmmsg+0x474/0xae0 net/socket.c:2952
 __sys_recvmmsg net/socket.c:3031 [inline]
 __do_sys_recvmmsg net/socket.c:3054 [inline]
 __se_sys_recvmmsg net/socket.c:3047 [inline]
 __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3047
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdfbaf75d39
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fdfbbc7e048 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007fdfbb104070 RCX: 00007fdfbaf75d39
RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000003
RBP: 00007fdfbaff6766 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fdfbb104070 R15: 00007ffeafeb36a8
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90008800000, ffffc90008809000) created by:
 copy_process+0x5d1/0x3d90 kernel/fork.c:2206

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x295f2
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 1052, tgid 1052 (kworker/u8:5), ts 20453244600, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1500
 prep_new_page mm/page_alloc.c:1508 [inline]
 get_page_from_freelist+0x2ccb/0x2d80 mm/page_alloc.c:3487
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4745
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 vm_area_alloc_pages mm/vmalloc.c:3576 [inline]
 __vmalloc_area_node mm/vmalloc.c:3652 [inline]
 __vmalloc_node_range_noprof+0x971/0x1460 mm/vmalloc.c:3833
 alloc_thread_stack_node kernel/fork.c:313 [inline]
 dup_task_struct+0x444/0x8c0 kernel/fork.c:1114
 copy_process+0x5d1/0x3d90 kernel/fork.c:2206
 kernel_clone+0x226/0x8f0 kernel/fork.c:2788
 user_mode_thread+0x132/0x1a0 kernel/fork.c:2866
 call_usermodehelper_exec_work+0x5c/0x230 kernel/umh.c:172
 process_one_work kernel/workqueue.c:3224 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3305
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3383
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:144
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page_owner free stack trace missing

Memory state around the buggy address:
 ffffc90008807500: 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
 ffffc90008807580: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2
>ffffc90008807600: 00 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
                            ^
 ffffc90008807680: 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 00 f3 f3 f3
 ffffc90008807700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
----------------------------------------

----------------------------------------
[  560.831831][    C0] DEBUG: holding rtnl_mutex for 937 jiffies.
[  560.838015][    C0] task:kworker/u8:9    state:R  running task     stack:20216 pid:2460  tgid:2460  ppid:2      flags:0x00004000
[  560.849882][    C0] Workqueue: netns cleanup_net
[  560.854770][    C0] Call Trace:
[  560.854789][    C0]  <TASK>
[  560.872376][    C0]  __schedule+0x17e8/0x4a20
[  560.877336][    C0]  ? mark_lock+0x9a/0x360
[  560.881823][    C0]  ? lockdep_hardirqs_on_prepare+0x43d/0x780
[  560.887887][    C0]  ? __virt_addr_valid+0x183/0x520
[  560.893171][    C0]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[  560.899593][    C0]  ? lock_release+0xbf/0x9f0
[  560.904330][    C0]  ? __pfx___schedule+0x10/0x10
[  560.909271][    C0]  ? lockdep_hardirqs_on+0x99/0x150
[  560.914617][    C0]  ? mark_lock+0x9a/0x360
[  560.919119][    C0]  preempt_schedule_irq+0xfb/0x1c0
[  560.924392][    C0]  ? __pfx_preempt_schedule_irq+0x10/0x10
[  560.931783][    C0]  irqentry_exit+0x5e/0x90
[  560.936590][    C0]  asm_sysvec_reschedule_ipi+0x1a/0x20
[  560.942783][    C0] RIP: 0010:synchronize_rcu+0x0/0x360
[  560.948403][    C0] Code: e1 07 80 c1 03 38 c1 0f 8c 97 fe ff ff 4c 89 f7 e8 15 50 80 00 e9 8a fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 55 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48
[  560.968242][    C0] RSP: 76c0:0000000000000a06 EFLAGS: 1ffff92001100ed4
[  560.975129][    C0] ==================================================================
[  560.994479][    C0] BUG: KASAN: stack-out-of-bounds in __show_regs+0xa6/0x610
[  561.002642][    C0] Read of size 8 at addr ffffc90008807618 by task syz.0.1430/9588
[  561.014598][    C0] 
[  561.017321][    C0] CPU: 0 UID: 0 PID: 9588 Comm: syz.0.1430 Not tainted 6.10.0-rc5-next-20240624-syzkaller #0
[  561.028952][    C0] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
[  561.043847][    C0] Call Trace:
[  561.047213][    C0]  <IRQ>
[  561.050101][    C0]  dump_stack_lvl+0x241/0x360
[  561.054963][    C0]  ? __pfx_dump_stack_lvl+0x10/0x10
[  561.073046][    C0]  ? __pfx__printk+0x10/0x10
[  561.077786][    C0]  ? _printk+0xd5/0x120
[  561.082123][    C0]  print_report+0x169/0x550
[  561.086775][    C0]  ? __virt_addr_valid+0xbd/0x520
[  561.091947][    C0]  ? __show_regs+0xa6/0x610
[  561.096544][    C0]  kasan_report+0x143/0x180
[  561.101170][    C0]  ? show_opcodes+0x148/0x170
[  561.105909][    C0]  ? __show_regs+0xa6/0x610
[  561.110457][    C0]  __show_regs+0xa6/0x610
[  561.114858][    C0]  ? asm_sysvec_reschedule_ipi+0x1a/0x20
[  561.120539][    C0]  ? asm_sysvec_reschedule_ipi+0x1a/0x20
[  561.126227][    C0]  show_trace_log_lvl+0x3d4/0x520
[  561.131292][    C0]  ? __pfx_synchronize_rcu+0x10/0x10
[  561.136630][    C0]  sched_show_task+0x578/0x740
[  561.141466][    C0]  ? report_rtnl_holders+0x183/0x2d0
[  561.147055][    C0]  ? __pfx__printk+0x10/0x10
[  561.151699][    C0]  ? __pfx_sched_show_task+0x10/0x10
[  561.157153][    C0]  report_rtnl_holders+0x1ba/0x2d0
[  561.162519][    C0]  ? report_rtnl_holders+0x20/0x2d0
[  561.167755][    C0]  call_timer_fn+0x18e/0x650
[  561.172361][    C0]  ? call_timer_fn+0xc0/0x650
[  561.177086][    C0]  ? __pfx_report_rtnl_holders+0x10/0x10
[  561.182785][    C0]  ? __pfx_call_timer_fn+0x10/0x10
[  561.187939][    C0]  ? __pfx_report_rtnl_holders+0x10/0x10
[  561.193631][    C0]  ? __pfx_report_rtnl_holders+0x10/0x10
[  561.199303][    C0]  ? __pfx_report_rtnl_holders+0x10/0x10
[  561.204994][    C0]  ? _raw_spin_unlock_irq+0x23/0x50
[  561.210231][    C0]  ? lockdep_hardirqs_on+0x99/0x150
[  561.215469][    C0]  ? __pfx_report_rtnl_holders+0x10/0x10
[  561.221120][    C0]  __run_timer_base+0x66a/0x8e0
[  561.226093][    C0]  ? __pfx___run_timer_base+0x10/0x10
[  561.231493][    C0]  ? __pfx_lockdep_hardirqs_on_prepare+0x10/0x10
[  561.237874][    C0]  run_timer_softirq+0xb7/0x170
[  561.242832][    C0]  handle_softirqs+0x2c4/0x970
[  561.247626][    C0]  ? __irq_exit_rcu+0xf4/0x1c0
[  561.252429][    C0]  ? __pfx_handle_softirqs+0x10/0x10
[  561.257856][    C0]  ? irqtime_account_irq+0xd4/0x1e0
[  561.263090][    C0]  __irq_exit_rcu+0xf4/0x1c0
[  561.267711][    C0]  ? __pfx___irq_exit_rcu+0x10/0x10
[  561.272931][    C0]  irq_exit_rcu+0x9/0x30
[  561.277231][    C0]  sysvec_apic_timer_interrupt+0xa6/0xc0
[  561.283185][    C0]  </IRQ>
[  561.286769][    C0]  <TASK>
[  561.289972][    C0]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  561.297172][    C0] RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140
[  561.307112][    C0] Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 0e 94 61 f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> c3 10 ca f5 65 8b 05 b4 54 6b 74 85 c0 74 43 48 c7 04 24 0e 36
[  561.327228][    C0] RSP: 0018:ffffc9000407f600 EFLAGS: 00000206
[  561.333355][    C0] RAX: 13958dc9d919f000 RBX: 1ffff9200080fec4 RCX: ffffffff816fd2da
[  561.341352][    C0] RDX: dffffc0000000000 RSI: ffffffff8bcac820 RDI: 0000000000000001
[  561.349458][    C0] RBP: ffffc9000407f690 R08: ffffffff92fe47ef R09: 1ffffffff25fc8fd
[  561.357460][    C0] R10: dffffc0000000000 R11: fffffbfff25fc8fe R12: dffffc0000000000
[  561.365478][    C0] R13: 1ffff9200080fec0 R14: ffffc9000407f620 R15: 0000000000000246
[  561.373533][    C0]  ? mark_lock+0x9a/0x360
[  561.378221][    C0]  ? __pfx__raw_spin_unlock_irqrestore+0x10/0x10
[  561.385142][    C0]  ? autoremove_wake_function+0x37/0x110
[  561.391145][    C0]  __wake_up_common_lock+0x18c/0x1e0
[  561.396936][    C0]  __unix_dgram_recvmsg+0x5f4/0x12f0
[  561.403018][    C0]  ? __pfx___unix_dgram_recvmsg+0x10/0x10
[  561.409788][    C0]  ? __pfx___might_resched+0x10/0x10
[  561.415745][    C0]  ? iovec_from_user+0x61/0x240
[  561.421927][    C0]  ? unix_dgram_recvmsg+0xb6/0xe0
[  561.427965][    C0]  ? __pfx_unix_dgram_recvmsg+0x10/0x10
[  561.435584][    C0]  sock_recvmsg_nosec+0x18e/0x1d0
[  561.441322][    C0]  ____sys_recvmsg+0x3c0/0x470
[  561.446583][    C0]  ? __pfx_____sys_recvmsg+0x10/0x10
[  561.455788][    C0]  ? __might_fault+0xaa/0x120
[  561.460634][    C0]  do_recvmmsg+0x474/0xae0
[  561.465088][    C0]  ? __pfx___futex_wait+0x10/0x10
[  561.470148][    C0]  ? __pfx_do_recvmmsg+0x10/0x10
[  561.475130][    C0]  ? __pfx_futex_wake_mark+0x10/0x10
[  561.480509][    C0]  ? futex_wait+0x285/0x360
[  561.485124][    C0]  ? __pfx_futex_wait+0x10/0x10
[  561.490014][    C0]  ? fd_install+0x9c/0x5d0
[  561.494459][    C0]  ? __pfx_lock_release+0x10/0x10
[  561.499504][    C0]  ? __pfx_do_futex+0x10/0x10
[  561.504229][    C0]  __x64_sys_recvmmsg+0x199/0x250
[  561.510481][    C0]  ? __pfx___x64_sys_recvmmsg+0x10/0x10
[  561.517399][    C0]  ? do_syscall_64+0x100/0x230
[  561.522660][    C0]  ? do_syscall_64+0xb6/0x230
[  561.529823][    C0]  do_syscall_64+0xf3/0x230
[  561.534742][    C0]  ? clear_bhb_loop+0x35/0x90
[  561.540096][    C0]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  561.546133][    C0] RIP: 0033:0x7fdfbaf75d39
[  561.550744][    C0] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
[  561.571064][    C0] RSP: 002b:00007fdfbbc7e048 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
[  561.580376][    C0] RAX: ffffffffffffffda RBX: 00007fdfbb104070 RCX: 00007fdfbaf75d39
[  561.588397][    C0] RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000003
[  561.596400][    C0] RBP: 00007fdfbaff6766 R08: 0000000000000000 R09: 0000000000000000
[  561.604404][    C0] R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
[  561.612415][    C0] R13: 000000000000006e R14: 00007fdfbb104070 R15: 00007ffeafeb36a8
[  561.620458][    C0]  </TASK>
[  561.623517][    C0] 
[  561.625876][    C0] The buggy address belongs to the virtual mapping at
[  561.625876][    C0]  [ffffc90008800000, ffffc90008809000) created by:
[  561.625876][    C0]  copy_process+0x5d1/0x3d90
[  561.643549][    C0] 
[  561.645879][    C0] The buggy address belongs to the physical page:
[  561.652306][    C0] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x295f2
[  561.661135][    C0] flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
[  561.668346][    C0] raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
[  561.677050][    C0] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[  561.685659][    C0] page dumped because: kasan: bad access detected
[  561.692219][    C0] page_owner tracks the page as allocated
[  561.697979][    C0] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 1052, tgid 1052 (kworker/u8:5), ts 20453244600, free_ts 0
[  561.716523][    C0]  post_alloc_hook+0x1f3/0x230
[  561.721344][    C0]  get_page_from_freelist+0x2ccb/0x2d80
[  561.727009][    C0]  __alloc_pages_noprof+0x256/0x6c0
[  561.732233][    C0]  alloc_pages_mpol_noprof+0x3e8/0x680
[  561.737727][    C0]  __vmalloc_node_range_noprof+0x971/0x1460
[  561.743664][    C0]  dup_task_struct+0x444/0x8c0
[  561.748479][    C0]  copy_process+0x5d1/0x3d90
[  561.753128][    C0]  kernel_clone+0x226/0x8f0
[  561.757766][    C0]  user_mode_thread+0x132/0x1a0
[  561.762660][    C0]  call_usermodehelper_exec_work+0x5c/0x230
[  561.768674][    C0]  process_scheduled_works+0xa2c/0x1830
[  561.774240][    C0]  worker_thread+0x86d/0xd40
[  561.778849][    C0]  kthread+0x2f0/0x390
[  561.782979][    C0]  ret_from_fork+0x4b/0x80
[  561.787453][    C0]  ret_from_fork_asm+0x1a/0x30
[  561.792332][    C0] page_owner free stack trace missing
[  561.797698][    C0] 
[  561.800029][    C0] Memory state around the buggy address:
[  561.805664][    C0]  ffffc90008807500: 00 00 00 00 00 f3 f3 f3 f3 f3 f3 f3 00 00 00 00
[  561.813728][    C0]  ffffc90008807580: 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2
[  561.821814][    C0] >ffffc90008807600: 00 f3 f3 f3 00 00 00 00 00 00 00 00 00 00 00 00
[  561.829912][    C0]                             ^
[  561.834781][    C0]  ffffc90008807680: 00 00 00 00 f1 f1 f1 f1 00 f2 f2 f2 00 f3 f3 f3
[  561.842858][    C0]  ffffc90008807700: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  561.851024][    C0] ==================================================================
[  561.859206][    C0] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  561.866452][    C0] CPU: 0 UID: 0 PID: 9588 Comm: syz.0.1430 Not tainted 6.10.0-rc5-next-20240624-syzkaller #0
----------------------------------------

arch/x86/kernel/process_64.c:83 is

	printk("%sRAX: %016lx RBX: %016lx RCX: %016lx\n",
	       log_lvl, regs->ax, regs->bx, regs->cx);

(which looks nothing special), and kernel stack area [ffffc90008800000, ffffc90008809000) is
32768 bytes + 4096 bytes (which looks sane to me), and ffffc90008807618 is within the 32768
bytes (which looks sane to me).

Kernel config is https://syzkaller.appspot.com/text?tag=KernelConfig&x=6221d1071c39b052 .
Can somebody find what is wrong?


