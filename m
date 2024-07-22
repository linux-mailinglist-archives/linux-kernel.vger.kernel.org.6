Return-Path: <linux-kernel+bounces-258891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCCB938DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4012F1C213DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFAC16CD06;
	Mon, 22 Jul 2024 11:11:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634B16B399
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646666; cv=none; b=fVAlt3fADz/HYa51UOcgDlZOL9ZlAFtjZhR+XAmc0YCmbV9KzlXnT5HatZeqvxQZHIjx5lpuMb1vMDkN8Jx6TB2zexNmNhxIzGfsjwQVjZiee1HbIRbDQgwWjoV+mooiGlMXl6RPfotIowaTaUSy0S29QXdHB/OcvnZ61PXQTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646666; c=relaxed/simple;
	bh=cxIc4m96cevkAiwx0PSBIgGgJHn749EMuGJl/x42R1M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=piqETSBo3X08bUrc1kEihsiPiNJyaZzA+I0zbaWEUbG5zCS4B48YW5iXTB1JbbzHuDsVWyzAxtW3dm115o8cuezZXGcpXigULwpNJhFmEMbb0f3Qaif+EI8madiHNbcvZ3OkN06D34nyo9Vornp7uOUBKpvI3dlba3nNWSkiNI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81d1b92b559so157369139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 04:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721646664; x=1722251464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/E3wVpUhltLYYbbq1wtOkkKnWAdmthyoW3u0NeacOQ=;
        b=losCJX/2rVEeToPXru4caQGlpb7Qm6fq0xR3aQWjtc4qHCbEZhAKFiDHdD38W6SOdV
         DtS05x92UlAO+FyDJlhIkEyUu2h1W97a/fKyVvyoeZZjXn/XSt+/ClFuK1sDG+E+B7ke
         gBg1AlcVanG1m+RcTO/l8Sjk71RGepBfkmfUB0jpfBlJ/5Gh6zTp8i6dk/1jkOpewzjH
         2CYkr438Co0Vg4vAJoZyM3oHHULGsXqzVhSl1Fxe5kG0TArsfEBilo1DD8QoUABPSocE
         MWQ6WzZu3PIVn2UYWsFCbGy5Mvb8qxo4bc9VtMhUQ2YPS2KDKb1QpvDQlkPNhbgZez5T
         u1wg==
X-Forwarded-Encrypted: i=1; AJvYcCXm9VXR2zdNtaaMBNQPTogfG2KHt1CFM6WaBl1FFnwLi7C0+EdpXnfFQXWqCmWqnJ0TaVDtA4O3HxHwsh46MfNzJFUucUBOSmk8wBxt
X-Gm-Message-State: AOJu0Yz/8uvOlWctaQ0PLOcj6tv7Uuv10jBHqn8t+SmRtsveOydgIVnM
	Cm4d9qhoV1KpXZrZofiXnQfT7UExvFDI7CaPaSFwLK6tOXYkxFrDlDy3K4wJscDOQdayvZTGd2R
	wk1tvXmmbx1GUR5RYrhXqLQoeCzqrzMsKfrhsNc9Z3a79XpSbB/5L684=
X-Google-Smtp-Source: AGHT+IECR8Hv8QPrRR4vyNbE54cJBko0HyIKWAADwCmc/bYB8EITkJ+rzT/0tzy7Am8/DDg1VkNdyCLvxdDEMfMhKVLGrNq93ppq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2187:b0:4bb:624c:5a7f with SMTP id
 8926c6da1cb9f-4c23fcbd7b6mr338149173.1.1721646663954; Mon, 22 Jul 2024
 04:11:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 04:11:03 -0700
In-Reply-To: <20240722103139.4718-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d588a4061dd41951@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: stack-out-of-bounds Read in xdp_do_check_flushed

==================================================================
BUG: KASAN: stack-out-of-bounds in bpf_net_ctx_get_all_used_flush_lists include/linux/filter.h:837 [inline]
BUG: KASAN: stack-out-of-bounds in xdp_do_check_flushed+0x41c/0x4e0 net/core/filter.c:4298
Read of size 4 at addr ffffc9000167fa50 by task syz.0.111/5959

