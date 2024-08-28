Return-Path: <linux-kernel+bounces-305921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F6A96366D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BE61C2281A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3D81ACDF3;
	Wed, 28 Aug 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="XTA7JFDa";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="EvPf0MM6"
Received: from mx-lax3-3.ucr.edu (mx-lax3-3.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FC1146A63
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888952; cv=none; b=ks5XAQSHF4ReRRCS4qg8u6i2l6NvZc89i/7jDY6/KCylzqYFf/jEf39e/OjOfTf028/RqnjrwmSt/lI4K1k7dPNwCKbsAF98zl4i7S1wkQgD+Mlq8G3/HcbKkWIkYe5asRRrtyNY8uYn3jDbCqSxGOmdcQ7G/XOTuFHy1q7DXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888952; c=relaxed/simple;
	bh=AcAyvAQL1nLbsXA1WfvjG41Jmv+mw3eUoA9oqVmzXW0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jqB3nX24B1OU8WQ4soL9rq+00DZ90veoD4c8BYFJbUFBKF3rHP2PhORFaRTgOQh1TTyQHB2u5baWkmxB5S6SVlOc4FC/0wisWHMpSTLEEW6oKSWnEIQPks1TRQmJHt7k6JrksCPEYksOy//8WkvFKk2G3KFvSSdPsFFvpq/ZrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=XTA7JFDa; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=EvPf0MM6; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724888950; x=1756424950;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=AcAyvAQL1nLbsXA1WfvjG41Jmv+mw3eUoA9oqVmzXW0=;
  b=XTA7JFDaol9RbFTGTgLNKr17Z3sJ2UiErUhgV1S9HgZ1esGIFySXLrxP
   gVcFrCGXFYn6aGsuax+ohX/DUvPOjnZeo9LqSLDcXb29aRZLcLdETr8yZ
   TayxIZRSgLbxvsvO4YbcjnD37/Ik/ZjGje/sQ8aa5o9blxXSF5C1DCAOb
   d5/R05MraMha35pPCJF85biVcUsx5PjFN36uFKbO8e4ZsTdpzeq22gCYL
   bc7YIw3EaxrzUdFSeCPDsY2WSWxn8p7i8v6A7OE6qY+NSKzPqtyGoyQiO
   1if33g7vR6MI6EZH5iH9XuM9RkWLxqPPmj1JTVFSgjfOgeYs90qUNylNY
   g==;
X-CSE-ConnectionGUID: xR65GZybRkGumeYQfS+BLQ==
X-CSE-MsgGUID: OdKTwouwQIqWOCOU7WZdPw==
Received: from mail-il1-f197.google.com ([209.85.166.197])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:49:10 -0700
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d2dbd9bebso230575ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724888949; x=1725493749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KBdAgVEL/PxHH0jYLTMrc38oVwY/87lzyjT/UDiKcM0=;
        b=EvPf0MM6m90IZGbAuNKIKLzIVXRR2RBfsRbbJy8Ng7+rDFLrBLzlRyAFUllPV3Rxis
         H+gBIMmK3Ve1SbNk0JNzDGTGtOLnCz3BXWIkV41NqOqptv6Reux0eUThRflCLlbJ0Nyh
         Py/FUmVLAJnJ4Wd1VzVsmQ0WmCqebzaciU4mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888949; x=1725493749;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBdAgVEL/PxHH0jYLTMrc38oVwY/87lzyjT/UDiKcM0=;
        b=ovMlUljBqsHLgjH02WDoMstw6gMhe08gJYnkWQ1HEqTaN/qeHhMt/mPNF8ZYEKl3Y8
         NyBz0hode4K5l8GvDITg9BB0NQ2kNd96i3oTRny5yDj6n8GN+k8nwbJ5m59Fcsx7FhMR
         j/+/GfXj9ac+0PPPvNa5DCI8AyhmecywzlFPj8j6S0wRhtJ2YR7RmhOBAPwZKCYLhST4
         fVIqBEJ0eWMZ6eQ40vnpJMcJ1ebN9lNqg90w9wLVt2KLQMbFk86C9j6yi+ixbOhIeWBF
         JSW3Dlm0Kfqu1JMtyF9odm0J0cJaTQyRU/VMGkqotQaN/AmOGFdI6Tw88OUO992bQtyP
         St4g==
X-Forwarded-Encrypted: i=1; AJvYcCXpyEvCkbmPdeZvwEKIuuHMcUSGAFES/Mie0vVSK1Px5zeK1O4U2JziZMBd2nHtIEcsqVc0dt2WJbaJgVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbfMSEx3Ih5joJuoe5zIQEzVoAJffl1j5jdGXJvjOrW/Cio4k
	25IxYyqBFCYwaG822zzEtFCJoThYIV3XrvS4e9jLX6a2aEQWA5Nb2HOhubqCyxFs8diBmc736xO
	LzjiwQ8U5d8gLuTZo84MsbSQcsGxiNFycogLw71+hoCuH6FnAd0GW12Lq6Wi1ads6yrpEK2kyOa
	E+fzqfqtCzp3tUEXdDWW2vI6pYU6RMTx+k7UAloA==
X-Received: by 2002:a92:cd8a:0:b0:39a:e9ec:9462 with SMTP id e9e14a558f8ab-39f377ce440mr17839075ab.5.1724888948961;
        Wed, 28 Aug 2024 16:49:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT02Dd/vrS1nYT8EZngSFnQLhrE6+0ATV/7vfZyoBL3hDTW+LK974tD3OhkSXka/m7lKU4MCEd3Sq/gCgP2LU=
X-Received: by 2002:a92:cd8a:0:b0:39a:e9ec:9462 with SMTP id
 e9e14a558f8ab-39f377ce440mr17838955ab.5.1724888948670; Wed, 28 Aug 2024
 16:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:48:58 -0700
Message-ID: <CALAgD-72YS4AYHcKNegajDoehaqYQEfHFhtxPb2s8y=A0jXDag@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in bcmp
To: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a page fault bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

BUG: unable to handle page fault for address: ffffffffffffffe0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD d936067 P4D d936067 PUD d938067 PMD 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 8474 Comm: kworker/0:5 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events nsim_fib_event_work
RIP: 0010:memcmp lib/string.c:665 [inline]
RIP: 0010:bcmp+0x50/0x1e0 lib/string.c:697
Code: 00 00 4d 89 fd 4c 89 e3 48 8d 6b 07 48 89 d8 48 c1 e8 03 0f b6
04 10 84 c0 75 65 48 89 e8 48 c1 e8 03 0f b6 04 10 84 c0 75 7b <49> 8b
34 24 49 8d 6d 07 4c 89 e8 48 c1 e8 03 0f b6 04 10 84 c0 0f
RSP: 0018:ffffc9000fb57520 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffffe0 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: ffffc9000fb579a0 RDI: ffffffffffffffe0
RBP: ffffffffffffffe7 R08: ffffffff869e3a06 R09: ffffffff84569d43
R10: 0000000000000003 R11: 0000000000000000 R12: ffffffffffffffe0
R13: ffffc9000fb579a0 R14: 000000000000001c R15: ffffc9000fb579a0
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffe0 CR3: 000000004521a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rhashtable_compare include/linux/rhashtable.h:585 [inline]
 __rhashtable_lookup include/linux/rhashtable.h:610 [inline]
 rhashtable_lookup include/linux/rhashtable.h:646 [inline]
 rhashtable_lookup_fast+0x51b/0x9a0 include/linux/rhashtable.h:672
 nsim_fib_rt_lookup drivers/net/netdevsim/fib.c:271 [inline]
 nsim_fib6_rt_lookup drivers/net/netdevsim/fib.c:594 [inline]
 nsim_fib6_rt_insert drivers/net/netdevsim/fib.c:757 [inline]
 nsim_fib6_event drivers/net/netdevsim/fib.c:856 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:889 [inline]
 nsim_fib_event_work+0x28ca/0x4050 drivers/net/netdevsim/fib.c:1492
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: ffffffffffffffe0
---[ end trace 0000000000000000 ]---
RIP: 0010:memcmp lib/string.c:665 [inline]
RIP: 0010:bcmp+0x50/0x1e0 lib/string.c:697
Code: 00 00 4d 89 fd 4c 89 e3 48 8d 6b 07 48 89 d8 48 c1 e8 03 0f b6
04 10 84 c0 75 65 48 89 e8 48 c1 e8 03 0f b6 04 10 84 c0 75 7b <49> 8b
34 24 49 8d 6d 07 4c 89 e8 48 c1 e8 03 0f b6 04 10 84 c0 0f
RSP: 0018:ffffc9000fb57520 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffffe0 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: ffffc9000fb579a0 RDI: ffffffffffffffe0
RBP: ffffffffffffffe7 R08: ffffffff869e3a06 R09: ffffffff84569d43
R10: 0000000000000003 R11: 0000000000000000 R12: ffffffffffffffe0
R13: ffffc9000fb579a0 R14: 000000000000001c R15: ffffc9000fb579a0
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffe0 CR3: 000000004521a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 00 00                 add    %al,(%rax)
   2: 4d 89 fd             mov    %r15,%r13
   5: 4c 89 e3             mov    %r12,%rbx
   8: 48 8d 6b 07           lea    0x7(%rbx),%rbp
   c: 48 89 d8             mov    %rbx,%rax
   f: 48 c1 e8 03           shr    $0x3,%rax
  13: 0f b6 04 10           movzbl (%rax,%rdx,1),%eax
  17: 84 c0                 test   %al,%al
  19: 75 65                 jne    0x80
  1b: 48 89 e8             mov    %rbp,%rax
  1e: 48 c1 e8 03           shr    $0x3,%rax
  22: 0f b6 04 10           movzbl (%rax,%rdx,1),%eax
  26: 84 c0                 test   %al,%al
  28: 75 7b                 jne    0xa5
* 2a: 49 8b 34 24           mov    (%r12),%rsi <-- trapping instruction
  2e: 49 8d 6d 07           lea    0x7(%r13),%rbp
  32: 4c 89 e8             mov    %r13,%rax
  35: 48 c1 e8 03           shr    $0x3,%rax
  39: 0f b6 04 10           movzbl (%rax,%rdx,1),%eax
  3d: 84 c0                 test   %al,%al
  3f: 0f                   .byte 0xf



-- 
Yours sincerely,
Xingyu

