Return-Path: <linux-kernel+bounces-300274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B995E1CB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2E928257A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCEB2D60C;
	Sun, 25 Aug 2024 05:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jyKuEuMb";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="PkV2dn/+"
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BDA4A2C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 05:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724562308; cv=none; b=ktubpP3SVaQ5Hco7QtJpGJ47vqcVB4PqOM0TQH3dRdxxQNtkcWxOdZL/el4lNA86GLPYOJiuNMKycWSSQQk2SREPdVmhJBAIjEIwkij2PN/69ry2UGuFL9Y5Kj1969tyBllv4+UdpXk401GUr93ZshtNR++jwledCFWbqvIxDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724562308; c=relaxed/simple;
	bh=8FpRTyeOhJ0guT2h0u9UVtjbOVetRp9JK63j9WBzw1E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MeVm4TZlrGbYuV+X/vZKI+MQ17zTooTgCtyrh3MCCpU4BH/WBC1aZWtrlmJTKqqMsKZHSSxgeLVWJqFdS1QIik81DSjUDMhbcxQTjp/AYya0euqRnoENh9gNDPmmc7YgvSYaXkTBqoBlvlRhPM3ihaIycFIZHHPTcstImV3IrVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=jyKuEuMb; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=PkV2dn/+; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724562307; x=1756098307;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=8FpRTyeOhJ0guT2h0u9UVtjbOVetRp9JK63j9WBzw1E=;
  b=jyKuEuMbVRAnOjgW6a+0KLFzolGyEOFJooFiuYzI07vlj6wROiPvh1VA
   kZCCiUsaRq8MHeFgWhwplibvokSJI6KffMXa9ACYCie9hA2FoIM+rM9Xi
   mdt+U0EMTUffxVy11r5U7GrqUYvVGKoavBhi0cT+9dALNB9/unQzgl7O+
   TrYKIpmDCGmzQKXUEbhDPt4Z0JtO157P+KTNCxpfPPwi0sbjOmXKHanKZ
   mBtd2z+eifh8E0VZf+WvrobH3QYrseWICPkfFGm7C0NEW0oc8nfyKuKEf
   0zkYPcTgZrSKAI3sNgm+bDgvDmTgwqCe39jHk8gJ4rCkTRzs/i2AYAhUd
   A==;
X-CSE-ConnectionGUID: sKD/cavNT0u6YDgLqCxFAQ==
X-CSE-MsgGUID: ZF5jGe3vT7KXz7DNti2GHQ==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 22:05:06 -0700
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d3f948347eso3812982a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 22:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724562305; x=1725167105; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OodOnIJ7JzHSZKULdiN3iAGxZmh21/hh01Dz4jKvgNs=;
        b=PkV2dn/+k2dDgTcD8QNP8JuSMN8D/Lbo9FU8txQ9naN5tf/AAWr9qX4Art4NgoZXNU
         3Q8oemgJq8gfi6wdaPc0U23OIOGw7WSOXkkIRipQ1jLxLQWxqyq4edn54qiSLdo/jqY4
         EE7neLeUHNZY00Wg/LryuMZM8Fw/ikAoslHSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724562305; x=1725167105;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OodOnIJ7JzHSZKULdiN3iAGxZmh21/hh01Dz4jKvgNs=;
        b=ulYUx2g7iZoUGuhttR8Oixw8rpZ2RlJTP68GfJaOmtweBt2X9OOgK3m3Qv7wTdmtSF
         wcn9qZXf5nikFO2bjxzhJtt4wfDJzkpSt42AX8NZN5DtIsYwACWI3gOB7U8feN2/qC2K
         ZXUl3SE4mYNdGYHLwNPxolnkbd7hXLkgtI+dy2EeY7neoTyAMG4r7DyOsdk/315sthYy
         6ZkqRJVgJ64hRvBTWv/TJegaBX1ej1D8ggBWaPmggBovYiH2r0aJLGopBOh+vuws15En
         qZvvKFxf2+AoDURUfcTajvizzVB35xJz2wPtdOC3SGrEtGyEc5llXQox7S9JCPa2Pkbm
         dO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6jOm6nZZZ8i404ch+xfEAlxU0UxGd7ncbYCK3aTgLDPz5wJAiJW4JQLW+A8VpyQv2qZnRw1udO3pi3Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM2x1G76MCQVPfMRxQnLRjFoBIdTf4vCZJOhd7SIx36/9WNoYQ
	qJ1pAIDBMT+W/8Ikp0ymzQAbirYxt9muFANOQkOCSuFIEUjYCwmyYUbv5C85VgAgpOsL71A2U6z
	74V3UO6dAm65lq1Mf4rmWw8cAFX3+YweejEs73A01FoFMVMwBJfIJVElWVsrHb9rAOOjRNA7whd
	gNAEvQ0fttoXtHsaMS6NijElVBLS1wBfgrb3Njsw==
