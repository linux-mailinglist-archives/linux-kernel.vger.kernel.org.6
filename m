Return-Path: <linux-kernel+bounces-300217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC195E0B7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 04:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B2A1C20CC1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 02:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9644A3E;
	Sun, 25 Aug 2024 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="Lzq3gXCR";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="QCNsS7zE"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E2370
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724551707; cv=none; b=ZHfCfIw9lH/+ce+gPZ803WkNc+7nhBuSDBafwVvNMYHfW5q4msawRnpHZ+gezAENG+qj6vOMM+RH0bUeuKLrwZScUhPSA+5XLuJwS3fK05d1PFOFEjOlphAkoX2sCWKJ4hEUaD9BnmwpKYyPjrwiyApitPars4/NME+Ntd49GjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724551707; c=relaxed/simple;
	bh=P2XMtVAMRX2Cm+rBdQ892VJRFjWBWuv5Iq3DS4OisMw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i02Lpr2/1fu6IBL9xVslm21b3p+CQXQaLEMEGPUOofv0qvp8PkLi8vJFaSGLy//FSBPkl35InMmNKeVZdjM3AtKNJ8b5Vj1AoP6+ee4Se5IuRInf3JxsvGqw8E5a7siCP3wJZsquJ0H+mYFZfLyYxU+YPOaL3LFm0IWxkG31rRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=Lzq3gXCR; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=QCNsS7zE; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724551706; x=1756087706;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=P2XMtVAMRX2Cm+rBdQ892VJRFjWBWuv5Iq3DS4OisMw=;
  b=Lzq3gXCRteZXZ7nuPLuHj8FzDgp93mCr/xfyQ+qAz6EpQyekBbkeYn2b
   oyhsqhN4rg4JZ6KYI2LVvWx00z2ZinvXw7PzvETdWls90GcVSJXMr6PcP
   ZOnu1kFNl2j03GUhDghO5rZKXXKsVhmSIGnBf1cSnSmqByT0aU4NINvl5
   Af9DoFZVSRLR4qtFbALPyKXuFx+FqzKsMMGOo6HRnOs9I1i5roo57dMoL
   RHITibsaCLK3GJ/u29pOO8myaOP6bpqkktzzzqpocLW11e8jPFU5KU1JA
   ojpMrYJfKy2SUeUIEGkL2Faf5HeHRjqEcHCRwY/H42yYtZKC8qI6jgap0
   w==;
X-CSE-ConnectionGUID: auKwXbXEQH2FdQzwqNf31g==
X-CSE-MsgGUID: mEw0FNmhStqulX027rz0pQ==
Received: from mail-io1-f69.google.com ([209.85.166.69])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 24 Aug 2024 19:08:24 -0700
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-824c925d120so317982439f.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 19:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724551703; x=1725156503; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+tOT2BwNYoEYn2Q+HTw71mqzlg3wQSgfwGy0SB5UxVc=;
        b=QCNsS7zENuSw5tXdn1Eq1losxT2UEuOugCvZCGWtsrgksZGXF1i/ARJdTf5XIzkRae
         JgMzdxl90GUk2tGNeMIU1sQRslWMa0pUpPVguYdeYbG1yqmY6VpWGjH+Cjqlu4AEw3x8
         +/eXPTFzZ7vo7k5Rwos8y4TaFmmCe7qxuhSG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724551703; x=1725156503;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+tOT2BwNYoEYn2Q+HTw71mqzlg3wQSgfwGy0SB5UxVc=;
        b=dGQhslAOmAgO5KTJt9JASGUMH2LGt9ETWsuGdNjrT75P8YnJw7nyqxZ678xX6NnL2l
         At05hPo6v9AASfIXoe/JEDzYLz9+5pFMNweomvrbBS8PiknT7JdiB8OgCopoiJVvDscW
         xA8JSG1dbMwH/q6KqNSuyJsG0nZmRkPanCQ12RPg/+qvKTrxWiika5JcvIF8vQtyW4Nm
         TpS9AvSeLebSF2lKx2+QxoSepGfbzttxMFOPRz1hLPiJiruU69PUnTs+9+nO/MvHCuK2
         eFjfHDNpeYu3Iykntw2UJOa97ShHmV/ofoimivrfB/nHRm/aQzDdJj2nW4m62CsQKRvJ
         byCg==
