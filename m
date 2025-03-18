Return-Path: <linux-kernel+bounces-566852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF1A67D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5C2424861
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F63F2116E1;
	Tue, 18 Mar 2025 19:54:35 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942317A303
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327675; cv=none; b=kGVNDs+nQH5CFeI5t4DQwICi4v4eAjzsSGCy/Guvl8eIgd28E7kyiKAghW4X3q7K8IyBs4hBx04RQAkmT2NFI87LIYWPgrjb3Wjfytk5NMQ16nNA6B6GZ1CrVIJzCN6XLFXEkrJ3CHsVm0Q7mAcomBR0KNW/bi8y6F7m+7MjaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327675; c=relaxed/simple;
	bh=UvqG0s3chd5r2FwnnTYZMdcOq0cu81JNXGo56buL5oE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MjoUXa/egBFsk32joODNxiSpC9Tjc/Y93ZkZd4vQkUWJ40/E3zYaiaEBD0EPpmVsP9NlNanwchig4m9mfKe9Y4HS0Xr+JCNfHQNJxfi6vih9Tvw/VXgOOu+K4vyTXURi5rax+cSPcT42bBB7a8bSfKkfAP6rASQYBmIvwgJYjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d060cfe752so56341965ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742327672; x=1742932472;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KnkuTP7eug4W7I6Rhre+Qbp1jyOhKw2a5x1q7jB9uw=;
        b=pqWzIbpXWyHfHfHmhNHr9IC8gTzfzlIer2S3UTHUdqaVIhm2sXre8v0Ey0ECgHa0mE
         hrhzh8+JvYPU47GbRLuVR94FOvqXD/2HTT4EsPkrd0oGyUpDyj/9Q0NI8YrTbyGXanSY
         AF2+P84pSFgyLf2F0TT4Ny5stQ/JMx6T89u7hXECvmBzbgL5fgEDj8qAP6ALBqXRTULR
         sem3omRbP6N3EQGhXRyZG4PfnNHn6lgiNb7uSOYlGcFmmQ4DwAeTSeUqra6DKbaZdDoj
         fnaU70akzi61/kso0/spQTCWfGVQPQ7aOxlIo5grbs5LlexFvXxed7/ubjkCzhhxIX4Z
         0l8A==
X-Forwarded-Encrypted: i=1; AJvYcCVgMZXbrYK46mn4zbsVebPKWYC7tupGqcibEiKHTqQNlDlasVlI9C6lcjJXrj5u/cTvrakKUZsywRKuuG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQp8FJrhZUzLfwlzXuV0DIcn/TwlEtHCudoA/bx/yWMdps5AvB
	5VWpVgrPIMjyqfifyCP4A4SDGa3xSt9MVEjm2NlussiERCn2TqKzDCp4ngIcHCDMHm50X2G5ydO
	m635ZTYT3FDp0erwCoin7K7DODDp/Jta+O5SvwEEabJLiOMRCJSVNz8c=
X-Google-Smtp-Source: AGHT+IHQJWl+30V3m4/2dI0PQSnP1yYA9I1btbc1XRCHdLXioiL+h9NAIYA1xB75vyiElV0fCcEs8VmKKXMrOp2j4gJLoeEX0Tbk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8d:b0:3d4:3ab3:daf5 with SMTP id
 e9e14a558f8ab-3d586b3d37amr887195ab.6.1742327672466; Tue, 18 Mar 2025
 12:54:32 -0700 (PDT)
Date: Tue, 18 Mar 2025 12:54:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d9cf78.050a0220.3657bb.000f.GAE@google.com>
Subject: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dtDelete
From: syzbot <syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e3a854b577cb Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=111b1fa8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb44f62cb82f8a0a
dashboard link: https://syzkaller.appspot.com/bug?extid=4f9c823a6f63d87491ba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484dc78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151b1fa8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e3a854b5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/80a4e52e75a6/vmlinux-e3a854b5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e261756ed740/bzImage-e3a854b5.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7fd9c181a987/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=135a419b980000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f9c823a6f63d87491ba@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dtree.c:2132:32
index 240 is out of range for type 'struct dtslot[128]'
CPU: 0 UID: 0 PID: 5303 Comm: syz-executor483 Not tainted 6.14.0-rc6-syzkaller-00115-ge3a854b577cb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 dtDelete+0x2d67/0x2db0 fs/jfs/jfs_dtree.c:2132
 jfs_rename+0xf91/0x1bf0 fs/jfs/namei.c:1239
 vfs_rename+0xbdb/0xf00 fs/namei.c:5069
 do_renameat2+0xd94/0x13f0 fs/namei.c:5226
 __do_sys_rename fs/namei.c:5273 [inline]
 __se_sys_rename fs/namei.c:5271 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5271
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc873bc9bb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff24dc46e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0000400000000e00 RCX: 00007fc873bc9bb9
RDX: 00007fc873bc9bb9 RSI: 0000400000000f40 RDI: 0000400000000300
RBP: 00007fc873c42610 R08: 00007fff24dc48b8 R09: 00007fff24dc48b8
R10: 00007fff24dc48b8 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff24dc48a8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
---[ end trace ]---


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

