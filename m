Return-Path: <linux-kernel+bounces-336557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9E983C52
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95321C225DF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 05:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A383AC2B;
	Tue, 24 Sep 2024 05:20:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450B1B85CF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727155231; cv=none; b=EWEuLPcywiXcjG9Picb+s0XJRXL/RSXKUWE3Wgswfcx0mSFWii6DUR8wcC9p0qvQ+EpRZMs+X+NXVRs5E29T9ORdJY/IhYSVv0auhWEZtXqXB1xmm2H6VkTWDw+mpy//sJj71GEe2+seWdH6QcNqNo4aIssgedksjFuNf52qJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727155231; c=relaxed/simple;
	bh=iUt3mVwkN9ouI7nqUHGZK3+oLndEiVA/ex/B6M46Im0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qurZ+aU6Seg6OYOBp6eQM6rUlUQ2SjREEFTQ2gTRcmEYjMZNebnK1YQoK3jiF/Kbk4Q1ekNWBQp7HxaH9GeoQECzMUexlhv90eMX5bY8MKIZJAi6vGP4BaVtiKhPGJcP4runGTqkZLYMCUBp69jdhLrqUevHHTGHGNLqtZQvlas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cd9c20b2bso704077339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 22:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727155229; x=1727760029;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtOAhvzrE3NiHI+6u3Xq/T0/jo8d75uTK8vspri69UI=;
        b=SJFhC0V+M0zjpLLRyU4G2kMi110sJjaMZ7g02dWwrU7RFSSpVKponq8NsXPC49xJdG
         NiqjK7hvJLimTtCp4QQDLQ7eoF7TPSmCCd5uQ4h0WZSAiDc3FmdxHG8oimzKlnAF4o7N
         AIjvP8FasGrfGnvUv1dS6KM4FQtE1i4LvBFHNU35to7Cpt0Jj2xnsBE712dd1IGlFEGK
         JpKj3AcE53ihhOXLASGy2invHWXOY6HMseYoly1n11/gVXOFrwjv4VgPqYFtUgLwuFyA
         GxSszyaoz+7hXtkEEt2RqZiKAsnI45lBMfWjqS7O0XM1l0eGuEjwWYTjgPgfSw7kVBhw
         E+SQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1MaU4o9HxhOlj1dq2K0cT4/1Obt51XQBJajkY3e1wuUTNDL8tak/0igHqQZMQe8YXiTT7kcGo1JESKDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ke51VYpjq0ISbd7ryKxITJ/F2pWFqb4ZVbG9mAVPM7S9l9Xi
	jS1QvgV/pooSCsB1d/AIgoWMosHoMnwQcxiN9l4Gs1Y2pUKLvujb3jOFnD/apZfnJQMZOsLDBRw
	0tN0/HDoQ7AsKL2w8HiUBWHn/hqHip5r5YX+OTuw1NmKsqIwenUZsWcM=
X-Google-Smtp-Source: AGHT+IFrvxIdrk2sPHgKGF8JJbwmCGbe9cHcp6OohgBPCAJtAQseD4QLCNlWMsCLnWPar8uR3k/mv/+NpBUr17jVQl0HyAeO2kGk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:52d:b0:3a1:a179:bb54 with SMTP id
 e9e14a558f8ab-3a1a179bd78mr28973925ab.0.1727155229007; Mon, 23 Sep 2024
 22:20:29 -0700 (PDT)
Date: Mon, 23 Sep 2024 22:20:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f24c1c.050a0220.3eed3.0020.GAE@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in ocfs2_populate_inode
From: syzbot <syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2004cef11ea0 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17e84ca9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38d475ce6711b8b4
dashboard link: https://syzkaller.appspot.com/bug?extid=779d072a1067a8b1a917
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11257b00580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bfc427980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8e353f58adf6/disk-2004cef1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0638768bdedf/vmlinux-2004cef1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/89ae9bc7ea4e/bzImage-2004cef1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/28a85cffdc50/mount_0.gz

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12446e9f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11446e9f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16446e9f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+779d072a1067a8b1a917@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
kernel BUG at fs/ocfs2/inode.c:336!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5225 Comm: syz-executor259 Not tainted 6.11.0-syzkaller-07337-g2004cef11ea0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:ocfs2_populate_inode+0x17c1/0x17e0 fs/ocfs2/inode.c:336
Code: de e8 a3 93 0e fe 45 84 f6 75 2f e8 99 90 0e fe 49 bc 00 00 00 00 00 fc ff df 4c 8b 6c 24 20 e9 a8 f1 ff ff e8 80 90 0e fe 90 <0f> 0b e8 78 90 0e fe 90 0f 0b 90 e9 bb fe ff ff e8 6a 90 0e fe e8
RSP: 0018:ffffc90003bded20 EFLAGS: 00010293
RAX: ffffffff83862e50 RBX: 0000000000000020 RCX: ffff88804d20da00
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000000
RBP: ffffc90003bdee50 R08: ffffffff8386215b R09: 1ffffffff20365d5
R10: dffffc0000000000 R11: fffffbfff20365d6 R12: dffffc0000000000
R13: ffff88807497cfb8 R14: 0000000000000001 R15: ffff88801a86fe2c
FS:  0000555560764380(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd72273000 CR3: 000000007892e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_read_locked_inode fs/ocfs2/inode.c:542 [inline]
 ocfs2_iget+0x1162/0x2180 fs/ocfs2/inode.c:159
 _ocfs2_get_system_file_inode fs/ocfs2/sysfile.c:142 [inline]
 ocfs2_get_system_file_inode+0x352/0x7b0 fs/ocfs2/sysfile.c:112
 ocfs2_init_global_system_inodes+0x32c/0x730 fs/ocfs2/super.c:457
 ocfs2_initialize_super fs/ocfs2/super.c:2250 [inline]
 ocfs2_fill_super+0x3068/0x5880 fs/ocfs2/super.c:994
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc4abec51aa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd72272638 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd72272640 RCX: 00007fc4abec51aa
RDX: 0000000020004480 RSI: 00000000200044c0 RDI: 00007ffd72272640
RBP: 0000000000000004 R08: 00007ffd72272680 R09: 0000000000004476
R10: 0000000000800401 R11: 0000000000000282 R12: 00007ffd72272680
R13: 0000000000000003 R14: 0000000001000000 R15: 00007fc4abf0d03b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_populate_inode+0x17c1/0x17e0 fs/ocfs2/inode.c:336
Code: de e8 a3 93 0e fe 45 84 f6 75 2f e8 99 90 0e fe 49 bc 00 00 00 00 00 fc ff df 4c 8b 6c 24 20 e9 a8 f1 ff ff e8 80 90 0e fe 90 <0f> 0b e8 78 90 0e fe 90 0f 0b 90 e9 bb fe ff ff e8 6a 90 0e fe e8
RSP: 0018:ffffc90003bded20 EFLAGS: 00010293
RAX: ffffffff83862e50 RBX: 0000000000000020 RCX: ffff88804d20da00
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000000
RBP: ffffc90003bdee50 R08: ffffffff8386215b R09: 1ffffffff20365d5
R10: dffffc0000000000 R11: fffffbfff20365d6 R12: dffffc0000000000
R13: ffff88807497cfb8 R14: 0000000000000001 R15: ffff88801a86fe2c
FS:  0000555560764380(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd72273000 CR3: 000000007892e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

