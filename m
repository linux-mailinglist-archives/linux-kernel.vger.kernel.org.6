Return-Path: <linux-kernel+bounces-399860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA209C0563
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D471C225FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2546E20C499;
	Thu,  7 Nov 2024 12:11:25 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961515B0F2
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981484; cv=none; b=GNarDeiDFC5+1xfhLh4/cwD/LcDn1rBDFMNmGAl8s+eHs3fgDYpPtn+X95pjAYNvzJ58dbs8f8/tYch8gPTh+HR3CsxCm/EtbTRNMI5pwT4vcTMWFyMa75GoA8tuyB+Cp4CusvMnfnlhv+IfXUM4Nkg2J65HPZmIsVQYDW6VNP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981484; c=relaxed/simple;
	bh=WlGrOTq2ZGCnMErwGwUv88XscMLz2bExy2OkM2PmUmI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FzwpSKgjHWzxWswz3xEuyztfEwfRDgPsl/wYbq/6bK3I0LRq5QHb1S2vulVPkKMVWfHQKdSCSzWLGr0WpSA837USawZCmUEGKdOWlU6lXlhSLa7xBD0jdpCxsZMjKYfJR2jTZOq9V6JuAIzzzhXf1HRUDQ4X1ZrkfFa/tYzQj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3da2d46b9so10564135ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:11:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730981482; x=1731586282;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAc+gN3U1lZ4dETJ1tEfH3oqqMme/6EXP07BmLXVE/k=;
        b=l5PAXRbW2KCHN9JeYV2CkduD8RQRxEH4TEzbD87cS5+BxIZYuKiMTSxhI8L2sMMDtF
         Pf26amMB51tX4p8aZw098KcZdgbA08QetzT0ost1xcPCfrFvWGpw+q0jKU0Z95oDDemT
         SRSgdP62XU+paJUofNZkTZ2U6kbPvDJ3EsrnW8IfboLSnGW2Rft++gBC50XcP3MY1N7V
         08aFkC9/X/v+pj70cDGrrcBGGx4O0S7kkf6ioLWUzFAv72mrWbYt5954RTasiEoE19sq
         3ujN5mO/eSsWC3PpFSTzhZy6AcTdctJ6QwUqapqNpsvLLP1qMsv1x8vvNh3g9WIArwNx
         mm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8QDweqqOCIvUZUR2b7ZrCHHLxg5JwN8aRKd7Xns2WkaNzjMDX7wKiwRtHspgvyWXz88h0kCSe8AcMeq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmQogSN6dex69ypv2bULX6U0/Yv6A2yRCRe+5h5OwDjSwJorIx
	0d6PHyb6jgT43e+sDjvPxCQQBswy2KnYdehIYEysjzHhRb1XUa+gYycC5wfMlUoYqX60u5q0WeH
	5G2pfrhlqrzkTn3/2uYIch4XeMm9YkPAZsC/wYcAsBypUPispT/2pbM4=
X-Google-Smtp-Source: AGHT+IGZVevAss48PSTHktohcmL7sCGUNN6VbrTZuUuWPMWwUi3mZvrDrA7itJWaqd/rNeHQxuzoUc4nlGJ1ikbOmLFP9ME5QXdJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11a7:b0:3a6:aade:e30f with SMTP id
 e9e14a558f8ab-3a6aadee5ffmr194760835ab.3.1730981481900; Thu, 07 Nov 2024
 04:11:21 -0800 (PST)
