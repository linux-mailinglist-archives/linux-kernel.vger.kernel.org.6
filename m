Return-Path: <linux-kernel+bounces-433720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC59E5C2B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28191886B8C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3422259C;
	Thu,  5 Dec 2024 16:51:27 +0000 (UTC)
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5487420C468
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733417486; cv=none; b=iPP+w0EeutpYVPysIW8E2NBEqr0UPxziDc6eTHo+GyyMZR9uQjr5eI0h+XrAkL7Lc+/2XYVegyYEuiEOx5BdF3dLqFAdsnaQjeAyzrh7w9kszKTtVYpke/Gjft+Tma63CWhOqXaAxNMtPaIaXpnjLe16hA90cu67R2QyUte5Fhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733417486; c=relaxed/simple;
	bh=UAmPDj30xoP/mRT/12Tk/ijVz4LSRAml6O+Za2Nyc+4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bAEsEwfxZidM8u+fd/WHanDr6uCgRLNTkkNY2x0HU2nbBWDkimhzwROWPO4U3l5s0ZyWiAts46zCyWySvZTdmTlNCU7NlGw0t/QYQftUmJuo5hl2pcki2LySr0F+r0ZCwOxeB4fCkZNB0+QgzAE4/WerNlJErzxKUwoEZs22kFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a7e1e6d83fso20954285ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 08:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733417484; x=1734022284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2gbEUkjVJzZMe3qDA5y2A+gClxSmSQxcirGoSqiF0Q=;
        b=RTcA30/R/EfoG8y0n9uwYQUotY2k+wmE3sFkucZJeNbJhvyQlrdzX6yQ5aTnfSPD7O
         IdNbl0Kc0C0Q6BR8/S5pouVtMCzpWE37/rNNsnPCj5LDB9YkkDKNziew7Q88X9hvLGej
         kPejO3R8ubBgiR27askLeG8RT0IurclHhWsPvTeQOCx0y6C9ooADLUeyJviyT6bNQHQV
         c6MFi3Xwze14Ihd5hDz5xehyIB44x1fd0Qpa53Wel0X3vlKt1bjyljG4VAKRzEiSXsKg
         OIwYWNUujZLdUakBwCfDK+MsK39zVBmmC0DvYc5itATNijZV8fkcVNWjcgbZ0nTdN/Uk
         9DQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW9ottMk4APf0lN6HtMLB5Ybia98lUi9eZtXmk9jX+uwZawPIBprBXNX1ZXpHTOXlD3OBC/e0K/8VN1fo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFf6Amq7+ACg1HVqm8+CkFeVLyvnNKsEG7o8mTyzg2BqgcYz4n
	Yfd/sj8E6RXf4KVFf9r0aRMVmC51c0FmaTK9ByVdTOx3UbJp3z6aOLEcV+7jErfzqEssKiVX8oI
	AL/CYVygRuJ6YiYogMVYJoWmqbWKHmVTI2fq8DazjVMxfEwS08Qh7454=
X-Google-Smtp-Source: AGHT+IESiye16sM1MLh4ToS68muDj2aem9gMWWEZ/DY4Au40yyXXuSg01lsQy1c1j1U6L6rd3Gqy4JT941LzuGUSobKTymt4BpZz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a23:b0:3a7:7ded:53b9 with SMTP id
 e9e14a558f8ab-3a7fed9effcmr116225875ab.20.1733417484608; Thu, 05 Dec 2024
 08:51:24 -0800 (PST)
Date: Thu, 05 Dec 2024 08:51:24 -0800
In-Reply-To: <67508b5f.050a0220.17bd51.0070.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6751da0c.050a0220.b4160.01dc.GAE@google.com>
Subject: Re: [syzbot] [tipc?] general protection fault in cleanup_bearer
From: syzbot <syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, eric.dumazet@gmail.com, 
	horms@kernel.org, jmaloy@redhat.com, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tipc-discussion@lists.sourceforge.net, 
	ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    31f1b55d5d7e net :mana :Request a V2 response version for ..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d290f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3891b550f14aea0f
dashboard link: https://syzkaller.appspot.com/bug?extid=46aa5474f179dacd1a3b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1724ade8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148868df980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba0fb1ec0f79/disk-31f1b55d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/535224afed4c/vmlinux-31f1b55d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bd1b0227ba3d/bzImage-31f1b55d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.12.0-syzkaller-10767-g31f1b55d5d7e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events cleanup_bearer
RIP: 0010:read_pnet include/net/net_namespace.h:392 [inline]
RIP: 0010:sock_net include/net/sock.h:655 [inline]
RIP: 0010:cleanup_bearer+0x1f7/0x280 net/tipc/udp_media.c:820
Code: 18 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 ec 2e 91 f6 48 8b 1b 48 83 c3 30 e8 80 97 63 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 ca 2e 91 f6 49 83 c7 e8 48 8b 1b
RSP: 0018:ffffc900000e7b70 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: ffff88801cef8000
RDX: dffffc0000000000 RSI: ffffffff8c0ad980 RDI: 0000000000000001
RBP: ffff8880287b5e08 R08: ffffffff9432398f R09: 1ffffffff2864731
R10: dffffc0000000000 R11: fffffbfff2864732 R12: ffff8880287b5e98
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff8880287b5e18
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efddcf2f208 CR3: 000000007aa02000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:read_pnet include/net/net_namespace.h:392 [inline]
RIP: 0010:sock_net include/net/sock.h:655 [inline]
RIP: 0010:cleanup_bearer+0x1f7/0x280 net/tipc/udp_media.c:820
Code: 18 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 ec 2e 91 f6 48 8b 1b 48 83 c3 30 e8 80 97 63 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 ca 2e 91 f6 49 83 c7 e8 48 8b 1b
RSP: 0018:ffffc900000e7b70 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: ffff88801cef8000
RDX: dffffc0000000000 RSI: ffffffff8c0ad980 RDI: 0000000000000001
RBP: ffff8880287b5e08 R08: ffffffff9432398f R09: 1ffffffff2864731
R10: dffffc0000000000 R11: fffffbfff2864732 R12: ffff8880287b5e98
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff8880287b5e18
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bf163e0cc0 CR3: 000000007e7d8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	18 48 89             	sbb    %cl,-0x77(%rax)
   3:	d8 48 c1             	fmuls  -0x3f(%rax)
   6:	e8 03 42 80 3c       	call   0x3c80420e
   b:	28 00                	sub    %al,(%rax)
   d:	74 08                	je     0x17
   f:	48 89 df             	mov    %rbx,%rdi
  12:	e8 ec 2e 91 f6       	call   0xf6912f03
  17:	48 8b 1b             	mov    (%rbx),%rbx
  1a:	48 83 c3 30          	add    $0x30,%rbx
  1e:	e8 80 97 63 00       	call   0x6397a3
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 ca 2e 91 f6       	call   0xf6912f03
  39:	49 83 c7 e8          	add    $0xffffffffffffffe8,%r15
  3d:	48 8b 1b             	mov    (%rbx),%rbx


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

