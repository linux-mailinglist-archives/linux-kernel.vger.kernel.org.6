Return-Path: <linux-kernel+bounces-305804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6AB9634AE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10CA1F23180
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA95D1AD3F9;
	Wed, 28 Aug 2024 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="DPhZmxv5";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="xwijqajO"
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455361AC442
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884024; cv=none; b=ad95bS6L7L+ykuv4K8uIJyHa1zMwGA2yqC4agSqi60eXEbBIZIz2ywKHMkexc1ctHFjckDAfTWcWTKl0fpSDyxZslaj6z8EYqHX+aVnKKHlqvotb3Eroi6bgkvt6Y42x3EvYAW7/jlYQCCj+zVJjXBj+TQ3lJf9QmS95JIy0fJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884024; c=relaxed/simple;
	bh=E900X6eOIDysivie/UIIxy4tEChL87qrfDGcuGsm3qE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kEjozlhj/foOps8QCz43ZZ/XdMRknvm4QvuI/7JwwiNddEjhmhpnYagdrjanKM5QaYLk/pNG+4SnUxuix9iqare6MyRZ5C1bkSs1EaxytoSkDTjId2/IhEXMcOdhVJXReB3WxzKFpEC/AGG4FOAHDQ/sjqfRFMDbIX6X1PB1qzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=DPhZmxv5; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=xwijqajO; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724884023; x=1756420023;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=E900X6eOIDysivie/UIIxy4tEChL87qrfDGcuGsm3qE=;
  b=DPhZmxv5VxO0z56trxlZnsPt24ri6oJTRVIaAu1zWeaoI4jldwpRUha6
   Y+EqSI6CW953IwJN0bfnvLzb8VkfYkXUm26qL5TuGZgRuthdeIleD+eP0
   S2OI5/EF/I7OuvskxhaqVHlYULqd/FjF4xMskdRUEa4jvgDn9tOPE5UjW
   RoaZQV4d/zKbk/xIcmTw54zgWLzJwPNK7gmHAtBlgo1APOAl3kyGaEaTE
   4836e0oaR00+rrlkc5Ze4OIv2yyGMp43dXldMRWa1urmsqW3vdiNH+ycW
   c2cLrw+60PxY6mR2eENIGNj/IqxBi9FeHttKtip92274zl+ZSWjDj/kJb
   g==;
X-CSE-ConnectionGUID: czD0MlqjSn+SOp5Kh4PrGg==
X-CSE-MsgGUID: CV7oDkyLTEK2Zn8DawCiGg==
Received: from mail-pg1-f200.google.com ([209.85.215.200])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 15:27:03 -0700
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7163489149fso6873781a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724884022; x=1725488822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eDOXD/EP9F/yMuuaJch1JjWR7K79TDmYgKEG8ltHe34=;
        b=xwijqajO5kF7OtxveBLADVAUhppni7TVlDpVZM3eRtLhWW6ccCsxofErNQVHhKpSBM
         Z6Z9fJO5QKcQqg4bZDQZqmWTzq2RaZyi009jGSI++okJ72Bl4TPCFc9oRBTaMkaFp0sk
         wRMRZBi0ivEZlaSK/+S0+ttxW8S0v7iTkEbbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724884022; x=1725488822;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDOXD/EP9F/yMuuaJch1JjWR7K79TDmYgKEG8ltHe34=;
        b=bxBXJPcNc4IZaKqOSHicELqnEWm1Q2EM4vSSv5CcYuWaOkwCPESnQzfzYT+NDq39qq
         C6Wl46+R1g9st1BNmmkG3XR+E7Sdzvjyib1/5ZBOm8hrrRNlSKz9YqrSLjwmLEMGa+6y
         ++3yYssm7V7CEqEIinMibbfLYtXId2iQY3j8I1Qt2yBOqZ6HwK7GRi6T/iLRSZ5XuOfo
         nTD/z1SuBLtpbGv8hXizFCqpR8NffHasne5Zz4X17O3ZZc2MrOdVbq8dFNje6pTthH7U
         NyBoaNjbfHaXCXaRivZ4StDvLQfMTAbM+qGfCcK6qGZzJQhigmivsNq5XEcd8mntHRfM
         /PfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLYzhRUFl2FHie61Nr69TWjtcl6r3haSRDxEiytwWplPft9kZ+YGEHoCE9+RgdWNoIQ44AkMpizzVgVOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3QABb/TaMS1m2+AvSYnbJbQMBYcjneW6MYs6IkkXU+AVEauSZ
	sWAs52RzHftKf7U9v4gwg4kndoUKGREEX0UYxDsFOWVjGW8Z4fJ8bbK+3omN/HrhDpfL4hAhDaM
	FzKSGoJcMbYLNMcyJEElFfKkDvXyh18mqbEfHtKHd5iepZeRrQNhspPmOkshIUVKkJD64wpG9lm
	bpUxYxt3hYiOx8uqXRdkCAbwzQByI7+kuRxDrc5g==
