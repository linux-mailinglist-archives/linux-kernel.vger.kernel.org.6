Return-Path: <linux-kernel+bounces-258153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1D938472
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FAFB20BF6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 11:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E417E792;
	Sun, 21 Jul 2024 11:22:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F096441D
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721560926; cv=none; b=A9FlEunraBNve4lb+TAdCSI8VT6pi0v2DZd61SZUomR//ABFUEeCFXdWdz1rDSKu16xbMJVFA2jtEiZFISpMapSe1gvLk7kHKUVS6vINKEbpY4g4RDIWoCub/PS+S8uxwHMnJ7TfL5Eck8OmrHBpiE3cJYvQuzftkQPiLc8M1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721560926; c=relaxed/simple;
	bh=NLBQ1iJn9so5gHJhKMMcm8Eoav8/mRr7NXycGRUB8EM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ChZRz4n4SleILeTpz8Jbohl5gwAFKJZyfXm3eYgL8cv/Xpy+YSAaR+ain69ABL1u6HGX9uvv6scpala1W5KgOBk+/MlzGFdyxM3RYoyQt8jmfY5buVJN/LwAExlxNfSzUAJPoQ/4VYGS9O16iTEN0iesck+85PJnho5rfpksHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39915b8e08dso25028645ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 04:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560923; x=1722165723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOdmrcfKA2orZwJliSWITrbQnFCyyZ+XPabYMHKVhW4=;
        b=xRoWBEfC5PztcBmh+DL8ECgupDmUKOaYfV0sG7B7HJ4yTAc2LDk2hEFhfd35yXwFQ2
         WrfZ7XUznDcKK+UdbjUzJ37w4psamkh3XdwOhITbc/yRbTzB7PqiK9mCVzLOOlU33q9x
         zIFx4IxOIL7CjxrDwrM307juSOgVj8lYiQ2rtHEscfEilimwTMs/T/TFtDo20KjwiWRj
         nz4sbgPYjT9WGwWD5cBAyeXStuJp4p+9PuZiHe+K4J6P8zh/TyBnWJJSa1Wmgqm4daSM
         FxZ3EWmHFe5xocPB/WSXWHSqZrhbAsVwqHeEscZiARxUibzrDYGnLoL6/3I1Pb1peMPf
         wvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVetFkBwzYymrsQPD3VGT9XW1v8XID0gNoNqQiHVqjO7kocs7hIRmMrhrp2fAcqqbxHHYehOI5AZ4eted6a+WVIdJKoyFKYIMPaPyHU
X-Gm-Message-State: AOJu0YylDB/E8/HNH+M2pIkDln1mxWMJLWndt1AKf2PS2Ho/tZxSGbAL
	RzbnEkNTDcAb5kdctj2q8fweGArcRBAPZ9Uz0Ygo751Uqdb/xft8lzL4XdjXJJAMf9NgCv3Odmn
	mBOqQZPeTrJqehSl5jdyBUOukUwOadHqFjhTsrgykFZESHTl97icsO2U=
X-Google-Smtp-Source: AGHT+IEpM6gC4+tiIUywesaAhc8UIW7c3zaAW8iE4RR6p953Et2A4rjBDFU1Ui4VqPzZolYe482/qJ3eTomkQiDadjI18Uvn81jA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:398:8121:5de with SMTP id
 e9e14a558f8ab-398e7de7ac0mr3351735ab.4.1721560923527; Sun, 21 Jul 2024
 04:22:03 -0700 (PDT)
Date: Sun, 21 Jul 2024 04:22:03 -0700
In-Reply-To: <20240721104511.234568-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e6ed7061dc023a8@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in bq_xmit_all

==================================================================
BUG: KASAN: slab-use-after-free in bq_xmit_all+0x134/0x11d0 kernel/bpf/devmap.c:385
Read of size 8 at addr ffff88802e0fa748 by task syz.0.32/5981

