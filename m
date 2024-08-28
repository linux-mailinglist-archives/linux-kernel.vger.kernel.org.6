Return-Path: <linux-kernel+bounces-305929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCCA963685
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3991F24FED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABB61AD3F2;
	Wed, 28 Aug 2024 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="NJXJpqQH";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="CJTWdAo+"
Received: from mx-lax3-2.ucr.edu (mx-lax3-2.ucr.edu [169.235.156.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DC647
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889572; cv=none; b=eGSV+WvygjRDo/A+zK3wMFvI+/Le4nCZcBZTf5d2RfvuE4UDgKooE+i6zjMNHI0QU9DF1uKaRuhc0xWEJV4OU1IPnHaqLE/hm7CTgaqml3kDaIGX5As5I4K/OP07toeR/KcBEe0OiPJGSnxNs3jBIm16IQkb0CxAKNKj51CG+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889572; c=relaxed/simple;
	bh=bNbEB49grLerxF89rqiuAH4xVfxwCRWH8pnTt+dv6gQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XFEFsVlzqBbEqQYmvamj5iDu8dEnmD1iNgwtw/cloMeJk1m1qFMMtyJx6Z0uXCOwjHJQ939SUz19pHyaEdYDyBAlQEzjTsUKvtwDvgSEoCSqJXLi1zPP5WVgNJasTMWgw+7sJh5dqsYW+3VH2nvNY3Mc1pCUOmlEXoeSe5YlQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=NJXJpqQH; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=CJTWdAo+; arc=none smtp.client-ip=169.235.156.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724889571; x=1756425571;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=bNbEB49grLerxF89rqiuAH4xVfxwCRWH8pnTt+dv6gQ=;
  b=NJXJpqQHSNpo5q3IoKkNTOu47TiG8KaZbrkdQMMqy935cGjom0pS6KXJ
   tQJaBLEG9I4AgS6If3jI5W1kJcrzgM/dsxjunrYxvvINhDp7B99L/XECS
   aMCjFL+VVkPx/NxDdxhvTZThqi9Pxx69dMit3zr+oHtkw2UjO1jKzsuj0
   bCy+5RlC7z+yMummrlhgXSlTfxtC6kA0jFgd5fhAYK+BYat3agtMaJZcD
   Onwde5jvinKbcRenUQWyiRNzf9/UhYeFTBd4Cde5qXUW5qJhhphpxiMal
   hQor5xIGVfNI+n7KmtNVTD6+9Wz8iGu06R2PTqm2TbxGRD6XBcLgmbUTg
   Q==;
X-CSE-ConnectionGUID: 5bWF9a0GRPOVVDBP8I2Fag==
X-CSE-MsgGUID: b8B/SgaUT7+jTbIoGMKhWg==
Received: from mail-il1-f198.google.com ([209.85.166.198])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:59:30 -0700
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d52097234so167215ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724889569; x=1725494369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VabcLhtJvfPer028FnlcUZwOG7FyTKna5cJCzCodfqo=;
        b=CJTWdAo+IIY6ZAhcHjjHlPaiqPKx+jMoMXXzlOu9F8lD1N8KlwJVoZm+wD/g1o2Mul
         gBTLrgftj/TtiX9qMeMliwhEmp+Qt3D96LXWEmS9IdcvoFjSS8umT42v4f5CObe8o2RI
         PjaCqptKgz/tiBSeWOtJJYcWrg1Sq8W90ej6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724889569; x=1725494369;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VabcLhtJvfPer028FnlcUZwOG7FyTKna5cJCzCodfqo=;
        b=nu1eVM820K/GJB9xS0e+SotlKdxUlZa2lj6nxCwIBNGG+zBxJG0JbEqT2tXQItPpjR
         arp465LDBTrv6WGnsHDAcvfo5xck33RmtFe1xaqR8BzDdgRSo/XyWfvapmi0pQfw73SP
         abntgjqGcDZGbZGonq4VjXCvcn9jxr24l2uWIU+/eJfdoW5/L9oLGaWZukRB0xCfBZO9
         t6yFha3w4P9qhqrazJ4oyZmaM46dkiN7eowWK/z635S00KgXr/NflQyyaqiILsZfJ32N
         ji4ZIO6dU+vtPav3vG4Qtl2foD3v9wHVTyQ4QVrcXZfCZ6oKfDDPkz6/Y/7f+VJp8Pu4
         vRuA==
X-Forwarded-Encrypted: i=1; AJvYcCWR8I1rnw2fqYZ92gIure+cFTCOqCL11SxEk+AslNmoeWew5mgyBL7Om+mxNKZtgadFAaa/n8a6aZuZWT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYKdGjJyOWWZz9auIzumhsKhsTa8mdFEarZ/CxhlBgQjzHxePp
	w5MbwXktoZeKC0hqbfdUKSOXwgvpMXK/pol25jfVO+nF12LWXbAZyCdlEu231au8nYoaipryNV+
	yvcsL92xa+oP2QGkXDIP6rmIygQuJ0A7/LLDj6A2+HR/esKP/oW3YpZJdbYRirR4HGrnPg3TQX1
	gOS/LhOOYwY9K0LToa6ODH8OKZjD6lCTHgrklIfGTLIenUznteizc=
X-Received: by 2002:a05:6e02:1a0e:b0:39d:6532:d953 with SMTP id e9e14a558f8ab-39f3790564amr16517615ab.10.1724889568598;
        Wed, 28 Aug 2024 16:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRUimduPkbOEDESBZXee0WXiuxcqJ07NgEtoNyuJWPScOsB7jciNA9gEjDaykaxBwCCP2K/UXp9ntOcZ76aOE=
X-Received: by 2002:a05:6e02:1a0e:b0:39d:6532:d953 with SMTP id
 e9e14a558f8ab-39f3790564amr16517435ab.10.1724889568210; Wed, 28 Aug 2024
 16:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:59:17 -0700
Message-ID: <CALAgD-7AaoOOpv39CWeSo=nuPvPfkGQsuC7g7TL4SJFRz-m2Og@mail.gmail.com>
Subject: BUG: general protection fault in anon_vma_interval_tree_verify
To: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a null
pointer dereference  bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc000000000f: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 0 PID: 7637 Comm: rs:main Q:Reg Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:vma_start_pgoff mm/interval_tree.c:15 [inline]
RIP: 0010:avc_start_pgoff mm/interval_tree.c:63 [inline]
RIP: 0010:anon_vma_interval_tree_verify+0x5b/0x150 mm/interval_tree.c:108
Code: 00 4d 8b 77 40 4d 89 fd 49 c1 ed 03 43 80 7c 25 00 00 74 08 4c
89 ff e8 c3 bc 1b 00 49 8b 1f 48 83 c3 78 48 89 d8 48 c1 e8 03 <42> 80
3c 20 00 74 08 48 89 df e8 a6 bc 1b 00 48 8b 1b 4c 89 f7 48
RSP: 0018:ffffc9000a457810 EFLAGS: 00010206
RAX: 000000000000000f RBX: 0000000000000078 RCX: ffff888014b75a00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888018bafc80
RBP: ffffc9000a457970 R08: ffff888024fa2de7 R09: 1ffff110049f45bc
R10: dffffc0000000000 R11: ffffed10049f45bd R12: dffffc0000000000
R13: 1ffff11003175f88 R14: 0000000000000000 R15: ffff888018bafc40
FS:  00007f7ce5800700(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f40e98fef98 CR3: 000000001d99e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 validate_mm+0x2c0/0x510 mm/mmap.c:318
 vma_merge+0x15af/0x24b0 mm/mmap.c:1038
 vma_modify+0xb4/0x340 mm/mmap.c:2494
 vma_modify_flags include/linux/mm.h:3352 [inline]
 mprotect_fixup+0x3dc/0xa60 mm/mprotect.c:637
 do_mprotect_pkey+0x87a/0xc50 mm/mprotect.c:820
 __do_sys_mprotect mm/mprotect.c:841 [inline]
 __se_sys_mprotect mm/mprotect.c:838 [inline]
 __x64_sys_mprotect+0x7c/0x90 mm/mprotect.c:838
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f7ce69451d7
Code: 73 01 c3 48 8b 0d b9 8c 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66
2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0a 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 89 8c 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007f7ce57ff558 EFLAGS: 00000206 ORIG_RAX: 000000000000000a
RAX: ffffffffffffffda RBX: 00007f7cd4000020 RCX: 00007f7ce69451d7
RDX: 0000000000000003 RSI: 0000000000001000 RDI: 00007f7cd4044000
RBP: 0000000000000110 R08: 00007f7cd4000000 R09: 0000000000044000
R10: 0000000000000130 R11: 0000000000000206 R12: 0000000000000100
R13: 0000000000001000 R14: 00007f7cd4043f00 R15: fffffffffffff000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:vma_start_pgoff mm/interval_tree.c:15 [inline]
RIP: 0010:avc_start_pgoff mm/interval_tree.c:63 [inline]
RIP: 0010:anon_vma_interval_tree_verify+0x5b/0x150 mm/interval_tree.c:108
Code: 00 4d 8b 77 40 4d 89 fd 49 c1 ed 03 43 80 7c 25 00 00 74 08 4c
89 ff e8 c3 bc 1b 00 49 8b 1f 48 83 c3 78 48 89 d8 48 c1 e8 03 <42> 80
3c 20 00 74 08 48 89 df e8 a6 bc 1b 00 48 8b 1b 4c 89 f7 48
RSP: 0018:ffffc9000a457810 EFLAGS: 00010206
RAX: 000000000000000f RBX: 0000000000000078 RCX: ffff888014b75a00
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888018bafc80
RBP: ffffc9000a457970 R08: ffff888024fa2de7 R09: 1ffff110049f45bc
R10: dffffc0000000000 R11: ffffed10049f45bd R12: dffffc0000000000
R13: 1ffff11003175f88 R14: 0000000000000000 R15: ffff888018bafc40
FS:  00007f7ce5800700(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f40e98fef98 CR3: 000000001d99e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 00 4d 8b             add    %cl,-0x75(%rbp)
   3: 77 40                 ja     0x45
   5: 4d 89 fd             mov    %r15,%r13
   8: 49 c1 ed 03           shr    $0x3,%r13
   c: 43 80 7c 25 00 00     cmpb   $0x0,0x0(%r13,%r12,1)
  12: 74 08                 je     0x1c
  14: 4c 89 ff             mov    %r15,%rdi
  17: e8 c3 bc 1b 00       call   0x1bbcdf
  1c: 49 8b 1f             mov    (%r15),%rbx
  1f: 48 83 c3 78           add    $0x78,%rbx
  23: 48 89 d8             mov    %rbx,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 20 00       cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f: 74 08                 je     0x39
  31: 48 89 df             mov    %rbx,%rdi
  34: e8 a6 bc 1b 00       call   0x1bbcdf
  39: 48 8b 1b             mov    (%rbx),%rbx
  3c: 4c 89 f7             mov    %r14,%rdi
  3f: 48                   rex.W


-- 
Yours sincerely,
Xingyu

