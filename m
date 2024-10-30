Return-Path: <linux-kernel+bounces-389671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4789B6F91
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 22:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3411F22532
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A01217655;
	Wed, 30 Oct 2024 21:47:21 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37268217656
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730324841; cv=none; b=oOhvNhPP1KdTlmZnkV/hXgc9T9ZGgJw+h+8Ehsp0yr7LBLf5X2zGqIcnsd7Yexl1HPECM3UdDAmcjjNIntZvTYvm/tsx6HrCXAdQOfhhl3/8twJMyimjXxW6ePhbrt3ozSpwdTNKk19icigXDoTWNH95EAk6OGtO9IVQstntIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730324841; c=relaxed/simple;
	bh=NnhSSDuhgIN9PydpMQz47O0FfU32rYYkCnIYWcsI+aQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E6Q3Zbw6SQzXkCt51eD8FccSHw26Wr2DlPURHgHuvQCH6hh8rEomxSzua40hwMIxY/2ZrfoSjqx+yjzAtr761wNsIOlFtCgarwt+zNz521et6D1I3vNQd2y8/WmFz3IuWYVsIzD2hkOxPVZNe2a/t5pVQkaR9X+VI0gnxFCnP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so5411325ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730324838; x=1730929638;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ACNr8p3H4GA+eQueFWCy362LjkJVfIpsAD1zKVorlo=;
        b=H0tKxiN4ISY1rHB/tsbC0EeTiA+cLr/v/nVdkaoBP8kpiNOfmLwvGspeFDJR20f4Ry
         HkXXt0f4l6F1QpPnTRvXeM24OqWTKyQFWMQFV52Nsm2d7MpPM7n33SZ6AE/Rgu7GfLVz
         XMCLWfhir2HZDeMlm61Exw93Effb8xoGCUJZvjAhmREfCkYSeOyxWxbnCFQG05FSEXGe
         SUNKK50AcenH8X8TmKEN3992J2qVGowiwobd+FWmeG0dPSWKUmxzD3LZtw1T2lsChNes
         1BEuMN+E/93pxhra4EcxI3S0J5XfjHAL5bcsLq+i1rVtiX9czah7B0t2fS/DtaH+drcd
         UEsA==
X-Forwarded-Encrypted: i=1; AJvYcCVWZ6nnp+ku+OALWfc5D4xauWZmgLukG85N6Hcm9upeRhwlag4bLo+dapuYErn5cXoem7qqxiW1tZpPir8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWeGFKflOSclsprG60cJEVb8uXkuaHrAmkeo1TgnA4d/DIarq
	72LLVRynNRTkeoKxM9MDYOypt1TYVLaOWDo/yMifWgpPrwyow3wVm46ilZKnjYnganT+aHV4qPd
	9+N+Rpdj5phahwBv9MIbCD/nQvom6+SUEfqXhJt/5oDlHN0zTxd3YKk0=
X-Google-Smtp-Source: AGHT+IGDHwIPnYRBVo+9z9k8UvpsIigKV0m3M5x6Dmnyf+EM89WUTa/SxkXlZsW/E97JtKjvzHajrt+DeZAJyP5BoJc7iOKQdMFt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c2:b0:3a0:8f20:36e7 with SMTP id
 e9e14a558f8ab-3a5e2513c38mr50694505ab.19.1730324838365; Wed, 30 Oct 2024
 14:47:18 -0700 (PDT)
Date: Wed, 30 Oct 2024 14:47:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6722a966.050a0220.529b6.0002.GAE@google.com>
Subject: [syzbot] [ocfs2?] kernel BUG in ocfs2_find_subtree_root
From: syzbot <syzbot+c6bd015c32fbb94aa3ec@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ea1fda89f5b2 Merge tag 'x86_urgent_for_v6.12_rc5' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135ba940580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7c88a43a2c4a2024
dashboard link: https://syzkaller.appspot.com/bug?extid=c6bd015c32fbb94aa3ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-ea1fda89.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2b219efb942/vmlinux-ea1fda89.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e79d4e9109b5/bzImage-ea1fda89.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6bd015c32fbb94aa3ec@syzkaller.appspotmail.com

