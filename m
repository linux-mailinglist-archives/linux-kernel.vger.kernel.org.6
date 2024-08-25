Return-Path: <linux-kernel+bounces-300277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD6E95E1D3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2141C20C5E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0860B2D60C;
	Sun, 25 Aug 2024 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="a9fWB5/o";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kw2ExnXp"
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953803209
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 05:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724562672; cv=none; b=TWMBc1FOW4VDiu95STiC6FTnNEvrrQwfu8FG2t5LVazY4arBg0IUDO8RDtyYgwgWupsdeizux5RTFlQSbvxv+QFmdl+iCld99Fz4vEgM+KQssoeoiLxGdUENISE2IlpyaKziCdkrqVAPFopl395ENEIrlBP8Jfj3SPRrjkumFiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724562672; c=relaxed/simple;
	bh=r8fSZZAkztvwgMS1RQkgMWFwRxP1fwiNkSnvFeTAVD4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=j901gqEaXyTw10+gvmaByGtuwQZVSOXZ5YsNwX+7iru3pGil1f6TiFLMLNZLRVPjPyAhAY8YhGY6FHHF6rp9pSDmqWwGGoogwbAF/09MbWVka13/bweIVusKK1ankBTo0fH2qVZz0cuVhwyib92iE/2YGSLPufrdeOl8ZKJz2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=a9fWB5/o; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kw2ExnXp; arc=none smtp.client-ip=169.235.156.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724562671; x=1756098671;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:content-transfer-encoding:
   x-cse-connectionguid:x-cse-msgguid;
  bh=r8fSZZAkztvwgMS1RQkgMWFwRxP1fwiNkSnvFeTAVD4=;
  b=a9fWB5/o59CNpgU0lKbwhSuailA0GR1MDzYoHiwRqjaEPMaCrNfW//Uc
   Uv+1I52cj4t4VOQ5KBpzeRdkUO951vrpV8XaktM7xmxTL8GMS7eGKsIj0
   NHR+MJz0944q9e/iX8XDRToglFMMoql/vGSSiAO7xHBDcRUYmaT11qMdf
   FGJW8F6pS57ZaGjHO7dj55jzA2pSgxJBxAKmZvzTKYbK7JtQ5pEEvXNmh
   /18fo9x5i5VkrmRJijAZcyiI2fikCxNOwpgAuUT8XWGm7XTmwbhXT5469
   BWKiYcJ8kPmRXYhIMzJcltY5eiYsQi11WFPnPRu4YTz4UEDGtSUVWebHR
   A==;
X-CSE-ConnectionGUID: z28NVRRDRQSy/cwLxR2NlA==
X-CSE-MsgGUID: ZuDpVNxkSu2Hk6lQzG+ftg==
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 22:11:10 -0700
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-715a16b4206so423119b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 22:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724562669; x=1725167469; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p7huxQOEChvdaykUFKGm0QTI9D846dJ8HoKnVfcJIa4=;
        b=kw2ExnXpdlUQP09ttmT0ceOnR7mSxNdXShuqB/68jUKUh2wFLjBiWf3BoaJIDb14sm
         vesPkWVAiMRgoIJ/is+33HR8ZDpP7qrxtKYIRLAVDYeCEk22acCJIL7xDA2jT1KY0efh
         /1+Q2SU96Fsy8dCUpCN4tpba6CDmiN32/P45c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724562669; x=1725167469;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p7huxQOEChvdaykUFKGm0QTI9D846dJ8HoKnVfcJIa4=;
        b=vil5YIkBt2EHHIW1wlzHayaQ62e6C89D7fzUNV3FH8LB6JrdIIzGgul2GhV7BbLsoR
         /TfAcHtXoPPj+7QwKIt2Hrk2G3vBr5Ob1M7Rh9rdL0GeYnBJL/nWBhL/Yg0l4Uw7xLhD
         YMz5yF4t+xeCC5OL7n8YC149zxN8YWQZthIEljtBkfze3keflLOZSfvVX8IntH7TuQMs
         O0WZIJ0ubFUeWOlqZtYqJ2yXxMbsLe7mb8SIAAmWOY3g/X1sHAdusxkUGxx77jhorK+8
         zXu2rLHj00bvQVMrv9cgbBzgbHOL/VvTBty20h2Rx5xKx3eBnhcigOGrcGZ2/Vr46hTJ
         PJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF/fE5JFOLGPmCk3apBoeKSCQIUpooX1UL2ZFAQejir+iFtL3s00KJ9jowfM+QW9srU7Fk3dVF2+oH2qU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuCYSRNKAf2T1/bURwA5F98r/vAklmY/iiWWRWTy3nSpvNYl8u
	qsvtK0jH1AnzWhxs8bstRDkJayqI9TCRin0bylm0HYOJEsycwO1cs/wYVXVW3KN16avMILL57cw
	v7nASndd0nhYkrtwQao7G1pKPk+1rHmR7KRR/kVOqVqrnRQhdv04b1p6sPcTj5WzFBd0N0BD8ao
	2MPJz0jwXMHcwlz6ndfDP2M2ccudCqMnSSfW5MSi1Xf27TJ3G8M5I=
