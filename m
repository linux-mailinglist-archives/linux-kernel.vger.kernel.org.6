Return-Path: <linux-kernel+bounces-303820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1796156E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E627A1C22CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3EA1CFEB7;
	Tue, 27 Aug 2024 17:28:34 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A91BF329
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779714; cv=none; b=TPrA88i+cdLe2M5QEySMhazbRf8aIm+7BgoTt9oy/uUvdiK44/rv38wRDblrlUEQssw9gvaKBqEQUV+8K/UuEFoN19VBdbR7glZWMmama8QkwawVq5aILBHQLgz0z05XmwVWrc1Uoy8jqn7ICz8zMHy1c1IGnBMv5CTCAQ35nM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779714; c=relaxed/simple;
	bh=wwb8nKB4B/nJax5vJleZPaRNqKCxzZ8UzV46o5Ma/jA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=B88n2+wY4lV9vUVAEuC2H+H4T45W+RHH4Nlxk722+16gIDtYpdZZz+7d2plBmqKJMnfXm1BcHRxw+2/JAIXkxLsqq0PcKvRqfq924pBIhtpdE1rn542AmGCTOEaLXMcdw3Wr+l5qkNSWLng7zhHcth7jj2GlU7pvEEpNLebENUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-829f8b33dc6so82403239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724779710; x=1725384510;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BPdFNQV8hE6NdPUPYNv61RkrsMR/Y2yvk7IMsO/4QFI=;
        b=H3N6mlhEwUPFRhKUlTylmWpwAo1vgOQkYP6IuPFparlVTMqY6JnEU/XNtTugirpg9s
         Ljy/jCANhsftAlaKUG5rQsAsDp+XrBCKP56HLFau+ftV3TzFHGnOcMnfUxfilpGSSaes
         44RYFYR0kbX3iQqKHyuqa2dNOcHHxaVoKPTdQMwFu0YKwHQCJWfTXlGuEOqpCZLchTC2
         XoNbIJAdrtXJGhP0yeNzQOx3/x50d/wYqwM2yS4Gsdo13X2KyhI3wWgG+HtFTBGZ8Fsk
         /JQbRBwROTwEnNZhgYp/EzB8zeG+UC7QNPU/ESSCQAle85ZGhevXrWFOACDLNC0LBbwx
         0P/w==
X-Forwarded-Encrypted: i=1; AJvYcCUSF73WZAlNWO8seGV/I/2zahh7lUOitlyVuxiAXbkXCn9uN3lxTeiBdloMUxnkAiwLygWvu31GC1gs3/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgr3ECkmqPGoEbBjoloM0CxWcUAYQwZjZwwonac5OS0yNx7ih
	jo21Q1k8kUTJhkX2MEV3aJsYtQ7pvsgop6zozHfvOBz+3TPvr76GEh47VhoBDt6bunJIH2wQWhq
	KPgERQPVC6mv531Cy0u193xiakuzjvjE5sCDLEis2eGeDXsvuSjqERl4=
X-Google-Smtp-Source: AGHT+IHpwS4ytjJui1CjtnwDOci4hxz8VYMPRH/O+vl+i00LXSDbC9FjUjYFooDbNR7O+NgShgYfWOKjayGOtIWSlxEw1Yeb6VJS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3006:b0:4c0:a8a5:81e9 with SMTP id
 8926c6da1cb9f-4ceb528e640mr198948173.3.1724779709881; Tue, 27 Aug 2024
 10:28:29 -0700 (PDT)
Date: Tue, 27 Aug 2024 10:28:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec6b3f0620ad9124@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel paging request in mmap_region
From: syzbot <syzbot+3bca0d9eb36e75bc36ed@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    94ede2a3e913 profiling: remove stale percpu flip buffer va..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122f6d9d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0cca2f3880513d
dashboard link: https://syzkaller.appspot.com/bug?extid=3bca0d9eb36e75bc36ed
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e10dde6d5041/disk-94ede2a3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bda8d01811d/vmlinux-94ede2a3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/653dc61d9ae6/bzImage-94ede2a3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3bca0d9eb36e75bc36ed@syzkaller.appspotmail.com

kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
BUG: unable to handle page fault for address: ffffea000169a5c0
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0011) - permissions violation
PGD 13fff7067 P4D 13fff7067 PUD 13fff6067 PMD 800000013d4001e3 
Oops: Oops: 0011 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6910 Comm: syz.0.357 Not tainted 6.11.0-rc1-syzkaller-00043-g94ede2a3e913 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:0xffffea000169a5c0
Code: ad de 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 24 00 24 00 00 00 00 00 ff ff ff fd 01 00 00 00 01 e8 e4 2c 80 88 ff ff <00> 00 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00 22 01 00 00 00 00
RSP: 0018:ffffc90002e0f8f8 EFLAGS: 00010286
RAX: 1ffff1100be13426 RBX: ffff88805f09a130 RCX: dffffc0000000000
RDX: ffff88807f842600 RSI: 0000000000000002 RDI: ffff88805f09a120
RBP: ffffc90002e0fa30 R08: ffff88802b3aecc7 R09: 1ffff11005675d98
R10: dffffc0000000000 R11: ffffea000169a5c0 R12: ffff88807f842600
R13: ffff88805f09a120 R14: ffff88802b3aed50 R15: ffff88802b3aecb8
FS:  00007f32016ce6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffea000169a5c0 CR3: 000000005af9c000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 mmap_region+0x1891/0x2090 mm/mmap.c:3058
 do_mmap+0x8f9/0x1010 mm/mmap.c:1468
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1514
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3200977299
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f32016ce048 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f3200b06058 RCX: 00007f3200977299
RDX: 0000000000000001 RSI: 0000000000003000 RDI: 0000000020000000
RBP: 00007f32009e48e6 R08: 0000000000000012 R09: 0000000000000000
R10: 0000000000000012 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f3200b06058 R15: 00007ffebfee75d8
 </TASK>
Modules linked in:
CR2: ffffea000169a5c0
---[ end trace 0000000000000000 ]---
RIP: 0010:0xffffea000169a5c0
Code: ad de 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 24 00 24 00 00 00 00 00 ff ff ff fd 01 00 00 00 01 e8 e4 2c 80 88 ff ff <00> 00 00 00 00 f0 ff 00 00 00 00 00 00 00 00 00 22 01 00 00 00 00
RSP: 0018:ffffc90002e0f8f8 EFLAGS: 00010286
RAX: 1ffff1100be13426 RBX: ffff88805f09a130 RCX: dffffc0000000000
RDX: ffff88807f842600 RSI: 0000000000000002 RDI: ffff88805f09a120
RBP: ffffc90002e0fa30 R08: ffff88802b3aecc7 R09: 1ffff11005675d98
R10: dffffc0000000000 R11: ffffea000169a5c0 R12: ffff88807f842600
R13: ffff88805f09a120 R14: ffff88802b3aed50 R15: ffff88802b3aecb8
FS:  00007f32016ce6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffea000169a5c0 CR3: 000000005af9c000 CR4: 0000000000350ef0


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

