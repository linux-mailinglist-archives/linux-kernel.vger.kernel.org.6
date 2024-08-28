Return-Path: <linux-kernel+bounces-305860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5802C963558
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BD61F24B92
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240261AD9FA;
	Wed, 28 Aug 2024 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jc5R3yt0";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="NZQlUj9m"
Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50B1AB513
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887531; cv=none; b=fvD/FNAcQJvosm36m56Ee0D/tizDf25Cf2VIo6JEq8Fhbxh3TrlK6wOxj6vztvwQcLSfzNl0Dpl+lswWjwCndFRFx9+V4QQm4KbQSS42OAC+JRAWELqSl3M93Uf+Y4WDPN7ulCQKiaYShZ1g9q+LE7dHF863Ripg5eYkJRgvX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887531; c=relaxed/simple;
	bh=oJbF2yz6XR8no4LjrJBbFrwVIWCRKWaFqfVTjpDN7nQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Z8SOq0V0Md4TryAUlAomWZTq6f5I7OIppPNv0QurL0ZJF1/6MT4mZVMgs9FVyUWddfzPguOXBMSdhZgxpNcOUQpjFnkI7JX/7jJ9JhU+U3LZZZazFAZU5RtT9hEMCqLkXIwZG7flNOCJwSkP7c57Vp/czzwM5OLDYk4gnEaYJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=jc5R3yt0; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=NZQlUj9m; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724887529; x=1756423529;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=oJbF2yz6XR8no4LjrJBbFrwVIWCRKWaFqfVTjpDN7nQ=;
  b=jc5R3yt0kIekwePDeFvBwi4WeSHehiyT5YIJujXpzy3+RIBB+d/y7XZL
   SDyK1ISb0vI8CMBtXRkhWnvsZNihDBS4bs5MyQPVGPlE7OPZTRF18Jpbo
   jsnbtvjpN5labL3W9Rb06efk5JhDfvS9Uq8sPUAFO1tlT2KCUeo8nvmKt
   4Ld6s46fgWt6L8xPs5Ssd8RilDnSJl4wFYRYpt34rpR/I8MaSOID8jr/f
   bssovAld3H4vDrG+jWFXvZygczoNLMdmARiNq6wIylXSQVUu0ZkqDUiKU
   tR4Bxp1Mk9GJpHsy5JqNQfwNkDqjJQhc2VNz0RkM8otG7gPuNsgMp5kCU
   w==;
X-CSE-ConnectionGUID: vVfL6YzPRdOz/3J84J1lmg==
X-CSE-MsgGUID: 7GFArnOJQ0uyrvs1C7p8Xw==
Received: from mail-il1-f199.google.com ([209.85.166.199])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:25:28 -0700
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d5537a62dso94911405ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724887528; x=1725492328; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9TgNRra2oIKkfCSIvqDpzSvQIQZPPLVaclRfYyTQtO8=;
        b=NZQlUj9mqAbfECXA67oQyA9aa4ZbKJDbnEO3sT1/uQXJfFvkbqkBpGBAm7Oc/2W7Y5
         pVMKr0KBkvCTx8rKRNHE0nOliVXzPdMMBBlpB2Ke88w0dJVQPRcMTD837k+LmHXYD7G/
         wCSN7a1dbuD/QVW6wBixPBo85Mv5sT7JPN4/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724887528; x=1725492328;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9TgNRra2oIKkfCSIvqDpzSvQIQZPPLVaclRfYyTQtO8=;
        b=QuD2xzqO6rpYdnCCVV4GAqUcAXSHeVIM25LK9dn9Pr75MkzYlpspB1/8NvmxXriScq
         TTGOJ8omjO40NvrHX0vyf+xzJlHgvjZV9Jtlqp8iJrMIH2JhJqJ/i5S/jPqGJTJSMT1K
         U6R4410uzURhXBGSIcKO7EFNBQ5Pz1uMvWFRtm2AWhGDhSCp3/lfWU+jAYtPpYVWdaNi
         c+3lDSE5cjnGikVyLuEntYNWQGXlGeIMCOTUT2Q6coLyzbghZHty37S+fBlHae7HvMFP
         DE3mJdUHpfNSu+kep0AhlHecR7OXE1RpDH881Kl+j5JRFtKTfuVUYLo8s8q6TTs0J6zR
         O65A==
X-Forwarded-Encrypted: i=1; AJvYcCXYeDVgKuk34MQjj5SRX52zixT3ehVPkhyt5IUENrqKzIe2bVTobqxPn3iIRd1DzOs4uD6RKJU4H0SH5zE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3SIAQryi4LXj+oEucyKPjP2S5fgzSG4ar/gpCjOvt32lMcWg
	e0G8AEpffwHjVmz9ucd5K261gbNfUwRQZ8lYn+qvjDBpWJq4mMS92ubRn5wYZcmn767+2S/D08d
	GdL3HnC+F/IGNQ7V/Vbd7gRJWV933CYfpidpmaUFaBB0Ccc+ppfbMe+eaRBLT0GxmAnx8CU4pCt
	AQUtT6iIRMBCIMBiFQNXfy9qojKdE+CqNq8TR7ZA==
