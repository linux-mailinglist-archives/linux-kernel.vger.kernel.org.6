Return-Path: <linux-kernel+bounces-392722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DBC9B977D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6077DB21096
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74041CEEA1;
	Fri,  1 Nov 2024 18:28:24 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6BF1CEAB2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730485704; cv=none; b=ZOTyf/pl9ueMKx9iAlM+0E8SjBf3myRy2wJgoMYFPjUQEueQSDE7857r+rJg392J9y3iGGD8QRs9y/HH6F3SBSbHlb+NpTEnDaUOS+rD3R73bXymeXjs0axnzlQEXhlPLvAfnMz9R/Ww4MAOo7Hn1t6r6cY+AxKDl9Acfos6gZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730485704; c=relaxed/simple;
	bh=l0T9mCnjOg2XvMLD+hWsTelnrQD13YtAkSS3/V1DClg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CdIPQBdeiXYNLwG2V92+rSrNTt7rtom1qxihjlpA78a63fTin5PfXG4pSRdhaT67EwwMWlWBNuU4ARW2AG38uQgIvjaFF3VzcYDyTBmy754s0DPmH3Cbg1WyYzR7ktAE3XYz9V8UpYCQl6To6hvTyQlbJ4fehorYUC76BvQ6vgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4daf7174eso21946715ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730485702; x=1731090502;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYSzkUhLHjbwBxT1pIhzrxhNq7Z6ar3u+agVTALcisA=;
        b=dZPv/ZDliTg+ES4loWrgiSr6ihPZnshjx063ZG8fdYjRKAG1kew4E7nhbXINt0TEjT
         rMCGoN6xzMwoqnXvW8nbosOJOQqoQ4KtB0/fUG//hguzguyOs5d4u50G7j3BsMOKWS+L
         fk0WRhaVB7lkmTuGLjTS7OS/C4071cF633/wyy/4D3VzxsRSke9BHFCEHnMNJpxxMSqc
         L1lQtvPhuy1+nSc7LqxhSJUQ3CKEe7uMXAixs5gImIDs+RnjzZbqW5W51AWz+X527ibC
         O70TIfNu27zmei6nQvFKCGzHuYasDB1b+2RfArfU5MiSJEB4sPvdoVTGHylcw9y7xwL2
         rRoA==
X-Forwarded-Encrypted: i=1; AJvYcCW42IG5EDVHj2cPfTJ8r4sUI1DnMkE+6y1nRUQd0/ANRbG0OgYZ5rlgTQDR9XYBqrtdrW15y945G10q+t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM45Dc6zurfFzMgW6CPwjuK+UNYziIBw6g92B7KfeTemnLG/XK
	n2PblnHnSY9CIiy1GulOqb6CnruSIrCVaDQhLXIYNVNTSTsqySFwOxn++cd3pP+VEe9kTzW0eTL
	Ag82TUAA0NbHpQq4NsJv53xJ3tfYBUHBN9oKl6Ro/XDyjJYLg1k6svyY=
X-Google-Smtp-Source: AGHT+IHzaHk3yeELuE84dm8bqG8Ermt+8ogyze3Cvn+bmQdk+DCerk7BQ5xQhzR+l+ndFXW8DCGsQHPKNtO6eTOzKNeDjoLLzUMN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:3a3:b256:f31f with SMTP id
 e9e14a558f8ab-3a617539ebfmr90746135ab.19.1730485702003; Fri, 01 Nov 2024
 11:28:22 -0700 (PDT)
Date: Fri, 01 Nov 2024 11:28:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67251dc5.050a0220.529b6.015d.GAE@google.com>
Subject: [syzbot] [io-uring?] general protection fault in io_uring_show_fdinfo (2)
From: syzbot <syzbot+6cb1e1ecb22a749ef8e8@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=162bc6f7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=6cb1e1ecb22a749ef8e8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f92630580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126b655f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb84549dd6b3/disk-f9f24ca3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/beb29bdfa297/vmlinux-f9f24ca3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8881fe3245ad/bzImage-f9f24ca3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6cb1e1ecb22a749ef8e8@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 UID: 0 PID: 5845 Comm: syz-executor422 Not tainted 6.12.0-rc5-next-20241031-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_uring_show_fdinfo+0xeed/0x1810 io_uring/fdinfo.c:181
Code: 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 cb 68 3c f6 48 8b 1b 48 83 c3 18 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 a5 68 3c f6 4d 89 fe 48 8b 1b 48 89
RSP: 0018:ffffc9000352f700 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: dffffc0000000000
RDX: ffff888030040000 RSI: 0000000000000003 RDI: 0000000000000000
RBP: ffffc9000352f940 R08: ffffffff8bc2f00d R09: 1ffff1100690201f
R10: dffffc0000000000 R11: ffffed1006902020 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888034e26128 R15: ffff888034e26120
FS:  00005555693ab380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564acb56e0d8 CR3: 000000007f2d0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 seq_show+0x608/0x770 fs/proc/fd.c:68
 seq_read_iter+0x43f/0xd70 fs/seq_file.c:230
 seq_read+0x3a9/0x4f0 fs/seq_file.c:162
 do_loop_readv_writev fs/read_write.c:854 [inline]
 vfs_readv+0x6bc/0xa80 fs/read_write.c:1027
 do_preadv fs/read_write.c:1142 [inline]
 __do_sys_preadv fs/read_write.c:1192 [inline]
 __se_sys_preadv fs/read_write.c:1187 [inline]
 __x64_sys_preadv+0x1c7/0x2d0 fs/read_write.c:1187
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7f677d1669
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffecebd7a78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 00007ffecebd7a80 RCX: 00007f7f677d1669
RDX: 0000000000000001 RSI: 0000000020000640 RDI: 0000000000000004
RBP: 00007f7f67844610 R08: 0000000000000000 R09: 68742f636f72702f
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffecebd7cb8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:io_uring_show_fdinfo+0xeed/0x1810 io_uring/fdinfo.c:181
Code: 00 fc ff df 80 3c 08 00 74 08 48 89 df e8 cb 68 3c f6 48 8b 1b 48 83 c3 18 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 48 89 df e8 a5 68 3c f6 4d 89 fe 48 8b 1b 48 89
RSP: 0018:ffffc9000352f700 EFLAGS: 00010206
RAX: 0000000000000003 RBX: 0000000000000018 RCX: dffffc0000000000
RDX: ffff888030040000 RSI: 0000000000000003 RDI: 0000000000000000
RBP: ffffc9000352f940 R08: ffffffff8bc2f00d R09: 1ffff1100690201f
R10: dffffc0000000000 R11: ffffed1006902020 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888034e26128 R15: ffff888034e26120
FS:  00005555693ab380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000008 CR3: 000000007f2d0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
   4:	74 08                	je     0xe
   6:	48 89 df             	mov    %rbx,%rdi
   9:	e8 cb 68 3c f6       	call   0xf63c68d9
   e:	48 8b 1b             	mov    (%rbx),%rbx
  11:	48 83 c3 18          	add    $0x18,%rbx
  15:	48 89 d8             	mov    %rbx,%rax
  18:	48 c1 e8 03          	shr    $0x3,%rax
  1c:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  23:	fc ff df
* 26:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2a:	74 08                	je     0x34
  2c:	48 89 df             	mov    %rbx,%rdi
  2f:	e8 a5 68 3c f6       	call   0xf63c68d9
  34:	4d 89 fe             	mov    %r15,%r14
  37:	48 8b 1b             	mov    (%rbx),%rbx
  3a:	48                   	rex.W
  3b:	89                   	.byte 0x89


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

