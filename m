Return-Path: <linux-kernel+bounces-172607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB58BF42F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C06282826
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EDB8F6C;
	Wed,  8 May 2024 01:41:34 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B30F1A2C29
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 01:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715132493; cv=none; b=boxCAfQvxSmA8NHUUeDRvOJBPSQJa3Fd/bkAwFsiUC+phSYH3hIgkHhyHLMoAo9luwjJnxkAWN/iSGLlBgGV1xCLDlPvKilj3Wt7L4b3DXFj734kDXIVL8C0Lyd1xU02+UXje1jKZ+H12XKnzSghjixY8nhy6vsMst6q1jUo0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715132493; c=relaxed/simple;
	bh=U++Wt1vJMVU24lMaRM/asFxVOCqBflE/pPriRsK4LOE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oDItViIA0XuGEv088e2VnD7YWClcXd1t/Oq2EegZIPZokKk8rdaAbuM0XOOIiroyUZJjLRp9GWjB2IXLXsi7fxRH3Ih+DegDCsDBnC06ffLum3T8RV8ABMUt5tyM5pEuy3OeekKhsrO3gkDPlWgBpE/9ysZ8+VdQop/2ybnLof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e195fac186so11154639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 18:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715132491; x=1715737291;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiedDuSC7553Sx1Ao9avbkr7uy7OLcZ+DBs6tFTz7e0=;
        b=GpnJE5Gw9dP0LKuEaw6b0NO5V9XGOEjfPOIL4PDEfP3Tlawq4gxXGj9NpL/bl4l7Qw
         JTM931P164OZkdutFlIHcqu9KDsZIXWeHNlyW3STEl7zSICh1lncjTf26is/Brr7B8V5
         CLhzNItEDb9BoN5WzxV6kpABbFP3sDvdh63CohWYLGkkYS1H8+O+MEY3PZfCKZKmQR8e
         alBPUCmgZ+Nm9QOvOtUxEUwfw/+asVz0CO7yIwCDLkTxb7F0rnEAyUSCTuCiBovXyEft
         e0O9uO+GD7NL7GkQubfDbZA8+6MPgV45PY/Gwmq0Ts1r3qi6Hd/K6/EiWzVOhJ1sPxRa
         U38g==
X-Forwarded-Encrypted: i=1; AJvYcCWGttWkWoSpqkx7Gbt2oPqdGKDyRF+4AQ8texRo5qq7DHHSTykgNgo0Eu3LTmC+IvzoFPtseyXShQy6vtvGqRQFlaynT456S5ddRJTC
X-Gm-Message-State: AOJu0YzgGkpg6w6xcMAv7yTRgrtbGKg3Y3DvtkxQXI5MFzcV8XnKg/GA
	gqD9QQ2FbppBTxA4x0Hv09b8tEyx85Ut8DWnOZq7yyehWduMjCVlIeC59lzqzli141XcUKKRb9W
	6wo8kobZ1AEp81Z1SObYZk4uLsWUGuXxm09p2HMnLsgLagdtuIJQHt2A=
X-Google-Smtp-Source: AGHT+IGNEia7F/Es2blJowud1vQuzy7L7xI3FVzaB2IIGaPWCswb8lmUg0ktjC8lKytL8TvA6rLQfnhFfhtXbyYNmQ3pmbTkjitz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:36c:4e54:aedc with SMTP id
 e9e14a558f8ab-36caed5342cmr506445ab.3.1715132491424; Tue, 07 May 2024
 18:41:31 -0700 (PDT)
Date: Tue, 07 May 2024 18:41:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4fa7f0617e76674@google.com>
Subject: [syzbot] [serial?] KMSAN: kernel-infoleak in con_font_op
From: syzbot <syzbot+8d57540d08e2510c9741@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d25a941ea50 Merge tag 'block-6.9-20240503' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1503a62f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bbf567496022057b
dashboard link: https://syzkaller.appspot.com/bug?extid=8d57540d08e2510c9741
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/31394def760d/disk-3d25a941.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b07167755ad1/vmlinux-3d25a941.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7cb810157366/bzImage-3d25a941.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d57540d08e2510c9741@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 con_font_get drivers/tty/vt/vt.c:4750 [inline]
 con_font_op+0x14a2/0x1710 drivers/tty/vt/vt.c:4844
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0x2b6e/0x2fe0 drivers/tty/vt/vt_ioctl.c:751
 tty_ioctl+0xd18/0x1990 drivers/tty/tty_io.c:2803
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
 x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0xc0/0x2d0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 con_font_get drivers/tty/vt/vt.c:4719 [inline]
 con_font_op+0x659/0x1710 drivers/tty/vt/vt.c:4844
 vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
 vt_ioctl+0x2b6e/0x2fe0 drivers/tty/vt/vt_ioctl.c:751
 tty_ioctl+0xd18/0x1990 drivers/tty/tty_io.c:2803
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
 x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 65536-81919 of 81920 are uninitialized
Memory access of size 81920 starts at ffff888073400000
Data copied to user address 00000000200001c0

CPU: 0 PID: 32400 Comm: syz-executor.1 Not tainted 6.9.0-rc6-syzkaller-00227-g3d25a941ea50 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


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