X-Forwarded-Encrypted: i=1; AJvYcCWCId6fNPeRO4d720yFq3ccLE5qIi/Y+kP8b6jHcw2+4AXDtHLwOptlgKBxDVNYgbAmdHRzxIJcJfcaa2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ek2eARBiGJDpBkHOEIKYwhGeVks8KnxZ0mScHiX0Bw7Lr5YZ
	E4l3D0qPsuvYM+PSB84enZFohjR5VUG5S4fAHrMSySHXe1UE+dyaok6fAHiPwdGK+aniqUGDqdW
	pvB11t1xbNs6boSnpyc9FRbrbZ7AOd3sceuLg87DYuzgCdsjwGmZFDh4Mvxmwe9H2w0zLezR/WI
	sWB4aR5V74KvuNk9Xeny04zEChogLKtO3TMuYuYQ==
X-Received: by 2002:a05:6602:6b88:b0:803:83c0:6422 with SMTP id ca18e2360f4ac-8278813bc2dmr593945939f.9.1724551702713;
        Sat, 24 Aug 2024 19:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWmpfh5KtpHLGQDvCyMewsJ+mUdjEK9WbspRmK3nU6vzN7QM7yx3ZHO0OB1o7WKI4f4nDA+KFgpp7h24+IKT8=
X-Received: by 2002:a05:6602:6b88:b0:803:83c0:6422 with SMTP id
 ca18e2360f4ac-8278813bc2dmr593943939f.9.1724551702342; Sat, 24 Aug 2024
 19:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sat, 24 Aug 2024 19:08:10 -0700
Message-ID: <CANikGpcmGe1PLZjM6t8H6=P93aXg-jdaPFPUtkzLOXaKOprHmA@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in wake_up_bit
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `__wake_up_common`, when executing `ret = curr->func(curr, mode,
wake_flags, key);`, a NULL pointer dereference happened. According to
the report, the RIP is 0x0, it seems that the function pointer is used
without checking its value.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0010) - not-present page
PGD 0 P4D 0
Oops: Oops: 0010 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 1 Comm: systemd Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000003fc38 EFLAGS: 00010046
RAX: 1ffff920013daf09 RBX: 0000000000000000 RCX: ffffc9000003fce0
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffc90009ed7838
RBP: 0000000000000001 R08: 0000000000000003 R09: fffff52000007f64
R10: dffffc0000000000 R11: 0000000000000000 R12: ffffc90009ed7848
R13: 0000000000000000 R14: ffffc90009ed7838 R15: ffffffff8d80e360
FS:  00007ff4720ac900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000001532c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __wake_up_common kernel/sched/wait.c:89 [inline]
 __wake_up_common_lock+0x134/0x1e0 kernel/sched/wait.c:106
 __wake_up kernel/sched/wait.c:127 [inline]
 __wake_up_bit kernel/sched/wait_bit.c:126 [inline]
 wake_up_bit+0x18c/0x1f0 kernel/sched/wait_bit.c:149
 evict+0x487/0x630 fs/inode.c:678
 __dentry_kill+0x1fb/0x610 fs/dcache.c:607
 dput+0x197/0x2b0 fs/dcache.c:849
 __fput+0x5f0/0x8a0 fs/file_table.c:430
 __do_sys_close fs/open.c:1563 [inline]
 __se_sys_close+0x15b/0x1e0 fs/open.c:1548
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x7e/0x150 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7ff472517c6b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c
24 0c e8 a3 4d f9 ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 e1 4d f9 ff 8b 44
RSP: 002b:00007ffd335674a0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 00007ff4720ac6c8 RCX: 00007ff472517c6b
RDX: 00007ff4725fabe0 RSI: 0000000000000000 RDI: 0000000000000019
RBP: 0000000000000019 R08: 0000000000000000 R09: 000055e07191c838
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 00007ffd33567560 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:0x0
Code: Unable to access opcode bytes at 0xffffffffffffffd6.
RSP: 0018:ffffc9000003fc38 EFLAGS: 00010046
RAX: 1ffff920013daf09 RBX: 0000000000000000 RCX: ffffc9000003fce0
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffc90009ed7838
RBP: 0000000000000001 R08: 0000000000000003 R09: fffff52000007f64
R10: dffffc0000000000 R11: 0000000000000000 R12: ffffc90009ed7848
R13: 0000000000000000 R14: ffffc90009ed7838 R15: ffffffff8d80e360
FS:  00007ff4720ac900(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 000000001532c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

