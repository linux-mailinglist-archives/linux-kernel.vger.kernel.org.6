Return-Path: <linux-kernel+bounces-305946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36FA9636C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A29A1F2211F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5C49474;
	Thu, 29 Aug 2024 00:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="idjxu4/r";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="xIIJwrRW"
Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10DA94F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890744; cv=none; b=OmUf/kssnMVicmEgSffw20G5hAiSqrCi8OGj6O3CydchT30KwTLcn16TXwN3WUUKJAa/Xf59xdUYNuhzERk4KMJIlUOTk3JxZjh2/uOOLAPrrxPhB7H1AK1FeF5gE7pbTJxZiozwSX+kc+iVPRir1Hgi1ZS5eNj8RjR19BqBbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890744; c=relaxed/simple;
	bh=91Qb4x2mE4Yov3OwOKgJwUXPPzemN7wt1wPPgSzydjM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mBYGLvrTiaNmQ2b3XGpRLkdWv5bdc2si+LHf6xDIi8orrLI2iDCp/qunpGD3hDBMdfq7GOkW8HjcKMmuhbX+vizB3T2p9UOtPb7+KMylodvICJKkdqNNv9P0+VuitGZnoND9Qxt2VW20T4tAQ4fOLIqzZOhFHv9UXd2bYFn+tM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=idjxu4/r; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=xIIJwrRW; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724890742; x=1756426742;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=91Qb4x2mE4Yov3OwOKgJwUXPPzemN7wt1wPPgSzydjM=;
  b=idjxu4/rK9usJjwaPBPaoM3a1IPsQXinZA7t2yiwJ1bsDfYWiorr3YSa
   KFCs2syGB7HNwlGpUrFrhkRGqKnY3NDPA3v0/S4UWQHCVPA1z+nfUyLoY
   aLngUqU1yjcYfDnC7lEMEw4HnlVbUpAg+zTtsjPyXVSjJW+2Qk93580hT
   FnurFIZmeJh35PRIX4JhU5/PIpBlZ9p9KuwCR5SSO0WIdY/IheYfe1bfF
   1t2OrfYz6+xiLk78ePEPzF++kEl+0kV+LkXwIQZJXq97pa3l6Er52Jzuk
   3jUC+AaaZ3l3LwaypT5hKiGWyLn5zVR1d2kQb2OSbncTezPZ6ursXaK0t
   Q==;
X-CSE-ConnectionGUID: pwmJjktyRFuV1/YcB2tPGw==
X-CSE-MsgGUID: O06vo491SgKyi6B91p5vcQ==
Received: from mail-il1-f200.google.com ([209.85.166.200])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 17:19:00 -0700
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d4c656946so336845ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724890741; x=1725495541; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=piY5vSxaAQrSvyrcWvXCTwg74AI3HDMUYVVmeZ6xPy0=;
        b=xIIJwrRWCG+mApCyI74TI1gNzlK0Xy7OVinbSRMo2swO3BXDc+ZVMcHsQ8QZSpBys9
         YECR1bOb8Z94uDrKviuNDAJtj6qDs7QgHYj0/RlttcTtL4NCJQDGfl6qcqrk5/9wv6fS
         k6dQz6xKKgYW6LQRAejUCmQ1TETarbjrDP+OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724890741; x=1725495541;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=piY5vSxaAQrSvyrcWvXCTwg74AI3HDMUYVVmeZ6xPy0=;
        b=QLMXWxIFANFtehiBzp+iPCJt6sBWtcOm/JSX6zalwB4ShE+O0Srec25vTlRMm4FDEL
         YYadh1UC3vJXMhg8qC9eOJo3RHsh5uU4b21lPywSp+JVCcc9mBvKLIpEZw0pX6FzCn3/
         BYob6z3gEt5gqaX6rcOfNMeSAMXzVMtKBuL3JlgLcoQB1pHrDMuZsgtx83C9YusM+VwK
         WsOrO2nKd4AkrOvJWNImQta1GIz/H2GoUf2jRjNwe4SNQZGuSDsPwWetgWeOJUk5iLeE
         DKw7s1Eu0SXwAG16Eq5zjtAhqua8+28Z/TPuSZXsWh0Iyg1EEz7fKLnLw3Red+ShofTA
         oPtg==
X-Forwarded-Encrypted: i=1; AJvYcCUe8XdOMAg06taIpgvPFtMRv5+BN9jnTIL63hgHyqx4NR++36RpdeSbm8nsycvhRZS9acnkH5mXGEB7hT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSyyZkxKaoZ+BYAvsU1NYhTriMJOLk/XYK3zN/KwHvbH7gbRg
	YNh26uRUeeyFmotSJ33B9XpAcAUYVd7ZYuwjVLCwkaRVDlLuwJJfF3ZoUZorT07LV+1HD2qr4IJ
	TkbBRd5NnICMq9tMMdcevHT90cMZp+tR2DbblfWgctzTWaYvl2empFZ6CT18+wgiAGaZgDYMm1x
	Uv/GoGHiwEPrJZELtLrMJBnB7qe/JM++JOs6CJyw==
