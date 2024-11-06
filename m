Return-Path: <linux-kernel+bounces-397370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D80A9BDB1E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2854B21546
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DEE188917;
	Wed,  6 Nov 2024 01:23:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0D10E5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730856206; cv=none; b=ecL7Qcc7BukS1Q5+9g0dRgmW/AJB4yEqhuyeMd24jGxrZA9l1GrjMsfZBuZLhTL/MO2wsCIDNIRQ13uyBGYH9Lz1TKeAr1NkXIbOIcq/gSb1Jqu/YVXhmJG7oPFG54PDCxoaosQ+R5OlZRYmh1AcPvm7ZfB6TBNIw//mM1J/Rkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730856206; c=relaxed/simple;
	bh=6yLlZITvH8NbUcq9Kta/gfra9Mp8do4AIJKyfJKp2Rs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cQrQcbz+qpbxRxU/0vPqonTonri0Bd66i5y4JgmT/JnH/jJtyzzZ5/q6I+A5SjDKcV5qK0XV2PbWkoqQHmbTAFCXE1QazgBJdmoUCw7ulYP2Q1YOEVrN+cFYMS9dxrimv2eFr/EbTl0Xjl5jLCYgCBtqlBOchDcJbKVzpu2j9m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83acaa1f819so649659639f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 17:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730856204; x=1731461004;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aT5WHJEhZBduW+KZdkbfOoPSA10DQ8oyIrv49jCOf+I=;
        b=LWF3HbVPxGMxeETtpadYJRwCiI26n56rnbjK90yobD6EoTa5Rq5kiF8a050g8HQz3D
         mVf4idZCFSNz2vsoGABqP7PI0e56Jo49XnwfKwyAY2KMOBs3BY0B22yghdPbZmooPS3I
         cPEq671LaNsWKPzfA4wp9/OrrXhJkRGfnfpGsgCwqbgpFW9XXP0Fr36wNiog3PtrPWjL
         vpczecEP+XH16ZgvNA9I8SbFTIe43eZnm6Pwb4T33bUGpVo4uT/uulAcrAKnGharZjOf
         ipAPpf5Qgqs98ge/KJEQvIonDVdk1e4jQzbmbXwpzZNJZ0nAsb0Gc1uj0eW/P8V2wkX6
         p5uw==
X-Forwarded-Encrypted: i=1; AJvYcCVemyVxIcSG0SlvqAXiknTbYxOHDJPZMX+ulIdCWH8rI4/qQ6kfiFzuObJiGvwvyTNWJkXHIQ492z++YEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjNrf0kSE7MHl2qk7AAth+dMjBDnLeW79L/+tKaw7Mm+Uw98NR
	10MLn3z8/DEvJKCnaq3+Q6PgEdb8ZyBkPH7uqYI/UEf3042Qcufavk1JjKrBo2YYWMaY9ZZksIs
	TvwjuVVIEFr9TR9ia5z4BW+dCMcGBRLzK6sOJ+4BmrteH8zUzTx7uNVo=
X-Google-Smtp-Source: AGHT+IGNT+x/SIDkLbkhDqsE277Z4mgZHTVfNbivms6UlbUnuM1sgEvxGaUckesLiE0/fJgX7vXhlH1vieR1gIX+9grdw7wbWbdZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1746:b0:3a6:c716:ab1f with SMTP id
 e9e14a558f8ab-3a6c716ae23mr121886285ab.9.1730856203780; Tue, 05 Nov 2024
 17:23:23 -0800 (PST)
Date: Tue, 05 Nov 2024 17:23:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ac50b.050a0220.2edce.1517.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in swap_reclaim_full_clusters
From: syzbot <syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    59b723cd2adb Linux 6.12-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1076c740580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b77c8a55ccf1d9e2
dashboard link: https://syzkaller.appspot.com/bug?extid=078be8bfa863cb9e0c6b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167aa1f7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110d86a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/699c7100a12a/disk-59b723cd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/74524a66d4bc/vmlinux-59b723cd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e81ed2bba0ef/bzImage-59b723cd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+078be8bfa863cb9e0c6b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 UID: 0 PID: 51 Comm: kworker/1:1 Not tainted 6.12.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events swap_reclaim_work
RIP: 0010:__list_del_entry_valid_or_report+0x20/0x1c0 lib/list_debug.c:49
Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 fe 48 83 c7 08 48 83 ec 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 19 01 00 00 48 89 f2 48 8b 4e 08 48 b8 00 00 00
RSP: 0018:ffffc90000bb7c30 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88807b9ae078
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000000004f R12: dffffc0000000000
R13: ffffffffffffffb8 R14: ffff88807b9ae000 R15: ffffc90003af1000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffaca68fb8 CR3: 00000000791c8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_move_tail include/linux/list.h:310 [inline]
 swap_reclaim_full_clusters+0x109/0x460 mm/swapfile.c:748
 swap_reclaim_work+0x2e/0x40 mm/swapfile.c:779
 process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x20/0x1c0 lib/list_debug.c:49
Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 fe 48 83 c7 08 48 83 ec 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 19 01 00 00 48 89 f2 48 8b 4e 08 48 b8 00 00 00
RSP: 0018:ffffc90000bb7c30 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88807b9ae078
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 000000000000004f R12: dffffc0000000000
R13: ffffffffffffffb8 R14: ffff88807b9ae000 R15: ffffc90003af1000
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffaca68fb8 CR3: 00000000791c8000 CR4: 00000000003526f0
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
   a:	f3 0f 1e fa          	endbr64
   e:	48 89 fe             	mov    %rdi,%rsi
  11:	48 83 c7 08          	add    $0x8,%rdi
  15:	48 83 ec 18          	sub    $0x18,%rsp
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 19 01 00 00    	jne    0x14d
  34:	48 89 f2             	mov    %rsi,%rdx
  37:	48 8b 4e 08          	mov    0x8(%rsi),%rcx
  3b:	48                   	rex.W
  3c:	b8                   	.byte 0xb8
  3d:	00 00                	add    %al,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

