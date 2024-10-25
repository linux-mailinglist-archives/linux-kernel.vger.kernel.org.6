Return-Path: <linux-kernel+bounces-382530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F269B0F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AE71C21F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833DF20F3E3;
	Fri, 25 Oct 2024 19:50:38 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347F20EA55
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729885838; cv=none; b=c4Bw8C74uKo0FRKFSxw36ySGm6uVLlO8BeunVVeB5+6pO+O8of9ahPEuXmhR2tSiL8ua9R1lPAaw8Yj4ajsAo4sFSFA9GccdYSA7fLryuY+tZE3yc06pvL1LjO2KzzkEg8XejsVQCeMXY8cOoP4KA7cWgUXSTyK5cFGUxyoYayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729885838; c=relaxed/simple;
	bh=yVO+s+o48RUWreKwnqGscc2Yeo7D5WZpBJ2A2MdY2ro=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AS3g2kqZGPkfxO1lmUJyP0XBOKMOm9NAHpeZFed9UXTvYs42LIhVvIZvY3sGzA2JO94fGwhOVDvpM+CGq2qbl1lFwhGAoICCDeGctZkF0LLyRu7RuV5i94jP+aluau7PW1B8Mn2KCOKoiDNZ9p9n8msegqiRx1FFceMPAw0p43s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c70e58bfso23535415ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729885835; x=1730490635;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3U9mgde2TjPn/zWkp8i6653oN/Z9/BIWs0PwCoaQzY=;
        b=tfhYkx99zLvHHAWWNzDlkz6nKvBrM1PcLk9jTyzDVf3/TzNNMlBTI2JNRpnxpC8R6c
         zwCfOgAl7QQCPTot7Qcu//97xuZxkgLcc7nBZUUqlWE37ROck/RWb+doPQpIdilMAl8H
         BBO1D67/qsiyJCeSmB71x+0D6r9fJOGsFwpEpcFGJ3Y8JTXGbLZZe4ort3eGlZPd78H6
         ZjmSE5eixC34+WN1xzuDbaAkHL+9x+zdbyF/RZkQ3uSkIEpmdAJznyYVkR8DuB3hP6FJ
         8eUqVpSj2CPjULkH6uUcBSj5rGDHG1kMRwRUtbLvelpTX5uWJVX2lGvit+wpvQ0HyK8j
         NWXA==
X-Forwarded-Encrypted: i=1; AJvYcCUel2dwjB74TdksbJp9kFJIPy1kmzJlDsXoXWkO71ogXLl4z1Z/FBzLOsnCaE3hw85J+T71fTRxNfwQMlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6IKhWj/HyeMVMivDcS3iCmgIQjtVYBj+W/0B6yxg9fZ0Q/DZF
	1NI9ZuD1TuIS3fwgbRxyqb6TikhFTTzeSM589Fs7r+m7kz1mVLLewlq8iLodzeAitQBsCOsja+a
	n6pfXBVuSa31iiXqns4IdB5FuxVQqHbw4hjLIH87JvDSP+aXCuDTuR8Q=
X-Google-Smtp-Source: AGHT+IHLXY+9E8AIBhQZr/5madJlxV09+XdGcLanZPWpCO43cofeDuh2ncH+AKIdajEW0aAqoAdjeQbAGyl7kyRLt4sipqUAmwb0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3a0:8d60:8b7d with SMTP id
 e9e14a558f8ab-3a4ed2aaddfmr6050175ab.11.1729885834893; Fri, 25 Oct 2024
 12:50:34 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:50:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671bf68a.050a0220.2fdf0c.0219.GAE@google.com>
Subject: [syzbot] [mm?] WARNING in get_taint (2)
From: syzbot <syzbot+aa5a1e52e2ac09339fca@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11dc50a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f68c7e50d4601b1
dashboard link: https://syzkaller.appspot.com/bug?extid=aa5a1e52e2ac09339fca
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c78a5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a95430580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bcc7a230eb09/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/96b5df297c4b/zImage-c2ee9f59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aa5a1e52e2ac09339fca@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3115 at mm/highmem.c:622 kunmap_local_indexed+0x20c/0x224 mm/highmem.c:622
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 1 UID: 0 PID: 3115 Comm: syz-executor704 Not tainted 6.12.0-rc4-syzkaller #0
Hardware name: ARM-Versatile Express
Call trace: 
[<81999930>] (dump_backtrace) from [<81999a2c>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:257)
 r7:00000000 r6:82622f44 r5:00000000 r4:8203d814
