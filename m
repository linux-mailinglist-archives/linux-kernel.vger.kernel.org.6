Return-Path: <linux-kernel+bounces-271123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74B89449D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D71C289E85
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865718453A;
	Thu,  1 Aug 2024 10:56:23 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A64184536
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509782; cv=none; b=a54HvLeqUEbL91cQwGzLqFejyoA8egFwJwGfjbieUf52syBh0AlTvYPeGhNIXpII5KL+h247G6TCT0B3SaYcfb2j2GatbvpyyArGpe2vCNUk0RtaBkEPkWMXUYH9KEfZO7nEgR1ofUpJtRoqXJvKZObUAB3cJqo25Yd78MD5evg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509782; c=relaxed/simple;
	bh=eOE0N8YGEbi7pMSZ8DFCRHIpVRJSep5yfz9Pv8jgpZo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BbZQ7hjcPeOaX6qTM/vpE15AeOQljarkTq3Z1snlNUcY3/KcitXM/JbBjbpERUsxM0hSH3XAuZJBogxs4DRP09XRGLCqCZtw2X8lgQ2iBJ7xBxwVYyealw/8OOBlgFmqdIvbJxUGz/Z50MuSArUDK4BjV5BOvZ5QqqvB0cniHvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f890b6fa6so1140329739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 03:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722509780; x=1723114580;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MS41VGE4LZARYbbs2s5Peg/vt+HCGpu2lbzImRJhm6U=;
        b=XsZdkZhyFzkFIOwe0HrlXnyfU05M8QBZ1KPZzQUQDhoYn+HurX7ly4lVgUkHwz5ulL
         fo6maPIeUNt1pi9vhldSzxi8SFuzqk4El/K3AfR+3WpvArwedev+VsQgtuA9AIlc7RLJ
         7f8g4/4ZqjYAMVvrPKBAYM0YnDp64+eUexwf8OAc+ZAfLlOVH3RgtYXV+tJWmg2AB5KU
         5sCZxNGgl7EkzzTR7LbbCRez92b1zApirV6Jn+izFMYsuHV+gDC9xxIUhqbjnAvEF4iT
         v8+mDSbxoRpeR3z55hogx23d5h3+iv7Pkbgiw/1u7V354P8Mcl7h6pRvkr/Yb48d/TvF
         /ChA==
X-Forwarded-Encrypted: i=1; AJvYcCX049JM/waWJogiD9nsbaqUdPNm/m3tGhg9vO6VkJQGzofH/dcD7hHstF6G85jQh8l7e86x/po4qyUE0BYwkQ3U5FzZXH9f8C4mk2Yj
X-Gm-Message-State: AOJu0YzKaSyWegj4UNIa5Qwh7mWMAfuNuZs/xx5AzjM20P8UgH9AeKfH
	Xn/W9G8E/zRhAvL1i61jOeHMVZ8vpiCe0kI6Zz5g+4gOeWm6S9OFtXaS3ncfMKJWUrDQEbUOi/q
	vTxW6YaGc7rSZ3UiS0YEEjIyVvPfTB8b9JQ5exAYxfuTvWCXn1coT6SE=
X-Google-Smtp-Source: AGHT+IGtdLSZk41w7X6MBaxejTdAP23t97hOC0ZaMhucyxiUz0tSL2uNe6DF//jUXWxnqYGHn/sH7puoICyNe2orUK6hnmlwSiab
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2115:b0:4c0:a8a5:81cc with SMTP id
 8926c6da1cb9f-4c8c9c6bb20mr133296173.3.1722509780317; Thu, 01 Aug 2024
 03:56:20 -0700 (PDT)
Date: Thu, 01 Aug 2024 03:56:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094071d061e9d0f66@google.com>
Subject: [syzbot] [dri?] WARNING in drm_wait_one_vblank (2)
From: syzbot <syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com>
To: airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6342649c33d2 Merge tag 'block-6.11-20240726' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1443cb03980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6057dd16bc1c/disk-6342649c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4121b87a6477/vmlinux-6342649c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/57d676edb7cb/bzImage-6342649c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com

------------[ cut here ]------------
platform vkms: [drm] vblank wait timed out on crtc 0
WARNING: CPU: 1 PID: 7412 at drivers/gpu/drm/drm_vblank.c:1307 drm_wait_one_vblank+0x976/0x9f0 drivers/gpu/drm/drm_vblank.c:1307
Modules linked in:
CPU: 1 UID: 0 PID: 7412 Comm: syz.1.410 Not tainted 6.10.0-syzkaller-12881-g6342649c33d2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:drm_wait_one_vblank+0x976/0x9f0 drivers/gpu/drm/drm_vblank.c:1307
Code: 80 3c 08 00 74 08 4c 89 ff e8 76 0a 9c fc 49 8b 1f 48 c7 c7 e0 f4 72 8c 4c 89 f6 48 89 da 8b 5c 24 0c 89 d9 e8 0b e1 f6 fb 90 <0f> 0b 90 90 49 be 00 00 00 00 00 fc ff df e9 68 fb ff ff 44 89 e9
RSP: 0018:ffffc90003f87ac0 EFLAGS: 00010246
RAX: 1af066dba6c5c900 RBX: 0000000000000000 RCX: 0000000000040000
RDX: ffffc900041f9000 RSI: 0000000000031631 RDI: 0000000000031632
RBP: ffffc90003f87c00 R08: ffffffff815592f2 R09: fffffbfff1cf9f80
R10: dffffc0000000000 R11: fffffbfff1cf9f80 R12: 1ffff920007f0f64
R13: 0000000000002635 R14: ffffffff8c861520 R15: ffff888020618010
FS:  00007ff6598ef6c0(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff6598ced58 CR3: 000000004b096000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drm_fb_helper_ioctl+0x114/0x140 drivers/gpu/drm/drm_fb_helper.c:1088
 do_fb_ioctl+0x40a/0x7b0 drivers/video/fbdev/core/fb_chrdev.c:155
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff658b77299
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff6598ef048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff658d05f80 RCX: 00007ff658b77299
RDX: 0000000000000000 RSI: 0000000040044620 RDI: 0000000000000003
RBP: 00007ff658be48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff658d05f80 R15: 00007ff658e2fa38
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

