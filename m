Return-Path: <linux-kernel+bounces-205117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B82A8FF7A2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE5CB23041
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F041A13DDDE;
	Thu,  6 Jun 2024 22:22:31 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF8224D6
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712551; cv=none; b=AXlUS295WsAuJ4HOOcwMH3qIwqcsMCQHQUFY40hBXqHEVly0SgTKwlLnkZvrpw7XyfYMF/RvAS24l4I2zpLQ7KbTLyHRS53A3++kkhWFIRLPotx8dtenUg/dl6/gedb57k6tqmzN34c7qqukinW4VZnJQWXnoQjPHSNQB7P3v/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712551; c=relaxed/simple;
	bh=z2QV/maktCWYkqDj9No4guM/7CIphPIbi4uuFKOd++U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TIHCaRAv6FM6ZfPNPte7ayzs8Z7bZFuvh6IkmzXiHlamBE752n3U7w1SyA3f5Lm1ODhMvIciwZoaXYUoMv+Z/GDR5PIpA7DdYAK4fCtmSnWPPtWyyA5y/74FICi1da7VYWGZO4kGTQN2gnJOghciVHZdMdKmvq3zhkFHPuQQMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-374a23b72c9so12979825ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 15:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717712549; x=1718317349;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbcoDrICfmc575uOdnZ9zlJqBUWcep+aJFxdognMjOA=;
        b=pAsccHh3mxSMh6qyT2zMq96utD+S07gj2//RZh7bWCR3JtzeuvaDN+iFLeVcZKQ+jJ
         hhWxwGO3IKtUUpzFsOfBQSSFOGihbTFg8rCLiBoqG5bKHIGAiFuZDlCRt2mcvW4dWGUV
         J7D1/fpMFnGkQDW4LypJB2Z7XygnAUwpZzcePlLZffixMIQAWwFNQcl10jsxUujMFXxf
         0+S5Mjx1kIBkzVbMenIZUb6ryCkNHJ9TpMAYfofDOGOqlqAwATDIb54e/wr3QJ1eM91w
         mzreg73f+bEILVREJc3iWD2edNp8aYWxWrVVDuBpx6qWC2NmV20DOStigj3VsfN30MNt
         kTEg==
X-Forwarded-Encrypted: i=1; AJvYcCXdIizZukMPwogrR/IWg06MSAOMmA3CLVK0eLdbhtFYOg74XzRcRMAalMnxt9VucuY922Xhon/cdDdf8PYRQnYjM5ONIHTXe3nMsBhD
X-Gm-Message-State: AOJu0YygUiiQSmeC3cjmqlcgLVvV1rdP5jpMINllI4+89Hmg5Fl8gLDK
	BxZQrCRDUb9PALWvLqY+WT/15Kn+8s4rIB1XllmYLYqlUN35es3jnh1p4D+MxtMnLYCPtGV3gwM
	SDKmacoP9MzERaKx5KnJdz0mGiNH+XWkxMSGBXpkEZ3R2yQBYwJAgLpQ=
X-Google-Smtp-Source: AGHT+IHyj7f0bTOm3GgwUpeNDeil1SLlPxiGgk5g6XWoTCHPXg29IjA2MV7LE4U4c3g0PosbyajMX/7jqiIpXNUU8olu4H0N0ADi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154c:b0:36d:92b9:8f30 with SMTP id
 e9e14a558f8ab-375802ed81emr528315ab.1.1717712548863; Thu, 06 Jun 2024
 15:22:28 -0700 (PDT)
Date: Thu, 06 Jun 2024 15:22:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d2e4d061a401e51@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_vm_page_mkwrite
From: syzbot <syzbot+f195123a45ad487ca66c@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    83814698cf48 Merge tag 'powerpc-6.10-2' of git://git.kerne..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15cb1a16980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=238430243a58f702
dashboard link: https://syzkaller.appspot.com/bug?extid=f195123a45ad487ca66c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1129d362980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10d4ce06980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49e438bd237c/disk-83814698.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc25a0ccc6f6/vmlinux-83814698.xz
kernel image: https://storage.googleapis.com/syzbot-assets/85871c08ab8f/bzImage-83814698.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/cc6db24192e2/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f195123a45ad487ca66c@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/file.c:105!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 5092 Comm: syz-executor296 Not tainted 6.10.0-rc1-syzkaller-00304-g83814698cf48 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:f2fs_vm_page_mkwrite+0x1679/0x1bb0 fs/f2fs/file.c:105
Code: e7 41 83 e7 01 4c 89 fe e8 84 39 c8 fd 4d 85 ff 0f 84 f6 f8 ff ff e8 46 3e c8 fd 49 83 ec 01 e9 eb f8 ff ff e8 38 3e c8 fd 90 <0f> 0b e8 30 3e c8 fd e8 5b 0a 3b fd e9 f0 f1 ff ff 48 89 4c 24 08
RSP: 0018:ffffc9000316f828 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807aa48000 RCX: ffffffff83c58900
RDX: ffff8880123a0000 RSI: ffffffff83c596b8 RDI: 0000000000000007
RBP: ffffc9000316fb68 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff9393ffd0 R12: ffffc9000316f8a8
R13: 0000000000000001 R14: ffffea00013dfbc0 R15: ffff88807aa484a8
FS:  0000555581924380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000280 CR3: 00000000791d4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_page_mkwrite+0x17d/0x390 mm/memory.c:3099
 wp_page_shared mm/memory.c:3501 [inline]
 do_wp_page+0xc89/0x3380 mm/memory.c:3651
 handle_pte_fault mm/memory.c:5396 [inline]
 __handle_mm_fault+0x2311/0x53f0 mm/memory.c:5523
 handle_mm_fault+0x476/0xa00 mm/memory.c:5688
 do_user_addr_fault+0x2e5/0xe50 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:rep_movs_alternative+0x33/0x70 arch/x86/lib/copy_user_64.S:58
