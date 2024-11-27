Return-Path: <linux-kernel+bounces-423258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B669DA517
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF75161EB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CEF1940A1;
	Wed, 27 Nov 2024 09:49:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CE0A95E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700973; cv=none; b=kBti+LKA/oaK42+MiLBf1SVbM/+mhluf+2PUSiHXrk5l++zRwGpVhaIstgUrIkslO8bDDQHlAAYrLxtehA7fgxbB7exSMMMRQn8rbW5F8SfIsrNZsBngZLYliZDG7nMu6Xhia5Tz5Ub6JQ+Jm4h5AZblhntbs/GTX+ADAPa0XcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700973; c=relaxed/simple;
	bh=+i9UYsPc1u314u44i+XhREFyNRvregaPr93eeYTMGSo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PDyibtmTUqnQ3hpCDaaUAeWq5kKIV7E7i6sEk+2gs5RprG5doPeQdSEAEIuyk0rIjuoyb5jGOLUSNNyNbDNBy/FVpWs4lJ2QkXfM6wA+UBXWNP4+Xk95xq1dkUU67eEPHwlOfkHknkXflU6Fwo6Jnwko8JK8MQsHBZkegUbfk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a76690f813so78649355ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732700971; x=1733305771;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1e1txHINzeeISulL9qfNM+/I+6cuMZa6XFV5XbUwNI=;
        b=MPZ1QjGfNYS60+nwDJFO0hfWMaq7NrZuRtS3cteM3pFJZsWL/ytaGj536p8bN2qeqB
         cBUryvnmjzYCfQ6IsUKo7lzMi6nmo53P0gfBjvr25gBupKl9mYVLT0LgoVJtSSUaj/GA
         shT5/bpxDfbae670P5jTLvDfawQCJOnpXpXXg6XCXj6YAZk9Z73Uk04QXMtIEARY1LoG
         Jm9Fe+hxu8kA/MtyxfiJ8NkfaFfQ17+RUf7e8F+cUYgrYXhlDPxPXQmW20TyOCup0aaA
         Yg1jYevI90Ysk0RFRV2ltHwBo9npDobBrFYdAIwWwg+ZqEjpDWT/wHMUH6pNeS2alow5
         Bl6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ou4RoGV+EZnHKdo3zknIlAFfRwG5imAAOnNNPp40z9HDvAj6wj3O4l3SdFyYjhWdpaOhviQojf/LIjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4hisuXj4L4j26XHfdKnrqChx/DtxOQKLS/JhU3ZxgCwLNDHi
	Nc4jQ+5DD7gkqBKc2H/+s7eZOM0UZYfcxNnp//Yb8kNU9K95skjCbnbGgzJad8dX68wq28EeyvL
	P0wDmN7a2TrlsTk3LNdVrMDYIDJnZPd+RNTO899pyUEbXjk9OZi9UK3Q=
X-Google-Smtp-Source: AGHT+IGnSYm2uvF5NkzSJivqe/0veQUq8O25REPzZJbwv2ce3zRIfMnm2/RsaifYxx6o8VgmqMMBjZdIP9GYzHC2Di+1CHSftSEr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3a7:7ad4:fe78 with SMTP id
 e9e14a558f8ab-3a7c55d3e94mr20879165ab.19.1732700970906; Wed, 27 Nov 2024
 01:49:30 -0800 (PST)
Date: Wed, 27 Nov 2024 01:49:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6746eb2a.050a0220.21d33d.0022.GAE@google.com>
Subject: [syzbot] [ntfs3?] kernel panic: stack is corrupted in ntfs_set_state
From: syzbot <syzbot+bbcb68026d186313e795@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1724c778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5073f0bff19a2470
dashboard link: https://syzkaller.appspot.com/bug?extid=bbcb68026d186313e795
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1738b75f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15772530580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b34c9010f21/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa5635896077/bzImage-9f16d5e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d8c38ce23614/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbcb68026d186313e795@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (1024) and media sector size (512).
ntfs3(loop0): Mark volume as dirty due to NTFS errors
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: ntfs_set_state+0x6b9/0x6c0
CPU: 0 UID: 0 PID: 5922 Comm: syz-executor192 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 panic+0x349/0x880 kernel/panic.c:354
 __stack_chk_fail+0x15/0x20 kernel/panic.c:836
 ntfs_set_state+0x6b9/0x6c0
 ntfs_iget5+0x912/0x37b0 fs/ntfs3/inode.c:548
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
RIP: 0033:0x7fde72d5479a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 ee 08 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff75a1aaf8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff75a1ab10 RCX: 00007fde72d5479a
RDX: 0000000020000140 RSI: 0000000020000040 RDI: 00007fff75a1ab10
RBP: 0000000000000004 R08: 00007fff75a1ab50 R09: 000000000001f853
R10: 0000000000004002 R11: 0000000000000286 R12: 0000000000004002
R13: 00007fff75a1ab50 R14: 0000000000000003 R15: 0000000000200000
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

