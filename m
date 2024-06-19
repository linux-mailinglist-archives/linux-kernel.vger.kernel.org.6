Return-Path: <linux-kernel+bounces-221042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFEF90EB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF11B1F213B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6CC1411D5;
	Wed, 19 Jun 2024 12:27:23 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6813F439
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718800043; cv=none; b=C0v5g3rSMtKae/z0EVWdvDNQWN/fU6cFgXLPDYqsogFMon7O90dJqTyhPTbFdkh8SIdIPU0wpstsDfKs8wXlZ5V329k+4iie50VSR7YMKMST0Jh4Dh3o9/IKXoGeLDZU1p8JiV2oWJRs4mABYqkz1SNlrOlNzp2PmUWVlrB3N2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718800043; c=relaxed/simple;
	bh=fUpUaqrPwpb83yw33JksO5mV9132sSE/SfyVteYoznU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tK9s6CqAj+vKiQn9jnTCxSspowDMlR7nuHS0tWFjvofYvRskOSCn7cEJ3IaNcPiyr2SxjzS4Riopk/i64gAbntkEqr5ta2sYGEOeIzQQuRpxY1NpOwOdRFY7xtpA3b89lmzz08/idZ+2LcPtWByyn0JecQMrm4S+b9CWyA/ZgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-375e46790a4so59235335ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718800040; x=1719404840;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJyo26rSnMfat9hiyMJIQJniNDSZ+IVc7ZbSIt7VdFI=;
        b=iwToL6h6pHAwSS7mPkDP1MfhwVjRbAqtfF3P3fupsrotmtrj9ZuJjE6aR8E0x5bKmI
         7PMiMEeEpAVZ1bY47KwVymMTtc82SKo9WFAXPGne1VIK+t3KjSXUkZe/YRe/KaPpENdD
         bRoFEZN9y9bL6fC3Mnkky/dmddInRr/vwSGPeUozp4sjWDXAy/rvUY3L3z97mOEa7u5i
         5VHwW00ZEX8Ks0FsX/uerLbMBJQQrXIzUiQd7ugTyPSs8i5W+1z5tXTNG8Tr6MyK0sfj
         BpDae5ZBLK8YWP3IEarjq6VQrx2JNLs6NNt3fARNGf7twz6DksFMHrkunOqX61PqRIli
         kgmA==
X-Forwarded-Encrypted: i=1; AJvYcCXIkBpCjpBDSf2xOAKorfbGvBPcnh8luy9dp0baFBKs3caLDGswTAmggcFTYxnwtJ/LMgo4uCl/eb5+jmUZXsiXZxATMe9ppdVwUrgY
X-Gm-Message-State: AOJu0YyixP5oDabo8NdFvMa5tYDq3BbhtEcggiq3TfrinsCYUORM3wCB
	8lSgj6gk4RVpGVV1yiG59oeSgCDCr1eEIhpwg2Giu+HOLmRn5j0b0EvVYT2GvHmxGz7mXd8ybWP
	xeUpP1CNlVXL3ri7igI5ABoFIcubk2aYeXSyBlbILpPL/kI319+8dhkI=
X-Google-Smtp-Source: AGHT+IGHfyj1u3PcnPwfuYEoj17fZlR+5CaNKeBXF+w/noEokNM0TR+1adov37/prYDBtFAdSvTZ1vfsT69sNhYEuk3P2oiKxzzO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8f:b0:375:e04f:55af with SMTP id
 e9e14a558f8ab-3761d63e806mr1261095ab.1.1718800040598; Wed, 19 Jun 2024
 05:27:20 -0700 (PDT)
Date: Wed, 19 Jun 2024 05:27:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc2e3d061b3d519c@google.com>
Subject: [syzbot] [block?] KCSAN: data-race in block_uevent / inc_diskseq (2)
From: syzbot <syzbot+c147f9175ec6cc7bd73b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d54351c64e8 Merge tag 'lsm-pr-20240617' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12426cfa980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cd45aedbb3f7637b
dashboard link: https://syzkaller.appspot.com/bug?extid=c147f9175ec6cc7bd73b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba0a777cccff/disk-3d54351c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a78193318c92/vmlinux-3d54351c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/54456f3d3bfe/bzImage-3d54351c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c147f9175ec6cc7bd73b@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in block_uevent / inc_diskseq

write to 0xffff888101f05220 of 8 bytes by task 3101 on cpu 0:
 inc_diskseq+0x2c/0x40 block/genhd.c:1472
 disk_force_media_change+0x9f/0xf0 block/disk-events.c:297
 __loop_clr_fd+0x270/0x3f0 drivers/block/loop.c:1193
 loop_clr_fd drivers/block/loop.c:1276 [inline]
 lo_ioctl+0xea6/0x1330 drivers/block/loop.c:1578
 blkdev_ioctl+0x35f/0x450 block/ioctl.c:676
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xd3/0x150 fs/ioctl.c:893
 __x64_sys_ioctl+0x43/0x50 fs/ioctl.c:893
 x64_sys_call+0x1581/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888101f05220 of 8 bytes by task 3091 on cpu 1:
 block_uevent+0x31/0x50 block/genhd.c:1206
 dev_uevent+0x2f3/0x380 drivers/base/core.c:2687
 uevent_show+0x11e/0x210 drivers/base/core.c:2745
 dev_attr_show+0x3a/0xa0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x17c/0x250 fs/sysfs/file.c:59
 kernfs_seq_show+0x7c/0x90 fs/kernfs/file.c:205
 seq_read_iter+0x2d7/0x940 fs/seq_file.c:230
 kernfs_fop_read_iter+0xc6/0x310 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x5e6/0x6e0 fs/read_write.c:476
 ksys_read+0xeb/0x1b0 fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __x64_sys_read+0x42/0x50 fs/read_write.c:627
 x64_sys_call+0x27e5/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000000000045 -> 0x0000000000000048

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 3091 Comm: udevd Not tainted 6.10.0-rc4-syzkaller-00035-g3d54351c64e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
==================================================================


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

