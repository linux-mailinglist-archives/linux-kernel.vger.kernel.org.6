Return-Path: <linux-kernel+bounces-209649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBA69038E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31239285EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A308E17625F;
	Tue, 11 Jun 2024 10:34:28 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C227407C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102068; cv=none; b=kINHusqpYArX4cw35CyhoIqFoJAJgIkq9xyNfaDdDKMY2AWllxYPGIuQ32taU6YuF+nKdj2JLEdE6wl3CJw9VWEaiGE2YNiODBPOpi4/4gJPCnYuHEKwyZEscXHv/SsuGLqrGk+Y5jHN7y+qkpaDTPOKXxr/OL0KuTPTWYgVvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102068; c=relaxed/simple;
	bh=CKyWflBnZp0xDghv0Z1IUjrrDkT30bvZHVx8eX8fasQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jWRuW0R4rp6acXBZbYu3Ik/0oXl7ewQ4aVBSTo/5GwXhz41+Bem+gDzoS2gtw/NUcsMRuBnYa5w+OfPBF0VbRnIprR1pWRhBjCRmQfU4Z3Tf64fJ+C4mi4UZeWIy+hlpvHMZrFX284BCmvaLXDjbWSDfb5CdtiXxp/uIswz4CbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7ebc15850c0so39467539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718102065; x=1718706865;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K0IQqv9KqFj11BocG4s0Pz4yp+q9Far854P6moXfG1o=;
        b=pPuvAyAwWe2I6qjScvjdbV9Qi8Zr1coUiLiXQ8ftCvTV/MzphpOidwXE/+tUXfonG2
         i//MVpGoM6cBbymdBzwK1xw2HSaRpL2GOoJjEHMYj7zH5CmHPvkzkKnR8Z6l6Du4HbJR
         h87rUW2HzU/s+9rVtIzI+r9l6XN1RSPrgl67Bl2iW2gWJb1IW9QU1OVIA3OWtS84NCAR
         UWz24T9I+KFMtnBQxlvLlMl24jhUBZZDE7NgHKh2Rndl9aru4PhzAvp9IHJvAucjDIkc
         eDRTacoe+Vdf6gqdi1msoOzJA/ONHfWxjtgSPjqTjPoLfAEN/skbi083XO1RK6EDx4to
         SI2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUETy1fu/Xa4PsYnVBuk2GWB2maaQEQBapGRdGBrn4G9S9KC+6xd5b3fkcKrfgw9hPTu/zQwLqJB39XokIFkVDjXQ7DnXQQUoBYcJyv
X-Gm-Message-State: AOJu0YyE0Tb+FBTIAUx8rlJzvCS8keFpdgNervGsKbNDIbml4LMUmm2U
	1h5yVmfo9ySiBw8oXELeMnctp0qmL+F7+9bdD/LsMrBHGftrmRrRQi8m16rOPCLUGnKA6cQ1J3e
	RlB3sLUlQ4pxDMhL4VCl/vgxbGsI9aAtlHPlNAl3J5bz85dxXDIaHVc0=
X-Google-Smtp-Source: AGHT+IE1jKA6jRl5lFabUppzbVmpAkrc/Htj2NFMHxp6Jdd45yLPOX/S1ZuGnkYIQAT/D0BX+vYqlqYBGDLj9gvCPEVCzELSsYLP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:36c:4b17:e05d with SMTP id
 e9e14a558f8ab-375803cf3abmr7259195ab.4.1718102065609; Tue, 11 Jun 2024
 03:34:25 -0700 (PDT)
Date: Tue, 11 Jun 2024 03:34:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f12bb061a9acf07@google.com>
Subject: [syzbot] [mm?] general protection fault in dequeue_hugetlb_folio_nodemask
 (2)
