Return-Path: <linux-kernel+bounces-422469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085549D9A04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7130A1669FE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E881D5CEE;
	Tue, 26 Nov 2024 14:56:37 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E071CEAB2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632996; cv=none; b=Q/nqL/EVPn4GmcE7jsxB10HF6FrsolrE8/w3gLYYsTsWF99pO77ZDCaDewML8cMRNml82XZM4Kf7/U2cvvCcPJrD+cXGQFBgHraDKXARs67R0/eoZE8sjw8P9zeG4ASFVulIovsk0QSQYasOQxIcDNM1NNJwQtbS05iMhnbnwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632996; c=relaxed/simple;
	bh=F+j6cctGB4BryAKUPypfbV98NiE0XfY/NTwLpKdF54o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dixsLg6q92EDlGwvXHeKPtYGbZAetb2AiO/vB4nIDCqfOYczl0lzwGwrQVVfnKYqa3qNk+1IKBaKZ2jE6nbGT0B4Fx4Z2s+Jm19t8zeteFS++Ig5hgziNQFawIqM8VZbCCfsfQVbJRvnDcCzOaeCkuayjGYAOF00Eq1oIajrfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a77a808c27so61056865ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 06:56:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732632994; x=1733237794;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zMM0lIHh2/RqH3sor6A84JpOsygfJ+R/zji3PChQLI=;
        b=L3Zl6Ph0+4m6Sw6e+wCgz4o7xl5JhpJITjBHPT1WQfWgLk1XBv0JAGa2u01jWo4X51
         XJZ4PyuyWlrJB7Q57WgpO9xKeoMibIQ/3+/7qsiMGH0JK43PyAMDJJC8OslxbLXEFG8W
         5Mh07QXXVRrJXvaxX/RH7OlBZE5oPrFW/MNBFE3VB1F/1HZA6wFP6/TWNf1fgVbtrH4a
         01zLG6QnMoj4yvyq2RI8tzwtasHvGoCdFvn/8DM8T/R14Za+lU69Ry2Vv04LBE5TMi4O
         dWot4eNU0qzaKdI/bdSxYZcRNVc+TKLchLWBNE7jozvtQncr9IZYZxhIZeeGnEbfTmwp
         gjXA==
X-Forwarded-Encrypted: i=1; AJvYcCUX+KCuFLQMpai4teiaEpAbraFWah6s1DUIEIuzvH9MdEehpJAMF3KsMKYpzftjQUcUkCY88cyp6z1LYYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaoCzh+kdBRb9m4F8SXn4R9Q/l5+oRN92/xTmD0aYmeHN2Kqhd
	NpfYrETC5oEEIyR1EF37rugbkxOZr2OwZaPFKK5YZRsBy+kqaLWDmuPqAmfRndez7q0eCISv6c7
	SnI5JD1rkvKgvMj/VN+y7kN25jeZTaMrxHGeGnaoJZDoh4p/FIK0cS4s=
X-Google-Smtp-Source: AGHT+IF4vTLZBM/7Ucb9mM1ExsDQfwNPt5krUvdKZJgRf6zjU57lT15KLvqofpV4n68CacPY97hvgQ07fRXbJC59MBtZwztXjw25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caa:b0:3a7:7ad4:fe78 with SMTP id
 e9e14a558f8ab-3a79af9c05emr161283425ab.19.1732632994451; Tue, 26 Nov 2024
 06:56:34 -0800 (PST)
Date: Tue, 26 Nov 2024 06:56:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6745e1a2.050a0220.1286eb.001d.GAE@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in __put_partials (2)
From: syzbot <syzbot+b271f27b05eb3340c195@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129cf75f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=54f7b2f59e7640e5
dashboard link: https://syzkaller.appspot.com/bug?extid=b271f27b05eb3340c195
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7562d921dc97/disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8fb84b5dec53/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cac8b3f180c1/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b271f27b05eb3340c195@syzkaller.appspotmail.com

BUG: kernel NULL pointer dereference, address: 0000000000000002
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 800000002fc40067 P4D 800000002fc40067 PUD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 25 Comm: kworker/1:0 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: slub_flushwq flush_cpu_slab
RIP: 0010:PagePoisoned include/linux/page-flags.h:293 [inline]
RIP: 0010:page_to_nid include/linux/mm.h:1647 [inline]
RIP: 0010:folio_nid include/linux/mm.h:1653 [inline]
RIP: 0010:slab_nid mm/slab.h:196 [inline]
RIP: 0010:__put_partials+0x26/0x130 mm/slub.c:3119
Code: 90 90 90 90 55 41 57 41 56 41 55 41 54 53 50 48 85 f6 0f 84 df 00 00 00 48 89 f3 49 89 fe 31 c0 48 89 04 24 45 31 ff 45 31 ed <48> 8b 03 48 83 f8 ff 0f 84 d3 00 00 00 4c 8b 63 10 48 c1 e8 3a 49
RSP: 0018:ffffc900001f7b18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffffff81718e6a
RDX: dffffc0000000000 RSI: 0000000000000002 RDI: ffff88803003f8c0
RBP: 0000000000000001 R08: ffffffff942ea8b7 R09: 1ffffffff285d516
R10: dffffc0000000000 R11: fffffbfff285d517 R12: 0000000000000002
R13: 0000000000000000 R14: ffff88803003f8c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 00000000667dc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 put_partials mm/slub.c:3164 [inline]
 flush_cpu_slab+0x2bf/0x450 mm/slub.c:3299
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
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
RIP: 0010:slab_nid mm/slab.h:196 [inline]
RIP: 0010:__put_partials+0x26/0x130 mm/slub.c:3119
Code: 90 90 90 90 55 41 57 41 56 41 55 41 54 53 50 48 85 f6 0f 84 df 00 00 00 48 89 f3 49 89 fe 31 c0 48 89 04 24 45 31 ff 45 31 ed <48> 8b 03 48 83 f8 ff 0f 84 d3 00 00 00 4c 8b 63 10 48 c1 e8 3a 49
RSP: 0018:ffffc900001f7b18 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000002 RCX: ffffffff81718e6a
RDX: dffffc0000000000 RSI: 0000000000000002 RDI: ffff88803003f8c0
RBP: 0000000000000001 R08: ffffffff942ea8b7 R09: 1ffffffff285d516
R10: dffffc0000000000 R11: fffffbfff285d517 R12: 0000000000000002
R13: 0000000000000000 R14: ffff88803003f8c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000002 CR3: 00000000667dc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	55                   	push   %rbp
   5:	41 57                	push   %r15
   7:	41 56                	push   %r14
   9:	41 55                	push   %r13
   b:	41 54                	push   %r12
   d:	53                   	push   %rbx
   e:	50                   	push   %rax
   f:	48 85 f6             	test   %rsi,%rsi
  12:	0f 84 df 00 00 00    	je     0xf7
  18:	48 89 f3             	mov    %rsi,%rbx
  1b:	49 89 fe             	mov    %rdi,%r14
  1e:	31 c0                	xor    %eax,%eax
  20:	48 89 04 24          	mov    %rax,(%rsp)
  24:	45 31 ff             	xor    %r15d,%r15d
  27:	45 31 ed             	xor    %r13d,%r13d
* 2a:	48 8b 03             	mov    (%rbx),%rax <-- trapping instruction
  2d:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  31:	0f 84 d3 00 00 00    	je     0x10a
  37:	4c 8b 63 10          	mov    0x10(%rbx),%r12
  3b:	48 c1 e8 3a          	shr    $0x3a,%rax
  3f:	49                   	rex.WB


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

