Return-Path: <linux-kernel+bounces-183476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 949D58C99A3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDFC1F21742
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5C1C2A3;
	Mon, 20 May 2024 08:06:39 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD1168B7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716192399; cv=none; b=uOZI1yiEeNOyilVLqt4HmuanlG7/Z4QYmbrF/AaQ74B9qfO4LeN+G8UvaXUqFW2SsumGY8Z6+mrol2jEV/oV5ekLJqTiLd605SHCQge40i1iXAQp5O7mS9Gyh9eu5WjLGkl/Aa9pLNyQddpfhEDDpxTqxB5hg0benlsRoy22wYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716192399; c=relaxed/simple;
	bh=/K7ci0TyVb6yNyxuqXd0mYfjFOuDKmaTCa6ESll68lY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=USxuj21RzEuy77M1Zah7zpHFHBrBlk1HEsh9UjuxRsEqjolqvrDEqWgilG+eXmLvzWsHq45Bw8B/EnMUbKxiKIsXfFhlARce2X2kMUGuQR2OZbH4uvjJScQWdXuy8JKP2jafedcUqecKyKKMW1ut1Q1/twMWx1/NnwjOlMlGKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1b97c1b19so1147906839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716192397; x=1716797197;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hY/NcJMQiiMdWCWi2cq/vnWcITZlQA3YKCGo1tRNyWQ=;
        b=Kv7FbLJeCHi882qUBnIYYRHA1or9lxeww4OVA1qlPRQQzQxHKlKVFeuLVvFo9oDncr
         Z/fHXog3kaE6rxw0pUmetwsxd2+HAf47ixPVv0Vsx4k6/b/hV2HohWB2HjMhyoR2FZUA
         CMBWt+ntxw5ilcZMX5ecJ8oajrccYhOHPcqPUMecaqEwTh105xQ0lED/CvYRT5NWy6dG
         P6Ik5bni7N7nZ2P5ZUHSnzTC32ixjLVqfmrTpAddXu3eRMrWNMi3AKV3D/ZbvXHtgYu1
         aSifum5Z7dw/1sM0hyvVmRTvYMuUGKuxiIZZC90H+agtMng/AKwQ1S9jN0nlkVw3/MFz
         cr1w==
X-Forwarded-Encrypted: i=1; AJvYcCWmamye9lchXR2C2yvDVwo4pFWSpBkfUR5g+X/DzNdHY38uCUNtFi+sV+5gEjDE5q24ao0FfnpiUiq2NEeask0HFnuTjoT6Hv6U+XUi
X-Gm-Message-State: AOJu0YwNe2mEGvq9iNo7o0h9klcOKbN3wf9dzNXWnhyvNMbyKrOgi7rR
	GBk33PEpEtQH4tdaCfI4ia8Fusw55S+1pQSfn0epkL+aoXgDuLlGCi3U/X5KsLGXkU0gGnnjI74
	lx32flC7oQCJ0bK7M4eYwcqPm/H0c+rA6xavjrFAAaCY8qEl42v1pHUg=
X-Google-Smtp-Source: AGHT+IFq3uO/UhtVBXa4Djzdi7C8ugAfiwRzvCnwh/ZLvesXXEj5LMquqqmisP+rEjSyJQfvfWrP9ovQ7/K0BS+bIF3dONYeTPXn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b82:b0:7de:d6a0:dbe1 with SMTP id
 ca18e2360f4ac-7e1b51fdb00mr162044539f.2.1716192396951; Mon, 20 May 2024
 01:06:36 -0700 (PDT)
Date: Mon, 20 May 2024 01:06:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fd2de0618de2e65@google.com>
Subject: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    33e02dc69afb Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13ad18d0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1526a8dc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f53ae4980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-33e02dc6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/573c88ac3233/vmlinux-33e02dc6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/760a52b9a00a/bzImage-33e02dc6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 3 PID: 5196 Comm: syz-executor259 Not tainted 6.9.0-syzkaller-07370-g33e02dc69afb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
RIP: 0010:iter_file_splice_write+0xa24/0x10b0 fs/splice.c:759
Code: 00 48 89 fa 48 c1 ea 03 80 3c 1a 00 0f 85 b1 04 00 00 4d 8b 65 10 49 c7 45 10 00 00 00 00 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 0f 85 1a 05 00 00 49 8b 54 24 08 4c 89 ee 4c 89 ff 83
RSP: 0018:ffffc900031b7930 EFLAGS: 00010202
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff8209a1a8
RDX: 0000000000000001 RSI: ffffffff8209a06c RDI: 0000000000000008
RBP: 000000000000003d R08: 0000000000000006 R09: 0000000000000000
R10: 7fffffffffffefff R11: 0000000000000001 R12: 0000000000000000
R13: ffff888026d5a208 R14: 7fffffffffffefff R15: ffff88801e5c5800
FS:  00007f78cdfc16c0(0000) GS:ffff88806b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78ce0454d0 CR3: 0000000019dc8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x19b/0x6d0 fs/splice.c:1164
 splice_direct_to_actor+0x346/0xa40 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x17e/0x250 fs/splice.c:1233
 do_sendfile+0xaa8/0xdb0 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64 fs/read_write.c:1348 [inline]
 __x64_sys_sendfile64+0x1da/0x220 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f78ce009d09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f78cdfc1168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f78ce091328 RCX: 00007f78ce009d09
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000004
RBP: 00007f78ce091320 R08: 00007f78cdfc16c0 R09: 0000000000000000
R10: 0000000100000000 R11: 0000000000000246 R12: 00007f78ce09132c
R13: 0000000000000006 R14: 00007ffe98369ff0 R15: 00007ffe9836a0d8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
RIP: 0010:iter_file_splice_write+0xa24/0x10b0 fs/splice.c:759
Code: 00 48 89 fa 48 c1 ea 03 80 3c 1a 00 0f 85 b1 04 00 00 4d 8b 65 10 49 c7 45 10 00 00 00 00 49 8d 7c 24 08 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 0f 85 1a 05 00 00 49 8b 54 24 08 4c 89 ee 4c 89 ff 83
RSP: 0018:ffffc900031b7930 EFLAGS: 00010202
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff8209a1a8
RDX: 0000000000000001 RSI: ffffffff8209a06c RDI: 0000000000000008
RBP: 000000000000003d R08: 0000000000000006 R09: 0000000000000000
R10: 7fffffffffffefff R11: 0000000000000001 R12: 0000000000000000
R13: ffff888026d5a208 R14: 7fffffffffffefff R15: ffff88801e5c5800
FS:  00007f78cdfc16c0(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f78ce05d0d8 CR3: 0000000019dc8000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 1a 00          	cmpb   $0x0,(%rdx,%rbx,1)
   c:	0f 85 b1 04 00 00    	jne    0x4c3
  12:	4d 8b 65 10          	mov    0x10(%r13),%r12
  16:	49 c7 45 10 00 00 00 	movq   $0x0,0x10(%r13)
  1d:	00
  1e:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 1a 00          	cmpb   $0x0,(%rdx,%rbx,1) <-- trapping instruction
  2e:	0f 85 1a 05 00 00    	jne    0x54e
  34:	49 8b 54 24 08       	mov    0x8(%r12),%rdx
  39:	4c 89 ee             	mov    %r13,%rsi
  3c:	4c 89 ff             	mov    %r15,%rdi
  3f:	83                   	.byte 0x83


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