From: syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d35b2284e966 Add linux-next specific files for 20240607
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=161352e2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
dashboard link: https://syzkaller.appspot.com/bug?extid=569ed13f4054f271087b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15eb5e86980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15db597e980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e0055a00a2cb/disk-d35b2284.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/192cbb8cf833/vmlinux-d35b2284.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57804c9c9319/bzImage-d35b2284.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000489: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: probably user-memory-access in range [0x0000000000002448-0x000000000000244f]
CPU: 1 PID: 5095 Comm: syz-executor603 Not tainted 6.10.0-rc2-next-20240607-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:zonelist_zone_idx include/linux/mmzone.h:1613 [inline]
RIP: 0010:next_zones_zonelist include/linux/mmzone.h:1644 [inline]
RIP: 0010:first_zones_zonelist include/linux/mmzone.h:1670 [inline]
RIP: 0010:dequeue_hugetlb_folio_nodemask+0x193/0xe40 mm/hugetlb.c:1362
Code: 93 7a a0 ff c7 44 24 14 00 00 00 00 83 7c 24 40 00 0f 85 97 0c 00 00 48 83 7c 24 20 00 0f 85 45 09 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 58 09 00 00 44 8b 33 44 89 f7 8b 5c 24
RSP: 0018:ffffc900035bf720 EFLAGS: 00010002
RAX: 0000000000000489 RBX: 0000000000002448 RCX: ffff88807651bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900035bf858 R08: ffffffff81f5e800 R09: fffff520006b7ee8
R10: dffffc0000000000 R11: fffff520006b7ee8 R12: 00000000ffffffff
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000055558f377380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000001cfda000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 alloc_hugetlb_folio_nodemask+0xae/0x3f0 mm/hugetlb.c:2603
 memfd_alloc_folio+0x15e/0x390 mm/memfd.c:75
 memfd_pin_folios+0x1066/0x1720 mm/gup.c:3864
 udmabuf_create+0x658/0x11c0 drivers/dma-buf/udmabuf.c:353
 udmabuf_ioctl_create drivers/dma-buf/udmabuf.c:420 [inline]
 udmabuf_ioctl+0x304/0x4f0 drivers/dma-buf/udmabuf.c:451
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb1c16b4ab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff21e63e48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb1c16b4ab9
RDX: 0000000020000000 RSI: 0000000040187542 RDI: 0000000000000003
RBP: 00007fb1c17275f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:zonelist_zone_idx include/linux/mmzone.h:1613 [inline]
RIP: 0010:next_zones_zonelist include/linux/mmzone.h:1644 [inline]
RIP: 0010:first_zones_zonelist include/linux/mmzone.h:1670 [inline]
RIP: 0010:dequeue_hugetlb_folio_nodemask+0x193/0xe40 mm/hugetlb.c:1362
Code: 93 7a a0 ff c7 44 24 14 00 00 00 00 83 7c 24 40 00 0f 85 97 0c 00 00 48 83 7c 24 20 00 0f 85 45 09 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 58 09 00 00 44 8b 33 44 89 f7 8b 5c 24
RSP: 0018:ffffc900035bf720 EFLAGS: 00010002
RAX: 0000000000000489 RBX: 0000000000002448 RCX: ffff88807651bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900035bf858 R08: ffffffff81f5e800 R09: fffff520006b7ee8
R10: dffffc0000000000 R11: fffff520006b7ee8 R12: 00000000ffffffff
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  000055558f377380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005fdeb8 CR3: 000000001cfda000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	93                   	xchg   %eax,%ebx
   1:	7a a0                	jp     0xffffffa3
   3:	ff c7                	inc    %edi
   5:	44 24 14             	rex.R and $0x14,%al
   8:	00 00                	add    %al,(%rax)
   a:	00 00                	add    %al,(%rax)
   c:	83 7c 24 40 00       	cmpl   $0x0,0x40(%rsp)
  11:	0f 85 97 0c 00 00    	jne    0xcae
  17:	48 83 7c 24 20 00    	cmpq   $0x0,0x20(%rsp)
  1d:	0f 85 45 09 00 00    	jne    0x968
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 58 09 00 00    	jne    0x98f
  37:	44 8b 33             	mov    (%rbx),%r14d
  3a:	44 89 f7             	mov    %r14d,%edi
  3d:	8b                   	.byte 0x8b
  3e:	5c                   	pop    %rsp
  3f:	24                   	.byte 0x24


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

