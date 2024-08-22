Return-Path: <linux-kernel+bounces-297547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE995BAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6D41F23BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F11CC17B;
	Thu, 22 Aug 2024 15:38:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051A51CB30F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341101; cv=none; b=BTwQi3by7NMsqDXJ/qV3F/steQ2s1A1R+99pdiB7Fo9ND9gODxwd3yzmpngYlSzLUR4/hoa4I8qy3M8QDzfKDIZalE+pBN5hUxIu2zauD88KUYViVXGn55YnQa0G/FCJTC4A97r2ROh8GFgJ4YD7uXukKcC1fr2qEKluja/qW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341101; c=relaxed/simple;
	bh=Gl2UxPETi8oCJN7w7psP5fGk21HkMQECQYviwtc9BFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=byBZvwFQLUqxVeBUhbqdSutdlmRn1J2WsfOIdEX2D76s36ZG6jzHPTmXkacHDG9yeyKigRbPv0N1LQ0gFDZPllz6E89fQVHMo1gOM47Q4p4lFtI1Ej5RMCj5W1lAG2QfKIMNQvrPu5A9CIXqUKVCcpGq2lT+OArtJwUa4rMp4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d27488930so9037595ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724341099; x=1724945899;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfKYsHbOQ5A3mI9bYwHAlT48QrarSm2MDkSYLCjLupw=;
        b=l5QYy+Rb04Xvq92bu/nFlNL0hxCdRnQgJPfg7KHyTxL7p+cJ8Nzy4ywUp32wgLwhjv
         qXBMOzdgCXYOGPg67Ls3Cil3hNjc+p0Ei7W0alCg351XvVdPnxYuCt3dpmhKUUSPMrGJ
         4RrUgiHiZKDTl8rfnjxw0+4O1Dm0jtZnRP4tTqc7sEqFigKUtLYSXqKEw5omiAnOmXmu
         hG/beQuq+JNalcXFHk5qeRjaT/BiYle68X8RyghLNvmyVW/phHDVsc9fIMnkyO0VgRCQ
         ZWkYsD4pBRek9+Yts5je9/AuBhr0fxxk0gABUuky63Gnn6Mkv5XT2haTRBX+hTK0w4Db
         W5Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUsjAZqsyyojP6kCEXSOy7Z/bmz0+HiBSTCsyyj9M2jOb7QbZ1FdoEGnRkV7v/lMgCXGqmDaAyKE+ojeRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+KHCobazMCoa1quWHaq+Qfo5l8/nX2muoGy0OjKkmnZGrcEs
	wI4JfZb/EYRVUPLl2Q+10jTNLF1d97Xg5bH/bp8zNu8zw5nVJr0k+KvcB1hxXSFtyyteM3l/yAs
	zVN5QI1GxbU7AnJIYPumTct8iXN42WIY20c3A+uxD6F3tuVq3pwN1Qjw=
X-Google-Smtp-Source: AGHT+IEtX8IqW5G74fu+kZOKoA3ERwvpjCtOsNXhOVU26AFXVmnWAcMS4XoFfI2w7ZOh/fGgXZFWdBJ4yPGlH9ea+b7uuVtZa7RR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d16:b0:39d:1ca5:3903 with SMTP id
 e9e14a558f8ab-39d6c353c38mr4303105ab.1.1724341099171; Thu, 22 Aug 2024
 08:38:19 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:38:19 -0700
In-Reply-To: <000000000000a7b20f061ff2d56a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0231406204772a1@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (3)
From: syzbot <syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    872cf28b8df9 Merge tag 'platform-drivers-x86-v6.11-4' of g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ece38d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=ebea2790904673d7c618
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1344680b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1034880b980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c63409516c62/disk-872cf28b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79b2b8c52d3a/vmlinux-872cf28b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/27cb9df9c339/bzImage-872cf28b.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/1f04d7ef7499/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/831601ee93df/mount_5.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebea2790904673d7c618@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/f2fs/inode.c:896!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 5217 Comm: syz-executor605 Not tainted 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
Code: 6e 9b ab fd 31 ff 89 de e8 65 9b ab fd 40 84 ed 75 28 e8 5b 98 ab fd e9 3c ec ff ff e8 51 98 ab fd 90 0f 0b e8 49 98 ab fd 90 <0f> 0b e8 41 98 ab fd 90 0f 0b 90 e9 fc fe ff ff e8 33 98 ab fd e8
RSP: 0018:ffffc90003497808 EFLAGS: 00010293
RAX: ffffffff83e7f267 RBX: 0000000000000002 RCX: ffff88801a3e8000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83e7ec50 R09: 1ffff1100efe9611
R10: dffffc0000000000 R11: ffffed100efe9612 R12: ffff88807a834000
R13: ffff888077f4b088 R14: ffff888077f4abe8 R15: dffffc0000000000
FS:  000055556d6353c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f376cbf9000 CR3: 00000000786a0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x532/0x950 fs/inode.c:704
 dispose_list fs/inode.c:747 [inline]
 evict_inodes+0x5f9/0x690 fs/inode.c:797
 generic_shutdown_super+0x9d/0x2d0 fs/super.c:627
 kill_block_super+0x44/0x90 fs/super.c:1696
 kill_f2fs_super+0x344/0x690 fs/f2fs/super.c:4898
 deactivate_locked_super+0xc4/0x130 fs/super.c:473
 cleanup_mnt+0x41f/0x4b0 fs/namespace.c:1373
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2402
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xc6/0x190 kernel/entry/common.c:173
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:200 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:205 [inline]
 syscall_exit_to_user_mode+0x279/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f37740a00a7
Code: 08 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffc120a25e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000015fbb RCX: 00007f37740a00a7
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffc120a26a0
RBP: 00007ffc120a26a0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000206 R12: 00007ffc120a3750
R13: 000055556d636700 R14: 431bde82d7b634db R15: 00007ffc120a36f4
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:f2fs_evict_inode+0x1598/0x15c0 fs/f2fs/inode.c:896
Code: 6e 9b ab fd 31 ff 89 de e8 65 9b ab fd 40 84 ed 75 28 e8 5b 98 ab fd e9 3c ec ff ff e8 51 98 ab fd 90 0f 0b e8 49 98 ab fd 90 <0f> 0b e8 41 98 ab fd 90 0f 0b 90 e9 fc fe ff ff e8 33 98 ab fd e8
RSP: 0018:ffffc90003497808 EFLAGS: 00010293
RAX: ffffffff83e7f267 RBX: 0000000000000002 RCX: ffff88801a3e8000
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff83e7ec50 R09: 1ffff1100efe9611
R10: dffffc0000000000 R11: ffffed100efe9612 R12: ffff88807a834000
R13: ffff888077f4b088 R14: ffff888077f4abe8 R15: dffffc0000000000
FS:  000055556d6353c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f376bda6000 CR3: 00000000786a0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

