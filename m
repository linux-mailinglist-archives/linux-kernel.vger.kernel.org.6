Return-Path: <linux-kernel+bounces-178879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7F8C58FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E79B2180C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65CE17EBB5;
	Tue, 14 May 2024 15:44:45 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8611E480
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701485; cv=none; b=UCrclGX7GiJNtd8Kz1NJttziJEkP3pXJxbvw7I+D55fNMX4SoYZgoimQiNjKXvSuoPPx5JYdDjKjFSbqiNwixUefYgl800kJLjXFDooLUJiQqbUQEg3yrZ9hsZ2XWgxTYUu1KWcnvPRlbHC49LDeaSUBCz+qnqNupHkULY9PSfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701485; c=relaxed/simple;
	bh=Tzigt9y2Ubkzua+SFQ3VstVK5Sf+6jtdYihzu6CCgv0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iP0ZsIsSrZb2RnsteqogU6IO7GJa2FQw+PR33j8wc7xOUC8wvj0kXkUot9IhVAwY19MXFalVx3gnUNYEdYgIvDhu3rhP/UNaCsr6EAcWjdMftoulxjMsywp6vXhsrMRTv3SSynshot0+jgK6W2o0QbfU76LafMDtgEdtVjxmNL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1bbace584so519243539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715701483; x=1716306283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84bc90QHt4ImGokmn/lScqXwBR18E3W9oI7qQt/YIG4=;
        b=sPaRAbL4b01uBT+sob4ffDUTKeauhxOlXiEEp70RVRXDNwvM/DMLfqzBXfDdUxeUP1
         6MwYQtMjzb6W9E0S9py1xeV6jAZaxbwzr8EYCq396jSzxPiySqqHYTip52DPGGpjoqc6
         k0q1RvwBLLcU06UEVyfERw4xJHnj2GF7zJGLmasm4w83F9aiWZw6rabXVzajI9RPvxx0
         ZNSP68/IduV4lJjpf1l4A1YIaPNIMu4gmMVIefFbxRDSW6sYqgaKYsyKmQ0928ijK8rf
         mYJ88wK7C8GA1iMNONBpLY62Uny0Ck/oSo9Vkh6nuFCmqGPINuDRbby3dmmQ5dJ6mBPA
         UzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqRL73kNhGTtbFFT9xtj7T3nzMxL+prpVAYFH6OzsxD2YgRymJNkEo+K+RPROSOX+PKbIR88NyRF2Q/ukTTKmOnAkegfdMLzE4Cnr/
X-Gm-Message-State: AOJu0YxUIve0DcjZkXG8snpFe0RkPvjqC2bKtgNJk6f+XTlE4mv/zy+a
	7rYRTk4tG5aBg9Cb/WgV2F75UXjPSvNkCKEtJ6PJe2becHb/4a+luM4kax/evkgArmwOXp7aasv
	ExtSsOseVAiKQelgrzwrLog/xTGGNSXtl+E87FkOkpBhv/4kAuw1fO88=
X-Google-Smtp-Source: AGHT+IEKvseE3flGi3RquF8/sbhTBAWZPUuEPOU5uSAeVdr0dnI2sW3qlnIYDzHMEFHBAHHVNeA3rLV3Q97/PJ1x2ppHCdxN9zSp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b02:b0:7de:e172:3eb2 with SMTP id
 ca18e2360f4ac-7e1b51a0707mr72719339f.1.1715701483180; Tue, 14 May 2024
 08:44:43 -0700 (PDT)
Date: Tue, 14 May 2024 08:44:43 -0700
In-Reply-To: <000000000000b236c90617ef4e00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007224f506186be18b@google.com>
Subject: Re: [syzbot] [kernfs?] [usb?] WARNING in kernfs_get (5)
From: syzbot <syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    26dd54d03cd9 Add linux-next specific files for 20240514
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1392596c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8af44e051929224
dashboard link: https://syzkaller.appspot.com/bug?extid=2f44671e54488d20f0e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b06900980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/dca5ce975d7a/disk-26dd54d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24844585ee37/vmlinux-26dd54d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ea82f6342f5/bzImage-26dd54d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f44671e54488d20f0e6@syzkaller.appspotmail.com

usb 2-1: Direct firmware load for ueagle-atm/eagleI.fw failed with error -2
usb 2-1: Falling back to sysfs fallback for: ueagle-atm/eagleI.fw
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5166 at fs/kernfs/dir.c:526 kernfs_get+0x71/0x90 fs/kernfs/dir.c:526
Modules linked in:
CPU: 0 PID: 5166 Comm: kworker/0:4 Not tainted 6.9.0-next-20240514-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Workqueue: events request_firmware_work_func
RIP: 0010:kernfs_get+0x71/0x90 fs/kernfs/dir.c:526
Code: 23 e8 63 b0 5e ff 48 89 df be 04 00 00 00 e8 96 6c c4 ff f0 ff 03 eb 05 e8 4c b0 5e ff 5b 5d c3 cc cc cc cc e8 40 b0 5e ff 90 <0f> 0b 90 eb d7 89 d9 80 e1 07 80 c1 03 38 c1 7c b7 48 89 df e8 96
RSP: 0018:ffffc90003bdf6e0 EFLAGS: 00010293
RAX: ffffffff82379c40 RBX: ffff8880770dff00 RCX: ffff88802729da00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82379c14 R09: 1ffff1100ee1bfe0
R10: dffffc0000000000 R11: ffffed100ee1bfe1 R12: dffffc0000000000
R13: ffff88802a984008 R14: ffffffff8c4497f0 R15: ffff88802a984038
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f55ba7ad988 CR3: 0000000024c16000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sysfs_get include/linux/sysfs.h:786 [inline]
 create_dir lib/kobject.c:89 [inline]
 kobject_add_internal+0x4ba/0x8d0 lib/kobject.c:240
 kobject_add_varg lib/kobject.c:374 [inline]
 kobject_add+0x152/0x220 lib/kobject.c:426
 device_add+0x4e5/0xbf0 drivers/base/core.c:3659
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:86 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:162 [inline]
 firmware_fallback_sysfs+0x307/0x9e0 drivers/base/firmware_loader/fallback.c:238
 _request_firmware+0xcf5/0x12b0 drivers/base/firmware_loader/main.c:914
 request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1165
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3393
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