X-Received: by 2002:a05:6e02:1607:b0:374:a781:64b9 with SMTP id e9e14a558f8ab-39f3780c6f7mr17892505ab.13.1724887527956;
        Wed, 28 Aug 2024 16:25:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZpomsO4U4P4+X/daIZV8LmqaPsEjkXqqXqxOoU1A5UEMoG2TwRI99kOvL4QwpAl0fPDi/Q5XlxPxqG4tIXWM=
X-Received: by 2002:a05:6e02:1607:b0:374:a781:64b9 with SMTP id
 e9e14a558f8ab-39f3780c6f7mr17892305ab.13.1724887527646; Wed, 28 Aug 2024
 16:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:25:17 -0700
Message-ID: <CALAgD-4r853VgJpUqfzuOrp1BnCEmpU7csCaUBfsCHfeJenqgg@mail.gmail.com>
Subject: BUG: general protection fault in __igmp_group_dropped
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

bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 28284 Comm: kworker/u4:15 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__igmp_group_dropped+0x9e/0x870 net/ipv4/igmp.c:1295
Code: e8 c7 52 19 f8 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89
ff e8 d1 5d 7c f8 4d 8b 37 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 80
3c 28 00 74 08 4c 89 f7 e8 b3 5d 7c f8 bb 18 01 00 00 4c 89
RSP: 0018:ffffc9000925f620 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888017ff1800 RCX: ffff888042a10000
RDX: 0000000000000000 RSI: 0000000000000cc0 RDI: ffff888017ff1800
RBP: ffffc9000925f708 R08: ffffffff88db7a02 R09: 1ffffffff1dabe04
R10: dffffc0000000000 R11: fffffbfff1dabe05 R12: 1ffff11007978487
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888017ff1800
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005647db0853f8 CR3: 0000000043c92000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 igmp_group_dropped net/ipv4/igmp.c:1332 [inline]
 ip_mc_down+0xfd/0x340 net/ipv4/igmp.c:1741
 inetdev_event+0x2e3/0x1590 net/ipv4/devinet.c:1619
 notifier_call_chain kernel/notifier.c:93 [inline]
 raw_notifier_call_chain+0xe0/0x180 kernel/notifier.c:461
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 dev_close_many+0x352/0x4e0 net/core/dev.c:1585
 unregister_netdevice_many_notify+0x542/0x16d0 net/core/dev.c:11194
 cleanup_net+0x764/0xcd0 net/core/net_namespace.c:635
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__igmp_group_dropped+0x9e/0x870 net/ipv4/igmp.c:1295
Code: e8 c7 52 19 f8 4c 89 f8 48 c1 e8 03 42 80 3c 28 00 74 08 4c 89
ff e8 d1 5d 7c f8 4d 8b 37 4c 89 f0 48 c1 e8 03 48 89 44 24 28 <42> 80
3c 28 00 74 08 4c 89 f7 e8 b3 5d 7c f8 bb 18 01 00 00 4c 89
RSP: 0018:ffffc9000925f620 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888017ff1800 RCX: ffff888042a10000
RDX: 0000000000000000 RSI: 0000000000000cc0 RDI: ffff888017ff1800
RBP: ffffc9000925f708 R08: ffffffff88db7a02 R09: 1ffffffff1dabe04
R10: dffffc0000000000 R11: fffffbfff1dabe05 R12: 1ffff11007978487
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff888017ff1800
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005647db02e058 CR3: 000000003c91c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: e8 c7 52 19 f8       call   0xf81952cc
   5: 4c 89 f8             mov    %r15,%rax
   8: 48 c1 e8 03           shr    $0x3,%rax
   c: 42 80 3c 28 00       cmpb   $0x0,(%rax,%r13,1)
  11: 74 08                 je     0x1b
  13: 4c 89 ff             mov    %r15,%rdi
  16: e8 d1 5d 7c f8       call   0xf87c5dec
  1b: 4d 8b 37             mov    (%r15),%r14
  1e: 4c 89 f0             mov    %r14,%rax
  21: 48 c1 e8 03           shr    $0x3,%rax
  25: 48 89 44 24 28       mov    %rax,0x28(%rsp)
* 2a: 42 80 3c 28 00       cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f: 74 08                 je     0x39
  31: 4c 89 f7             mov    %r14,%rdi
  34: e8 b3 5d 7c f8       call   0xf87c5dec
  39: bb 18 01 00 00       mov    $0x118,%ebx
  3e: 4c                   rex.WR
  3f: 89                   .byte 0x89




-- 
Yours sincerely,
Xingyu