[<81999a14>] (show_stack) from [<819b7ec8>] (__dump_stack lib/dump_stack.c:94 [inline])
[<81999a14>] (show_stack) from [<819b7ec8>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:120)
[<819b7e74>] (dump_stack_lvl) from [<819b7f08>] (dump_stack+0x18/0x1c lib/dump_stack.c:129)
 r5:00000000 r4:82870d18
[<819b7ef0>] (dump_stack) from [<8199a558>] (panic+0x120/0x374 kernel/panic.c:354)
[<8199a438>] (panic) from [<802420e0>] (check_panic_on_warn kernel/panic.c:243 [inline])
[<8199a438>] (panic) from [<802420e0>] (get_taint+0x0/0x1c kernel/panic.c:238)
 r3:8260c5c4 r2:00000001 r1:82025be8 r0:8202d650
 r7:8048c78c
[<8024206c>] (check_panic_on_warn) from [<80242244>] (__warn+0x80/0x188 kernel/panic.c:748)
[<802421c4>] (__warn) from [<802424c4>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:775)
 r8:00000009 r7:82055258 r6:ec13dd24 r5:841fec00 r4:00000000
[<80242350>] (warn_slowpath_fmt) from [<8048c78c>] (kunmap_local_indexed+0x20c/0x224 mm/highmem.c:622)
 r10:ffedc0a8 r9:83eb9800 r8:20508000 r7:fffffffe r6:00000003 r5:841fec00
 r4:ffedc000
[<8048c580>] (kunmap_local_indexed) from [<80505bb8>] (__kunmap_local include/linux/highmem-internal.h:94 [inline])
[<8048c580>] (kunmap_local_indexed) from [<80505bb8>] (move_pages_pte mm/userfaultfd.c:1329 [inline])
[<8048c580>] (kunmap_local_indexed) from [<80505bb8>] (move_pages+0x7e8/0x149c mm/userfaultfd.c:1730)
 r7:fffffffe r6:00000000 r5:845ab810 r4:ffeda840
[<805053d0>] (move_pages) from [<80581e18>] (userfaultfd_move fs/userfaultfd.c:1871 [inline])
[<805053d0>] (move_pages) from [<80581e18>] (userfaultfd_ioctl+0x114c/0x2080 fs/userfaultfd.c:1994)
 r10:83eb9800 r9:ec13de98 r8:00000001 r7:20c16000 r6:00000000 r5:20000080
 r4:837d6000
[<80580ccc>] (userfaultfd_ioctl) from [<8052f7d0>] (vfs_ioctl fs/ioctl.c:51 [inline])
[<80580ccc>] (userfaultfd_ioctl) from [<8052f7d0>] (__do_sys_ioctl fs/ioctl.c:907 [inline])
[<80580ccc>] (userfaultfd_ioctl) from [<8052f7d0>] (sys_ioctl+0x134/0xda8 fs/ioctl.c:893)
 r10:841fec00 r9:843e0840 r8:00000003 r7:20000080 r6:843e0840 r5:00000000
 r4:c028aa05
[<8052f69c>] (sys_ioctl) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:67)
Exception stack(0xec13dfa8 to 0xec13dff0)
dfa0:                   ffffffff 00000000 00000003 c028aa05 20000080 0000011a
dfc0: ffffffff 00000000 0008e058 00000036 7ef11e0c 00000000 00000001 00000000
dfe0: 7ef11c70 7ef11c60 0001072c 0002e8a0
 r10:00000036 r9:841fec00 r8:8020029c r7:00000036 r6:0008e058 r5:00000000
 r4:ffffffff
Rebooting in 86400 seconds..


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

