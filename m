Return-Path: <linux-kernel+bounces-424502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4EA9DB510
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78E9B221FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192C3156F5F;
	Thu, 28 Nov 2024 09:49:27 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F19146590
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787366; cv=none; b=U/LHw9TwwIetXm3xLFkWwxNb9uu8Cihh7/KPl3aGlFaNO3JeRKKRAWxUvgM4L6Z0ynB9yM/ImXwJEEDqNYwRycv66i4x2nZsdUf1ZgQ4YmCGe2gsjtCgGHPmwv6/gf5AQqNMOPoFK/VU5HTCuf9CXLfO+/kCoOOZ+b6atgSpD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787366; c=relaxed/simple;
	bh=tQAvcycBwOfJdIRAmxrY9EsOuNMOEqfZttZzIIRQG5A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g/oIoehDWbVTfZEyZWZGXdJfXL1A+2W5pPijq1hWaJn/6WBJ+xL3BKdsiyDIHMhNYdN8jIVSfhJA9X3BZ/6IjvqIC3fmtbx8oQQUFHVRR7yExvEYlvPr0osIJXnHhClyEKctqnT4MrK6wNY8uXBroXoQJrEC/L37yILywwoX/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8418612c3b5so51891139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732787364; x=1733392164;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zK3P3DlewWoZ4unENJOCERkDx8cE+aWhywBL9zE4H90=;
        b=YaGrkL4TcwVKTyY54ghBzmvj1zjjZ9XGifKGjHjW/YhwZWSurtKLbo4HSOwrbZ8iAd
         KkXX7zIgAI8nDVaDSzy7WSTAu1DdHD3osL7P0bs7fwlKA4tTKZXaeoOtN/X5PPHhDH45
         8bOKIzvsWIMrJ52Ihlbaa3etRIJ/0N+jF7rChq/y2uIVSGcG1SpmU0GqbpCdYc76OD41
         t6vpR2Za9SaKAvzha/cx0DYMRixaFq/wWCu4eCesarvlrbYLM1M5Uwa31TtcKNEvTr+U
         ps1t3c2CNiRf81IUYaCOYR3nMxcHpjG2FBYLFkTl3+1kF7L5Lv0wVeWIorL63j8qT9Hd
         i7gA==
X-Forwarded-Encrypted: i=1; AJvYcCXsbxxaxKcuggcE0tADBT3OrB8fxGa9H5sIZyBsRTQX3rOInGHMwcDLX9fPGkMZMcApPx5R5ussgsyNVx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1wX8iA43iDbswUsWY0b4APs1yEJFhMq0XsDb0h2YnPWSeZXN
	OkNFRuNC807u7gCOKJ6xWp5QC/cLTT5gHZfYcT9wRkQYLQWI/NOJVewJmx0jHuo+BV28oweNnOR
	n525Ieqtp9XP5oO2III46fYhFelBJVh7FTDz+wIi093r7DKHlEM6zeDA=
X-Google-Smtp-Source: AGHT+IFVu1X3bU7dZRV2tG6l1XARo75f7CoAruWQEkEFFvhLvaXmYZAAyLoOsell0piiFG5S8nkl9sRLQoebZX+DgjdfDUEwr2kh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e3:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3a7c5525305mr71488155ab.1.1732787364112; Thu, 28 Nov 2024
 01:49:24 -0800 (PST)
Date: Thu, 28 Nov 2024 01:49:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67483ca4.050a0220.253251.007d.GAE@google.com>
Subject: [syzbot] [bcachefs?] kernel BUG in bch2_get_scanned_nodes
From: syzbot <syzbot+64e6509c7f777aec3a24@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f486c8aa16b8 Add linux-next specific files for 20241128
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1432a3c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=64e6509c7f777aec3a24
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1389ef5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164a8f78580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/beb58ebb63cf/disk-f486c8aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b241b5609e64/vmlinux-f486c8aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c9d817f665f2/bzImage-f486c8aa.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ee49d5c23880/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64e6509c7f777aec3a24@syzkaller.appspotmail.com

