Return-Path: <linux-kernel+bounces-305925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3FD96367B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F3B22831
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6428A1AC89F;
	Wed, 28 Aug 2024 23:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Mer2CDoi";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="hqSofwFc"
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E516C690
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889242; cv=none; b=V422MH6om3gTdhZrLfsNl0/VVRMVemRJLK1keekYhD8jNzOUmar0RjNaeeJH/Mqzyh7haF/VILDfTrFVdBBb4Bwb/hQGIN16kMED3lSjHw0J/IQcK2HrRpUBDrgJE9efYNhr3QRWA7kD51wCj5J0n7p8gwj7SP9Rh9NoNqyl/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889242; c=relaxed/simple;
	bh=E97A5dx1onLjqWdMNb6LaX9rBWGWuXOGtXQUI1GCRl8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qWD4ru4rDRoySr1n0nBgz90t1YQ8y7Gr2Mif/QcFsNfsRH1mhrfU/XWfWrto9XezabIsJwz6HxuvkXGJHUwAGl8ukdOpM+K7bbUpkVNvHGJPdkZCWH4UY/FHkji0KbG/qcr3QD0CChT2pwOM4ckWcqLuyLwp7pX75z9rA+sSStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Mer2CDoi; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=hqSofwFc; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724889241; x=1756425241;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=E97A5dx1onLjqWdMNb6LaX9rBWGWuXOGtXQUI1GCRl8=;
  b=Mer2CDoizqRnyoYVFihiMYg7bBREJJ0qYKoNco7RSr4c69IXnCrkUOWP
   gj9P4fSjk+bQ8qUYvqszVVNOMXjn6/YDlBB4ZdHhRtKrHLVos1vPaFClh
   fjCc2h1kI9jHvHnVdm2UEyeDe/9XLy0zeJP/Sf8kTAQqgXps4jxdQncSk
   HSpNW0xm6QApPSzsL0O5VE6roDlmou9BFvxGosejTXx/ikn+DfUZMqLuu
   9h40c8/oouUKr90cIIueRWJIGhZlQEqU9lC1R8VSr54/hQf1qApVfl8GR
   pw7IQcFAN693u5VyyHmFjw+bnPYxVnv8nebt6jf4gG7EnRMBicPCTqK+h
   Q==;
X-CSE-ConnectionGUID: nurEGHWOTrKeM0jQIECdew==
X-CSE-MsgGUID: IZmMdtb9QnahpjbntyEQhw==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:53:54 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d4c745e31so246485ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724889233; x=1725494033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H6J+Lk54GJ2FAsyo2jNZMja5LmQJBxgSCMdJcnPlBXI=;
        b=hqSofwFcOO4jjdeqjlWWr5G4da4tN8JF9b9PerpCW3Aif2mkUYuYCz5lDakQGrQPdb
         0LdSzxW0dwZR1bRcJWvZ6tdBc1170rpN09ft+r6NupbDxoHPwT8g4BnOZBxCEfDaifNR
         8ilpcLWvgCPuYO7XVI5nBnwHlINUOyTIMZidc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724889233; x=1725494033;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H6J+Lk54GJ2FAsyo2jNZMja5LmQJBxgSCMdJcnPlBXI=;
        b=MQC1CEufRKbBFNvKGdBTL/5QZwTha148KMUILBSq3GUc7k2mnp2NLJaWdmjOpcOpAQ
         TO+594vDjDSno151WTuD3f0JIi+aJ/9zn8TMUzKjqWccEvD+iM/p+8zvfnSc5G2+me5j
         i6CaMZUCuZjGkZHDB6xjYoIB3gSBs5fU/r4e3vqkArZuOHB9Awsl9UAEGxEq7b0Hgy3a
         G2AtNY8lcIuFpF4b9lNxx0bbwqmypaLbxMmotFvxE8dZ+w4o7UMM2SBHf0jwrfCp81R4
         OQOZnne0a2/c26FgSHETuvTzYYrRZVb/s7nR6zfUeWrnT+H3eydwoSDlLXHA8PCbwNJV
         kpNw==
X-Forwarded-Encrypted: i=1; AJvYcCXDPcErh25Cajf9hTQiQtzNtk5FKqRUPeUN39HV/QEPLlE2hJsaTLDCkQsj+1BO32tOleqQU3ipySFEtY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKIlAGEEQDKJhIFeWpYIYc/cuK/YG8y7p+u5QCvF8QtSqQgx7z
	H0aQvO9Z2A/Sq42FuADglCVJKfU64ll494AxEUe7XAtqixZKnVPwHr0bipUOcZrS3MKziw4vZ2U
	2RqEh+Q10qgtAAY/Kg+2oXuvW/ygun8gabrzrgy/C48vwHgheUeG+2JrkbVRIpUboVNE5dhD+GZ
	cOXamQ7Hac8K6HS7/uSLcbE4/E+kOIeVWR8ekbs3bqAoezBgZq8wk=
