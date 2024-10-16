Return-Path: <linux-kernel+bounces-368118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C97BD9A0B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3735928154D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5B0208D90;
	Wed, 16 Oct 2024 13:28:33 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079C1C2325
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085312; cv=none; b=XXLlwxnPD2rCKVr7uT2yX1irJbSYK/BBuFAUVftO0/awGATnRCgTLGyWpAX7kk53qoUh57Ijyz56kIoVD4ZJQMyMh1fesmWlhZ5+VL5ba6QN8ywd6FcbuFPFjz0z6xcEqIzkUCkZ0nlN04R0QiuuzQxDPffvYNxBtp0S8VfCLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085312; c=relaxed/simple;
	bh=cDH7W5SIRx6EvRVcEvp5Ew170fZtpONlu3SBvrY/X6w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MNDdqz0NbU0rAww25h7HE/wc9cJirSJGix3BkXwqOpeJ+Wi6GHRQNEoecBjgnveX97lCpTDTRNPGLPkW0VDEy0ywc4Q4CmcnnvTeBC9aUaRFMtOhmx/MZoOYSLRrn2defLxvt+Drt0m0CHTtrMfyxgfuE4vbdM5PL7xqn/zCmeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso37527615ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729085310; x=1729690110;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2viWj9RmwKjrmmP92RP6ps4fihzdHe/1KNGxiCL1tzI=;
        b=VDX1kZfl1fVqCBmeJMJTYuIRC0211wB0oesek0oDSvngZqmV5ZHxpYDloKAuRw2X4h
         A7FDRYeh/DvQwXMH3EWEewR5K6TinmeccohbUH+Nb2JiNSGCtyu74hE6paBdZ+HmM9FY
         L+7Dx4bqN0WiqXstZQl/VaUR80Md1NaUJzJPMWJ89Wh2rEcfpORK5h6P5QT3oPBQwtDz
         HjUbWeriZXQ+fz+e+wvLSudkKkW/y38xGEGNofo7lJBnxWOiG8sTHczr+ZrcyygLBhQX
         0OvGZSimgtLwmhp2ZTlmDRhtoVFyaVor607oogiHWxNjh86biw6frGIy7T/BlFkhxt78
         QDnA==
X-Forwarded-Encrypted: i=1; AJvYcCXefRQqgVkhHiyvbxgxDSMRz/rhpG/i0zsuSdyJLRsjgeTtp6Nye+5UDIqb5hOS2ClDkfAfe6z0iI1+UjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPU5GnT3SyJ/wmX0mHJRy68zQ/Fbbu0ZiahG0Xm3EorqPtwbh2
	b7j4DXjWCX36rGDj/d564632i5O3oPZN3VNK1nDPEP/qof5TGIbKaRUy5M3MIG4Oth/HpEtPst2
	/okisCHlUDln5O4xdcSeD+5gu2ooA8mqsi97+O/k1SA6+9FsdtxHqrck=
X-Google-Smtp-Source: AGHT+IFhHlpgKJjj9INdUnW92Srm+iHrIJjIkv78+sCcQuHPiR72YJr+h40NLJLxknlXvJVmH04uwfbB5EDLVXb0d1FcW34LAxL+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216d:b0:3a3:41cf:f594 with SMTP id
 e9e14a558f8ab-3a3b5f72f0emr177858645ab.12.1729085310390; Wed, 16 Oct 2024
 06:28:30 -0700 (PDT)
Date: Wed, 16 Oct 2024 06:28:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670fbf7e.050a0220.d9b66.016b.GAE@google.com>
Subject: [syzbot] [nilfs?] WARNING in nilfs_segctor_abort_construction
From: syzbot <syzbot+d3bebcf5d53a3b1a2019@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9e4c6c1ad9a1 Merge tag 'io_uring-6.12-20241011' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a07b27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=d3bebcf5d53a3b1a2019
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f74026db2f8c/disk-9e4c6c1a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f9344dfaa631/vmlinux-9e4c6c1a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7282ccb66a08/bzImage-9e4c6c1a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d3bebcf5d53a3b1a2019@syzkaller.appspotmail.com

segctord: attempt to access beyond end of device
loop5: rw=0, sector=464, nr_sectors = 8 limit=0
NILFS (loop5): I/O error reading meta-data file (ino=3, block-offset=2)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 9015 at fs/nilfs2/segment.c:1500 nilfs_cancel_segusage fs/nilfs2/segment.c:1500 [inline]
WARNING: CPU: 0 PID: 9015 at fs/nilfs2/segment.c:1500 nilfs_segctor_abort_construction+0xe51/0xec0 fs/nilfs2/segment.c:1866
Modules linked in:
CPU: 0 UID: 0 PID: 9015 Comm: segctord Not tainted 6.12.0-rc2-syzkaller-00260-g9e4c6c1ad9a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:nilfs_cancel_segusage fs/nilfs2/segment.c:1500 [inline]
RIP: 0010:nilfs_segctor_abort_construction+0xe51/0xec0 fs/nilfs2/segment.c:1866
Code: 8b 04 25 28 00 00 00 48 3b 84 24 a0 00 00 00 75 74 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d e9 c0 6c 75 08 e8 00 13 1a fe 90 <0f> 0b 90 e9 ea f9 ff ff e8 f2 12 1a fe 90 0f 0b 90 e9 93 fb ff ff
RSP: 0018:ffffc9000326f680 EFLAGS: 00010293
RAX: ffffffff837ad450 RBX: 00000000fffffffb RCX: ffff888026890000
RDX: 0000000000000000 RSI: 00000000fffffffb RDI: 0000000000000000
RBP: ffffc9000326f770 R08: ffffffff837ace36 R09: 1ffff1100d2d1b40
R10: dffffc0000000000 R11: ffffed100d2d1b41 R12: 000000000000000e
R13: 0000000000000003 R14: ffff88805b1f26e8 R15: ffff888070060e18
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000559d87803680 CR3: 000000002d42e000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 nilfs_segctor_do_construct+0x6335/0x6b90 fs/nilfs2/segment.c:2179
 nilfs_segctor_construct+0x181/0x6b0 fs/nilfs2/segment.c:2479
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2587 [inline]
 nilfs_segctor_thread+0x69e/0xe80 fs/nilfs2/segment.c:2701
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

