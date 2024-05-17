Return-Path: <linux-kernel+bounces-181843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D8B8C823F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 10:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19C61F2149A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889A20DCC;
	Fri, 17 May 2024 08:02:31 +0000 (UTC)
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4331A269
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932950; cv=none; b=Zvg8PXfJwHmEzcVGnW73LplxW0x+l65ejTKrb8MmXzD6f7nOOADJPSjMgElo8f/9qc/hLxPSn1YehRuMLTIIb7qUJYjeymTAWagvBbNtsuMQi7h0y6QgBU8rbbtjl5YH7FKihxvDRsOx2NWzl3hC6daLO/LQ6LhEilCwGfqoTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932950; c=relaxed/simple;
	bh=p45+b/pSpV/zvqpjYIjk+i4pyy2EMc9SNVvuUSNDgzI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AuauFRugkgW44zirLs1A7CPhZhDuF0bkUaBUgVryk72v4pH5+UHG83UD33r/lvxGjOWaK/wvVE2CX4Da+hWvwcB6lBOu/Zy0P1kQB9DTbyXRBWrDPkTEjvriGIqQozfQOm97HQKxTuS5KC3+GL+YGYATbb8p8VfVUMQl6eit3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e1be009e6eso859926839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 01:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932948; x=1716537748;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3IPiib30PKj0HoFUNsOUfWlrZ5YZUAkEjiI/WkOAew=;
        b=HQqbAJPbI8fofPSPTJOulSTnE0o1+Ff2R0WJxlYx7Jw5GgesBYYNNq46gO4BBymokO
         zf81V/o3z240vCcyGqeMHOLuxzXEy8r6xr/42Xhx1iGebf3IWziy3Fh52+sr46o/7xAW
         GADBg+cbZISTVc+bK8ttqu7QJ4eAglaqMufI4I3jnypjlZudegz8R0+Lo99gvDMIbe45
         w5irSrZtDxTuuRiK6QdDLo0xiPmYlkWQ7cvYWQ7lefvLR3g9b1tHpaUIXa0lnqRHAbFG
         2syvw4mmqnjYTqSMuIMcLkDWuKoFrCsxo7ajRsDueytMHx/rn4IR1o8t0Nf4GU/KE5pm
         Tb9w==
X-Forwarded-Encrypted: i=1; AJvYcCV6M8z92GKiTzH+08jQuU8fGs+NN34AE1NOvGTY0Xf5kkO5QEL2TT7Pafm81yTVmmvmWCTdZ61DO6Q82OF+Ffh2s+XF1sH5ORHSIIdD
X-Gm-Message-State: AOJu0YwyJLdrNB4ubJdot2LyH2YBIW3d1pz0l49d39mmDDPjTZLRP0Yh
	tSCPmDxcrPa3b91fiZklVHANArSaqb8addcPHFW2Qn04vG2SeaZMb73AkxVLUgjWI1hRpIjHRX4
	36tWO34K5tVpP1z8jZP+/U8isqBKfQKF8KvzkutfZL4CIEeb9/zRAMFM=
X-Google-Smtp-Source: AGHT+IGAjDdsV8ez56rlHz1o0lz0WD4jrCNjiClk7aEbNl1XYJdX7MGQXv32iG91ji5IRRyNi4AWTvGP5jC0RIdZTAMbNY0i7Fwa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:484:b0:7de:e182:ddf1 with SMTP id
 ca18e2360f4ac-7e1b5010346mr83760039f.0.1715932948678; Fri, 17 May 2024
 01:02:28 -0700 (PDT)
Date: Fri, 17 May 2024 01:02:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd5d730618a1c598@google.com>
Subject: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_btree_lost_data
From: syzbot <syzbot+29f65db1a5fe427b5c56@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8c06da67d0bd Merge tag 'livepatching-for-6.10' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=135f87d4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc69cd6a2dcb5aa
dashboard link: https://syzkaller.appspot.com/bug?extid=29f65db1a5fe427b5c56
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d09ce0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ea775c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/331202aeac12/disk-8c06da67.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4db56871f364/vmlinux-8c06da67.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2ab7bc870390/bzImage-8c06da67.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b709a5f7f34f/mount_0.gz

The issue was bisected to:

commit 55936afe11077a84d9e1c5068169af328bbf2811
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Mar 16 03:03:42 2024 +0000

    bcachefs: Flag btrees with missing data

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=145dc1d0980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=165dc1d0980000
console output: https://syzkaller.appspot.com/x/log.txt?x=125dc1d0980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+29f65db1a5fe427b5c56@syzkaller.appspotmail.com
Fixes: 55936afe1107 ("bcachefs: Flag btrees with missing data")

bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=metadata_checksum=none,data_checksum=none,nojournal_transaction_names
bcachefs (loop0): recovering from clean shutdown, journal seq 10
bcachefs (loop0): error validating btree node on loop0 at btree (unknown) level 3/3
  u64s 11 type btree_ptr_v2 SPOS_MAX len 0 ver 0: seq 27c2ec7b8e70cb08 written 16 min_key POS_MIN durability: 1 ptr: 0:31:0 gen 0
  node offset 0/16 bset u64s 0: incorrect btree id
bcachefs (loop0): inconsistency detected - emergency read only at journal seq 10
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/bcachefs/recovery.c:38:10
shift exponent 255 is too large for 64-bit type 'unsigned long long'
CPU: 1 PID: 5082 Comm: syz-executor184 Not tainted 6.9.0-syzkaller-07387-g8c06da67d0bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
 bch2_btree_lost_data+0x143/0x150 fs/bcachefs/recovery.c:38
 bch2_btree_node_read_done+0x50f9/0x5a40 fs/bcachefs/btree_io.c:1272
 btree_node_read_work+0x665/0x1300 fs/bcachefs/btree_io.c:1324
 bch2_btree_node_read+0x2b64/0x32c0
 __bch2_btree_root_read fs/bcachefs/btree_io.c:1748 [inline]
 bch2_btree_root_read+0x61e/0x970 fs/bcachefs/btree_io.c:1772
 read_btree_roots+0x22d/0x7b0 fs/bcachefs/recovery.c:457
 bch2_fs_recovery+0x4334/0x63b0 fs/bcachefs/recovery.c:785
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1043
 bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2105
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1906
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa695417daa
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc4c8ca6b8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc4c8ca6d0 RCX: 00007fa695417daa
RDX: 0000000020011a00 RSI: 0000000020000080 RDI: 00007ffc4c8ca6d0
RBP: 0000000000000004 R08: 00007ffc4c8ca710 R09: 00000000000119fd
R10: 0000000001200014 R11: 0000000000000282 R12: 0000000001200014
R13: 00007ffc4c8ca710 R14: 0000000000000003 R15: 0000000001000000
 </TASK>
---[ end trace ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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

