Return-Path: <linux-kernel+bounces-305843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F94963523
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CD01C21901
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB41AD3FB;
	Wed, 28 Aug 2024 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="j3CJPQsv";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="pThyU92F"
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB1116078B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886071; cv=none; b=LOgkYfkc8KpPqT4Ut20A5QUUuJu/rL5rg2HgwDgYrVTPr4oC2RoWw2jOWjZH5aS0VdomUuo4sieh4sxMy0wHLjV78eX9oXBXaHmAtET/0JzICKTce+uxwCKYjyv42cchcC1h58K7ZgwyoVw/4i7VajgHXq/zXybY+FeAgHWbxCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886071; c=relaxed/simple;
	bh=6Zq8e9tLvyXQSLrr8/GICIJ1f3j621g7RarkGvzikbI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KeqA0uS9aiH/NEZWSubCcsqFfPiI2UB2ZQ/HIR/AHlUGBCisKIQcUgFoXDF/K4LjTYnUa0Nv7Vkix2cx2xgjb+VOMy0O+kEm+DDhZQ4BdXvw7gDMSgJbDyVlyk8E5kueQhI5W0z89okKYx+z6Ij+PTuTtIhvaU4Gt1N5SkjfguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=j3CJPQsv; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=pThyU92F; arc=none smtp.client-ip=138.23.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724886070; x=1756422070;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=6Zq8e9tLvyXQSLrr8/GICIJ1f3j621g7RarkGvzikbI=;
  b=j3CJPQsvTTG5AFBB9prj/3gbCIIv9rmLPJdW3WITyGnHBYPyRxW7X7hE
   87uuAi+mqmQAerBhCcGYUCSeqvqf4T5fh7l6Ovt65rJFitOskhV1ZQOKb
   +HJEKqhC302vNQCAjSmD78UrXcSQWw+GaOcq5BsPm/9pHGigENEPYsyJe
   ycMdNdL1/GPAGdMxm9Aqgi9A00X8oritV2O2cGZZZKP1f8csmhowIfhrv
   1Yy4hYHkOpB1dlkdXiDVIcPlgRTQ9SgiGPrTYU9eA41mGDhd4i77av5+l
   yfc7YvcxJHuy8qtF62uyD9lUFe3wxIkjWcN3OsRAwTTPg7py/Bl4nxZwz
   w==;
X-CSE-ConnectionGUID: tsyvXGDVTtyePaVicCfWnQ==
X-CSE-MsgGUID: LUYHQoVlTt62yo6rv/8JoA==
Received: from mail-pj1-f72.google.com ([209.85.216.72])
  by smtp2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:01:10 -0700
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d83f709d76so35353a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724886069; x=1725490869; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7aaoX13Po+tmh5G8gUT9+u5zII2s+aasP3CnLzRHEk=;
        b=pThyU92FfxncZFVYen6fQocYV/xNaLXJUEzCQIcyAWAghXXZYvKz7Z4LpstZKdhhQs
         fsmwIeEXKtpl4MgplvEyibdMhgVLDoGoXp22Q9ImKwLp1qG3RUGxKlf0MbnfFb6YJTr6
         EomDuq/0FUGoMNiVIVoaX3BhVlq5wfAYTUG7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886069; x=1725490869;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7aaoX13Po+tmh5G8gUT9+u5zII2s+aasP3CnLzRHEk=;
        b=ezwXJ/CN+tkzXgzHGQmJ21AOgrTTCebsuDXY4sig1HVzrHirQ+xOdrjvZ7nhEs6/to
         2aIWInbayieijN4RMuv2R4wavt5rHtqDNiL7o3I13XuYUu608NddTch9R1AR1AsajNrT
         Ghj+V+netlLdXM7z+nZkceMhFeSkYm1yxJSRvB5OSRGsTAk0nvKqeoxfNVt1GhWxIdIu
         /lXPUYbSrLVSKmqgLQuSOB51ODXj28uUXOtTvx2H1OLTO/px4y614JoJpq1soBwZnu16
         l4mB9BLlNp55OB5tHOI7iPKjvFefsbF571UM2oByRKWGKcYXSp2fDmPROFYGwRZw27fh
         EpoA==
X-Forwarded-Encrypted: i=1; AJvYcCXBuQhi8HwsFizXlpBH71dH4Mvwppn72M+x96zuIJxXtt6q1GI/B3HkELY5ry/uY4FjiQOrWndxJV0wRzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHfk7lXhe2MTjogLWHIV70ygWPYH0ltNk9TbgyTgu7Qq36IhXL
	Ni+5qhfKYu4V9JDYEzRjozvXpunMaSv92qLxGMbYqXeQHljl8gUcJjLoD/iJJXmtbS2DaOiGDjX
	tDcCeLNNiNOiC+Bhoy4Qb8FAheSjwqSde25fKwjJz9H3Db6ZS79vioL5gkCmbXcx3JBjmYOxyer
	v0Ub1OwFABHjpG5Ply+NtdPI/+bzQ40spZeBTcSFeyxQj6rz2eieI=
