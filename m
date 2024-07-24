Return-Path: <linux-kernel+bounces-260955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189CB93B0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCA4283DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D331581FD;
	Wed, 24 Jul 2024 12:20:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D4B1494C8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721823604; cv=none; b=rmq/BYd+2H2O4TsVf/5enzHXvfBApoBZSjAFJNnt8bPLxDWvnMcDUrqaQUkXUAQS9I2uYfDcVkEYXaO3Lg8ggZH5SU3GUw6hWXRfLXWsdRNSD1hY0nLf37GJyrYIrDbpHKta0OUcXzAKg68seFBfYpyF5hUDUIGWotsganFx8Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721823604; c=relaxed/simple;
	bh=W3fDYpYnRwwueJFd0hjJNaVAhl6GOqTmmkXxWVHUvu4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CBq3jB9tELj7PvAPXNg25sD8S7s3BbA4K7MQIBSi82nackNSRA4q0CAC/iUFzCedZGCcNnC2yWPZDOUKWMFCvuLgbva4Fx9jOqrepPc/jXWiM648tn6OWyjB2aTfbbCCz5nIPYfsmGc/C8BmGE78YLCJ97qdLYt78/leZcZsYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7fba8d323f9so1092689439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721823601; x=1722428401;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnJ0N7Pun2yupADJSSudpbBvHt45p0L4l3tilf/EaOI=;
        b=eR1XhfEuFO2x+CdLbYYF8OoHEOllWuuEyOriFxDTxwYDDnnLUtc0tQ4WOBPJktdLkJ
         l6hvPdnK5uGdfjJAIsBQ5GIQoWHDrgOAZqnqyKL1FRr5kfmcIAMwPE4XclNkl9kSys+e
         TJS0nz2bs9ZZKpvxVij2QNZ1fquAambA2EHk6qF9PcsdI3ivEBdWE2L2bNAtl7dTT9cx
         +I3AnVfbNkf5elbA64TdRioMqicAot3bLWUCj/GMeEhRgcMWYt8LHdn0ZxusjexcgZx8
         pMDybz32V0NUfe40kV5P4ui2EqDJ/WFJPmD5rSK31A9k5E62iJ2kgahmeLAXqpTpKfuJ
         AcOw==
X-Forwarded-Encrypted: i=1; AJvYcCWw+kH2JzcLOnfb+G9bSFqkTJOWVljdRYoyz3WJKC+10LBEPDqjRWNPLsMa8hJQmaqy8sYmDvdrCZxy9eXAXVq6WUMuEZKz0jO7sZAa
X-Gm-Message-State: AOJu0YxfjuF7wAh2/MmmmUA7hYjXS89uCyAU9MjhLqp1IuzO9A7knQrh
	0RFOHmSJiL8JxcftBloNfeHbZrbQkwbT5VOPcmGW18/p3uNEOOBvqIqG4Hhvf9BqzvM3YX5k1nU
	+l+wK3Sd2rnV9VKkIFz+Lgjla6B7sKyxTZuqC7O1xl7ITWOzEJUs3m34=
X-Google-Smtp-Source: AGHT+IHGBYx3M1RUIbwd/ifDFOdgWoyywUITBoUdHHdbAZayNMya8aIKG9kwiXMgOSLR22OJ6GONJ+ypAXiVNFAk/eHT37p6K7f9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8607:b0:4c0:9380:a262 with SMTP id
 8926c6da1cb9f-4c28a098594mr181328173.1.1721823601487; Wed, 24 Jul 2024
 05:20:01 -0700 (PDT)
Date: Wed, 24 Jul 2024 05:20:01 -0700
In-Reply-To: <20240724114325.8995-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000220733061dfd4c4f@google.com>
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
Read of size 4 at addr ffffc900032bfa50 by task syz.0.42/5811

CPU: 0 UID: 0 PID: 5811 Comm: syz.0.42 Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3-dirty #0
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
RIP: 0010:const_folio_flags.constprop.0+0x56/0x150 include/linux/page-flags.h:310
Code: 8b 6b 08 31 ff 83 e5 01 48 89 ee e8 84 cc ab ff 48 85 ed 0f 85 d4 00 00 00 e8 46 d1 ab ff 66 90 e8 3f d1 ab ff e8 3a d1 ab ff <48> 89 d8 5b 5d 41 5c c3 cc cc cc cc e8 29 d1 ab ff 48 89 dd 31 ff
RSP: 0018:ffffc900032bf6d0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffea00010118c0 RCX: ffffffff81deb54c
RDX: ffff8880274e8000 RSI: ffffffff81deb566 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000127
R13: ffff88802305c948 R14: ffffea00010118c0 R15: 0000000000000000
 folio_test_swapbacked include/linux/page-flags.h:534 [inline]
 folio_test_swapcache include/linux/page-flags.h:576 [inline]
 free_swap_cache mm/swap_state.c:291 [inline]
 free_pages_and_swap_cache+0x24e/0x510 mm/swap_state.c:325
 __tlb_batch_free_encoded_pages+0xf9/0x290 mm/mmu_gather.c:136
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu mm/mmu_gather.c:373 [inline]
 tlb_finish_mmu+0x168/0x7b0 mm/mmu_gather.c:465
 exit_mmap+0x3d1/0xb20 mm/mmap.c:3395
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
RIP: 0033:0x7f6f7c575b59
Code: Unable to access opcode bytes at 0x7f6f7c575b2f.
RSP: 002b:00007f6f7d27b0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f6f7c705f68 RCX: 00007f6f7c575b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f6f7c705f68
RBP: 00007f6f7c705f60 R08: 00007f6f7d27b6c0 R09: 00007f6f7d27b6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6f7c705f6c
R13: 000000000000000b R14: 00007ffd97f8d280 R15: 00007ffd97f8d368
 </TASK>

