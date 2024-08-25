Return-Path: <linux-kernel+bounces-300272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D9D95E1C0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A7E1C211A0
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826262AD16;
	Sun, 25 Aug 2024 04:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="bci4kPhw";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="s2MKuzHs"
Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A62F46
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 04:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724561622; cv=none; b=GejXsZszD9i5UKDP9dgQ1j8zA9PaJpjRT4te/tA5ZpPHvnr1z5sgyRaxVyCh7n0vN7zkxlfVKFRty9kN6xokf10MZ+8V+mEGYE1fBd4b2wWxgEqnn2A4MGmGvBJ5fFOCiUgSnLRgRYACQYp7Y0/wshfrzJj9qskxX6L0RmY2lgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724561622; c=relaxed/simple;
	bh=dvHLZaQL9cWEEHXAwWUKQI/gHPoikJJZLlLpQE+aPBQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=B4TGYfHcc4QPAFohEcWi7dI7XYxJ/1GXVafTvntUXEa8uKlxiVfvYi/sb5d4pHEdGyzdDuw59+WmGeiDClSAPDtscp6EgsPh8VCmRhnDrTDca+eMdtqn9pqm7qtizG9FbSIhV4HnEQPHQJ/nsAdVt7DKLdCF5uCQS40JNADI9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=bci4kPhw; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=s2MKuzHs; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724561621; x=1756097621;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=dvHLZaQL9cWEEHXAwWUKQI/gHPoikJJZLlLpQE+aPBQ=;
  b=bci4kPhw/gbXmwBd2Lv73IVUYiYEoNgbXgn8FCbwzYXvt1/hLRbXZzda
   eEKOkYcSG8HIKapUZTxzgCOUEoHmVJCmnE7OZVOArCvnHSDj9+XGeZPhm
   vp25BIc6NOb+yvDqeW1WVKlXgH13wNJQ9639ALh6Ge8Ix2n5GuaFs6obk
   K0R2NY9nHX55SxTfY/ept0+1u7Ls4WDi3D21nJzX+mqQJW+U7CSMx+YHw
   tJ1JDcEiDgxl9QeH0bpMs0IM93rByYl1wb1XjblEnQl3k6s6uQb7Qp1sN
   AXqLMs1uIgzhu+4QyHc2rumSnYMK8ZRLRUsMXBpzfk/FjJoKMCKFUqCcU
   w==;
X-CSE-ConnectionGUID: dVDr+M1NQBC0aoEhqcYeGA==
X-CSE-MsgGUID: 2HU4dWFGTliGoohfbrhT/Q==
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 21:53:40 -0700
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d699beb77cso192393a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 21:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724561620; x=1725166420; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ue8uVudDrEMPKrv9pJbfYq7VvUlsCSZcasiVyX+NGWU=;
        b=s2MKuzHsNOBr3jSBEBw6HhaUEdOQEEAbxnbfrgEzn4zGJ6qxwypLkD2jRqp99W4ury
         SNUtQiaQAExZZ/rhQduhFzYItBkGyTHn++bSGzM0bp9tYBG4zlTzHVDaYkILXhmz4mlG
         l+Au9HKvbDMIAIPhgRFhza4RH9zkj1boeEduw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724561620; x=1725166420;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ue8uVudDrEMPKrv9pJbfYq7VvUlsCSZcasiVyX+NGWU=;
        b=wTvSZAlZWwyN+lli1iXmvNihpXlJ3sLIWCtfXCYSsPPgYmnW/YhmpWmskXkU56B7m5
         IUsTvvJZMRxHXvMO+Mxm8CHKKSFKLSLlrMnFXxT4eSe0jJMKMOqP7GVbTPx0SHwBWjKd
         158wdYYTqj7YlK3lCDIcHuIF4aNm5FWZ+U2Jt/ibmLDDuuWIgKWOjtxPrzX7ZAE8WDqz
         PjfTaZg68ChMT+yc3froyZ8IIfhYYQ3ZJhxGYD80ewCSWUsDCL+DSyyzaaCWtMVPr4Eh
         wId9hOSBCQeA1b+7caFbrDJj7eovOaW421xoH84XfPYoy8AwjKnVf4jcQ5uhdg/EwdL+
         32Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUwQXUNfGu3oDsABamkch3/WMgDbUOCZCSkgQqhfw/ZE8dVJF0ZwTCS2qDlbFdzFHrixlmZscAVlXImXgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0ornhKbLLm2uZMOQnsqJcMh0eNC3UD74lC0D2GUcBm3E8TJh
	Yg5uKQxFo2zwlrmX8zB9M30XWlndHFYsLnTK0uicq0n8uAaWK1fFKk22OE8es2RNgQg4/Ii6tdC
	0xjVNH9A1UPhQ37x/Dyw87/SXDJNiMHGF6Njht3qci47Y5ljiVBW7ZAigC34ogjPaLKP5KxIRsr
	kE5kH5wtRekUl0p8t+U6A36iJYB7CRg7gJV/+rHw==
