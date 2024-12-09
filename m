Return-Path: <linux-kernel+bounces-437340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC3B9E9202
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3854D280EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E824221884E;
	Mon,  9 Dec 2024 11:20:22 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C133E1E48A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743222; cv=none; b=Pc4yXEXUiGn3wUPd6YJix4vYpcHbjj2UU8X3yghJtRaCqtR7F6JzDwktPshzco9PrruGomq8pFSRMmvDcUw6JZqYURBFNqFeHhH/ssYgJ+Z57me++UCN7CF+XnZU7Gf6TTMCnWRKAveIeBa8hguWvYsQJI9g03D2VP6ynK2vi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743222; c=relaxed/simple;
	bh=gv3k5bUUfMvgEeTWdoNo69gvWGg77ARw/8iyBjqzNkI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Posg+xeCZRFkmi+1aWBg307XSJOZS3qlln+Kd1LHocTY/nyjWWFZPXTL8MzgHPhCIFU43GBkrSzfRTTYJYgpi++qIYcp+Yzxne8Js07ovp8voRgkNhp6UFjgJiZLT5wQN5WrLn1AYDLlLc+B21KZ6WFboQuyL5+NP9nxcdDxuUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a812f562bbso44263625ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743220; x=1734348020;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c1Z55HRJnZ6tkjpxl7hN/deOPO0pijifB0azjb9acSE=;
        b=wuvwP5kQLOjf6vtmQFBXm9/suPg/2dWKIkJS/qd3yuULWSlz5oUhifkbM9888Qo5Zf
         O8hWD5NOF4CcT5XtxLHRZyCajzgTxqiquPA0XNLVOHkduRbHoMylejVxmqTsqw4jsMja
         AnD21BWijBs4WEh6Un8JgVYGlymkgZos+uOs/6Yq0SvDQuejtK8DxzIrEBqzF7yZ5Lgf
         bFo/9zw/o/RImjf9CESuzSM41iOMQWQm219c11I4BdEb5cl15EEhqalMMB+zjz7gaVNa
         JNmFlY8buCc4IZpjBjO60NuQt+uBVySKn24D+R57bAgUjKgrCewUq5ZpRU+J5IUgXuiL
         HrqA==
X-Forwarded-Encrypted: i=1; AJvYcCVBVuabqreEcgEXCBsDaWtGK7En+S/HM7OFW8V1QBlU7aFJx1Pp/xlyBrfMqrwcBG1ERBM19d6CuVxAmWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQEwv767msuFV5aj1TFzlSaujKpVfWB9l7ZcJy/JOeqeVWs9x
	TClcMMeQhhdBwWtEaV9CRyH69gknAqKYDi8Y+eoOl5cjWoHhYzy7B+hXp2swkofr7MoZnHtAPXs
	GIBSIBNcxFf3AJ/5uiSvpLr2IW4/0MtQ3tdfZjqLDC9SUO9nRoL0kMqI=
X-Google-Smtp-Source: AGHT+IFilrhJ+Po4uZb16XUvne4MVVRPmZ0HwWr35+QyNC8NTzDNFhrbyW68x4lCNnxHFgKK/0D80F1Gpwl0p4RXsx1f+aTPV6+u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c6:b0:3a7:e83c:2d10 with SMTP id
 e9e14a558f8ab-3a811e3fea2mr141988935ab.24.1733743219873; Mon, 09 Dec 2024
 03:20:19 -0800 (PST)
Date: Mon, 09 Dec 2024 03:20:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6756d273.050a0220.2477f.003d.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in find_mergeable_anon_vma
From: syzbot <syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, jannh@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    feffde684ac2 Merge tag 'for-6.13-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f85fc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=2d788f4f7cb660dac4b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-feffde68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6135c7297e8e/vmlinux-feffde68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c154fdcc9cb/bzImage-feffde68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2d788f4f7cb660dac4b7@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000080: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000400-0x0000000000000407]
CPU: 0 UID: 0 PID: 5319 Comm: syz.0.0 Not tainted 6.13.0-rc1-syzkaller-00025-gfeffde684ac2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:anon_vma_compatible mm/vma.c:1804 [inline]
RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 39 10 00 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf80000
RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 0000000000000000
RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b642
R10: 0000000000000003 R11: ffff88801cf80000 R12: 0000000000000080
R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4ca0
FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000140 CR3: 0000000040256000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __anon_vma_prepare+0xd9/0x4a0 mm/rmap.c:199
 anon_vma_prepare include/linux/rmap.h:164 [inline]
 uprobe_write_opcode+0x1a95/0x2d80 kernel/events/uprobes.c:516
 install_breakpoint+0x4fc/0x660 kernel/events/uprobes.c:1135
 register_for_each_vma+0xa08/0xc50 kernel/events/uprobes.c:1275
 uprobe_register+0x811/0x970 kernel/events/uprobes.c:1384
 bpf_uprobe_multi_link_attach+0xaca/0xdd0 kernel/trace/bpf_trace.c:3442
 link_create+0x6d7/0x870 kernel/bpf/syscall.c:5399
 __sys_bpf+0x4bc/0x810 kernel/bpf/syscall.c:5860
 __do_sys_bpf kernel/bpf/syscall.c:5897 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5895 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5895
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f137e97ff19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f137f7e8058 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f137eb46080 RCX: 00007f137e97ff19
RDX: 000000000000003c RSI: 00000000200012c0 RDI: 000000000000001c
RBP: 00007f137e9f3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f137eb46080 R15: 00007fff36be56b8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:anon_vma_compatible mm/vma.c:1804 [inline]
RIP: 0010:reusable_anon_vma mm/vma.c:1837 [inline]
RIP: 0010:find_mergeable_anon_vma+0x1e4/0x8f0 mm/vma.c:1863
Code: 00 00 00 00 fc ff df 41 80 3c 06 00 74 08 4c 89 ff e8 10 39 10 00 4d 8b 37 4d 89 ec 49 c1 ec 03 48 b8 00 00 00 00 00 fc ff df <41> 80 3c 04 00 74 08 4c 89 ef e8 ed 38 10 00 49 8b 5d 00 4c 89 f7
RSP: 0018:ffffc9000d3df500 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: ffffc9000d3df540 RCX: ffff88801cf80000
RDX: 0000000000000000 RSI: ffffffff900062a0 RDI: 0000000000000000
RBP: ffffc9000d3df610 R08: 0000000000000005 R09: ffffffff8bc6b642
R10: 0000000000000003 R11: ffff88801cf80000 R12: 0000000000000080
R13: 0000000000000406 R14: 0000000021000000 R15: ffff8880120d4ca0
FS:  00007f137f7e86c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020002240 CR3: 0000000040256000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 6 bytes skipped:
   0:	df 41 80             	filds  -0x80(%rcx)
   3:	3c 06                	cmp    $0x6,%al
   5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   9:	89 ff                	mov    %edi,%edi
   b:	e8 10 39 10 00       	call   0x103920
  10:	4d 8b 37             	mov    (%r15),%r14
  13:	4d 89 ec             	mov    %r13,%r12
  16:	49 c1 ec 03          	shr    $0x3,%r12
  1a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  21:	fc ff df
* 24:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1) <-- trapping instruction
  29:	74 08                	je     0x33
  2b:	4c 89 ef             	mov    %r13,%rdi
  2e:	e8 ed 38 10 00       	call   0x103920
  33:	49 8b 5d 00          	mov    0x0(%r13),%rbx
  37:	4c 89 f7             	mov    %r14,%rdi


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

