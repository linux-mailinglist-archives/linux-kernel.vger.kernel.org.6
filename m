Return-Path: <linux-kernel+bounces-173104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A2A8BFB92
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2444B2351D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E204781AA2;
	Wed,  8 May 2024 11:07:27 +0000 (UTC)
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6026AFF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166447; cv=none; b=do2cBp2nN/Zl4cZbRYFmtWHpZWgctPQyN3SsVNR29RpVScp7n5a8zDgLgMsDaMnp55VztrCACcaluYteVm3JpsHq9VsdJhBAAs008R+ORvZBQEhIO7uLZcBeVLGgdgtSVYh9p3EIwz6XW0mPMlEFEI5bNnRuQWj8jCLnFGkXcuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166447; c=relaxed/simple;
	bh=ir3D0QdZr9HwbVUUxDbuMqQlj8Nkcs8ADI8rrzl+he0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=muwQwvAvXXizK4zOnprwTHbZDxcpP7sBirOIdbKfCgx8hx0AOM11bukqsj3lLzxkQXw+0UNoOKNj3QrZo8rn5DNM79IJmLkkHJsMPPYuo6buDpg0C3FDJIobqwV9AecAH4ElpX53TDy3SilVfnl/jHb8OZjXFuFycYH86zXRKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-36c8c30f0e6so29884385ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715166445; x=1715771245;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ik31MZzfCGX6EDiTgXX6TmzFIMH6cq0cGYyndm4GXQA=;
        b=QumPRGAA23eQi0YD7hddUsvSZ8ICiZjEky05sdRkspx04umqgaH1rDEUc+h+qKlGEw
         oz+EHuaZcvrNG0ahaBoMgkrShWNkzVe84jpf/2TUtSqCAF7uS+45xnQKenNGq9rhpfQm
         /1KDDVHbkkCOP595a1eS4+wgWjcJdLE4RSqvEeZv41aGc/z88EC/mWN8vyKZ4vUc+4zV
         j4z3GNQAa+fMLSy1juLDxoB4mCjxUnEkAQfxhtb4LLDTIH2yfrTV+ZGF2StigHkBM2YX
         lYpBbsuhofiMQbiGI+tIetlaYChsPJiYmfs1wElcuQXgk1mSz8cjNJ8FtImz8OIvE8+1
         H9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBLg3xtcnN6O++NvDvXnAWZiAsSGni3JbcVtssVFJb3zX/DRmTaTvGZA6Pl4vRQTbX4r96C05AsyGfpMjV+jiPfZvrI8VWvQKNXsj5
X-Gm-Message-State: AOJu0YwfCKmn7pKh880BvzSUU5OmRGIVpGBEFuY00myPhZOH7oIgrpiG
	3Ab00cRuNEdqvtI9FqnAy64+rnOpdFjbbO/1E3raabO2CATKAOKkwRg9lw7/hujvGp3Zg1ZY7o8
	rovmG7DJ7lePI0p9s+rYV6f41UEtmo5gmb57sqGIo0gmnkwLh7oMMmxM=
X-Google-Smtp-Source: AGHT+IFfV61csI8Z2CUVlLl9OoAWp20SJfWg0IS7du1wCEMLJiZuN1ZboyH2c7xsFLiD3/6r7snDoOzBBcMT383oLRmW5G/BD4hY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:36c:5520:9597 with SMTP id
 e9e14a558f8ab-36caed58de7mr861145ab.6.1715166445182; Wed, 08 May 2024
 04:07:25 -0700 (PDT)
Date: Wed, 08 May 2024 04:07:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b236c90617ef4e00@google.com>
Subject: [syzbot] [kernfs?] WARNING in kernfs_get (5)
From: syzbot <syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d25a941ea50 Merge tag 'block-6.9-20240503' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15afe9ff180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3714fc09f933e505
dashboard link: https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e03ace4a616f/disk-3d25a941.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/14bf616395b8/vmlinux-3d25a941.xz
kernel image: https://storage.googleapis.com/syzbot-assets/197f0e10a223/bzImage-3d25a941.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for ueagle-atm/eagleI.fw failed with error -2
usb 1-1: Falling back to sysfs fallback for: ueagle-atm/eagleI.fw
------------[ cut here ]------------
WARNING: CPU: 0 PID: 927 at fs/kernfs/dir.c:526 kernfs_get+0x71/0x90 fs/kernfs/dir.c:526
Modules linked in:
CPU: 0 PID: 927 Comm: kworker/0:2 Not tainted 6.9.0-rc6-syzkaller-00227-g3d25a941ea50 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events request_firmware_work_func
RIP: 0010:kernfs_get+0x71/0x90 fs/kernfs/dir.c:526
Code: 23 e8 b3 76 5f ff 48 89 df be 04 00 00 00 e8 e6 23 c4 ff f0 ff 03 eb 05 e8 9c 76 5f ff 5b 5d c3 cc cc cc cc e8 90 76 5f ff 90 <0f> 0b 90 eb d7 89 d9 80 e1 07 80 c1 03 38 c1 7c b7 48 89 df e8 e6
RSP: 0018:ffffc900046776e8 EFLAGS: 00010293
RAX: ffffffff82369a30 RBX: ffff888023bcf690 RCX: ffff888020f8bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82369a04 R09: 1ffff11004779ed2
R10: dffffc0000000000 R11: ffffed1004779ed3 R12: ffffffff8c441320
R13: dffffc0000000000 R14: ffff888023bcf690 R15: ffffffff8c441338
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1db245f256 CR3: 0000000060d26000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 internal_create_group+0x5a8/0x11d0 fs/sysfs/group.c:179
 dpm_sysfs_add+0x69/0x280 drivers/base/power/sysfs.c:702
 device_add+0x5c3/0xca0 drivers/base/core.c:3680
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xcf5/0x12b0 drivers/base/firmware_loader/main.c:914
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1165
 process_one_work kernel/workqueue.c:3267 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3348
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3429
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

