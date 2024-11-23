Return-Path: <linux-kernel+bounces-419077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B09D6932
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDD9281DE6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F68018A6AB;
	Sat, 23 Nov 2024 13:14:25 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818E1EEE6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732367664; cv=none; b=VxBhgXIsApQpF1pvTLia/bKyOjMwGaG6w6bGxiH5rElAukNn1OqkYN0WFXRyTH/fhs18LkT2zSM45e+3CZt4U9BMvtmn1VmUoN9NsX/Vo+gGwyHo+CW/1dd7LGs/etBKgRHOSEos9LgKbYNd22qGnNVS0S+IUPKXxiPErW6JRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732367664; c=relaxed/simple;
	bh=W5VLZhCmHZLlr9K3vcCe2Q44BqQ4UeuOvfDDNyP5frk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=saKySDNI8efPpRNKRChqg2mj0RPrXQ1CGDww/dD/BVTEYQ+ydLC2cnekp8/UipjSchCGni/B6wNZJUam8q85GQQa+WmO4X8FIeiSeY1IXtR8a7m/CMAPEv/wRiJkziLO0/CTR+0Ftz6+U5SnaYW8bgL/VQ2Cy0t4lKSVUhdfre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a77d56e862so24676135ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732367662; x=1732972462;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDZ99ejxD/GrhQAqRtjpC0KOChx8C2/P4scOf1Xv+qE=;
        b=YiT8OAbkv3WqF0fpb31OU/7pP44OUcEjoJ5CRkrLr6i4WIP6BjSZd7jMw0637Y7fY+
         BGeRPWENTO8//dK892mKJG/3pzcu1J71pL2AzJv0cFzfn1A1IcrG6eVCF/foi3YeHR0x
         8+wFH7E4ULU/Gw6MKtyzfI0iORjF2FbNRNOevINM93TFIGxePZmx/gv6hEi76piXi74z
         6nBUwjWLXBT8A600B0I+sEuruOw+jEPE0gKjF3dvVNgUDKu2om2mw1ii8xJq7Ni7f/B4
         1npkPevfUPsPnA9+NdZqNbWy+Pce5MdrVGjFb5EDeKTa8upF6FrFDXNLGw1pvyzUdCHR
         AN9g==
X-Forwarded-Encrypted: i=1; AJvYcCV0RSdfbV9EN5zzr+TsX2UCpLzuWZCr2YXiyM9OdbmIV4q7aqZ6cXaocQEvh2XcbWpi/nv0gnbauqAHy1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/OISXNNcF6C4IIVpK/+7H9zgd8oc0SibtuTVLYIgAIvAmj/ya
	jy3y3SeOc63CDTczoIzc77u8Q9vQnEJXC04tfQQ8dGVv9LHuC3Ah252CojC3HG8Mh9PkCfK8E//
	G1vniN2m3gUkZKM7L/XgjemtE5qtfhyuHRPiv/XzjRh8vF3LgmT3xI6M=
X-Google-Smtp-Source: AGHT+IGtIebMFpXYtE3/Wjyx/JZ6wmIoZw2ukrYTaEKklxbWbe6pqUNQ7MXIDTC2XLQhT9hmIn/wFJR1h2cYl9vvCdVXcmTmE7Ky
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c269:0:b0:3a7:91a4:c752 with SMTP id
 e9e14a558f8ab-3a79afa90a6mr85761255ab.23.1732367662254; Sat, 23 Nov 2024
 05:14:22 -0800 (PST)
Date: Sat, 23 Nov 2024 05:14:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741d52e.050a0220.1cc393.0010.GAE@google.com>
Subject: [syzbot] [udf?] WARNING in __find_get_block (2)
From: syzbot <syzbot+3c9f079f8fb1d7d331be@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, jack@suse.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cfba9f07a1d6 Add linux-next specific files for 20241122
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178636e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=3c9f079f8fb1d7d331be
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be35516c7ba5/disk-cfba9f07.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70295210dc7d/vmlinux-cfba9f07.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8b5d044072ee/bzImage-cfba9f07.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c9f079f8fb1d7d331be@syzkaller.appspotmail.com

------------[ cut here ]------------
VFS: brelse: Trying to free free buffer
WARNING: CPU: 0 PID: 12266 at fs/buffer.c:1229 __brelse fs/buffer.c:1229 [inline]
WARNING: CPU: 0 PID: 12266 at fs/buffer.c:1229 brelse include/linux/buffer_head.h:324 [inline]
WARNING: CPU: 0 PID: 12266 at fs/buffer.c:1229 bh_lru_install fs/buffer.c:1346 [inline]
WARNING: CPU: 0 PID: 12266 at fs/buffer.c:1229 __find_get_block+0x109d/0x1150 fs/buffer.c:1400
Modules linked in:
CPU: 0 UID: 0 PID: 12266 Comm: syz.6.1269 Not tainted 6.12.0-next-20241122-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__brelse fs/buffer.c:1229 [inline]
RIP: 0010:brelse include/linux/buffer_head.h:324 [inline]
RIP: 0010:bh_lru_install fs/buffer.c:1346 [inline]
RIP: 0010:__find_get_block+0x109d/0x1150 fs/buffer.c:1400
Code: 67 3e 9a e8 05 20 db ff e9 1b f7 ff ff e8 4b 2f 70 ff e9 87 f7 ff ff e8 41 2f 70 ff 90 48 c7 c7 20 e1 18 8c e8 c4 cd 30 ff 90 <0f> 0b 90 90 e9 6b f7 ff ff e8 25 2f 70 ff 48 c7 c7 c0 cf a8 8e 4c
RSP: 0018:ffffc90005d974a0 EFLAGS: 00010246
RAX: 678501cd73c0d900 RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc9000fba1000 RSI: 0000000000011153 RDI: 0000000000011154
RBP: ffffc90005d975d0 R08: ffffffff81601b32 R09: fffffbfff1cfa218
R10: dffffc0000000000 R11: fffffbfff1cfa218 R12: ffff88807bcf69f8
R13: ffff8880b86398b0 R14: ffff888034c6d828 R15: ffff88805ae4f6b8
FS:  00007fbd27ae76c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30210ff8 CR3: 0000000067510000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bdev_getblk+0x33/0x550 fs/buffer.c:1425
 __bread_gfp+0x86/0x400 fs/buffer.c:1485
 sb_bread include/linux/buffer_head.h:346 [inline]
 fat__get_entry fs/fat/dir.c:100 [inline]
 fat_get_entry+0x78f/0xae0 fs/fat/dir.c:128
 fat_get_short_entry fs/fat/dir.c:885 [inline]
 fat_subdirs+0x227/0x3c0 fs/fat/dir.c:951
 fat_read_root+0x5e5/0x8b0 fs/fat/inode.c:1345
 fat_fill_super+0x205f/0x35a0 fs/fat/inode.c:1814
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbd26d7ffba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbd27ae6e68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fbd27ae6ef0 RCX: 00007fbd26d7ffba
RDX: 00000000200000c0 RSI: 0000000020000000 RDI: 00007fbd27ae6eb0
RBP: 00000000200000c0 R08: 00007fbd27ae6ef0 R09: 0000000002010000
R10: 0000000002010000 R11: 0000000000000246 R12: 0000000020000000
R13: 00007fbd27ae6eb0 R14: 0000000000000336 R15: 0000000020000640
 </TASK>


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

