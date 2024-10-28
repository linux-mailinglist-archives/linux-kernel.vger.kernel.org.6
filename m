Return-Path: <linux-kernel+bounces-385823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6932F9B3C2F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E193B1F22DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC31DF985;
	Mon, 28 Oct 2024 20:47:26 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B241C3F10
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148446; cv=none; b=DIfChpKIv0MUI6RbXY53o80BM3u8/0nMrZcGWlXM0s+Cz0FyceDZgMpn15nfjWEH9zV2vjEnXfzr7vd5lBXFS6pVwe3kNTxTExmssNxEJsa4gRDMgmf8mZdbNLLbd6hn6+teuYu0LwSYQ5L4heVqzcUWkTS9+ORsu8zSFPzn4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148446; c=relaxed/simple;
	bh=N6bOlJD7PbaacOZTLVaB5y/OgJJV366J1EHzdDh+e7k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kqk4ockVFAHNrQOJFv3x8/N0EHuoQ62YVAyr9tOnrqarDKznvGtJbWv992ttwoRAziR2Ky2g5JhJGqTIsXLpiYbxnAvOrU6Y365i5NBfQvFR5fWu9zTmL0QhcVj1YCkUy4r4z8TxEGrDunciiTAtLrIpM0BtrvrEa+g1MrDOi0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4f2698c76so19133305ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148443; x=1730753243;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDyEXl6HR/2DQ7b9MMx8HahR7q5lnqMBfeBQrEM3ITU=;
        b=CE+5ZcP96+/xxQdTKBWv4xwdLTPFHygyB3iS7DkidXi2cfumP3iNh2+U6e4xchRK95
         aqPWHrNzx8bAYf9R0UNybweCTBwxkaCqVM6nyyQ/P8X3qCVVochSyWzRt3I3CKf4ipu6
         aI1mBmBAYBEPKXoNQ4y7tx2QgMDY/mnIgMW0l9yBoAs7EtQofGugrDcSmvC0C2gr/vGQ
         wly70sHzKxJ66No6oRs6aRf/1biXHizxJRbmSJeEgxKZn/SZY0JHPnWNe2ey2zT/pTT5
         EEgveoaRI6NCx+JTB6pIe4WKOPI9bDd79Jd24Kr4GgWruuS/MJwkqNaAvDiv7Bk6zBXc
         8hKw==
X-Forwarded-Encrypted: i=1; AJvYcCWBmGLUpC0imxBoUVBHFgBNEMYzO2JxoYpuA6QZDym+lffbNX25GjwpTYgQ0baoEf+C1Du/S+gkG7O5ft4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlGnPkB4mDRbYM03nRBuZskHpFhsJqtMDRBhOef4aDmx9MEVrV
	H9rYNbHbufCL1q/kZv76V+kKuVrEe2oidFROq3ReMmc3sFnJn9JwY7ZGYjq6gtXmq1nvjSQKZwT
	AatPxf3Op7DE6U0Y68NU3bgUgi+Hu6sah5pLhp7wl9JdukBC/Qtcf4Hg=
X-Google-Smtp-Source: AGHT+IEqKIMGfSjyyjY6QtkQx5kwG+mIIJfbiQmQGjUtL8Qj5HaR4eL70NEuw1NB9njNAx2zusEYsdswkk3aYsyvNlW+y1cYfCN8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:b0:3a3:a5c5:3915 with SMTP id
 e9e14a558f8ab-3a4ed32f502mr85967235ab.16.1730148442850; Mon, 28 Oct 2024
 13:47:22 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:47:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671ff85a.050a0220.11b624.04b3.GAE@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in ocfs2_journal_toggle_dirty
From: syzbot <syzbot+ea8d1726e1e3367085ce@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c128a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=ea8d1726e1e3367085ce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b9d287980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a3541902b13/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a00efacc2604/bzImage-c2ee9f59.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7a179d67c0cd/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea8d1726e1e3367085ce@syzkaller.appspotmail.com

(syz.0.130,5573,0):ocfs2_assign_bh:2416 ERROR: status = -30
(syz.0.130,5573,0):ocfs2_inode_lock_full_nested:2511 ERROR: status = -30
(syz.0.130,5573,0):ocfs2_shutdown_local_alloc:412 ERROR: status = -30
------------[ cut here ]------------
kernel BUG at fs/ocfs2/journal.c:1012!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5573 Comm: syz.0.130 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_journal_toggle_dirty+0x397/0x3a0 fs/ocfs2/journal.c:1012
Code: 70 fe e9 f7 fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 2a fe ff ff 48 89 df e8 24 12 70 fe e9 1d fe ff ff e8 da 4c 06 fe 90 <0f> 0b e8 d2 db 37 08 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000b916ee0 EFLAGS: 00010293
RAX: ffffffff838e8b06 RBX: 00000000ffffffff RCX: ffff8880009d2440
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc9000b916fb0 R08: ffffffff838e8870 R09: 1ffffffff2859322
R10: dffffc0000000000 R11: fffffbfff2859323 R12: dffffc0000000000
R13: ffff8880416cc570 R14: ffff888051214600 R15: 1ffff92001722de4
FS:  000055558215b500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcefd324000 CR3: 000000004b2fc000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_journal_shutdown+0x479/0xc30 fs/ocfs2/journal.c:1094
 ocfs2_mount_volume+0x169f/0x1940 fs/ocfs2/super.c:1840
 ocfs2_fill_super+0x475a/0x5750 fs/ocfs2/super.c:1084
 mount_bdev+0x20a/0x2d0 fs/super.c:1679
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb70397f79a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe031589e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe03158a70 RCX: 00007fb70397f79a
RDX: 0000000020004440 RSI: 0000000020000040 RDI: 00007ffe03158a30
RBP: 0000000020004440 R08: 00007ffe03158a70 R09: 00000000000008c0
R10: 00000000000008c0 R11: 0000000000000246 R12: 0000000020000040
R13: 00007ffe03158a30 R14: 0000000000004436 R15: 0000000020000180
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_journal_toggle_dirty+0x397/0x3a0 fs/ocfs2/journal.c:1012
Code: 70 fe e9 f7 fd ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 2a fe ff ff 48 89 df e8 24 12 70 fe e9 1d fe ff ff e8 da 4c 06 fe 90 <0f> 0b e8 d2 db 37 08 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc9000b916ee0 EFLAGS: 00010293
RAX: ffffffff838e8b06 RBX: 00000000ffffffff RCX: ffff8880009d2440
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000000000000
RBP: ffffc9000b916fb0 R08: ffffffff838e8870 R09: 1ffffffff2859322
R10: dffffc0000000000 R11: fffffbfff2859323 R12: dffffc0000000000
R13: ffff8880416cc570 R14: ffff888051214600 R15: 1ffff92001722de4
FS:  000055558215b500(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000004b2fc000 CR4: 0000000000352ef0
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