CPU: 1 UID: 0 PID: 5959 Comm: syz.0.111 Not tainted 6.10.0-syzkaller-g933069701c1b #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 bpf_net_ctx_get_all_used_flush_lists include/linux/filter.h:837 [inline]
 xdp_do_check_flushed+0x41c/0x4e0 net/core/filter.c:4298
 __napi_poll.constprop.0+0xd1/0x550 net/core/dev.c:6774
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0xa92/0x1010 net/core/dev.c:6962
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:write_comp_data+0x0/0x90 kernel/kcov.c:230
Code: 48 8b 05 e3 5c 79 7e 48 8b 80 10 16 00 00 c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <49> 89 d2 49 89 f8 49 89 f1 65 48 8b 15 af 5c 79 7e 65 8b 05 b0 5c
RSP: 0018:ffffc9000167f618 EFLAGS: 00000246
RAX: 0000000000000003 RBX: ffffea0000d86e40 RCX: ffffffff81d6e231
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000005
RBP: ffffea0000d86e40 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: 0000000000000000 R15: ffffc9000167fab8
 __folio_rmap_sanity_checks+0x61/0x550 include/linux/rmap.h:201
 __folio_remove_rmap mm/rmap.c:1514 [inline]
 folio_remove_rmap_ptes+0x31/0x3d0 mm/rmap.c:1595
 zap_present_folio_ptes mm/memory.c:1517 [inline]
 zap_present_ptes mm/memory.c:1576 [inline]
 zap_pte_range mm/memory.c:1618 [inline]
 zap_pmd_range mm/memory.c:1736 [inline]
 zap_pud_range mm/memory.c:1765 [inline]
 zap_p4d_range mm/memory.c:1786 [inline]
 unmap_page_range+0x1997/0x3c10 mm/memory.c:1807
 unmap_single_vma+0x194/0x2b0 mm/memory.c:1853
 unmap_vmas+0x22f/0x490 mm/memory.c:1897
 exit_mmap+0x1b8/0xb20 mm/mmap.c:3382
 __mmput+0x12a/0x480 kernel/fork.c:1345
 mmput+0x62/0x70 kernel/fork.c:1367
 exit_mm kernel/exit.c:571 [inline]
 do_exit+0x9bf/0x2bb0 kernel/exit.c:869
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fd/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f66e7375b59
Code: Unable to access opcode bytes at 0x7f66e7375b2f.
RSP: 002b:00007f66e809c0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f66e7505f68 RCX: 00007f66e7375b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f66e7505f68
RBP: 00007f66e7505f60 R08: 00007f66e809c6c0 R09: 00007f66e809c6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f66e7505f6c
R13: 000000000000000b R14: 00007ffd814e49e0 R15: 00007ffd814e4ac8
 </TASK>

The buggy address belongs to stack of task syz.0.111/5959
 and is located at offset 24 in frame:
 exit_mmap+0x0/0xb20 mm/mmap.c:3202

This frame has 2 objects:
 [32, 96) 'vmi'
 [128, 256) 'tlb'

The buggy address belongs to the virtual mapping at
 [ffffc90001678000, ffffc90001681000) created by:
 kernel_clone+0xfd/0x980 kernel/fork.c:2781

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801ec13150 pfn:0x1ec13
memcg:ffff8880261f3b82
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff88801ec13150 0000000000000000 00000001ffffffff ffff8880261f3b82
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 5636, tgid 5636 (syz-executor), ts 121181133330, free_ts 121100052787
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x1351/0x2e50 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4696
 alloc_pages_mpol_noprof+0x275/0x610 mm/mempolicy.c:2263
 vm_area_alloc_pages mm/vmalloc.c:3584 [inline]
 __vmalloc_area_node mm/vmalloc.c:3660 [inline]
 __vmalloc_node_range_noprof+0xa6a/0x1520 mm/vmalloc.c:3841
 alloc_thread_stack_node kernel/fork.c:313 [inline]
 dup_task_struct kernel/fork.c:1113 [inline]
 copy_process+0x2f3b/0x8de0 kernel/fork.c:2204
 kernel_clone+0xfd/0x980 kernel/fork.c:2781
 __do_sys_clone+0xba/0x100 kernel/fork.c:2924
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 0 tgid 0 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2608
 __folio_put+0x31c/0x3e0 mm/swap.c:128
 folio_put include/linux/mm.h:1479 [inline]
 free_page_and_swap_cache+0x249/0x2c0 mm/swap_state.c:308
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x89/0xe0 mm/mmu_gather.c:282
 rcu_do_batch kernel/rcu/tree.c:2569 [inline]
 rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2843
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702

Memory state around the buggy address:
 ffffc9000167f900: 00 f2 f2 f2 00 f2 f2 f2 00 00 f2 f2 00 00 00 00
 ffffc9000167f980: 00 f3 f3 f3 f3 f3 00 00 00 00 00 00 00 00 00 00
>ffffc9000167fa00: 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00
                                                 ^
 ffffc9000167fa80: 00 00 00 f2 f2 f2 f2 00 00 00 00 00 00 00 00 00
 ffffc9000167fb00: 00 00 00 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess):
   0:	48 8b 05 e3 5c 79 7e 	mov    0x7e795ce3(%rip),%rax        # 0x7e795cea
   7:	48 8b 80 10 16 00 00 	mov    0x1610(%rax),%rax
   e:	c3                   	ret
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	cc                   	int3
  13:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	90                   	nop
  27:	90                   	nop
  28:	90                   	nop
  29:	90                   	nop
* 2a:	49 89 d2             	mov    %rdx,%r10 <-- trapping instruction
  2d:	49 89 f8             	mov    %rdi,%r8
  30:	49 89 f1             	mov    %rsi,%r9
  33:	65 48 8b 15 af 5c 79 	mov    %gs:0x7e795caf(%rip),%rdx        # 0x7e795cea
  3a:	7e
  3b:	65                   	gs
  3c:	8b                   	.byte 0x8b
  3d:	05                   	.byte 0x5
  3e:	b0 5c                	mov    $0x5c,%al


Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17687d79980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c043ce4607a33671
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