X-Received: by 2002:a17:90a:67c6:b0:2cd:55be:785a with SMTP id 98e67ed59e1d1-2d646bd1a7emr7676807a91.1.1724561619981;
        Sat, 24 Aug 2024 21:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzcT+rZFWNEHXAjRXfpAjYLFPZAJg3AM7wLQISqLQWGOkqWJBXAV97mLG1El1fvN2nL55Ippv61SgxzvI8K2A=
X-Received: by 2002:a17:90a:67c6:b0:2cd:55be:785a with SMTP id
 98e67ed59e1d1-2d646bd1a7emr7676793a91.1.1724561619660; Sat, 24 Aug 2024
 21:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 21:53:29 -0700
Message-ID: <CALAgD-6=bRtF++chjMwgTyMssCqyPzhXyY=zjB6w5SorVxuCcw@mail.gmail.com>
Subject: BUG: general protection fault in kernfs_remove_by_name_ns
To: peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	longman@redhat.com, boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in linux 6.10. It is probably a null pointer dereference bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

netdevsim netdevsim0 netdevsim2 (unregistering): unset [1, 0] type 2
family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2
family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2
family 0 port 6081 - 0
Oops: general protection fault, probably for non-canonical address
0xdffffc0000000029: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000148-0x000000000000014f]
CPU: 0 PID: 10054 Comm: kworker/u4:29 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__lock_acquire+0x106/0x8050 kernel/locking/lockdep.c:5005
Code: 85 5d 20 00 00 83 3d 14 d2 b5 0d 00 48 89 9c 24 18 01 00 00 0f
84 00 10 00 00 83 3d 33 3a 31 0c 00 74 31 48 89 d0 48 c1 e8 03 <42> 80
3c 00 00 74 17 48 89 d7 e8 fb 9c 85 00 48 8b 54 24 10 49 b8
RSP: 0018:ffffc9000a0bf540 EFLAGS: 00010002
RAX: 0000000000000029 RBX: 1ffff92001417ecc RCX: 0000000000000000
RDX: 0000000000000148 RSI: 0000000000000000 RDI: 0000000000000148
RBP: ffffc9000a0bf808 R08: dffffc0000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801fc31e00
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc6fba84cd0 CR3: 0000000020224000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1a9/0x400 kernel/locking/lockdep.c:5754
 down_write+0x36/0x50 kernel/locking/rwsem.c:1579
 kernfs_remove_by_name_ns+0x76/0x150 fs/kernfs/dir.c:1689
 del_nbp+0xa6/0xb50 net/bridge/br_if.c:338
 br_dev_delete+0x76/0x110 net/bridge/br_if.c:386
 br_net_exit_batch_rtnl+0xee/0x1a0 net/bridge/br.c:369
 cleanup_net+0x712/0xcd0 net/core/net_namespace.c:633
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0x106/0x8050 kernel/locking/lockdep.c:5005
Code: 85 5d 20 00 00 83 3d 14 d2 b5 0d 00 48 89 9c 24 18 01 00 00 0f
84 00 10 00 00 83 3d 33 3a 31 0c 00 74 31 48 89 d0 48 c1 e8 03 <42> 80
3c 00 00 74 17 48 89 d7 e8 fb 9c 85 00 48 8b 54 24 10 49 b8
RSP: 0018:ffffc9000a0bf540 EFLAGS: 00010002
RAX: 0000000000000029 RBX: 1ffff92001417ecc RCX: 0000000000000000
RDX: 0000000000000148 RSI: 0000000000000000 RDI: 0000000000000148
RBP: ffffc9000a0bf808 R08: dffffc0000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801fc31e00
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc6fba84cd0 CR3: 0000000020224000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 85 5d 20             test   %ebx,0x20(%rbp)
   3: 00 00                 add    %al,(%rax)
   5: 83 3d 14 d2 b5 0d 00 cmpl   $0x0,0xdb5d214(%rip)        # 0xdb5d220
   c: 48 89 9c 24 18 01 00 mov    %rbx,0x118(%rsp)
  13: 00
  14: 0f 84 00 10 00 00     je     0x101a
  1a: 83 3d 33 3a 31 0c 00 cmpl   $0x0,0xc313a33(%rip)        # 0xc313a54
  21: 74 31                 je     0x54
  23: 48 89 d0             mov    %rdx,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 00 00       cmpb   $0x0,(%rax,%r8,1) <-- trapping instruction
  2f: 74 17                 je     0x48
  31: 48 89 d7             mov    %rdx,%rdi
  34: e8 fb 9c 85 00       call   0x859d34
  39: 48 8b 54 24 10       mov    0x10(%rsp),%rdx
  3e: 49                   rex.WB
  3f: b8                   .byte 0xb8


-- 
Yours sincerely,
Xingyu

