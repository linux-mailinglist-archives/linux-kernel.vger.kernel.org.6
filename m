Return-Path: <linux-kernel+bounces-281168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F1694D3DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BC4B21390
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBDB1946B9;
	Fri,  9 Aug 2024 15:45:21 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68843198E6E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723218320; cv=none; b=VJJ2V/bgciI0CF6FRSwIxUuzN/VbaMJpvFAmBSBXzS4eCmbr+TzQYt7iTZAbt5KV/RL1i2oI/n8izfAhGOmnpz94Nfcy6D2HkD1TL3f7xy0Vh6vRoq2kTwXK4THKOIUJMUHbHCMu+04g44K9JW+IPPM/JRCJ9y5ZTb269STIBXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723218320; c=relaxed/simple;
	bh=5fGXuXdavB5QrFI6ZW2XId6XrsCE8kEszsjvz4ngG2s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f13ggLFvs6FliUPNYDtEUB3jJ2e3FJKRvqL+vnJLzdGmswmXNFQeYACK1rJx9qu0MBYb4HUyKNoSp98otYrRwejxMh5S9jJxo8JWUbct7Eo+hlkXJuqiYZeU2+ofnwGqwkn2IV7cwgtEHER5exFPm1iOjU6FsLGayukp6byCcnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f93601444so275597239f.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 08:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723218318; x=1723823118;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gYMz9DavZgsxe/N7/Nv+CrURGsOaUrjPtpaY60Rs55I=;
        b=EfMeFvP3z5JIDFalTm9+3V+FByYMdrkmgDbzZonxw0GoRJIKk/nC99F6AZLvd1TcCF
         nPzBOPEW2TPFFTEQ4nmIg8mRa0nsWLKR5e9lH0wJ8m6Rh0Yo8C9y16uFnzG+l7zssB9Q
         hlnK4gHW5UxH7ps1YVAo6N3Vwbxd7y3FdHAmM4O8MC2gzmJVwAoLuypTP157gm8U7UkM
         n08km4nPbMp4HQUvnQh8VrS2YYEzQ/Az9StlaRPXRbU8/XqG3omT+W3h10i+ECXCEv7e
         co1cKTfqH1oDMYaUVeq+x3onkNnp/jLJ1eOEsANw5KOo3tJDODqGl4fSD7O2QfmxCelO
         xJ8g==
X-Forwarded-Encrypted: i=1; AJvYcCVGBuHhz4X4tBjz37qmoVZZ81RltCmS1YGvjuIXSaCNaSIMsC9lkE915rfhJFpHQL+gB8olE0BvCMuhDrEDEIRCkrtfqMDSwkEQ70cO
X-Gm-Message-State: AOJu0YyJLJ9NZ0UoMy7XOQtW9zHRfUU7kh5t1WiLsCMB8lV4E/hI8SIe
	CIGZGRkJa8ivVkj1/oNYQa/8AZeE3lOnoyNmC4eZkaYs1P6ex6v+L/yuhZgcM8Ihph/gM1De0Gh
	NZtaYtZgbcrrgWdcVG6eGfVPCj8cPfsEVBi/6G3BFeqFRAMKW6dgAeQA=
X-Google-Smtp-Source: AGHT+IFwhpqZCjS2l9vlcjlDvow0WdXD/3oRZfuPiyMtgyfKfprUnxaBRZ7BjqZgSF2yYMSbw7i4s8zHFSsIHCNAteczZ6D/DVxm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411b:b0:4c0:9a3e:c263 with SMTP id
 8926c6da1cb9f-4ca6eba4580mr51129173.0.1723218318381; Fri, 09 Aug 2024
 08:45:18 -0700 (PDT)
Date: Fri, 09 Aug 2024 08:45:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bce370061f4207cf@google.com>
Subject: [syzbot] [kernel?] WARNING in firmware_fallback_sysfs (2)
From: syzbot <syzbot+8f06445357a052a92657@syzkaller.appspotmail.com>
To: dakr@redhat.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, rafael@kernel.org, russ.weight@linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    de9c2c66ad8e Linux 6.11-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14019861980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=8f06445357a052a92657
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2a5965e13719/disk-de9c2c66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/52c0d9ae2edc/vmlinux-de9c2c66.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c8963098f5f/bzImage-de9c2c66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f06445357a052a92657@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for v4l-pvrusb2-29xxx-01.fw failed with error -2
usb 1-1: Falling back to sysfs fallback for: v4l-pvrusb2-29xxx-01.fw
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2036 at drivers/base/firmware_loader/fallback.c:148 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:148 [inline]
WARNING: CPU: 0 PID: 2036 at drivers/base/firmware_loader/fallback.c:148 firmware_fallback_sysfs+0x782/0x9e0 drivers/base/firmware_loader/fallback.c:238
Modules linked in:
CPU: 0 UID: 0 PID: 2036 Comm: pvrusb2-context Not tainted 6.11.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:148 [inline]
RIP: 0010:firmware_fallback_sysfs+0x782/0x9e0 drivers/base/firmware_loader/fallback.c:238
Code: 1c 24 e9 4d fc ff ff e8 ec cb 9f fb c6 05 45 f0 0d 0a 01 48 c7 c7 80 83 86 8c e8 f9 1e bf 05 e9 72 fc ff ff e8 cf cb 9f fb 90 <0f> 0b 90 48 89 df 48 c7 c6 60 84 86 8c 4c 89 ea e8 29 85 c1 05 e9
RSP: 0018:ffffc90004daf730 EFLAGS: 00010293
RAX: ffffffff85f3ab21 RBX: ffff88805bb470a8 RCX: ffff8880258a8000
RDX: 0000000000000000 RSI: 00000000fffffff5 RDI: 0000000000000000
RBP: 000000000000003c R08: ffffffff85f3a530 R09: 1ffffffff26e5922
R10: dffffc0000000000 R11: fffffbfff26e5923 R12: 00000000fffffff5
R13: ffffffff8cddfb00 R14: 0000000000000001 R15: 0000000000001770
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020bc5000 CR3: 000000000e734000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 _request_firmware+0xcf5/0x12b0 drivers/base/firmware_loader/main.c:914
 request_firmware+0x36/0x50 drivers/base/firmware_loader/main.c:963
 pvr2_locate_firmware+0xb1/0x500 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:1359
 pvr2_upload_firmware1+0x1c6/0x950 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:1426
 pvr2_hdw_setup_low drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2107 [inline]
 pvr2_hdw_setup drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2261 [inline]
 pvr2_hdw_initialize+0x411/0x3d10 drivers/media/usb/pvrusb2/pvrusb2-hdw.c:2338
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:111 [inline]
 pvr2_context_thread_func+0x4b3/0xb50 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
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

