Return-Path: <linux-kernel+bounces-447984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A59A9F3989
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2C6188E805
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3901146019;
	Mon, 16 Dec 2024 19:16:31 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D41E87B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376591; cv=none; b=sOrTfNZmol/Up0G1tK2Vv2BpSyD5Z5UvRQoVC4agptQR88pUtooifvUnE03R6QTdzw9uiwtlLmwY/EuPTSylCod6WdnKWUEmCAplstxWWYvun+x0rKy87dRLb7LiBwDKxwXEthkZPvZfp5bhJ+3n3QGE0ZLPu/iiMvcP1ioCTBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376591; c=relaxed/simple;
	bh=GPYGRmq5hMY/z9biIT+c0Gj7Z6hxxEiW/uOfFkHCGFg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tEy/9jtmiLRI3UcHskxCqXhCTHwFF5CLYdrtQZwm5bbZUvbZ96pQ30eyf0IxMEMZcIeGinNV1dwFA0LRZGhtWSQsu1eniGh8LeWtDMoyCnkS9IecCe+VTM7d5fI0yauz2dUFTpIoePwMAhYAfLtBY2f5w1oNLnro8nsGyyYwCKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso42747545ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734376588; x=1734981388;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysevNBa1o97DtsNJkILIAJiTHHF/LiJkIs1PQ7evepc=;
        b=eCaGvb8h6SoPDQHc/RWWfDw6wNlr7jY5CMBF5e6Dj5Z/zamWz0dfYNd/NvxTaai8rw
         O/RNx640G2niPz0APilInxf14X6/Ec5baeEchKXxEiin7ZNgz0ea8n1VAD8x4LdtszUO
         OlngZgIGBORR+xDRPrDjy1kiacXmHAcXtS7i7WeeD62dS+ZkFxKjR9NQHjNNEPfrZiBW
         yZ6TB1fCYCUb5+C3QSYtZNg29FBUQFjM2CbXBk7vGm5+C+F9knZMY5XbyMI5bSuX4KMU
         c/K5KWNDkiNwRLUZASvEFgCtuAxEyGVF8QDmS+3x0hW3hKOqxM8YjZnqSW1LbTwQA+Ug
         pkug==
X-Forwarded-Encrypted: i=1; AJvYcCUtpN3xcYvlNUr3Ve9DXmdL8DfRu2MnGSjBdBYyS55gUaGeD2I9scbScFz7GWmGGFDU+yoHuSlvV9F+wIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS9G+3zDAf5Et0B5Q8aMFPiB8Nfc/HJm+w+V/7YV8w14wTCjPR
	kch26wVjKBnSVfySLR21iglRijiMbpzaRJJkuJJGFoVTQ25oPAxeRO4/p4nmG+ZTqTNkkyHKvGB
	la9p1UjEdC0Jrfjbce8QNzom3tLqDNWelEadJ4u6nTuNN39ypPy42y90=
X-Google-Smtp-Source: AGHT+IHTOhz8RR59D+DPzC/Y02b2hgEmzCRJftUNd0h/A+jIL3fCy1pDChtg6a1c5+BoSHqoGrilIWccmRX2FFBr5S42dKF2S2vk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:3a7:7124:bd2c with SMTP id
 e9e14a558f8ab-3affab62206mr145529225ab.19.1734376588677; Mon, 16 Dec 2024
 11:16:28 -0800 (PST)
Date: Mon, 16 Dec 2024 11:16:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67607c8c.050a0220.37aaf.013a.GAE@google.com>
Subject: [syzbot] [mm?] general protection fault in find_lock_task_mm
From: syzbot <syzbot+c2e074db555379260750@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    231825b2e1ff Revert "unicode: Don't special case ignorable..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133b4d44580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
dashboard link: https://syzkaller.appspot.com/bug?extid=c2e074db555379260750
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102844f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/41e68d86d902/disk-231825b2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0cb4e353f885/vmlinux-231825b2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c4df524e0176/bzImage-231825b2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c2e074db555379260750@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000006c: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000360-0x0000000000000367]
CPU: 0 UID: 0 PID: 8122 Comm: syz-executor Not tainted 6.13.0-rc2-syzkaller-00036-g231825b2e1ff #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__lock_acquire+0xe4/0x3c40 kernel/locking/lockdep.c:5089
Code: 08 84 d2 0f 85 15 14 00 00 44 8b 0d 4a 00 a7 0e 45 85 c9 0f 84 b4 0e 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 96 2c 00 00 49 8b 04 24 48 3d a0 17 32 93 0f 84
RSP: 0018:ffffc9000d087990 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000006c RSI: 1ffff92001a10f44 RDI: 0000000000000360
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff901cc317 R11: 0000000000000002 R12: 0000000000000360
R13: ffff888034c38000 R14: 0000000000000000 R15: 0000000000000000
FS:  00005555879c4500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555879c4808 CR3: 0000000030ed6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 task_lock include/linux/sched/task.h:229 [inline]
 find_lock_task_mm+0xd4/0x2f0 mm/oom_kill.c:140
 __set_oom_adj.isra.0+0xcd8/0x1120 fs/proc/base.c:1157
 oom_score_adj_write+0x1b8/0x200 fs/proc/base.c:1294
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3c079847cf
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007fffc0defcf0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f3c079847cf
RDX: 0000000000000004 RSI: 00007fffc0defd40 RDI: 0000000000000003
RBP: 00007f3c07a0320c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000004
R13: 00007fffc0defd40 R14: 00007fffc0df02a0 R15: 00007fffc0df02a0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xe4/0x3c40 kernel/locking/lockdep.c:5089
Code: 08 84 d2 0f 85 15 14 00 00 44 8b 0d 4a 00 a7 0e 45 85 c9 0f 84 b4 0e 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 96 2c 00 00 49 8b 04 24 48 3d a0 17 32 93 0f 84
RSP: 0018:ffffc9000d087990 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 000000000000006c RSI: 1ffff92001a10f44 RDI: 0000000000000360
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff901cc317 R11: 0000000000000002 R12: 0000000000000360
R13: ffff888034c38000 R14: 0000000000000000 R15: 0000000000000000
FS:  00005555879c4500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555879c4808 CR3: 0000000030ed6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 84 d2 0f 85 15 14 	or     %al,0x1415850f(%rdx,%rdx,8)
   7:	00 00                	add    %al,(%rax)
   9:	44 8b 0d 4a 00 a7 0e 	mov    0xea7004a(%rip),%r9d        # 0xea7005a
  10:	45 85 c9             	test   %r9d,%r9d
  13:	0f 84 b4 0e 00 00    	je     0xecd
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 96 2c 00 00    	jne    0x2cca
  34:	49 8b 04 24          	mov    (%r12),%rax
  38:	48 3d a0 17 32 93    	cmp    $0xffffffff933217a0,%rax
  3e:	0f                   	.byte 0xf
  3f:	84                   	.byte 0x84


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

