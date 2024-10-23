Return-Path: <linux-kernel+bounces-378168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB609ACC3E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8894B283D41
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF01BE223;
	Wed, 23 Oct 2024 14:27:35 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF451AAE00
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693654; cv=none; b=mPtnYm0ane8A0iFqtWloYhK6AVGY4q5vTaiOZcAly/vUI+bT0Q+N41/qoukcsyIu7u+j9vfbYqWFtxin7GAZ+LT5W6iD16yBJZiZ61XjPDPDqCTnQCFQ8CO9JdTFiw4XYoB64O+GF/u20FdVnIGTgF6cNXUSYqGz6EecVVWgCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693654; c=relaxed/simple;
	bh=wtP/NxJgdxIz8oV9uHmBzipVXqr9N46aFLNrTpRMShY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=r/0ojdvJTvWd6FMQUn8JXFUlAwyzJRZ5oadxF0q1Ee9BepXHglNjSFnfe1kmWx4Lblo++vf7WA2a6kNvrHI0DoZD70jq9dewsNY2ColrVjtvCuJCN9uKuh7u+jJLqK0UZljuyp+/L+67ieanIuxNV+vQ5BXlVlrOtbXXGs8PqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so61023485ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729693652; x=1730298452;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+v1VeT6FcS4wrKJrKwXE8lgby5WygTxXqrIqNjOgiZQ=;
        b=rIIq4FdZ+ddik16gk2cReFpW0YRFqKDKS2kCk84h3QO9pYz3tsGb25Wuo4HwSEsxMx
         00WJpG6/7st/bF3wabZEHClmUyFZD0YnUAfjoUOCJILR1usBH6GNKnv8jAYvOX00/XKG
         IGgTHrlORB0DNdHOSarsgwWAyPJYJffcd/pK965y98pWBVfcDxiHi5U/ZJqxIS8E1VDB
         zMwzA+QBUWj7iF3gbNhPqgrLWwUhTb3BtpNg1a1GAK4jg8dcxC+OVG/h3iz7uBgFS02S
         XkIjXuaeVzM9KM1uHxoWU+OJRoH1VUED0z0wt5fsfuQu1SXgUdsA5zuAdyEgezuOZk08
         zSvA==
X-Forwarded-Encrypted: i=1; AJvYcCUv7B+bl4LegtiosWX1cOhhVFp2jDqRwxwZBNzbLfmWCQRNbipvOauV5MIzARzFWWWgSvu1Z9t6/RAb/zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwFn0o7OqiuZ89cymAGnFLHtF9hRxvsGdhpAxOxOUIm4zw+73y
	WDI2TOa7hPIHg2nQLk1qcMIxByI+TT6nkzmUWcCMGsGIW9PxgS3sU9dv1tBv4W/zU75XjoJwE7s
	6+HBR42FZAipeYrIVlb4zJ1ki0xa9pLGNgzIGjW0+pn2lOH9ToboGAUU=
X-Google-Smtp-Source: AGHT+IF9D45qKuktmPAVRe+qc1d+dxucRjP88Tw+D6hNKjf4B4W1wFDhfjPH9NRiWP6YCdb6u43FWZzXWE2HgQ7/y3lFkeri9dlI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:3649:0:b0:3a4:d9d0:55a6 with SMTP id
 e9e14a558f8ab-3a4d9d0572dmr10741355ab.19.1729693652397; Wed, 23 Oct 2024
 07:27:32 -0700 (PDT)
Date: Wed, 23 Oct 2024 07:27:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671907d4.050a0220.1e4b4d.008e.GAE@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in validate_sb_layout
From: syzbot <syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16acc287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=089fad5a3a5e77825426
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109dd640580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f288a7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d116f71ad0eb/disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bdd6f545b105/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0d26b05e3d7c/bzImage-c2ee9f59.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b13b1120386a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/super-io.c:290:18
shift exponent 255 is too large for 32-bit type 'int'
CPU: 0 UID: 0 PID: 5220 Comm: syz-executor166 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 validate_sb_layout+0xafa/0xb10 fs/bcachefs/super-io.c:290
 bch2_sb_validate+0x8e4/0xf70 fs/bcachefs/super-io.c:442
 __bch2_read_super+0xc24/0x1380 fs/bcachefs/super-io.c:832
 bch2_fs_open+0x270/0x2f80 fs/bcachefs/super.c:2032
 bch2_fs_get_tree+0x738/0x1710 fs/bcachefs/fs.c:2161
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f55733ccb7a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff5b40e1e8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fff5b40e1f0 RCX: 00007f55733ccb7a
RDX: 00000000200058c0 RSI: 0000000020005900 RDI: 00007fff5b40e1f0
RBP: 0000000000000004 R08: 00007fff5b40e230 R09: 000000000000594e
R10: 0000000000014001 R11: 0000000000000282 R12: 00007fff5b40e230
R13: 0000000000000003 R14: 0000000001000000 R15: 0000000000000001
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

