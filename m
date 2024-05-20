Return-Path: <linux-kernel+bounces-183826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD3B8C9EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77F9284700
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FFA13667F;
	Mon, 20 May 2024 14:18:46 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D11054780
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716214726; cv=none; b=M9av3czZPQidNSqo2vGTIOlPZRy8WWnV3609Vk+k9ze1D8MidLLcfbfayl8It4Mx99wU6qYj6qkS3cg4G/GAY3eCrbFkGlL5pjqCitGbSQ/jG98G9ZHV9hDQdjCysGQIm6U3aMXGn37rsLYb8+rxCxonemJso9+jHdguVvLP7Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716214726; c=relaxed/simple;
	bh=MmVMKh7UbCxWmdRdTzC2qbOowW7HMoJRuQszlggfMVQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FTSvAJJ1RUhwBx95Rff/kYmpKlNdaiWCYFfnlcYsnXoTAiKTtkiXIE2mlS7+dxnt6/dGjA8gaBtrJb5A9gv9vM11VvtiJfGMqQWmHvgukHbiplJcG6ibcwMJKvkDFFRop3xConEFdf/sa0ddUxMxpdoCoTI3ViK0Q8XxhCmyOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1bbace584so1192433439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716214723; x=1716819523;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Al0eT/vifUewppj4Qbeoj56W0sQsrL1KIXvwMav+KbU=;
        b=emxjBZYtdHo9Mvv7UnZ0xWQrKow6iUrvcoKUmiytd/T/46/rgimUNmP457C2g9r3VN
         zN1XNrHdIPP65o6hIfc0lypzI0Rr2yHw+5u4DdiNnCvQJwbz0XUVX/OgpYMzqa6LwMqy
         1T9LvrS0VeJtipDH/01mNc+63jli9CS4UhHZuIsiMIjJQQcK4+LAynQdrcO5Q9IbCWtO
         A6RrySxOyLcR5ApLck9KBncYDFdAhCA57Vj/XSlQWI3lzxEjSsP25SEYldfIc75uQosa
         hGrx5jJKCnRxjBZqoDH9yZJVcQ5V0xX6AlHoeq3CUJl9G+VWDn18zVd1wwKsfMfdDck0
         Gxmg==
X-Forwarded-Encrypted: i=1; AJvYcCUD8ERGG/4y/FeaIOWT0d7fwuWKQCyPDMsC0yCghJPj3NGVYqSkTpeOtjcj7F6CddO3LWfwgWp8RwBU6usUpGjsOloYQHEtgw7LzADn
X-Gm-Message-State: AOJu0Yyj2731QeJlQwTfKxY89nWsglD3BEFiSRXHMOBikNQH3o/hWfvA
	PLDH9BSb4+c2+QSHv7z4ZYkMHN1bf9pTGqE3EBFWMoG2+jBV+Bv2QthRpmDBtdW7pmRZ0cPn0hq
	LXdTQy+YSbTjSkkwmj7JyMNQOzRcPhK5tGeNwnFzVV5BVh6rWhLesfgA=
X-Google-Smtp-Source: AGHT+IErAjHM3lXj2RdAK0MbfoezVYSbq053nJeJnh0Kg6nZ89B03IryS0Ti0MdkZKSDCBWoujbTFg2fpnOMWBZFXX3QU6lsXIGL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150b:b0:488:dd9c:2483 with SMTP id
 8926c6da1cb9f-4895912b334mr2218337173.5.1716214723596; Mon, 20 May 2024
 07:18:43 -0700 (PDT)
Date: Mon, 20 May 2024 07:18:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f565710618e360b9@google.com>
Subject: [syzbot] [bcachefs?] WARNING in set_precision (3)
From: syzbot <syzbot+25cbf9415915b655f11f@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0cc6f45cecb4 Merge tag 'iommu-updates-v6.10' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13067b84980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1cd4092753f97c5
dashboard link: https://syzkaller.appspot.com/bug?extid=25cbf9415915b655f11f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131e3c42980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1354b784980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-0cc6f45c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/efa96164e152/vmlinux-0cc6f45c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d56503d42d4e/bzImage-0cc6f45c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/25e310ed1e40/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25cbf9415915b655f11f@syzkaller.appspotmail.com

precision 65535 too large
WARNING: CPU: 2 PID: 5186 at lib/vsprintf.c:2721 set_precision+0xc0/0x160 lib/vsprintf.c:2721
Modules linked in:
CPU: 2 PID: 5186 Comm: syz-executor131 Not tainted 6.9.0-syzkaller-08654-g0cc6f45cecb4 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:set_precision+0xc0/0x160 lib/vsprintf.c:2721
Code: ff 44 89 e6 e8 d1 dc b5 f6 45 84 e4 75 20 e8 47 e2 b5 f6 c6 05 4c 8b f5 04 01 90 48 c7 c7 80 2e 81 8c 89 de e8 91 f6 77 f6 90 <0f> 0b 90 90 e8 27 e2 b5 f6 31 c0 85 db 48 89 ea 0f 48 d8 b8 ff 7f
RSP: 0018:ffffc9000336ec48 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 000000000000ffff RCX: ffffffff814ff309
RDX: ffff888023858000 RSI: ffffffff814ff316 RDI: 0000000000000001
RBP: ffffc9000336ecc0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffffc9000336ecc7 R14: ffffc9000336ed98 R15: 0000000000000002
FS:  0000555570d35380(0000) GS:ffff88806b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e601f3870 CR3: 000000002ee12000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vsnprintf+0xa93/0x1880 lib/vsprintf.c:2797
 bch2_prt_printf+0x19f/0x3d0 fs/bcachefs/printbuf.c:75
 bch2_xattr_to_text+0x28b/0x760 fs/bcachefs/xattr.c:121
 bch2_val_to_text fs/bcachefs/bkey_methods.c:300 [inline]
 bch2_bkey_val_to_text+0x1c9/0x210 fs/bcachefs/bkey_methods.c:310
 journal_entry_btree_keys_to_text+0x12f/0x250 fs/bcachefs/journal_io.c:410
 bch2_journal_entry_to_text+0x119/0x170 fs/bcachefs/journal_io.c:835
 bch2_sb_clean_to_text+0x109/0x210 fs/bcachefs/sb-clean.c:316
 __bch2_sb_field_to_text+0x123/0x1e0 fs/bcachefs/super-io.c:1245
 bch2_sb_field_validate+0x248/0x2d0 fs/bcachefs/super-io.c:1228
 bch2_sb_validate.isra.0+0x6d8/0xce0 fs/bcachefs/super-io.c:468
 __bch2_read_super+0x93c/0x12a0 fs/bcachefs/super-io.c:822
 bch2_fs_open+0x3e5/0x1110 fs/bcachefs/super.c:2052
 bch2_mount+0xdcc/0x1130 fs/bcachefs/fs.c:1906
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14e6/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1d7b3d38fa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffec78729d8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffec78729f0 RCX: 00007f1d7b3d38fa
RDX: 0000000020011a00 RSI: 0000000020000080 RDI: 00007ffec78729f0
RBP: 0000000000000004 R08: 00007ffec7872a30 R09: 0000000000011a09
R10: 0000000001200014 R11: 0000000000000282 R12: 0000000001200014
R13: 00007ffec7872a30 R14: 0000000000000003 R15: 0000000001000000
 </TASK>


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

