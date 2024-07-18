Return-Path: <linux-kernel+bounces-256194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4B3934A84
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEEAB28A957
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F37F498;
	Thu, 18 Jul 2024 08:55:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7F37A715
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292925; cv=none; b=jvlW+RNBa7Q7yGaeUqpwYlM/xkunW1kVN6/8XEWoDruWGhZ2r1M+2PlCZeG/KV5w/Qtzk7qWQjP4aoYrSFlnEyPn7DKuK6HkABe19RwUOZ+FCCDMOp6/R38sP/6788VuJbkba/xd4O21kMjQDHrV6ZKDeCAhdBbxifsf/FJshr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292925; c=relaxed/simple;
	bh=G4tg2F/QW0nKngT8+nay3BKNMXLV48bRsFGcwpHn98I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MpVCDCswIwq/GjcMIhbx/rVExBkZ0RGfIu0HloqtPlbXWqhAWfNz5BulOikGVW+NHJU57Jnwid9QdIZB2smelbv6O4mXD1q43Cv//xtk75pxjIvg9S1nFVbwX8rU2AAvycSW2LAIU5Ce/cueI0wkgdzQ/7Q3mMorpZBf0P/EhA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8048edd8993so90701639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721292923; x=1721897723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7McO9m37Lnvov1xbsyKaOD5AcBS50AYUxNojjkUYXI=;
        b=autTU1aXn9PjO1dHSQv/65PtieepOl29WhJjBRoQx9+LMjwxDk8EGhhnDShLxsjtUf
         UmuE2Q1VBtyCnMC8GcT+xTEL/6tXeHrZuR54dsjkF9Ql0pNUooQRozQ6P7HRb/7GfU1M
         qve8M7kKuH8ARi8Z0nrY3MzqU9q7RxZVYjJSaRIHHRuQEds3jxzC3QKrCkUg5Zc5OdNf
         dxkOCWkRdwn+Q/kmE4aorJvFeJirU14BMv4g6I4M8jGSE6ZF/Dhm7mBlN291LZMONLo0
         85nqlV7ss1D1hlfytEAeN1g/8BLyZH/MZYvSNYsoiYsH25sjK10UxuUCy25dl3xlYUFN
         oXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIQDC0ny4DmktV6yDH27F37xpRGfCGbVi4KiR7dFq86dTbTL2oOOSfO1UAJYg/WkUcQyIGHuKZcvkDuwfkqRYn4lDK74j0cp0vL/Ro
X-Gm-Message-State: AOJu0Yxi/Kzk+TKoN1g9BthW0suQPZ0mioDTzrhjoculsG5/UVV5bNBX
	HoxfcJJrAkeZTzlmCEAE4wc6JACFNruPKPTw4c1aLJNfR0gUEGFLynTEeOGZXp03ZM0BZUDH1c2
	YTlz0l1PF5ZR4ep5V6o4GdK5YeSRC+kgxkgES5IQM1XsIIhHLPX/ljpQ=
X-Google-Smtp-Source: AGHT+IEAGzfHtksu/BSVmcmICthN2j/912YUuRqCXWfnNS67UCTXmYCAib65VHO+zAAZXCBxtUWn47APkrsmVyUBIgMYctbJZu4/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25c7:b0:4b9:afd1:d4f8 with SMTP id
 8926c6da1cb9f-4c215870ddemr228550173.2.1721292922817; Thu, 18 Jul 2024
 01:55:22 -0700 (PDT)
Date: Thu, 18 Jul 2024 01:55:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000381fbb061d81bd85@google.com>
Subject: [syzbot] [kernel?] KCSAN: data-race in kobject_put /
 kobject_uevent_env (2)
From: syzbot <syzbot+0ac8e4da6d5cfcc7743e@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d67978318827 Merge tag 'x86_cpu_for_v6.11_rc1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11af145e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca8f4e92a17047ec
dashboard link: https://syzkaller.appspot.com/bug?extid=0ac8e4da6d5cfcc7743e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1f219d0a9994/disk-d6797831.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91aed26b830f/vmlinux-d6797831.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c7e753e56950/bzImage-d6797831.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ac8e4da6d5cfcc7743e@syzkaller.appspotmail.com

llcp: llcp_sock_recvmsg: Recv datagram failed state 3 -6 0
==================================================================
BUG: KCSAN: data-race in kobject_put / kobject_uevent_env

read-write to 0xffff888139ddec54 of 1 bytes by task 22621 on cpu 0:
 kobject_uevent_env+0x4e/0x550 lib/kobject_uevent.c:476
 kobject_uevent+0x1c/0x30 lib/kobject_uevent.c:641
 device_del+0x6fa/0x780 drivers/base/core.c:3886
 nfc_unregister_device+0x114/0x130 net/nfc/core.c:1183
 nci_unregister_device+0x14c/0x160 net/nfc/nci/core.c:1312
 virtual_ncidev_close+0x30/0x50 drivers/nfc/virtual_ncidev.c:172
 __fput+0x192/0x6f0 fs/file_table.c:422
 ____fput+0x15/0x20 fs/file_table.c:450
 task_work_run+0x13a/0x1a0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888139ddec54 of 1 bytes by task 22615 on cpu 1:
 kobject_put+0x25/0x180 lib/kobject.c:733
 put_device+0x1f/0x30 drivers/base/core.c:3787
 nfc_put_device net/nfc/nfc.h:103 [inline]
 nfc_llcp_local_put+0x87/0xb0 net/nfc/llcp_core.c:196
 nfc_llcp_sock_free net/nfc/llcp_sock.c:1021 [inline]
 llcp_sock_destruct+0x14d/0x1a0 net/nfc/llcp_sock.c:966
 __sk_destruct+0x3d/0x440 net/core/sock.c:2175
 sk_destruct net/core/sock.c:2223 [inline]
 __sk_free+0x284/0x2d0 net/core/sock.c:2234
 sk_free+0x39/0x70 net/core/sock.c:2245
 sock_put include/net/sock.h:1879 [inline]
 llcp_sock_release+0x38f/0x3d0 net/nfc/llcp_sock.c:646
 __sock_release net/socket.c:659 [inline]
 sock_close+0x68/0x150 net/socket.c:1421
 __fput+0x192/0x6f0 fs/file_table.c:422
 ____fput+0x15/0x20 fs/file_table.c:450
 task_work_run+0x13a/0x1a0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xbe/0x130 kernel/entry/common.c:218
 do_syscall_64+0xd6/0x1c0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x07 -> 0x0d

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 22615 Comm: syz.0.6322 Tainted: G        W          6.10.0-syzkaller-01155-gd67978318827 #0
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

