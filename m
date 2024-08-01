Return-Path: <linux-kernel+bounces-271919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2FA9454F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7011D1F247AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7956E14D2BF;
	Thu,  1 Aug 2024 23:39:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F4B14D283
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722555566; cv=none; b=p9irYZp4o6nDdwd+qNiQ9jQOkWWMLhT+l5vScaw7HZ49+hR7kr9Cl4995u0sX84CiMZ1MBrOZH73eDL6cIMeqqMx8W/8uScofh5MYu8l8JKODaj7CTXgi9h19smKEMChMUJiqeC3IP5dkhlrkRf7FxpD5GwQGI+STp/0VteAy74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722555566; c=relaxed/simple;
	bh=ATaz9YbEXYwQvXrIkOvHR2Of3tfdzkZlrtj5C8grm10=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H04OjbRprXKLEt/KmEE3cMw15yzjtqb9/3zpqJdSQiYRK7IVUY1uy6KU+DoFpOXSUQuIe9jhB6jKHtraLBpQERvodoAqaLzz0jE1BCIe9MrO4mgdJgmODGwk5Qc84lRKV+t3kdsES1paSPW412V/ofx55B7w9sUcRvAOwbWYzuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3983ed13f0bso110423075ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 16:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722555564; x=1723160364;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsTIWpJR0+r62QX7gypMcATU+M6juxm2SQQS95KAVjs=;
        b=tNh5X/Eor1tNAC6PmLr1HtV5qBeEI/mSYAfYf5VZPm0rZj8oaU7vB67CZsApZqxisY
         ZjG/jQVDXp/RX6CtQhkP/kPxJ1zmJvhHvNNrCsrXCK7sOkgM6CrglKLtUOC7FgPMMFqN
         OPBpe5t10wkIzBIaA7AgCGls9FNJg8/x/1L2cVi3b9tRplh6DkjEcI4SaBwsmqODWGzm
         RNxTCPLfPTksmxcUdKo79d1x5xBbEaXCg3Ycwep/Nfoz6d+IiIH2+LmQ2h91En19iDbH
         EKVrDfPKW6peoGcvnobvnyaobo3FkDGF1ocoxUcHPbZiO8RnIASsW1XIz4DpmbtzaQRX
         MLxA==
X-Forwarded-Encrypted: i=1; AJvYcCWwUtZjhPvqphIMk7EELtKotcPLID7gycHpf19QrqJqRfFDa+TeieoDCq3XddjSd6lPJfQR6EJZ1h2MEFYeEcCpgmmWDK5S92OgC0rG
X-Gm-Message-State: AOJu0YximjdEgoiySy5dcWgACYBD6wNEqTc10Vrxoq082FP7tjQI7162
	xk0qsrFPwdpa19CmF1EkhuTmGib05N0KtYhDYKR84S4XChc3CYy9vv2X0OBzF6izFswj4TMVw08
	mcxMFIxjbrUsCoH+a69/h/uSezy29brb66+vxqaBMiO3ksBuDkldvlRo=
X-Google-Smtp-Source: AGHT+IG85Z5wCxz7RIy+BPNUG56W7Fpe7lgMIhIkBlExbfujENlid37gbYyXPMPPKKE9gqfIrEQpulvoLSh+ZzmuJkKNq7hKQHOd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:396:ec3b:df65 with SMTP id
 e9e14a558f8ab-39b1fc356damr1137845ab.4.1722555564014; Thu, 01 Aug 2024
 16:39:24 -0700 (PDT)
Date: Thu, 01 Aug 2024 16:39:23 -0700
In-Reply-To: <000000000000a8c856061ae85e20@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fca5d061ea7b850@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in __show_regs (2)
From: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>
To: andreyknvl@gmail.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	dvyukov@google.com, elver@google.com, glider@google.com, hpa@zytor.com, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mingo@redhat.com, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    931a3b3bccc9 Add linux-next specific files for 20240729
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10f2388d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91dc4a647da4c251
dashboard link: https://syzkaller.appspot.com/bug?extid=e9be5674af5e3a0b9ecc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16efaf11980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f437f1980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6b83209c369b/disk-931a3b3b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a5b0c2d893d4/vmlinux-931a3b3b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b3ee6d54a9b/bzImage-931a3b3b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com