Process accounting resumed
(syz.0.0,5323,0):ocfs2_find_subtree_root:1777 ERROR: bug expression: i > left->p_tree_depth
(syz.0.0,5323,0):ocfs2_find_subtree_root:1777 ERROR: Owner 17059, left depth 1, right depth 1
left leaf blk 10739, right leaf blk 10739
------------[ cut here ]------------
kernel BUG at fs/ocfs2/alloc.c:1777!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5323 Comm: syz.0.0 Not tainted 6.12.0-rc4-syzkaller-00289-gea1fda89f5b2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ocfs2_find_subtree_root+0x5ab/0x5c0 fs/ocfs2/alloc.c:1771
Code: 68 ea 11 8e ba f1 06 00 00 48 c7 c1 40 10 49 8c 4c 8b 44 24 20 45 89 f1 ff 33 41 57 ff 74 24 28 e8 6a 0d 22 00 48 83 c4 18 90 <0f> 0b e8 8e 17 13 fe 90 0f 0b e8 a6 25 45 08 66 0f 1f 44 00 00 90
RSP: 0018:ffffc9000d1bdfa0 EFLAGS: 00010296
RAX: 1bb296cac2b5b100 RBX: ffff888043f97018 RCX: 1bb296cac2b5b100
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000d1be090 R08: ffffffff81749fac R09: 1ffff92001a37b60
R10: dffffc0000000000 R11: fffff52001a37b61 R12: 0000000000000001
R13: 0000000000000010 R14: 0000000000000001 R15: 00000000000029f3
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffbb527fc00 CR3: 00000000432aa000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ocfs2_insert_path+0xad7/0x12c0 fs/ocfs2/alloc.c:4232
 ocfs2_do_insert_extent+0xae1/0x10d0 fs/ocfs2/alloc.c:4334
 ocfs2_insert_extent+0x1377/0x2270 fs/ocfs2/alloc.c:4757
 ocfs2_add_clusters_in_btree+0x741/0x1370 fs/ocfs2/alloc.c:4849
 ocfs2_add_inode_data+0xcf/0x120 fs/ocfs2/file.c:550
 ocfs2_write_cluster fs/ocfs2/aops.c:1134 [inline]
 ocfs2_write_cluster_by_desc+0x54c/0x20b0 fs/ocfs2/aops.c:1239
 ocfs2_write_begin_nolock+0x3a2f/0x4ec0 fs/ocfs2/aops.c:1815
 ocfs2_write_begin+0x205/0x3a0 fs/ocfs2/aops.c:1902
 generic_perform_write+0x344/0x6d0 mm/filemap.c:4054
 ocfs2_file_write_iter+0x17b1/0x1f50 fs/ocfs2/file.c:2459
 __kernel_write_iter+0x42a/0x940 fs/read_write.c:616
 __kernel_write+0x120/0x180 fs/read_write.c:636
 do_acct_process+0x11ff/0x1870 kernel/acct.c:539
 slow_acct_process+0x3e8/0x510 kernel/acct.c:597
 do_exit+0x9f0/0x28e0 kernel/exit.c:929
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffbc0d7e719
Code: Unable to access opcode bytes at 0x7ffbc0d7e6ef.
RSP: 002b:00007ffcdf65a878 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffbc0d7e719
RDX: 0000000000000064 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000003 R08: 00007ffcdf65a95f R09: 00007ffbc0f06260
R10: 0000000000000001 R11: 0000000000000246 R12: 00007ffbc0f06f68
R13: 00007ffbc0f06260 R14: 0000000000000003 R15: 00007ffcdf65a920
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ocfs2_find_subtree_root+0x5ab/0x5c0 fs/ocfs2/alloc.c:1771
Code: 68 ea 11 8e ba f1 06 00 00 48 c7 c1 40 10 49 8c 4c 8b 44 24 20 45 89 f1 ff 33 41 57 ff 74 24 28 e8 6a 0d 22 00 48 83 c4 18 90 <0f> 0b e8 8e 17 13 fe 90 0f 0b e8 a6 25 45 08 66 0f 1f 44 00 00 90
RSP: 0018:ffffc9000d1bdfa0 EFLAGS: 00010296
RAX: 1bb296cac2b5b100 RBX: ffff888043f97018 RCX: 1bb296cac2b5b100
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000d1be090 R08: ffffffff81749fac R09: 1ffff92001a37b60
R10: dffffc0000000000 R11: fffff52001a37b61 R12: 0000000000000001
R13: 0000000000000010 R14: 0000000000000001 R15: 00000000000029f3
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffbb527fc00 CR3: 000000001fb5e000 CR4: 0000000000352ef0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

