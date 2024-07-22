Return-Path: <linux-kernel+bounces-259062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 927029390B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E46F0B2167E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A64125D6;
	Mon, 22 Jul 2024 14:32:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0ED515
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658727; cv=none; b=FC97MzFyDqThGRgd3gAtKUbXxsbb6D9MUX4yDc46XvRyPJX//Ng9b7eoEHzMt+fucO13fqTMMTsVlQ0FIInOhHkb5XoVQdtgMYLv01iBwiMckLSSk1aiYumMTdnPjt1I2ygbF3vz1cs4qCkLMGx/q4AsXBuikn56SuoZVvQ/IxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658727; c=relaxed/simple;
	bh=X3FmQCmoKBtXXMxk5yzmuIY/ZYYVOD4j6RT1mVsFO9I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EoIKlgTDwDepvjcaEwuKal/1RM4W0WpoPqbCM153d7/msR3yfNg4xLHWNpHDfrwgQPYbyHyq0JPZexuKvJcfpxRpmKu89AOhpZSWlvODnsUgUQD2SSrw8/9Tw1S3oKBIG5HQO8s8yb/XtnYCdN7FTzv9mYJSWLzfzbcDYxJESIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3988d01a236so47566695ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721658724; x=1722263524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyjkwRLPn5DlZytUE8p5/g3bKJSaKxdZvTaHZYLXS9I=;
        b=iI2HJdLK4haK2pNQgdsTGObRh+7c049hsA+YFS3/WAnFQO+uKprcX2MVEDKCqjVghG
         ULKWrcoDIhLHGNo9O135oJTQFFphwPjb0hEPWn0fChp3MfJqpp5/FlY2HnXmUixOGMXq
         i0yYW3vMlfqnbMSNPag157gqVGKIUy58EaQYVPIWeyDrpLBWkIxFf+TPAFR9tY1ifrPK
         hmP+QJraBqLrI1YCCqghRZveKKgnMmAW+cV5AnupxpgAVPkgTe2yHXhaetu2t004aCNN
         i75xQB6lXFrQFQWoovO5wNyo6/9Y+z57uPSZfl1fMIaJtu30bNo2bQVWyiXmTo74dNoI
         6dHw==
X-Forwarded-Encrypted: i=1; AJvYcCW+aozXpvCPVDamiu+ZY/fLwVfghAyJjxqg6yMO1usgUt9pQKPNo8NtkCjTX5kyLxSIQhEoVNzDLmTziO+ByCnfMI6d1Okq2hXg++oc
X-Gm-Message-State: AOJu0YwalAxeENQ/qckKPyb8U6zXaCMy40Ius3Tef9FROtV8fiV35/Km
	BrPQScMqRZinTx3K3r6u7xDNxqJc18YBZSkgnRhxtvB4vhyu0/D5xgZBpZoLbn/GzsDVfZ87A+4
	3Z5pFpIDGRXvXY3iaE7L8FnPnVrrOlyL5yacQ1STqjJSfypS/Nc+KMlA=
X-Google-Smtp-Source: AGHT+IFZYYEJUFIlqOvS4ip5Tc42MOR1Vkj0gm5QZsLO5DgEdZds7n9i6LGVtOrWUK9hzCp5PD/+/p3+bo5dDwah/cDA5QVvcwfv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c6:b0:398:b1d3:7c9d with SMTP id
 e9e14a558f8ab-398e6f78362mr8054235ab.3.1721658724508; Mon, 22 Jul 2024
 07:32:04 -0700 (PDT)
Date: Mon, 22 Jul 2024 07:32:04 -0700
In-Reply-To: <20240722125338.6315-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b30c4e061dd6e8c8@google.com>
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
Read of size 8 at addr ffff88807a1c2d50 by task syz.0.283/6567

