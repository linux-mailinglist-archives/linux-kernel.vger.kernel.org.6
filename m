Return-Path: <linux-kernel+bounces-258219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65C593851C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 17:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00299281357
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7A1662E7;
	Sun, 21 Jul 2024 15:18:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B99BE4A
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721575085; cv=none; b=UKHzxBeOrDj7R7fDjoYn0q77wMPVpee/LJ5F6OK4mulqX8lMhUC4s2j4J8BaraEdSwAAjyH7IhNillVBnOMaaok7c255hHIb3S86pFjXqUmrRnsIzqbgmoJZonijzjXMl0RFbHcbR/OBpcYxy4qEYL4wbLgU7C1qB0ts4cyGgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721575085; c=relaxed/simple;
	bh=osHA9DY6Gw6vvhghdRDx9Laisa0U/MVCcJiuKZ6nMW4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JBrmahMk8tzs2EnhrC7qCV0yQf3+6SOktQLi1fp9yRfpahct01PW2L6A6HFXjZ7YKKw1u2soEe30II8BC9l7alWAA7es3avIhOQE3ULFs5SZmrIGA2DNp85dU0jbk38FqNhlZRmG3Vaf/oOERKL7kNdCeacNBlBT6WCmzKXCO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8152f0c63c4so572498539f.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 08:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721575083; x=1722179883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlrqsBIeeb0ODKXqTbglUi+xxMoz06BaFbZ1TW+IoN0=;
        b=qeDe+GbV3ckP3e8vwm9lmB45M9UfZRK3c/POVqWk2wUmjdRZaDD+CZuHcMv3+pB90p
         l3g7B+bYvWQhgyJs9izvyKdphh1bdyc1cCor2BMUp6kAaUCDAc/KFm6AN6D558ob8beh
         feundGHFC089vdEprVNV0qdAGs1c0iCUMNGK7ouBORnBtnxl/PrL5UYTwNzWtBsWfEUK
         URL8KjdZLA1GU4sX5UzCpm9oFOL8YhILPOv5HAAUVTC0gVQT3Kpydggue4c78VpUeISQ
         RIv7zNFgDtU72hGL6m/B0g5VFiGhDSNgtz3dEXJ+0IYjv/BbNJS3Jw9nlkieev0NGBCh
         Yjqg==
X-Forwarded-Encrypted: i=1; AJvYcCVJz+n5vF0+BBxJW/jJUB5qNz92UFlR/uZLb1P9B69/LzLx3bh/tYALisATim+OsxnUiKIBvhI9fkqVWa30D9J48CtbwPGrf0rmDsW7
X-Gm-Message-State: AOJu0Yzo8XHLngOem8PIHwlNFtbglHvmb2eN3kCqKLYu8UeOZlFx+N8/
	K3TkaRb/zApy4ifejxyZ+nWIEtKhjTjn9h0Sstixv4Wl3ZMRMeA/0UXqxMPjSRm4Do2fiQ580Hg
	WP15rlLX42PLlNsC12/rNUyGcWWCFlh6cxaoJk8Ag+wKzv4KQfB4y478=
X-Google-Smtp-Source: AGHT+IGhMbEOLeh5G//TyxF3XFzX+ER7eECsU+PHwjo663AER5AkFVjojiTA8xMl8n7PtwSa1nxiCrPxivGIQ4xrmf+V7LqMky+B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:841f:b0:4b9:9c0a:6f6c with SMTP id
 8926c6da1cb9f-4c2406d50f9mr249914173.1.1721575083080; Sun, 21 Jul 2024
 08:18:03 -0700 (PDT)
