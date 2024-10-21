Return-Path: <linux-kernel+bounces-374407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 624139A69B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E64631F23012
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AA1F4FC7;
	Mon, 21 Oct 2024 13:07:44 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0F91E6DFC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516063; cv=none; b=jhVLKswHHCtbGXIx/K8pmGDEx8XeS69qs20ywM2Z09yhyUAUxwrL11YQreBPGPUMySkfbg4tlrX+LwxGvSnsBjSDww+ywNy/VaUvdAwVI6sl7Kofi2tegkaZWkiDe7Qe7msM2Zq3sUoYuyVkf0rG467eB90JL0+9r9lcdmm3pag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516063; c=relaxed/simple;
	bh=kFiPJ27GfSMqXxuc9mMVrXDeN56RLe0OSGvF1iL5E1w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D3pJMhPeoh6MU9C1aOPW8TGwUA1EPbZBtenKYAe6IOmokeviTY1ItiMi3/n0aJbEkHC5A2Zu02euAXbRjv5yV7otMRz1Urfoex+cAsHWhEp8dTh73mAP+HFnRvLOV7joyXgDk75W5FRTQdkCTzpRKSAIvjgkepybFS7dy9gDdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aba93c01bso294637439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729516060; x=1730120860;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tPh7t0LFFLPi4r7wg/IIJqFewGMgN9TOFPdliAC59Jk=;
        b=FZpcQuvWCSVGUGoR0uqeNzcGnnPqXc0IOsT+2FU8fctRCFG/pOWHkZN6j7wxyolIJ6
         r+IKK6OuPoqPX5c1zITaTyBjbAsZ68Y+Yw5G1XPOjWgS0JMcFtSrLo33XEttrPJEt8xf
         eZcmahQxyWPos8ROqz93JCUuKuF296EiHa8ULGCHrr3p0vUIabjq1cKg/EXS9dPjKxXw
         ODww3izOCxxKOkQlQFZqLoJmTt5ihLtrMys+cnmmOoVVdh/h5c/bPRrzKOi3DV+bOHDl
         ahTQ7b1nPCXEF0eodQbpDZr4Kp7WjeW7d7EGDkgu97eSc1kD/cZlrO+mqw7DDi391new
         WAXA==
X-Forwarded-Encrypted: i=1; AJvYcCVdqjqChyIztMK5HL+I0SSDnKW+hM1CN8aRpwRBSQpqsgOP+59uZMPl1XYtIcuOfspdBnTFNGDeDAdlExc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz17UcoBo9pYiRfOC15lJ2drDpg6znXhuQTDfvI6qdHmhnMSE7u
	L/EGg+nEumIHQrq8hOE5bvyI8JukEKDuOVeu27vYmGB8YNFPdjc1DekE4dI5tT3VoLPPODPjOyv
	bPgwbvRUuQvJm0gqUQFEMaOyzF97mfxgNWSfYeqvjh4a0C0Z96xCa9SU=
X-Google-Smtp-Source: AGHT+IEEKRHwDbZlGFRSvZF5R3RQiyV/Xrpf3sN0Nw4xTh3udAwxcFIg+hzbqUP3/lMJiQPTqCUZm71Vsb6Mi85Yrzb1btRJGRP5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138b:b0:3a3:da4f:79f4 with SMTP id
 e9e14a558f8ab-3a3f40457c6mr94687505ab.2.1729516060244; Mon, 21 Oct 2024
 06:07:40 -0700 (PDT)
Date: Mon, 21 Oct 2024 06:07:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716521c.050a0220.1e4b4d.005a.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_dev_btree_bitmap_mark
From: syzbot <syzbot+e8eff054face85d7ea41@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6efbea77b390 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c38240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=e8eff054face85d7ea41
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b10487980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f8af27980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-6efbea77.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa4b0fb0c7f0/vmlinux-6efbea77.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7128c5b0c0b5/bzImage-6efbea77.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/459a008a6b91/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8eff054face85d7ea41@syzkaller.appspotmail.com

bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): check_allocations...
------------[ cut here ]------------
kernel BUG at fs/bcachefs/sb-members.c:453!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5100 Comm: syz-executor307 Not tainted 6.12.0-rc3-syzkaller-00183-g6efbea77b390 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__bch2_dev_btree_bitmap_mark fs/bcachefs/sb-members.c:453 [inline]
RIP: 0010:bch2_dev_btree_bitmap_mark+0xfd2/0xff0 fs/bcachefs/sb-members.c:473
Code: b3 f1 ff ff e8 af 9f 4c fd 90 0f 0b e8 a7 9f 4c fd 90 0f 0b e8 9f 9f 4c fd 90 0f 0b e8 97 9f 4c fd 90 0f 0b e8 8f 9f 4c fd 90 <0f> 0b e8 87 9f 4c fd 90 0f 0b e8 7f 0d 7e 07 66 2e 0f 1f 84 00 00
RSP: 0018:ffffc90002dfe5a0 EFLAGS: 00010293
RAX: ffffffff84484871 RBX: 00000000ffffffc8 RCX: ffff88801e284880
RDX: 0000000000000000 RSI: 000000000000003f RDI: 0000000000000039
RBP: ffffc90002dfe7b0 R08: ffffffff844844f1 R09: 0000000000000000
R10: 0000042098000000 R11: 0000000000000000 R12: 000000000000003f
R13: 0000042098000000 R14: ffff88803f7839d0 R15: 000000000000003f
FS:  0000555592498380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561dbfb3d000 CR3: 00000000400e8000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_gc_mark_key+0xc9b/0x10e0 fs/bcachefs/btree_gc.c:622
 bch2_gc_btree fs/bcachefs/btree_gc.c:698 [inline]
 bch2_gc_btrees fs/bcachefs/btree_gc.c:729 [inline]
 bch2_check_allocations+0x22e8/0x6e80 fs/bcachefs/btree_gc.c:1123
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:185
 bch2_run_recovery_passes+0x387/0x870 fs/bcachefs/recovery_passes.c:232
 bch2_fs_recovery+0x25cc/0x39c0 fs/bcachefs/recovery.c:862
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1036
 bch2_fs_get_tree+0xd68/0x1710 fs/bcachefs/fs.c:2174
 vfs_get_tree+0x90/0x2b0 fs/super.c:1800
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4055 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa72a53cf2a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd5b715e88 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffd5b715ea0 RCX: 00007fa72a53cf2a
RDX: 00000000200000c0 RSI: 0000000020000000 RDI: 00007ffd5b715ea0
RBP: 0000000000000004 R08: 00007ffd5b715ee0 R09: 0000000000005901
R10: 0000000000808016 R11: 0000000000000282 R12: 0000000000808016
R13: 00007ffd5b715ee0 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__bch2_dev_btree_bitmap_mark fs/bcachefs/sb-members.c:453 [inline]
RIP: 0010:bch2_dev_btree_bitmap_mark+0xfd2/0xff0 fs/bcachefs/sb-members.c:473
Code: b3 f1 ff ff e8 af 9f 4c fd 90 0f 0b e8 a7 9f 4c fd 90 0f 0b e8 9f 9f 4c fd 90 0f 0b e8 97 9f 4c fd 90 0f 0b e8 8f 9f 4c fd 90 <0f> 0b e8 87 9f 4c fd 90 0f 0b e8 7f 0d 7e 07 66 2e 0f 1f 84 00 00
RSP: 0018:ffffc90002dfe5a0 EFLAGS: 00010293
RAX: ffffffff84484871 RBX: 00000000ffffffc8 RCX: ffff88801e284880
RDX: 0000000000000000 RSI: 000000000000003f RDI: 0000000000000039
RBP: ffffc90002dfe7b0 R08: ffffffff844844f1 R09: 0000000000000000
R10: 0000042098000000 R11: 0000000000000000 R12: 000000000000003f
R13: 0000042098000000 R14: ffff88803f7839d0 R15: 000000000000003f
FS:  0000555592498380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561dbfb3d000 CR3: 00000000400e8000 CR4: 0000000000352ef0
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

