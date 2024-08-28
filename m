Return-Path: <linux-kernel+bounces-305847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70F996352F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0336285905
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 23:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4035D1AD40E;
	Wed, 28 Aug 2024 23:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="tXXVHLlh";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="RdWu8clh"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AF1158DCD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724886441; cv=none; b=J2K5tmWTXvohEh/7P/7LlJl1KHavStiCzNcxt4+J9cWp5yc+aeEWKFnIRtbG9gSWnS0nFPs2ku8YhS4AZvOWixqnscjwRJbeZNqm5bcZ9KljgsONKyyduTYvcdb1X/w4GFpC+kJzXKrlR218j1wwxJ8Yotzll6xfPsxaPPXhp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724886441; c=relaxed/simple;
	bh=BAxwNyY8n8sD14z3VFSftBaW92dNQmN1QZPZMmXVuq8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DsG0IWJhro8faZebm6O16qIUepOM9qM4XP8isWGBrno9GWH2NLr1eiC64Xu5TeedCY32iMB6J3OXoXykp7pfAJvBKQ34+UJ+0b5YTww+xavIS+WjLkwGtQoA70g8/E7+Uw/dBKP5pWsTzByaGYOeubi9myUm67gbwYEYTu1uIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=tXXVHLlh; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=RdWu8clh; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724886440; x=1756422440;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=BAxwNyY8n8sD14z3VFSftBaW92dNQmN1QZPZMmXVuq8=;
  b=tXXVHLlhuEiwCm4Nux6xqPvINN2kS7Ldp2Jgphw7V/Zx/5inmQEYwbg5
   TXAO2iYjCgU7KaoUg763LS0+mrIZuZ+1GafdVDbGf7SLn33XlqffBjGFr
   HG7IDmUoVcf8b5b9whDWrSJOCG8KPtQExEht3LVoVfZVY8r+fztjGaeRL
   FyyJ5H6ZzieAlfT2CtPCtRRNHs2S8naTYmkjljasN9TlBzS49kr9WYNKz
   pLtO9FuPYMYtcBlujQJo3hYRbnYYD3LyfHOtDuLn31Ig5p2j70YCjMdkZ
   Imq+J0ms91ip6AR/AkHwocRJrqEOC9IK0JhLnqI4SdsQxbS/b4tQCUyU9
   g==;
X-CSE-ConnectionGUID: 5L1++PKFTFuV5PtwBuD0rg==
X-CSE-MsgGUID: KgPFtCVPShyJFkAvO3US5g==
Received: from mail-pj1-f71.google.com ([209.85.216.71])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:07:18 -0700
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d699beb78dso49257a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724886437; x=1725491237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r69KSwSvtdfgReOplWdtpyBR/WAgO5KSF4K15+N0o6w=;
        b=RdWu8clhBGQrVK8Ux5+II51n+amaXSoP8u67TkP6j5PkLY9xBrWNxz9dcrX7MpgfmH
         IVf34agvd/c/HeEg8gRl92Oi8o1EhI4Vi6VuCDe1+WYYYilUOoEEIpTzti25xW3WmmH8
         6uvMhO/wWpbb1SMN2l2XUFmDamxcTxwW/9pvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724886437; x=1725491237;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r69KSwSvtdfgReOplWdtpyBR/WAgO5KSF4K15+N0o6w=;
        b=WHgyCqogePetppieIXHMStX3NjjoLJ+iA5Hf5NKnqNo239E1KWMH/m4hRtk/h7HZ8G
         LGzQ98eDb043QWOnLRafMHb1q81hKULd1GjeU25uUlL1oH8TQLAGevPV8zmQwFbyVU0g
         0waiDBNkCSrm1yh9QJX1XyEb2cNfg49ihWatRZn47ZcDzDbf8i4o628tzNZkQ5Vzl0bZ
         3p0fwGs2N6URCBjo8vzK5DfHITCvK8Bh324c6VHiMnx7F9zJzJdM4uI9to+QhFXBXDHD
         Gh42CSXdYnfl20JbOpXUjRPCg8SmKWcW5mXdzgQCimkWIrr63e+AL+N19aNEIWYdKeVU
         12Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVNqAKanYYsg7XNG9i7SG2L1+DFUk7dvH5x/B1fICUrRW6VbjSfZBQbFID66t09vt0a/64wU5G93Afdmgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdaLrUmRQ1pfnMHLJFDjWqHYVWnCKVJPZbTqW0JQc29TpY09gm
	TQ2HISTnS2e2cA8zIG1rn5G0KuUQJo81xmndZzo2FjX6+TFJEfskpoQT01Yqk/Fi+UZ/7Iv2CZf
	h0inc492xtbK5yef4Q7KVvVyN9f9ME8J6LIb0e7W+IO/sujt1HEX7Gnb2WyL5w7XzOUi/sdn7jX
	6cR1459Z4op/ormK3iHfjABFghl5q4RNZkM6kVQQ==
X-Received: by 2002:a17:90a:9a91:b0:2c8:6bfa:bbf1 with SMTP id 98e67ed59e1d1-2d8561c8d43mr944535a91.23.1724886437196;
        Wed, 28 Aug 2024 16:07:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwUuvWEGO9DWk8T9maSwiK7UXrBgf8YVXIonMy085ch756KYE6OTnnmNwIpUOaqBEHYzcRATjxLVsfxMnRUtY=
X-Received: by 2002:a17:90a:9a91:b0:2c8:6bfa:bbf1 with SMTP id
 98e67ed59e1d1-2d8561c8d43mr944510a91.23.1724886436873; Wed, 28 Aug 2024
 16:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:07:05 -0700
