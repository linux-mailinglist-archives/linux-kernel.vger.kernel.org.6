Return-Path: <linux-kernel+bounces-411718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E24B9CFEC7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208681F22E60
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 12:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEFE191F7A;
	Sat, 16 Nov 2024 12:19:27 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C32F3E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731759567; cv=none; b=l2VPWtDz58lPYeL1tlKvlHgA2RVI0LdQJnICQDm6ybLwCoSBvT38MBoR780z+/b+qkip0yHQWQJ1mbiYB7fzoGmDf24tUyonjH51k2F083CXvGoVi97e3ncafcAAa5r2wxqNqi0gkcKqXbW3e9w17R9WnHacTbRsQeW2pLRI+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731759567; c=relaxed/simple;
	bh=vO5KtMJiMiJzKM//YoXE7G/y0SOlestyR4qo9xWpZEM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LBGvEbc5jXQdCT5l9w+HOOXti0riRhlm/IgyfXVwMJo7fZDxK5ZoKJTqpH46ssrBskc59LcAAZGtaM4lUSrX1x2S5rupEg4OlBCcvPzFU7NqDQ+ZtyaEyM/2ED2i2v095mSo1j+29bNb56s4DftC7U7CUzzj3hTAxRifl5FEf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a71d035135so6803145ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 04:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731759565; x=1732364365;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3anrA2PKz52eUeH1obWVljaLKGmkTsCdR4ZJj9hlvjE=;
        b=mnsrluwxhBZmykk6sRZE2WM8/PG3Wu85eHGFU+YEfom6AmuUWk2YAAc8Oz4G62CCNC
         PNidLqPrf+cAMaJxjX8o7thW5vkCfG1+NaXtfpTLml7tufBlVzdiMRti/8RdJXKJjK0j
         KY1wg2VGLQocOuUVh3S9iKa42HDuMBZr5ba9ILwRzNDADXnrF4vTzKMOkFqwTI+GrKPh
         vLeSG1Zw3qzjeSe6171/pQt6FXpASDrpzIHinBorRBj/Pjt17tLWqIvUA+N5Az3j6K0S
         dXi6PTvAF35Z2dqAgqhnIDFmsw++gumAipDsiABZc+vPCgMX/wRAXMabRpqXUIOeTkZ3
         HkQg==
X-Forwarded-Encrypted: i=1; AJvYcCXmCD1tNNWpEwPt1tjAyU71ofZdmEpG36qRw+v70LfeIv4WO8DDIKRlrlGtku4dprvQZCEutthYNmzY4L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuwdZ/Zrx9O+HphMopfnx5qx0i1oLhVeS4jqonJKy30Qf5MEDB
	fdDoITuv9fRc3HXDPA7bUJxglZ01r9krI+7ZgWIZA+5gC2q3wNFED+1VkhSY988G4GkMmGWxVc9
	K8DW3JJQ0NYquh4qhhOQPj94APQpgUQXcxiIANr3/m2WzJmzYEAxFr0Q=
X-Google-Smtp-Source: AGHT+IFbSbf0OEedC5Ufrq0317YnBNFYeic6nqI9O0JEfjvq2aLN3ue6tcGQ2rxSjvE5LQd5Ruz7GduzwOJ5ykzIt3J3+RVUjXmJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda3:0:b0:3a4:ec4b:92f0 with SMTP id
 e9e14a558f8ab-3a748077de2mr57693315ab.19.1731759565014; Sat, 16 Nov 2024
 04:19:25 -0800 (PST)
Date: Sat, 16 Nov 2024 04:19:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67388dcc.050a0220.bb738.0008.GAE@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (4)
From: syzbot <syzbot+5c81eb8c0a380fa578b5@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108a0ce8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a2d329b82126/disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37a04ca225dd/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f837ce9d9dc/bzImage-2d5404ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c81eb8c0a380fa578b5@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:901!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 6239 Comm: syz-executor Not tainted 6.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:901
Code: 2e 8b a5 fd 31 ff 89 de e8 25 8b a5 fd 40 84 ed 75 28 e8 1b 88 a5 fd e9 3c ec ff ff e8 11 88 a5 fd 90 0f 0b e8 09 88 a5 fd 90 <0f> 0b e8 01 88 a5 fd 90 0f 0b 90 e9 fc fe ff ff e8 f3 87 a5 fd e8
RSP: 0000:ffffc9000529f928 EFLAGS: 00010293
RAX: ffffffff83ef51a7 RBX: 0000000000000002 RCX: ffff8880312a1e00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83ef4b90 R09: 1ffff1100c3aeed9
R10: dffffc0000000000 R11: ffffed100c3aeeda R12: ffff888027a68000
R13: ffff888061d776c8 R14: ffff888061d77228 R15: dffffc0000000000
FS:  000055556b022500(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcb2134e000 CR3: 0000000061454000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x4e8/0x9b0 fs/inode.c:725
 dispose_list fs/inode.c:774 [inline]
 evict_inodes+0x6f6/0x790 fs/inode.c:828
 generic_shutdown_super+0xa0/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1710
 kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4927
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f34b5b7fa47
Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff051bb088 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f34b5b7fa47
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff051bb140
RBP: 00007fff051bb140 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff051bc1c0
R13: 00007f34b5bf14b4 R14: 000000000002dc8b R15: 00007fff051bc200
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:901
Code: 2e 8b a5 fd 31 ff 89 de e8 25 8b a5 fd 40 84 ed 75 28 e8 1b 88 a5 fd e9 3c ec ff ff e8 11 88 a5 fd 90 0f 0b e8 09 88 a5 fd 90 <0f> 0b e8 01 88 a5 fd 90 0f 0b 90 e9 fc fe ff ff e8 f3 87 a5 fd e8
RSP: 0000:ffffc9000529f928 EFLAGS: 00010293

RAX: ffffffff83ef51a7 RBX: 0000000000000002 RCX: ffff8880312a1e00
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83ef4b90 R09: 1ffff1100c3aeed9
R10: dffffc0000000000 R11: ffffed100c3aeeda R12: ffff888027a68000
R13: ffff888061d776c8 R14: ffff888061d77228 R15: dffffc0000000000
FS:  000055556b022500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f00031ff800 CR3: 0000000061454000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

