Return-Path: <linux-kernel+bounces-296862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE7095AFEF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A5B51C22C67
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7DC16EBEC;
	Thu, 22 Aug 2024 08:11:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410CE16A955
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314285; cv=none; b=C6yse/y2PyMjwIAQJoAzzqPJ5xC1quQVkLwuaWz6Ww6HtyjwqC5MuSYM/Y1LZgN0ZPyhx2wgfWixRDiWCJZ11x103a3mkTagVDNFFlBJrXpNvhlzL7iKUctnqy9VsP3V6L5CHpyMSMckOjpg/Z9/A8lmc70bc45Uz3NGVB87JZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314285; c=relaxed/simple;
	bh=G6kwiZn+TMjTY5AQa1oDjQjKCUPOt+jGlDql56vTilA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KPE7X8pvvbCxl+eySpzl45ks92MJgf3G5wfohoRVbCy/QauBv/I8iyXKyLfgB8kRH8U4imZqfXZIXCE3Mn3e/ebZ+42l9/+h1QlGsArtPLLOvw5rROUR2mWqXt3IrI5ECnaulAed9j7IrUfadH9e/pHHqHjk3pn95TBKKoo3ylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa44764bbso57402939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724314283; x=1724919083;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kwgo8GM4qwz2LIHM+QrkESbLV7CJIlgDH2Lxi7v5Eeg=;
        b=UqfYszecRwmfeerzKuyV0uD1/Ah5nBQMgV4EkAwAv2RK9h8DU14Kg+oLpbAooPw/ZU
         kh48uj9hGPIVTUlsMBCwB/Ey4470LalZw6nzKjH8718bL8VojnOzEuhc2loc29pNGoEk
         hOQFnlehudSSSKwlELrfWznqqmrRAxd3rJiAKD7WGa9++NGxSeYSPeKekkZfrLjcXdPF
         VEJq90dimuvvKeaOgigAp/YjVIK3dL43G2frLJW7T87db3ikd80+W0/aBWDnhH30oqpj
         yb00IDNRyt2aaW7kz3nNU9WKFKoNTXEGX6bru2a6SkAvgnHWuJ4v+pZSw13pdiu50jJH
         VSXg==
X-Forwarded-Encrypted: i=1; AJvYcCXjJIFzc8wn3vrwF/2HMS1KQ4k39dEeSRCB1AtMIwmSwdeSvlA5Np3nKzHG6GrVZ2ss1+nhAu15NPDwRYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7q3Zs7Vh5MMMDhB8LreJoIyN63/4enENYfE7Hxu0d2bwZGIQj
	23PPuD6JrS5O82iWZh73kHy1J0OWeUu2C9eibOMnS718BB9mS/2w0LJTyPf6dS3XqjZMoicaWPh
	fM8Vju8IU3CyUNHg8V/jodKq02cerbxwFlkcwcdi6DPEvvhSItzjmZNI=
X-Google-Smtp-Source: AGHT+IHVmDybS8JpLETGFUGH6E+mCgYvAxtn69Ro+jRZQ1yl8ercFlms5qCgMojDAMIfMjhEyreFLLlmm/Zklg3hGV1yK7F+Ei8h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8719:b0:4cc:eaee:f13d with SMTP id
 8926c6da1cb9f-4ce626b2fa3mr231887173.0.1724314283278; Thu, 22 Aug 2024
 01:11:23 -0700 (PDT)
Date: Thu, 22 Aug 2024 01:11:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000560ff106204134d2@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in ocfs2_claim_suballoc_bits
From: syzbot <syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    872cf28b8df9 Merge tag 'platform-drivers-x86-v6.11-4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e78c33980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=96d38c6e1655c1420a72
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1641940b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c6747b980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-872cf28b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e42852893b68/vmlinux-872cf28b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99d0f54d6297/bzImage-872cf28b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7e59b3a54e83/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96d38c6e1655c1420a72@syzkaller.appspotmail.com

         option from the mount to silence this warning.
=======================================================
ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
------------[ cut here ]------------
kernel BUG at fs/ocfs2/suballoc.c:1441!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5092 Comm: syz-executor170 Not tainted 6.11.0-rc4-syzkaller-00033-g872cf28b8df9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_find_victim_chain fs/ocfs2/suballoc.c:1441 [inline]
RIP: 0010:ocfs2_claim_suballoc_bits+0x240c/0x2570 fs/ocfs2/suballoc.c:1982
Code: 0a 12 05 fe 90 0f 0b e8 02 12 05 fe 90 0f 0b e8 fa 11 05 fe 90 0f 0b e8 f2 11 05 fe 90 0f 0b e8 4a 40 28 08 e8 e5 11 05 fe 90 <0f> 0b e8 dd 11 05 fe 90 0f 0b f3 0f 1e fa 65 8b 1d 9b 5d 75 7c bf
RSP: 0018:ffffc9000af36da0 EFLAGS: 00010293
RAX: ffffffff838e795b RBX: 0000000000000000 RCX: ffff88801c86c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000af37050 R08: ffffffff838e6445 R09: 0000000000000000
R10: ffffc9000af370e0 R11: fffff520015e6e21 R12: dffffc0000000000
R13: ffff88805f022008 R14: ffff88803f268400 R15: 0000000000000002
FS:  000055558fd61380(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001d86c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_claim_new_inode+0x338/0x870 fs/ocfs2/suballoc.c:2267
 ocfs2_mknod_locked+0x17a/0x3b0 fs/ocfs2/namei.c:633
 ocfs2_mknod+0x17d4/0x2b40 fs/ocfs2/namei.c:379
 ocfs2_create+0x1ab/0x480 fs/ocfs2/namei.c:672
 lookup_open fs/namei.c:3578 [inline]
 open_last_lookups fs/namei.c:3647 [inline]
 path_openat+0x1a9a/0x3470 fs/namei.c:3883
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f40f4c89c59
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc3348c8c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f40f4c89c59
RDX: 0000000000040942 RSI: 0000000020000200 RDI: 00000000ffffff9c
RBP: 00007f40f4d015f0 R08: 000055558fd624c0 R09: 000055558fd624c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc3348c8f0
R13: 00007ffc3348cb18 R14: 431bde82d7b634db R15: 00007f40f4cd203b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_find_victim_chain fs/ocfs2/suballoc.c:1441 [inline]
RIP: 0010:ocfs2_claim_suballoc_bits+0x240c/0x2570 fs/ocfs2/suballoc.c:1982
Code: 0a 12 05 fe 90 0f 0b e8 02 12 05 fe 90 0f 0b e8 fa 11 05 fe 90 0f 0b e8 f2 11 05 fe 90 0f 0b e8 4a 40 28 08 e8 e5 11 05 fe 90 <0f> 0b e8 dd 11 05 fe 90 0f 0b f3 0f 1e fa 65 8b 1d 9b 5d 75 7c bf
RSP: 0018:ffffc9000af36da0 EFLAGS: 00010293
RAX: ffffffff838e795b RBX: 0000000000000000 RCX: ffff88801c86c880
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000af37050 R08: ffffffff838e6445 R09: 0000000000000000
R10: ffffc9000af370e0 R11: fffff520015e6e21 R12: dffffc0000000000
R13: ffff88805f022008 R14: ffff88803f268400 R15: 0000000000000002
FS:  000055558fd61380(0000) GS:ffff888020800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001d86c000 CR4: 0000000000350ef0
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

