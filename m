Return-Path: <linux-kernel+bounces-184682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7158CAA81
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AEAC1F228B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D0356771;
	Tue, 21 May 2024 09:11:36 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254E355C29
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282695; cv=none; b=LX1ba1Vgm2iTmnWFDDXarkBsleorU1PlMTdur4uiONVVm5FqDfsNmZqSDUQ9x+vwzYAolmiLyiSNdPenF1vBQ4Pi54v+1S7n2ilpucoo9mLSc7o7wGoEt90Oq+DTRydG+FheXpf1J7ObcqyNvr2pMHOdfWkZK802FYk9v8BACWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282695; c=relaxed/simple;
	bh=jgnQ6wmaKHbNvEHwOVfj9VogqXVupxEKa3YmTs+ZCg0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aikis5S5Du5jVTA9bmxKqOh4/t9VeoryWqKF+KlMdbu6oFaQ+j7wkIXk10JMx9QIoHc4+YZOxBcgZEIU5Blg2Dd3KLOzmk9lbIYT+jftWdyadtPOwyQatukPBMlbpo5cB7CZF46GxyJOudqOm2At/d7ZSQu8jWRnzlATnM2d+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7deb999eea4so1289204239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716282693; x=1716887493;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvGKGmO6+ntYMSuVfjxXLrTW9b/7sOga0PuNigSgnJM=;
        b=Jw47R88UmlnYs2b74NCCaPtGSqk3ulCZNl+5OY+5Zx2ky3XrxcWgGqMidFemojg9/n
         u/vX+jGz4ASMvUIwJ1EiSUiVie6BqsXEJ2eqLvnm9VcoTKDuVIQ10jBkfddZz1Hzk01L
         RgI/YXt6rsPcE/wqTHNcgs1TuFNOjaW7yCqwRS3WJMuLHoStjRVIWswhv6nxt+d7v8Yv
         bmHVquKTK5koG2NfpGDwMxQP39aWr3c9lwGnbJcmGZa3nftBDSaBiRz925Hx+sLNKvrG
         9BgUdT7RtpJjcMl1yalRJWEZLYjNRN652/7RB4BVw6V/bSRNTPLLlLgOT6dOXnmTa4CJ
         ku5w==
X-Forwarded-Encrypted: i=1; AJvYcCVDdPBWqT06ebLIGsMTZqt5d0qVYBeD9bRVrsRQO9ATN4P0qUN9UhWsJC3HsQTdrVAtWXhwzqLihYr5r4M1io1fkUvPaca+tnSkpbrX
X-Gm-Message-State: AOJu0YxU5A8B1BR+c4i4MBZRiPaQ3FKxRFwRe+pNoJs1Taj+7vFpetFR
	chMspbxEAzGldcDW/kDSDUPIsp4vmrU9aLIaSLz2BWflls/o3des8IjrFZJtlNiDavV0G/+1P3c
	oOh3zqnUD2kwGwNvvn0L3w6kt41xyb9a/HqCCrDvSt3XhqvjzRUNChQ8=
X-Google-Smtp-Source: AGHT+IFgTr/QCPjlKxXGwDpQT1Qxa/hNTo/rOBj/5t3EY+94YVMSGE3DIpRGbF2KSJvDhVCyDJS4G7Y7mY9ezKRNXjURotM4YKJO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c0f:b0:7de:a1dc:bf36 with SMTP id
 ca18e2360f4ac-7e1b521c4dcmr142055039f.4.1716282693207; Tue, 21 May 2024
 02:11:33 -0700 (PDT)
Date: Tue, 21 May 2024 02:11:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000435c360618f334d0@google.com>
Subject: [syzbot] [kernel?] general protection fault in srcu_invoke_callbacks
From: syzbot <syzbot+dfe85a6b612e19d45a07@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb6a9339efeb Merge tag 'mm-nonmm-stable-2024-05-19-11-56' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1276c97c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2ea586e11acd6ec
dashboard link: https://syzkaller.appspot.com/bug?extid=dfe85a6b612e19d45a07
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-eb6a9339.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21782c1528d1/vmlinux-eb6a9339.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c377678e8b1/bzImage-eb6a9339.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfe85a6b612e19d45a07@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000030: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000180-0x0000000000000187]
CPU: 0 PID: 5282 Comm: kworker/0:4 Not tainted 6.9.0-syzkaller-09699-geb6a9339efeb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: rcu_gp srcu_invoke_callbacks
RIP: 0010:rcu_seq_current kernel/rcu/rcu.h:138 [inline]
RIP: 0010:srcu_invoke_callbacks+0x158/0x490 kernel/rcu/srcutree.c:1732
Code: 48 c1 ea 03 80 3c 02 00 0f 85 02 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 38 48 8d bb 80 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d2 02 00 00 48 8b b3 80 01 00 00 48 8d 85 20 ff
RSP: 0018:ffffc90003c17bf8 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff816d1bfd
RDX: 0000000000000030 RSI: 0000000000000004 RDI: 0000000000000180
RBP: ffffe8ffad054220 R08: 0000000000000001 R09: fffff52000782f71
R10: 0000000000000003 R11: 0000000000000002 R12: 1ffff92000782f83
R13: ffffe8ffad054140 R14: ffffc90003c17c38 R15: ffffc90003c17d80
FS:  0000000000000000(0000) GS:ffff88802c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc3fbc5ffc9 CR3: 0000000053e80000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rcu_seq_current kernel/rcu/rcu.h:138 [inline]
RIP: 0010:srcu_invoke_callbacks+0x158/0x490 kernel/rcu/srcutree.c:1732
Code: 48 c1 ea 03 80 3c 02 00 0f 85 02 03 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5b 38 48 8d bb 80 01 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 d2 02 00 00 48 8b b3 80 01 00 00 48 8d 85 20 ff
RSP: 0018:ffffc90003c17bf8 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff816d1bfd
RDX: 0000000000000030 RSI: 0000000000000004 RDI: 0000000000000180
RBP: ffffe8ffad054220 R08: 0000000000000001 R09: fffff52000782f71
R10: 0000000000000003 R11: 0000000000000002 R12: 1ffff92000782f83
R13: ffffe8ffad054140 R14: ffffc90003c17c38 R15: ffffc90003c17d80
FS:  0000000000000000(0000) GS:ffff88802c000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc3fbc5ffc9 CR3: 0000000053e80000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 c1 ea 03          	shr    $0x3,%rdx
   4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   8:	0f 85 02 03 00 00    	jne    0x310
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	48 8b 5b 38          	mov    0x38(%rbx),%rbx
  1c:	48 8d bb 80 01 00 00 	lea    0x180(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 d2 02 00 00    	jne    0x306
  34:	48 8b b3 80 01 00 00 	mov    0x180(%rbx),%rsi
  3b:	48                   	rex.W
  3c:	8d                   	.byte 0x8d
  3d:	85 20                	test   %esp,(%rax)
  3f:	ff                   	.byte 0xff


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