CPU: 0 UID: 0 PID: 6567 Comm: syz.0.283 Not tainted 6.10.0-syzkaller-11840-g933069701c1b #0
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
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__sanitizer_cov_trace_pc+0x5d/0x70 kernel/kcov.c:225
Code: f8 15 00 00 83 fa 02 75 21 48 8b 91 00 16 00 00 48 8b 32 48 8d 7e 01 8b 89 fc 15 00 00 48 39 cf 73 08 48 89 3a 48 89 44 f2 08 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90
RSP: 0018:ffffc90003ddf398 EFLAGS: 00000293
RAX: ffffffff81d0022b RBX: dffffc0000000000 RCX: ffff888026fe8000
RDX: 0000000000000000 RSI: 000000000000000f RDI: 000000000000001f
RBP: ffffc90003ddf4b0 R08: ffffffff81d001ee R09: 1ffffd40003c2f6e
R10: dffffc0000000000 R11: fffff940003c2f6f R12: ffffc90003ddf5a0
R13: ffffea0001e17b80 R14: ffffc90003ddf520 R15: 000000000000000f
 folios_put_refs+0x19b/0x860 mm/swap.c:994
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:332
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
RIP: 0033:0x7f1635175bd9
Code: Unable to access opcode bytes at 0x7f1635175baf.
RSP: 002b:00007f1635e770f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f1635303f68 RCX: 00007f1635175bd9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f1635303f68
RBP: 00007f1635303f60 R08: 00007f1635e776c0 R09: 00007f1635e776c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1635303f6c
R13: 000000000000000b R14: 00007ffeb68d9450 R15: 00007ffeb68d9538
 </TASK>

Allocated by task 5754:
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

The buggy address belongs to the object at ffff88807a1c2c98
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 0 bytes to the right of
 allocated 184-byte region [ffff88807a1c2c98, ffff88807a1c2d50)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a1c2
memcg:ffff8880227b2101
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xfdffffff(slab)
raw: 00fff00000000000 ffff888015eefb40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001fdffffff ffff8880227b2101
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x152cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5972, tgid 5972 (dhcpcd-run-hook), ts 122017798005, free_ts 121858197708
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
page last free pid 5966 tgid 5966 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2608
 discard_slab mm/slub.c:2583 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3051
 put_cpu_partial+0x17c/0x250 mm/slub.c:3126
 __slab_free+0x2ea/0x3d0 mm/slub.c:4343
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3988 [inline]
 slab_alloc_node mm/slub.c:4037 [inline]
 __do_kmalloc_node mm/slub.c:4157 [inline]
 __kmalloc_noprof+0x1a6/0x400 mm/slub.c:4170
 kmalloc_noprof include/linux/slab.h:685 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
 security_inode_getattr+0xd8/0x130 security/security.c:2269
 vfs_getattr+0x45/0x430 fs/stat.c:204
 vfs_fstat fs/stat.c:229 [inline]
 vfs_fstatat+0xe4/0x190 fs/stat.c:338
 __do_sys_newfstatat fs/stat.c:505 [inline]
 __se_sys_newfstatat fs/stat.c:499 [inline]
 __x64_sys_newfstatat+0x11d/0x1a0 fs/stat.c:499
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807a1c2c00: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
 ffff88807a1c2c80: fc fc fc 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807a1c2d00: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
                                                 ^
 ffff88807a1c2d80: fc fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807a1c2e00: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	f8                   	clc
   1:	15 00 00 83 fa       	adc    $0xfa830000,%eax
   6:	02 75 21             	add    0x21(%rbp),%dh
   9:	48 8b 91 00 16 00 00 	mov    0x1600(%rcx),%rdx
  10:	48 8b 32             	mov    (%rdx),%rsi
  13:	48 8d 7e 01          	lea    0x1(%rsi),%rdi
  17:	8b 89 fc 15 00 00    	mov    0x15fc(%rcx),%ecx
  1d:	48 39 cf             	cmp    %rcx,%rdi
  20:	73 08                	jae    0x2a
  22:	48 89 3a             	mov    %rdi,(%rdx)
  25:	48 89 44 f2 08       	mov    %rax,0x8(%rdx,%rsi,8)
* 2a:	c3                   	ret <-- trapping instruction
  2b:	cc                   	int3
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
  36:	00 00 00
  39:	0f 1f 40 00          	nopl   0x0(%rax)
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=130810c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d04f9888ed34da73
dashboard link: https://syzkaller.appspot.com/bug?extid=61a1cfc2b6632363d319
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