X-Received: by 2002:a17:90a:8c91:b0:2d3:b643:8386 with SMTP id 98e67ed59e1d1-2d85617c056mr834382a91.9.1724886067734;
        Wed, 28 Aug 2024 16:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY3zcurLUsl0Fn2fPoSOc5sLswZXvIL53c258k2u45F9ok2NboScFF5AMOJROoLscBfnyLwtS7wxCICRSP4mo=
X-Received: by 2002:a17:90a:8c91:b0:2d3:b643:8386 with SMTP id
 98e67ed59e1d1-2d85617c056mr834253a91.9.1724886065804; Wed, 28 Aug 2024
 16:01:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:00:55 -0700
Message-ID: <CALAgD-6NoE1UD-sM_DE8wqvNRKEi-w+K10P7Y2v=_HJ+pbG4vA@mail.gmail.com>
Subject: BUG: general protection fault in tomoyo_check_acl
To: takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a null
pointer dereference  bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 1 Comm: systemd Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:tomoyo_check_acl+0xa8/0x3f0 security/tomoyo/domain.c:173
Code: e8 03 42 8a 04 28 84 c0 0f 85 c1 02 00 00 48 8b 1c 24 4c 8b 23
49 39 dc 0f 84 fa 01 00 00 49 8d 6c 24 18 48 89 e8 48 c1 e8 03 <42> 0f
b6 04 28 84 c0 0f 85 16 01 00 00 0f b6 6d 00 31 ff 89 ee e8
RSP: 0018:ffffc9000003f518 EFLAGS: 00010206
RAX: 0000000000000003 RBX: ffff88801e329f10 RCX: ffff8880142c8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000018 R08: ffffffff840e6c85 R09: ffffffff840fb2f0
R10: 0000000000000002 R11: ffffffff840e6c00 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88801e329f00 R15: 0000000000000000
FS:  00007f1b0d157900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff1162f68b8 CR3: 000000001a4bc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tomoyo_path_permission+0x1a8/0x360 security/tomoyo/file.c:586
 tomoyo_check_open_permission+0x2f5/0x4f0 security/tomoyo/file.c:777
 security_file_open+0x4f/0x760 security/security.c:2962
 do_dentry_open+0x382/0x1420 fs/open.c:942
 vfs_open+0x3a/0x330 fs/open.c:1086
 do_open fs/namei.c:3654 [inline]
 path_openat+0x2bb9/0x3580 fs/namei.c:3813
 do_filp_open+0x22d/0x480 fs/namei.c:3840
 do_sys_openat2+0x13a/0x1c0 fs/open.c:1413
 do_sys_open fs/open.c:1428 [inline]
 __do_sys_openat fs/open.c:1444 [inline]
 __se_sys_openat fs/open.c:1439 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1439
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f1b0d62d1e4
Code: 84 00 00 00 00 00 44 89 54 24 0c e8 36 58 f9 ff 44 8b 54 24 0c
44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 68 58 f9 ff 8b 44
RSP: 002b:00007ffc7a797b50 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000560238c8c780 RCX: 00007f1b0d62d1e4
RDX: 0000000000080000 RSI: 00007ffc7a797cb0 RDI: 00000000ffffff9c
RBP: 00007ffc7a797cb0 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000080000
R13: 0000560238c8c780 R14: 0000000000000001 R15: 00007ffc7a797cb0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tomoyo_check_acl+0xa8/0x3f0 security/tomoyo/domain.c:173
Code: e8 03 42 8a 04 28 84 c0 0f 85 c1 02 00 00 48 8b 1c 24 4c 8b 23
49 39 dc 0f 84 fa 01 00 00 49 8d 6c 24 18 48 89 e8 48 c1 e8 03 <42> 0f
b6 04 28 84 c0 0f 85 16 01 00 00 0f b6 6d 00 31 ff 89 ee e8
RSP: 0018:ffffc9000003f518 EFLAGS: 00010206
RAX: 0000000000000003 RBX: ffff88801e329f10 RCX: ffff8880142c8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000018 R08: ffffffff840e6c85 R09: ffffffff840fb2f0
R10: 0000000000000002 R11: ffffffff840e6c00 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88801e329f00 R15: 0000000000000000
FS:  00007f1b0d157900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff116299ba8 CR3: 000000001a4bc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: e8 03 42 8a 04       call   0x48a4208
   5: 28 84 c0 0f 85 c1 02 sub    %al,0x2c1850f(%rax,%rax,8)
   c: 00 00                 add    %al,(%rax)
   e: 48 8b 1c 24           mov    (%rsp),%rbx
  12: 4c 8b 23             mov    (%rbx),%r12
  15: 49 39 dc             cmp    %rbx,%r12
  18: 0f 84 fa 01 00 00     je     0x218
  1e: 49 8d 6c 24 18       lea    0x18(%r12),%rbp
  23: 48 89 e8             mov    %rbp,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 0f b6 04 28       movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f: 84 c0                 test   %al,%al
  31: 0f 85 16 01 00 00     jne    0x14d
  37: 0f b6 6d 00           movzbl 0x0(%rbp),%ebp
  3b: 31 ff                 xor    %edi,%edi
  3d: 89 ee                 mov    %ebp,%esi
  3f: e8                   .byte 0xe8


-- 
Yours sincerely,
Xingyu