Date: Thu, 07 Nov 2024 04:11:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672cae69.050a0220.2619e7.014f.GAE@google.com>
Subject: [syzbot] [mm?] BUG: unable to handle kernel paging request in schedule
From: syzbot <syzbot+acb4e7a57eadb542630f@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3e5e6c9900c3 Merge tag 'nfsd-6.12-3' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a96b40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=672325e7ab17fdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=acb4e7a57eadb542630f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-3e5e6c99.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7df898d050b2/vmlinux-3e5e6c99.xz
kernel image: https://storage.googleapis.com/syzbot-assets/630f9b55fdbc/bzImage-3e5e6c99.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+acb4e7a57eadb542630f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (4096) and media sector size (512).
BUG: unable to handle page fault for address: ffffed1103eab90f
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 5ffcd067 P4D 5ffcd067 PUD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 16895 PID: 5323 Comm: syz.0.0 Not tainted 6.12.0-rc5-syzkaller-00308-g3e5e6c9900c3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:constant_test_bit arch/x86/include/asm/bitops.h:206 [inline]
RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:238 [inline]
RIP: 0010:tif_need_resched include/linux/thread_info.h:184 [inline]
RIP: 0010:need_resched include/linux/sched.h:2108 [inline]
RIP: 0010:__schedule_loop kernel/sched/core.c:6769 [inline]
RIP: 0010:schedule+0x155/0x320 kernel/sched/core.c:6782
Code: c1 eb 03 eb 0a 48 f7 45 00 08 00 00 00 74 2c bf 01 00 00 00 e8 ec e9 93 f5 31 ff e8 d5 b2 ff ff bf 01 00 00 00 e8 7b eb 93 f5 <42> 80 3c 23 00 74 d4 48 89 ef e8 bc 54 2f f6 eb ca 4c 8d 75 2c 4d
RSP: 0018:ffffc90001797150 EFLAGS: 00010297
RAX: 0000000080000001 RBX: 1ffff11003eab910 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff88801f55c880 R08: ffff888000ee5f03 R09: 1ffff110001dcbe0
R10: dffffc0000000000 R11: ffffed10001dcbe1 R12: dffffc00ffffffff
R13: 0000000000000000 R14: ffffffff8bcf4350 R15: ffff88801f55daf8
FS:  00007fcccefc56c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1103eab90f CR3: 000000003e6da000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 io_schedule+0x8d/0x110 kernel/sched/core.c:7574
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1309
 __filemap_get_folio+0xaf/0xbd0 mm/filemap.c:1900
 filemap_lock_folio include/linux/pagemap.h:788 [inline]
 collapse_file mm/khugepaged.c:1895 [inline]
 hpage_collapse_scan_file+0x1d07/0x6880 mm/khugepaged.c:2317
 madvise_collapse+0x602/0xd30 mm/khugepaged.c:2759
 madvise_vma_behavior mm/madvise.c:1100 [inline]
 madvise_walk_vmas mm/madvise.c:1274 [inline]
 do_madvise+0xce7/0x4700 mm/madvise.c:1461
 __do_sys_madvise mm/madvise.c:1477 [inline]
 __se_sys_madvise mm/madvise.c:1475 [inline]
 __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1475
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fccce17e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcccefc5038 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007fccce335f80 RCX: 00007fccce17e719
RDX: 0000000000000019 RSI: 0000000000800000 RDI: 00000000207fe000
RBP: 00007fccce1f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fccce335f80 R15: 00007ffedc3723c8
 </TASK>
Modules linked in:
CR2: ffffed1103eab90f
---[ end trace 0000000000000000 ]---
RIP: 0010:constant_test_bit arch/x86/include/asm/bitops.h:206 [inline]
RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:238 [inline]
RIP: 0010:tif_need_resched include/linux/thread_info.h:184 [inline]
RIP: 0010:need_resched include/linux/sched.h:2108 [inline]
RIP: 0010:__schedule_loop kernel/sched/core.c:6769 [inline]
RIP: 0010:schedule+0x155/0x320 kernel/sched/core.c:6782
Code: c1 eb 03 eb 0a 48 f7 45 00 08 00 00 00 74 2c bf 01 00 00 00 e8 ec e9 93 f5 31 ff e8 d5 b2 ff ff bf 01 00 00 00 e8 7b eb 93 f5 <42> 80 3c 23 00 74 d4 48 89 ef e8 bc 54 2f f6 eb ca 4c 8d 75 2c 4d
RSP: 0018:ffffc90001797150 EFLAGS: 00010297
RAX: 0000000080000001 RBX: 1ffff11003eab910 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: ffff88801f55c880 R08: ffff888000ee5f03 R09: 1ffff110001dcbe0
R10: dffffc0000000000 R11: ffffed10001dcbe1 R12: dffffc00ffffffff
R13: 0000000000000000 R14: ffffffff8bcf4350 R15: ffff88801f55daf8
FS:  00007fcccefc56c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed1103eab90f CR3: 000000003e6da000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	c1 eb 03             	shr    $0x3,%ebx
   3:	eb 0a                	jmp    0xf
   5:	48 f7 45 00 08 00 00 	testq  $0x8,0x0(%rbp)
   c:	00
   d:	74 2c                	je     0x3b
   f:	bf 01 00 00 00       	mov    $0x1,%edi
  14:	e8 ec e9 93 f5       	call   0xf593ea05
  19:	31 ff                	xor    %edi,%edi
  1b:	e8 d5 b2 ff ff       	call   0xffffb2f5
  20:	bf 01 00 00 00       	mov    $0x1,%edi
  25:	e8 7b eb 93 f5       	call   0xf593eba5
* 2a:	42 80 3c 23 00       	cmpb   $0x0,(%rbx,%r12,1) <-- trapping instruction
  2f:	74 d4                	je     0x5
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 bc 54 2f f6       	call   0xf62f54f5
  39:	eb ca                	jmp    0x5
  3b:	4c 8d 75 2c          	lea    0x2c(%rbp),%r14
  3f:	4d                   	rex.WRB


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

