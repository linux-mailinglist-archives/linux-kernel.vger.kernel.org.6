Return-Path: <linux-kernel+bounces-440618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 391F09EC1C2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 02:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C157188A3C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AC31DF254;
	Wed, 11 Dec 2024 01:54:23 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4411422A8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733882062; cv=none; b=PTL7ydYhdCr76bGpzLOyudzTjFiiDvWrZxN10iK3przby5YhNOzRinwKdK/QpqS4j5RKEcQ8fgkv89I+ZQTkhrLpPDhdz3reSsPDxTmxAm3UJVJWx8Ql9wwoMeTEUmbnFiy/3oXyQSFGNf7+KUjGJZj4YyK0DYtzY3IlDjQvCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733882062; c=relaxed/simple;
	bh=PPUJl4Hj21/NpgKwiG1FpkHwhOObgsysMrURRmDNtcc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V+/PJycf/92Ki+ngWbGC5OTgbGFra3oWog7uxISICvkSSl7L0mEGrEx+zZKbXOj4FJHERcA9Tanv+shcmIp+dQCwd+lPEqLjxDNVyxBBu4pwmHOt3j4wUB20DzKdsWu6FDR0yj/iJYeTkve1mPPjSLIWEZqY2ajMQdZxQvJRyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-844c7998c63so134292339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 17:54:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733882060; x=1734486860;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XTBkCGqrlOArm3uxPVsBxLgqcsQhUMhoRwDz1H6FEa8=;
        b=Ot+Gx8KWSMt43+FJPWOCmyGE5+h0Uta60CyUwyJBj4m3dTTrE4SyOmwapHYIg/GVB7
         dPRKyK81gBK5dFkQr5V0nsDFZs5j3B3Xn7tnisse9b1UCM5AOrMKBBIHJ1nTG22S3pVv
         bzmolsS+DEu2QrENlYWwbw7+DC7THMPS0+4oXiIGYiDE+cM0PNjoIOoRtNSgzWOeUccA
         iKEMqKyuRAOeXLPu5Vgs3uNLk5fBan3ulC0LH0oR3eFToeZjp/MOakYV31X6eWi2hWLS
         CQenquZ5ldrEH78tnu/Y4iV9j0PrvBMtAj6fea6k2wX5lR2dtL6Bj9ErsC5YPk3sxebS
         rCTA==
X-Forwarded-Encrypted: i=1; AJvYcCUKNU052bKDXCIeiUECTbDC0hc6lFug3hf4SktMNfkJTECb6sVx7Bk1mgVE4phYV4ur3W1P1FbECvujMzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6rdhRFD7iOnYYs58+mKgWTcgj9WhhJiBYhlNSRk4aKhK8aJn
	6j0sNIlTzUCEbejTXcgUHABSrZ/zfGtUtGfQLc0CNDexXIdud0kvndhu3e287TBTEZhV1ebeWRf
	0Uf6FPPMvC7SdWB6RlpzLdNlkX88qJfkyM0CLNTiFnnn2JB9mKt63db0=
X-Google-Smtp-Source: AGHT+IG2Cd1vEtB/iNGAsQrfG0QsrTc/+Jxk7cRhPqb12MKk7UDeJLyAOgp21oTGExcBHHqU6BlLbuBC76TTK/CW7Gv0o6DZt+2e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1549:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3aa06bee088mr11677675ab.11.1733882060300; Tue, 10 Dec 2024
 17:54:20 -0800 (PST)
