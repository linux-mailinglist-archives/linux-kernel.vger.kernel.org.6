Return-Path: <linux-kernel+bounces-305851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC94696353B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C6B1F22AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7481AD9FB;
	Wed, 28 Aug 2024 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="guR9n05f";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kkAnEiVy"
Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205D1AD3F0
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886703; cv=none; b=cC5+tup6QdeX57qilW+r8+Zx8R93pA4SiI4dWJOQ7E87X4un65/s+MOqnwyAr8H/iHvDB41ga+9WWYjTov/w1UFLQBNVurMxP5VQCRZY+Il1piqEaU0EszS5Vfm5AqhYbArZ5iob9movkVB+ZPu3QlxhwSi6JZzJ7qUfKf5vWwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886703; c=relaxed/simple;
	bh=BwserWTJsoUXT2VW4VwyHHxVgatZZKxDwuEpV8we/hc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kWccitwzexE3W2Yahgl1OvIhVgejktTBpWQdzHfvgxftUjVWdisl4kRghFlQnIhjziDHCquIqN8QW2uYCzHnkdGh4kjGfz158K79b5ts0nT4RdRxnO01nUQ8j/Ys8qoWM7d/TqunKXLYKfaJXqfsozazH1CzzXwwl4onQpVGgEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=guR9n05f; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kkAnEiVy; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724886702; x=1756422702;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=BwserWTJsoUXT2VW4VwyHHxVgatZZKxDwuEpV8we/hc=;
  b=guR9n05fiMZ6BQ0tb5V81j1z9P/75B4zpM7vhcZ1bB/E9la0g/QKadnx
   r7LDjeFNk28prES3TGEBp7ESnQDWWJAVMgHl6OlF+tUoqT2DSwSD/dpju
   PigUloOvbX7WfMGjhdEe85sFY3T1Wsx56Km93I+xLQRT8R7G/On7psKC6
   U+YQr3ZPx3U64RHXDdNSRqQAkXwG4D4Uu7exz5Gn4SIRw1Y0Dr3YsM5PK
   rP3PW63db6ev63qirzaI3MpzqU/7MlpzZZsBxQgS89Qh5AV8tu+Facrjv
   RlADhKFKVc/2pMYYOrPRC9nzLq8wx91niC06p75Euicx7e9/alinWzX5u
   g==;
X-CSE-ConnectionGUID: T3ShMj5xS7Oyaxmnx59Opg==
X-CSE-MsgGUID: kkAsuTF5Qna3bWcqd9FI9w==
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:11:40 -0700
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3efe18d05so26072a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724886699; x=1725491499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DUeO6JKVK3baCx2aj9FjMQevTqN2pmnShjWnM3JexP0=;
        b=kkAnEiVyzw0oJgTPF+14JPmRgAibFEcH9Ftgyx/MMD3arm5ELTMMRu4cwh6mq3gDzJ
         rCX/x/H/+v+rU1biy2cHONpe59GXttLgu9i9l2pY2agBjGm/P8Ssvru2/7wB3zkppqQD
         EXdUowHYk3kSfGjfbZbHYH6I9DcNPDckIA0gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886699; x=1725491499;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUeO6JKVK3baCx2aj9FjMQevTqN2pmnShjWnM3JexP0=;
        b=VyQ7cgoIqrtGJ1KCkPEKP5BSpouK5GrZsr9tc5KxZHaajJnMt+A8SbwPWubt4FQ8kx
         gmr6aDREXA7kT11FCcY0zANtdoWMBCKudvKIor2O5btUp1v56vvxLbRH+MxoU8NTbuE1
         CJKvV9tWI9uiJqKzcmZHs3shngQJDubDL8BS9+aXDBZONk6s2BDxDoW1BBrC6qt7Ha24
         a0n56WYHWIczsVfcsPgAnjUi9M7Wx9zJI0MEE822KzTKVk1YjlSomOqR9omIb4B+DL1q
         PcpsnxeUpUN7UdQqykcY8hinbjLGimwELyNZ2MO5IB4dxv0aSUe7ZmafSJCG6KFYngKN
         pI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVF1LP9mJarqm2ybCgQfzQ5wD0QShrEntltCjxM3FbDqM6nKPeGEFdTA6ahNQSB3suXaz+fr4Vgf4Vfxr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCOItZWXdaK0lnktgLGwINNgPoH801zto+A5XsIJoRVWDE8Ybq
	jlZJYgswqFSTNvnK2Cn4x55rlY0SemcFg8f4ifSkJD0zWSRvJTgApnI/IzehWDy/g4u78wBaX1o
	JgcqGPXNBYBwlKP8vRLzYCSw9KA99IADamZPoJI/KLhLjQIf5eI+7D427DaBLtKPdgJ+ruVA6J6
	amJlIPMq5UMCRRH9qfJZZmPSHLccLfS2U2KDF5WA==
X-Received: by 2002:a17:90a:ad7:b0:2cf:f3e9:d5c9 with SMTP id 98e67ed59e1d1-2d8561c89f6mr835527a91.21.1724886699257;
        Wed, 28 Aug 2024 16:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaWo946zxgM1iMHA7cDHZY6g+Z0HfHOJ9Ly5ZrdwqZxwFZuwmXoITlveZQlNG55Tc8rn7K0KD0OiMTRnnul3Q=
