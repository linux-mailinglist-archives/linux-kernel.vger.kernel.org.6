Return-Path: <linux-kernel+bounces-198138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7F58D73FA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 08:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064A71C20B13
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D112D1BC5C;
	Sun,  2 Jun 2024 06:20:24 +0000 (UTC)
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DC134A8
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717309224; cv=none; b=s7UakIP3Nwv99pCtE1GkMskl64wgfMXIXwvI41rk3ofTk+vzjaYUN8SCfbMiXBGsyEtbwdHhOHL/+04paJ48IEBr7U4qp+6/Ro231SWXl86GrBAiXF4MVR8ub0+rab3lK6DIienJUJLYF/MIyhoLs9QfAlZufB3YAy582aH3YtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717309224; c=relaxed/simple;
	bh=wxwWOV1DHtZf+U/E0W6APZNj5PyrYS0cyMVG0sxJZLw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rmwbogLb5u4xKSFj9VEhv5OmKiM8xfT0HrEsyz6THdCIol+KyJZIENTbPSa06YCNLdxIY9+iUAH1VdcdHAq7Fyf/I/s7zaAEe+roP2gCwqV4P2Tiz1FxJWt26HPObqbCArdDo7FsdKqk1aMX3YSRzv5r5PlwKgVw0q/mDtN+gKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so455937139f.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 23:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717309222; x=1717914022;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htGAco0bPsov3LqE3CBGEk0l7m4jTDd+5G2UFFbuNvo=;
        b=d5Zwie587P+E7/6BIX5Wa+E6yC2Zjz5QqKZ7S7qFZ3oqwoUUITumvVJ/4qm9ZE5cPH
         ODwWmbBDHdi1ZiC0y8aXhYJxxCCqYRjma5Yu22oXZUuVjr8k3o2YdCpMwx+wACDsZzF4
         MqTY/HPWrBOnYkQrdNOrfNtba5C6/uUNF0AnHVqL9VvsoWTbja1M5+3434Xfys6+P6U4
         cZ4habkySuKWOCC6RJNb14Fs3Fa8abrmBp2gNnX2T0549jPRIb9R+/ITNIi0NuO30SSx
         I/TeypkfTnaO9Ecy+NOO3FiqTtA9DTexgK3b363LReUsUCGljuX5pU0Gn8ZAGplAp0mk
         YH1w==
X-Forwarded-Encrypted: i=1; AJvYcCXt3aClwtgPnL/EOOh1cfoUx6/nLG94zBSzfW8Ki/PkEPeu96E3eDmZ4RsBsiYAUZMSI3Th68BpWjX2WlJs8IYFLG2HqmaM+hRlELpB
X-Gm-Message-State: AOJu0YzvWutLq2YQiLPwpC1mw1yyV9XV7/f1dbwXoHdqYbOUPXGC+npF
	ANKsYgZFQUhEMFxsH0osBoLbTFE2oxz0u3GQdQ5P7GuPmywEQVFrAtExNsFVXDxOYB22U3+2cQl
	2hqQigLXOdMql0qIBq0Ql30IqjU1EZz6wW4Xm/7QBJqCFKzYj0IiEScw=
X-Google-Smtp-Source: AGHT+IFOpgdxpCnn1FbIK5ys+0pV5dixwDRHp6XHcl5Vy5xYm2nr0UlihlD3N8MS3QaxBZWNvtbGcS1XeNkqJ9+fdFOoWwNRICXL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6425:b0:7de:de58:3b1f with SMTP id
 ca18e2360f4ac-7eafff5f893mr41162539f.4.1717309221955; Sat, 01 Jun 2024
 23:20:21 -0700 (PDT)
Date: Sat, 01 Jun 2024 23:20:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002501960619e2366b@google.com>
Subject: [syzbot] [gfs2?] BUG: corrupted list in gfs2_fill_super
From: syzbot <syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d99040b1bc8 Add linux-next specific files for 20240529
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=166afa9a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=735e953fee00ec19
dashboard link: https://syzkaller.appspot.com/bug?extid=d34c2a269ed512c531b0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100817e6980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f0deeb27b28b/disk-9d99040b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5acd2205cee1/vmlinux-9d99040b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/222eebb6b9d8/bzImage-9d99040b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c09aa7fc8a5a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: can't create logd thread: -4
list_del corruption, ffff88806f0fe010->prev is LIST_POISON2 (dead000000000122)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:61!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 5367 Comm: syz-executor.1 Not tainted 6.10.0-rc1-next-20240529-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__list_del_entry_valid_or_report+0x106/0x140 lib/list_debug.c:59
Code: e8 6f 50 d0 06 90 0f 0b 48 c7 c7 e0 03 20 8c 4c 89 fe e8 5d 50 d0 06 90 0f 0b 48 c7 c7 40 04 20 8c 4c 89 fe e8 4b 50 d0 06 90 <0f> 0b 48 c7 c7 a0 04 20 8c 4c 89 fe 48 89 d9 e8 36 50 d0 06 90 0f
RSP: 0018:ffffc9000313f928 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 0a380b9a54d54400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff11005247900 R08: ffffffff8176b139 R09: 1ffff92000627ec0
R10: dffffc0000000000 R11: fffff52000627ec1 R12: dffffc0000000000
R13: ffff88806f0fe000 R14: ffff88806f0fdc10 R15: ffff88806f0fe010
FS:  000055558b8fd480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055776d320f00 CR3: 000000002dc2c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_rcu include/linux/rculist.h:157 [inline]
 destroy_workqueue+0x7b3/0xc40 kernel/workqueue.c:5859
 gfs2_fill_super+0x12a4/0x2520 fs/gfs2/ops_fstype.c:1311
 get_tree_bdev+0x3f7/0x570 fs/super.c:1615
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x90/0x2a0 fs/super.c:1780
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f40a8e7e5ea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 09 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe7139d798 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffe7139d820 RCX: 00007f40a8e7e5ea
RDX: 0000000020000200 RSI: 00000000200002c0 RDI: 00007ffe7139d7e0
RBP: 0000000020000200 R08: 00007ffe7139d820 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000200002c0
R13: 00007ffe7139d7e0 R14: 0000000000037f59 R15: 0000000020000140
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x106/0x140 lib/list_debug.c:59
Code: e8 6f 50 d0 06 90 0f 0b 48 c7 c7 e0 03 20 8c 4c 89 fe e8 5d 50 d0 06 90 0f 0b 48 c7 c7 40 04 20 8c 4c 89 fe e8 4b 50 d0 06 90 <0f> 0b 48 c7 c7 a0 04 20 8c 4c 89 fe 48 89 d9 e8 36 50 d0 06 90 0f
RSP: 0018:ffffc9000313f928 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: 0a380b9a54d54400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: 1ffff11005247900 R08: ffffffff8176b139 R09: 1ffff92000627ec0
R10: dffffc0000000000 R11: fffff52000627ec1 R12: dffffc0000000000
R13: ffff88806f0fe000 R14: ffff88806f0fdc10 R15: ffff88806f0fe010
FS:  000055558b8fd480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9b37cbc000 CR3: 000000002dc2c000 CR4: 00000000003506f0
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

