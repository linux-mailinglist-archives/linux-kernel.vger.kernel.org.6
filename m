Return-Path: <linux-kernel+bounces-418396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B229D612E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E163F1603B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B2E1DE88B;
	Fri, 22 Nov 2024 15:15:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F213D2B2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288527; cv=none; b=hJxjAisMPj1EsHpHMqQHZ2/JSys1P0sYYEXtQhMGNyI7bghM9BxO+vgCAMHTHn7IJvjQBa4Gdy4OjpW0WKsyeLsDUMmzOgP7xs+3LbBlVwJ6ezuvkw+2P1JKNQip2yJ2aTylArXLhcepfRs/awPbdYfRCJL7w0OibmWjN/kgruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288527; c=relaxed/simple;
	bh=QuC+M2sxgVF2RFm2qrIs/DwGTkCOc+GiEkPfFjpbkB0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fwkuvMeECG01d+eoQo2kIQyxwxdUile9/Ky1IdQ2h1Pe4QHcAczMhXseoIlPohwZb1PfUVDknPPHb9xRuaqa9gP5Ao8C301yf9HBodwQFhLvpbcyDeM7SFHF4SI4wBa/AR5yuQlAcSzvmXZJkaLGXgUAO6fwI9H8TEkqZcozVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a79088e7abso22082955ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288525; x=1732893325;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ejQ4luGM0Gf7q3W5sue7aadcqAkloWGiUT5VdFqQcio=;
        b=arOcdf2w9CHACjhqgKjl0TaNPufTLlwLLZ5KHnimIfaZnWs57XhGKUlxbOJm1JO4r4
         r2VZdSa/hCaXrATsoMbCHnZQVTOFfRh7r4LTqWB7iOBcdiW8z24ZQlhgnHL+8IVisp+h
         YgbHJuh6W9qrLU/zw3W8Ch/jmt3smu2KEtUqKCwwN8JfWt4NQZpeQkgZa6B7kt3C+r3I
         nOJHKzXLnzJxMfi8sKbqnlSrIaaT0O2RRJxBTZ7niBoaX+s3zuZAZoadSyv7dkjoeNk9
         2esTTgtR6MlhBbUfohwknPmA8lsYhg4FDIIHGhhYpyijFFm3vL8rfAAxc62sYiQrKmBf
         dM/A==
X-Forwarded-Encrypted: i=1; AJvYcCWRxuSAHfAECaT+cQAXIvIlOkghnTElFVkEka7Nlpgt9RfFAvjU9WbZe0ulj5M+AjSrJhsuNrXvQr2Toas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypxm9utawUSKFo2ZdvKSb2i2Z4G3cGKucAafszWmqsOUWBKExK
	o+WOPy4xgIsmZW6GOt8Kvj/fzCrn+f4qSDMAO3UbpnkR253k2iQ/eYVcM1dAGpoJnkoldg3RJkT
	BercujdyF2U2oBtgWXliOzF+dvIBTw23YnpZw9FZ0tMoTfDVZv7PHRRM=
X-Google-Smtp-Source: AGHT+IEuzJDSiXvi4tJrnkPXJgVJtTbxGoUlnFlYXnfnOA85fBK28gFk1/h0ZXpAQ0p5T+ReZxKH1kWjBmAvrnY3xqHS3o1l7bRM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c8:b0:3a7:9801:9d11 with SMTP id
 e9e14a558f8ab-3a79afd9c2fmr27835885ab.22.1732288524703; Fri, 22 Nov 2024
 07:15:24 -0800 (PST)
Date: Fri, 22 Nov 2024 07:15:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6740a00c.050a0220.363a1b.0144.GAE@google.com>
Subject: [syzbot] [f2fs?] WARNING in f2fs_delete_entry
From: syzbot <syzbot+35a21b6aade7af3c7b3a@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b1d1d4cfac0 Merge remote-tracking branch 'iommu/arm/smmu'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12978ec0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dfe1e340fbee3d16
dashboard link: https://syzkaller.appspot.com/bug?extid=35a21b6aade7af3c7b3a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f31b78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16978ec0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/354fe38e2935/disk-7b1d1d4c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f12e0b1ef3fd/vmlinux-7b1d1d4c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/291dbc519bb3/Image-7b1d1d4c.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/009d543e9698/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35a21b6aade7af3c7b3a@syzkaller.appspotmail.com

F2FS-fs (loop0): invalid crc value
F2FS-fs (loop0): Found nat_bits in checkpoint
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
------------[ cut here ]------------
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.c:336
Modules linked in:
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor117 Not tainted 6.12.0-syzkaller-g7b1d1d4cfac0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : drop_nlink+0xe4/0x138 fs/inode.c:336
lr : drop_nlink+0xe4/0x138 fs/inode.c:336
sp : ffff8000a3d57930
x29: ffff8000a3d57930 x28: 0000000000000000 x27: dfff800000000000
x26: 0000000000000003 x25: fffffdffc363c040 x24: 1fffe0001bc77232
x23: 1fffe0001bc7723b x22: dfff800000000000 x21: 0000000000000000
x20: ffff0000de3b91d8 x19: ffff0000de3b9190 x18: ffff8000a3d57520
x17: 000000000000d842 x16: ffff800080355c58 x15: 0000000000000001
x14: 1ffff00011f440c0 x13: 0000000000000000 x12: 0000000000000000
x11: ffff700011f440c1 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : ffff0000c2d80000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff8000933cf888 x4 : 0000000000000004 x3 : ffff8000804807cc
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
 drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
 f2fs_i_links_write fs/f2fs/f2fs.h:3127 [inline]
 f2fs_drop_nlink+0xd0/0x2ec fs/f2fs/dir.c:822
 f2fs_delete_entry+0x9c8/0xcb0 fs/f2fs/dir.c:886
 f2fs_unlink+0x48c/0xad8 fs/f2fs/namei.c:572
 vfs_unlink+0x2f0/0x534 fs/namei.c:4469
 do_unlinkat+0x4d0/0x700 fs/namei.c:4533
 __do_sys_unlinkat fs/namei.c:4576 [inline]
 __se_sys_unlinkat fs/namei.c:4569 [inline]
 __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
 el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
irq event stamp: 212352
hardirqs last  enabled at (212351): [<ffff80008047a5a4>] seqcount_lockdep_reader_access+0x80/0x104 include/linux/seqlock.h:74
hardirqs last disabled at (212352): [<ffff80008b4b302c>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:488
softirqs last  enabled at (212312): [<ffff80008020396c>] softirq_handle_end kernel/softirq.c:400 [inline]
softirqs last  enabled at (212312): [<ffff80008020396c>] handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
softirqs last disabled at (212299): [<ffff800080020db4>] __do_softirq+0x14/0x20 kernel/softirq.c:588
---[ end trace 0000000000000000 ]---


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