X-Received: by 2002:a05:6e02:1845:b0:39d:25a2:7b6b with SMTP id e9e14a558f8ab-39f377d81fcmr17116095ab.1.1724890740833;
        Wed, 28 Aug 2024 17:19:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWYq9ZBxKYRX9NBDMJ96aE+ikB6HcOt5nHkpONM5r9OpzxpcBPlGUYVeP26HqnXu3IHCg4QoyYGUMCgjXQvj8=
X-Received: by 2002:a05:6e02:1845:b0:39d:25a2:7b6b with SMTP id
 e9e14a558f8ab-39f377d81fcmr17115955ab.1.1724890740512; Wed, 28 Aug 2024
 17:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 17:18:49 -0700
Message-ID: <CALAgD-4M6bv53fpWnb2vdu4kxnCe_7H3kbOvs3DBAd8DeRHYuw@mail.gmail.com>
Subject: BUG: INFO: trying to register non-static key in free_pgtables
To: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a
corrupted lock  bug.
The reproducer  is
https://gist.github.com/freexxxyyy/09beafefaba6bf750780dde92b97cab8

The bug report is:

Syzkaller hit 'INFO: trying to register non-static key in free_pgtables' bug.

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 8525 Comm: syz-executor118 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x23d/0x360 lib/dump_stack.c:114
 assign_lock_key+0x22f/0x260 kernel/locking/lockdep.c:976
 register_lock_class+0x285/0x9a0 kernel/locking/lockdep.c:1289
 __lock_acquire+0x186/0x8050 kernel/locking/lockdep.c:5014
 lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
 down_write+0x36/0x50 kernel/locking/rwsem.c:1579
 vma_start_write include/linux/mm.h:736 [inline]
 free_pgtables+0x458/0xbb0 mm/memory.c:403
 exit_mmap+0x435/0xa20 mm/mmap.c:3352
 __mmput+0x114/0x3b0 kernel/fork.c:1346
 exit_mm+0x207/0x2e0 kernel/exit.c:567
 do_exit+0x996/0x2560 kernel/exit.c:863
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1025
 get_signal+0x1697/0x1730 kernel/signal.c:2909
 arch_do_signal_or_restart+0x92/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x95/0x280 kernel/entry/common.c:218
 do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fc7391d323d
Code: Unable to access opcode bytes at 0x7fc7391d3213.
RSP: 002b:00007fff88ca0c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000002 RBX: 0000000000000003 RCX: 00007fc7391d323d
RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff88ca0ce0 R09: 00007fff88ca0ce0
R10: 002367732f766564 R11: 0000000000000246 R12: 00007fff88ca0c7c
R13: 00007fff88ca0ca0 R14: 0000000000000000 R15: 00007fff88ca0ce0
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x1, magic = 0x0,
owner = 0xffff888019e43c00, curr 0xffff888019e43c00, list not empty
WARNING: CPU: 0 PID: 8525 at kernel/locking/rwsem.c:1364 __up_write
kernel/locking/rwsem.c:1364 [inline]
WARNING: CPU: 0 PID: 8525 at kernel/locking/rwsem.c:1364
up_write+0x405/0x570 kernel/locking/rwsem.c:1632
Modules linked in:
CPU: 0 PID: 8525 Comm: syz-executor118 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1364 [inline]
RIP: 0010:up_write+0x405/0x570 kernel/locking/rwsem.c:1632
Code: 48 c7 c7 40 7b 4c 8b 48 c7 c6 20 7d 4c 8b 48 89 da 48 8b 4c 24
20 4c 8b 44 24 30 4c 8b 4c 24 28 50 e8 ef 98 e7 ff 48 83 c4 08 <0f> 0b
e9 c0 fc ff ff 0f 0b e9 34 fd ff ff 48 89 5c 24 30 c6 05 b8
RSP: 0018:ffffc9000b517660 EFLAGS: 00010296
RAX: fb8e9a7beeddf000 RBX: 0000000000000001 RCX: ffff888019e43c00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000b517738 R08: ffffffff8155a25a R09: 1ffff1100c74519a
R10: dffffc0000000000 R11: ffffed100c74519b R12: ffff888018f3eeb0
R13: ffff888018f3ee58 R14: 1ffff920016a2ed4 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056207a826098 CR3: 000000000d932000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vma_start_write include/linux/mm.h:744 [inline]
 free_pgtables+0x489/0xbb0 mm/memory.c:403
 exit_mmap+0x435/0xa20 mm/mmap.c:3352
 __mmput+0x114/0x3b0 kernel/fork.c:1346
 exit_mm+0x207/0x2e0 kernel/exit.c:567
 do_exit+0x996/0x2560 kernel/exit.c:863
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1025
 get_signal+0x1697/0x1730 kernel/signal.c:2909
 arch_do_signal_or_restart+0x92/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x95/0x280 kernel/entry/common.c:218
 do_syscall_64+0x8a/0x150 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7fc7391d323d
Code: Unable to access opcode bytes at 0x7fc7391d3213.
RSP: 002b:00007fff88ca0c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000002 RBX: 0000000000000003 RCX: 00007fc7391d323d
RDX: 0000000020000080 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff88ca0ce0 R09: 00007fff88ca0ce0
R10: 002367732f766564 R11: 0000000000000246 R12: 00007fff88ca0c7c
R13: 00007fff88ca0ca0 R14: 0000000000000000 R15: 00007fff88ca0ce0
 </TASK>




-- 
Yours sincerely,
Xingyu

