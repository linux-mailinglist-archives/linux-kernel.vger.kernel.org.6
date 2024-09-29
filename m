Return-Path: <linux-kernel+bounces-342870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6939893E1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88241C20F41
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1FB13D260;
	Sun, 29 Sep 2024 08:52:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9966813B5A1
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727599946; cv=none; b=bficAZ/6fue18SplEmgB427YpAYKYY1CryNCQblqfwS8tnYJPFZ2qkbnyQcPIamtvPxUwo4qpQppvGh2tU9FNPe8FI9j3p8Qq+etwicYXdlzSuCWSjWKFMwIhG21A5yL1jexYzAEeteZlGXv6c+3LAI6wxmlpNQwXVYEirv61Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727599946; c=relaxed/simple;
	bh=ChkYvA0tuIgKErcKET75lqb93hN0n/mf7qQqrbPKhtI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s3GgEkktU773YNGOaslhgg51co8UlAOu3Wxh3hpfVY8zHwerQfgnb2sbOhP7LuXBKTmUx0EDb88LJt9p0QL0FYiHbheqfzab8DzIDBVICkNJG7nKFKt2g1KVpPnTRgH0UMi/LXXmZGM0dfi+9NPpbimNyNymfm/Io9pg8An9yqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a344da7987so30324685ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 01:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727599944; x=1728204744;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rJW+wBIDOm7srUL8NiLF1TLwhXaEQu5U9OO94RJwrM=;
        b=xUraspuYVnq7CxmqUI1b5pkZl/K8KmCMpuime8L8bKmavwF8F+usE3IwHTXuWwOQ3X
         1raNWCeeQhsxjY0tIj/A6a+HLNUafMo9dTxBL9o40vHDwwPXnxudOsuU7G6tnoWBiHdO
         0CJBRsOJssr35HVyPF5Co1JwIhuqgOjS/ZTMEg3Un6Zu0VrX0VnXE5q7QlZ/bi8Ic5VY
         oeFTrWDzjkR0VL3m+zTiWhxj6xSXqbUpkFx3x1leQjYVYM+uqNIRY4y7nZeM+6X/01sA
         Ze7mnnrkRNHtAhYR3UEtnw77IYCVwLQfGdCho3UYnmosgegWg6nhdE8/XCmkBJatfRK5
         amaA==
X-Forwarded-Encrypted: i=1; AJvYcCUfTEvk8NCnoAnLYkcH9X0QF+mb+bRCm8+JpIG5/zEeKejYGqT3WnBZgBBDkk7YqMAwBxv48oL4qrHKYBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW92vaKe59/FvjwALvKVMTPLCthgSwFw0XsQutAOdFiD9mcjsW
	DnCYsXZNLuuzLT7SQo7zdQnSkqXrjNZjGmhCFFZRN3Uvw2W7eB4Ma+LirRdC5CNQiLGJH9KYOm/
	yJi847fZT2wrrnhC7Rk6Dd7z50xJV6Nz/YzmrHLqnJsroiczu28YKbw4=
X-Google-Smtp-Source: AGHT+IHgjQdIHOg+ugAbgbxYA0w1puMXe5M14rxACCESNWIp2yKUc5V5z7vuq2cP2HSkmeVTXY8uLFc0Rl8oJNWWPswHtP0GcTMI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56f:0:b0:3a0:5642:c78 with SMTP id
 e9e14a558f8ab-3a3451738c8mr72535405ab.15.1727599943742; Sun, 29 Sep 2024
 01:52:23 -0700 (PDT)
Date: Sun, 29 Sep 2024 01:52:23 -0700
In-Reply-To: <000000000000aeb73d0621e8fa14@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f91547.050a0220.aab67.0015.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_assert_warn_i
From: syzbot <syzbot+ffe01cefd437cbde362b@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b1de80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=ffe01cefd437cbde362b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1357f6a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1757f6a9980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-3efc5736.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0988c372a39/vmlinux-3efc5736.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8547f30d7e9d/bzImage-3efc5736.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ff644c356076/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffe01cefd437cbde362b@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: Corruption found in quota_change0file: duplicate identifier in slot 82152
gfs2: fsid=syz:syz.0: warning: assertion "!qd->qd_change" failed - function = gfs2_qd_dispose, file = fs/gfs2/quota.c, line = 129
------------[ cut here ]------------
kernel BUG at fs/gfs2/util.c:414!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5093 Comm: syz-executor245 Not tainted 6.11.0-syzkaller-11993-g3efc57369a0c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:gfs2_assert_warn_i+0x2df/0x2f0 fs/gfs2/util.c:414
Code: fe 48 c7 c7 00 03 50 8c 48 89 ee 48 8b 54 24 08 48 8b 4c 24 10 4c 8b 44 24 18 44 8b 4c 24 04 e8 97 8b d4 07 e8 32 53 a7 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc90002c7f608 EFLAGS: 00010293
RAX: ffffffff83ed92ee RBX: 0000000000000004 RCX: ffff88801aac2440
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffff888011ff8000 R08: ffffffff83ed91a7 R09: 1ffff9200058fe5c
R10: dffffc0000000000 R11: fffff5200058fe5d R12: ffff888011ff82bc
R13: 00000000000003e8 R14: 1ffff110023ff057 R15: 0000000000002086
FS:  000055557cbb8380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc4c1c0e28 CR3: 000000003f704000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_qd_dispose+0x4af/0x5b0 fs/gfs2/quota.c:129
 gfs2_quota_init+0xd7b/0x1440 fs/gfs2/quota.c:1470
 gfs2_make_fs_rw+0x43f/0x5e0 fs/gfs2/super.c:159
 gfs2_fill_super+0x22a1/0x24d0 fs/gfs2/ops_fstype.c:1274
 get_tree_bdev+0x3f7/0x570 fs/super.c:1635
 gfs2_get_tree+0x54/0x220 fs/gfs2/ops_fstype.c:1330
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f707505d16a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc87086d28 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc87086d40 RCX: 00007f707505d16a
RDX: 0000000020021140 RSI: 0000000020021180 RDI: 00007ffc87086d40
RBP: 0000000000000004 R08: 00007ffc87086d80 R09: 0000000000021197
R10: 000000000300c888 R11: 0000000000000282 R12: 000000000300c888
R13: 00007ffc87086d80 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gfs2_assert_warn_i+0x2df/0x2f0 fs/gfs2/util.c:414
Code: fe 48 c7 c7 00 03 50 8c 48 89 ee 48 8b 54 24 08 48 8b 4c 24 10 4c 8b 44 24 18 44 8b 4c 24 04 e8 97 8b d4 07 e8 32 53 a7 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 90 90 90 90 90
RSP: 0018:ffffc90002c7f608 EFLAGS: 00010293
RAX: ffffffff83ed92ee RBX: 0000000000000004 RCX: ffff88801aac2440
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffff888011ff8000 R08: ffffffff83ed91a7 R09: 1ffff9200058fe5c
R10: dffffc0000000000 R11: fffff5200058fe5d R12: ffff888011ff82bc
R13: 00000000000003e8 R14: 1ffff110023ff057 R15: 0000000000002086
FS:  000055557cbb8380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc4c1c0e28 CR3: 000000003f704000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

