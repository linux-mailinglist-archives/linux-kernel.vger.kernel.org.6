Return-Path: <linux-kernel+bounces-415072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0409D3140
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732BB1F227F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76B18952C;
	Wed, 20 Nov 2024 00:00:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD020EB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732060825; cv=none; b=X/h+fJxxfGE9htTjs2/ngxtNsgV+fdPG1hA+pHl9zbJ7iuNLwyPyQQSlHzBrn01fR20E33Y0HMGpI0km5VcwuXhYkuMC60ckqDUKPxUYWBiBCA5metzBge3/v6eJedbzW1/pUaOXEhx/21NugAVF3+4+pM2DUc5D3poTBaQvjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732060825; c=relaxed/simple;
	bh=Z5IFvB8QbBHkxPG61KPUTK02sJToa+B8MM4le5D+hKM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Jm4F6Rp5TCCItf0kT7kifUVei3pIksiAski31lj4APUZfGCz+5C0cCgYJRWrxmYDSFsDCZMaPdUnJL2GGbbWI34E2vbfcsHQClo6uc7Gdh9EcdBQ0N8LuxJ9jipEgcuLlDzuxiuLU+w/hEgJ5wTCWqWdIs+kI4Y2KBEeQ3NSVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3cb771556so49632745ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732060822; x=1732665622;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+eQhMeTY0xS3SQmrcWgAce0lKg9CWYeSfIaILFoVlY=;
        b=VE1w4fpQ470FY7DMrypgtjAOBRzW07Y7/wHOjAZuXD4kGp0wZQlsFdy4TKl6NFcZzX
         rvUKn+hPKDRHHYNzWuFx2EaUBmzlhRiUVECGX9Xe2MtdwbRki84GRGOgfd+DReaY3+Do
         2tPUIWVU2D4lLPnBh+fkMmZn5eeqkouIueSLlEnZAeisRHyiL7fwm6UsbvoSCxlFKPGf
         rhoGB+VdQPMJK5rnzbcu1cBXZiNK6Q3H1Bna3tOdfVjJdTB+86Qj02CSWFXXsXdAV25H
         XKmAew3zSd9hy5z1I7RRPVlhmUMXtfXYxHUab4Hab+DfeVfwtQa62axsYLt90VHsI51g
         jtjA==
X-Forwarded-Encrypted: i=1; AJvYcCWZlXlenWIuLTaqUTVmlSGoqx/BSNqLulYW3GeZjcJemUKVlNEW7vdKefBKnmjzXkUchJue2YvG4wmVB08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGX3fO/raSPMfLISiubkcyU/hFx8qtAjD2i+xKxjNDmPmTQ8XK
	msnl8yN+DJOzmWgE3bLrbQwlM2ChRVaEfMJM19QzdDzZ8uPK3caZ8uHI/WipsZOqu9iiFFTQ8Zr
	pPv3rzQhwPCYGMZOF8/nFxY5frWGIUmEfbzBbvauhywyGIfpyS2wg3yI=
X-Google-Smtp-Source: AGHT+IEVaiQPmDPmQT4bt7ayQyjltBev1uCmq7aHpNsiPoxYHmS1nq5Yl4KrfpMWWNCraP8X5kikvMw0tLZCWXIv2JWKnCbiapyY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1563:b0:3a7:1c51:f83d with SMTP id
 e9e14a558f8ab-3a78657081emr8160835ab.18.1732060822433; Tue, 19 Nov 2024
 16:00:22 -0800 (PST)
Date: Tue, 19 Nov 2024 16:00:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673d2696.050a0220.3c9d61.012f.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in do_migrate_pages
From: syzbot <syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f868cd251776 Merge tag 'drm-fixes-2024-11-16' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15473cc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff8e8187a30080b5
dashboard link: https://syzkaller.appspot.com/bug?extid=3511625422f7aa637f0d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e8d130580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c71a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a0d46da55993/disk-f868cd25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/da57ef4813fd/vmlinux-f868cd25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3cdde892ea08/bzImage-f868cd25.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3511625422f7aa637f0d@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 6021 Comm: syz-executor284 Not tainted 6.12.0-rc7-syzkaller-00187-gf868cd251776 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
Code: 8b 54 24 30 41 83 c8 10 80 3a 00 4d 63 c0 0f 85 d1 02 00 00 48 89 c1 48 8b 54 24 18 48 be 00 00 00 00 00 fc ff df 48 c1 e9 03 <80> 3c 31 00 48 8b 92 b0 00 00 00 0f 85 74 02 00 00 48 8b 30 49 89
RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kernel_migrate_pages+0x5b2/0x750 mm/mempolicy.c:1709
 __do_sys_migrate_pages mm/mempolicy.c:1727 [inline]
 __se_sys_migrate_pages mm/mempolicy.c:1723 [inline]
 __x64_sys_migrate_pages+0x96/0x100 mm/mempolicy.c:1723
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fedcca74af9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe4d85c278 EFLAGS: 00000206 ORIG_RAX: 0000000000000100
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fedcca74af9
RDX: 0000000020000000 RSI: 000000000000005a RDI: 0000000000001786
RBP: 0000000000010bf2 R08: 0000000000006080 R09: 0000000000000006
R10: 0000000020000040 R11: 0000000000000206 R12: 00007ffe4d85c28c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:migrate_to_node mm/mempolicy.c:1090 [inline]
RIP: 0010:do_migrate_pages+0x403/0x6f0 mm/mempolicy.c:1194
Code: 8b 54 24 30 41 83 c8 10 80 3a 00 4d 63 c0 0f 85 d1 02 00 00 48 89 c1 48 8b 54 24 18 48 be 00 00 00 00 00 fc ff df 48 c1 e9 03 <80> 3c 31 00 48 8b 92 b0 00 00 00 0f 85 74 02 00 00 48 8b 30 49 89
RSP: 0018:ffffc9000375fd08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc9000375fd78 RCX: 0000000000000000
RDX: ffff88807e171300 RSI: dffffc0000000000 RDI: ffff88803390c044
RBP: ffff88807e171428 R08: 0000000000000014 R09: fffffbfff2039ef1
R10: ffffffff901cf78f R11: 0000000000000000 R12: 0000000000000003
R13: ffffc9000375fe90 R14: ffffc9000375fe98 R15: ffffc9000375fdf8
FS:  00005555919e1380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555919e1ca8 CR3: 000000007f12a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b 54 24 30          	mov    0x30(%rsp),%edx
   4:	41 83 c8 10          	or     $0x10,%r8d
   8:	80 3a 00             	cmpb   $0x0,(%rdx)
   b:	4d 63 c0             	movslq %r8d,%r8
   e:	0f 85 d1 02 00 00    	jne    0x2e5
  14:	48 89 c1             	mov    %rax,%rcx
  17:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
  1c:	48 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%rsi
  23:	fc ff df
  26:	48 c1 e9 03          	shr    $0x3,%rcx
* 2a:	80 3c 31 00          	cmpb   $0x0,(%rcx,%rsi,1) <-- trapping instruction
  2e:	48 8b 92 b0 00 00 00 	mov    0xb0(%rdx),%rdx
  35:	0f 85 74 02 00 00    	jne    0x2af
  3b:	48 8b 30             	mov    (%rax),%rsi
  3e:	49                   	rex.WB
  3f:	89                   	.byte 0x89


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

