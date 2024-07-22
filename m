Return-Path: <linux-kernel+bounces-258932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FCA938EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F011C2123C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B97D16CD3F;
	Mon, 22 Jul 2024 12:01:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD816130D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649665; cv=none; b=aIB3KrN/cXWvc3+opboYjUThIltXpXr7f9K6+2+z8D70bnY9tB+RIbkAyy1Q5hXmwhp9yu7iLxNbMhu8XGyXQZ9r+Ca81t8enm/IwwDpHbdyns1xoAlR4ud90/gs3J81Tlh79AeNfHQ9tDJdy5CiRXOkrXRaVaRdjmEin8N7krw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649665; c=relaxed/simple;
	bh=3jkS8R5TVNxpBJLEAsN282SaOuvnMO7k/ZX8tL+SDlc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VYWtizQ7WHbSkm5OIi3+rYth91BmDuzO8Zwvw5NZCtT88tgOtjzjBvLZvByBnXMnrKCdqylM0eUtcAxDx2zrs7voT4nlNy0kvQqyxyUJNK+cOe86IsxwEgWBxIsh92WPo2kUHo68qlUWTOstA6tFvLuRmGG2mCeTnzrCPcrPhxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3983ed13f0bso45233025ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 05:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721649663; x=1722254463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuS+qzZJsFaEeaOBD1ooEZV4nkEBEX6UozbS25HR/h8=;
        b=xMegg/kZGVzTYX2KTERzU9Ui3QYvT9oPCUJf1DR9+XlPJAKeID4ploruy+X9ERC06e
         ngfFdLDVeRmkGjALnGIBX+mE+I+5xuFagKVgnVK4Cyzr/Sy0wyiIyLnFTW2TMb4aHuEJ
         9hChDDImHC7LL+hjoPs7X0xQPt6bzt9irA8pwxtK6H1nzQ+kRhEHX5zAInPVaeaLBYG9
         m/q4P2PNnQ+8Qy0lLDjX0Wow85fWYp6Q+JG90lJbYqgML+i+Ps6x1zYW74EWv/iaQH+k
         V611mdlq6oGYl9UdsK+2jpGKlwhohuMwtFaHijf2S9Qt8MtoV7/rcdBIAQDI3GzROUHi
         TsXA==
X-Forwarded-Encrypted: i=1; AJvYcCVYlb9Iiwai6pJ8mVVPdzjvXamEAh6lBdgPk4lUrThNkpXar078id+pA+W5HaZqbcvFx4g7nOVKs6e1C6fKVQlgHWc7mhCW1fvTtDeP
X-Gm-Message-State: AOJu0Yy7wPrKRTfnqMBR9MP81CGYnevHEBz/yv+vtufFuJ9RMgRlY2Ri
	ZIuGmMekC9MLNtQSeUtqQvVEhxzic17NwSoyubNc0zyglRLOXe5/Vrb4rxON2hsMbaRp9qe7u0m
	WOFrq/rjBVOyfC0OzMQ0ZldDlQlCvPIY7tpu17UxuqOxIC/y4CjS4Q2E=
X-Google-Smtp-Source: AGHT+IGRlgjtJMRkzxkKUClv8N6J+Hi8EAs4LiuNvZtQpF2O7Jsv+oijixCdw9zR5UhhC3ZmfEtNtkezWCOa6nw+L8p21Yt1vxc7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:385:ffe:4516 with SMTP id
 e9e14a558f8ab-398e4db86a7mr4396995ab.2.1721649662850; Mon, 22 Jul 2024
 05:01:02 -0700 (PDT)
Date: Mon, 22 Jul 2024 05:01:02 -0700
In-Reply-To: <20240722114035.5337-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000950db2061dd4ccd9@google.com>
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
Read of size 4 at addr ffffc9000336fa50 by task syz.0.70/5863

