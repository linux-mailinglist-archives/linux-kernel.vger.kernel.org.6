Return-Path: <linux-kernel+bounces-259214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B89392B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08632B21B72
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A97516EB58;
	Mon, 22 Jul 2024 16:46:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFED216E89B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721666766; cv=none; b=RNv5pNz56Vtk08Nv9275KLoG2J4+yxqnpUNRqY0MaBBU4b4AoMWWv9t4eEvN5lX67HvTnZbXjRzs3gzyiLjgINTZ93JucSF0E53Ra5dagVxysSrlQ0eTAINddLGHg7+5HjZv7E1jU2sexvhFUKRO9rrrP1y486fzVYlISEzAAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721666766; c=relaxed/simple;
	bh=touT9+JVTcBY8uWgfeS51xiQ2FKdcQoKfsYYtN9ANng=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KP4CqsignxYccjhG2EbvWiSe2Dj7QgrhegoDauSxZE5wiNb3qKg68RHHybaTe67bEOMP/RAWk4gx7ahTlDct0T1H7WxroUfrWeYfSMcSUL/Jy2GIBSRzBj/jlYjTLqC7gZAjRZrKVpWa6fi+q7AyyILrJJmGEKHfuZxV42NDpuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3987dace329so46685175ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721666764; x=1722271564;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ee4pEJtOfUylxwimgN34Ud09dnojGP9rODX4I3bNuBc=;
        b=nn3bPnT9JCgu8vnBvycWoGI9dOAcUC7/tClzGhsWKg3mz6cfB02sYqVPECuXEYFji+
         jooIF4S3ku75duNTK/V4g9REDM+r+Rv7nMTfbtBH1EEAjtGRB9pDnrMSAEC9Yowpt8Fh
         6iBVuawItuR1F64ayBxpRW4KQGOSr/cou/+jlreVgM15SWTV1zLlNAKquzp1r//jEpMF
         n/+4v+XKRj+KD/eUAA3JluAez1Mpw42NRjsHbeTOVcbsLY7iEyCyi60JXaUjJUsV53aB
         GIsrACt2XKA1HJjYckH3l3v0BgqgGu60CtMid+jCgPzlGZWMXnYgoKePMMy0bIqlu4FA
         o9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzYehQj7mMnR3oskYMEz4Ag6yzpmYw8Bv5ZCk0aOkfVUcutISWOAgUNsLLub//6AeBTNKVg8A3y5b8DetyhDaLa3NOT+roKOzh9xxL
X-Gm-Message-State: AOJu0YwhF1DCWJYcprICXL4IhFHz5Ndizw1mxouFyvHVd74AXnPNBgsK
	51XcTWasV0AnbBtBl4euEttyFOD9Z2vycc0SRamyY24Stj53h39h99vDGgQ4XoSKrDQ54Iyrpi+
	sypTxB4zz7xB8kfxuCcz7l2H1o+mmn4vQRJzI+RYzxn4A/TcyO4qMaSs=
X-Google-Smtp-Source: AGHT+IGSHEno9cTAntG97SSwRtpT6V6atA9uleN5sqzZRr19LXNNWHZ7P3WnQIalHDq2zV9LLs+YWCB8O3dvEecV/K5yWHT6oM9w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c546:0:b0:381:a6b6:2dbd with SMTP id
 e9e14a558f8ab-39a0c96e0d4mr118125ab.4.1721666763848; Mon, 22 Jul 2024
 09:46:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:46:03 -0700
In-Reply-To: <20240722161240.4116-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e18bf9061dd8c79f@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
From: syzbot <syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in bq_xmit_all

==================================================================
BUG: KASAN: slab-out-of-bounds in bq_xmit_all+0x134/0x11d0 kernel/bpf/devmap.c:385
Read of size 8 at addr ffff88807a2f03a0 by task syz.0.305/6537

CPU: 0 UID: 0 PID: 6537 Comm: syz.0.305 Not tainted 6.10.0-syzkaller-11840-g933069701c1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 bq_xmit_all+0x134/0x11d0 kernel/bpf/devmap.c:385
 __dev_flush+0x81/0x160 kernel/bpf/devmap.c:425
 xdp_do_check_flushed+0x129/0x240 net/core/filter.c:4300
 __napi_poll+0xe4/0x490 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 common_interrupt+0xaa/0xd0 arch/x86/kernel/irq.c:278
 </IRQ>
 <TASK>
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:__sanitizer_cov_trace_switch+0x110/0x120 kernel/kcov.c:342
Code: 43 28 4c 39 f8 77 a3 49 ff c4 4c 89 21 4c 89 44 0b 08 4c 89 74 0b 10 48 89 7c 0b 18 4c 89 4c 0b 20 eb 87 5b 41 5c 41 5e 41 5f <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90002de6ec0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffff88801cb4da00
RDX: 0000000000000003 RSI: ffffffff8e1a32f0 RDI: 0000000000000002
RBP: ffffffff9033a231 R08: 0000000000000005 R09: ffffffff81411746
R10: 0000000000000003 R11: ffff88801cb4da00 R12: ffffffff9033a230
R13: dffffc0000000000 R14: ffffc90002de6ff0 R15: 1ffff920005bcdf4
 unwind_next_frame+0xff6/0x2a00 arch/x86/kernel/unwind_orc.c:581
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x75/0x3f0 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2656
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3395
 __mmput+0x115/0x390 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 get_signal+0x16a1/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faf1cf75bd9
