Return-Path: <linux-kernel+bounces-258883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77682938DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC471F21A16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275C316C863;
	Mon, 22 Jul 2024 10:52:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCE1B977
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645525; cv=none; b=hOxchvd+wPanw9B4mfXwURrqUO1z1SKwYfyClbU/PP/9A+wJNQ2MSQeS9FS3RuNptxXRL3pj3uLqa1fkCd/wPYqS3LhwgXG+A2MZMt2LtKOKffOO5Ak0ZInYNHdbEcbgS6F4QvPs45uCH9IcCp+SIVMTwqDg+jaXcTCYislgzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645525; c=relaxed/simple;
	bh=3eIODS4n4o1OzXwSAhPhdMuzc6xW2B0D4/pMNK9O3bA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lVIKGGMFmxUUN3rf/vfa7MFli+c5KekaVpb6wfpjvjWUomARMkUbwu3mT6x+ZBimRIr3ghCY7/mDcQNBGV0hHAX2K9h3KQJM3wv/gm08EH1HqVWHO/QBrS0TtiZuKDmMKGQCjoiHMt4iK8GOeSRPmAkjHGxSY5A5NtWMCyEFW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-806199616d0so679738039f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721645523; x=1722250323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wPG3q6xfFkpjCUfW1k4mAHW7o/gS9hixOBkoGtAhqf4=;
        b=NaaBuguBUormmlh+ys5xfStA8omEpwy8CRcRGcopvn46JNp4ApgMKgrzMwI9v7lfxb
         S4wR19+/KwFFLjny8E6CHmcR7YtaQ7DVOzRgjgHV1/y2Wcd8k3ZfeQ2wBIL0smE7w9VD
         SeB4q6teeeB6KvDOkPB0c0opJOeDGKJHBaPoj1Jz+xoydep1sSNY7SVNcDReNOtYavyx
         nwos7ncEkIDeIzfY381UWiNXhXJ8634TYwM8YPeusJoq5aO2bNeT5E3/DHu8VCqubvSS
         BO83MrCun+cS54wTx7JpYU4LvewSrJn0n8ApWbv9fU8otT+S4FpIUsT6/RWvQYfZE52m
         t0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCViLht3F9qMzLVcWYiOFff2cnPdzESc8hwq5hKhl/H+FZWto+MkUdHVlKXN3mt+aYL6lO2kkOx6Bm2mFHNzZX5IpjCgJUndmMpOokfb
X-Gm-Message-State: AOJu0YxL08Lz79FQdtX6vAxveG+Nnm2tmaIs5R1DjWCznhBV5E53MEhl
	n6Cgn4oqWU1Oa1khpPNvnUuGbx2onqdlJtKm4N9Jcz9gkVCP1w4dKSWFoGLWtQLvVvoYFDmOpSD
	/HfPGcrjRf3EyX5EWHgRU7UWHmBzgK1NLdQp5Jrkx9fXLpNxoSyCxh5I=
X-Google-Smtp-Source: AGHT+IEXtujOUktgB9phxO0jKozUjC7kXoLsLwnWPIBQDq+6B2zPmlsIb/CHC0SCSAcATBZJI2UxGqUZJvA9R5/ZcT1s1YTIynWh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:841f:b0:4c0:a8a5:81e9 with SMTP id
 8926c6da1cb9f-4c23fe63d83mr350413173.3.1721645523098; Mon, 22 Jul 2024
 03:52:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 03:52:03 -0700
In-Reply-To: <20240722103109.4668-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d57245061dd3d547@google.com>
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
BUG: KASAN: stack-out-of-bounds in xdp_do_check_flushed+0x355/0x3f0 net/core/filter.c:4298
Read of size 4 at addr ffffc90003387a50 by task syz.0.105/5938