bcachefs (loop0): bch2_get_scanned_nodes(): recovery btree=xattrs level=0 POS_MIN - SPOS_MAX
bcachefs (loop0): bch2_get_scanned_nodes(): recovering u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 22000000ba0abe32 written 8 min_key POS_MIN durability: 1 ptr: 0:31:0 gen 0
invalid bkey in btree_node btree=xattrs level=0: u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 22000000ba0abe32 written 8 min_key POS_MIN durability: 1 ptr: 0:31:0 gen 0
  key at POS_MAX: delete?, fixing
------------[ cut here ]------------
kernel BUG at fs/bcachefs/btree_node_scan.c:546!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5831 Comm: syz-executor341 Not tainted 6.12.0-next-20241128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:bch2_get_scanned_nodes+0x1e23/0x1e30 fs/bcachefs/btree_node_scan.c:541
Code: 24 18 48 8d b4 24 f0 03 00 00 48 8b 94 24 00 01 00 00 e9 17 e8 ff ff e8 4b de a7 07 e8 f6 74 73 fd 90 0f 0b e8 ee 74 73 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003e36cc0 EFLAGS: 00010293
RAX: ffffffff842c0012 RBX: ffff888074b80000 RCX: ffff888035983c00
RDX: 0000000000000000 RSI: 00000000fffff75b RDI: 0000000000000000
RBP: ffffc90003e37160 R08: ffffffff842bf611 R09: 1ffffffff285892b
R10: dffffc0000000000 R11: fffffbfff285892c R12: 1ffff920007c6dcc
R13: ffffc90003e37020 R14: 00000000fffff75b R15: dffffc0000000000
FS:  0000555584e7a380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005590e5ed3c28 CR3: 0000000074aca000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bch2_check_topology+0x597/0xbb0 fs/bcachefs/btree_gc.c:543
 bch2_run_recovery_pass+0xf0/0x1e0 fs/bcachefs/recovery_passes.c:222
 bch2_run_recovery_passes+0x290/0x9f0 fs/bcachefs/recovery_passes.c:285
 bch2_fs_recovery+0x2660/0x3ab0 fs/bcachefs/recovery.c:917
 bch2_fs_start+0x37c/0x610 fs/bcachefs/super.c:1037
 bch2_fs_get_tree+0xd8d/0x1740 fs/bcachefs/fs.c:2201
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3507
 do_mount fs/namespace.c:3847 [inline]
 __do_sys_mount fs/namespace.c:4057 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b2490497a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe3bd4ff8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fffe3bd5010 RCX: 00007f8b2490497a
RDX: 00000000200000c0 RSI: 0000000020000040 RDI: 00007fffe3bd5010
RBP: 0000000000000004 R08: 00007fffe3bd5050 R09: 000000000000595a
R10: 0000000000800000 R11: 0000000000000282 R12: 0000000000800000
R13: 00007fffe3bd5050 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bch2_get_scanned_nodes+0x1e23/0x1e30 fs/bcachefs/btree_node_scan.c:541
Code: 24 18 48 8d b4 24 f0 03 00 00 48 8b 94 24 00 01 00 00 e9 17 e8 ff ff e8 4b de a7 07 e8 f6 74 73 fd 90 0f 0b e8 ee 74 73 fd 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90003e36cc0 EFLAGS: 00010293
RAX: ffffffff842c0012 RBX: ffff888074b80000 RCX: ffff888035983c00
RDX: 0000000000000000 RSI: 00000000fffff75b RDI: 0000000000000000
RBP: ffffc90003e37160 R08: ffffffff842bf611 R09: 1ffffffff285892b
R10: dffffc0000000000 R11: fffffbfff285892c R12: 1ffff920007c6dcc
R13: ffffc90003e37020 R14: 00000000fffff75b R15: dffffc0000000000
FS:  0000555584e7a380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005590e5ed3c28 CR3: 0000000074aca000 CR4: 00000000003526f0
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