CPU: 1 PID: 5981 Comm: syz.0.32 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
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
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:propagate_protected_usage+0x42/0x210 mm/page_counter.c:22
Code: fc ff df e8 d0 ab 95 ff 49 8d 9c 24 a0 00 00 00 49 89 de 49 c1 ee 03 41 80 3c 2e 00 74 08 48 89 df e8 d2 a1 f8 ff 48 83 3b 00 <74> 78 48 89 1c 24 49 8d bc 24 80 00 00 00 48 89 f8 48 c1 e8 03 80
RSP: 0018:ffffc90003c87160 EFLAGS: 00000246
RAX: ffffffff81fd96f0 RBX: ffff8880162dc1e0 RCX: ffff8880271e3c00
RDX: 0000000000000000 RSI: 000000000000014a RDI: ffff8880162dc140
RBP: dffffc0000000000 R08: ffffffff81fd9639 R09: 1ffff11002c5b828
R10: dffffc0000000000 R11: ffffed1002c5b829 R12: ffff8880162dc140
R13: ffffc90003c872e0 R14: 1ffff11002c5b83c R15: 000000000000014a
 page_counter_uncharge+0x2e/0x70 mm/page_counter.c:158
 uncharge_batch+0xde/0x4f0 mm/memcontrol.c:7637
 __mem_cgroup_uncharge_folios+0x14a/0x1c0 mm/memcontrol.c:7739
 mem_cgroup_uncharge_folios include/linux/memcontrol.h:721 [inline]
 folios_put_refs+0x932/0xa60 mm/swap.c:1023
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3354
 __mmput+0x115/0x380 kernel/fork.c:1343
 exit_mm+0x220/0x310 kernel/exit.c:566
 do_exit+0x9b2/0x27f0 kernel/exit.c:864
 do_group_exit+0x207/0x2c0 kernel/exit.c:1026
 get_signal+0x16a1/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc403375b59
Code: Unable to access opcode bytes at 0x7fc403375b2f.
RSP: 002b:00007fc4041330f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fc403505f68 RCX: 00007fc403375b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fc403505f68
RBP: 00007fc403505f60 R08: 00007fc4041336c0 R09: 00007fc4041336c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc403505f6c
R13: 000000000000000b R14: 00007ffd23f516c0 R15: 00007ffd23f517a8
 </TASK>

Allocated by task 5977:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3979 [inline]
 slab_alloc_node mm/slub.c:4028 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4035
 vm_area_dup+0x27/0x290 kernel/fork.c:484
 __split_vma+0x1a9/0xc30 mm/mmap.c:2394
 split_vma mm/mmap.c:2466 [inline]
 vma_modify+0x194/0x350 mm/mmap.c:2500
 vma_modify_flags include/linux/mm.h:3352 [inline]
 mprotect_fixup+0x3ea/0xa90 mm/mprotect.c:637
 do_mprotect_pkey+0x908/0xe00 mm/mprotect.c:820
 __do_sys_mprotect mm/mprotect.c:841 [inline]
 __se_sys_mprotect mm/mprotect.c:838 [inline]
 __x64_sys_mprotect+0x80/0x90 mm/mprotect.c:838
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5977:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2235 [inline]
 slab_free mm/slub.c:4464 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4539
 remove_vma mm/mmap.c:146 [inline]
 exit_mmap+0x645/0xc80 mm/mmap.c:3365
 __mmput+0x115/0x380 kernel/fork.c:1343
 exit_mm+0x220/0x310 kernel/exit.c:566
 do_exit+0x9b2/0x27f0 kernel/exit.c:864
 do_group_exit+0x207/0x2c0 kernel/exit.c:1026
 __do_sys_exit_group kernel/exit.c:1037 [inline]
 __se_sys_exit_group kernel/exit.c:1035 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1035
 x64_sys_call+0x26c3/0x26d0 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802e0fa6c8
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 128 bytes inside of
 freed 184-byte region [ffff88802e0fa6c8, ffff88802e0fa780)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2e0fa
