Return-Path: <linux-kernel+bounces-422238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6199D9652
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07161167CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB10F1CEE82;
	Tue, 26 Nov 2024 11:38:30 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA58C1CEAD4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621110; cv=none; b=d1WjtA7IRLVJe6lhib1K7FMHMbAm3aWMp5SHCFoxzecD3AggjtPdCWGC2nWWUzygvWhagz2DgPiBzXVjfsmW3eJ19WPYJyxUEzYOQoDbbbH4gR0tZhT4f/FrtnWwJE3VI5V+1elSQHUCJPaDSUC89soNyIJHtY6zwFmSSCHfGsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621110; c=relaxed/simple;
	bh=d04pFtjp3aB6UVCibWCR/sDgJ7z94d5RgrcgLgKxCbE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u5dYhmvUHcttn8hb3hywdliv69SO3gDzMHYpYvmUcbk0o33QZvJ/wZsQpKwsjMWPgXlwbuQ8JfbHEhS1dXzTp7c/31mGZv59V6k6owW6qPN/ixnSHvLpcYvlbQToduzLvWnGWmSFtYQzHohfZisI9bELyg+V2cIyoBF4GF5HURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7932544c4so52413525ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732621107; x=1733225907;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEmnuJrlOTw7VDUs9t4zoFz+7BAxEM5wGCiCwqDzQLw=;
        b=D26i+AGUGqK3zuVcQKHBLm0HcS9KaD1F8tzkgR4lYBo02+nhWxiijUs4xsh7kff+zP
         shlKYBOzLH3NA+TSruOcZr3oJ0VFxaBv5XFXioCryIRcWNeDb6NjuIMhSveCgwQcI5ro
         DxDLCFmxAf3g72rO/ItNgjGnnepXpRPeYIFkikrVv5JHQ8BqkIzgWq0VaB47XFJWOXGy
         5HSbXZGkTu3cnxuQHy/iPss/KNpl1n7737NQX39Fg1cFNlUaXdaeH0MohA6rVXLp/0xp
         wSSIT1OGHKliMZ24PqaWchNl8E1MSKl+iHSCz/DG4A8UZUIWfALTgVcMrLjh8g97/scD
         p5wg==
X-Forwarded-Encrypted: i=1; AJvYcCUXqeKDAX47L5uiHt/OK8Q+0GAUMTx7kMTBoTRtteK/KKDRfZDrVRBOgq2ZiTaIwFp+QSmloZaFTuLx2Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0ON/lBOmdA6gqxF2Mk+ZYtPYEUUKqbzCwP4mdxh0MEt6AowB
	AX6YI6gCBTK15boH/9CrASZ9H9oTuYy26lyS/CiM3SW1lVgj3Bfa8hYBU9+kNhSoqtiTBVkdnVu
	BTg+gcfFwzh+YEf8Zjc+n+/kSdtk1xmYhzh6DrIDs6dQI2tMovj5dNpA=
X-Google-Smtp-Source: AGHT+IG0BSO+ApdsgG/2//bSnwoh9SH5pSX4ESapIr7O85ULYLfBU7NOZRFKUV0yl5EAHFzjd3HDeREE9/aUpJA2oR4XXWBLML2f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16c5:b0:3a7:87f2:b010 with SMTP id
 e9e14a558f8ab-3a79acf9b88mr178413885ab.5.1732621106822; Tue, 26 Nov 2024
 03:38:26 -0800 (PST)
Date: Tue, 26 Nov 2024 03:38:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6745b332.050a0220.1286eb.0016.GAE@google.com>
Subject: [syzbot] [udf?] WARNING in udf_rename (2)
From: syzbot <syzbot+3ff7365dc04a6bcafa66@syzkaller.appspotmail.com>
To: jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=149e7930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=3ff7365dc04a6bcafa66
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f8975f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129e7930580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/77e67e959031/disk-06afb0f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef29cbe930b4/vmlinux-06afb0f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/430d1fe2c7b0/bzImage-06afb0f3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0f103b2b0acc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ff7365dc04a6bcafa66@syzkaller.appspotmail.com

UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/11/22 14:59 (1000)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5834 at fs/inode.c:407 drop_nlink+0xc4/0x110 fs/inode.c:407
Modules linked in:
CPU: 1 UID: 0 PID: 5834 Comm: syz-executor342 Not tainted 6.12.0-syzkaller-07834-g06afb0f36106 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:drop_nlink+0xc4/0x110 fs/inode.c:407
Code: bb 70 07 00 00 be 08 00 00 00 e8 27 d8 e5 ff f0 48 ff 83 70 07 00 00 5b 41 5c 41 5e 41 5f 5d c3 cc cc cc cc e8 9d 40 7e ff 90 <0f> 0b 90 eb 83 44 89 e1 80 e1 07 80 c1 03 38 c1 0f 8c 5c ff ff ff
RSP: 0018:ffffc90003ab7610 EFLAGS: 00010293
RAX: ffffffff82170c43 RBX: 1ffff1100e413100 RCX: ffff88807e470000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff82170bc3 R09: 1ffffffff2038026
R10: dffffc0000000000 R11: fffffbfff2038027 R12: ffff888072098800
R13: ffffc90003ab77d0 R14: ffff8880720987b8 R15: dffffc0000000000
FS:  000055556dfec380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564225f57310 CR3: 00000000770da000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inode_dec_link_count include/linux/fs.h:2521 [inline]
 udf_rename+0x969/0xe10 fs/udf/namei.c:867
 vfs_rename+0xbdb/0xf00 fs/namei.c:5067
 do_renameat2+0xd94/0x13f0 fs/namei.c:5224
 __do_sys_rename fs/namei.c:5271 [inline]
 __se_sys_rename fs/namei.c:5269 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:5269
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f25e8587ad9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdbb95b938 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007f25e8587ad9
RDX: 00007f25e8587ad9 RSI: 0000000020000f00 RDI: 00000000200000c0
RBP: 00007f25e85fb5f0 R08: 000055556dfed4c0 R09: 000055556dfed4c0
R10: 000055556dfed4c0 R11: 0000000000000246 R12: 00007ffdbb95b960
R13: 00007ffdbb95bb88 R14: 431bde82d7b634db R15: 00007f25e85d003b
 </TASK>


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

