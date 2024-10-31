Return-Path: <linux-kernel+bounces-390498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5249B7AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1D01F2520D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379C119D880;
	Thu, 31 Oct 2024 12:34:34 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E6194C6B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378073; cv=none; b=j6v1/5CLC9r7jvvohIVKNwXFk9g6iZg4sTW16Oj+m2D34RutRjj6aPm77OpOJb5MBmlQZQrbQ4qCX2NlpbQd+5iT5Wt7EnRmjnKQ2CLa9ki8NAkUVv52tWnokUKN9J61RLF5jxR3N20uZpvkg2ufT9dF5DMAbFC4LyWAnNMAmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378073; c=relaxed/simple;
	bh=IOLEIvFntfa/vJIfsQrKeKgmzvB1DmysIaiRifAEDhA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=H6Ij82bgkV5KaRP1cbbOmdjLU4Tt4c8J7kkfhno9ceW97GTceurSx0+A2AAMUI6odX6aRMZuDTuXxRFWK9aoC81TLSwQwxaFFg/WxdVS6JOOF0NormyLEISx2Do5YisANWOM3eugfX808U+ufnF91p8HC6rV0CYUyR/N5dm/Qxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3ae3c2cacso8117125ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378070; x=1730982870;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xv6ARN5aEJ9MUwnWoiTuHTxUy2W0dDI5d24R9VVxYp0=;
        b=rsJBj63zoOzrgUsMIlVyRrscFdz6+j3sOBRwlfnzV0jhBtkMsHM520g4Yhtz2LjsNP
         7fQcO9pJpRWBaVi4TTx0DKrd1LARnXvSr7WGF0urHHHksAah5iSMc6Z/wFjKKBGETVWL
         AjwyrSzx7UjCrhlx5A03HC2/cjVGtqczW4iRRLzjnr6t2V26jEGtanCuyFxtAfIVWD0G
         IwaM6tyqy+3wX/tim4VPmXZrZQ8CIl5UTgjjrQdIgIAiEr0uVezmPk0trDbrKEAYJHc0
         44aJsaQpdB+Y4TDQPbXwqPc4LaM1natchlSHvjdws4U9JdhxoFm3mEorRq6GzxyeMniP
         /JaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg3avpEzGirb3snvLFesYG+5gKlIWRB8UazPflbkNv9/JNo+ZVP+O50UezfPaaJ9Chic8Dk4sP63fWDV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0ghpFkcEtE6UdHpuO6tMsT/xF/JUe4LUgZt1ckZqzf7QKFId
	W6L4nAalf8Ygc0RA8u0iPF2KHQiHO0AmakQBTm0kkRVkBO605Y5OHLkgJp/ckdV0/y/ZTdWEfyi
	Rq2wutdX7OnItPQCqof2dC4YLHQm03ddwgeNwgVWJ80b7Gm6wIWusmEI=
X-Google-Smtp-Source: AGHT+IFU/b84mYqdr2YklowtdzDfYYUNrJpqW599a9vUVayG4XUjgCe/yToCpCOVO2/3c8/LcOTzoNsbq0YayU0TQbWynVd3Cno2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c81:b0:3a4:e67c:eb7f with SMTP id
 e9e14a558f8ab-3a60f229da5mr36529555ab.15.1730378070348; Thu, 31 Oct 2024
 05:34:30 -0700 (PDT)
Date: Thu, 31 Oct 2024 05:34:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67237956.050a0220.35b515.015c.GAE@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_iomap_begin (3)
From: syzbot <syzbot+626aa13bf52efc3aa86e@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    850925a8133c Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109c2940580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=309bb816d40abc28
dashboard link: https://syzkaller.appspot.com/bug?extid=626aa13bf52efc3aa86e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-850925a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c831c931f29c/vmlinux-850925a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/85f584e52a7f/bzImage-850925a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+626aa13bf52efc3aa86e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5328 at fs/ext4/inode.c:3389 ext4_iomap_begin+0xaa2/0xd30 fs/ext4/inode.c:3389
Modules linked in:
CPU: 0 UID: 0 PID: 5328 Comm: syz.0.0 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ext4_iomap_begin+0xaa2/0xd30 fs/ext4/inode.c:3389
Code: 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 18 ce 34 ff 49 be 00 00 00 00 00 fc ff df 48 8b 5c 24 48 e9 61 ff ff ff e8 ff cd 34 ff 90 <0f> 0b 90 41 bc de ff ff ff e9 87 f6 ff ff 89 d9 80 e1 07 38 c1 0f
RSP: 0018:ffffc9000d087560 EFLAGS: 00010293
RAX: ffffffff82601c71 RBX: 0000000010000000 RCX: ffff888000bb8000
RDX: 0000000000000000 RSI: 00000000000000d4 RDI: 0000000000000000
RBP: ffffc9000d0876d0 R08: ffffffff826013b8 R09: 1ffff110087be63b
R10: dffffc0000000000 R11: ffffed10087be63c R12: 00000000000000d4
R13: 1ffff110087be69f R14: 000000000000000b R15: 0000000000000000
FS:  00007fbf155ff6c0(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbf09d45000 CR3: 0000000042eb6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 iomap_iter+0x691/0xf60 fs/iomap/iter.c:91
 __iomap_dio_rw+0xdea/0x2370 fs/iomap/direct-io.c:677
 iomap_dio_rw+0x46/0xa0 fs/iomap/direct-io.c:767
 ext4_dio_write_iter fs/ext4/file.c:577 [inline]
 ext4_file_write_iter+0x15f0/0x1a20 fs/ext4/file.c:696
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbf1577e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbf155ff038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbf15936130 RCX: 00007fbf1577e719
RDX: 000000000000001c RSI: 0000000020000300 RDI: 0000000000000007
RBP: 00007fbf157f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fbf15936130 R15: 00007ffd4ab6bf78
 </TASK>


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

