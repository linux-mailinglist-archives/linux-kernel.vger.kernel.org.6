Return-Path: <linux-kernel+bounces-385577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E2A9B38D8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB51C1F2307A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE311DF278;
	Mon, 28 Oct 2024 18:12:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED821DF738
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139151; cv=none; b=i5/Dxr7qAcWSiQiiqKVWdSntCVPPRk4zZbhYztZLTXBhsQtvISZgpknW70MQpU8h1arjSF/pyGDULidnAzPt1TgET8WfrZE8C59KXjdsuMMdEP/mLpZNTkLRbteFjoIOZJME8w4QwbB4uWJy/4LgjnOWGXLyHs9cIeu1R+SRkZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139151; c=relaxed/simple;
	bh=q6FpP2QA5N4r3dgwc3meUU6xGy7EzmpuvymXwJ1K8RM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ojv2vpsPHfo6UkNDdHKeLRbnzGhrVPBLkrQBHVaFQJYycS9CDOmeVHF2X/dP0As60pVV73KyjYeyo3xoiHHI8DRzmF3E537pOIJL/T1+1P0gJM8QiLKiQDeiioXN7av3MEAFiaO0uChyggQ7bIANCCeSM0FvkgmKz6TB7KYg9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a4e5c68f6bso38149515ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139148; x=1730743948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=St+fKTQI1ljguXNK5rR1GNwGlKeuluur0G4UkXay8fI=;
        b=Pr5OMZTzcJkOoDCUONUYYNevIjETl2GCa+9ZL3PBtI+u8CAmKjYbwr/uQNMMRm7NkV
         mvmpg25KLdlh0boukZ8SSagMA0noCDpcwVYMTQz/4QYgl8ChLr5N9v4MDfhL/vBZKavb
         5Ah5l8Mog9q0h+TH7JIzDmfVMgzB8FFXT+Eo8UMl4ONgBqSbQcUdha3fPKgHkGTf+bWB
         3a2h+E56R8/++p51B+wicVjP/OjKUNoFbxACMHnctcGA+s28qNhF3WKS6dxhqK3noeXk
         55Tg1D7dze53snpHNwFQ1S2GSB9b4PGsJCUQbWW5wV+lxhjaHeAv37TtDBx+uB2YEms1
         o4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU+bBiq3lBeattP8DlfSNgFAFnoYK4/BGCC7jFjl6ZGdoq/nANKUF3Yz+zzRu2Kb2A5G5FBI9/+cmQHRP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSOzROc82eH7y7qPVYhRI3XTBXJt79L0ZBRmGGCN+F3+aCW/9
	syZjtf/QZgL4GL84pJ22D/gYWZA7Ph+dS1e/GdPXvRj6Rv8UJgAr98BINUof2VP252YGAJ8c13a
	4u79/cWMxS1nC8GfGaNNIJG2cPcYi26geunoHx979wRMAq47QiFZqx9M=
X-Google-Smtp-Source: AGHT+IHTno+3mCcY2BMZQ3BatgETWv2efZ1dJCqFsErEnhDuipDHMcmEfutcotiC9PB8+iXsAVq12kDBEW65QDvIDwpeqUzYZrbb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156b:b0:3a4:ebfa:2ac7 with SMTP id
 e9e14a558f8ab-3a4ed2ef57bmr77193655ab.12.1730139148294; Mon, 28 Oct 2024
 11:12:28 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:12:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671fd40c.050a0220.4735a.024f.GAE@google.com>
Subject: [syzbot] [overlayfs?] WARNING in ovl_encode_real_fh
From: syzbot <syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178bf640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=ec07f6f5ce62b858579f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112628a7980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104bf640580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a3541902b13/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a00efacc2604/bzImage-c2ee9f59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com

RDX: 0000000000000000 RSI: 0000000020000440 RDI: 00000000ffffff9c
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000003932
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc9b4e42fc
R13: 0000000000000004 R14: 431bde82d7b634db R15: 00007ffc9b4e4330
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5103 at fs/overlayfs/copy_up.c:448 ovl_encode_real_fh+0x2e2/0x410 fs/overlayfs/copy_up.c:448
Modules linked in:
CPU: 0 UID: 0 PID: 5103 Comm: syz-executor195 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ovl_encode_real_fh+0x2e2/0x410 fs/overlayfs/copy_up.c:448
Code: 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 05 b6 75 fe 90 0f 0b 90 eb 14 e8 fa b5 75 fe 90 0f 0b 90 eb 09 e8 ef b5 75 fe 90 <0f> 0b 90 4c 89 ff e8 b3 6a d3 fe 49 c7 c7 fb ff ff ff eb 8b 89 d1
RSP: 0018:ffffc9000b1f73c0 EFLAGS: 00010293
RAX: ffffffff831f21f1 RBX: 1ffff9200163ee80 RCX: ffff88801fbc2440
RDX: 0000000000000000 RSI: 00000000000000ff RDI: 00000000000000ff
RBP: ffffc9000b1f7470 R08: ffffffff831f208c R09: 1ffffffff2039fdd
R10: dffffc0000000000 R11: fffffbfff2039fde R12: 00000000000000ff
R13: 0000000000000080 R14: 1ffff9200163ee7c R15: ffff888036790300
FS:  0000555590223480(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6fdf3d7709 CR3: 0000000040e6e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ovl_get_origin_fh fs/overlayfs/copy_up.c:484 [inline]
 ovl_do_copy_up fs/overlayfs/copy_up.c:961 [inline]
 ovl_copy_up_one fs/overlayfs/copy_up.c:1203 [inline]
 ovl_copy_up_flags+0x1068/0x46f0 fs/overlayfs/copy_up.c:1258
 ovl_setattr+0x11d/0x5a0 fs/overlayfs/inode.c:40
 notify_change+0xbca/0xe90 fs/attr.c:503
 chown_common+0x501/0x850 fs/open.c:793
 do_fchownat+0x16a/0x240 fs/open.c:824
 __do_sys_fchownat fs/open.c:839 [inline]
 __se_sys_fchownat fs/open.c:836 [inline]
 __x64_sys_fchownat+0xb5/0xd0 fs/open.c:836
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6fdf3812f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 1b 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc9b4e42a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 00007ffc9b4e42b0 RCX: 00007f6fdf3812f9
RDX: 0000000000000000 RSI: 0000000020000440 RDI: 00000000ffffff9c
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000003932
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc9b4e42fc
R13: 0000000000000004 R14: 431bde82d7b634db R15: 00007ffc9b4e4330
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