Code: Unable to access opcode bytes at 0x7faf1cf75baf.
RSP: 002b:00007faf1dd780f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007faf1d103f68 RCX: 00007faf1cf75bd9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007faf1d103f68
RBP: 00007faf1d103f60 R08: 00007faf1dd786c0 R09: 00007faf1dd786c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007faf1d103f6c
R13: 000000000000000b R14: 00007fff7453a500 R15: 00007fff7453a5e8
 </TASK>

Allocated by task 5658:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4044
 vm_area_dup+0x27/0x290 kernel/fork.c:486
 dup_mmap kernel/fork.c:695 [inline]
 dup_mm kernel/fork.c:1672 [inline]
 copy_mm+0xc7b/0x1f30 kernel/fork.c:1721
 copy_process+0x187a/0x3dc0 kernel/fork.c:2374
 kernel_clone+0x226/0x8f0 kernel/fork.c:2781
 __do_sys_clone kernel/fork.c:2924 [inline]
 __se_sys_clone kernel/fork.c:2908 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2908
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88807a2f02e8
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 0 bytes to the right of
 allocated 184-byte region [ffff88807a2f02e8, ffff88807a2f03a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a2f0
memcg:ffff88802c3dca01
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff888015eefb40 ffffea0001e7a400 0000000000000009
raw: 0000000000000000 0000000000100010 00000001fdffffff ffff88802c3dca01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5933, tgid 5933 (dhcpcd-run-hook), ts 112186336296, free_ts 112182429345
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4696
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2321
 allocate_slab+0x5a/0x2f0 mm/slub.c:2484
 new_slab mm/slub.c:2537 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3723
 __slab_alloc+0x58/0xa0 mm/slub.c:3813
 __slab_alloc_node mm/slub.c:3866 [inline]
 slab_alloc_node mm/slub.c:4025 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4044
 vm_area_dup+0x27/0x290 kernel/fork.c:486
 dup_mmap kernel/fork.c:695 [inline]
 dup_mm kernel/fork.c:1672 [inline]
 copy_mm+0xc7b/0x1f30 kernel/fork.c:1721
 copy_process+0x187a/0x3dc0 kernel/fork.c:2374
 kernel_clone+0x226/0x8f0 kernel/fork.c:2781
 __do_sys_clone kernel/fork.c:2924 [inline]
 __se_sys_clone kernel/fork.c:2908 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2908
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5935 tgid 5935 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0x103a/0x1b00 mm/page_alloc.c:2656
 folios_put_refs+0x76e/0x860 mm/swap.c:1039
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:335
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3395
 __mmput+0x115/0x390 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 __do_sys_exit_group kernel/exit.c:1042 [inline]
 __se_sys_exit_group kernel/exit.c:1040 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1040
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807a2f0280: 00 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00
 ffff88807a2f0300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807a2f0380: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
                               ^
 ffff88807a2f0400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807a2f0480: 00 00 00 fc fc fc fc fc fc fc fc fa fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	43 28 4c 39 f8       	sub    %cl,-0x8(%r9,%r15,1)
   5:	77 a3                	ja     0xffffffaa
   7:	49 ff c4             	inc    %r12
   a:	4c 89 21             	mov    %r12,(%rcx)
   d:	4c 89 44 0b 08       	mov    %r8,0x8(%rbx,%rcx,1)
  12:	4c 89 74 0b 10       	mov    %r14,0x10(%rbx,%rcx,1)
  17:	48 89 7c 0b 18       	mov    %rdi,0x18(%rbx,%rcx,1)
  1c:	4c 89 4c 0b 20       	mov    %r9,0x20(%rbx,%rcx,1)
  21:	eb 87                	jmp    0xffffffaa
  23:	5b                   	pop    %rbx
  24:	41 5c                	pop    %r12
  26:	41 5e                	pop    %r14
  28:	41 5f                	pop    %r15
* 2a:	c3                   	ret <-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  36:	00 00 00
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f902b1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d04f9888ed34da73
dashboard link: https://syzkaller.appspot.com/bug?extid=61a1cfc2b6632363d319
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11da7f49980000


