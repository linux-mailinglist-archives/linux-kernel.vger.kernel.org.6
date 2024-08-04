Return-Path: <linux-kernel+bounces-273734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02825946D25
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 09:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2720C1C20A12
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 07:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF36E1A277;
	Sun,  4 Aug 2024 07:57:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54BE545
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758225; cv=none; b=dIqoRM6hpcPKEiMo0i38B33EUhSvNlHxbrQ6dJ12Y6qRTab91f4Z+LFvVBARc9vtnN0WkYiVgNE9Mkt18yqeA8RL3LiaYwhym32iokQap63KgrN4RUGk28oqYT032W3gxHq0wT1463uRfgTWB6s9Vr3p6CEP7DuMGrCvDnFL2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758225; c=relaxed/simple;
	bh=fWI/5DjHpZnnjwxHkdkLUhqTDrG4f3YFFMGup/TPgP0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jsfuXiGBVDU243tk9phLh5l0RGXzZgBcujvi59msFh/2z0OgXZLynO38tLbGNSDfY9ZNk8q/g5F8GNdtad/C4jYuNwVluLl22lzbTzQ1D9Nxs17VRGQ983aAhAI4lJVRni67CrX/SWhcETuFFJcrBiu4UtnODXNaAWyiXby3ZFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f86fc9fdaso1366756939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 00:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758223; x=1723363023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBLUhMpYt54/61pecPnjOIcKl0dqmprp2PUzPy6QbwI=;
        b=wcl8nX9XSRc/KgJio44eMc8gVlj+iFfyABaLY9jAD+l3iec2VE7chl898xyb8+r49Q
         PJ60sdFysHSGd2bjZ5QJ1BUMZFnfsVTvjxGJQPBNfwbTJqSJMJEa9E4LYsi46BWcf7Yg
         8KPgjyvbPUf7/+HmqvW5kfCZpmxv3KaaZSgCQ/vSpLJyNpryG1niBmM/Blxxh90WRM4u
         yA+afACqBvRPDethPapZJpmCcycl6jijI7w0IVc0lVNAAZuKiaK42khcD0nlMHLyvZBy
         xPg+hIZNOA20CQ3yz/bozHGV0JR7vbfAlFCGb4Nk69bluUxOs2L1CrYWdxQmAMsHacQg
         q7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXGrpL7YmivtZ6BZ9Wm4oSLNq55gwqyY1ki6lmCRdl/VdfCfsVBCq1j3B3BysHZ3YicE+5zx5r2L9bw369SXFu3n0Huf1DB3s3jJq4/
X-Gm-Message-State: AOJu0Yx1RPSgFQX52zp4gHTxYFxSVJuSAYvaXRdx5nc8cm2TfkhDFuM+
	kawnmW4XojISa1l0kmZt4pYMuymRUlIr86t7KLkqVDJu94buvLnyzjMHS7fLD7FpOMA/nVU9hqQ
	T2NboJouy3p7IPEQkaRwnwCNFscWgxAxoqPAc6TNAx5HpgtbVDi1WQqI=
X-Google-Smtp-Source: AGHT+IFnH1ziE/oD+332X9AsACWKYFP8Qs0BYNHSCIw3T2atj1+L2rW2U1oBCgy9ONc2vwt9Ppj+2U88PL6CSKSS9f+iDBWgstMb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:b0:4c2:7945:5a32 with SMTP id
 8926c6da1cb9f-4c8d56c392amr527539173.5.1722758222970; Sun, 04 Aug 2024
 00:57:02 -0700 (PDT)
Date: Sun, 04 Aug 2024 00:57:02 -0700
In-Reply-To: <tencent_3753976AB76BE6C03368E36CC96363BE2405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea1291061ed6e7d0@google.com>
Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
From: syzbot <syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in lmLogSync

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 PID: 114 Comm: jfsCommit Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:write_special_inodes fs/jfs/jfs_logmgr.c:208 [inline]
RIP: 0010:lmLogSync+0x130/0xae0 fs/jfs/jfs_logmgr.c:935
Code: a6 fe 49 8d 5f f0 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 1e 97 d3 fe 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 01 97 d3 fe 48 8b 3b e8 b9 c5 a6
RSP: 0018:ffffc90002cefc00 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 328fe0b8e03e5b00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002cefd18 R08: ffffffff81cbb49a R09: 0000000000000000
R10: ffffc90002cef9e8 R11: fffff5200059df6b R12: ffff88806a112800
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff88807cb0ba38
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055559488b938 CR3: 000000000e132000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_syncpt+0x7d/0xa0 fs/jfs/jfs_logmgr.c:1041
 txEnd+0x30f/0x560 fs/jfs/jfs_txnmgr.c:549
 txLazyCommit fs/jfs/jfs_txnmgr.c:2684 [inline]
 jfs_lazycommit+0x634/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:write_special_inodes fs/jfs/jfs_logmgr.c:208 [inline]
RIP: 0010:lmLogSync+0x130/0xae0 fs/jfs/jfs_logmgr.c:935
Code: a6 fe 49 8d 5f f0 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 1e 97 d3 fe 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 01 97 d3 fe 48 8b 3b e8 b9 c5 a6
RSP: 0018:ffffc90002cefc00 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 328fe0b8e03e5b00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002cefd18 R08: ffffffff81cbb49a R09: 0000000000000000
R10: ffffc90002cef9e8 R11: fffff5200059df6b R12: ffff88806a112800
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff88807cb0ba38
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055559488b938 CR3: 000000002bf6a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)
   1:	fe 49 8d             	decb   -0x73(%rcx)
   4:	5f                   	pop    %rdi
   5:	f0 48 89 d8          	lock mov %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 1e 97 d3 fe       	call   0xfed3973a
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 30          	add    $0x30,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 01 97 d3 fe       	call   0xfed3973a
  39:	48 8b 3b             	mov    (%rbx),%rdi
  3c:	e8                   	.byte 0xe8
  3d:	b9                   	.byte 0xb9
  3e:	c5                   	.byte 0xc5
  3f:	a6                   	cmpsb  %es:(%rdi),%ds:(%rsi)


Tested on:

commit:         50736169 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16ca70f3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12f98862a3c0c799
dashboard link: https://syzkaller.appspot.com/bug?extid=eda89a33c5856f66f823
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1688319d980000


