Return-Path: <linux-kernel+bounces-311817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B386D968E06
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695411F228D2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1C519CC3C;
	Mon,  2 Sep 2024 18:57:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36381A3ABA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303448; cv=none; b=LLnfqHzkiDYC/Y96hVYbnVLVITVXTI7J996uG9EaljolTlnwbwv4C50WTnj9oyM1OK2XM30R96uow0FflV1ODKnoGBH/jySQWF9QJfJOHyryi1U6+g4f3mBhAiEY6Kym+flCl15F1Os0E49mXugvcmMvt8PUjqDUVQGtN1pBNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303448; c=relaxed/simple;
	bh=9hCYL8/cuhkN/ybfSMLAc7IMZoaJxXgeEJTJH8gOLxo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e3aWUaSxMZ1RthqmQ90NQaJqjhYnKEGJuCRLPM8rHT33gA/8OZWBQYGL84vqhBLBxyeQUSGt1sp8sQH0qM9yAQCQjXwb7PDQzjhP+O1R4kqM5MIcLY9HmFygMvUHBAAJ6avgd+zbDBr4RuIqPEEny7nLlbPvLddBYraU2X0WCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a246b5043so440987139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725303445; x=1725908245;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Axq36qhopmenh1xRYlMyTkgurZ0z3aEBecEo01UjEmQ=;
        b=WffHQVgs8+W+cecvgWr0Fd3rG4K5PG8KxDqYWf/t+waScE+1A7kw3WL5n8ieANBqKJ
         DgPy6R2Bj9zoTBL17WOdj6CPGe5SGxovz2SE1Hu98xIdhU5ocKra5EU+EulBMHzqWi4K
         9MZ/L2DBcJIjlJZw1oQ3QwknnXsRrCMQJSEjcKfxO0SFLN4aStx/eQiwNWTshRcoUoQm
         lFMPlO1QzWEZTyyontPcaTtTnp5IfS+l3npyLt2ddwRkBiYWonMKV7Co5pwm7Nok45zv
         I1byatVRhQH9vDu0BXe6wV4oEGHgaUVmJpGYICA6oBW3I2YKIkpbbak++LGbDpR6Gw0g
         NDbg==
X-Gm-Message-State: AOJu0YzaqziBOu4VrvHXCGYg/OAe5sKOwYZDhCig+hP0BOW6/o7OnT64
	h72iScXJRIzgzGytjiCowprcgap6fUi2pqlfuw74QxhGv79i3vsoSRyJtB6MoaZNkjlWrWz3vPm
	BeayjzlUg8zIwyJkUTxhklXK4pEYa1niuzj/1fBzwUB97p85dHx7QKPA=
X-Google-Smtp-Source: AGHT+IHVn8TMoaIaawjpBdY9ogK+wxid8R6DlD1QeBAATUhrBebfvKanI1xMydo5+1J3cY4DbNUOrW3ZcslcuBUhGZdZGP/TQ6Gd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6413:b0:803:85e8:c40b with SMTP id
 ca18e2360f4ac-82a262f597dmr65460939f.3.1725303445591; Mon, 02 Sep 2024
 11:57:25 -0700 (PDT)
Date: Mon, 02 Sep 2024 11:57:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000013050062127830a@google.com>
Subject: [syzbot] [media?] WARNING in __v4l2_ctrl_modify_dimensions
From: syzbot <syzbot+a828133770f62293563e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1934261d8974 Merge tag 'input-for-v6.11-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d51929980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=a828133770f62293563e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1250552b980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1641150b980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-1934261d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dae6d4b5572b/vmlinux-1934261d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aabe290f51ea/bzImage-1934261d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a828133770f62293563e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5111 at mm/util.c:665 __kvmalloc_node_noprof+0x17a/0x190 mm/util.c:665
Modules linked in:
CPU: 0 UID: 0 PID: 5111 Comm: syz-executor170 Not tainted 6.11.0-rc5-syzkaller-00219-g1934261d8974 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__kvmalloc_node_noprof+0x17a/0x190 mm/util.c:665
Code: cc 44 89 fe 81 e6 00 20 00 00 31 ff e8 bf 23 bb ff 41 81 e7 00 20 00 00 74 0a e8 71 1f bb ff e9 3b ff ff ff e8 67 1f bb ff 90 <0f> 0b 90 e9 2d ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
RSP: 0018:ffffc9000323f930 EFLAGS: 00010293
RAX: ffffffff81d86cc9 RBX: 00000000da6b5000 RCX: ffff88801ca92440
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff81d86cb1 R09: 00000000ffffffff
R10: ffffc9000323f7a0 R11: fffff52000647ef9 R12: 00000000da6b5000
R13: ffffc9000323fa60 R14: 00000000ffffffff R15: 0000000000000000
FS:  000055555ed0c380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f12c2b010f0 CR3: 000000003d746000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __v4l2_ctrl_modify_dimensions+0x43b/0xb60 drivers/media/v4l2-core/v4l2-ctrls-api.c:999
 v4l2_ctrl_modify_dimensions include/media/v4l2-ctrls.h:1013 [inline]
 vivid_update_format_cap+0x133c/0x2090 drivers/media/test-drivers/vivid/vivid-vid-cap.c:458
 vivid_vid_cap_s_dv_timings+0x535/0x1230 drivers/media/test-drivers/vivid/vivid-vid-cap.c:1500
 __video_do_ioctl+0xc26/0xde0 drivers/media/v4l2-core/v4l2-ioctl.c:3118
 video_usercopy+0x89b/0x1180 drivers/media/v4l2-core/v4l2-ioctl.c:3459
 v4l2_ioctl+0x18c/0x1e0 drivers/media/v4l2-core/v4l2-dev.c:364
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f12c2a8a939
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcb8e91828 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f12c2a8a939
RDX: 0000000020000200 RSI: 00000000c0845657 RDI: 0000000000000003
RBP: 00007f12c2afd5f0 R08: 0000000000000006 R09: 0000000000000006
R10: 00236962762f7665 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
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

