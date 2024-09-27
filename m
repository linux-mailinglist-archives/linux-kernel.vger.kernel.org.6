Return-Path: <linux-kernel+bounces-342110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F83988AB1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF6B2132A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E2E1C231B;
	Fri, 27 Sep 2024 19:06:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5296316FF3B
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463988; cv=none; b=l89WovySnxLDrmv8fzUbxH/7R7YNSRTUSQVCGoYnNIMs7vZfy9lDOp9NhLbHcWoYa0qhP/DHe4hGzmhwhwFHnPh4Jb7gSUp8UPwyltdWQKU6bmcAsWIKMOyZ+QXEqqaquWsuNorCCbevxUDvFVRISXYnuVqD+K2+amW+wmsYBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463988; c=relaxed/simple;
	bh=w1dC9j7fndcQTKIgy4Ii3T0Rd7BykY2onXtMnlRZGcE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D1Peozyo5woOyvc+EjzOxRM/rPSQU90xwVKEKi6hT7cKV/X1zSX4ZeFoy8ana53nsRCpbayDV8nKLeG08cBFcWtqz/UBmLdiOK/mpMQkFukvNMzm0CuxA5RMOYQodC1MMgXEaln7v9xCw4GwWT4TqSfHXLVoFxjAtCJq6rGwj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so25685175ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463986; x=1728068786;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hgY8hzI99QnPWMPwvALIbHs6Az4q/B4sE1z/OIjt2MA=;
        b=FD4cVxbLA4JplOPoYQZQPDrWm0qL58Kisb4aQBV4q9FUWAdvt/Y+oVYNeDTG/18LXu
         qZ1NmSaNY26eqDRRvqZZd8CQZEk8tsglTCosSOPkXSDxMOsGCdsV/WsLWZdnyIIlKu6J
         ZUbNN4Q6h1WANVTb29A+77J0L5GTKeiVs2jYVt4sQ2uMeRcVxkCq6Sj4DSSWgabkAOax
         U0H7Et3ceopvWLnqw00ukffgG4zQoNlKLVNSFfdY87RJ2/gy3x5J0gVw7xGtW2pw7Kx6
         1qBG9bGssNUNFv2AhCbdAWqbrOZeJRweQtX0PrcbjFg/tKgmI7s/Z5PF8/66R8akj+go
         cDDw==
X-Forwarded-Encrypted: i=1; AJvYcCUER8V7NVikFgiO1TiOx4AqzCFj7AtKmftyJcMLfJZqooY/OajElKnDDokOhuJNYwx/xcCCBCKBsVzIQZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIruAKIfSMeGTrAj8zfC2h6zWQNHKQAHYf/Mi3mAC2EiWSemvc
	etDGVNTuIiomWXY2xQBoRe8kwX6m49YacVWRyc8OXOOi1gpWtM6ycTTPxSHpp8PBUJYkxradcDZ
	QPE/zzhhUm8cIR7Xyg3e2LnCkZVo5vwbq7Gq3GzUZagJK+LaAthzGp0E=
X-Google-Smtp-Source: AGHT+IGE8RNmEFTPX2Ywn6IH8Zh04GJEFSVVevZAvdbyqKj9hV2LEyChhp8FfbasKEdwpEq8OE+5ktgv1rh3oxhj4y8IB52wKtm2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c25:b0:3a3:44e6:fe66 with SMTP id
 e9e14a558f8ab-3a34515d324mr44989385ab.10.1727463986466; Fri, 27 Sep 2024
 12:06:26 -0700 (PDT)
Date: Fri, 27 Sep 2024 12:06:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f70232.050a0220.38ace9.002f.GAE@google.com>
Subject: [syzbot] [ntfs3?] WARNING in wnd_init (2)
From: syzbot <syzbot+47de774a425e2380f16f@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    de5cb0dcb74c Merge branch 'address-masking'
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b8ca27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
dashboard link: https://syzkaller.appspot.com/bug?extid=47de774a425e2380f16f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=159a0c80580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120d619f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-de5cb0dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2124e771a37c/vmlinux-de5cb0dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b134c0b5e676/bzImage-de5cb0dc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/22d82b1df465/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47de774a425e2380f16f@syzkaller.appspotmail.com

         option from the mount to silence this warning.
=======================================================
ntfs3: loop0: Different NTFS sector size (4096) and media sector size (512).
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5096 at mm/util.c:670 __kvmalloc_node_noprof+0x17a/0x190 mm/util.c:670
Modules linked in:
CPU: 0 UID: 0 PID: 5096 Comm: syz-executor108 Not tainted 6.11.0-syzkaller-08833-gde5cb0dcb74c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__kvmalloc_node_noprof+0x17a/0x190 mm/util.c:670
Code: cc 44 89 fe 81 e6 00 20 00 00 31 ff e8 1f ec b9 ff 41 81 e7 00 20 00 00 74 0a e8 d1 e7 b9 ff e9 3b ff ff ff e8 c7 e7 b9 ff 90 <0f> 0b 90 e9 2d ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
RSP: 0018:ffffc90002d9f8b8 EFLAGS: 00010293
RAX: ffffffff81dad1e9 RBX: 0003ffffff400002 RCX: ffff88801f15c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81dad1d1 R09: 00000000ffffffff
R10: ffffc90002d9f720 R11: fffff520005b3ee9 R12: ffff88804032e0b0
R13: 0003ffffff400002 R14: 00000000ffffffff R15: 0000000000000000
FS:  0000555588ee8380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa23b395ed8 CR3: 0000000041826000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kvmalloc_array_node_noprof include/linux/slab.h:1040 [inline]
 wnd_init+0x1ed/0x320 fs/ntfs3/bitmap.c:663
 ntfs_fill_super+0x2ffe/0x4730 fs/ntfs3/super.c:1315
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f528f5191fa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd5057158 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffcd5057160 RCX: 00007f528f5191fa
RDX: 000000002001f6c0 RSI: 00000000200000c0 RDI: 00007ffcd5057160
RBP: 0000000000000004 R08: 00007ffcd50571a0 R09: 000000000001f27a
R10: 000000000181c041 R11: 0000000000000286 R12: 00007ffcd50571a0
R13: 0000000000000003 R14: 0000000000200000 R15: 00007f528f56103b
 </TASK>


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

