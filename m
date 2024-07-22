Return-Path: <linux-kernel+bounces-259180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C893923C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7204CB21766
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7950F16E884;
	Mon, 22 Jul 2024 16:04:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504028F70
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721664245; cv=none; b=TXAumF5U2zVlrBzkjO7OtoIpgqU4m5qMvzUByi5uhI3AvRtX3mqJBK0FAZjJihh1+izrzhTzI7wZ4JA8SMV75S6GRp9Y2qQh2Gifr+FGtIEHVJi1MGfkmTt89LTUuu8P5bmLhYkhZG34nOB3ejLmEcq/fusiHPsRw6/Q3ysL24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721664245; c=relaxed/simple;
	bh=dBvPbttBsydsmsUrFqNyQecJ2458QwJasAGRdSTdpj8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BQ7JwWRHfpoJIHJLqyh057FNgDA6Y/ggjII1MVx3ujCNFv8lsC+FXjSTzkIavlH119q3+PisU3zDYagvB8i7y0EvkJJbPhKlInePiK2sEjaCimJ9Q/PP/wflDD8+z8qbDBuW7SEIoHN0NlzUGgDaM7hvpmGifrw2wC4E1tsn5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3982257ab28so54118345ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721664243; x=1722269043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNKOWdqSlBzyB2+x9QyGUdTXeGl0m0k6SJ2xE2/eohc=;
        b=aQW/KjJZgsyxl5rGaK9t/YavLgVJYssc5GH1lbsEd5OfOeyHECvx6mtzS0L0M8yWmO
         Exi4vXihcdtGBv7J+PqXp6RiYsT9Uteyc2p4EefUTO5ffRsRgK99RMW+X9M8enELG5Iw
         ijLjfQahLOTWiJvwHG1h0YDPCu14YNypoZc5wtsn8cFc5fh0inn6pl0zX9m8GaZ8SIwu
         OgoS/jWr1dbo4bUE14DOrFjV1QjYOcrgMly14rh36TKuo+XieBhLRvwSQJgCYYf63+EB
         GHR70YVvda+n8U9TxaVj/rTjbcK3i+ehW0Xa7LLmeJuDTyFDNwoa8PLArDtgZ4rYynFy
         3U+A==
X-Forwarded-Encrypted: i=1; AJvYcCVoYC2+sbpYY1H6tlQ0SvGbf4m7tK7+GO3+d7csbqLUeIFUUND4xBRB8u3u1Jhvb6l0NGn4WfRlZ8S+Kxt19XIi0H3lDjZoSuxA5Las
X-Gm-Message-State: AOJu0YyX13C48cZjy3daO3iYFjVZFs9LNeJTQXHhiVAiCaJnhm4uf/ZB
	MChO9pBkTjwarDZKScTHQmllff1hxwgexU2ZwjWS0NP7GZ66TTuFF67dLZ7cf2ihrY7G4ctIX94
	aJY0x2ItaQmkWaBOu3qrTUnBtJ4qu8mKUUvu2Sf6mVuzGFk3Yo/wScCQ=
X-Google-Smtp-Source: AGHT+IGoo2GsGYrIAnv1oNtBkXEW3SctPJPzMGLpUx6iE1rRGhzuGQb9ARAxohFshhdkFFXwgIS+EHqheKcW6zjvxLLqa9ywq9M1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ea:b0:397:fa4e:3df0 with SMTP id
 e9e14a558f8ab-398e7821024mr4045515ab.3.1721664243486; Mon, 22 Jul 2024
 09:04:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:04:03 -0700
In-Reply-To: <20240722145736.3603-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7e919061dd83111@google.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
From: syzbot <syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: unable to handle kernel paging request in bpf_net_ctx_get_all_used_flush_lists