CPU: 0 UID: 0 PID: 5938 Comm: syz.0.105 Not tainted 6.10.0-syzkaller-g933069701c1b-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 bpf_net_ctx_get_all_used_flush_lists include/linux/filter.h:837 [inline]
 xdp_do_check_flushed+0x355/0x3f0 net/core/filter.c:4298
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
RIP: 0010:__schedule+0xe3f/0x5490 kernel/sched/core.c:6399
Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 ba 3f 00 00 48 8b bd 10 ff ff ff 4d 89 77 10 4c 89 f6 e8 c9 a5 0f f6 48 89 c7 e8 61 54 6a f6 <48> 8b 8d a0 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 01 c1 48 c7
RSP: 0018:ffffc90003387980 EFLAGS: 00000206
RAX: 00000000000001a9 RBX: ffff888043a40000 RCX: 1ffffffff1fce089
RDX: 0000000000000000 RSI: ffffffff8b2cc580 RDI: ffffffff8b90c740
RBP: ffffc90003387b10 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe7489f R11: 0000000000000001 R12: ffff88806b03f908
R13: 0000000000000000 R14: ffff888043a40000 R15: ffff88806b03ee00
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:6708
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 class_preempt_destructor include/linux/preempt.h:480 [inline]
 class_preempt_destructor include/linux/preempt.h:480 [inline]
 try_to_wake_up+0xc08/0x13e0 kernel/sched/core.c:4022
 wake_up_process kernel/sched/core.c:4299 [inline]
 wake_up_q+0x91/0x140 kernel/sched/core.c:1029
 futex_wake+0x43e/0x4e0 kernel/futex/waitwake.c:199
 do_futex+0x1e5/0x350 kernel/futex/syscalls.c:107
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faaa0975b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007faaa16670f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007faaa0b05f68 RCX: 00007faaa0975b59
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007faaa0b05f6c
RBP: 00007faaa0b05f60 R08: 00007faaa1668080 R09: 00007faaa16676c0
R10: 0000000000000e80 R11: 0000000000000246 R12: 00007faaa0b05f6c
R13: 000000000000000b R14: 00007fff8e045980 R15: 00007fff8e045a68
 </TASK>

The buggy address belongs to stack of task syz.0.105/5938
 and is located at offset 40 in frame:
 __schedule+0x0/0x5490

This frame has 3 objects:
 [48, 52) 'cid'
 [64, 80) 'rf'
 [96, 120) 'ac'

The buggy address belongs to the virtual mapping at
 [ffffc90003380000, ffffc90003389000) created by:
 kernel_clone+0xfd/0x980 kernel/fork.c:2781

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801f49d0f0 pfn:0x1f49d
memcg:ffff88802787e902
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff88801f49d0f0 0000000000000000 00000001ffffffff ffff88802787e902
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 5663, tgid 5663 (syz-executor), ts 127270798487, free_ts 127240380476
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
page last free pid 5663 tgid 5663 stack trace:
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
 ffffc90003387900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90003387980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90003387a00: 00 00 00 00 00 f1 f1 f1 f1 f1 f1 04 f2 00 00 f2
                                                 ^
 ffffc90003387a80: f2 00 00 00 f3 f3 f3 f3 f3 00 00 00 00 00 00 00
 ffffc90003387b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess):
   0:	fa                   	cli
   1:	48 c1 ea 03          	shr    $0x3,%rdx
   5:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   9:	0f 85 ba 3f 00 00    	jne    0x3fc9
   f:	48 8b bd 10 ff ff ff 	mov    -0xf0(%rbp),%rdi
  16:	4d 89 77 10          	mov    %r14,0x10(%r15)
  1a:	4c 89 f6             	mov    %r14,%rsi
  1d:	e8 c9 a5 0f f6       	call   0xf60fa5eb
  22:	48 89 c7             	mov    %rax,%rdi
  25:	e8 61 54 6a f6       	call   0xf66a548b
* 2a:	48 8b 8d a0 fe ff ff 	mov    -0x160(%rbp),%rcx <-- trapping instruction
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df
  3b:	48 01 c1             	add    %rax,%rcx
  3e:	48                   	rex.W
  3f:	c7                   	.byte 0xc7


Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1162fe3d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c043ce4607a33671
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1214995e980000