X-Received: by 2002:a17:90a:de86:b0:2cb:56bd:5d7 with SMTP id 98e67ed59e1d1-2d60a8cb8bamr17364202a91.5.1724562305593;
        Sat, 24 Aug 2024 22:05:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpY8/ovDEMWRVctMrIPjKVishJEZui15/lauUh7A/DfySy3xVYTzAGRCfM6A68gzxkKIDvg3x9AAu0e/VJGgQ=
X-Received: by 2002:a17:90a:de86:b0:2cb:56bd:5d7 with SMTP id
 98e67ed59e1d1-2d60a8cb8bamr17364184a91.5.1724562305190; Sat, 24 Aug 2024
 22:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 22:04:54 -0700
Message-ID: <CALAgD-4n=bgzbLyyw1Q3C=2aa=wh8FimDgS30ud_ay53hDgYBQ@mail.gmail.com>
Subject: BUG: general protection fault in put_links
To: mcgrof@kernel.org, kees@kernel.org, j.granados@samsung.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10. It is probably a null pointer reference bug.
The reason is probably that before line 123 of
fs/proc/proc_sysctl.c(entry = &head->ctl_table[ctl_node -
head->node];), there is no null pointer check for `head`.
The bug report is as follow:

Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 8491 Comm: kworker/0:5 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events free_ipc
RIP: 0010:find_entry fs/proc/proc_sysctl.c:123 [inline]
RIP: 0010:put_links+0x19e/0x4f0 fs/proc/proc_sysctl.c:1472
Code: 0f 84 33 02 00 00 49 8d 5f 18 48 89 d8 48 c1 e8 03 42 80 3c 28
00 74 08 48 89 df e8 bc 94 c6 ff 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80
3c 28 00 74 08 48 89 df e8 a3 94 c6 ff 48 8b 2b 48 89 5c 24
RSP: 0018:ffffc9000bf87980 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888026909e00
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: 000000000000000b R08: ffffffff822dc888 R09: ffffffff822dc93a
R10: 0000000000000002 R11: ffff888026909e00 R12: ffffffff8d9d70d0
R13: dffffc0000000000 R14: ffffffff8ba0d080 R15: ffff888018108058
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4e64ba9930 CR3: 0000000020a88000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drop_sysctl_table+0xed/0x4f0 fs/proc/proc_sysctl.c:1494
 unregister_sysctl_table+0x3d/0x60 fs/proc/proc_sysctl.c:1520
 retire_ipc_sysctls+0x5a/0x80 ipc/ipc_sysctl.c:310
 free_ipc_ns ipc/namespace.c:158 [inline]
 free_ipc+0x139/0x280 ipc/namespace.c:179
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:find_entry fs/proc/proc_sysctl.c:123 [inline]
RIP: 0010:put_links+0x19e/0x4f0 fs/proc/proc_sysctl.c:1472
Code: 0f 84 33 02 00 00 49 8d 5f 18 48 89 d8 48 c1 e8 03 42 80 3c 28
00 74 08 48 89 df e8 bc 94 c6 ff 48 8b 1b 48 89 d8 48 c1 e8 03 <42> 80
3c 28 00 74 08 48 89 df e8 a3 94 c6 ff 48 8b 2b 48 89 5c 24
RSP: 0018:ffffc9000bf87980 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888026909e00
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: 000000000000000b R08: ffffffff822dc888 R09: ffffffff822dc93a
R10: 0000000000000002 R11: ffff888026909e00 R12: ffffffff8d9d70d0
R13: dffffc0000000000 R14: ffffffff8ba0d080 R15: ffff888018108058
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4e64ba9930 CR3: 0000000020a88000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 0f 84 33 02 00 00     je     0x239
   6: 49 8d 5f 18           lea    0x18(%r15),%rbx
   a: 48 89 d8             mov    %rbx,%rax
   d: 48 c1 e8 03           shr    $0x3,%rax
  11: 42 80 3c 28 00       cmpb   $0x0,(%rax,%r13,1)
  16: 74 08                 je     0x20
  18: 48 89 df             mov    %rbx,%rdi
  1b: e8 bc 94 c6 ff       call   0xffc694dc
  20: 48 8b 1b             mov    (%rbx),%rbx
  23: 48 89 d8             mov    %rbx,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 28 00       cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f: 74 08                 je     0x39
  31: 48 89 df             mov    %rbx,%rdi
  34: e8 a3 94 c6 ff       call   0xffc694dc
  39: 48 8b 2b             mov    (%rbx),%rbp
  3c: 48                   rex.W
  3d: 89                   .byte 0x89
  3e: 5c                   pop    %rsp
  3f: 24                   .byte 0x24

-- 
Yours sincerely,
Xingyu

