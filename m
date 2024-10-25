Return-Path: <linux-kernel+bounces-381097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EDB9AFA54
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB711281618
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867F1B0F3F;
	Fri, 25 Oct 2024 06:49:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512301B0F03
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838968; cv=none; b=HK2E+dZ40athuAOF6amA06Oua89jpek9aIrxQCl3zb7DGfnRDEFpR5d8GwRc5KxmtFZjex6OxWGc0Nm41EGG+Ga9pR5wIUG/9Q77HsZ3DWmAUhqDI0ikJnpqjby6918CiSwkxFJQCX5e1DnvvGd5GemkgQsYoRGrTJBL2v3abes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838968; c=relaxed/simple;
	bh=3y1MGRa9wXq/gDwF/J9bwMUn0WQisQvmIdne5468hk0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LYzREuEoCE5iO7bFITejBziGJivivgM9QAtGaLeXqiSzrQ1oJ5/ouOPZgy/Kfr3fFoSsWzz0dG0clbad3ECmZwNDAHxMN/Y5xGGOJ0EJXqk/MH36SCcaXJZSLJ1zkTuKpoThBlbjoekLOsnFmtDPJjxiSHhKim2phir9MGRAcxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b457f6aeso12395815ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729838965; x=1730443765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXklT+dGxU6+dZYSffIqi/eZ1ermDWOpD2cmaHIQ8ko=;
        b=aVsposKWor1fKLL4TswFklzEd1ePMgmesQFDiOCPrIhw7GPjCURNQQbCsC4e6mtqd+
         QlQBWQFD3k6hmLdh6Aks57pRLVw7cVO0h7gKGWy6UcDyMuFG2113GDwYb68O+d5rpDGG
         l0j9pNOy/TS8KDkZjpGG3FjlSuwhipjeYINu9Aak5OMLK6jQC1kSmYUs3uuRLRzGnON+
         x4xgxnepLB75tg2NjxzH8diBgkiMIEtxOTSaJcynZBopcQEUk4dfXA31Hfd4/QieD27k
         z9j87VUbMrEe5kxUuFj4w8usIThN6pGJZG0z79hRS8PpW44yhswH94f+MT6GgN4T+ugP
         9BuA==
X-Forwarded-Encrypted: i=1; AJvYcCUE2zhwNWqe3DMGZGLnSS6hy3Ve2u7MwaHYsHBNHQQTrdUjyR/vFWH4gJNFKsBur2diP2BPLNfhm+OMl0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSR/MS0f6It/ppmxhuvPO3NcTg+WmMcqidqnHIf8z+IzWuOnKU
	dBge9c5N9Sk41cxc1nW/py099QssYztpE0azHRFzD13qQHNZuVhyINVtA4MHG3v5LXYxfve/VNq
	CwUrbY7o4Mr3Wk+/XpqhJBJ7Zg+o8ctny1v9fFbqAKxHJK8+5vt8XZZY=
X-Google-Smtp-Source: AGHT+IFDPwVKoM3/z71lmIAFjU571JAkl/ihPXOdzmv59/DC+zWY9Uv3xULq9CPVtxn1q75BU6e0M4RbJSrGZ48aAGspapB2O8UU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190f:b0:3a4:e6e9:2575 with SMTP id
 e9e14a558f8ab-3a4e6e9281emr5770945ab.7.1729838965467; Thu, 24 Oct 2024
 23:49:25 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:49:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671b3f75.050a0220.2eb763.00d7.GAE@google.com>
Subject: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindBits (2)
From: syzbot <syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=134fc640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=9e90a1c5eedb9dc4c6cc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118f0287980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128f8a5f980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a3541902b13/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a00efacc2604/bzImage-c2ee9f59.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0a96c5cc2569/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com

ERROR: (device loop0): remounting filesystem as read-only
ERROR: (device loop0): dbDiscardAG: -EIO
ERROR: (device loop0): dbAllocBits: leaf page corrupt
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:3028:55
shift exponent 32 is too large for 32-bit type 'u32' (aka 'unsigned int')
CPU: 0 UID: 0 PID: 5092 Comm: syz-executor128 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 dbFindBits+0x11a/0x1d0 fs/jfs/jfs_dmap.c:3028
 dbAllocDmapLev+0x1e9/0x4a0 fs/jfs/jfs_dmap.c:1985
 dbAllocCtl+0x113/0x920 fs/jfs/jfs_dmap.c:1825
 dbAllocAG+0x28f/0x10b0 fs/jfs/jfs_dmap.c:1364
 dbDiscardAG+0x352/0xa20 fs/jfs/jfs_dmap.c:1613
 jfs_ioc_trim+0x45a/0x6b0 fs/jfs/jfs_discard.c:105
 jfs_ioctl+0x2cd/0x3e0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f54e7034c99
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd37b5c358 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f54e7034c99
RDX: 00000000200000c0 RSI: 00000000c0185879 RDI: 0000000000000004
RBP: 00007f54e70ad5f0 R08: 000055557b4874c0 R09: 000055557b4874c0
R10: 000055557b4874c0 R11: 0000000000000246 R12: 00007ffd37b5c380
R13: 00007ffd37b5c5a8 R14: 431bde82d7b634db R15: 00007f54e707d03b
 </TASK>
---[ end trace ]---


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

