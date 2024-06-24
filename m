Return-Path: <linux-kernel+bounces-226816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140BD914449
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A937B23511
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4D949650;
	Mon, 24 Jun 2024 08:10:22 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE249627
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216622; cv=none; b=TQNzM9J2kVdh2ZficB5qwDkx+QwnvPya5BrfHN11xKcFFnZsBsvht2VS7wTZdL7t7PxaMXwPpFpjI5gDtMVTNXUGR8lo3CIgS69Mi7X5W6fCogTkkimw9jTk0J4wFkCjP2JS1GYgfsc8TKkAxQoJVS3bnLvQyfwv5XDEDI2DLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216622; c=relaxed/simple;
	bh=zIyvgWFaeIlC6wY0oLvhImDAkpB3sPxCGbJFpjHhtYU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=neKKS5zo2PAswxxzOkFdBSfWsHkre+qcQtx6/sQ3Horh5EkD/TOkwi0GQkj9oF+amRC5KJflG190FDMcpWM2FJ4LXTaeBBsmvliNo6pG+rsn8yr0ZWwlgAcsGPWM8G+NpaCNYTB/rJ+W6yMIaxTv5yXr3tgqwkZ2GYM550iKvbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-7f38e9f1f06so433624339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719216620; x=1719821420;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4ui/w/2QHEuTbhE9x9Ney1/6b+4+wI7ecwps7AMd9k=;
        b=xO92PNU14e2jDrRh9zRzToOVmcKueVKH9RhI4enC+ccN8qmWV6oLI5mZgH5+PSRyl6
         RM5MJaumurlu1HGD8SIrrNCKmCNM9ZUvAH95KQMnC36whFRzpTq1tf1smtSbC8UCpTCA
         5+k3qhpqpZFgHANEdKTlBwezAJyC6mCWX4SnlrSfEGafHpnmGbM3s9ypmC5bTp194kO9
         wEBDk83X+FT5AJ8SpXL9LjR22H43yZuPucmChSC55Tctv9Hd4Zq0PM75Cy3HGCb6WF1s
         41zpnDdPk+cftRnVWsqV4Jf5afqRqWqLff0r4uJx8BskfXWu5FggbxjQft3UygfWHzhY
         GBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7KubyLFS8WBk0OprkxKv2Yx0DhLWQhaaMnnc3bzNxgmzYOH9eq1jj751MkOsfrj6UeAoBuMdH60e9zKkHuH7vot2aEZAPJjxrG/6X
X-Gm-Message-State: AOJu0YzeMHt+VJLthpAcZBnA2j0ySPke2EPUFa0TUE7tHNNZpd4nHjqS
	XAbtZhaGrcboB5lJMH/c7hxuyThJYCZFQA34pRRKSQxX4RqhdyXFOczUnlN10DADBjGr7DCo4cY
	ZwTFwr10025eldSQOqoQrvphrMNefBkDF4DpWN0fZe9igxRXazrSVvX8=
X-Google-Smtp-Source: AGHT+IFswqZDd0QhNaYPhOWm4JfDIL0Iv6J8blqz9+BBmj1/+K3kKzSiDXIJPipv1kvIV1AM1Mm6qTt7FGoEpq14wibUmsx0yxms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0c:b0:7eb:ee5e:cc05 with SMTP id
 ca18e2360f4ac-7f3a4f6b459mr9015239f.4.1719216620082; Mon, 24 Jun 2024
 01:10:20 -0700 (PDT)
Date: Mon, 24 Jun 2024 01:10:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eea704061b9e4fb8@google.com>
Subject: [syzbot] [ext4?] WARNING in __ext4_ioctl
From: syzbot <syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c16f0a4ed1c Merge tag 'i2c-for-6.10-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e04151980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d112b9ab538ebab
dashboard link: https://syzkaller.appspot.com/bug?extid=2cab87506a0e7885f4b9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b29845d4c0ce/disk-7c16f0a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e39e5d18a392/vmlinux-7c16f0a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f6ac8c44d142/bzImage-7c16f0a4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2cab87506a0e7885f4b9@syzkaller.appspotmail.com

------------[ cut here ]------------
strnlen: detected buffer overflow: 17 byte read of buffer size 16
WARNING: CPU: 1 PID: 19420 at lib/string_helpers.c:1029 __fortify_report+0x9c/0xd0 lib/string_helpers.c:1029
Modules linked in:
CPU: 1 PID: 19420 Comm: syz-executor.1 Not tainted 6.10.0-rc4-syzkaller-00330-g7c16f0a4ed1c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:__fortify_report+0x9c/0xd0 lib/string_helpers.c:1029
Code: ed 48 c7 c0 20 c9 8f 8b 48 0f 44 d8 e8 8d 53 0b fd 4d 89 e0 48 89 ea 48 89 d9 4c 89 f6 48 c7 c7 a0 c9 8f 8b e8 e5 6e cd fc 90 <0f> 0b 90 90 5b 5d 41 5c 41 5d 41 5e e9 3e 67 8c 06 48 89 de 48 c7
RSP: 0018:ffffc90004c2fbf0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff8b8fc920 RCX: ffffc9000bb9b000
RDX: 0000000000040000 RSI: ffffffff81514a46 RDI: 0000000000000001
RBP: 0000000000000011 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000010
R13: 0000000000000000 R14: ffffffff8b8fd2e0 R15: ffff88802bb42060
FS:  00007f6eba6e46c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff2d1cbc28 CR3: 0000000062552000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __fortify_panic+0x23/0x30 lib/string_helpers.c:1036
 strnlen include/linux/fortify-string.h:235 [inline]
 sized_strscpy include/linux/fortify-string.h:309 [inline]
 ext4_ioctl_getlabel fs/ext4/ioctl.c:1154 [inline]
 __ext4_ioctl+0x404d/0x4580 fs/ext4/ioctl.c:1609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl fs/ioctl.c:893 [inline]
 __x64_sys_ioctl+0x196/0x220 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6eb987d0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6eba6e40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6eb99b3f80 RCX: 00007f6eb987d0a9
RDX: 0000000020000100 RSI: 0000000081009431 RDI: 0000000000000003
RBP: 00007f6eb98ec074 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6eb99b3f80 R15: 00007ffcd312f958
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