Date: Sun, 21 Jul 2024 08:18:03 -0700
In-Reply-To: <20240721144408.268936-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000481300061dc36fd1@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in bq_flush_to_queue

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 6041 Comm: syz.0.49 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:bq_flush_to_queue+0x44/0x610 kernel/bpf/cpumap.c:675
Code: df e8 30 d9 d6 ff 49 8d 5e 50 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 d6 cd 39 00 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 1d 05 00 00 44 8b 65 00 4d 8d 6e 58 4c
RSP: 0018:ffffc90000007a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88802a8dc290 RCX: ffff88802e52bc00
RDX: 0000000000000101 RSI: 0000000000000000 RDI: ffff88802a8dc240
RBP: 0000000000000000 R08: ffffffff895fbd7a R09: 1ffffffff1f5d135
R10: dffffc0000000000 R11: fffffbfff1f5d136 R12: 0000000000000002
R13: ffffc900034ff7c0 R14: ffff88802a8dc240 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3025ffff CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __cpu_map_flush+0x5d/0xd0 kernel/bpf/cpumap.c:765
 xdp_do_check_flushed+0x136/0x240 net/core/filter.c:4304
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
RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:236 [inline]
RIP: 0010:__sanitizer_cov_trace_switch+0x9d/0x120 kernel/kcov.c:341
Code: 00 00 4d 85 d2 0f 84 8b 00 00 00 4c 8b 4c 24 20 65 4c 8b 1c 25 40 d5 03 00 31 d2 eb 08 48 ff c2 49 39 d2 74 71 4c 8b 74 d6 10 <65> 8b 05 64 8c 70 7e a9 00 01 ff 00 74 11 a9 00 01 00 00 74 de 41
RSP: 0018:ffffc900034ff280 EFLAGS: 00000202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88802e52bc00
RDX: 0000000000000006 RSI: ffffffff8e1a32a0 RDI: 0000000000000004
RBP: 0000000000000004 R08: 0000000000000005 R09: ffffffff81410f0e
R10: 0000000000000008 R11: ffff88802e52bc00 R12: ffffffff9027c0cc
R13: dffffc0000000000 R14: 0000000000000008 R15: 1ffff9200069fe70
 unwind_next_frame+0x7be/0x2a00 arch/x86/kernel/unwind_orc.c:515
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2235 [inline]
 slab_free mm/slub.c:4464 [inline]
 kmem_cache_free+0x145/0x350 mm/slub.c:4539
 vma_lock_free kernel/fork.c:455 [inline]
 __vm_area_free+0xe0/0x110 kernel/fork.c:511
 remove_vma mm/mmap.c:146 [inline]
 exit_mmap+0x645/0xc80 mm/mmap.c:3365
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
RIP: 0033:0x7ff317375b59
Code: Unable to access opcode bytes at 0x7ff317375b2f.
RSP: 002b:00007ff3180f50f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007ff317505f68 RCX: 00007ff317375b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007ff317505f68
RBP: 00007ff317505f60 R08: 00007ff3180f56c0 R09: 00007ff3180f56c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff317505f6c
R13: 000000000000000b R14: 00007ffc63823320 R15: 00007ffc63823408
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bq_flush_to_queue+0x44/0x610 kernel/bpf/cpumap.c:675
Code: df e8 30 d9 d6 ff 49 8d 5e 50 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 d6 cd 39 00 48 8b 2b 48 89 e8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 1d 05 00 00 44 8b 65 00 4d 8d 6e 58 4c
RSP: 0018:ffffc90000007a80 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88802a8dc290 RCX: ffff88802e52bc00
RDX: 0000000000000101 RSI: 0000000000000000 RDI: ffff88802a8dc240
RBP: 0000000000000000 R08: ffffffff895fbd7a R09: 1ffffffff1f5d135
R10: dffffc0000000000 R11: fffffbfff1f5d136 R12: 0000000000000002
R13: ffffc900034ff7c0 R14: ffff88802a8dc240 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3025ffff CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 30 d9 d6 ff       	call   0xffd6d935
   5:	49 8d 5e 50          	lea    0x50(%r14),%rbx
   9:	48 89 d8             	mov    %rbx,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
  15:	74 08                	je     0x1f
  17:	48 89 df             	mov    %rbx,%rdi
  1a:	e8 d6 cd 39 00       	call   0x39cdf5
  1f:	48 8b 2b             	mov    (%rbx),%rbp
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 1d 05 00 00    	jne    0x553
  36:	44 8b 65 00          	mov    0x0(%rbp),%r12d
  3a:	4d 8d 6e 58          	lea    0x58(%r14),%r13
  3e:	4c                   	rex.WR


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=128d0ae6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1346ca3d980000


