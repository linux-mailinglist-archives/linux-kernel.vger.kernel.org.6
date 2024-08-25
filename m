Return-Path: <linux-kernel+bounces-300267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 911EA95E1B5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 06:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120C71F21D1B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F4B2207A;
	Sun, 25 Aug 2024 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="PRBt0o8g";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="sYSUZqXn"
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385C0BE6F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 04:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724560277; cv=none; b=PzTLb9cLkmWb5KFBrQK6HlvmqWS0LN0pK19NHtgHf0mDYPWuz9ovZsIpql2L5KZH3MQGJpzZIfKNLAdBf7ntg4ZNqbg7VBf8NA98sukCpHuTtB/AeXVqM0yrJgh5DQMQVNxr8ls8+ngxyFNE1Eh5ZpNVVURzInFsGrCcyRMxmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724560277; c=relaxed/simple;
	bh=RD85Os2xcrVLJyTtfNKqnqHl+iMHDJHj3qh8ulnhlug=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KDMq9R+rs5R0lkSbzjz3jd2WHygV0IfMpvXAmYkkH7Klg0RTyKVPrUQN55h4SmMjPquqdnzCYNkVBTaY0fIAg1bRKmrW+gw8sgWd2y6rYQbbbc3/fd8sK6pa8cnP7gTaEnZjjMAi0EX8QrhJOuL7Wa7DaeI7GucQZ0aWlUj0S9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=PRBt0o8g; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=sYSUZqXn; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724560275; x=1756096275;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=RD85Os2xcrVLJyTtfNKqnqHl+iMHDJHj3qh8ulnhlug=;
  b=PRBt0o8gdXEeWo3eSSZJulGvsBWmogZhXI4Ji4xDe8cqAviKNYN4nyMu
   ZBP8jKJfqUuOQUi/08AEYMre9oCeTWfHMBJZ2nj9O0PUYRcUKhOcKI5CW
   46nHcjqS7OAHk9Zm/n6z1jjvI8tMppoyJMuc6x8EY1e1mgA5LgKYb+e3J
   VMIRsGRc1EoSdjO6CNZJ6nmpKQcwzpr1Ww4Pe4q8cWR2viSkMZMFzyjMY
   o9jSyCIUffAhHziTQHo/5Crp2gdb8qSgz5jUF8GCp9zBfm3HAjNrFSzZ2
   FxIvd6wlcEWN1B8f1FVWPN1M37dKW2BrQZxkUotu2z5e4sQOoaJThucCt
   A==;
X-CSE-ConnectionGUID: 0MHqXp2jS16Yxzje7GnMlA==
X-CSE-MsgGUID: CdP4EEjnTI2KsXfDbSY5xA==
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 21:31:15 -0700
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d3e42ef677so3231327a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 21:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724560275; x=1725165075; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1NlgtRT7Tqlz5rfofFA2eZq2PJOhoc3/e1WHMbiqxdc=;
        b=sYSUZqXn8ZvLc0ls3TnCxCw0P1aEvapKEP3kyxhMmGZKctoosT6RF4MbNjP6BvrCPN
         Ja5UYFDbWSAYIWkEyu2t2pwBeEe8lFM/VxPe/IDrusoTGThH34dXzjH/YbgP3LcJM28d
         MLpqhsbphAiRzFOK8GQ/HeH09xWfcez9ERpVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724560275; x=1725165075;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1NlgtRT7Tqlz5rfofFA2eZq2PJOhoc3/e1WHMbiqxdc=;
        b=Okjvc+eGXiFIA/N7/DybEIo6wJWH4XA3BBtpqRg35D875QQ5wlCdAHeOCExHYdYXRI
         UqgcN46V9oZZIP81voc9cl3HdKINVkYh6e1n9Af4fVVKHbrp09HKU6um+r1SnVF2VrpC
         iNMi6Rnghv/usc3mjbp84W6cP+P8Tl9XzShJGciPfVma1KgH9wZyk8JXAKI/5eRgYGOE
         tMy3PE8BSNWhC82LbxIHJsuPa+i4bBKb3+G6SnnYi0/HLMxbcSJLz5v4tbJ2z8pzbyuK
         +e9QgB50LTXHQVarsaVR9qQ9G2Kza9Q6iM1ZUPozjfFlhJsj5MPtuiN0/POLmfg5mUCX
         LM6A==
