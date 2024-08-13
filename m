Return-Path: <linux-kernel+bounces-285493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF2950E24
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA6C1C2317C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35691A7065;
	Tue, 13 Aug 2024 20:49:31 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C71A38EC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582171; cv=none; b=nPdtqwgUks384bBlKni+V/BbjgPN44oeN2ZS/8txCuMuD9PYHQIOBefD9s4OEJFcUGkQpqmrkKrhkNOaq9jdXMrz15pkYhafS9oVxHRJrdZ3ykGDCPo1QP3pQaFuI7WhWBy5sbmDLxD0bSVudqWC6fHa7fPyzyk1BP6iV56tdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582171; c=relaxed/simple;
	bh=EiT4Sh/TlUEfS98np+ZSarcrRWXKNgiurPtOYNWpY8o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oDX0W358bJPDsZyTdx4GCfKi/iKaz5D7QwiuvTlQVXtvAw1vObGqAF/JiHKk4K/R5M6zkMu0zSoK59lhZ6noKIuy2fXuTFCgSe1LuBR1MmZK+vzx5NJ+xWCY1NnAWVIMzqBKwVnoHhNW5D4AHOZbqyodWjKGz4JPbZMxg/JB4X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d10b6da2dso7360445ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582169; x=1724186969;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5Kkke9tL3v4lVVfPkmFG8izoAwG1RpBwsTReLWE04I=;
        b=QGT7DXgLuI59KzSVvCytMxf+U6601ypLL+skdgyFvxMlBcZFZQ5cVw7CBv7iHMnxGo
         LNW16hZ2mEJWN8uB1NNozsYDOb2yGdp4lnhzBUoEIRkyK13G2sZAwa3BBUTDF3aYCbPx
         /DXcblQDZdP/hFIufp55PmcokGVoWHhxoa1Pzpha/dLYzfnvnaSx2zFuU212WYrmaxNm
         D7hizf1dbBLWSPEKb/cB6QQEnF9OsiToE+Cgg/DAGFCD3dEjGZ9RYKMqMoXC1AUyHNyH
         Y3Zg9Pu0Hm/O1RM45raDE2jcI2DMZ8Toxm0kY0t1Vh1mJLWXedIE9NtRtUcbvu1z7YJQ
         lyUA==
X-Forwarded-Encrypted: i=1; AJvYcCXKp/9gT7xohroCcQ0TIjuqxTO2NDJ5vmmPZ4WvbHpJvDnL8nn1Jquc2+lRaINmK6KgrllKHPb8bqjr8zP7wKcZpWYlWAheG9KqnB5R
X-Gm-Message-State: AOJu0Yz3nMVv4n9j3CV/gJAEcHmpeNcB+DQQTis5M75lyrapSzV2wihu
	QDGkq+Sb+JsEMn7WrH2Vvzw5vAoiNJBDPymGkyG86MQ2tnaDejF45bBtXjjsSjLLiYs/VImx8ct
	FydwXPo7pYM22qKdT5V5ed0rC0gTWous9gKG6BtC7qTolubFk/DcMOFM=
X-Google-Smtp-Source: AGHT+IHxnlYeDkxLzfdRvriRh4COdW9nBQXt9nEoPN/DpZLTo0V4Qzu1bzwzXUiRALbjaRfvOPOYfvwMrEdFz5GhjZY2J4mGlAdS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca7:b0:39a:ea89:22e8 with SMTP id
 e9e14a558f8ab-39d1245851dmr454095ab.2.1723582168930; Tue, 13 Aug 2024
 13:49:28 -0700 (PDT)
Date: Tue, 13 Aug 2024 13:49:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ebae95061f96be85@google.com>
Subject: [syzbot] [f2fs?] WARNING: lock held when returning to user space in f2fs_commit_atomic_write
From: syzbot <syzbot+78ff2855f26377625419@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9e6869691724 Add linux-next specific files for 20240812
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=177ea68d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=78ff2855f26377625419
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13deecd5980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c1fdd9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1b086192f50/disk-9e686969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b457920fb52e/vmlinux-9e686969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e63ba9cce98a/bzImage-9e686969.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a0c7f05fa485/mount_0.gz

The issue was bisected to:

commit 7566a155c666dd23b413a002a50cd9ae7b95f053
Author: Chao Yu <chao@kernel.org>
Date:   Tue Jun 25 03:13:49 2024 +0000

    f2fs: atomic: fix to not allow GC to pollute atomic_file

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1255068d980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1155068d980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1655068d980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com
Fixes: 7566a155c666 ("f2fs: atomic: fix to not allow GC to pollute atomic_file")

F2FS-fs (loop0): Found nat_bits in checkpoint
F2FS-fs (loop0): Try to recover 1th superblock, ret: 0
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
syz-executor306: attempt to access beyond end of device
loop0: rw=2049, sector=45096, nr_sectors = 64 limit=40427
================================================
WARNING: lock held when returning to user space!
6.11.0-rc3-next-20240812-syzkaller #0 Not tainted
------------------------------------------------
syz-executor306/5229 is leaving the kernel with locks still held!
1 lock held by syz-executor306/5229:
 #0: ffff8880473a18b0 (&fi->i_gc_rwsem[WRITE]){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2196 [inline]
 #0: ffff8880473a18b0 (&fi->i_gc_rwsem[WRITE]){+.+.}-{3:3}, at: f2fs_commit_atomic_write+0x105/0x1510 fs/f2fs/segment.c:388


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

