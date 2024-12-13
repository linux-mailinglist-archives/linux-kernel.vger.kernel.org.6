Return-Path: <linux-kernel+bounces-444480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D499F078A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B743D286AA5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303E1B0F18;
	Fri, 13 Dec 2024 09:18:23 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CA1B0F1A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081502; cv=none; b=qtwoNf0L0OKmybWDYly7vBg8O+4Zg0K3hOiLIZzAUTUnOmxOpOw5bGNruvXSN8YNQ+PUd6uZyXyvhKde6tA63s6+8KaeUzflGVUeASvcoJvY32OW7+Uo++obMZDLL07kUpshqoTzim/jW8UO8xeNdJefrJJ68CX55+QOalhWSNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081502; c=relaxed/simple;
	bh=tsKvWnR8aa9ANu+HpZAMk0CqvhkTcM7amNADeYVkuz0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=un2sbGY77QoNqlMHy0LnRb4/gMSED15kfKt03QqBibByiDEWKLbQbWmEfZX2cZR2aqkdCMlmj2x0sLJurP1PJy1Cwo8wYaYyixNR5Qb0PV49zsbHrFIex9kTEQuOZjSKDDkwaZw9Febf/hiq9d815kbsdrwAQO+8R4IlVv26/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9cbe8fea1so16049925ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734081500; x=1734686300;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTS0zdkZSAnSz6xeVSDRmHWEJduoXXdOmU8y9NMoOlo=;
        b=X9vH8FuOzwieWhtC/yfDWhgvXIiGpu1Mmo1+fm6UM+djPvqrjUQNL1dRbtin0by2tQ
         nG0VcNNCZj46YQzV4fdHW22p4UOwhveW/wRFYTs+bAcRYNUYvlHDM4pOUA9cWpTwpouI
         dmx60EsioV7VHRO+IIyYArCpZemUiRs7ukSbLUHBbC3YKPG0VbK1J1XVZZFZH2VmSoVU
         8ZWHH05tP2Y+7tGbFQUjAHJ/dVwLbYQp19yG4QEPtcymMFMk2AiV6acci1lpWzkFyOg7
         A9lfyxX46QiLB6+F745xO4IBoAjx0sr1iIN9RcgKFvz+cZnOGHhUx0wqsljDvC7QL3PA
         xgfg==
X-Forwarded-Encrypted: i=1; AJvYcCXAoVSk8bJDd8PgL1RdjnZT0eWPt6hKDaIu452eih2G+26AjHA12nw/FEUHp2djs1Ss39ugt1A2nhCeuwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6cSZt518TmPg9V+vNxwyXq2zUdmS8RZ2Xwc8++8GKIYlAFF83
	zJ6g0D6WF5+LawVoo1opGukgArX2SnKRsAAO7RcnoDSFIEHju4s+GdjD4lsjTNH/xL5CsVKs+n8
	05Hi95G8w6yGMpzEa9w3leEpSFJMoA1MAN6/3PTTpYpDyX23xtUUD1zs=
X-Google-Smtp-Source: AGHT+IEqMzsgQBbFyp09z6WIKaiFL6FMRK7MuiM/kyCuVEC1qJWr+7ubBtRJ/20xWQK3NoFURsUICIFuVsMaF2Oi/Zzs3hqDw1Ba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0a:b0:3a7:7ee3:10a2 with SMTP id
 e9e14a558f8ab-3aff800ffdbmr16610115ab.19.1734081500547; Fri, 13 Dec 2024
 01:18:20 -0800 (PST)