X-Received: by 2002:a05:6a20:c78e:b0:1c8:d4d4:4139 with SMTP id adf61e73a8af0-1cc89ee9760mr7128025637.43.1724562668889;
        Sat, 24 Aug 2024 22:11:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMx+3/jZdACx242VZMz16w96+QtHP69PBKO3MDWyzAQk+gOxzbDpBjWTxSNCAsJyamiZqedVQCaEf+xbuOsTE=
X-Received: by 2002:a05:6a20:c78e:b0:1c8:d4d4:4139 with SMTP id
 adf61e73a8af0-1cc89ee9760mr7128020637.43.1724562668543; Sat, 24 Aug 2024
 22:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Sat, 24 Aug 2024 22:10:58 -0700
Message-ID: <CALAgD-6gJ4W1rPj=CWG7bFUPpEJnUjEhQd3uvH=7C=aGKb=CUQ@mail.gmail.com>
Subject: BUG: general protection fault in update_io_ticks
To: "axboe@kernel.dk" <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We found a bug in Linux 6.10. It is probably a null pointer dereference bug=
.
The bug report and syzkaller reproducer are as follows:

Bug report:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 45 Comm: kworker/u4:3 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:update_io_ticks+0x94/0x2c0 block/blk-core.c:992
Code: f3 f3 f3 48 89 54 24 18 4a 89 04 32 e8 75 77 59 fd 48 c1 eb 03
48 89 5c 24 08 eb 03 4c 8b 2b 49 8d 5d 28 48 89 d8 48 c1 e8 03 <42> 80
3c 30 00 74 08 48 89 df e8 6d 82 bc fd 4c 8b 3b 48 8b 44 24
RSP: 0018:ffffc9000090e620 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: ffff888015330000
RDX: 0000000000000000 RSI: 0000000100000845 RDI: 0000000000000000
RBP: ffffc9000090e6d8 R08: ffffffff843a8b4a R09: 1ffffffff1e48be5
R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: 0000000100000845
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88801d4f2058
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd0a027408 CR3: 00000000232cc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blk_account_io_start+0x189/0x2d0 block/blk-mq.c:1022
 blk_mq_bio_to_request block/blk-mq.c:2559 [inline]
 blk_mq_submit_bio+0x1043/0x1f40 block/blk-mq.c:2996
 __submit_bio+0x1bc/0x550 block/blk-core.c:627
 __submit_bio_noacct_mq block/blk-core.c:708 [inline]
 submit_bio_noacct_nocheck+0x3ed/0xc20 block/blk-core.c:737
 ext4_io_submit+0xd4/0x130 fs/ext4/page-io.c:377
 ext4_do_writepages+0x293b/0x38e0 fs/ext4/inode.c:2699
 ext4_writepages+0x20c/0x3b0 fs/ext4/inode.c:2768
 do_writepages+0x36f/0x880 mm/page-writeback.c:2656
 __writeback_single_inode+0xe2/0x660 fs/fs-writeback.c:1651
 writeback_sb_inodes+0x8ee/0x1140 fs/fs-writeback.c:1947
 __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2018
 wb_writeback+0x3e7/0x750 fs/fs-writeback.c:2129
 wb_check_old_data_flush fs/fs-writeback.c:2233 [inline]
 wb_do_writeback fs/fs-writeback.c:2286 [inline]
 wb_workfn+0xa29/0xf00 fs/fs-writeback.c:2314
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:update_io_ticks+0x94/0x2c0 block/blk-core.c:992
Code: f3 f3 f3 48 89 54 24 18 4a 89 04 32 e8 75 77 59 fd 48 c1 eb 03
48 89 5c 24 08 eb 03 4c 8b 2b 49 8d 5d 28 48 89 d8 48 c1 e8 03 <42> 80
3c 30 00 74 08 48 89 df e8 6d 82 bc fd 4c 8b 3b 48 8b 44 24
RSP: 0018:ffffc9000090e620 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000028 RCX: ffff888015330000
RDX: 0000000000000000 RSI: 0000000100000845 RDI: 0000000000000000
RBP: ffffc9000090e6d8 R08: ffffffff843a8b4a R09: 1ffffffff1e48be5
R10: dffffc0000000000 R11: fffffbfff1e48be6 R12: 0000000100000845
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88801d4f2058
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd0a027408 CR3: 00000000232cc000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: f3 f3 f3 48 89 54 24 repz repz xrelease mov %rdx,0x18(%rsp)
   7: 18
   8: 4a 89 04 32           mov    %rax,(%rdx,%r14,1)
   c: e8 75 77 59 fd       call   0xfd597786
  11: 48 c1 eb 03           shr    $0x3,%rbx
  15: 48 89 5c 24 08       mov    %rbx,0x8(%rsp)
  1a: eb 03                 jmp    0x1f
  1c: 4c 8b 2b             mov    (%rbx),%r13
  1f: 49 8d 5d 28           lea    0x28(%r13),%rbx
  23: 48 89 d8             mov    %rbx,%rax
  26: 48 c1 e8 03           shr    $0x3,%rax
