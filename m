Return-Path: <linux-kernel+bounces-260856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72B93AF7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5B3283345
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C8815572D;
	Wed, 24 Jul 2024 09:59:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC10433B5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721815146; cv=none; b=QkeT3u4A1KIPiomA25yn2kaGSvlHu+OCArvPPrJne9mLoXkkiAhpdgFXVhbIYSEiYa9zhgFD58KFP2ec3iI3UpjzHfcB3EBq53XB5vF0dGYqZ5hisnwxRu9XZLRzPWMhE0hh0s0IHT19LH2zA7D4m9DGk/qJxS1QoieW6leHg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721815146; c=relaxed/simple;
	bh=+Ers5ANQLwYdS6V5nhGvndt57d55sPqVm8fjuZ0Bti0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u2B5nqo5+l8H6yX/0NKon/ys4vvNY4VYBgjEbXcMbuZpAseyFJyt4ZfFZmQCveYiT4Bwme++Lzwl+Ks40jwhenY5TZ6jQUqIhaT5lglgcmMqWJ8W3VH+VRN/jNLmfJZMmx/r5U8G0Z8ZKcfvdKIu1EuO6c42KBknA3oQ7rgs1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39a17513a7eso13783605ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721815144; x=1722419944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNS6nURqstw13CwY3XowIzCxemMtLyn1jZ1DIrtEuVo=;
        b=xOEkmX4hFmRLDsc03PF3ZLSWNLBQ0zKlqfPJYs+DJGi6ojEEKN7BqDba8u9SL27YcZ
         q7YnqDfrnyUF1tI6J9knxe9wrNAqZdU8iFzOz0XHfMw5vtXoUoAcoNRT6sjJoO26WW86
         8BpN7lOChrTzSFwJAV8IsdgjAaOW39CEqm80NSZGwcM3/HJKcDArcgGqi+a9+sFIY2AH
         T2mtSWVX75h/vkiXr+yvoAGXJCIALx3RI27df8uqOkgf1fDDeGHGfSyL3M8HJ1xrCz+5
         DAWfcGPVt+FwNom+D6I+vlf+IyBkFF3/nOE3TIWdxsW8ijh1Vsqx/MAhp7syQX2/lHnC
         smGA==
X-Forwarded-Encrypted: i=1; AJvYcCUMMTfkIrPZ0d6bUh3CUckxWk4k+K9ZUtP2+CmDdtTJfGlDkDO+K/5Q65mECIalQuiRB5Ydmgwez8PxXDCer266uk+kTFsPp+KlDKIw
X-Gm-Message-State: AOJu0YwtR7CV16V6t/5MJI57S1Off8UoPM8Yb6aRJPazaiQJwgVVaCHt
	U9F9Y0D8ASaGuRQzkpqBIIuX/5rZBJQDtF2uNFbg76gh0nOD3ONs/zaQuc4WWD5XcW2i6+16l9v
	fz2N22qVjbfH77ET7cvgr9VZ0ihST10Pa2SRMM2mUennMnkM1ZYstNb0=
X-Google-Smtp-Source: AGHT+IH625EuHzeQqgqjaFWrDgLn1pqjwGKR9iubXcRsJOZDvCMB8aKuD2efv3y7G/sZfhwdOQWv9aeT91i1n/VtOceSKJ9abl8T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1525:b0:381:24e:7a85 with SMTP id
 e9e14a558f8ab-39a1924c6c4mr1853215ab.1.1721815143425; Wed, 24 Jul 2024
 02:59:03 -0700 (PDT)
Date: Wed, 24 Jul 2024 02:59:03 -0700
In-Reply-To: <20240724093902.8331-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe3caa061dfb5359@google.com>
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
Read of size 4 at addr ffffc9000331fa50 by task syz.0.36/5802

