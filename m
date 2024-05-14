Return-Path: <linux-kernel+bounces-178514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F638C4EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716A7B21BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DDF12DDAB;
	Tue, 14 May 2024 09:33:33 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58BE12D761
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715679213; cv=none; b=L+f83EkWc2sCod/ByvmsgPSF+wjzRdErv4LSfnoqETBa0KOFaeihkgpcmv+oj82ux4usJwjmtr5pu040aD6grBopEgiBy/7Y6zYhzbdQYUqkPJBZ4eFOIfhJjotsUx99Ea9zKS0F7YEZ+Ypjj3hMmYP+qMNPNjBafTO4/hUugN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715679213; c=relaxed/simple;
	bh=kURtlY5cDvzhTq9BlSF93mSqPcR3Ib3pu/yxpA7syRo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Vqm9GBiL4boc1tYaIKGIe2RtcDbAfUUGesh92Qv1Il9em7iMBwekrqvzWdkvZ5y5KvZCfAJfmtdvSF5O1ISsnZYnUUcFevqPrG4uUo//eZoOAe1Rc9RYhaf6DkwAHHCbVsFDDsbDJOeqjPpMuo1WgG/XRoxZXL/gbcdeBqckNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1c22e7280so484822139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715679211; x=1716284011;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAB1jUJaPwwIIZCl7ic94AmiI9/S/BxVDLghu+WIUYQ=;
        b=ObcgyFHENZ3chRyZ1oEiPFgNvFJw9svqY6rByR7vV98/bzZOxvt1/q/EVPscUiNrty
         Z+lD/+2PvnT8F0XtTooKpUp/wlccN+3tDWNcBR4D432zLi5QHIOUEdZJdhAmdTb1w1Ud
         4e7UjkPbdALLsl6DQZ1rdiuM00ffDshoaFB1VXPnmDLWHOVREWo2+y1VkzvNsgE9C2oD
         ezz3a6uM6q7ETbCrCs5ZOgDP/MsiCqxQHVRpZBXzLrHvYagHr5bWgmZx/y0CGoX/m8dF
         gtv27k3wHiMVZDwAMyBhR2o+O8LVYHgeZ0WppsSvBsBJ/6yjmsB5nUl3KfOWfSfKLaSs
         dYHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxcgpEkpW8Z2HUcxbPmB5GfVJGyr3GYKFiiFuP8Ged/BsZPuQ8q1MlgfVrcy7D2c7rM0exp4Ra8IhGyed/+Tdr8bcOwNu9zAqTrB+d
X-Gm-Message-State: AOJu0YwrPbWNQfZB+V4jFoVxpI1bqwywD3Pm9I0git1AQRkBLbsqOr+y
	Idw+rnHthVUu4yVNRDNB5aWN+YWnu8GU3Z+8sdLA7OCTUAehk50vu6y3JQMIeFGfZWY4ViTamd9
	eNbVdnB992k0qIf8J46z/oUMFkBgsmKW2x5fdcMEMlpqq1gforcqOMc8=
X-Google-Smtp-Source: AGHT+IHlE7LVzAW3RsUeVHqIZ0qSn+eH++WU1uD97Wi3J9INxjWyaSgSR1m8nYkrFV6eioFLo/H805lpgzqGGPAr+GrTioa0vAGc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:48f:b0:7de:e172:3d4e with SMTP id
 ca18e2360f4ac-7e1b5208481mr66921939f.3.1715679211020; Tue, 14 May 2024
 02:33:31 -0700 (PDT)
Date: Tue, 14 May 2024 02:33:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebf2e0061866b102@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_sb_dev_has_data
From: syzbot <syzbot+249018ea545364f78d04@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cf87f46fd34d Merge tag 'drm-fixes-2024-05-11' of https://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=162f8fbc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=249018ea545364f78d04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a40d04980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102e5b70980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c147953fc8e/disk-cf87f46f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a55c9d1f91fc/vmlinux-cf87f46f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f8dab47ae8c2/bzImage-cf87f46f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2c5c030a256e/mount_0.gz

The issue was bisected to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13d673d4980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=103673d4980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17d673d4980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+249018ea545364f78d04@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/replicas.c:1010:20
shift exponent 155 is too large for 32-bit type 'int'
CPU: 0 PID: 5075 Comm: syz-executor397 Not tainted 6.9.0-rc7-syzkaller-00183-gcf87f46fd34d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 bch2_sb_dev_has_data+0x22a/0x5f0 fs/bcachefs/replicas.c:1010
 member_to_text+0xcb/0x1030 fs/bcachefs/sb-members.c:163
 bch2_sb_members_v1_to_text+0x1aa/0x2f0 fs/bcachefs/sb-members.c:317
 bch2_sb_field_validate+0x1f7/0x2d0 fs/bcachefs/super-io.c:1228
 bch2_sb_validate+0x9b6/0xe10 fs/bcachefs/super-io.c:460
 __bch2_read_super+0xc9a/0x1460 fs/bcachefs/super-io.c:822
 bch2_fs_open+0x246/0xdf0 fs/bcachefs/super.c:2052
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1903
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f16b990d8ba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd930ef68 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdd930ef80 RCX: 00007f16b990d8ba
RDX: 0000000020011a00 RSI: 0000000020011a40 RDI: 00007ffdd930ef80
RBP: 0000000000000004 R08: 00007ffdd930efc0 R09: 00000000000119f3
R10: 0000000001200014 R11: 0000000000000282 R12: 0000000001200014
R13: 00007ffdd930efc0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
---[ end trace ]---


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

