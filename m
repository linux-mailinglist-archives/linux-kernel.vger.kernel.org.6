Return-Path: <linux-kernel+bounces-345639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF0298B872
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A19A1F227A7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069019DFA3;
	Tue,  1 Oct 2024 09:37:33 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF82B9B0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775453; cv=none; b=TZ/KendeuU4a3xDZtUqtIl+hA1GxADAmnprzRukgIbjO52+r0wVMmXaiy/UfnTumU1vBTnWwv74L2mZWhKSTKEyPBk7z8fYf7nLkEe/SKaU7nHKvvS4b3oqOT/t+ejqLJp/m4cnGwfO/8YnRSWrIWWFQkYc6bwxMdp9TDXxeZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775453; c=relaxed/simple;
	bh=QL8NbA4SC9uofWvjOFHMeurILQKuEkpxhYA/Lwff4O4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yf6nvX4Seg2RJi3S3kfPdPLojh0gL2UjyeqPjpXajOkKwoE495Z3WmFKFxPbdGeREgRMkPCeJcIwbEwgnlhBBrBklVA+oEnLlpnXR5mPPUN4GHjkdY2UOZg+ziZZm2ydalAey8OcmkXbGvz4Byz81L+5+WrF9u+fKbf4WtRj1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3466d220dso57229275ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727775450; x=1728380250;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JtjygGK1VvrvXVTQh+AePIv5h3RDydbXN4fKTRUyXU=;
        b=XXXE+W7KUS7VUPfKEECF2MdcCpNYF7qGc3t3erxOgeJIq6gB6thXeAvU5l+L5slCNa
         fwkRq4tFc1fkPKAud/svszv5vaQRBBIjhrWFiy2saAhaAVhJBwkppEOyWnmvhIoek/dL
         GNFDy48SiqMmuldYGjZW4xMP0urNqTrPWCAJHb2pHsZv3yYXr8HPuzr7Jt6Nj/qruqaX
         9phuq/7G6FkLL8JDd4kLluM2N/DqAnYB9h9vOLOITG6Pr9hc6klps7pB4evvt6Pbbw+G
         YjwFBn8eHTrFhloxPXDcpSaBWldhjub1ZPY9cMRFzCU+xPSNU87J2gh+uP5A8FR5IJN/
         seww==
X-Forwarded-Encrypted: i=1; AJvYcCU7oUjsHuFtARqXI9p45cyvzrvD+/kXy6JMXfHu24Mos9kx1ezDsOX1KOKiRXA+WNOV27qlB9eP3t/iqUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiiaI7NJDS8A/tYvZLIKqA9/bDdBgTQNF8Ef8GPTkuft9pusu
	StIAf02qsUZBlkTMvP2Wv9iHZlIUgURuiILqoOfrYB+bJ9aXkdAJlEgcToSQE9WxuzdDKqmQ71+
	sL1DP8LhFn5pe3dv+opdt/9wMCWcj4fUvpwm97CbcB9B8UHuk8o4GnfM=
X-Google-Smtp-Source: AGHT+IGCc7zeJhi1zrGLxqYbf+Oue7PaZJhvkce5wE3rFJ5xJ8sgDWDMj/R6iutKK5OVHRd7F48/o4wuvnYo9VlX0prcNfqL5Fhw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56f:0:b0:3a0:9a32:dedc with SMTP id
 e9e14a558f8ab-3a3451703b8mr137007715ab.6.1727775449913; Tue, 01 Oct 2024
 02:37:29 -0700 (PDT)
Date: Tue, 01 Oct 2024 02:37:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fbc2d9.050a0220.6bad9.0057.GAE@google.com>
Subject: [syzbot] [kernel?] general protection fault in follow_pfnmap_start
From: syzbot <syzbot+093d096417e7038a689b@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    075dbe9f6e3c Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17945e27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=093d096417e7038a689b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145dba80580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1703159f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-075dbe9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c02adb371c0/vmlinux-075dbe9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5e56aa110f69/bzImage-075dbe9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+093d096417e7038a689b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 0 UID: 0 PID: 5102 Comm: syz-executor119 Not tainted 6.11.0-syzkaller-11558-g075dbe9f6e3c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:pfnmap_lockdep_assert mm/memory.c:6349 [inline]
RIP: 0010:follow_pfnmap_start+0x1a7/0xfd0 mm/memory.c:6402
Code: 8d 9f 80 00 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 57 0c 1a 00 48 8b 1b 48 83 c3 58 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 3a 0c 1a 00 4c 8b 23 48 c7 c0 7c
RSP: 0018:ffffc9000179f100 EFLAGS: 00010202
RAX: 000000000000000b RBX: 0000000000000058 RCX: ffff88801aa0c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000179f1e0
RBP: ffffc9000179f290 R08: ffffc9000179f311 R09: 0000000000000000
R10: ffffc9000179f2f0 R11: fffff520002f3e63 R12: dffffc0000000000
R13: 1ffff110023c0202 R14: ffffc9000179f2e0 R15: ffff888011e01000
FS:  0000555593c58380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9ad1af10f0 CR3: 000000001270e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 follow_phys arch/x86/mm/pat/memtype.c:956 [inline]
 get_pat_info+0x182/0x3f0 arch/x86/mm/pat/memtype.c:988
 untrack_pfn+0x327/0x640 arch/x86/mm/pat/memtype.c:1101
 unmap_single_vma+0x1f6/0x2b0 mm/memory.c:1834
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1900
 unmap_region+0x214/0x380 mm/vma.c:354
 mmap_region+0x22f9/0x2990 mm/mmap.c:1573
 do_mmap+0x8f0/0x1000 mm/mmap.c:496
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:588
 ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9ad1a7a879
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd49b2ee58 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9ad1a7a879
RDX: 0000000000000007 RSI: 0000000000005000 RDI: 0000000020371000
RBP: 00007f9ad1aed5f0 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pfnmap_lockdep_assert mm/memory.c:6349 [inline]
RIP: 0010:follow_pfnmap_start+0x1a7/0xfd0 mm/memory.c:6402
Code: 8d 9f 80 00 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 57 0c 1a 00 48 8b 1b 48 83 c3 58 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 3a 0c 1a 00 4c 8b 23 48 c7 c0 7c
RSP: 0018:ffffc9000179f100 EFLAGS: 00010202
RAX: 000000000000000b RBX: 0000000000000058 RCX: ffff88801aa0c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000179f1e0
RBP: ffffc9000179f290 R08: ffffc9000179f311 R09: 0000000000000000
R10: ffffc9000179f2f0 R11: fffff520002f3e63 R12: dffffc0000000000
R13: 1ffff110023c0202 R14: ffffc9000179f2e0 R15: ffff888011e01000
FS:  0000555593c58380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555593c58ca8 CR3: 000000001270e000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8d 9f 80 00 00 00    	lea    0x80(%rdi),%ebx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 57 0c 1a 00       	call   0x1a0c73
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 58          	add    $0x58,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 3a 0c 1a 00       	call   0x1a0c73
  39:	4c 8b 23             	mov    (%rbx),%r12
  3c:	48                   	rex.W
  3d:	c7                   	.byte 0xc7
  3e:	c0                   	.byte 0xc0
  3f:	7c                   	.byte 0x7c


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