CPU: 0 UID: 0 PID: 5802 Comm: syz.0.36 Not tainted 6.10.0-syzkaller-12246-g786c8248dbd3-dirty #0
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
 instr_sysvec_call_function arch/x86/kernel/smp.c:257 [inline]
 sysvec_call_function+0x95/0xb0 arch/x86/kernel/smp.c:257
 </IRQ>
 <TASK>
 asm_sysvec_call_function+0x1a/0x20 arch/x86/include/asm/idtentry.h:710
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x60 kernel/kcov.c:200
Code: be b0 01 00 00 e8 a0 ff ff ff 31 c0 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 65 48 8b 15 94 54 79 7e 65 8b 05 95 54 79 7e a9 00 01
RSP: 0018:ffffc9000331f3e8 EFLAGS: 00000283
RAX: dffffc0000000000 RBX: ffffc9000331f470 RCX: ffffffff813cf026
RDX: 1ffff92000663e90 RSI: ffffffff813cf082 RDI: ffffc9000331f480
RBP: ffffc9000331fcd0 R08: 0000000000000004 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90003318000
R13: ffffc90003320000 R14: 0000000000000001 R15: 0000000000000001
 on_stack arch/x86/include/asm/stacktrace.h:60 [inline]
 unwind_next_frame+0x11af/0x23a0 arch/x86/kernel/unwind_orc.c:665
 arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object+0xf7/0x160 mm/kasan/common.c:240
 __kasan_slab_free+0x32/0x50 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2252 [inline]
 slab_free mm/slub.c:4473 [inline]
 kmem_cache_free+0x12f/0x3a0 mm/slub.c:4548
 anon_vma_chain_free mm/rmap.c:147 [inline]
 unlink_anon_vmas+0x173/0x820 mm/rmap.c:421
 free_pgtables+0x33c/0x950 mm/memory.c:409
 exit_mmap+0x3c9/0xb20 mm/mmap.c:3393
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
RIP: 0033:0x7f0dd5175b59
Code: Unable to access opcode bytes at 0x7f0dd5175b2f.
RSP: 002b:00007f0dd5f6a0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f0dd5305f68 RCX: 00007f0dd5175b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f0dd5305f68
RBP: 00007f0dd5305f60 R08: 00007f0dd5f6a6c0 R09: 00007f0dd5f6a6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0dd5305f6c
R13: 000000000000000b R14: 00007ffd8748bdc0 R15: 00007ffd8748bea8
 </TASK>

The buggy address belongs to stack of task syz.0.36/5802
 and is located at offset 24 in frame:
 exit_mmap+0x0/0xb20 mm/mmap.c:3202

This frame has 2 objects:
 [32, 96) 'vmi'
 [128, 256) 'tlb'

The buggy address belongs to the virtual mapping at
 [ffffc90003318000, ffffc90003321000) created by:
 kernel_clone+0xfd/0x980 kernel/fork.c:2781

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888029ce3690 pfn:0x29ce3
memcg:ffff88801dd09c02
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: ffff888029ce3690 0000000000000000 00000001ffffffff ffff88801dd09c02
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x102dc2(GFP_HIGHUSER|__GFP_NOWARN|__GFP_ZERO), pid 5781, tgid 5781 (syz.0.26), ts 125931643135, free_ts 125907940889
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
 __do_sys_clone3+0x1f5/0x270 kernel/fork.c:3085
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5780 tgid 5779 stack trace:
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
 ffffc9000331f900: 00 00 00 f1 f1 f1 f1 f1 f1 00 00 00 00 00 00 00
 ffffc9000331f980: 00 00 f3 f3 f3 f3 f3 00 00 00 00 00 00 00 00 00
>ffffc9000331fa00: 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00
                                                 ^
 ffffc9000331fa80: 00 00 00 f2 f2 f2 f2 00 00 00 00 00 00 00 00 00
 ffffc9000331fb00: 00 00 00 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00
==================================================================
----------------
Code disassembly (best guess):
   0:	be b0 01 00 00       	mov    $0x1b0,%esi
   5:	e8 a0 ff ff ff       	call   0xffffffaa
   a:	31 c0                	xor    %eax,%eax
   c:	c3                   	ret
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  18:	00 00
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
* 2a:	f3 0f 1e fa          	endbr64 <-- trapping instruction
  2e:	65 48 8b 15 94 54 79 	mov    %gs:0x7e795494(%rip),%rdx        # 0x7e7954ca
  35:	7e
  36:	65 8b 05 95 54 79 7e 	mov    %gs:0x7e795495(%rip),%eax        # 0x7e7954d2
  3d:	a9                   	.byte 0xa9
  3e:	00 01                	add    %al,(%rcx)


Tested on:

commit:         786c8248 Merge tag 'perf-tools-fixes-for-v6.11-2024-07..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12e39145980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47beaba1a1054668
dashboard link: https://syzkaller.appspot.com/bug?extid=44623300f057a28baf1e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138553b5980000


