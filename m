Return-Path: <linux-kernel+bounces-258188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657009384D2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CD772817D5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450111649CC;
	Sun, 21 Jul 2024 13:41:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294B88C0B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569264; cv=none; b=Kt54dxfbdYOEPFWaHzkeM0ASnYkPYneJJQn9QR4n2MDPog9C1gCU5zLyZkwT/AQHFEPRVLfTrERjG8EvaR+x0wbgx+kzmJM5zrypMiXb3zA1gL2iM6hxgw4FNHhhxR+dUVIPZBMvxRdCtzNVIIAjJ5M2AGWJSpfyJAMLeL0F6LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569264; c=relaxed/simple;
	bh=1vmLenoVpbV4Fxz/HSAxK/Bl67vhiGgK4m9HeHjKW44=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B6WA1nXuCTYnIJt084w/7YugRWB2Ar68MC6iJOGx5murQnfMpZwe5ly1u8D389fkIU/Vo0P7MRBYXAaNp5+80kibNXRmR6pH2W2p2hWF/JG3Qf5hSFsqeut4hG87lNICr6oA0vTr9DBSbJnFlvCSBi35zTpx2S2La+kAJWEIfF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3962d4671c7so57486715ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 06:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721569262; x=1722174062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8tYaJLqttcjE6LYnLd3uje49NESKqfja0A+IlpNjUI=;
        b=twBP4AAk4QkcAuzcMsU2YEcJ3a2oMKmNjXJoAMG2fleHDcWlCDhV9hYFjaQC1Q48p1
         U6GtL6hFqAPwwesHbDf6sCNqg7GzMggMWNb5xxLMyzyqZvM5HnFDMcgOkeYNn+47Eyoy
         fd+GS8x8stPquELVtuo8eKpLCaORfloBQV9xd3+yvqsOLmvIHcX5DXxN84kx+FNE2LnK
         NYevnuyB0b6HEQ0PQVuS+GYpQhgSpC/m5R1bkTuRzhqAkBCu09uTCw6XNIhIOjd1oaU0
         U/Teiood/+vIeM7ADv65NdpN2E7dnQIwWfjo8SmS5FeCHdxx6qZIzTGCqE0EZtzmoVMD
         w41A==
X-Forwarded-Encrypted: i=1; AJvYcCX4SFzfnQGlWB8wjdCnBAC+szp+QDLAs/B9srtzsQ2Z9dUQUjWvhmidb7eiokybEouv0xGq+p4tCSh3PKPJYBff9tXbPDr5xxtFl3K5
X-Gm-Message-State: AOJu0Yxfr2lShZsz/l8PLfychBlrvqNnhtAu3d0pqVbdyLRC1My1CJfS
	+DVXoAd1rhIUVm5D6f0ymnyXIBHOFe2gAxMvgD9ohHhxsiCc8MyJEAbvfS+CRCipy7NOmblf4wx
	s9bs3pY/nvA8wC87F/xIX7vA3Cqj6s2iA7QU4sl3QBPc5rvDdA8hcbXw=
X-Google-Smtp-Source: AGHT+IGC5/EJfDeGZYwEm3S6o4MYTlLgbU3HV2g0nVf+2Jo9HKmOaqN+WR2d850OFeC9ge/+poFEYueB2qI3r9FmfAE4pVApJfd0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219c:b0:396:e35:f958 with SMTP id
 e9e14a558f8ab-398e4bcdd7cmr2047015ab.2.1721569262268; Sun, 21 Jul 2024
 06:41:02 -0700 (PDT)
Date: Sun, 21 Jul 2024 06:41:02 -0700
In-Reply-To: <20240721131603.267262-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005586b6061dc21492@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in __dev_flush