memcg:ffff88806981bc01
anon flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffefff(slab)
raw: 00fff00000000000 ffff888015eefb40 ffffea00008fcf00 dead000000000005
raw: 0000000000000000 0000000000100010 00000001ffffefff ffff88806981bc01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5298, tgid 5298 (rm), ts 85421049674, free_ts 85420936799
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1473
 prep_new_page mm/page_alloc.c:1481 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3425
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2304
 allocate_slab+0x5a/0x2f0 mm/slub.c:2467
 new_slab mm/slub.c:2520 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3706
 __slab_alloc+0x58/0xa0 mm/slub.c:3796
 __slab_alloc_node mm/slub.c:3849 [inline]
 slab_alloc_node mm/slub.c:4016 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x2a0 mm/slub.c:4035
 vm_area_dup+0x27/0x290 kernel/fork.c:484
 __split_vma+0x1a9/0xc30 mm/mmap.c:2394
 do_vmi_align_munmap+0x388/0x18c0 mm/mmap.c:2592
 do_vmi_munmap+0x261/0x2f0 mm/mmap.c:2759
 __vm_munmap+0x1fc/0x400 mm/mmap.c:3038
 elf_map fs/binfmt_elf.c:383 [inline]
 elf_load+0x2d8/0x6f0 fs/binfmt_elf.c:408
 load_elf_binary+0x1027/0x2680 fs/binfmt_elf.c:1167
 search_binary_handler fs/exec.c:1821 [inline]
 exec_binprm fs/exec.c:1863 [inline]
 bprm_execve+0xaf8/0x1770 fs/exec.c:1914
page last free pid 5298 tgid 5298 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_folios+0xf12/0x19c0 mm/page_alloc.c:2637
 folios_put_refs+0x93a/0xa60 mm/swap.c:1024
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 shift_arg_pages fs/exec.c:781 [inline]
 setup_arg_pages+0xd2d/0x1000 fs/exec.c:880
 load_elf_binary+0xb80/0x2680 fs/binfmt_elf.c:1014
 search_binary_handler fs/exec.c:1821 [inline]
 exec_binprm fs/exec.c:1863 [inline]
 bprm_execve+0xaf8/0x1770 fs/exec.c:1914
 do_execveat_common+0x55f/0x6f0 fs/exec.c:2021
 do_execve fs/exec.c:2095 [inline]
 __do_sys_execve fs/exec.c:2171 [inline]
 __se_sys_execve fs/exec.c:2166 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2166
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802e0fa600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802e0fa680: fb fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb
>ffff88802e0fa700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88802e0fa780: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
 ffff88802e0fa800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	df e8                	fucomip %st(0),%st
   2:	d0 ab 95 ff 49 8d    	shrb   -0x72b6006b(%rbx)
   8:	9c                   	pushf
   9:	24 a0                	and    $0xa0,%al
   b:	00 00                	add    %al,(%rax)
   d:	00 49 89             	add    %cl,-0x77(%rcx)
  10:	de 49 c1             	fimuls -0x3f(%rcx)
  13:	ee                   	out    %al,(%dx)
  14:	03 41 80             	add    -0x80(%rcx),%eax
  17:	3c 2e                	cmp    $0x2e,%al
  19:	00 74 08 48          	add    %dh,0x48(%rax,%rcx,1)
  1d:	89 df                	mov    %ebx,%edi
  1f:	e8 d2 a1 f8 ff       	call   0xfff8a1f6
  24:	48 83 3b 00          	cmpq   $0x0,(%rbx)
* 28:	74 78                	je     0xa2 <-- trapping instruction
  2a:	48 89 1c 24          	mov    %rbx,(%rsp)
  2e:	49 8d bc 24 80 00 00 	lea    0x80(%r12),%rdi
  35:	00
  36:	48 89 f8             	mov    %rdi,%rax
  39:	48 c1 e8 03          	shr    $0x3,%rax
  3d:	80                   	.byte 0x80


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155234ad980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=122040b1980000


