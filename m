Return-Path: <linux-kernel+bounces-300271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D195E1BC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33A51C211D7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98512AE68;
	Sun, 25 Aug 2024 04:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="JhqMlpCe";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jHQDM4CT"
Received: from mx2.ucr.edu (mx.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7EB282FB
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724561461; cv=none; b=edMZ0ZsI3YOn1fiym/Dg+fL5TDPbydJy3ZKi6pU5fRsUKoKJ/Up4J74O86/l+d8XxyyPnHhc9roM3EZgNV41suWGUFH36k6ngrcSouuFbgQOkE8tVcgmsEaVTAHxYIQt/nElGTmyZFTo+zsvNleEMVQSdMD768LZBR5B382lQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724561461; c=relaxed/simple;
	bh=yAmSmirlkH/7W/allKxd4WPwwoGltYch1feUUZwjY28=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Yi6gH6gz5rjTuzSZ5FlertbxSrMOwmdrvCouroEx4TdbzSG8B/vOBfoDsk5wRF3S9AhlvTFgbvBJSYDDp+iq+eGxL/QzI5XuvqBx2+f8HiyraM7Ry0+v/O96YLDubKBX6x4U5UrW7TZ1GWtV1x+a1k0A1dbDvo6EbfRHirRelAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=JhqMlpCe; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=jHQDM4CT; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724561459; x=1756097459;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=yAmSmirlkH/7W/allKxd4WPwwoGltYch1feUUZwjY28=;
  b=JhqMlpCeF7qzotf0uU5fpcFtbHwMceTIdVNlGQ4djuhQki0xdQwjj3gp
   R2NaDYeViUoSAKz0axozVw468Qf9OLbzBmMeS3eIGsIlN7GGUwF4hf6Yy
   SSqTbHhELZgb5UR7ZJs78APMU0dxgbUalDuhvpAVGnoQvvrH1gKXD/Xcq
   q8R0k1Kb3H1qrNQacdRFnz8Uz/3icuaeq40evgTajEey+EoVQChymniBi
   EvpwPajy+6UoYPXkQWg07C2XQLtvjU89nHTAMOV0vjX70koBcZ0/TeQgu
   6yl8uP9cawshrtCMsr63y1a9EozTODr5fYBtReGFDo5kgWT8cFJ4Pxdkf
   w==;
X-CSE-ConnectionGUID: KWkMR+z9R0e4V2YhOsTBOg==
X-CSE-MsgGUID: 5BAmIAt9QMmlcFV80K+B0A==
Received: from mail-pg1-f200.google.com ([209.85.215.200])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 21:50:58 -0700
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-778702b9f8fso2136358a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 21:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724561458; x=1725166258; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T++9W96RsDlequohJfEldzl31p8QMLYJ/2wM3xDcsJM=;
        b=jHQDM4CTbpSVpo7PGHAIMxVXDWWQw2B7K5FqmWNe3d9LU5CZOJm83rZPKUjCt5AUic
         9Q4wswfQfuQ9jRKQ8nflZviA69kOscnBbUNB/IBtN/0tZhry5YYKTtUHSpB6w7MDYkSb
         HWhiXskkSXCR3d2yxBHrP9lUwPwp2wl4fIFds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724561458; x=1725166258;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T++9W96RsDlequohJfEldzl31p8QMLYJ/2wM3xDcsJM=;
        b=ReJUpr8aV40zm5EWe4pLl1RcXMJeugwedjsVS5uovWVu8IH9K1Rn/8IeR+1sB4QTN9
         4SWvBnVfN9/YrcepNFw6c1O00+Ccj6p6WEL1WgWXIOp3sWrD3FeNubW+g0eFwoRx3Ihe
         SVYzrWcPFnR54OXh6UlaeIvxDrqpsPEAUbj67KCbuZbqyJX+B334KXbRqVHO4iuJ24b8
         sMX/cBTbERIl6CI9iV3Ja2VmX0fH61Nf/Vepm3wmZrgzYXnGWyLkfr4ytoPYAZZrugXg
         5HY73V6VERsvOKuRU0IVQsFuj5gSLkrDTYqMyu7t9csK0PWTCDmtp+dMKHRN63dcCXve
         /akw==
X-Forwarded-Encrypted: i=1; AJvYcCU9wnSlqvYZbD+zzsMHCG5pVROdg+gpacRrCEiSbc0WMulAIyUuHfQg26VdNbgznAboJrjJcThevWuGAFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOFQB65tDWpLx8Rfr1FpooDMyhy28czwqKX5i8hGWIaBXjoMG
	3YBE0i1i4jB20x7Fk1cIJsqZtly/MItSkQo9Q5FMZqZu4B1Jnx5JYz8h7g2o6gidIyVkLn/Avv8
	HlhrRWjWVPdQNstUjgp1RlGn5fgoWJf8TV1dEkaOGTihQc9p7JgRh7PMM+Iscb04K2XYNQJfXnC
	mPnE+QOnXZ91Y5DXv0RJ5zhy1U5MAn9GLz0O5O+g==
X-Received: by 2002:a17:90a:780f:b0:2c9:5a71:1500 with SMTP id 98e67ed59e1d1-2d6444b91aamr11471377a91.0.1724561457998;
        Sat, 24 Aug 2024 21:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB0vRxhsT9aVOUvwAsmyIuX4XlycmNKr2x2kfgtpGQEPh7nSWgPETybVUbLm8rOc8bR9S8KHF40mjpupvC5Ag=
X-Received: by 2002:a17:90a:780f:b0:2c9:5a71:1500 with SMTP id
 98e67ed59e1d1-2d6444b91aamr11471365a91.0.1724561457572; Sat, 24 Aug 2024
 21:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 21:50:46 -0700
Message-ID: <CALAgD-4F7g=Fqy0KL0t0SaZburRiENsnzm_CYbb8SzbAk1+8oA@mail.gmail.com>
Subject: BUG: general protection fault in hrtimer_try_to_cancel
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10. It is probably a null pointer dereference bug.
The reason is probably that in line 1615 of kernel/time/hrtimer.c,
before "seq = raw_read_seqcount_begin(&base->seq);", there is no null
pointer check for 'base'.

The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

bridge0: port 2(bridge_slave_1) entered disabled state
bridge_slave_0: left allmulticast mode
bridge_slave_0: left promiscuous mode
bridge0: port 1(bridge_slave_0) entered disabled state
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 0 PID: 29 Comm: kworker/u4:2 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__seqprop_raw_spinlock_sequence include/linux/seqlock.h:226 [inline]
RIP: 0010:hrtimer_active kernel/time/hrtimer.c:1615 [inline]
RIP: 0010:hrtimer_try_to_cancel+0x7c/0x410 kernel/time/hrtimer.c:1332
Code: 2f 12 00 48 8b 5c 24 10 48 8b 44 24 08 42 80 3c 30 00 74 08 48
89 df e8 02 3b 75 00 4c 8b 3b 4d 8d 67 10 4c 89 e3 48 c1 eb 03 <42> 8a
04 33 84 c0 0f 85 f4 00 00 00 41 8b 2c 24 89 ee 83 e6 01 31
RSP: 0018:ffffc9000080f7a0 EFLAGS: 00010202
RAX: 1ffffd1ffff88a14 RBX: 0000000000000002 RCX: 1ffffd1ffff88a15
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffc45070
RBP: ffffe8ffffc45070 R08: ffffc9000080f867 R09: 1ffff92000101f0c
R10: dffffc0000000000 R11: fffff52000101f0d R12: 0000000000000010
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f09772124b0 CR3: 000000001f978000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hrtimer_cancel+0x12/0x50 kernel/time/hrtimer.c:1447
 napi_disable+0x1b6/0x210 net/core/dev.c:6648
 gro_cells_destroy+0x12a/0x3d0 net/core/gro_cells.c:116
 unregister_netdevice_many_notify+0x10a5/0x16d0 net/core/dev.c:11239
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
RIP: 0010:__seqprop_raw_spinlock_sequence include/linux/seqlock.h:226 [inline]
RIP: 0010:hrtimer_active kernel/time/hrtimer.c:1615 [inline]
RIP: 0010:hrtimer_try_to_cancel+0x7c/0x410 kernel/time/hrtimer.c:1332
Code: 2f 12 00 48 8b 5c 24 10 48 8b 44 24 08 42 80 3c 30 00 74 08 48
89 df e8 02 3b 75 00 4c 8b 3b 4d 8d 67 10 4c 89 e3 48 c1 eb 03 <42> 8a
04 33 84 c0 0f 85 f4 00 00 00 41 8b 2c 24 89 ee 83 e6 01 31
RSP: 0018:ffffc9000080f7a0 EFLAGS: 00010202
RAX: 1ffffd1ffff88a14 RBX: 0000000000000002 RCX: 1ffffd1ffff88a15
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffe8ffffc45070
RBP: ffffe8ffffc45070 R08: ffffc9000080f867 R09: 1ffff92000101f0c
R10: dffffc0000000000 R11: fffff52000101f0d R12: 0000000000000010
R13: dffffc0000000000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563cd2cf2058 CR3: 000000001d166000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: 12 00                 adc    (%rax),%al
   2: 48 8b 5c 24 10       mov    0x10(%rsp),%rbx
   7: 48 8b 44 24 08       mov    0x8(%rsp),%rax
   c: 42 80 3c 30 00       cmpb   $0x0,(%rax,%r14,1)
  11: 74 08                 je     0x1b
  13: 48 89 df             mov    %rbx,%rdi
  16: e8 02 3b 75 00       call   0x753b1d
  1b: 4c 8b 3b             mov    (%rbx),%r15
  1e: 4d 8d 67 10           lea    0x10(%r15),%r12
  22: 4c 89 e3             mov    %r12,%rbx
  25: 48 c1 eb 03           shr    $0x3,%rbx
* 29: 42 8a 04 33           mov    (%rbx,%r14,1),%al <-- trapping instruction
  2d: 84 c0                 test   %al,%al
  2f: 0f 85 f4 00 00 00     jne    0x129
  35: 41 8b 2c 24           mov    (%r12),%ebp
  39: 89 ee                 mov    %ebp,%esi
  3b: 83 e6 01             and    $0x1,%esi
  3e: 31                   .byte 0x31


-- 
Yours sincerely,
Xingyu