BUG: unable to handle page fault for address: ffffe63017937f02
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1503a067 P4D 1503a067 PUD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 6602 Comm: syz.0.303 Not tainted 6.10.0-syzkaller-11840-g933069701c1b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:bpf_net_ctx_get_all_used_flush_lists+0x16b/0x390 include/linux/filter.h:846
Code: e6 08 31 ff e8 f6 c8 29 f8 4c 89 f8 48 83 e0 08 75 07 e8 08 c4 29 f8 eb 56 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 47 0f 91 f8 48 8b 03 48 39 d8 74 2a
RSP: 0000:ffffc90000a18a28 EFLAGS: 00010a02
RAX: 1fffea3017937f02 RBX: ffff5180bc9bf810 RCX: dffffc0000000000
RDX: 0000000080000101 RSI: 0000000000000008 RDI: 0000000000000000
RBP: ffffffff8ddf3a48 R08: ffffffff8969be0a R09: 1ffffffff1f5f50d
R10: dffffc0000000000 R11: fffffbfff1f5f50e R12: 1ffff9200014315c
R13: ffffc900034bf7c0 R14: ffffc90000a18ae0 R15: 0000000000697f0a
FS:  00007fd8f234c6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffe63017937f02 CR3: 0000000072ffa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 xdp_do_check_flushed+0x130/0x2f0 net/core/filter.c:4298
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
RIP: 0010:rdtsc_ordered arch/x86/include/asm/msr.h:230 [inline]
RIP: 0010:__pvclock_clocksource_read arch/x86/kernel/pvclock.c:77 [inline]
RIP: 0010:pvclock_clocksource_read_nowd+0x4a/0xf0 arch/x86/kernel/pvclock.c:120
Code: 89 e1 48 d3 e3 4c 89 2c 24 48 89 d8 48 f7 24 24 48 0f ac d0 20 49 8b 4e 10 41 0f b6 56 1d 41 8b 36 39 ee 89 f5 74 5d 0f 01 f9 <66> 90 48 89 d3 48 c1 e3 20 48 09 c3 49 2b 5e 08 83 e5 fe 45 8b 6e
RSP: 0000:ffffc900034bf318 EFLAGS: 00000283
RAX: 0000000068d4b4f6 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000089 RSI: 0000000000000000 RDI: ffffffff929f5040
RBP: 0000000000000004 R08: ffffea00019b5cf7 R09: 0000000000000000
R10: ffffed100cdae600 R11: fffff94000336b9f R12: 0000000000140dca
R13: 0000000000000001 R14: ffffffff929f5040 R15: dffffc0000000000
 kvm_sched_clock_read+0x11/0x20 arch/x86/kernel/kvmclock.c:91
 local_clock_noinstr+0xe/0xe0 kernel/sched/clock.c:301
 local_clock+0x10/0x30 kernel/sched/clock.c:315
 __set_page_owner+0x80/0x800 mm/page_owner.c:317
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1493
 prep_new_page mm/page_alloc.c:1501 [inline]
 get_page_from_freelist+0x2e4c/0x2f10 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4696
 alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2263
 folio_alloc_mpol_noprof mm/mempolicy.c:2281 [inline]
 vma_alloc_folio_noprof+0xf3/0x1f0 mm/mempolicy.c:2309
 folio_prealloc+0x31/0x170
 alloc_anon_folio mm/memory.c:4498 [inline]
 do_anonymous_page mm/memory.c:4555 [inline]
 do_pte_missing mm/memory.c:3945 [inline]
 handle_pte_fault+0x252d/0x6eb0 mm/memory.c:5522
 __handle_mm_fault mm/memory.c:5665 [inline]
 handle_mm_fault+0x1021/0x1990 mm/memory.c:5830
 do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7fd8f1447716
Code: 13 ff ff 48 c7 c0 ff ff ff ff eb b0 0f 1f 84 00 00 00 00 00 41 56 41 55 41 54 55 53 48 81 ec 40 20 00 00 48 8b 05 6a fd 1a 00 <48> 89 7c 24 18 48 89 74 24 10 be 02 55 08 80 48 89 54 24 08 48 8b
RSP: 002b:00007fd8f2349fd0 EFLAGS: 00010202
RAX: 0000100000000000 RBX: 00007fd8f1703f60 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffffffffff
RBP: 00007fd8f15e4e60 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd8f1703f60 R15: 00007ffd1bc275c8
 </TASK>
Modules linked in:
CR2: ffffe63017937f02
---[ end trace 0000000000000000 ]---
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:bpf_net_ctx_get_all_used_flush_lists+0x16b/0x390 include/linux/filter.h:846
Code: e6 08 31 ff e8 f6 c8 29 f8 4c 89 f8 48 83 e0 08 75 07 e8 08 c4 29 f8 eb 56 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 47 0f 91 f8 48 8b 03 48 39 d8 74 2a
RSP: 0000:ffffc90000a18a28 EFLAGS: 00010a02
RAX: 1fffea3017937f02 RBX: ffff5180bc9bf810 RCX: dffffc0000000000
RDX: 0000000080000101 RSI: 0000000000000008 RDI: 0000000000000000
RBP: ffffffff8ddf3a48 R08: ffffffff8969be0a R09: 1ffffffff1f5f50d
R10: dffffc0000000000 R11: fffffbfff1f5f50e R12: 1ffff9200014315c
R13: ffffc900034bf7c0 R14: ffffc90000a18ae0 R15: 0000000000697f0a
FS:  00007fd8f234c6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffe63017937f02 CR3: 0000000072ffa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	e6 08                	out    %al,$0x8
   2:	31 ff                	xor    %edi,%edi
   4:	e8 f6 c8 29 f8       	call   0xf829c8ff
   9:	4c 89 f8             	mov    %r15,%rax
   c:	48 83 e0 08          	and    $0x8,%rax
  10:	75 07                	jne    0x19
  12:	e8 08 c4 29 f8       	call   0xf829c41f
  17:	eb 56                	jmp    0x6f
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 47 0f 91 f8       	call   0xf8910f7f
  38:	48 8b 03             	mov    (%rbx),%rax
  3b:	48 39 d8             	cmp    %rbx,%rax
  3e:	74 2a                	je     0x6a


Tested on:

commit:         93306970 Merge tag '6.11-rc-smb3-server-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b58b79980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d04f9888ed34da73
dashboard link: https://syzkaller.appspot.com/bug?extid=61a1cfc2b6632363d319
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=145810a1980000


