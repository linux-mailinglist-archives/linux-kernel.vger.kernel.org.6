Return-Path: <linux-kernel+bounces-423884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 848DD9DADDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D8DB2743A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDF201116;
	Wed, 27 Nov 2024 19:31:35 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D213D89D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735895; cv=none; b=exgDz6xvX/GeuPO6ecDhT+xtqNjDqKrH7DZlygu9sVDKLBfpk0shpOspUYEjLyMMmduNdZNpJC1oY0DMiL653TejyK9Hys1dnu5P97p0kfYjQ1VYDHVyaFxTz3dWkP9bU6lbD0oRDr1rmDNtrFlMZegw5SklOn3qwJBsydie6OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735895; c=relaxed/simple;
	bh=ZRWv/qJXWX0N+LmlrTPTdZNF7tI8MhRL5ijfHMRhmuI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RS4uD31CD3qD3JWR2AYuX2UQTzphBs8uFf0DvnREQZkKyYm+SNSBuSfgri0zdnifxWYqD8pn+xhU49T0Lc5WpeqcpC5DHgjGTMr20d9oDAsh4qh25KSJbxgX0iPa+6nwZUGnvgA9Hzl9gHu5YERlTtfwdjoxH9+Cwu6mkO1DV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7bdd00353so769595ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732735892; x=1733340692;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nhvv+26YcoilaAxS4XzL863FzPGOjY6ajDUbRofaE8U=;
        b=L/heIPsTYG5+iRbuWTwZFvtgfD5ZbK7+DqDX4HY9Fx8+Y0A9G9Uz7Jq5rtwvb/45qt
         9lr6kORQ6crb+YMuYH229kIHuDmmVmlb5x8MT8XIuGtF/XE5myBEweXqgzP3sswfaj6M
         1tpjnErzwOphMvq2uWL9BfrvSHlw1ASq+ze/CJRbni1kyniJH+G9uwyXB2a3n83Tvrff
         HUSUoLfj8sGWT1PVW2YRLofrQu/DycRM+q/IQ6VEOHcYHELoZCGCLp9WkCL3VXtinV/Y
         f59umL2EjS/jyrrPh0h3KKXQfzs8XwKt97Hi5uyUjEaWjxzjP+P14ZNlYgrDmnDOO+4A
         1Tng==
X-Forwarded-Encrypted: i=1; AJvYcCVSNQg1P5WH/DvOVfPxHzXVIW38UGzpdQMTVcNgu07s6PR/mlGzMU1xj5V8yDNDQPzdVR6rI8I+KVrcNYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLP0gYidbSGlkReL+qgsZvOgNjr06qA7Q/zlNuMrDNKKMov9k
	3j7hWQ33GTg0cMqYgPiRr6OBUPP/BaKoStdA0wUPl4fQ52G4dk31VMKJjCnAnsvUTfrqGLCGc8b
	f1kK61liTgdLadznzRpJ/4/uRlG1S8dLVD3QM3nNddPKZKhKq1SpHy+E=
X-Google-Smtp-Source: AGHT+IGY8P0kD9Kmo8vCaJ0MVKVivQfixo468bFvt0QCfbxcippbtBDZm5OvuigToBSx0ngtAUJfslLcqQ6yvMLlfBYqp54CCWfp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144a:b0:3a7:6f1c:a084 with SMTP id
 e9e14a558f8ab-3a7c55e2adfmr49463305ab.23.1732735892640; Wed, 27 Nov 2024
 11:31:32 -0800 (PST)
Date: Wed, 27 Nov 2024 11:31:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67477394.050a0220.21d33d.0026.GAE@google.com>
Subject: [syzbot] [ntfs3?] kernel panic: stack is corrupted in ntfs_printk
From: syzbot <syzbot+41821903c04037f57f20@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110e19c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5073f0bff19a2470
dashboard link: https://syzkaller.appspot.com/bug?extid=41821903c04037f57f20
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130e19c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1064f6e8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b34c9010f21/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa5635896077/bzImage-9f16d5e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d7a3b96e4e1b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41821903c04037f57f20@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Inode r=a is not in use!
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ntfs_printk+0x415/0x420
CPU: 0 UID: 0 PID: 5379 Comm: syz-executor218 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 panic+0x349/0x880 kernel/panic.c:354
 __stack_chk_fail+0x15/0x20 kernel/panic.c:836
 ntfs_printk+0x415/0x420
 ntfs_read_mft fs/ntfs3/inode.c:86 [inline]
 ntfs_iget5+0x57c/0x37b0 fs/ntfs3/inode.c:537
 ntfs_fill_super+0x3e8e/0x4730 fs/ntfs3/super.c:1477
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3c5f178d6a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 7e 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffedbe7c538 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffedbe7c540 RCX: 00007f3c5f178d6a
RDX: 0000000020000280 RSI: 0000000020000300 RDI: 00007ffedbe7c540
RBP: 0000000000000004 R08: 00007ffedbe7c580 R09: 000000000001f746
R10: 0000000000200001 R11: 0000000000000286 R12: 00007ffedbe7c580
R13: 0000000000000003 R14: 0000000000200000 R15: 00007ffedbe7c7d0
 </TASK>
Kernel Offset: disabled
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

