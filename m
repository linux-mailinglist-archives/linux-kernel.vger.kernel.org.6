Return-Path: <linux-kernel+bounces-251306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD219930334
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 04:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644D32835C6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 02:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F2125BA;
	Sat, 13 Jul 2024 02:15:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96014168B7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720836904; cv=none; b=Ai7ut3Pgx0l4SiM/XuUSHIFlVdPUFNtVhKkviI0cskujD7nb00R3k4dzd3LSP2OjtgyMs8Z3KHDYSJan7ldiGb9kOLi+z4fQ0v01MlOkU7GIYTXZs5udd7fRIw9QcFvYSfOTePMk9PxY3ppR52c8l3swlo795XgNti4pVP8/yDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720836904; c=relaxed/simple;
	bh=mZjF58qK2WpLCkoES8ZKlJx5azVD6vs8qZQ2WRU0hRk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T8cPQ5ONGE1z0UYBjhik+ThBPg6aNBamFcWLN+boLeyDThd+mNPhLDV1gi7KO5/ee0ciA+HlWI9uYWdjOXWkmHmhXfQd8+xMuuHbB8xE+8ZXW9jJSbFaium93Dg/26cR/Irz0yyzY9+gTsRGcILw5jrbE9T9V/NlPzGa2mKSyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-376210a881dso28689615ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 19:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720836902; x=1721441702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9Kk8CJVUPg3VRcQyUc/7+rXvK/IRtTgNpnGXejXDlE=;
        b=gnroOvIw9IXPy4m9zsfqPRvTMVMVlphEG/wCeng/Z/m1NEn39Oyo5RGK62d5ai5YKw
         JWLzvUlAz/tJJTZi2Al6x7bRQmeAzGiqb+HV4pBHG1AVn/BBI3VUjRkdU3V+Jjqx4pze
         jkTMgLCle8zQjx+1Xzu4M6/D+k5tB7XPL4+8/LZb2wx951hH+5UPqL42Cu5oVbLbaw1H
         SV1VfubXA72hkID0x0gAuLWLJ3FGrxFDqSndvrVDDc2mjrCU0sVYzFJxswRcn/NLoWBC
         AbKhsCpqXHfUop1SNkB0AeX59lIVYnu3uyxiiRemji2zA6mYCsp0zhuz9HeZs8SaxXng
         SZtw==
X-Forwarded-Encrypted: i=1; AJvYcCXTspixsOlbGAKgkax+6wuVRb0iyFO0ZcPjA2jMUr/Coaugj0jbXSwgN8AaBDCR8ftTIdc0vPbDYfjj0LmOWm+B68s3tDaaxq2R0Foz
X-Gm-Message-State: AOJu0YxL2wXL+4KTMSTVnBXwoSgZBuVhsW8aC5Wu10lm/A7btTD98YLT
	HREYqwMzb0yl0mkvDin1q1P1MKYuowqbvib0ctm1eg9/EO+r5FKtLuOet99qqVBbzRp7kxbP/B/
	/0uPHWDy4ccBvDMwUx9oZngsYOEUlb6wbpy7VS9BUEs7iJVifGBpDpN4=
X-Google-Smtp-Source: AGHT+IFeQNxrS4G/fznoOn96fm+gKOSxCHn6WWbIKrujIh+7mZOSeJn9ia5XCTpmIuM4rbYwUhw4RvbErHJ7vItgQh/+0qv88qSy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:874c:0:b0:380:f12f:30d9 with SMTP id
 e9e14a558f8ab-38a585851c9mr2513265ab.2.1720836901620; Fri, 12 Jul 2024
 19:15:01 -0700 (PDT)
Date: Fri, 12 Jul 2024 19:15:01 -0700
In-Reply-To: <20240713014858.1281-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ce1d3061d17904c@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in list_lru_add
From: syzbot <syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in list_lru_del

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 5638 Comm: syz-executor Not tainted 6.10.0-rc7-syzkaller-00141-g43db1e03c086-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:list_lru_del+0x247/0x310 mm/list_lru.c:132
Code: 1c 00 4d 89 3f 49 8d 7f 08 48 89 f8 48 c1 e8 03 80 3c 28 00 74 05 e8 88 02 1c 00 4d 89 7f 08 48 83 c3 10 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 7b 01 1c 00 48 ff 0b 48 8b 44 24 28
RSP: 0018:ffffc9000405fbd8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000010 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8bcaccc0 RDI: ffff88806ced81c0
RBP: dffffc0000000000 R08: ffffffff8fac686f R09: 1ffffffff1f58d0d
R10: dffffc0000000000 R11: fffffbfff1f58d0e R12: ffff88801fb75240
R13: ffff88801fb75200 R14: ffff88801fb75240 R15: ffff88806ced81b8
FS:  000055555b96b500(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d5667df000 CR3: 000000007b826000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_lru_list_del fs/inode.c:485 [inline]
 evict_inodes+0x22d/0x690 fs/inode.c:732
 generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
 bch2_kill_sb+0x41/0x50 fs/bcachefs/fs.c:2052
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x360 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9fb9b76f07
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffcfeb94e78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9fb9b76f07
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffcfeb94f30
RBP: 00007ffcfeb94f30 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffcfeb95ff0
R13: 00007f9fb9be3515 R14: 000000000001ce83 R15: 000000000001cd13
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:list_lru_del+0x247/0x310 mm/list_lru.c:132
Code: 1c 00 4d 89 3f 49 8d 7f 08 48 89 f8 48 c1 e8 03 80 3c 28 00 74 05 e8 88 02 1c 00 4d 89 7f 08 48 83 c3 10 48 89 d8 48 c1 e8 03 <80> 3c 28 00 74 08 48 89 df e8 7b 01 1c 00 48 ff 0b 48 8b 44 24 28
RSP: 0018:ffffc9000405fbd8 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000010 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8bcaccc0 RDI: ffff88806ced81c0
RBP: dffffc0000000000 R08: ffffffff8fac686f R09: 1ffffffff1f58d0d
R10: dffffc0000000000 R11: fffffbfff1f58d0e R12: ffff88801fb75240
R13: ffff88801fb75200 R14: ffff88801fb75240 R15: ffff88806ced81b8
FS:  000055555b96b500(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d5667df000 CR3: 000000007b826000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	1c 00                	sbb    $0x0,%al
   2:	4d 89 3f             	mov    %r15,(%r15)
   5:	49 8d 7f 08          	lea    0x8(%r15),%rdi
   9:	48 89 f8             	mov    %rdi,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  14:	74 05                	je     0x1b
  16:	e8 88 02 1c 00       	call   0x1c02a3
  1b:	4d 89 7f 08          	mov    %r15,0x8(%r15)
  1f:	48 83 c3 10          	add    $0x10,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 df             	mov    %rbx,%rdi
  33:	e8 7b 01 1c 00       	call   0x1c01b3
  38:	48 ff 0b             	decq   (%rbx)
  3b:	48 8b 44 24 28       	mov    0x28(%rsp),%rax


Tested on:

commit:         43db1e03 Merge tag 'for-6.10/dm-fixes-2' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1566ca21980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=2403e3909382fbdeaf6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16185766980000


