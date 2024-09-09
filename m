Return-Path: <linux-kernel+bounces-320897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6502A9711BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8BFF1F22E63
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFD1B29C9;
	Mon,  9 Sep 2024 08:19:23 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215E1509AE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869963; cv=none; b=iKLEcjwWUQITUWg+SmbjLnIUtVuUWybFW4lDUD9RbhCRMSnk196ANkaD1o7cQrkOwHCz3tLNtpTYHOlR4K9AMXTVq6liPiyWjEM1q0dE3A3Wi6oMHyFtPVDhQIhDBm0UUV5PiHwDkimEX/7hvgWpRPe3527CjbR2C1sa+9+iS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869963; c=relaxed/simple;
	bh=5HcaJElruX1pfb/i26+Bz4f+dMBbfRhhO/ZN8ksb0tQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Dp3370JKsUjwR2M/ojIE6I4TeX+O7YILCEauGgeZfqAAJcwf4j7RX18qFZn/nNJpLYeS8IDzaRJfuU0SwaK9as4/og37I2CMfZH54NRYCrWe1JQes/7rWv0nI+SBISaRrvsqaiiJKjO7i2p1Zine8cr4xJoej+WpZ2J3Y+/jdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-82aac437083so266510539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869961; x=1726474761;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9TK8D86o1H3VoOuFUaA0UFyWXWnfWkirvCcfMCQEsA=;
        b=xTtsOB9tPTfqz5Lm6kxyqnni3S4FyOmLgIiYCwUgGdphIPN0fC4vReF/xkSO2fgpv1
         0HoqK5HEvfhvhqqlR27KKVFZWSRmwujIZmVDhtwLr4kmqJeS2x0xRrAEhkkIFqqO74Z7
         j/rJiNFm5rpO5D8thM4TMWX2Dnqgr0Fer0Ev7+AqXkFQDOQ101eVO8pZVnJLBhodnz0I
         BBiNK58jw7U93/85gqjCVWQ+bKEF53vKb2xIj7VlvyADO/nqExhLpOEQUTIrNc41Tn5O
         ksGQFmO9MiIGM/xkwAVzebq/ncI3uHVvRT9cMgzg7ry27OyFGgY6HKdJQ00+j/DfTijQ
         K3WA==
X-Forwarded-Encrypted: i=1; AJvYcCW5jdpnLFRwzsx4iidJW//V6kCV7Rjm8Ewd4QQK1aU3PuZA2hKrNbjN0FS8WvTXRvPzWlXCth/iURmHMPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmFMBHL8C0TvhEtHfHTuQ/NKB2mPA76BPwnvy2eyR0J9qi72xL
	Aph7+D1KU+SERg0dClePtNlRPi6bBXqnWwPWS5SPxYgE1neTx1TF6DzrDLxXtELpRjbAQFdfXz+
	BULAB2L/SEDVhxLwUaC02JtaOySESgkfsGjsTRLNmyRkEgDRgTbZVEXI=
X-Google-Smtp-Source: AGHT+IG7kEzqFgnOnAhum1TROlVcYzIW5NwHjb6aNcqMjh+PwlS6M0OWvm/FZXOWP19qz3UN84Uc9eHJZ5zxsHt0FmtFtWGSqKBf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:154f:b0:82a:2385:74a6 with SMTP id
 ca18e2360f4ac-82a9618c4f3mr1287721039f.5.1725869960780; Mon, 09 Sep 2024
 01:19:20 -0700 (PDT)
Date: Mon, 09 Sep 2024 01:19:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0ee5b0621ab694b@google.com>
Subject: [syzbot] [f2fs?] kernel BUG in new_curseg
From: syzbot <syzbot+341e5f32ebafbb46b81c@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    89f5e14d05b4 Merge tag 'timers_urgent_for_v6.11_rc7' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14085f29980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a85aa6925a8b78
dashboard link: https://syzkaller.appspot.com/bug?extid=341e5f32ebafbb46b81c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1614c807980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13854e00580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-89f5e14d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfc310daee41/vmlinux-89f5e14d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a92f22c06568/bzImage-89f5e14d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c7aaf1741c93/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+341e5f32ebafbb46b81c@syzkaller.appspotmail.com

F2FS-fs (loop0): inject no free segment in get_new_segment of __allocate_new_segment+0x1ce/0x940 fs/f2fs/segment.c:3167
F2FS-fs (loop0): Stopped filesystem due to reason: 7
------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2748!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5109 Comm: syz-executor304 Not tainted 6.11.0-rc6-syzkaller-00363-g89f5e14d05b4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:get_new_segment fs/f2fs/segment.c:2748 [inline]
RIP: 0010:new_curseg+0x1f61/0x1f70 fs/f2fs/segment.c:2836
Code: 24 58 e8 12 b9 f2 ff eb 05 e8 4b 71 96 fd 48 8b 7c 24 70 e8 91 ac c6 07 48 8b 7c 24 10 31 f6 ba 07 00 00 00 e8 50 1e f6 ff 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000179f548 EFLAGS: 00010246
RAX: 8fb07c62f860e300 RBX: 00000000000002b2 RCX: 8fb07c62f860e300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff8880125250c8 R08: ffffffff817401bc R09: 1ffff920002f3e20
R10: dffffc0000000000 R11: fffff520002f3e21 R12: ffff8880008c2700
R13: ffff8880125250cc R14: 1ffff110024a4a19 R15: 00000000000002b2
FS:  0000555593e0e380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6cf8cb40f8 CR3: 000000001255a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __allocate_new_segment+0x1ce/0x940 fs/f2fs/segment.c:3167
 f2fs_allocate_new_section fs/f2fs/segment.c:3181 [inline]
 f2fs_allocate_pinning_section+0xfa/0x4e0 fs/f2fs/segment.c:3195
 f2fs_expand_inode_data+0x5d6/0xbb0 fs/f2fs/file.c:1799
 f2fs_fallocate+0x448/0x960 fs/f2fs/file.c:1903
 vfs_fallocate+0x553/0x6c0 fs/open.c:334
 do_vfs_ioctl+0x2592/0x2e50 fs/ioctl.c:886
 __do_sys_ioctl fs/ioctl.c:905 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6cf8c37229
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeb5036b58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f6cf8c37229
RDX: 00000000200000c0 RSI: 0000000040305828 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffeb5036b90 R09: 00007ffeb5036b90
R10: 00007ffeb5036b90 R11: 0000000000000246 R12: 00007ffeb5036b7c
R13: 0000000000000002 R14: 431bde82d7b634db R15: 00007ffeb5036bb0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:get_new_segment fs/f2fs/segment.c:2748 [inline]
RIP: 0010:new_curseg+0x1f61/0x1f70 fs/f2fs/segment.c:2836
Code: 24 58 e8 12 b9 f2 ff eb 05 e8 4b 71 96 fd 48 8b 7c 24 70 e8 91 ac c6 07 48 8b 7c 24 10 31 f6 ba 07 00 00 00 e8 50 1e f6 ff 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000179f548 EFLAGS: 00010246
RAX: 8fb07c62f860e300 RBX: 00000000000002b2 RCX: 8fb07c62f860e300
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff8880125250c8 R08: ffffffff817401bc R09: 1ffff920002f3e20
R10: dffffc0000000000 R11: fffff520002f3e21 R12: ffff8880008c2700
R13: ffff8880125250cc R14: 1ffff110024a4a19 R15: 00000000000002b2
FS:  0000555593e0e380(0000) GS:ffff88801fe00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6cf8cb40f8 CR3: 000000001255a000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