The buggy address belongs to stack of task syz.0.42/5811
 and is located at offset 24 in frame:
 exit_mmap+0x0/0xb20 mm/mmap.c:3202

This frame has 2 objects:
 [32, 96) 'vmi'
 [128, 256) 'tlb'

The buggy address belongs to the virtual mapping at
 [ffffc900032b8000, ffffc900032c1000) created by:
 kernel_clone+0xfd/0x980 kernel/fork.c:2781

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802b3e0000 pfn:0x2b3e0
memcg:ffff8880206d0182
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff88802b3e0000 0000000000000000 00000001ffffffff ffff8880206d0182
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 5653, tgid 5653 (syz-executor), ts 116595661744, free_ts 116458660012
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
page last free pid 5653 tgid 5653 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2608
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __kmalloc_cache_node_noprof+0x173/0x350 mm/slub.c:4197
 kmalloc_node_noprof include/linux/slab.h:704 [inline]
 __get_vm_area_node+0xe1/0x2d0 mm/vmalloc.c:3109
 __vmalloc_node_range_noprof+0x276/0x1520 mm/vmalloc.c:3801
 __vmalloc_node_noprof mm/vmalloc.c:3906 [inline]
 vzalloc_noprof+0x6b/0x90 mm/vmalloc.c:3979
 alloc_counters net/ipv4/netfilter/ip_tables.c:799 [inline]
 copy_entries_to_user net/ipv4/netfilter/ip_tables.c:821 [inline]
 get_entries net/ipv4/netfilter/ip_tables.c:1022 [inline]
 do_ipt_get_ctl+0x6b8/0xaa0 net/ipv4/netfilter/ip_tables.c:1668
 nf_getsockopt+0x79/0xe0 net/netfilter/nf_sockopt.c:116
 ip_getsockopt+0x18e/0x1e0 net/ipv4/ip_sockglue.c:1777
 tcp_getsockopt+0x9e/0x100 net/ipv4/tcp.c:4409
 do_sock_getsockopt+0x2e5/0x760 net/socket.c:2386
 __sys_getsockopt+0x1a1/0x270 net/socket.c:2415
 __do_sys_getsockopt net/socket.c:2425 [inline]
 __se_sys_getsockopt net/socket.c:2422 [inline]
 __x64_sys_getsockopt+0xbd/0x160 net/socket.c:2422
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83

Memory state around the buggy address:
 ffffc900032bf900: f3 f3 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc900032bf980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc900032bfa00: 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00
                                                 ^
 ffffc900032bfa80: 00 00 00 f2 f2 f2 f2 00 00 00 00 00 00 00 00 00
 ffffc900032bfb00: 00 00 00 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess):
   0:	8b 6b 08             	mov    0x8(%rbx),%ebp
   3:	31 ff                	xor    %edi,%edi
   5:	83 e5 01             	and    $0x1,%ebp
   8:	48 89 ee             	mov    %rbp,%rsi
   b:	e8 84 cc ab ff       	call   0xffabcc94
  10:	48 85 ed             	test   %rbp,%rbp
  13:	0f 85 d4 00 00 00    	jne    0xed
  19:	e8 46 d1 ab ff       	call   0xffabd164
  1e:	66 90                	xchg   %ax,%ax
  20:	e8 3f d1 ab ff       	call   0xffabd164
  25:	e8 3a d1 ab ff       	call   0xffabd164
* 2a:	48 89 d8             	mov    %rbx,%rax <-- trapping instruction
  2d:	5b                   	pop    %rbx
  2e:	5d                   	pop    %rbp
  2f:	41 5c                	pop    %r12
  31:	c3                   	ret
  32:	cc                   	int3
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	e8 29 d1 ab ff       	call   0xffabd164
  3b:	48 89 dd             	mov    %rbx,%rbp
  3e:	31 ff                	xor    %edi,%edi


Tested on:

commit:         786c8248 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1293bca1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47beaba1a1054668
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c0adad980000


