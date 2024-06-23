Return-Path: <linux-kernel+bounces-226098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8E3913A21
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07791F21C21
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7E613C9A3;
	Sun, 23 Jun 2024 11:38:23 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7913C8E8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719142703; cv=none; b=frF3DIzyV9afSoY2c9rPAuLMVkddwJ6fig/urSv0r2DGr4M/LqRQA/vDCn2vhkQ28GC9fEnuUd3r0c/exe70oSPLNVrmBtBppxIT7sO/IlcKShwlQvoGnDRUnauhX5Wb/HOv/2xZ5pY6LzoFzbzADohmypaL3d47rmSvEsF7iCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719142703; c=relaxed/simple;
	bh=b6JhR9MiEzkcIX0MIec0eiJRhJvB0Y/3y3oHapqr3b8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A7JIRCAkCQlsnWhu2fTPRh4sizHSRD8Vz7NxF81UcFXeboPi59o3rUYIl9jNEuhBD+GJywwdGoWIbdLhdWerb2gmBMPNRzelW4ER3gYB7sj7MEtN5mhi7O9Qcgt8MREaIi5tObXqRVgohHjoiZc2xcHVJgmdBzmb0G9B7egorIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7f397d76359so257671239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 04:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719142701; x=1719747501;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVxSIG43KcNLz34pznhPdganrMoBK9A31hUJxH9l4sY=;
        b=TuqFC6ijjSZVPz0TtOoh5iDMYl8ogm0AnjRtR/zGcz8qqmpypa1cEZEV2EVmUP7/L8
         589izwqfniBffFkh9e02MVgpmeWhRGLYWLNCHQLHbwkwFV5vZYc+cwkJcx1938s1BB4u
         5S6kzNIr18P/uAHQRQr60x/sh5YawwaMSTieJWLnKhbeGgDijPNTxrtvFL6BZ+Yxw1bc
         enaH727wHcvgG0bugN0rmtGIPb9UDr+SlXohIWYJNbrMPblGYzBNFflQByF+3gBY9+Vi
         oLi8+4Kc0ZKtJWwbu6Z03Op7N4dSkQbfoVJcRdPiJK3i4Sax9TSxBQ7nmAxJgW2Shmlt
         Wcvw==
X-Forwarded-Encrypted: i=1; AJvYcCWxC9NveiWXVVjKh2jVF+k/YcazwGxvDh3t/uQbPkuO/6l/dGUxqTC4HWNAHdFySgyE/yDu/Ja4cybQio7r6kNi+C06DdKFd5PFie5o
X-Gm-Message-State: AOJu0YyzoWapApb1B2oWt+RpZWCXo/EKaxcHVE22UFqkZsk77ZE/G2qO
	UN6waVRrDHvNPiNt0Exf5+g9w9RkaIHFhN1dn4tjgLyDBDOn9o/Fo2STfaGjXFBjK6xjGdrkoow
	TSTim+J38Ewnnhb5Xi0xM9VKhwdXeegABEF9sh054TCkK41ri5+IWqMo=
X-Google-Smtp-Source: AGHT+IFNb25exBl68C29CyLHOEK8eShrMIsIDUadBWn6cwC+g8PXiqSfG30C9qEV+cMMU7iaEtb3qK2c/uPanuO4aweo4GT4ovo9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411a:b0:4b9:def5:3dcb with SMTP id
 8926c6da1cb9f-4b9efb3acd8mr75604173.2.1719142700720; Sun, 23 Jun 2024
 04:38:20 -0700 (PDT)
Date: Sun, 23 Jun 2024 04:38:20 -0700
In-Reply-To: <000000000000a8c856061ae85e20@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000feb389061b8d19ae@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: stack-out-of-bounds Read in __show_regs (2)
From: syzbot <syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    f76698bd9a8c Add linux-next specific files for 20240621
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14293f0e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca79e3c3b9118bd0
dashboard link: https://syzkaller.appspot.com/bug?extid=e9be5674af5e3a0b9ecc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118dd151980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f204c5d02251/disk-f76698bd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50289c7e8999/vmlinux-f76698bd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c360e133a94f/bzImage-f76698bd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9be5674af5e3a0b9ecc@syzkaller.appspotmail.com

