Return-Path: <linux-kernel+bounces-357870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75091997735
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969311C212DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDFA1E32BD;
	Wed,  9 Oct 2024 21:02:17 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDDC1E32AA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507737; cv=none; b=Ho0zJNDw6OTss6hRGo3pdqZ3iTtm0c1gFgUjVgb7Aq5hTZA6PwnH4gtJyrDy5lW9jLDVyLeaA0lB0CokouUVQaoV4FJmwEL5j7VZ1KXduMJ2s/pduQ0+/GUMS6BpATsw+P3Uvh3Bk3i5JslkWiWnoKAn7pwmo3mtQB630Izc/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507737; c=relaxed/simple;
	bh=Vw39MqVKtV0mj1Fwmos++bAfOPjtMJRPcebS8xUwtVo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hS6D2STeboVGpMTlFcJXDbVnHIGWhi+W9JocyWrXcgadoUxsKKbJ+wu98fgN2ZetUgLOWj0Ihx143n+OtIHAJQnEU/4BgsbAnZ4oNn1pEmOwz0cSJonMHN5LUQYStd5Lmm27xWZfCQ8gt/KgK8X5VK3tnebHrKgtxkkGohvwY+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cf147a566so22383139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 14:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728507735; x=1729112535;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ml4lrQ87lU0vbubrVun0YvSXbexJLRmkJ4OcUVq+pK4=;
        b=fNm653LvD2iU7OtifDCwS5lu3gqe4y6ULrdwNR07Wif3r+EeNIka2tQqzoXgA6l96P
         /n48+f6rpyqyZVxiTnxAHsLMmf5gALXxzR77/hzv/DTXOk8Zi0TS06pq0DTumPbeacr6
         pnpquyG4aHMyUOX0dEk3VaEk26kcVa+Sh5UCUCgo89gn7W+0yCUNIjPvDfN3PveOXlJV
         XvvzbNJ4kdnCSonCROuVWGQPU3Zh5VrRkYXMiKTWY/si2Rt7170BpVHRxJ9OK37tP3Rx
         kSt6bK1lzzEJwwOASFVnMSWyb3RJd8QGGeVLe4SksTsUM6Xrcu913UiRqGzbYiQ4BSu2
         /2AQ==
X-Gm-Message-State: AOJu0YyvFL++e84BEBlWKUwbkYv6GZaC+sm5IleDQU7CRRsLTBDw4VGr
	9/jJie1eJn3heVxrFByzyCeqCEp+F+t5nHIT+RusuNVUqkI5QQvmnKWiu6St2C58dA1ru8XubgC
	4fcB2WpCoNTiNaIk3epNhMHcBFCLSXaTQnmFZx7b4MSx33Oo14x389iM=
X-Google-Smtp-Source: AGHT+IGe5o+L2b8uJGA2W+2yWkcn5uaXPsi33O9K0kFMbHa4Xt+PPW7W1zI6x0rgTQucWJxW8Awm9lRS+1aeehH9d+yQYhpZ+DZn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168b:b0:3a0:92e5:af68 with SMTP id
 e9e14a558f8ab-3a397cfd68dmr39026035ab.15.1728507734551; Wed, 09 Oct 2024
 14:02:14 -0700 (PDT)
Date: Wed, 09 Oct 2024 14:02:14 -0700
In-Reply-To: <6700d799.050a0220.49194.04b3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706ef56.050a0220.67064.0055.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [hfs?] general protection fault in hfs_mdb_commit
From: syzbot <syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [hfs?] general protection fault in hfs_mdb_commit
Author: sandeen@sandeen.net

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git ffcd06b6d13b72823aba0d7c871f7e4876e7916b

On 10/5/24 1:07 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c02d24a5af66 Add linux-next specific files for 20241003
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=111f2b9f980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
> dashboard link: https://syzkaller.appspot.com/bug?extid=5cfa9ffce7cc5744fe24
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114be307980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bef527980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/641e642c9432/disk-c02d24a5.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/98aaf20c29e0/vmlinux-c02d24a5.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c23099f2d86b/bzImage-c02d24a5.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/d12a33e3e104/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com
> 
> Oops: general protection fault, probably for non-canonical address 0xdffffc00000000c7: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000638-0x000000000000063f]
> CPU: 1 UID: 0 PID: 116 Comm: kworker/1:2 Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: events_long flush_mdb
> RIP: 0010:hfs_mdb_commit+0x37/0xfd0 fs/hfs/mdb.c:266
> Code: 53 48 83 ec 48 48 89 fb 49 bd 00 00 00 00 00 fc ff df e8 dc 45 0a ff 48 89 5c 24 08 4c 8d a3 38 06 00 00 4c 89 e3 48 c1 eb 03 <42> 80 3c 2b 00 74 08 4c 89 e7 e8 0a 2b 74 ff 4d 8b 34 24 49 8d 6e
> RSP: 0018:ffffc90002d0fb40 EFLAGS: 00010202
> RAX: ffffffff828a89e4 RBX: 00000000000000c7 RCX: ffff88801ef68000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
> RBP: ffffc90002d0fdc0 R08: ffff88802e32d1eb R09: 1ffff11005c65a3d
> R10: dffffc0000000000 R11: ffffed1005c65a3e R12: 0000000000000638
> R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000001800000
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055fc5eb2fb50 CR3: 00000000786e8000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:hfs_mdb_commit+0x37/0xfd0 fs/hfs/mdb.c:266
> Code: 53 48 83 ec 48 48 89 fb 49 bd 00 00 00 00 00 fc ff df e8 dc 45 0a ff 48 89 5c 24 08 4c 8d a3 38 06 00 00 4c 89 e3 48 c1 eb 03 <42> 80 3c 2b 00 74 08 4c 89 e7 e8 0a 2b 74 ff 4d 8b 34 24 49 8d 6e
> RSP: 0018:ffffc90002d0fb40 EFLAGS: 00010202
> RAX: ffffffff828a89e4 RBX: 00000000000000c7 RCX: ffff88801ef68000
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
> RBP: ffffc90002d0fdc0 R08: ffff88802e32d1eb R09: 1ffff11005c65a3d
> R10: dffffc0000000000 R11: ffffed1005c65a3e R12: 0000000000000638
> R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000001800000
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055fc5eb2fb50 CR3: 00000000786e8000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	53                   	push   %rbx
>    1:	48 83 ec 48          	sub    $0x48,%rsp
>    5:	48 89 fb             	mov    %rdi,%rbx
>    8:	49 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%r13
>    f:	fc ff df
>   12:	e8 dc 45 0a ff       	call   0xff0a45f3
>   17:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
>   1c:	4c 8d a3 38 06 00 00 	lea    0x638(%rbx),%r12
>   23:	4c 89 e3             	mov    %r12,%rbx
>   26:	48 c1 eb 03          	shr    $0x3,%rbx
> * 2a:	42 80 3c 2b 00       	cmpb   $0x0,(%rbx,%r13,1) <-- trapping instruction
>   2f:	74 08                	je     0x39
>   31:	4c 89 e7             	mov    %r12,%rdi
>   34:	e8 0a 2b 74 ff       	call   0xff742b43
>   39:	4d 8b 34 24          	mov    (%r12),%r14
>   3d:	49                   	rex.WB
>   3e:	8d                   	.byte 0x8d
>   3f:	6e                   	outsb  %ds:(%rsi),(%dx)
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup
> 


