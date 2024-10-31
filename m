Return-Path: <linux-kernel+bounces-389973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A6C9B73F1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 05:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6511F221B7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7DC13A89A;
	Thu, 31 Oct 2024 04:54:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466813174B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730350465; cv=none; b=Fx2a+2avwdtMAR10WPLVkEF2kZJQnD7ecdvP1EhIM4i4BfQOAoNFeDQI3laXVq4rH2yLKMwjh8mU5Zbh33vgHokBtbglrKCobxYF47TF1ZqUdqqYO/S6UyEIFHJkZQXEQ5swjBH8DGCOQDNHqHlW9LWrmkhF57RvwXJEjpe0g+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730350465; c=relaxed/simple;
	bh=y6I2wuZK7ZvBbjMtA4s6V/h9dZcFJgKi76oAoACAN70=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kBSKhqgGxiKZibU4MPSz9HaDOc/jWkhMrd3DzZ9YtWZmkw/8nND2iADF3CALSbUtID23Ku/2eUuGTNyedSM1HhoejyMW5tSk52ZOTGiwZVbJ8yYP3uDWHbxNVBA+zoj8EnHYfGxZ8AcI8cxWnFfmo1dMfHgfvOe2F8+bPgsh39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so5097315ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730350462; x=1730955262;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtDbAjdsgzcWKz/FOa3oeNb8HB5AJBpHDCiEvwdNOgs=;
        b=Ji5Eb1ANjjNZQCjvc+qQVnBuznSM1+vYrocl4cnJod6fcYARZfkYZNV9/oXInfNxKg
         w054TRQVqiGRlCwLtni9XP1X+3Obp0I4RXNQUHOrjnx268PPeUUM1ul+EMyAAf6lpaOn
         /wJEN+S3rASxCB2hBwobYX4RkJ++LDDSZouFg5vfyRU0cRD0b5iw7ixb3wO4aVIY4gC8
         fm03u3WCzTuPH4CxVOShuFHGpESLGCbPD8LU2279x/s363yKfbUxXRQzDGD4CKgsOBfI
         ihshXICyn5HKE/WX57vM2A8SPgW/6EkSZFiBUa704nO1k3IXbpzHxbcvAGvFObfomSCp
         jMRg==
X-Forwarded-Encrypted: i=1; AJvYcCVyy6y0NingH8HAdAWPU5SH09zZbBuwhDkPQtFP2xEHaq6qGVjmdvMYbYAukM6WJUXdc2d03ICzXMYFz5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuKFYXRa9lAb64yeaQHupeZXz1fvxmn8+Eraj0khAIgIZyai6E
	PdtR5cDJpiIvwahZo+5OkWKKj77gRJw9nt6YOmzMYj2QtAmr2V8N9NJCXQXnmp8zaEsoIck2vJx
	2AhVP8RNCTK/pM/4WgaZlgNy29NfIubHdp2fvJIl0b/c5lrdLZ3OH3V0=
X-Google-Smtp-Source: AGHT+IHIH8j2LHXa9325YhwJBFYe+BcCApf331ZrDE2/kvziFBEGKho65ZAR/dwGZzL4hYMvzJJhqotuwtc+AQEbpSZeu4zICcDo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3a6:ac17:13e5 with SMTP id
 e9e14a558f8ab-3a6ac171810mr1430135ab.11.1730350462032; Wed, 30 Oct 2024
 21:54:22 -0700 (PDT)
Date: Wed, 30 Oct 2024 21:54:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67230d7e.050a0220.529b6.0005.GAE@google.com>
Subject: [syzbot] [mm?] kernel BUG in __page_table_check_zero (2)
From: syzbot <syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    850925a8133c Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1346c940580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=ccc0e1cfdb72b664f0d8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158ab65f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120e6a87980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/da8019730dec/disk-850925a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b1ee80babbbc/vmlinux-850925a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/462580e2ad54/bzImage-850925a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ccc0e1cfdb72b664f0d8@syzkaller.appspotmail.com

Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffede422258 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffede422280 RCX: 00007f69e1b3c569
RDX: 0000000002000005 RSI: 0000000000003000 RDI: 000000002001a000
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000080000000
R10: 0000000000011012 R11: 0000000000000246 R12: 00007ffede42227c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
------------[ cut here ]------------
kernel BUG at mm/page_table_check.c:157!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5850 Comm: syz-executor279 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__page_table_check_zero+0x274/0x350 mm/page_table_check.c:157
Code: c1 0f 8c 39 fe ff ff 48 89 df e8 87 28 f3 ff e9 2c fe ff ff e8 dd 6a 89 ff 90 0f 0b e8 d5 6a 89 ff 90 0f 0b e8 cd 6a 89 ff 90 <0f> 0b f3 0f 1e fa 4c 89 f6 48 81 e6 ff 0f 00 00 31 ff e8 95 6f 89
RSP: 0018:ffffc900046bf6d8 EFLAGS: 00010293
RAX: ffffffff820b7fa3 RBX: dffffc0000000000 RCX: ffff88802fc13c00
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88801e97380c
RBP: ffff88801e97380c R08: ffff88801e97380f R09: 1ffff11003d2e701
R10: dffffc0000000000 R11: ffffed1003d2e702 R12: ffff88801e9737c0
R13: 1ffffffff34887b4 R14: 0000000000000002 R15: 0000000000000000
FS:  0000555570714380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f69e1b92385 CR3: 0000000073ae6000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 page_table_check_free include/linux/page_table_check.h:41 [inline]
 free_pages_prepare mm/page_alloc.c:1109 [inline]
 free_unref_page+0xd0f/0xf20 mm/page_alloc.c:2638
 dec_usb_memory_use_count+0x259/0x350 drivers/usb/core/devio.c:198
 mmap_region+0x2180/0x2a30 mm/mmap.c:1574
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f69e1b3c569
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffede422258 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007ffede422280 RCX: 00007f69e1b3c569
RDX: 0000000002000005 RSI: 0000000000003000 RDI: 000000002001a000
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000080000000
R10: 0000000000011012 R11: 0000000000000246 R12: 00007ffede42227c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__page_table_check_zero+0x274/0x350 mm/page_table_check.c:157
Code: c1 0f 8c 39 fe ff ff 48 89 df e8 87 28 f3 ff e9 2c fe ff ff e8 dd 6a 89 ff 90 0f 0b e8 d5 6a 89 ff 90 0f 0b e8 cd 6a 89 ff 90 <0f> 0b f3 0f 1e fa 4c 89 f6 48 81 e6 ff 0f 00 00 31 ff e8 95 6f 89
RSP: 0018:ffffc900046bf6d8 EFLAGS: 00010293
RAX: ffffffff820b7fa3 RBX: dffffc0000000000 RCX: ffff88802fc13c00
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88801e97380c
RBP: ffff88801e97380c R08: ffff88801e97380f R09: 1ffff11003d2e701
R10: dffffc0000000000 R11: ffffed1003d2e702 R12: ffff88801e9737c0
R13: 1ffffffff34887b4 R14: 0000000000000002 R15: 0000000000000000
FS:  0000555570714380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f69e1b92385 CR3: 0000000073ae6000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	28 00                	sub    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	75 05                	jne    0xb
   6:	48 83 c4 28          	add    $0x28,%rsp
   a:	c3                   	ret
   b:	e8 a1 1a 00 00       	call   0x1ab1
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
* 2a:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax <-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 c7 c1 b8 ff ff ff 	mov    $0xffffffffffffffb8,%rcx
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W


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