RIP: 0010:minstrel_ht_fill_rate_array net/mac80211/rc80211_minstrel_ht.c:1883 [inline]
RIP: 0010:minstrel_ht_init_cck_rates net/mac80211/rc80211_minstrel_ht.c:1909 [inline]
RIP: 0010:minstrel_ht_alloc+0x299/0x860 net/mac80211/rc80211_minstrel_ht.c:1962
Code: 4c 24 08 45 31 ed 4c 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 f1 00 00 00 41 8b 6c 24 fc 21 dd 89 ef 89 de e8 17 f5 48 f6 <39> dd 75 4c 49 8d 7f 04 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: dc9b:0000000000000007 EFLAGS: 00000007 ORIG_RAX: ffffc90003606e70
==================================================================
BUG: KASAN: stack-out-of-bounds in __show_regs+0xc1/0x610 arch/x86/kernel/process_64.c:83
Read of size 8 at addr ffffc90003606ea0 by task swapper/0/0

CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc1-next-20240729-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __show_regs+0xc1/0x610 arch/x86/kernel/process_64.c:83
 show_trace_log_lvl+0x3d4/0x520 arch/x86/kernel/dumpstack.c:301
 sched_show_task+0x506/0x6d0 kernel/sched/core.c:7512
 report_rtnl_holders+0x327/0x400 net/core/rtnetlink.c:110
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
RIP: 0010:flush_smp_call_function_queue+0x23f/0x2a0 kernel/smp.c:592
Code: 00 4d 85 f6 75 16 e8 40 4f 0c 00 eb 15 e8 39 4f 0c 00 e8 c4 19 32 0a 4d 85 f6 74 ea e8 2a 4f 0c 00 fb 48 c7 04 24 0e 36 e0 45 <4b> c7 04 27 00 00 00 00 66 43 c7 44 27 09 00 00 43 c6 44 27 0b 00
RSP: 0018:ffffffff8e607cc0 EFLAGS: 00000293
RAX: ffffffff81877c36 RBX: 0000000000000000 RCX: ffffffff8e694680
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffffff8e607d70 R08: ffffffff81877c0c R09: 1ffffffff202faed
R10: dffffc0000000000 R11: fffffbfff202faee R12: 1ffffffff1cc0f98
R13: 0000000000000046 R14: 0000000000000200 R15: dffffc0000000000
 do_idle+0x565/0x5d0 kernel/sched/idle.c:353
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
 rest_init+0x2dc/0x300 init/main.c:747
 start_kernel+0x47a/0x500 init/main.c:1103
 x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
 x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
 common_startup_64+0x13e/0x147
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90003600000, ffffc90003609000) created by:
 copy_process+0x5d1/0x3d90 kernel/fork.c:2206

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7fbc5
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 5241, tgid 5241 (syz-executor243), ts 226123633416, free_ts 218311192673
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3442
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4700
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 vm_area_alloc_pages mm/vmalloc.c:3584 [inline]
 __vmalloc_area_node mm/vmalloc.c:3660 [inline]
 __vmalloc_node_range_noprof+0x971/0x1460 mm/vmalloc.c:3841
 alloc_thread_stack_node kernel/fork.c:314 [inline]
 dup_task_struct+0x444/0x8c0 kernel/fork.c:1115
 copy_process+0x5d1/0x3d90 kernel/fork.c:2206
 kernel_clone+0x226/0x8f0 kernel/fork.c:2788
 __do_sys_clone kernel/fork.c:2931 [inline]
 __se_sys_clone kernel/fork.c:2915 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2915
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5231 tgid 5231 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2612
 __folio_put+0x2c8/0x440 mm/swap.c:128
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:224 [inline]
 pipe_read+0x6f2/0x13e0 fs/pipe.c:344
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9bd/0xbc0 fs/read_write.c:476
 ksys_read+0x1a0/0x2c0 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc90003606d80: 00 f3 f3 f3 f3 f3 f3 f3 00 00 00 00 00 00 00 00
 ffffc90003606e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90003606e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                               ^
 ffffc90003606f00: f1 f1 f1 f1 00 00 00 00 00 00 00 00 f3 f3 f3 f3
 ffffc90003606f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess):
   0:	4c 24 08             	rex.WR and $0x8,%al
   3:	45 31 ed             	xor    %r13d,%r13d
   6:	4c 89 f8             	mov    %r15,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
  12:	84 c0                	test   %al,%al
  14:	0f 85 f1 00 00 00    	jne    0x10b
  1a:	41 8b 6c 24 fc       	mov    -0x4(%r12),%ebp
  1f:	21 dd                	and    %ebx,%ebp
  21:	89 ef                	mov    %ebp,%edi
  23:	89 de                	mov    %ebx,%esi
  25:	e8 17 f5 48 f6       	call   0xf648f541
* 2a:	39 dd                	cmp    %ebx,%ebp <-- trapping instruction
  2c:	75 4c                	jne    0x7a
  2e:	49 8d 7f 04          	lea    0x4(%r15),%rdi
  32:	48 89 f8             	mov    %rdi,%rax
  35:	48 c1 e8 03          	shr    $0x3,%rax
  39:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
  3e:	84 c0                	test   %al,%al


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