X-Forwarded-Encrypted: i=1; AJvYcCXL0e4GZXf70cZa5UiAQMp99F/dcd9qqkj3BpQmDjCL9XMYzekyaJyvtaGG/GechdhyiSHeyEGljcetcrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZeUMM1hxMCeOr0E99rjT+OqopiyA5/8w3ikPZqpEiqcUsMMf
	BoMnc3DbDSHofR9PCG/d7h/LST+IL/3qhNPiob/YzRf1WTKhgLvcF2Xqu37n5LMmze5L6/BYkir
	b1XHQVORWErsO/Wooft77epHaczUNcfcQtTMleoarMzJML15tJDqsANyONIx7KIMSYqbbqqNytb
	s6uDzLsxBDMcsV1Hl7QgsRQk2DvpZovSs3jhPZGw==
X-Received: by 2002:a17:90b:f0a:b0:2c9:7a8d:43f7 with SMTP id 98e67ed59e1d1-2d646bf7321mr5938963a91.23.1724560274850;
        Sat, 24 Aug 2024 21:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2hAq3STv1mjGw5dbkE+8VTrmxtp8Pa08Pibq1nj7viDVODkf3gW+DgtAa8YCNrBtkyhZEfOxLBvS8INa/62o=
X-Received: by 2002:a17:90b:f0a:b0:2c9:7a8d:43f7 with SMTP id
 98e67ed59e1d1-2d646bf7321mr5938954a91.23.1724560274406; Sat, 24 Aug 2024
 21:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 21:31:03 -0700
Message-ID: <CALAgD-5hheRoik1vz49AxFSQ49uQ3eR0D=Mo=tWbrqKBkMD=WQ@mail.gmail.com>
Subject: BUG: general protection fault in check_lifetime
To: tj@kernel.org, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller.
It seems a null pointer dereference bug.
The bug report is as follows, but there is no generated syzkaller reproducer.

Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: events_power_efficient check_lifetime
RIP: 0010:check_lifetime+0x6ae/0x960
Code: 01 48 c7 c7 60 86 74 8c be 06 03 00 00 48 c7 c2 20 6f 74 8c e8
33 c0 f8 f7 4c 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c
08 00 74 08 4c 89 ef e8 04 a4 7d f8 49 8b 5d 00 48 85 db 0f
RSP: 0018:ffffc900000cfb70 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff88db7a02 R09: 1ffffffff1dabe05
R10: dffffc0000000000 R11: fffffbfff1dabe06 R12: ffff88803bdcbe00
R13: 0000000000000018 R14: ffff88803bdcbe18 R15: 1ffff110077b97c3
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4bbd251460 CR3: 0000000030dc8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:check_lifetime+0x6ae/0x960
Code: 01 48 c7 c7 60 86 74 8c be 06 03 00 00 48 c7 c2 20 6f 74 8c e8
33 c0 f8 f7 4c 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c
08 00 74 08 4c 89 ef e8 04 a4 7d f8 49 8b 5d 00 48 85 db 0f
RSP: 0018:ffffc900000cfb70 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff88db7a02 R09: 1ffffffff1dabe05
R10: dffffc0000000000 R11: fffffbfff1dabe06 R12: ffff88803bdcbe00
R13: 0000000000000018 R14: ffff88803bdcbe18 R15: 1ffff110077b97c3
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4bbd2ad850 CR3: 0000000030dc8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: 48 c7 c7 60 86 74 8c mov    $0xffffffff8c748660,%rdi
   7: be 06 03 00 00       mov    $0x306,%esi
   c: 48 c7 c2 20 6f 74 8c mov    $0xffffffff8c746f20,%rdx
  13: e8 33 c0 f8 f7       call   0xf7f8c04b
  18: 4c 89 e8             mov    %r13,%rax
  1b: 48 c1 e8 03           shr    $0x3,%rax
  1f: 48 b9 00 00 00 00 00 movabs $0xdffffc0000000000,%rcx
  26: fc ff df
* 29: 80 3c 08 00           cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2d: 74 08                 je     0x37
  2f: 4c 89 ef             mov    %r13,%rdi
  32: e8 04 a4 7d f8       call   0xf87da43b
  37: 49 8b 5d 00           mov    0x0(%r13),%rbx
  3b: 48 85 db             test   %rbx,%rbx
  3e: 0f                   .byte 0xf


-- 
Yours sincerely,
Xingyu