X-Received: by 2002:a05:6e02:1e09:b0:39d:300f:e8ff with SMTP id e9e14a558f8ab-39f377ce515mr20440175ab.6.1724889232631;
        Wed, 28 Aug 2024 16:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJRyEFlJr4UE6xdXANDb2dpDgeKNlBSstJYfCRCj3LG6DLaJPiIvdMOI7mAGs+dGLp7jboE7424Wj/ZGqIbLs=
X-Received: by 2002:a05:6e02:1e09:b0:39d:300f:e8ff with SMTP id
 e9e14a558f8ab-39f377ce515mr20439985ab.6.1724889232255; Wed, 28 Aug 2024
 16:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:53:41 -0700
Message-ID: <CALAgD-6x1j8n6TkdHUyNDLJY1YMR+aFFP0Z5xa9Vfbf-=TVvGQ@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in rhashtable_lookup
To: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a page fault   bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

BUG: unable to handle page fault for address: ffffed10ee2f3093
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 13ffee067 P4D 13ffee067 PUD 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 11166 Comm: syz.1.137 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
RIP: 0010:__rhashtable_lookup include/linux/rhashtable.h:607 [inline]
RIP: 0010:rhashtable_lookup+0x2f7/0x850 include/linux/rhashtable.h:646
Code: 48 8d 9c c1 80 00 00 00 48 89 d8 48 83 c8 01 48 89 44 24 28 49
bd 00 00 00 00 00 fc ff df 48 89 5c 24 50 48 89 d8 48 c1 e8 03 <42> 80
3c 28 00 74 08 48 89 df e8 0a b8 28 f8 4c 8b 23 e8 92 ec 2b
RSP: 0018:ffffc90000006fa0 EFLAGS: 00010a06
RAX: 1ffff110ee2f3093 RBX: ffff888771798498 RCX: ffff88802cd45000
RDX: 0000000000000302 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000007108 R08: ffffffff89cba429 R09: ffffffff84569d43
R10: 0000000000000003 R11: ffff8880453d9e00 R12: ffff88802cd45004
R13: dffffc0000000000 R14: ffffc90000007090 R15: 00000000e894a683
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed10ee2f3093 CR3: 000000004b92c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 br_mdb_ip_get_rcu net/bridge/br_multicast.c:102 [inline]
 br_mdb_entry_skb_get+0x66f/0x990 net/bridge/br_multicast.c:198
 br_dev_xmit+0xd82/0x1ad0 net/bridge/br_device.c:101
 __netdev_start_xmit include/linux/netdevice.h:4882 [inline]
 netdev_start_xmit include/linux/netdevice.h:4896 [inline]
 xmit_one net/core/dev.c:3578 [inline]
 dev_hard_start_xmit+0x1d9/0x410 net/core/dev.c:3594
 __dev_queue_xmit+0x1b40/0x3b40 net/core/dev.c:4393
 neigh_output include/net/neighbour.h:542 [inline]
 ip6_finish_output2+0xf91/0x15b0 net/ipv6/ip6_output.c:137
 ip6_finish_output+0x43b/0x8f0 net/ipv6/ip6_output.c:222
 dst_output include/net/dst.h:450 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ndisc_send_skb+0xb6c/0x11e0 net/ipv6/ndisc.c:509
 addrconf_rs_timer+0x3a3/0x650 net/ipv6/addrconf.c:4039
 call_timer_fn+0xff/0x240 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2417 [inline]
 __run_timer_base+0x734/0x9a0 kernel/time/timer.c:2428
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb3/0x160 kernel/time/timer.c:2447
 handle_softirqs+0x272/0x750 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf0/0x1b0 kernel/softirq.c:637
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa0/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_release+0x5ca/0x860 kernel/locking/lockdep.c:5778
Code: 3c 23 00 74 08 4c 89 f7 e8 13 18 85 00 f6 84 24 91 00 00 00 02
75 68 41 f7 c5 00 02 00 00 74 01 fb 48 c7 44 24 60 0e 36 e0 45 <4b> c7
04 3c 00 00 00 00 4b c7 44 3c 08 00 00 00 00 65 48 8b 04 25
RSP: 0018:ffffc9000907f260 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200120fe5e RCX: ffffc9000907f203
RDX: 0000000000000003 RSI: ffffffff8b4c9b40 RDI: ffffffff8ba956e0
RBP: ffffc9000907f398 R08: ffffffff8f245f2f R09: 1ffffffff1e48be5
R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: dffffc0000000000
R13: 0000000000000246 R14: ffffc9000907f2f0 R15: 1ffff9200120fe58
 rcu_lock_release include/linux/rcupdate.h:339 [inline]
 rcu_read_unlock_sched include/linux/rcupdate.h:894 [inline]
 pfn_valid+0x3db/0x430 include/linux/mmzone.h:2032
 page_table_check_clear+0x1e/0x540 mm/page_table_check.c:70
 get_and_clear_full_ptes include/linux/pgtable.h:678 [inline]
 zap_present_folio_ptes mm/memory.c:1481 [inline]
 zap_present_ptes+0x664/0x1970 mm/memory.c:1564
 zap_pte_range+0x2f3/0x1840 mm/memory.c:1606
 zap_pmd_range+0x40f/0x5e0 mm/memory.c:1724
 zap_pud_range mm/memory.c:1753 [inline]
 zap_p4d_range mm/memory.c:1774 [inline]
 unmap_page_range+0x3c9/0x9f0 mm/memory.c:1795
 unmap_vmas+0x3c4/0x5e0 mm/memory.c:1885
 exit_mmap+0x245/0xa20 mm/mmap.c:3341
 __mmput+0x114/0x3b0 kernel/fork.c:1346
 exit_mm+0x207/0x2e0 kernel/exit.c:567
 do_exit+0x996/0x2560 kernel/exit.c:863
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1025
 __do_sys_exit_group kernel/exit.c:1036 [inline]
 __se_sys_exit_group kernel/exit.c:1034 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f87bf3809b9