* 2a: 42 80 3c 30 00       cmpb   $0x0,(%rax,%r14,1) <-- trapping instructi=
on
  2f: 74 08                 je     0x39
  31: 48 89 df             mov    %rbx,%rdi
  34: e8 6d 82 bc fd       call   0xfdbc82a6
  39: 4c 8b 3b             mov    (%rbx),%r15
  3c: 48                   rex.W
  3d: 8b                   .byte 0x8b
  3e: 44                   rex.R
  3f: 24                   .byte 0x24


Syzkaller reproducer:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1
Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false
NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false
KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false
Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
HandleSegv:false Trace:false LegacyOptions:{Collide:false Fault:false
FaultCall:0 FaultNth:0}}
write$syz_spec_18446744072532934322_80(0xffffffffffffffff,
&(0x7f0000000000)=3D"2b952480c7ca55097d1707935ba64b20f3026c03d658026b81bf26=
4340512b3cb4e01afda2de754299ea7a113343ab7b9bda2fc0a2e2cdbfecbca0233a0772b12=
ebde5d98a1203cb871672dff7e4c86ec1dccef0a76312fbe8d45dc2bd0f8fc2ebeb2a6be6a3=
00916c5281da2c1ef64d66267091b82429976c019da3645557ed1d439c5a637f6bf58c53bc4=
14539dd87c69098d671402586b631f9ac5c2fe9cedc281a6f005b5c4d1dd5ed9be400",
0xb4)
r0 =3D syz_open_dev$sg(&(0x7f00000000c0), 0x0, 0x181040)
ioctl$syz_spec_1724254976_2866(r0, 0x1, &(0x7f0000000080)=3D{0x0, 0x2,
[0x85, 0x8, 0x15, 0xd]})


--=20
Yours sincerely,
Xingyu