X-Received: by 2002:a17:90a:ad7:b0:2cf:f3e9:d5c9 with SMTP id
 98e67ed59e1d1-2d8561c89f6mr835510a91.21.1724886698864; Wed, 28 Aug 2024
 16:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:11:28 -0700
Message-ID: <CALAgD-5236x-7bVxVzuv9DGqAVj+UT6pJL8QBd-CHAHPNd1n5Q@mail.gmail.com>
Subject: BUG: general protection fault in fib6_walk_continue
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a null
pointer dereference  bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 14197 Comm: syz-executor Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:fib6_walk_continue+0x485/0x8e0 net/ipv6/ip6_fib.c:2145
Code: 4c 89 e0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 e7 e8 ff 94 4b
f8 4d 8b 34 24 e8 86 c9 4e 01 49 8d 7e 08 48 89 f8 48 c1 e8 03 <42> 80
3c 38 00 74 05 e8 df 94 4b f8 4d 8b 6e 08 e8 66 c9 4e 01 49
RSP: 0000:ffffc900046b6f70 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88801c35da00
RDX: 0000000000000000 RSI: ffffffff8ee6fe40 RDI: 0000000000000008
RBP: ffff88803f4451a0 R08: 0000000000000005 R09: ffffffff89a8c42a
R10: 0000000000000005 R11: ffff88801c35da00 R12: ffff88803f445180
R13: ffffc900046b70f8 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f226a135b70 CR3: 000000002d330000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fib6_walk+0x148/0x280 net/ipv6/ip6_fib.c:2179
 fib6_clean_tree net/ipv6/ip6_fib.c:2259 [inline]
 __fib6_clean_all+0x31b/0x4b0 net/ipv6/ip6_fib.c:2275
 rt6_sync_down_dev net/ipv6/route.c:4910 [inline]
 rt6_disable_ip+0x151/0x810 net/ipv6/route.c:4915
 addrconf_ifdown+0x170/0x1b50 net/ipv6/addrconf.c:3855
 addrconf_notify+0x3c4/0x1000
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 dev_close_many+0x352/0x4e0 net/core/dev.c:1585
 unregister_netdevice_many_notify+0x542/0x16d0 net/core/dev.c:11194
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 unregister_netdevice_queue+0x2ff/0x370 net/core/dev.c:11156
 unregister_netdevice include/linux/netdevice.h:3119 [inline]
 __tun_detach+0x6ad/0x15e0 drivers/net/tun.c:685
 tun_detach drivers/net/tun.c:701 [inline]
 tun_chr_close+0x104/0x1b0 drivers/net/tun.c:3500
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x239/0x2f0 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa13/0x2560 kernel/exit.c:876
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1025
 get_signal+0x1697/0x1730 kernel/signal.c:2909
 arch_do_signal_or_restart+0x92/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x95/0x280 kernel/entry/common.c:218
 do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f9aeb77f3fc
Code: Unable to access opcode bytes at 0x7f9aeb77f3d2.
RSP: 002b:00007ffd2d9a0320 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000003 RCX: 00007f9aeb77f3fc
RDX: 0000000000000028 RSI: 00007ffd2d9a03d0 RDI: 00000000000000f9
RBP: 00007ffd2d9a037c R08: 0000000000000000 R09: 0079746972756365
R10: 00007f9aeb9147e0 R11: 0000000000000246 R12: 0000555564b1a5eb
R13: 0000555564b1a590 R14: 0000000000058bc3 R15: 00007ffd2d9a03d0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fib6_walk_continue+0x485/0x8e0 net/ipv6/ip6_fib.c:2145
Code: 4c 89 e0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 e7 e8 ff 94 4b
f8 4d 8b 34 24 e8 86 c9 4e 01 49 8d 7e 08 48 89 f8 48 c1 e8 03 <42> 80
3c 38 00 74 05 e8 df 94 4b f8 4d 8b 6e 08 e8 66 c9 4e 01 49
RSP: 0000:ffffc900046b6f70 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88801c35da00
RDX: 0000000000000000 RSI: ffffffff8ee6fe40 RDI: 0000000000000008
RBP: ffff88803f4451a0 R08: 0000000000000005 R09: ffffffff89a8c42a
R10: 0000000000000005 R11: ffff88801c35da00 R12: ffff88803f445180
R13: ffffc900046b70f8 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f226a135b70 CR3: 000000002d330000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 4c 89 e0             mov    %r12,%rax
   3: 48 c1 e8 03           shr    $0x3,%rax
   7: 42 80 3c 38 00       cmpb   $0x0,(%rax,%r15,1)
   c: 74 08                 je     0x16
   e: 4c 89 e7             mov    %r12,%rdi
  11: e8 ff 94 4b f8       call   0xf84b9515
  16: 4d 8b 34 24           mov    (%r12),%r14
  1a: e8 86 c9 4e 01       call   0x14ec9a5
  1f: 49 8d 7e 08           lea    0x8(%r14),%rdi
  23: 48 89 f8             mov    %rdi,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 38 00       cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
  2f: 74 05                 je     0x36
  31: e8 df 94 4b f8       call   0xf84b9515
  36: 4d 8b 6e 08           mov    0x8(%r14),%r13
  3a: e8 66 c9 4e 01       call   0x14ec9a5
  3f: 49                   rex.WB


-- 
Yours sincerely,
Xingyu