CPU: 1 PID: 5863 Comm: syz.0.70 Not tainted 6.10.0-syzkaller-11323-g7846b618e0a4-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
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
Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 ba 3f 00 00 48 8b bd 10 ff ff ff 4d 89 77 10 4c 89 f6 e8 b9 6e 0f f6 48 89 c7 e8 71 e8 69 f6 <48> 8b 8d a0 fe ff ff 48 b8 00 00 00 00 00 fc ff df 48 01 c1 48 c7
RSP: 0018:ffffc9000336f980 EFLAGS: 00000206
RAX: 000000000000018b RBX: ffff8880256b0000 RCX: 1ffffffff1fce461
RDX: 0000000000000000 RSI: ffffffff8b2cbac0 RDI: ffffffff8b909e40
RBP: ffffc9000336fb10 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe7675f R11: 0000000000000001 R12: ffff88806b13f788
R13: 0000000000000000 R14: ffff8880256b0000 R15: ffff88806b13ec80
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
RIP: 0033:0x7fc830f75b59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc831d8e0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fc831105f68 RCX: 00007fc830f75b59
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fc831105f6c
RBP: 00007fc831105f60 R08: 00007fc831d8f080 R09: 00007fc831d8e6c0
R10: 0000000000000e80 R11: 0000000000000246 R12: 00007fc831105f6c
R13: 000000000000000b R14: 00007ffea9d2b330 R15: 00007ffea9d2b418
 </TASK>

The buggy address belongs to stack of task syz.0.70/5863
 and is located at offset 40 in frame:
 __schedule+0x0/0x5490

This frame has 3 objects:
 [48, 52) 'cid'
 [64, 80) 'rf'
 [96, 120) 'ac'

The buggy address belongs to the virtual mapping at
 [ffffc90003368000, ffffc90003371000) created by:
 kernel_clone+0xfd/0x980 kernel/fork.c:2780

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802b714360 pfn:0x2b714
memcg:ffff888021296f02
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff88802b714360 0000000000000000 00000001ffffffff ffff888021296f02
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 5862, tgid 5862 (syz.0.70), ts 130256428069, free_ts 129532353425
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d1/0x350 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x1353/0x2e50 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4683
 alloc_pages_mpol_noprof+0x275/0x610 mm/mempolicy.c:2265
 vm_area_alloc_pages mm/vmalloc.c:3583 [inline]
 __vmalloc_area_node mm/vmalloc.c:3659 [inline]
 __vmalloc_node_range_noprof+0xa6a/0x1520 mm/vmalloc.c:3840
 alloc_thread_stack_node kernel/fork.c:311 [inline]
 dup_task_struct kernel/fork.c:1111 [inline]
 copy_process+0x2f3b/0x8de0 kernel/fork.c:2203
 kernel_clone+0xfd/0x980 kernel/fork.c:2780
 __do_sys_clone3+0x1f5/0x270 kernel/fork.c:3084
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5829 tgid 5828 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_page+0x64a/0xe40 mm/page_alloc.c:2588
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:468
 exit_mmap+0x3d1/0xb20 mm/mmap.c:3354
 __mmput+0x12a/0x480 kernel/fork.c:1343
 mmput+0x62/0x70 kernel/fork.c:1365
 exit_mm kernel/exit.c:566 [inline]
 do_exit+0x9bf/0x2bb0 kernel/exit.c:864
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1026
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffffc9000336f900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc9000336f980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc9000336fa00: 00 00 00 00 00 f1 f1 f1 f1 f1 f1 04 f2 00 00 f2
                                                 ^
 ffffc9000336fa80: f2 00 00 00 f3 f3 f3 f3 f3 00 00 00 00 00 00 00
 ffffc9000336fb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
  1d:	e8 b9 6e 0f f6       	call   0xf60f6edb
  22:	48 89 c7             	mov    %rax,%rdi
  25:	e8 71 e8 69 f6       	call   0xf669e89b
* 2a:	48 8b 8d a0 fe ff ff 	mov    -0x160(%rbp),%rcx <-- trapping instruction
  31:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  38:	fc ff df
  3b:	48 01 c1             	add    %rax,%rcx
  3e:	48                   	rex.W
  3f:	c7                   	.byte 0xc7


Tested on:

commit:         7846b618 Merge tag 'rtc-6.11' of git://git.kernel.org/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11d729b5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4129de17851dbe
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148939c3980000


