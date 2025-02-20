Return-Path: <linux-kernel+bounces-523206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D55ACA3D37F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA37189EFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5400E1EBFFF;
	Thu, 20 Feb 2025 08:42:24 +0000 (UTC)
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC71EB1A3
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040943; cv=none; b=LKrfHm5XDAQisEgTZDzjpRijyL1T0UzAnX7asOnHmAa+CegYIvnz2gDNmCaJQ49pzynVH1s4KfWpj4K24mBDfY+Bu6Eov4dgppWVVpn3l2fH5cxV2ReJDWw4dCBiUBPKeDSJn6+C79UsgvPEpOoYfzrNJHjC4utIVzN2+EzzZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040943; c=relaxed/simple;
	bh=Rvd1AkBI3DQft8A+d56w/9z1RNJNy+10DkMiBhcY4fM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UVMrw00AzBuGm7TsHaoDlDxRLsg8RNy5bgEy0iMDIMxIYMxvwGLVDIka/6TAL4OMm7SfHSX35ug37svVIr4fxsCXB211qYi5Ve1/UOhMSxVRLP2a2l0RJYugyasNfoJIJZEPYrlOgmL0b4FWswvuIhiL7OHHFEc0LroR0dxGv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2a6ead92fso13513255ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:42:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740040941; x=1740645741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tspJAAykuhA+T1wvtVtZTwQlwpV9zuUPnroEWvAUycg=;
        b=jTdPtFZ7SgLRQdhouF4Qm480ZpfMulcA9HBztlKIvw94t4r1LYqk4zQjAHNVFv3tkN
         dyVratDhloq3lgggldKpdVzcb8CAw/g+wBhBuS6Mx+rnOCz2+1it93KzEIw3NP5UvHS9
         5NJvRmePA6d5bMeGhKtOfqOEh1bU/QElmu1ZYIZKftd5elvz4JWsJXQp82ouMkJVWnY5
         2BxlqJI+ICIUqasi6mEr+29xft5Gl7RAq9zERwoNc3zmuu9mvpAqK4W9xeXDodfSeJ1U
         OwQK4M+KJfxdmt/qIlnex5z1j+DScHJAT4yk1dux0svJ6S88FrESVzg+V0B0EdnFJTx+
         5ghg==
X-Forwarded-Encrypted: i=1; AJvYcCW9TtqLhRFafHHvslcT+sjZrq9uSxXGDBCNjJmlwZO9YWPgJ8Ql+YafYrd17COPOsqjCxqhX8RYqoIoEb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMHgxgMpQQw1uriGoP1r0q4s/Nm3pW9NgM5ULmtiLGEUudIOoP
	VPkqFdQ+G2aLM9bYTkRCGsIwJc1Knxk286XS60ABj5TrkrtYxo7v6oPjb6CcXGL0Fx7qccLPSA4
	ZnKCfIxbWuLaJu4rSq9B2wzCDjUEnktS+lE4KLtdbJvHJIWtt6NESlo8=
X-Google-Smtp-Source: AGHT+IGAC6WwtHen8etce11Gn8GZe12LsA5KARfnqzzs6ZLUcjWb8ey0gede7mxguW4WO4Z2h9dhjHZxdeb7dDytEUbtpIDs8/rY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4519:b0:3d2:a5a0:8b06 with SMTP id
 e9e14a558f8ab-3d2a5a08d00mr132769895ab.2.1740040941067; Thu, 20 Feb 2025
 00:42:21 -0800 (PST)
Date: Thu, 20 Feb 2025 00:42:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b6eaed.050a0220.14d86d.0163.GAE@google.com>
Subject: [syzbot] [f2fs?] UBSAN: array-index-out-of-bounds in
 f2fs_truncate_inode_blocks (2)
From: syzbot <syzbot+51d857eed5614c310da0@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6537cfb395f3 Merge tag 'sound-6.14-rc4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f8b5b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=51d857eed5614c310da0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-6537cfb3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f0fee59b531/vmlinux-6537cfb3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ebf361d1fa57/bzImage-6537cfb3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51d857eed5614c310da0@syzkaller.appspotmail.com

F2FS-fs (loop0): access invalid blkaddr:1
CPU: 0 UID: 0 PID: 5318 Comm: syz.0.0 Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __f2fs_is_valid_blkaddr+0xe16/0x1460 fs/f2fs/checkpoint.c:213
 f2fs_map_blocks+0xd93/0x4e70 fs/f2fs/data.c:1586
 f2fs_preallocate_blocks fs/f2fs/file.c:4836 [inline]
 f2fs_file_write_iter+0x1125/0x2550 fs/f2fs/file.c:5072
 aio_write+0x56b/0x7c0 fs/aio.c:1633
 io_submit_one+0x8a7/0x18a0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x171/0x2e0 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f238798cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f23888cc038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f2387ba5fa0 RCX: 00007f238798cde9
RDX: 0000400000000700 RSI: 0000000000001417 RDI: 00007f2388883000
RBP: 00007f2387a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2387ba5fa0 R15: 00007ffc34e50188
 </TASK>
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/f2fs/node.h:381:10
index 18446744073709550692 is out of range for type '__le32[5]' (aka 'unsigned int[5]')
CPU: 0 UID: 0 PID: 5318 Comm: syz.0.0 Not tainted 6.14.0-rc3-syzkaller-00060-g6537cfb395f3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 get_nid fs/f2fs/node.h:381 [inline]
 f2fs_truncate_inode_blocks+0xa5e/0xf60 fs/f2fs/node.c:1181
 f2fs_do_truncate_blocks+0x782/0x1030 fs/f2fs/file.c:808
 f2fs_truncate_blocks+0x10d/0x300 fs/f2fs/file.c:836
 f2fs_truncate+0x417/0x720 fs/f2fs/file.c:886
 f2fs_file_write_iter+0x1bdb/0x2550 fs/f2fs/file.c:5093
 aio_write+0x56b/0x7c0 fs/aio.c:1633
 io_submit_one+0x8a7/0x18a0 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x171/0x2e0 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f238798cde9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f23888cc038 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 00007f2387ba5fa0 RCX: 00007f238798cde9
RDX: 0000400000000700 RSI: 0000000000001417 RDI: 00007f2388883000
RBP: 00007f2387a0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f2387ba5fa0 R15: 00007ffc34e50188
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