Code: 8b 3d 3c 28 4a 0c 48 89 de 5b e9 d3 de 5a 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 04 24 <65> 48 8b 0c 25 00 d6 03 00 65 8b 15 20 5b 70 7e f7 c2 00 01 ff 00
RSP: 0018:ffffc9000b8bf5b8 EFLAGS: 00000202
RAX: ffffffff81375c3f RBX: ffffffff81f9a77f RCX: ffff888025659e00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
==================================================================
BUG: KASAN: out-of-bounds in __show_regs+0x172/0x610 arch/x86/kernel/process_64.c:87
Read of size 8 at addr ffffc9000b8bf528 by task swapper/1/0

CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.10.0-rc4-next-20240621-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __show_regs+0x172/0x610 arch/x86/kernel/process_64.c:87
 show_trace_log_lvl+0x3d4/0x520 arch/x86/kernel/dumpstack.c:301
 sched_show_task+0x578/0x740 kernel/sched/core.c:7503
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
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:92 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:113
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 00 d6 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d d5 66 9c 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc900001a7d08 EFLAGS: 00000246
RAX: ffff8880176b0000 RBX: ffff88801b2db864 RCX: 00000000123988e9
RDX: 0000000000000001 RSI: ffff88801b2db800 RDI: ffff88801b2db864
RBP: 000000000003a6b8 R08: ffff8880b9537ccb R09: 1ffff110172a6f99
R10: dffffc0000000000 R11: ffffffff8b8d9ba0 R12: ffff88801a71e000
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8ead7e20
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x112/0x480 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:230 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:326
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
 start_secondary+0x100/0x100 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x147
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc9000b8b8000, ffffc9000b8c1000) created by:
 copy_process+0x5d1/0x3d90 kernel/fork.c:2206

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880678c2140 pfn:0x678c2
memcg:ffff88801a6b4002
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff8880678c2140 0000000000000000 00000001ffffffff ffff88801a6b4002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 6303, tgid 6303 (syz-executor.4), ts 1539185935031, free_ts 1529629150697
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
 __do_sys_clone3 kernel/fork.c:3089 [inline]
 __se_sys_clone3+0x2cb/0x350 kernel/fork.c:3073
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 6242 tgid 6242 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2651
 __slab_free+0x31b/0x3d0 mm/slub.c:4384
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3975 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x1a3/0x400 mm/slub.c:4171
 kmalloc_noprof include/linux/slab.h:664 [inline]
 kzalloc_noprof include/linux/slab.h:778 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x540 security/tomoyo/realpath.c:80
 tomoyo_path_perm+0x3ca/0x740 security/tomoyo/file.c:831
 tomoyo_path_symlink+0xde/0x120 security/tomoyo/tomoyo.c:212
 security_path_symlink+0xe3/0x140 security/security.c:1876
 do_symlinkat+0x136/0x3a0 fs/namei.c:4530
 __do_sys_symlink fs/namei.c:4553 [inline]
 __se_sys_symlink fs/namei.c:4551 [inline]
 __x64_sys_symlink+0x7a/0x90 fs/namei.c:4551
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc9000b8bf400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000b8bf480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000b8bf500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                     ^
 ffffc9000b8bf580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000b8bf600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess):
   0:	8b 3d 3c 28 4a 0c    	mov    0xc4a283c(%rip),%edi        # 0xc4a2842
   6:	48 89 de             	mov    %rbx,%rsi
   9:	5b                   	pop    %rbx
   a:	e9 d3 de 5a 00       	jmp    0x5adee2
   f:	0f 1f 00             	nopl   (%rax)
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	f3 0f 1e fa          	endbr64
  26:	48 8b 04 24          	mov    (%rsp),%rax
* 2a:	65 48 8b 0c 25 00 d6 	mov    %gs:0x3d600,%rcx <-- trapping instruction
  31:	03 00
  33:	65 8b 15 20 5b 70 7e 	mov    %gs:0x7e705b20(%rip),%edx        # 0x7e705b5a
  3a:	f7 c2 00 01 ff 00    	test   $0xff0100,%edx


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