Date: Tue, 10 Dec 2024 17:54:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6758f0cc.050a0220.17f54a.0001.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks (2)
From: syzbot <syzbot+c0673e1f1f054fac28c2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b8f52214c61a Merge tag 'audit-pr-20241205' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164958df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c579265945b98812
dashboard link: https://syzkaller.appspot.com/bug?extid=c0673e1f1f054fac28c2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/27d16eb66738/disk-b8f52214.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e6e3d3856a3/vmlinux-b8f52214.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4a9277cf155/bzImage-b8f52214.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0673e1f1f054fac28c2@syzkaller.appspotmail.com

 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0x661/0x1080 mm/page_alloc.c:2657
 free_contig_range+0x133/0x3f0 mm/page_alloc.c:6630
 destroy_args+0xa87/0xe60 mm/debug_vm_pgtable.c:1017
 debug_vm_pgtable+0x168e/0x31a0 mm/debug_vm_pgtable.c:1397
 do_one_initcall+0x12b/0x700 init/main.c:1266
 do_initcall_level init/main.c:1328 [inline]
 do_initcalls init/main.c:1344 [inline]
 do_basic_setup init/main.c:1363 [inline]
 kernel_init_freeable+0x5c7/0x900 init/main.c:1577
 kernel_init+0x1c/0x2b0 init/main.c:1466
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
------------[ cut here ]------------
WARNING: CPU: 0 PID: 10473 at ./include/linux/rmap.h:217 __folio_rmap_sanity_checks+0x356/0x540 include/linux/rmap.h:217
Modules linked in:
CPU: 0 UID: 0 PID: 10473 Comm: syz.3.899 Not tainted 6.13.0-rc1-syzkaller-00182-gb8f52214c61a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__folio_rmap_sanity_checks+0x356/0x540 include/linux/rmap.h:217
Code: d2 b0 ff 49 8d 6f ff e8 28 d2 b0 ff 48 39 eb 0f 84 53 fe ff ff e8 1a d2 b0 ff 48 c7 c6 20 ac 7a 8b 48 89 df e8 db fb f6 ff 90 <0f> 0b 90 e9 36 fe ff ff e8 fd d1 b0 ff 49 89 ec 31 ff 41 81 e4 ff
RSP: 0018:ffffc900036b75d8 EFLAGS: 00010246
RAX: 0000000000080000 RBX: ffffea0001108000 RCX: ffffc9000de50000
RDX: 0000000000080000 RSI: ffffffff81e933a5 RDI: ffff88802e0d8444
RBP: ffffea000111ffc0 R08: 0000000000000000 R09: fffffbfff20be52a
R10: ffffffff905f2957 R11: 0000000000000006 R12: 0000000000000000
R13: 0000000000000410 R14: 0000000000000000 R15: dead000000000100
FS:  00007ffb8d5086c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1678a23712 CR3: 0000000068232000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __folio_add_rmap mm/rmap.c:1170 [inline]
 __folio_add_file_rmap mm/rmap.c:1489 [inline]
 folio_add_file_rmap_ptes+0x72/0x310 mm/rmap.c:1511
 set_pte_range+0x135/0x520 mm/memory.c:5065
 filemap_map_folio_range mm/filemap.c:3572 [inline]
 filemap_map_pages+0xb5a/0x16b0 mm/filemap.c:3681
 do_fault_around mm/memory.c:5280 [inline]
 do_read_fault mm/memory.c:5313 [inline]
 do_fault mm/memory.c:5456 [inline]
 do_pte_missing+0xdae/0x3e70 mm/memory.c:3979
 handle_pte_fault mm/memory.c:5801 [inline]
 __handle_mm_fault+0x103c/0x2a40 mm/memory.c:5944
 handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6112
 faultin_page mm/gup.c:1187 [inline]
 __get_user_pages+0x8d9/0x3b50 mm/gup.c:1485
 populate_vma_page_range+0x27f/0x3a0 mm/gup.c:1923
 __mm_populate+0x1d6/0x380 mm/gup.c:2026
 mm_populate include/linux/mm.h:3386 [inline]
 vm_mmap_pgoff+0x293/0x360 mm/util.c:585
 ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb8c77fed9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb8d508058 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffb8c946080 RCX: 00007ffb8c77fed9
RDX: 0000000000000002 RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007ffb8c7f3cc8 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000028011 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007ffb8c946080 R15: 00007ffd68dca078
 </TASK>


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

