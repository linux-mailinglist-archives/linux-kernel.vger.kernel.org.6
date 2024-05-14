Return-Path: <linux-kernel+bounces-178564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC468C503E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E8E1F210E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 11:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75C413AA5D;
	Tue, 14 May 2024 10:38:30 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AF213AA31
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683110; cv=none; b=eRn8mPF7Oqy2x48uJk97tN9740j6P3X1I9sDgArCtP7AVhIcw+vJ3PjOdRBjGP/hj93IQQIvSVCwIn23sqhb0Y8VFDTZBUZRDEV+s+9WRFHe8lXp8h6xLG2TFX6FvX65qwKnoEuKxys+cCN8bVYPcc83qXcR4Znm3Q1UXf/zoAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683110; c=relaxed/simple;
	bh=EGR+zXCDOQwL+HrkhqqNQmPU229zOujEZFCnP487w4E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jDLq2nnBYFKs6bzqeaY6zPEpsoxjetJG5imCwfJoxPkqkRL2fT++21ZmFZ7G0fVKj0jesbdB6TXn0eFccF41K3uYTIPICu/OEvoHwZxbaK/fJOSR0ZuekOUXIuhnXWfckLaDLo1FDjUjBb/lYGmRQ1nJRDk5OXXNW2VpSHoKHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7da42114485so650025139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 03:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715683108; x=1716287908;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Th1iuK1DlThv8EL75EHFzI8PLOP2SWOYowjVuRjrzPM=;
        b=JBRTZ6i0BFzhCIOuOPEmkG14XpwWsUldUtJUrCAmpr2pUUjcLdPSwu4Kxy27LTMfzC
         00EdZ+CxpLB/LUqQKoiYWv/qgxPaXTulT3hb9ewZFAm0EclRa05jWbXNIPGRwiN0lqhu
         SP/DpEUVlqu5Rfx/0BUQBBfxwwo8PKRgASRN2KuVtJ/trRMVj+zGo2S2Rxs26XNhdWzm
         B0RbEOmvpXDnu+sb4WIKHHt8yaissDvXbYw1ZvKdtFUGsffUx9aUJ/dIFuBfeJFqG2/M
         6wxLTpSE5IrnBg/LarZ0RdWxBdxbX9JKPvxGbosC3NIugPspXl/+YxLJnU2wyBy90uKb
         BJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXvspvwwJ9Liue2J0ujGyxrR4zLVsMJvrjKwbd3P8Tbvpgn3/Uh5spNW/B1MfRMH1TU42Rj6rfu3xcMF7jR3hDUbfnPxkVYB43PwDzr
X-Gm-Message-State: AOJu0YwVhcEJgkhPfAPks+Id8U1oijmR4DCR5R3uNI9342Tj9HAbmG3D
	ROHrJFZd2FGHizbGBAwAjvTJulCKDmRBzW4f5f2yzjvFu+e0FbjEt4ucJc2FJqeBKdpSs26IFT6
	ZyIoAnSCKTnXVYEdWQiMOESd4sVbwb/X0NQVHMhIhgH1BSz21dtzU0fI=
X-Google-Smtp-Source: AGHT+IGh6Oc6KG1zbf86PaYErI91mn2SkLXeKoN4jk6itUDDjbTrCcndENysiRoMiBJtIIBhMrgih3yhHIJhzM6j3WFwqUn5Nlcj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b08:b0:7de:8cc5:fd1 with SMTP id
 ca18e2360f4ac-7e1b521bcacmr61700639f.3.1715683108017; Tue, 14 May 2024
 03:38:28 -0700 (PDT)
Date: Tue, 14 May 2024 03:38:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003361de0618679a80@google.com>
Subject: [syzbot] [bcachefs?] WARNING in bch2_printbuf_make_room
From: syzbot <syzbot+52eec578b7504cf32002@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cf87f46fd34d Merge tag 'drm-fixes-2024-05-11' of https://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11e4d598980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=52eec578b7504cf32002
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153d4878980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12813878980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f9ed1ac24b43/disk-cf87f46f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4934308925bc/vmlinux-cf87f46f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e19a148ec56c/bzImage-cf87f46f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6df3bd28499c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52eec578b7504cf32002@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5075 at mm/page_alloc.c:4551 __alloc_pages+0x1fce/0x2460 mm/page_alloc.c:4551
Modules linked in:
CPU: 1 PID: 5075 Comm: syz-executor362 Not tainted 6.9.0-rc7-syzkaller-00183-gcf87f46fd34d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:__alloc_pages+0x1fce/0x2460 mm/page_alloc.c:4551
Code: ef e8 36 8e 0b 00 e9 ef f2 ff ff e8 2c 8e 0b 00 e9 1b f3 ff ff 4c 89 f7 e8 1f 8e 0b 00 e9 f6 f2 ff ff c6 05 44 6a cb 0d 01 90 <0f> 0b 90 e9 81 e4 ff ff 49 8d bc 24 40 09 00 00 48 b8 00 00 00 00
RSP: 0018:ffffc9000314eb68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000800000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000040cc0
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000040cc0
R13: 1ffff92000629d81 R14: 0000000000000cc0 R15: 00000000ffffffff
FS:  000055555685a380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e69851e000 CR3: 00000000662c8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __kmalloc_large_node+0x7f/0x1a0 mm/slub.c:3917
 __do_kmalloc_node mm/slub.c:3960 [inline]
 __kmalloc_node_track_caller.cold+0x5/0x5f mm/slub.c:3992
 __do_krealloc mm/slab_common.c:1192 [inline]
 krealloc+0x5d/0x100 mm/slab_common.c:1225
 bch2_printbuf_make_room+0x195/0x2a0 fs/bcachefs/printbuf.c:38
 bch2_prt_printf+0x223/0x3d0 fs/bcachefs/printbuf.c:78
 journal_entry_btree_keys_to_text+0x11b/0x250 fs/bcachefs/journal_io.c:409
 bch2_journal_entry_to_text+0x119/0x170 fs/bcachefs/journal_io.c:835
 bch2_sb_clean_to_text+0x109/0x210 fs/bcachefs/sb-clean.c:316
 __bch2_sb_field_to_text+0x123/0x1e0 fs/bcachefs/super-io.c:1245
 bch2_sb_field_validate+0x248/0x2d0 fs/bcachefs/super-io.c:1228
 bch2_sb_validate.isra.0+0x6d8/0xce0 fs/bcachefs/super-io.c:468
 __bch2_read_super+0x93c/0x12a0 fs/bcachefs/super-io.c:822
 bch2_fs_open+0x3e5/0x1110 fs/bcachefs/super.c:2052
 bch2_mount+0xdcc/0x1130 fs/bcachefs/fs.c:1903
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
RIP: 0033:0x7fa562243dea
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc4bfcc738 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc4bfcc750 RCX: 00007fa562243dea
RDX: 0000000020011a00 RSI: 00000000200000c0 RDI: 00007ffc4bfcc750
RBP: 0000000000000004 R08: 00007ffc4bfcc790 R09: 00000000000119fd
R10: 0000000001200014 R11: 0000000000000282 R12: 0000000001200014
R13: 00007ffc4bfcc790 R14: 0000000000000003 R15: 0000000001000000
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