bq->count = 0
Oops: general protection fault, probably for non-canonical address 0xdffffc0003fffe01: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: probably user-memory-access in range [0x000000001ffff008-0x000000001ffff00f]
CPU: 1 PID: 6644 Comm: syz.0.358 Not tainted 6.10.0-syzkaller-11185-g2c9b3512402e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:__list_del include/linux/list.h:195 [inline]
RIP: 0010:__list_del_clearprev include/linux/list.h:209 [inline]
RIP: 0010:__dev_flush+0xe4/0x160 kernel/bpf/devmap.c:430
Code: b8 00 00 00 00 00 fc ff df 41 80 7c 05 00 00 49 89 c5 74 08 48 89 df e8 0a 80 3a 00 48 8b 2b 48 8d 5d 08 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 dd 80 3a 00 4c 89 23 4c 89 e0 48
RSP: 0018:ffffc90000a18af0 EFLAGS: 00010202
RAX: 0000000003fffe01 RBX: 000000001ffff008 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88802e31a120
RBP: 000000001ffff000 R08: ffff88802e31a11f R09: 0000000000000000
R10: ffff88802e31a110 R11: ffffed1005c63424 R12: 0000000020000000
R13: dffffc0000000000 R14: ffff88802e31a100 R15: 1ffff11005c63420
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efc38d06030 CR3: 000000002d8c8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
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
RIP: 0010:page_ext_get+0x5/0x2a0 mm/page_ext.c:518
Code: f1 49 91 ff 90 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 55 <41> 57 41 56 41 54 53 48 89 fb e8 bc 49 91 ff e8 57 40 78 ff 4c 8d
RSP: 0018:ffffc90003d6f378 EFLAGS: 00000283
RAX: 0000001e5a5649e6 RBX: ffffea00019ecd00 RCX: 0000001f7035090d
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffffea00019ecd00
RBP: 0000000000000000 R08: ffffea00019ecd37 R09: 1ffffd400033d9a6
R10: dffffc0000000000 R11: fffff9400033d9a7 R12: 0000000000000005
R13: ffffea00019ecd00 R14: 0000000000000000 R15: 0000000000000000
 __reset_page_owner+0x2f/0x3f0 mm/page_owner.c:290
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1093 [inline]
 free_unref_folios+0xf12/0x19c0 mm/page_alloc.c:2637
 folios_put_refs+0x93a/0xa60 mm/swap.c:1024
 folios_put include/linux/mm.h:1572 [inline]
 folio_batch_move_lru+0x5d7/0x690 mm/swap.c:227
 lru_add_drain_cpu+0x10e/0x8c0 mm/swap.c:657
 lru_add_drain+0x123/0x3e0 mm/swap.c:757
 exit_mmap+0x22b/0xc80 mm/mmap.c:3336
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
RIP: 0033:0x7efc38b75b59
Code: Unable to access opcode bytes at 0x7efc38b75b2f.
RSP: 002b:00007efc385ff0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007efc38d05f68 RCX: 00007efc38b75b59
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007efc38d05f68
RBP: 00007efc38d05f60 R08: 00007efc385ff6c0 R09: 00007efc385ff6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007efc38d05f6c
R13: 000000000000000b R14: 00007fff8a519330 R15: 00007fff8a519418
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del include/linux/list.h:195 [inline]
RIP: 0010:__list_del_clearprev include/linux/list.h:209 [inline]
RIP: 0010:__dev_flush+0xe4/0x160 kernel/bpf/devmap.c:430
Code: b8 00 00 00 00 00 fc ff df 41 80 7c 05 00 00 49 89 c5 74 08 48 89 df e8 0a 80 3a 00 48 8b 2b 48 8d 5d 08 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 dd 80 3a 00 4c 89 23 4c 89 e0 48
RSP: 0018:ffffc90000a18af0 EFLAGS: 00010202
RAX: 0000000003fffe01 RBX: 000000001ffff008 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88802e31a120
RBP: 000000001ffff000 R08: ffff88802e31a11f R09: 0000000000000000
R10: ffff88802e31a110 R11: ffffed1005c63424 R12: 0000000020000000
R13: dffffc0000000000 R14: ffff88802e31a100 R15: 1ffff11005c63420
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efc38d06030 CR3: 000000002d8c8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b8 00 00 00 00       	mov    $0x0,%eax
   5:	00 fc                	add    %bh,%ah
   7:	ff                   	(bad)
   8:	df 41 80             	filds  -0x80(%rcx)
   b:	7c 05                	jl     0x12
   d:	00 00                	add    %al,(%rax)
   f:	49 89 c5             	mov    %rax,%r13
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 0a 80 3a 00       	call   0x3a8026
  1c:	48 8b 2b             	mov    (%rbx),%rbp
  1f:	48 8d 5d 08          	lea    0x8(%rbp),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 dd 80 3a 00       	call   0x3a8116
  39:	4c 89 23             	mov    %r12,(%rbx)
  3c:	4c 89 e0             	mov    %r12,%rax
  3f:	48                   	rex.W


Tested on:

commit:         2c9b3512 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103033fd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f4925140c45a2a50
dashboard link: https://syzkaller.appspot.com/bug?extid=707d98c8649695eaf329
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13eae521980000


