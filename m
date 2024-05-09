Return-Path: <linux-kernel+bounces-174762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A288C14A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF60D2819A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E18E7EF12;
	Thu,  9 May 2024 18:20:34 +0000 (UTC)
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A897EF02
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715278834; cv=none; b=EWDri19fBGLXpA1bHE7IN7uVMKW9MsgF+L1vtxP4HDdWD7dbq8UlGqEPyPTxicDTdeWtrCcqjP7QWj6iOukWAPv+B90fj+iz01qpdLT+lIpKOq4O6haqQUIWJapWPPR0+TUubeX5rMpek6/QWxWtC8I1j48YqXnlRUgtgmL+ii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715278834; c=relaxed/simple;
	bh=A/E0A/P32TGhxzHZi+5Gm0N8XE0PiUO4vgwJsfWz51s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lRAJKVRTFyFIS+OaQ1szyEuXYT+SrrRn4NablydDFym1x3dmgm2ovbT3JZM+s5m0txZf8vvFvJ/+NyYOfsXXJ59lZy+eI6mSVoX02naePb7ROz1dkNbls3hBchIhtNC6hFYqb8n2I/dsNlBw7Vpr9hPtdKERuEjx5Zrnf0zNfOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e1b65780b7so11714539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 11:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715278831; x=1715883631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T1RH5NVOJ+gNod5M6x8WPGgAaUoOxvUyj5zzhvkcIvU=;
        b=R2MqMgtFqbzdDXz+0fpyrKkkviCBAYGQJUuxwMUmq97+g5UVrLk/cc+6ZqanoF16ST
         N/Zsm4KE9AWIGrrYsc5OQDZF5mvfhtFil+Yg/nlw0nLw+naY5miWrMHx71jjBAk3oT3h
         Bo2YU99FDNC1Fv2X58fKeHrtTsjXgd8zgHhpu3O81YJwFw3JaJkFg7ShFuOg7mkfP6TP
         G9wnEJI+P+nC3xkCTmBhvSy7RadLiVOf+jyQYiOqazSMyO8Hzx5AklWmDU0wu6PFjP+x
         QvtB499yftJzG5nVk6/LtEDCxqqcdBWiv6O9ewMV7NtmXLmPOtTRojARWTp1HEDZRDMd
         6PcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7xlHRdZtT85yqO5nBSEpSTqJP5XrATQkV/pu+AHEGeSUE6Q/Luh1rxaLYGZrMJ6DqUpmirC0vB3AWmFgGEv9aaV1zNQXF3MZnbc6X
X-Gm-Message-State: AOJu0YxlFw2Stgqny4L8rS7RxqOujYAnHZ+1vwcMA/l93UJcHZSWppAm
	MGATv6ktevPz6j63+vwRptDvOkAKoqdIJBGCI8iYnf2kFz8Q7JBBLinnId9Q7V5eobkE79cgEW/
	2dqxzG0wm4TKGTp66PIhAaviPtEqPBl9V07GZso4Yhoa+Tap/izjco1c=
X-Google-Smtp-Source: AGHT+IFbd2uWtX7GAvoAVSd1xCJ/tlrYyHTVLjM85FEUU5xUsKaYlzv89TmJ8tLw5WXIb4pYwsPYWD+dRIUlFj7yOKVOH9Dv0sTI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8506:b0:488:f465:f4cd with SMTP id
 8926c6da1cb9f-4895856fa08mr14460173.1.1715278831552; Thu, 09 May 2024
 11:20:31 -0700 (PDT)
Date: Thu, 09 May 2024 11:20:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000721c2f06180979fc@google.com>
Subject: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer (2)
From: syzbot <syzbot+67f60a88fd6facb063c5@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b9158815de52 Merge tag 'char-misc-6.9-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157f69df180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=67f60a88fd6facb063c5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cce8a7180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e90b54980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df94a89cedc6/disk-b9158815.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ba4fcae1454/vmlinux-b9158815.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f238a9413b64/bzImage-b9158815.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2be1818fa274/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/210e60e68a3d/mount_3.gz

The issue was bisected to:

commit 63e92a0c5a0d5816803907a3e30a91ef72c903a5
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Tue Feb 14 09:57:09 2023 +0000

    fs/ntfs3: Undo critial modificatins to keep directory consistency

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b99824980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13b99824980000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b99824980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+67f60a88fd6facb063c5@syzkaller.appspotmail.com
Fixes: 63e92a0c5a0d ("fs/ntfs3: Undo critial modificatins to keep directory consistency")

------------[ cut here ]------------
memcpy: detected field-spanning write (size 3656) of single field "hdr1" at fs/ntfs3/index.c:1912 (size 16)
WARNING: CPU: 1 PID: 6119 at fs/ntfs3/index.c:1912 indx_insert_into_buffer.isra.0+0x103a/0x12a0 fs/ntfs3/index.c:1912
Modules linked in:
CPU: 1 PID: 6119 Comm: syz-executor897 Not tainted 6.9.0-rc6-syzkaller-00290-gb9158815de52 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:indx_insert_into_buffer.isra.0+0x103a/0x12a0 fs/ntfs3/index.c:1912
Code: 4c 7e b9 fe c6 05 f0 b0 b4 0c 01 90 48 8b 74 24 68 b9 10 00 00 00 48 c7 c2 60 81 43 8b 48 c7 c7 c0 81 43 8b e8 d7 e8 7b fe 90 <0f> 0b 90 90 e9 e1 fd ff ff e8 08 ca 14 ff e9 56 f4 ff ff e8 fe c9
RSP: 0018:ffffc90009f876c0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 00000000ffffffe4 RCX: ffffffff81503279
RDX: ffff888023540000 RSI: ffffffff81503286 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88807248c471
R13: ffff88802caecc00 R14: ffff88807b610800 R15: ffff888025a46018
FS:  00007fc54202e6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc539c1b000 CR3: 0000000023d38000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 indx_insert_entry+0x1a5/0x460 fs/ntfs3/index.c:1981
 ni_add_name+0x4db/0x820 fs/ntfs3/frecord.c:3055
 ni_rename+0xa1/0x1a0 fs/ntfs3/frecord.c:3087
 ntfs_rename+0x96f/0xf20 fs/ntfs3/namei.c:334
 vfs_rename+0xf84/0x20a0 fs/namei.c:4880
 do_renameat2+0xc54/0xdc0 fs/namei.c:5037
 __do_sys_rename fs/namei.c:5084 [inline]
 __se_sys_rename fs/namei.c:5082 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:5082
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc542099289
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc54202e218 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007fc54215f6d8 RCX: 00007fc542099289
RDX: 0000000000000000 RSI: 0000000020000f00 RDI: 0000000020000400
RBP: 00007fc54215f6d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc54212c0ac
R13: 00007fc5420ed06b R14: 00007fc54212bfa8 R15: 0030656c69662f2e
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

