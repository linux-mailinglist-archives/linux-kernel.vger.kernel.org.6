Return-Path: <linux-kernel+bounces-287510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 606009528A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 06:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44FB91F21559
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 04:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224C53BBD8;
	Thu, 15 Aug 2024 04:43:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619F3A268
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 04:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697012; cv=none; b=WInaCP29sEIJe9GR9ZBRk+7pk+jQo8NXc0QijRXdDpOU3sRk0VqQRlUXwBE3478MVznDrUyvWwcSAR739m/JQBCJtKOYWZM5grfzcGiimpIu4JwkLS1Qx3hGmc+eQ8mwYJbTVDtdjdqmN/TiPqAcMzjCTMG7Q6Esc2ieRXoxZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697012; c=relaxed/simple;
	bh=+OfmWu58lwiDcN9az/6Z+Dm3nYj6oZN1ZDy7lG/m4ro=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BF9RxQwgtNTs+U9Yozcu6USBSmEa1WlyjSjjPN/uOuAk95J/uRt2ll4WYGU4Wc+/xdLAR6q2ao2asaDPzls8zdaLIycVnBWloJmC6L8R/upflmPceShtSvq6sC0c8pEPuCtD7XODErh/KNLmFkSR4IgwMJmnqSGTT4DlUehPGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39ad7e6b4deso6543275ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723697010; x=1724301810;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KlINiNYAjwgbuikBxuQRI5vmFrO8r6178a8vmxg2PU=;
        b=KkdQVx5LiLxrqQ+VtK33ReAqlliqFv/sksbD215Sict/+CXmWVGnY4UMDSWgDiT5nh
         dgTjw9AMVEuwUHFf8OMJwGsr3pXKqDFwLhFuyxqiM/vkzLQ2G7BnCBb93w2VqxBOJA8G
         U24dWUpx7K7UezdYR4nwlIUfhHkmtkU5rXtqvEM0OliNlZ+HXgsYBv5iLBWsN624rWWv
         pqpfkKW9y2SFmHR0rw6m8Tpvqi30RUFtQ5pUH7jabnoflMlHZAySfFxABaBeZwBPK6np
         UsgzBk5wQ7MbUUdZzmMdn9hmsLdDfELvzkVx37QZJ4NLXJjvSIrBenJd+ppqmPO+j82e
         /x1g==
X-Forwarded-Encrypted: i=1; AJvYcCUDG/OYokv9cE+blF6pM9Gn0PEUiQ8WnfSWX2GzAD3Sih9UKsXF9c5s2bZtgeTzpfwVTKhAzOPjHPFrUhhkkmE2kFW48YSsgpfkVNGb
X-Gm-Message-State: AOJu0YwUf0QlJVool8t8V7WnGLG+MX/1VQePQj+KZXs4dreV2JsAaclf
	1xtQgR5c5/Mm9b5gZKd200dO0dL90xwWFeUHULlXx02wbGSTqjIyMxkPZLikKWIUf6N/8TjwiNW
	c5ldnBWQ2IHvc2luLnkVyrpvPvqK65YqBiVRsTzURMqV0d3oeITGKJQM=
X-Google-Smtp-Source: AGHT+IFa/f2OOuHz3CzVT4PzqgSqVTDToCuG5Lv0PYNlxJPAbDUJ5wVBraqQYZVic8v8NRoGpAxB9ECLWfDl2yy/QpYAkY7/SMa+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:398:3831:4337 with SMTP id
 e9e14a558f8ab-39d124f7a5bmr3069235ab.5.1723697010219; Wed, 14 Aug 2024
 21:43:30 -0700 (PDT)
