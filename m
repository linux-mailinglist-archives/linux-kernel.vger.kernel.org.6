Return-Path: <linux-kernel+bounces-539839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FEDA4A99B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936213BB61C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EEB1CCEE2;
	Sat,  1 Mar 2025 07:59:26 +0000 (UTC)
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9B1CAA71
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740815966; cv=none; b=kB5m0AHmkrOWkRSnmpYgkylC6sXra1I8/WQiwrZatF/UUrvjlhzIkZLe4IySW1zqcJvXV9068bL19znubuuKs+CPGMfkG4PuYccWc8Ylfi4xfVFXjOSi/dVvwX5PUCfSW/gXT5ulN2MHvavtsPKIRJIJ7qSxdYDskW11u85HXxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740815966; c=relaxed/simple;
	bh=Yd4tc2V8z3YQYvl3BkrLJcEKsrKoL54QyhIDwkmjQpo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=px+5zZECF3uBwDVPBDmu4dqHVhCbJuwAxsOi/JWsJ0cNyaPysAaKLY6Jw1aGHvpJzxFSxfl60fHA9jFVGcLz9cS2rSQMItW0v3zDliF/FuSqU+ydML+isE2/pNIBWawKps6vWodmhBmxH1f4HxD/lQhBx3+Nx/5iPgOtTDNWt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3cf64584097so34067485ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740815963; x=1741420763;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQfjU0CFSSNm9Q04jClWvWXmuJQpF9HWUNBd2fNcWrs=;
        b=Wq/mVtPR93eZHR4E7MDxmi8jFLt+wHKVGdgzEmngPfyOv7HvMJmLlmWSQbh1+Z4Pkk
         VvoXv1rVV1USt2q5wxQq62NnsUbr7ONM/lUrwuCUwRa6eK5rFFESoileMhuXmmRnio2u
         4aLc+SlJn1hD/FQ9Np0gnRqDCF62tuG7mXrho1gJADoysR5Ni7qQRtf1vbiqYBnaAVO0
         GcgoTyavdiXttzcF45iYiRccVjjW0ftq+rOd7RNT2X+DEe8hNToBtqNTxf59IfV+FtBm
         HESHQFEqYcdNhgUJyRNzZyjk96a4eSFeaII5YaNLcqgTcDokHiKWwPVtyPmRNr8LSAZw
         pWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTuAC5NF+Cx5N5+Hi33k1C23rI6C2sCEL3lZjDxzrBRIm3prj9/DbGZCgGujMtmFNPKzj0G2H/0J8nD2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO4RcA+sMTplrKFUIT0hOFOrdj4Qx/e2jlPFaru+Lk+NMMtfvv
	TtWAYjriLHzGv3QC5vkok/xpy9lky9mdQuB76Wnuz8/kdhFFhmcrF8VmyZBBIWs9vVVdHYYJsey
	0Z7428YJ3xqAT1XzUFYKbVC6UZpCuF4F3nidVFj5gN+4j2BpMIYCFado=
X-Google-Smtp-Source: AGHT+IGhw00S9WjVz5GoUuoA42DWyssDnpGTHvtqKZG5J7OBfBy+IvnzfMnGcRf9KsHdrCg/rJowB+F1JeW1jsomT9D4qWy4QXW/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:3d3:f64a:38b9 with SMTP id
 e9e14a558f8ab-3d3f64a398fmr17930135ab.15.1740815963741; Fri, 28 Feb 2025
 23:59:23 -0800 (PST)