Date: Fri, 13 Dec 2024 01:18:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675bfbdc.050a0220.1a2d0d.0007.GAE@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in deactivate_slab (2)
From: syzbot <syzbot+a4aee0aec9e2bdcac817@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    231825b2e1ff Revert "unicode: Don't special case ignorable..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1232acdf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=a4aee0aec9e2bdcac817
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dc23b60ff29a/disk-231825b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/377c8f65d53a/vmlinux-231825b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/09bc1abb7c7a/bzImage-231825b2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a4aee0aec9e2bdcac817@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000002
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 800000002f379067 P4D 800000002f379067 PUD 31b4e067 PMD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.13.0-rc2-syzkaller-00036-g231825b2e1ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: slub_flushwq flush_cpu_slab
RIP: 0010:PagePoisoned include/linux/page-flags.h:293 [inline]
RIP: 0010:page_to_nid include/linux/mm.h:1647 [inline]
RIP: 0010:folio_nid include/linux/mm.h:1653 [inline]
RIP: 0010:slab_nid mm/slab.h:201 [inline]
RIP: 0010:deactivate_slab+0x1f/0x370 mm/slub.c:3028
Code: 90 90 90 90 90 90 90 90 90 90 90 55 41 57 41 56 41 55 41 54 53 48 83 ec 48 49 89 f7 65 48 8b 04 25 28 00 00 00 48 89 44 24 40 <48> 8b 06 48 83 f8 ff 0f 84 12 03 00 00 49 89 fd 48 c1 e8 3a 48 8b
RSP: 0018:ffffc900000e7ad8 EFLAGS: 00010296
RAX: 07d990de08412b00 RBX: 0000000000000202 RCX: ffffffff817b117a
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88802f7cb3c0
RBP: 0000000000000000 R08: ffffffff9426d8b7 R09: 1ffffffff284db16
R10: dffffc0000000000 R11: fffffbfff284db17 R12: 0000607f4766a0e0
R13: ffff88801bee0000 R14: ffff8880b8600000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 000000007e682000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 flush_slab mm/slub.c:3248 [inline]
 flush_cpu_slab+0x195/0x450 mm/slub.c:3294
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
CR2: 0000000000000002
---[ end trace 0000000000000000 ]---
RIP: 0010:PagePoisoned include/linux/page-flags.h:293 [inline]
RIP: 0010:page_to_nid include/linux/mm.h:1647 [inline]
RIP: 0010:folio_nid include/linux/mm.h:1653 [inline]
RIP: 0010:slab_nid mm/slab.h:201 [inline]
RIP: 0010:deactivate_slab+0x1f/0x370 mm/slub.c:3028
Code: 90 90 90 90 90 90 90 90 90 90 90 55 41 57 41 56 41 55 41 54 53 48 83 ec 48 49 89 f7 65 48 8b 04 25 28 00 00 00 48 89 44 24 40 <48> 8b 06 48 83 f8 ff 0f 84 12 03 00 00 49 89 fd 48 c1 e8 3a 48 8b
RSP: 0018:ffffc900000e7ad8 EFLAGS: 00010296
RAX: 07d990de08412b00 RBX: 0000000000000202 RCX: ffffffff817b117a
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff88802f7cb3c0
RBP: 0000000000000000 R08: ffffffff9426d8b7 R09: 1ffffffff284db16
R10: dffffc0000000000 R11: fffffbfff284db17 R12: 0000607f4766a0e0
R13: ffff88801bee0000 R14: ffff8880b8600000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 000000007e682000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	55                   	push   %rbp
   c:	41 57                	push   %r15
   e:	41 56                	push   %r14
  10:	41 55                	push   %r13
  12:	41 54                	push   %r12
  14:	53                   	push   %rbx
  15:	48 83 ec 48          	sub    $0x48,%rsp
  19:	49 89 f7             	mov    %rsi,%r15
  1c:	65 48 8b 04 25 28 00 	mov    %gs:0x28,%rax
  23:	00 00
  25:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
* 2a:	48 8b 06             	mov    (%rsi),%rax <-- trapping instruction
  2d:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  31:	0f 84 12 03 00 00    	je     0x349
  37:	49 89 fd             	mov    %rdi,%r13
  3a:	48 c1 e8 3a          	shr    $0x3a,%rax
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


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

