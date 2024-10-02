Return-Path: <linux-kernel+bounces-348345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A7798E646
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 00:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D88F1F213DF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B6199938;
	Wed,  2 Oct 2024 22:49:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F498DDD2
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909367; cv=none; b=HyYpjg3KjSeyMUmnKY1m4qdqNU3ngBzllKJ7LR9XR6GMFYJX0ej2zs2Bz8eWw+tugpKbloAuCcMTkdeBoRg03iCktBNBmETA/DEXKVXTW5xtGJ0bkHnX3UAPCgNVzf7eeVpMd2nJbPpnk2N+fnhQNGefC+RPGZ771qEVmn66OaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909367; c=relaxed/simple;
	bh=naD2NVf7RE1w/76nKdpyZ2fQ5KZie9Ey35uFYxVCoUM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iudPnbsB9Rch7anD3XD6ime2wkMJ6CwCaz2UgHi16DQu76pds3LfbGKAuLz3WPEtsvmK/379ZRNd3mXSrbOwDMu8etWgOyYstTqFzOSInD0ET9erdgIdu3K2LT/9cAa5dP7IPx3yYlqbyZtFG98eiOUylw9u3GPvi63Wp4xT4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a345a02c23so3983055ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 15:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727909363; x=1728514163;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RvxOQi9xFVJyAYD4SPSaHddmEAQF1noqJDuXy5vGPT8=;
        b=RxZA3alyjHkh0og3qTyecbxataCILHHaKX2AxAPZp+t8iJWdoXvZwACJyivpWEzqoV
         5gV89ZliTUjCvtL4OsUCuid9oiT2QIDWtcpddU3hzzIM+6HVAVuMttdZF1RySOIFRib1
         ooHZsmkBWNi6nvZcnwq61KwY0ojdw5smj7iV/NwXkdHmKc4gE3TLcQuTtp7MVFGDKib/
         NX8gPbBO9aFt9uOmhxK7H6EmBpkqhfQTdViGU85wSXmrJ6sMsdO1zctDpQG6+Efpfep4
         LyCvL3DzuEEIaYljUs2zimPwPbOODVeTNbn+b7nN5vSe7XXcCKBbqiiP3iB5MMI/POfF
         2TIw==
X-Forwarded-Encrypted: i=1; AJvYcCUISaA+hoVtrHQ7SRKxRDry8XhIzqig4TZkTvMkrBnVh/pdICMVmZujJKarLrtZqKRSyZcn9XwG65kxCBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv+Xis6ZTErDxKGjfFa8omEQK983mw4vqqMyUUkO2V7UMkbpHn
	uvO0m6zaeN9aiGZLNlaPxUdfSKjppptMsqbr20HZ5uN7KFlLGOj5rkIPnvw3rjWUq8V5seTsunu
	Lq124kj40ZaPXJbgKfK3RyqbgRj2lO2VjBCWghQgOXJvStWhLMw81pkc=
X-Google-Smtp-Source: AGHT+IESzE9QVhHj1f9F1AwaKPFizMah9awWpUEaMFUlePyIe/uO95N8nd43A8aYOxA5fbuHh/cwX/PteqtNEEXbfnGBAGWD+Zsd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:3a0:8d60:8ba7 with SMTP id
 e9e14a558f8ab-3a36592c2dfmr44271465ab.14.1727909363643; Wed, 02 Oct 2024
 15:49:23 -0700 (PDT)
Date: Wed, 02 Oct 2024 15:49:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fdcdf3.050a0220.40bef.0025.GAE@google.com>
Subject: [syzbot] [f2fs?] UBSAN: array-index-out-of-bounds in f2fs_truncate_inode_blocks
From: syzbot <syzbot+6653f10281a1badc749e@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=122b3507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62086b2fd100a029
dashboard link: https://syzkaller.appspot.com/bug?extid=6653f10281a1badc749e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ad46e8f9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72b7539cbeb1/vmlinux-ad46e8f9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/73c9b9cebaf4/bzImage-ad46e8f9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6653f10281a1badc749e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 40427
=======================================================
WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
F2FS-fs (loop0): Invalid log_blocksize (268), supports only 12
F2FS-fs (loop0): Can't find valid F2FS filesystem in 1th superblock
F2FS-fs (loop0): invalid crc value
F2FS-fs (loop0): Found nat_bits in checkpoint
F2FS-fs (loop0): Try to recover 1th superblock, ret: 0
F2FS-fs (loop0): Mounted with checkpoint version = 48b305e5
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: zone id is out of range
netlink: 209852 bytes leftover after parsing attributes in process `syz.0.0'.
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/f2fs/node.c:1170:12
index 18446744073709550692 is out of range for type '__le32[5]' (aka 'unsigned int[5]')
CPU: 0 UID: 0 PID: 5108 Comm: syz.0.0 Not tainted 6.11.0-syzkaller-11728-gad46e8f95e93 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 f2fs_truncate_inode_blocks+0xa07/0xd30 fs/f2fs/node.c:1170
 f2fs_do_truncate_blocks+0x7bf/0x1180 fs/f2fs/file.c:769
 f2fs_truncate_blocks+0x10d/0x300 fs/f2fs/file.c:797
 f2fs_truncate+0x407/0x700 fs/f2fs/file.c:847
 f2fs_setattr+0xc08/0x12d0 fs/f2fs/file.c:1066
 notify_change+0xbca/0xe90 fs/attr.c:503
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3395 [inline]
 do_open fs/namei.c:3778 [inline]
 path_openat+0x2e1e/0x3590 fs/namei.c:3933
 do_filp_open+0x235/0x490 fs/namei.c:3960
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
 do_sys_open fs/open.c:1430 [inline]
 __do_sys_creat fs/open.c:1506 [inline]
 __se_sys_creat fs/open.c:1500 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1500
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fce7717dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fce77eec038 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fce77335f80 RCX: 00007fce7717dff9
RDX: 0000000000000000 RSI: 000000000000000d RDI: 0000000020000240
RBP: 00007fce771f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fce77335f80 R15: 00007ffca65fb488
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

