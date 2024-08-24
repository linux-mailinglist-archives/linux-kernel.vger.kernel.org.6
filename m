Return-Path: <linux-kernel+bounces-299830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3000995DA85
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210411C219E4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE49922309;
	Sat, 24 Aug 2024 02:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="C3t5P0YD";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Bv0j1h/r"
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E583182B4
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465518; cv=none; b=sXnvsoPsWSBjcF0wClqnRl5iSg99zeYcWbhmrXxWuwSbAOCef8n8PADUPWiINMEKmLMUhSstcNB/ZK+qFYfSFs5CSV2hAwwuKxezgF6Q8cVgQapVeCzOiGEO3u2KMkkmeKVVePphJNAv4CpIReSiz45zSotvHDRC1CniHI7tJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465518; c=relaxed/simple;
	bh=934wDLlbm1PZ0ERQdFU8JnT0iLloEeAIYa1GS0wifCM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=USvyrdM2cM/zVt/SE5MWJ9bLqpwOUOG5tsunyxEcMpVdPBFrLAHduwHiYdJ9osR1n1FBcD/b8sJmzXNz4nO6RIYaOpes926NOqwnFfp49jkIBWcdqlAerPMsEVc3wi1ANGIxnIgOUNDjluDLFKdPCebyi4gCC0jOrF4Vs94XIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=C3t5P0YD; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Bv0j1h/r; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724465517; x=1756001517;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=934wDLlbm1PZ0ERQdFU8JnT0iLloEeAIYa1GS0wifCM=;
  b=C3t5P0YDe3IHqIqSUkS3GmA7gZa1tW3KIk7PIHQmEb/7h+abIebgMkKG
   Trd8Tdcv0igiQuCzG1DEEvAOlnbMU0APvExlf6YFtslYbjXr0xZON1FoO
   21PA3sMxN7QbqeyIMI2rEMBPVmBKGeoWya218PCdC63hYu8TTP+nIVcTv
   9eKb0x8WmRRTz0DNgKe0kqEmMKpfz2p76InN3Rs/Y3wY+AKHjuzAFKkQi
   Suoh5iBT+Z6lec2IS0fuGOdmt1TWEkpp++SKGCrQNdDXwn9kzRmXBasiQ
   GL9DE+yZQG1kvvM+a9fwWV8egsGq6mGTcU6s4iLw/ET3rw7wZdstbcRBf
   Q==;
X-CSE-ConnectionGUID: FhkCXYsrT5SL8/1hMV5lrA==
X-CSE-MsgGUID: KhY6YMpJQNSZltano8ybxA==
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Aug 2024 19:10:47 -0700
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3e42ef677so2633796a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724465446; x=1725070246; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hDIrJj0PVJOEFwwnt6IKXzIuX6NBvsz+s/TaAofkIyc=;
        b=Bv0j1h/rue0QUczeVN0g63Sgxqpm+bzQdJtXodNyankkIiDjXFBf5/wC23cqnzfy7J
         qyBo5HJ52dW6Yho5925m0IfIkEX4jy3sWOW2wxxkctyvJkfk4fRvZAO6tJWO8QjgiQs0
         +WTOE0q4KSutBhixsW3eP/ryweAhMDy6zdpo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465446; x=1725070246;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDIrJj0PVJOEFwwnt6IKXzIuX6NBvsz+s/TaAofkIyc=;
        b=USzqfuShGCqPLnAx6EBuYFB5MLdiBuARvcYF2KODI1rrrOVu8n0F3Dx1bkOj54aunU
         Krujetccw2K6dAgW4WWxkAKmdZAzXPeId5hFENIj1lqyt+KNuevIbOn0NaYBx/wRAi7R
         bCcU0Rv0/cCdfw7fsERzSFem1/HKmDbAAyTaCYZrVuDhPPBwHfXbJGc7oEkIL2sMgeEA
         TZr5oKgnqNJ7hVD2ra9/129vpwOcTGde0/H3XlzyJKJgmcqajOpGERjQDG2cbcttX5lT
         RKkTJMux1BIUynlHFaSfG6ZeTOGeb7NBSfO5EFKue4iADbYGxat0tPf35SrQxzhc/vCR
         d4cg==
X-Forwarded-Encrypted: i=1; AJvYcCVZE7Jvq49+LTSmZ0WFU+toUz844TWxwmnyZmssMgBl0HoY1f2xEGzX0P2imajvohOg4vFW+YfeGc890UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo3HJcJEe0HD5PmWjeujqrq2CcrtGWa35JPvzmoH+lgaPUcjeT
	2PTvZufqQevnFOQc8aX2WqEXwz+rXkXGQRrjJpLjRlxBMiB6KXfNB74ANZGujNAILS8YqQ9xLKe
	Yzs8gf9nvuvE1m2gmcRGk4H/Mb0i7Tt8jUzRFaTWS20kQ6fxOafMsDOebVln94Fxldxp38xLoT3
	FomsNC2uY6absPKBiRbWK9dW5z6jn32kzmBPKLOw==