Code: 40 83 f9 08 73 21 85 c9 74 0f 8a 06 88 07 48 ff c7 48 ff c6 48 ff c9 75 f1 c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 48 8b 06 <48> 89 07 48 83 c6 08 48 83 c7 08 83 e9 08 74 df 83 f9 08 73 e8 eb
RSP: 0018:ffffc9000316fdd8 EFLAGS: 00050212
RAX: 00000000665cff9a RBX: 0000000000000010 RCX: 0000000000000010
RDX: fffff5200062dfc8 RSI: ffffc9000316fe30 RDI: 0000000020000280
RBP: 0000000020000280 R08: 0000000000000000 R09: fffff5200062dfc7
R10: ffffc9000316fe3f R11: 0000000000000000 R12: ffffc9000316fe30
R13: 0000000020000290 R14: 0000000000000000 R15: 0000000000000000
 copy_user_generic arch/x86/include/asm/uaccess_64.h:110 [inline]
 raw_copy_to_user arch/x86/include/asm/uaccess_64.h:131 [inline]
 _copy_to_user lib/usercopy.c:46 [inline]
 _copy_to_user+0xac/0xc0 lib/usercopy.c:39
 copy_to_user include/linux/uaccess.h:191 [inline]
 put_timespec64+0xb6/0x120 kernel/time/time.c:910
 __do_sys_clock_gettime kernel/time/posix-timers.c:1144 [inline]
 __se_sys_clock_gettime kernel/time/posix-timers.c:1132 [inline]
 __x64_sys_clock_gettime+0x1d5/0x270 kernel/time/posix-timers.c:1132
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feea661dc19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeab229a38 EFLAGS: 00000246 ORIG_RAX: 00000000000000e4
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007feea661dc19
RDX: 00007feea661dc19 RSI: 0000000020000280 RDI: 0000000000000000
RBP: 00007feea66965f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 00007ffeab229a70
R13: 00007ffeab229c98 R14: 431bde82d7b634db R15: 00007feea666603b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_vm_page_mkwrite+0x1679/0x1bb0 fs/f2fs/file.c:105
Code: e7 41 83 e7 01 4c 89 fe e8 84 39 c8 fd 4d 85 ff 0f 84 f6 f8 ff ff e8 46 3e c8 fd 49 83 ec 01 e9 eb f8 ff ff e8 38 3e c8 fd 90 <0f> 0b e8 30 3e c8 fd e8 5b 0a 3b fd e9 f0 f1 ff ff 48 89 4c 24 08
RSP: 0018:ffffc9000316f828 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88807aa48000 RCX: ffffffff83c58900
RDX: ffff8880123a0000 RSI: ffffffff83c596b8 RDI: 0000000000000007
RBP: ffffc9000316fb68 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000001 R11: ffffffff9393ffd0 R12: ffffc9000316f8a8
R13: 0000000000000001 R14: ffffea00013dfbc0 R15: ffff88807aa484a8
FS:  0000555581924380(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000280 CR3: 00000000791d4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	40 83 f9 08          	rex cmp $0x8,%ecx
   4:	73 21                	jae    0x27
   6:	85 c9                	test   %ecx,%ecx
   8:	74 0f                	je     0x19
   a:	8a 06                	mov    (%rsi),%al
   c:	88 07                	mov    %al,(%rdi)
   e:	48 ff c7             	inc    %rdi
  11:	48 ff c6             	inc    %rsi
  14:	48 ff c9             	dec    %rcx
  17:	75 f1                	jne    0xa
  19:	c3                   	ret
  1a:	cc                   	int3
  1b:	cc                   	int3
  1c:	cc                   	int3
  1d:	cc                   	int3
  1e:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  25:	00 00
  27:	48 8b 06             	mov    (%rsi),%rax
* 2a:	48 89 07             	mov    %rax,(%rdi) <-- trapping instruction
  2d:	48 83 c6 08          	add    $0x8,%rsi
  31:	48 83 c7 08          	add    $0x8,%rdi
  35:	83 e9 08             	sub    $0x8,%ecx
  38:	74 df                	je     0x19
  3a:	83 f9 08             	cmp    $0x8,%ecx
  3d:	73 e8                	jae    0x27
  3f:	eb                   	.byte 0xeb


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

