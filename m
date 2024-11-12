Return-Path: <linux-kernel+bounces-405190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9FF9C4E13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EF01F24F19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CAF205E31;
	Tue, 12 Nov 2024 05:16:30 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8561FD7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388590; cv=none; b=QJzfYAFrASC4mzcZPENiW0qWVE6rmXoTo2YkKODnA8h7eW4ppcMGd9CfjXNMp23kwfdLghH/IVO1/aLyMmWo8k7CHjBeJ7hWlyFz5AifgFUGUBq07GoFD+9ZvxEAmP3/BBp/DWYgN2CuW/LwJRTO93HOCEj4LZasrJMSLfQK2WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388590; c=relaxed/simple;
	bh=0h2yxa1BvADATJKbZsHeOUog3m15KVv5gv0l9jl2Wq0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bl+yRle6DcMdnF98K9CdwmuLUgKVs3Ygd9voz91CA+cBSx/fIuB7TmGDe4yJRcCoFoVhYN8KzlHK2CsaD3fzqkuueuVq/ABpIPhPlf9fGYwmy/fXGNoJ6sc6U99y0ltV3YOOwmP3VQR40mhU2zvoRNXTBnTUUTFq9n/+vvBIr1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ab369a523so616461239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731388587; x=1731993387;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uRlkjyhqGfVdVXaAn9cBNd99mlZMQn1NrQpSrCI6ISs=;
        b=IkPuifP5qYrHhM2LfTmtsZJ8BqPb8Pj5s4mzD4NaGKFzdb25UMDsKx7RYyhV+hQ0kw
         lUDs4V6+Bn8L5gxh+NKoKvLJ7qS+oEtos7iMJ3Dxlk/4jjsZCpFS6SPHjQiKAE6DRur6
         ax721gD2vVwQtP5+eeu0tOI962NsADFLBOWRSipMZZ6mopXipUlru3gtMBuFawW3Yb5n
         BN+6zOy/8QChlZkCqvyxQE4EDUWnC8CBKUPYiMRobp9BKQYOgQh78PND0Z/2IZLgwh4q
         qipPpGE0/xAcBFG0WRDnh1tuO3b4KwL7CJB3a6G2Rap3bjYcUDh+pgSIao6j96n0i6bc
         rTbw==
X-Forwarded-Encrypted: i=1; AJvYcCVh0y+sKvYAeP8B8hDnM4f6wUn7Yi3PJUNmQ3sYR0g3hUSlu3NLUPrcI8jTAUCY0VfYzch4PHfbhK5ysCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtAkIzEgf4btDym4EBfzCgIr6qGA0qIMkLobsgwfIcQk0sDsp3
	rwE6jnqzfKRVYJQ2M1L1B67dg915NJBQR6uw3rIkEnNQ8r8vRIukTuUkRBWfbWsF/xBE5ZMXmIM
	B3eglpU18gGaY1252jEl5FEf14gzMnYC9R75z98z4tQFE/sYSeh+/oMI=
X-Google-Smtp-Source: AGHT+IHW5bbCBf/D1lkOcGUXV7pQlpQoKXjDNT/ylQS+rDxz3a+0qK6CBujYqmY/aI0Q5AIAUjyc4i+v2Ct6e9gYIhm8TCiD+c7s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ce:b0:3a6:c1ad:3a02 with SMTP id
 e9e14a558f8ab-3a70c8990e2mr11720555ab.24.1731388586830; Mon, 11 Nov 2024
 21:16:26 -0800 (PST)
Date: Mon, 11 Nov 2024 21:16:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732e4aa.050a0220.5088e.0007.GAE@google.com>
Subject: [syzbot] [mm?] kernel BUG in resv_map_release (3)
From: syzbot <syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    906bd684e4b1 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146cc0c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20d60fe605153ebe
dashboard link: https://syzkaller.appspot.com/bug?extid=f525fd79634858f478e7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ae035f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126cc0c0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-906bd684.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/34d4b570061f/vmlinux-906bd684.xz
kernel image: https://storage.googleapis.com/syzbot-assets/08ae18992ed1/bzImage-906bd684.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/hugetlb.c:1131!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 16399 Comm: syz-executor416 Not tainted 6.12.0-rc6-syzkaller-00169-g906bd684e4b1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:resv_map_release mm/hugetlb.c:1131 [inline]
RIP: 0010:resv_map_release+0x1f3/0x290 mm/hugetlb.c:1116
Code: a4 ff 48 85 db 75 1d e8 ab 1b a4 ff 48 8b 7c 24 08 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 e3 ea fa ff e8 8e 1b a4 ff 90 <0f> 0b 4c 89 ef e8 83 a6 05 00 e9 3d ff ff ff 48 89 ef e8 86 a5 05
RSP: 0018:ffffc9002634f900 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81e95f9b
RDX: ffff888020d6c880 RSI: ffffffff81e95fc2 RDI: 0000000000000007
RBP: ffff88802b289860 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88802b289860
R13: ffff88802b289860 R14: ffff888033f4ed88 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc9bfa142b8 CR3: 000000000df7c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kref_put include/linux/kref.h:65 [inline]
 hugetlb_vm_op_close+0x4a7/0x5b0 mm/hugetlb.c:5075
 remove_vma+0xa8/0x1a0 mm/vma.c:330
 exit_mmap+0x4e0/0xb30 mm/mmap.c:1937
 __mmput+0x12a/0x480 kernel/fork.c:1348
 mmput+0x62/0x70 kernel/fork.c:1370
 exit_mm kernel/exit.c:571 [inline]
 do_exit+0x9bf/0x2d70 kernel/exit.c:926
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc9bf9be159
Code: Unable to access opcode bytes at 0x7fc9bf9be12f.
RSP: 002b:00007fc9bf957178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007fc9bfa48338 RCX: 00007fc9bf9be159
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fc9bfa48338
RBP: 00007fc9bfa48330 R08: 00007fc9bf9576c0 R09: 00007fc9bf9576c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc9bfa4833c
R13: 000000000000000b R14: 00007ffda7c51e30 R15: 00007ffda7c51f18
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:resv_map_release mm/hugetlb.c:1131 [inline]
RIP: 0010:resv_map_release+0x1f3/0x290 mm/hugetlb.c:1116
Code: a4 ff 48 85 db 75 1d e8 ab 1b a4 ff 48 8b 7c 24 08 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f e9 e3 ea fa ff e8 8e 1b a4 ff 90 <0f> 0b 4c 89 ef e8 83 a6 05 00 e9 3d ff ff ff 48 89 ef e8 86 a5 05
RSP: 0018:ffffc9002634f900 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff81e95f9b
RDX: ffff888020d6c880 RSI: ffffffff81e95fc2 RDI: 0000000000000007
RBP: ffff88802b289860 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88802b289860
R13: ffff88802b289860 R14: ffff888033f4ed88 R15: dead000000000100
FS:  0000000000000000(0000) GS:ffff88806a700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffda7c52014 CR3: 00000000325ae000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

