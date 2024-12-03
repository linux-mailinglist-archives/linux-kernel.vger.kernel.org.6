Return-Path: <linux-kernel+bounces-430013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481AD9E2AE4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108A5166723
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006511FC7E4;
	Tue,  3 Dec 2024 18:31:28 +0000 (UTC)
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2271E1632EF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250687; cv=none; b=d3ZWIk1B39FBnDSIjy8YCl7FC7q35Qz4ElRCcmPmCDlnik6FJGM7mmwY6iJneT3ITKzWc23NKB3syNrEfFiZqPcbGVOnAH1AVt5I4S9GTOK3D4cT9MCNKTDzoxL63RjguJ8q3DU/wbs5b2S4UL+lY6w0Y+f1iE1M6y0LMrZ1wak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250687; c=relaxed/simple;
	bh=FHsPm392ri0eB54pCMUsMs4Vhsff1ZRMeMJL3uT5FFo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l5TsiU0A6P5C5PdBtezV69bON6JDJzaklC+X0dV/oOwnn2L4DNe5lsGQKMHZcWQa91myn2csS3qs7VOOn5tmZsX6NZXQyWqU+h6aB4e87QA5li7MIbbXhh3ODf2QwxsPT+sa0zPBl6c0e23BF+Nudc7NP+eR/Uncv2qlI3ffdTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-8419946e077so674872039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 10:31:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733250685; x=1733855485;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hjj6R/xMvb7wKkH2m47buE6p9q7fmi7jYfOqhRPXBC8=;
        b=A5v8bCLl9lY5Ks3tbYsAX3QeQFYKI9onAHhH0123kLILogQgzcgQYpByIxkBn/zw5l
         ycEmO+vgKDUN9NiGk1oy2FO3k1iqChOqKC/25txCTg9YYEJpRDHGLDvEwrGUTMAXt5oC
         RPpNz+9oERbN18fHtl1b5dpHq31KiOy1qUKr7dxFwwBmPtmclzdNr51iKj5onacwaq/V
         PuKbNecE1XIu5Xibl/+FmFUbiBcUnr2QyUl2f9Q26UwZIP5DSTu53cvNip0uDnDYxB7G
         MfDWmH1qEX3BYgHtAqVaj9fQEnklqQ6X0pDAWjbuI/cqPv33PWvNeXTdcEGrt6bcyXQI
         8isQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQG1HMg8zeKo0iMnKzijyFeh1g7Bc3OfFuuUetdK0CCeU4BMLgA4sxsyGUUdR4acMgfMtsDzMD41YbDWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu3NTrQvo9GYsyevhXzzVwMukUA/aYzVue7dRN3idIhH58sdTO
	Aw8i4hm+pUErcECjhEONbi5blpvMDn8a47TY5I0tM57IGSbg19usqwhGJPxLq9CGIL17wmGkZT1
	S73+7/ujXF1KjUewzIKEE94HZRFo6FpzVYkq9RI+Sg/vuDocwj5WZqJo=
X-Google-Smtp-Source: AGHT+IEOo3SCsgbxAa9xqtkmIEQ+7AEX0hf07PLykR1Stk6qa9V9Xc7UwyKJdnn9cnAwO/M21fCLjnewMDkd3n+Z8R0yQYmhMyTM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c246:0:b0:3a6:c98d:86bc with SMTP id
 e9e14a558f8ab-3a7f9a3838cmr48606465ab.1.1733250685284; Tue, 03 Dec 2024
 10:31:25 -0800 (PST)
Date: Tue, 03 Dec 2024 10:31:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f4e7d.050a0220.17bd51.004f.GAE@google.com>
Subject: [syzbot] [f2fs?] UBSAN: array-index-out-of-bounds in read_inline_xattr
From: syzbot <syzbot+69f5379a1717a0b982a1@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7af08b57bcb9 Merge tag 'trace-v6.13-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1519f3c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3891b550f14aea0f
dashboard link: https://syzkaller.appspot.com/bug?extid=69f5379a1717a0b982a1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-7af08b57.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/63d6781734c3/vmlinux-7af08b57.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f3bd17982594/bzImage-7af08b57.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69f5379a1717a0b982a1@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 131072
F2FS-fs (loop0): Invalid Fs Meta Ino: node(13) meta(0) root(3)
F2FS-fs (loop0): Can't find valid F2FS filesystem in 2th superblock
F2FS-fs (loop0): Found nat_bits in checkpoint
F2FS-fs (loop0): Try to recover 2th superblock, ret: 0
F2FS-fs (loop0): Mounted with checkpoint version = 1b41e955
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in fs/f2fs/f2fs.h:3292:19
index 18446744073709550491 is out of range for type '__le32[923]' (aka 'unsigned int[923]')
CPU: 0 UID: 0 PID: 5338 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-10689-g7af08b57bcb9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 read_inline_xattr+0x273/0x280
 lookup_all_xattrs fs/f2fs/xattr.c:341 [inline]
 f2fs_getxattr+0x57b/0x13b0 fs/f2fs/xattr.c:533
 vfs_getxattr_alloc+0x472/0x5c0 fs/xattr.c:393
 ima_read_xattr+0x38/0x60 security/integrity/ima/ima_appraise.c:229
 process_measurement+0x117a/0x1fb0 security/integrity/ima/ima_main.c:353
 ima_file_check+0xd9/0x120 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xb9/0x280 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x2ccd/0x3590 fs/namei.c:3987
 do_file_open_root+0x3a7/0x720 fs/namei.c:4039
 file_open_root+0x247/0x2a0 fs/open.c:1382
 do_handle_open+0x85b/0x9d0 fs/fhandle.c:414
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a4bf80849
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a4cd52058 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007f4a4c145fa0 RCX: 00007f4a4bf80849
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f4a4bff3986 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4a4c145fa0 R15: 00007ffd9526f5d8
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

