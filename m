Return-Path: <linux-kernel+bounces-234571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B7B91C825
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF3CB22C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1607D06B;
	Fri, 28 Jun 2024 21:30:29 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0A81EA73
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610229; cv=none; b=VFU6sN8cJlvELY96raMcck6gBkctqB/e3EN8A/AW7mfcNzGotQaH8pqQAKftxhMwRY7BiO3GJwCSK7xrT/QLQ0Cm4KZ6NrXbjvzpZBO1azhJGtFrPKSnf/udShaguV1BdGnZ6MZ8Fv1BszRE2FeDrGxx55eNhonSPeIJ011tI0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610229; c=relaxed/simple;
	bh=orzVMnByEYWXxQ0YJmusC3pJW27oEp1gfsaZgcLftxM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rTqvou41XCBKM+EOQTrrI7xLzkJ+JfDue1u11EP0JbnepOXYnUD4d7aAIAsBTdRCQSj/QFR4r8XmSOxmXbdnm8n+FLxdgapMKxrS5W/+oAx0XNrnvobkVSg+IuG2wKtMezs9Fx8QcePklZUSl7p6QyyhkmJDPmSXT3r6C47piTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7f61f4c998bso117511139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719610226; x=1720215026;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIWtAA8Xev+5bClis/Hf4jpkqXQp3+VOHFxeEf/6JzU=;
        b=tNip1KH5OdAle0yWbW7N1RAgqA1KdsTkvPK+kQx+YC6Tl5+yaCRyVgc/pWFsL10aB4
         jcfSUQRdbFciehXsVLAymVTS0p3JnwjyTv0+nPAJc/Eh5vA7bf0kg7waLi9U9wnBJfVv
         SQr0MEJ30i4Zg25Xfj0ErlzR8XDy1KHvYjUjqR2MKsn5DEHAiXk2qSiKuRg+XIp1rgSn
         YGBDpUtBCeS8K2X10oAhczwBcu9g3r/1r+llX2wXkuHRSvVN/O9tXqyMlrpYP2iRxMMm
         9oPXeoVPc8t7Gwnu/nb0V/VYuM4uZHKCKUk3HQYXC85/1z5dvH0UflcKBc+wGLHnSwTS
         3CeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6rNWiYgLNw4KGaqSWa1WWrEwbcX5XcBtj9AFrCEnCufPKuK8c8ZYwucODfuJV/pm7xsdQUwMVpajgjrIic8lmrWsDF4gVMLfPMqX1
X-Gm-Message-State: AOJu0YxnAQceRh5FlOM8Sr9KlpMxQKG2V+WFPf7LEToXzLZH69n8YJpp
	d9GvXbag973q+qPTmbxbAK3TApLEQ2OAEuDZEGbN1cOhfOiRiWIToereuEZzJSNx59kESIPlvg0
	7qD2VraiNFbjSnNEFPOKB56ClfsXEJU1t2tTuL3FVbJSVwp4OoRqRNgQ=
X-Google-Smtp-Source: AGHT+IFStlaJ8hJVe0K/frourUyfzn+cX0J0cnxBAZeFPS3W4x7chDciA/ipEVYiBQj1qIo5cdy9BEElGvU17a3PF7QXrs61lSoG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8420:b0:4b9:26f5:3632 with SMTP id
 8926c6da1cb9f-4b9ecf452e0mr956895173.6.1719610226654; Fri, 28 Jun 2024
 14:30:26 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:30:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b6533c061bf9f4ff@google.com>
Subject: [syzbot] [kernel?] upstream-arm64 test error: INFO: task hung in prepare_namespace
From: syzbot <syzbot+b2e8737f75941acc4220@syzkaller.appspotmail.com>
To: catalin.marinas@arm.com, gregkh@linuxfoundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    59ed70ca3c29 Merge remote-tracking branch 'tglx/devmsi-arm..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17daa881980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e37fbf116261f0b
dashboard link: https://syzkaller.appspot.com/bug?extid=b2e8737f75941acc4220
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/60815a10a042/disk-59ed70ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed29e6661847/vmlinux-59ed70ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0bc74b03961e/Image-59ed70ca.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2e8737f75941acc4220@syzkaller.appspotmail.com

INFO: task swapper/0:1 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc5-syzkaller-g59ed70ca3c29 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:swapper/0       state:D stack:0     pid:1     tgid:1     ppid:0      flags:0x0000000c
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0x14ac/0x24d8 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xbc/0x238 kernel/sched/core.c:6837
 wait_for_device_probe+0x120/0x1c0 drivers/base/dd.c:772
 prepare_namespace+0x5c/0x11c init/do_mounts.c:479
 kernel_init_freeable+0x360/0x478 init/main.c:1591
 kernel_init+0x24/0x2a0 init/main.c:1467
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffff80008f3879e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:328
2 locks held by kworker/u8:2/42:
 #0: ffff0000c0031148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x624/0x15b8 kernel/workqueue.c:3205
 #1: ffff800095677c20 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work+0x6a0/0x15b8 kernel/workqueue.c:3205
3 locks held by kworker/u8:4/210:
 #0: ffff0000c181d148 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work+0x624/0x15b8 kernel/workqueue.c:3205
 #1: ffff800098157c20 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x6a0/0x15b8 kernel/workqueue.c:3205
 #2: ffff0000c2b941b0 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff0000c2b941b0 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1093 [inline]
 #2: ffff0000c2b941b0 (&dev->mutex){....}-{3:3}, at: __driver_attach_async_helper+0xc8/0x230 drivers/base/dd.c:1143
1 lock held by hwrng/1371:
 #0: ffff800090aef948 (reading_mutex){+.+.}-{3:3}, at: hwrng_fillfn+0x6c/0x2b4 drivers/char/hw_random/core.c:495

=============================================



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