X-Received: by 2002:a17:90b:4b01:b0:2d3:ce8d:f7f1 with SMTP id 98e67ed59e1d1-2d8561c7556mr867151a91.25.1724884021821;
        Wed, 28 Aug 2024 15:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrnlHDYNEZ3LM9N1ZyjWq7qFuRO6rPI0y/TNS8kmGFEz+u5w7lJ9GUvzIOqvSDHJO/uK6Kk8bjKnAOjM/Od/4=
X-Received: by 2002:a17:90b:4b01:b0:2d3:ce8d:f7f1 with SMTP id
 98e67ed59e1d1-2d8561c7556mr867133a91.25.1724884021483; Wed, 28 Aug 2024
 15:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 15:26:51 -0700
Message-ID: <CALAgD-4953yNbwDnL99Tzt+H=Sa7jGOzPWZ0VZJU-=XRrZ3DaA@mail.gmail.com>
Subject: BUG: stack segment fault in insert_vmap_area_augment
To: akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a
corrupted stack  bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

Oops: stack segment: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 8042 Comm: syz-executor Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__rb_insert lib/rbtree.c:115 [inline]
RIP: 0010:__rb_insert_augmented+0x90/0x6a0 lib/rbtree.c:459
Code: 48 89 ef e8 d2 4c 03 f7 4c 8b 6d 00 41 f6 c5 01 0f 85 0c 06 00
00 48 89 5c 24 18 48 89 2c 24 4d 8d 75 08 4c 89 f5 48 c1 ed 03 <42> 80
7c 3d 00 00 74 08 4c 89 f7 e8 a0 4c 03 f7 49 8b 1e 48 3b 1c
RSP: 0018:ffffc9000a9b74e8 EFLAGS: 00010202
RAX: 1ffff11003b5f029 RBX: ffff88801daf8148 RCX: 0000000000000000
RDX: ffffffff81e63c60 RSI: ffffffff92949620 RDI: ffff88801daf8148
RBP: 0000000000000001 R08: ffffffff81e68333 R09: 0000000000000000
R10: ffff88801daf8150 R11: ffff88802f3f1e00 R12: 1ffff110078b0ff0
R13: 0000000000000000 R14: 0000000000000008 R15: dffffc0000000000
FS:  0000555565ef3500(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f25ffff CR3: 000000001bc74000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rb_insert_augmented include/linux/rbtree_augmented.h:50 [inline]
 __link_va mm/vmalloc.c:1197 [inline]
 link_va_augment mm/vmalloc.c:1221 [inline]
 insert_vmap_area_augment+0x322/0x640 mm/vmalloc.c:1347
 va_clip mm/vmalloc.c:1722 [inline]
 va_alloc mm/vmalloc.c:1747 [inline]
 __alloc_vmap_area mm/vmalloc.c:1783 [inline]
 alloc_vmap_area+0xde6/0x2200 mm/vmalloc.c:1999
 __get_vm_area_node+0x1c9/0x290 mm/vmalloc.c:3118
 __vmalloc_node_range_noprof+0x3c5/0x1440 mm/vmalloc.c:3800
 alloc_thread_stack_node+0x354/0x5f0 kernel/fork.c:309
 dup_task_struct+0x8b/0x5a0 kernel/fork.c:1115
 copy_process+0x5c8/0x3d80 kernel/fork.c:2220
 kernel_clone+0x224/0x6c0 kernel/fork.c:2797
 __do_sys_clone3 kernel/fork.c:3098 [inline]
 __se_sys_clone3+0x2c6/0x340 kernel/fork.c:3082
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f22ec1b48e9
Code: bc 07 00 48 8d 3d 7c bc 07 00 e8 a2 29 f6 ff 66 90 b8 ea ff ff
ff 48 85 ff 74 2c 48 85 d2 74 27 49 89 c8 b8 b3 01 00 00 0f 05 <48> 85
c0 7c 18 74 01 c3 31 ed 48 83 e4 f0 4c 89 c7 ff d2 48 89 c7
RSP: 002b:00007ffec2afdbf8 EFLAGS: 00000206 ORIG_RAX: 00000000000001b3
RAX: ffffffffffffffda RBX: 00007f22ec17ebc0 RCX: 00007f22ec1b48e9
RDX: 00007f22ec17ebc0 RSI: 0000000000000058 RDI: 00007ffec2afdc60
RBP: 00007ffec2afdcc0 R08: 00007ffec2afdcc0 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000206 R12: ffffffffffffffa8
R13: 0000000000000009 R14: 00007ffec2afdc60 R15: 00007ffec2afe130
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__rb_insert lib/rbtree.c:115 [inline]
RIP: 0010:__rb_insert_augmented+0x90/0x6a0 lib/rbtree.c:459
Code: 48 89 ef e8 d2 4c 03 f7 4c 8b 6d 00 41 f6 c5 01 0f 85 0c 06 00
00 48 89 5c 24 18 48 89 2c 24 4d 8d 75 08 4c 89 f5 48 c1 ed 03 <42> 80
7c 3d 00 00 74 08 4c 89 f7 e8 a0 4c 03 f7 49 8b 1e 48 3b 1c
RSP: 0018:ffffc9000a9b74e8 EFLAGS: 00010202
RAX: 1ffff11003b5f029 RBX: ffff88801daf8148 RCX: 0000000000000000
RDX: ffffffff81e63c60 RSI: ffffffff92949620 RDI: ffff88801daf8148
RBP: 0000000000000001 R08: ffffffff81e68333 R09: 0000000000000000
R10: ffff88801daf8150 R11: ffff88802f3f1e00 R12: 1ffff110078b0ff0
R13: 0000000000000000 R14: 0000000000000008 R15: dffffc0000000000
FS:  0000555565ef3500(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2f25ffff CR3: 000000001bc74000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 48 89 ef             mov    %rbp,%rdi
   3: e8 d2 4c 03 f7       call   0xf7034cda
   8: 4c 8b 6d 00           mov    0x0(%rbp),%r13
   c: 41 f6 c5 01           test   $0x1,%r13b
  10: 0f 85 0c 06 00 00     jne    0x622
  16: 48 89 5c 24 18       mov    %rbx,0x18(%rsp)
  1b: 48 89 2c 24           mov    %rbp,(%rsp)
  1f: 4d 8d 75 08           lea    0x8(%r13),%r14
  23: 4c 89 f5             mov    %r14,%rbp
  26: 48 c1 ed 03           shr    $0x3,%rbp
* 2a: 42 80 7c 3d 00 00     cmpb   $0x0,0x0(%rbp,%r15,1) <-- trapping
instruction
  30: 74 08                 je     0x3a
  32: 4c 89 f7             mov    %r14,%rdi
  35: e8 a0 4c 03 f7       call   0xf7034cda
  3a: 49 8b 1e             mov    (%r14),%rbx
  3d: 48                   rex.W
  3e: 3b                   .byte 0x3b
  3f: 1c                   .byte 0x1c


-- 
Yours sincerely,
Xingyu