Date: Wed, 14 Aug 2024 21:43:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000feae34061fb17b73@google.com>
Subject: [syzbot] [ntfs3?] WARNING in wnd_add_free_ext (3)
From: syzbot <syzbot+7f3761b790fa41d0f3d5@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5189dafa4cf9 Merge tag 'nfsd-6.11-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13007ae5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=7f3761b790fa41d0f3d5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14997d23980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17fb6ced980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/430efe109c38/disk-5189dafa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/01a4087208d1/vmlinux-5189dafa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/82162927fd2c/bzImage-5189dafa.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/663048cdc587/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/31fa56bb1564/mount_6.gz
mounted in repro #3: https://storage.googleapis.com/syzbot-assets/6bf53fa597f1/mount_7.gz
mounted in repro #4: https://storage.googleapis.com/syzbot-assets/19d8450427c7/mount_11.gz

The issue was bisected to:

commit 8335ebe195dcc76ece418485a9f08b9a9ad7fe23
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Thu Jul 7 16:25:43 2022 +0000

    fs/ntfs3: Make MFT zone less fragmented

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d4f2cb980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17d4f2cb980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13d4f2cb980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f3761b790fa41d0f3d5@syzkaller.appspotmail.com
Fixes: 8335ebe195dc ("fs/ntfs3: Make MFT zone less fragmented")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5807 at fs/ntfs3/bitmap.c:217 rb_insert_start fs/ntfs3/bitmap.c:217 [inline]
WARNING: CPU: 0 PID: 5807 at fs/ntfs3/bitmap.c:217 wnd_add_free_ext+0xaba/0xd60 fs/ntfs3/bitmap.c:352
Modules linked in:
CPU: 0 UID: 0 PID: 5807 Comm: syz-executor351 Not tainted 6.11.0-rc2-syzkaller-00257-g5189dafa4cf9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:rb_insert_start fs/ntfs3/bitmap.c:217 [inline]
RIP: 0010:wnd_add_free_ext+0xaba/0xd60 fs/ntfs3/bitmap.c:352
Code: 00 fc ff df 80 3c 28 00 74 08 48 89 df e8 2e be 14 ff 48 8b 7c 24 08 48 89 3b 4c 89 f6 e8 fe 08 c3 08 eb 13 e8 a7 9c b0 fe 90 <0f> 0b 90 48 bd 00 00 00 00 00 fc ff df 48 8b 44 24 38 80 3c 28 00
RSP: 0018:ffffc90004587008 EFLAGS: 00010293
RAX: ffffffff82e2da99 RBX: 0000000000000603 RCX: ffff888022c4bc00
RDX: 0000000000000000 RSI: 0000000000000603 RDI: 0000000000000603
RBP: 0000000000000603 R08: ffffffff82e2d9d2 R09: 0000000000000000
R10: ffff888076ea21a8 R11: ffffed100edd4437 R12: ffff888076ea2120
R13: ffff888076ea2120 R14: ffff8880240322d8 R15: 1ffff1100edd4433
FS:  00007fbc4836d6c0(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbc4834cd58 CR3: 000000007b5dc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 wnd_zone_set+0xa6/0x160 fs/ntfs3/bitmap.c:1421
 mark_as_free_ex+0x30d/0x390
 run_deallocate_ex+0x244/0x5f0 fs/ntfs3/attrib.c:122
 attr_set_size+0x168d/0x4300 fs/ntfs3/attrib.c:753
 ntfs_truncate fs/ntfs3/file.c:459 [inline]
 ntfs3_setattr+0x7a4/0xb80 fs/ntfs3/file.c:775
 notify_change+0xb9d/0xe70 fs/attr.c:495
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3381 [inline]
 do_open fs/namei.c:3731 [inline]
 path_openat+0x2ced/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbc483e0e89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbc4836d218 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fbc48486718 RCX: 00007fbc483e0e89
RDX: 000000000000275a RSI: 0000000020001000 RDI: 00000000ffffff9c
RBP: 00007fbc48486710 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fbc48452b94
R13: 0030656c69662f2e R14: 7275632e73646970 R15: 00007fbc48452940
 </TASK>


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