Date: Fri, 28 Feb 2025 23:59:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c2be5b.050a0220.dc10f.015f.GAE@google.com>
Subject: [syzbot] [ntfs3?] BUG: unable to handle kernel paging request in io_schedule
From: syzbot <syzbot+b43febb4dbd338b56739@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1616ec98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b4c41bdaeea1964
dashboard link: https://syzkaller.appspot.com/bug?extid=b43febb4dbd338b56739
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102737a4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11176db0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-d082ecbc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5299c562b1f/vmlinux-d082ecbc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c0bed38fa342/bzImage-d082ecbc.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/251596561f87/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b43febb4dbd338b56739@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3(loop0): Different NTFS sector size (2048) and media sector size (512).
overlayfs: upper fs does not support tmpfile.
overlayfs: upper fs does not support RENAME_WHITEOUT.
BUG: unable to handle page fault for address: ffffed110016d539
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 5ffcd067 P4D 5ffcd067 PUD 0 
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5311 Comm: syz-executor285 Not tainted 6.14.0-rc4-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:io_schedule_finish kernel/sched/core.c:7665 [inline]
RIP: 0010:io_schedule+0x8d/0x110 kernel/sched/core.c:7691
Code: 42 80 3c 38 00 74 08 48 89 df e8 1e 82 1f f6 48 8b 3b 48 85 ff 74 0a be 01 00 00 00 e8 1c 43 ca f8 41 83 e5 08 e8 43 f4 ff ff <43> 0f b6 04 3c 84 c0 75 59 41 8b 06 83 e0 f7 41 0f b7 cd 09 c1 66
RSP: 0018:ffffc9000d136378 EFLAGS: 00010246
RAX: 0000000000400140 RBX: ffff888000b6b6c8 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000008 R08: ffff888011ec6e03 R09: 1ffff110023d8dc0
R10: dffffc0000000000 R11: ffffed10023d8dc1 R12: 1ffff1100016d53a
R13: 0000000000000000 R14: ffff888000b6a9d0 R15: dffffc00ffffffff
FS:  000055558362e380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed110016d539 CR3: 000000004066a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bit_wait_io+0x12/0xd0 kernel/sched/wait_bit.c:247
 __wait_on_bit+0xb0/0x2f0 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0x1d5/0x260 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:105 [inline]
 __wait_on_buffer fs/buffer.c:123 [inline]
 wait_on_buffer include/linux/buffer_head.h:414 [inline]
 __sync_dirty_buffer+0x2f7/0x390 fs/buffer.c:2858
 ntfs_write_bh+0x5fa/0x7c0 fs/ntfs3/fsntfs.c:1485
 mi_write+0x9b/0x1e0 fs/ntfs3/record.c:402
 indx_update_dup+0x69a/0x860 fs/ntfs3/index.c:2697
 ni_update_parent+0xa18/0xdd0 fs/ntfs3/frecord.c:3230
 ni_write_inode+0xe61/0x1100 fs/ntfs3/frecord.c:3321
 write_inode fs/fs-writeback.c:1525 [inline]
 __writeback_single_inode+0x708/0x10d0 fs/fs-writeback.c:1745
 writeback_single_inode+0x1f3/0x660 fs/fs-writeback.c:1801
 sync_inode_metadata+0xc4/0x120 fs/fs-writeback.c:2871
 __generic_file_fsync+0x134/0x1a0 fs/libfs.c:1536
 generic_file_fsync+0x70/0xf0 fs/libfs.c:1566
 ovl_sync_file+0x3a/0x50 fs/overlayfs/copy_up.c:254
 ovl_copy_up_metadata+0xac1/0xef0 fs/overlayfs/copy_up.c:724
 ovl_copy_up_workdir fs/overlayfs/copy_up.c:816 [inline]
 ovl_do_copy_up fs/overlayfs/copy_up.c:1001 [inline]
 ovl_copy_up_one fs/overlayfs/copy_up.c:1202 [inline]
 ovl_copy_up_flags+0x244a/0x47c0 fs/overlayfs/copy_up.c:1257
 ovl_open+0x139/0x310 fs/overlayfs/file.c:211
 do_dentry_open+0xdec/0x1960 fs/open.c:956
 vfs_open+0x3b/0x370 fs/open.c:1086
 do_open fs/namei.c:3830 [inline]
 path_openat+0x2c81/0x3590 fs/namei.c:3989
 do_filp_open+0x27f/0x4e0 fs/namei.c:4016
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1428
 do_sys_open fs/open.c:1443 [inline]
 __do_sys_openat fs/open.c:1459 [inline]
 __se_sys_openat fs/open.c:1454 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1454
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8041315cb9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd14b37ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f8041315cb9
RDX: 0000000000040042 RSI: 0000400000002580 RDI: 00000000ffffff9c
RBP: 0000400000000180 R08: 000055558362f4c0 R09: 000055558362f4c0
R10: 00000000000000f7 R11: 0000000000000246 R12: 00004000000001a8
R13: 000040000000018c R14: 0000400000000188 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffed110016d539
---[ end trace 0000000000000000 ]---
RIP: 0010:io_schedule_finish kernel/sched/core.c:7665 [inline]
RIP: 0010:io_schedule+0x8d/0x110 kernel/sched/core.c:7691
Code: 42 80 3c 38 00 74 08 48 89 df e8 1e 82 1f f6 48 8b 3b 48 85 ff 74 0a be 01 00 00 00 e8 1c 43 ca f8 41 83 e5 08 e8 43 f4 ff ff <43> 0f b6 04 3c 84 c0 75 59 41 8b 06 83 e0 f7 41 0f b7 cd 09 c1 66
RSP: 0018:ffffc9000d136378 EFLAGS: 00010246
RAX: 0000000000400140 RBX: ffff888000b6b6c8 RCX: 0000000000000001
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
RBP: 0000000000000008 R08: ffff888011ec6e03 R09: 1ffff110023d8dc0
R10: dffffc0000000000 R11: ffffed10023d8dc1 R12: 1ffff1100016d53a
R13: 0000000000000000 R14: ffff888000b6a9d0 R15: dffffc00ffffffff
FS:  000055558362e380(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed110016d539 CR3: 000000004066a000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
   5:	74 08                	je     0xf
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 1e 82 1f f6       	call   0xf61f822d
   f:	48 8b 3b             	mov    (%rbx),%rdi
  12:	48 85 ff             	test   %rdi,%rdi
  15:	74 0a                	je     0x21
  17:	be 01 00 00 00       	mov    $0x1,%esi
  1c:	e8 1c 43 ca f8       	call   0xf8ca433d
  21:	41 83 e5 08          	and    $0x8,%r13d
  25:	e8 43 f4 ff ff       	call   0xfffff46d
* 2a:	43 0f b6 04 3c       	movzbl (%r12,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	75 59                	jne    0x8c
  33:	41 8b 06             	mov    (%r14),%eax
  36:	83 e0 f7             	and    $0xfffffff7,%eax
  39:	41 0f b7 cd          	movzwl %r13w,%ecx
  3d:	09 c1                	or     %eax,%ecx
  3f:	66                   	data16


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

