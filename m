Return-Path: <linux-kernel+bounces-339905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4992E986C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE03C1F2292E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490C93A1DA;
	Thu, 26 Sep 2024 05:30:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE55223
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727328629; cv=none; b=d5ORC/EhHMIdLf6COK2j67h6Wj/hpAibQnZGfM6DFGOOoFh2weUD9zcUyK9a2PLDbsgHRVC6AMeveg3vFv6V7hR9lxD6lV6P9uLqIYmbQEKfN+UMwwJLaQXwaPsOjhAsRmrFBSsbrcp/AQt4s9LMina8YWwsY5w3oi+eF+atXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727328629; c=relaxed/simple;
	bh=mebvIZ2WJCFA1nFSlcQjCt2CfRZgaWvC+Yt1++doUnk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ObEOmhHyKwOiRK3BQTmi0hBD2ctLilp3W8NSs+k4gWwIjcrMNwe/7QQbVBVmqB89nkNNqFJSePjRXSGic7urMuR2smksTWp7A61Y5JPF1Oz/bvnEJ+HTsG6H5VhaTtLAMMiWt72/6j+sisTZxLaJSDpSDkc85DLlMn1ZhZE+b64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1a6d8bb03so8329425ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727328627; x=1727933427;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+DG2n49yH9O9N3pdkDt+zO7P1Vuu4TTd8T7h3UqeR4=;
        b=IFvI4OMoqTNr7jCQ+pLsgT9ptH4x4eMyhlVIuJVBH1LLSFVQBvtcHlARpeB0G1jmTU
         8ic+KUjlUGOGF6eZn8P4vmIkApvTeRGNBbkeIrOxw9t1HB2FudBVINOF9V8V1FF/6JWc
         KgpKSq1AesVq1LOvFy+zrziMjvfaZE/3SoQKWOkLciROHsTXMdgQFSrHfzO7MdRK+qq+
         iStOMq7owiB9WFLyguKEzDHGsyE4F7kBVUhJMXGant9aHFtGlub3lImx4KHKrQmuk/4f
         PumlptG7fqhAG5c4OWZlJiSPd0xiFADG6Xfqi5oN8ilv9sIZn7o7a2EaBV6E9PRHVKWM
         TxHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAJW0xtYQq/MkigWuvswDB0SoXxZFI9CDkpMPFdGJtfpv0/OafSZ/LwDv/TJhM2HUq3DdW+54WgCLexHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygVlxq57qW8hLtIeaITn202yjhdYRKFmPAW6aq+ao4iAxoh3qe
	icxi1FxWhRNgXqxUfO1Z1oOk3JZFXFg+NBCAgtT765zK4n1YlvtoJAjuxNfVnmNt0I7YsyhXoLl
	GmNNMCtFxYOihafZLC0Ts2lAqPpglLFsWqGpMxCEGGWtGhg1cRSTTbeY=
X-Google-Smtp-Source: AGHT+IHZ69wiWRSktXrVBvHmOeK7ii+yiWs8i58S0ZkRWlIoE6KaU2gf8lY4rxPaDTQjtKOo5kqNmMXkrT3/KK67fbLkk5GViJ2V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ce:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a26d7b5aa9mr63093825ab.23.1727328627250; Wed, 25 Sep 2024
 22:30:27 -0700 (PDT)
Date: Wed, 25 Sep 2024 22:30:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f4f173.050a0220.211276.003c.GAE@google.com>
Subject: [syzbot] [mm?] kernel BUG in page_table_check_clear (2)
From: syzbot <syzbot+645f216781b26a92a732@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1ec6d097897a Merge tag 's390-6.12-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173cdca9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6265dd30e362bb47
dashboard link: https://syzkaller.appspot.com/bug?extid=645f216781b26a92a732
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fcb080580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b76c27980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1ec6d097.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b74fa2b2b4e/vmlinux-1ec6d097.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ed852a3c5d1/bzImage-1ec6d097.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+645f216781b26a92a732@syzkaller.appspotmail.com

R10: 0000000000008031 R11: 0000000000000246 R12: 00007ffe75fa944c
R13: 431bde82d7b634db R14: 00007ffe75fa9460 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
kernel BUG at mm/page_table_check.c:90!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5134 Comm: syz-executor420 Not tainted 6.11.0-syzkaller-08068-g1ec6d097897a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:page_table_check_clear+0x395/0x550 mm/page_table_check.c:90
Code: c1 0f 8c 57 fd ff ff 48 89 df e8 26 25 f3 ff e9 4a fd ff ff e8 cc 66 8a ff 90 0f 0b e8 c4 66 8a ff 90 0f 0b e8 bc 66 8a ff 90 <0f> 0b e8 b4 66 8a ff 90 0f 0b e8 ac 66 8a ff 90 0f 0b f3 0f 1e fa
RSP: 0018:ffffc90002cdf1a0 EFLAGS: 00010293
RAX: ffffffff820a4e24 RBX: ffff88801b8c8098 RCX: ffff888000650000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffffffff820a4c86 R09: 1ffff11003719013
R10: dffffc0000000000 R11: ffffed1003719014 R12: 0000000000000000
R13: ffff88801b8c8050 R14: 00000000000001fe R15: 1ffffffff3483da4
FS:  0000555555871480(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5df7332584 CR3: 0000000011c16000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 page_table_check_pmd_clear include/linux/page_table_check.h:57 [inline]
 pmdp_huge_get_and_clear arch/x86/include/asm/pgtable.h:1390 [inline]
 pmdp_huge_get_and_clear_full include/linux/pgtable.h:636 [inline]
 zap_huge_pmd+0x940/0xc40 mm/huge_memory.c:2071
 zap_pmd_range mm/memory.c:1719 [inline]
 zap_pud_range mm/memory.c:1768 [inline]
 zap_p4d_range mm/memory.c:1789 [inline]
 unmap_page_range+0x762/0x40e0 mm/memory.c:1810
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1900
 unmap_region+0x214/0x380 mm/vma.c:354
 mmap_region+0x22f9/0x2990 mm/mmap.c:1573
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5df72dce29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe75fa93f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffe75fa9410 RCX: 00007f5df72dce29
RDX: b635773f06ebbeee RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 0000000000000002 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000008031 R11: 0000000000000246 R12: 00007ffe75fa944c
R13: 431bde82d7b634db R14: 00007ffe75fa9460 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:page_table_check_clear+0x395/0x550 mm/page_table_check.c:90
Code: c1 0f 8c 57 fd ff ff 48 89 df e8 26 25 f3 ff e9 4a fd ff ff e8 cc 66 8a ff 90 0f 0b e8 c4 66 8a ff 90 0f 0b e8 bc 66 8a ff 90 <0f> 0b e8 b4 66 8a ff 90 0f 0b e8 ac 66 8a ff 90 0f 0b f3 0f 1e fa
RSP: 0018:ffffc90002cdf1a0 EFLAGS: 00010293
RAX: ffffffff820a4e24 RBX: ffff88801b8c8098 RCX: ffff888000650000
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: 00000000ffffffff R08: ffffffff820a4c86 R09: 1ffff11003719013
R10: dffffc0000000000 R11: ffffed1003719014 R12: 0000000000000000
R13: ffff88801b8c8050 R14: 00000000000001fe R15: 1ffffffff3483da4
FS:  0000555555871480(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5df7332584 CR3: 0000000011c16000 CR4: 0000000000350ef0
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