Code: Unable to access opcode bytes at 0x7f87bf38098f.
RSP: 002b:00007ffc9a3fa668 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f87bf3809b9
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffc9a3fa6bc R08: 00007ffc9a3fa74f R09: 0000000000037b19
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000037b19 R14: 00000000000378e1 R15: 00007ffc9a3fa710
 </TASK>
Modules linked in:
CR2: ffffed10ee2f3093
---[ end trace 0000000000000000 ]---
RIP: 0010:rht_ptr_rcu include/linux/rhashtable.h:376 [inline]
RIP: 0010:__rhashtable_lookup include/linux/rhashtable.h:607 [inline]
RIP: 0010:rhashtable_lookup+0x2f7/0x850 include/linux/rhashtable.h:646
Code: 48 8d 9c c1 80 00 00 00 48 89 d8 48 83 c8 01 48 89 44 24 28 49
bd 00 00 00 00 00 fc ff df 48 89 5c 24 50 48 89 d8 48 c1 e8 03 <42> 80
3c 28 00 74 08 48 89 df e8 0a b8 28 f8 4c 8b 23 e8 92 ec 2b
RSP: 0018:ffffc90000006fa0 EFLAGS: 00010a06
RAX: 1ffff110ee2f3093 RBX: ffff888771798498 RCX: ffff88802cd45000
RDX: 0000000000000302 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000007108 R08: ffffffff89cba429 R09: ffffffff84569d43
R10: 0000000000000003 R11: ffff8880453d9e00 R12: ffff88802cd45004
R13: dffffc0000000000 R14: ffffc90000007090 R15: 00000000e894a683
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed10ee2f3093 CR3: 000000004b92c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 48 8d 9c c1 80 00 00 lea    0x80(%rcx,%rax,8),%rbx
   7: 00
   8: 48 89 d8             mov    %rbx,%rax
   b: 48 83 c8 01           or     $0x1,%rax
   f: 48 89 44 24 28       mov    %rax,0x28(%rsp)
  14: 49 bd 00 00 00 00 00 movabs $0xdffffc0000000000,%r13
  1b: fc ff df
  1e: 48 89 5c 24 50       mov    %rbx,0x50(%rsp)
  23: 48 89 d8             mov    %rbx,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 28 00       cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f: 74 08                 je     0x39
  31: 48 89 df             mov    %rbx,%rdi
  34: e8 0a b8 28 f8       call   0xf828b843
  39: 4c 8b 23             mov    (%rbx),%r12
  3c: e8                   .byte 0xe8
  3d: 92                   xchg   %eax,%edx
  3e: ec                   in     (%dx),%al
  3f: 2b                   .byte 0x2b


-- 
Yours sincerely,
Xingyu