Message-ID: <CALAgD-5myPieAa_9BY6RVfBjWT_8g48+S0CX7c=EihMzdwakxw@mail.gmail.com>
Subject: BUG: general protection fault in mmap_region
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	lorenzo.stoakes@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.6 using syzkaller. It is possibly a  null
pointer dereference bug.
The reprodcuer is
https://gist.github.com/freexxxyyy/67b082078a6d4da117013f0f269bf7cc

The bug report is:

Syzkaller hit 'general protection fault in mmap_region' bug.

general protection fault, probably for non-canonical address
0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 8267 Comm: apt-helper Not tainted 6.6.0 #9
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:__rb_insert lib/rbtree.c:115 [inline]
RIP: 0010:__rb_insert_augmented+0x78/0x8e0 lib/rbtree.c:459
Code: ea 48 c1 ea 03 42 80 3c 2a 00 0f 85 7f 05 00 00 4c 8b 65 00 41
f6 c4 01 0f 85 2f 05 00 00 4d 8d 44 24 08 4c 89 c2 48 c1 ea 03 <42> 80
3c 2a 00 0f 85 6f 05 00 00 4d 8b 74 24 08 49 39 ee 0f 84 77
RSP: 0018:ffffc9000962f8b0 EFLAGS: 00010202
RAX: ffff888018b5add8 RBX: ffff88802e724e40 RCX: 1ffff11005ce49c8
RDX: 0000000000000001 RSI: ffff888018b5add8 RDI: ffff88802e724e40
RBP: ffff88802bf80f40 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888024c55680 R15: ffffffff81c875b0
FS:  0000000000000000(0000) GS:ffff888063600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055622b1160c0 CR3: 000000002afe6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mmap_region+0x1466/0x2800 mm/mmap.c:2846
 do_mmap+0x86f/0xee0 mm/mmap.c:1374
 vm_mmap_pgoff+0x1a8/0x3b0 mm/util.c:546
 vm_mmap+0x96/0xc0 mm/util.c:565
 elf_map+0x118/0x320 fs/binfmt_elf.c:395
 load_elf_interp fs/binfmt_elf.c:637 [inline]
 load_elf_binary+0x32ab/0x50b0 fs/binfmt_elf.c:1249
 search_binary_handler fs/exec.c:1739 [inline]
 exec_binprm fs/exec.c:1781 [inline]
 bprm_execve fs/exec.c:1856 [inline]
 bprm_execve+0x7f5/0x1990 fs/exec.c:1812
 do_execveat_common.isra.0+0x5e8/0x760 fs/exec.c:1964
 do_execve fs/exec.c:2038 [inline]
 __do_sys_execve fs/exec.c:2114 [inline]
 __se_sys_execve fs/exec.c:2109 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2109
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x40/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x6f/0xd9
RIP: 0033:0x7f507cc66c47
Code: Unable to access opcode bytes at 0x7f507cc66c1d.
RSP: 002b:00007ffe880488a8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00005621cb93a230 RCX: 00007f507cc66c47
RDX: 00005621cba830b0 RSI: 00005621cb9ed600 RDI: 00005621cb911990
RBP: 00007ffe88048aa0 R08: 00005621cb8b13e0 R09: 0000000000000000
R10: 00005621cb93ef40 R11: 0000000000000246 R12: 00005621cb9ed600
R13: 0000000000000000 R14: 00005621cb961ba0 R15: 00005621cb9ed600
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__rb_insert lib/rbtree.c:115 [inline]
RIP: 0010:__rb_insert_augmented+0x78/0x8e0 lib/rbtree.c:459
Code: ea 48 c1 ea 03 42 80 3c 2a 00 0f 85 7f 05 00 00 4c 8b 65 00 41
f6 c4 01 0f 85 2f 05 00 00 4d 8d 44 24 08 4c 89 c2 48 c1 ea 03 <42> 80
3c 2a 00 0f 85 6f 05 00 00 4d 8b 74 24 08 49 39 ee 0f 84 77
RSP: 0018:ffffc9000962f8b0 EFLAGS: 00010202
RAX: ffff888018b5add8 RBX: ffff88802e724e40 RCX: 1ffff11005ce49c8
RDX: 0000000000000001 RSI: ffff888018b5add8 RDI: ffff88802e724e40
RBP: ffff88802bf80f40 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888024c55680 R15: ffffffff81c875b0
FS:  0000000000000000(0000) GS:ffff888063600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f012fc22f70 CR3: 000000002afe6000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: 48 c1 ea 03           shr    $0x3,%rdx
   4: 42 80 3c 2a 00       cmpb   $0x0,(%rdx,%r13,1)
   9: 0f 85 7f 05 00 00     jne    0x58e
   f: 4c 8b 65 00           mov    0x0(%rbp),%r12
  13: 41 f6 c4 01           test   $0x1,%r12b
  17: 0f 85 2f 05 00 00     jne    0x54c
  1d: 4d 8d 44 24 08       lea    0x8(%r12),%r8
  22: 4c 89 c2             mov    %r8,%rdx
  25: 48 c1 ea 03           shr    $0x3,%rdx
* 29: 42 80 3c 2a 00       cmpb   $0x0,(%rdx,%r13,1) <-- trapping instruction
  2e: 0f 85 6f 05 00 00     jne    0x5a3
  34: 4d 8b 74 24 08       mov    0x8(%r12),%r14
  39: 49 39 ee             cmp    %rbp,%r14
  3c: 0f                   .byte 0xf
  3d: 84                   .byte 0x84
  3e: 77                   .byte 0x77







-- 
Yours sincerely,
Xingyu