X-Received: by 2002:a17:90a:98b:b0:2c9:888a:7a7b with SMTP id 98e67ed59e1d1-2d646c197eamr4385869a91.25.1724465446048;
        Fri, 23 Aug 2024 19:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsIgUPSD5q07XNG9vDNuDdezYBTm9lI7+ddhPDbH3O0UBrChnntO5SEpI/JxOX0KFRc2CcrsxDrxALy8nSTM0=
X-Received: by 2002:a17:90a:98b:b0:2c9:888a:7a7b with SMTP id
 98e67ed59e1d1-2d646c197eamr4385859a91.25.1724465445682; Fri, 23 Aug 2024
 19:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Fri, 23 Aug 2024 19:10:34 -0700
Message-ID: <CALAgD-58VEomA47Srga5H-p6cZa0zPj+y3E1se0rHb3gj4UvyA@mail.gmail.com>
Subject: BUG: general protection fault in batadv_bla_del_backbone_claims
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

We found the following issue using syzkaller on Linux v6.10.

It seems to be a null pointer dereference bug
Need to check the `fi==NULL` before 'fi->fib_dead' on line 1587 of
net/ipv4/fib_trie.c

The bug report is:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000008: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 0 PID: 9032 Comm: syz.0.15 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:fib_table_lookup+0x709/0x1790 net/ipv4/fib_trie.c:1587
Code: 38 f3 75 4c e8 38 b9 15 f8 49 be 00 00 00 00 00 fc ff df eb 05
e8 27 b9 15 f8 48 8b 44 24 20 48 8d 58 44 48 89 d8 48 c1 e8 03 <42> 8a
04 30 84 c0 0f 85 76 03 00 00 0f b6 1b 31 ff 89 de e8 df bb
RSP: 0018:ffffc90004acf020 EFLAGS: 00010203
RAX: 0000000000000008 RBX: 0000000000000044 RCX: ffff88801db88000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004acf170 R08: ffffffff897b97ee R09: 1ffffffff221f8b0
R10: dffffc0000000000 R11: fffffbfff221f8b1 R12: 1ffff11003b1bbe6
R13: ffff88801d8ddf20 R14: dffffc0000000000 R15: ffff88801d8ddf30
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0cfb3b48d0 CR3: 000000001811e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __inet_dev_addr_type+0x2e9/0x510 net/ipv4/fib_frontend.c:225
 inet_addr_type_dev_table net/ipv4/fib_frontend.c:267 [inline]
 fib_del_ifaddr+0x1114/0x14b0 net/ipv4/fib_frontend.c:1320
 fib_inetaddr_event+0xcc/0x1f0 net/ipv4/fib_frontend.c:1448
 notifier_call_chain kernel/notifier.c:93 [inline]
 blocking_notifier_call_chain+0x126/0x1d0 kernel/notifier.c:388
 __inet_del_ifa+0x87a/0x1020 net/ipv4/devinet.c:437
 inet_del_ifa net/ipv4/devinet.c:474 [inline]
 inetdev_destroy net/ipv4/devinet.c:327 [inline]
 inetdev_event+0x664/0x1590 net/ipv4/devinet.c:1633
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
RIP: 0033:0x7f38fcb809b9
Code: Unable to access opcode bytes at 0x7f38fcb8098f.
RSP: 002b:00007ffca268d598 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000002 RBX: 00007f38fcd45f80 RCX: 00007f38fcb809b9
RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f38fcbf4f70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f38fcd45f80 R14: 00007f38fcd45f80 R15: 0000000000000d01
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fib_table_lookup+0x709/0x1790 net/ipv4/fib_trie.c:1587
Code: 38 f3 75 4c e8 38 b9 15 f8 49 be 00 00 00 00 00 fc ff df eb 05
e8 27 b9 15 f8 48 8b 44 24 20 48 8d 58 44 48 89 d8 48 c1 e8 03 <42> 8a
04 30 84 c0 0f 85 76 03 00 00 0f b6 1b 31 ff 89 de e8 df bb
RSP: 0018:ffffc90004acf020 EFLAGS: 00010203
RAX: 0000000000000008 RBX: 0000000000000044 RCX: ffff88801db88000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90004acf170 R08: ffffffff897b97ee R09: 1ffffffff221f8b0
R10: dffffc0000000000 R11: fffffbfff221f8b1 R12: 1ffff11003b1bbe6
R13: ffff88801d8ddf20 R14: dffffc0000000000 R15: ffff88801d8ddf30
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2a89116b60 CR3: 00000000202c2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


-- 
Yours sincerely,
Xingyu

