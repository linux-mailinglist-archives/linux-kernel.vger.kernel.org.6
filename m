Return-Path: <linux-kernel+bounces-300269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BF895E1B8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90171F21DB7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC82AEFB;
	Sun, 25 Aug 2024 04:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="YwecKXVw";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="fufiP/No"
Received: from mx6.ucr.edu (mx6.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D182207A
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 04:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724560993; cv=none; b=jR+9sPE3qSshUNLXyalmHMP4cxRtJc+2zSqLR5hFle2HnfmcHX2wpN6qTO3bHpZLQv30iyev+sVP/Ny0uXE2Ej0hqrx7jKsOT8q4c18cGL22AWjH3dhU/cygYgKgu3A/zh7fhA4v7f4bjwCfyh6kuNPKAv1fTeiBdcbTdcgmpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724560993; c=relaxed/simple;
	bh=dPxybXlvHz3O8LDvjIG5RR6Lq9WCiAiYGU7pULvw8bs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WwmlnHjGEe4mb9DfYuiJpgFqmqrz5kSmJsn6Q3D6/aOHd3a31ugxVJkbf+L3+xWuE0OJBOrXqoBF2kEgr/Uck2SZW8YIOU1Qu7HtFq8X1cT7SgkAK+IWC/kRWUht6S/WVX99J1dyK76fkVMnO+OHetDgfoTYrDyD03pZ0Zd3ppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=YwecKXVw; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=fufiP/No; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724560991; x=1756096991;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=dPxybXlvHz3O8LDvjIG5RR6Lq9WCiAiYGU7pULvw8bs=;
  b=YwecKXVwQvLNm9TDgHUuYbgec2i9IGllPahnqwp1jyFssO0w2JuaaYAh
   4ihhLxx/IEAzMJRO9vlqqHOJ/ijwy6zeZdRPpxfvcpeU+dq8dDfJSeSuw
   Fx7CG5DLBMfZL3wjrZGYxsQNsFItQlQnowswt9UKJ1MzPDgZvzRz5uZR2
   PbPU0C7KseGWWfmaCnngy2q+rGUuQYseUG9+YH0IJlvirQfVg3ayzaghU
   YBwU6d3pHNN9y//3rD/gqq1VpcVbcrAIDcp/XMubHpfCtOJCCXKWbRkEz
   80nRLgcpwj4G+Hj0w8zAi6ZZobhokH+S6YTRembPI8Qwl3WYzKdJXRV/Z
   g==;
X-CSE-ConnectionGUID: VP8QQ0IQTJGYmtriOBRUKQ==
X-CSE-MsgGUID: EkOzSLgASiWN1F39qZd0mw==
Received: from mail-pg1-f199.google.com ([209.85.215.199])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 21:43:11 -0700
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7cd96715e6aso3560967a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 21:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724560990; x=1725165790; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OL+1qFcdm2Kl6M4VYgYSupH7pU7/Hky9GaaX52RzkKk=;
        b=fufiP/NoY9RHeEj+QF5/ikgoXpp7axnK0K8DYe835DrvADL1Os0PRYAohrOS7xNczk
         J0i8ngn8OlXM0i5fDO/ozFx5ESopDRBM+G91niBZ9UJJcmCpP85thfIIHAkm/uI3iUOp
         khh34Nkx0v42wUcoR6pJrbvMa7QwxivLW09M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724560990; x=1725165790;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OL+1qFcdm2Kl6M4VYgYSupH7pU7/Hky9GaaX52RzkKk=;
        b=NJB0o3n360cyUT3tCyqb+LE3KWAn1bMP3c1Va+NyYqT8IdLPDDCrU0UWGEI35EMgdG
         yXqITfEOOV3ORluaagz7i4OUedwXjxr96tMlrptfjzZ3tcZampc0U5Wj76omVYL8SLYr
         55G/j5GUIGyKz75naPObAM+4VP6fAxJd2V5W+UZeuYmtdhe+sI++tJaJ9MXkIDaTlAM2
         rUQof0jI3VkM+JKhQKNwJbBsR0cDHq2+0iVmTu8eck+k7GFzECLbm0y0dnR/Pmwh+4kS
         U/maOoRfZ5UKqty5lfTW5hdZYqL//gWtKeuNSGkcGg46OuagIW+F6ZLIyrJB5HeY3Ywh
         VIIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWD6Na5lXvB/QmhTmDbsp1UDkKrM/v52WjX0e8NYb3QHm7tnfITu0Wuhs7/YNsHfd5xks0Y4DNSZPAI8U0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3tpCHW28qFy36pD6o8orRtcOcIfoTYJeatUuVB8RIdTYZt+JH
	+V9AVljWvIBu4hBhp4jbB99Jk8y7XjHmGORAq7aEYHyetovoJnyoLdzV3XuatCWieI0wbmtFeGk
	Y6lZBsuiWjTpy11+12dfcgyRCdV5T2G/9CVW7mEspf1vcGcrwiGf01qmJlzdHnv5V5QgslO8V4v
	E2C3+c+4M6QEqGONBlFtrC49y9wpzA2QSvW0GVPg==
X-Received: by 2002:a05:6a21:8cc5:b0:1c4:919f:3677 with SMTP id adf61e73a8af0-1cc89ee58a7mr8591655637.42.1724560990409;
        Sat, 24 Aug 2024 21:43:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs+Vb7CoN7loeTOeBHj9EnWfT+G7B2k8bT3vcmBj+ASamWI7UuTSXudfJ9ypOE2QMSmOdDKa9eYTBvIbdTKm0=
X-Received: by 2002:a05:6a21:8cc5:b0:1c4:919f:3677 with SMTP id
 adf61e73a8af0-1cc89ee58a7mr8591644637.42.1724560989990; Sat, 24 Aug 2024
 21:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 21:42:59 -0700
Message-ID: <CALAgD-77-2pS6L2=xCKBLDpvQejExZ2jWLnOWRsd1whwRXKn_A@mail.gmail.com>
Subject: BUG: general protection fault in fib_rules_event
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shaozhengchao@huawei.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10. It seems like a null pointer dereference bug.
The bug report  is as follow:

Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 19006 Comm: syz-executor Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:detach_rules net/core/fib_rules.c:1231 [inline]
RIP: 0010:fib_rules_event+0x998/0xc00 net/core/fib_rules.c:1263
Code: 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 e0 8b 0a f9 4d 8b 27
4d 39 fc 0f 84 d1 01 00 00 4d 8d 74 24 10 4d 89 f5 49 c1 ed 03 <41> 0f
b6 44 1d 00 84 c0 0f 85 fe 00 00 00 41 8b 2e 48 8b 04 24 0f
RSP: 0000:ffffc90002e17548 EFLAGS: 00010202
RAX: ffffffff88e9d1bf RBX: dffffc0000000000 RCX: ffff88801c229e00
RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff88e9d15f R09: ffffffff88e9c7c7
R10: 0000000000000003 R11: ffff88801c229e00 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000010 R15: ffff888135ce6080
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555597f281c0 CR3: 0000000026ad2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 unregister_netdevice_many_notify+0xd65/0x16d0 net/core/dev.c:11219
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
RIP: 0033:0x7f1dd437f3fc
Code: Unable to access opcode bytes at 0x7f1dd437f3d2.
RSP: 002b:00007ffded2aa8f0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000003 RCX: 00007f1dd437f3fc
RDX: 0000000000000028 RSI: 00007ffded2aa9a0 RDI: 00000000000000f9
RBP: 00007ffded2aa94c R08: 0000000000000000 R09: 0079746972756365
R10: 00007f1dd45147e0 R11: 0000000000000246 R12: 0000555579f775eb
R13: 0000555579f77590 R14: 000000000008620e R15: 00007ffded2aa9a0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:detach_rules net/core/fib_rules.c:1231 [inline]
RIP: 0010:fib_rules_event+0x998/0xc00 net/core/fib_rules.c:1263
Code: 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ff e8 e0 8b 0a f9 4d 8b 27
4d 39 fc 0f 84 d1 01 00 00 4d 8d 74 24 10 4d 89 f5 49 c1 ed 03 <41> 0f
b6 44 1d 00 84 c0 0f 85 fe 00 00 00 41 8b 2e 48 8b 04 24 0f
RSP: 0000:ffffc90002e17548 EFLAGS: 00010202
RAX: ffffffff88e9d1bf RBX: dffffc0000000000 RCX: ffff88801c229e00
RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff88e9d15f R09: ffffffff88e9c7c7
R10: 0000000000000003 R11: ffff88801c229e00 R12: 0000000000000000
R13: 0000000000000002 R14: 0000000000000010 R15: ffff888135ce6080
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc95549118 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 48 c1 e8 03           shr    $0x3,%rax
   4: 80 3c 18 00           cmpb   $0x0,(%rax,%rbx,1)
   8: 74 08                 je     0x12
   a: 4c 89 ff             mov    %r15,%rdi
   d: e8 e0 8b 0a f9       call   0xf90a8bf2
  12: 4d 8b 27             mov    (%r15),%r12
  15: 4d 39 fc             cmp    %r15,%r12
  18: 0f 84 d1 01 00 00     je     0x1ef
  1e: 4d 8d 74 24 10       lea    0x10(%r12),%r14
  23: 4d 89 f5             mov    %r14,%r13
  26: 49 c1 ed 03           shr    $0x3,%r13
* 2a: 41 0f b6 44 1d 00     movzbl 0x0(%r13,%rbx,1),%eax <-- trapping
instruction
  30: 84 c0                 test   %al,%al
  32: 0f 85 fe 00 00 00     jne    0x136
  38: 41 8b 2e             mov    (%r14),%ebp
  3b: 48 8b 04 24           mov    (%rsp),%rax
  3f: 0f                   .byte 0xf


-- 
Yours sincerely,
Xingyu

